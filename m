Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F6666E08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjALJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbjALJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:26:23 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0961ADA3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:16:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id tz12so43190720ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKR2tXKyALNq5BiHC3M8UwwfGSVJszQwrE9Cpy7GyxA=;
        b=qcfr3oUGRPmLkFvhnqk2sM0zqTxrvx8QgbhTwONUMbUZGR3JEKj2wmGfuZ8FIBIC6+
         aTckz82ae5wih36cb1CuxCOgzmzotwWXLTYEnuSTELmjnKQ01rPVMwOMxIFhIYHqaH64
         iO7178U096AMqLUA3WNLFuBnjohLrRraGWhO3CFGmWMuJzIjoaBFwBi7j5jSvHwIhd5B
         CS4Q5wdRdw54Eiwi7DV8KoqjlQ+UeowyzdUGZIcLCVq9WjGJbTf/7PcyioI2IGbA5IWl
         URRRFxlpgQAHM3JnTviBLgRKTN0+pqBsJU4vKdwR0XlKKAarZAt3f2TX0kYHNylTrfog
         bLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKR2tXKyALNq5BiHC3M8UwwfGSVJszQwrE9Cpy7GyxA=;
        b=J+l/3CG7F3okrZjwPIVPEF1Jfl0M1EPnZP7SXdaP5eZm+iZYnaDKNL1Z1Cj9YZJtL7
         6IxGaYQhG8vSbxnOAg6lEmLr4BGqv1AK5HKT5ZAWG1ZQf/We4Vha/Pp0COR3x2QWluSz
         Ikr8BouazzDVNm0dSHH9Y2gCYqZDFRhWbaD/m8P98CKx0zolS+x0E8Zf4tePSmRr7OgF
         TMAdJ2pgZSyv/bZKcEJoYKihQKnWs1hjiJUW7tEyEEvJoHcv3LGsnmQ3s6iKWAOPcdWq
         Y4DyQdShX28nT65dWZjkeKia8rzoM0wmtspTK/NZekCAA1iAun5UcYObwUz1pwRLrSf/
         035g==
X-Gm-Message-State: AFqh2kqP+LMP/wSr0Lgwsb8bbE7PvfdW3CxP97Pk7L1QMM7bvkxwBfEp
        zWlo+rJOKYzD2UYYkWgBpEljgA==
X-Google-Smtp-Source: AMrXdXsHr93+ZbXdYi8g1JbBSFkw8D4sHzKUP1p8Wt9Y0ByRiqExj1DEJ3QGEWmiaj2EtcCmRxhvjg==
X-Received: by 2002:a17:907:c202:b0:7ad:b14f:dea4 with SMTP id ti2-20020a170907c20200b007adb14fdea4mr65519714ejc.14.1673514987634;
        Thu, 12 Jan 2023 01:16:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x3-20020a170906b08300b007c0688a68cbsm7303890ejy.176.2023.01.12.01.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:16:27 -0800 (PST)
Message-ID: <1b827ded-cc34-23ae-4b60-7e7993ce659d@linaro.org>
Date:   Thu, 12 Jan 2023 10:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
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
 <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org>
 <Y708DfB41c/ZivRw@google.com>
 <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com>
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

