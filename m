Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A172E5EF3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiI2K46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiI2K4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:56:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BD543CF;
        Thu, 29 Sep 2022 03:56:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TAbjBs023869;
        Thu, 29 Sep 2022 10:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lrbmEnvFj0qbNHfuGo6CEoh1FFGnRSOUFShvbbb4DDg=;
 b=StUu863Nfoc5YK7DJWGwc8NJ/RzYRK8DK2LgVm1hop5a0Hqg1Wgl/ToPmR0b9na/lGug
 eNRbzy1A+tFIcc09HPQAKlk7zA5OHYTAsAr+BfFpSIKMJzilBMHcfwZbKIlz00KOBckq
 sWJuLZ0UR6fhua/Rqmc7GsTsJxiBEEie2uWQcIsgx/PUqNvZr7gOWnhpb5mjoq9QqS2L
 fF9CCEJqll/6+O/vYLtfUz2JoJSsQgz5sSPoS/5oFAsx82NrID4eREFlqvsddw8PFBeO
 aZ0Kty3b1ZYdW7vnCg0OmmMZhJ+NF3SNY2lUCv+Zxc8NpF/o6eOiMHDvnoN3k3QsakU6 MA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvm4vk229-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:56:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28TAuiu0005130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:56:44 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 03:56:42 -0700
Message-ID: <107dfb13-85fc-123d-d244-962ce6c1cdb7@quicinc.com>
Date:   Thu, 29 Sep 2022 18:56:39 +0800
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
 <2d6fac8d-0ac1-75bb-0b4c-c2c34583b09e@quicinc.com>
 <d6dc534f-2dc4-979c-ddad-c2122db7923a@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <d6dc534f-2dc4-979c-ddad-c2122db7923a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pzQp1rHY6c0KGEWIM9fG4L2eFyld4grH
X-Proofpoint-GUID: pzQp1rHY6c0KGEWIM9fG4L2eFyld4grH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=985 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290067
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 15:06, Krzysztof Kozlowski wrote:
> On 29/09/2022 04:20, Fenglin Wu wrote:
>>
>>
>> On 2022/9/28 16:21, Krzysztof Kozlowski wrote:
>>> On 28/09/2022 04:42, Fenglin Wu wrote:
>>>> Add binding document for flash LED module inside Qualcomm Technologies,
>>>> Inc. PMICs.
>>>>
>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>
>>> You did not Cc me on first patch, so difficult to say how much it
>>> matches the driver... There is also no DTS.
>> Thanks for reviewing the binding change, I sent the driver changes in
>> the same series and you can check it here:
>> https://lore.kernel.org/linux-leds/6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org/T/#m97f71ce3f291f62d65f8107352d8ab9507093ab2
>>
>> I will add you in email to list when sending next patchset.
> 
> Don't add just mine. Use instead scripts/get_maintainers.pl. For small
> patchsets recipients should get everything. For big patchsets it is
> usually split, where everyone receive only cover letter. It's not the
> case here...
> 
Thanks for the suggestion.
I actually used scripts/get_maintainers.pl when pushing the patches. I 
will double check it when sending v2.
Thanks
>>>
>>>> ---
>>>>    .../bindings/leds/leds-qcom-flash.yaml        | 108 ++++++++++++++++++
>>>>    1 file changed, 108 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>>> new file mode 100644
>>>> index 000000000000..52a99182961b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>>
>>>
>>> Filename matching compatible if there is one fallback (e.g.
>>> qcom,spmi-flash-led.yaml).
>>>
>> Sure, I will update the file name to match with the fallback compatible
>> string.
>>>> @@ -0,0 +1,108 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/leds/leds-qcom-flash.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
>>>> +
>>>> +maintainers:
>>>> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
>>>> +
>>>> +description: |
>>>> +  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
>>>> +  The flash LED module can have different number of LED channels supported
>>>> +  e.g. 3 or 4. There are some different registers between them but they can
>>>> +  both support maximum current up to 1.5 A per channel and they can also support
>>>> +  ganging 2 channels together to supply maximum current up to 2 A. The current
>>>> +  will be split symmetrically on each channel and they will be enabled and
>>>> +  disabled at the same time.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - qcom,spmi-flash-led
>>>> +          - qcom,pm8150c-flash-led
>>>> +          - qcom,pm8150l-flash-led
>>>> +          - qcom,pm8350c-flash-led
>>>
>>> I doubt these are all different. You should use fallback, which also
>>> will make use of the "items" you used...
>> pm8150c and pm8150l are different PMIC variants which have same flash
>> LED module with 3 flash LED channels, while pm8350c has a different
>> flash LED module with 4 flash LED channels. They can all use
>> "qcom,spmi-flash-led" as the fallback because the driver has code logic
>> to detect HW sub-types.
> 
> If driver binds to only one compatible, it is expected to be the
> fallback for all others. There might be exception for this rule but it
> does not look like here.
> 
>> But I was thinking to give out the PMIC names
>> here so anyone who is using the driver could easily identify if the
>> driver is suitable for the HW that he/she is using.
> 
> I did not say to remove other compatibles, but to use one fallback for
> all of them.
> 
Do you mean to update it similar to this?

compatible:
   items:
     - enum:
         - qcom,pm8150c-flash-led
         - qcom,pm8150l-flash-led
         - qcom,pm8350c-flash-led
     - const:
         - qcom,spmi-flash-led

> Best regards,
> Krzysztof
> 
