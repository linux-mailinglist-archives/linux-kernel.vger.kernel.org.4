Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043D6F350D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjEARbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEARbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:31:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE94AF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:31:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so41536248a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682962273; x=1685554273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WN7VMG5C5LsmQlGIpGnb286okb1jEuCeKOJuuAE/q8o=;
        b=TbZYtI/DasR6GK/EHf1HUEVZLAI/Q8csHQPFXrxeI7SiPuos+HwsHyCYkz6c3zfr4Q
         rsCFUT2KMUmARm03apxkypy+nElrsFqy48UzMVb2WQJsJvRS2AFWtoCOYuy3kh9TzEAv
         tJtPQ8ru24y5N0bMGwQGIbyXkC6CLtd8kuqTYDjxuzMsKX0cUFs/U0NkPFs//Pmf73kL
         +V5FYDfJLIZk8SAR5UeV3XxtG8x2I8dfBLJFU+QgN39aG1ukPJ/D/y1zQXlkCNKa3qsY
         g16Kgzvgm3ruaM92xAKr83XIa0i1++LpSk7dtYPUmCE8w+NcFQ/OtSB06l/L6/CgJOVL
         WRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962273; x=1685554273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WN7VMG5C5LsmQlGIpGnb286okb1jEuCeKOJuuAE/q8o=;
        b=B64094zIkE63W3lr+gBaY3x0mC/J0v8aWfMFlIzmV9i4xDwo5QNFMURadhAdccQ9+X
         kLxyIAAc9qrpVtjBT22Nm1+9G/WDTCro1fAFpAwYWHQZbKT0QQtQjkbcWZhNzf06UnzN
         CuYTBcZFY9ekVT/El+1PUnD4i9YloLIYf49QEVJTbXr8/F109zqOaFUvqS66ag8szEHP
         pEeeR9bu1WBDrnw0Cb9LBZiijiR5KlkmC88Aj4PqDlJfrNwPehKe7VgTIktFXdLlPwoA
         +st6X4v9ac/teLtW4VIqqxgdRoIan6bzy+Zzw2VcnMUZzgRQSQ1eTlPlgOCG+4ZhdZ0U
         ZRSw==
X-Gm-Message-State: AC+VfDxmFH09S233LIBtlfB1mngkJiPZDYP+LS0Mie/F/Mh5UFOQJGXh
        oB1+7wNOklVf3G0RlPjXyl8egQ==
X-Google-Smtp-Source: ACHHUZ5YQFaPEghAQxcDEv4R3TbtuLh6CswjJh+j47ONB42SC2ySUbiAgRDqgpkgkkyl1E1gD6C2Aw==
X-Received: by 2002:a17:907:31c4:b0:953:87bf:3caa with SMTP id xf4-20020a17090731c400b0095387bf3caamr12803298ejb.22.1682962273117;
        Mon, 01 May 2023 10:31:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id hq32-20020a1709073f2000b0094f206b97e8sm15066737ejc.130.2023.05.01.10.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:31:08 -0700 (PDT)
Message-ID: <1f2d67e9-ee64-e26c-ca1d-1c5195b8867f@linaro.org>
Date:   Mon, 1 May 2023 19:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2] arm64: dts: Add a device tree file for Emtop SOM
 IMX8MM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BM1PR01MB4899A5B20580E5988FBF80EA9A6E9@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BM1PR01MB4899A5B20580E5988FBF80EA9A6E9@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 18:39, Himanshu Bhavani wrote:
> From 33b96ec2602598f2a29e876c1f83b101d88faf2e Mon Sep 17 00:00:00 2001
> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching). It is still wrong.

> Date: Mon, 1 May 2023 21:50:44 +0530
> Subject: [PATCH] Added dts for describing the Emtop SOM-IMX8MM
> 

This is still not applicable patch. This is not a patch at all.


> Changes in v2:
> 	- Update dtb add order in Makefile
> 	- Update bindings
> 	- Update proper prefix/name in dts
> 	- Removed stray blank line
> 	- Add pinctrl-names in pmic node

This is not commit msg, but changelog so under ---.

> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 198fff3731ae..36590515fbc1 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> new file mode 100644
> index 000000000000..5c569bbedc69
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Emtop
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Emtop SOM i.MX8MM";
> +	compatible = "emtop,imx8mm-emtop", "fsl,imx8mm";

You still miss bindings. Don't send them separately, but as part of
patchset. There is extensive guide how to do it.
https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst

> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +		
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +/*	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		sys {
> +			label = "sys";
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};*/

Don't add dead code to upstream.

> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;

Run checkpatch. Fix indentation to tabs,

> +};
> +
> +&A53_1 {
> +        cpu-supply = <&buck2>;
> +};
> + 
> +&A53_2 {
> +        cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +        cpu-supply = <&buck2>;
> +};
> +
> +&uart2 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +/* eMMC */

Keep one style of comments.

> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9450";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-compatible = "BUCK1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-compatible = "BUCK2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck3: BUCK3 {
> +				regulator-compatible = "BUCK3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-compatible = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-compatible = "BUCK5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-compatible = "BUCK6";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-compatible = "LDO1";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-compatible = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <945000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-compatible = "LDO3";
> +				regulator-min-microvolt = <1710000>;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-compatible = "LDO4";
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <945000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-compatible = "LDO5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <3600000>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +
> +	pinctrl_gpio_led: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
> +			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL				0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA				0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicirq {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3			0x41
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX			0x140
> +			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX			0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x190
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d0
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d0
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d0
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d0
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d0
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d0
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {

NAK, nothing improved here.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.
Best regards,
Krzysztof

