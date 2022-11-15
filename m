Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A92629AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKONn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiKONnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:43:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60D7F186E2;
        Tue, 15 Nov 2022 05:43:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE8E13D5;
        Tue, 15 Nov 2022 05:43:28 -0800 (PST)
Received: from [10.57.70.90] (unknown [10.57.70.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDDEA3F73B;
        Tue, 15 Nov 2022 05:43:19 -0800 (PST)
Message-ID: <4a9083fc-81ba-f5ca-5df7-cd04becb1dce@arm.com>
Date:   Tue, 15 Nov 2022 13:43:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
 <20221114104222.36329-2-konrad.dybcio@linaro.org>
 <6fa8e3ea-2113-d930-96bc-3726d53e5bcd@linaro.org>
 <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
 <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
 <12578e05-ced9-e5f7-7922-0af2f2159333@linaro.org>
 <878402e7-7f80-31c7-3a6b-989a6ca29841@linaro.org>
 <f59ddce1-c2e1-4055-3bce-1319c68ddf94@linaro.org>
 <4b4ca3ba-8e4d-088e-8b3e-a47ad6ecb965@linaro.org>
 <cff269c8-f944-9277-9df8-653522efbba0@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cff269c8-f944-9277-9df8-653522efbba0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-15 13:06, Konrad Dybcio wrote:
> 
> 
> On 15/11/2022 14:00, Krzysztof Kozlowski wrote:
>> On 15/11/2022 13:54, Konrad Dybcio wrote:
>>>
>>>
>>> On 14/11/2022 17:58, Krzysztof Kozlowski wrote:
>>>> On 14/11/2022 16:53, Konrad Dybcio wrote:
>>>>>
>>>>> On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
>>>>>> On 14/11/2022 12:17, Konrad Dybcio wrote:
>>>>>>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>>>>>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>>>>>>> Some SMMUs require that a vote is held on as much as 3 separate 
>>>>>>>>> PDs
>>>>>>>>> (hello Qualcomm). Allow it in bindings.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>>> ---
>>>>>>>>> Changes since v1:
>>>>>>>>> - Add minItems
>>>>>>>>>
>>>>>>>>>      Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git 
>>>>>>>>> a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml 
>>>>>>>>> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>>>> index 9066e6df1ba1..82bc696de662 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>>>> @@ -159,7 +159,8 @@ properties:
>>>>>>>>>                through the TCU's programming interface.
>>>>>>>>>        power-domains:
>>>>>>>>> -    maxItems: 1
>>>>>>>>> +    minItems: 0
>>>>>>>> It cannot be 0.
>>>>>>>>
>>>>>>>> minItems: 1
>>>>>>>>
>>>>>>>> Anyway you still need to restrict it per variant, as I said in 
>>>>>>>> previous
>>>>>>>> version.
>>>>>>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>>>>>>> compatibles
>>>>>> Yes and limit it to maxItems: 1 for "else".
>>>>>
>>>>> I tried adding:
>>>>>
>>>>>
>>>>>
>>>>>      - if:
>>>>>          properties:
>>>>>            compatible:
>>>>>              contains:
>>>>>                enum:
>>>>>                  - qcom,sm6375-smmu-500
>>>>>        then:
>>>>>          properties:
>>>>>            power-domains:
>>>>>              minItems: 3
>>>>>              maxItems: 3
>>>>>        else:
>>>>>          properties:
>>>>>            power-domains:
>>>>>              maxItems: 1
>>>>>
>>>>>
>>>>> Right under the nvidia reg if-else in the allOf, but dtbs_check throws
>>>>> errors like:
>>>>>
>>>>>
>>>>> /home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb:
>>>>> iommu@5040000: 'power-domains' does not match any of the regexes:
>>>>> 'pinctrl-[0-9]+'
>>>>>
>>>>>
>>>>> Any clues as to why?
>>>>
>>>> I don't know what code do you have there, but generic pattern is:
>>>>
>>>> https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38
>>>>
>>> I tried many things, but I still don't seem to get a hang of it.. Here's
>>> my current diff rebased on top of Dmitry's recent cleanups (available at
>>> [1])
>>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> index 28f5720824cd..55759aebc4a0 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> @@ -200,7 +200,7 @@ properties:
>>>        maxItems: 7
>>>
>>>      power-domains:
>>
>> As I mentioned before - minItems: 1.
> But not all SMMUs require a power domain :/

Right, so it's not a required property. However if it *is* present, then 
it needs to reference at least one power domain, because having an empty 
property, i.e.:

	power-domains = <>;

or
	power-domains;

makes no sense whatsoever.

Thanks,
Robin.

> 
>>
>> Just like the link I gave you.
>>
>>> -    maxItems: 1
>>> +    maxItems: 3
>>>
>>>      nvidia,memory-controller:
>>>        description: |
>>> @@ -364,6 +364,26 @@ allOf:
>>>                - description: interface clock required to access smmu's
>>> registers
>>>                    through the TCU's programming interface.
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: qcom,sm6375-smmu-500
>>> +    then:
>>> +      properties:
>>> +        power-domains:
>>> +          items:
>>> +            - description: SNoC MMU TBU RT GDSC
>>> +            - description: SNoC MMU TBU NRT GDSC
>>> +            - description: SNoC TURING MMU TBU0 GDSC
>>> +
>>> +      required:
>>> +        - power-domains
>>> +    else:
>>> +      properties:
>>> +        power-domains:
>>> +          maxItems: 1
>>> +
>>>    examples:
>>>      - |+
>>>        /* SMMU with stream matching or stream indexing */
>>>
>>>
>>> In my eyes, this should work, but I still get errors like:
>>>
>>> /home/konrad/linux/arch/arm64/boot/dts/qcom/sm8250-hdk.dtb:
>>> iommu@3da0000: power-domains: [[108, 0]] is too short
>>>
>>> as if the else: path was never taken..
>>
>> It was, but the top-level property said that minItems=3 (implicitly), so
>> it is too short.
> So the top-level properties take precedence over the ones that come from 
> the if-then-else?? Ugh.
> 
> Konrad
>>
>> Best regards,
>> Krzysztof
>>
