Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144E4637839
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKXL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKXL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:57:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C827FCF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:57:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a15so1738555ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPmDZK4XmnAOyxkMxe20Ybvmmjh3LoW3ETcvzboBHAU=;
        b=i5SSIpvAf/Ejbtaj6w2g0uRZ1sYzLR2tKI4VuD5gebcozOR63sD/+MzOhXRACplESB
         LHwegGYPl8iBopiP93nlp5lHcQMTENa/voWA5xLlfSZP5AmiNS/eNbGc4EzfO+atjyGr
         wP57XcXhkEfrEkWUUEf+QNFJun17+XlV+7X/5gpbtTnLn8noMdaVuwLZDUeKTNg++cQo
         jxOO+XSra4VZKbSXP+iur4Ulw7dd9tP1rFoIDCzFUpIMOPwA2UlygQIVGuqP61SEVMEe
         iP+TKP6eMnpQgF+FF9s6VT4SrJ7WL4JeO4ssxYaYcjq0FfPp7odFaUcQQ2s7r7EZTQQg
         HShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPmDZK4XmnAOyxkMxe20Ybvmmjh3LoW3ETcvzboBHAU=;
        b=KQCylc2d9GepY9YNSbXIRE94YoG9yaOWaI1W37Xd79C6qFduioOSWfwMuYQM8BBz/K
         84oQfESV3lZM1Hc8KCPJ2cx33G0Y/gmJ1ACH27JugQoQncLw1ynU+9+n80b8ZwRpvwAU
         DOFA0560ax2EbuH+UoiBkvDodQtaNSICcamnLVaPVKqTU+ji3eyB7epHt1+YfW1imx3Y
         LpbFzyjF94uHCTFbo/+F4Ga4sbZ2+wzvwTeIjSVGZQgvOv96E9jCtffxdgczBILWjtHv
         6e/ZzG8Fxhn9WhiRs5oiMkyzQqwTgaTZSZckjx+nDYnLmxX7kjEXIZKzvub7vOHRs5TK
         oFjg==
X-Gm-Message-State: ANoB5pnj6R7PhyqAqxJgSSMk/5C//aaljSlA8Gt4mgLMX6oNseiJWJsu
        d7X3TuMo5ynGaY7GavVW3gHdZw==
X-Google-Smtp-Source: AA0mqf4tOZy1XI6gIeGCQKO0IE9RPc/SMBSueH4Z9MiM8wsB9AjA+IiTBUojMenLOoCXCuQmT5PXhA==
X-Received: by 2002:a2e:9941:0:b0:26d:fe34:6dc0 with SMTP id r1-20020a2e9941000000b0026dfe346dc0mr5110775ljj.477.1669291069405;
        Thu, 24 Nov 2022 03:57:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o30-20020a198c1e000000b004a26b9cea32sm97055lfd.271.2022.11.24.03.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:57:49 -0800 (PST)
Message-ID: <9cbc6894-4d08-5edd-3b29-e15611700dfe@linaro.org>
Date:   Thu, 24 Nov 2022 12:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] arm: dts: omap4: pcm959: add initial support for
 phytec pcm959
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221123233209.1854806-1-colin.foster@in-advantage.com>
 <20221123233209.1854806-3-colin.foster@in-advantage.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123233209.1854806-3-colin.foster@in-advantage.com>
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

On 24/11/2022 00:32, Colin Foster wrote:
> The Phytec PCM-959 is a development platform for the Phytec PCM-049 SOM.
> Add initial functionality for the board. The verified interfaces and
> peripherals are listed below for the SOM (PCM-049) and the dev board
> (PCM-959)
> 
> The omap2plus_defconfig was used for testing. Only the On-board LEDs
> required CONFIG_LEDS_PCA9532 addition.
> 

Thank you for your patch. There is something to discuss/improve.

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

Okay is by default, why adding it? Was it disabled in DTSI file?

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
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&led_gpio_pins
> +		>;

That's unusual syntax.

pinctrl-0 = <&led_gpio_pins>;


> +
> +		led-0 {
> +			label = "modul:red:status1";

You should rather use function and color. label is slowly getting
deprecated.

> +			gpios = <&gpio5 0x18 GPIO_ACTIVE_HIGH>; /* GPIO 152 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			label = "modul:green:status2";
> +			gpios = <&gpio5 0x19 GPIO_ACTIVE_HIGH>; /* GPIO 153 */
> +			linux,default-trigger = "mmc0";
> +		};
> +	};
> +};
> +
> +&gpio1_target {
> +	ti,no-reset-on-init;
> +};
> +
> +&omap4_pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		&tps62361_pins

Ditto.

