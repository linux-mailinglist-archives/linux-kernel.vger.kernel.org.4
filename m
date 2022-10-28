Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC356114EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJ1Oo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJ1OoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:44:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A574D19ABC9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:44:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQam-0006Lb-SP; Fri, 28 Oct 2022 16:44:16 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQam-0000bP-H6; Fri, 28 Oct 2022 16:44:16 +0200
Date:   Fri, 28 Oct 2022 16:44:16 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 10/15] arm64: dts: imx8mn-evk: add i2c gpio recovery
 settings
Message-ID: <20221028144416.rjxwjasvz4asbfpi@pengutronix.de>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-11-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024031351.4135651-11-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-24, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add I2C gpio recovery iomuxc settings
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 2b4395854283..a37a165b40ec 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -160,8 +160,11 @@ &i2c1 {
>  
>  &i2c2 {
>  	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  
>  	ptn5110: tcpc@50 {
> @@ -196,8 +199,11 @@ typec1_con: connector {
>  
>  &i2c3 {
>  	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
> +	scl-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  
>  	pca6416: gpio@20 {
> @@ -344,6 +350,13 @@ MX8MN_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
>  		>;
>  	};
>  
> +	pinctrl_i2c2_gpio: i2c2grp-gpio {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16		0x1c3
> +			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17		0x1c3
> +		>;
> +	};
> +
>  	pinctrl_gpio_wlf: gpiowlfgrp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
> @@ -377,6 +390,13 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
>  		>;
>  	};
>  
> +	pinctrl_i2c3_gpio: i2c3grp-gpio {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18		0x1c3
> +			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19		0x1c3
> +		>;
> +	};

Please sort them alphabetical.

Regards,
  Marco

> +
>  	pinctrl_pmic: pmicirqgrp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
> -- 
> 2.37.1
> 
> 
> 
