Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8633630AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiKSDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKSDE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:04:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B3B6B18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:04:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0EEBFCE2228
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FBEC433C1;
        Sat, 19 Nov 2022 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827092;
        bh=ezOyZB3UDJ+PvNMeOk2B7+t6LUaggH2t0CNftLyOflc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d43z9PmV6H5gN8FuLdJoxOrAmFK8JdxkyyBNIclfrnFeNyIuzSJ+8lRjXVOpFTFvg
         7oYaL5HHdbd1nMM/m82TxQu2d9O752zGbxqdGLea2iBZBKpgaPjJNXgADCLU2lbqYU
         WNNMenGToHImY7ygPHQEMbdPWcbnUCvPEw+otc+jBwoUZMxDhoyCpxQbTTEKd1wviN
         hDA3UgeIpEy/nkh1rtMAriAypDPYaL6sRn6zdYvF2zA3hwbVSRhRq87pWNj/owEDn/
         lD7TnFqynSpEZ9o3Zmq67SDYJQCdqIYTsTFhUZSlcmW54OikO7BrJV0hyg0EAQXI6o
         O/Q2t3yADibyw==
Date:   Sat, 19 Nov 2022 11:04:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 04/12] arm64: dts: imx8mp-evk: enable uart1/3 ports
Message-ID: <20221119030444.GE16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-5-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:55PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable uart1/3 ports for evk board.
> Configure the clock to source from IMX8MP_SYS_PLL1_80M, because the uart
> could only support max 1.5M buadrate if using OSC_24M as clock source.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index e323e6f4b7e5..29472502d547 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -412,6 +412,15 @@ &snvs_pwrkey {
>  	status = "okay";
>  };
>  
> +&uart1 { /* BT */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	fsl,uart-has-rtscts;

'fsl,uart-has-rtscts' is deprecated, and 'uart-has-rtscts' should be
used instead.

Fixed it up and applied, thanks!

Shawn

> +	status = "okay";
> +};
> +
>  &uart2 {
>  	/* console */
>  	pinctrl-names = "default";
> @@ -434,6 +443,15 @@ &usb_dwc3_1 {
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
> @@ -609,6 +627,15 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
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
> @@ -622,6 +649,15 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
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
