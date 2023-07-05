Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71E747F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGEIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjGEIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:25:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD841710;
        Wed,  5 Jul 2023 01:25:41 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA26D6606FAA;
        Wed,  5 Jul 2023 09:25:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688545540;
        bh=5y5cHr9U6mJvvsu4JGIZRqPBdqSpfmRDfG3XLf9+IbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hB9uS9ejhdDbC5VZo9aDr4wFOT+cFIRzLMO965jd94TKzdS0koxgkhxtaWAytS9c8
         /P18GUKMp2SbZs7Xj0KpHnaV4zi+wINljiSYIfJpdZkIU24cGH8TYas4A37xZB8d53
         Gc3+Zo7lSxmOcO9UtcZFxgYtPkRzlQOTDT1cvs+81BpfgjI26b5OeVKKRQ9CT8a9P9
         buBcuog0Z5YJ8ykeGbQOEoo9+qVbIacXTSy+SoV+23Haw4QFghKKwuFb6nHiD6i7PY
         MgHYdNGwtdjDnptWpFK2tdUnCM1v+c1/nJhn750B0U3WquJLIUNRBZG1aYzxGn2N+l
         OE8sBcjU1WiqA==
Message-ID: <123eb649-f3f7-7751-9b02-553bd11a97a8@collabora.com>
Date:   Wed, 5 Jul 2023 10:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230705065744.25848-1-jason-ch.chen@mediatek.com>
 <20230705065744.25848-4-jason-ch.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230705065744.25848-4-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/07/23 08:57, Jason-ch Chen ha scritto:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8188 on evaluation board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 402 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 926 ++++++++++++++++++++
>   3 files changed, 1329 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c99c3372a4b5..9bd2324259a3 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> new file mode 100644
> index 000000000000..d3872196200a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8188 evaluation board";
> +	compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial0:115200n8";
> +		kaslr-seed = <0 0>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scp_mem_reserved: scp_mem_region {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&auxadc {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_default_pins>;
> +	pinctrl-1 = <&mmc0_uhs_pins>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	supports-cqe;
> +	cap-mmc-hw-reset;
> +	no-sdio;
> +	no-sd;
> +	hs400-ds-delay = <0x1481b>;
> +	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
> +	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
> +	non-removable;
> +};
> +
> +&mt6359_vbbck_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcn33_2_bt_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcore_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vufs_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&nor_flash {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nor_pins_default>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <52000000>;
> +	};
> +};
> +
> +&pio {
> +	adsp_uart_pins: adsp-uart-pins {
> +		pins_adsp_uart {

Please, no underscores. This should be `pins-adsp-uart`

> +			pinmux = <PINMUX_GPIO35__FUNC_O_ADSP_UTXD0>,
> +				 <PINMUX_GPIO36__FUNC_I1_ADSP_URXD0>;
> +		};
> +	};
> +
> +	i2c0_pins: i2c0-pins {
> +		pins_bus {

pins-bus

> +			pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>,
> +				 <PINMUX_GPIO55__FUNC_B1_SCL0>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
> +		};
> +	};
> +

..snip..

> +
> +	mmc0_default_pins: mmc0-default-pins {
> +		pins_cmd_dat {

pins-cmd-dat

> +			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
> +				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
> +				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
> +				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
> +				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
> +				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
> +				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
> +				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
> +				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_6mA>;

You don't need the MTK_DRIVE_(x)mA definitions here because:
1. The drive-strength property expresses values in milliamperes,
    for more information, check its description at pincfg-node.yaml;
2. Those definitions are mapping to mA values anyway, so, for example,
    MTK_DRIVE_6mA == 6, MTK_DRIVE_28mA == 28, etc.

This means that you can write this as:

			drive-strength = <6>;

please fix.

> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +

..snip..

> +
> +&pmic {
> +	interrupt-parent = <&pio>;
> +	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;

You can do that in one line instead:

	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;

> +};
> +
> +&scp {
> +	memory-region = <&scp_mem_reserved>;
> +	status = "okay";
> +};
> +

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> new file mode 100644
> index 000000000000..8f042ffe0938
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -0,0 +1,926 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
> +#include <dt-bindings/power/mediatek,mt8188-power.h>
> +
> +/ {
> +	compatible = "mediatek,mt8188";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;

Can you please populate the cache properties?

i-cache-size, i-cache-line-size, i-cache-sets,
d-cache-size, d-cache-line-size, d-cache-sets are missing for all CPUs.

> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			clock-frequency = <2600000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78";
> +			reg = <0x700>;
> +			enable-method = "psci";
> +			clock-frequency = <2600000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core5 {
> +					cpu = <&cpu5>;
> +				};
> +			};
> +
> +			cluster1 {

This is wrong. This SoC uses ARM DynamIQ and combines both the big and LITTLE
CPUs in *one* single cluster.
Please fix.

> +				core0 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +

..snip..


> +
> +		pwrap: pwrap@10024000 {
> +			compatible = "mediatek,mt8195-pwrap", "syscon";

Please:

compatible = "mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap", "syscon";

> +			reg = <0 0x10024000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
> +				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
> +			clock-names = "spi", "wrap";
> +		};
> +

..snip..

> +		uart0: serial@11001100 {
> +			compatible = "mediatek,mt8188-uart",
> +				     "mediatek,mt6577-uart";

Those compatible strings fit in one line. 85 columns is ok.

> +			reg = <0 0x11001100 0 0x100>;
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART0>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +

..snip..

> +
> +		auxadc: adc@11002000 {
> +			compatible = "mediatek,mt8188-auxadc",
> +				     "mediatek,mt8173-auxadc";

89 columns is ok, fits in one line.

> +			reg = <0 0x11002000 0 0x1000>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_AUXADC>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		pericfg_ao: syscon@11003000 {
> +			compatible = "mediatek,mt8188-pericfg-ao", "syscon";
> +			reg = <0 0x11003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		spi0: spi@1100a000 {
> +			compatible = "mediatek,mt8188-spi-ipm",
> +				     "mediatek,spi-ipm";

Fits in one line.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +

..snip..

> +
> +		xhci1: usb@11200000 {
> +			compatible = "mediatek,mt8188-xhci",
> +				     "mediatek,mtk-xhci";

Fits in one line again.

> +			reg = <0 0x11200000 0 0x1000>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port1 PHY_TYPE_USB2>,
> +			       <&u3port1 PHY_TYPE_USB3>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_BUS>,
> +				 <&topckgen CLK_TOP_SSUSB_TOP_REF>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x468 2>;
> +			wakeup-source;
> +			status = "disabled";
> +		};
> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8188-mmc",
> +				     "mediatek,mt8183-mmc";

same here.

> +			reg = <0 0x11230000 0 0x10000>,
> +			      <0 0x11f50000 0 0x1000>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>,
> +				 <&infracfg_ao CLK_INFRA_AO_RG_AES_MSDCFDE_CK_0P>;
> +			clock-names = "source", "hclk", "source_cg", "crypto_clk";
> +			status = "disabled";
> +		};
> +

..snip..

> +
> +		xhci2: usb@112a0000 {
> +			compatible = "mediatek,mt8188-xhci",
> +				     "mediatek,mtk-xhci";

and here, and somewhere else as well.

Regards,
Angelo


