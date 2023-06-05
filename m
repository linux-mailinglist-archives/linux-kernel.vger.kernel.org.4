Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5807221C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFEJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFEJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:12:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24828BD;
        Mon,  5 Jun 2023 02:12:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3556s3Yu012562;
        Mon, 5 Jun 2023 09:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w2e5SiDmS0rDwr/6LK5nJ7itsFZbJ4fL9jvR5MHo6OI=;
 b=hbRkpk7/ZcveVEqyDGIN/Ir7BSI5G7+2zFu6s0VRHOOryJtGjWd7dLD9KjRvkSRYDLy/
 eW2IT0HWnEVNwR4ZxKSdbOIEAtmfH9iwoYyEwrCh7iq/RhWd2AegCDJVhvK+xcECtLeo
 JPLPxKSToSYSaGeTpaIfxPQBY+wNRnoSLYfUVCe6aRvUzQoJ3VlzGJmlD5FDVIkfGxWT
 s60Ve9xygKn0yhdK7Sw7O6Th8JH03Z5Y688sdFKQkKkNomBgNKOIeNjL4nbB//p0CsSe
 8BaNC37b7A+sliLFbz/cOJdhz4z0GukScHTiDnZmI5xFYYrsbdSsunBs0CBA4DZvjv/y KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1auggfv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 09:12:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3559CBPu005415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 09:12:11 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 02:12:06 -0700
Message-ID: <cc22f94e-eb51-89b4-d2a6-f56fff369ddd@quicinc.com>
Date:   Mon, 5 Jun 2023 17:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 07/11] coresight-tpdm: Add nodes for dsb edge control
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-8-git-send-email-quic_taozha@quicinc.com>
 <606b8a25-0468-c310-ccff-1477e2b238b2@arm.com>
 <c5c28ab8-7d6a-f8e7-ad34-8716ac77d2dc@quicinc.com>
 <a2bd3bbf-5512-971a-95a1-3220f31814a2@arm.com>
 <e82d7387-a299-20e5-3176-dce20966a10b@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <e82d7387-a299-20e5-3176-dce20966a10b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0NVnTUp8seVfUupZLoPqRFjuRFfLFqs1
X-Proofpoint-ORIG-GUID: 0NVnTUp8seVfUupZLoPqRFjuRFfLFqs1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306050082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2023 5:00 PM, Suzuki K Poulose wrote:
> On 02/06/2023 09:45, Suzuki K Poulose wrote:
>> On 02/06/2023 09:21, Tao Zhang wrote:
>>>
>>> On 6/1/2023 8:14 PM, Suzuki K Poulose wrote:
>>>> On 27/04/2023 10:00, Tao Zhang wrote:
>>>>> Add the nodes to set value for DSB edge control and DSB edge
>>>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>>>> resgisters to configure edge control. DSB edge detection control
>>>>> 00: Rising edge detection
>>>>> 01: Falling edge detection
>>>>> 10: Rising and falling edge detection (toggle detection)
>>>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>>>>> configure mask. Eight 32 bit registers providing DSB interface
>>>>> edge detection mask control.
>>>>>
>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>> ---
>>>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
>>>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 135 
>>>>> ++++++++++++++++++++-
>>>>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  21 ++++
>>>>>   3 files changed, 187 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>> index 348e167..a57f000 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>> @@ -60,3 +60,35 @@ Description:
>>>>>           Bit[3] : Set to 0 for low performance mode.
>>>>>                    Set to 1 for high performance mode.
>>>>>           Bit[4:8] : Select byte lane for high performance mode.
>>>>> +
>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
>>>>> +Date:        March 2023
>>>>> +KernelVersion    6.3
>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>> +Description:
>>>>> +        Read/Write a set of the edge control registers of the DSB
>>>>> +        in TPDM.
>>>>> +
>>>>> +        Expected format is the following:
>>>>> +        <integer1> <integer2> <integer3>
>>>>> +
>>>>> +        Where:
>>>>> +        <integer1> : Start EDCR register number
>>>>> +        <integer2> : End EDCR register number
>>>>> +        <integer3> : The value need to be written
>>>>> +
>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
>>>>> +Date:        March 2023
>>>>> +KernelVersion    6.3
>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>> +Description:
>>>>> +        Read/Write a set of the edge control mask registers of the
>>>>> +        DSB in TPDM.
>>>>> +
>>>>> +        Expected format is the following:
>>>>> +        <integer1> <integer2> <integer3>
>>>>> +
>>>>> +        Where:
>>>>> +        <integer1> : Start EDCMR register number
>>>>> +        <integer2> : End EDCMR register number
>>>>> +        <integer3> : The value need to be written
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>> index 1bacaa5..a40e458 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>> @@ -80,7 +80,14 @@ static void set_trigger_type(struct 
>>>>> tpdm_drvdata *drvdata, u32 *val)
>>>>>     static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>>>>   {
>>>>> -    u32 val;
>>>>> +    u32 val, i;
>>>>> +
>>>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
>>>>> +        writel_relaxed(drvdata->dsb->edge_ctrl[i],
>>>>> +               drvdata->base + TPDM_DSB_EDCR(i));
>>>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>>>>> + writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>>>>> +               drvdata->base + TPDM_DSB_EDCMR(i));
>>>>
>>>> Do all TPDM DSBs have MAX_EDCR registers ? Or some have less than 
>>>> that ?
>>>> If it is latter, do we need special care to avoid writing to 
>>>> inexistent
>>>> registers ?
>>>>
>>> You are right, not all DSB TPDMs have MAX_EDCR registers. In our 
>>> design, the inexistent register addresses
>>>
>>> are not occupied and safe for accessing.
>
> Does the TRM for the component say so ? Or is it by luck ? If the spec
> says it is RAZ/WriteIgnore, then we could keep the code as it is,
> with a comment. Otherwise, we could add a DT property. So please get
> this clarified with the H/W designers.

Confirmed with H/W designers, these addresses are reserved for the maximum

quantity of EDCR/EDCMR registers. It is safe to write data to them and 
it will not

impact anything.


Best,

Tao

>
> Suzuki
