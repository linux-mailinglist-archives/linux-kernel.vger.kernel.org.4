Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F663D168
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiK3JIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiK3JIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:08:16 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FB317D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:08:15 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h10so3433578ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bik6TT2i9Vj5K+t2eRzxUcLiyFVx0MQXz0h6XwsVogM=;
        b=mPmMPUZxuC7l/Tcc+dBgioqnRaRa0D0FoqaQOYbwN8D3+FCZ3IUnDD7bwzz7fYnTvk
         3yl53k+4nj+2z5v/UckpqtYIuxeMH2K1EUbin2EN55rHMJSG4RcWyYjZ3HjWdJyXAax6
         eQsG5XFz3aBdRKOLQ9SXoJnmcytpOp+M9yaFDbkSv5J6ommalxFqSVBR9bqos31KC6av
         XiA+sy4Wgae/zF/dLx7rMo+CionAk+pTQkdAF5HU4g15Stpvuq44dhbDeIe9aAi2CqHE
         iEpesI6VZcENQfWmXptocflcjfB50mJtMJ3G8iJA9iRGlFOd3W5/KcGNBmdGbf8YcXFL
         gnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bik6TT2i9Vj5K+t2eRzxUcLiyFVx0MQXz0h6XwsVogM=;
        b=ZqzR/VKx8mhbYxDHJqvEXOdzjMwXdG5yPp6i5gsCzIH1RwFK45gtjZwoafN9D2cPPg
         jAIN8R5lvzyR7vFfilnfaxBQWU3Ws+qJnZgH4Ogwv5/tMlJXs8CYYM1E1zWaD30T6tOe
         vIeypZfc4iQT0hd5UCFVdrAE6XnsEbfPW/vacbVyOHb3XjwGabcfUFVrOrxJhQWhf1u5
         0BbEEwLZxzUehllDFQu2WR80Hn9gwIZJbAE/tRYfFeKEgwY5Rv+2JjvPTUnbhgdYXYJP
         kWJYhvhC5j9r1sbyvDpiNrKhq9TyU3VUtWsbYGQFL3R9NwqHZj2nuFz/VjVm5wGF9ZzD
         touw==
X-Gm-Message-State: ANoB5pnZDdoW3j5/+D/7YdLZkI3XVnirwwmk80Ks+S+/YGoYSV0Xd0QM
        iy1ax06c+qf+ePTT/tukNUfQwQ==
X-Google-Smtp-Source: AA0mqf6NCA6yu+P9dbo+rNNBrMl51Mjly+oRbmjw0M3xfZDbotMi0I3GxWkQgayN0qBz2BQ5RpkEiw==
X-Received: by 2002:a05:651c:10a1:b0:279:8211:d8fa with SMTP id k1-20020a05651c10a100b002798211d8famr9472031ljn.448.1669799293648;
        Wed, 30 Nov 2022 01:08:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t15-20020a056512208f00b004b4ec76016esm176696lfr.113.2022.11.30.01.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:08:12 -0800 (PST)
Message-ID: <7b3f97f9-34af-413c-aaad-9108b4f36c51@linaro.org>
Date:   Wed, 30 Nov 2022 10:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for
 worldsemi,ws2812b-spi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
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
References: <20221129140955.137361-1-gch981213@gmail.com>
 <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
 <CAJsYDVJknDWKMW1tH0M=85tJOPG-HngxhhMzvJpk5qn_Q9mzAg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJsYDVJknDWKMW1tH0M=85tJOPG-HngxhhMzvJpk5qn_Q9mzAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 09:36, Chuanhong Guo wrote:
> Hi!
> 
> On Wed, Nov 30, 2022 at 12:54 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>> +description: |
>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
>>> +  together and controlled individually using a single wire.
>>> +  This driver simulates the protocol used by this LED chip with SPI bus.
>>
>> Drop references to Linux driver, unless important for the binding.
> 
> I think the SPI part is important. (I'll explain it below.) What about:
> 
> This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
> 
> instead?

OK

> 
>>> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
>>> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
>>> +  for the data pin.
>>> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
>>> +  and the controller needs to send all the bytes continuously.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: worldsemi,ws2812b-spi
>>
>> Drop "-spi". Compatibles are not supposed to include bus information.
>> The same for file name.
> 
> WS2812B isn't a SPI chip. It's controlled with only a single wire and
> can be driven
> using anything that can produce a long and a short pulse meeting its timing
> requirement.
> This driver uses a SPI bus to send the pulses, but it can also be
> controlled with
> I2S and the PIO pins on a Raspberry Pi Pico.
> This spi suffix is to distinguish it from other possible
> implementations if someone
> else submits a support with a different peripheral.

And that's exactly what I said - the compatibles should not include bus
information. The bus information comes from... the bus!

> 
>>
>>> +
>>> +  reg:
>>> +    description: The chip-select line on the SPI bus
>>
>> Drop description, it's obvious.
> 
> OK.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  spi-max-frequency:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Maximum SPI clocking speed of the device in Hz.
>>
>> No need for ref and description. It comes from spi-peripheral-props.
> 
> OK.
> 
>>
>>> +    minimum: 2105000
>>> +    maximum: 2850000
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^multi-led(@[0-9a-f])?$":
>>
>> Why unit address is optional?
> 
> It isn't. I copy-pasted it from led-class-multicolor.yaml and
> didn't check the exact regex.
> I'll fix it in the next version.

Make it required and matching your case.

> 
>>
>>> +    type: object
>>> +    $ref: leds-class-multicolor.yaml#
>>
>>     unevaluatedProperties: false
> 
> OK.
> 
>>> +
>>> +    properties:
>>> +      color-index:
>>> +        description: |
>>> +          A 3-item array specifying color of each components in this LED. It
>>> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
>>> +          header include/dt-bindings/leds/common.h. Defaults to
>>> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
>>> +          if unspecified.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        minItems: 3
>>
>> Drop minItems.... but see comment below:
>>
>>> +        maxItems: 3
>>
>> Why this is different than other multi-color LEDs? I would expect here
>> children with common.yaml.
> 
> WS2812B is a single LED package with 3 diodes and a microcontroller.
> Each LED package has 3 colors. The original chip comes with GRB
> color while there are some clones with RGB arrangement instead.
> The LED chain can be really long so I'd like to simplify the binding
> by using a single property to override the only variable, color, here.

OK, that makes sense.

> 
>>
>>> +
>>> +      default-intensity:
>>> +        description: |
>>> +          An array of 3 integer specifying the default intensity of each color
>>> +          components in this LED. <255 255 255> if unspecified.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        minItems: 3
>>
>> Drop minItems.... but:
>>
>>> +        maxItems: 3
>>> +        items:
>>> +          minimum: 0
>>> +          maximum: 255
>>
>> default: 255
>>
>> What controls the intensity? Don't you have PWM there?
> 
> The LED takes 3-byte brightness value of each color. This property is used to
> specify the default multi_intensity field for the multi-color LED. The final
> brightness value is calculated with led_mc_calc_color_components like this:
> 
> mcled_cdev->subled_info[i].brightness = brightness *
> mcled_cdev->subled_info[i].intensity / led_cdev->max_brightness;
> 
> The LED chip takes exactly 8 bits for the brightness (max_brightness = 255
> which can't be changed.), so according to the formula above the maximum
> intensity should be 255.

So this is brightness of each color... why insisting on calling it
differently?

Best regards,
Krzysztof

