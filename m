Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF4663CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbjAJJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjAJJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:24:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC62551CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:24:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so6466216wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg4fJCUnoSRlzXyJ1LMz44RFvLFOb8lmc5mvIzP913c=;
        b=xupfoX0UCmEZzwH4NFlC1gg2k0EYuEf6kQJG/reO4r3KrOtwptqzbgJgX+xtTGxwfl
         UNiA5gXcflfOhunahXenuXu9dcqZICXnmlOuNltuQ6m0jMlvjVX7+OvfkJxFN6Djc9LQ
         UAhOf/OAJ51nndsFPQvhcfDG06kPCE3vG+PRxDcwBa9K+LgIPEDcLJNkBBvBImjMdD20
         QonVec4iV3uzGTnp8387qHqyZhyVXrP/C+654nMDrrXOVPcsT8O+0tPPoz0sV11YgyrI
         qKVHJrB6+7GL7eFQl8zQxQOHZnZGRvj3DnGVSOCdXlV3wNEr2o8MgmG3ba58kTcDucL1
         e6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg4fJCUnoSRlzXyJ1LMz44RFvLFOb8lmc5mvIzP913c=;
        b=ZFXTjaEgD8uNtnoGcuDiifJQtApWXZf9LoiVoeG5xnUU8boZN4VVNhw655dBkmI5O8
         1z2MMp22Lzss5oCH4ZNJpcFNxb4TuA7CwVF5ujbqTJSKxvdct/f258JvsInSksk0gIxA
         hhXPItShKiawdYgEVA1oN8+/f407p+qvT3b9QV/N3uSw5aGUfYQcJxq1pNcd67vinPPB
         htvhvEa7aZqjK2xkX2vZlJ9ZveKrNgSF7smlRXPs5Saqru7v55ltXd6biVOM9kooiwcE
         rHJEc+Ny4YwR733zXWjfZaMnC8qnqDU9vT1v/JBYhF6AaGHZNFFruqCjqbL2yQDRptsY
         7Dpg==
X-Gm-Message-State: AFqh2kqLDIuqn0woe2lS5e25kNBvuBvaFjTfSKvVLbbtvS9KweTcYYFI
        W7sSa9VJ2v0Y5IZ4R/CgJvR/ng==
X-Google-Smtp-Source: AMrXdXsxIpgTgO5wi29paeZAIOBhOnmuRUnR/9hWFGJmj+KWHOH1/sA1ITsKjYE5SrFGae9VxQR+Jg==
X-Received: by 2002:a05:600c:18a1:b0:3d2:3ec4:7eed with SMTP id x33-20020a05600c18a100b003d23ec47eedmr52097609wmp.10.1673342642915;
        Tue, 10 Jan 2023 01:24:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003d34faca949sm14342269wmb.39.2023.01.10.01.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:24:02 -0800 (PST)
Message-ID: <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org>
Date:   Tue, 10 Jan 2023 10:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Chuanhong Guo <gch981213@gmail.com>,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221212045558.69602-1-gch981213@gmail.com>
 <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
 <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
 <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org>
 <Y7xGUiWBKIAm9YFA@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7xGUiWBKIAm9YFA@google.com>
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

On 09/01/2023 17:52, Lee Jones wrote:
> On Sat, 24 Dec 2022, Krzysztof Kozlowski wrote:
> 
>> On 23/12/2022 18:19, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> Add dt binding schema for WorldSemi WS2812B driven using SPI
>>>>> bus.
>>>>>
>>>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>>>>> ---
>>>>> Changes since v1:
>>>>> remove linux driver reference from description
>>>>> remove some obvious descriptions
>>>>> fix unit address regex in multi-led property
>>>>> drop various minItems
>>>>> add maxItems = 1 to reg
>>>>> fix node names and property orders in binding example
>>>>> drop -spi from compatible string
>>>>> add default-brightness
>>>>>
>>>>> Change since v2:
>>>>> drop "this patch" from commit message
>>>>> rename leds to led-controller
>>>>> drop default-brightness and default-intensity
>>>>>
>>>>> Change since v3:
>>>>> reword commit title
>>>>>
>>>>>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
>>>>>  1 file changed, 116 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..548c05ac3d31
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>>> @@ -0,0 +1,116 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: WS2812B LEDs driven using SPI
>>>>> +
>>>>> +maintainers:
>>>>> +  - Chuanhong Guo <gch981213@gmail.com>
>>>>> +
>>>>> +description: |
>>>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
>>>>> +  together and controlled individually using a single wire.
>>>>> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
>>>>> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
>>>>> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
>>>>> +  for the data pin.
>>>>> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
>>>>> +  and the controller needs to send all the bytes continuously.
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: worldsemi,ws2812b
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  spi-max-frequency:
>>>>> +    minimum: 2105000
>>>>> +    maximum: 2850000
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^multi-led@[0-9a-f]+$":
>>>>> +    type: object
>>>>> +    $ref: leds-class-multicolor.yaml#
>>>>> +    unevaluatedProperties: false
>>>>> +
>>>>> +    properties:
>>>>> +      color-index:
> 
> Why "index"?
> 
> Isn't it just an array of colours rather than an index into something?

Yeah.

> 
>>>>> +        description: |
>>>>> +          A 3-item array specifying color of each components in this LED. It
> 
> Why are you forcing this to 3?
> 
> Surely there are multi-colour LEDs containing more or less colours?

For this device, because it has only tuples of three.

> 
>>>>> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
>>>>> +          header include/dt-bindings/leds/common.h. Defaults to
> 
> Isn't "include" a Linuxisum?

No, better to have full paths, so automated tools can validate them. If
we ever decide to drop it, we can also make a easier search&replace for
the pattern starting with include/.

> 
>>>>> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
>>>>> +          if unspecified.
>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>> +        maxItems: 3
>>>>
>>>> In general I am fine with it, although there is still question for
>>>> adding more multi-color defines in binding headers to replace this
>>>> property - GRB/RBG/GBR and even more for RGBW.
>>>>
>>>> Pavel, Lee, any thoughts from your side?
>>>
>>> This really needs to mention the name this hardware is known as -- I
>>> believe it is NeoPixel.
>>
>> We wait here for feedback on colors... The binding is re-implementing
>> color, just because of combinations GRB/RBG/GBR, which could be achieved
>> with new color defines.
> 
> Sure, but where does that end?
> 
> How many permutations are there likely to be?

For light emitting devices, RGB seems to be used for so long, that I
don't expect more permutations (e.g. CMY). On the other hand, someone
might create LED strip with whatever colors, so maybe indeed better to
allow any variations as in array.

> An unlimited array has more of a chance of standing the test of time.


Best regards,
Krzysztof

