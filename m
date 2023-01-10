Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479D6663B73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjAJIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbjAJIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:40:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A2C4D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:40:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d17so10923551wrs.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzc6hdjQTHbPCxWj+m5gERAJ10AVL3L5//b7OUxg4Es=;
        b=KzQc8yML1zFUavhHO2vHTnfFIsHPyJzUZxKd5CQbiS4DMKLhfTVvo7CIcTsO9/05nG
         FSVtujfArS0tXwJ+jL8+qKaiGMUBVeQZfqAUKj6xwfzxwpC3dl8j3snqS1HUc7IDtg2C
         fv54KCUp+1QZ/q+EsUT/GWOykzl40qVIWe0x+Urmxj+1Z4sk0IiqnUS/d663Yt3YN/w1
         4r/jbGq2D3MktMPUGDgZYtBjX2wnMhoXmVF8DymjMpy8TBVNLGWjz2IpdHqLfEMV6UZT
         oGiLPLFJugj66swnl42/KYuNXky3ZwOtS6wezUwUWzc7nNz7fK4I2p7eidGn0YWy41nt
         prdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzc6hdjQTHbPCxWj+m5gERAJ10AVL3L5//b7OUxg4Es=;
        b=mS+nRddLWHepfij6HpVb7eTC/ADWYS9owu2ljg9+R2vPq3f16O0SRgGyrPKWhoKsh3
         ax6/qmaq3Me/9zrQqY7vWmcjUKojuYs28UfRwaVOH/KyZwyhD7DDHcrGIsTbSfMDSO3g
         H4d04FTaMHnmRQ3vKxDWPhig6/c94qSVNej1RL038/cMSqTRU8myOiH8ozii+0PNckme
         neGqoEeBTodACvee3QsbgDMqXNmXgEDUIl3iN/iw55TcIdcPLWyHE2+9v4J2gyblxZ9u
         5T6ZL8EGa1EYrBxK59tN5TZqFPECrsBFP3Xb5Nm9KN9vVJiCJKxaI7TaD6HOkCA1dDM/
         3WzQ==
X-Gm-Message-State: AFqh2kp8QzstpjN59FO2GhaG+ObZYioyqELXh62RcmTarJq4BulPk97f
        QJuB/zoI4vMF6trMtThvKKuiaQ==
X-Google-Smtp-Source: AMrXdXuXvs7kmxwud6wPlxYBXc1N2FBJ4gD32d1t6nFYov+QTX3Y1AZ4JwWjs8ntIBz+Gqb4C9t5Zg==
X-Received: by 2002:a5d:54ce:0:b0:242:8b69:cf2b with SMTP id x14-20020a5d54ce000000b002428b69cf2bmr39013216wrv.47.1673340040850;
        Tue, 10 Jan 2023 00:40:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm1230690wrr.26.2023.01.10.00.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 00:40:40 -0800 (PST)
Message-ID: <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
Date:   Tue, 10 Jan 2023 09:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-3-william.zhang@broadcom.com>
 <b529a53b-d00c-063d-a58d-e64b0300605d@linaro.org>
 <5dfac2d7-3b4b-9ded-0dde-26b289c604d0@broadcom.com>
 <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
 <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 20:13, William Zhang wrote:
> 
> 
> On 01/09/2023 12:56 AM, Krzysztof Kozlowski wrote:
>> On 09/01/2023 09:27, William Zhang wrote:
>>> Hi Krzysztof,
>>>
>>> On 01/08/2023 06:51 AM, Krzysztof Kozlowski wrote:
>>>> On 06/01/2023 21:07, William Zhang wrote:
>>>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
>>>>> controller. Add a new compatible string and required fields for the new
>>>>> driver.  Also add myself and Kursad as the maintainers.
>>>>>
>>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>>> ---
>>>>>
>>>>>    .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 84 +++++++++++++++++--
>>>>>    1 file changed, 78 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>>> index 45f1417b1213..56e69d4a1faf 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>>> @@ -4,22 +4,51 @@
>>>>>    $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>>>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>    
>>>>> -title: Broadcom BCM6328 High Speed SPI controller
>>>>> +title: Broadcom Broadband SoC High Speed SPI controller
>>>>>    
>>>>>    maintainers:
>>>>> +
>>>>
>>>> Drop blank line.
>>> will fix in  v2.
>>>
>>>>
>>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>>> +  - Kursad Oney <kursad.oney@broadcom.com>
>>>>>      - Jonas Gorski <jonas.gorski@gmail.com>
>>>>
>>>>>    
>>>>> +description: |
>>>>> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
>>>>> +  early MIPS based chips such as BCM6328 and BCM63268.  This controller was
>>>>> +  carried over to recent ARM based chips, such as BCM63138, BCM4908 and BCM6858.
>>>>> +
>>>>> +  It has a limitation that can not keep the chip select line active between
>>>>> +  the SPI transfers within the same SPI message. This can terminate the
>>>>> +  transaction to some SPI devices prematurely. The issue can be worked around by
>>>>> +  either the controller's prepend mode or using the dummy chip select
>>>>> +  workaround. This controller uses the compatible string brcm,bcm6328-hsspi.
>>>>> +
>>>>> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
>>>>> +  controller that add the capability to allow the driver to control chip select
>>>>> +  explicitly. This solves the issue in the old controller. This new controller
>>>>> +  uses the compatible string brcm,bcmbca-hsspi.
>>>>> +
>>>>>    properties:
>>>>>      compatible:
>>>>> -    const: brcm,bcm6328-hsspi
>>>>> +    enum:
>>>>> +      - brcm,bcm6328-hsspi
>>>>> +      - brcm,bcmbca-hsspi
>>>>
>>>> bca seems quite unspecific. Your description above mentions several
>>>> model numbers and "bca" is not listed as model. Compatibles cannot be
>>>> generic.
>>> "bca" is not model number, rather it is a group (broadband carrier
>>> access) of chip that share the same spi host controller IP. Agree it is
>>> not particularly specific but it differentiate from other broadcom spi
>>> controller ip used by other groups.  We just don't have a specific name
>>> for this spi host controller but can we treat bcmbca as the ip name?
>>
>> No, it is discouraged in such forms. Family or IP block compatibles
>> should be prepended with a specific compatible. There were many issues
>> when people insisted on generic or family compatibles...
>>
>>> Otherwise we will have to have a compatible string with chip model for
>>> each SoC even they share the same IP. We already have more than ten of
>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>
>> You will have to do it anyway even with generic fallback, so I don't get
>> what is here to gain... I also don't get why Broadcom should be here
>> special, different than others. Why it is not a good solution for
>> Broadcom SoCs but it is for others?
>>
> I saw a few other vendors like these qcom ones:
>   qcom,spi-qup.yaml
>       - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>       - qcom,spi-qup-v2.1.1 # for 8974 and later
>       - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>   qcom,spi-qup.yaml
>       const: qcom,geni-spi

