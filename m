Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD476B7111
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCMIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:24:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66712303DB;
        Mon, 13 Mar 2023 01:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC12EB80E3C;
        Mon, 13 Mar 2023 08:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B50BC433EF;
        Mon, 13 Mar 2023 08:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678695836;
        bh=qoyyqFTBmio9iuREDsppO/pSpASeAglT5N8qHENTGJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pi6wXdbqwrhYwoWuP7JTqaxtSfbchBjSK50zLM4iE8yGcdSyJCe7IRHfsN44vKp6u
         nnBCjYY2erDWSlUN2/ANL77ORA//JVsgp83ylx19Y3dBtJ1IU2x+a7m9ONoMm2AtaT
         WUJCQsKh+kBJKMsXJco7iWlSm6/c1kBXcfqFFqlStld0pbpTyldYBippzGNz0Jd5fz
         b+JyhsTf//uS9/dVl0scnXyRQFQ4pTWTGQHKV7bsEBTRjYqOnFJAo/ed8UqmYpsi/X
         NLRKFYGxtMrG8p/Ea/QJK8WAppgrvYEwJSMgiKTyo1zdYVB1uXWuFgYjAz/B2qmK0A
         rSfCvctfIErTg==
Date:   Mon, 13 Mar 2023 16:23:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] ARM: dts: =?iso-8859-1?Q?i?=
 =?iso-8859-1?Q?mx6dl-yapp43=3A_Add_support_for_new_HW_revision_of_the_IOT?=
 =?iso-8859-1?Q?A=A0board?=
Message-ID: <20230313082348.GM143566@dragon>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-6-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230210154855.3086900-6-michal.vokac@ysoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:48:54PM +0100, Michal Vokáč wrote:
> The PCB used for all the current boards (Ursa, Draco, Hydra, Orion, Crux)
> was slightly redesigned and delivers some new features while some unused
> components were removed.
> 
> - External RTC chip with supercap added.
> - Secure element added.
> - LCD display power supply enable/disable signal added.
> - Touch keyboard reset and interrupt signals added.
> - Factory reset GPIO button added.
> - Audio codec LM49350 (EoL) removed and replaced by PWM audio output.
> - QCA8334 switch was replaced by Marvell 88E6141.
> - PCIe completely removed.
> - uSD card removed and replaced by board-to-board expansion connector.
> 
> There are four configuration variants of the new board:
> 
> 1. Pegasus
> The board configuration is based on Orion with the following major changes:
> 
> - Quad core SoC
> - 4GB of RAM
> - RTC with supercap added
> - Secure element added
> 
> 2. Pegasus+
> This is the very same board as Pegasus but uses the i.MX6QuadPlus SoC.
> 
> 3. Lynx
> The board configuration is based on Draco with the following major changes:
> 
> - DualLite SoC
> - 1GB of RAM
> - RTC with supercap added
> - Secure element added
> 
> 4. Phoenix
> The board configuration is based on Ursa with the following major changes:
> 
> - DualLite Soc
> - 1GB of RAM
> - RTC with supercap added
> - Secure element added
> - LCD display support removed
> - UART2 removed
> - Factory reset GPIO button added
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   4 +
>  arch/arm/boot/dts/imx6dl-yapp4-lynx.dts       |  58 ++
>  arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts    |  42 ++
>  arch/arm/boot/dts/imx6dl-yapp43-common.dtsi   | 619 ++++++++++++++++++
>  arch/arm/boot/dts/imx6q-yapp4-pegasus.dts     |  58 ++
>  .../boot/dts/imx6qp-yapp4-pegasus-plus.dts    |  58 ++
>  6 files changed, 839 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
>  create mode 100644 arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d08a3c450ce7..9a60d3fc0483 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -558,7 +558,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-wandboard-revd1.dtb \
>  	imx6dl-yapp4-draco.dtb \
>  	imx6dl-yapp4-hydra.dtb \
> +	imx6dl-yapp4-lynx.dtb \
>  	imx6dl-yapp4-orion.dtb \
> +	imx6dl-yapp4-phoenix.dtb \
>  	imx6dl-yapp4-ursa.dtb \
>  	imx6q-apalis-eval.dtb \
>  	imx6q-apalis-ixora.dtb \
> @@ -625,6 +627,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-nitrogen6_max.dtb \
>  	imx6q-nitrogen6_som2.dtb \
>  	imx6q-novena.dtb \
> +	imx6q-yapp4-pegasus.dtb \
>  	imx6q-phytec-mira-rdk-emmc.dtb \

