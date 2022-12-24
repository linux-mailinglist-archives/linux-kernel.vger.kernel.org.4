Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A3655A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiLXMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:54:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB976D100
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:53:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so10343144lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zv9IznoKeqq4XhdztR/BEG3Np/4v5us6ivTnhTur1yY=;
        b=VEhDA7Skf/Euj6CB+4WOCDIlaiEh0+vrmGApjwwGSqvB0tFz/UXpDq0ZiY4SYLaGW7
         F+RlU2Tv3bcdEnYc/wfC/3+iq8KSub7YapZDDv/NbMQndGiukFR+ngew9IuA8LRZ85yO
         zO5uuoASGTB7c/KJ5vySrRPIXE1aPQEcwdEyDnEMRm0elCf5sbEbs3GUIMaFnTZn7+FJ
         ZeJJmbqTCSWxDiZWPEcam5KztnZnB4KO+ENgQwIjCEJAJMMyDD59ShhSDVRFPXn61Xh9
         TjwT86HXVR1Hw0ziAJ6TjlWpHchzxGc3JO20eHOl5BHtbpDDe0TBQZ6hetr4nmlQJV8J
         b+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv9IznoKeqq4XhdztR/BEG3Np/4v5us6ivTnhTur1yY=;
        b=KpVxXqvUjqJ0WP1Qd0lAEEyD7ozTL8R/sWZijzeTvh1rGDhzD7p2HeM8wYCTVwA3ZU
         GRhxtQDGdSqRYV8vikwtJHyN7wgM1s/GisInAO2N+0ak38Pjrynh9SpJBm12//V07vcc
         +6cDim0GFCfVMI/jJ7ZekI1ePgLRFUvpNmQJuXEQX0FZpO2q/WLZCHD+/CW+xCTf3TEa
         J7CUom7zDam7c/fdc/qst45RP0393iAPd9xByf4FBP6VWXt955rNRszS8bxt3+AfyT4/
         V5BZVumWF+SxkMe08lXVNmZ3A7IK4Vl7DDc/aNeLyLWcVroPyMZoHIcsUziRCMoYpFDk
         xb7g==
X-Gm-Message-State: AFqh2krwP8ySE8FiqUT+txI9z9yCjkUal1xl8EzImt/57Mgl+yEVUIvZ
        ucaffBdypPMwlM8348y7x0BQng==
X-Google-Smtp-Source: AMrXdXuodh9FHymbmpohqNn+aN73HnLyNMGQMfaM4A8CMcQthOis9+U3w2QaUyRVjC6UF3jQ0FdJzQ==
X-Received: by 2002:ac2:5e9d:0:b0:4b6:ec97:a629 with SMTP id b29-20020ac25e9d000000b004b6ec97a629mr3352154lfq.35.1671886438132;
        Sat, 24 Dec 2022 04:53:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x30-20020a0565123f9e00b0048a9e899693sm952658lfa.16.2022.12.24.04.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 04:53:57 -0800 (PST)
Message-ID: <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org>
Date:   Sat, 24 Dec 2022 13:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 18:19, Pavel Machek wrote:
> Hi!
> 
>>> Add dt binding schema for WorldSemi WS2812B driven using SPI
>>> bus.
>>>
>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>>> ---
>>> Changes since v1:
>>> remove linux driver reference from description
>>> remove some obvious descriptions
>>> fix unit address regex in multi-led property
>>> drop various minItems
>>> add maxItems = 1 to reg
>>> fix node names and property orders in binding example
>>> drop -spi from compatible string
>>> add default-brightness
>>>
>>> Change since v2:
>>> drop "this patch" from commit message
>>> rename leds to led-controller
>>> drop default-brightness and default-intensity
>>>
>>> Change since v3:
>>> reword commit title
>>>
>>>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
>>>  1 file changed, 116 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>> new file mode 100644
>>> index 000000000000..548c05ac3d31
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
>>> @@ -0,0 +1,116 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: WS2812B LEDs driven using SPI
>>> +
>>> +maintainers:
>>> +  - Chuanhong Guo <gch981213@gmail.com>
>>> +
>>> +description: |
>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
>>> +  together and controlled individually using a single wire.
>>> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
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
>>> +    const: worldsemi,ws2812b
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-max-frequency:
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
>>> +  "^multi-led@[0-9a-f]+$":
>>> +    type: object
>>> +    $ref: leds-class-multicolor.yaml#
>>> +    unevaluatedProperties: false
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
>>> +        maxItems: 3
>>
>> In general I am fine with it, although there is still question for
>> adding more multi-color defines in binding headers to replace this
>> property - GRB/RBG/GBR and even more for RGBW.
>>
>> Pavel, Lee, any thoughts from your side?
> 
> This really needs to mention the name this hardware is known as -- I
> believe it is NeoPixel.

We wait here for feedback on colors... The binding is re-implementing
color, just because of combinations GRB/RBG/GBR, which could be achieved
with new color defines.

Best regards,
Krzysztof

