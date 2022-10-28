Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D261154E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJ1PBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1PBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:01:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF8EAEA27
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:01:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQqx-0004ob-LN; Fri, 28 Oct 2022 17:00:59 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQqx-0001iP-9p; Fri, 28 Oct 2022 17:00:59 +0200
Date:   Fri, 28 Oct 2022 17:00:59 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, Han Xu <han.xu@nxp.com>,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 06/15] arm64: dts: imx8mp-evk: enable fspi nor on
 imx8mp evk
Message-ID: <20221028150059.jubkfqiqo6mhg2zh@pengutronix.de>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024031351.4135651-7-peng.fan@oss.nxp.com>
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
> From: Han Xu <han.xu@nxp.com>
> 
> enable fspi nor on imx8mp evk dts
> 
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

LGTM, feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index b8a7de87ce4c..54dfac4ac63b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -85,6 +85,20 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  	};
>  };
>  
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <80000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
>  &A53_0 {
>  	cpu-supply = <&reg_arm>;
>  };
> @@ -567,6 +581,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
>  		>;
>  	};
>  
> +	pinctrl_flexspi0: flexspi0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
> +			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
> +			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
> +			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
> +			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
> +			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
> +		>;
> +	};
> +
>  	pinctrl_gpio_led: gpioledgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
> -- 
> 2.37.1
> 
> 
> 
