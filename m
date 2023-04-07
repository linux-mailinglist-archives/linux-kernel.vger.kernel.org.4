Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5544F6DAFA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjDGPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:24:43 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6AB9EE5;
        Fri,  7 Apr 2023 08:24:29 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 804F8FF802;
        Fri,  7 Apr 2023 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680881067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVJevmstjvTLekBw3KmH6h3qZSNHahDWW8/Xhd0wQwM=;
        b=dCFjQl1q2MvQIxunEVSEb4wDT9vmB74NbrHfNJfzEefkIruTVkl4fOe+dkvwGgazRjNv9W
        DyOJlsqUNh7Qwu0EtPrtSdj6fMeJA7WYGc6lKSszrhazvZa2fTmhH7KuwqT9I3uO6wCeE/
        pC0ybnUyJQ0TbaOWX8doG4uMuAl35/aeyaS/dbvvoH8SyxWPKtro8COhSqVL1qiSBmAiyM
        F5dC7UQkDLgvQdpriz+zLZtW1tvGZ1qDWAkWJfAGo4U1aJ3YRHGrQ1iKz8L4ivqSinfPtW
        U71UTLhTJfudGwtO4gmJLskfsq/B6E+KJegnrqlsKPyJWxne40VWpxCzPEA7ag==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: marvell: add DTS for GL.iNet GL-MV1000
In-Reply-To: <20230203174618.arqh2gqspoh3rlt6@pali>
References: <20230202093706.30995-1-mrkiko.rs@gmail.com>
 <20230203174618.arqh2gqspoh3rlt6@pali>
Date:   Fri, 07 Apr 2023 17:24:27 +0200
Message-ID: <87pm8f3ec4.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Thursday 02 February 2023 10:37:06 Enrico Mioso wrote:
>> The GL-MV1000 (Brume) is a small form-factor gateway router.
>> It is based on the Marvell Armada 88F3720 SOC (1GHz), has 3 gigabit ethe=
rnet ports, 1 GB RAM, 16M SPI flash, 8GB eMMC and an uSD slot, as well as a=
n USB 2.0 type A and an USB 3.0 type C port.
>>=20
>> Signed-off-by: Enrico Mioso <mrkiko.rs@gmail.com>
>> CC: Pali <pali@kernel.org>
>
> Looks good,
>
> Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>


Applied on mvebu/dt64

Thanks,

Gregory

