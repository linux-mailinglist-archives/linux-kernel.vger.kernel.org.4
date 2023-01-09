Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216BE6620E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjAIJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbjAIJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:03:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D019915822
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:56:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o15so5713844wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkS6ryyVO3m71hcn6THyhTm7nRya1cKN2SD9TksIJ68=;
        b=b0I08kGC325puhFWUTfCzD/tGSB0juYwlttLEJO1fXogVoXNpAN2VPbC1mUW0CJ3Vj
         7eTo5OR6+QcAVvfDF0/7oZo3j7pfvQqh/LcsAUBUF8ABGNIaaaVSjkVqoW27Hm6X3e2d
         hmJsL9tUtIoxDl8SksSVIjkKtS7fMFG7iJcRGx6gfoYK3BXOq2a5H8gYG2PB+j8QAFyA
         Qqwf2iXchSB9saLrXcde8KxSaPcJpDSyjxH3jM9WHSplKcv3r2nypKfUSKw1b1t9t1MX
         ZnAfxJr5cm0NiuUKPs+z+VgmVNs0ofZ0ySF/FDIm6ROVLc8xTcpWEEt+2Hxb66wROMcS
         RShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkS6ryyVO3m71hcn6THyhTm7nRya1cKN2SD9TksIJ68=;
        b=fuMI+jOPcLP4m4NQ6xmx4Nic1P8qRJlVTGW5Hqbus/Gd5+0o1EFl+xxu1o9jBG6ChM
         hzqJHSCtw86KGkeCn/LRfpWvg6MpfC+G/YV8wCdutufyuBjulxIFbbUQLikzsMC0LI6C
         EnYE44PB6xtz0rl4yBTb9mQGXzfTcJOx3ZrFNuH1EJSmPV+OnOUrc/g5Zxe2sF8C/jQa
         NYkpw7WcChYSDIGdyYcS1vqdI22w/li9oOTfwn1z+Bxcfl4wMqzXikk0UfFgX1rf5LRL
         i7kW8UiEEYZ+p/7/I8ziiiAUlE0j+1oiQJmaPul+hPXgKk/QsfKn50lyKsjrphWFxyMf
         zWSg==
X-Gm-Message-State: AFqh2kqmpjC/fMq5oSBhsE4hNboCC/8GyvbBn64CzdTIw5AyLE9oCGRP
        kIcABJ6EkTBvzGtDAQuCaAQyzA==
X-Google-Smtp-Source: AMrXdXv/LTfIUE+pq+r5uK163nL8BHMy1oBryyJ2UHDcDdfs95k58i+bGQQu6IoDYqKITcsK4/QE3Q==
X-Received: by 2002:a05:600c:3584:b0:3d9:719a:8f7d with SMTP id p4-20020a05600c358400b003d9719a8f7dmr38331902wmq.35.1673254597292;
        Mon, 09 Jan 2023 00:56:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm16872994wms.15.2023.01.09.00.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:56:36 -0800 (PST)
Message-ID: <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
Date:   Mon, 9 Jan 2023 09:56:35 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5dfac2d7-3b4b-9ded-0dde-26b289c604d0@broadcom.com>
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

