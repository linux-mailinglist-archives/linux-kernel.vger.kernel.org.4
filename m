Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DFC7195A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjFAIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFAIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:30:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E119D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:30:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-974265a1a40so404365566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685608231; x=1688200231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IknQKmTR7kqbGZ9D3bOkaxDoaW3BD+kHO8lIYcEdVgA=;
        b=Bw7dQKesdU9IzhF+A25KkL/Li5b0Y0l9uOCVheeRoRPvFoDjdbvNzDzqF53gOzgKa/
         oHXVAcrwylf6HMRwfrnvDCexiQKhoOdoypCSswBnFkxu9akllwCkzyOc2rSDsw4vstdy
         P13iwK8ZElHLmDcNOOOu6T0/YLEItuaS65YNsTtiZj+JH6y7FI954krcXKZaZoSDfwkk
         M9rLlVPm/BmNLLkCVlNZTtvIoWHZ2AIDek5omg6lhrKTWccTCZvCgjHkO33HmwL0OUlv
         zyjvWkHOrGQe5Rl2OxWxZiEKSZYL2kRpHX1RTa7kiZ3Ti8uwcW7g7ImHi0dmJ6NHJt1C
         ASqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608231; x=1688200231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IknQKmTR7kqbGZ9D3bOkaxDoaW3BD+kHO8lIYcEdVgA=;
        b=WUmfEFQIjsAK9n0UkmSjbLFiPfTME/JGC/mKFtlc1JI+gimcXY83ltOgRnVdvprD3/
         YYKCDSzB9/fZa4SrkYL0oqSLiD2xYlYt/3P2JS7z9kg9/DFyuvp5TxluA6UlRqU6SXI4
         mHKX0Tc/Ubs9odKyKyP5p9roQ2SwcgxUeGU+6BF8cSyZljZRb7DC1Zq/k5RltyYCNb1T
         FIMoLOonu8OQQPHxqclyXDZjV/PxmHCvwoyCieSl5AcQ+xJUyuuIO9iA9KlxYERUpgx7
         Zne4kDwItV6ornsTCNa4kpJ1uA77Xgfbl+I64cMZ/tqwhg7EdRZV2WMRf7v2DYSAuvaJ
         hyOA==
X-Gm-Message-State: AC+VfDzhFSSUb3H2kx7gN4uWOcOPRBkrcC0dtZOdebGbRA22XNMTAoha
        P9IMIwgAXbrh/LqggHLGs3K7nA==
X-Google-Smtp-Source: ACHHUZ7IWIvMmVz9GiXdRuIpuol3f7CPSNeBBNiigma3VcpFBi7lOJHB9bLcJJPltXuRycTxzmmZ+A==
X-Received: by 2002:a17:907:2d8c:b0:96f:a412:8b03 with SMTP id gt12-20020a1709072d8c00b0096fa4128b03mr1106967ejc.5.1685608230719;
        Thu, 01 Jun 2023 01:30:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906154700b00965ec1faf27sm10073801ejd.74.2023.06.01.01.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:30:30 -0700 (PDT)
Message-ID: <869e07c3-74ca-840d-136d-20948ea4ef49@linaro.org>
Date:   Thu, 1 Jun 2023 10:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 35/43] ARM: dts: add device tree for ep93xx Soc
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-17-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601054549.10843-17-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:45, Nikita Shubin wrote:
> This adds a divice for Cirrus ep93xx SoC amd ts7250 board that has been

device

> my testing target for ep93xx device support.
> 
> Also inluded device tree for Liebherr BK3.1 board through it's not a

included

> complete support.

Thank you for your patch. There is something to discuss/improve.


> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - add empty chosen node
>     - s/dallas,rtc-m48t86/st,m48t86/
>     - changed phy_id to phy-handle
>     - dropped gpio chip-label's
>     - s/eth@80010000/ethernet@80010000
>     - s/use_dma/ep9301,use-dma
>     - added i2s to bk3
> 
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/ep93xx-bk3.dts    | 119 +++++++
>  arch/arm/boot/dts/ep93xx-ts7250.dts | 132 ++++++++
>  arch/arm/boot/dts/ep93xx.dtsi       | 466 ++++++++++++++++++++++++++++

Split adding DTSI from adding boards.

