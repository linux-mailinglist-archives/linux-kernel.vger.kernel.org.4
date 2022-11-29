Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2963C5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiK2Q7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiK2Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:59:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D16716E4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:54:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so22958911lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPP5M8nm64GW+AqhpAjDLIzUD1IRtALSKI3rciCxMCg=;
        b=N/WWddMcTIxfxjPDL2zeasXG7QIhK0D0LbS0jO/30Zd0uWwXJoMNqwJ+VaO5T35WmO
         YgH9g+/XrUh7HuZyodVn3oCyrXtQYKb8lri9aH22/bcw9UEO1mMx88QezreupIrSaui4
         2dsr22JT0bcPjvIuQY9fiYbakS2CZVfwXJIOYOzF8YbpNzYTf22PpDdRWZ5b0mZkaGXq
         /3b3dOauQlfrPI2MNGmLEzFWA6BD9t422FJJhH2HycZg8UABTd0NLw4edOxFOi31mhBk
         fOYwqy4fXGShNOCf8HawSjotSw6Rb63Cxk2qdVjJmCaOKLgYGb5fzyFJLIb6oW8IMh1t
         7TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPP5M8nm64GW+AqhpAjDLIzUD1IRtALSKI3rciCxMCg=;
        b=e7b/cObYCEyG5q+jKs2jAdqmu8Vtz5nEcU+fa90QAY63HETfLbkdMZ5Lhxbur8ANfJ
         MzwwDdo3fbUFJi/jYeB9Gm5G2+yWieVGFYGFRMV5cTaOxx+GosEuvtiGA3OFSytR7zBl
         bgcSlK7zv/aQoxJrV1wYfRsLn272zyEtMiG5nlTe/mB+rSfoiOx6QgIgmVkP0JdFnfb6
         VOnQCbZX9kKs/UJ874Vd9HhCR1FRegFn+Yr1QnRj6nrQhPvgJtJ4begxr2HZzquHehFq
         rwWrpZS7CKzZMxS+o/siFmSpGem/APFTqENDy5fcxPMHWdf0LxLElS+yzKX3YTRVnWR1
         3mLQ==
X-Gm-Message-State: ANoB5pnGQ7j0P3F2jUXusg4TEzTeKxZ483R/6RU3p+vriyV/PvKCO6BN
        9d/jiwBfNK19U+QjDvJ0vW8dBw==
X-Google-Smtp-Source: AA0mqf7vtzQqNUNhEEIBlVMZhby5QrpufE0j4tOFvXeQEdaJoKxxtvrGJi8QNjObZYnYVUoyaGi79A==
X-Received: by 2002:a19:ca06:0:b0:4b5:29fd:a58b with SMTP id a6-20020a19ca06000000b004b529fda58bmr1026858lfg.591.1669740893900;
        Tue, 29 Nov 2022 08:54:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m30-20020ac24ade000000b004947f8b6266sm2266620lfp.203.2022.11.29.08.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:54:53 -0800 (PST)
Message-ID: <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
Date:   Tue, 29 Nov 2022 17:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for
 worldsemi,ws2812b-spi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129140955.137361-3-gch981213@gmail.com>
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

On 29/11/2022 15:09, Chuanhong Guo wrote:
> This patch adds dt binding schema for WorldSemi WS2812B driven using SPI
> bus.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  .../bindings/leds/worldsemi,ws2812b-spi.yaml  | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml
> new file mode 100644
> index 000000000000..8544bde4f261
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b-spi.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b-spi.yaml#
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
> +  This driver simulates the protocol used by this LED chip with SPI bus.

Drop references to Linux driver, unless important for the binding.

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
> +    const: worldsemi,ws2812b-spi

Drop "-spi". Compatibles are not supposed to include bus information.
The same for file name.

> +
> +  reg:
> +    description: The chip-select line on the SPI bus

Drop description, it's obvious.

> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Maximum SPI clocking speed of the device in Hz.

No need for ref and description. It comes from spi-peripheral-props.

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
> +  "^multi-led(@[0-9a-f])?$":

Why unit address is optional?

> +    type: object
> +    $ref: leds-class-multicolor.yaml#

    unevaluatedProperties: false

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
> +        minItems: 3

Drop minItems.... but see comment below:

> +        maxItems: 3

Why this is different than other multi-color LEDs? I would expect here
children with common.yaml.

> +
> +      default-intensity:
> +        description: |
> +          An array of 3 integer specifying the default intensity of each color
> +          components in this LED. <255 255 255> if unspecified.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 3

Drop minItems.... but:

> +        maxItems: 3
> +        items:
> +          minimum: 0
> +          maximum: 255

default: 255

What controls the intensity? Don't you have PWM there?

> +
> +      reg:
> +        description: |
> +          Which LED this node represents. The reg of the first LED on the chain
> +          is 0.

maxItems: 1

> +
> +    required:
> +      - reg
> +      - color
> +      - function
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ws2812b@0 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "worldsemi,ws2812b-spi";
> +            reg = <0>;

compatible is first property, reg is second.


Best regards,
Krzysztof

