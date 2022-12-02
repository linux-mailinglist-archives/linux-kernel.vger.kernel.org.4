Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6F64027F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiLBIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLBIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:50:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22481B0A2A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:50:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g12so6408225lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gsTbE/7GQ0DUUZOUEsL7VShze2Hvn86+52Ynad1eeE=;
        b=Wsol0pH86/yxFy6bDZXC9Lh6lIly9rD2SpU2aVIjtwMayvX0UWQirO3cLXoqu+Y3Lt
         G8TbFhO9PVNSLUc59zBvWaIpIdqjnXSr7J3q2DKBuVGJjF4ezhdTJYmCihefQNPi6dOb
         /KgwDaNthvQxGSz4R6KB8AM+khfDpeEhzFndKyCCo7DG3egkPls97WQ9SEM4MrGF0t8j
         UWadkagQQf5kFzYzuGXyge0IyCCfkJFDJyHcH1ZfNlKiFntt0/J2sSdfRsCD+WoztbK3
         0XOol8Nku6SKKQnFgCCe7aVWf30TgwSuw7uC7fLIrqmz2zWHLtsJcJIc3DL2a9mQRlGM
         yRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsTbE/7GQ0DUUZOUEsL7VShze2Hvn86+52Ynad1eeE=;
        b=KbRuECG5CU2OVRWW7vC17a30XDLHNj/+fEUGIuFEA3JPAj6UZYw7sl93C7KZhAo7VO
         29RISM4cLBNwhKhIlLU9icTDdxrfA50LvzxSZijkW+uqbf2oQWQamZUBg+epcO/BbZq2
         qtvGuK9AsTq4D7UlwA+ayDWoxJZTFPRvXONU2CvjhTdNZrSjVXW6WUCA8IUikplLHO/v
         DZ/WYDcaRnsko/uxrTNj/XymrI+wrPIfWzm+nWmZLMTn8IR3WyfrxYCOgo3TrIY0dt8m
         T7B5uZRmWXysuN40t3xTLDor1iZ6kJ/VMhr5iWrRsAMx+7UWXQvz+nC+Y0ewnV4x0lRL
         muMA==
X-Gm-Message-State: ANoB5pkWrNk516v5jN46cHTjivBsdvjSsFEidcuBXSTNb2225FzvbS/P
        mShVBdKlxnBURQLgHfms1/kSUQ==
X-Google-Smtp-Source: AA0mqf5Ml0gyPLfuAmL2QWjPk3UILvqZG5RWFVqh9aiaimTDqjo5MrCmpTCHWOBaWTGOYKzabjXtYg==
X-Received: by 2002:a19:7404:0:b0:4aa:bdfb:75b8 with SMTP id v4-20020a197404000000b004aabdfb75b8mr17694403lfe.175.1669971023380;
        Fri, 02 Dec 2022 00:50:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j15-20020a05651231cf00b004b4b0a68f67sm945243lfe.185.2022.12.02.00.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 00:50:22 -0800 (PST)
Message-ID: <bed4c4aa-e9d5-4de8-1a4a-689f9c44bc23@linaro.org>
Date:   Fri, 2 Dec 2022 09:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64/boot/dts and arm_scpi: add to support Phytium
 FT2004 CPU
Content-Language: en-US
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <0D48D1B7AC373F2F+Y4l+EOBIC9SmZD2A@TP-P15V>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0D48D1B7AC373F2F+Y4l+EOBIC9SmZD2A@TP-P15V>
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

On 02/12/2022 05:24, Wang Honghui wrote:
> arm64/boot/dts and arm_scpi: add to support Phytium FT2004 CPU.

That's not correct commit msg. You just pasted subject.

> 

Use subject prefixes matching the subsystem (git log --oneline -- ...).


> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/phytium/Makefile          |   5 +
>  .../dts/phytium/ft2004-devboard-d4-dsk.dts    |  73 +++
>  .../dts/phytium/ft2004-generic-psci-soc.dtsi  | 469 ++++++++++++++++++
>  drivers/firmware/arm_scpi.c                   |   1 +
>  6 files changed, 554 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/phytium/Makefile
>  create mode 100644 arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts
>  create mode 100644 arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 76580b932e44..7e8b17855eb7 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -236,6 +236,11 @@ config ARCH_NPCM
>  	  General support for NPCM8xx BMC (Arbel).
>  	  Nuvoton NPCM8xx BMC based on the Cortex A35.
>  
> +config ARCH_PHYTIUM
> +        bool "Phytium SoC Family"
> +        help
> +          This enables support for Phytium ARMv8 SoC family.
> +
>  config ARCH_QCOM
>  	bool "Qualcomm Platforms"
>  	select GPIOLIB
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 7b107fa7414b..386e74291f32 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -21,6 +21,7 @@ subdir-y += mediatek
>  subdir-y += microchip
>  subdir-y += nuvoton
>  subdir-y += nvidia
> +subdir-y += phytium
>  subdir-y += qcom
>  subdir-y += realtek
>  subdir-y += renesas
> diff --git a/arch/arm64/boot/dts/phytium/Makefile b/arch/arm64/boot/dts/phytium/Makefile
> new file mode 100644
> index 000000000000..911190cb1199
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_PHYTIUM) += ft2004-devboard-d4-dsk.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts b/arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts
> new file mode 100644
> index 000000000000..5bef2e886292
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DTS file for phytium FT-2000/4 devboard (FT-2000/4-D4-DSK series)
> + *
> + * Copyright (C) 2018-2019, Phytium Technology Co., Ltd.
> + */
> +
> +/dts-v1/;
> +/memreserve/ 0x80000000 0x10000;
> +
> +#include "ft2004-generic-psci-soc.dtsi"
> +
> +/{
> +	model = "FT-2000/4-D4-DSK Development Board";
> +	compatible = "phytium,ft-2004";

Not documented. Checkpatch should fail, so it means you did not run it.
Be sure your new platform passes:
1. checkpatch
2. dtbs_check
3. dtbs W=1

You need changes to bindings.


> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen {
> +		stdout-path = "uart1:115200n8";
> +	};
> +
> +	memory@00{
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x1 0x00000000>;
> +	};
> +
> +	memory@01{
> +		device_type = "memory";
> +		reg = <0x20 0x00000000 0x1 0x00000000>;
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +};
> +
> +&rtc0 {
> +	status = "ok";
> +};
> +
> +&uart1 {

Bring some order to all these nodes.

> +	status = "ok";
> +};
> +
> +&gmac0 {
> +	status = "ok";
> +	phy-mode = "rgmii-rxid";
> +};
> +
> +&gmac1 {
> +	status = "ok";
> +	phy-mode = "rgmii-rxid";
> +};
> +
> +&spi0 {
> +	status = "ok";
> +};
> +
> +&qspi {
> +	status = "ok";
> +};
> +
> +&i2c0 {
> +	status = "ok";
> +};
> +
> +&i2c1 {
> +	status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi b/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
> new file mode 100644
> index 000000000000..80d64e17899b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for FT-2000/4 SoC
> + *
> + * Copyright (C) 2018-2019, Phytium Technology Co., Ltd.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "phytium,ft2004";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
> +	psci {
> +		compatible   = "arm,psci-1.0";

Drop weird indentation before =

> +		method       = "smc";
> +		cpu_suspend  = <0xc4000001>;
> +		cpu_off      = <0x84000002>;
> +		cpu_on       = <0xc4000003>;
> +		sys_poweroff = <0x84000008>;
> +		sys_reset    = <0x84000009>;
> +	};
> +
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			numa-node-id = <0>;

Where is the other NUMA node?

> +			clocks = <&scpi_dvfs 0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			numa-node-id = <0>;
> +			clocks = <&scpi_dvfs 0>;
> +		};
> +
> +		cpu2: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			numa-node-id = <0>;
> +			clocks = <&scpi_dvfs 1>;
> +		};
> +
> +		cpu3: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +			numa-node-id = <0>;
> +			clocks = <&scpi_dvfs 1>;
> +		};
> +	};
> +
> +	gic: interrupt-controller@29900000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +		reg = <0x0 0x29900000 0 0x20000>,       /* GICD */
> +		      <0x0 0x29980000 0 0x80000>,       /* GICR */
> +		      <0x0 0x29c00000 0 0x10000>,       /* GICC */
> +		      <0x0 0x29c10000 0 0x10000>,       /* GICH */
> +		      <0x0 0x29c20000 0 0x10000>;       /* GICV */

compatible is the first, reg is the second property.

> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		its: gic-its@29920000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0x29920000 0x0 0x20000>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +		clock-frequency = <48000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clk250mhz: clk250mhz {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <250000000>;

Are these really clocks in the SoC?

> +		};
> +
> +		sysclk_48mhz: clk48mhz {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <48000000>;
> +		};
> +
> +		sysclk_600mhz: clk600mhz {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <600000000>;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-coherent;
> +		ranges;
> +
> +		gpio0: gpio@28004000 {
> +			compatible = "phytium,gpio";

Not documented. The same all others. If there is dependency, you should
clearly communicate it.

> +			reg = <0x0 0x28004000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			porta {
> +				compatible = "phytium,gpio-port";
> +				reg = <0>;
> +				nr-gpios = <8>;
> +			};
> +
> +			portb {
> +				compatible = "phytium,gpio-port";
> +				reg = <1>;
> +				nr-gpios = <8>;
> +			};
> +		};
> +
> +		gpio1: gpio@28005000 {
> +			compatible = "phytium,gpio";
> +			reg = <0x0 0x28005000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			porta {
> +				compatible = "phytium,gpio-port";
> +				reg = <0>;
> +				nr-gpios = <8>;
> +			};
> +
> +			portb {
> +				compatible = "phytium,gpio-port";
> +				reg = <1>;
> +				nr-gpios = <8>;
> +			};
> +		};
> +
> +		uart0: uart@28000000 {

Fails tests. Shouldn't this be serial?

> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0x28000000 0x0 0x1000>;
> +			baud = <115200>;

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


There is little point to review stuff which is being pointed out by
tools. First, fix your DTS to pass the tests. Then send for review.

> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz &sysclk_48mhz>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart1: uart@28001000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0x28001000 0x0 0x1000>;
> +			baud = <115200>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz &sysclk_48mhz>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart2: uart@28002000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0x28002000 0x0 0x1000>;
> +			baud = <115200>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz &sysclk_48mhz>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart3: uart@28003000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0x28003000 0x0 0x1000>;
> +			baud = <115200>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz &sysclk_48mhz>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		sdci: sdci@28207c00 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "phytium,sdci";
> +			reg = <0x0 0x28207c00 0x0 0x100>;
> +			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_600mhz &sysclk_600mhz>;
> +			clock-names = "phytium_sdc_clk";
> +			no-sdio;
> +			no-mmc;
> +			no-dma-coherent;
> +		};
> +
> +		watchdog0: watchdog@2800a000 {
> +			compatible = "arm,sbsa-gwdt";
> +			reg = <0x0 0x2800b000 0x0 0x1000>,
> +			      <0x0 0x2800a000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +			timeout-sec = <30>;
> +		};
> +
> +		watchdog1: watchdog@28016000 {
> +			compatible = "arm,sbsa-gwdt";
> +			reg = <0x0 0x28017000 0x0 0x1000>,
> +			      <0x0 0x28016000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			timeout-sec = <30>;
> +		};
> +
> +		rtc0: rtc@2800d000 {
> +			compatible = "phytium,rtc";
> +			reg = <0x0 0x2800d000 0x0 0x1000>;
> +			clocks = <&sysclk_48mhz>;
> +			clock-names = "rtc_pclk";
> +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c@28006000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x28006000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@28007000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x28007000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@28008000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x28008000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@28009000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x28009000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi@2800c000 {
> +			compatible = "phytium,spi";
> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x2800c000 0x0 0x1000>;
> +			clocks = <&sysclk_48mhz>;
> +			num-cs = <4>;
> +		};
> +
> +		spi1: spi@28013000 {
> +			compatible = "phytium,spi";
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x28013000 0x0 0x1000>;
> +			clocks = <&sysclk_48mhz>;
> +			num-cs = <4>;
> +		};
> +
> +		qspi: qspi@28014000 {
> +			compatible = "phytium,qspi";
> +			reg = <0x0 0x28014000 0x0     0x1000>,
> +			      <0x0        0x0 0x0 0x02000000>;
> +			reg-names = "qspi", "qspi_mm";
> +			clocks = <&sysclk_600mhz>;
> +
> +			flash@0 {
> +				spi-rx-bus-width = <1>;
> +				spi-max-frequency = <600000000>;
> +			};
> +		};
> +
> +		pcie: pcie {

Even dtc will complain...

> +			compatible = "pci-host-ecam-generic";
> +			device_type = "pci";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			reg = <0x0 0x40000000 0x0 0x10000000>;
> +			msi-parent = <&its>;
> +			bus-range = <0x0 0xff>;
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0x0 0x0 0x2 &gic 0x0 0x0 GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0x0 0x0 0x3 &gic 0x0 0x0 GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0x0 0x0 0x4 &gic 0x0 0x0 GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			ranges = <0x01000000 0x00 0x00000000 0x0  0x50000000  0x0  0x00f00000>,
> +				 <0x02000000 0x00 0x58000000 0x0  0x58000000  0x0  0x28000000>,
> +				 <0x03000000 0x10 0x00000000 0x10 0x00000000 0x10  0x00000000>;
> +		};
> +
> +		phytium_axi_setup: stmmac-axi-config {
> +			snps,wr_osr_lmt = <0>;
> +			snps,rd_osr_lmt = <0>;
> +			snps,blen = <0 0 0 0 16 8 4>;
> +		};
> +
> +		gmac0: eth@2820c000 {

ethernet

> +			compatible = "snps,dwmac";
> +			reg = <0x0 0x2820c000 0x0 0x2000>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clk250mhz>;
> +			clock-names = "stmmaceth";
> +			status = "disabled";
> +
> +			snps,pbl = <16>;
> +			snps,fixed-burst;
> +			snps,axi-config = <&phytium_axi_setup>;
> +			snps,force_sf_dma_mode;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <128>;
> +			tx-fifo-depth = <4096>;
> +			rx-fifo-depth = <4096>;
> +			max-frame-size = <9000>;
> +		};
> +
> +		gmac1: eth@28210000 {

ethernet

> +			compatible = "snps,dwmac";
> +			reg = <0x0 0x28210000 0x0 0x2000>;
> +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clk250mhz>;
> +			clock-names = "stmmaceth";
> +			status = "disabled";
> +
> +			snps,pbl = <16>;
> +			snps,fixed-burst;
> +			snps,axi-config = <&phytium_axi_setup>;
> +			snps,force_sf_dma_mode;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <128>;
> +			snps,rx-queues-to-use = <2>;
> +			tx-fifo-depth = <4096>;
> +			rx-fifo-depth = <4096>;
> +			max-frame-size = <9000>;
> +		};
> +
> +		can0: can@28207000 {
> +			compatible = "phytium,can";
> +			reg = <0x0 0x28207000 0x0 0x400>;
> +			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_600mhz>;
> +			clock-names = "phytium_can_clk";
> +			tx-fifo-depth = <0x40>;
> +			rx-fifo-depth = <0x40>;
> +		};
> +
> +		can1: can@28207400 {
> +			compatible = "phytium,can";
> +			reg = <0x0 0x28207400 0x0 0x400>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_600mhz>;
> +			clock-names = "phytium_can_clk";
> +			tx-fifo-depth = <0x40>;
> +			rx-fifo-depth = <0x40>;
> +		};
> +
> +		can2: can@028207800 {
> +			compatible = "phytium,can";
> +			reg = <0x0 0x28207800 0x0 0x400>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_600mhz>;
> +			clock-names = "phytium_can_clk";
> +			tx-fifo-depth = <0x40>;
> +			rx-fifo-depth = <0x40>;
> +		};
> +
> +		hda: hda@28206000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "phytium,hda";
> +			reg = <0 0x28206000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk_48mhz>;
> +			clock-names = "phytium_hda_clk";
> +		};
> +
> +		mbox: mailbox@2a000000 {
> +			compatible = "phytium,mbox";
> +			reg = <0x0 0x2a000000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <1>;
> +			clocks = <&sysclk_48mhz>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		sram: sram@2a006000 {
> +			compatible = "phytium,ft2004-sram-ns","mmio-sram";
> +			reg = <0x0 0x2a006000 0x0 0x2000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x2a006000 0x2000>;
> +
> +			scpi_lpri: scpi-shmem@0 {
> +				compatible = "phytium,ft2004-scpi-shmem";
> +				reg = <0x1000 0x800>;
> +			};
> +		};
> +
> +		scpi_protocol: scpi {
> +			compatible = "arm,scpi";
> +			mboxes = <&mbox 0>;
> +			shmem = <&scpi_lpri>;
> +
> +			clocks {
> +				compatible = "arm,scpi-clocks";
> +
> +				scpi_dvfs: scpi_clocks@0 {

No underscores in node names.

> +					compatible = "arm,scpi-dvfs-clocks";
> +					#clock-cells = <1>;
> +					clock-indices = <0>, <1>;
> +					clock-output-names = "c0", "c1";
> +				};
> +			};
> +
> +			scpi_sensors: sensors {
> +				compatible = "arm,scpi-sensors";
> +				#thermal-sensor-cells = <1>;
> +			};
> +		};
> +	};
> +};
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 435d0e2658a4..876eb2f9ff81 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c

Code never goes with DTS.


Best regards,
Krzysztof

