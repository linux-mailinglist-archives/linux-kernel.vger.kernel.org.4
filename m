Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB557280ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjFHNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFHNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:13:42 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E82103;
        Thu,  8 Jun 2023 06:13:39 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358BItDr013526;
        Thu, 8 Jun 2023 15:13:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Ac7eQ8C+JKzlcCz+U/acnj1Q/qFHU3l6e/he0/JylMg=;
 b=hKMymlTVbmMtwwP+GJaBRAe9cdmsFsj9kjUH15HAmQxMyy+MVyyPh4bTuHNJgM00fPR1
 wYl750U+wMIu4x01tyfNWmCh1Vis5OvlKsu64JWgbh4B7BLa5xqFXPLlqdD7KIZ9wNEn
 NYLPla4wM3HwGWopBzmrRcqxthhyHzySyrtl5MdergUs4xkxFM/EQ2+31bLMVJ659bRh
 Q2UoccT2qUk+neKLZBiSnbGv9XD27pA++iyhziY3J1SjBx1g+peCxqHtILByMI5GEOvL
 eeTfAD/nSkjMpGa/P+lTlhbctZrawdHtAB1j16Vinb45QnAZQx9VCsu4Oyj6CjgZ6MoJ PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r3atmaa2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 15:13:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6135E10002A;
        Thu,  8 Jun 2023 15:13:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7029D22FA4F;
        Thu,  8 Jun 2023 15:13:15 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 8 Jun
 2023 15:13:14 +0200
Message-ID: <9e95c14b-2442-dea5-9b8e-e604abd5cdae@foss.st.com>
Date:   Thu, 8 Jun 2023 15:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 8/8] ARM: dts: stm32: lxa-tac: add Linux Automation
 GmbH TAC
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-8-l.goehrs@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230607115508.2964574-8-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_09,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard

On 6/7/23 13:55, Leonard Göhrs wrote:
> The Linux Automation Test Automation Controller (LXA TAC)[1] is an embedded
> software development tool built around the Octavo Systems OSD32MP15x SiP.
> 
> The device contains an eMMC for storage, a DSA-capable on board ethernet
> switch with two external ports, dual CAN busses, a power switch to turn
> a device under test on or off and some other I/O.
> 
> As of now there are two STM32MP157 based hardware generations (Gen 1 and
> Gen 2) that have most of their hardware config in common.
> In the future there will also be a STM32MP153 based hardware generation.
> 
> [1]: https://www.linux-automation.com/en/products/lxa-tac.html
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---

There are some YAML issues reported. Some are linked to the 
stm32mp151.dts or common bindings and are going to be fixed. But some 
looks more linked to your board. Can you have a look on those:


arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dtb: gpio@24: 
'gpio-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml

arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dtb: display@0: compatible:0: 
'shineworld,lh133k' is not one of ['sainsmart18']
	From schema: 
/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml

arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dtb: display@0: Unevaluated 
properties are not allowed ('compatible', 'spi-3wire' were unexpected)
	From schema: 
/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml

arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dtb: 
/soc/spi@44005000/display@0: failed to match any schema with compatible: 
['shineworld,lh133k', 'panel-mipi-dbi-spi']

/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dtb: switch@0: Unevaluated 
properties are not allowed ('spi-cpha', 'spi-cpol', 'interrupt-parent', 
'interrupts' were unexpected)
	From schema: /Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml

arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dtb: can@4400f000: 
'termination-gpios', 'termination-ohms' do not match any of the regexes: 
'pinctrl-[0-9]+'
	From schema: /Documentation/devicetree/bindings/net/can/bosch,m_can.yaml

Thanks in advance

Alex