> +	>;
> +
> +	i2c1_pins: pinmux-i2c1-pins {
> +		pinctrl-single,pins = <

These can stay like this. But it's exception.

> +			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
> +			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
> +		>;
> +	};
> +
> +	i2c3_pins: pinmux-i2c3-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
> +			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
> +		>;
> +	};
> +
> +	i2c4_pins: pinmux-i2c4-pins {
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
> +	uart2_pins: pinmux-uart2-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts */
> +			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
> +			OMAP4_IOPAD(0x11c, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
> +			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
> +		>;
> +	};
> +
> +	uart3_pins: pinmux-uart3-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x140, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts */
> +			OMAP4_IOPAD(0x142, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts */
> +			OMAP4_IOPAD(0x144, PIN_INPUT | MUX_MODE0)		/* uart3_rx */
> +			OMAP4_IOPAD(0x146, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
> +		>;
> +	};
> +
> +	led_gpio_pins: pinmux-leds-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x156, PIN_OUTPUT | MUX_MODE3)	/* gpio_152 */
> +			OMAP4_IOPAD(0x158, PIN_OUTPUT | MUX_MODE3)	/* gpio_153 */
> +		>;
> +	};
> +
> +	pinctrl_tempsense: pinmux-pinctrl-tempsense-pins{
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x154, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpio_151 */
> +		>;
> +	};
> +
> +	gpmc_pins: gpmc-pins {
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
> +	ethernet_pins: ethernet-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x114, PIN_INPUT | MUX_MODE3)		/* gpio_121 */
> +		>;
> +	};
> +
> +	tps62361_pins: pinmux-tps62361-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x19c, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_182 */
> +		>;
> +	};
> +
> +	mmc1_pins: pinmux-mmc1-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x0e2, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
> +			OMAP4_IOPAD(0x0e4, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
> +			OMAP4_IOPAD(0x0e6, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0 */
> +			OMAP4_IOPAD(0x0e8, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
> +			OMAP4_IOPAD(0x0ea, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
> +			OMAP4_IOPAD(0x0ec, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
> +		>;
> +	};
> +};
> +
> +&omap4_pmx_wkup {
> +	pinctrl-names = "default";
> +	pinctrl-0= <
> +		&smartreflex_i2c_pins
> +		&fref_xtal_in_pins
> +		&fref_clk3_out_pins
> +		&sys_pins

Squash the lines.

> +	>;
> +
> +	ethernet_wkgpio_pins: pinmux-ethernet-wkup-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE3)		/* gpio_wk29 */
> +		>;
> +	};
> +
> +	smartreflex_i2c_pins: pinmux-smartreflex-i2c-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x4a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_scl */
> +			OMAP4_IOPAD(0x4c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_sda */
> +		>;
> +	};
> +
> +	fref_xtal_in_pins: pinmux-fref-xtal-in-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x4e, PIN_OUTPUT | MUX_MODE0)		/* fref_xtal_in */
> +		>;
> +	};
> +
> +	fref_clk3_out_pins: pinmux-usb-refclk-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x58, PIN_OUTPUT | MUX_MODE0)		/* fref_clk3_out */
> +		>;
> +	};
> +
> +	sys_pins: pinmux-sys-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x5e, PIN_INPUT | MUX_MODE0)		/* sys_32k */
> +			OMAP4_IOPAD(0x60, PIN_OUTPUT | MUX_MODE0)		/* sys_nrespwron */
> +			OMAP4_IOPAD(0x62, PIN_OUTPUT | MUX_MODE0)		/* sys_nreswarm */
> +			OMAP4_IOPAD(0x64, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sys_pwr_req */
> +			OMAP4_IOPAD(0x68, PIN_INPUT | MUX_MODE0)		/* sys_boot6 */
> +			OMAP4_IOPAD(0x6a, PIN_INPUT | MUX_MODE0)		/* sys_boot7 */
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

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,twl6030";
> +		reg = <0x48>;
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
> +	};
> +
> +	core_vdd_reg: regulator@60 {
> +		compatible = "ti,tps62361";
> +		reg = <0x60>;
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

Includes are usually at beginning. Is it a convention for all OMAP DTSes
to add it in the middle?

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

Merge/squash lines.

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
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-959.dts b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> new file mode 100644
> index 000000000000..f323d64660d7
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
> @@ -0,0 +1,48 @@
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
> +	compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4430", "ti,omap4";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	leddim: led@62 {
> +		compatible = "nxp,pca9533";
> +		reg = <0x62>;
> +
> +		led-1 {
> +			label = "board:red:free_use1";
> +			linux,default-trigger = "none";
> +			type = <PCA9532_TYPE_LED>;
> +		};
> +
> +		led-2 {
> +			label = "board:yellow:free_use2";
> +			linux,default-trigger = "none";
> +			type = <PCA9532_TYPE_LED>;
> +		};
> +
> +		led-3 {
> +			label = "board:yellow:free_use3";
> +			linux,default-trigger = "none";
> +			type = <PCA9532_TYPE_LED>;
> +		};
> +
> +		led-4 {
> +			label = "board:green:free_use4";
> +			linux,default-trigger = "none";
> +			type = <PCA9532_TYPE_LED>;
> +		};
> +	};
> +};
> +

Drop trailing new line.


Best regards,
Krzysztof

