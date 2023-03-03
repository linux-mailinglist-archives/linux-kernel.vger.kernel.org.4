Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE946A8FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCCD1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCD1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:27:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167AA584B6;
        Thu,  2 Mar 2023 19:27:47 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32329hb6021258;
        Fri, 3 Mar 2023 03:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GY0TFrVhMCoPIc7EbW+Q9b60LgtQRQZfYEjJtrvOov0=;
 b=AmIiv+x2Dbdl8U3viGmZ4NJl5AcqPderxzOAJpEugoBcknh1LgLe7uwIFeEnl77V6vqE
 6PI1dwnjtRsh5RbE1+45nghC7fCPsIeKQNru+JcJAP16bsrts0Dq5vXaazAm6+66O0li
 jabjfmoK9TIGLv7/d4ONfx7kddhu7JyPM5aaobfZSRw+ktxC8tV1rbZLFzTQMaujk4Qw
 AlGB33OEO8DDOYR+Z2DEe/fgBHUr+DQ7MQD5SMfKu6K1o6ccinZ7B/6SaDgUZ1lVndef
 h21JvEAWX4Kgn+42M3yb2v7d0CoNQR2dyxrXO2tWNrqN+56EaSWMC4IF0Z1/nNaA2zNK qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2veet0ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 03:27:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3233RdvO032230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 03:27:39 GMT
