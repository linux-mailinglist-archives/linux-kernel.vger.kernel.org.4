Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB05EEBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiI2CVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiI2CV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:21:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72B124751;
        Wed, 28 Sep 2022 19:20:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SNTBBU008607;
        Thu, 29 Sep 2022 02:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hhwIaG05I+vjp+zpF69jrGv/z7cENff/DU0sjIfbwqI=;
 b=jdvz8yZ4+gc4XK5k6+K+Q5uEinNdAq5u8Q0JZyBXm4cK7swVxzp/Fka9/pyFLYCIiXrl
 QW0InxHBmR9wkNeV6R+oFkz7VaKGThh5y8q2CVr4tqoU2stLUaRrwioVwXSOb58Fo3h9
 qn93qgNvwv3eH61mFSSM9eL0h9RQh/iFiQzVKtXFYuUlYY1E/TqsOKX6/j+Rrznb9qNq
 inZ9TdT/XLByGrAFhjtpLzu0ERjW5ad/sU8XRpD3ozpD9ZXxSWXzNmVLlpZR2y9dfSW/
 g9I5td3PPQVQYTFgN4chz6AA85KGOyee+HT6OBxDYlEe+d0cT9Ir+UzPR4zLsZTn1GVL iQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvkbahy70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 02:20:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28T2Km42017661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 02:20:48 GMT
Received: from [10.233.23.112] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 19:20:45 -0700
Message-ID: <2d6fac8d-0ac1-75bb-0b4c-c2c34583b09e@quicinc.com>
Date:   Thu, 29 Sep 2022 10:20:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
References: <20220928024239.3843909-1-quic_fenglinw@quicinc.com>
 <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
 <6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _U0xUoQlL-pRfK8IYpJAQoNQ7AI1AnVD
X-Proofpoint-ORIG-GUID: _U0xUoQlL-pRfK8IYpJAQoNQ7AI1AnVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_11,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209290013
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/28 16:21, Krzysztof Kozlowski wrote:
> On 28/09/2022 04:42, Fenglin Wu wrote:
>> Add binding document for flash LED module inside Qualcomm Technologies,
>> Inc. PMICs.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> You did not Cc me on first patch, so difficult to say how much it
> matches the driver... There is also no DTS.
Thanks for reviewing the binding change, I sent the driver changes in 
the same series and you can check it here:
https://lore.kernel.org/linux-leds/6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org/T/#m97f71ce3f291f62d65f8107352d8ab9507093ab2

I will add you in email to list when sending next patchset.
> 
>> ---
>>   .../bindings/leds/leds-qcom-flash.yaml        | 108 ++++++++++++++++++
>>   1 file changed, 108 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>> new file mode 100644
>> index 000000000000..52a99182961b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
> 
> 
> Filename matching compatible if there is one fallback (e.g.
> qcom,spmi-flash-led.yaml).
> 
Sure, I will update the file name to match with the fallback compatible 
string.
>> @@ -0,0 +1,108 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/leds-qcom-flash.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
>> +
>> +maintainers:
>> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
>> +
>> +description: |
>> +  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
>> +  The flash LED module can have different number of LED channels supported
>> +  e.g. 3 or 4. There are some different registers between them but they can
>> +  both support maximum current up to 1.5 A per channel and they can also support
>> +  ganging 2 channels together to supply maximum current up to 2 A. The current
>> +  will be split symmetrically on each channel and they will be enabled and
>> +  disabled at the same time.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,spmi-flash-led
>> +          - qcom,pm8150c-flash-led
>> +          - qcom,pm8150l-flash-led
>> +          - qcom,pm8350c-flash-led
> 
> I doubt these are all different. You should use fallback, which also
> will make use of the "items" you used...
pm8150c and pm8150l are different PMIC variants which have same flash 
LED module with 3 flash LED channels, while pm8350c has a different 
flash LED module with 4 flash LED channels. They can all use 
"qcom,spmi-flash-led" as the fallback because the driver has code logic 
to detect HW sub-types. But I was thinking to give out the PMIC names 
here so anyone who is using the driver could easily identify if the 
driver is suitable for the HW that he/she is using.
> 
>> +
>> +  reg:
>> +    description: address offset of the flash LED controller
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^led@[0-3]$":
>> +    type: object
>> +    $ref: common.yaml#
>> +    unevaluatedProperties: false
>> +    description:
>> +      Represents the physical LED components which are connected to the flash LED channels' output.
> 
> Does not look like wrapped at 80.
> 
> Other places as well.
> Sure, will wrap the lines at 80, I thought not exceeding 110 is also 
acceptable.
>> +
>> +    properties:
> 
> Does not look like you tested the bindings...
> 
> You miss here reg.
> 
will update the node name without using unit name.

>> +      led-sources:
>> +        description: The HW indices of the flash LED channels that connect to the physical LED
>> +        allOf:
>> +          - minItems: 1
>> +            maxItems: 2
>> +            items:
>> +              enum: [1, 2, 3, 4]
>> +
>> +      led-max-microamp:
>> +        description: |
>> +          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
>> +          Valid values when an LED is connected to one flash LED channel:
>> +            5000 - 500000, step by 5000> +          Valid values when an LED is connected to two flash LED
> channels:
>> +            10000 - 1000000, step by 10000
> 
> You need minimum and maximum.
> 
Sure, I will add them
>> +
>> +      flash-max-microamp:
>> +        description: |
>> +          The maximum current value when LED is operating in flash mode.
>> +          Valid values when an LED is connected to one flash LED channel:
>> +            12500 - 1500000, step by 12500
>> +          Valid values when an LED is connected to two flash LED channels:
>> +            25000 - 2000000, step by 12500
> 
> You need minimum and maximum.
Sure, I will add them
> 
> 
>> +
>> +      flash-max-timeout-us:
>> +        description: |
>> +          The maximum timeout value when LED is operating in flash mode.
>> +          Valid values: 10000 - 1280000, step by 10000
> 
> You need minimum and maximum.
> 
>> +
>> +    required:
>> +      - led-sources
>> +      - led-max-microamp
> 
> reg.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/leds/common.h>
>> +    flash-led@ee00 {
> 
> Node name: led-controller
> 
>> +            compatible = "qcom,spmi-flash-led";
>> +            reg = <0xee00>;
>> +
>> +            led@0 {
> 
> Test your bindings...
> 
>> +                    function = LED_FUNCTION_FLASH;
> 
> Use 4 spaces for indentation of example.
> 
sure, I will update it.
>> +                    color = <LED_COLOR_ID_WHITE>;
>> +                    led-sources = <1>, <4>;
>> +                    led-max-microamp = <300000>;
>> +                    flash-max-microamp = <2000000>;
>> +                    flash-max-timeout-us = <1280000>;
>> +                    function-enumerator = <0>;
>> +            };
>> +
> 
> Best regards,
> Krzysztof
> 
