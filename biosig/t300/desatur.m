function [arg0,s0,ODI,x,HDR]=desatur(arg1,arg2,arg3)
%  This is part of the BIOSIG-toolbox http://biosig.sf.net/

% References:
%  [5] J-C. Vazquez, W.H. Tsai, W.W. Flemons, A. Masuda, R. Brant, E.Hajduk, W.A. Whitelaw, J.E. Remmers, 
% This program is free software; you can redistribute it and/or
if nargin>2
%%%%% Load data 
if isstr(arg1),  % if string, assume arg1 is a Filename and SaO2 is at channel 16
        Fs = HDR.SampleRate;   
else              % assume arg1 is the SaO2 signal with given sampling rate
end;
s0=s; % output argument returns original data
% subsampling to 4Hz
N1 = inf; %30*Fs; % window length of baseline filter, inf means baseline is the median of the all-nigth recording
if Mode>1, % correct invalid values, corrently no correction is performed. 
m0=median(s);   

switch Mode
	if (Fs>2) & (Fs==fix(Fs/2)*2), % downsampling to 2 Hz, if possible 
	    s=rs(s,ones(2,1)/2);
	    Fs=Fs/2;
	else
	    fprintf(1,'DESATUR: sampling rate is not 2Hz but %i\n',Fs);    
	end;
	
	x=repmat(0,size(s));
	s(length(s)+1)=-inf;
	ak0=nan; k=1;
	while k<=length(s)-Fs,
		while isnan(ak0)	% while a-point not found
			%(s(k)-s(k+Fs)),
			if (s(k)-s(k+Fs)) > 0.1
				a=(s(k)+s(k+Fs))/2; 	 % keep a-value in s(k0)	
				ak0=k+Fs/2;
			else k=k+1;
			end 
                end;
                bk0=ak0;
	        while (k<length(s)-1) & (s(k) > s(k+[0 2])),
			k=k+1;
			bk0=k;
                        %tmp=s(k+[-1 1]);
		end;
                if s(bk0) > a-2;   % not lower than 2%
		        bk0=nan; 		% not a valid b-point
			ak0=nan;
		end;  
		Q=1;   
		while ~isnan(ak0) & Q      
			k = k+1;
			Q = s(k) > max(a-1,s(bk0)+3);
		end;
		ck0=k;
		if abs((ck0-ak0-1)/Fs-35)<=25, % 10<=ck0-ak0<=60
			x(ak0:ck0-1)=1;		
		end;
		k=k+1;
	end;	    	
case 5
	    Fs=1;
	else
	    fprintf(1,'DESATUR: sampling rate is not 1Hz but %i\n',Fs);    
	end;

	x=repmat(0,size(s));
        x2=x;
        x1=filter([3 -1 -1 -1],1,sign(diff(s)))>5;
        if 1 
ODI = mean(diff(x)>0)/Fs*3600; % OD's per hour [1/h]
if ~any(x)