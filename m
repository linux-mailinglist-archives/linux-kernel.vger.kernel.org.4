Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB8666C56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbjALIX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjALIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:22:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B11E3F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:21:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id tz12so42878894ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmdF79SXsIqABhejON+1FL/wkOkEnV19rbuuYjkz4bU=;
        b=N10u8PkXKxiV2Z2uf5hccqbyEDza3ArbfRkQBpznQEhYDs9BNOsIdEqOt5UECRqx1i
         8CRLXffZCgbae5z9t4SMarDOEZAE6IxtegeGaAceiL9jrkpK2JDRHVsdS6A65+gSV4T3
         APUgFzPGs0S+mrdiXxuP6w9BcnfATbjOKKNlGLRGbIuZPWEK/GorjTUyYNYEi3KxCLIU
         erRsogQeYpzQqyjWKSyvdSAPTxOALUKe1Q5r5baqjzYp5v7+4jdXajDl6RrpQNpdbNgr
         WU9GWrp1G3veJdS+hxssNfTOZsvW8Z2O0cSPAv8GfN/SHj2wp4GvDG75iadnD5TbHAH0
         eMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmdF79SXsIqABhejON+1FL/wkOkEnV19rbuuYjkz4bU=;
        b=qSKKI/38yyczS742XyxHHoAgaXRyk762V2m9sQEuP9Zcp+3qepTy3ee7u1oCStw6+0
         d8Z86Xl5IRA31DxCiS9Utne9FrvQUWDjP0oY2rssfxOZ9pDasbZVs2p/caPDfGhG56AX
         I+HwTd7LoFazf/XYh6TuG1SBXCj24uYFd4bECKyKMA/J2/JUI8kmlXFUpckRRslzVUBO
         eVPZCaGztpGGwdLtv/PHira8LvNcH4Kzp99bLv5b3/OIUrzOM+pab5qDjmfeRKCIaoHn
         oOkldI38yPZNpqSxWs9FVsa+cDnOjOHnF9f2Fg8ajCtxrODt7GsHAZD3fnaWuDQdZIDM
         oIEg==
X-Gm-Message-State: AFqh2kr42Q4tzlOe6wmXh2GOPaoIkaSeDwcc+JGRxeFcoHf4u0+KqMn6
        M7D9yvUa86Q9WbzJ8y2Jpz1UHg==
X-Google-Smtp-Source: AMrXdXu8NQkZ2kxq2Zw2KbVv34v3HLtzxtlB1LDG0r0rHEAtE3pMHfTxsA8OmCjGYhNeRsMlnb+nYw==
X-Received: by 2002:a17:907:c717:b0:7c1:ad6:638a with SMTP id ty23-20020a170907c71700b007c10ad6638amr70406421ejc.17.1673511685975;
        Thu, 12 Jan 2023 00:21:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906078600b0084d381d0528sm5942204ejc.180.2023.01.12.00.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 00:21:25 -0800 (PST)
Message-ID: <0cc43891-405e-418f-01ee-845d680b3a24@linaro.org>
Date:   Thu, 12 Jan 2023 09:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        jonas.gorski@gmail.com, kursad.oney@broadcom.com, dregan@mail.com,
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
 <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
 <32a464f8-6a4b-6777-9775-f17e990e0c6a@gmail.com>
 <71c2e796-f0fb-90cd-4599-13c9718f41d5@linaro.org>
 <31644849-dc69-ddfc-a6b6-6ffd37d64d2b@broadcom.com>
 <f0a50234-bc8c-09c4-e2c1-22cbeaba5c15@linaro.org>
 <e99a71b2-0b05-1a53-1c29-3778b49a3b86@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e99a71b2-0b05-1a53-1c29-3778b49a3b86@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 19:44, William Zhang wrote:
