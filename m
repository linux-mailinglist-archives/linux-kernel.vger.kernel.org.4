Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3476E70AFE7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjEUT0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEUT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:26:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F7CF;
        Sun, 21 May 2023 12:26:26 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LJ7ZmH003038;
        Sun, 21 May 2023 19:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : cc : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x3gTcSSEkTaSqEvWxiLK+n/OjcuixqGUeVluMbFO3Es=;
 b=hR5hIzutVvnvdn2T668iFGhUHWMvjTo3fxUMLaWXdHeN7OtCGIVh0/lOVFpqFs8B3/Ak
 iDTXUmLToZQ+GEC39jYTU+KkN0lXzdB8fqVI4D8JWuy62t9Z535z+Hepcn/gHkwp7fLm
 shbI9TEEsVYyfnbQ1aWqjhB4VwrRDe5weNLFCGD2KClQRdfQw3P7pOKIdieQfiyA1IAS
 FjCceQogIaTQOM5QGyAdJJr1Wrz6OmjgUaYQvZC5BM9nTwO0GVT3zT9No9+6BK5TFw/k
 iKROXqqE/vwhzvS6dBTQrwliVrTrUicz5+N6YCw0mS86QA9lDTa3aaGS8FVKH0R73Tm0 Bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpn5y2675-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 19:26:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LJQPSF000788
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 19:26:25 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 12:26:22 -0700
Message-ID: <0b6dfd41-6e9a-8231-4ffd-289e42267673@quicinc.com>
Date:   Mon, 22 May 2023 00:56:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20230519083855.GB9173@varda-linux.qualcomm.com>
 <82272edf-71b7-f9bb-4b94-c7970c1317bc@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
