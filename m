Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B177649A82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiLLI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiLLI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:56:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AAB6D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:56:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so17427988lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QdvuUyS+6CWEm93IiNhP+hlhAXaHYJrxB4vuciAs1s=;
        b=GR01tUm7ffyceoIwnCnYkv1qFr/OOJetI0ZTc8QVmvp+qLB8Dhm2cfnO0Uv63Bm+J2
         KI9SBFqezS4Uo9/JLqoBtHLiadnZIiutz0S+0zQNqsqLxUJqOjlLUSETkN//C0FtnMVJ
         lF+P8himJ6dWzQLHIHXizTqEfcGF4lQH4LW0TkdN/splysgemCJPrlWpzWwUwGsj4GTq
         /SoGiBkOu5SStPXI73/vi9/eUbPTFdN7em0/BiVZbqbQmrYPpMQ5iwHD4Ot5odEYzxcP
         ldz1a0W64oh9cioYJ/X1BxbOe8zqyiOvUEw5jWrNKuvYdjxsetl1I5RE3PSheZCK9diI
         YV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QdvuUyS+6CWEm93IiNhP+hlhAXaHYJrxB4vuciAs1s=;
        b=EXgbsDf0Xl1nXycDnD5aL2jo+ccAqMR+mywH7uuxsez74CuORm0x5j334038HgIT6+
         2mwepp/9H/6d+LX3Yf0lyJWgtFsVlWMZ0ulFbFysqevCVVy+iTFyeu6/UnA8R18K/gKY
         6sMN5IjW+QH/1Z81CKsb5T1m1Qy6ZfDVFzIDrxY8h3xE8ABA36RLS+UXLuEomUS4r4EU
         EwpGJHc9w1R1Rh7/1pnD5URMaCVbZtkfj98w/rw2xummB001p+DHZujCf2+qhGoflcL/
         TS9XFZ6SP1ArsY0504pfJM2ISzc/UP8RQepHmuSC3sxqPMRP21FKzeYK9yp/dFE4cdip
         6rWw==
X-Gm-Message-State: ANoB5plr+sSDKuZ/2mtRauj8d+HhefDwdiLnswAhCEw3mhjk7ZHlxYLP
        rsC02X7fKJIvw9O1RQgEahNJmQ==
X-Google-Smtp-Source: AA0mqf4KMzDBXw3GpK3cmEv0n839Lx+uhrj/I437niP4N28oe3+cSmv2GHnbgFFIprLLCYmPQ4IRyQ==
X-Received: by 2002:a05:6512:15a6:b0:4b4:b5bf:3ce6 with SMTP id bp38-20020a05651215a600b004b4b5bf3ce6mr7288585lfb.38.1670835408063;
        Mon, 12 Dec 2022 00:56:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id cf31-20020a056512281f00b0049465afdd38sm1563922lfb.108.2022.12.12.00.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 00:56:47 -0800 (PST)
Message-ID: <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
Date:   Mon, 12 Dec 2022 09:56:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221212045558.69602-3-gch981213@gmail.com>
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

On 12/12/2022 05:55, Chuanhong Guo wrote:
> Add dt binding schema for WorldSemi WS2812B driven using SPI
> bus.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Changes since v1:
> remove linux driver reference from description
> remove some obvious descriptions
> fix unit address regex in multi-led property
> drop various minItems
> add maxItems = 1 to reg
> fix node names and property orders in binding example
> drop -spi from compatible string
> add default-brightness
> 
> Change since v2:
> drop "this patch" from commit message
> rename leds to led-controller
> drop default-brightness and default-intensity
> 
> Change since v3:
> reword commit title
> 
>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> new file mode 100644
> index 000000000000..548c05ac3d31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: WS2812B LEDs driven using SPI
> +
> +maintainers:
> +  - Chuanhong Guo <gch981213@gmail.com>
> +
> +description: |
> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> +  together and controlled individually using a single wire.
> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
> +  for the data pin.
> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
> +  and the controller needs to send all the bytes continuously.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: worldsemi,ws2812b
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    minimum: 2105000
> +    maximum: 2850000
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^multi-led@[0-9a-f]+$":
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      color-index:
> +        description: |
> +          A 3-item array specifying color of each components in this LED. It
> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
> +          header include/dt-bindings/leds/common.h. Defaults to
> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> +          if unspecified.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        maxItems: 3

In general I am fine with it, although there is still question for
adding more multi-color defines in binding headers to replace this
property - GRB/RBG/GBR and even more for RGBW.

Pavel, Lee, any thoughts from your side?

Best regards,
Krzysztof