>
>> ---
>>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>>  .../dts/marvell/armada-3720-gl-mv1000.dts     | 239 ++++++++++++++++++
>>  2 files changed, 240 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
>>=20
>> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/=
marvell/Makefile
>> index 058237681fe5..79ac09b58a89 100644
>> --- a/arch/arm64/boot/dts/marvell/Makefile
>> +++ b/arch/arm64/boot/dts/marvell/Makefile
>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-espressobin-em=
mc.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-espressobin-ultra.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-espressobin-v7.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-espressobin-v7-emmc.dtb
>> +dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-gl-mv1000.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-turris-mox.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-uDPU.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-7040-db.dtb
>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
>> new file mode 100644
>> index 000000000000..b1b45b4fa9d4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
>> @@ -0,0 +1,239 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include "armada-372x.dtsi"
>> +
>> +/ {
>> +	model =3D "GL.iNet GL-MV1000";
>> +	compatible =3D "glinet,gl-mv1000", "marvell,armada3720";
>> +
>> +	aliases {
>> +		led-boot =3D &led_power;
>> +		led-failsafe =3D &led_power;
>> +		led-running =3D &led_power;
>> +		led-upgrade =3D &led_power;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path =3D "serial0:115200n8";
>> +	};
>> +
>> +	memory@0 {
>> +		device_type =3D "memory";
>> +		reg =3D <0x00000000 0x00000000 0x00000000 0x20000000>;
>> +	};
>> +
>> +	vcc_sd_reg1: regulator {
>> +		compatible =3D "regulator-gpio";
>> +		regulator-name =3D "vcc_sd1";
>> +		regulator-min-microvolt =3D <1800000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		regulator-boot-on;
>> +
>> +		gpios-states =3D <0>;
>> +		states =3D <1800000 0x1
>> +			3300000 0x0>;
>> +		enable-active-high;
>> +	};
>> +
>> +	keys {
>> +		compatible =3D "gpio-keys";
>> +
>> +		reset {
>> +			label =3D "reset";
>> +			linux,code =3D <KEY_RESTART>;
>> +			gpios =3D <&gpionb 14 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		switch {
>> +			label =3D "switch";
>> +			linux,code =3D <BTN_0>;
>> +			gpios =3D <&gpiosb 22 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible =3D "gpio-leds";
>> +
>> +		vpn {
>> +			label =3D "green:vpn";
>> +			gpios =3D <&gpionb 11 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		wan {
>> +			label =3D "green:wan";
>> +			gpios =3D <&gpionb 12 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led_power: power {
>> +			label =3D "green:power";
>> +			gpios =3D <&gpionb 13 GPIO_ACTIVE_LOW>;
>> +			default-state =3D "on";
>> +		};
>> +	};
>> +};
>> +
>> +&spi0 {
>> +	status =3D "okay";
>> +
>> +	flash@0 {
>> +		reg =3D <0>;
>> +		compatible =3D "jedec,spi-nor";
>> +		spi-max-frequency =3D <104000000>;
>> +		m25p,fast-read;
>> +		partitions {
>> +			compatible =3D "fixed-partitions";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +
>> +			partition@0 {
>> +				label =3D "firmware";
>> +				reg =3D <0 0xf0000>;
>> +			};
>> +
>> +			partition@f0000 {
>> +				label =3D "u-boot-env";
>> +				reg =3D <0xf0000 0x8000>;
>> +			};
>> +
>> +			factory: partition@f8000 {
>> +				label =3D "factory";
>> +				reg =3D <0xf8000 0x8000>;
>> +				read-only;
>> +			};
>> +
>> +			partition@100000 {
>> +				label =3D "dtb";
>> +				reg =3D <0x100000 0x10000>;
>> +				read-only;
>> +			};
>> +
>> +			partition@110000 {
>> +				label =3D "rescue";
>> +				reg =3D <0x110000 0x1000000>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&sdhci1 {
>> +	wp-inverted;
>> +	bus-width =3D <4>;
>> +	cd-gpios =3D <&gpionb 17 GPIO_ACTIVE_LOW>;
>> +	marvell,pad-type =3D "sd";
>> +	no-1-8-v;
>> +	vqmmc-supply =3D <&vcc_sd_reg1>;
>> +	status =3D "okay";
>> +};
>> +
>> +&sdhci0 {
>> +	bus-width =3D <8>;
>> +	mmc-ddr-1_8v;
>> +	mmc-hs400-1_8v;
>> +	non-removable;
>> +	no-sd;
>> +	no-sdio;
>> +	marvell,pad-type =3D "fixed-1-8v";
>> +	status =3D "okay";
>> +};
>> +
>> +&usb3 {
>> +	status =3D "okay";
>> +};
>> +
>> +&usb2 {
>> +	status =3D "okay";
>> +};
>> +
>> +&uart0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&mdio {
>> +	switch0: switch0@1 {
>> +		compatible =3D "marvell,mv88e6085";
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		reg =3D <1>;
>> +
>> +		dsa,member =3D <0 0>;
>> +
>> +		ports: ports {
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +
>> +			port@0 {
>> +				reg =3D <0>;
>> +				label =3D "cpu";
>> +				ethernet =3D <&eth0>;
>> +			};
>> +
>> +			port@1 {
>> +				reg =3D <1>;
>> +				label =3D "wan";
>> +				phy-handle =3D <&switch0phy0>;
>> +			};
>> +
>> +			port@2 {
>> +				reg =3D <2>;
>> +				label =3D "lan0";
>> +				phy-handle =3D <&switch0phy1>;
>> +
>> +				nvmem-cells =3D <&macaddr_factory_6>;
>> +				nvmem-cell-names =3D "mac-address";
>> +			};
>> +
>> +			port@3 {
>> +				reg =3D <3>;
>> +				label =3D "lan1";
>> +				phy-handle =3D <&switch0phy2>;
>> +
>> +				nvmem-cells =3D <&macaddr_factory_6>;
>> +				nvmem-cell-names =3D "mac-address";
>> +			};
>> +		};
>> +
>> +		mdio {
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +
>> +			switch0phy0: switch0phy0@11 {
>> +				reg =3D <0x11>;
>> +			};
>> +			switch0phy1: switch0phy1@12 {
>> +				reg =3D <0x12>;
>> +			};
>> +			switch0phy2: switch0phy2@13 {
>> +				reg =3D <0x13>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&eth0 {
>> +	nvmem-cells =3D <&macaddr_factory_0>;
>> +	nvmem-cell-names =3D "mac-address";
>> +	phy-mode =3D "rgmii-id";
>> +	status =3D "okay";
>> +
>> +	fixed-link {
>> +		speed =3D <1000>;
>> +		full-duplex;
>> +	};
>> +};
>> +
>> +&factory {
>> +	compatible =3D "nvmem-cells";
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <1>;
>> +
>> +	macaddr_factory_0: macaddr@0 {
>> +		reg =3D <0x0 0x6>;
>> +	};
>> +
>> +	macaddr_factory_6: macaddr@6 {
>> +		reg =3D <0x6 0x6>;
>> +	};
>> +};
>> --=20
>> 2.39.1
>>=20

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
