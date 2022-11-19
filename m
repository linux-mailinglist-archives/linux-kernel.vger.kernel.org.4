Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA6630AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiKSDKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKSDKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:10:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE7C6B210
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3592560B35
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9974DC433D6;
        Sat, 19 Nov 2022 03:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827450;
        bh=/wFZSz9BsO4d5OVNvC1Agf8X5c4DoBk4OzwwoSfgXGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9qHeaMicAY0xiMxnB0BTkswYl0H0rrM9JaT4GoajBcUMLTpbn3DipLU8ldRAonT6
         xsi236PTlBccVaXVc6XEadbYls4Yt+Wnpq1QrLv7wrC9MYNXXprFT0Qvoa0XqQQeJJ
         fYs5G8RBd9wXAtpBABJe/QWQeEBaXhevRXqTdBqqs05WzjGLE0IZmiqvzhcgAGxVOy
         JwiIMO5jVkC8gTXW1Bl90WzGfPe/KwQQXRcOuMccZDoo0PG95eFacvxGQahY07MZzO
         MsAYSxyFkiZPc6Cth2knE59AusdZR2IfhGtw3neuyCv3YVEi7yK0YfD08gNKk2H5J6
         KwdIMbg15Th6w==
Date:   Sat, 19 Nov 2022 11:10:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 10/12] arm64: dts: imx8mn-evk: enable uart1
Message-ID: <20221119031039.GK16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-11-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-11-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:54:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable uart1 for BT usage
> Configure the clock to source from IMX8MN_SYS_PLL1_80M, because the uart
> could only support max 1.5M buadrate if using OSC_24M as clock source.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 2439b91e51d8..dfa11927b1d7 100644
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

uart-has-rtscts

Fixed it up and applied, thanks!

Shawn

> +	status = "okay";
> +};
> +
>  &uart2 { /* console */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
> @@ -444,6 +453,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
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
