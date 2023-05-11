Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D146FF858
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjEKRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbjEKRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:23:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B501BCC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:23:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so81671868a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683825822; x=1686417822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TErA49NYnxkJrT15NELOp4zXx8Zgys2cWf79xIMHURc=;
        b=AGBX1B84cJTPrv7C77dVONKvFs5a7h9Iq6gULlPPrYDCu5EVPE8/TLOM9lHn4Slmbw
         yK1Cy8E60Hv4e+y9lqk2vhrfOCKlvG+DeyUzI1y0LyiRzPwcUHZumx9HkT8AbYsgxGlq
         NI9PtUWXfcTxZzyAXHPlxUFhJAWIksfA/H8WNqTZKX3IraOcU0527ySm7PjW91orc0yP
         x9iVml5lTljm/vA01qQzm0yw/Fi7w+IAVrpwo6qPlUEQLkhiPXBAqoHs92V7UsMVnH8O
         0PQcBl/ooM3+SvKsAIFn2d5YyMUZEi63R3dUtCbD0k+imRR6pYNweRblBdA6McaGwA0o
         6OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825822; x=1686417822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TErA49NYnxkJrT15NELOp4zXx8Zgys2cWf79xIMHURc=;
        b=iBumuDqpWnRHCXQN67VVNpSf84I+CQFBh0O98CxCkukCryN9Twk+ZZUkczRYuJItAt
         XKJKEMFxNrxplMkn6V7jiXcrZM0ctbKReKVrBc/xHZmcfgF00RyT98Qc5/IWanyrbHi7
         nYYFnbBLNHJW0AQuYxwqJTiLeh1w8KWqUtadaAisxLG54W3XUGAuAFWO5OB5JRUO6rUr
         Wtkki5LnA00JzJQ+EVUmXakCcHrrQycc+T7wuiPYSZLOJK7NM/PJEJEDJUGfmTbg+u/I
         E+5KSoeW88/4USb7jSmdQBMBmE87DqR+5W9kPu5j5TS5aPXAqXgp7RvAjijUcBqJieZr
         MP2Q==
X-Gm-Message-State: AC+VfDxQ7xbGibacSk4kzv4q5cukLOWfaaFCH38uUexpulVlE0W++kyy
        iodivawbqDeurvy4QJCr+CcS0g==
X-Google-Smtp-Source: ACHHUZ4W7brRdywxNtA1AHqGbss0GVjRpLvl5ZibG8uLHCJ797zlonRIK3xeFxDgGnsU0kfYDzgKow==
X-Received: by 2002:aa7:cb11:0:b0:504:a3ec:eacc with SMTP id s17-20020aa7cb11000000b00504a3eceaccmr19160559edt.4.1683825822055;
        Thu, 11 May 2023 10:23:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7cd:1be6:f89d:7218? ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b0050bcb6cf16asm3173262edw.41.2023.05.11.10.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 10:23:41 -0700 (PDT)
Message-ID: <1b3b58b9-b441-f04f-a3e1-8b5fb7f19f9d@linaro.org>
Date:   Thu, 11 May 2023 19:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw7905-2x
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511171041.4011087-1-tharvey@gateworks.com>
 <20230511171041.4011087-2-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511171041.4011087-2-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 19:10, Tim Harvey wrote:
> The Gateworks imx8mp-venice-gw7905-2x consists of a SOM + baseboard.
> 
> The GW702x SOM contains the following:
>  - i.MX8M Plus SoC
>  - LPDDR4 memory
>  - eMMC Boot device
>  - Gateworks System Controller (GSC) with integrated EEPROM, button
>    controller, and ADC's
>  - PMIC
>  - RGMII PHY (eQoS)
>  - SOM connector providing:
>   - eQoS GbE MII
>   - 1x SPI
>   - 2x I2C
>   - 4x UART
>   - 2x USB 3.0
>   - 1x PCI
>   - 1x SDIO (4-bit 3.3V)
>   - 1x SDIO (4-bit 3.3V/1.8V)
>   - GPIO
> 
> The GW7905 Baseboard contains the following:
>  - GPS
>  - microSD
>  - off-board I/O connector with I2C, SPI, GPIO
>  - EERPOM
>  - PCIe clock generator
>  - 1x full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
>  - 1x half-length miniPCIe socket with USB2.0 and USB3.0
>  - USB 3.0 HUB
>  - USB Type-C with USB PD Sink capability and peripheral support
>  - USB Type-C with USB 3.0 host support
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../dts/freescale/imx8mp-venice-gw702x.dtsi   | 589 ++++++++++++++++++
>  .../dts/freescale/imx8mp-venice-gw7905-2x.dts |  28 +
>  .../dts/freescale/imx8mp-venice-gw7905.dtsi   | 358 +++++++++++


