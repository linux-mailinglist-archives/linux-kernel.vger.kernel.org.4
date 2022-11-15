Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9330262A270
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiKOUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiKOUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:04:20 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84E2D747;
        Tue, 15 Nov 2022 12:04:16 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFK3wau119608;
        Tue, 15 Nov 2022 14:03:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668542638;
        bh=rk+CU3daBc5J398ZpI08oiNhcy7xq480JMeOel81xoU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uwGUmkrWW4Fmd2rkJTEknHxXB17+9lnFRT0bilM/COCABTL5UOgwnT/mjFw4QgBL6
         Meuy0KxfhdBbTDTKcOPHpz9/a758rvcB6nUzc9bocOqhLj8+3xoclX4D1+cVRg8e0b
         iwfBfLsaJCK3D/eIo6FXKBmkD5zIKycKBr+idNKE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFK3w7W125941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 14:03:58 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 14:03:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 14:03:57 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFK3vfJ094274;
        Tue, 15 Nov 2022 14:03:57 -0600
Date:   Tue, 15 Nov 2022 14:03:57 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Robert Nelson <robertcnelson@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: ti: add k3-j721e-beagleboneai64
Message-ID: <20221115200357.qa2rvw3clbz7unzq@symptom>
References: <20221114215817.1953186-1-robertcnelson@gmail.com>
 <20221114215817.1953186-2-robertcnelson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221114215817.1953186-2-robertcnelson@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:58-20221114, Robert Nelson wrote:
[...]
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4555a5be2257..cf7c509538a4 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> new file mode 100644
> index 000000000000..55ffa9ba6c3a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -0,0 +1,1110 @@
> +// SPDX-License-Identifier: GPL-2.0
[...]

> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_default>;
> +
> +		led-0 {
> +			gpios = <&main_gpio0 96 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			gpios = <&main_gpio0 95 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_DISK_ACTIVITY;
> +			linux,default-trigger = "mmc0";
> +		};
> +
> +		led-2 {
> +			gpios = <&main_gpio0 97 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_CPU;
> +			linux,default-trigger = "cpu";
> +		};
> +
> +		led-3 {
> +			gpios = <&main_gpio0 110 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_DISK_ACTIVITY;
> +			linux,default-trigger = "mmc1";
> +		};
> +
> +		led-4 {
> +			gpios = <&main_gpio0 109 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/common.yaml#n82

we'd be Violating the oneOf conditions here.

> +			function = LED_FUNCTION_WLAN;
> +			default-state = "off";
> +		};
> +	};
> +
> +	evm_12v0: regulator-0 {
> +		/* main supply */
> +		compatible = "regulator-fixed";
> +		regulator-name = "evm_12v0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: regulator-1 {
> +		/* Output of LMS140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_5v0: regulator-2 {
> +		/* Output of LM5140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_pwr_en_pins_default>;
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vsys_3v3>;
> +		gpios = <&main_gpio0 82 GPIO_ACTIVE_HIGH>;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml

s/gpios/gpio ?

> +	};
> +
> +	vdd_sd_dv_alt: regulator-4 {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_alt_pins_default>;
> +		regulator-name = "tlv71033";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_5v0>;
> +		gpios = <&main_gpio0 117 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
> +	dp_pwr_3v3: regulator-5 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dp0_3v3_en_pins_default>;
> +		regulator-name = "dp-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>; /* DP0_PWR_SW_EN */

Same here - gpio ?

> +		enable-active-high;
> +	};

[...]

> +
> +
> +&main_gpio0 {
> +	gpio-line-names = "", "P9_11", "P9_13", "P8_17", "P8_18", /* 0-4 */
> +		"P8_22", "P8_24", "P8_34", "P8_36", "P8_38A", /* 5-9 */
> +		"P9_23", "P8_37B", "P9_26B", "P9_24B", "P8_08", /* 10-14 */
> +		"P8_07", "P8_10", "P8_09", "P9_42B", "", /* 15-19 */
> +		"P8_03", "TYPEC_PWR_ST", "M2_RSTz", "M2_I2C_ALERT#", "P8_35A", /* 20-24 */
> +		"P8_33A", "P8_32A", "", "P9_17A", "", /* 25-29 */
> +		"P8_21", "P8_23", "P8_31A", "P8_05", "P8_06", /* 30-34 */
> +		"P8_25", "M2_W_DISABLE1#", "M2_W_DISABLE2#", "P9_22A (BOOTMODE1)", "P9_21A", /* 35-39 */
> +		"P9_18A", "DSI_I2C_SCL", "DSI_I2C_SDA", "P9_28B", "P9_30B", /* 40-44 */
> +		"P9_12", "P9_27A", "P9_15", "P8_04 (BOOTMODE2)", "VCC_DP_EN", /* 45-49 */
> +		"P9_33B", "P8_26", "P9_31B", "P9_29B", "P9_39B", /* 50-54 */
> +		"P9_35B", "P9_36B", "P9_37B", "P9_38B", "P8_12", /* 55-59 */
> +		"P8_11 (BOOTMODE7)", "P8_15", "P8_16", "", "", /* 60-64 */
> +		"P8_43", "P8_44", "P8_41", "P8_42 (BOOTMODE6)", "P8_39", /* 65-69 */
> +		"P8_40", "P8_27", "P8_28", "P8_29", "P8_30", /* 70-74 */
> +		"P8_14", "P8_20", "P9_20B", "P9_19B", "P8_45", /* 75-79 */
> +		"P8_46 (BOOTMODE3)", "P9_40B", "VDD_SD_EN", "CSI_I2C_SCL", "CSI_I2C_SDA", /* 80-84 */
> +		"M2_I2S_SCK", "M2_I2S_WS", "M2_I2S_IN", "P8_19", "P8_13", /* 85-89 */
> +		"P9_21B", "P9_22B", "M2_I2S_OUT", "P9_14", "P9_16", /* 90-94 */
> +		"USR1", "USR0", "USR2", "DSI_GPIO1", "FAN_PWM", /* 95-99 */
> +		"FAN_TACH", "CSI1_GPIO1", "CSI0_GPIO2", "CSI0_GPIO1", "P9_25B", /* 100-104 */
> +		"P8_38B", "P8_37A", "CSI1_GPIO2", "DSI_GPIO2", "USR4", /* 105-109 */
> +		"USR3", "P8_33B", "DP_HPD", "M2_UART_CTSn", "M2_UART_RTSn", /* 110-114 */
> +		"P9_17B", "P8_35B", "VDD_SD_SEL", "P9_26A", "P9_24A", /* 115-119 */
> +		"P9_18B", "CONSOLE_RX", "CONSOLE_TX", "P9_42A", "P9_27B", /* 120-124 */
> +		"M2_UART_RX", "M2_UART_TX", "P9_25A"; /* 125-127 */

Can we drop the gpio-line-names description for now?
gpio-line-names: maxItems: 32 in
Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml - that probably
should be fixed prior to this else we get the dtbs_check warning around
this. The max count actually depends on ti,ngpio - So, I think the
schema is probably not accurate here.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
