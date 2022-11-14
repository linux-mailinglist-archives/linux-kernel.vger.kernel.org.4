Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D55628A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiKNUic convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 15:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbiKNUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:38:21 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFE012088
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:38:18 -0800 (PST)
Received: from [192.168.2.144] (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4EF211F8D5;
        Mon, 14 Nov 2022 21:38:14 +0100 (CET)
Date:   Mon, 14 Nov 2022 21:38:08 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH V2 2/2] arm64: dts: Add basic support for BIQU CB1
To:     Jernej =?iso-8859-2?q?=A9krabec?= <jernej.skrabec@gmail.com>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Andrew Lunn <andrew@lunn.ch>,
        Conley Lee <conleylee@foxmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Message-Id: <KNUCLR.WTN1W6BOHHHQ@somainline.org>
In-Reply-To: <3191151.oiGErgHkdL@jernej-laptop>
References: <20221114172018.1876608-1-martin.botka@somainline.org>
        <20221114172018.1876608-2-martin.botka@somainline.org>
        <3191151.oiGErgHkdL@jernej-laptop>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 14 2022 at 09:16:29 PM +01:00:00, Jernej ©krabec 
<jernej.skrabec@gmail.com> wrote:
> Hi Martin,
> 
> Dne ponedeljek, 14. november 2022 ob 18:20:16 CET je Martin Botka 
> napisal(a):
>>  CB1 is Compute Module style board that plugs into Rpi board style 
>> adapter or
>>  Manta 3D printer boards (M4P/M8P).
>> 
>>  The board has:
>>  	H616 SoC
>>  	1GB of RAM
>>  	AXP313A PMIC
>> 
>>  And the actual boards that CB1 plugs in are just extension to it 
>> with ports
>>  and thus are not split in DT.
>> 
>>  Boards have:
>>  	4x (3x for Manta boards) USB and 1 USB OTG.
>>  	SDcard slot for loading images.
>>  	Ethernet port wired to the internal PHY.
>>  	2x HDMI 2.0.
>>  	Power and Status LEDs.
>> 
>>  Currently working:
>>  	Booting
>>  	USB
>>  	UART
>> 
>>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>  ---
>>  Changes in V2:
>>  Add proper board compatible
>>  Add regulator prefix for vcc5v
>>  Drop okay status from PMIC
>>  Drop standby_param
>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>   .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 186 
>> ++++++++++++++++++
>>   2 files changed, 187 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>> 
>>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
>>  b/arch/arm64/boot/dts/allwinner/Makefile index 
>> 6a96494a2e0a..223f1be73541
>>  100644
>>  --- a/arch/arm64/boot/dts/allwinner/Makefile
>>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>  @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>>  +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-biqu-cb1.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>>  diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts new file 
>> mode
>>  100644
>>  index 000000000000..297536d7629a
>>  --- /dev/null
>>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>>  @@ -0,0 +1,186 @@
>>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>  +/*
>>  + * Copyright (C) 2022 Arm Ltd.
> 
> I suppose Arm Ltd. has nothing to do with this board? Put yours 
> copyrights
> there.
Correct. Was a left over from Opi Zero 2 with just changed year. Will 
correct in V3 with the rest of the changes
> 
>>  + */
>>  +
>>  +/dts-v1/;
>>  +
>>  +#include "sun50i-h616.dtsi"
>>  +
>>  +#include <dt-bindings/gpio/gpio.h>
>>  +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>  +#include <dt-bindings/leds/common.h>
>>  +
>>  +/ {
>>  +	model = "BIQU CB1";
>>  +	compatible = "biqu,cb1", "allwinner,sun50i-h616";
>>  +
>>  +	aliases {
>>  +		serial0 = &uart0;
>>  +	};
>>  +
>>  +	chosen {
>>  +		stdout-path = "serial0:115200n8";
>>  +	};
>>  +
>>  +	leds {
>>  +		compatible = "gpio-leds";
>>  +
>>  +		led-0 {
>>  +			function = LED_FUNCTION_POWER;
>>  +			color = <LED_COLOR_ID_RED>;
>>  +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /*
> PC12 */
>>  +			default-state = "on";
>>  +		};
>>  +
>>  +		led-1 {
>>  +			function = LED_FUNCTION_STATUS;
>>  +			color = <LED_COLOR_ID_GREEN>;
>>  +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /*
> PC13 */
>>  +		};
>>  +	};
>>  +
>>  +	reg_vcc5v: regulator_vcc5v {
>>  +		/* board wide 5V supply directly from the USB-C socket
> */
>>  +		compatible = "regulator-fixed";
>>  +		regulator-name = "vcc-5v";
>>  +		regulator-min-microvolt = <5000000>;
>>  +		regulator-max-microvolt = <5000000>;
>>  +		regulator-always-on;
>>  +	};
>>  +
>>  +	reg_usb1_vbus: regulator-usb1-vbus {
>>  +		compatible = "regulator-fixed";
>>  +		regulator-name = "usb1-vbus";
>>  +		regulator-min-microvolt = <5000000>;
>>  +		regulator-max-microvolt = <5000000>;
>>  +		vin-supply = <&reg_vcc5v>;
>>  +		enable-active-high;
>>  +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
>>  +	};
>>  +};
>>  +
>>  +&ehci0 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ehci1 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ehci2 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ehci3 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&mmc0 {
>>  +	vmmc-supply = <&reg_dldo1>;
>>  +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
>>  +	no-1-8-v;
>>  +	bus-width = <4>;
>>  +	status = "disabled";
>>  +};
>>  +
>>  +&ohci0 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ohci1 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ohci2 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ohci3 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&r_i2c {
>>  +	status = "okay";
>>  +
>>  +	axp1530: pmic@36 {
>>  +		compatible = "x-powers,axp1530";
> 
> I see that you send driver for this PMIC separately. Next time please 
> mention
> that this series depends on another, otherwise checks will fail. Ping 
> us here
> once PMIC driver is merged to unblock this.
> 
> Anyway, RSB is prefered. Can you switch to it?
RSB does initialize but as soon as I try to give it the PMIC via RSB it 
doesnt really wanna work so thats a no sadly.
> 
>>  +		reg = <0x36>;
>>  +		wakeup-source;
>>  +
>>  +		regulators{
>>  +			reg_dcdc1: dcdc1 {
>>  +				regulator-name = "axp1530-dcdc1";
>>  +				regulator-min-microvolt =
> <500000>;
>>  +				regulator-max-microvolt =
> <3400000>;
>>  +				regulator-step-delay-us = <25>;
>>  +				regulator-final-delay-us = <50>;
>>  +				regulator-always-on;
>>  +			};
>>  +
>>  +			reg_dcdc2: dcdc2 {
>>  +				regulator-name = "axp1530-dcdc2";
>>  +				regulator-min-microvolt =
> <500000>;
>>  +				regulator-max-microvolt =
> <1540000>;
>>  +				regulator-step-delay-us = <25>;
>>  +				regulator-final-delay-us = <50>;
>>  +				regulator-ramp-delay = <200>;
>>  +				regulator-always-on;
>>  +			};
>>  +
>>  +			reg_dcdc3: dcdc3 {
>>  +				regulator-name = "axp1530-dcdc3";
>>  +				regulator-min-microvolt =
> <500000>;
>>  +				regulator-max-microvolt =
> <1840000>;
>>  +				regulator-step-delay-us = <25>;
>>  +				regulator-final-delay-us = <50>;
>>  +				regulator-always-on;
>>  +			};
>>  +
>>  +			reg_aldo1: ldo1 {
>>  +				regulator-name = "axp1530-aldo1";
>>  +				regulator-min-microvolt =
> <1800000>;
>>  +				regulator-max-microvolt =
> <1800000>;
>>  +				regulator-step-delay-us = <25>;
>>  +				regulator-final-delay-us = <50>;
>>  +				regulator-always-on;
>>  +			};
>>  +
>>  +			reg_dldo1: ldo2 {
>>  +				regulator-name = "axp1530-dldo1";
>>  +				regulator-min-microvolt =
> <3300000>;
>>  +				regulator-max-microvolt =
> <3300000>;
>>  +				regulator-step-delay-us = <25>;
>>  +				regulator-final-delay-us = <50>;
>>  +				regulator-always-on;
>>  +			};
>>  +		};
>>  +	};
>>  +};
>>  +
>>  +&uart0 {
>>  +	pinctrl-names = "default";
>>  +	pinctrl-0 = <&uart0_ph_pins>;
>>  +	status = "okay";
>>  +};
>>  +
>>  +&usbotg {
>>  +	/*
>>  +	 * PHY0 pins are connected to a USB-C socket, but a role switch
>>  +	 * is not implemented: both CC pins are pulled to GND.
>>  +	 * The VBUS pins power the device, so a fixed peripheral mode
>>  +	 * is the best choice.
>>  +	 * The board can be powered via GPIOs, in this case port0 *can*
>>  +	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
>>  +	 * then provided by the GPIOs. Any user of this setup would
>>  +	 * need to adjust the DT accordingly: dr_mode set to "host",
>>  +	 * enabling OHCI0 and EHCI0.
>>  +	 */
> 
> Above text is verbatim copy from OrangePi Zero2 and I'm not sure if 
> it is
> fully accurate for this board too. Looking at board photo, it surely 
> looks
> like this board has same USB design as Zero2. But if that's true, you
> shouldn't enable OHCI0 and EHCI0 nodes.
Correct. But M8P has a dip switch that enables or disables usbotg.
As for if it does anything its hard to say.
> 
> Is there any board schematic publicly available for this board?
This is one of the issues. Im in contact with BIQU and asking for the 
schematics.
I hope we can get them released ASAP as it would help me as well.
> 
> Best regards,
> Jernej
> 
>>  +	dr_mode = "peripheral";
>>  +	status = "okay";
>>  +};
>>  +
>>  +&usbphy {
>>  +	usb1_vbus-supply = <&reg_usb1_vbus>;
>>  +	status = "okay";
>>  +};
> 
> 
Best Regards,
Martin


