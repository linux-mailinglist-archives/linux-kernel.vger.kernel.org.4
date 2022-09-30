Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3861F5F09F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiI3LV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiI3LUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:20:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B91C40F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:09:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so6336364lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tdHtHF+L8WhspMis4iiPFewDbwHGxtfsKqQmXXud88E=;
        b=tGmnFIBQmr9QlELIQAtuwtWwClhFeZsqW5T14DWkCokssrq7YlfiFRj15ZVoUC/1P8
         N3mZ6QC50rgkyzKwlxil8ftVUg48SRsEi0yyXnMw71faySgOvUgJT4EI7hTZbe72HXpL
         NiCIizhUp7eyQ73+9m/G7kxApuDmIdaNDt+EP8oc13U2qtpWBRM/3WpZCePzh0GPwNOA
         RqUtUyB7MRUW8t6t3Y44Kc9H87o6ciys9ZbGolNUpirFUvk+4NiGQmWadnMAZpE29/uz
         ZZeecXqHI8jbQTLLXQrkWq2H7SIirmdd1xP4qSUy55ZH9GAQ68vTuGzJCsm/wEDpDXux
         a84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tdHtHF+L8WhspMis4iiPFewDbwHGxtfsKqQmXXud88E=;
        b=cUbnb4cUW4J4Djqm//wDIPnegZ8xxq+A5mMpdujz1VKiCo7X6FlBFYYMAfp0F2FsTa
         0q3gTJMdG3Nbxg533VmmmxVwDV03M6SkL1k7ry3y1LFs553U8C7oZAGES0m51NFMjFYa
         AaRgGrr95HE/Kctdjk9xFvikBbcYgwmz/SmXuoG+W2x/zaYoDogHEQT1twI84t4Btycl
         H3rYhf8VyEYkXKM20Lrrl8Dng+VJVXLd3z4Tz4cEcKiCF6Yxyr99z0bAls+9Ito/rHc1
         Eql0L6XbRY1PZqm+J6QF8jMFq3z5kUkkKPzTHFbKNnstSdRUdDBbbjjELJWpwAcxaONs
         k9zg==
X-Gm-Message-State: ACrzQf3DZQHqYT3JVYYSIluS5qH2cDNqG5kM5T0rM+d7yEIUnibknrTy
        pm1AhkK5Js7SJSeFZvFUbAE8GQ==
X-Google-Smtp-Source: AMsMyM5z65vzq0NTyxq5BiAd6UIgpP759WsaUofMn8X6LLynEJE+EvhVg9aA4Mh0qlJ6nqx67+gX3Q==
X-Received: by 2002:a19:dc54:0:b0:49f:53f3:9bcd with SMTP id f20-20020a19dc54000000b0049f53f39bcdmr3275718lfj.158.1664536162165;
        Fri, 30 Sep 2022 04:09:22 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d15-20020ac25ecf000000b004979e231fafsm263696lfq.38.2022.09.30.04.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 04:09:21 -0700 (PDT)
Message-ID: <727a540d-0ca9-ade3-894d-f1774d10a681@linaro.org>
Date:   Fri, 30 Sep 2022 13:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 2/3] dt-bindings: gpio: Convert Unisoc EIC controller
 binding to yaml
Content-Language: en-US
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220930082405.1761-1-zhang.lyra@gmail.com>
 <20220930082405.1761-3-zhang.lyra@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930082405.1761-3-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 10:24, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Convert the Unisoc EIC controller binding to DT schema format.