Received: from [10.110.97.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 19:27:38 -0800
Message-ID: <dc6a6c8a-f312-0200-b117-536cb5f9d6b6@quicinc.com>
Date:   Thu, 2 Mar 2023 19:27:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: Add remoteproc tracing
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230224165142.17745-1-quic_gokukris@quicinc.com>
 <20230224165142.17745-2-quic_gokukris@quicinc.com>
 <20230227200639.fei5rsb5omaquhqn@ripper>
Content-Language: en-US
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <20230227200639.fei5rsb5omaquhqn@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: poS2GyZ8Ril9XOxki7pigAC0CdwlZ0lh
X-Proofpoint-GUID: poS2GyZ8Ril9XOxki7pigAC0CdwlZ0lh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030026
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review comments.

On 2/27/2023 12:06 PM, Bjorn Andersson wrote:
> On Fri, Feb 24, 2023 at 08:51:42AM -0800, Gokul krishna Krishnakumar wrote:
>> This change adds traces to the following rproc events:
>> 1. subdevices events - (STRAT/STOP/CRASH)
>> 2. subsystem events - (START/STOP/CRASH)
>> 3. RPROC framework events - (Firmware Load/Authentication)
>>
> 
> Thanks for proposing the introduction of tracepoints, this is something
> we have talked about for years, but no one has shown enough
> need/interest to do the work.
> 
> Most of the proposed tracepoints would however be very useful if you
> move them one step up (or down...) in the stack.
> 
> I.e. please move them into the common code.
> 
Moving the traces to one step up in the stack.
>> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>> ---
>>   drivers/remoteproc/Makefile           |  3 ++-
>>   drivers/remoteproc/qcom_common.c      | 25 +++++++++++++++++++
>>   drivers/remoteproc/qcom_q6v5.c        |  3 +++
>>   drivers/remoteproc/qcom_q6v5_pas.c    | 17 +++++++++++++
>>   drivers/remoteproc/qcom_sysmon.c      | 13 ++++++++++
>>   drivers/remoteproc/qcom_tracepoints.c | 10 ++++++++
>>   include/trace/events/rproc_qcom.h     | 36 +++++++++++++++++++++++++++
>>   7 files changed, 106 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>>   create mode 100644 include/trace/events/rproc_qcom.h
>>
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 91314a9b43ce..e52fa815ddc0 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -22,7 +22,8 @@ obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
>>   obj-$(CONFIG_MESON_MX_AO_ARC_REMOTEPROC)+= meson_mx_ao_arc.o
>>   obj-$(CONFIG_PRU_REMOTEPROC)		+= pru_rproc.o
>>   obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
>> -obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>> +obj-$(CONFIG_QCOM_RPROC_COMMON)		+= rproc_qcom_common.o
>> +rproc_qcom_common-y			:= qcom_common.o qcom_tracepoints.o
>>   obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
>>   obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
>>   obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
>> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
>> index a0d4238492e9..7da3259be14a 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>>   #include <linux/soc/qcom/smem.h>
>> +#include <trace/events/rproc_qcom.h>
>>   
>>   #include "remoteproc_internal.h"
>>   #include "qcom_common.h"
>> @@ -26,6 +27,10 @@
>>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>>   
>> +#define GLINK_SUBDEV_NAME	"glink"
>> +#define SMD_SUBDEV_NAME		"smd"
>> +#define SSR_SUBDEV_NAME		"ssr"
>> +
>>   #define MAX_NUM_OF_SS           10
>>   #define MAX_REGION_NAME_LENGTH  16
>>   #define SBL_MINIDUMP_SMEM_ID	602
>> @@ -189,6 +194,8 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
>>   {
>>   	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>>   
>> +	trace_rproc_qcom_event(dev_name(glink->dev->parent), GLINK_SUBDEV_NAME, "start");
> 
> Please do add individual events, rather than adding a single
> trace_printk()-like event. That allows the user to selectively enable
> events, and it becomes convenient to use the events in debugging.
> 
Adding spearate trace events for load/start/stop/interrupts/subdevices.
>> +
>>   	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
>>   
>>   	return PTR_ERR_OR_ZERO(glink->edge);
> [..]
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 6cc4e13c5d36..27d3a6f8c92f 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/soc/qcom/mdt_loader.h>
>>   #include <linux/soc/qcom/smem.h>
>>   #include <linux/soc/qcom/smem_state.h>
>> +#include <trace/events/rproc_qcom.h>
>>   
>>   #include "qcom_common.h"
>>   #include "qcom_pil_info.h"
>> @@ -206,10 +207,13 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>>   	int ret;
>>   
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_load", "enter");
>> +
>>   	/* Store firmware handle to be used in adsp_start() */
>>   	adsp->firmware = fw;
>>   
>>   	if (adsp->dtb_pas_id) {
>> +		trace_rproc_qcom_event(dev_name(adsp->dev), "dtb_firmware_loading", "enter");
>>   		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
>>   		if (ret) {
>>   			dev_err(adsp->dev, "request_firmware failed for %s: %d\n",
>> @@ -231,6 +235,8 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>>   			goto release_dtb_metadata;
>>   	}
>>   
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_load", "exit");
> 
> I believe it would be more useful to capture the error path as well.
> 
Done.
>> +
>>   	return 0;
>>   
>>   release_dtb_metadata:
>> @@ -247,6 +253,8 @@ static int adsp_start(struct rproc *rproc)
>>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>>   	int ret;
>>   
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_start", "enter");
>> +
>>   	ret = qcom_q6v5_prepare(&adsp->q6v5);
>>   	if (ret)
>>   		return ret;
>> @@ -276,6 +284,7 @@ static int adsp_start(struct rproc *rproc)
>>   	}
>>   
>>   	if (adsp->dtb_pas_id) {
>> +	        trace_rproc_qcom_event(dev_name(adsp->dev), "dtb_auth_reset", "enter");
>>   		ret = qcom_scm_pas_auth_and_reset(adsp->dtb_pas_id);
>>   		if (ret) {
>>   			dev_err(adsp->dev,
>> @@ -289,6 +298,8 @@ static int adsp_start(struct rproc *rproc)
>>   	if (ret)
>>   		goto disable_px_supply;
>>   
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_firmware_loading", "enter");
> 
> I would like this to contain move useful information, e.g. what file is
> it that we're trying to load?
> 
> And you only put "enter" here because you have a single tracepoint, it
> doesn't add any value...
> 
Adding firmware name field in the remoteproc load function.
>> +
>>   	ret = qcom_mdt_load_no_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
>>   				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
>>   				    &adsp->mem_reloc);
>> @@ -296,6 +307,7 @@ static int adsp_start(struct rproc *rproc)
>>   		goto release_pas_metadata;
>>   
>>   	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_auth_reset", "enter");
>>   
> 
> When is this tracepoint useful to you? (Same with the mdt loader above)
>
To see where the boot failed- if it failed in the dtb authentication or 
it got timed out in the Q6 boot.

> Should mdt-loader and scm drivers have their own tracepoints defined?
> They are after all called from a variety of other drivers...
>
Yes I think it would be better to move these trace points to the 
mdt_loader driver.

>>   	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
>>   	if (ret) {
>> @@ -303,6 +315,7 @@ static int adsp_start(struct rproc *rproc)
>>   			"failed to authenticate image and release reset\n");
>>   		goto release_pas_metadata;
>>   	}
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_auth_reset", "exit");
>>   
>>   	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>>   	if (ret == -ETIMEDOUT) {
>> @@ -364,6 +377,8 @@ static int adsp_stop(struct rproc *rproc)
>>   	int handover;
>>   	int ret;
>>   
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_stop", "enter");
>> +
>>   	ret = qcom_q6v5_request_stop(&adsp->q6v5, adsp->sysmon);
>>   	if (ret == -ETIMEDOUT)
>>   		dev_err(adsp->dev, "timed out on wait\n");
>> @@ -385,6 +400,8 @@ static int adsp_stop(struct rproc *rproc)
>>   	if (handover)
>>   		qcom_pas_handover(&adsp->q6v5);
>>   
>> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_stop", "exit");
> 
> You're missing an opportunity to convey the success/failure by not using
> "ret".
> 
Adding more information in the trace events.
>> +
>>   	return ret;
>>   }
>>   
> [..]
>> diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
>> new file mode 100644
>> index 000000000000..b8748873ab25
>> --- /dev/null
>> +++ b/include/trace/events/rproc_qcom.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM rproc_qcom
>> +
>> +#if !defined(_TRACE_RPROC_QCOM_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_RPROC_QCOM_H
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(rproc_qcom_event,
>> +
>> +	TP_PROTO(const char *name, const char *event, const char *subevent),
>> +
>> +	TP_ARGS(name, event, subevent),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__string(event, event)
>> +		__string(subevent, subevent)
> 
> Please ensure that your trace events are carrying useful information;
> as seen above, subevent is not useful in all cases, and in several other
> cases you're missing useful information.
> 
> Please think beyond printk, and please consider that these buffers could
> be consumed by a machine.
> 
Please review the V2 patchset where the events are seperated and more 
information is passed.
> Regards,
> Bjorn
> 
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__assign_str(event, event);
>> +		__assign_str(subevent, subevent);
>> +	),
>> +
>> +	TP_printk("%s: %s: %s", __get_str(name), __get_str(event), __get_str(subevent))
>> +);
>> +#endif /* _TRACE_RPROC_QCOM_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> -- 
>> 2.39.2
>>
Thanks,
Gokul
