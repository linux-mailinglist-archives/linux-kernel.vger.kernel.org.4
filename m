Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6696B7DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCMQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCMQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:42:27 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64829E0B;
        Mon, 13 Mar 2023 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678725741;
        bh=wt7iUzJTKN3AxLs39WMRr+BQIVPXOku2SH0wkSYlUPI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JcZBTYLXN2U/SIWvpb9EEgIHjxJ4Fe5ZHE9a9VeUJh+sYDzbgzWyRGAcN9qgUh91Y
         AM1kL0ngLmq3qVLCKC8ml4ZbBIt+pFiBHyaqMSpEX3pEC2kEn1AXQiFzpd5WstnuQO
         7hev1m73vYXY8Ug1MdlVALBxZHQc0IP6anwpC3hs=
Received: from [10.0.29.154] (unknown [10.0.29.154])
        by uho.ysoft.cz (Postfix) with ESMTP id 46502A0430;
        Mon, 13 Mar 2023 17:42:21 +0100 (CET)
Message-ID: <6a942ff5-4bf4-ae23-fe78-900d1965e821@ysoft.com>
Date:   Mon, 13 Mar 2023 17:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_5/6=5d_ARM=3a_dts=3a_imx6dl-yapp43=3a_Add_?=
 =?UTF-8?Q?support_for_new_HW_revision_of_the_IOTA=c2=a0board?=
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-6-michal.vokac@ysoft.com>
 <20230313082348.GM143566@dragon>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <20230313082348.GM143566@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 03. 23 9:23, Shawn Guo wrote:
> On Fri, Feb 10, 2023 at 04:48:54PM +0100, Michal Vokáč wrote:
>> The PCB used for all the current boards (Ursa, Draco, Hydra, Orion, Crux)
>> was slightly redesigned and delivers some new features while some unused
>> components were removed.
>>
>> - External RTC chip with supercap added.
>> - Secure element added.
>> - LCD display power supply enable/disable signal added.
>> - Touch keyboard reset and interrupt signals added.
>> - Factory reset GPIO button added.
>> - Audio codec LM49350 (EoL) removed and replaced by PWM audio output.
>> - QCA8334 switch was replaced by Marvell 88E6141.
>> - PCIe completely removed.
>> - uSD card removed and replaced by board-to-board expansion connector.
>>
>> There are four configuration variants of the new board:
>>
>> 1. Pegasus
>> The board configuration is based on Orion with the following major changes:
>>
>> - Quad core SoC
>> - 4GB of RAM
>> - RTC with supercap added
>> - Secure element added
>>
>> 2. Pegasus+
>> This is the very same board as Pegasus but uses the i.MX6QuadPlus SoC.
>>
>> 3. Lynx
>> The board configuration is based on Draco with the following major changes:
>>
>> - DualLite SoC
>> - 1GB of RAM
>> - RTC with supercap added
>> - Secure element added
>>
>> 4. Phoenix
>> The board configuration is based on Ursa with the following major changes:
>>
>> - DualLite Soc
>> - 1GB of RAM
>> - RTC with supercap added
>> - Secure element added
>> - LCD display support removed
>> - UART2 removed
>> - Factory reset GPIO button added
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   arch/arm/boot/dts/Makefile                    |   4 +
>>   arch/arm/boot/dts/imx6dl-yapp4-lynx.dts       |  58 ++
>>   arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts    |  42 ++
>>   arch/arm/boot/dts/imx6dl-yapp43-common.dtsi   | 619 ++++++++++++++++++
>>   arch/arm/boot/dts/imx6q-yapp4-pegasus.dts     |  58 ++
>>   .../boot/dts/imx6qp-yapp4-pegasus-plus.dts    |  58 ++
>>   6 files changed, 839 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
>>   create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
>>   create mode 100644 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
>>   create mode 100644 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
>>   create mode 100644 arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index d08a3c450ce7..9a60d3fc0483 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -558,7 +558,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>   	imx6dl-wandboard-revd1.dtb \
>>   	imx6dl-yapp4-draco.dtb \
>>   	imx6dl-yapp4-hydra.dtb \
>> +	imx6dl-yapp4-lynx.dtb \
>>   	imx6dl-yapp4-orion.dtb \
>> +	imx6dl-yapp4-phoenix.dtb \
>>   	imx6dl-yapp4-ursa.dtb \
>>   	imx6q-apalis-eval.dtb \
>>   	imx6q-apalis-ixora.dtb \
>> @@ -625,6 +627,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>   	imx6q-nitrogen6_max.dtb \
>>   	imx6q-nitrogen6_som2.dtb \
>>   	imx6q-novena.dtb \
>> +	imx6q-yapp4-pegasus.dtb \
>>   	imx6q-phytec-mira-rdk-emmc.dtb \
> 
> Break the alphabetic order?