> Update the maxItems of 'reg' property, since the current gpio-eic-sprd
> driver supports 3 reg items. Also remove three redundant examples.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/gpio/gpio-eic-sprd.txt           |  97 --------------
>  .../bindings/gpio/sprd,gpio-eic.yaml          | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 97 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> deleted file mode 100644
> index 54040a2bfe3a..000000000000
> --- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -Spreadtrum EIC controller bindings
> -
> -The EIC is the abbreviation of external interrupt controller, which can
> -be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
> -one is in digital chip, and another one is in PMIC. The digital chip EIC
> -controller contains 4 sub-modules: EIC-debounce, EIC-latch, EIC-async and
> -EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
> -module.
> -
> -The EIC-debounce sub-module provides up to 8 source input signal
> -connections. A debounce mechanism is used to capture the input signals'
> -stable status (millisecond resolution) and a single-trigger mechanism
> -is introduced into this sub-module to enhance the input event detection
> -reliability. In addition, this sub-module's clock can be shut off
> -automatically to reduce power dissipation. Moreover the debounce range
> -is from 1ms to 4s with a step size of 1ms. The input signal will be
> -ignored if it is asserted for less than 1 ms.
> -
> -The EIC-latch sub-module is used to latch some special power down signals
> -and generate interrupts, since the EIC-latch does not depend on the APB
> -clock to capture signals.
> -
> -The EIC-async sub-module uses a 32kHz clock to capture the short signals
> -(microsecond resolution) to generate interrupts by level or edge trigger.
> -
> -The EIC-sync is similar with GPIO's input function, which is a synchronized
> -signal input register. It can generate interrupts by level or edge trigger
> -when detecting input signals.
> -
> -Required properties:
> -- compatible: Should be one of the following:
> -  "sprd,sc9860-eic-debounce",
> -  "sprd,sc9860-eic-latch",
> -  "sprd,sc9860-eic-async",
> -  "sprd,sc9860-eic-sync",
> -  "sprd,sc2731-eic".
> -- reg: Define the base and range of the I/O address space containing
> -  the GPIO controller registers.
> -- gpio-controller: Marks the device node as a GPIO controller.
> -- #gpio-cells: Should be <2>. The first cell is the gpio number and
> -  the second cell is used to specify optional parameters.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -- #interrupt-cells: Should be <2>. Specifies the number of cells needed
> -  to encode interrupt source.
> -- interrupts: Should be the port interrupt shared by all the gpios.
> -
> -Example:
> -	eic_debounce: gpio@40210000 {
> -		compatible = "sprd,sc9860-eic-debounce";
> -		reg = <0 0x40210000 0 0x80>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	eic_latch: gpio@40210080 {
> -		compatible = "sprd,sc9860-eic-latch";
> -		reg = <0 0x40210080 0 0x20>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	eic_async: gpio@402100a0 {
> -		compatible = "sprd,sc9860-eic-async";
> -		reg = <0 0x402100a0 0 0x20>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	eic_sync: gpio@402100c0 {
> -		compatible = "sprd,sc9860-eic-sync";
> -		reg = <0 0x402100c0 0 0x20>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	pmic_eic: gpio@300 {
> -		compatible = "sprd,sc2731-eic";
> -		reg = <0x300>;
> -		interrupt-parent = <&sc2731_pmic>;
> -		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -	};
> diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> new file mode 100644
> index 000000000000..c288a8dd44c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/sprd,gpio-eic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc EIC controller
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description:
> +  The EIC is the abbreviation of external interrupt controller, which can
> +  be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
> +  one is in digital chip, and another one is in PMIC. The digital chip EIC
> +  controller contains 4 sub-modules, i.e. EIC-debounce, EIC-latch, EIC-async and
> +  EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
> +  module.
> +
> +  The EIC-debounce sub-module provides up to 8 source input signal
> +  connections. A debounce mechanism is used to capture the input signals'
> +  stable status (millisecond resolution) and a single-trigger mechanism
> +  is introduced into this sub-module to enhance the input event detection
> +  reliability. In addition, this sub-module's clock can be shut off
> +  automatically to reduce power dissipation. Moreover the debounce range
> +  is from 1ms to 4s with a step size of 1ms. The input signal will be
> +  ignored if it is asserted for less than 1 ms.
> +
> +  The EIC-latch sub-module is used to latch some special power down signals
> +  and generate interrupts, since the EIC-latch does not depend on the APB
> +  clock to capture signals.
> +
> +  The EIC-async sub-module uses a 32kHz clock to capture the short signals
> +  (microsecond resolution) to generate interrupts by level or edge trigger.
> +
> +  The EIC-sync is similar with GPIO's input function, which is a synchronized
> +  signal input register. It can generate interrupts by level or edge trigger
> +  when detecting input signals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc9860-eic-debounce
> +      - sprd,sc9860-eic-latch
> +      - sprd,sc9860-eic-async
> +      - sprd,sc9860-eic-sync
> +      - sprd,sc2731-eic
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 3
> +    description:
> +      EIC controller can support maximum 3 banks which has its own
> +      address base.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      The interrupt shared by all GPIO lines for this controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        eic_debounce: gpio@40210000 {
> +            compatible = "sprd,sc9860-eic-debounce";
> +            reg = <0 0x40210000 0 0x80>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +
> +    sc2730_pmic {

If you insisted to keep it, at least should be correct, so just pmic.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic_eic: gpio@300 {

It's exactly the same example as above - all same properties. Drop it or
bring some differences.


Best regards,
Krzysztof

