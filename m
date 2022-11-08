Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861B621B60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiKHSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiKHSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:01:53 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA74E438
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:01:51 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id h12so22264411ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvGNfl+xUwynFcEarWovhqAApUecQPFN2ZOjRKIqluY=;
        b=VVw6KznYF6yLbGa0C2qr/w+3Q+sRsTBZ9+uZ9VAWo2yNOrzfqz+sk3KtZ/U0NqgRNz
         s0Yk2Mjfpl5BG296P1WEGWlXCvluBqcq/rAPO0Hax94lftfo4cDmR3Q2t8Uw1ha8WsQQ
         3hDPMmCfO9cFSLAvBAXaLiybTN1iq3P07nToDyL4hyt8YzAoVSI5IlKYpTsm3Zez9GBa
         8VHFEdJziLd8F+61imDq7sEyWNlasxuCPXSlF/SwSfXO7JojvVVsdlAAEsX8/2EJ3C9j
         LYdZ6Rdf1AfOZ9hs6tT9jqoi9WZAb3wzDZLW9qnIudXvXdpuOzKi0+LAqxJrEKB6zSv7
         u+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvGNfl+xUwynFcEarWovhqAApUecQPFN2ZOjRKIqluY=;
        b=tMwKPGvODDnLa9Sn28yYJG5PeZVtGbaUz0jfymUlhXaSMVJoJAEYGIryPItpGLyE+f
         ICj/MG19C2INjoiqmCnJyI67puR5mxKw6mXQeLPwCqd9UpIJtFTGpYn8rlv55l8zzXtx
         ZUHYDUnE1urdb7MTis/FLY+thsn7X6SJxpG7SXvix7f+T8ouLUtCPUTguQlLgusxm1i2
         2iPVjhaG5Y9BK6Iu5qHX7KfY/4Utzek48o+/G3IVSCmcF8d/ECtEmJ4m3MGcekqq3fUY
         77TGs6UBZpWwJ3Mftg2EM77NVRvW3i6RrIvZuRP/2YOlThwGfZWkLneCSp3IQTpf92R8
         qT6w==
X-Gm-Message-State: ANoB5pk87BWer1dXu+O7VMntuy2Bc+IUyO6bXEvF7q3sqjqmalpFR6jI
        yE6NiMssoVZ7bGr6tDaU2LNZDg==
X-Google-Smtp-Source: AA0mqf4x4o6jubMb5oppXLP9yHRFR4HYjr+sagv1qttLsORS2s7rL9vaMtk76mhrxqGIySor4XS2CQ==
X-Received: by 2002:a05:651c:106c:b0:277:3026:c5d1 with SMTP id y12-20020a05651c106c00b002773026c5d1mr1790300ljm.292.1667930508324;
        Tue, 08 Nov 2022 10:01:48 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t9-20020a05651c204900b0026fc8855c20sm1818620ljo.19.2022.11.08.10.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:01:47 -0800 (PST)
Message-ID: <414f8281-80ba-dd2c-e5f9-9e9cde1ad1e0@linaro.org>
Date:   Tue, 8 Nov 2022 19:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: Add support for
 phyBOARD-Electra-AM642
To:     Wadim Egorov <w.egorov@phytec.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     upstream@phytec.de, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20221108175050.285340-1-w.egorov@phytec.de>
 <20221108175050.285340-2-w.egorov@phytec.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108175050.285340-2-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 18:50, Wadim Egorov wrote:
> Add basic support for phyCORE-AM64x SoM & phyBOARD-Electra-AM642 CB.
> 
> The phyCORE-AM64x [1] is a SoM (System on Module) featuring TI's AM64x SoC.
> It can be used in combination with different carrier boards.
> This module can come with different sizes and models for
> DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
> 
> A development Kit, called phyBOARD-Electra [2] is used as a carrier board
> reference design around the AM64x SoM.
> 
> Supported features:
>   * Debug UART
>   * Heartbeat LED
>   * GPIO buttons & LEDs
>   * SPI NOR flash
>   * SPI TPM Chip
>   * eMMC
>   * CAN
>   * Ethernet
>   * Micro SD card
>   * I2C EEPROM
>   * I2C RTC
>   * I2C LED Dimmer
>   * USB
> 
> For more details, see:
> 
> [1] Product page SoM: https://www.phytec.com/product/phycore-am64x
> [2] Product page CB: https://www.phytec.com/product/phyboard-am64x
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v2:
>   - Update commit message
>   - Add links to product pages for SoM & CB
>   - Drop "fixed" from regulator node names
>   - Use generic node names for pmic, tpm, leds & keys
>   - Update compatible of som.dtsi
>   - Remove not needed node labels for pmic, tpm
>   - Remove not needed R5 core mailbox & reserved memory definitions
>     This is use case specific and should not be defined in the som.dtsi
>   - Provide aliases for used devices by SoM & CB
>   - Fixed led definition: Provide proper default-trigger, function & color
>   - Renamed rtc label to i2c_som_rtc
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 286 ++++++++++++++++
>  .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 321 ++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4555a5be2257..79331f16cd4b 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> new file mode 100644
> index 000000000000..86e6b87b826a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Matt McKee <mmckee@phytec.com>
> + *
> + * Copyright (C) 2022 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phycore-am64x
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "PHYTEC phyCORE-AM64x";
> +	compatible = "phytec,am64-phycore-som", "ti,am642";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		mmc0 = &sdhci0;
> +		rtc0 = &i2c_som_rtc;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&leds_pins_default>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +	};
> +
> +	vcc_5v0_som: vcc-5v0-som {

I asked to drop "fixed", not other generic parts.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		/* VIN / VCC_5V0_SOM */
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_5V0_SOM";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&main_pmx0 {
> +	cpsw_mdio_pins_default: cpsw-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)	/* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
> +			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)	/* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
> +			AM64X_IOPAD(0x0100, PIN_OUTPUT, 7)	/* (V7) PRG1_PRU0_GPO18.GPIO0_63 */
> +		>;
> +	};
> +
> +	cpsw_rgmii1_pins_default: cpsw-rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0184, PIN_INPUT, 4)	/* (W6) PRG0_PRU0_GPO9.RGMII1_RX_CTL */
> +			AM64X_IOPAD(0x0188, PIN_INPUT, 4)	/* (AA5) PRG0_PRU0_GPO10.RGMII1_RXC */
> +			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)	/* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
> +			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4)	/* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
> +			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)	/* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
> +			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)	/* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
> +			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)	/* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
> +			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)	/* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
> +			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)	/* (V6) PRG0_PRU1_GPO10.RGMII1_RD2 */
> +			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)	/* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
> +			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)	/* (V5) PRG0_PRU1_GPO17.RGMII1_RD3 */
> +			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)	/* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
> +			AM64X_IOPAD(0x0154, PIN_INPUT, 7)	/* (V12) PRG1_PRU1_GPO19.GPIO0_84 */
> +		>;
> +	};
> +
> +	eeprom_wp_pins_default: eeprom-wp-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0208, PIN_OUTPUT, 7)	/* (D12) SPI0_CS0.GPIO1_42 */
> +		>;
> +	};
> +
> +	leds_pins_default: leds-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7)	/* (L18) OSPI0_CSn1.GPIO0_12 */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* (A18) I2C0_SCL */
> +			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* (B18) I2C0_SDA */
> +		>;
> +	};
> +
> +	ospi0_pins_default: ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)	/* (N20) OSPI0_CLK */
> +			AM64X_IOPAD(0x0008, PIN_INPUT, 0)	/* (N19) OSPI0_DQS */
> +			AM64X_IOPAD(0x000c, PIN_INPUT, 0)	/* (M19) OSPI0_D0 */
> +			AM64X_IOPAD(0x0010, PIN_INPUT, 0)	/* (M18) OSPI0_D1 */
> +			AM64X_IOPAD(0x0014, PIN_INPUT, 0)	/* (M20) OSPI0_D2 */
> +			AM64X_IOPAD(0x0018, PIN_INPUT, 0)	/* (M21) OSPI0_D3 */
> +			AM64X_IOPAD(0x001c, PIN_INPUT, 0)	/* (P21) OSPI0_D4 */
> +			AM64X_IOPAD(0x0020, PIN_INPUT, 0)	/* (P20) OSPI0_D5 */
> +			AM64X_IOPAD(0x0024, PIN_INPUT, 0)	/* (N18) OSPI0_D6 */
> +			AM64X_IOPAD(0x0028, PIN_INPUT, 0)	/* (M17) OSPI0_D7 */
> +			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)	/* (L19) OSPI0_CSn0 */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cpsw_rgmii1_pins_default>;
> +};
> +
> +&cpsw3g_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cpsw_mdio_pins_default>;
> +
> +	cpsw3g_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		reset-gpios = <&main_gpio0 63 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1000>;
> +		reset-deassert-us = <1000>;
> +	};
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy1>;
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster2 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster3 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster4 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster5 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster6 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster7 {
> +	status = "disabled";
> +};
> +
> +&main_i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&eeprom_wp_pins_default>;
> +		pagesize = <32>;
> +		reg = <0x50>;
> +	};
> +
> +	i2c_som_rtc: rtc@52 {
> +		compatible = "microcrystal,rv3028";
> +		reg = <0x52>;
> +		trickle-resistor-ohms = <3000>;
> +	};
> +
> +	pmic@61 {
> +		compatible = "ti,lp8733";
> +		reg = <0x61>;
> +
> +		buck0-in-supply =<&vcc_5v0_som>;
> +		buck1-in-supply =<&vcc_5v0_som>;
> +		ldo0-in-supply =<&vdd_3v3>;
> +		ldo1-in-supply =<&vdd_3v3>;
> +
> +		regulators {
> +			vdd_core: buck0 {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_3v3: buck1 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_1v8_ldo0: ldo0 {
> +				regulator-name = "VDD_1V8_LDO0";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdda_1v8: ldo1 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +/* mcu_gpio0 is reserved for mcu firmware usage */
> +&mcu_gpio0 {
> +	status = "reserved";
> +};
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <0>;
> +	};
> +};
> +
> +&sdhci0 {
> +	bus-width = <8>;
> +	non-removable;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	keep-power-in-suspend;
> +};
> +
> +/* adc0 is reserved for R5 usage */
> +&tscadc0 {
> +	status = "reserved";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> new file mode 100644
> index 000000000000..15c554cd6fe4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Matt McKee <mmckee@phytec.com>
> + *
> + * Copyright (C) 2022 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phyboard-am64x
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/leds/leds-pca9532.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +#include <dt-bindings/phy/phy.h>
> +#include "k3-am642.dtsi"
> +#include "k3-am64-phycore-som.dtsi"
> +
> +/ {
> +	compatible = "phytec,am642-phyboard-electra-rdk",
> +		     "phytec,am64-phycore-som", "ti,am642";
> +	model = "PHYTEC phyBOARD-Electra-AM64x RDK";
> +
> +	aliases {
> +		mmc1 = &sdhci1;
> +		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart0;
> +	};
> +
> +	can_tc1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&can_tc1_pins_default>;
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	can_tc2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&can_tc2_pins_default>;
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pins_default>;
> +
> +		key-home {
> +			label = "home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&main_gpio0 17 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		key-menu {
> +			label = "menu";
> +			linux,code = <KEY_MENU>;
> +			gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&user_leds_pins_default>;
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&main_gpio0 15 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc0";
> +			function = LED_FUNCTION_DISK;
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc1";
> +			function = LED_FUNCTION_DISK;
> +		};
> +	};
> +
> +	vcc_3v3_mmc: regulator-sd {

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

