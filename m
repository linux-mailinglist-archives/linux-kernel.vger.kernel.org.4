Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5845C5F9C38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiJJJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJJJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:47:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69865675;
        Mon, 10 Oct 2022 02:47:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A7VSOh021186;
        Mon, 10 Oct 2022 09:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S06w9rvEa830S5qbSrhluBM4E6Rpm9SaC0dYDr7rCi4=;
 b=HSNRK4PrLCDy3wyf1HK8kgxSgLqN4Fpi7XNTIVMm4loTfs0O5UBDk0xNtF/ChPIR6Vb0
 Yz80eCuMf326Wcm81GEy0PUwpUCeTgSgBuwMPwoeXF5MwCLCBU6ogConyVY/G9ngySpI
 NOUb3CO07d+mdQmjz3SRWM+e/Z/L98jPUliwFo+p/qwZ/VYjF3zG+wiQnNYE+CZc/0n3
 mxGcXt+51L2iDmpypMNwZV+XSnh9M3TXc7cvXKzQ2XlqRPlm0fg2v0uBcvVmgXbYOb67
 iUprFfbEAyU1kv/9fS6R0oqI1bfrfc4IM7rfDkwjAp0zThH/74n/EicxCQaA3xM/mBsp 6Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k32csbsj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:47:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29A9lbfP010122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:47:37 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 02:47:34 -0700
Message-ID: <c3a6c664-d52e-4de4-07f3-b15537d29d5a@quicinc.com>
Date:   Mon, 10 Oct 2022 17:47:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
 <20220929121544.1064279-3-quic_fenglinw@quicinc.com>
 <5445adda-80e6-41d0-9786-c26d253631c9@linaro.org>
 <20220930193308.GA741352-robh@kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20220930193308.GA741352-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -N9EX9PEnXfiL1OOkr4IylsRLzPvUOeQ
X-Proofpoint-ORIG-GUID: -N9EX9PEnXfiL1OOkr4IylsRLzPvUOeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100059
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/1 3:33, Rob Herring wrote:
> On Thu, Sep 29, 2022 at 02:40:05PM +0200, Krzysztof Kozlowski wrote:
>> On 29/09/2022 14:15, Fenglin Wu wrote:
>>> Add binding document for flash LED module inside Qualcomm Technologies,
>>> Inc. PMICs.
>>>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +  reg:
>>> +    description: address offset of the flash LED controller
>>> +    maxItems: 1
>>> +
>>> +patternProperties:
>>> +  "^led[0-3]$":
>>
>> In such case: ^led-[0-9]$"
>>
>>> +    type: object
>>> +    $ref: common.yaml#
>>> +    unevaluatedProperties: false
>>> +    description: |
>>> +      Represents the physical LED components which are connected to the
>>> +      flash LED channels' output.
>>> +
>>> +    properties:
>>> +      led-sources:
> 
> This is for when the power source and LED connection are programmable.
> IOW, when 'reg' is not enough to describe the configuration. If you only
> have LED channels 1-4 with a fixed connection to LED pins/output 1-4,
> then use 'reg'.
> 
I think using led-sources here is more appropriate. The LED connection 
can be programmable to match with the board design. The flash module has 
4 channels (current outputs, indexed from 1 to 4) and the LEDs can be 
connected to either one or two of them depends on the design. Such as, 
if the design only requires LEDs with 1.5 A maximum current, then the HW 
just connects one channel to each LED and specify the corresponding 
channel index in the led-sources. Or if the design requires LEDs 
supporting up to 2 A maximum current, then the HW needs to gang 2 
channels' output together and specify the HW indices in led-sources 
accordingly.

>>> +        description: |
>>> +          The HW indices of the flash LED channels that connect to the
>>> +          physical LED
>>> +        allOf:
>>> +          - minItems: 1
>>> +            maxItems: 2
>>> +            items:
>>> +              enum: [1, 2, 3, 4]
>>> +
>>> +      led-max-microamp:
>>> +        description: |
>>> +          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
>>> +          Valid values when an LED is connected to one flash LED channel:
>>> +            5000 - 500000, step by 5000
>>> +          Valid values when an LED is connected to two flash LED channels:
>>> +            10000 - 1000000, step by 10000
>>> +        minimum: 5000
>>> +        maximum: 1000000
> 
> anyOf:
>    - minimum: 5000
>      maximum: 500000
>      multipleOf: 5000
>    - minimum: 10000
>      maximum: 1000000
>      multipleOf: 10000
> 
> Drop any description that's captured by the constraints.
Thanks for the suggestion. I will update it accordingly.
> 
>>> +
>>> +      flash-max-microamp:
>>> +        description: |
>>> +          The maximum current value when LED is operating in flash mode.
>>> +          Valid values when an LED is connected to one flash LED channel:
>>> +            12500 - 1500000, step by 12500
>>> +          Valid values when an LED is connected to two flash LED channels:
>>> +            25000 - 2000000, step by 12500
>>> +        minimum: 12500
>>> +        maximum: 2000000
>>> +
>>> +      flash-max-timeout-us:
>>> +        description: |
>>> +          The maximum timeout value when LED is operating in flash mode.
>>> +          Valid values: 10000 - 1280000, step by 10000
>>> +        minimum: 10000
>>> +        maximum: 1280000
> 
> Similar comment for these 2.
Done
> 
>>> +
>>> +    required:
>>> +      - led-sources
>>> +      - led-max-microamp
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/leds/common.h>
>>> +    spmi_bus {
>>
>> No underscores in node names, so just "bus"
> 
> SPMI is something else though...
Sure, will update it to spmi
> 
