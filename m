Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DA640594
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiLBLOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiLBLOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:14:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E1CEF92
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:14:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so6954204lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kfh2uEkgJYQbt4ZY05bMmlo4I+toC+Od514z9x7yJ0k=;
        b=SkmDWVnXOjLeqsSC4ZOtRofWVZ93d6mCs/ekDDHIWFooXvfvs6MfRpGlopzHiWAlr6
         Vk4ZfEiyCFPmwf2t+Hb85BEHKcebyK5qr6DF6LU5+WvXkXPF08YdyngSQx/E2rWDf1Ut
         KJRDJ/dYf6DnvxnR+Sy3L0/eGdsRGVMqj9KcPoTBUFGCfj+WOlPh3N+t2M/AMR1ubXa5
         rmvbCly7HbX2OK87ZOjEiajksvErHyDoo90irw+OSM1cwxFikrPlXdE8BJsrCBLlV93K
         rScWtvq23c38FdMGoOBTYWNWVM4s5YieLhID7kg5qGzd3pQU9ydjbTPnqPqE8V7AcN0n
         IvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfh2uEkgJYQbt4ZY05bMmlo4I+toC+Od514z9x7yJ0k=;
        b=3WVUN7g1M0voVWeOKL/0pohb9bjipwTtlNyF5IlWHrE1Ad8uKqq3UOPDY7ORT+Oqn5
         ILJEUHtIQAcsF2xyCitLzbqHAffMTurvS3X9Jr62QeHzCaaWqrLmp6PPMYbGG/Qg3Lof
         E3mf7Ah/+s7DucvdT2Bu7Z24sda+3ymKJPsvSVr6NDpXXFqMmuCh27eeXna9dzSRMK8W
         ICWlHscazAS+zKYrXZ9Q5qKPIoz1sVjOs4jWeCkrr4kmWyMy/pTiT9wK7RXngQkUe3Uo
         YU6TRint8zIz+j6PYD8MSsL4MdDAfvoLpweS/FxNo70qeeM6w5o1fEoQNQyn3KW5rwzC
         dTPQ==
X-Gm-Message-State: ANoB5plSgjXwCY9PJJSvgPpM4heLTrt5W8YxvN9TAgJqnPEB3/Qwe+Mt
        xiahuWxi7Z6eVaLtwVgMidaYNQ==
X-Google-Smtp-Source: AA0mqf7mJhhZCg+x1t1Y5hOsdmMcgg0eIKKgvFfGcYURBsM7OgPVL6InsNZyygYH0zfQsxsaDdpGqg==
X-Received: by 2002:ac2:5326:0:b0:4b1:5bf0:df51 with SMTP id f6-20020ac25326000000b004b15bf0df51mr26269906lfh.674.1669979645249;
        Fri, 02 Dec 2022 03:14:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b004a6f66eed7fsm979178lfr.165.2022.12.02.03.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 03:14:04 -0800 (PST)
Message-ID: <df8a683a-0df9-c32a-4272-19e7313ef7d7@linaro.org>
Date:   Fri, 2 Dec 2022 12:14:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: add dt schema for
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
References: <20221202034240.455831-1-gch981213@gmail.com>
 <20221202034240.455831-3-gch981213@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202034240.455831-3-gch981213@gmail.com>
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

On 02/12/2022 04:42, Chuanhong Guo wrote:
> This patch adds dt binding schema for WorldSemi WS2812B driven using SPI
> bus.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

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
>  .../bindings/leds/worldsemi,ws2812b.yaml      | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> new file mode 100644
> index 000000000000..f91908d0acef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> @@ -0,0 +1,138 @@
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
> +
> +      default-brightness:
> +        description:
> +          The default brightness that should be applied to the LED by the operating
> +          system on start-up. The brightness should not exceed the brightness the
> +          LED can provide.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 255
> +        default: 0
> +
> +      default-intensity:
> +        description: |
> +          An array of 3 integer specifying the default intensity of each color
> +          components in this LED. <255 255 255> if unspecified.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array

I am still not convinced these two properties are correct. Why this LED
is special and defines default brightness and intensity and other LEDs
do not? You explained you are doing it for user-space which is usually
not a valid reason for changes specific to one binding. Either all
bindings should support it or none.

> +        maxItems: 3
> +        items:
> +          minimum: 0
> +          maximum: 255
> +
> +      reg:
> +        description: |
> +          Which LED this node represents. The reg of the first LED on the chain
> +          is 0.
> +        maxItems: 1
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
> +        leds@0 {

git grep leds@ -- Documentation/devicetree/ | wc -l
1
git grep led@ -- Documentation/devicetree/ | wc -l
165

so rather not the first one ("leds").

There is also:
git grep led-controller@ -- Documentation/devicetree/ | wc -l
30


> +            compatible = "worldsemi,ws2812b";
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            spi-max-frequency = <2850000>;
> +            multi-led@0 {
> +                reg = <0>;

Best regards,
Krzysztof

