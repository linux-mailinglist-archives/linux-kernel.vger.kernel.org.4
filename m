Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B668A0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjBCRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjBCRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:47:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0860AA271;
        Fri,  3 Feb 2023 09:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63103B82B65;
        Fri,  3 Feb 2023 17:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DDCC433D2;
        Fri,  3 Feb 2023 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675446382;
        bh=1M70rA559reP+o5VXh4vyRjd4344pwwY97+cwJnC4p4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IZZjKn2EZfdanRlcRA4B2d3PfeY3U2KQJSRNUxExG6yGuWFMTsSIaYK02OMqiK2kj
         zqJvd59bEtYtds8KkG8lGBNEog/AI9ja9S6llSy1HAqu6LeDCC/cYktHOAq3qK9HdK
         J3jxpCwBSAKBUVSxbSd63jN8lSRwuMDowhGEsCycdS3YKJ0X8Ljyn8eQZRHyzTPxEU
         kqIZzuyCti2qAiBR9vADj+a6hpThsgqfLptvjAgx0KczycBwv5kPjBoZ+8VMEMKQsb
         sVrqv0V2GzSiFD+AVxt+ay4+tTytpE7PTm1H7Z0AgvGVyG0vzjnoMpJSviVkwe862r
         Heqlw1SVrFpBQ==
Received: by pali.im (Postfix)
        id 9B538723; Fri,  3 Feb 2023 18:46:18 +0100 (CET)
Date:   Fri, 3 Feb 2023 18:46:18 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: marvell: add DTS for GL.iNet GL-MV1000
Message-ID: <20230203174618.arqh2gqspoh3rlt6@pali>
References: <20230202093706.30995-1-mrkiko.rs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202093706.30995-1-mrkiko.rs@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2023 10:37:06 Enrico Mioso wrote:
> The GL-MV1000 (Brume) is a small form-factor gateway router.
> It is based on the Marvell Armada 88F3720 SOC (1GHz), has 3 gigabit ethernet ports, 1 GB RAM, 16M SPI flash, 8GB eMMC and an uSD slot, as well as an USB 2.0 type A and an USB 3.0 type C port.
> 
> Signed-off-by: Enrico Mioso <mrkiko.rs@gmail.com>
> CC: Pali <pali@kernel.org>

Looks good,

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../dts/marvell/armada-3720-gl-mv1000.dts     | 239 ++++++++++++++++++
>  2 files changed, 240 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 058237681fe5..79ac09b58a89 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-gl-mv1000.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> new file mode 100644
> index 000000000000..b1b45b4fa9d4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model = "GL.iNet GL-MV1000";
> +	compatible = "glinet,gl-mv1000", "marvell,armada3720";
> +
> +	aliases {
> +		led-boot = &led_power;
> +		led-failsafe = &led_power;
> +		led-running = &led_power;
> +		led-upgrade = &led_power;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> +	};
> +
> +	vcc_sd_reg1: regulator {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vcc_sd1";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +
> +		gpios-states = <0>;
> +		states = <1800000 0x1
> +			3300000 0x0>;
> +		enable-active-high;
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +
> +		reset {
> +			label = "reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		switch {
> +			label = "switch";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpiosb 22 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		vpn {
> +			label = "green:vpn";
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		wan {
> +			label = "green:wan";
> +			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led_power: power {
> +			label = "green:power";
> +			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		reg = <0>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <104000000>;
> +		m25p,fast-read;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "firmware";
> +				reg = <0 0xf0000>;
> +			};
> +
> +			partition@f0000 {
> +				label = "u-boot-env";
> +				reg = <0xf0000 0x8000>;
> +			};
> +
> +			factory: partition@f8000 {
> +				label = "factory";
> +				reg = <0xf8000 0x8000>;
> +				read-only;
> +			};
> +
> +			partition@100000 {
> +				label = "dtb";
> +				reg = <0x100000 0x10000>;
> +				read-only;
> +			};
> +
> +			partition@110000 {
> +				label = "rescue";
> +				reg = <0x110000 0x1000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&sdhci1 {
> +	wp-inverted;
> +	bus-width = <4>;
> +	cd-gpios = <&gpionb 17 GPIO_ACTIVE_LOW>;
> +	marvell,pad-type = "sd";
> +	no-1-8-v;
> +	vqmmc-supply = <&vcc_sd_reg1>;
> +	status = "okay";
> +};
> +
> +&sdhci0 {
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	marvell,pad-type = "fixed-1-8v";
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&mdio {
> +	switch0: switch0@1 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <1>;
> +
> +		dsa,member = <0 0>;
> +
> +		ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				label = "cpu";
> +				ethernet = <&eth0>;
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				label = "wan";
> +				phy-handle = <&switch0phy0>;
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				label = "lan0";
> +				phy-handle = <&switch0phy1>;
> +
> +				nvmem-cells = <&macaddr_factory_6>;
> +				nvmem-cell-names = "mac-address";
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				label = "lan1";
> +				phy-handle = <&switch0phy2>;
> +
> +				nvmem-cells = <&macaddr_factory_6>;
> +				nvmem-cell-names = "mac-address";
> +			};
> +		};
> +
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			switch0phy0: switch0phy0@11 {
> +				reg = <0x11>;
> +			};
> +			switch0phy1: switch0phy1@12 {
> +				reg = <0x12>;
> +			};
> +			switch0phy2: switch0phy2@13 {
> +				reg = <0x13>;
> +			};
> +		};
> +	};
> +};
> +
> +&eth0 {
> +	nvmem-cells = <&macaddr_factory_0>;
> +	nvmem-cell-names = "mac-address";
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};
> +
> +&factory {
> +	compatible = "nvmem-cells";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	macaddr_factory_0: macaddr@0 {
> +		reg = <0x0 0x6>;
> +	};
> +
> +	macaddr_factory_6: macaddr@6 {
> +		reg = <0x6 0x6>;
> +	};
> +};
> -- 
> 2.39.1
> 