Break the alphabetic order?

>  	imx6q-phytec-mira-rdk-nand.dtb \
>  	imx6q-phytec-pbab01.dtb \
> @@ -680,6 +683,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6qp-vicutp.dtb \
>  	imx6qp-wandboard-revd1.dtb \
>  	imx6qp-yapp4-crux-plus.dtb \
> +	imx6qp-yapp4-pegasus-plus.dtb \
>  	imx6qp-zii-rdu2.dtb \
>  	imx6s-dhcom-drc02.dtb
>  dtb-$(CONFIG_SOC_IMX6SL) += \
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts b/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
> new file mode 100644
> index 000000000000..5c2cd517589b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2021 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6dl-yapp43-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Lynx i.MX6DualLite board";
> +	compatible = "ysoft,imx6dl-yapp4-lynx", "fsl,imx6dl";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x40000000>;
> +	};
> +};
> +
> +&backlight {
> +	status = "okay";
> +};
> +
> +&lcd_display {
> +	status = "okay";
> +};
> +
> +&leds {
> +	status = "okay";
> +};
> +
> +&panel {
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&reg_usb_h1_vbus {
> +	status = "okay";
> +};
> +
> +&touchscreen {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts b/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
> new file mode 100644
> index 000000000000..e0292f11d03e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2021 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6dl-yapp43-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Phoenix i.MX6DualLite board";
> +	compatible = "ysoft,imx6dl-yapp4-phoenix", "fsl,imx6dl";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x40000000>;
> +	};
> +};
> +
> +&aliases {
> +	/delete-property/ ethernet1;
> +};
> +
> +&gpio_keys {
> +	status = "okay";
> +};
> +
> +&reg_usb_h1_vbus {
> +	status = "okay";
> +};
> +
> +&switch_ports {
> +	/delete-node/ port@2;
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
> new file mode 100644
> index 000000000000..30f354195e01
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
> @@ -0,0 +1,619 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2021 Y Soft Corporation, a.s.
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	aliases: aliases {
> +		ethernet1 = &eth1;
> +		ethernet2 = &eth2;
> +		mmc0 = &usdhc3;
> +		mmc1 = &usdhc4;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
> +		brightness-levels = <0 32 64 128 255>;
> +		default-brightness-level = <32>;
> +		num-interpolated-steps = <8>;
> +		power-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +		status = "disabled";
> +
> +		button {
> +			label = "Factory RESET";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	lcd_display: display {
> +		compatible = "fsl,imx-parallel-display";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ipu1>;
> +		status = "disabled";
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			lcd_display_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			lcd_display_out: endpoint {
> +				remote-endpoint = <&lcd_panel_in>;
> +			};
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "dataimage,scf0700c48ggu18";
> +		power-supply = <&sw2_reg>;
> +		backlight = <&backlight>;
> +		enable-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint = <&lcd_display_out>;
> +			};
> +		};
> +	};
> +
> +	reg_usb_h1_vbus: regulator-usb-h1-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbh1_vbus>;
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		status = "disabled";
> +	};
> +
> +	reg_usb_otg_vbus: regulator-usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbotg_vbus>;
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		status = "okay";
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii-id";
> +	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <20>;

Deprecated.  Check Documentation/devicetree/bindings/net/fsl,fec.yaml.

