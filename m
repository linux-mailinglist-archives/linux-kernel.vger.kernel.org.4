Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384F5701B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjENDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENDFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3C2682;
        Sat, 13 May 2023 20:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368A960A6C;
        Sun, 14 May 2023 03:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C648C433D2;
        Sun, 14 May 2023 03:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684033537;
        bh=yobh4RVNESvEJWq2XpL1kFVKuHdXpKZw40NV0nK3kRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKukP/X0Bx7y7OD1gQg1HPw9mXywsgDcWfDM1wPNq6NYXawU7zEMaP2P9oO1N8CVY
         hd0FS8/b7MVYJqNS83lqtIHk3cUA56EJv192JQ4jeqX2NnINjVD8iGIlL7IyiJeEtU
         wxd1hGpAWPgSbd6etjeUk65yHMfrufQ2mV3PWm1YE6I37bUwq2SV3hVm0J3uvqmzIW
         ZJozvvGT+aKYBMZLDnHzoEa2/MWtXx8WWZ4NyFuyxBzCk67obzV0PgjKrVoGJpP2NU
         eVdoeDphD5cz/uHKmM5tO3FNgwpVa/2fKTD9YkD6UkAtOWdDRhShRbXhDNZ7r7v20U
         FZPj6sTDSbQrA==
Date:   Sun, 14 May 2023 11:05:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: colibri-imx8x: delete adc1 and dsp
Message-ID: <20230514030525.GK727834@dragon>
References: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
 <20230417173830.19401-5-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417173830.19401-5-andrejs.cainikovs@toradex.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:38:30PM +0200, Andrejs Cainikovs wrote:
> i.MX8, i.MX8X, i.MX8XP and i.MX8XL SOC device trees are all based on
> imx8-ss-*.dtsi files. For i.MX8X and i.MX8XP these device trees
> should be updated with some peripherals removed or updated, similar
> to i.MX8XL (imx8dxl-ss-*.dtsi files). However, it looks like only
> i.MX8 and i.MX8XL are up to date, but for i.MX8X and i.MX8XP some
> of the peripherals got inherited from imx8-ss-*.dtsi files, but in
> reality they are not present on SOC.
> As a result, during resource partition ownership check U-Boot receives
> messages from SCU firmware about these resources not owned by boot
> partition. In reality, these resources are not owned by anyone, as
> they simply does not exist, but are defined in Linux device tree.
> This change removes those peripherals, which are listed during
> U-Boot resource partition ownership check as warnings:
> 
>   ## Flattened Device Tree blob at 9d400000
>      Booting using the fdt blob at 0x9d400000
>      Loading Device Tree to 00000000fd652000, end 00000000fd67efff ... OK
>   Disable clock-controller@59580000 rsrc 512 not owned
>   Disable clock-controller@5ac90000 rsrc 102 not owned
> 
>   Starting kernel ...
> 
> Fixes: ba5a5615d54f ("arm64: dts: freescale: add initial support for colibri imx8x")
> 
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Applying of the patch will result in a different patch author and SoB email.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> index b0d6f632622c..49d105eb4769 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> @@ -769,3 +769,10 @@ pinctrl_wifi: wifigrp {
>  		fsl,pins = <IMX8QXP_SCU_BOOT_MODE3_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20>;
>  	};
>  };
> +
> +/* Delete peripherals which are not present on SOC, but are defined in imx8-ss-*.dtsi */
> +
> +/delete-node/ &adc1;
> +/delete-node/ &adc1_lpcg;
> +/delete-node/ &dsp;
> +/delete-node/ &dsp_lpcg;
> -- 
> 2.34.1
> 
