Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B76F286D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjD3KL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 06:11:25 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FD1989
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 03:11:20 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 4E3871F8F7;
        Sun, 30 Apr 2023 12:11:17 +0200 (CEST)
Date:   Sun, 30 Apr 2023 12:11:13 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: Add a device tree file for Emtop SOM IMX8MM
Message-ID: <ZE4+waqXtJIp7rv5@francesco-nb.int.toradex.com>
References: <BM1PR01MB4899EDE006EB24863E80D8C09A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BM1PR01MB4899EDE006EB24863E80D8C09A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 01:44:59PM +0000, Himanshu Bhavani wrote:
> >From 9b2f563e1286c960ad81bc78ec811029ffb2f57a Mon Sep 17 00:00:00 2001
> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> Date: Sat, 29 Apr 2023 19:03:53 +0530
> Subject: [PATCH] Add a device tree file for Emtop SOM IMX8MM
All these looks broken

> 
> Added dts for describing the Emtop SOM-IMX8MM
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 198fff3731ae..8f281c753e5a 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dahlia.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dev.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-yavia.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
keep the list alphabetically ordered

>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> new file mode 100644
> index 000000000000..5238a3b5f4cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2019 NXP
Is this NXP works/copyright?

> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "FSL i.MX8MM Emtop SOM";
> +	compatible = "fsl,imx8mm-emtop", "fsl,imx8mm-evk", "fsl,imx8mm";
"fsl,imx8mm-evk" ?


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
> +		sys {
> +			label = "sys";
label is deprecated, see
Documentation/devicetree/bindings/leds/common.yaml.
Use function/function-enumerator/color bindings.

> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&uart2 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +/* eMMC */
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
pinctrl first?
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		reg = <0x25>;
> +		compatible = "nxp,pca9450";
> +		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
> +		pinctrl-0 = <&pinctrl_pmic>;
missing pinctrl-names?


Francesco

