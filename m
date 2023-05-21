Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019270AEAA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjEUPsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjEUPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:48:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9898AE3;
        Sun, 21 May 2023 08:48:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LFlShd017419;
        Sun, 21 May 2023 15:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NUTBc1xORa5ulkz4rTxoTTP07JM5rWNkZD3lV+ZKALI=;
 b=Wj1/0uxS0h69MGZLwZWS+2BCipYQMSSRjulDXzy/k/mainTu+Atpb7+7pQBwGizMBjL4
 8UD6JIk9zoaS9846dvs9CZ2NQ5L1zQobNAz3OBRvEB1OK8a+sv4kU0zFlB2a3OqMWZYp
 lDZd+c69kVi9a320xRfn2POKxLkI4pT2NYq5x1El+ElI9bvzXxJ19658WWQ0W6q/xUZZ
 T9w2H7na+B1QZIcDj57M6igHSySBYRBJVFsb8o5uRFSkRz/uZZSYUAChu4OA+jPy3ic4
 TJDS8BMFgK99mrhhcS5L0QvbfA9RfRYNTjD43iY931rKcBsWUOcHOwc39fuJ4ZkFwbyb Mg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppyp9vgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 15:48:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LFmYXX014584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 15:48:34 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 08:48:26 -0700
Message-ID: <f63c86fd-4c39-7523-1971-6d8df91afcf4@quicinc.com>
Date:   Sun, 21 May 2023 21:18:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
 <366ed962-dedb-0e88-036d-a1a806d0b589@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <366ed962-dedb-0e88-036d-a1a806d0b589@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z_kex2yC5ScYScyRtdZovxYkdONRSVWO
