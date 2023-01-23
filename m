Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2484E677637
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAWIUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAWIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:20:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F61E1C9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:20:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t5so10003375wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpyB0rokuQ4wQfP2tx1Eq5EsqYXF1HZGttzBzrBr53I=;
        b=JBl/G3PA5mQdxCvY0PoImKwNOMj/lZqnSVbE4yeLMSi5Sgh1/EzGTs+DiUmNdLd7aB
         MMpflZ+deh8o9OwruxzN5WO00ViNRy0O2+FayjsqsGiilrRPAsupy7cjR88ucBF/hbWp
         Fs4BnFS/R0L0booURtRyAvhbxgci6IwGOMIii3acmtWdcSOvxbv1eHWu9KBo9t+QFoQc
         YAjtDsvQgqfJQD2C+5KswcpjPcdaS7Ixd4d5XESwlRvUt9MVy8zs1Q5yoR9ce6Hcovwv
         CqgSV/jH6hPa5V3iHJdamwy6whFjjJUHoQA8AvQclSr93vIL03LooiWlPCahf55I939Y
         CZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpyB0rokuQ4wQfP2tx1Eq5EsqYXF1HZGttzBzrBr53I=;
        b=QAK4NMlO8OBM/L3Ff5gmmctOlc5WTP3mNaDETFGHzM799a5PlVdR1KUzwW816Q5pvQ
         pTktZcLixcKJNCAHEnhISEKlnBxf2D6rWLNEQP661NggG5JFpc60KyEvQfQfMtVv5s2I
         AVeINkN0tdKgbz5gu0HOQGHYAddsMELrFDC7q7blAAsTL2y5QrrLebgZXmvpwHydooHv
         1stUDnRMltje1aIq2kCG5I0ulFlVLTK5h0R4OZ4Ck2YiBI1d9/Su38Zls0Hl2+9cWNYo
         nxoCAr38KVfFvcCXdCWz/OI7kpg4uGQJNFSk1cqy0e2Qu1/BAq8lr8qfs2jKAQZD1Tb4
         4eoA==
X-Gm-Message-State: AFqh2kqjxZwjwLYhMSFyVDeonuAmwXjVBxIwTnvDxwJRxYWLQdt7vldO
        /tDKRK0mO3IpKEEvnzQ7y3bmWw==
X-Google-Smtp-Source: AMrXdXtIkl4GQcYmgLPkcWWqYSwD8K6JX24cquISjRBuEaY9mBapy+dMHsJBETOQ2iSm/5XiOI72sA==
X-Received: by 2002:a5d:5e85:0:b0:2bd:d782:c2b8 with SMTP id ck5-20020a5d5e85000000b002bdd782c2b8mr22762525wrb.29.1674462014890;
        Mon, 23 Jan 2023 00:20:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe0d0000000b002be36beb2d9sm10990348wri.113.2023.01.23.00.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:20:14 -0800 (PST)
Message-ID: <6b6a7094-9f0e-dbc3-424a-54fd426e8243@linaro.org>
Date:   Mon, 23 Jan 2023 09:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 15/15] arm64: dts: ambarella: introduce Ambarella s6lm SoC
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Li Chen <me@linux.beauty>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-16-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-16-lchen@ambarella.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 08:32, Li Chen wrote:
> This patch adds s6lm's devicetree.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: Idc7a04cc64a53b3296bc9fcf9dd3cd648ebefeae
> ---
>  MAINTAINERS                                   |   2 +
>  .../boot/dts/ambarella/ambarella-s6lm.dtsi    | 332 ++++++++++++++++++
>  .../boot/dts/ambarella/s6lm_pineapple.dts     |  29 ++
>  3 files changed, 363 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ambarella/ambarella-s6lm.dtsi
>  create mode 100644 arch/arm64/boot/dts/ambarella/s6lm_pineapple.dts
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1360fe2f4236..d9d1033b6452 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1894,6 +1894,8 @@ ARM/Ambarella SoC support
>  M:	Li Chen <me@linux.beauty>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
> +F:	arch/arm64/boot/dts/ambarella/ambarella-s6lm.dts
> +F:	arch/arm64/boot/dts/ambarella/ambarella-s6lm.dtsi
>  F:	Documentation/devicetree/bindings/arm/ambarella.yaml
>  F:	Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
>  F:	Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
> diff --git a/arch/arm64/boot/dts/ambarella/ambarella-s6lm.dtsi b/arch/arm64/boot/dts/ambarella/ambarella-s6lm.dtsi
> new file mode 100644
> index 000000000000..c3fa77b33e04
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ambarella/ambarella-s6lm.dtsi
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Ambarella,Inc. - http://www.ambarella.com/
> + * Author: Cao Rongrong <rrcao@ambarella.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Drop boilerplate.

> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "ambarella,s6lm";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		nand = &nand0;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart0;
> +	};
> +
> +	/*
> +	 * the memory node will be overwritten in Amboot,
> +	 * here is just the default value.
> +	 */
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00200000 0x07e00000>; /* 126M */
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 5 0x4>,

??? Just compare these two lines above...

> +			     <0 6 0x4>,
> +			     <0 7 0x4>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu@2 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu@3 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	gic: interrupt-controller@f3000000 {
> +		compatible = "arm,gic-400";

reg should be second property.

> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0xf3001000 0x1000>,	/* GIC Dist */
> +		      <0xf3002000 0x2000>,	/* GIC CPU */
> +		      /* following are not used if no virtulization */
> +		      <0xf3004000 0x2000>,	/* GIC VCPU Control */
> +		      <0xf3006000 0x2000>;	/* GIC VCPU */
> +		interrupts = <GIC_PPI 9 0xf04>;	/* GIC Maintenence IRQ */
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 0xf08>,	/* Secure Phys IRQ */
> +			     <1 14 0xf08>,	/* Non-secure Phys IRQ */

And you do not see here anything odd?

> +			     <1 11 0xf08>,	/* Virt IRQ */
> +			     <1 10 0xf08>;	/* Hyp IRQ */
> +	};
> +
> +	n_apb@e4000000 { /* Non-Secure APB, but configurable */

No underscores in node names. Generic node names, so just "bus"

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0xe4000000 0x01000000>;
> +		ranges;
> +
> +		uart0: uart@e4000000 {

serial

> +			compatible = "ambarella,uart";
> +			reg = <0xe4000000 0x1000>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins>;
> +			clocks = <&gclk_uart0>;
> +			amb,ignore-fe;
> +			status = "ok";
> +		};
> +	};
> +
> +	s_apb@ec000000 { /* Secure APB, but configurable */

bus

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0xec000000 0x01000000>;

reg is second property

> +		ranges;
> +
> +		pinctrl: pinctrl@0xec003000 {
> +			compatible = "ambarella,pinctrl";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0xec003000 0x1000>,
> +			      <0xec004000 0x1000>,
> +			      <0xec005000 0x1000>,
> +			      <0xec000000 0x1000>;

reg is second
> +			reg-names = "gpio0", "gpio1", "gpio2", "iomux";
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			amb,pull-regmap = <&scratchpad_syscon 0x14 0x30>;
> +			amb,ds-regmap = <&rct_syscon>;
> +
> +			gpio: gpio@0 {
> +				reg = <0>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				gpio-ranges = <&pinctrl 0 0 86>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			uart0_pins: uart0@0 {
> +				reg = <0>;

Why do you have unit addresses here? What is this?

> +				amb,pinmux-ids = <0x100a 0x100b>;

This will need more explanation... your bindings are not ready for
review, so we will get to this later when you rewrite your bindings and
test them before sending.

> +			};
> +
> +			snand0_pins_a: snand0@0 {
> +				reg = <0>;
> +				amb,pinmux-ids = <0x2024 0x2025 0x202a 0x202b
> +						  0x202c 0x202d>;
> +			};
> +
> +			snand0_pins_b: snand0@1 {
> +				reg = <1>;
> +				amb,pinmux-ids = <0x4036 0x4037 0x4038 0x4039
> +						  0x403a 0x403b>;
> +			};
> +		};
> +	};
> +
> +	n_ahb@e0000000 { /* Non-Secure AHB, but configurable */

bus

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0xe0000000 0x01000000>;

reg is a second property.

> +		ranges;
> +
> +		cpuid_syscon: cpuid@e0000000 {
> +			compatible = "ambarella,cpuid", "syscon";
> +			reg = <0xe0000000 0x1000>;
> +		};
> +
> +		nand0: nand@e0002000 {
> +			compatible = "ambarella,nand";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0xe0002000 0x1000>;

ditto

> +			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;	/* fio_irq */
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&snand0_pins_a>;
> +			clocks = <&pll_out_enet>;
> +			nand-on-flash-bbt;
> +			/* amb,soft-ecc = <6>; */

Drop dead code

> +		};
> +
> +		scratchpad_syscon: scratchpad_syscon@e0022000 {
> +			compatible = "ambarella,scratchpad", "syscon";
> +			reg = <0xe0022000 0x100>;
> +		};
> +	};
> +
> +	rct@ed080000 {

bus

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0xed080000 0x1000>;
> +		ranges;
> +
> +		rct_syscon: rct_syscon@ed080000 {

syscon
(no underscores in node names, generic node names)

> +			compatible = "ambarella,rct", "syscon";
> +			reg = <0xed080000 0x1000>;
> +		};
> +	};
> +
> +	clocks {
> +		compatible = "ambarella,clkpll-v0";

Nope, nope. Register proper clock controller.


> +		#address-cells = <1>;
> +		#size-cells = <1>;

Why? You do not have any children with unit addresses.
> +
> +		/*
> +		 * This is a dummy clock, to be used as placeholder on other
> +		 * mux clocks when corresponding bits in register don't
> +		 * represent real parent clock.
> +		 */
> +		gclk_dummy: gclk_dummy {

NAK. Register proper clock controller.

> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <0>;
> +		};
> +
> +		/*
> +		 * Fixed 24MHz oscillator inputs to SoC
> +		 */
> +		osc: oscillator {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;

This is actually the only clock which makes sense, but it is not a
property of SoC. Put it with the board DTS. At least frequency goes
there to note it.

> +			clock-output-names = "osc";
> +		};
> +
> +		gclk_core: gclk-core {

NAK here and for all other weird nodes below

> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "gclk_core";
> +			amb,clk-regmap = <&rct_syscon 0x000 0x004 0x100 0x104 0x000 0x000>;
> +		};
> +
> +		gclk_ddr: gclk-ddr {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "gclk_ddr";
> +			amb,clk-regmap = <&rct_syscon 0x0dc 0x0e0 0x110 0x114 0x000 0x000>;
> +			amb,fix-divider = <2>;
> +		};
> +
> +		gclk_cortex: gclk-cortex {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "gclk_cortex";
> +			amb,clk-regmap = <&rct_syscon 0x264 0x268 0x26c 0x270 0x000 0x000>;
> +		};
> +
> +		gclk_axi: gclk-axi {
> +			#clock-cells = <0>;
> +			compatible = "fixed-factor-clock";
> +			clocks = <&gclk_cortex>;
> +			clock-output-names = "gclk_axi";
> +			clock-mult = <1>;
> +			clock-div = <3>;
> +		};
> +
> +		gclk_so: gclk-so {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "gclk_so";
> +			assigned-clocks = <&gclk_so>;
> +			assigned-clock-rates = <24000000>;
> +			amb,clk-regmap = <&rct_syscon 0x024 0x028 0x11c 0x120 0x04c 0x030>;
> +			amb,frac-mode;
> +		};
> +
> +		pll_out_vo2: pll-out-vo2 {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "pll_out_vo2";
> +			assigned-clocks = <&pll_out_vo2>;
> +			assigned-clock-rates = <24000000>;
> +			amb,clk-regmap = <&rct_syscon 0x0c0 0x0c4 0x13c 0x140 0x0c8 0x000>;
> +			amb,frac-mode;
> +		};
> +
> +		pll_out_sd: pll-out-sd {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "pll_out_sd";
> +			amb,clk-regmap = <&rct_syscon 0x4ac 0x4b0 0x4b4 0x4b8 0x000 0x000>;
> +		};
> +		pll_out_enet: pll-out-enet {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,pll-clock";
> +			clocks = <&osc>;
> +			clock-output-names = "pll_out_enet";
> +			amb,clk-regmap = <&rct_syscon 0x520 0x524 0x528 0x52c 0x000 0x000>;
> +		};
> +		gclk_uart0: gclk-uart0 {
> +			#clock-cells = <0>;
> +			compatible = "ambarella,composite-clock";
> +			clocks = <&osc>, <&gclk_core>, <&pll_out_enet>, <&pll_out_sd>;
> +			clock-output-names = "gclk_uart0";
> +			assigned-clocks = <&gclk_uart0>;
> +			assigned-clock-parents = <&osc>;
> +			assigned-clock-rates = <24000000>;
> +			amb,mux-regmap = <&rct_syscon 0x1c8>;
> +			amb,div-regmap = <&rct_syscon 0x038>;
> +			amb,div-width = <24>;
> +			amb,div-shift = <0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ambarella/s6lm_pineapple.dts b/arch/arm64/boot/dts/ambarella/s6lm_pineapple.dts
> new file mode 100644
> index 000000000000..2d5d6d18e738
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ambarella/s6lm_pineapple.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 Ambarella,Inc. - http://www.ambarella.com/
> + * Author: Cao Rongrong <rrcao@ambarella.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "ambarella-s6lm.dtsi"
> +
> +/ {
> +	model = "Ambarella S6LM Pineapple Board";
> +	compatible = "ambarella,s6lm";

Missing board compatible.

> +
> +	chosen {
> +		bootargs = "console=ttyS0 ubi.mtd=lnx root=ubi0:rootfs rw
> +			rootfstype=ubifs init=/linuxrc";

Drop bootargs. These should not be needed in DTS. Otherwise - why do you
need them? Why bootloader cannot provide these?

> +	};
> +
> +	n_apb@e4000000 {
> +		i2c1: i2c@e4009000 {

No, use override by phandle/label.

> +			status = "ok";
> +		};
> +	};
> +};

Best regards,
Krzysztof

