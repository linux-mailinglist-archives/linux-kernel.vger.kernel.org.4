Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5497C5F3D01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJDHEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJDHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:04:20 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341038697
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:04:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id k19so727003lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EX68fILOrwkOw/PWHtfiPH8faXfSotP5mMz4zz7I7/g=;
        b=fVkDYuJlzK8TnoBXd94hS7wwEGwyM0fsPXGgCHKTRKZj0+uRSBSG6Uf+1FmbY3ffeV
         LKy2/1RPpkF5/HVZrxQ18kFNwOptiK1MN61fDMC3Mfv5P03QCjAJxm48HrzeMy5QjvUQ
         MM+Pvh6Phog5w5CFudrq3InDNNbzbxpQEsmC0SXkkf6vMwq83LH72syJsXObzz6tZXa7
         oN/6rgrne2cvuFtRXwa+1AlWhEKJe/DcEE8w3lTMwDFZmjoCoxs34TteES+2iuXkeWY6
         UrojuvSmTsG9VsSjscoWPZxWmozEOfcxfLCxlTfxY1usSDu/uP9Jdu9lg9Bs86QemMQJ
         fjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EX68fILOrwkOw/PWHtfiPH8faXfSotP5mMz4zz7I7/g=;
        b=1X1GjrFM3Nj7X6bsI8JMbGuHqXLkLS/4AE+fb/UtrObpcHadUP5iTsh+xLvr7HCC2t
         LUJB9KF6U3//xOJnbWQXHSSASRf9xfZqa3ONAEta7Bz4IyXyCuevEqQq6jx9Q0HhuUwp
         ER7OQ3AK0Jh8CcAQthf4rX1vMU5NsLdszFYL26y+MWKeErFOZNxLH51CD1upoyPBnBEt
         amHma4rBuobp+NnxqDWYOABJli79JpZI4EVuETKUGwTvpwY3ssnzkrRyYyB9xe2fQqEJ
         5SeGD7lIwM7x+3aXH3pbsyJZOQuk5zcbkBKdmWeJc6iNCDECFXi+f+9Fc1+QOIpLf5J7
         SFFg==
X-Gm-Message-State: ACrzQf0NPzGviuUB0p3ED7fJdS+i1kZUI3I86rYmjch5sH2lPKOjlRUT
        uxzQM5JUolHShQn1OahI5UXvVw==
X-Google-Smtp-Source: AMsMyM5wBl4VWP8SnFYrzTlQSS6dvEnLzeGbwmH/+keuzXujb3Qv3VSvV8HrMvyMEbNMQiYEzLqu9g==
X-Received: by 2002:a2e:96d0:0:b0:26a:8a3c:861e with SMTP id d16-20020a2e96d0000000b0026a8a3c861emr7466095ljj.54.1664867056449;
        Tue, 04 Oct 2022 00:04:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y22-20020a197516000000b004946bb30469sm1786837lfe.82.2022.10.04.00.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 00:04:15 -0700 (PDT)
Message-ID: <6d58c08e-1537-f1ab-2883-baf869650ef2@linaro.org>
Date:   Tue, 4 Oct 2022 09:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC v1 1/1] arm: dts: omap4: pcm959: add initial support for
 phytec pcm959
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
References: <20221004024012.1386218-1-colin.foster@in-advantage.com>
 <20221004024012.1386218-2-colin.foster@in-advantage.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004024012.1386218-2-colin.foster@in-advantage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 04:40, Colin Foster wrote:
