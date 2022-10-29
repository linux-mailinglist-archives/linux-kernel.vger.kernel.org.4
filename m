Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1B6122E1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ2MXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2MXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836034DC9;
        Sat, 29 Oct 2022 05:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E47260683;
        Sat, 29 Oct 2022 12:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E18C433C1;
        Sat, 29 Oct 2022 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046213;
        bh=2rAz/7cIZHOgN7rQrdQWulR/fVQBW8dzB+F/2hYImNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7Ms5KyeSzTbrcGfVIhy2kppOQx/z2Qw4QyUqYcL4icKyJHD/1rfNBdNluGcQzry+
         zalrlflp/c4p50wCfVX9TPtZWQgU3Sq5vS0u2m0sYVgJt2xqPH4O082sr306z4KzpV
         WQ47CUi+PzF8kKn2/v9iCFGEpeXAAmfYIthLeD7kKNS9f7u6n9CW9K4zKy1FuZRabj
         ov6D9PE4uqLzuB5sTLpF/KYTaNUpWcgiCa1NRKKyE2mZxoGFC+HUF3S/jk2lk+/0Tr
         YXNFFhPe1iqno8C5GLDuOW1cDSkVSWOnDB5IEvEvIZX+KLbuiYr9I84mgwTFucD1tw
         UakcuW43F3ArA==
Date:   Sat, 29 Oct 2022 20:23:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 off-on-delay-us for regulator-usdhc2-vmmc
Message-ID: <20221029122326.GV125525@dragon>
References: <20221024111902.1338095-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024111902.1338095-1-heiko.thiery@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:19:03PM +0200, Heiko Thiery wrote:
> The delay is not required and can be remove.
> 
> Fixes: 5dbadc848259 (arm64: dts: fsl: add support for Kontron pitx-imx8m board)

It looks more like a clean-up than bug fix.

Shawn

> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
> v2:
>  - add Fixes tag
> 
>  arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> index a91c136797f6..21442e04a632 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> @@ -51,7 +51,6 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> -		off-on-delay-us = <20000>;
>  		enable-active-high;
>  	};
>  };
> -- 
> 2.30.2
> 
