Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4F68C293
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBFQK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBFQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:10:22 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40F610F2;
        Mon,  6 Feb 2023 08:10:18 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id t5so2617313oiw.1;
        Mon, 06 Feb 2023 08:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7llHpQnTyuFxRAMYW9d7K5OY8P3bfvlKMK5rAjZx9/M=;
        b=XmgfIDZ5CKIy+dOpzK4mRtrCNZiX38jD/NW/slTNBYdw1JbbQmfNFTd+10A0T4oKX3
         hNJ+lxJvAT3In/fVke3REkmvHOiKhHn/1B4hWgiN8/zp0UbcJcXCBP/TymXc5SVrYmWN
         AMvqke/7xgf2XWQ/MQ8Mb9BbPCmfXetlnM6eJEa7pN1dYDC7cLISvmCWTsM1khKxNOnH
         PR72qt59XmFCXieytWcH8NaJYoDp9zzfP1p2aCIYuzMurOEjZ2tNGn+W6WyaYoJJg1WL
         dVPGXaxuxpl0n/FKR3iUzSG9tzGs8BamvwSLy9FmQwXUy7sxsu2ZXXUlqa7y7KWY2Tbg
         gKcg==
X-Gm-Message-State: AO0yUKUQiXfQwRGjK2xzH2Tq1kcj1osbDc4mCBO78cK48HMZrcxXcyio
        guMzCOfmUBtEeYIlK7SXkg==
X-Google-Smtp-Source: AK7set+s8N8h1fzWapx/vtalR162om+ieAHyQIYvZzUt2l3rowwqqPOZkkdS+XDqzCNoxlJcxf2kHg==
X-Received: by 2002:aca:da82:0:b0:37a:adb3:26db with SMTP id r124-20020acada82000000b0037aadb326dbmr81453oig.18.1675699817718;
        Mon, 06 Feb 2023 08:10:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q125-20020acac083000000b00369a721732asm4301842oif.41.2023.02.06.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:10:17 -0800 (PST)
Received: (nullmailer pid 160449 invoked by uid 1000);
        Mon, 06 Feb 2023 16:10:16 -0000
Date:   Mon, 6 Feb 2023 10:10:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: pinctrl: Add StarFive JH7110 sys
 pinctrl
Message-ID: <20230206161016.GA156592-robh@kernel.org>
References: <20230203141801.59083-1-hal.feng@starfivetech.com>
 <20230203141801.59083-2-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203141801.59083-2-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 10:17:58PM +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC sys pinctrl controller.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-sys-pinctrl.yaml  | 141 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +-
>  .../pinctrl/starfive,jh7110-pinctrl.h         | 115 ++++++++++++++
>  3 files changed, 260 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
> new file mode 100644
> index 000000000000..22554e68ec91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-sys-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SYS Pin Controller
> +
> +description: |
> +  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
> +
> +  Out of the SoC's many pins only the ones named PAD_GPIO0 to PAD_GPIO63
> +  can be multiplexed and have configurable bias, drive strength,
> +  schmitt trigger etc.
> +  Some peripherals have their I/O go through the 64 "GPIOs". This also
> +  includes a number of other UARTs, I2Cs, SPIs, PWMs etc.
> +  All these peripherals are connected to all 64 GPIOs such that
> +  any GPIO can be set up to be controlled by any of the peripherals.
> +
> +maintainers:
> +  - Jianlong Huang <jianlong.huang@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-sys-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +patternProperties:
> +  '-[0-9]+$':
> +    type: object
> +    additionalProperties: false
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        description: |
> +          A pinctrl node should contain at least one subnode representing the
> +          pinctrl groups available on the machine. Each subnode will list the
> +          pins it needs, and how they should be configured, with regard to
> +          muxer configuration, bias, input enable/disable, input schmitt
> +          trigger enable/disable, slew-rate and drive strength.
> +        $ref: /schemas/pinctrl/pincfg-node.yaml

On 2nd look, this should be:

allOf:
  - $ref: /schemas/pinctrl/pincfg-node.yaml
  - $ref: /schemas/pinctrl/pinmux-node.yaml

> +        additionalProperties: false
> +
> +        properties:
> +          pinmux:
> +            description: |
> +              The list of GPIOs and their mux settings that properties in the
> +              node apply to. This should be set using the GPIOMUX or PINMUX
> +              macros.
> +            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pinmux

And drop this.

Same in other patch. With that, Reviewed-by stands.