>  4 files changed, 718 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ep93xx-bk3.dts
>  create mode 100644 arch/arm/boot/dts/ep93xx-ts7250.dts
>  create mode 100644 arch/arm/boot/dts/ep93xx.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..a68f868fffe7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1670,3 +1670,4 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-vegman-n110.dtb \
>  	aspeed-bmc-vegman-rx20.dtb \
>  	aspeed-bmc-vegman-sx20.dtb
> +dtb-$(CONFIG_ARCH_EP93XX) += ep93xx-ts7250.dtb
> diff --git a/arch/arm/boot/dts/ep93xx-bk3.dts b/arch/arm/boot/dts/ep93xx-bk3.dts
> new file mode 100644
> index 000000000000..215587c498e6
> --- /dev/null
> +++ b/arch/arm/boot/dts/ep93xx-bk3.dts
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for Liebherr controller BK3.1 based on Cirrus EP9302 SoC
> + */
> +/dts-v1/;
> +#include "ep93xx.dtsi"
> +
> +/ {
> +	model = "Liebherr controller BK3.1";
> +	compatible = "liebherr,bk3", "cirrus,ep9301";
> +
> +	chosen {
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +	};
> +
> +	soc {
> +		nand-controller@60000000 {

Override/extend by label/phandle.

> +			compatible = "technologic,ts7200-nand";
> +			reg = <0x60000000 0x8000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0 {
> +					label = "System";
> +					reg = <0x00000000 0x01e00000>;
> +					read-only;
> +				};
> +
> +				partition@1e00000 {
> +					label = "Data";
> +					reg = <0x01e00000 0x05f20000>;
> +				};
> +
> +				partition@7d20000 {
> +					label = "RedBoot";
> +					reg = <0x07d20000 0x002e0000>;
> +					read-only;
> +				};
> +			};
> +		};
> +
> +		syscon: syscon@80930000 {

Override/extend by label/phandle.

> +			pinctrl: pinctrl {
> +				compatible = "cirrus,ep9301-pinctrl";

Why this is board specific?

> +			};
> +		};
> +
> +		gpio1: gpio@80840004 {

Override/extend by label/phandle.

> +			/* PWM */
> +			gpio-ranges = <&pinctrl 6 163 1>;
> +		};
> +	};
> +};
> +
> +&gpio1 {
> +	/* PWM */
> +	gpio-ranges = <&pinctrl 6 163 1>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 97 2>;
> +	status = "okay";
> +};
> +
> +&gpio6 {
> +	gpio-ranges = <&pinctrl 0 87 2>;
> +	status = "okay";
> +};
> +
> +&gpio7 {
> +	gpio-ranges = <&pinctrl 2 199 4>;
> +	status = "okay";
> +};
> +
> +&i2c {
> +	status = "okay";
> +};
> +
> +&spi0: spi@808a0000 {
> +	cs-gpios = <&gpio5 3 0>;

Use proper defines for flags.

> +	status = "okay";

What's here? Empty enabled bus?


> +};
> +
> +&eth0 {
> +	phy-handle = <&phy0>;
> +};
> +
> +&mdio0 {
> +	phy0: ethernet-phy@1 {
> +		reg = <1>;
> +		device_type = "ethernet-phy";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&i2s {

Up to you, but I seriously recommend keeping all labels ordered by name.
Avoids conflicts.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s_on_ac97_pins>;
> +	/delete-property/ status;

??? I don't understand. Why would you do this?

...

> diff --git a/arch/arm/boot/dts/ep93xx.dtsi b/arch/arm/boot/dts/ep93xx.dtsi
> new file mode 100644
> index 000000000000..6da556ceaf04
> --- /dev/null
> +++ b/arch/arm/boot/dts/ep93xx.dtsi
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for Cirrus Logic systems EP93XX SoC
> + */
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +/ {
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		compatible = "simple-bus";
> +
> +		syscon: syscon@80930000 {
> +			compatible = "cirrus,ep9301-syscon",
> +						"syscon", "simple-mfd";

Broken wrapping. Align these with previous ".

> +			reg = <0x80930000 0x1000>;
> +
> +			ep9301-reboot {

Just "reboot" (and fix bindings)... but why would you need it in the
first place? I think something is seriously missing in your bindings.

> +				compatible = "cirrus,ep9301-reboot";
> +			};
> +
> +			eclk: clock-controller {
> +				#clock-cells = <1>;
> +				compatible = "cirrus,ep9301-clk";
> +				status = "okay";
> +				clocks = <&xtali>;
> +			};
> +
> +			pinctrl: pinctrl {

Missing compatible.

> +				spi_default_pins: pins-spi {
> +					function = "spi";
> +					groups = "ssp";
> +				};
> +
> +				ac97_default_pins: pins-ac97 {
> +					function = "ac97";
> +					groups = "ac97";
> +				};
> +
> +				i2s_on_ssp_pins: pins-i2sonssp {
> +					function = "i2s";
> +					groups = "i2s_on_ssp";
> +				};
> +
> +				i2s_on_ac97_pins: pins-i2sonac97 {
> +					function = "i2s";
> +					groups = "i2s_on_ac97";
> +				};
> +
> +				gpio1_default_pins: pins-gpio1 {
> +					function = "gpio";
> +					groups = "gpio1agrp";
> +				};
> +
> +				pwm1_default_pins: pins-pwm1 {
> +					function = "pwm";
> +					groups = "pwm1";
> +				};
> +
> +				gpio2_default_pins: pins-gpio2 {
> +					function = "gpio";
> +					groups = "gpio2agrp";
> +				};
> +
> +				gpio3_default_pins: pins-gpio3 {
> +					function = "gpio";
> +					groups = "gpio3agrp";
> +				};
> +
> +				keypad_default_pins: pins-keypad {
> +					function = "keypad";
> +					groups = "keypadgrp";
> +				};
> +
> +				gpio4_default_pins: pins-gpio4 {
> +					function = "gpio";
> +					groups = "gpio4agrp";
> +				};
> +
> +				gpio6_default_pins: pins-gpio6 {
> +					function = "gpio";
> +					groups = "gpio6agrp";
> +				};
> +
> +				gpio7_default_pins: pins-gpio7 {
> +					function = "gpio";
> +					groups = "gpio7agrp";
> +				};
> +
> +				ide_default_pins: pins-ide {
> +					function = "pata";
> +					groups = "idegrp";
> +				};
> +
> +				lcd_on_dram0_pins: pins-rasteronsdram0 {
> +					function = "lcd";
> +					groups = "rasteronsdram0grp";
> +				};
> +
> +				lcd_on_dram3_pins: pins-rasteronsdram3 {
> +					function = "lcd";
> +					groups = "rasteronsdram3grp";

I would expect somewhere two groups since you explicitly allow it.

> +				};
> +			};
> +		};
> +
> +		vic0: interrupt-controller@800b0000 {
> +			compatible = "arm,pl192-vic";
> +			interrupt-controller;
> +			reg = <0x800b0000 0x1000>;

compatible first, reg is second. ranges if present - third. Fix it
everywhere.

> +			#interrupt-cells = <1>;
> +			valid-mask = <0x7ffffffc>;
> +			valid-wakeup-mask = <0x0>;
> +		};
> +
> +		vic1: interrupt-controller@800c0000 {
> +			compatible = "arm,pl192-vic";
> +			interrupt-controller;
> +			reg = <0x800c0000 0x1000>;
> +			#interrupt-cells = <1>;
> +			valid-mask = <0x1fffffff>;
> +			valid-wakeup-mask = <0x0>;
> +		};
> +
> +		timer: timer@80810000 {
> +			compatible = "cirrus,ep9301-timer";
> +			reg = <0x80810000 0x100>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <19>;
> +		};
> +
> +		dma0: dma-controller@80000000 {
> +			compatible = "cirrus,ep9301-dma-m2p";
> +			reg = <0x80000000 0x0040>,
> +				<0x80000040 0x0040>,
> +				<0x80000080 0x0040>,
> +				<0x800000c0 0x0040>,
> +				<0x80000240 0x0040>,
> +				<0x80000200 0x0040>,
> +				<0x800002c0 0x0040>,
> +				<0x80000280 0x0040>,
> +				<0x80000340 0x0040>,
> +				<0x80000300 0x0040>;
> +			clocks = <&eclk EP93XX_CLK_M2P0>,
> +				<&eclk EP93XX_CLK_M2P1>,
> +				<&eclk EP93XX_CLK_M2P2>,
> +				<&eclk EP93XX_CLK_M2P3>,
> +				<&eclk EP93XX_CLK_M2P4>,
> +				<&eclk EP93XX_CLK_M2P5>,
> +				<&eclk EP93XX_CLK_M2P6>,
> +				<&eclk EP93XX_CLK_M2P7>,
> +				<&eclk EP93XX_CLK_M2P8>,
> +				<&eclk EP93XX_CLK_M2P9>;
> +			clock-names = "m2p0", "m2p1",
> +				"m2p2", "m2p3",
> +				"m2p4", "m2p5",
> +				"m2p6", "m2p7",
> +				"m2p8", "m2p9";
> +			interrupt-parent = <&vic0>;
> +			interrupts = <7>, <8>, <9>, <10>, <11>,
> +				<12>, <13>, <14>, <15>, <16>;
> +			#dma-cells = <1>;
> +		};
> +
> +		dma1: dma-controller@80000100 {
> +			compatible = "cirrus,ep9301-dma-m2m";
> +			reg = <0x80000100 0x0040>,
> +				<0x80000140 0x0040>;
> +			clocks = <&eclk EP93XX_CLK_M2M0>,
> +				<&eclk EP93XX_CLK_M2M1>;
> +			clock-names = "m2m0", "m2m1";
> +			interrupt-parent = <&vic0>;
> +			interrupts = <17>, <18>;
> +			#dma-cells = <1>;
> +		};
> +
> +		i2s: i2s@80820000 {
> +			compatible = "cirrus,ep9301-i2s";
> +			#sound-dai-cells = <0>;
> +			reg = <0x80820000 0x100>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <28>;
> +			clocks = <&eclk EP93XX_CLK_I2S_MCLK
> +				  &eclk EP93XX_CLK_I2S_SCLK
> +				  &eclk EP93XX_CLK_I2S_LRCLK>;
> +			clock-names = "mclk", "sclk", "lrclk";
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio@80840000 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840000 0x04>,
> +			<0x80840010 0x04>,
> +			<0x80840090 0x1c>;

Messed wrapping.

> +			reg-names = "data", "dir", "intr";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <27>;
> +		};
> +
> +		gpio1: gpio@80840004 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840004 0x04>,
> +			<0x80840014 0x04>,
> +			<0x808400ac 0x1c>;

Ditto, in other places as well.

> +			reg-names = "data", "dir", "intr";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <27>;
> +		};
> +
> +		gpio2: gpio@80840008 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840008 0x04>,
> +			<0x80840018 0x04>;
> +			reg-names = "data", "dir";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			status = "disabled";

Status is usually last.

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio2_default_pins>;
> +		};
> +
> +		gpio3: gpio@8084000c {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x8084000c 0x04>,
> +			<0x8084001c 0x04>;
> +			reg-names = "data", "dir";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio3_default_pins>;
> +		};
> +
> +		gpio4: gpio@80840020 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840020 0x04>,
> +			<0x80840024 0x04>;
> +			reg-names = "data", "dir";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio4_default_pins>;
> +		};
> +
> +		gpio5: gpio@80840030 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840030 0x04>,
> +			<0x80840034 0x04>,
> +			<0x8084004c 0x1c>;
> +			reg-names = "data", "dir", "intr";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupts-extended = <&vic0 19>, <&vic0 20>,
> +				<&vic0 21>, <&vic0 22>,
> +				<&vic1 15>, <&vic1 16>,
> +				<&vic1 17>, <&vic1 18>;
> +		};
> +
> +		gpio6: gpio@80840038 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840038 0x04>,
> +			<0x8084003c 0x04>;
> +			reg-names = "data", "dir";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio6_default_pins>;
> +		};
> +
> +		gpio7: gpio@80840040 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840040 0x04>,
> +			<0x80840044 0x04>;
> +			reg-names = "data", "dir";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio7_default_pins>;
> +		};
> +
> +		ide: ide@800a0000 {
> +			compatible = "cirrus,ep9312-pata";
> +			reg = <0x800a0000 0x38>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <8>;
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ide_default_pins>;
> +		};
> +
> +		uart0: uart@808c0000 {

This should scream with dtbs_check. serial.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +			compatible = "arm,primecell";
> +			reg = <0x808c0000 0x1000>;
> +			arm,primecell-periphid = <0x00041010>;
> +			clocks = <&eclk EP93XX_CLK_UART1>, <&eclk EP93XX_CLK_UART>;
> +			clock-names = "apb:uart1", "apb_pclk";
> +			interrupt-parent = <&vic1>;
> +			interrupts = <20>;
> +			status = "disabled";
> +		};
> +
> +		uart1: uart@808d0000 {
> +			compatible = "arm,primecell";
> +			reg = <0x808d0000 0x1000>;
> +			arm,primecell-periphid = <0x00041010>;
> +			clocks = <&eclk EP93XX_CLK_UART2>, <&eclk EP93XX_CLK_UART>;
> +			clock-names = "apb:uart2", "apb_pclk";
> +			interrupt-parent = <&vic1>;
> +			interrupts = <22>;
> +			status = "disabled";
> +		};
> +
> +		uart2: uart@808b0000 {
> +			compatible = "arm,primecell";
> +			reg = <0x808b0000 0x1000>;
> +			arm,primecell-periphid = <0x00041010>;
> +			clocks = <&eclk EP93XX_CLK_UART3>, <&eclk EP93XX_CLK_UART>;
> +			clock-names = "apb:uart3", "apb_pclk";
> +			interrupt-parent = <&vic1>;
> +			interrupts = <23>;
> +			status = "disabled";
> +		};
> +
> +		usb0: usb@80020000 {
> +			compatible = "generic-ohci";
> +			reg = <0x80020000 0x10000>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <24>;
> +			clocks = <&eclk EP93XX_CLK_USB>;
> +			status = "disabled";
> +		};
> +
> +		eth0: ethernet@80010000 {
> +			compatible = "cirrus,ep9301-eth";
> +			reg = <0x80010000 0x10000>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <7>;
> +			mdio0: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Your SoC comes with mdio? If so, why is this empty?

> +			};
> +		};
> +
> +		rtc0: rtc@80920000 {
> +			compatible = "cirrus,ep9301-rtc";
> +			reg = <0x80920000 0x100>;
> +		};
> +
> +		spi0: spi@808a0000 {
> +			compatible = "cirrus,ep9301-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x808a0000 0x18>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <21>;
> +			clocks = <&eclk EP93XX_CLK_SPI>;
> +			cs-gpios = <&gpio5 2 0>;

defines... but why is it here in the first place? Rarely CS gpios are
part of the SoC. I have several of such questions further as well, so
this looks like you are mixing SoC and boards in one file.

> +			cirrus,ep9301-use-dma;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi_default_pins>;
> +			status = "disabled";
> +		};
> +
> +		adc: adc@80900000 {
> +			compatible = "cirrus,ep9301-adc";
> +			reg = <0x80900000 0x28>;
> +			clocks = <&eclk EP93XX_CLK_ADC>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <30>;
> +			status = "disabled";
> +		};
> +
> +		watchdog0: watchdog@80940000 {
> +			compatible = "cirrus,ep9301-wdt";
> +			reg = <0x80940000 0x08>;
> +		};
> +
> +		pwm0: pwm@80910000 {
> +			compatible = "cirrus,ep9301-pwm";
> +			reg = <0x80910000 0x10>;
> +			clocks = <&eclk EP93XX_CLK_PWM>;
> +			status = "disabled";
> +		};
> +
> +		pwm1: pwm@80910020 {
> +			compatible = "cirrus,ep9301-pwm";
> +			reg = <0x80910020 0x10>;
> +			clocks = <&eclk EP93XX_CLK_PWM>;
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1_default_pins>;
> +		};
> +
> +		keypad: keypad@800f0000 {
> +			compatible = "cirrus,ep9307-keypad";
> +			reg = <0x800f0000 0x0c>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <29>;
> +			clocks = <&eclk EP93XX_CLK_KEYPAD>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&keypad_default_pins>;
> +			linux,keymap =
> +						<KEY_UP>,
> +						<KEY_DOWN>,
> +						<KEY_VOLUMEDOWN>,
> +						<KEY_HOME>,
> +						<KEY_RIGHT>,
> +						<KEY_LEFT>,
> +						<KEY_ENTER>,
> +						<KEY_VOLUMEUP>,
> +						<KEY_F6>,
> +						<KEY_F8>,
> +						<KEY_F9>,
> +						<KEY_F10>,
> +						<KEY_F1>,
> +						<KEY_F2>,
> +						<KEY_F3>,
> +						<KEY_POWER>;
> +		};
> +	};
> +
> +	xtali: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <14745600>;
> +		clock-output-names = "xtali";
> +	};
> +
> +	i2c0: i2c0 {

i2c or i2c-0

> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpio6 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpio6 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";

Wait, what? Why this is disabled? If this is part of the SoC, although
hardly looks like, then it should be complete. What is missing? How one
could design SoC with incomplete GPIO I2C controller?

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";

I really doubt this is property of the SoC. Please double check as it
really looks wrong.


> +		led0 {

led-0

> +			label = "grled";
> +			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +
> +		led1 {
led-1

> +			label = "rdled";
> +			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +	};
> +};

Best regards,
Krzysztof

