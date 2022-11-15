Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6962954D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiKOKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiKOKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:07:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280E248C4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:07:53 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ousr7-0002Os-Vg; Tue, 15 Nov 2022 11:07:49 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ousr7-0007A3-I9; Tue, 15 Nov 2022 11:07:49 +0100
Date:   Tue, 15 Nov 2022 11:07:49 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 09/12] arm64: dts: imx8mn-evk: add i2c gpio recovery
 settings
Message-ID: <20221115100749.46d6uksuaouzuj3p@pengutronix.de>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
 <20221115091709.2865997-10-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115091709.2865997-10-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-15, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add I2C gpio recovery iomuxc settings
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 2b4395854283..1971f095e4c2 100644
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
> @@ -370,6 +376,13 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
>  		>;
>  	};
>  
> +	pinctrl_i2c2_gpio: i2c2grp-gpio {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16	0x1c3
> +			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17	0x1c3
> +		>;
> +	};
> +
>  	pinctrl_i2c3: i2c3grp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
> @@ -377,6 +390,13 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
>  		>;
>  	};
>  
> +	pinctrl_i2c3_gpio: i2c3grp-gpio {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18	0x1c3
> +			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x1c3
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicirqgrp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
> -- 
> 2.37.1
> 
> 
> 
