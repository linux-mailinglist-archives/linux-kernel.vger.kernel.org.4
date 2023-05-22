Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD270C130
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjEVOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjEVOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:36:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8799;
        Mon, 22 May 2023 07:36:20 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MDKcCt014866;
        Mon, 22 May 2023 14:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=udS8vuoIq/MqmnFiF3MIBi5Ur5CPSuoz/BwfHiDeaR0=;
 b=QOguyjJY0yx/Q+jfcgp+RXugmJGJJ3wOMr+lWV3lH/t4ZtULQEO2qHPPuzX8WxEqDd+B
 VxDxrRvPrloQwXj0biQf2N63glTSa4vtrX9G3s6w5K3MRcHMEB2jlDs4X3rlFqdN0O+m
 NTIo2pGFIlI2SGQ4oF/mKY02MxEkp/T/KtIt1yZA/Nc3Na0Ubuvkk1SxFMzwUykeQnVX
 EGwHi1q02QwG11qvsDkxEhKfpGyQPnz8XBCQH1n01b22j0CgDNaTE7ncg30VhqPaI0hF
 nxVzhPanhUR5s6ccLj4MolZDm/2e8RU/XOaIe62Cp/7bbGWBXcgMV+SkG1lRHSRSuMMG 6Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr8qr871m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 14:36:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MEaC46014016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 14:36:12 GMT
Received: from [10.216.34.225] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 07:36:07 -0700
Message-ID: <b5566ae2-ec72-9326-fad3-82b69c7e13c4@quicinc.com>
Date:   Mon, 22 May 2023 20:05:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] remoteproc: Introduce traces for remoteproc events
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <cover.1683741283.git.quic_gokukris@quicinc.com>
 <5c7c2657d12808e211942d71ad79e3846f4e70bb.1683741283.git.quic_gokukris@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <5c7c2657d12808e211942d71ad79e3846f4e70bb.1683741283.git.quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: irUSM7gcudgQy1KrA8swdUkGl4H7GxoN
X-Proofpoint-ORIG-GUID: irUSM7gcudgQy1KrA8swdUkGl4H7GxoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_10,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220121
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 11:35 PM, Gokul krishna Krishnakumar wrote:
> Adding Traces for the following remoteproc events:
> 	rproc_subdev_event,
> 	rproc_interrupt_event,
> 	rproc_load_event,
> 	rproc_start_event,
> 	rproc_stop_event
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>   drivers/remoteproc/Makefile           |   1 +
>   drivers/remoteproc/qcom_tracepoints.c |  12 +++


Again, all names are generic enough why file name should contain
qcom in it's name. Make it such that other remoteproc drivers can
also use it.


-- Mukesh

>   include/trace/events/rproc_qcom.h     | 128 ++++++++++++++++++++++++++
>   3 files changed, 141 insertions(+)
>   create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>   create mode 100644 include/trace/events/rproc_qcom.h
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..3399fcaba39b 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_debugfs.o
>   remoteproc-y				+= remoteproc_sysfs.o
>   remoteproc-y				+= remoteproc_virtio.o
>   remoteproc-y				+= remoteproc_elf_loader.o
> +remoteproc-y				+= qcom_tracepoints.o
>   obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
>   obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>   obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
> diff --git a/drivers/remoteproc/qcom_tracepoints.c b/drivers/remoteproc/qcom_tracepoints.c
> new file mode 100644
> index 000000000000..1b587ef54aa7
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_tracepoints.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/rproc_qcom.h>
> +EXPORT_TRACEPOINT_SYMBOL(rproc_load_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_start_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_stop_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_interrupt_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_subdev_event);
> diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
> new file mode 100644
> index 000000000000..48ad26ce18a3
> --- /dev/null
> +++ b/include/trace/events/rproc_qcom.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rproc_qcom
> +
> +#if !defined(_TRACE_RPROC_QCOM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RPROC_QCOM_H
> +#include <linux/tracepoint.h>
> +#include <linux/remoteproc.h>
> +
> +/*
> + * Tracepoints for remoteproc and subdevice events
> + */
> +TRACE_EVENT(rproc_load_event,
> +
> +	TP_PROTO(struct rproc *rproc, int ret),
> +
> +	TP_ARGS(rproc, ret),
> +
> +	TP_STRUCT__entry(
> +		__string(name, rproc->name)
> +		__string(firmware, rproc->firmware)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, rproc->name);
> +		__assign_str(firmware, rproc->firmware);
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("%s loading firmware %s returned %d",
> +			__get_str(name), __get_str(firmware),
> +			__entry->ret)
> +);
> +
> +TRACE_EVENT(rproc_start_event,
> +
> +	TP_PROTO(struct rproc *rproc, int ret),
> +
> +	TP_ARGS(rproc, ret),
> +
> +	TP_STRUCT__entry(
> +		__string(name, rproc->name)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, rproc->name);
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("%s %d", __get_str(name), __entry->ret)
> +);
> +
> +TRACE_EVENT(rproc_stop_event,
> +
> +	TP_PROTO(struct rproc *rproc, char *crash_msg),
> +
> +	TP_ARGS(rproc, crash_msg),
> +
> +	TP_STRUCT__entry(
> +		__string(name, rproc->name)
> +		__string(crash_msg, crash_msg)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, rproc->name);
> +		__assign_str(crash_msg, crash_msg)
> +	),
> +
> +	TP_printk("%s %s", __get_str(name), __get_str(crash_msg))
> +);
> +
> +TRACE_EVENT(rproc_interrupt_event,
> +
> +	TP_PROTO(struct rproc *rproc, const char *event,
> +			 const char *msg),
> +
> +	TP_ARGS(rproc, event, msg),
> +
> +	TP_STRUCT__entry(
> +		__string(name, rproc->name)
> +		__string(event, event)
> +		__string(msg, msg)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, rproc->name);
> +		__assign_str(event, event);
> +		__assign_str(msg, msg);
> +	),
> +
> +	TP_printk("%s %s returned %s", __get_str(name),
> +			 __get_str(event), __get_str(msg))
> +);
> +
> +TRACE_EVENT(rproc_subdev_event,
> +
> +	TP_PROTO(const char *rproc, const char *subdev,
> +			const char *event, int ret),
> +
> +	TP_ARGS(rproc, subdev, event, ret),
> +
> +	TP_STRUCT__entry(
> +		__string(rproc, rproc)
> +		__string(subdev, subdev)
> +		__string(event, event)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(rproc, rproc);
> +		__assign_str(subdev, subdev);
> +		__assign_str(event, event);
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("%s %s %s %d", __get_str(rproc), __get_str(subdev),
> +			__get_str(event), __entry->ret)
> +);
> +#endif /* _TRACE_RPROC_QCOM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