> The Phytec PCM-959 is a development platform for the Phytec PCM-049 SOM.
> Add initial functionality for the board. The verified interfaces and
> peripherals are listed below for the SOM (PCM-049) and the dev board
> (PCM-959)
> 
> The omap2plus_defconfig was used for testing. Only the On-board LEDs
> required CONFIG_LEDS_PCA9532 addition.
> 
> PCM-049:
> i2c1
>   * EEPROM at 0x50
>   * TMP102 (hwmon) at 0x4b
> twl6030
> GPMC
>   * Ethernet
>   * Flash
> Serial (ttyS2 console)
> 
> PCM959:
> MMC1
> On-board LEDs (with CONFIG_LEDS_PCA9532)
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi | 352 ++++++++++++++++++++
>  arch/arm/boot/dts/omap4-phytec-pcm-959.dts  | 130 ++++++++
>  3 files changed, 483 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
>  create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 27eec8e670ec..ef225150c5d7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -949,6 +949,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
>  	omap4-panda.dtb \
>  	omap4-panda-a4.dtb \
>  	omap4-panda-es.dtb \
> +	omap4-phytec-pcm-959.dtb \
>  	omap4-sdp.dtb \
>  	omap4-sdp-es23plus.dtb \
>  	omap4-var-dvk-om44.dtb \
> diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
> new file mode 100644
> index 000000000000..05b5cd581f15
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Innovative Advantage, Inc.
> + */
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>; /* 1 GB */
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		dsp_memory_region: dsp-memory@98000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x98000000 0x800000>;
> +			reusable;
> +			status = "okay";
> +		};
> +
> +		ipu_memory_region: ipu-memory@98800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x98800000 0x7000000>;
> +			reusable;
> +			status = "okay";
> +		};
> +	};
> +
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +
> +	leds: leds {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		status = "okay";

By default it is okay. If you override, override by label.

> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&led_gpio_pins
> +		>;
> +
> +		heartbeat {

led-heartbeat or led-0

> +			label = "modul:red:status1";
> +			gpios = <&gpio5 0x18 GPIO_ACTIVE_HIGH>; /* GPIO 152 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		mmc {

ditto

> +			label = "modul:green:status2";
> +			gpios = <&gpio5 0x19 GPIO_ACTIVE_HIGH>; /* GPIO 153 */
> +			linux,default-trigger = "mmc0";
> +		};
> +	};
> +};
> +
> +&omap4_pmx_core {
> +	i2c1_pins: pinmux_i2c1_pins {

No underscores in node names. Use hyphen/dash


> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
> +			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
> +		>;
> +	};
> +
> +	i2c3_pins: pinmux_i2c3_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
> +			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
> +		>;
> +	};
> +
> +	i2c4_pins: pinmux_i2c4_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
> +			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
> +		>;
> +	};
> +
> +	uart1_pins: pinmux_uart1_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x126, PIN_INPUT_PULLUP | MUX_MODE1)	/* uart1_rx */
> +			OMAP4_IOPAD(0x128, PIN_INPUT_PULLUP | MUX_MODE1)	/* uart1_tx */
> +		>;
> +	};
> +
> +	led_gpio_pins: pinmux_leds_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x156, PIN_OUTPUT | MUX_MODE3)	/* gpio_152 */
> +			OMAP4_IOPAD(0x158, PIN_OUTPUT | MUX_MODE3)	/* gpio_153 */
> +		>;
> +	};
> +
> +	pinctrl_tempsense: pinmux_pinctrl_tempsense_pins{
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x154, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpio_151 */
> +		>;
> +	};
> +
> +	gpmc_pins: gpmc_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x40, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0 */
> +			OMAP4_IOPAD(0x42, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1 */
> +			OMAP4_IOPAD(0x44, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2 */
> +			OMAP4_IOPAD(0x46, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3 */
> +			OMAP4_IOPAD(0x48, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4 */
> +			OMAP4_IOPAD(0x4a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5 */
> +			OMAP4_IOPAD(0x4c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6 */
> +			OMAP4_IOPAD(0x4e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7 */
> +			OMAP4_IOPAD(0x50, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad8 */
> +			OMAP4_IOPAD(0x52, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad9 */
> +			OMAP4_IOPAD(0x54, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad10 */
> +			OMAP4_IOPAD(0x56, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad11 */
> +			OMAP4_IOPAD(0x58, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad12 */
> +			OMAP4_IOPAD(0x5a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad13 */
> +			OMAP4_IOPAD(0x5c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad14 */
> +			OMAP4_IOPAD(0x5e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad15 */
> +
> +			OMAP4_IOPAD(0x60, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a16 */
> +			OMAP4_IOPAD(0x62, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a17 */
> +			OMAP4_IOPAD(0x64, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a18 */
> +			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a19 */
> +			OMAP4_IOPAD(0x68, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a20 */
> +			OMAP4_IOPAD(0x6a, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a21 */
> +			OMAP4_IOPAD(0x6c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a22 */
> +			OMAP4_IOPAD(0x6e, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a23 */
> +
> +			OMAP4_IOPAD(0x82, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_noe */
> +			OMAP4_IOPAD(0x84, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nwe */
> +
> +			OMAP4_IOPAD(0x7c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nwp */
> +			OMAP4_IOPAD(0x80, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nadv_ale */
> +			OMAP4_IOPAD(0x86, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nbe0_cle */
> +			OMAP4_IOPAD(0x8a, PIN_INPUT_PULLUP | MUX_MODE0)		/* gpmc_wait0 */
> +			OMAP4_IOPAD(0x8c, PIN_INPUT_PULLUP | MUX_MODE0)		/* gpmc_wait1 */
> +
> +			OMAP4_IOPAD(0x74, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ncs0 */
> +			OMAP4_IOPAD(0x76, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ncs1 */
> +			OMAP4_IOPAD(0x92, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ncs5 */
> +		>;
> +	};
> +
> +	ethernet_pins: ethernet_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x114, PIN_INPUT | MUX_MODE3)		/* gpio_121 */
> +		>;
> +	};
> +
> +	tps62361_pins: pinmux_tps62361_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x19c, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_182 */
> +		>;
> +	};
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x0e2, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
> +			OMAP4_IOPAD(0x0e4, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
> +			OMAP4_IOPAD(0x0e6, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0 */
> +			OMAP4_IOPAD(0x0e8, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
> +			OMAP4_IOPAD(0x0ea, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
> +			OMAP4_IOPAD(0x0ec, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
> +		>;
> +	};
> +
> +};
> +
> +&omap4_pmx_wkup {
> +	ethernet_wkgpio_pins: pinmux_ethernet_wkpins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE3)
> +		>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	clock-frequency = <400000>;
> +
> +	twl: twl@48 {

Please put compatible first in list of properties (and follow same order
in "required"). It's the most important piece, so we want it to be the
first to see. It also follows the convention of DTS, where compatible is
expected to be first.

> +		reg = <0x48>;
> +		status = "okay";

No need

> +		/* IRQ# = 7 */
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
> +	};
> +
> +	core_vdd_reg: tps62361@60 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tps62361";
> +		reg = <0x60>;
> +		status = "okay";

No need


> +
> +		regulator-name = "tps62361-vout";
> +		regulator-min-microvolt = <500000>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-coupled-max-spread = <300000>;
> +		regulator-max-step-microvolt = <100000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		ti,vsel0-gpio = <&gpio5 22 GPIO_ACTIVE_HIGH>;
> +		ti,vsel0-state-high;
> +	};
> +
> +	temperature-sensor@4b {
> +		compatible = "ti,tmp102";
> +		reg = <0x4b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tempsense>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +	};
> +};
> +
> +#include "twl6030.dtsi"
> +#include "twl6030_omap4.dtsi"
> +
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	status = "okay";
> +
> +	clock-frequency = <100000>;
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	status = "disabled";
> +
> +	clock-frequency = <400000>;
> +};
> +
> +&vmmc {
> +	ti,retain-on-reset;
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +
> +	vmmc-supply = <&vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	status = "disabled";
> +};
> +
> +&mmc3 {
> +	status = "disabled";
> +};
> +
> +&mmc4 {
> +	status = "disabled";
> +};
> +
> +&mmc5 {
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "disabled";
> +};
> +
> +&elm {
> +	status = "okay";
> +};
> +
> +#include "omap-gpmc-smsc9221.dtsi"
> +
> +&gpmc {
> +	ranges = <5 0 0x2c000000 0x01000000>,
> +		 <0 0 0x08000000 0x01000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		&gpmc_pins
> +		>;
> +	status = "okay";
> +
> +	nandflash: nand@0,0 {
> +		compatible = "ti,omap2-nand";
> +		reg = <0 0 4>;
> +		interrupt-parent = <&gpmc>;
> +		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>;
> +		nand-bus-width = <16>;
> +		ti,nand-ecc-opt = "bch8";
> +		ti,elm-id=<&elm>;
> +		linux,mtd-name = "micron,nand";
> +		gpmc,device-nand = "true";
> +		gpmc,device-width = <1>;
> +
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <44>;
> +		gpmc,cs-wr-off-ns = <44>;
> +		gpmc,adv-rd-off-ns = <34>;
> +		gpmc,adv-wr-off-ns = <44>;
> +		gpmc,we-off-ns = <40>;
> +		gpmc,oe-off-ns = <54>;
> +		gpmc,access-ns = <64>;
> +		gpmc,rd-cycle-ns = <82>;
> +		gpmc,wr-cycle-ns = <82>;
> +		gpmc,wr-access-ns = <40>;
> +		gpmc,wr-data-mux-bus-ns = <0>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +
> +	ethernet@gpmc {
> +		reg = <5 0 0xff>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&ethernet_pins
> +			&ethernet_wkgpio_pins
> +		>;
> +
> +		/* Either GPIO 103 or GPIO 121. Use 121 to match the reference design */
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";

Is it a new node or override?

> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-959.dts b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> new file mode 100644
> index 000000000000..dca2b1dd4d51
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Innovative Advantage, Inc.
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/leds-pca9532.h>
> +#include "omap4460.dtsi"
> +#include "omap4-phytec-pcm-049.dtsi"
> +
> +/ {
> +	model = "Phytec PCM-959 Eval Board";
> +	compatible = "ti,omap4460", "ti,omap4430", "ti,omap4";

RFC or not, you need to:
1. Use dedicated board compatible.
2. Document the compatible in bindings.

> +};
> +
> +&omap4_pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		&sr_wkup_pins
> +		&fref_xtal_in_pins
> +		&fref_clk3_out_pins
> +		&gpio_wk7_pins
> +		&fref_clk4_out_pins
> +		&sys_pins
> +		&tps62361_pins
> +	>;
> +
> +	status = "okay";
> +
> +	uart3_pins: pinmux_uart3_pins {

No underscores in node names.

> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x140, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts */
> +			OMAP4_IOPAD(0x142, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts */
> +			OMAP4_IOPAD(0x11c, PIN_INPUT | MUX_MODE0)		/* uart3_rx */
> +			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
> +		>;
> +	};
> +
> +	uart2_pins: pinmux_uart2_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts */
> +			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
> +			OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_rx */
> +			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
> +		>;
> +	};
> +};
> +
> +&gpio1_target {
> +	 ti,no-reset-on-init;
> +};
> +
> +&omap4_pmx_wkup {
> +	sr_wkup_pins: pinmux_sr_wkup_pins {

Eh...

> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x4a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_scl */
> +			OMAP4_IOPAD(0x4c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_sda */
> +		>;
> +	};
> +
> +	fref_xtal_in_pins: pinmux_fref_xtal_in_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x4e, PIN_OUTPUT | MUX_MODE0)		/* fref_xtal_in */
> +		>;
> +	};
> +
> +	fref_clk3_out_pins: pinmux_fref_clk3_out_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x58, PIN_OUTPUT | MUX_MODE0)		/* fref_clk3_out */
> +		>;
> +	};
> +
> +	gpio_wk7_pins: pinmux_gpio_wk7_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x5a, PIN_INPUT | MUX_MODE3)		/* fref_clk4_req */
> +		>;
> +	};
> +
> +	fref_clk4_out_pins: pinmux_fref_clk4_out_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x5c, PIN_OUTPUT | MUX_MODE0)		/* fref_clk4_out */
> +		>;
> +	};
> +
> +	sys_pins: pinmux_sys_pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x5e, PIN_INPUT | MUX_MODE0)		/* sys_32k */
> +			OMAP4_IOPAD(0x60, PIN_OUTPUT | MUX_MODE0)		/* sys_nrespwron */
> +			OMAP4_IOPAD(0x62, PIN_OUTPUT | MUX_MODE0)		/* sys_nreswarm */
> +			OMAP4_IOPAD(0x64, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sys_pwr_req */
> +			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE0)		/* sys_pwron_reset_out */
> +			OMAP4_IOPAD(0x68, PIN_OUTPUT | MUX_MODE0)		/* sys_boot6 */
> +			OMAP4_IOPAD(0x6a, PIN_OUTPUT | MUX_MODE0)		/* sys_boot7 */
> +		>;
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	leddim: leddimmer@62 {

Just 'led@62'

> +		compatible = "nxp,pca9533";
> +		reg = <0x62>;
> +
> +		led1 {

led-1

> +			label = "board:red:free_use1";
> +			linux,default-trigger = "none";
> +			type = <PCA9532_TYPE_LED>;
> +		};
> +
> +		led2 {

led-2

> +			label = "board:yellow:free_use2";
> +			linux,default-trigger = "none";
> +			type = <PCA9532_TYPE_LED>;


Best regards,
Krzysztof