> 
> 
> On 01/11/2023 10:12 AM, Krzysztof Kozlowski wrote:
>> On 11/01/2023 19:04, William Zhang wrote:
>>>
>>>
>>> On 01/11/2023 01:02 AM, Krzysztof Kozlowski wrote:
>>>> On 10/01/2023 23:18, Florian Fainelli wrote:
>>>>> On 1/10/23 00:40, Krzysztof Kozlowski wrote:
>>>>>>>> No, it is discouraged in such forms. Family or IP block compatibles
>>>>>>>> should be prepended with a specific compatible. There were many issues
>>>>>>>> when people insisted on generic or family compatibles...
>>>>>>>>
>>>>>>>>> Otherwise we will have to have a compatible string with chip model for
>>>>>>>>> each SoC even they share the same IP. We already have more than ten of
>>>>>>>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>>>>>>>
>>>>>>>> You will have to do it anyway even with generic fallback, so I don't get
>>>>>>>> what is here to gain... I also don't get why Broadcom should be here
>>>>>>>> special, different than others. Why it is not a good solution for
>>>>>>>> Broadcom SoCs but it is for others?
>>>>>>>>
>>>>>>> I saw a few other vendors like these qcom ones:
>>>>>>>      qcom,spi-qup.yaml
>>>>>>>          - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>>>>>>>          - qcom,spi-qup-v2.1.1 # for 8974 and later
>>>>>>>          - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>>>>>>>      qcom,spi-qup.yaml
>>>>>>>          const: qcom,geni-spi
>>>>>>
>>>>>> IP block version numbers are allowed when there is clear mapping between
>>>>>> version and SoCs using it. This is the case for Qualcomm because there
>>>>>> is such clear mapping documented and available for Qualcomm engineers
>>>>>> and also some of us (although not public).
>>>>>>
>>>>>>> I guess when individual who only has one particular board/chip and is
>>>>>>> not aware of the IP family,  it is understandable to use the chip
>>>>>>> specific compatible string.
>>>>>>
>>>>>> Family of devices is not a versioned IP block.
>>>>>
>>>>> Would it be acceptable to define for instance:
>>>>>
>>>>> - compatible = "brcm,bcm6868-hsspi", "brcm,bcmbca-hsspi";
>>>>
>>>> Yes, this is perfectly valid. Although it does not solve William
>>>> concerns because it requires defining specific compatibles for all of
>>>> the SoCs.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> As I mentioned in another email,  I would be okay to use these
>>> compatibles to differentiate by ip rev and to conforms to brcm convention:
>>> "brcm,bcmXYZ-hsspi", "brcm,bcmbca-hsspi-v1.0", "brcm,bcmbca-hsspi";
>>> "brcm,bcmXYZ-hsspi", "brcm,bcmbca-hsspi-v1.1", "brcm,bcmbca-hsspi";
>>
>>
>> Drop the version in such case, no benefits. I assume XYZ is the SoC
>> model, so for example 6868.
>>
> Yes XYZ is the SoC model
>>>
>>> In the two drivers I included in this series, it will be bound to
>>> brcm,bcmbca-hsspi-v1.0 (in additional to brcm,bcm6328-hsspi) and
>>> brcm,bcmbca-hsspi-v1.1 respectively.  This way we don't need to update
>>> the driver with a new soc specific compatible whenever a new chips comes
>>> out.
>>
>> I don't understand why do you bring it now as an argument. You defined
>> before that your driver will bind to the generic bcmbca compatible, so
>> now it is not enough?
>>
> No as we are adding chip model specific info here.  The existing driver 
> spi-bcm63xx-hsspi.c only binds to brcm,bcm6328-hsspi. This driver 
> supports all the chips with rev1.0 controller so I am using this 6328 
> string for other chips with v1.0 in the dts patch, which is not ideal.

Why? This is perfectly ideal and usual case. Why changing it?

> Now I have to add more compatible to this driver and for each new chip 
> with 1.0 in the future if any.

Why you cannot use compatibility with older chipset?


Best regards,
Krzysztof

