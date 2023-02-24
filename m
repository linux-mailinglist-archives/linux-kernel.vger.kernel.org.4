Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7476A2047
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBXRIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBXRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:08:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB451689B;
        Fri, 24 Feb 2023 09:08:40 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O8hZEM019716;
        Fri, 24 Feb 2023 17:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A8MIzr29nEmdxqzWLno6oMciV0fh3UrJGsk6p8PIvPo=;
 b=Lr/NChLJoOkpl7pk1D8QmPJttoXW0kskn0awPzDoyilizQ9S1FuHDiIEadevItc5xiQ8
 fekXolwxJVJPrbYXBczAZwfectmLC8+sctHY5fNAdP4qU81JzwMtXxFW+S/GaOTLXqVa
 ne279GgecFDDMubiN++2NkOoKN7D01TSpGmK9PcWMR9ES+SIHs/flSjeGtQpvTuIAnkB
 rvsSlpV6LrcEedFKBJic0Ojt8NhWvGeniStF/5dBBAf3GohPx+FnezyQnmeFqC+OOV/x
 R9DaO/P2nxY0gZUfBQLh6jGG+9oWWmy1nNAhSwgNUlVPz6ZnASQWADM2zvJ5B6re4muR CQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxsy7schb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:08:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OH8T41007386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:08:29 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 09:08:28 -0800
Message-ID: <ffad035c-68d9-0f7b-458d-a2b9b56d45df@quicinc.com>
Date:   Fri, 24 Feb 2023 09:08:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: Add remoteproc tracing
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230224165142.17745-1-quic_gokukris@quicinc.com>
 <20230224165142.17745-2-quic_gokukris@quicinc.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230224165142.17745-2-quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M_u8cKI-b7A39Hi75Zbn_tVQimOtCnr9
