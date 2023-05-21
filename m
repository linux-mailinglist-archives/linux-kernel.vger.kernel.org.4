Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2270B15C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjEUWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUWHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:07:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8FDC;
        Sun, 21 May 2023 15:07:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LM08BE003381;
        Sun, 21 May 2023 22:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+63/G/Tv/MrcI5FFFsDFDEW053aArl4gLPbcVipYQ/I=;
 b=ZjssRMTFpesSGNTyncoKjKunNIuZOaWsNoYAPnF0i5Kvf17qPPlbbX5ra5xYz5HIttGZ
 7J5lrWFWsgIvqzsMFly2EZj1Pt+Nqy8fdTe9IGfomX1jtBGgnDZh1Lp+uBgsHvLi2mwQ
 3GzCkOXmDnwi1FCVa0nbxG4JnTBdrfpvAU82WOQjvz6WVZ17bd24ax0mdu9bZT4UWVRV
 Yzc6964KvVAGApYq7UIXYLvve590DjKszl32dCh/NTMqSB1huJeL+g3rnKQ382GkpwS5
 P/su2SIcL29aXSV9fe0NGvqKztsUgqjhhE1CNDl0YUfVZ/s55OHE61W7FBjlBHDTnViO +w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppa1a98t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:07:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LM7NgP023683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:07:23 GMT
