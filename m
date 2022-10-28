Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D81611546
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiJ1O7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1O7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:59:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F6620355A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:59:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQp5-0004NN-4a; Fri, 28 Oct 2022 16:59:03 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQp3-00016F-V0; Fri, 28 Oct 2022 16:59:01 +0200
Date:   Fri, 28 Oct 2022 16:59:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 02/15] arm64: dts: imx8mp-evk: correct pcie pad
 settings
Message-ID: <20221028145901.q4i73vwagny36xdj@pengutronix.de>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024031351.4135651-3-peng.fan@oss.nxp.com>
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
> According to RM bit layout, BIT3 and BIT0 are reserved.
>   8  7   6   5   4   3  2 1  0
>   PE HYS PUE ODE FSEL X  DSE  X
> 
> Although function is not broken, we should not set reserved bit.
> 
> Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

LGTM, feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 9f1469db554d..b4c1ef2559f2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -544,14 +544,14 @@ MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
>  
>  	pinctrl_pcie0: pcie0grp {
>  		fsl,pins = <
> -			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
> -			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
> +			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x60 /* open drain, pull up */
> +			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
>  		>;
>  	};
>  
>  	pinctrl_pcie0_reg: pcie0reggrp {
>  		fsl,pins = <
> -			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
> +			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
>  		>;
>  	};
>  
> -- 
> 2.37.1
> 
> 
> 
