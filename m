Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6462A03B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiKORZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiKORZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:25:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD1C526571;
        Tue, 15 Nov 2022 09:25:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD76A13D5;
        Tue, 15 Nov 2022 09:25:12 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEECE3F587;
        Tue, 15 Nov 2022 09:25:03 -0800 (PST)
Date:   Tue, 15 Nov 2022 17:25:01 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Martin Botka <martin.botka1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
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
Message-ID: <20221115172501.04065c13@donnerap.cambridge.arm.com>
In-Reply-To: <JCFELR.HONCNORN1D0L@somainline.org>
References: <20221114214452.1993744-1-martin.botka@somainline.org>
        <20221114214452.1993744-2-martin.botka@somainline.org>
        <20221114233102.3b1f96cc@slackpad.lan>
        <CADQ2G_HXx59YYjNvhcNRonahgT3AcE_2BiU43vDJ3CRUGKwAKA@mail.gmail.com>
        <20221115005429.57d72f64@slackpad.lan>
        <D69CAA04-56A2-4FFD-A33D-C802084A7150@somainline.org>
        <20221115103307.5f5b9106@donnerap.cambridge.arm.com>
        <78EC79B1-1664-48EB-A902-9173FE59C45B@somainline.org>
        <20221115142714.310049c4@donnerap.cambridge.arm.com>
        <JCFELR.HONCNORN1D0L@somainline.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 18:02:43 +0100
Martin Botka <martin.botka@somainline.org> wrote:

