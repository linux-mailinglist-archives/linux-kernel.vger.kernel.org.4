Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B525F150F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiI3VlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiI3VlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:41:11 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64EC12D2F;
        Fri, 30 Sep 2022 14:41:09 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-12803ac8113so6890401fac.8;
        Fri, 30 Sep 2022 14:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jnmEu5Aa7YonFIfxOTzWoZtuSAOnEqJRaAksgNqWVko=;
        b=G+ib/ivkseEnHLl6TgQbau+zyX2P4EQJaT00AeBvTZ+lUcR5BSIIO844OintHvZKze
         Q8ZXlBYdwS7zp1aywVQWYPvV0Wg1ShRwikd2qFV7N+sCXFnu6jAAZbEjfT2zwDwBJO4t
         oXFGoZvhnPozf6PG6pTO0FZ9el/rRO3Y+TgHn1+yH5ZRqFipinx6M09el+GnARz/yuzr
         AGvG1sTXZimtrNpBKjJvXnGfE/vElqJj4U1FS1HS/DxbiN1DyDNP1wrz34nzjtLyJD36
         YEZDdaKyzgqjVtauUtjqjZMRTU994X4wXez8jZ1ee2+P58Y0Ist6BGow4erY7RWAHtyS
         mVvw==
X-Gm-Message-State: ACrzQf3MTQEK0wKovyu5PVC+Lv5oepnvJmClPmbHJs2SNJ/xPcEHroOh
        5xGJmR3Q94cVxB9LT8YiajoahT/G4Q==
X-Google-Smtp-Source: AMsMyM4Ff5SWx6oitZzCbMUxBmcmkkE4D5xAww3D0giDuEXkG78oAgdebOnYRVu50fa5sp0yhYJ2dg==
X-Received: by 2002:a05:6870:6325:b0:12d:3605:dd85 with SMTP id s37-20020a056870632500b0012d3605dd85mr101849oao.227.1664574068875;
        Fri, 30 Sep 2022 14:41:08 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a4aa746000000b004764a441aa5sm676947oom.27.2022.09.30.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:41:08 -0700 (PDT)
Received: (nullmailer pid 1090627 invoked by uid 1000);
        Fri, 30 Sep 2022 21:41:07 -0000
Date:   Fri, 30 Sep 2022 16:41:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/3] dt-bindings: gpio: Convert Unisoc EIC controller
 binding to yaml
Message-ID: <20220930214107.GA1088921-robh@kernel.org>
References: <20220930082405.1761-1-zhang.lyra@gmail.com>
 <20220930082405.1761-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930082405.1761-3-zhang.lyra@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:24:04PM +0800, Chunyan Zhang wrote:
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

If you want the formatting maintained, you need '|' on the end.

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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic_eic: gpio@300 {
> +            compatible = "sprd,sc2731-eic";
> +            reg = <0x300>;
> +            interrupt-parent = <&sc2731_pmic>;
> +            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
