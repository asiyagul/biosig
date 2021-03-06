/*
 * Generated by asn1c-0.9.21 (http://lionet.info/asn1c)
 * From ASN.1 module "FEF-IntermediateDraft"
 * 	found in "../annexb-snacc-122001.asn1"
 */

#ifndef	_MetricCalEntry_H_
#define	_MetricCalEntry_H_


#include <asn_application.h>

/* Including external dependencies */
#include "MetricCalType.h"
#include "MetricCalState.h"
#include "AbsoluteTime.h"
#include <constr_SEQUENCE.h>

#ifdef __cplusplus
extern "C" {
#endif

/* MetricCalEntry */
typedef struct MetricCalEntry {
	MetricCalType_t	 cal_type;
	MetricCalState_t	 cal_state;
	AbsoluteTime_t	 cal_time;
	
	/* Context for parsing across buffer boundaries */
	asn_struct_ctx_t _asn_ctx;
} MetricCalEntry_t;

/* Implementation */
extern asn_TYPE_descriptor_t asn_DEF_MetricCalEntry;

#ifdef __cplusplus
}
#endif

#endif	/* _MetricCalEntry_H_ */
