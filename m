Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2864161D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLCKwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLCKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:52:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E5ADF5F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:52:45 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h10so8075161ljk.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOE4mpD8YL+gAB16izdpROoKo4vm2v2bTehR3QjiK5c=;
        b=lnyeUxxXhWfPe5PQ3l2lE9F6ZhNt5vJL1fkjjTE9ZBTaJgc2kQdVnRrYQUnjSTlvue
         +fFKTdsxcyurkp08MjubxDn4xXaj73Ll0GiaJP/GDbuSqWZYFeVmAa1iFP/EfyRmwCrk
         /RJowQerORci33UVQcO4+GUPKCjsBr/Z5W2f2dmFJnTGadvzdIzEv4n5wg8Au3jicYaL
         Ejx1kZj1/HyThTY2bTM4ax1CeABM7sY+JwsqLQ+lBqS/4x6qLgMTP7TN37dbIRTqh+gE
         oqaAnqzLvkMnIbQXqamssPYNRTALq0jjlBqsCHUMgjmAUmqh1FeglTGYeuaJy6VV5zpo
         s/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOE4mpD8YL+gAB16izdpROoKo4vm2v2bTehR3QjiK5c=;
        b=pAAkh4xk942b5PAKkhmlDXXFrbawnIRHQWcjYKTfAhPhQ2BXc4Fr2u0j215J1zdo0M
         ppBWTkAZcuqxL8tG8Po3jCgHQGA0D3qFQ+15Jav/58J1unp2eUh6MXHZeA6KpeEIXWZn
         KBQCuSA4jKUbZESOXl6oYpqdgI7O3JadpZqeMUSxiWMzGtQetixaciqVbQvyT22zinh7
         uE5ZTdRB9XT5grp6Y+NinrKksC9okwIHJCEdSHEnhwQvtNR1amlaJ4DAsCbm3dGojSCq
         UQKQ77PvJRJkCh05+eYj532TkHCIu+uHqL6gc1vmtNHE0oQSp1C+CnTOqpkn4eiY3zJM
         B++g==
X-Gm-Message-State: ANoB5pnJPQ8jJnYVfiXz55VxgCWdXDA7rcZF7uFHgUbQOFgEOnEOvDBf
        TwtTn4bWUoR6EPAa7ooLg6hzHw==
X-Google-Smtp-Source: AA0mqf7sDLhkrE1jgR17wWFRW2wPDYHPCijEAnqNWrehG/nAlJhmSTnamkFg7e/l8nkYtRikdz206Q==
X-Received: by 2002:a05:651c:50e:b0:277:1c8d:27b9 with SMTP id o14-20020a05651c050e00b002771c8d27b9mr19617514ljp.210.1670064763740;
        Sat, 03 Dec 2022 02:52:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004b4bb6286d8sm1368495lfr.84.2022.12.03.02.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Dec 2022 02:52:42 -0800 (PST)
Message-ID: <783fd2ff-cf7a-d820-6be7-9863e1786349@linaro.org>
Date:   Sat, 3 Dec 2022 11:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: add dt schema for
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
References: <20221202034240.455831-1-gch981213@gmail.com>
 <20221202034240.455831-3-gch981213@gmail.com>
 <df8a683a-0df9-c32a-4272-19e7313ef7d7@linaro.org>
 <CAJsYDVLwyCG2xnWXDo72H-T4Tk7Edxmv_GSfJFvvWKrXZgBtCA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJsYDVLwyCG2xnWXDo72H-T4Tk7Edxmv_GSfJFvvWKrXZgBtCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 13:55, Chuanhong Guo wrote:
>>> +
>>> +      default-brightness:
>>> +        description:
>>> +          The default brightness that should be applied to the LED by the operating
>>> +          system on start-up. The brightness should not exceed the brightness the
>>> +          LED can provide.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        minimum: 0
>>> +        maximum: 255
>>> +        default: 0
>>> +
>>> +      default-intensity:
>>> +        description: |
>>> +          An array of 3 integer specifying the default intensity of each color
>>> +          components in this LED. <255 255 255> if unspecified.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>
>> I am still not convinced these two properties are correct. Why this LED
>> is special and defines default brightness and intensity and other LEDs
>> do not? You explained you are doing it for user-space which is usually
>> not a valid reason for changes specific to one binding. Either all
>> bindings should support it or none.
> 
> There's already a default-state for simple LEDs without brightness
> control so I think it makes sense to add default-brightness for LEDs
> with brightness control and default-intensity for colored LEDs.
> The default-state seems to be implemented in various LED drivers,
> so I implemented these two properties in my LED driver.
> There's nothing device-specific about these two properties.

default-state has a bit different purpose - to prevent any
glitches/changes when probing driver. Other values should not be
controller by default, at least not for this specific LED. If you want
to change common LED bindings and LED maintainers agree, sure, that's
different case.

Your device does not require these default brightness/intensity
properties... or at least you did not provide rationale why your device
(not driver... you keep referring to driver for some reason) needs them.

>>
>>> +        maxItems: 3
>>> +        items:
>>> +          minimum: 0
>>> +          maximum: 255
>>> +
>>> +      reg:
>>> +        description: |
>>> +          Which LED this node represents. The reg of the first LED on the chain
>>> +          is 0.
>>> +        maxItems: 1
>>> +
>>> +    required:
>>> +      - reg
>>> +      - color
>>> +      - function
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/leds/common.h>
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        leds@0 {
>>
>> git grep leds@ -- Documentation/devicetree/ | wc -l
>> 1
>> git grep led@ -- Documentation/devicetree/ | wc -l
>> 165
>>
>> so rather not the first one ("leds").
> 
> As you can see, this node describes a chain of LEDs, not
> a single LED, so the plural form is more appropriate than
> the singular form.
> 
>>
>> There is also:
>> git grep led-controller@ -- Documentation/devicetree/ | wc -l
>> 30
> 
> This also isn't appropriate. WS2812B is a single LED package
> of 3 diodes and a microcontroller. If we treat every package
> as a LED, the SPI MOSI is connected directly to the LED
> packages themselves with no controller in between.
> If we treat the microcontroller as a led-controller, every
> LED contains its own controller, instead of one controller
> controlling all LEDs, and the parent node still shouldn't
> be called a led-controller.
> 
> Here's a picture of the WS2812B LED package:
> https://cdn-shop.adafruit.com/970x728/1655-00.jpg
> and a chain of them:
> https://cdn-shop.adafruit.com/970x728/1463-00.jpg

Then your bindings and DTS do not represent the hardware.

Best regards,
Krzysztof

