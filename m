Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBF605E74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJTLHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJTLHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:07:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30419DD9D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:07:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTOW-00054g-CG; Thu, 20 Oct 2022 13:07:24 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTOV-0003bH-UK; Thu, 20 Oct 2022 13:07:23 +0200
Date:   Thu, 20 Oct 2022 13:07:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/15] arm64: dts: imx8mp-evk: enable uart1/3 ports
Message-ID: <20221020110723.udftsfrfdnghudto@pengutronix.de>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020095934.1659449-6-peng.fan@oss.nxp.com>
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

Hi Peng,

On 22-10-20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable uart1/3 ports for evk board.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 2e29bb3c041c..366f709f8790 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -428,6 +428,15 @@ &snvs_pwrkey {
>  	status = "okay";
>  };
>  
> +&uart1 { /* BT */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;

I'm curious, what is the default parent and why is this wrong? For the
already exisiting uart2 we don't do that. Same applies for uart3.

Regards,
  Marco


> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	/* console */
>  	pinctrl-names = "default";
> @@ -450,6 +459,15 @@ &usb_dwc3_1 {
>  	status = "okay";
>  };
>  
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
>  &usdhc2 {
>  	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
>  	assigned-clock-rates = <400000000>;
> @@ -625,6 +643,15 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
>  		>;
>  	};
>  
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
> +			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
> +			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
> @@ -638,6 +665,15 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
>  		>;
>  	};
>  
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
> +			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
> +			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS		0x140
> +			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x140
> +		>;
> +	};
> +
>  	pinctrl_usdhc2: usdhc2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
> -- 
> 2.37.1
> 
> 
> 
