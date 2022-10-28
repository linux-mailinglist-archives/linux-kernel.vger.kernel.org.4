Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70C961156C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJ1PEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiJ1PEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:04:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1F208829
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:04:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQtn-0005Lw-0P; Fri, 28 Oct 2022 17:03:55 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQtm-0002Tc-05; Fri, 28 Oct 2022 17:03:54 +0200
Date:   Fri, 28 Oct 2022 17:03:53 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 11/15] arm64: dts: imx8mn-evk: enable uart1
Message-ID: <20221028150353.ct6p7mwzvla7675z@pengutronix.de>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-12-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024031351.4135651-12-peng.fan@oss.nxp.com>
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
> Enable uart1 for BT usage

Nit: In the other patch you're describe why you need to use a other PLL
as source.

Regards,
  Marco

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index a37a165b40ec..f137eb406c24 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -247,6 +247,15 @@ &spdif1 {
>  	status = "okay";
>  };
>  
> +&uart1 { /* BT */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
>  &uart2 { /* console */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
> @@ -440,6 +449,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
>  		>;
>  	};
>  
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
> +			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
> +			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
> +			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> -- 
> 2.37.1
> 
> 
> 
