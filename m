Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE5602C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJRNDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJRNDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:03:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC39C5139
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:03:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 8so8542603qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AB2EbrChnmBL7oBGHE/6MtN2jF0J4wzaUTGiVzmnlVg=;
        b=x1ICTBgWWYFz1IFhPQ+53xfu8G3EaWVgNqfY1kfVOlN69hi3KO/2Gh8umBqAyLCI6R
         AMVcqdbRtpflmltS1Ouq3EHJhlqPCZtn04VSQ/M+aghoW1YSHQz73MXrqLAbAGoOz5gG
         uBewEzOsYqoZ0IORjxk8LT5/cT+oaxnLIhOsJVa6pcSDAk41d1NQtwQrIQnIvfDCI8Fw
         Kflir/RW7Jw7TsQ35a/iIZvxGvklnEkPYUb7MYNG9u3RmFKKCsRqykNXFflr+j9wC+Bk
         jeaMP3YJZ6dfuHjbS+8ivlVi3zEZabHeSRZEesYeVV5tQSl9182mrkx0+vR+OsOQp5Sb
         IBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB2EbrChnmBL7oBGHE/6MtN2jF0J4wzaUTGiVzmnlVg=;
        b=6ib8ldJ9FO6TN/1t92lNmUCOm19ckyc1Zq2HAANTWkRD2nnFGZnjSXLiSIxeeBvmvP
         Da3Vc7PEXIfRYs+L9VMSpis4ZhzweBDOmMWC+I2BHZswt4cMpFmj8pDLSNywViMJLcaO
         H+O7Hg+VRGFRlQ6nNaOedcKfw6vPkcT6IWUTsGp/aDR+/3SnJau1gm5UPup7QIPrEZ2E
         w7qZri9PAHhV2aMafGdUUQd9C1Sgc+fH076P0rrF2YpgDoUMIQZR8mpF/QAiZkdS2Cc5
         EdSTELZmXDwDWnEus3ytGF6BD+uKS6FDK4VXSPPDWuxmWbsSR+wekPN98ceYw5go6ZXY
         iPQQ==
X-Gm-Message-State: ACrzQf1P0BbAlAigyulC9eMhxRM7hgFaP3RX9+8yy6GCsfS3eIuQZArs
        Dcka0B30GKxhqAzM0cm8oVL+TQ==
X-Google-Smtp-Source: AMsMyM7FeQZGGQk4O5PWn+dFyE24MMaawpBbfCr7zAgXa6AlMNuAtHJeYuPeZPZAjtT4ob+Xsl5IJg==
X-Received: by 2002:a05:620a:b52:b0:6ec:6204:3d7b with SMTP id x18-20020a05620a0b5200b006ec62043d7bmr1726415qkg.68.1666098180399;
        Tue, 18 Oct 2022 06:03:00 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a248800b006bb0f9b89cfsm2453477qkn.87.2022.10.18.06.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:02:59 -0700 (PDT)
Message-ID: <3f1afad0-1e93-4843-defd-ca32c308cc9e@linaro.org>
Date:   Tue, 18 Oct 2022 09:02:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] arch: arm64: ti: Add support for AM68 SK base board
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20221018123849.23695-1-sinthu.raja@ti.com>
 <20221018123849.23695-4-sinthu.raja@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221018123849.23695-4-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 08:38, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The SK architecture comprises of baseboard and a SOM board. It is
> as follows,
> 
>        +--------------------------------------+---+
>        |                                      |   |<--Connectors
>        |                                      +---|
>        |      +---------------------------+   |   |
>        |      | SOM                       |   +---|
>        |      |                           |   |   |
>        |      |                           |   +---| Power Supply
>        |      |                           |       |   |
>        |      +---------------------------+       |   |
>        |                                          |<--+
>        |           BASE BOARD                     |
>        +------------------------------------------+

This is pretty straightforward for SoM, I am not sure what's the benefit
to add it.

