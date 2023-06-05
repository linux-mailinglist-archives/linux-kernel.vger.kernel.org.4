Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4357231D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjFEVBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjFEVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:01:29 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D27F7F7;
        Mon,  5 Jun 2023 14:01:27 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 1DC6041D13A6;
        Mon,  5 Jun 2023 22:01:26 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Mon, 05 Jun 2023 22:01:26 +0100
Date:   Mon, 5 Jun 2023 22:01:26 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
Message-ID: <ZH5NJsbY6ZLXYJYz@bart.dudau.co.uk>
References: <20230605150114.601102-1-liviu@dudau.co.uk>
 <20230605150114.601102-2-liviu@dudau.co.uk>
 <552b4604-d1b3-0052-62aa-424944c5ecb1@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <552b4604-d1b3-0052-62aa-424944c5ecb1@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:35:44PM +0300, Arınç ÜNAL wrote:
> On 5.06.2023 18:01, Liviu Dudau wrote:
> > This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> > a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board,
> > connected to the main SoC over PCIe.
> > 
> > The device uses NMBM over NAND, which is not currently supported in the
> > mainline, so NAND node is skipped in this revision.
> > 
> > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> > ---
> >   arch/mips/boot/dts/ralink/Makefile            |  3 +-
> >   .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 92 +++++++++++++++++++
> >   2 files changed, 94 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> > 
> > diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> > index 11732b8c8163a..d27d7e8c700fe 100644
> > --- a/arch/mips/boot/dts/ralink/Makefile
> > +++ b/arch/mips/boot/dts/ralink/Makefile
> > @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
> >   dtb-$(CONFIG_SOC_MT7621) += \
> >   	mt7621-gnubee-gb-pc1.dtb \
> > -	mt7621-gnubee-gb-pc2.dtb
> > +	mt7621-gnubee-gb-pc2.dtb \
> > +	mt7621-tplink-hc220-g5-v1.dtb
> >   obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> > diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> > new file mode 100644
> > index 0000000000000..859aaa1c1bc2b
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/dts-v1/;
> > +
> > +#include "mt7621.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
> > +	model = "TP-Link HC220 G5 v1";
> > +
> > +	memory@0 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x8000000>;
> 
> Please use 8 digit addressing for the memory start and size offsets:
> 
> 0x00000000 0x08000000

Will do.

> 
> > +	};
> > +
> > +	chosen {
> > +		bootargs = "earlycon console=ttyS0,115200";
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +
> > +		key-reset {
> > +			label = "reset";
> > +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_RESTART>;
> > +		};
> > +
> > +		key-wps {
> > +			label = "wps";
> > +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_WPS_BUTTON>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		red {
> 
> Usually the led name would point to the component the LED is used for.

These are "generic" LEDs controlled from the userspace. The original firmware
uses GREEN for normal operations, RED for faults and BLUE for when WPS is
enabled. I'm not sure if there are any standard bindings that I can use here.

> 
> > +			color = <LED_COLOR_ID_RED>;
> > +			function = LED_FUNCTION_FAULT;
> 
> Is there a specific reason you're using leds/common.h,
> color & function instead of 'label = "red:ledname"'?

I actually can't remember why I've created them this way. I might've been
under the impression that giving them standard colour names will make it
easier for userspace to identify and use them, but as I haven't yet
investigated into how I'm going to use the device I'm unaware of any
userspace requirements. It's possible OpenWRT or LEDE have some strong
definitions, but I'm not aware of them as I don't use any of the distros.


> 
> > +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		green {
> > +			color = <LED_COLOR_ID_GREEN>;
> > +			function = LED_FUNCTION_POWER;
> > +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "default-on";
> > +		};
> > +
> > +		blue {
> > +			color = <LED_COLOR_ID_BLUE>;
> > +			function = LED_FUNCTION_WPS;
> > +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> > +		};
> 
> Every led node needs the "led-" prefix to satisfy the leds-gpio.yaml
> schema. You can check for dt-schema warnings using this command:
> 
> ARCH=mips make clean dtbs_check
> 
> Ignore the warning for mediatek,mt7621-eth.

Sure, will run the checks before submitting v4.

> 
> > +	};
> > +};
> > +
> > +&pcie {
> > +	status = "okay";
> > +
> > +	pcie@0,0 {
> > +		compatible = "mediatek,mt76";
> > +	};
> > +
> > +	pcie@1,0 {
> > +		compatible = "mediatek,mt76";
> > +	};
> 
> Both radios work with this then?

Yes, they work with and without the compatible property.

> 
> Also, I see a bunch of warnings now that the mediatek,mt76 compatible
> string is added. The warning from schemas/pci/pci-bus.yaml is concerning.
> 
> /mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: pcie@0,0:compatible: ['mediatek,mt76'] does not contain items matching the given schema
> 	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> /mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: pcie@0,0: Unevaluated properties are not allowed ('compatible' was unexpected)
> 	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> /mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'reset-gpios' were unexpected)
> 	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> /mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: pcie@0,0:compatible: ['mediatek,mt76'] does not contain items matching the given schema
> 	From schema: /usr/lib/python3/dist-packages/dtschema/schemas/pci/pci-bus.yaml
> /mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@0,0: clocks: [[2, 23]] is too short
> 	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> /mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@0,0: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'clocks', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'phy-names', 'phys', 'ranges' were unexpected)
> 	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> 
> Rob, Krzysztof any ideas what to do? The PCI child node is supposed to
> be the properties of the wireless device. But the compatible string
> doesn't match the schema on schemas/pci/pci-bus.yaml.

TBH, I've always found the attempts to add device tree nodes for PCI(e) devices
amusing. The bus is supposed to be queried and one can learn from device ID
what hardware they're talking to. But then you need device tree (or ACPI for x86_64)
to layer on top of that information about where EEPROM data might be, and other
metadata that blurs the "DT describes the hardware" line (you could technically
reformat the NAND and place the EEPROM data somewhere else on this platform).

> 
>       compatible:
>         contains:
>           pattern: "^(pci[0-9a-f]{3,4},[0-9a-f]{1,4}|pciclass,[0-9a-f]{4,6})$"
> 
> Liviu, in the meantime, you should submit this patch without this
> compatible string. I will handle this issue.

OK, I will drop the compatible strings from v4.

Thanks for the quick review!

Best regards,
Liviu

> 
> Arınç

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