Sorry, for some reason I missed that line. Will be fixed in v2.
> 
>>   	imx6q-phytec-mira-rdk-nand.dtb \
>>   	imx6q-phytec-pbab01.dtb \
>> @@ -680,6 +683,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>   	imx6qp-vicutp.dtb \
>>   	imx6qp-wandboard-revd1.dtb \
>>   	imx6qp-yapp4-crux-plus.dtb \
>> +	imx6qp-yapp4-pegasus-plus.dtb \
>>   	imx6qp-zii-rdu2.dtb \
>>   	imx6s-dhcom-drc02.dtb
>>   dtb-$(CONFIG_SOC_IMX6SL) += \

[...snip...]

>> diff --git a/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
>> new file mode 100644
>> index 000000000000..30f354195e01
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
>> @@ -0,0 +1,619 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2021 Y Soft Corporation, a.s.
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>> +/ {
>> +	aliases: aliases {
>> +		ethernet1 = &eth1;
>> +		ethernet2 = &eth2;
>> +		mmc0 = &usdhc3;
>> +		mmc1 = &usdhc4;
>> +	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
>> +		brightness-levels = <0 32 64 128 255>;
>> +		default-brightness-level = <32>;
>> +		num-interpolated-steps = <8>;
>> +		power-supply = <&sw2_reg>;
>> +		status = "disabled";
>> +	};
>> +
>> +	gpio_keys: gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpio_keys>;
>> +		status = "disabled";
>> +
>> +		button {
>> +			label = "Factory RESET";
>> +			linux,code = <BTN_0>;
>> +			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	lcd_display: display {
>> +		compatible = "fsl,imx-parallel-display";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		interface-pix-fmt = "rgb24";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_ipu1>;
>> +		status = "disabled";
>> +
>> +		port@0 {
>> +			reg = <0>;
>> +
>> +			lcd_display_in: endpoint {
>> +				remote-endpoint = <&ipu1_di0_disp0>;
>> +			};
>> +		};
>> +
>> +		port@1 {
>> +			reg = <1>;
>> +
>> +			lcd_display_out: endpoint {
>> +				remote-endpoint = <&lcd_panel_in>;
>> +			};
>> +		};
>> +	};
>> +
>> +	panel: panel {
>> +		compatible = "dataimage,scf0700c48ggu18";
>> +		power-supply = <&sw2_reg>;
>> +		backlight = <&backlight>;
>> +		enable-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
>> +		status = "disabled";
>> +
>> +		port {
>> +			lcd_panel_in: endpoint {
>> +				remote-endpoint = <&lcd_display_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	reg_usb_h1_vbus: regulator-usb-h1-vbus {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usbh1_vbus>;
>> +		regulator-name = "usb_h1_vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		status = "disabled";
>> +	};
>> +
>> +	reg_usb_otg_vbus: regulator-usb-otg-vbus {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usbotg_vbus>;
>> +		regulator-name = "usb_otg_vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&fec {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet>;
>> +	phy-mode = "rgmii-id";
>> +	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
>> +	phy-reset-duration = <20>;
> 
> Deprecated.  Check Documentation/devicetree/bindings/net/fsl,fec.yaml.

OK, I will remove the reset-duration property and move
the reset-gpios property under the mdio switch subnode.

>> +	phy-supply = <&sw2_reg>;
>> +	status = "okay";
>> +
>> +	fixed-link {
>> +		speed = <1000>;
>> +		full-duplex;
>> +	};
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		switch@0 {
>> +			compatible = "marvell,mv88e6085";
>> +			reg = <0>;
>> +
>> +			switch_ports: ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				ethphy0: port@0 {
>> +					reg = <0>;
>> +					label = "cpu";
>> +					phy-mode = "rgmii-id";
>> +					ethernet = <&fec>;
>> +
>> +					fixed-link {
>> +						speed = <1000>;
>> +						full-duplex;
>> +					};
>> +				};
>> +
>> +				eth2: port@1 {
>> +					reg = <1>;
>> +					label = "eth2";
>> +					phy-handle = <&phy_port1>;
>> +				};
>> +
>> +				eth1: port@2 {
>> +					reg = <2>;
>> +					label = "eth1";
>> +					phy-handle = <&phy_port2>;
>> +				};
>> +			};
>> +
>> +			mdio {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				phy_port1: switchphy@11 {
>> +					reg = <0x11>;
>> +				};
>> +
>> +				phy_port2: switchphy@12 {
>> +					reg = <0x12>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	status = "okay";
>> +
>> +	pmic@8 {
>> +		compatible = "fsl,pfuze200";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		reg = <0x8>;
>> +
>> +		regulators {
>> +			sw1a_reg: sw1ab {
>> +				regulator-min-microvolt = <300000>;
>> +				regulator-max-microvolt = <1875000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <6250>;
>> +			};
>> +
>> +			sw2_reg: sw2 {
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			sw3a_reg: sw3a {
>> +				regulator-min-microvolt = <400000>;
>> +				regulator-max-microvolt = <1975000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			sw3b_reg: sw3b {
>> +				regulator-min-microvolt = <400000>;
>> +				regulator-max-microvolt = <1975000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			swbst_reg: swbst {
>> +				regulator-min-microvolt = <5000000>;
>> +				regulator-max-microvolt = <5150000>;
>> +			};
>> +
>> +			vgen1_reg: vgen1 {
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1550000>;
>> +			};
>> +
>> +			vgen2_reg: vgen2 {
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1550000>;
>> +			};
>> +
>> +			vgen3_reg: vgen3 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen4_reg: vgen4 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen5_reg: vgen5 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen6_reg: vgen6 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vref_reg: vrefddr {
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vsnvs_reg: vsnvs {
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <3000000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +		};
>> +	};
>> +
>> +	leds: led-controller@30 {
>> +		compatible = "ti,lp5562";
>> +		reg = <0x30>;
>> +		clock-mode = /bits/ 8 <1>;
>> +		status = "disabled";
> 
> Move 'status' to the end of property list.

Hmm, I am little bit surprised it is sorted like that.
I always put the status to the end. I am going to blame
author of the commit: b86d3d21cd4c (ARM: dts: imx6dl-yapp4:
Add reg property to the lp5562 channel node, 2020-08-12).

I will fix that in v2.

>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		led@0 {
>> +			chan-name = "R";
>> +			led-cur = /bits/ 8 <0x20>;
>> +			max-cur = /bits/ 8 <0x60>;
>> +			reg = <0>;
>> +			color = <LED_COLOR_ID_RED>;
>> +		};
>> +
>> +		led@1 {
>> +			chan-name = "G";
>> +			led-cur = /bits/ 8 <0x20>;
>> +			max-cur = /bits/ 8 <0x60>;
>> +			reg = <1>;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +		};
>> +
>> +		led@2 {
>> +			chan-name = "B";
>> +			led-cur = /bits/ 8 <0x20>;
>> +			max-cur = /bits/ 8 <0x60>;
>> +			reg = <2>;
>> +			color = <LED_COLOR_ID_BLUE>;
>> +		};
>> +	};
>> +
>> +	eeprom@57 {
>> +		compatible = "atmel,24c128";
>> +		reg = <0x57>;
>> +		pagesize = <64>;
>> +		status = "okay";
> 
> The "okay" status is only needed to flip a "disabled" one.

OK, I will remove the status "okay" from all device nodes defined
by this dtsi that should be enabled by default.

I assume that using status "okay" (or "disabled") for referenced
nodes coming from included SoC dtsi files is fine even if these
nodes already have the required status at the moment.

Otherwise I see no guarantee that the node will have my required
status in the future as well. The status in the included files
may be changed by someone else for whatever reason.

>> +	};
>> +
>> +	touchscreen: touchscreen@5c {
>> +		compatible = "pixcir,pixcir_tangoc";
>> +		reg = <0x5c>;
>> +		pinctrl-0 = <&pinctrl_touch>;
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>> +		attb-gpio = <&gpio4 5 GPIO_ACTIVE_HIGH>;
>> +		reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>> +		touchscreen-size-x = <800>;
>> +		touchscreen-size-y = <480>;
>> +		status = "disabled";
>> +	};
>> +
>> +	rtc: rtc@68 {
>> +		compatible = "dallas,ds1341";
>> +		reg = <0x68>;
>> +		status = "okay";
> 
> Ditto
> 
> Shawn

ACK, will remove it in v2.
Thank you for the review.

Michal

[...snip...]
