Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056EB747FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGEIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGEIef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:34:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E71F3;
        Wed,  5 Jul 2023 01:34:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3657kl4r004902;
        Wed, 5 Jul 2023 08:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=47xGRx8X89NPv+AJ+kRPJuy8G/+b0hfke+iKGy566Ok=;
 b=YTvD4a88CccbuFGCn0ZTovRkkLlj6OHa5npKlnSrRICPQWWzUAobYNU0/aY2cfI7vxZb
 +lHTM9j9+k22CTM3XRKW2duE7xa8uSj/U5Ij52CaCmMwY+LIKODsl4Ne1DTR8aAj2Ul2
 rW5RmHTUSRccIqkW5SqLwxCAhORoLfXw5KzpXR40S+KSYpgxFlPb6aqnwe0z0QObAvUA
 kuGs2WkNxB8jpKjEubAsx27Fn3NOI+E/M8L3VadbyUSmoBfMn4HpKvNT4wO+4qX8YJB5
 21KsB87+aOTrQU+ThaMrgjbYwijyXeJe25AIQBsrAK3vheN2tnZcqy0v8NBI0ms6l6XT Gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmfqjjjj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 08:34:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3658YLES026583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 08:34:21 GMT
Received: from [10.50.20.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 01:34:14 -0700
Message-ID: <968fb5d3-6cd8-7850-47e7-682e26f9ee5f@quicinc.com>
Date:   Wed, 5 Jul 2023 14:03:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
 <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y2gyi1B5kMqnpwkpR9XBzlmm-VP4UgI7
X-Proofpoint-ORIG-GUID: y2gyi1B5kMqnpwkpR9XBzlmm-VP4UgI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 mlxlogscore=927 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050077
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2023 11:47 AM, Krzysztof Kozlowski wrote:
> On 05/07/2023 07:32, Souradeep Chowdhury wrote:
>> Add the device tree bindings for boot stats. This has 2 properties
>> pre-abl-time and abl-time which records the timestamps for boot
>> stats.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Link: https://lore.kernel.org/linux-arm-kernel/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/
>> ---
>>   .../bindings/firmware/qcom,bootstats.yaml     | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml b/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
>> new file mode 100644
>> index 000000000000..22e697524058
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/firmware/qcom,bootstats.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Boot Stats
> 
> This explains nothing...

Ack

> 
>> +
>> +maintainers:
>> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +
>> +description: |
> 
> Drop |

Ack

> 
>> +    Qualcomm's proprietary Android boot-loaders capture boot time
> 
> Wrong indentation.

Ack
> 
>> +    stats, like the time when the bootloader started execution and
>> +    at what point the bootloader handed over control to the kernel.
>> +    This is captured in the unit of ms in devicetree property.
>> +
>> +properties:
>> +  pre-abl-time:
>> +    description: The property to store the starting point of abl in ms.
> 
> String instead of ms? No, this is the craziest idea I saw recently. Use
> -ms suffix.
> 
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +
>> +  abl-time:
>> +    description: The property to store the duration of abl in ms.
>> +    $ref: /schemas/types.yaml#/definitions/string-array
> 
> I have no clue what this entire binding is about. Nothing can bind to
> it, no usage explained. Properties are not used to "store the duration".
> This does not look like suitable for DT, drop entire binding.

This binding was created as per the suggestion on version 6 of the patch 
by Arnd. The idea was that these 2 devicetree properties will be used to 
populate the bootstat values from the bootloader and exposed to the user 
via /sys/firmware/devicetree/ directly.

Details in the link below:-

https://lore.kernel.org/lkml/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/T/#mbdc9ad95fcbb5ad7b56c6996a3933899b42d982c

Can you suggest any alternative way to represent this as a binding?

> 
>> +
>> +required:
>> +  - pre-abl-time
>> +  - abl-time
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    bootstats {
>> +        pre-abl-time="17627";
>> +        abl-time="26748";
> 
> Missing spaces. Open existing DTS and look at existing coding style.

Ack

> 
> Best regards,
> Krzysztof
> 
