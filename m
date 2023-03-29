Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC766CF33F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC2TjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2TjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:39:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0E469C;
        Wed, 29 Mar 2023 12:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1394B8241D;
        Wed, 29 Mar 2023 19:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33EDC433EF;
        Wed, 29 Mar 2023 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680118745;
        bh=/ZKmyLoYa9YS0DXYnLXFFJPL5/iEPvy2OKhP2ekYTT4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PAOWrLl7L61fDDI8YTLYLHQ6TTPdDCbyASFG2/dVFGsCcbM5wtzYmrptlEFO6DqpQ
         L1bnJR6naswl5+8iIR+BGKvBF9lCCL7bQN5cJgDnrWYAb9n2t7HF9tsgwxJTSNDWEk
         23n1OItL22vUOaJZLgwPupWdx1dOz2S3EDvRQVhmpgND2bih8roF8QoJKiWCaDmD+q
         IhpB0WGKxeKpqWQi8c7O0sVEFe/txkt/gpRPQ+Qx0VxaIU7pwnrZ9GTJ5GrF+6UShW
         MSP62jauG+062S/3+rmI7/9MhUYUwiUd28a03LOGupucyjXEldbo0G8xA3RZ9oo//o
         bRxFK0AbrXUDg==
Received: by pali.im (Postfix)
        id 4599A29F; Wed, 29 Mar 2023 21:39:02 +0200 (CEST)
Date:   Wed, 29 Mar 2023 21:39:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: marvell: add DTS for GL.iNet GL-MV1000
Message-ID: <20230329193902.xu5xqwr5wdqjwg5j@pali>
References: <20230202093706.30995-1-mrkiko.rs@gmail.com>
 <20230203174618.arqh2gqspoh3rlt6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230203174618.arqh2gqspoh3rlt6@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Friday 03 February 2023 18:46:18 Pali Rohár wrote:
> On Thursday 02 February 2023 10:37:06 Enrico Mioso wrote:
> > The GL-MV1000 (Brume) is a small form-factor gateway router.
> > It is based on the Marvell Armada 88F3720 SOC (1GHz), has 3 gigabit ethernet ports, 1 GB RAM, 16M SPI flash, 8GB eMMC and an uSD slot, as well as an USB 2.0 type A and an USB 3.0 type C port.
> > 
> > Signed-off-by: Enrico Mioso <mrkiko.rs@gmail.com>
> > CC: Pali <pali@kernel.org>
> 
> Looks good,
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
> > ---
> >  arch/arm64/boot/dts/marvell/Makefile          |   1 +
> >  .../dts/marvell/armada-3720-gl-mv1000.dts     | 239 ++++++++++++++++++
> >  2 files changed, 240 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> > index 058237681fe5..79ac09b58a89 100644
> > --- a/arch/arm64/boot/dts/marvell/Makefile
> > +++ b/arch/arm64/boot/dts/marvell/Makefile
> > @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
> > +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-gl-mv1000.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> > new file mode 100644
> > index 000000000000..b1b45b4fa9d4
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include "armada-372x.dtsi"
> > +
> > +/ {
> > +	model = "GL.iNet GL-MV1000";
> > +	compatible = "glinet,gl-mv1000", "marvell,armada3720";
> > +
> > +	aliases {
> > +		led-boot = &led_power;
> > +		led-failsafe = &led_power;
> > +		led-running = &led_power;
> > +		led-upgrade = &led_power;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	memory@0 {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> > +	};
> > +
> > +	vcc_sd_reg1: regulator {
> > +		compatible = "regulator-gpio";
> > +		regulator-name = "vcc_sd1";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-boot-on;
> > +
> > +		gpios-states = <0>;
> > +		states = <1800000 0x1
> > +			3300000 0x0>;
> > +		enable-active-high;
> > +	};
> > +
> > +	keys {
> > +		compatible = "gpio-keys";
> > +
> > +		reset {
> > +			label = "reset";
> > +			linux,code = <KEY_RESTART>;
> > +			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
> > +		};
> > +
> > +		switch {
> > +			label = "switch";
> > +			linux,code = <BTN_0>;
> > +			gpios = <&gpiosb 22 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		vpn {
> > +			label = "green:vpn";
> > +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> > +		};
> > +
> > +		wan {
> > +			label = "green:wan";
> > +			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
> > +		};
> > +
> > +		led_power: power {
> > +			label = "green:power";
> > +			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
> > +			default-state = "on";
> > +		};
> > +	};
> > +};
> > +
> > +&spi0 {
> > +	status = "okay";
> > +
> > +	flash@0 {
> > +		reg = <0>;
> > +		compatible = "jedec,spi-nor";
> > +		spi-max-frequency = <104000000>;
> > +		m25p,fast-read;
> > +		partitions {
> > +			compatible = "fixed-partitions";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +
> > +			partition@0 {
> > +				label = "firmware";
> > +				reg = <0 0xf0000>;
> > +			};
> > +
> > +			partition@f0000 {
> > +				label = "u-boot-env";
> > +				reg = <0xf0000 0x8000>;
> > +			};
> > +
> > +			factory: partition@f8000 {
> > +				label = "factory";
> > +				reg = <0xf8000 0x8000>;
> > +				read-only;
> > +			};
> > +
> > +			partition@100000 {
> > +				label = "dtb";
> > +				reg = <0x100000 0x10000>;
> > +				read-only;
> > +			};
> > +
> > +			partition@110000 {
> > +				label = "rescue";
> > +				reg = <0x110000 0x1000000>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&sdhci1 {
> > +	wp-inverted;
> > +	bus-width = <4>;
> > +	cd-gpios = <&gpionb 17 GPIO_ACTIVE_LOW>;
> > +	marvell,pad-type = "sd";
> > +	no-1-8-v;
> > +	vqmmc-supply = <&vcc_sd_reg1>;
> > +	status = "okay";
> > +};
> > +
> > +&sdhci0 {
> > +	bus-width = <8>;
> > +	mmc-ddr-1_8v;
> > +	mmc-hs400-1_8v;
> > +	non-removable;
> > +	no-sd;
> > +	no-sdio;
> > +	marvell,pad-type = "fixed-1-8v";
> > +	status = "okay";
> > +};
> > +
> > +&usb3 {
> > +	status = "okay";
> > +};
> > +
> > +&usb2 {
> > +	status = "okay";
> > +};
> > +
> > +&uart0 {
> > +	status = "okay";
> > +};
> > +
> > +&mdio {
> > +	switch0: switch0@1 {
> > +		compatible = "marvell,mv88e6085";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		reg = <1>;
> > +
> > +		dsa,member = <0 0>;
> > +
> > +		ports: ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +				label = "cpu";
> > +				ethernet = <&eth0>;
> > +			};
> > +
> > +			port@1 {
> > +				reg = <1>;
> > +				label = "wan";
> > +				phy-handle = <&switch0phy0>;
> > +			};
> > +
> > +			port@2 {
> > +				reg = <2>;
> > +				label = "lan0";
> > +				phy-handle = <&switch0phy1>;
> > +
> > +				nvmem-cells = <&macaddr_factory_6>;
> > +				nvmem-cell-names = "mac-address";
> > +			};
> > +
> > +			port@3 {
> > +				reg = <3>;
> > +				label = "lan1";
> > +				phy-handle = <&switch0phy2>;
> > +
> > +				nvmem-cells = <&macaddr_factory_6>;
> > +				nvmem-cell-names = "mac-address";
> > +			};
> > +		};
> > +
> > +		mdio {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			switch0phy0: switch0phy0@11 {
> > +				reg = <0x11>;
> > +			};
> > +			switch0phy1: switch0phy1@12 {
> > +				reg = <0x12>;
> > +			};
> > +			switch0phy2: switch0phy2@13 {
> > +				reg = <0x13>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&eth0 {
> > +	nvmem-cells = <&macaddr_factory_0>;
> > +	nvmem-cell-names = "mac-address";
> > +	phy-mode = "rgmii-id";
> > +	status = "okay";
> > +
> > +	fixed-link {
> > +		speed = <1000>;
> > +		full-duplex;
> > +	};
> > +};
> > +
> > +&factory {
> > +	compatible = "nvmem-cells";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	macaddr_factory_0: macaddr@0 {
> > +		reg = <0x0 0x6>;
> > +	};
> > +
> > +	macaddr_factory_6: macaddr@6 {
> > +		reg = <0x6 0x6>;
> > +	};
> > +};
> > -- 
> > 2.39.1
> > 