> +	phy-supply = <&sw2_reg>;
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		switch@0 {
> +			compatible = "marvell,mv88e6085";
> +			reg = <0>;
> +
> +			switch_ports: ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ethphy0: port@0 {
> +					reg = <0>;
> +					label = "cpu";
> +					phy-mode = "rgmii-id";
> +					ethernet = <&fec>;
> +
> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +					};
> +				};
> +
> +				eth2: port@1 {
> +					reg = <1>;
> +					label = "eth2";
> +					phy-handle = <&phy_port1>;
> +				};
> +
> +				eth1: port@2 {
> +					reg = <2>;
> +					label = "eth1";
> +					phy-handle = <&phy_port2>;
> +				};
> +			};
> +
> +			mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				phy_port1: switchphy@11 {
> +					reg = <0x11>;
> +				};
> +
> +				phy_port2: switchphy@12 {
> +					reg = <0x12>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	pmic@8 {
> +		compatible = "fsl,pfuze200";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		reg = <0x8>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3a_reg: sw3a {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3b_reg: sw3b {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vsnvs_reg: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	leds: led-controller@30 {
> +		compatible = "ti,lp5562";
> +		reg = <0x30>;
> +		clock-mode = /bits/ 8 <1>;
> +		status = "disabled";

Move 'status' to the end of property list.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@0 {
> +			chan-name = "R";
> +			led-cur = /bits/ 8 <0x20>;
> +			max-cur = /bits/ 8 <0x60>;
> +			reg = <0>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +
> +		led@1 {
> +			chan-name = "G";
> +			led-cur = /bits/ 8 <0x20>;
> +			max-cur = /bits/ 8 <0x60>;
> +			reg = <1>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@2 {
> +			chan-name = "B";
> +			led-cur = /bits/ 8 <0x20>;
> +			max-cur = /bits/ 8 <0x60>;
> +			reg = <2>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +	};
> +
> +	eeprom@57 {
> +		compatible = "atmel,24c128";
> +		reg = <0x57>;
> +		pagesize = <64>;
> +		status = "okay";

The "okay" status is only needed to flip a "disabled" one.

> +	};
> +
> +	touchscreen: touchscreen@5c {
> +		compatible = "pixcir,pixcir_tangoc";
> +		reg = <0x5c>;
> +		pinctrl-0 = <&pinctrl_touch>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +		attb-gpio = <&gpio4 5 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +		status = "disabled";
> +	};
> +
> +	rtc: rtc@68 {
> +		compatible = "dallas,ds1341";
> +		reg = <0x68>;
> +		status = "okay";

Ditto

Shawn

> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "disabled";
> +
> +	oled_1309: oled@3c {
> +		compatible = "solomon,ssd1309fb-i2c";
> +		reg = <0x3c>;
> +		solomon,height = <64>;
> +		solomon,width = <128>;
> +		solomon,page-offset = <0>;
> +		solomon,segment-no-remap;
> +		solomon,prechargep2 = <15>;
> +		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
> +		vbat-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +
> +	oled_1305: oled@3d {
> +		compatible = "solomon,ssd1305fb-i2c";
> +		reg = <0x3d>;
> +		solomon,height = <64>;
> +		solomon,width = <128>;
> +		solomon,page-offset = <0>;
> +		solomon,col-offset = <4>;
> +		solomon,prechargep2 = <15>;
> +		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
> +		vbat-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +
> +	gpio_oled: gpio@41 {
> +		compatible = "nxp,pca9536";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		reg = <0x41>;
> +		vcc-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +
> +	touchkeys: keys@5a {
> +		compatible = "fsl,mpr121-touchkey";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touchkeys>;
> +		reg = <0x5a>;
> +		vdd-supply = <&sw2_reg>;
> +		autorepeat;
> +		linux,keycodes = <KEY_1>, <KEY_2>, <KEY_3>, <KEY_4>, <KEY_5>,
> +				<KEY_6>, <KEY_7>, <KEY_8>, <KEY_9>,
> +				<KEY_BACKSPACE>, <KEY_0>, <KEY_ENTER>;
> +		poll-interval = <50>;
> +		status = "disabled";
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b020
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b020
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b020
> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b020
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b020
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b020
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b020
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b020
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b020
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b020
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b020
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b020
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b020
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b020
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b010
> +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x1b010
> +			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b899
> +			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b899
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_3__I2C3_SCL	0x4001b899
> +			MX6QDL_PAD_GPIO_6__I2C3_SDA	0x4001b899
> +		>;
> +	};
> +
> +	pinctrl_ipu1: ipu1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_DA7__GPIO3_IO07                  0x1b0b0
> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
> +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
> +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
> +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
> +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
> +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
> +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
> +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
> +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_18__GPIO7_IO13	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
> +		>;
> +	};
> +
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_19__GPIO4_IO05	0x1b098
> +			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_touchkeys: touchkeysgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b098
> +			MX6QDL_PAD_GPIO_5__GPIO1_IO05	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0a8
> +			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0a8
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_7__UART2_TX_DATA	0x1b098
> +			MX6QDL_PAD_GPIO_8__UART2_RX_DATA	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_usbh1: usbh1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D30__USB_H1_OC	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_usbh1_vbus: usbh1-vbus {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x98
> +		>;
> +	};
> +
> +	pinctrl_usbotg: usbotggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x1b098
> +			MX6QDL_PAD_EIM_D21__USB_OTG_OC		0x1b098
> +		>;
> +	};
> +
> +	pinctrl_usbotg_vbus: usbotg-vbus {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x98
> +		>;
> +	};
> +
> +	pinctrl_usdhc4: usdhc4grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_CMD__SD4_CMD	0x1f069
> +			MX6QDL_PAD_SD4_CLK__SD4_CLK	0x10069
> +			MX6QDL_PAD_SD4_DAT0__SD4_DATA0	0x17069
> +			MX6QDL_PAD_SD4_DAT1__SD4_DATA1	0x17069
> +			MX6QDL_PAD_SD4_DAT2__SD4_DATA2	0x17069
> +			MX6QDL_PAD_SD4_DAT3__SD4_DATA3	0x17069
> +			MX6QDL_PAD_SD4_DAT4__SD4_DATA4	0x17069
> +			MX6QDL_PAD_SD4_DAT5__SD4_DATA5	0x17069
> +			MX6QDL_PAD_SD4_DAT6__SD4_DATA6	0x17069
> +			MX6QDL_PAD_SD4_DAT7__SD4_DATA7	0x17069
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_1__WDOG2_B	0x1b0b0
> +		>;
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&lcd_display_in>;
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "disabled";
> +};
> +
> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	over-current-active-low;
> +	status = "disabled";
> +};
> +
> +&usbotg {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	over-current-active-low;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	fsl,tx-d-cal = <106>;
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	fsl,tx-d-cal = <109>;
> +	status = "disabled";
> +};
> +
> +&usdhc4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc4>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	vmmc-supply = <&sw2_reg>;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	status = "disabled";
> +};
> +
> +&wdog2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts b/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
> new file mode 100644
> index 000000000000..ec6651ba4ba2
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2021 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include "imx6dl-yapp43-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Pegasus i.MX6Quad board";
> +	compatible = "ysoft,imx6q-yapp4-pegasus", "fsl,imx6q";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0xf0000000>;
> +	};
> +};
> +
> +&gpio_oled {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&leds {
> +	status = "okay";
> +};
> +
> +&oled_1305 {
> +	status = "okay";
> +};
> +
> +&oled_1309 {
> +	status = "okay";
> +};
> +
> +&reg_pu {
> +	regulator-always-on;
> +};
> +
> +&reg_usb_h1_vbus {
> +	status = "okay";
> +};
> +
> +&touchkeys {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts b/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
> new file mode 100644
> index 000000000000..4a961a33bf2d
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2021 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6qp.dtsi"
> +#include "imx6dl-yapp43-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Pegasus+ i.MX6QuadPlus board";
> +	compatible = "ysoft,imx6qp-yapp4-pegasus-plus", "fsl,imx6qp";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0xf0000000>;
> +	};
> +};
> +
> +&gpio_oled {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&leds {
> +	status = "okay";
> +};
> +
> +&oled_1305 {
> +	status = "okay";
> +};
> +
> +&oled_1309 {
> +	status = "okay";
> +};
> +
> +&reg_pu {
> +	regulator-always-on;
> +};
> +
> +&reg_usb_h1_vbus {
> +	status = "okay";
> +};
> +
> +&touchkeys {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	status = "okay";
> +};
> -- 
> 2.25.1
> 