> +
> +          bias-disable: true
> +
> +          bias-pull-up:
> +            type: boolean
> +
> +          bias-pull-down:
> +            type: boolean
> +
> +          drive-strength:
> +            enum: [ 2, 4, 8, 12 ]
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          slew-rate:
> +            maximum: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@13040000 {
> +        compatible = "starfive,jh7110-sys-pinctrl";
> +        reg = <0x13040000 0x10000>;
> +        clocks = <&syscrg 112>;
> +        resets = <&syscrg 2>;
> +        interrupts = <86>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +
> +        uart0-0 {
> +            tx-pins {
> +                pinmux = <0xff140005>;
> +                bias-disable;
> +                drive-strength = <12>;
> +                input-disable;
> +                input-schmitt-disable;
> +                slew-rate = <0>;
> +            };
> +
> +            rx-pins {
> +                pinmux = <0x0E000406>;
> +                bias-pull-up;
> +                drive-strength = <2>;
> +                input-enable;
> +                input-schmitt-enable;
> +                slew-rate = <0>;
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f61eb221415b..babd133cdc4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19890,13 +19890,15 @@ F:	Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
>  F:	drivers/clk/starfive/clk-starfive-jh7100*
>  F:	include/dt-bindings/clock/starfive-jh7100*.h
>  
> -STARFIVE JH7100 PINCTRL DRIVER
> +STARFIVE JH71X0 PINCTRL DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> +M:	Jianlong Huang <jianlong.huang@starfivetech.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
> +F:	Documentation/devicetree/bindings/pinctrl/starfive,jh71*.yaml
>  F:	drivers/pinctrl/starfive/
>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
> +F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>  
>  STARFIVE JH7100 RESET CONTROLLER DRIVER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> diff --git a/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h b/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
> new file mode 100644
> index 000000000000..57c1659e4bbf
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
> +#define __DT_BINDINGS_PINCTRL_STARFIVE_JH7110_H__
> +
> +/* sys_iomux pins */
> +#define	PAD_GPIO0		0
> +#define	PAD_GPIO1		1
> +#define	PAD_GPIO2		2
> +#define	PAD_GPIO3		3
> +#define	PAD_GPIO4		4
> +#define	PAD_GPIO5		5
> +#define	PAD_GPIO6		6
> +#define	PAD_GPIO7		7
> +#define	PAD_GPIO8		8
> +#define	PAD_GPIO9		9
> +#define	PAD_GPIO10		10
> +#define	PAD_GPIO11		11
> +#define	PAD_GPIO12		12
> +#define	PAD_GPIO13		13
> +#define	PAD_GPIO14		14
> +#define	PAD_GPIO15		15
> +#define	PAD_GPIO16		16
> +#define	PAD_GPIO17		17
> +#define	PAD_GPIO18		18
> +#define	PAD_GPIO19		19
> +#define	PAD_GPIO20		20
> +#define	PAD_GPIO21		21
> +#define	PAD_GPIO22		22
> +#define	PAD_GPIO23		23
> +#define	PAD_GPIO24		24
> +#define	PAD_GPIO25		25
> +#define	PAD_GPIO26		26
> +#define	PAD_GPIO27		27
> +#define	PAD_GPIO28		28
> +#define	PAD_GPIO29		29
> +#define	PAD_GPIO30		30
> +#define	PAD_GPIO31		31
> +#define	PAD_GPIO32		32
> +#define	PAD_GPIO33		33
> +#define	PAD_GPIO34		34
> +#define	PAD_GPIO35		35
> +#define	PAD_GPIO36		36
> +#define	PAD_GPIO37		37
> +#define	PAD_GPIO38		38
> +#define	PAD_GPIO39		39
> +#define	PAD_GPIO40		40
> +#define	PAD_GPIO41		41
> +#define	PAD_GPIO42		42
> +#define	PAD_GPIO43		43
> +#define	PAD_GPIO44		44
> +#define	PAD_GPIO45		45
> +#define	PAD_GPIO46		46
> +#define	PAD_GPIO47		47
> +#define	PAD_GPIO48		48
> +#define	PAD_GPIO49		49
> +#define	PAD_GPIO50		50
> +#define	PAD_GPIO51		51
> +#define	PAD_GPIO52		52
> +#define	PAD_GPIO53		53
> +#define	PAD_GPIO54		54
> +#define	PAD_GPIO55		55
> +#define	PAD_GPIO56		56
> +#define	PAD_GPIO57		57
> +#define	PAD_GPIO58		58
> +#define	PAD_GPIO59		59
> +#define	PAD_GPIO60		60
> +#define	PAD_GPIO61		61
> +#define	PAD_GPIO62		62
> +#define	PAD_GPIO63		63
> +#define	PAD_SD0_CLK		64
> +#define	PAD_SD0_CMD		65
> +#define	PAD_SD0_DATA0		66
> +#define	PAD_SD0_DATA1		67
> +#define	PAD_SD0_DATA2		68
> +#define	PAD_SD0_DATA3		69
> +#define	PAD_SD0_DATA4		70
> +#define	PAD_SD0_DATA5		71
> +#define	PAD_SD0_DATA6		72
> +#define	PAD_SD0_DATA7		73
> +#define	PAD_SD0_STRB		74
> +#define	PAD_GMAC1_MDC		75
> +#define	PAD_GMAC1_MDIO		76
> +#define	PAD_GMAC1_RXD0		77
> +#define	PAD_GMAC1_RXD1		78
> +#define	PAD_GMAC1_RXD2		79
> +#define	PAD_GMAC1_RXD3		80
> +#define	PAD_GMAC1_RXDV		81
> +#define	PAD_GMAC1_RXC		82
> +#define	PAD_GMAC1_TXD0		83
> +#define	PAD_GMAC1_TXD1		84
> +#define	PAD_GMAC1_TXD2		85
> +#define	PAD_GMAC1_TXD3		86
> +#define	PAD_GMAC1_TXEN		87
> +#define	PAD_GMAC1_TXC		88
> +#define	PAD_QSPI_SCLK		89
> +#define	PAD_QSPI_CS0		90
> +#define	PAD_QSPI_DATA0		91
> +#define	PAD_QSPI_DATA1		92
> +#define	PAD_QSPI_DATA2		93
> +#define	PAD_QSPI_DATA3		94
> +
> +#define GPOUT_LOW		0
> +#define GPOUT_HIGH		1
> +
> +#define GPOEN_ENABLE		0
> +#define GPOEN_DISABLE		1
> +
> +#define GPI_NONE		255
> +
> +#endif
> -- 
> 2.38.1
> 