X-Proofpoint-GUID: Z_kex2yC5ScYScyRtdZovxYkdONRSVWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210139
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 6:47 PM, Sricharan Ramabadhran wrote:
> 
> 
> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>> APSS brings Q6 out of reset and then Q6 brings
>> WCSS block (wifi radio's) out of reset.
>>
>>                    ---------------
>>                   -->  |WiFi 2G radio|
>>                   |       --------------
>>                   |
>> --------    -------          |
>> | APSS | --->   |QDSP6|  -----|
>> ---------    -------       |
>>                                |
>>                          |
>>                   |   --------------
>>                   --> |WiFi 5G radio|
>>                   --------------
>>
>> Problem here is if any radio crashes, subsequently other
>> radio also should crash because Q6 crashed. Let's say
>> 2G radio crashed, Q6 should pass this info to APSS. Only
>> Q6 processor interrupts registered with APSS. Obviously
>> Q6 should crash and raise fatal interrupt to APSS. Due
>> to this 5G radio also crashed. But no issue in 5G radio,
>> because of 2G radio crash 5G radio also impacted.
>>
>> In multi pd model, this problem is resolved. Here WCSS
>> functionality (WiFi radio's) moved out from Q6 root pd
>> to a separate user pd. Due to this, radio's independently
>> pass their status info to APPS with out crashing Q6. So
>> other radio's won't be impacted.
>>
>>                         ---------
>>                             |WiFi    |
>>                         --> |2G radio|
>>                         |     ---------
>> ------    Start Q6             -------     |
>> |    |    ------------------>     |     |     |
>> |    |  Start WCSS PD1 (2G)       |     |        |
>> |APSS|    ----------------------->|QDSP6|-----|
>> |    |    Start WCSS PD1 (5G)    |     |
>> |    |    ----------------------->|     |-----|
>> ------                     -------     |
>>                         |
>>                         |    -----------
>>                         |-->|WiFi      |
>>                         |5G radio |
>>                         -----------
>> According to linux terminology, here consider Q6 as root
>> i.e it provide all services, WCSS (wifi radio's) as user
>> i.e it uses services provided by root.
>>
>> Since Q6 root & WCSS user pd's able to communicate with
>> APSS individually, multipd remoteproc driver registers
>> each PD with rproc framework. Here clients (Wifi host drivers)
>> intrested on WCSS PD rproc, so multipd driver start's root
>> pd in the context of WCSS user pd rproc start. Similarly
>> on down path, root pd will be stopped after wcss user pd
>> stopped.
>>
>> Here WCSS(user) PD is dependent on Q6(root) PD, so first
>> q6 pd should be up before wcss pd. After wcss pd goes down,
>> q6 pd should be turned off.
>>
>> rproc->ops->start(userpd_rproc) {
>>     /* Boot root pd rproc */
>>     rproc_boot(upd_dev->parent);
>>     ---
>>     /* user pd rproc start sequence */
>>     ---
>>     ---
>> }
>> With this way we ensure that root pd brought up before userpd.
>>
>> rproc->ops->stop(userpd_rproc) {
>>     ---
>>     ---
>>     /* user pd rproc stop sequence */
>>     ---
>>     ---
>>     /* Shutdown root pd rproc */
>>     rproc_shutdown(upd_dev->parent);
>> }
>> After userpd rproc stops, root pd rproc will be stopped.
>> IPQ5018, IPQ9574 supports multipd remoteproc driver.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   drivers/firmware/qcom_scm.c            | 114 +++++
>>   drivers/firmware/qcom_scm.h            |   6 +
>>   drivers/remoteproc/Kconfig             |  20 +
>>   drivers/remoteproc/Makefile            |   1 +
>>   drivers/remoteproc/qcom_common.c       |  23 +
>>   drivers/remoteproc/qcom_common.h       |   1 +
>>   drivers/remoteproc/qcom_q6v5.c         |  41 +-
>>   drivers/remoteproc/qcom_q6v5.h         |  15 +-
>>   drivers/remoteproc/qcom_q6v5_adsp.c    |   5 +-
>>   drivers/remoteproc/qcom_q6v5_mpd.c     | 668 +++++++++++++++++++++++++
>>   drivers/remoteproc/qcom_q6v5_mss.c     |   4 +-
>>   drivers/remoteproc/qcom_q6v5_pas.c     |   3 +-
>>   drivers/soc/qcom/mdt_loader.c          | 314 ++++++++++++
>>   include/linux/firmware/qcom/qcom_scm.h |   3 +
>>   include/linux/soc/qcom/mdt_loader.h    |  19 +
>>   15 files changed, 1228 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index d88c5f14bd54..d69560963353 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -654,6 +654,120 @@ int qcom_scm_pas_shutdown(u32 peripheral)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_pas_shutdown);
>> +/**
>> + * qti_scm_int_radio_powerup - Bring up internal radio userpd
>> + *
>> + * @peripheral:    peripheral id
>> + *
>> + * Return 0 on success.
>> + */
>> +int qti_scm_int_radio_powerup(u32 peripheral)
>> +{
> 
> qcom instead and in other places too.
> 
Internal open source team suggested to use qti.
>> +    int ret;
>> +    struct qcom_scm_desc desc = {
>> +        .svc = QCOM_SCM_PD_LOAD_SVC_ID,
>> +        .cmd = QCOM_SCM_INT_RAD_PWR_UP_CMD_ID,
>> +        .arginfo = QCOM_SCM_ARGS(1),
>> +        .args[0] = peripheral,
>> +        .owner = ARM_SMCCC_OWNER_SIP,
>> +    };
>> +    struct qcom_scm_res res;
>> +
>> +    ret = qcom_scm_clk_enable();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qcom_scm_bw_enable();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +    qcom_scm_bw_disable();
>> +    qcom_scm_clk_disable();
>> +
>> +    return ret ? : res.result[0];
>> +}
>> +EXPORT_SYMBOL(qti_scm_int_radio_powerup);
>> +
>> +/**
>> + * qti_scm_int_radio_powerdown() - Shut down internal radio userpd
>> + *
>> + * @peripheral: peripheral id
>> + *
>> + * Returns 0 on success.
>> + */
>> +int qti_scm_int_radio_powerdown(u32 peripheral)
>> +{
>> +    int ret;
>> +    struct qcom_scm_desc desc = {
>> +        .svc = QCOM_SCM_PD_LOAD_SVC_ID,
>> +        .cmd = QCOM_SCM_INT_RAD_PWR_DN_CMD_ID,
>> +        .arginfo = QCOM_SCM_ARGS(1),
>> +        .args[0] = peripheral,
>> +        .owner = ARM_SMCCC_OWNER_SIP,
>> +    };
>> +    struct qcom_scm_res res;
>> +
>> +    ret = qcom_scm_clk_enable();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qcom_scm_bw_enable();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +    qcom_scm_bw_disable();
>> +    qcom_scm_clk_disable();
>> +
>> +    return ret ? : res.result[0];
>> +}
>> +EXPORT_SYMBOL(qti_scm_int_radio_powerdown);
>> +
>> +/**
>> + * qti_scm_pdseg_memcpy_v2() - copy userpd PIL segments data to dma 
>> blocks
>> + *
>> + * @peripheral:        peripheral id
>> + * @phno:        program header no
>> + * @dma:        handle of dma region
>> + * @seg_cnt:        no of dma blocks
>> + *
>> + * Returns 0 if trustzone successfully loads userpd PIL segments from 
>> dma
>> + * blocks to DDR
>> + */
>> +int qti_scm_pdseg_memcpy_v2(u32 peripheral, int phno, dma_addr_t dma,
>> +                int seg_cnt)
>> +{
>> +    int ret;
>> +    struct qcom_scm_desc desc = {
>> +        .svc = QCOM_SCM_PD_LOAD_SVC_ID,
>> +        .cmd = QCOM_SCM_PD_LOAD_V2_CMD_ID,
>> +        .arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
>> +                        QCOM_SCM_RW, QCOM_SCM_VAL),
>> +        .args[0] = peripheral,
>> +        .args[1] = phno,
>> +        .args[2] = dma,
>> +        .args[3] = seg_cnt,
>> +        .owner = ARM_SMCCC_OWNER_SIP,
>> +    };
>> +    struct qcom_scm_res res;
>> +
>> +    ret = qcom_scm_clk_enable();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qcom_scm_bw_enable();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +    qcom_scm_bw_disable();
>> +    qcom_scm_clk_disable();
>> +
>> +    return ret ? : res.result[0];
>> +}
>> +EXPORT_SYMBOL(qti_scm_pdseg_memcpy_v2);
>> +
> 
> This patch should be split further.
> btw, this new scm apis should go in as one patch first separately.
> 
Sure, will do it.
>>   /**
>>    * qcom_scm_pas_supported() - Check if the peripheral authentication 
>> service is
>>    *                  available for the given peripherial
>> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
>> index e6e512bd57d1..99e3ab2f1986 100644
>> --- a/drivers/firmware/qcom_scm.h
>> +++ b/drivers/firmware/qcom_scm.h
>> @@ -132,6 +132,12 @@ extern int scm_legacy_call(struct device *dev, 
>> const struct qcom_scm_desc *desc,
>>   #define QCOM_SCM_SMMU_CONFIG_ERRATA1        0x03
>>   #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL    0x02
>> +#define QCOM_SCM_PD_LOAD_SVC_ID            0x2
>> +#define QCOM_SCM_PD_LOAD_CMD_ID            0x16
>> +#define QCOM_SCM_PD_LOAD_V2_CMD_ID        0x19
>> +#define QCOM_SCM_INT_RAD_PWR_UP_CMD_ID        0x17
>> +#define QCOM_SCM_INT_RAD_PWR_DN_CMD_ID        0x18
>> +
>>   #define QCOM_SCM_SVC_WAITQ            0x24
>>   #define QCOM_SCM_WAITQ_RESUME            0x02
>>   #define QCOM_SCM_WAITQ_GET_WQ_CTX        0x03
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index a850e9f486dd..44af5c36f67e 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -234,6 +234,26 @@ config QCOM_Q6V5_PAS
>>         CDSP (Compute DSP), MPSS (Modem Peripheral SubSystem), and
>>         SLPI (Sensor Low Power Island).
>> +config QCOM_Q6V5_MPD
>> +    tristate "Qualcomm Hexagon based MPD model Peripheral Image Loader"
>> +    depends on OF && ARCH_QCOM
>> +    depends on QCOM_SMEM
>> +    depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
>> +    depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>> +    depends on QCOM_SYSMON || QCOM_SYSMON=n
>> +    depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>> +    depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>> +    select MFD_SYSCON
>> +    select QCOM_MDT_LOADER
>> +    select QCOM_PIL_INFO
>> +    select QCOM_Q6V5_COMMON
>> +    select QCOM_RPROC_COMMON
>> +    select QCOM_SCM
>> +    help
>> +      Say y here to support the Qualcomm Secure Peripheral Image Loader
>> +      for the Hexagon based MultiPD model remote processors on e.g. 
>> IPQ5018.
>> +      This is trustZone wireless subsystem.
>> +
>>   config QCOM_Q6V5_WCSS
>>       tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>>       depends on OF && ARCH_QCOM
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 91314a9b43ce..b64051080ec1 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -25,6 +25,7 @@ obj-$(CONFIG_QCOM_PIL_INFO)        += qcom_pil_info.o
>>   obj-$(CONFIG_QCOM_RPROC_COMMON)        += qcom_common.o
>>   obj-$(CONFIG_QCOM_Q6V5_COMMON)        += qcom_q6v5.o
>>   obj-$(CONFIG_QCOM_Q6V5_ADSP)        += qcom_q6v5_adsp.o
>> +obj-$(CONFIG_QCOM_Q6V5_MPD)        += qcom_q6v5_mpd.o
>>   obj-$(CONFIG_QCOM_Q6V5_MSS)        += qcom_q6v5_mss.o
>>   obj-$(CONFIG_QCOM_Q6V5_PAS)        += qcom_q6v5_pas.o
>>   obj-$(CONFIG_QCOM_Q6V5_WCSS)        += qcom_q6v5_wcss.o
>> diff --git a/drivers/remoteproc/qcom_common.c 
>> b/drivers/remoteproc/qcom_common.c
>> index a0d4238492e9..b72fbda02242 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -510,5 +510,28 @@ void qcom_remove_ssr_subdev(struct rproc *rproc, 
>> struct qcom_rproc_ssr *ssr)
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
>> +/**
>> + * qcom_get_pd_asid() - get the pd asid number from DT node
>> + * @node:    device tree node
>> + *
>> + * Returns asid if node name has 'pd' string
>> + */
>> +s8 qcom_get_pd_asid(struct device_node *node)
>> +{
>> +    char *str;
>> +    u8 pd_asid;
>> +
>> +    if (!node)
>> +        return -EINVAL;
>> +
>> +    str = strstr(node->name, "pd");
>> +    if (!str)
>> +        return 0;
>> +
>> +    str += strlen("pd");
>> +    return kstrtos8(str, 10, &pd_asid) ? -EINVAL : pd_asid;
>> +}
>> +EXPORT_SYMBOL(qcom_get_pd_asid);
>> +
>>   MODULE_DESCRIPTION("Qualcomm Remoteproc helper driver");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/remoteproc/qcom_common.h 
>> b/drivers/remoteproc/qcom_common.h
>> index 9ef4449052a9..9f3fb11224aa 100644
>> --- a/drivers/remoteproc/qcom_common.h
>> +++ b/drivers/remoteproc/qcom_common.h
>> @@ -75,5 +75,6 @@ static inline bool qcom_sysmon_shutdown_acked(struct 
>> qcom_sysmon *sysmon)
>>       return false;
>>   }
>>   #endif
>> +s8 qcom_get_pd_asid(struct device_node *node);
>>   #endif
>> diff --git a/drivers/remoteproc/qcom_q6v5.c 
>> b/drivers/remoteproc/qcom_q6v5.c
>> index 192c7aa0e39e..b88bf3a8e53b 100644
>> --- a/drivers/remoteproc/qcom_q6v5.c
>> +++ b/drivers/remoteproc/qcom_q6v5.c
>> @@ -118,7 +118,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, 
>> void *data)
>>       return IRQ_HANDLED;
>>   }
>> -static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>> +irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>   {
>>       struct qcom_q6v5 *q6v5 = data;
>>       size_t len;
>> @@ -139,7 +139,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, 
>> void *data)
>>       return IRQ_HANDLED;
>>   }
>> -static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>> +irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>>   {
>>       struct qcom_q6v5 *q6v5 = data;
>> @@ -183,7 +183,16 @@ static irqreturn_t q6v5_handover_interrupt(int 
>> irq, void *data)
>>       return IRQ_HANDLED;
>>   }
>> -static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
>> +irqreturn_t q6v5_spawn_interrupt(int irq, void *data)
>> +{
>> +    struct qcom_q6v5 *q6v5 = data;
>> +
>> +    complete(&q6v5->spawn_done);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +irqreturn_t q6v5_stop_interrupt(int irq, void *data)
>>   {
>>       struct qcom_q6v5 *q6v5 = data;
>> @@ -220,6 +229,28 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 
>> *q6v5, struct qcom_sysmon *sysmon)
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
>> +/**
>> + * qcom_q6v5_request_spawn() - request the remote processor to spawn
>> + * @q6v5:      reference to qcom_q6v5 context
>> + *
>> + * Return: 0 on success, negative errno on failure
>> + */
>> +int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5)
>> +{
>> +    int ret;
>> +
>> +    ret = qcom_smem_state_update_bits(q6v5->spawn_state,
>> +                      BIT(q6v5->spawn_bit), BIT(q6v5->spawn_bit));
>> +
>> +    ret = wait_for_completion_timeout(&q6v5->spawn_done, 5 * HZ);
>> +
>> +    qcom_smem_state_update_bits(q6v5->spawn_state,
>> +                    BIT(q6v5->spawn_bit), 0);
>> +
>> +    return ret == 0 ? -ETIMEDOUT : 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_q6v5_request_spawn);
>> +
>>   /**
>>    * qcom_q6v5_panic() - panic handler to invoke a stop on the remote
>>    * @q6v5:    reference to qcom_q6v5 context
>> @@ -250,7 +281,8 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>>    * Return: 0 on success, negative errno on failure
>>    */
>>   int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device 
>> *pdev,
>> -           struct rproc *rproc, int crash_reason, const char 
>> *load_state,
>> +           struct rproc *rproc, int remote_id, int crash_reason,
>> +           const char *load_state,
>>              void (*handover)(struct qcom_q6v5 *q6v5))
>>   {
>>       int ret;
>> @@ -258,6 +290,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct 
>> platform_device *pdev,
>>       q6v5->rproc = rproc;
>>       q6v5->dev = &pdev->dev;
>>       q6v5->crash_reason = crash_reason;
>> +    q6v5->remote_id = remote_id;
>>       q6v5->handover = handover;
>>       init_completion(&q6v5->start_done);
>> diff --git a/drivers/remoteproc/qcom_q6v5.h 
>> b/drivers/remoteproc/qcom_q6v5.h
>> index 5a859c41896e..d00568339d46 100644
>> --- a/drivers/remoteproc/qcom_q6v5.h
>> +++ b/drivers/remoteproc/qcom_q6v5.h
>> @@ -18,22 +18,29 @@ struct qcom_q6v5 {
>>       struct qcom_smem_state *state;
>>       struct qmp *qmp;
>> +    struct qcom_smem_state *shutdown_state;
>> +    struct qcom_smem_state *spawn_state;
>>       struct icc_path *path;
>>       unsigned stop_bit;
>> +    unsigned shutdown_bit;
>> +    unsigned spawn_bit;
>>       int wdog_irq;
>>       int fatal_irq;
>>       int ready_irq;
>>       int handover_irq;
>>       int stop_irq;
>> +    int spawn_irq;
>>       bool handover_issued;
>>       struct completion start_done;
>>       struct completion stop_done;
>> +    struct completion spawn_done;
>> +    int remote_id;
>>       int crash_reason;
>>       bool running;
>> @@ -43,14 +50,20 @@ struct qcom_q6v5 {
>>   };
>>   int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device 
>> *pdev,
>> -           struct rproc *rproc, int crash_reason, const char 
>> *load_state,
>> +           struct rproc *rproc, int remote_id, int crash_reason,
>> +           const char *load_state,
>>              void (*handover)(struct qcom_q6v5 *q6v5));
>>   void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>>   int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
>>   int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
>>   int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct 
>> qcom_sysmon *sysmon);
>> +int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5);
>>   int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
>>   unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
>> +irqreturn_t q6v5_fatal_interrupt(int irq, void *data);
>> +irqreturn_t q6v5_ready_interrupt(int irq, void *data);
>> +irqreturn_t q6v5_spawn_interrupt(int irq, void *data);
>> +irqreturn_t q6v5_stop_interrupt(int irq, void *data);
> 
> Even this also you can keep it as a separate preparatory patch to pull
> out the common functions.
> 
Sure, will raise a new patch.
>>   #endif
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 08d8dad22ca7..bf8909ad5ff5 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -733,8 +733,9 @@ static int adsp_probe(struct platform_device *pdev)
>>       if (ret)
>>           goto disable_pm;
>> -    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, 
>> desc->crash_reason_smem,
>> -                 desc->load_state, qcom_adsp_pil_handover);
>> +    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>> +                 desc->crash_reason_smem, desc->load_state,
>> +                 qcom_adsp_pil_handover);
>>       if (ret)
>>           goto disable_pm;
>> diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c 
>> b/drivers/remoteproc/qcom_q6v5_mpd.c
>> new file mode 100644
>> index 000000000000..853aa3bc5859
>> --- /dev/null
>> +++ b/drivers/remoteproc/qcom_q6v5_mpd.c
>> @@ -0,0 +1,668 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2016-2018 Linaro Ltd.
>> + * Copyright (C) 2014 Sony Mobile Communications AB
>> + * Copyright (c) 2012-2018, 2021 The Linux Foundation. All rights 
>> reserved.
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/soc/qcom/mdt_loader.h>
>> +#include <linux/soc/qcom/smem.h>
>> +#include <linux/soc/qcom/smem_state.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/interrupt.h>
> 
>   Alphabetical order.
> 
I will update.
> Regards,
>   Sricharan
