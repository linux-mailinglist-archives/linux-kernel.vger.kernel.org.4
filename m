Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3975016A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGLI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjGLI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:26:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7C4C24;
        Wed, 12 Jul 2023 01:21:20 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C4jWe4023871;
        Wed, 12 Jul 2023 08:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0Wz+o7GnxSWoI8DF4hbm6y4vu4Hx/KUIMK1XvFYHduY=;
 b=KeGp44eCcQXa+YULECNMj4tagR3gkLu3loX2WzOVlMC/cMIMwxkKtMUsTGHjWXcsX0cq
 L+7JDYzV+Yc/BnFwrNabGM71mhp7wDBu8pG3QGJPgoAHclR+TADnpgpjbKM8opWELIm+
 VTBLq7aCpG2vIwjCoTkz7Y88MiiKk6veZr9QnNW0hFQe5+AqYQvUmjBRkrubT5PihueQ
 ozjygU7IMz+SuxWwKwzOEYe+gG9aJd+l6w4uMQE7vxvGGu+/xFp1ygcZn0A4L1GFxSBT
 11WV/uCyTF8gEUxNj8JZ4PfJcYNL1AHZZGn5cPsoTHm4jOZ0Ow4mm5LsK68WfniahlAh Yw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsfeq0x3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:20:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C8KWV0010149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:20:32 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 01:20:29 -0700
Message-ID: <5d648cbe-de43-39a8-760e-1c9b9b2ec064@quicinc.com>
Date:   Wed, 12 Jul 2023 13:50:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <2040226e-9b45-b409-3edd-a5b86d86daa8@linaro.org>
 <8a3124ce-a11d-2491-eaee-1695cec70b17@quicinc.com>
 <e885383b-a231-75a1-32ce-bf850f0cb022@linaro.org>
 <8c3468f0-3069-95e3-e2f1-279fca78a578@linaro.org>
 <4330df82-77a9-27ce-3f24-144718cc082e@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <4330df82-77a9-27ce-3f24-144718cc082e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VUY1Nr5idbUqx2Sf1FxEDGMVBPb8hU5m
X-Proofpoint-GUID: VUY1Nr5idbUqx2Sf1FxEDGMVBPb8hU5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=902 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120073
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 8:29 PM, Dmitry Baryshkov wrote:
> On 11/07/2023 14:44, Konrad Dybcio wrote:
>> On 11.07.2023 08:22, Krzysztof Kozlowski wrote:
>>> On 11/07/2023 08:17, Rohit Agarwal wrote:
>>>>
>>>> On 7/11/2023 11:22 AM, Krzysztof Kozlowski wrote:
>>>>> On 11/07/2023 07:42, Rohit Agarwal wrote:
>>>>>> Add Generic RPMh Power Domain indexes that can be used
>>>>>> for all the Qualcomm SoC henceforth.
>>>>>>
>>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>>    include/dt-bindings/power/qcom-rpmhpd.h | 30 
>>>>>> ++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 30 insertions(+)
>>>>>>    create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>>>>>
>>>>>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h 
>>>>>> b/include/dt-bindings/power/qcom-rpmhpd.h
>>>>>> new file mode 100644
>>>>>> index 0000000..4da2e04
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>>>>> Filename based on compatible.
>>>> This is not specific for SDX75. These are generic ones that should be
>>>> used for all other targets.
>>>> Konrad suggested in v1 to avoid target specific prefixes everytime and
>>>> to create a new generic
>>>> dt-bindings that can be reused.
>>>>>> @@ -0,0 +1,30 @@
>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>> +/*
>>>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All 
>>>>>> rights reserved.
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>>>>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>>>>>> +
>>>>>> +/* Generic RPMH Power Domain Indexes */
>>>>>> +#define CX               0
>>>>> These are very generic names, usually not used in global headers. 
>>>>> Please
>>>>> use some reasonable prefix.
>>>> This was based on the suggestion from Konrad in v2 to drop the RPMHPD
>>>> prefix and we can go only with names like CX, etc.
>>>
>>> I don't think having so generic name in tree-wide header is good idea.
>> Conversely, I think that it would be very clear in files including 
>> this header.
>
> It is expected to be included into dtsi and into rpmhpd driver (only). 
> However I'd also suggest adding some generic prefix (e.g. RPMHPD_CX). 
> Just `CX' is too short and has a sensible possibility of getting  a 
> symbol conflict.
>
Ok, Will add them back as in v2.

Thanks,
Rohit.
>>
>> Konrad
>>> CX can mean anything.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>
