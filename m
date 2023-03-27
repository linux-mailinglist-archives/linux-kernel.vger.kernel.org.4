Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421EE6C9AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjC0FO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435FE1FCB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D062160FB0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFFBC433D2;
        Mon, 27 Mar 2023 05:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679894066;
        bh=6VVfShZfbeXDOFwAA3zf3bc3mThnHWj9bZeroxo3p6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noKQosnJNmZRV7UBNx7zXYeUMr7hz12JD7pKh5kH53J1Ft7tGI4n5wYARg70WdIL1
         QzDwj6cxoNAQg0JrWfQtpbwFLt6P2cACuHXCwtGbeQru/0Fo97uDU0UJYJuFClaB3E
         axOwiQ2rbP1WBOH0uyghWpvaBf4uWTPiaQt141cZAcfyO5vya9yUo4GRwZELCS2wsC
         jMiB+glgeYuT6cKgqfl2loJpiowM+/P+mq0MEwXDKoZaDgsU/v63Wf7Rb+Xtng5Ha1
         Fenpiqt2yzjhxbcTp2OT4DvqJ5+1SIsWkyngGBPk1WBfMjdXy6Yvtir2voJHkxJuZy
         zJgC9/RteZ7tQ==
Date:   Mon, 27 Mar 2023 13:14:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-evk: update i2c pinctrl to match
 dtschema
Message-ID: <20230327051409.GO3364759@dragon>
References: <20230323111924.102541-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323111924.102541-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:19:24PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The dtschema requires 'grp' in the end, so update the name.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 8fef980c4ab2..876eb5da5e2d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -389,7 +389,7 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
>  		>;
>  	};
>  
> -	pinctrl_i2c2_gpio: i2c2grp-gpio {
> +	pinctrl_i2c2_gpio: i2c2gpriogrp {

i2c2gpiogrp

Shawn

>  		fsl,pins = <
>  			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16	0x1c3
>  			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17	0x1c3
> @@ -403,7 +403,7 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
>  		>;
>  	};
>  
> -	pinctrl_i2c3_gpio: i2c3grp-gpio {
> +	pinctrl_i2c3_gpio: i2c3gpiogrp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18	0x1c3
>  			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x1c3
> -- 
> 2.37.1
> 