X-Proofpoint-ORIG-GUID: M_u8cKI-b7A39Hi75Zbn_tVQimOtCnr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_12,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240135
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 8:51 AM, Gokul krishna Krishnakumar wrote:
> This change adds traces to the following rproc events:
> 1. subdevices events - (STRAT/STOP/CRASH)
> 2. subsystem events - (START/STOP/CRASH)
> 3. RPROC framework events - (Firmware Load/Authentication)
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>   drivers/remoteproc/Makefile           |  3 ++-
>   drivers/remoteproc/qcom_common.c      | 25 +++++++++++++++++++
>   drivers/remoteproc/qcom_q6v5.c        |  3 +++
>   drivers/remoteproc/qcom_q6v5_pas.c    | 17 +++++++++++++
>   drivers/remoteproc/qcom_sysmon.c      | 13 ++++++++++
>   drivers/remoteproc/qcom_tracepoints.c | 10 ++++++++
>   include/trace/events/rproc_qcom.h     | 36 +++++++++++++++++++++++++++
>   7 files changed, 106 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>   create mode 100644 include/trace/events/rproc_qcom.h
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..e52fa815ddc0 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -22,7 +22,8 @@ obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
>   obj-$(CONFIG_MESON_MX_AO_ARC_REMOTEPROC)+= meson_mx_ao_arc.o
>   obj-$(CONFIG_PRU_REMOTEPROC)		+= pru_rproc.o
>   obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
> -obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
> +obj-$(CONFIG_QCOM_RPROC_COMMON)		+= rproc_qcom_common.o
> +rproc_qcom_common-y			:= qcom_common.o qcom_tracepoints.o
>   obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
>   obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
>   obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index a0d4238492e9..7da3259be14a 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -18,6 +18,7 @@
>   #include <linux/slab.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   #include <linux/soc/qcom/smem.h>
> +#include <trace/events/rproc_qcom.h>
>   
>   #include "remoteproc_internal.h"
>   #include "qcom_common.h"
> @@ -26,6 +27,10 @@
>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>   
> +#define GLINK_SUBDEV_NAME	"glink"
> +#define SMD_SUBDEV_NAME		"smd"
> +#define SSR_SUBDEV_NAME		"ssr"
> +
>   #define MAX_NUM_OF_SS           10
>   #define MAX_REGION_NAME_LENGTH  16
>   #define SBL_MINIDUMP_SMEM_ID	602
> @@ -189,6 +194,8 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
>   {
>   	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>   
> +	trace_rproc_qcom_event(dev_name(glink->dev->parent), GLINK_SUBDEV_NAME, "start");
> +
>   	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
>   
>   	return PTR_ERR_OR_ZERO(glink->edge);
> @@ -198,6 +205,9 @@ static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>   {
>   	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>   
> +	trace_rproc_qcom_event(dev_name(glink->dev->parent), GLINK_SUBDEV_NAME,
> +			       crashed ? "crash stop" : "stop");
> +
>   	qcom_glink_smem_unregister(glink->edge);
>   	glink->edge = NULL;
>   }
> @@ -206,6 +216,8 @@ static void glink_subdev_unprepare(struct rproc_subdev *subdev)
>   {
>   	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>   
> +	trace_rproc_qcom_event(dev_name(glink->dev->parent), GLINK_SUBDEV_NAME, "unprepare");
> +
>   	qcom_glink_ssr_notify(glink->ssr_name);
>   }
>   
> @@ -300,6 +312,8 @@ static int smd_subdev_start(struct rproc_subdev *subdev)
>   {
>   	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>   
> +	trace_rproc_qcom_event(dev_name(smd->dev->parent), SMD_SUBDEV_NAME, "start");
> +
>   	smd->edge = qcom_smd_register_edge(smd->dev, smd->node);
>   
>   	return PTR_ERR_OR_ZERO(smd->edge);
> @@ -309,6 +323,9 @@ static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>   {
>   	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>   
> +	trace_rproc_qcom_event(dev_name(smd->dev->parent), SMD_SUBDEV_NAME,
> +			       crashed ? "crash stop" : "stop");
> +
>   	qcom_smd_unregister_edge(smd->edge);
>   	smd->edge = NULL;
>   }
> @@ -425,6 +442,8 @@ static int ssr_notify_prepare(struct rproc_subdev *subdev)
>   		.crashed = false,
>   	};
>   
> +	trace_rproc_qcom_event(ssr->info->name, SSR_SUBDEV_NAME, "prepare");
> +
>   	srcu_notifier_call_chain(&ssr->info->notifier_list,
>   				 QCOM_SSR_BEFORE_POWERUP, &data);
>   	return 0;
> @@ -438,6 +457,8 @@ static int ssr_notify_start(struct rproc_subdev *subdev)
>   		.crashed = false,
>   	};
>   
> +	trace_rproc_qcom_event(ssr->info->name, SSR_SUBDEV_NAME, "start");
> +
>   	srcu_notifier_call_chain(&ssr->info->notifier_list,
>   				 QCOM_SSR_AFTER_POWERUP, &data);
>   	return 0;
> @@ -451,6 +472,8 @@ static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
>   		.crashed = crashed,
>   	};
>   
> +	trace_rproc_qcom_event(ssr->info->name, SSR_SUBDEV_NAME, crashed ? "crash stop" : "stop");
> +
>   	srcu_notifier_call_chain(&ssr->info->notifier_list,
>   				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
>   }
> @@ -463,6 +486,8 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>   		.crashed = false,
>   	};
>   
> +	trace_rproc_qcom_event(ssr->info->name, SSR_SUBDEV_NAME, "unprepare");
> +
>   	srcu_notifier_call_chain(&ssr->info->notifier_list,
>   				 QCOM_SSR_AFTER_SHUTDOWN, &data);
>   }
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 192c7aa0e39e..31bbbe16363e 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -14,6 +14,7 @@
>   #include <linux/soc/qcom/qcom_aoss.h>
>   #include <linux/soc/qcom/smem.h>
>   #include <linux/soc/qcom/smem_state.h>
> +#include <trace/events/rproc_qcom.h>
>   #include <linux/remoteproc.h>
>   #include "qcom_common.h"
>   #include "qcom_q6v5.h"
> @@ -113,6 +114,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>   		dev_err(q6v5->dev, "watchdog without message\n");
>   
>   	q6v5->running = false;
> +	trace_rproc_qcom_event(dev_name(q6v5->dev), "q6v5_wdog", msg);
>   	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>   
>   	return IRQ_HANDLED;
> @@ -134,6 +136,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>   		dev_err(q6v5->dev, "fatal error without message\n");
>   
>   	q6v5->running = false;
> +	trace_rproc_qcom_event(dev_name(q6v5->dev), "q6v5_fatal", msg);
>   	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>   
>   	return IRQ_HANDLED;
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6cc4e13c5d36..27d3a6f8c92f 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -24,6 +24,7 @@
>   #include <linux/soc/qcom/mdt_loader.h>
>   #include <linux/soc/qcom/smem.h>
>   #include <linux/soc/qcom/smem_state.h>
> +#include <trace/events/rproc_qcom.h>
>   
>   #include "qcom_common.h"
>   #include "qcom_pil_info.h"
> @@ -206,10 +207,13 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>   	int ret;
>   
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_load", "enter");
> +
>   	/* Store firmware handle to be used in adsp_start() */
>   	adsp->firmware = fw;
>   
>   	if (adsp->dtb_pas_id) {
> +		trace_rproc_qcom_event(dev_name(adsp->dev), "dtb_firmware_loading", "enter");
>   		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
>   		if (ret) {
>   			dev_err(adsp->dev, "request_firmware failed for %s: %d\n",
> @@ -231,6 +235,8 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>   			goto release_dtb_metadata;
>   	}
>   
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_load", "exit");
> +
>   	return 0;
>   
>   release_dtb_metadata:
> @@ -247,6 +253,8 @@ static int adsp_start(struct rproc *rproc)
>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>   	int ret;
>   
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_start", "enter");
> +
>   	ret = qcom_q6v5_prepare(&adsp->q6v5);
>   	if (ret)
>   		return ret;
> @@ -276,6 +284,7 @@ static int adsp_start(struct rproc *rproc)
>   	}
>   
>   	if (adsp->dtb_pas_id) {
> +	        trace_rproc_qcom_event(dev_name(adsp->dev), "dtb_auth_reset", "enter");
>   		ret = qcom_scm_pas_auth_and_reset(adsp->dtb_pas_id);
>   		if (ret) {
>   			dev_err(adsp->dev,
> @@ -289,6 +298,8 @@ static int adsp_start(struct rproc *rproc)
>   	if (ret)
>   		goto disable_px_supply;
>   
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_firmware_loading", "enter");
> +
>   	ret = qcom_mdt_load_no_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
>   				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
>   				    &adsp->mem_reloc);
> @@ -296,6 +307,7 @@ static int adsp_start(struct rproc *rproc)
>   		goto release_pas_metadata;
>   
>   	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_auth_reset", "enter");
>   
>   	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
>   	if (ret) {
> @@ -303,6 +315,7 @@ static int adsp_start(struct rproc *rproc)
>   			"failed to authenticate image and release reset\n");
>   		goto release_pas_metadata;
>   	}
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "Q6_auth_reset", "exit");
>   
>   	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>   	if (ret == -ETIMEDOUT) {
> @@ -364,6 +377,8 @@ static int adsp_stop(struct rproc *rproc)
>   	int handover;
>   	int ret;
>   
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_stop", "enter");
> +
>   	ret = qcom_q6v5_request_stop(&adsp->q6v5, adsp->sysmon);
>   	if (ret == -ETIMEDOUT)
>   		dev_err(adsp->dev, "timed out on wait\n");
> @@ -385,6 +400,8 @@ static int adsp_stop(struct rproc *rproc)
>   	if (handover)
>   		qcom_pas_handover(&adsp->q6v5);
>   
> +	trace_rproc_qcom_event(dev_name(adsp->dev), "adsp_stop", "exit");
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index 746f56b4bafb..57b8a03d4a30 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -13,9 +13,12 @@
>   #include <linux/platform_device.h>
>   #include <linux/remoteproc/qcom_rproc.h>
>   #include <linux/rpmsg.h>
> +#include <trace/events/rproc_qcom.h>
>   
>   #include "qcom_common.h"
>   
> +#define SYSMON_SUBDEV_NAME "sysmon"
> +
>   static BLOCKING_NOTIFIER_HEAD(sysmon_notifiers);
>   
>   struct qcom_sysmon {
> @@ -477,6 +480,8 @@ static int sysmon_prepare(struct rproc_subdev *subdev)
>   		.ssr_event = SSCTL_SSR_EVENT_BEFORE_POWERUP
>   	};
>   
> +	trace_rproc_qcom_event(dev_name(sysmon->rproc->dev.parent), SYSMON_SUBDEV_NAME, "prepare");
> +
>   	mutex_lock(&sysmon->state_lock);
>   	sysmon->state = SSCTL_SSR_EVENT_BEFORE_POWERUP;
>   	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
> @@ -504,6 +509,8 @@ static int sysmon_start(struct rproc_subdev *subdev)
>   		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
>   	};
>   
> +	trace_rproc_qcom_event(dev_name(sysmon->rproc->dev.parent), SYSMON_SUBDEV_NAME, "start");
> +
>   	reinit_completion(&sysmon->ssctl_comp);
>   	mutex_lock(&sysmon->state_lock);
>   	sysmon->state = SSCTL_SSR_EVENT_AFTER_POWERUP;
> @@ -540,6 +547,9 @@ static void sysmon_stop(struct rproc_subdev *subdev, bool crashed)
>   		.ssr_event = SSCTL_SSR_EVENT_BEFORE_SHUTDOWN
>   	};
>   
> +	trace_rproc_qcom_event(dev_name(sysmon->rproc->dev.parent), SYSMON_SUBDEV_NAME,
> +			       crashed ? "crash stop" : "stop");
> +
>   	sysmon->shutdown_acked = false;
>   
>   	mutex_lock(&sysmon->state_lock);
> @@ -571,6 +581,9 @@ static void sysmon_unprepare(struct rproc_subdev *subdev)
>   		.ssr_event = SSCTL_SSR_EVENT_AFTER_SHUTDOWN
>   	};
>   
> +	trace_rproc_qcom_event(dev_name(sysmon->rproc->dev.parent), SYSMON_SUBDEV_NAME,
> +			       "unprepare");
> +
>   	mutex_lock(&sysmon->state_lock);
>   	sysmon->state = SSCTL_SSR_EVENT_AFTER_SHUTDOWN;
>   	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
> diff --git a/drivers/remoteproc/qcom_tracepoints.c b/drivers/remoteproc/qcom_tracepoints.c
> new file mode 100644
> index 000000000000..546ebe90f141
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_tracepoints.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm Technologies, Inc. Peripheral Image Loader helpers
> + *
> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.

2023 QuIC copyright?

> + */
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/rproc_qcom.h>
> +EXPORT_TRACEPOINT_SYMBOL(rproc_qcom_event);
> diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
> new file mode 100644
> index 000000000000..b8748873ab25
> --- /dev/null
> +++ b/include/trace/events/rproc_qcom.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.

Ditto

> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rproc_qcom
> +
> +#if !defined(_TRACE_RPROC_QCOM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RPROC_QCOM_H
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(rproc_qcom_event,
> +
> +	TP_PROTO(const char *name, const char *event, const char *subevent),
> +
> +	TP_ARGS(name, event, subevent),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__string(event, event)
> +		__string(subevent, subevent)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__assign_str(event, event);
> +		__assign_str(subevent, subevent);
> +	),
> +
> +	TP_printk("%s: %s: %s", __get_str(name), __get_str(event), __get_str(subevent))
> +);
> +#endif /* _TRACE_RPROC_QCOM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
