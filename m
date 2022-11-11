Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3762512E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKKCxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiKKCwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:52:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91452EE19;
        Thu, 10 Nov 2022 18:52:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F33961E84;
        Fri, 11 Nov 2022 02:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1131FC433D6;
        Fri, 11 Nov 2022 02:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668135165;
        bh=sZ0z3LPYriwx/rk2VZkne10P2Vh1hJUJ5kAQewV4+eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW2pHWXbynJWLIfbdKcPOh4SjwGf40tr6tCIyCac7aSm5ys6JhoAPw530RherP5bx
         /dLO+tdf4YiJT0DJ081GKYSuqNhfL9wit8LptaDVsrD+zGti6LYJCNxTpUtEpjga4w
         0psglM0sf1VwsuTeZJbUlMporJAXzoxPIfYn6K5dJ+C4D+xHF6Smiohvu3jxTbPAmQ
         Gt/Y47ya1kDe84xd1qqYMwUD77N5P1NJNaq9odgeR3emhvrCSRajLRy0ndl0XQA0L4
         +Z/iBdJjKulTyCOlEVDa6sDLjaUzEo9pHOSzGAQkqhvWPR+QuuHTWA0YnNj2h1FnA2
         Dddx/X8ZBie4g==
Date:   Fri, 11 Nov 2022 10:52:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabre: Add mmc aliases
Message-ID: <20221111025232.GI125525@dragon>
References: <20221028141811.101122-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028141811.101122-1-detlev.casanova@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:18:11AM -0400, Detlev Casanova wrote:
> If not specified, the mmc0 and mmc1 devices will be the devices
> mmc@2190000 and mmc@2194000, which are in disabled state on the iMX.6
> Sabrelite devices.
> 
> The actual SD card reader devices are the ones at mmc@2198000 and
> mmc@219c000.
> 
> Set aliases to use the correct mmc devices order.

Is this something never worked or a regression?  For the latter, we may
need a Fixes tag?

Shawn

> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> index 22f8e2783cdf..12573e1f917c 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> @@ -14,6 +14,11 @@ chosen {
>  		stdout-path = &uart2;
>  	};
>  
> +	aliases {
> +		mmc0 = &usdhc3;
> +		mmc1 = &usdhc4;
> +	};
> +
>  	memory@10000000 {
>  		device_type = "memory";
>  		reg = <0x10000000 0x40000000>;
> -- 
> 2.38.1
> 
