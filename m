Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8402D625A61
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiKKMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKKMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:19:18 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74566315A;
        Fri, 11 Nov 2022 04:19:15 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ABCJ5UQ037678;
        Fri, 11 Nov 2022 06:19:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668169145;
        bh=RxZQqT7CzYYwrQOggpseJOaSexhZund2j84t2+jgt3w=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GFpCfZBtN6aDbq76Nb3f7OCZw3YsieoeejIFp9pQFAKbxK/1E0pgqr8gfBhM6BQ0/
         zEzbi6gr3NGLnYHf+pnJlPgbkrBMvlPDHuzUw3vOCyPgkYw9jtXkD/DS5WVqDjOWlV
         d0Xbgw4bjeZuVUTPiKV0aDp7qgLUM+hyDFRRBpmg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ABCJ5V3061190
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Nov 2022 06:19:05 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 11
 Nov 2022 06:19:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 11 Nov 2022 06:19:04 -0600
Received: from [10.250.233.43] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ABCIwSQ010732;
        Fri, 11 Nov 2022 06:18:59 -0600
Message-ID: <581d0735-8294-5805-9a44-ed4ec3e9ae54@ti.com>
Date:   Fri, 11 Nov 2022 17:48:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: Add support for J784S4 EVM board
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Hari Nagalla <hnagalla@ti.com>
References: <20221014082314.118361-1-a-nandan@ti.com>
 <20221014082314.118361-5-a-nandan@ti.com>
 <cd5dbbb0-2d9f-8d7d-b051-f8d01d710c62@ti.com>