> On Tue, Nov 15 2022 at 02:27:14 PM +00:00:00, Andre Przywara 
> <andre.przywara@arm.com> wrote:
> > On Tue, 15 Nov 2022 12:38:59 +0100
> > Martin Botka <martin.botka@somainline.org> wrote:
> > 
> > Hi Martin,
> >   
> >>  On November 15, 2022 11:33:07 AM GMT+01:00, Andre Przywara 
> >> <andre.przywara@arm.com> wrote:  
> >>  >On Tue, 15 Nov 2022 09:24:04 +0100
> >>  >Martin Botka <martin.botka@somainline.org> wrote:
> >>  >
> >>  >Hi,
> >>  >  
> >>  >> On November 15, 2022 1:54:29 AM GMT+01:00, Andre Przywara   
> >> <andre.przywara@arm.com> wrote:  
> >>  >> >On Tue, 15 Nov 2022 00:44:46 +0100
> >>  >> >Martin Botka <martin.botka1@gmail.com> wrote:
> >>  >> >
> >>  >> >Hi Martin,
> >>  >> >  
> >>  >> >> I can totally understand how this can get confusing.
> >>  >> >>
> >>  >> >> Basically because of the Rpi shortage biqu decided to make an   
> >> Rpi  
> >>  >> >> alternative.
> >>  >> >>
> >>  >> >> So they made CB1 which is compute module style board.
> >>  >> >>
> >>  >> >> And they made 3 other boards where CB1 or Rpi CM4 can be   
> >> plugged in. The 3  
> >>  >> >> boards are:
> >>  >> >>
> >>  >> >> Rpi adapter which takes the Compute module style boards and   
> >> turns them into  
> >>  >> >> SBC style with basically identical size and etc to Rpi 4.
> >>  >> >>
> >>  >> >> Then we have Manta M8P and M4P. These boards are MCUs for a   
> >> 3D printer. But  
> >>  >> >> they were made for Klipper use case which requires a computer   
> >> or SBC  
> >>  >> >> (Usually Rpi4). They combined it into 1 board.
> >>  >> >> Where you get the MCU and you can plug in CM4 or CB1  
> >>  >> >
> >>  >> >Thanks for the explanations! I was guessing along those   
> >> shortage lines,  
> >>  >> >since the H616 is quite a step down from the RPi4CM, though   
> >> probably  
> >>  >> >still enough for driving a 3D printer.  
> >>  >> Mostly yes  
> >>  >> >  
> >>  >> >> All these boards are basically taking the pins and routing   
> >> them to ports.  
> >>  >> >
> >>  >> >Yes, this is what those SoM carrier boards do ;-)  
> >>  >> :)  
> >>  >> >  
> >>  >> >> There is nearly 0 chips for conversion or processing of the   
> >> pins from CB1  
> >>  >> >> or CM4 thus i do not see a reason for having parent dtsi and   
> >> dts for the  
> >>  >> >> adapter and Manta boards.  
> >>  >> >
> >>  >> >And the DT does not need to describe "chips" only, a lot of DT   
> >> nodes  
> >>  >> >are about connectors, and which ports and which exact pins (out   
> >> of the  
> >>  >> >possible pinmuxes) are actually used. The SoM itself mostly   
> >> exposes  
> >>  >> >just pins, and the board DT describes how these pins are used   
> >> (GPIO or  
> >>  >> >special function, for instance).
> >>  >> >
> >>  >> >So did you try to split this up? How would that look?  
> >>  >>
> >>  >> The main difference between adapter and Manta boards is that   
> >> adapter has 4x USB.  
> >>  >
> >>  >So those are two double-type-A sockets? This is not really what   
> >> the DT  
> >>  >below describes? It's perfectly fine to fix USB0 to host mode, we   
> >> do this  
> >>  >on the Pine64 boards (both A64 and H6), for instance.  
> >> 
> >>  Yes. But the third and fourth is also used. Third is done in 2.54 
> >> 4p connector (just pins on board) and fourth is connected directly 
> >> to manta stm32 MCU. So all 4 are host.  
> > 
> > Wait, so you are talking about the Manta board now? I see two 
> > sockets, the
> > 2.54mm headers and the STM32 there, but the Pi4B is quite different in
> > that respect: I see four(!) USB type-A sockets (two dual-port stacks).
> > Plus the CM4 connector seems to only have pins for one USB 2.0 port
> > (D-,D+). So is this a hub chip on the underside of the board, close 
> > to the
> > USB ports? Can you read the label of that chip?
> > And where are the other H616 USB pins routed to? Are they (ab-)using 
> > the
> > PCIe pins of the CM4 connector? Or are they actually not used at all, 
> > and
> > it's all one USB port through a by-4 hub?
> > If you have a running system, "lsusb -t" should give you a clue which 
> > host
> > ports are used and if there is a hub.
> > 
> > Cheers,
> > Andre
> >   
> >>  >> Manta only has 3 and 1 otg. But it has a switch to disable or   
> >> enable otg.  
> >>  >
> >>  >What does the switch do, exactly? By definition OTG works fine in   
> >> both  
> >>  >ways. And there are pins in the connector to decide the role.  
> >>  The switch is just signal pin for RS2227. Its the multiplexer i 
> >> mentioned. It decides if we should have the pins wired to usb type C 
> >> port or normally to stm32 MCU. Thats all it does.  
> >>  >
> >>  >Allwinner actually goes one step further and provides a full HCI   
> >> to the  
> >>  >same PHY that the MUSB OTG controller is connected to, so you   
> >> don't need  
> >>  >to live with the sometimes limited performance of the MUSB host   
> >> mode  
> >>  >(which we drive without DMA). Not sure if that is the case or a   
> >> problem on  
> >>  >the RPi4.
> >>  >  
> >>  >> Im not opposed to splitting it up. It is probably a good idea.
> >>  >> I dont see how to resolve that switch on manta boards tho.  
> >>  >
> >>  >If the Manta board is (almost) a superset of the Pi4B, then you can
> >>  >include the latter from there. Look at sun50i-a64-pine64-lts.dts or
> >>  >sun50i-h6-pine-h64-model-b.dts for examples.
> >>  >
> >>  >Cheers,
> >>  >Andre.
> >>  >  
> >>  Yep i will split it into SoM boards.  
> >>  >> >> The only exception to conversion are the LEDs on the boards   
> >> but since both  
> >>  >> >> adapter and manta boards have them this yet again eliminates   
> >> need for  
> >>  >> >> parent style DT.
> >>  >> >>
> >>  >> >> Best regards,
> >>  >> >> Martin
> >>  >> >>
> >>  >> >> On Tue, Nov 15, 2022, 12:32 AM Andre Przywara   
> >> <andre.przywara@arm.com>  
> >>  >> >> wrote:
> >>  >> >>  
> >>  >> >> > On Mon, 14 Nov 2022 22:44:49 +0100
> >>  >> >> > Martin Botka <martin.botka@somainline.org> wrote:
> >>  >> >> >  
> >>  >> >> > > CB1 is Compute Module style board that plugs into Rpi   
> >> board style  
> >>  >> >> > adapter or  
> >>  >> >> > > Manta 3D printer boards (M4P/M8P).
> >>  >> >> > >
> >>  >> >> > > The board has:
> >>  >> >> > >       H616 SoC
> >>  >> >> > >       1GB of RAM
> >>  >> >> > >       AXP313A PMIC
> >>  >> >> > >
> >>  >> >> > > And the actual boards that CB1 plugs in are just   
> >> extension to it with  
> >>  >> >> > ports and  
> >>  >> >> > > thus are not split in DT.  
> >>  >> >> >
> >>  >> >> > I don't really understand that sentence. There is some   
> >> precedent for a  
> >>  >> >> > SoM/board split, look at the sun50i-a64-sopine or
> >>  >> >> > sun50i-h5-emlid-neutis-n5 files. And if I see this   
> >> correctly, then  
> >>  >> >> > there are *two* boards available for the same CB1 SoM, the   
> >> PI4B and the  
> >>  >> >> > Manta board? Which would a strong case for a SoM .dtsi,   
> >> plus the one  
> >>  >> >> > or two board .dts files.
> >>  >> >> > I am just not sure whether that relation to the Pi4-CM is   
> >> helpful or  
> >>  >> >> > just complicates things...
> >>  >> >> >
> >>  >> >> > Cheers,
> >>  >> >> > Andre
> >>  >> >> >  
> >>  >> >> > >
> >>  >> >> > > Boards have:
> >>  >> >> > >       4x (3x for Manta boards) USB and 1 USB OTG.
> >>  >> >> > >       SDcard slot for loading images.
> >>  >> >> > >       Ethernet port wired to the internal PHY.
> >>  >> >> > >       2x HDMI 2.0.
> >>  >> >> > >       Power and Status LEDs.
> >>  >> >> > >
> >>  >> >> > > Currently working:
> >>  >> >> > >       Booting
> >>  >> >> > >       USB
> >>  >> >> > >       UART
> >>  >> >> > >
> >>  >> >> > > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>  >> >> > > ---
> >>  >> >> > > Changes in V2:
> >>  >> >> > > Add proper board compatible
> >>  >> >> > > Add regulator prefix for vcc5v
> >>  >> >> > > Drop okay status from PMIC
> >>  >> >> > > Drop standby_param
> >>  >> >> > > Changes in V3:
> >>  >> >> > > Change copyright to me
> >>  >> >> > > regulator_vcc5v to regulator-vcc5v
> >>  >> >> > > Drop ehci0 and ohci0
> >>  >> >> > >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>  >> >> > >  .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 178   
> >> ++++++++++++++++++  
> >>  >> >> > >  2 files changed, 179 insertions(+)
> >>  >> >> > >  create mode 100644  
> >>  >> >> > arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
> >>  >> >> > >
> >>  >> >> > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile  
> >>  >> >> > b/arch/arm64/boot/dts/allwinner/Makefile  
> >>  >> >> > > index 6a96494a2e0a..223f1be73541 100644
> >>  >> >> > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> >>  >> >> > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >>  >> >> > > @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=   
> >> sun50i-h6-pine-h64.dtb  
> >>  >> >> > >  dtb-$(CONFIG_ARCH_SUNXI) +=   
> >> sun50i-h6-pine-h64-model-b.dtb  
> >>  >> >> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> >>  >> >> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> >>  >> >> > > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-biqu-cb1.dtb
> >>  >> >> > >  dtb-$(CONFIG_ARCH_SUNXI) +=   
> >> sun50i-h616-orangepi-zero2.dtb  
> >>  >> >> > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> >>  >> >> > > diff --git   
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
> >>  >> >> > b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
> >>  >> >> > > new file mode 100644
> >>  >> >> > > index 000000000000..86b5aca9b53e
> >>  >> >> > > --- /dev/null
> >>  >> >> > > +++   
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts  
> >>  >> >> > > @@ -0,0 +1,178 @@
> >>  >> >> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>  >> >> > > +/*
> >>  >> >> > > + * Copyright (C) 2022 Martin Botka   
> >> <martin.botka@somainline.org>.  
> >>  >> >> > > + */
> >>  >> >> > > +
> >>  >> >> > > +/dts-v1/;
> >>  >> >> > > +
> >>  >> >> > > +#include "sun50i-h616.dtsi"
> >>  >> >> > > +
> >>  >> >> > > +#include <dt-bindings/gpio/gpio.h>
> >>  >> >> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  >> >> > > +#include <dt-bindings/leds/common.h>
> >>  >> >> > > +
> >>  >> >> > > +/ {
> >>  >> >> > > +     model = "BIQU CB1";
> >>  >> >> > > +     compatible = "biqu,cb1", "allwinner,sun50i-h616";
> >>  >> >> > > +
> >>  >> >> > > +     aliases {
> >>  >> >> > > +             serial0 = &uart0;
> >>  >> >> > > +     };
> >>  >> >> > > +
> >>  >> >> > > +     chosen {
> >>  >> >> > > +             stdout-path = "serial0:115200n8";
> >>  >> >> > > +     };
> >>  >> >> > > +
> >>  >> >> > > +     leds {
> >>  >> >> > > +             compatible = "gpio-leds";
> >>  >> >> > > +
> >>  >> >> > > +             led-0 {
> >>  >> >> > > +                     function = LED_FUNCTION_POWER;
> >>  >> >> > > +                     color = <LED_COLOR_ID_RED>;
> >>  >> >> > > +                     gpios = <&pio 2 12   
> >> GPIO_ACTIVE_HIGH>; /* PC12 */  
> >>  >> >> > > +                     default-state = "on";
> >>  >> >> > > +             };
> >>  >> >> > > +
> >>  >> >> > > +             led-1 {
> >>  >> >> > > +                     function = LED_FUNCTION_STATUS;
> >>  >> >> > > +                     color = <LED_COLOR_ID_GREEN>;
> >>  >> >> > > +                     gpios = <&pio 2 13   
> >> GPIO_ACTIVE_HIGH>; /* PC13 */  
> >>  >> >> > > +             };
> >>  >> >> > > +     };
> >>  >> >> > > +
> >>  >> >> > > +     reg_vcc5v: regulator-vcc5v {
> >>  >> >> > > +             /* board wide 5V supply directly from the   
> >> USB-C socket */  
> >>  >> >> > > +             compatible = "regulator-fixed";
> >>  >> >> > > +             regulator-name = "vcc-5v";
> >>  >> >> > > +             regulator-min-microvolt = <5000000>;
> >>  >> >> > > +             regulator-max-microvolt = <5000000>;
> >>  >> >> > > +             regulator-always-on;
> >>  >> >> > > +     };
> >>  >> >> > > +
> >>  >> >> > > +     reg_usb1_vbus: regulator-usb1-vbus {
> >>  >> >> > > +             compatible = "regulator-fixed";
> >>  >> >> > > +             regulator-name = "usb1-vbus";
> >>  >> >> > > +             regulator-min-microvolt = <5000000>;
> >>  >> >> > > +             regulator-max-microvolt = <5000000>;
> >>  >> >> > > +             vin-supply = <&reg_vcc5v>;
> >>  >> >> > > +             enable-active-high;
> >>  >> >> > > +             gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /*   
> >> PC16 */  
> >>  >> >> > > +     };
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&ehci1 {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&ehci2 {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&ehci3 {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&mmc0 {
> >>  >> >> > > +     vmmc-supply = <&reg_dldo1>;
> >>  >> >> > > +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
> >>  >> >> > > +     no-1-8-v;
> >>  >> >> > > +     bus-width = <4>;
> >>  >> >> > > +     status = "disabled";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&ohci1 {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&ohci2 {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&ohci3 {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&r_i2c {
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +
> >>  >> >> > > +     axp1530: pmic@36 {
> >>  >> >> > > +             compatible = "x-powers,axp1530";
> >>  >> >> > > +             reg = <0x36>;
> >>  >> >> > > +             wakeup-source;
> >>  >> >> > > +
> >>  >> >> > > +             regulators{
> >>  >> >> > > +                     reg_dcdc1: dcdc1 {
> >>  >> >> > > +                             regulator-name =   
> >> "axp1530-dcdc1";  
> >>  >> >> > > +                             regulator-min-microvolt =   
> >> <500000>;  
> >>  >> >> > > +                             regulator-max-microvolt =   
> >> <3400000>;  
> >>  >> >> > > +                             regulator-step-delay-us =   
> >> <25>;  
> >>  >> >> > > +                             regulator-final-delay-us =   
> >> <50>;  
> >>  >> >> > > +                             regulator-always-on;
> >>  >> >> > > +                     };
> >>  >> >> > > +
> >>  >> >> > > +                     reg_dcdc2: dcdc2 {
> >>  >> >> > > +                             regulator-name =   
> >> "axp1530-dcdc2";  
> >>  >> >> > > +                             regulator-min-microvolt =   
> >> <500000>;  
> >>  >> >> > > +                             regulator-max-microvolt =   
> >> <1540000>;  
> >>  >> >> > > +                             regulator-step-delay-us =   
> >> <25>;  
> >>  >> >> > > +                             regulator-final-delay-us =   
> >> <50>;  
> >>  >> >> > > +                             regulator-ramp-delay =   
> >> <200>;  
> >>  >> >> > > +                             regulator-always-on;
> >>  >> >> > > +                     };
> >>  >> >> > > +
> >>  >> >> > > +                     reg_dcdc3: dcdc3 {
> >>  >> >> > > +                             regulator-name =   
> >> "axp1530-dcdc3";  
> >>  >> >> > > +                             regulator-min-microvolt =   
> >> <500000>;  
> >>  >> >> > > +                             regulator-max-microvolt =   
> >> <1840000>;  
> >>  >> >> > > +                             regulator-step-delay-us =   
> >> <25>;  
> >>  >> >> > > +                             regulator-final-delay-us =   
> >> <50>;  
> >>  >> >> > > +                             regulator-always-on;
> >>  >> >> > > +                     };
> >>  >> >> > > +
> >>  >> >> > > +                     reg_aldo1: ldo1 {
> >>  >> >> > > +                             regulator-name =   
> >> "axp1530-aldo1";  
> >>  >> >> > > +                             regulator-min-microvolt =   
> >> <1800000>;  
> >>  >> >> > > +                             regulator-max-microvolt =   
> >> <1800000>;  
> >>  >> >> > > +                             regulator-step-delay-us =   
> >> <25>;  
> >>  >> >> > > +                             regulator-final-delay-us =   
> >> <50>;  
> >>  >> >> > > +                             regulator-always-on;
> >>  >> >> > > +                     };
> >>  >> >> > > +
> >>  >> >> > > +                     reg_dldo1: ldo2 {
> >>  >> >> > > +                             regulator-name =   
> >> "axp1530-dldo1";  
> >>  >> >> > > +                             regulator-min-microvolt =   
> >> <3300000>;  
> >>  >> >> > > +                             regulator-max-microvolt =   
> >> <3300000>;  
> >>  >> >> > > +                             regulator-step-delay-us =   
> >> <25>;  
> >>  >> >> > > +                             regulator-final-delay-us =   
> >> <50>;  
> >>  >> >> > > +                             regulator-always-on;
> >>  >> >> > > +                     };
> >>  >> >> > > +             };
> >>  >> >> > > +     };
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&uart0 {
> >>  >> >> > > +     pinctrl-names = "default";
> >>  >> >> > > +     pinctrl-0 = <&uart0_ph_pins>;
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&usbotg {
> >>  >> >> > > +     /*
> >>  >> >> > > +      * PHY0 pins are connected to a USB-C socket, but a   
> >> role switch  
> >>  >> >> > > +      * is not implemented: both CC pins are pulled to   
> >> GND.  
> >>  >> >> > > +      * The VBUS pins power the device, so a fixed   
> >> peripheral mode  
> >>  >> >> > > +      * is the best choice.
> >>  >> >> > > +      * The board can be powered via GPIOs, in this case   
> >> port0 *can*  
> >>  >> >> > > +      * act as a host (with a cable/adapter ignoring   
> >> CC), as VBUS is  
> >>  >> >> > > +      * then provided by the GPIOs. Any user of this   
> >> setup would  
> >>  >> >> > > +      * need to adjust the DT accordingly: dr_mode set   
> >> to "host",  
> >>  >> >> > > +      * enabling OHCI0 and EHCI0.
> >>  >> >> > > +      */
> >>  >> >> > > +     dr_mode = "peripheral";
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};
> >>  >> >> > > +
> >>  >> >> > > +&usbphy {
> >>  >> >> > > +     usb1_vbus-supply = <&reg_usb1_vbus>;
> >>  >> >> > > +     status = "okay";
> >>  >> >> > > +};  
> >>  >> >> >
> >>  >> >> >  
> >>  >> >  
> >>  >  
> >   
> And yes there should be CM4 and CB1 DT for these boards.
> But since i do not own CM4. I will only create CB1 version of this DT.

That's the interesting part: there is already a DT for the CM4:
arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
Theoretically you should be able to include this .dtsi instead of your
cb1.dtsi into the board .dts, and it should work(TM). Now I don't know if
this has ever been done before, but I would imagine this to not compile,
as the references are not the same, and the peripherals being rather
different anyway.
So let's for a moment pretend we can only plug the CB1 in ;-)

As for the same DT between the Manta and RPi4: let's just start with one.
If the other one is indeed identical (thought they look very different to
me!), we just might not bother with upstreaming the other one.
Should there be differences (which could be an LED wired differently), and
people care, we can always add a second .dts, and include the first one.

As to which board to upstream: I am a bit torn between the more practical
RPi4 board and the fact that you actually own the Manta board. I guess we
should play it safe, and you upstream what you have and can test.

Cheers,
Andre