> 
> AM68 Starter Kit's baseboard contains most of the actual connectors,
> power supply etc. The System on Module (SoM) is plugged on to the base
> board. Therefore, add support for peripherals brought out in the base
> board.
> 
> Schematics: https://www.ti.com/lit/zip/SPRR463
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 459 ++++++++++++++++++
>  2 files changed, 461 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4555a5be2257..498b089d96f8 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
> +

Alphabetical order, although does not look like other entries are ordered...

>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> new file mode 100644
> index 000000000000..f51cbd2e3b72
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Base Board: https://www.ti.com/lit/zip/SPRR463
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am68-sk-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +
> +/ {
> +	compatible = "ti,am68-sk", "ti,j721s2";
> +	model = "Texas Instruments AM68 SK";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";

None of these bootargs are suitable for mainline. earlycon for sure - it
is pure debug option.

> +	};
> +
> +	aliases {
> +		serial2 = &main_uart8;
> +		mmc1 = &main_sdhci1;
> +		can0 = &mcu_mcan0;
> +		can1 = &mcu_mcan1;
> +		can2 = &main_mcan6;
> +		can3 = &main_mcan7;
> +	};
> +
> +	vusb_main: fixedregulator-vusb-main5v0 {

Not "fixedregulator-" but just "regulator-"

Same in other places.

> +		/* USB MAIN INPUT 5V DC */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vusb-main5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: fixedregulator-vsys3v3 {
> +		/* Output of LM5141 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vusb_main>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: fixedregulator-sd {
> +		/* Output of TPS22918 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vsys_3v3>;
> +		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv: gpio-regulator-TLV71033 {

1. regulator-xxxxxx
2. lowercase node name

> +		/* Output of TLV71033 */
> +		compatible = "regulator-gpio";
> +		regulator-name = "tlv71033";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_3v3>;
> +		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
> +	vsys_io_1v8: regulator-vsys-io-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_io_1v2: regulator-vsys-io-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	transceiver1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan0_pins_default>;
> +		standby-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan1_pins_default>;
> +		standby-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver3: can-phy2 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_mcan6_pins_default>;
> +		standby-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver4: can-phy3 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_mcan7_pins_default>;
> +		standby-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&main_pmx0 {
> +

No need for blank line.

> +	main_uart8_pins_default: main-uart8-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
> +			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: i2c0_pins_default {

No underscores in node names. Why do you use here different style than
in other places?

> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0e0, PIN_INPUT, 0) /* (AH25) I2C0_SCL */
> +			J721S2_IOPAD(0x0e4, PIN_INPUT, 0) /* (AE24) I2C0_SDA */
> +		>;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
> +			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
> +			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
> +			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
> +			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
> +			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
> +			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
> +		>;
> +	};
> +
> +	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0c4, PIN_INPUT, 7) /* (AB26) ECAP0_IN_APWM_OUT.GPIO0_49 */
> +		>;
> +	};
> +
> +	main_usbss0_pins_default: main-usbss0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
> +		>;
> +	};
> +
> +	main_mcan6_pins_default: mcan6_pins_default {

Be sure you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x098, PIN_INPUT, 0) /* (V25) MCASP0_AXR10.MCAN6_RX */
> +			J721S2_IOPAD(0x094, PIN_INPUT, 0) /* (AA25) MCASP0_AXR9.MCAN6_TX */
> +		>;
> +	};
> +
> +	main_mcan7_pins_default: mcan7_pins_default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
> +			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
> +		>;
> +	};
> +
> +};
> +
> +&wkup_pmx0 {
> +	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
> +			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
> +			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
> +			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
> +			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
> +			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
> +			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
> +			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
> +			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
> +			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
> +			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
> +			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	mcu_mdio_pins_default: mcu-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
> +			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
> +		>;
> +	};
> +
> +	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
> +			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
> +			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
> +		>;
> +	};
> +
> +	mcu_i2c1_pins_default: mcu_i2c1_pins_default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
> +			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
> +		>;
> +	};
> +

Drop line

> +};
> +
> +&main_gpio2 {
> +	status = "disabled";
> +};
> +
Best regards,
Krzysztof