How do you compile it? Missing Makefile. This also suggests that maybe
you did not test it with dtbs_check...


>  3 files changed, 975 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi

...

> +	gsc: gsc@20 {
> +		compatible = "gw,gsc";
> +		reg = <0x20>;
> +		pinctrl-0 = <&pinctrl_gsc>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		adc {
> +			compatible = "gw,gsc-adc";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			channel@6 {
> +				gw,mode = <0>;
> +				reg = <0x06>;
> +				label = "temp";
> +			};
> +
> +			channel@8 {
> +				gw,mode = <1>;
> +				reg = <0x08>;
> +				label = "vdd_bat";
> +			};
> +
> +			channel@16 {
> +				gw,mode = <4>;
> +				reg = <0x16>;
> +				label = "fan_tach";
> +			};
> +
> +			channel@82 {
> +				gw,mode = <2>;
> +				reg = <0x82>;
> +				label = "vdd_vin";
> +				gw,voltage-divider-ohms = <22100 1000>;
> +			};
> +
> +			channel@84 {
> +				gw,mode = <2>;
> +				reg = <0x84>;
> +				label = "vdd_adc1";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@86 {
> +				gw,mode = <2>;
> +				reg = <0x86>;
> +				label = "vdd_adc2";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@88 {
> +				gw,mode = <2>;
> +				reg = <0x88>;
> +				label = "vdd_1p0";
> +			};
> +
> +			channel@8c {
> +				gw,mode = <2>;
> +				reg = <0x8c>;
> +				label = "vdd_1p8";
> +			};
> +
> +			channel@8e {
> +				gw,mode = <2>;
> +				reg = <0x8e>;
> +				label = "vdd_2p5";
> +			};
> +
> +			channel@90 {
> +				gw,mode = <2>;
> +				reg = <0x90>;
> +				label = "vdd_3p3";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@92 {
> +				gw,mode = <2>;
> +				reg = <0x92>;
> +				label = "vdd_dram";
> +			};
> +
> +			channel@98 {
> +				gw,mode = <2>;
> +				reg = <0x98>;
> +				label = "vdd_soc";
> +			};
> +
> +			channel@9a {
> +				gw,mode = <2>;
> +				reg = <0x9a>;
> +				label = "vdd_arm";
> +			};
> +
> +			channel@a2 {
> +				gw,mode = <2>;
> +				reg = <0xa2>;
> +				label = "vdd_gsc";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +		};
> +
> +		fan-controller@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Why do you need these two? I know binding expects them, but why? Anyway
compatible is first, reg is second property.


> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
> new file mode 100644
> index 000000000000..4a1bbbbe19e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +#include "imx8mp-venice-gw702x.dtsi"
> +#include "imx8mp-venice-gw7905.dtsi"
> +
> +/ {
> +	model = "Gateworks Venice GW7905-2x i.MX8MP Development Kit";
> +	compatible = "gateworks,imx8mp-gw7905-2x", "fsl,imx8mp";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> +
> +/* Disable SOM interfaces not used on baseboard */
> +&eqos {
> +	status = "disabled";
> +};
> +
> +&usdhc1 {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi
> new file mode 100644
> index 000000000000..479190a6391f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &eqos;
> +	};
> +
> +	led-controller {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	pps {
> +		compatible = "pps-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pps>;
> +		gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	reg_usb2_vbus: regulator-usb2-vbus {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb2_en>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb2_vbus";
> +		gpio = <&gpio4 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "SD2_3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +

Drop stay blank line

> +};
> +
> +/* off-board header */
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};



Best regards,
Krzysztof

