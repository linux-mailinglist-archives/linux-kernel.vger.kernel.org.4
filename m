Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254FC6F28AD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjD3MKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3MKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:10:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F626BF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:10:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9619095f479so28120566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682856632; x=1685448632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGqAmxewrP7RkR8C9dvCorfbXmBLx3MwbowSEa7nqgo=;
        b=ajprBWr6iz9pzWekIrhQ1riu7O1UHcG67J97einbZ4lo6QnZzVNZMET4BQfry2fV9c
         IUj+hCd5auTR+AiuqG3DGKi9khF0f+Jvn6s92Mvxfve2zOVvy3P3glWImY8BgOH1HGcn
         Nw39ueysV5r3qi9+46vK/X+KnlPhfUHzeLKFsm8xvn3iKmq4AL9mqhqxc6ijlN2QhMj9
         vq2cgAt9US2wycOj7zKDX769kO5GM+g4GVHKRFFlAOwLL3a27ccpUmtU1Jn1lQyRpxLB
         XvnFnbvVsR/OgZFsqX8vG1mrOSmgTj59WmCUC9JoAJPebMPBDy7PW9n9BYwHwlFxgf42
         RwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682856632; x=1685448632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGqAmxewrP7RkR8C9dvCorfbXmBLx3MwbowSEa7nqgo=;
        b=i7IeZqyyHbttdLpNarMPfIyhf653HEIeXiZ2ZY+7q5UXMUyiEh9CqL2T9ooD+OW/OP
         P1c/ztVydl4azZ/09fv+vO5qxJrtdFpQ7mUFVfR9C1U+pWVu5fzpT5UW5rpqnNxlx4QV
         pY4nFyjHaB3luBzZof+S0wX/JVTCLkbdDiH1mjBDJ4UYY3HQs5buUabj/WNQOu0vLtLB
         unI9PbA9hQYMZks7k77DSW6JMNRm39S8HbdoNzSTD4KxlH+GA1x3lDknbhY33E2iC1t+
         dS6QVEPmbJy645udFf3G1xk1qJRmhscrvcaow6UsvxxkwVB/i72y1FJ2Dl7DBOQf2YZH
         kLBg==
X-Gm-Message-State: AC+VfDwWnGk9NKbir2FG7KjtyId5VHzyGYW1hY07TBLIrSHGg38geEC3
        p+KkYOTV7apgTSo5DQveY2V2/g==
X-Google-Smtp-Source: ACHHUZ5RwVJ+Dve2hxg3WdFoYBnDcmWNGJMH6IJnmdyqSCj46m2tF9ckACCp/ndnNdgGGJDiehKEnw==
X-Received: by 2002:a17:907:6e20:b0:94e:fe21:baf with SMTP id sd32-20020a1709076e2000b0094efe210bafmr10250762ejc.21.1682856632064;
        Sun, 30 Apr 2023 05:10:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3? ([2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3])
        by smtp.gmail.com with ESMTPSA id gz19-20020a170907a05300b0095076890fc1sm13591529ejc.1.2023.04.30.05.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 05:10:31 -0700 (PDT)
Message-ID: <db87c485-179d-0bf9-f5b7-77186dc81757@linaro.org>
Date:   Sun, 30 Apr 2023 14:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: dts: Add a device tree file for Emtop SOM IMX8MM
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
References: <BM1PR01MB4899EDE006EB24863E80D8C09A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BM1PR01MB4899EDE006EB24863E80D8C09A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
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

On 29/04/2023 15:44, Himanshu Bhavani wrote:
> From 9b2f563e1286c960ad81bc78ec811029ffb2f57a Mon Sep 17 00:00:00 2001
> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> Date: Sat, 29 Apr 2023 19:03:53 +0530
> Subject: [PATCH] Add a device tree file for Emtop SOM IMX8MM

Fix your email setup.

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

Keep order.

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
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "FSL i.MX8MM Emtop SOM";
> +	compatible = "fsl,imx8mm-emtop", "fsl,imx8mm-evk", "fsl,imx8mm";

I commented on bindings - this does not look correct at all.

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

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

missing proper prefix/name.
Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			label = "sys";
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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		reg = <0x25>;
> +		compatible = "nxp,pca9450";
> +		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
> +
> +		regulators {
> +

Stray blank line.

...

> +	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x194
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d4
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d4
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d4
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d4
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d4
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {

Here as well.


Best regards,
Krzysztof