Content-Language: en-US
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <cd5dbbb0-2d9f-8d7d-b051-f8d01d710c62@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/10/22 23:01, Andrew Davis wrote:
> On 10/14/22 3:23 AM, Apurva Nandan wrote:
>> J784S4 EVM board is designed for TI J784S4 SoC. It supports the following
>> interfaces:
>> * 32 GB DDR4 RAM
>> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
>> * x1 Input Audio Jack, x1 Output Audio Jack
>> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
>> * x2 4L PCIe connector
>> * x1 UHS-1 capable micro-SD card slot
>> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>>     UFS flash.
>> * x6 UART through UART-USB bridge
>> * XDS110 for onboard JTAG debug using USB
>> * Temperature sensors, user push buttons and LEDs
>> * 40-pin User Expansion Connector
>> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
>> * x1 15-pin CSI header
>> * x6 MCAN instances
>>
>> Add basic support for J784S4-EVM.
>>
>> Schematics: https://www.ti.com/lit/zip/sprr458
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>    arch/arm64/boot/dts/ti/Makefile          |   2 +
>>    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 199 +++++++++++++++++++++++
>>    2 files changed, 201 insertions(+)
>>    create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 02e5d80344d0..6381c458738a 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>>    
>>    dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>>    
>> +dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>> +
>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>    
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> new file mode 100644
>> index 000000000000..bf2f2dfb7658
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -0,0 +1,199 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>> + *
>> + * Common Processor Board: https://www.ti.com/tool/J721EXCPXEVM
> This doesn't seem to be the right EVM, I'd just drop this link.
>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/net/ti-dp83867.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "k3-j784s4.dtsi"
>> +
>> +/ {
>> +	compatible = "ti,j784s4-evm", "ti,j784s4";
>> +	model = "Texas Instruments J784S4 EVM";
>> +
>> +	chosen {
>> +		stdout-path = "serial2:115200n8";
>> +	};
>> +
>> +	aliases {
>> +		serial2 = &main_uart8;
>> +		mmc1 = &main_sdhci1;
>> +		i2c0 = &main_i2c0;
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* 32G RAM */
>> +		reg = <0x00 0x80000000 0x00 0x80000000>,
>> +		      <0x08 0x80000000 0x07 0x80000000>;
>> +	};
>> +
>> +	/* Reserving memory regions still pending */
> Comment not needed.
>
>> +	reserved_memory: reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		secure_ddr: optee@9e800000 {
>> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
>> +			alignment = <0x1000>;
> Is alignment needed here?
Okay, will drop this alignment property.
>
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	evm_12v0: regulator-evm12v0 {
>> +		/* main supply */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "evm_12v0";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vsys_3v3: regulator-vsys3v3 {
>> +		/* Output of LM5140 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vsys_3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&evm_12v0>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vsys_5v0: regulator-vsys5v0 {
>> +		/* Output of LM5140 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vsys_5v0";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&evm_12v0>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vdd_mmc1: regulator-sd {
>> +		/* Output of TPS22918 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_mmc1";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		vin-supply = <&vsys_3v3>;
>> +		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	vdd_sd_dv: regulator-TLV71033 {
>> +		/* Output of TLV71033 */
>> +		compatible = "regulator-gpio";
>> +		regulator-name = "tlv71033";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		vin-supply = <&vsys_5v0>;
>> +		gpios = <&main_gpio0 8 GPIO_ACTIVE_HIGH>;
>> +		states = <1800000 0x0>,
>> +			 <3300000 0x1>;
>> +	};
>> +};
>> +
>> +&main_pmx0 {
>> +	main_uart8_pins_default: main-uart8-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
>> +			J784S4_IOPAD(0x044, PIN_OUTPUT, 14) /* (AG37) MCASP0_AXR1.UART8_RTSn */
>> +			J784S4_IOPAD(0x0d0, PIN_INPUT, 11) /* (AP38) SPI0_CS1.UART8_RXD */
>> +			J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
>> +		>;
>> +	};
>> +
>> +	main_i2c0_pins_default: main-i2c0-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
>> +			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
>> +		>;
>> +	};
>> +
>> +	main_mmc1_pins_default: main-mmc1-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x104, PIN_INPUT, 0) /* (AB38) MMC1_CLK */
>> +			J784S4_IOPAD(0x108, PIN_INPUT, 0) /* (AB36) MMC1_CMD */
>> +			J784S4_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
> Pin ###?
This pin is not brought out physically, but needs to be muxed correctly 
internally.
Hence, there is no external pin/ball name.
>
> Andrew
>
>> +			J784S4_IOPAD(0x0fc, PIN_INPUT, 0) /* (AA33) MMC1_DAT0 */
>> +			J784S4_IOPAD(0x0f8, PIN_INPUT, 0) /* (AB34) MMC1_DAT1 */
>> +			J784S4_IOPAD(0x0f4, PIN_INPUT, 0) /* (AA32) MMC1_DAT2 */
>> +			J784S4_IOPAD(0x0f0, PIN_INPUT, 0) /* (AC38) MMC1_DAT3 */
>> +			J784S4_IOPAD(0x0e8, PIN_INPUT, 8) /* (AR38) TIMER_IO0.MMC1_SDCD */
>> +		>;
>> +	};
>> +
>> +	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
>> +		>;
>> +	};
>> +};
>> +
>> +&main_uart8 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_uart8_pins_default>;
>> +};
>> +
>> +&main_i2c0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_i2c0_pins_default>;
>> +
>> +	clock-frequency = <400000>;
>> +
>> +	exp1: gpio@20 {
>> +		compatible = "ti,tca6416";
>> +		reg = <0x20>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		gpio-line-names = "PCIE1_2L_MODE_SEL", "PCIE1_4L_PERSTZ", "PCIE1_2L_RC_RSTZ",
>> +				  "PCIE1_2L_EP_RST_EN", "PCIE0_4L_MODE_SEL", "PCIE0_4L_PERSTZ",
>> +				  "PCIE0_4L_RC_RSTZ", "PCIE0_4L_EP_RST_EN", "PCIE1_4L_PRSNT#",
>> +				  "PCIE0_4L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3",
>> +				  "AUDIO_MUX_SEL", "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTZ";
>> +	};
>> +
>> +	exp2: gpio@22 {
>> +		compatible = "ti,tca6424";
>> +		reg = <0x22>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		gpio-line-names = "R_GPIO_RGMII1_RST", "ENET2_I2CMUX_SEL", "GPIO_USD_PWR_EN",
>> +				  "USBC_PWR_EN", "USBC_MODE_SEL1", "USBC_MODE_SEL0",
>> +				  "GPIO_LIN_EN", "R_CAN_STB", "CTRL_PM_I2C_OE#",
>> +				  "ENET2_EXP_PWRDN", "ENET2_EXP_SPARE2", "CDCI2_RSTZ",
>> +				  "USB2.0_MUX_SEL", "CANUART_MUX_SEL0", "CANUART_MUX2_SEL1",
>> +				  "CANUART_MUX1_SEL1", "ENET1_EXP_PWRDN", "ENET1_EXP_RESETZ",
>> +				  "ENET1_I2CMUX_SEL", "ENET1_EXP_SPARE2", "ENET2_EXP_RESETZ",
>> +				  "USER_INPUT1", "USER_LED1", "USER_LED2";
>> +	};
>> +};
>> +
>> +&main_sdhci1 {
>> +	/* SD card */
>> +	status = "okay";
>> +	pinctrl-0 = <&main_mmc1_pins_default>;
>> +	pinctrl-names = "default";
>> +	disable-wp;
>> +	vmmc-supply = <&vdd_mmc1>;
>> +	vqmmc-supply = <&vdd_sd_dv>;
>> +};
>> +
>> +&main_gpio0 {
>> +	status = "okay";
>> +};
>> +

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