IP block version numbers are allowed when there is clear mapping between
version and SoCs using it. This is the case for Qualcomm because there
is such clear mapping documented and available for Qualcomm engineers
and also some of us (although not public).

> I guess when individual who only has one particular board/chip and is 
> not aware of the IP family,  it is understandable to use the chip 
> specific compatible string.

Family of devices is not a versioned IP block.

> But when company works on it, we have the 
> visibility and access to all the chips and ip blocks in the family and 
> IMHO it is very reasonable to use the IP family name for the same IP as 
> these examples shows. 

No, because family of devices is not a versioned IP block. I wrote
before that families and wildcards are not allowed.

> Are you saying these are not good example to 
> follow?  

It's nothing related to your case.

> What are the issues with generic or family compatibles? 
>  Could 
> you please elaborate?

They stop matching and some point and cause ABI breaks. We had several
cases where engineer believed "I have here family of devices" and then
later it turned out that the family is different.


> 
>>
>>
>>>
>>>>
>>>>>    
>>>>>      reg:
>>>>> -    maxItems: 1
>>>>> +    items:
>>>>> +      - description: main registers
>>>>> +      - description: miscellaneous control registers
>>>>> +    minItems: 1
>>>>> +
>>>>> +  reg-names:
>>>>> +    items:
>>>>> +      - const: hsspi
>>>>> +      - const: spim-ctrl
>>>>
>>>> This does not match reg
>>> Do you mean it does not match the description?
>>
>> No. reg can be 1 item but you state reg-names cannot. These are always
>> the same. If one is 1 item, second is as well.
>>
> I'll drop the "minItems: 1" from the reg property then.

Then it won't be correct, because it would mean two items are required
always.

> 
>>>>
>>>>>    
>>>>>      clocks:
>>>>>        items:
>>>>> -      - description: spi master reference clock
>>>>> -      - description: spi master pll clock
>>>>> +      - description: SPI master reference clock
>>>>> +      - description: SPI master pll clock
>>>>
>>>> Really? You just added it in previous patch, didn't you?
>>> The previous patch was just word to word conversion of the text file.  I
>>> will update that patch to include this change.
>>>
>>>>
>>>>>    
>>>>>      clock-names:
>>>>>        items:
>>>>> @@ -29,12 +58,43 @@ properties:
>>>>>      interrupts:
>>>>>        maxItems: 1
>>>>>    
>>>>> +  brcm,use-cs-workaround:
>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>> +    description: |
>>>>> +      Enable dummy chip select workaround for SPI transfers that can not be
>>>>> +      supported by the default controller's prepend mode, i.e. delay or cs
>>>>> +      change needed between SPI transfers.
>>>>
>>>> You need to describe what is the workaround.
>>> Will do.
>>>>
>>>>> +
>>>>>    required:
>>>>>      - compatible
>>>>>      - reg
>>>>>      - clocks
>>>>>      - clock-names
>>>>> -  - interrupts
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: "spi-controller.yaml#"
>>>>
>>>> No quotes. How this is related to this patch?
>>> Will remove quote and put it in patch 1.
>>>>
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - brcm,bcm6328-hsspi
>>>>> +    then:
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          minItems: 1
>>>>
>>>> Drop.
>>>>
>>>> reg-names now do not match.
>>> Don't quite understand your comment. What do I need to drop and what is
>>> not matched?
>>
>> You need to add constraints for reg-names, same way as for reg.
>> Disallowing the reg-names also could work, but there won't be benefit in
>> it. Better to have uniform DTS.
>>
> I agree it is better to have the uniform DTS but the situation here is 
> that the brcm,bcm6328-hsspi does not require reg name since there is 
> only one register needed and it was already used in many chip dts for 
> long time.  If I enforce it to have the corresponding reg name, that 

No one told you to enforce to have a reg-names.

> could potentially break the compatibility of those old device if the 
> driver change to use reg name, right?

How compatibility is broken by some optional, unrelated property?

Best regards,
Krzysztof

