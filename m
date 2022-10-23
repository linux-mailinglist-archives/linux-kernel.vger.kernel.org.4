Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A160936C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJWNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJWNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6586278BFA;
        Sun, 23 Oct 2022 06:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E87CEB80946;
        Sun, 23 Oct 2022 13:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1572C433D6;
        Sun, 23 Oct 2022 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530760;
        bh=+6IyGl0MVPkVHS2QT8+DH7EhBIU/cufLxi876OE1DWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAGT9kCaAHGKDvqtQwV95r6i9PfDKr2sRbQzDBsu2P9NJf9pKgtNXGH1ZCgSKrvOX
         F2e7nN6P54X3hJXo7VM7y2SwAYrQWRj2DVtdmOoYBczH/+n3XPWP/z/OamHJuU2bug
         8aYLLBwTV8xrBUrWHUNEyogDVskgbiQX4HslbJaq4G4Xy+oFzeGqHO/0ogE1eiw1iF
         wH13W6T4wd2wk+lij8n00YBPoGxC5g8xaun43rp6wvyLYaxbHo+qf30sA6Pw1pwuFw
         vX/ZACzrw3pO+E0g3t5ndKxM87PdAzZKC/jX6mMLkp662HwMDGYH1bHqaxGxAJm60H
         5TsclH/ofoH5w==
Date:   Sun, 23 Oct 2022 21:12:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/8] arm64: dts: verdin-imx8mp: add pcie support
Message-ID: <20221023131232.GN125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-7-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-7-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:23PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add PCIe support on the Verdin iMX8M Plus.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> This still relies on the PHY part landing [1] and the internal SYSPLL
> mode getting sorted [2].
> 
> [1] https://lore.kernel.org/all/1663659498-5180-1-git-send-email-hongxing.zhu@nxp.com/
> [2] https://lore.kernel.org/all/AS8PR04MB867657D03C61774096A5A1628C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com/

Are these dependencies already landed on v6.1-rc1?

Shawn

> 
>  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  9 +++++++-
>  .../boot/dts/freescale/imx8mp-verdin.dtsi     | 22 ++++++++++++++++++-
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> index 4b8f86f63081..60f9dc4847db 100644
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
> index 7be7e922927b..160bb32cb5f7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -734,7 +734,27 @@ eeprom_carrier_board: eeprom@57 {
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
> +	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>;
> +	clock-names = "ref";
> +	fsl,clkreq-unsupported;
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> +};
>  
>  /* Verdin PWM_1 */
>  &pwm1 {
> -- 
> 2.36.1
> 
