Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29B64D9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLOKjW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 05:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLOKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:39:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAAE2C10A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:39:18 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1p5ldl-0002Ha-Ud; Thu, 15 Dec 2022 11:39:02 +0100
Message-ID: <19bd825fa0df76e7b1223e34f934acadd32d6cdf.camel@pengutronix.de>
Subject: Re: [PATCH v1] arm64: dts: verdin-imx8mp: add pcie support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Dec 2022 11:38:58 +0100
In-Reply-To: <20221214061354.174072-1-marcel@ziswiler.com>
References: <20221214061354.174072-1-marcel@ziswiler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Mittwoch, dem 14.12.2022 um 07:13 +0100 schrieb Marcel Ziswiler:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add PCIe support on the Verdin iMX8M Plus.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
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

Now that I see this, I realize that those clocks and assignments could
move into imx8mp.dtsi. I doubt that anyone would want to configure
those clocks in a different way. The real difference between boards is
the PCIe PHY reference clock and those differences are fully contained
in the PHY node.

Regards,
Lucas

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

