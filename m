Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09101628C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiKNWzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 17:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKNWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:54:58 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493918E15;
        Mon, 14 Nov 2022 14:54:56 -0800 (PST)
Received: from [192.168.2.144] (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 471231F881;
        Mon, 14 Nov 2022 23:54:52 +0100 (CET)
Date:   Mon, 14 Nov 2022 23:54:46 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: Add basic support for BIQU CB1
To:     Jernej =?iso-8859-2?q?=A9krabec?= <jernej.skrabec@gmail.com>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Message-Id: <AZ0DLR.RINPITJM904E2@somainline.org>
In-Reply-To: <4534857.CvnuH1ECHv@jernej-laptop>
References: <20221114214452.1993744-1-martin.botka@somainline.org>
        <20221114214452.1993744-2-martin.botka@somainline.org>
        <4534857.CvnuH1ECHv@jernej-laptop>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 14 2022 at 11:30:17 PM +01:00:00, Jernej ©krabec 
<jernej.skrabec@gmail.com> wrote:
> Hi Martin,
> 
> I was just writing new e-mail as response to v2. You should wait at 
> least a
> day or two, usually more, before sending new version. Others will 
> likely have
> some more comments. And there is also no rush. Until PMIC series is 
> merged,
> this will not go anywhere. Since there is only this week until cut 
> off date for
> DT updates for kernel 6.2, it's most likely that this will land in 
> 6.3. And
> that gives as a few weeks (month) more.
Yep. Was hoping for 5.2 thus the frequent updates. Will take it slow 
then since 5.3 :)
> 
> See comments below.
> 
> Dne ponedeljek, 14. november 2022 ob 22:44:49 CET je Martin Botka 
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
> 
> H616 has only one HDMI output. Unless there is some additional chip 
> for some
> conversion, only one HDMI port can work.
Yes correct. But the Rpi adapter and Manta boards also support
Rpi Compute Module 4 which has 2 HDMI outputs.
The chip itself ofc doesnt support this on CB1. Same goes for DSI/CSI 
ports
on the boards and the 4x USB on Rpi adapter.

It is indeed a bit of a mess.
> 
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
>>  Changes in V3:
>>  Change copyright to me
>>  regulator_vcc5v to regulator-vcc5v
>>  Drop ehci0 and ohci0
>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>   .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 178 
>> ++++++++++++++++++
>>   2 files changed, 179 insertions(+)
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
>>  index 000000000000..86b5aca9b53e
>>  --- /dev/null
>>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>>  @@ -0,0 +1,178 @@
>>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>  +/*
>>  + * Copyright (C) 2022 Martin Botka <martin.botka@somainline.org>.
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
>>  +	reg_vcc5v: regulator-vcc5v {
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
> 
> Above property is not needed. If you don't provide vqmmc-supply with 
> 1.8 V
> regulator, it won't be used.
> 
>>  +	bus-width = <4>;
>>  +	status = "disabled";
> 
> Why is set to disabled? If it's not a typo, remove whole node. It 
> could be
> added later when it works.
Would not removing it also make PMIC node useless as the regulators 
wont be used and thus
should be technically removed ?
> 
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
> I just checked datasheet and it really seems that it supports only 
> I2C.
> Anyway, rather than using axp1530 compatible, introduce axp313a 
> compatible
> instead.
Will do in V2 for drivers later.
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
> 
> This one is most likely used by CPU. If so, you should set 
> appropriate range
> according to CPU needs, which are 810 - 1100 mV.
> 
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
> 
> This one is most likely used by GPU. Its range must also be adjusted 
> to GPU
> needs.
> 
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
> 
> This one looks like it supplies DRAM. You should set both min and max 
> to
> actual DRAM needs.
> 
>>  +				regulator-step-delay-us = <25>;
>>  +				regulator-final-delay-us = <50>;
>>  +				regulator-always-on;
>>  +			};
>>  +
>>  +			reg_aldo1: ldo1 {
> 
> ldo1 -> aldo1
> 
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
> 
> ldo2 -> dldo1
> 
> Another issue I see is that you marked all regulators with 
> regulator-always-
> on; While this works, I don't think this faithfully represent HW. For 
> example,
> GPU regulator will be enabled by GPU driver when needed, so it 
> shouldn't be
> marked with always on.
> 
> There is also RTCLDO, but without schematic it's impossible to say if 
> it is
> used or not.
> 
> There are at least a few clues in AXP313A datasheet about which 
> regulator is
> used for what. See chapter 7.5 in 
> https://github.com/bigtreetech/CB1-Kernel/
> blob/kernel-5.16/docs/AXP313A%20datasheet%20V0.1%20-
> %2020201105_draft%20version.pdf
As for regulators themselves. I have kept them as what downstream 
kernel specifies.
But until I have schematic in hand and can confirm that they actually 
used the correct regulators in
the correct place i will stick to stock values. If they in the end 
decide to not supply schematic or etc
to the public i can test with adjusted values.
> 
> Best regards,
> Jernej
> 
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
> 
> 
Best Regards,
Martin


