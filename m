Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B56416A8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLCMZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 07:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLCMZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 07:25:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FCEB4A9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 04:25:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so11445165lfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwSyqwMrqrfu5+iUWNYzC2nuUqa64qi42sFtQj9PwvI=;
        b=VCyv+3d27kBLhKGX9jxgmtiPVmQF6JwKORk4eVgQheDTEH8w3JTBpwh5FwFoMRqhm0
         x2djCBEv/3/dxW3LwYBvBaEMz03x1g7hCbf3xyyRAPOCU/XkRfRo2HynDlw3P/hs64UH
         xQvQd01q8HK27q5fAM7uSOIuMX3jgeWkO38TM+4FeTZmmOWg6Hwj+lmBL2U+kYXB9SQq
         kZZVjP0W1ZWoKaxwfV0Um1wQC+wI6F3tpCeNleiMMqmEpecZh5AgxTLy+JpqFzYQsHTb
         niMlUBZEgjgQBQ7crZ0wFwd6gxah8hiAuOcXjRualZbz6azICQls5tSQDpdU7AgZjv/w
         cPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwSyqwMrqrfu5+iUWNYzC2nuUqa64qi42sFtQj9PwvI=;
        b=nZWcqVlaVIScUuKAOawbwbhF5vnVWxTf0uIykErT3Bc5BPa1vQmQE4LhNuoQfIQqvs
         BzzwmtN2zN+Il7Tbz4VkMjdfTZVEu3pBAItxZMXVNlJEnCIvbJJS0o12Ms3X1GqiimC1
         8QPyrOSasjXNNbzGqS0brxjmF2egdBkcvU35mPfdvrlQV9IUJhrEkpuriNbaQbn022g0
         IqzZD5T8FdaEX/+Rr44HRjyOU+nV7APPCCIjCcwAqJLhGn2XvYCK0MUD04muOvovRcQy
         BP5JctcJ6y+S/e55TsDhhmo3tWFJep/7WBQquH3787Q5OF/5Qz0xe4pjJOGz3dfzNOiA
         a1SQ==
X-Gm-Message-State: ANoB5plZ9rWiqbs1l1jBzIymxT1W7qqWR9gkTRAj6DjAk0gggF+JuZE9
        xZAKTqzXzS90aiMr4RZV27koHg==
X-Google-Smtp-Source: AA0mqf5DFmukO5xtLWbUtNv4B2+qvLLV4rqxjVHTkkEEzcDCtp/Waa2l/ufMTOfMZro9HbxdJX8BOw==
X-Received: by 2002:a05:6512:a93:b0:4a2:6337:872d with SMTP id m19-20020a0565120a9300b004a26337872dmr19950566lfu.35.1670070339102;
        Sat, 03 Dec 2022 04:25:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u11-20020a2e9b0b000000b0027712379ec8sm854541lji.28.2022.12.03.04.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Dec 2022 04:25:38 -0800 (PST)
Message-ID: <b4f881aa-a0a6-1ee1-5346-cfc31ab6c1e7@linaro.org>
Date:   Sat, 3 Dec 2022 13:25:37 +0100
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
 <783fd2ff-cf7a-d820-6be7-9863e1786349@linaro.org>
 <CAJsYDVLuXG9UiOixxs997QdfeQVitFhhRDRbJ-uQ4Agz7LuMAQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJsYDVLuXG9UiOixxs997QdfeQVitFhhRDRbJ-uQ4Agz7LuMAQ@mail.gmail.com>
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

On 03/12/2022 13:11, Chuanhong Guo wrote:
> Hi!
> 
> On Sat, Dec 3, 2022 at 6:52 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/12/2022 13:55, Chuanhong Guo wrote:
>>>>> +
>>>>> +      default-brightness:
>>>>> +        description:
>>>>> +          The default brightness that should be applied to the LED by the operating
>>>>> +          system on start-up. The brightness should not exceed the brightness the
>>>>> +          LED can provide.
>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +        minimum: 0
>>>>> +        maximum: 255
>>>>> +        default: 0
>>>>> +
>>>>> +      default-intensity:
>>>>> +        description: |
>>>>> +          An array of 3 integer specifying the default intensity of each color
>>>>> +          components in this LED. <255 255 255> if unspecified.
>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>
>>>> I am still not convinced these two properties are correct. Why this LED
>>>> is special and defines default brightness and intensity and other LEDs
>>>> do not? You explained you are doing it for user-space which is usually
>>>> not a valid reason for changes specific to one binding. Either all
>>>> bindings should support it or none.
>>>
>>> There's already a default-state for simple LEDs without brightness
>>> control so I think it makes sense to add default-brightness for LEDs
>>> with brightness control and default-intensity for colored LEDs.
>>> The default-state seems to be implemented in various LED drivers,
>>> so I implemented these two properties in my LED driver.
>>> There's nothing device-specific about these two properties.
>>
>> default-state has a bit different purpose - to prevent any
>> glitches/changes when probing driver.
> 
> OK. I didn't know that property is used in this way.
> I can live without them. I'll drop it in the next version.
> 
>>
>>>>
>>>>> +        maxItems: 3
>>>>> +        items:
>>>>> +          minimum: 0
>>>>> +          maximum: 255
>>>>> +
>>>>> +      reg:
>>>>> +        description: |
>>>>> +          Which LED this node represents. The reg of the first LED on the chain
>>>>> +          is 0.
>>>>> +        maxItems: 1
>>>>> +
>>>>> +    required:
>>>>> +      - reg
>>>>> +      - color
>>>>> +      - function
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/leds/common.h>
>>>>> +    spi {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        leds@0 {
>>>>
>>>> git grep leds@ -- Documentation/devicetree/ | wc -l
>>>> 1
>>>> git grep led@ -- Documentation/devicetree/ | wc -l
>>>> 165
>>>>
>>>> so rather not the first one ("leds").
>>>
>>> As you can see, this node describes a chain of LEDs, not
>>> a single LED, so the plural form is more appropriate than
>>> the singular form.
>>>
>>>>
>>>> There is also:
>>>> git grep led-controller@ -- Documentation/devicetree/ | wc -l
>>>> 30
>>>
>>> This also isn't appropriate. WS2812B is a single LED package
>>> of 3 diodes and a microcontroller. If we treat every package
>>> as a LED, the SPI MOSI is connected directly to the LED
>>> packages themselves with no controller in between.
>>> If we treat the microcontroller as a led-controller, every
>>> LED contains its own controller, instead of one controller
>>> controlling all LEDs, and the parent node still shouldn't
>>> be called a led-controller.
>>>
>>> Here's a picture of the WS2812B LED package:
>>> https://cdn-shop.adafruit.com/970x728/1655-00.jpg
>>> and a chain of them:
>>> https://cdn-shop.adafruit.com/970x728/1463-00.jpg
>>
>> Then your bindings and DTS do not represent the hardware.
> 
> How should this hardware be represented, then?
> 
> The connection can be:
> 
> SPI-MOSI---LED1---LED2---LED3---...---LEDN
> 
> or
> 
> SPI-MOSI---Tri-state signal gate---LED1---LED2---LED3---...---LEDN
> SPI-CS-----|

I would look at it this as either of:
1. serially linked separate LED controllers (so multiple device nodes)

2. one LED controller handling the entire LED system of many
sub-controllers.

For the (2) I proposed the name led-controller. If you think this is not
(2), then looks like (1) and you should have many devices... which
probably is not doable on itself. And how to call this entire set of
separate LED controllers? Heh, can be also some controller, like
led-controller.

Best regards,
Krzysztof

