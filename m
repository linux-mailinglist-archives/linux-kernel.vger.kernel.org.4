Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282246FDE20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjEJMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjEJMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:52:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD1659D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:52:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pwjIK-0001K5-6f; Wed, 10 May 2023 14:51:48 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pwjIF-0005Aq-TN; Wed, 10 May 2023 14:51:43 +0200
Date:   Wed, 10 May 2023 14:51:43 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     krzysztof.kozlowski@linaro.org, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 1/3] arm64: dts: Add device tree for the Emtop SOM
 IMX8MM
Message-ID: <20230510125143.p7adxxhyttuzshfw@pengutronix.de>
References: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
 <20230510112347.3766247-2-himanshu.bhavani@siliconsignals.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510112347.3766247-2-himanshu.bhavani@siliconsignals.io>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-05-10, Himanshu Bhavani wrote:
> Add a device tree file describing the Emtop SOM IMX8MM
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../arm64/boot/dts/freescale/imx8mm-emtop.dts | 261 ++++++++++++++++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 198fff3731ae..36590515fbc1 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> new file mode 100644
> index 000000000000..461e1ef5dcb4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Emtop
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Emtop SOM i.MX8MM";
> +	compatible = "emtop,imx8mm-emtop", "fsl,imx8mm";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};

The nodes should be ordered alphabetical only exception is the iomuxc at
the end.

Regards,
  Marco

> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck3: BUCK3 {
> +				regulator-name = "BUCK3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <945000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1710000>;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <945000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <3600000>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_gpio_led: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
> +			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL				0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA				0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicirq {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3			0x41
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX			0x140
> +			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX			0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x190
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d0
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d0
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d0
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d0
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d0
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x194
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d4
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d4
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d4
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d4
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d4
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x196
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d6
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d6
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d6
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d6
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d6
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d6
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d6
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d6
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d6
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x196
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B			0xc6
> +		>;
> +	};
> +};
> -- 
> 2.25.1
> 
> 
> 
