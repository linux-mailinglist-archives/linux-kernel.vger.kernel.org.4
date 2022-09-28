Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113195EDBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiI1LeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiI1LeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:34:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F990832
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:34:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so19880942lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9PUsMni89Am5OjAGDtEoIlUjB+TXWbbnVhRlVPKPO9U=;
        b=Oo+/z2Nr81B3vE+3Gtlxr3eMfQFeU4sORRoLbJJ2DGPzOChULJzMxiUc5fHjJLE7g3
         SzSlou97u2DVK4w4vVyhV6/SRIEpS2ANEqnqGzH6brJdnNSxgJP8hbFMSi6s8PUKqYDR
         ygPQK1ghAwqUDvpg3G9wqGl9kkWdgnC/TSI6MO+vf6GgjcPSrrU21QBrOz4cywwuMO8z
         CL4FU2raUI3kXfVykoujgNw5fhFDnMflXb7+HZbjpnFvWdD3tRVECHKCr4znr1mmcy8P
         vzReyo+soNFVLHfWLbOjfWze+9GE7eZQvEKzcRZtMOhKKEJ6GTFWZlbSNdATG7MitvFp
         h7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9PUsMni89Am5OjAGDtEoIlUjB+TXWbbnVhRlVPKPO9U=;
        b=Qp85yJbjzEQ92TDz711VvihEa0EMM7KfoTsID3BXhJZHPeEdwtbUdVG4ertYmrok5g
         UUOaXCBMcbWAZJ0OxwDWH/VyKPSnNndS5KO9B7Tz9PkkthevCUJOHUbwIY1nkyRbwMye
         rGn/gkJSDZZqQ7y2j6UwcFtthcsSoMB1FjOoq+5X+mizH6o2WnRMMtROqKqL5MBCrWc8
         g/yHtsK5vznt0Un+nC0fKTzdQT+EwxD+hfUhzzscYA4xWQhnJhfn7GOPFaxZZPdBdvF2
         AL5aqjxWa/fey/bznRKRsxEzfbaZZL1TEycPwcYt159Q3rrwdkIACa8XfTyt6Toyo/lB
         vUbQ==
X-Gm-Message-State: ACrzQf3IYM1XxoKaPRnCjhvznxHu88Vyn9XWuh7aFmTGU4ViycYKQjk8
        uq2Bx8nLe2Rz0akwyLKTKGnG1w==
X-Google-Smtp-Source: AMsMyM4/5u1BsQkQqlJBphpdy4eMc5UqNeN7NvKgKooc/IBBODuuoCJa/wxSFfVQHXG91RRq2awSng==
X-Received: by 2002:a05:6512:32c7:b0:49d:d448:59c0 with SMTP id f7-20020a05651232c700b0049dd44859c0mr12619634lfg.335.1664364843040;
        Wed, 28 Sep 2022 04:34:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512348900b0049465afdd38sm451618lfr.108.2022.09.28.04.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:34:02 -0700 (PDT)
Message-ID: <75597c55-24f8-a76c-334d-cedc186aa841@linaro.org>
Date:   Wed, 28 Sep 2022 13:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] dt-bindings: gpio: Conver Unisoc EIC controller
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
        LKML <linux-kernel@vger.kernel.org>
References: <20220928092937.27120-1-zhang.lyra@gmail.com>
 <20220928092937.27120-2-zhang.lyra@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928092937.27120-2-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:29, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Convert the Unisoc EIC controller binding to DT schema format.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/gpio/gpio-eic-sprd.txt           |  97 ------------
>  .../bindings/gpio/sprd,gpio-eic.yaml          | 145 ++++++++++++++++++
>  2 files changed, 145 insertions(+), 97 deletions(-)
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
> index 000000000000..e25ee1884c07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> @@ -0,0 +1,145 @@
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
> +    maxItems: 4

Why up to 4 items? Previous bindings did not mention it. I also do not
see any users of this. Anyway you need to describe the items (items with
description) and restrict per variant in allOf:if:then


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
> +    description: The interrupt shared by all GPIO lines for this controller.
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

One example is enough. All others are the same.


Best regards,
Krzysztof