>   arch/arm/boot/dts/Makefile                    |   2 +
>   .../arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts |  93 +++
>   .../arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts | 172 +++++
>   arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi    | 612 ++++++++++++++++++
>   4 files changed, 879 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc903152..886371436bbc1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1266,6 +1266,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32mp157c-ev1.dtb \
>   	stm32mp157c-ev1-scmi.dtb \
>   	stm32mp157c-lxa-mc1.dtb \
> +	stm32mp157c-lxa-tac-gen1.dtb \
> +	stm32mp157c-lxa-tac-gen2.dtb \
>   	stm32mp157c-odyssey.dtb
>   dtb-$(CONFIG_MACH_SUN4I) += \
>   	sun4i-a10-a1000.dtb \
> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts
> new file mode 100644
> index 0000000000000..81f254fb88b0a
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2020 STMicroelectronics - All Rights Reserved
> + * Copyright (C) 2021 Rouven Czerwinski, Pengutronix
> + * Copyright (C) 2023 Leonard Göhrs, Pengutronix
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc-lxa-tac.dtsi"
> +
> +/ {
> +	model = "Linux Automation Test Automation Controller (TAC) Gen 1";
> +	compatible = "lxa,stm32mp157c-tac-gen1", "oct,stm32mp15xx-osd32", "st,stm32mp157";
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		power-supply = <&v3v3>;
> +
> +		brightness-levels = <0 31 63 95 127 159 191 223 255>;
> +		default-brightness-level = <7>;
> +		pwms = <&backlight_pwm 1 1000000 0>;
> +	};
> +
> +	reg_iobus_12v: regulator-iobus-12v {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_12v>;
> +
> +		gpio = <&gpioh 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-name = "12V_IOBUS";
> +	};
> +};
> +
> +&gpioa {
> +	gpio-line-names = "", "", "STACK_CS2", "", "STACK_CS3", /*  0 */
> +	"ETH_GPIO1", "ETH_INT", "", "", "",                     /*  5 */
> +	"", "", "", "BOOTROM_LED", "ETH_LAB_LEDRP",             /* 10 */
> +	"";                                                     /* 15 */
> +};
> +
> +&gpioc {
> +	gpio-line-names = "", "STACK_CS1", "", "", "", /*  0 */
> +	"", "", "", "", "",                            /*  5 */
> +	"", "";                                        /* 10 */
> +};
> +
> +&gpu {
> +	status = "disabled";
> +};
> +
> +&i2c1 {
> +	powerboard_gpio: gpio@24 {
> +		compatible = "nxp,pca9570";
> +		reg = <0x24>;
> +
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		gpio-line-names = "DUT_PWR_EN", "DUT_PWR_DISCH", "DUT_PWR_ADCRST", "";
> +	};
> +};
> +
> +&spi2 {
> +	adc@0 {
> +		compatible = "ti,lmp92064";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		vdd-supply = <&reg_pb_3v3>;
> +		vdig-supply = <&reg_pb_3v3>;
> +		reset-gpios = <&powerboard_gpio 2 GPIO_ACTIVE_HIGH>;
> +
> +		shunt-resistor-micro-ohms = <15000>;
> +	};
> +};
> +
> +&timers1 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +
> +	backlight_pwm: pwm {
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pwm1_pins_c>;
> +		pinctrl-1 = <&pwm1_sleep_pins_c>;
> +
> +		status = "okay";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts b/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts
> new file mode 100644
> index 0000000000000..8a34d15e9005f
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2020 STMicroelectronics - All Rights Reserved
> + * Copyright (C) 2021 Rouven Czerwinski, Pengutronix
> + * Copyright (C) 2023 Leonard Göhrs, Pengutronix
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc-lxa-tac.dtsi"
> +
> +/ {
> +	model = "Linux Automation Test Automation Controller (TAC) Gen 2";
> +	compatible = "lxa,stm32mp157c-tac-gen2", "oct,stm32mp15xx-osd32", "st,stm32mp157";
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		power-supply = <&v3v3>;
> +
> +		brightness-levels = <0 31 63 95 127 159 191 223 255>;
> +		default-brightness-level = <7>;
> +		pwms = <&led_pwm 3 1000000 0>;
> +	};
> +
> +	reg_iobus_12v: regulator-iobus-12v {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_12v>;
> +		gpio = <&gpioh 13 GPIO_ACTIVE_LOW>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-name = "12V_IOBUS";
> +	};
> +
> +	led-controller-1 {
> +		compatible = "pwm-leds-multicolor";
> +
> +		multi-led {
> +			color = <LED_COLOR_ID_RGB>;
> +			function = LED_FUNCTION_STATUS;
> +			max-brightness = <65535>;
> +
> +			led-red {
> +				active-low;
> +				color = <LED_COLOR_ID_RED>;
> +				pwms = <&led_pwm 0 1000000 0>;
> +			};
> +
> +			led-green {
> +				active-low;
> +				color = <LED_COLOR_ID_GREEN>;
> +				pwms = <&led_pwm 2 1000000 0>;
> +			};
> +
> +			led-blue {
> +				active-low;
> +				color = <LED_COLOR_ID_BLUE>;
> +				pwms = <&led_pwm 1 1000000 0>;
> +			};
> +		};
> +	};
> +
> +	led-controller-2 {
> +		compatible = "gpio-leds";
> +
> +		led-5 {
> +			label = "tac:green:iobus";
> +			gpios = <&gpiog 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-6 {
> +			label = "tac:green:can";
> +			gpios = <&gpiof 3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-7 {
> +			label = "tac:green:out0";
> +			gpios = <&gpiob 8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-8 {
> +			label = "tac:green:out1";
> +			gpios = <&gpiog 3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-9 {
> +			label = "tac:green:uarttx";
> +			gpios = <&gpiod 3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-10 {
> +			label = "tac:green:uartrx";
> +			gpios = <&gpiof 6 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-11 {
> +			label = "tac:green:usbh1";
> +			gpios = <&gpioc 8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-12 {
> +			label = "tac:green:usbh2";
> +			gpios = <&gpiod 6 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-13 {
> +			label = "tac:green:usbh3";
> +			gpios = <&gpiob 9 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-14 {
> +			label = "tac:green:usbg";
> +			gpios = <&gpiod 14 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "usb-gadget";
> +		};
> +
> +		led-15 {
> +			label = "tac:green:dutpwr";
> +			gpios = <&gpioa 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&gpioa {
> +	gpio-line-names = "", "", "DUT_PWR_EN", "", "STACK_CS3", /*  0 */
> +	"ETH_GPIO1", "ETH_INT", "", "", "",                      /*  5 */
> +	"", "", "", "BOOTROM_LED", "ETH_LAB_LEDRP",              /* 10 */
> +	"";                                                      /* 15 */
> +};
> +
> +&gpioc {
> +	gpio-line-names = "", "DUT_PWR_DISCH", "", "", "", /*  0 */
> +	"", "", "", "", "",                                /*  5 */
> +	"", "";                                            /* 10 */
> +};
> +
> +&gpu {
> +	status = "disabled";
> +};
> +
> +&m_can2 {
> +	termination-gpios = <&gpioe 4 GPIO_ACTIVE_HIGH>;
> +	termination-ohms = <120>;
> +};
> +
> +&spi2 {
> +	adc@0 {
> +		compatible = "ti,lmp92064";
> +		reg = <0>;
> +
> +		reset-gpios = <&gpioa 4 GPIO_ACTIVE_HIGH>;
> +		shunt-resistor-micro-ohms = <15000>;
> +		spi-max-frequency = <5000000>;
> +		vdd-supply = <&reg_pb_3v3>;
> +		vdig-supply = <&reg_pb_3v3>;
> +	};
> +};
> +
> +&timers8 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +
> +	led_pwm: pwm {
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pwm8_pins_b>;
> +		pinctrl-1 = <&pwm8_sleep_pins_b>;
> +		status = "okay";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi
> new file mode 100644
> index 0000000000000..ca4d25f5c9b51
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi
> @@ -0,0 +1,612 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2020 STMicroelectronics - All Rights Reserved
> + * Copyright (C) 2021 Rouven Czerwinski, Pengutronix
> + * Copyright (C) 2023 Leonard Göhrs, Pengutronix
> + */
> +
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15xx-osd32.dtsi"
> +#include "stm32mp15xxac-pinctrl.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &ethernet0;
> +		ethernet1 = &port_uplink;
> +		ethernet2 = &port_dut;
> +		mmc1 = &sdmmc2;
> +		serial0 = &uart4;
> +		serial1 = &usart3;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart4;
> +	};
> +
> +	led-controller-0 {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			label = "tac:green:user1";
> +			gpios = <&gpiof 10 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			label = "tac:green:user2";
> +			gpios = <&gpiog 7 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label = "tac:green:statusdut";
> +			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		/* led-3 and led-4 are internally connected antiparallel to one
> +		 * another inside the ethernet jack like this:
> +		 * GPIOA14 ---+---|led-3|>--+--- GPIOD15
> +		 *            +--<|led-4|---+
> +		 * E.g. only one of the LEDs can be illuminated at a time while
> +		 * the other output must be driven low.
> +		 * This should likely be implemented using a multi color LED
> +		 * driver for antiparallel LEDs.
> +		 */
> +		led-3 {
> +			label = "tac:green:statuslab";
> +			gpios = <&gpioa 14 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-4 {
> +			label = "tac:orange:statuslab";
> +			gpios = <&gpiod 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		button-lower {
> +			label = "USER_BTN2";
> +			linux,code = <KEY_ESC>;
> +			gpios = <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +		};
> +
> +		button-upper {
> +			label = "USER_BTN";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpioi 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +		};
> +	};
> +
> +	/* supplied by either barrel connector or PoE */
> +	reg_12v: regulator-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_5v: regulator-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_12v>;
> +	};
> +
> +	reg_1v2: regulator-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1V2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_5v>;
> +	};
> +
> +	reg_pb_5v: regulator-pb-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5V_POWERBOARD";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_5v>;
> +	};
> +
> +	reg_pb_3v3: regulator-pb-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3V3_POWERBOARD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_pb_5v>;
> +	};
> +
> +	output-iobus-12v {
> +		compatible = "regulator-output";
> +		vout-supply = <&reg_iobus_12v>;
> +	};
> +
> +	output-vuart {
> +		compatible = "regulator-output";
> +		vout-supply = <&v3v3_hdmi>;
> +	};
> +};
> +
> +baseboard_eeprom: &sip_eeprom {
> +};
> +
> +&adc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&adc1_ain_pins_a>;
> +	vdd-supply = <&vdd>;
> +	vdda-supply = <&vdda>;
> +	vref-supply = <&vrefbuf>;
> +	status = "okay";
> +
> +	adc1: adc@0 {
> +		st,adc-channels = <0 1 2 5 9 10 13 15>;
> +		st,min-sample-time-nsecs = <5000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		channel@0 {
> +			reg = <0>;
> +			label = "HOST_2_CURR_FB";
> +		};
> +
> +		channel@1 {
> +			reg = <1>;
> +			label = "HOST_3_CURR_FB";
> +		};
> +
> +		channel@2 {
> +			reg = <2>;
> +			label = "OUT_0_FB";
> +		};
> +
> +		channel@5 {
> +			reg = <5>;
> +			label = "IOBUS_CURR_FB";
> +		};
> +
> +		channel@9 {
> +			reg = <9>;
> +			label = "IOBUS_VOLT_FB";
> +		};
> +
> +		channel@10 {
> +			reg = <10>;
> +			label = "OUT_1_FB";
> +		};
> +
> +		channel@13 {
> +			reg = <13>;
> +			label = "HOST_CURR_FB";
> +		};
> +
> +		channel@15 {
> +			reg = <15>;
> +			label = "HOST_1_CURR_FB";
> +		};
> +	};
> +
> +	adc2: adc@100 {
> +		st,adc-channels = <12>;
> +		st,min-sample-time-nsecs = <500000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		channel@12 {
> +			reg = <12>;
> +			label = "TEMP_INTERNAL";
> +		};
> +	};
> +};
> +
> +&crc1 {
> +	status = "okay";
> +};
> +
> +&cryp1 {
> +	status = "okay";
> +};
> +
> +&dts {
> +	status = "okay";
> +};
> +
> +&ethernet0 {
> +	assigned-clocks = <&rcc ETHCK_K>, <&rcc PLL4_P>;
> +	assigned-clock-parents = <&rcc PLL4_P>;
> +	assigned-clock-rates = <125000000>; /* Clock PLL4 to 750Mhz in ATF */
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&ethernet0_rgmii_pins_d>;
> +	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_d>;
> +
> +	st,eth-clk-sel;
> +	phy-mode = "rgmii-id";
> +
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};
> +
> +&ethernet0_rgmii_pins_d {
> +	pins1 {
> +		/* Reduce EMI emission by reducing RGMII drive strength */
> +		slew-rate = <1>;
> +	};
> +};
> +
> +&gpiob {
> +	gpio-line-names = "", "", "", "", "", /*  0 */
> +	"", "USB_RESET", "", "", "",          /*  5 */
> +	"", "", "", "", "",                   /* 10 */
> +	"";                                   /* 15 */
> +};
> +
> +&gpiod {
> +	gpio-line-names = "", "", "", "", "TP38", /*  0 */
> +	"TP39", "", "", "TP41", "TP42",           /*  5 */
> +	"OLED_DC", "", "", "ETH_CS", "",          /* 10 */
> +	"ETH_LAB_LEDRN";                          /* 15 */
> +};
> +
> +&gpioe {
> +	gpio-line-names = "TP35", "", "", "", "CAN_1_120R", /*  0 */
> +	"", "", "USER_BTN2", "TP48", "UART_TX_EN",          /*  5 */
> +	"UART_RX_EN", "TP24", "", "TP25", "TP26",           /* 10 */
> +	"TP27";                                             /* 15 */
> +};
> +
> +&gpiof {
> +	gpio-line-names = "TP36", "TP37", "", "", "OLED_CS", /*  0 */
> +	"", "", "", "", "",                                  /*  5 */
> +	"USER_LED1", "", "STACK_CS0", "", "",                /* 10 */
> +	"";                                                  /* 15 */
> +};
> +
> +&gpiog {
> +	gpio-line-names = "ETH_RESET", "", "", "", "",               /*  0 */
> +	"IOBUS_FLT_FB", "", "USER_LED2", "ETH1_PPS_A", "CAN_0_120R", /*  5 */
> +	"TP49", "", "", "", "",                                      /* 10 */
> +	"";                                                          /* 15 */
> +};
> +
> +&gpioh {
> +	gpio-line-names = "", "", "OUT_1", "OUT_0", "OLED_RESET", /*  0 */
> +	"", "", "", "", "",                                       /*  5 */
> +	"ETH1_PPS_B", "ETH_GPIO2", "", "IOBUS_PWR_EN", "",        /* 10 */
> +	"TP33";                                                   /* 15 */
> +};
> +
> +&gpioi {
> +	gpio-line-names = "TIM_RTS", "", "", "", "DEVICE_DATA_EN", /*  0 */
> +	"", "", "", "ETH_WOL", "TP43",                             /*  5 */
> +	"", "USER_BTN";                                            /* 10 */
> +};
> +
> +&gpioz {
> +	gpio-line-names = "HWID0", "HWID1", "HWID2", "HWID3", "", /*  0 */
> +	"", "HWID4", "HWID5";                                     /*  5 */
> +};
> +
> +&hash1 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_pins_b>;
> +	pinctrl-1 = <&i2c1_sleep_pins_b>;
> +	status = "okay";
> +
> +	powerboard_eeprom: eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		vcc-supply = <&v3v3>;
> +	};
> +
> +	temperature-sensor@48 {
> +		compatible = "national,lm75a";
> +		reg = <0x48>;
> +		status = "disabled";
> +	};
> +};
> +
> +&i2c5 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c5_pins_b>;
> +	pinctrl-1 = <&i2c5_sleep_pins_b>;
> +
> +	status = "okay";
> +
> +	usbhub: usbhub@2c {
> +		compatible ="microchip,usb2514b";
> +		reg = <0x2c>;
> +		vdd-supply = <&v3v3>;
> +		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <8>;
> +	status = "okay";
> +};
> +
> +&m_can1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can1_pins_b>;
> +	pinctrl-1 = <&m_can1_sleep_pins_b>;
> +	status = "okay";
> +};
> +
> +&m_can2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can2_pins_a>;
> +	pinctrl-1 = <&m_can2_sleep_pins_a>;
> +	status = "okay";
> +};
> +
> +&pmic {
> +	regulators {
> +		buck1-supply = <&reg_5v>;	/* VIN */
> +		buck2-supply = <&reg_5v>;	/* VIN */
> +		buck3-supply = <&reg_5v>;	/* VIN */
> +		buck4-supply = <&reg_5v>;	/* VIN */
> +		ldo2-supply = <&reg_5v>;	/* PMIC_LDO25IN */
> +		ldo4-supply = <&reg_5v>;	/* VIN */
> +		ldo5-supply = <&reg_5v>;	/* PMIC_LDO25IN */
> +		vref_ddr-supply = <&reg_5v>;	/* VIN */
> +		boost-supply = <&reg_5v>;	/* PMIC_BSTIN */
> +		pwr_sw2-supply = <&bst_out>;	/* PMIC_SWIN */
> +	};
> +};
> +
> +&pwr_regulators {
> +	vdd-supply = <&vdd>;
> +	vdd_3v3_usbfs-supply = <&vdd_usb>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_b>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_b>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_b>;
> +	vmmc-supply = <&v3v3>;
> +
> +	bus-width = <8>;
> +	mmc-ddr-3_3v;
> +	no-1-8-v;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2_pins_c>;
> +	cs-gpios = <&gpiof 12 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&spi4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi4_pins_a>;
> +	cs-gpios = <&gpiof 4 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	lcd: display@0 {
> +		compatible = "shineworld,lh133k", "panel-mipi-dbi-spi";
> +		reg = <0>;
> +		power-supply = <&v3v3>;
> +		io-supply = <&v3v3>;
> +		backlight = <&backlight>;
> +		dc-gpios = <&gpiod 10 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpioh 4 GPIO_ACTIVE_HIGH>;
> +		spi-3wire;
> +		spi-max-frequency = <32000000>;
> +
> +		width-mm = <23>;
> +		height-mm = <23>;
> +		rotation = <180>;
> +
> +		panel-timing {
> +			hactive = <240>;
> +			vactive = <240>;
> +			hback-porch = <0>;
> +			vback-porch = <0>;
> +
> +			clock-frequency = <0>;
> +			hfront-porch = <0>;
> +			hsync-len = <0>;
> +			vfront-porch = <0>;
> +			vsync-len = <0>;
> +		};
> +	};
> +};
> +
> +&spi5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi5_pins_a>;
> +
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	cs-gpios = <&gpiod 13 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +
> +	switch: switch@0 {
> +		compatible = "microchip,ksz9563";
> +		reg = <0>;
> +
> +		reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
> +		spi-max-frequency = <44000000>;
> +		spi-cpha;
> +		spi-cpol;
> +
> +		interrupt-parent = <&gpioa>;
> +		interrupts = <6 IRQ_TYPE_EDGE_RISING>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port_dut: port@0 {
> +				reg = <0>;
> +				label = "dut";
> +			};
> +
> +			port_uplink: port@1 {
> +				reg = <1>;
> +				label = "uplink";
> +			};
> +
> +			port_cpu: port@2 {
> +				reg = <2>;
> +				label = "cpu";
> +
> +				ethernet = <&ethernet0>;
> +
> +				phy-mode = "rgmii-id";
> +				rx-internal-delay-ps = <2000>;
> +				tx-internal-delay-ps = <2000>;
> +
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&timers2 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +
> +	timer@1 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers3 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +
> +	timer@2 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers4 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +
> +	timer@3 {
> +		status = "okay";
> +	};
> +};
> +
> +&uart4 {
> +	label = "debug";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart4_pins_a>;
> +
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +};
> +
> +&usart3 {
> +	label = "dut";
> +	uart-has-rtscts;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usart3_pins_f>;
> +
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	status = "okay";
> +};
> +
> +&usbh_ehci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +
> +	status = "okay";
> +};
> +
> +&usbotg_hs {
> +	phys = <&usbphyc_port1 0>;
> +	phy-names = "usb2-phy";
> +
> +	vusb_d-supply = <&vdd_usb>;
> +	vusb_a-supply = <&reg18>;
> +
> +	dr_mode = "peripheral";
> +
> +	status = "okay";
> +};
> +
> +&usbphyc {
> +	status = "okay";
> +};
> +
> +&usbphyc_port0 {
> +	phy-supply = <&vdd_usb>;
> +};
> +
> +&usbphyc_port1 {
> +	phy-supply = <&vdd_usb>;
> +};
> +
> +&v3v3_hdmi {
> +	/delete-property/regulator-always-on;
> +};
> +
> +&vrefbuf {
> +	regulator-min-microvolt = <2500000>;
> +	regulator-max-microvolt = <2500000>;
> +	vdda-supply = <&vdda>;
> +
> +	status = "okay";
> +};