On 09/01/2023 09:27, William Zhang wrote:
> Hi Krzysztof,
> 
> On 01/08/2023 06:51 AM, Krzysztof Kozlowski wrote:
>> On 06/01/2023 21:07, William Zhang wrote:
>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
>>> controller. Add a new compatible string and required fields for the new
>>> driver.  Also add myself and Kursad as the maintainers.
>>>
>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>> ---
>>>
>>>   .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 84 +++++++++++++++++--
>>>   1 file changed, 78 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>> index 45f1417b1213..56e69d4a1faf 100644
>>> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>> @@ -4,22 +4,51 @@
>>>   $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>   
>>> -title: Broadcom BCM6328 High Speed SPI controller
>>> +title: Broadcom Broadband SoC High Speed SPI controller
>>>   
>>>   maintainers:
>>> +
>>
>> Drop blank line.
> will fix in  v2.
> 
>>
>>> +  - William Zhang <william.zhang@broadcom.com>
>>> +  - Kursad Oney <kursad.oney@broadcom.com>
>>>     - Jonas Gorski <jonas.gorski@gmail.com>
>>
>>>   
>>> +description: |
>>> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
>>> +  early MIPS based chips such as BCM6328 and BCM63268.  This controller was
>>> +  carried over to recent ARM based chips, such as BCM63138, BCM4908 and BCM6858.
>>> +
>>> +  It has a limitation that can not keep the chip select line active between
>>> +  the SPI transfers within the same SPI message. This can terminate the
>>> +  transaction to some SPI devices prematurely. The issue can be worked around by
>>> +  either the controller's prepend mode or using the dummy chip select
>>> +  workaround. This controller uses the compatible string brcm,bcm6328-hsspi.
>>> +
>>> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
>>> +  controller that add the capability to allow the driver to control chip select
>>> +  explicitly. This solves the issue in the old controller. This new controller
>>> +  uses the compatible string brcm,bcmbca-hsspi.
>>> +
>>>   properties:
>>>     compatible:
>>> -    const: brcm,bcm6328-hsspi
>>> +    enum:
>>> +      - brcm,bcm6328-hsspi
>>> +      - brcm,bcmbca-hsspi
>>
>> bca seems quite unspecific. Your description above mentions several
>> model numbers and "bca" is not listed as model. Compatibles cannot be
>> generic.
> "bca" is not model number, rather it is a group (broadband carrier 
> access) of chip that share the same spi host controller IP. Agree it is 
> not particularly specific but it differentiate from other broadcom spi 
> controller ip used by other groups.  We just don't have a specific name 
> for this spi host controller but can we treat bcmbca as the ip name? 

No, it is discouraged in such forms. Family or IP block compatibles
should be prepended with a specific compatible. There were many issues
when people insisted on generic or family compatibles...

> Otherwise we will have to have a compatible string with chip model for 
> each SoC even they share the same IP. We already have more than ten of 
> SoCs and the list will increase.  I don't see this is a good solution too.

You will have to do it anyway even with generic fallback, so I don't get
what is here to gain... I also don't get why Broadcom should be here
special, different than others. Why it is not a good solution for
Broadcom SoCs but it is for others?



> 
>>
>>>   
>>>     reg:
>>> -    maxItems: 1
>>> +    items:
>>> +      - description: main registers
>>> +      - description: miscellaneous control registers
>>> +    minItems: 1
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: hsspi
>>> +      - const: spim-ctrl
>>
>> This does not match reg
> Do you mean it does not match the description?

No. reg can be 1 item but you state reg-names cannot. These are always
the same. If one is 1 item, second is as well.

>>
>>>   
>>>     clocks:
>>>       items:
>>> -      - description: spi master reference clock
>>> -      - description: spi master pll clock
>>> +      - description: SPI master reference clock
>>> +      - description: SPI master pll clock
>>
>> Really? You just added it in previous patch, didn't you?
> The previous patch was just word to word conversion of the text file.  I 
> will update that patch to include this change.
> 
>>
>>>   
>>>     clock-names:
>>>       items:
>>> @@ -29,12 +58,43 @@ properties:
>>>     interrupts:
>>>       maxItems: 1
>>>   
>>> +  brcm,use-cs-workaround:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description: |
>>> +      Enable dummy chip select workaround for SPI transfers that can not be
>>> +      supported by the default controller's prepend mode, i.e. delay or cs
>>> +      change needed between SPI transfers.
>>
>> You need to describe what is the workaround.
> Will do.
>>
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>>     - clocks
>>>     - clock-names
>>> -  - interrupts
>>> +
>>> +allOf:
>>> +  - $ref: "spi-controller.yaml#"
>>
>> No quotes. How this is related to this patch?
> Will remove quote and put it in patch 1.
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - brcm,bcm6328-hsspi
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 1
>>
>> Drop.
>>
>> reg-names now do not match.
> Don't quite understand your comment. What do I need to drop and what is 
> not matched?

You need to add constraints for reg-names, same way as for reg.
Disallowing the reg-names also could work, but there won't be benefit in
it. Better to have uniform DTS.

> 
Best regards,
Krzysztof