Received: from [10.216.45.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 15:07:16 -0700
Message-ID: <24826ca7-a9fa-9602-39ba-870021150c8d@quicinc.com>
Date:   Mon, 22 May 2023 03:37:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
 <366ed962-dedb-0e88-036d-a1a806d0b589@quicinc.com>
 <f63c86fd-4c39-7523-1971-6d8df91afcf4@quicinc.com>
 <CAA8EJpoH51ajGvSdb1VBmtkKdLUnVGNhoBay93whz+hJh4ApXA@mail.gmail.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <CAA8EJpoH51ajGvSdb1VBmtkKdLUnVGNhoBay93whz+hJh4ApXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H7Ecfu0LluM_zm-IRWNWOOtdyxEJw1xS
X-Proofpoint-ORIG-GUID: H7Ecfu0LluM_zm-IRWNWOOtdyxEJw1xS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=943 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305210199
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2023 11:40 PM, Dmitry Baryshkov wrote:
> On Sun, 21 May 2023 at 18:48, Manikanta Mylavarapu
> <quic_mmanikan@quicinc.com> wrote:
>>
>>
>>
>> On 3/7/2023 6:47 PM, Sricharan Ramabadhran wrote:
>>>
>>>
>>> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>>>> APSS brings Q6 out of reset and then Q6 brings
>>>> WCSS block (wifi radio's) out of reset.
>>>>
>>>>                     ---------------
>>>>                    -->  |WiFi 2G radio|
>>>>                    |       --------------
>>>>                    |
>>>> --------    -------          |
>>>> | APSS | --->   |QDSP6|  -----|
>>>> ---------    -------       |
>>>>                                 |
>>>>                           |
>>>>                    |   --------------
>>>>                    --> |WiFi 5G radio|
>>>>                    --------------
>>>>
>>>> Problem here is if any radio crashes, subsequently other
>>>> radio also should crash because Q6 crashed. Let's say
>>>> 2G radio crashed, Q6 should pass this info to APSS. Only
>>>> Q6 processor interrupts registered with APSS. Obviously
>>>> Q6 should crash and raise fatal interrupt to APSS. Due
>>>> to this 5G radio also crashed. But no issue in 5G radio,
>>>> because of 2G radio crash 5G radio also impacted.
>>>>
>>>> In multi pd model, this problem is resolved. Here WCSS
>>>> functionality (WiFi radio's) moved out from Q6 root pd
>>>> to a separate user pd. Due to this, radio's independently
>>>> pass their status info to APPS with out crashing Q6. So
>>>> other radio's won't be impacted.
>>>>
>>>>                          ---------
>>>>                              |WiFi    |
>>>>                          --> |2G radio|
>>>>                          |     ---------
>>>> ------    Start Q6             -------     |
>>>> |    |    ------------------>     |     |     |
>>>> |    |  Start WCSS PD1 (2G)       |     |        |
>>>> |APSS|    ----------------------->|QDSP6|-----|
>>>> |    |    Start WCSS PD1 (5G)    |     |
>>>> |    |    ----------------------->|     |-----|
>>>> ------                     -------     |
>>>>                          |
>>>>                          |    -----------
>>>>                          |-->|WiFi      |
>>>>                          |5G radio |
>>>>                          -----------
>>>> According to linux terminology, here consider Q6 as root
>>>> i.e it provide all services, WCSS (wifi radio's) as user
>>>> i.e it uses services provided by root.
>>>>
>>>> Since Q6 root & WCSS user pd's able to communicate with
>>>> APSS individually, multipd remoteproc driver registers
>>>> each PD with rproc framework. Here clients (Wifi host drivers)
>>>> intrested on WCSS PD rproc, so multipd driver start's root
>>>> pd in the context of WCSS user pd rproc start. Similarly
>>>> on down path, root pd will be stopped after wcss user pd
>>>> stopped.
>>>>
>>>> Here WCSS(user) PD is dependent on Q6(root) PD, so first
>>>> q6 pd should be up before wcss pd. After wcss pd goes down,
>>>> q6 pd should be turned off.
>>>>
>>>> rproc->ops->start(userpd_rproc) {
>>>>      /* Boot root pd rproc */
>>>>      rproc_boot(upd_dev->parent);
>>>>      ---
>>>>      /* user pd rproc start sequence */
>>>>      ---
>>>>      ---
>>>> }
>>>> With this way we ensure that root pd brought up before userpd.
>>>>
>>>> rproc->ops->stop(userpd_rproc) {
>>>>      ---
>>>>      ---
>>>>      /* user pd rproc stop sequence */
>>>>      ---
>>>>      ---
>>>>      /* Shutdown root pd rproc */
>>>>      rproc_shutdown(upd_dev->parent);
>>>> }
>>>> After userpd rproc stops, root pd rproc will be stopped.
>>>> IPQ5018, IPQ9574 supports multipd remoteproc driver.
>>>>
>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>> ---
>>>>    drivers/firmware/qcom_scm.c            | 114 +++++
>>>>    drivers/firmware/qcom_scm.h            |   6 +
>>>>    drivers/remoteproc/Kconfig             |  20 +
>>>>    drivers/remoteproc/Makefile            |   1 +
>>>>    drivers/remoteproc/qcom_common.c       |  23 +
>>>>    drivers/remoteproc/qcom_common.h       |   1 +
>>>>    drivers/remoteproc/qcom_q6v5.c         |  41 +-
>>>>    drivers/remoteproc/qcom_q6v5.h         |  15 +-
>>>>    drivers/remoteproc/qcom_q6v5_adsp.c    |   5 +-
>>>>    drivers/remoteproc/qcom_q6v5_mpd.c     | 668 +++++++++++++++++++++++++
>>>>    drivers/remoteproc/qcom_q6v5_mss.c     |   4 +-
>>>>    drivers/remoteproc/qcom_q6v5_pas.c     |   3 +-
>>>>    drivers/soc/qcom/mdt_loader.c          | 314 ++++++++++++
>>>>    include/linux/firmware/qcom/qcom_scm.h |   3 +
>>>>    include/linux/soc/qcom/mdt_loader.h    |  19 +
>>>>    15 files changed, 1228 insertions(+), 9 deletions(-)
>>>>    create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
>>>>
>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>> index d88c5f14bd54..d69560963353 100644
>>>> --- a/drivers/firmware/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom_scm.c
>>>> @@ -654,6 +654,120 @@ int qcom_scm_pas_shutdown(u32 peripheral)
>>>>    }
>>>>    EXPORT_SYMBOL(qcom_scm_pas_shutdown);
>>>> +/**
>>>> + * qti_scm_int_radio_powerup - Bring up internal radio userpd
>>>> + *
>>>> + * @peripheral:    peripheral id
>>>> + *
>>>> + * Return 0 on success.
>>>> + */
>>>> +int qti_scm_int_radio_powerup(u32 peripheral)
>>>> +{
>>>
>>> qcom instead and in other places too.
>>>
>> Internal open source team suggested to use qti.
> 
> All existing drivers use qcom_ prefix. Other functions in qcom_scm.c
> use qcom_ prefix. Please stick to it.
> 

I will discuss with internal team and update in V3 series.

Thanks & Regards,
Manikanta.
