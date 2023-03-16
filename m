Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1A6BC78E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCPHpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCPHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:45:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEDA5929
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:45:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so3911821edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1EmzL55KL6Yhe0603WbJLtdC1HVfZvXj/gYh1h/D6Y=;
        b=QJOYyOA7Wh578Tz/Pg82TzuNAP6xwrb9OO//FpEhD+FzpZJKoazy1APhPwr1+6MAjt
         PlbLIuyJ4kI1DJlewY9ZzLr1R0K25LHsW/qYArzaYC5vs9iKph8HOGm3o9FEhcFKIkqO
         F/urhDjSGz2CKHIvaABKoRWy8kPv8QEMAKN7PIC0b070XhWxKjUsoQfrsYN2Nr234SXR
         xOpUs7GFc/kLMhypg0JMXdhdQ3Yy+wY8okFqCN1pKZmTWmB4KugB1/wa5vp5Y31yjTe2
         JO0jRpTCkH5jVZ+XUZfc5uAgW83SHO7ASt2Pb7Hl72LhslionPPBA/vQbBtd3f9dhMVk
         ving==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1EmzL55KL6Yhe0603WbJLtdC1HVfZvXj/gYh1h/D6Y=;
        b=hC1wi0kM4clJR3Ej36mTYFe/SKUAH+o6WWFePc4ERq4po6G3j1RXQZxukd+pnJAEqH
         TCg1jeFMRkdPza9Srf9HjMGfgsxAymGosVt6Ec/MyZSbuGPpA1I7JP9piNqtbCKnwFjr
         TsX7sot+LAhCRn+jP94jiqatf2o2JvY8Hu6x8xy0XA4ge93OvGNSwdKno6Jl2u9P08Eq
         sy3hJi3ry8DFG19hu2Wgo0NsCNg8o4y1skXEnuIk7ZP0t3OdkrvjjD28Q+TDmi003SCS
         7WsKrx5KIuiYwj6pEWI8ULlaVE1Ybw7C6m5D2o3IobbPu1k/YqVcm+DqZm84KAUlNdIa
         Ct3Q==
X-Gm-Message-State: AO0yUKVwwX8eOi8JuFYrf3MjnJ0tc8Iu9yTJRRu+t/Qt9nq2ZKxLsRgy
        rz5n7XVNzF9gPiZQ/pbZHoPtWg==
X-Google-Smtp-Source: AK7set8zToKb1XwApB4toxT+Fgo60TEyK5X2FWxld0F7bRzo5lBrJ3MSnT97HkfIIapsSz494s7UjQ==
X-Received: by 2002:a17:906:e093:b0:8b1:7e88:c20f with SMTP id gh19-20020a170906e09300b008b17e88c20fmr10670576ejb.15.1678952727053;
        Thu, 16 Mar 2023 00:45:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b0092fdb0b2e5dsm913436ejb.93.2023.03.16.00.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:45:26 -0700 (PDT)
Message-ID: <fb4f60a7-011e-3745-cc40-631247735f2b@linaro.org>
Date:   Thu, 16 Mar 2023 08:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-12-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add initial device tree support for Nuvoton ma35d1 SoC, including
> cpu, clock, reset, and serial controllers.
> Add reference boards som-256m and iot-512m.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
>  .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  24 ++
>  .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  23 ++
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 272 ++++++++++++++++++
>  4 files changed, 321 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>  create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>  create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
> index a99dab90472a..c11ab4eac9c7 100644
> --- a/arch/arm64/boot/dts/nuvoton/Makefile
> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
> @@ -1,2 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-evb.dtb
> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-iot-512m.dtb
> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-som-256m.dtb
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> new file mode 100644
> index 000000000000..dffcaef1e6d8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Shan-Chun Hung <schung@nuvoton.com>
> + *         Jacky huang <ychuang3@nuvoton.com>
> + */
> +
> +/dts-v1/;
> +#include "ma35d1.dtsi"
> +
> +/ {
> +	model = "Nuvoton MA35D1-IoT";
> +	compatible = "nuvoton,ma35d1-iot", "nuvoton,ma35d1";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	mem: memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> new file mode 100644
> index 000000000000..3e6c3d5469ac
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Shan-Chun Hung <schung@nuvoton.com>
> + *         Jacky huang <ychuang3@nuvoton.com>
> + */
> +
> +/dts-v1/;
> +#include "ma35d1.dtsi"
> +
> +/ {
> +	model = "Nuvoton MA35D1-SOM";
> +	compatible = "nuvoton,ma35d1-som", "nuvoton,ma35d1";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	mem: memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0 0x10000000>; /* 256M DRAM */
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> new file mode 100644
> index 000000000000..8c855f6b330a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Shan-Chun Hung <schung@nuvoton.com>
> + *         Jacky huang <ychuang3@nuvoton.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +/ {
> +	compatible = "nuvoton,ma35d1";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +		serial8 = &uart8;
> +		serial9 = &uart9;
> +		serial10 = &uart10;
> +		serial11 = &uart11;
> +		serial12 = &uart12;
> +		serial13 = &uart13;
> +		serial14 = &uart14;
> +		serial15 = &uart15;
> +		serial16 = &uart16;

Aliases of interfaces coming out of SoC are properties of boards, not
SoC DTSI.

> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;


Blank line.

> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};

Between every node as well.

> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	clk_hxt: clock_hxt {

No underscores in node names.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "clk_hxt";

This looks like a property of boards, not SoC. Are you sure the clock
physically is in every SoC? If so, why it is not part of clock
controller? (before you start explaining what is this, have in mind that
I am pretty sure I know what is this, so rather answer the questions)

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +			      IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +			      IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +			      IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +			      IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
> +		clock-frequency = <12000000>;
> +		interrupt-parent = <&gic>;
> +	};
> +
> +	sys: system-management@40460000 {
> +		compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
> +		reg = <0x0 0x40460000 0x0 0x200>;
> +
> +		reset: reset-controller {
> +			compatible = "nuvoton,ma35d1-reset";
> +			regmap = <&sys>;
> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	clk: clock-controller@40460200 {
> +		compatible = "nuvoton,ma35d1-clk", "syscon";
> +		reg = <0x00000000 0x40460200 0x0 0x100>;
> +		#clock-cells = <1>;
> +		clocks = <&clk_hxt>;
> +		clock-names = "clk_hxt";
> +		assigned-clocks = <&clk CAPLL>,
> +				  <&clk DDRPLL>,
> +				  <&clk APLL>,
> +				  <&clk EPLL>,
> +				  <&clk VPLL>;
> +		assigned-clock-rates = <800000000>,
> +				       <266000000>,
> +				       <180000000>,
> +				       <500000000>,
> +				       <102000000>;
> +		nuvoton,pll-mode = <0>, <1>, <0>, <0>, <0>;
> +		nuvoton,sys = <&sys>;
> +	};
> +
> +	gic: interrupt-controller@50801000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		interrupt-controller;
> +		reg =   <0x0 0x50801000 0 0x1000>, /* GICD */
> +			<0x0 0x50802000 0 0x2000>, /* GICC */
> +			<0x0 0x50804000 0 0x2000>, /* GICH */
> +			<0x0 0x50806000 0 0x2000>; /* GICV */

reg is second property.

> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
> +			      IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	uart0:serial@40700000 {
> +		compatible = "nuvoton,ma35d1-uart";
> +		reg = <0x0 0x40700000 0x0 0x100>;
> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clk UART0_GATE>;
> +		status = "okay";

Why? Drop the line... or convert it to disabled. Otherwise, why every
SoC has serial0 enabled? Is it used internally?


Best regards,
Krzysztof

