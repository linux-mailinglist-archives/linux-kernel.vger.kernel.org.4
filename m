Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780246294F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiKOJzm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 04:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiKOJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:55:31 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4466013F29
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:28 -0800 (PST)
Received: from [127.0.0.1] (85-237-234-20.dynamic.orange.sk [85.237.234.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AB227200CE;
        Tue, 15 Nov 2022 10:55:25 +0100 (CET)
Date:   Tue, 15 Nov 2022 10:55:24 +0100
From:   Martin Botka <martin.botka@somainline.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin.botka1@gmail.com>
CC:     ~postmarketos/upstreaming@lists.sr.ht,
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
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: Add basic support for BIQU CB1
User-Agent: K-9 Mail for Android
In-Reply-To: <20221115005429.57d72f64@slackpad.lan>
References: <20221114214452.1993744-1-martin.botka@somainline.org> <20221114214452.1993744-2-martin.botka@somainline.org> <20221114233102.3b1f96cc@slackpad.lan> <CADQ2G_HXx59YYjNvhcNRonahgT3AcE_2BiU43vDJ3CRUGKwAKA@mail.gmail.com> <20221115005429.57d72f64@slackpad.lan>
Message-ID: <EEA966B5-E8C3-4A65-A6AE-FF2F9410F088@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 15, 2022 1:54:29 AM GMT+01:00, Andre Przywara <andre.przywara@arm.com> wrote:
>On Tue, 15 Nov 2022 00:44:46 +0100
>Martin Botka <martin.botka1@gmail.com> wrote:
>
>Hi Martin,
>
>> I can totally understand how this can get confusing.
>> 
>> Basically because of the Rpi shortage biqu decided to make an Rpi
>> alternative.
>> 
>> So they made CB1 which is compute module style board.
>> 
>> And they made 3 other boards where CB1 or Rpi CM4 can be plugged in. The 3
>> boards are:
>> 
>> Rpi adapter which takes the Compute module style boards and turns them into
>> SBC style with basically identical size and etc to Rpi 4.
>> 
>> Then we have Manta M8P and M4P. These boards are MCUs for a 3D printer. But
>> they were made for Klipper use case which requires a computer or SBC
>> (Usually Rpi4). They combined it into 1 board.
>> Where you get the MCU and you can plug in CM4 or CB1
>
>Thanks for the explanations! I was guessing along those shortage lines,
>since the H616 is quite a step down from the RPi4CM, though probably
>still enough for driving a 3D printer.
>
>> All these boards are basically taking the pins and routing them to ports.
>
>Yes, this is what those SoM carrier boards do ;-)
>
>> There is nearly 0 chips for conversion or processing of the pins from CB1
>> or CM4 thus i do not see a reason for having parent dtsi and dts for the
>> adapter and Manta boards.
>
>And the DT does not need to describe "chips" only, a lot of DT nodes
>are about connectors, and which ports and which exact pins (out of the
>possible pinmuxes) are actually used. The SoM itself mostly exposes
>just pins, and the board DT describes how these pins are used (GPIO or
>special function, for instance).
>
>So did you try to split this up? How would that look?
>
>Cheers,
>Andre
>
>> The only exception to conversion are the LEDs on the boards but since both
>> adapter and manta boards have them this yet again eliminates need for
>> parent style DT.
>> 
>> Best regards,
>> Martin
>> 
>> On Tue, Nov 15, 2022, 12:32 AM Andre Przywara <andre.przywara@arm.com>
>> wrote:
>> 
>> > On Mon, 14 Nov 2022 22:44:49 +0100
>> > Martin Botka <martin.botka@somainline.org> wrote:
>> >  
>> > > CB1 is Compute Module style board that plugs into Rpi board style  
>> > adapter or  
>> > > Manta 3D printer boards (M4P/M8P).
>> > >
>> > > The board has:
>> > >       H616 SoC
>> > >       1GB of RAM
>> > >       AXP313A PMIC
>> > >
>> > > And the actual boards that CB1 plugs in are just extension to it with  
>> > ports and  
>> > > thus are not split in DT.  
>> >
>> > I don't really understand that sentence. There is some precedent for a
>> > SoM/board split, look at the sun50i-a64-sopine or
>> > sun50i-h5-emlid-neutis-n5 files. And if I see this correctly, then
>> > there are *two* boards available for the same CB1 SoM, the PI4B and the
>> > Manta board? Which would a strong case for a SoM .dtsi, plus the one
>> > or two board .dts files.
>> > I am just not sure whether that relation to the Pi4-CM is helpful or
>> > just complicates things...
>> >
>> > Cheers,
>> > Andre
>> >  
>> > >
>> > > Boards have:
>> > >       4x (3x for Manta boards) USB and 1 USB OTG.
>> > >       SDcard slot for loading images.
>> > >       Ethernet port wired to the internal PHY.
>> > >       2x HDMI 2.0.
>> > >       Power and Status LEDs.
>> > >
>> > > Currently working:
>> > >       Booting
>> > >       USB
>> > >       UART
>> > >
>> > > Signed-off-by: Martin Botka <martin.botka@somainline.org>
>> > > ---
>> > > Changes in V2:
>> > > Add proper board compatible
>> > > Add regulator prefix for vcc5v
>> > > Drop okay status from PMIC
>> > > Drop standby_param
>> > > Changes in V3:
>> > > Change copyright to me
>> > > regulator_vcc5v to regulator-vcc5v
>> > > Drop ehci0 and ohci0
>> > >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>> > >  .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 178 ++++++++++++++++++
>> > >  2 files changed, 179 insertions(+)
>> > >  create mode 100644  
>> > arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
>> > >
>> > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile  
>> > b/arch/arm64/boot/dts/allwinner/Makefile  
>> > > index 6a96494a2e0a..223f1be73541 100644
>> > > --- a/arch/arm64/boot/dts/allwinner/Makefile
>> > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> > > @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>> > > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-biqu-cb1.dtb
>> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
>> > b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
>> > > new file mode 100644
>> > > index 000000000000..86b5aca9b53e
>> > > --- /dev/null
>> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>> > > @@ -0,0 +1,178 @@
>> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> > > +/*
>> > > + * Copyright (C) 2022 Martin Botka <martin.botka@somainline.org>.
>> > > + */
>> > > +
>> > > +/dts-v1/;
>> > > +
>> > > +#include "sun50i-h616.dtsi"
>> > > +
>> > > +#include <dt-bindings/gpio/gpio.h>
>> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> > > +#include <dt-bindings/leds/common.h>
>> > > +
>> > > +/ {
>> > > +     model = "BIQU CB1";
>> > > +     compatible = "biqu,cb1", "allwinner,sun50i-h616";
>> > > +
>> > > +     aliases {
>> > > +             serial0 = &uart0;
>> > > +     };
>> > > +
>> > > +     chosen {
>> > > +             stdout-path = "serial0:115200n8";
>> > > +     };
>> > > +
>> > > +     leds {
>> > > +             compatible = "gpio-leds";
>> > > +
>> > > +             led-0 {
>> > > +                     function = LED_FUNCTION_POWER;
>> > > +                     color = <LED_COLOR_ID_RED>;
>> > > +                     gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
>> > > +                     default-state = "on";
>> > > +             };
>> > > +
>> > > +             led-1 {
>> > > +                     function = LED_FUNCTION_STATUS;
>> > > +                     color = <LED_COLOR_ID_GREEN>;
>> > > +                     gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
>> > > +             };
>> > > +     };
>> > > +
>> > > +     reg_vcc5v: regulator-vcc5v {
>> > > +             /* board wide 5V supply directly from the USB-C socket */
>> > > +             compatible = "regulator-fixed";
>> > > +             regulator-name = "vcc-5v";
>> > > +             regulator-min-microvolt = <5000000>;
>> > > +             regulator-max-microvolt = <5000000>;
>> > > +             regulator-always-on;
>> > > +     };
>> > > +
>> > > +     reg_usb1_vbus: regulator-usb1-vbus {
>> > > +             compatible = "regulator-fixed";
>> > > +             regulator-name = "usb1-vbus";
>> > > +             regulator-min-microvolt = <5000000>;
>> > > +             regulator-max-microvolt = <5000000>;
>> > > +             vin-supply = <&reg_vcc5v>;
>> > > +             enable-active-high;
>> > > +             gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
>> > > +     };
>> > > +};
>> > > +
>> > > +&ehci1 {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&ehci2 {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&ehci3 {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&mmc0 {
>> > > +     vmmc-supply = <&reg_dldo1>;
>> > > +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
>> > > +     no-1-8-v;
>> > > +     bus-width = <4>;
>> > > +     status = "disabled";
>> > > +};
>> > > +
>> > > +&ohci1 {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&ohci2 {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&ohci3 {
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&r_i2c {
>> > > +     status = "okay";
>> > > +
>> > > +     axp1530: pmic@36 {
>> > > +             compatible = "x-powers,axp1530";
>> > > +             reg = <0x36>;
>> > > +             wakeup-source;
>> > > +
>> > > +             regulators{
>> > > +                     reg_dcdc1: dcdc1 {
>> > > +                             regulator-name = "axp1530-dcdc1";
>> > > +                             regulator-min-microvolt = <500000>;
>> > > +                             regulator-max-microvolt = <3400000>;
>> > > +                             regulator-step-delay-us = <25>;
>> > > +                             regulator-final-delay-us = <50>;
>> > > +                             regulator-always-on;
>> > > +                     };
>> > > +
>> > > +                     reg_dcdc2: dcdc2 {
>> > > +                             regulator-name = "axp1530-dcdc2";
>> > > +                             regulator-min-microvolt = <500000>;
>> > > +                             regulator-max-microvolt = <1540000>;
>> > > +                             regulator-step-delay-us = <25>;
>> > > +                             regulator-final-delay-us = <50>;
>> > > +                             regulator-ramp-delay = <200>;
>> > > +                             regulator-always-on;
>> > > +                     };
>> > > +
>> > > +                     reg_dcdc3: dcdc3 {
>> > > +                             regulator-name = "axp1530-dcdc3";
>> > > +                             regulator-min-microvolt = <500000>;
>> > > +                             regulator-max-microvolt = <1840000>;
>> > > +                             regulator-step-delay-us = <25>;
>> > > +                             regulator-final-delay-us = <50>;
>> > > +                             regulator-always-on;
>> > > +                     };
>> > > +
>> > > +                     reg_aldo1: ldo1 {
>> > > +                             regulator-name = "axp1530-aldo1";
>> > > +                             regulator-min-microvolt = <1800000>;
>> > > +                             regulator-max-microvolt = <1800000>;
>> > > +                             regulator-step-delay-us = <25>;
>> > > +                             regulator-final-delay-us = <50>;
>> > > +                             regulator-always-on;
>> > > +                     };
>> > > +
>> > > +                     reg_dldo1: ldo2 {
>> > > +                             regulator-name = "axp1530-dldo1";
>> > > +                             regulator-min-microvolt = <3300000>;
>> > > +                             regulator-max-microvolt = <3300000>;
>> > > +                             regulator-step-delay-us = <25>;
>> > > +                             regulator-final-delay-us = <50>;
>> > > +                             regulator-always-on;
>> > > +                     };
>> > > +             };
>> > > +     };
>> > > +};
>> > > +
>> > > +&uart0 {
>> > > +     pinctrl-names = "default";
>> > > +     pinctrl-0 = <&uart0_ph_pins>;
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&usbotg {
>> > > +     /*
>> > > +      * PHY0 pins are connected to a USB-C socket, but a role switch
>> > > +      * is not implemented: both CC pins are pulled to GND.
>> > > +      * The VBUS pins power the device, so a fixed peripheral mode
>> > > +      * is the best choice.
>> > > +      * The board can be powered via GPIOs, in this case port0 *can*
>> > > +      * act as a host (with a cable/adapter ignoring CC), as VBUS is
>> > > +      * then provided by the GPIOs. Any user of this setup would
>> > > +      * need to adjust the DT accordingly: dr_mode set to "host",
>> > > +      * enabling OHCI0 and EHCI0.
>> > > +      */
>> > > +     dr_mode = "peripheral";
>> > > +     status = "okay";
>> > > +};
>> > > +
>> > > +&usbphy {
>> > > +     usb1_vbus-supply = <&reg_usb1_vbus>;
>> > > +     status = "okay";
>> > > +};  
>> >
>> >  
>

Dear Andre,

I have read the schematic of M8P again to recheck a few things. The split of DTS may not be needed after all.

The 4 USB of H616 are used on both boards.
Where this changes is with Rpi CM4 and the usbotg switch is used alongside rpiboot switch to make eMMC of CM4 as host media so data can be loaded onto it.

I will adjust the DT in next revision accordingly.

Regards,
Martin
