Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E0737745
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjFTWKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFTWKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:10:12 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AE1A3;
        Tue, 20 Jun 2023 15:10:10 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:09:58 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
Message-ID: <ZJIjtphyKdC48JrN@ofant>
References: <20230620134857.238941-1-tanure@linux.com>
 <20230620134857.238941-3-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620134857.238941-3-tanure@linux.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas:

On 14:48 Tue 20 Jun     , Lucas Tanure wrote:
> The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
> family, on a board with the same form factor as the VIM3 models.
> 
> - 8GB LPDDR4X 2016MHz
> - 32GB eMMC 5.1 storage
> - 32MB SPI flash
> - 10/100/1000 Base-T Ethernet
> - AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
> - HDMI 2.1 video
> - HDMI Input
> - 1x USB 2.0 + 1x USB 3.0 ports
> - 1x USB-C (power) with USB 2.0 OTG
> - 3x LED's (1x red, 1x blue, 1x white)
> - 3x buttons (power, function, reset)
> - M2 socket with PCIe, USB, ADC & I2C
> - 40pin GPIO Header
> - 1x micro SD card slot
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../amlogic/meson-t7-a311d2-khadas-vim4.dts   |  52 ++++++
>  arch/arm64/boot/dts/amlogic/meson-t7.dtsi     | 158 ++++++++++++++++++
>  3 files changed, 211 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index cd1c5b04890a..1c5846bd1ca0 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-t7-a311d2-khadas-vim4.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> new file mode 100644
> index 000000000000..04cc8b0dfd8c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-t7.dtsi"
> +
> +/ {
> +	model = "Khadas vim4";
> +	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
> +
> +	aliases {
> +		serial0 = &uart_A;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x2 0x0>; /* 8 GB */
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@5000000 {
> +			reg = <0x0 0x05000000 0x0 0x300000>;
> +			no-map;
> +		};
> +
> +		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> +		secmon_reserved_bl32: secmon@5300000 {
> +			reg = <0x0 0x05300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
> +};
> +
> +&uart_A {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-t7.dtsi b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> new file mode 100644
> index 000000000000..b268889bf8ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu100>;
> +				};
> +				core1 {
> +					cpu = <&cpu101>;
> +				};
> +				core2 {
> +					cpu = <&cpu102>;
> +				};
> +				core3 {
> +					cpu = <&cpu103>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu100: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu101: cpu@101{
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu102: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x102>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu103: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x103>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@fff01000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfff01000 0 0x1000>,
> +			      <0x0 0xfff02000 0 0x0100>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb4: bus@fe000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xfe000000 0x0 0x480000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +			uart_A: serial@78000 {
> +				compatible = "amlogic,meson-t7-uart",
                                              ~~~~~~~~~~~~~~~~~
if you introduce new compatible string, then at least you need to document it
so Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml need to be updated

but my qeustion here, why bother introducing new compatible string if nothing
changed with the compatible data? given the uart is same IP with g12a, can't we just
use "amlogic,meson-g12-uart" for this? no only it will reduce the structure length of
meson_uart_dt_match[], but also relieve maintainer's review burden?

> +					     "amlogic,meson-s4-uart";

> +				reg = <0x0 0x78000 0x0 0x18>;
> +				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +			};
> +		};
> +
> +	};
> +};
> --
> 2.41.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