On 11/01/2023 19:53, Chuanhong Guo wrote:
> Hi!
> 
> On Tue, Jan 10, 2023 at 6:21 PM Lee Jones <lee@kernel.org> wrote:
>>
>> On Tue, 10 Jan 2023, Krzysztof Kozlowski wrote:
>>
>>> On 09/01/2023 17:52, Lee Jones wrote:
>>>> On Sat, 24 Dec 2022, Krzysztof Kozlowski wrote:
>>>>
>>>>> On 23/12/2022 18:19, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>>> Add dt binding schema for WorldSemi WS2812B driven using SPI
>>>>>>>> bus.
>>>>>>>>
>>>>>>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>>>>>>>> ---
>>>>>>>> Changes since v1:
>>>>>>>> remove linux driver reference from description
>>>>>>>> remove some obvious descriptions
>>>>>>>> fix unit address regex in multi-led property
>>>>>>>> drop various minItems
>>>>>>>> add maxItems = 1 to reg
>>>>>>>> fix node names and property orders in binding example
>>>>>>>> drop -spi from compatible string
>>>>>>>> add default-brightness
>>>>>>>>
>>>>>>>> Change since v2:
>>>>>>>> drop "this patch" from commit message
>>>>>>>> rename leds to led-controller
>>>>>>>> drop default-brightness and default-intensity
>>>>>>>>
>>>>>>>> Change since v3:
>>>>>>>> reword commit title
>>>>>>>>
>>>>>>>>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
>>>>>>>>  1 file changed, 116 insertions(+)
>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..548c05ac3d31
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>>>>>> @@ -0,0 +1,116 @@
>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>> +%YAML 1.2
>>>>>>>> +---
>>>>>>>> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>> +
>>>>>>>> +title: WS2812B LEDs driven using SPI
>>>>>>>> +
>>>>>>>> +maintainers:
>>>>>>>> +  - Chuanhong Guo <gch981213@gmail.com>
>>>>>>>> +
>>>>>>>> +description: |
>>>>>>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
>>>>>>>> +  together and controlled individually using a single wire.
>>>>>>>> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
>>>>>>>> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
>>>>>>>> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
>>>>>>>> +  for the data pin.
>>>>>>>> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
>>>>>>>> +  and the controller needs to send all the bytes continuously.
>>>>>>>> +
>>>>>>>> +allOf:
>>>>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    const: worldsemi,ws2812b
>>>>>>>> +
>>>>>>>> +  reg:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  spi-max-frequency:
>>>>>>>> +    minimum: 2105000
>>>>>>>> +    maximum: 2850000
>>>>>>>> +
>>>>>>>> +  "#address-cells":
>>>>>>>> +    const: 1
>>>>>>>> +
>>>>>>>> +  "#size-cells":
>>>>>>>> +    const: 0
>>>>>>>> +
>>>>>>>> +patternProperties:
>>>>>>>> +  "^multi-led@[0-9a-f]+$":
>>>>>>>> +    type: object
>>>>>>>> +    $ref: leds-class-multicolor.yaml#
>>>>>>>> +    unevaluatedProperties: false
>>>>>>>> +
>>>>>>>> +    properties:
>>>>>>>> +      color-index:
>>>>
>>>> Why "index"?
>>>>
>>>> Isn't it just an array of colours rather than an index into something?
>>>
>>> Yeah.
> 
> The corresponding sysfs interface is called 'multi_index' so I called
> it this way.
> 
>>>
>>>>
>>>>>>>> +        description: |
>>>>>>>> +          A 3-item array specifying color of each components in this LED. It
>>>>
>>>> Why are you forcing this to 3?
>>>>
>>>> Surely there are multi-colour LEDs containing more or less colours?
>>>
>>> For this device, because it has only tuples of three.
> 
> WS2812B has 3 colors per chip. There are chips using a similar protocol
> with 4 colors but my current driver is hard-coded to support exactly 3 colors.
> 
>> This doesn't looks like a device specific property to me.
>>
>> If this is not going to be used by any other device, shouldn't it
>> contain a prefix?
>>
>>>>>>>> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
>>>>>>>> +          header include/dt-bindings/leds/common.h. Defaults to
>>>>
>>>> Isn't "include" a Linuxisum?
>>>
>>> No, better to have full paths, so automated tools can validate them. If
>>> we ever decide to drop it, we can also make a easier search&replace for
>>> the pattern starting with include/.
>>
>> Very well.  It's your train set. :)
>>
>>>>>>>> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
>>>>>>>> +          if unspecified.
>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>>>> +        maxItems: 3
>>>>>>>
>>>>>>> In general I am fine with it, although there is still question for
>>>>>>> adding more multi-color defines in binding headers to replace this
>>>>>>> property - GRB/RBG/GBR and even more for RGBW.
>>>>>>>
>>>>>>> Pavel, Lee, any thoughts from your side?
>>>>>>
>>>>>> This really needs to mention the name this hardware is known as -- I
>>>>>> believe it is NeoPixel.
>>>>>
>>>>> We wait here for feedback on colors... The binding is re-implementing
>>>>> color, just because of combinations GRB/RBG/GBR, which could be achieved
>>>>> with new color defines.
>>>>
>>>> Sure, but where does that end?
>>>>
>>>> How many permutations are there likely to be?
>>>
>>> For light emitting devices, RGB seems to be used for so long, that I
>>> don't expect more permutations (e.g. CMY). On the other hand, someone
>>> might create LED strip with whatever colors, so maybe indeed better to
>>> allow any variations as in array.
>>
>> Even you suggested variation: "even more for RGBW".
>>
>> Caveat: as you are well aware, "I'm new here", so my input is no more
>> informed or valuable as yours at this point.  I'm just calling it as I
>> see it.  If you have strong opinions and they differ wildly from mine,
>> we may have to take intervention from Pavel.  As it stands, the
>> property, although slightly restricted IMHO, appears fine.
>>
>>>> An unlimited array has more of a chance of standing the test of time.
> 
> I have another idea that avoids this whole conversation: Abandon
> color-index completely and determine colors with compatible string
> and platform data.
> My original idea of this property is to support WS2812B and its clones
> with different colors under the same compatible string. Technically
> genuine WS2812Bs only come with GRB colors and the clones
> should have their own chip names (e.g. xiaomi,hm0807a for an RGB
> clone and <unknown vendor>,sk6812 for an RGBW one.). It's
> reasonable to have one compatible string per chip for colors, a
> chip-specific property. Also, adding more compatible devices to a
> driver is less invasive than adding more definitions to leds/common.h
> What do you think?

This sounds good. However it should not lead to compatibles like
worldsemi,ws2812b-rgb, worldsemi,ws2812b-bgr etc.

Best regards,
Krzysztof