In-Reply-To: <82272edf-71b7-f9bb-4b94-c7970c1317bc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H68tcMDnIEpL3kySWODpmudU9qrf4MEo
X-Proofpoint-GUID: H68tcMDnIEpL3kySWODpmudU9qrf4MEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210174
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2023 10:17 PM, Manikanta Mylavarapu wrote:
> 
> 
> On 5/19/2023 2:08 PM, Varadarajan Narayanan wrote:
>> ----- Forwarded message from Varadarajan Narayanan 
>> <quic_varada@quicinc.com> -----
>>
>> Date: Tue, 7 Mar 2023 11:46:04 +0530
>> Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd 
>> rproc driver
>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>> To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, 
>> agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
>> robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
>>     jassisinghbrar@gmail.com, mathieu.poirier@linaro.org, 
>> mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com, 
>> loic.poulain@linaro.org, quic_eberman@quicinc.com,
>>     robimarko@gmail.com, linux-arm-msm@vger.kernel.org, 
>> devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
>> linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
>> CC: quic_srichara@quicinc.com, quic_gokulsri@quicinc.com, 
>> quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com, 
>> quic_arajkuma@quicinc.com, quic_anusha@quicinc.com, 
>> quic_poovendh@quicinc.com
>>
>>
>> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>>> APSS brings Q6 out of reset and then Q6 brings
>>> WCSS block (wifi radio's) out of reset.
>>>
>>>                    ---------------
>>>                   -->  |WiFi 2G radio|
>>>                   |       --------------
>>>                   |
>>> --------    -------          |
>>> | APSS | --->   |QDSP6|  -----|
>>> ---------    -------       |
>>>                                 |
>>>                           |
>>>                   |   --------------
>>>                   --> |WiFi 5G radio|
>>>                   --------------
>>>
>>> Problem here is if any radio crashes, subsequently other
>>> radio also should crash because Q6 crashed. Let's say
>>> 2G radio crashed, Q6 should pass this info to APSS. Only
>>> Q6 processor interrupts registered with APSS. Obviously
>>> Q6 should crash and raise fatal interrupt to APSS. Due
>>> to this 5G radio also crashed. But no issue in 5G radio,
>>> because of 2G radio crash 5G radio also impacted.
>>>
>>> In multi pd model, this problem is resolved. Here WCSS
>>> functionality (WiFi radio's) moved out from Q6 root pd
>>> to a separate user pd. Due to this, radio's independently
>>> pass their status info to APPS with out crashing Q6. So
>>> other radio's won't be impacted.
>>>
>>>                         ---------
>>>                             |WiFi    |
>>>                         --> |2G radio|
>>>                         |     ---------
>>> ------    Start Q6             -------     |
>>> |    |    ------------------>     |     |     |
>>> |    |  Start WCSS PD1 (2G)       |     |        |
>>> |APSS|    ----------------------->|QDSP6|-----|
>>> |    |    Start WCSS PD1 (5G)    |     |
>>> |    |    ----------------------->|     |-----|
>>> ------                     -------     |
>>>                         |
>>>                         |    -----------
>>>                         |-->|WiFi      |
>>>                         |5G radio |
>>>                         -----------
>>> According to linux terminology, here consider Q6 as root
>>> i.e it provide all services, WCSS (wifi radio's) as user
>>> i.e it uses services provided by root.
>>>
>>> Since Q6 root & WCSS user pd's able to communicate with
>>> APSS individually, multipd remoteproc driver registers
>>> each PD with rproc framework. Here clients (Wifi host drivers)
>>> intrested on WCSS PD rproc, so multipd driver start's root
>>> pd in the context of WCSS user pd rproc start. Similarly
>>> on down path, root pd will be stopped after wcss user pd
>>> stopped.
>>>
>>> Here WCSS(user) PD is dependent on Q6(root) PD, so first
>>> q6 pd should be up before wcss pd. After wcss pd goes down,
>>> q6 pd should be turned off.
>>>
>>> rproc->ops->start(userpd_rproc) {
>>>     /* Boot root pd rproc */
>>>     rproc_boot(upd_dev->parent);
>>>     ---
>>>     /* user pd rproc start sequence */
>>>     ---
>>>     ---
>>> }
>>> With this way we ensure that root pd brought up before userpd.
>>>
>>> rproc->ops->stop(userpd_rproc) {
>>>     ---
>>>     ---
>>>     /* user pd rproc stop sequence */
>>>     ---
>>>     ---
>>>     /* Shutdown root pd rproc */
>>>     rproc_shutdown(upd_dev->parent);
>>> }
>>> After userpd rproc stops, root pd rproc will be stopped.
>>> IPQ5018, IPQ9574 supports multipd remoteproc driver.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>>    drivers/firmware/qcom_scm.c            | 114 +++++
>>>    drivers/firmware/qcom_scm.h            |   6 +
>>>    drivers/remoteproc/Kconfig             |  20 +
>>>    drivers/remoteproc/Makefile            |   1 +
>>>    drivers/remoteproc/qcom_common.c       |  23 +
>>>    drivers/remoteproc/qcom_common.h       |   1 +
>>>    drivers/remoteproc/qcom_q6v5.c         |  41 +-
>>>    drivers/remoteproc/qcom_q6v5.h         |  15 +-
>>>    drivers/remoteproc/qcom_q6v5_adsp.c    |   5 +-
>>>    drivers/remoteproc/qcom_q6v5_mpd.c     | 668 
>>> +++++++++++++++++++++++++
>>>    drivers/remoteproc/qcom_q6v5_mss.c     |   4 +-
>>>    drivers/remoteproc/qcom_q6v5_pas.c     |   3 +-
>>>    drivers/soc/qcom/mdt_loader.c          | 314 ++++++++++++
>>>    include/linux/firmware/qcom/qcom_scm.h |   3 +
>>>    include/linux/soc/qcom/mdt_loader.h    |  19 +
>>>    15 files changed, 1228 insertions(+), 9 deletions(-)
>>>    create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
>>>
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index d88c5f14bd54..d69560963353 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -654,6 +654,120 @@ int qcom_scm_pas_shutdown(u32 peripheral)
>>>    }
>>>    EXPORT_SYMBOL(qcom_scm_pas_shutdown);
>>> +/**
>>> + * qti_scm_int_radio_powerup - Bring up internal radio userpd
>>> + *
>>> + * @peripheral:    peripheral id
>>> + *
>>> + * Return 0 on success.
>>> + */
>>> +int qti_scm_int_radio_powerup(u32 peripheral)
>>> +{
>>> +    int ret;
>>> +    struct qcom_scm_desc desc = {
>>> +        .svc = QCOM_SCM_PD_LOAD_SVC_ID,
>>> +        .cmd = QCOM_SCM_INT_RAD_PWR_UP_CMD_ID,
>>> +        .arginfo = QCOM_SCM_ARGS(1),
>>> +        .args[0] = peripheral,
>>> +        .owner = ARM_SMCCC_OWNER_SIP,
>>> +    };
>>> +    struct qcom_scm_res res;
>>> +
>>> +    ret = qcom_scm_clk_enable();
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = qcom_scm_bw_enable();
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = qcom_scm_call(__scm->dev, &desc, &res);
>>> +    qcom_scm_bw_disable();
>>> +    qcom_scm_clk_disable();
>>> +
>>> +    return ret ? : res.result[0];
>>> +}
>>> +EXPORT_SYMBOL(qti_scm_int_radio_powerup);
>>> +
>>> +/**
>>> + * qti_scm_int_radio_powerdown() - Shut down internal radio userpd
>>> + *
>>> + * @peripheral: peripheral id
>>> + *
>>> + * Returns 0 on success.
>>> + */
>>> +int qti_scm_int_radio_powerdown(u32 peripheral)
>>> +{
>>> +    int ret;
>>> +    struct qcom_scm_desc desc = {
>>> +        .svc = QCOM_SCM_PD_LOAD_SVC_ID,
>>> +        .cmd = QCOM_SCM_INT_RAD_PWR_DN_CMD_ID,
>>> +        .arginfo = QCOM_SCM_ARGS(1),
>>> +        .args[0] = peripheral,
>>> +        .owner = ARM_SMCCC_OWNER_SIP,
>>> +    };
>>> +    struct qcom_scm_res res;
>>> +
>>> +    ret = qcom_scm_clk_enable();
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = qcom_scm_bw_enable();
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = qcom_scm_call(__scm->dev, &desc, &res);
>>> +    qcom_scm_bw_disable();
>>> +    qcom_scm_clk_disable();
>>> +
>>> +    return ret ? : res.result[0];
>>> +}
>>> +EXPORT_SYMBOL(qti_scm_int_radio_powerdown);
>>> +
>>> +/**
>>> + * qti_scm_pdseg_memcpy_v2() - copy userpd PIL segments data to dma 
>>> blocks
>>> + *
>>> + * @peripheral:        peripheral id
>>> + * @phno:        program header no
>>> + * @dma:        handle of dma region
>>> + * @seg_cnt:        no of dma blocks
>>> + *
>>> + * Returns 0 if trustzone successfully loads userpd PIL segments 
>>> from dma
>>> + * blocks to DDR
>>> + */
>>> +int qti_scm_pdseg_memcpy_v2(u32 peripheral, int phno, dma_addr_t dma,
>>> +                int seg_cnt)
>>> +{
>>> +    int ret;
>>> +    struct qcom_scm_desc desc = {
>>> +        .svc = QCOM_SCM_PD_LOAD_SVC_ID,
>>> +        .cmd = QCOM_SCM_PD_LOAD_V2_CMD_ID,
>>> +        .arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
>>> +                        QCOM_SCM_RW, QCOM_SCM_VAL),
>>> +        .args[0] = peripheral,
>>> +        .args[1] = phno,
>>> +        .args[2] = dma,
>>> +        .args[3] = seg_cnt,
>>> +        .owner = ARM_SMCCC_OWNER_SIP,
>>> +    };
>>> +    struct qcom_scm_res res;
>>> +
>>> +    ret = qcom_scm_clk_enable();
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = qcom_scm_bw_enable();
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = qcom_scm_call(__scm->dev, &desc, &res);
>>> +    qcom_scm_bw_disable();
>>> +    qcom_scm_clk_disable();
>>> +
>>> +    return ret ? : res.result[0];
>>> +}
>>> +EXPORT_SYMBOL(qti_scm_pdseg_memcpy_v2);
>>> +
>>>    /**
>>>     * qcom_scm_pas_supported() - Check if the peripheral 
>>> authentication service is
>>>     *                  available for the given peripherial
>>> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
>>> index e6e512bd57d1..99e3ab2f1986 100644
>>> --- a/drivers/firmware/qcom_scm.h
>>> +++ b/drivers/firmware/qcom_scm.h
>>> @@ -132,6 +132,12 @@ extern int scm_legacy_call(struct device *dev, 
>>> const struct qcom_scm_desc *desc,
>>>    #define QCOM_SCM_SMMU_CONFIG_ERRATA1        0x03
>>>    #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL    0x02
>>> +#define QCOM_SCM_PD_LOAD_SVC_ID            0x2
>>> +#define QCOM_SCM_PD_LOAD_CMD_ID            0x16
>>> +#define QCOM_SCM_PD_LOAD_V2_CMD_ID        0x19
>>> +#define QCOM_SCM_INT_RAD_PWR_UP_CMD_ID        0x17
>>> +#define QCOM_SCM_INT_RAD_PWR_DN_CMD_ID        0x18
>>> +
>>>    #define QCOM_SCM_SVC_WAITQ            0x24
>>>    #define QCOM_SCM_WAITQ_RESUME            0x02
>>>    #define QCOM_SCM_WAITQ_GET_WQ_CTX        0x03
>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>> index a850e9f486dd..44af5c36f67e 100644
>>> --- a/drivers/remoteproc/Kconfig
>>> +++ b/drivers/remoteproc/Kconfig
>>> @@ -234,6 +234,26 @@ config QCOM_Q6V5_PAS
>>>          CDSP (Compute DSP), MPSS (Modem Peripheral SubSystem), and
>>>          SLPI (Sensor Low Power Island).
>>> +config QCOM_Q6V5_MPD
>>> +    tristate "Qualcomm Hexagon based MPD model Peripheral Image Loader"
>>> +    depends on OF && ARCH_QCOM
>>> +    depends on QCOM_SMEM
>>> +    depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
>>> +    depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>>> +    depends on QCOM_SYSMON || QCOM_SYSMON=n
>>> +    depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>>> +    depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>>> +    select MFD_SYSCON
>>> +    select QCOM_MDT_LOADER
>>> +    select QCOM_PIL_INFO
>>> +    select QCOM_Q6V5_COMMON
>>> +    select QCOM_RPROC_COMMON
>>> +    select QCOM_SCM
>>> +    help
>>> +      Say y here to support the Qualcomm Secure Peripheral Image Loader
>>> +      for the Hexagon based MultiPD model remote processors on e.g. 
>>> IPQ5018.
>>> +      This is trustZone wireless subsystem.
>>> +
>>>    config QCOM_Q6V5_WCSS
>>>        tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>>>        depends on OF && ARCH_QCOM
>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>>> index 91314a9b43ce..b64051080ec1 100644
>>> --- a/drivers/remoteproc/Makefile
>>> +++ b/drivers/remoteproc/Makefile
>>> @@ -25,6 +25,7 @@ obj-$(CONFIG_QCOM_PIL_INFO)        += qcom_pil_info.o
>>>    obj-$(CONFIG_QCOM_RPROC_COMMON)        += qcom_common.o
>>>    obj-$(CONFIG_QCOM_Q6V5_COMMON)        += qcom_q6v5.o
>>>    obj-$(CONFIG_QCOM_Q6V5_ADSP)        += qcom_q6v5_adsp.o
>>> +obj-$(CONFIG_QCOM_Q6V5_MPD)        += qcom_q6v5_mpd.o
>>>    obj-$(CONFIG_QCOM_Q6V5_MSS)        += qcom_q6v5_mss.o
>>>    obj-$(CONFIG_QCOM_Q6V5_PAS)        += qcom_q6v5_pas.o
>>>    obj-$(CONFIG_QCOM_Q6V5_WCSS)        += qcom_q6v5_wcss.o
>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>> b/drivers/remoteproc/qcom_common.c
>>> index a0d4238492e9..b72fbda02242 100644
>>> --- a/drivers/remoteproc/qcom_common.c
>>> +++ b/drivers/remoteproc/qcom_common.c
>>> @@ -510,5 +510,28 @@ void qcom_remove_ssr_subdev(struct rproc *rproc, 
>>> struct qcom_rproc_ssr *ssr)
>>>    }
>>>    EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
>>> +/**
>>> + * qcom_get_pd_asid() - get the pd asid number from DT node
>>> + * @node:    device tree node
>>> + *
>>> + * Returns asid if node name has 'pd' string
>>> + */
>>> +s8 qcom_get_pd_asid(struct device_node *node)
>>> +{
>>> +    char *str;
>>> +    u8 pd_asid;
>>> +
>>> +    if (!node)
>>> +        return -EINVAL;
>>> +
>>> +    str = strstr(node->name, "pd");
>>> +    if (!str)
>>> +        return 0;
>>> +
>>> +    str += strlen("pd");
>>> +    return kstrtos8(str, 10, &pd_asid) ? -EINVAL : pd_asid;
>>> +}
>>> +EXPORT_SYMBOL(qcom_get_pd_asid);
>>
>> Function return type is 's8', but pd_asid is 'u8'
>>
> I will update to s8.
>>> +
>>>    MODULE_DESCRIPTION("Qualcomm Remoteproc helper driver");
>>>    MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/remoteproc/qcom_common.h 
>>> b/drivers/remoteproc/qcom_common.h
>>> index 9ef4449052a9..9f3fb11224aa 100644
>>> --- a/drivers/remoteproc/qcom_common.h
>>> +++ b/drivers/remoteproc/qcom_common.h
>>> @@ -75,5 +75,6 @@ static inline bool 
>>> qcom_sysmon_shutdown_acked(struct qcom_sysmon *sysmon)
>>>        return false;
>>>    }
>>>    #endif
>>> +s8 qcom_get_pd_asid(struct device_node *node);
>>>    #endif
>>> diff --git a/drivers/remoteproc/qcom_q6v5.c 
>>> b/drivers/remoteproc/qcom_q6v5.c
>>> index 192c7aa0e39e..b88bf3a8e53b 100644
>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>> @@ -118,7 +118,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, 
>>> void *data)
>>>        return IRQ_HANDLED;
>>>    }
>>> -static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>> +irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>>    {
>>>        struct qcom_q6v5 *q6v5 = data;
>>>        size_t len;
>>> @@ -139,7 +139,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, 
>>> void *data)
>>>        return IRQ_HANDLED;
>>>    }
>>> -static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>>> +irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>>>    {
>>>        struct qcom_q6v5 *q6v5 = data;
>>> @@ -183,7 +183,16 @@ static irqreturn_t q6v5_handover_interrupt(int 
>>> irq, void *data)
>>>        return IRQ_HANDLED;
>>>    }
>>> -static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
>>> +irqreturn_t q6v5_spawn_interrupt(int irq, void *data)
>>> +{
>>> +    struct qcom_q6v5 *q6v5 = data;
>>> +
>>> +    complete(&q6v5->spawn_done);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +irqreturn_t q6v5_stop_interrupt(int irq, void *data)
>>>    {
>>>        struct qcom_q6v5 *q6v5 = data;
>>> @@ -220,6 +229,28 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 
>>> *q6v5, struct qcom_sysmon *sysmon)
>>>    }
>>>    EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
>>> +/**
>>> + * qcom_q6v5_request_spawn() - request the remote processor to spawn
>>> + * @q6v5:      reference to qcom_q6v5 context
>>> + *
>>> + * Return: 0 on success, negative errno on failure
>>> + */
>>> +int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = qcom_smem_state_update_bits(q6v5->spawn_state,
>>> +                      BIT(q6v5->spawn_bit), BIT(q6v5->spawn_bit));
>>> +
>>> +    ret = wait_for_completion_timeout(&q6v5->spawn_done, 5 * HZ);
>>> +
>>> +    qcom_smem_state_update_bits(q6v5->spawn_state,
>>> +                    BIT(q6v5->spawn_bit), 0);
>>> +
>>> +    return ret == 0 ? -ETIMEDOUT : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_q6v5_request_spawn);
>>> +
>>>    /**
>>>     * qcom_q6v5_panic() - panic handler to invoke a stop on the remote
>>>     * @q6v5:    reference to qcom_q6v5 context
>>> @@ -250,7 +281,8 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>>>     * Return: 0 on success, negative errno on failure
>>>     */
>>>    int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device 
>>> *pdev,
>>> -           struct rproc *rproc, int crash_reason, const char 
>>> *load_state,
>>> +           struct rproc *rproc, int remote_id, int crash_reason,
>>> +           const char *load_state,
>>>               void (*handover)(struct qcom_q6v5 *q6v5))
>>>    {
>>>        int ret;
>>> @@ -258,6 +290,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct 
>>> platform_device *pdev,
>>>        q6v5->rproc = rproc;
>>>        q6v5->dev = &pdev->dev;
>>>        q6v5->crash_reason = crash_reason;
>>> +    q6v5->remote_id = remote_id;
>>>        q6v5->handover = handover;
>>>        init_completion(&q6v5->start_done);
>>> diff --git a/drivers/remoteproc/qcom_q6v5.h 
>>> b/drivers/remoteproc/qcom_q6v5.h
>>> index 5a859c41896e..d00568339d46 100644
>>> --- a/drivers/remoteproc/qcom_q6v5.h
>>> +++ b/drivers/remoteproc/qcom_q6v5.h
>>> @@ -18,22 +18,29 @@ struct qcom_q6v5 {
>>>        struct qcom_smem_state *state;
>>>        struct qmp *qmp;
>>> +    struct qcom_smem_state *shutdown_state;
>>> +    struct qcom_smem_state *spawn_state;
>>>        struct icc_path *path;
>>>        unsigned stop_bit;
>>> +    unsigned shutdown_bit;
>>> +    unsigned spawn_bit;
>>>        int wdog_irq;
>>>        int fatal_irq;
>>>        int ready_irq;
>>>        int handover_irq;
>>>        int stop_irq;
>>> +    int spawn_irq;
>>>        bool handover_issued;
>>>        struct completion start_done;
>>>        struct completion stop_done;
>>> +    struct completion spawn_done;
>>> +    int remote_id;
>>>        int crash_reason;
>>>        bool running;
>>> @@ -43,14 +50,20 @@ struct qcom_q6v5 {
>>>    };
>>>    int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device 
>>> *pdev,
>>> -           struct rproc *rproc, int crash_reason, const char 
>>> *load_state,
>>> +           struct rproc *rproc, int remote_id, int crash_reason,
>>> +           const char *load_state,
>>>               void (*handover)(struct qcom_q6v5 *q6v5));
>>>    void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>>>    int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
>>>    int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
>>>    int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct 
>>> qcom_sysmon *sysmon);
>>> +int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5);
>>>    int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
>>>    unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
>>> +irqreturn_t q6v5_fatal_interrupt(int irq, void *data);
>>> +irqreturn_t q6v5_ready_interrupt(int irq, void *data);
>>> +irqreturn_t q6v5_spawn_interrupt(int irq, void *data);
>>> +irqreturn_t q6v5_stop_interrupt(int irq, void *data);
>>>    #endif
>>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>>> index 08d8dad22ca7..bf8909ad5ff5 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>>> @@ -733,8 +733,9 @@ static int adsp_probe(struct platform_device *pdev)
>>>        if (ret)
>>>            goto disable_pm;
>>> -    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, 
>>> desc->crash_reason_smem,
>>> -                 desc->load_state, qcom_adsp_pil_handover);
>>> +    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>>> +                 desc->crash_reason_smem, desc->load_state,
>>> +                 qcom_adsp_pil_handover);
>>>        if (ret)
>>>            goto disable_pm;
>>> diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c 
>>> b/drivers/remoteproc/qcom_q6v5_mpd.c
>>> new file mode 100644
>>> index 000000000000..853aa3bc5859
>>> --- /dev/null
>>> +++ b/drivers/remoteproc/qcom_q6v5_mpd.c
>>> @@ -0,0 +1,668 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2016-2018 Linaro Ltd.
>>> + * Copyright (C) 2014 Sony Mobile Communications AB
>>> + * Copyright (c) 2012-2018, 2021 The Linux Foundation. All rights 
>>> reserved.
>>> + */
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of_reserved_mem.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/soc/qcom/mdt_loader.h>
>>> +#include <linux/soc/qcom/smem.h>
>>> +#include <linux/soc/qcom/smem_state.h>
>>> +#include <linux/firmware/qcom/qcom_scm.h>
>>> +#include <linux/interrupt.h>
>>> +#include "qcom_common.h"
>>> +#include "qcom_q6v5.h"
>>> +
>>> +#include "remoteproc_internal.h"
>>> +
>>> +#define WCSS_CRASH_REASON        421
>>> +#define WCSS_SMEM_HOST            1
>>> +
>>> +#define WCNSS_PAS_ID            6
>>> +#define MPD_WCNSS_PAS_ID        0xD
>>> +
>>> +#define BUF_SIZE            35
>>> +
>>> +/**
>>> + * enum state - state of a wcss (private)
>>> + * @WCSS_NORMAL: subsystem is operating normally
>>> + * @WCSS_CRASHED: subsystem has crashed and hasn't been shutdown
>>> + * @WCSS_RESTARTING: subsystem has been shutdown and is now restarting
>>> + * @WCSS_SHUTDOWN: subsystem has been shutdown
>>> + *
>>> + */
>>> +enum q6_wcss_state {
>>> +    WCSS_NORMAL,
>>> +    WCSS_CRASHED,
>>> +    WCSS_RESTARTING,
>>> +    WCSS_SHUTDOWN,
>>> +};
>>> +
>>> +enum {
>>> +    Q6_IPQ,
>>> +    WCSS_AHB_IPQ,
>>> +    WCSS_PCIE_IPQ,
>>> +};
>>> +
>>> +struct q6_wcss {
>>> +    struct device *dev;
>>> +    struct qcom_rproc_glink glink_subdev;
>>> +    struct qcom_rproc_ssr ssr_subdev;
>>> +    struct qcom_q6v5 q6;
>>> +    phys_addr_t mem_phys;
>>> +    phys_addr_t mem_reloc;
>>> +    void *mem_region;
>>> +    size_t mem_size;
>>> +    int crash_reason_smem;
>>> +    u32 version;
>>> +    s8 pd_asid;
>>> +    enum q6_wcss_state state;
>>> +};
>>> +
>>> +struct wcss_data {
>>> +    int (*init_irq)(struct qcom_q6v5 *q6, struct platform_device *pdev,
>>> +            struct rproc *rproc, int remote_id,
>>> +            int crash_reason, const char *load_state,
>>> +            void (*handover)(struct qcom_q6v5 *q6));
>>> +    const char *q6_firmware_name;
>>> +    int crash_reason_smem;
>>> +    int remote_id;
>>> +    u32 version;
>>> +    const char *ssr_name;
>>> +    const struct rproc_ops *ops;
>>> +    bool need_auto_boot;
>>> +    bool glink_subdev_required;
>>> +    s8 pd_asid;
>>> +    bool reset_seq;
>>> +    u32 pasid;
>>> +    int (*mdt_load_sec)(struct device *dev, const struct firmware *fw,
>>> +                const char *fw_name, int pas_id, void *mem_region,
>>> +                phys_addr_t mem_phys, size_t mem_size,
>>> +                phys_addr_t *reloc_base);
>>> +};
>>> +
>>> +static int q6_wcss_start(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    int ret;
>>> +    struct device_node *upd_np;
>>> +    struct platform_device *upd_pdev;
>>> +    struct rproc *upd_rproc;
>>> +    struct q6_wcss *upd_wcss;
>>> +    const struct wcss_data *desc;
>>> +
>>> +    desc = of_device_get_match_data(wcss->dev);
>>> +    if (!desc)
>>> +        return -EINVAL;
>>> +
>>> +    qcom_q6v5_prepare(&wcss->q6);
>>> +
>>> +    ret = qcom_scm_pas_auth_and_reset(desc->pasid);
>>> +    if (ret) {
>>> +        dev_err(wcss->dev, "wcss_reset failed\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = qcom_q6v5_wait_for_start(&wcss->q6, 5 * HZ);
>>> +    if (ret == -ETIMEDOUT)
>>> +        dev_err(wcss->dev, "start timed out\n");
>>> +
>>> +    /* Bring userpd wcss state to default value */
>>> +    for_each_available_child_of_node(wcss->dev->of_node, upd_np) {
>>> +        if (!strstr(upd_np->name, "pd"))
>>> +            continue;
>>> +        upd_pdev = of_find_device_by_node(upd_np);
>>> +        upd_rproc = platform_get_drvdata(upd_pdev);
>>> +        upd_wcss = upd_rproc->priv;
>>> +        upd_wcss->state = WCSS_NORMAL;
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +static int q6_wcss_spawn_pd(struct rproc *rproc)
>>> +{
>>> +    int ret;
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +
>>> +    ret = qcom_q6v5_request_spawn(&wcss->q6);
>>> +    if (ret == -ETIMEDOUT) {
>>> +        pr_err("%s spawn timedout\n", rproc->name);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = qcom_q6v5_wait_for_start(&wcss->q6, msecs_to_jiffies(10000));
>>> +    if (ret == -ETIMEDOUT) {
>>> +        pr_err("%s start timedout\n", rproc->name);
>>> +        wcss->q6.running = false;
>>> +        return ret;
>>> +    }
>>> +    wcss->q6.running = true;
>>> +    return ret;
>>> +}
>>> +
>>> +static int wcss_ahb_pcie_pd_start(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    const struct wcss_data *desc = of_device_get_match_data(wcss->dev);
>>> +    int ret;
>>> +
>>> +    if (desc->reset_seq) {
>>> +        ret = qti_scm_int_radio_powerup(desc->pasid);
>>> +        if (ret) {
>>> +            dev_err(wcss->dev, "failed to power up ahb pd\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    if (wcss->q6.spawn_bit) {
>>> +        ret = q6_wcss_spawn_pd(rproc);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>> +    wcss->state = WCSS_NORMAL;
>>> +    return 0;
>>> +}
>>> +
>>> +static int q6_wcss_stop(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    int ret;
>>> +    const struct wcss_data *desc =
>>> +            of_device_get_match_data(wcss->dev);
>>> +
>>> +    if (!desc)
>>> +        return -EINVAL;
>>> +
>>> +    ret = qcom_scm_pas_shutdown(desc->pasid);
>>> +    if (ret) {
>>> +        dev_err(wcss->dev, "not able to shutdown\n");
>>> +        return ret;
>>> +    }
>>> +    qcom_q6v5_unprepare(&wcss->q6);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int wcss_ahb_pcie_pd_stop(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
>>> +    const struct wcss_data *desc = of_device_get_match_data(wcss->dev);
>>> +    int ret;
>>> +
>>> +    if (rproc->state != RPROC_CRASHED && wcss->q6.stop_bit) {
>>> +        ret = qcom_q6v5_request_stop(&wcss->q6, NULL);
>>> +        if (ret) {
>>> +            dev_err(&rproc->dev, "pd not stopped\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    if (desc->reset_seq) {
>>> +        ret = qti_scm_int_radio_powerdown(desc->pasid);
>>> +        if (ret) {
>>> +            dev_err(wcss->dev, "failed to power down pd\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    if (rproc->state != RPROC_CRASHED)
>>> +        rproc_shutdown(rpd_rproc);
>>> +
>>> +    wcss->state = WCSS_SHUTDOWN;
>>> +    return 0;
>>> +}
>>> +
>>> +static void *q6_wcss_da_to_va(struct rproc *rproc, u64 da, size_t len,
>>> +                  bool *is_iomem)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    int offset;
>>> +
>>> +    offset = da - wcss->mem_reloc;
>>> +    if (offset < 0 || offset + len > wcss->mem_size)
>>> +        return NULL;
>>> +
>>> +    return wcss->mem_region + offset;
>>> +}
>>> +
>>> +static int q6_wcss_load(struct rproc *rproc, const struct firmware *fw)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    const struct firmware *m3_fw;
>>> +    int ret;
>>> +    const char *m3_fw_name;
>>> +    struct device_node *upd_np;
>>> +    struct platform_device *upd_pdev;
>>> +    const struct wcss_data *desc =
>>> +                of_device_get_match_data(wcss->dev);
>>> +
>>> +    if (!desc)
>>> +        return -EINVAL;
>>> +
>>> +    /* load m3 firmware */
>>> +    for_each_available_child_of_node(wcss->dev->of_node, upd_np) {
>>> +        if (!strstr(upd_np->name, "pd"))
>>> +            continue;
>>> +        upd_pdev = of_find_device_by_node(upd_np);
>>> +
>>> +        ret = of_property_read_string(upd_np, "m3_firmware",
>>> +                          &m3_fw_name);
>>> +        if (!ret && m3_fw_name) {
>>> +            ret = request_firmware(&m3_fw, m3_fw_name,
>>> +                           &upd_pdev->dev);
>>> +            if (ret)
>>> +                continue;
>>> +
>>> +            ret = qcom_mdt_load_no_init(wcss->dev, m3_fw,
>>> +                            m3_fw_name, 0,
>>> +                            wcss->mem_region,
>>> +                            wcss->mem_phys,
>>> +                            wcss->mem_size,
>>> +                            &wcss->mem_reloc);
>>> +
>>> +            release_firmware(m3_fw);
>>> +
>>> +            if (ret) {
>>> +                dev_err(wcss->dev,
>>> +                    "can't load m3_fw.bXX ret:%d\n", ret);
>>> +                return ret;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    return qcom_mdt_load(wcss->dev, fw, rproc->firmware,
>>> +                desc->pasid, wcss->mem_region,
>>> +                wcss->mem_phys, wcss->mem_size,
>>> +                &wcss->mem_reloc);
>>> +}
>>> +
>>> +static int wcss_ahb_pcie_pd_load(struct rproc *rproc, const struct 
>>> firmware *fw)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv, *wcss_rpd;
>>> +    struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
>>> +    int ret;
>>> +    const struct wcss_data *desc =
>>> +                of_device_get_match_data(wcss->dev);
>>> +
>>> +    if (!desc)
>>> +        return -EINVAL;
>>> +
>>> +    wcss_rpd = rpd_rproc->priv;
>>> +
>>> +    /* Boot rootpd rproc */
>>> +    ret = rproc_boot(rpd_rproc);
>>> +    if (ret || wcss->state == WCSS_NORMAL)
>>> +        return ret;
>>> +
>>> +    return desc->mdt_load_sec(wcss->dev, fw, rproc->firmware,
>>> +                desc->pasid, wcss->mem_region,
>>> +                wcss->mem_phys, wcss->mem_size,
>>> +                &wcss->mem_reloc);
>>> +}
>>> +
>>> +static unsigned long q6_wcss_panic(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +
>>> +    return qcom_q6v5_panic(&wcss->q6);
>>> +}
>>> +
>>> +static const struct rproc_ops wcss_ahb_pcie_ipq5018_ops = {
>>> +    .start = wcss_ahb_pcie_pd_start,
>>> +    .stop = wcss_ahb_pcie_pd_stop,
>>> +    .load = wcss_ahb_pcie_pd_load,
>>> +};
>>> +
>>> +static const struct rproc_ops q6_wcss_ipq5018_ops = {
>>> +    .start = q6_wcss_start,
>>> +    .stop = q6_wcss_stop,
>>> +    .da_to_va = q6_wcss_da_to_va,
>>> +    .load = q6_wcss_load,
>>> +    .get_boot_addr = rproc_elf_get_boot_addr,
>>> +    .panic = q6_wcss_panic,
>>> +};
>>> +
>>> +static int q6_alloc_memory_region(struct q6_wcss *wcss)
>>> +{
>>> +    struct reserved_mem *rmem = NULL;
>>> +    struct device_node *node;
>>> +    struct device *dev = wcss->dev;
>>> +
>>> +    if (wcss->version == Q6_IPQ) {
>>> +        node = of_parse_phandle(dev->of_node, "memory-region", 0);
>>> +        if (node)
>>> +            rmem = of_reserved_mem_lookup(node);
>>> +
>>> +        of_node_put(node);
>>> +
>>> +        if (!rmem) {
>>> +            dev_err(dev, "unable to acquire memory-region\n");
>>> +            return -EINVAL;
>>> +        }
>>> +    } else {
>>> +        struct rproc *rpd_rproc = dev_get_drvdata(dev->parent);
>>> +        struct q6_wcss *rpd_wcss = rpd_rproc->priv;
>>> +
>>> +        wcss->mem_phys = rpd_wcss->mem_phys;
>>> +        wcss->mem_reloc = rpd_wcss->mem_reloc;
>>> +        wcss->mem_size = rpd_wcss->mem_size;
>>> +        wcss->mem_region = rpd_wcss->mem_region;
>>> +        return 0;
>>> +    }
>>> +
>>> +    wcss->mem_phys = rmem->base;
>>> +    wcss->mem_reloc = rmem->base;
>>> +    wcss->mem_size = rmem->size;
>>> +    wcss->mem_region = devm_ioremap_wc(dev, wcss->mem_phys, 
>>> wcss->mem_size);
>>> +    if (!wcss->mem_region) {
>>> +        dev_err(dev, "unable to map memory region: %pa+%pa\n",
>>> +            &rmem->base, &rmem->size);
>>> +        return -EBUSY;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int q6_get_inbound_irq(struct qcom_q6v5 *q6,
>>> +                  struct platform_device *pdev,
>>> +                  const char *int_name,
>>> +                  irqreturn_t (*handler)(int irq, void *data))
>>> +{
>>> +    int ret, irq;
>>> +    char *interrupt, *tmp = (char *)int_name;
>>> +    struct q6_wcss *wcss = q6->rproc->priv;
>>> +
>>> +    irq = platform_get_irq_byname(pdev, int_name);
>>> +    if (irq < 0) {
>>> +        if (irq != -EPROBE_DEFER)
>>> +            dev_err(&pdev->dev,
>>> +                "failed to retrieve %s IRQ: %d\n",
>>> +                    int_name, irq);
>>> +        return irq;
>>> +    }
>>> +
>>> +    if (!strcmp(int_name, "fatal")) {
>>> +        q6->fatal_irq = irq;
>>> +    } else if (!strcmp(int_name, "stop-ack")) {
>>> +        q6->stop_irq = irq;
>>> +        tmp = "stop_ack";
>>> +    } else if (!strcmp(int_name, "ready")) {
>>> +        q6->ready_irq = irq;
>>> +    } else if (!strcmp(int_name, "handover")) {
>>> +        q6->handover_irq  = irq;
>>> +    } else if (!strcmp(int_name, "spawn-ack")) {
>>> +        q6->spawn_irq = irq;
>>> +        tmp = "spawn_ack";
>>> +    } else {
>>> +        dev_err(&pdev->dev, "unknown interrupt\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    interrupt = devm_kzalloc(&pdev->dev, BUF_SIZE, GFP_KERNEL);
>>> +    if (!interrupt)
>>> +        return -ENOMEM;
>>> +
>>> +    snprintf(interrupt, BUF_SIZE, "q6v5_wcss_userpd%d", wcss->pd_asid);
>>> +    strlcat(interrupt, "_", BUF_SIZE);
>>> +    strlcat(interrupt, tmp, BUF_SIZE);
>>> +
>>
>> snprintf(interrupt, BUF_SIZE, "q6v5_wcss_userpd%d_%s", wcss->pd_asid, 
>> tmp);
>>
>>
> Sure, i will use it.
>>> +    ret = devm_request_threaded_irq(&pdev->dev, irq,
>>> +                    NULL, handler,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    interrupt, q6);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire %s irq\n", interrupt);
>>> +        return ret;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
>>> +                   struct platform_device *pdev,
>>> +                   const char *int_name)
>>> +{
>>> +    struct qcom_smem_state *tmp_state;
>>> +    unsigned  bit;
>>> +
>>> +    tmp_state = qcom_smem_state_get(&pdev->dev, int_name, &bit);
>>> +    if (IS_ERR(tmp_state)) {
>>> +        dev_err(&pdev->dev, "failed to acquire %s state\n", int_name);
>>> +        return PTR_ERR(tmp_state);
>>> +    }
>>> +
>>> +    if (!strcmp(int_name, "stop")) {
>>> +        q6->state = tmp_state;
>>> +        q6->stop_bit = bit;
>>> +    } else if (!strcmp(int_name, "spawn")) {
>>> +        q6->spawn_state = tmp_state;
>>> +        q6->spawn_bit = bit;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int init_irq(struct qcom_q6v5 *q6,
>>> +            struct platform_device *pdev, struct rproc *rproc,
>>> +            int remote_id, int crash_reason, const char *load_state,
>>> +            void (*handover)(struct qcom_q6v5 *q6))
>>> +{
>>> +    int ret;
>>> +
>>> +    q6->rproc = rproc;
>>> +    q6->dev = &pdev->dev;
>>> +    q6->crash_reason = crash_reason;
>>> +    q6->remote_id = remote_id;
>>> +    q6->handover = handover;
>>> +
>>> +    init_completion(&q6->start_done);
>>> +    init_completion(&q6->stop_done);
>>> +    init_completion(&q6->spawn_done);
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "fatal",
>>> +                 q6v5_fatal_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "ready",
>>> +                 q6v5_ready_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "stop-ack",
>>> +                 q6v5_stop_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "spawn-ack",
>>> +                 q6v5_spawn_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_outbound_irq(q6, pdev, "stop");
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_outbound_irq(q6, pdev, "spawn");
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int q6_wcss_probe(struct platform_device *pdev)
>>> +{
>>> +    const struct wcss_data *desc;
>>> +    struct q6_wcss *wcss;
>>> +    struct rproc *rproc;
>>> +    int ret;
>>> +    char *subdev_name;
>>> +
>>> +    desc = of_device_get_match_data(&pdev->dev);
>>> +    if (!desc)
>>> +        return -EINVAL;
>>> +
>>> +    rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
>>> +                desc->q6_firmware_name, sizeof(*wcss));
>>> +    if (!rproc) {
>>> +        dev_err(&pdev->dev, "failed to allocate rproc\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +    wcss = rproc->priv;
>>> +    wcss->dev = &pdev->dev;
>>> +    wcss->version = desc->version;
>>> +
>>> +    ret = q6_alloc_memory_region(wcss);
>>> +    if (ret)
>>> +        goto free_rproc;
>>> +
>>> +    wcss->pd_asid = qcom_get_pd_asid(wcss->dev->of_node);
>>> +    if (wcss->pd_asid < 0)
>>> +        goto free_rproc;
>>> +
>>> +    if (desc->init_irq) {
>>> +        ret = desc->init_irq(&wcss->q6, pdev, rproc, desc->remote_id,
>>> +                desc->crash_reason_smem, NULL, NULL);
>>> +        if (ret) {
>>> +            if (wcss->version == Q6_IPQ)
>>> +                goto free_rproc;
>>> +            else
>>> +                dev_info(wcss->dev,
>>> +                     "userpd irq registration failed\n");
>>> +        }
>>> +    }
>>> +
>>> +    if (desc->glink_subdev_required)
>>> +        qcom_add_glink_subdev(rproc, &wcss->glink_subdev, 
>>> desc->ssr_name);
>>> +
>>> +    subdev_name = (char *)(desc->ssr_name ? desc->ssr_name : 
>>> pdev->name);
>>> +    qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, subdev_name);
>>> +
>>> +    rproc->auto_boot = desc->need_auto_boot;
>>> +    ret = rproc_add(rproc);
>>> +    if (ret)
>>> +        goto free_rproc;
>>> +
>>> +    platform_set_drvdata(pdev, rproc);
>>> +
>>> +    ret = of_platform_populate(wcss->dev->of_node, NULL,
>>> +                   NULL, wcss->dev);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to populate wcss pd nodes\n");
>>> +        goto free_rproc;
>>> +    }
>>> +    return 0;
>>> +
>>> +free_rproc:
>>> +    rproc_free(rproc);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int q6_wcss_remove(struct platform_device *pdev)
>>> +{
>>> +    struct rproc *rproc = platform_get_drvdata(pdev);
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +
>>> +    if (wcss->version == Q6_IPQ)
>>> +        qcom_q6v5_deinit(&wcss->q6);
>>> +
>>> +    rproc_del(rproc);
>>> +    rproc_free(rproc);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct wcss_data q6_ipq5018_res_init = {
>>> +    .init_irq = qcom_q6v5_init,
>>> +    .q6_firmware_name = "IPQ5018/q6_fw.mdt",
>>> +    .crash_reason_smem = WCSS_CRASH_REASON,
>>> +    .remote_id = WCSS_SMEM_HOST,
>>> +    .ssr_name = "q6wcss",
>>> +    .ops = &q6_wcss_ipq5018_ops,
>>> +    .version = Q6_IPQ,
>>> +    .glink_subdev_required = true,
>>> +    .pasid = MPD_WCNSS_PAS_ID,
>>> +};
>>> +
>>> +static const struct wcss_data q6_ipq9574_res_init = {
>>> +    .init_irq = qcom_q6v5_init,
>>> +    .q6_firmware_name = "IPQ9574/q6_fw.mdt",
>>> +    .crash_reason_smem = WCSS_CRASH_REASON,
>>> +    .remote_id = WCSS_SMEM_HOST,
>>> +    .ssr_name = "q6wcss",
>>> +    .ops = &q6_wcss_ipq5018_ops,
>>> +    .version = Q6_IPQ,
>>> +    .glink_subdev_required = true,
>>> +    .pasid = WCNSS_PAS_ID,
>>> +};
>>> +
>>> +static const struct wcss_data wcss_ahb_ipq5018_res_init = {
>>> +    .init_irq = init_irq,
>>> +    .q6_firmware_name = "IPQ5018/q6_fw.mdt",
>>> +    .crash_reason_smem = WCSS_CRASH_REASON,
>>> +    .remote_id = WCSS_SMEM_HOST,
>>> +    .ops = &wcss_ahb_pcie_ipq5018_ops,
>>> +    .version = WCSS_AHB_IPQ,
>>> +    .pasid = MPD_WCNSS_PAS_ID,
>>> +    .reset_seq = true,
>>> +    .mdt_load_sec = qcom_mdt_load_pd_seg,
>>> +};
>>> +
>>> +static const struct wcss_data wcss_ahb_ipq9574_res_init = {
>>> +    .init_irq = init_irq,
>>> +    .q6_firmware_name = "IPQ9574/q6_fw.mdt",
>>> +    .crash_reason_smem = WCSS_CRASH_REASON,
>>> +    .remote_id = WCSS_SMEM_HOST,
>>> +    .ops = &wcss_ahb_pcie_ipq5018_ops,
>>> +    .version = WCSS_AHB_IPQ,
>>> +    .pasid = WCNSS_PAS_ID,
>>> +    .mdt_load_sec = qcom_mdt_load,
>>> +};
>>> +
>>> +static const struct wcss_data wcss_pcie_ipq5018_res_init = {
>>> +    .init_irq = init_irq,
>>> +    .q6_firmware_name = "IPQ5018/q6_fw.mdt",
>>> +    .crash_reason_smem = WCSS_CRASH_REASON,
>>> +    .ops = &wcss_ahb_pcie_ipq5018_ops,
>>> +    .version = WCSS_PCIE_IPQ,
>>> +    .mdt_load_sec = qcom_mdt_load_pd_seg,
>>> +    .pasid = MPD_WCNSS_PAS_ID,
>>> +};
>>> +
>>> +static const struct of_device_id q6_wcss_of_match[] = {
>>> +    { .compatible = "qcom,ipq5018-q6-mpd", .data = 
>>> &q6_ipq5018_res_init },
>>> +    { .compatible = "qcom,ipq9574-q6-mpd", .data = 
>>> &q6_ipq9574_res_init },
>>> +    { .compatible = "qcom,ipq5018-wcss-ahb-mpd",
>>> +        .data = &wcss_ahb_ipq5018_res_init },
>>> +    { .compatible = "qcom,ipq9574-wcss-ahb-mpd",
>>> +        .data = &wcss_ahb_ipq9574_res_init },
>>> +    { .compatible = "qcom,ipq5018-wcss-pcie-mpd",
>>> +        .data = &wcss_pcie_ipq5018_res_init },
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, q6_wcss_of_match);
>>> +
>>> +static struct platform_driver q6_wcss_driver = {
>>> +    .probe = q6_wcss_probe,
>>> +    .remove = q6_wcss_remove,
>>> +    .driver = {
>>> +        .name = "qcom-q6-mpd",
>>> +        .of_match_table = q6_wcss_of_match,
>>> +    },
>>> +};
>>> +module_platform_driver(q6_wcss_driver);
>>> +
>>> +MODULE_DESCRIPTION("Hexagon WCSS Multipd Peripheral Image Loader");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>>> b/drivers/remoteproc/qcom_q6v5_mss.c
>>> index ab053084f7a2..48685bb85718 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>>> @@ -28,6 +28,7 @@
>>>    #include <linux/soc/qcom/mdt_loader.h>
>>>    #include <linux/iopoll.h>
>>>    #include <linux/slab.h>
>>> +#include <linux/soc/qcom/smem.h>
>>>    #include "remoteproc_internal.h"
>>>    #include "qcom_common.h"
>>> @@ -2070,7 +2071,8 @@ static int q6v5_probe(struct platform_device 
>>> *pdev)
>>>        qproc->need_mem_protection = desc->need_mem_protection;
>>>        qproc->has_mba_logs = desc->has_mba_logs;
>>> -    ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, 
>>> MPSS_CRASH_REASON_SMEM, "modem",
>>> +    ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>>> +                 MPSS_CRASH_REASON_SMEM, "modem",
>>>                     qcom_msa_handover);
>>>        if (ret)
>>>            goto detach_proxy_pds;
>>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c 
>>> b/drivers/remoteproc/qcom_q6v5_pas.c
>>> index 0871108fb4dc..7408218042e5 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>>> @@ -723,7 +723,8 @@ static int adsp_probe(struct platform_device *pdev)
>>>            goto free_rproc;
>>>        adsp->proxy_pd_count = ret;
>>> -    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, 
>>> desc->crash_reason_smem, desc->load_state,
>>> +    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>>> +                 desc->crash_reason_smem, desc->load_state,
>>>                     qcom_pas_handover);
>>>        if (ret)
>>>            goto detach_proxy_pds;
>>> diff --git a/drivers/soc/qcom/mdt_loader.c 
>>> b/drivers/soc/qcom/mdt_loader.c
>>> index 33dd8c315eb7..a5ca5a078943 100644
>>> --- a/drivers/soc/qcom/mdt_loader.c
>>> +++ b/drivers/soc/qcom/mdt_loader.c
>>> @@ -16,6 +16,40 @@
>>>    #include <linux/sizes.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/soc/qcom/mdt_loader.h>
>>> +#include <linux/dma-mapping.h>
>>> +
>>> +#include "../../remoteproc/qcom_common.h"
>>> +#define PDSEG_PAS_ID    0xD
>>> +
>>> +/**
>>> + * struct region - structure passed to TrustZone
>>> + * @addr:    address of dma region, where dma blocks/chunks address 
>>> resides
>>> + * @blk_size:    size of each block
>>> + */
>>> +struct region {
>>> +    u64 addr;
>>> +    unsigned blk_size;
>>> +};
>>> +
>>> +/**
>>> + * struct pdseg_dma_mem_info
>>> + * @tz_addr:            reference to structure passed to trustzone
>>> + * @blocks:            no of blocks
>>> + * @tz_dma:            dma handle of tz_addr
>>> + * @dma_blk_arr_addr_phys:    dma handle of dma_blk_arr_addr
>>> + * @dma_blk_arr_addr:        VA of dma array, where each index 
>>> points to
>>> + *                dma block PA
>>> + * @pt:                stores VA of each block
>>> + */
>>> +
>>> +struct pdseg_dma_mem_info {
>>> +    struct region *tz_addr;
>>> +    int blocks;
>>> +    dma_addr_t tz_dma;
>>> +    dma_addr_t dma_blk_arr_addr_phys;
>>> +    u64 *dma_blk_arr_addr;
>>> +    void **pt;
>>> +};
>>>    static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>>>    {
>>> @@ -358,6 +392,259 @@ static int __qcom_mdt_load(struct device *dev, 
>>> const struct firmware *fw,
>>>        return ret;
>>>    }
>>> +static int allocate_dma_mem(struct device *dev,
>>> +                struct pdseg_dma_mem_info *pd_dma,
>>> +                int max_size)
>>> +{
>>> +    dma_addr_t dma_tmp = 0;
>>> +    int i;
>>> +
>>> +    pd_dma->blocks = DIV_ROUND_UP(max_size, PAGE_SIZE);
>>> +
>>> +    /* Allocate dma memory for structure passed to trust zone */
>>> +    pd_dma->tz_addr = dma_alloc_coherent(dev, sizeof(struct region),
>>> +                         &pd_dma->tz_dma, GFP_DMA);
>>> +    if (!pd_dma->tz_addr) {
>>> +        pr_err("Error in dma alloc\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    /* Allocate dma memory to store array of blocks PA */
>>> +    pd_dma->dma_blk_arr_addr =
>>> +            dma_alloc_coherent(dev, (pd_dma->blocks * sizeof(u64)),
>>> +                       &pd_dma->dma_blk_arr_addr_phys, GFP_DMA);
>>> +    if (!pd_dma->dma_blk_arr_addr) {
>>> +        pr_err("Error in dma alloc\n");
>>> +        goto free_tz_dma_alloc;
>>> +    }
>>> +
>>> +    /* Assign dma block array PA to trustzone structure addr 
>>> variable */
>>> +    memcpy(&pd_dma->tz_addr->addr, &pd_dma->dma_blk_arr_addr_phys,
>>> +           sizeof(dma_addr_t));
>>> +
>>> +    /* Allocate memory to store array of blocks VA */
>>> +    pd_dma->pt = kzalloc(pd_dma->blocks * sizeof(void *), GFP_KERNEL);
>>> +    if (!pd_dma->pt) {
>>> +        pr_err("Error in memory alloc\n");
>>> +        goto free_dma_blk_arr_alloc;
>>> +    }
>>> +
>>> +    for (i = 0; i < pd_dma->blocks; i++) {
>>> +        /* Allocate dma memory for blocks with PAGE_SIZE each */
>>> +        pd_dma->pt[i] = dma_alloc_coherent(dev, PAGE_SIZE,
>>> +                           &dma_tmp, GFP_DMA);
>>> +        if (!pd_dma->pt[i]) {
>>> +            pr_err("Error in dma alloc i:%d - blocks:%d\n", i,
>>> +                   pd_dma->blocks);
>>> +            goto free_mem_alloc;
>>> +        }
>>> +
>>> +        /* Assign dma block PA to dma_blk_arr_addr */
>>> +        memcpy(&pd_dma->dma_blk_arr_addr[i], &dma_tmp,
>>> +               sizeof(dma_addr_t));
>>> +    }
>>> +    pd_dma->tz_addr->blk_size = PAGE_SIZE;
>>> +    return 0;
>>> +
>>> +free_mem_alloc:
>>> +    i = 0;
>>> +    while (i < pd_dma->blocks && pd_dma->pt[i]) {
>>> +        memcpy(&dma_tmp, &pd_dma->dma_blk_arr_addr[i],
>>> +               sizeof(dma_addr_t));
>>> +        dma_free_coherent(dev, PAGE_SIZE, pd_dma->pt[i], dma_tmp);
>>> +        i++;
>>> +    }
>>> +    kfree(pd_dma->pt);
>>> +free_dma_blk_arr_alloc:
>>> +    dma_free_coherent(dev, (pd_dma->blocks * sizeof(u64)),
>>> +              pd_dma->dma_blk_arr_addr,
>>> +              pd_dma->dma_blk_arr_addr_phys);
>>> +free_tz_dma_alloc:
>>> +    dma_free_coherent(dev, sizeof(struct region), pd_dma->tz_addr,
>>> +              pd_dma->tz_dma);
>>> +
>>> +    return -ENOMEM;
>>> +}
>>> +
>>> +static void free_dma_mem(struct device *dev, struct 
>>> pdseg_dma_mem_info *pd_dma)
>>> +{
>>> +    int i;
>>> +    dma_addr_t dma_tmp = 0;
>>> +
>>> +    for (i = 0; i < pd_dma->blocks; i++) {
>>> +        memcpy(&dma_tmp, &pd_dma->dma_blk_arr_addr[i],
>>> +               sizeof(dma_addr_t));
>>> +        dma_free_coherent(dev, PAGE_SIZE, pd_dma->pt[i],
>>> +                  dma_tmp);
>>> +    }
>>> +
>>> +    dma_free_coherent(dev, (pd_dma->blocks * sizeof(u64)),
>>> +              pd_dma->dma_blk_arr_addr,
>>> +              pd_dma->dma_blk_arr_addr_phys);
>>> +
>>> +    dma_free_coherent(dev, sizeof(struct region), pd_dma->tz_addr,
>>> +              pd_dma->tz_dma);
>>> +    kfree(pd_dma->pt);
>>> +}
>>> +
>>> +static int memcpy_pdseg_to_dma_blk(const char *fw_name, struct 
>>> device *dev,
>>> +                   int ph_no, struct pdseg_dma_mem_info *pd_dma)
>>> +{
>>> +    const struct firmware *seg_fw;
>>> +    int ret, offset_tmp = 0, tmp = 0;
>>> +    size_t size = 0;
>>> +
>>> +    ret = request_firmware(&seg_fw, fw_name, dev);
>>> +    if (ret) {
>>> +        dev_err(dev, "failed to load %s\n", fw_name);
>>> +        return ret;
>>> +    }
>>> +    size = seg_fw->size < PAGE_SIZE ?
>>> +        seg_fw->size : PAGE_SIZE;
>>> +    while (tmp < pd_dma->blocks && size) {
>>> +        memset_io(pd_dma->pt[tmp], 0, PAGE_SIZE);
>>> +        memcpy_toio(pd_dma->pt[tmp], seg_fw->data + offset_tmp, size);
>>
>> Is the memset to zero needed if it is going to be overwritten with 
>> memcpy?
>> Can't the remaining area of the last page alone be memset?
>>
>> -Varada
>>
> Sure, i will do it.
> 
> Thanks & Regards,
> Manikanta.
>>> +        tmp++;
>>> +        offset_tmp += size;
>>> +        if ((seg_fw->size - offset_tmp) < PAGE_SIZE)
>>> +            size = seg_fw->size - offset_tmp;
>>> +    }
>>> +    release_firmware(seg_fw);
>>> +    ret = qti_scm_pdseg_memcpy_v2(PDSEG_PAS_ID, ph_no, pd_dma->tz_dma,
>>> +                      tmp);
>>> +    if (ret) {
>>> +        dev_err(dev, "pd seg memcpy scm failed\n");
>>> +        return ret;
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +static int __qcom_mdt_load_pd_seg(struct device *dev, const struct 
>>> firmware *fw,
>>> +                  const char *fw_name, int pas_id, void *mem_region,
>>> +                  phys_addr_t mem_phys, size_t mem_size,
>>> +                  phys_addr_t *reloc_base, bool pas_init)
>>> +{
>>> +    const struct elf32_phdr *phdrs;
>>> +    const struct elf32_phdr *phdr;
>>> +    const struct elf32_hdr *ehdr;
>>> +    phys_addr_t mem_reloc;
>>> +    phys_addr_t min_addr = PHYS_ADDR_MAX;
>>> +    ssize_t offset;
>>> +    bool relocate = false;
>>> +    int ret = 0;
>>> +    int i;
>>> +    u8 pd_asid;
>>> +    int max_size = 0;
>>> +    struct pdseg_dma_mem_info pd_dma = {0};
>>> +    char *firmware_name;
>>> +    size_t fw_name_len = strlen(fw_name);
>>> +
>>> +    if (!fw || !mem_region || !mem_phys || !mem_size)
>>> +        return -EINVAL;
>>> +
>>> +    firmware_name = kstrdup(fw_name, GFP_KERNEL);
>>> +    if (!firmware_name)
>>> +        return -ENOMEM;
>>> +
>>> +    pd_asid = qcom_get_pd_asid(dev->of_node);
>>> +
>>> +    ehdr = (struct elf32_hdr *)fw->data;
>>> +    phdrs = (struct elf32_phdr *)(ehdr + 1);
>>> +
>>> +    for (i = 0; i < ehdr->e_phnum; i++) {
>>> +        phdr = &phdrs[i];
>>> +
>>> +        if (!mdt_phdr_valid(phdr))
>>> +            continue;
>>> +        /*
>>> +         * While doing PD specific reloading, load only that PD
>>> +         * specific writeable entries. Skip others
>>> +         */
>>> +        if ((QCOM_MDT_PF_ASID(phdr->p_flags) != pd_asid) ||
>>> +            ((phdr->p_flags & PF_W) == 0))
>>> +            continue;
>>> +
>>> +        if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
>>> +            relocate = true;
>>> +
>>> +        if (phdr->p_paddr < min_addr)
>>> +            min_addr = phdr->p_paddr;
>>> +
>>> +        if (max_size < phdr->p_memsz)
>>> +            max_size = phdr->p_memsz;
>>> +    }
>>> +
>>> +    /**
>>> +     * During userpd PIL segments reloading, Q6 is live. Due to
>>> +     * this we can't access memory region of PIL segments. So
>>> +     * create DMA chunks/blocks to store PIL segments data.
>>> +     */
>>> +    ret = allocate_dma_mem(dev, &pd_dma, max_size);
>>> +    if (ret)
>>> +        goto out;
>>> +
>>> +    if (relocate) {
>>> +        /*
>>> +         * The image is relocatable, so offset each segment based on
>>> +         * the lowest segment address.
>>> +         */
>>> +        mem_reloc = min_addr;
>>> +    } else {
>>> +        /*
>>> +         * Image is not relocatable, so offset each segment based on
>>> +         * the allocated physical chunk of memory.
>>> +         */
>>> +        mem_reloc = mem_phys;
>>> +    }
>>> +
>>> +    for (i = 0; i < ehdr->e_phnum; i++) {
>>> +        phdr = &phdrs[i];
>>> +
>>> +        if (!mdt_phdr_valid(phdr))
>>> +            continue;
>>> +
>>> +        /*
>>> +         * While doing PD specific reloading, load only that PD
>>> +         * specific writeable entries. Skip others
>>> +         */
>>> +        if ((QCOM_MDT_PF_ASID(phdr->p_flags) != pd_asid) ||
>>> +            ((phdr->p_flags & PF_W) == 0))
>>> +            continue;
>>> +
>>> +        offset = phdr->p_paddr - mem_reloc;
>>> +        if (offset < 0 || offset + phdr->p_memsz > mem_size) {
>>> +            dev_err(dev, "segment outside memory range\n");
>>> +            ret = -EINVAL;
>>> +            break;
>>> +        }
>>> +
>>> +        if (phdr->p_filesz > phdr->p_memsz) {
>>> +            dev_err(dev,
>>> +                "refusing to load segment %d with p_filesz > 
>>> p_memsz\n",
>>> +                i);
>>> +            ret = -EINVAL;
>>> +            break;
>>> +        }
>>> +
>>> +        if (phdr->p_filesz) {
>>> +            snprintf(firmware_name + fw_name_len - 3, 4, "b%02d", i);
>>> +
>>> +            /* copy PIL segments data to dma blocks */
>>> +            ret = memcpy_pdseg_to_dma_blk(firmware_name, dev, i, 
>>> &pd_dma);
>>> +            if (ret)
>>> +                goto free_dma;
>>> +        }
>>> +    }
>>> +free_dma:
>>> +    free_dma_mem(dev, &pd_dma);
>>> +
>>> +out:
>>> +    if (reloc_base)
>>> +        *reloc_base = mem_reloc;
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>    /**
>>>     * qcom_mdt_load() - load the firmware which header is loaded as fw
>>>     * @dev:    device handle to associate resources with
>>> @@ -410,5 +697,32 @@ int qcom_mdt_load_no_init(struct device *dev, 
>>> const struct firmware *fw,
>>>    }
>>>    EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
>>> +/**
>>> + * qcom_mdt_load_pd_seg() - load userpd specific PIL segements
>>> + * @dev:    device handle to associate resources with
>>> + * @fw:        firmware object for the mdt file
>>> + * @firmware:    name of the firmware, for construction of segment 
>>> file names
>>> + * @pas_id:    PAS identifier
>>> + * @mem_region:    allocated memory region to load firmware into
>>> + * @mem_phys:    physical address of allocated memory region
>>> + * @mem_size:    size of the allocated memory region
>>> + * @reloc_base:    adjusted physical address after relocation
>>> + *
>>> + * Here userpd PIL segements are stitched with rootpd firmware.
>>> + * This function reloads userpd specific PIL segments during SSR
>>> + * of userpd.
>>> + *
>>> + * Returns 0 on success, negative errno otherwise.
>>> + */
>>> +int qcom_mdt_load_pd_seg(struct device *dev, const struct firmware *fw,
>>> +             const char *firmware, int pas_id, void *mem_region,
>>> +             phys_addr_t mem_phys, size_t mem_size,
>>> +             phys_addr_t *reloc_base)
>>> +{
>>> +    return __qcom_mdt_load_pd_seg(dev, fw, firmware, pas_id, 
>>> mem_region, mem_phys,
>>> +                      mem_size, reloc_base, true);
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_mdt_load_pd_seg);
>>> +
>>>    MODULE_DESCRIPTION("Firmware parser for Qualcomm MDT format");
>>>    MODULE_LICENSE("GPL v2");
>>> diff --git a/include/linux/firmware/qcom/qcom_scm.h 
>>> b/include/linux/firmware/qcom/qcom_scm.h
>>> index 1e449a5d7f5c..0bdb9b506ad1 100644
>>> --- a/include/linux/firmware/qcom/qcom_scm.h
>>> +++ b/include/linux/firmware/qcom/qcom_scm.h
>>> @@ -81,6 +81,9 @@ extern int qcom_scm_pas_mem_setup(u32 peripheral, 
>>> phys_addr_t addr,
>>>    extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
>>>    extern int qcom_scm_pas_shutdown(u32 peripheral);
>>>    extern bool qcom_scm_pas_supported(u32 peripheral);
>>> +int qti_scm_int_radio_powerup(u32 peripheral);
>>> +int qti_scm_int_radio_powerdown(u32 peripheral);
>>> +int qti_scm_pdseg_memcpy_v2(u32 peripheral, int phno, dma_addr_t 
>>> dma, int seg_cnt);
>>>    extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>>>    extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>>> diff --git a/include/linux/soc/qcom/mdt_loader.h 
>>> b/include/linux/soc/qcom/mdt_loader.h
>>> index 9e8e60421192..57021236dfc9 100644
>>> --- a/include/linux/soc/qcom/mdt_loader.h
>>> +++ b/include/linux/soc/qcom/mdt_loader.h
>>> @@ -7,6 +7,11 @@
>>>    #define QCOM_MDT_TYPE_MASK    (7 << 24)
>>>    #define QCOM_MDT_TYPE_HASH    (2 << 24)
>>>    #define QCOM_MDT_RELOCATABLE    BIT(27)
>>> +#define QCOM_MDT_ASID_MASK      0xfu
>>> +#define QCOM_MDT_PF_ASID_SHIFT  16
>>> +#define QCOM_MDT_PF_ASID_MASK   (QCOM_MDT_ASID_MASK << 
>>> QCOM_MDT_PF_ASID_SHIFT)
>>> +#define QCOM_MDT_PF_ASID(x)     \
>>> +            (((x) >> QCOM_MDT_PF_ASID_SHIFT) & QCOM_MDT_ASID_MASK)
>>>    struct device;
>>>    struct firmware;
>>> @@ -27,6 +32,10 @@ int qcom_mdt_load_no_init(struct device *dev, 
>>> const struct firmware *fw,
>>>                  const char *fw_name, int pas_id, void *mem_region,
>>>                  phys_addr_t mem_phys, size_t mem_size,
>>>                  phys_addr_t *reloc_base);
>>> +int qcom_mdt_load_pd_seg(struct device *dev, const struct firmware *fw,
>>> +             const char *firmware, int pas_id, void *mem_region,
>>> +             phys_addr_t mem_phys, size_t mem_size,
>>> +             phys_addr_t *reloc_base);
>>>    void *qcom_mdt_read_metadata(const struct firmware *fw, size_t 
>>> *data_len,
>>>                     const char *fw_name, struct device *dev);
>>> @@ -62,6 +71,16 @@ static inline int qcom_mdt_load_no_init(struct 
>>> device *dev,
>>>        return -ENODEV;
>>>    }
>>> +static inline int qcom_mdt_load_pd_seg(struct device *dev,
>>> +                       const struct firmware *fw,
>>> +                       const char *fw_name, int pas_id,
>>> +                       void *mem_region, phys_addr_t mem_phys,
>>> +                       size_t mem_size,
>>> +                       phys_addr_t *reloc_base)
>>> +{
>>> +    return -ENODEV;
>>> +}
>>> +
>>>    static inline void *qcom_mdt_read_metadata(const struct firmware *fw,
>>>                           size_t *data_len, const char *fw_name,
>>>                           struct device *dev)
>>
>> ----- End forwarded message -----
