Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23564C4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiLNIHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiLNIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:07:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5C1E733;
        Wed, 14 Dec 2022 00:07:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3591F4A7;
        Wed, 14 Dec 2022 09:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671005231;
        bh=9CYp5C0l95fUCkMQ6oeCVjqk3JD2+LW61VjeSjn+tac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDsk35Anqrj9WPElVOw/MYiiV9ndJKsGKW+OLuXUrkmEkhIm1kCK2SAG3E3OAYO/E
         ybu/RwjTiB/9nr2LLAjsmw8WtkK1OLyHT2wvl/jMSz+gpu8TquVAELWld4TQBeq4Ty
         rFjmPku/Y5sJ+T3n+k8fLiWQPb5Gib8v/Cb1HJ9Y=
Date:   Wed, 14 Dec 2022 10:07:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: verdin-imx8mp: add pcie support
Message-ID: <Y5mEK+d4MRB/vmNI@pendragon.ideasonboard.com>
References: <20221214061354.174072-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214061354.174072-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thank you for your humble patch ;-)

On Wed, Dec 14, 2022 at 07:13:54AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add PCIe support on the Verdin iMX8M Plus.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> This has successfully been tested with Lucas' imx8mp-hsio-blk-ctrl high
> performance PLL clock exposure patch set [1] a later version thereof
> hopefully may land together with my humble patch. Thanks!
> 
> [1] https://lore.kernel.org/all/20221213160112.1900410-1-l.stach@pengutronix.de/
> 
>  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  9 +++++++-
>  .../boot/dts/freescale/imx8mp-verdin.dtsi     | 22 ++++++++++++++++++-
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> index 80db1ad7c230..56b0e4b865c9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> @@ -67,7 +67,14 @@ &i2c4 {
>  	/* TODO: Audio Codec */
>  };
>  
> -/* TODO: Verdin PCIE_1 */
> +/* Verdin PCIE_1 */
> +&pcie {
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
>  
>  /* Verdin PWM_1 */
>  &pwm1 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> index 6a1890a4b5d8..f3a46f4caf49 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -749,7 +749,27 @@ eeprom_carrier_board: eeprom@57 {
>  	};
>  };
>  
> -/* TODO: Verdin PCIE_1 */
> +/* Verdin PCIE_1 */
> +&pcie {
> +	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
> +	assigned-clock-rates = <10000000>;
> +	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> +		 <&clk IMX8MP_CLK_PCIE_ROOT>,
> +		 <&clk IMX8MP_CLK_HSIO_AXI>;
> +	clock-names = "pcie", "pcie_aux", "pcie_bus";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	/* PCIE_1_RESET# (SODIMM 244) */
> +	reset-gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pcie_phy {
> +	clocks = <&hsio_blk_ctrl>;
> +	clock-names = "ref";
> +	fsl,clkreq-unsupported;
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> +};
>  
>  /* Verdin PWM_1 */
>  &pwm1 {

-- 
Regards,

Laurent Pinchart
