Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7100367371C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjASLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjASLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:41:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606D1DB94
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:40:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1039971wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ap65kPaWrg//vaLcwMT2fWDG60R1Z9fU8o81hSnfmog=;
        b=jHU/xFTlHQHRdepj1BTNZeUBjp45xi+8LTUOWgJktzOWGxIQCyCDzxVeWLaHHU7Ra/
         agJtm4Vim4iDM7REsR8Wz+DxLWynz3ywVkhMz5GGJeH+JV2xxNG7Q6Ji9XuhKHbD5bbm
         Kzi0e5Vn8qztHjExqa9LjHcjLyXl5ge7A1d1cBunlIvf1GRan+xJZmRmwXc7jmDRkbMY
         0kjn6BmMojixvTYslhCZt34ZR0CjdLX2BBoAnlPmLCgQpa0s1Ir1kGL7STLB28ZDBbCS
         LChampJT2tVVLQX3PxMfa0hDpTuYwCDm8iEM3rankOhYuhriPsR7dD2RIjbqo8eFhUv+
         B5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap65kPaWrg//vaLcwMT2fWDG60R1Z9fU8o81hSnfmog=;
        b=ORt88hbde4AsCah5FogXpboVyknyC7+eYWsuQpdY8teHZQhrle7ziESWi2XzG24N47
         UrSVOK5+m1tMd/cEJidindK4ok2rwypgo8P963BHfMz7o15e9THhSs8IYd9d8X/MVuUK
         IdfVmsFu1dRBBHmzSlQYy4YlNfjjn5v4mlu9+LcChwMf2zoFe+bQGAT7dVgJNq+4KUCK
         1BjOjYKXldHCAbQ6bpfegePLhTVpst7vEwUbxFx01AhU77W/gmmru4Xl/7wTg8s7VaKa
         OFFt0VIWZflnxk6lDT/Jrt2MepMjMCVRdexBX12YIgqecXK71yLjMjwqjBd0SXkszDpx
         7nfQ==
X-Gm-Message-State: AFqh2komYHg1iJ2M0QZW6/Johs/FUT81LDpg7nSbNZ4Oxq9aDHdxxD+5
        HFsp4g65u+qtcRDPN3OBuTXld9/evg4MXKy5
X-Google-Smtp-Source: AMrXdXs9VQHlr0++gE1JRCqV+bGS1HsqSexUqe30Kx05zSgjA7MI+E+QDIVPCtRoEhdT7Uc/76/M2A==
X-Received: by 2002:a1c:7417:0:b0:3da:fcd:7dfe with SMTP id p23-20020a1c7417000000b003da0fcd7dfemr18575115wmc.10.1674128440297;
        Thu, 19 Jan 2023 03:40:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c1c8e00b003d9ed40a512sm6475563wms.45.2023.01.19.03.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:40:39 -0800 (PST)
Message-ID: <41fd5c2a-9fc5-8af8-b66e-45bb83b24179@linaro.org>
Date:   Thu, 19 Jan 2023 12:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: Add support for Unisoc's UMS512
Content-Language: en-US
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230118084025.2898404-1-chunyan.zhang@unisoc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118084025.2898404-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 09:40, Chunyan Zhang wrote:
> Add basic support for Unisoc's UMS512, with this patch,
> the board ums512-1h10 can run into console.
> 

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching), e.g. "arm64: dts: sprd:"

> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  arch/arm64/boot/dts/sprd/Makefile        |   3 +-
>  arch/arm64/boot/dts/sprd/ums512-1h10.dts |  64 ++
>  arch/arm64/boot/dts/sprd/ums512.dtsi     | 919 +++++++++++++++++++++++
>  3 files changed, 985 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/sprd/ums512-1h10.dts
>  create mode 100644 arch/arm64/boot/dts/sprd/ums512.dtsi
> 
> diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
> index f4f1f5148cc2..97522fb0bf66 100644
> --- a/arch/arm64/boot/dts/sprd/Makefile
> +++ b/arch/arm64/boot/dts/sprd/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
>  			sp9860g-1h10.dtb	\
> -			sp9863a-1h10.dtb
> +			sp9863a-1h10.dtb	\
> +			ums512-1h10.dtb
> diff --git a/arch/arm64/boot/dts/sprd/ums512-1h10.dts b/arch/arm64/boot/dts/sprd/ums512-1h10.dts
> new file mode 100644
> index 000000000000..d549a8c361d4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/ums512-1h10.dts
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Unisoc UMS512-1h10 boards DTS file
> + *
> + * Copyright (C) 2021, Unisoc Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "ums512.dtsi"
> +
> +/ {
> +	model = "Unisoc UMS512-1H10 Board";
> +
> +	compatible = "sprd,ums512-1h10", "sprd,ums512";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +		bootargs = "earlycon";

earlycon is for debugging, not wide, mainline usage. Drop.

> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +/* SD card */
> +&sdio0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	sprd,phy-delay-sd-uhs-sdr104 = <0x7f 0x73 0x72 0x72>;
> +	sprd,phy-delay-sd-uhs-sdr50 = <0x6e 0x7f 0x01 0x01>;
> +	sprd,phy-delay-sd-highspeed = <0x7f 0x1a 0x9a 0x9a>;
> +	sprd,phy-delay-legacy = <0x7f 0x1a 0x9a 0x9a>;
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +};
> +
> +/* EMMC storage */
> +&sdio3 {
> +	status = "okay";
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +};
> diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
> new file mode 100644
> index 000000000000..028e17f8198e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
> @@ -0,0 +1,919 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Unisoc UMS512 SoC DTS file
> + *
> + * Copyright (C) 2021, Unisoc Inc.
> + */
> +
> +#include <dt-bindings/clock/sprd,ums512-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +				core4 {
> +					cpu = <&CPU4>;
> +				};
> +				core5 {
> +					cpu = <&CPU5>;
> +				};
> +				core6 {
> +					cpu = <&CPU6>;
> +				};
> +				core7 {
> +					cpu = <&CPU7>;
> +				};
> +			};
> +		};
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x400>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x500>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x600>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +
> +		CPU7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x700>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CORE_PD>;
> +		};
> +	};
> +
> +	idle-states {
> +		entry-method = "psci";
> +		CORE_PD: core-pd {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <4000>;
> +			exit-latency-us = <4000>;
> +			min-residency-us = <10000>;
> +			local-timer-stop;
> +			arm,psci-suspend-param = <0x00010000>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@12000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			redistributor-stride = <0x0 0x20000>;	/* 128KB stride */
> +			#redistributor-regions = <1>;
> +			interrupt-controller;
> +			reg = <0x0 0x12000000 0 0x20000>,	/* GICD */
> +			      <0x0 0x12040000 0 0x100000>;	/* GICR */

Keep reg as second property, after compatible. This applies everywhere.

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		ap_ahb_regs: syscon@20100000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x20100000 0 0x4000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x20100000 0x4000>;
> +
> +			apahb_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-apahb-gate";
> +				reg = <0x0 0x3000>;
> +				clocks = <&ext_26m>;
> +				clock-names = "ext-26m";
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		pub_apb_regs: syscon@31050000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x31050000 0 0x9000>;
> +		};
> +
> +		top_dvfs_apb_regs: syscon@322a0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x322a0000 0 0x8000>;
> +		};
> +
> +		ap_intc0_regs: syscon@32310000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32310000 0 0x1000>;
> +		};
> +
> +		ap_intc1_regs: syscon@32320000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32320000 0 0x1000>;
> +		};
> +
> +		ap_intc2_regs: syscon@32330000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32330000 0 0x1000>;
> +		};
> +
> +		ap_intc3_regs: syscon@32340000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32340000 0 0x1000>;
> +		};
> +
> +		ap_intc4_regs: syscon@32350000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32350000 0 0x1000>;
> +		};
> +
> +		ap_intc5_regs: syscon@32360000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32360000 0 0x1000>;
> +		};
> +
> +		anlg_phy_g0_regs: syscon@32390000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x32390000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x32390000 0x3000>;
> +
> +			dpll0: clock-controller@0 {
> +				compatible = "sprd,ums512-g0-pll";
> +				reg = <0x0 0x100>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		anlg_phy_g2_regs: syscon@323b0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x323b0000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x323b0000 0x3000>;
> +
> +			mpll1: clock-controller@0 {
> +				compatible = "sprd,ums512-g2-pll";
> +				reg = <0x0 0x100>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		anlg_phy_g3_regs: syscon@323c0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x323c0000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x323c0000 0x3000>;
> +
> +			pll1: clock-controller@0 {
> +				compatible = "sprd,ums512-g3-pll";
> +				reg = <0x0 0x3000>;
> +				clocks = <&ext_26m>;
> +				clock-names = "ext-26m";
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		anlg_phy_gc_regs: syscon@323e0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x323e0000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x323e0000 0x3000>;
> +
> +			pll2: clock-controller@0 {
> +				compatible = "sprd,ums512-gc-pll";
> +				reg = <0x0 0x100>;
> +				clock-names = "ext-26m";
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		anlg_phy_g10_regs: syscon@323f0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x323f0000 0 0x3000>;
> +		};
> +
> +		aon_apb_regs: syscon@327d0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x327d0000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x327d0000 0x3000>;
> +
> +			aonapb_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-aon-gate";
> +				reg = <0x0 0x3000>;
> +				clocks = <&ext_26m>;
> +				clock-names = "ext-26m";
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		pmu_apb_regs: syscon@327e0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x327e0000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x327e0000 0x3000>;
> +
> +			pmu_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-pmu-gate";
> +				reg = <0x0 0x3000>;
> +				clocks = <&ext_26m>;
> +				clock-names = "ext-26m";
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		audcp_apb_regs: syscon@3350d000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x3350d000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x3350d000 0x1000>;
> +
> +			audcpapb_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-audcpapb-gate";
> +				reg = <0x0 0x300>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		audcp_ahb_regs: syscon@335e0000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x335e0000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x335e0000 0x1000>;
> +
> +			audcpahb_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-audcpahb-gate";
> +				reg = <0x0 0x300>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		gpu_apb_regs: syscon@60100000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x60100000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x60100000 0x3000>;
> +
> +			gpu_clk: clock-controller@0 {
> +				compatible = "sprd,ums512-gpu-clk";
> +				clocks = <&ext_26m>;
> +				clock-names = "ext-26m";
> +				reg = <0x0 0x100>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		gpu_dvfs_apb_regs: syscon@60110000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x60110000 0 0x3000>;
> +		};
> +
> +		mm_ahb_regs: syscon@62200000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x62200000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x62200000 0x3000>;
> +
> +			mm_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-mm-gate-clk";
> +				reg = <0x0 0x3000>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		ap_apb_regs: syscon@71000000 {
> +			compatible = "sprd,ums512-glbregs", "syscon",
> +				     "simple-mfd";
> +			reg = <0 0x71000000 0 0x3000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x71000000 0x3000>;
> +
> +			apapb_gate: clock-controller@0 {
> +				compatible = "sprd,ums512-apapb-gate";
> +				reg = <0x0 0x3000>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		ap_clk: clock-controller@20200000 {
> +			compatible = "sprd,ums512-ap-clk";
> +			reg = <0 0x20200000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "ext-26m";
> +			#clock-cells = <1>;
> +		};
> +
> +		aon_clk: clock-controller@32080000 {
> +			compatible = "sprd,ums512-aonapb-clk";
> +			reg = <0 0x32080000 0 0x1000>;
> +			clocks = <&ext_26m>, <&ext_32k>,
> +				 <&ext_4m>, <&rco_100m>;
> +			clock-names = "ext-26m", "ext-32k",
> +				      "ext-4m", "rco-100m";
> +			#clock-cells = <1>;
> +		};
> +
> +		mm_clk: clock-controller@62100000 {
> +			compatible = "sprd,ums512-mm-clk";
> +			reg = <0 0x62100000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "ext-26m";
> +			#clock-cells = <1>;
> +		};
> +
> +		/* SoC Funnel */
> +		funnel@3c002000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x3c002000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_soc_out_port: endpoint {
> +						remote-endpoint = <&etb_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <1>;
> +					funnel_soc_in_port: endpoint {
> +						remote-endpoint =
> +						<&funnel_corinth_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* SoC ETF */
> +		soc_etb: etb@3c003000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x3c003000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					etb_in: endpoint {
> +						remote-endpoint =
> +						<&funnel_soc_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* AP-CPU Funnel for core3/4/5/7 */
> +		funnel@3e001000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x3e001000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_corinth_lit_out_port: endpoint {
> +						remote-endpoint =
> +						<&corinth_etf_lit_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					funnel_core_in_port3: endpoint {
> +						remote-endpoint = <&etm3_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					funnel_core_in_port4: endpoint {
> +						remote-endpoint = <&etm4_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					funnel_core_in_port5: endpoint {
> +						remote-endpoint = <&etm5_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					funnel_core_in_port7: endpoint {
> +						remote-endpoint = <&etm7_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* AP-CPU ETF for little cores */
> +		etf@3e002000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x3e002000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					corinth_etf_lit_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_corinth_from_lit_in_port>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					corinth_etf_lit_in: endpoint {
> +						remote-endpoint =
> +						<&funnel_corinth_lit_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* AP-CPU ETF for big cores */
> +		etf@3e003000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x3e003000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					corinth_etf_big_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_corinth_from_big_in_port>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					corinth_etf_big_in: endpoint {
> +						remote-endpoint =
> +						<&funnel_corinth_big_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Funnel to SoC */
> +		funnel@3e004000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x3e004000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_corinth_out_port: endpoint {
> +						remote-endpoint =
> +						<&funnel_soc_in_port>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					funnel_corinth_from_lit_in_port: endpoint {
> +						remote-endpoint = <&corinth_etf_lit_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					funnel_corinth_from_big_in_port: endpoint {
> +						remote-endpoint = <&corinth_etf_big_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* AP-CPU Funnel for core0/1/2/6 */
> +		funnel@3e005000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x3e005000 0 0x1000>;
> +			clocks = <&ext_26m>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_corinth_big_out_port: endpoint {
> +						remote-endpoint = <&corinth_etf_big_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					funnel_core_in_port0: endpoint {
> +						remote-endpoint = <&etm0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					funnel_core_in_port1: endpoint {
> +						remote-endpoint = <&etm1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					funnel_core_in_port2: endpoint {
> +						remote-endpoint = <&etm2_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					funnel_core_in_port6: endpoint {
> +						remote-endpoint = <&etm6_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm0: etm@3f040000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f040000 0 0x1000>;
> +			cpu = <&CPU0>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm1: etm@3f140000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f140000 0 0x1000>;
> +			cpu = <&CPU1>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm2: etm@3f240000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f240000 0 0x1000>;
> +			cpu = <&CPU2>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port2>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm3: etm@3f340000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f340000 0 0x1000>;
> +			cpu = <&CPU3>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm4: etm@3f440000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f440000 0 0x1000>;
> +			cpu = <&CPU4>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port4>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm5: etm@3f540000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f540000 0 0x1000>;
> +			cpu = <&CPU5>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port5>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm6: etm@3f640000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f640000 0 0x1000>;
> +			cpu = <&CPU6>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port6>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm7: etm@3f740000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x3f740000 0 0x1000>;
> +			cpu = <&CPU7>;
> +			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
> +			clock-names = "apb_pclk", "clk_cs", "cs_src";
> +
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +						<&funnel_core_in_port7>;
> +					};
> +				};
> +			};
> +		};
> +
> +
> +		apb@70000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x0 0x70000000 0x10000000>;
> +
> +			uart0: serial@0 {
> +				compatible = "sprd,ums512-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x0 0x100>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			uart1: serial@100000 {
> +				compatible = "sprd,ums512-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x100000 0x100>;
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		ap-apb {

Non-unit-address nodes cannot be mixed with unit address ones. Something
is wrong here.

> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			sdio0: sdio@71100000 {
> +				compatible = "sprd,sdhci-r11";
> +				reg = <0 0x71100000 0 0x1000>;
> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "sdio", "enable";
> +				clocks = <&ap_clk CLK_SDIO0_2X>,
> +					 <&apapb_gate CLK_SDIO0_EB>;
> +				assigned-clocks = <&ap_clk CLK_SDIO0_2X>;
> +				assigned-clock-parents = <&pll1 CLK_RPLL>;
> +				status = "disabled";
> +			};
> +
> +			sdio3: sdio@71400000 {
> +				compatible = "sprd,sdhci-r11";
> +				reg = <0 0x71400000 0 0x1000>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "sdio", "enable";
> +				clocks = <&ap_clk CLK_EMMC_2X>,
> +					 <&apapb_gate CLK_EMMC_EB>;
> +				assigned-clocks = <&ap_clk CLK_EMMC_2X>;
> +				assigned-clock-parents = <&pll1 CLK_RPLL>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		aon {

Same problem.

> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			adi_bus: spi@32100000 {
> +				compatible = "sprd,ums512-adi";
> +				reg = <0 0x32100000 0 0x100000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				sprd,hw-channels = <2 0x18cc>, <3 0x18cc>, <13 0x1854>, <15 0x1874>,
> +					<17 0x1844>,<19 0x1844>, <21 0x1864>, <30 0x1820>,
> +					<35 0x19b8>, <39 0x19ac>;
> +			};
> +		};
> +	};
> +
> +	ext_26m: ext-26m {

Node names should be generic, so at least clock prefix or suffix. This
applies to all further places as well.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "ext-26m";
> +	};
> +
> +	ext_32k: ext-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "ext-32k";
> +	};
> +
> +	ext_4m: ext-4m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <4000000>;
> +		clock-output-names = "ext-4m";
> +	};
> +
> +	rco_100m: rco-100m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "rco-100m";
> +	};
> +};

Best regards,
Krzysztof

