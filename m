Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33D69BB44
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBRRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBRRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:32:35 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC6213517;
        Sat, 18 Feb 2023 09:32:34 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pTR4W-0006LT-1K;
        Sat, 18 Feb 2023 18:32:28 +0100
Date:   Sat, 18 Feb 2023 17:32:26 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH 2/2] pinctrl: mediatek: fix naming inconsistency
Message-ID: <Y/ELqvXp5nfNWjOM@makrotopia.org>
References: <20230218065108.8958-1-arinc.unal@arinc9.com>
 <20230218065108.8958-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230218065108.8958-2-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 09:51:07AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Some options include "MediaTek", some "Mediatek". Rename all to "MediaTek"
> to address the naming inconsistency.
> 

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 42 ++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 67818ba14d4e..a71874fed3d6 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -45,35 +45,35 @@ config PINCTRL_MTK_PARIS
>  
>  # For ARMv7 SoCs
>  config PINCTRL_MT2701
> -	bool "Mediatek MT2701 pin control"
> +	bool "MediaTek MT2701 pin control"
>  	depends on MACH_MT7623 || MACH_MT2701 || COMPILE_TEST
>  	depends on OF
>  	default MACH_MT2701
>  	select PINCTRL_MTK
>  
>  config PINCTRL_MT7623
> -	bool "Mediatek MT7623 pin control with generic binding"
> +	bool "MediaTek MT7623 pin control with generic binding"
>  	depends on MACH_MT7623 || COMPILE_TEST
>  	depends on OF
>  	default MACH_MT7623
>  	select PINCTRL_MTK_MOORE
>  
>  config PINCTRL_MT7629
> -	bool "Mediatek MT7629 pin control"
> +	bool "MediaTek MT7629 pin control"
>  	depends on MACH_MT7629 || COMPILE_TEST
>  	depends on OF
>  	default MACH_MT7629
>  	select PINCTRL_MTK_MOORE
>  
>  config PINCTRL_MT8135
> -	bool "Mediatek MT8135 pin control"
> +	bool "MediaTek MT8135 pin control"
>  	depends on MACH_MT8135 || COMPILE_TEST
>  	depends on OF
>  	default MACH_MT8135
>  	select PINCTRL_MTK
>  
>  config PINCTRL_MT8127
> -	bool "Mediatek MT8127 pin control"
> +	bool "MediaTek MT8127 pin control"
>  	depends on MACH_MT8127 || COMPILE_TEST
>  	depends on OF
>  	default MACH_MT8127
> @@ -88,33 +88,33 @@ config PINCTRL_MT2712
>  	select PINCTRL_MTK
>  
>  config PINCTRL_MT6765
> -	tristate "Mediatek MT6765 pin control"
> +	tristate "MediaTek MT6765 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  
>  config PINCTRL_MT6779
> -	tristate "Mediatek MT6779 pin control"
> +	tristate "MediaTek MT6779 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  	help
>  	  Say yes here to support pin controller and gpio driver
> -	  on Mediatek MT6779 SoC.
> +	  on MediaTek MT6779 SoC.
>  	  In MTK platform, we support virtual gpio and use it to
>  	  map specific eint which doesn't have real gpio pin.
>  
>  config PINCTRL_MT6795
> -	bool "Mediatek MT6795 pin control"
> +	bool "MediaTek MT6795 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  
>  config PINCTRL_MT6797
> -	bool "Mediatek MT6797 pin control"
> +	bool "MediaTek MT6797 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
> @@ -128,42 +128,42 @@ config PINCTRL_MT7622
>  	select PINCTRL_MTK_MOORE
>  
>  config PINCTRL_MT7981
> -	bool "Mediatek MT7981 pin control"
> +	bool "MediaTek MT7981 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_MOORE
>  
>  config PINCTRL_MT7986
> -	bool "Mediatek MT7986 pin control"
> +	bool "MediaTek MT7986 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_MOORE
>  
>  config PINCTRL_MT8167
> -	bool "Mediatek MT8167 pin control"
> +	bool "MediaTek MT8167 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK
>  
>  config PINCTRL_MT8173
> -	bool "Mediatek MT8173 pin control"
> +	bool "MediaTek MT8173 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK
>  
>  config PINCTRL_MT8183
> -	bool "Mediatek MT8183 pin control"
> +	bool "MediaTek MT8183 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  
>  config PINCTRL_MT8186
> -	bool "Mediatek MT8186 pin control"
> +	bool "MediaTek MT8186 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
> @@ -182,28 +182,28 @@ config PINCTRL_MT8188
>  	  map specific eint which doesn't have real gpio pin.
>  
>  config PINCTRL_MT8192
> -	bool "Mediatek MT8192 pin control"
> +	bool "MediaTek MT8192 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  
>  config PINCTRL_MT8195
> -	bool "Mediatek MT8195 pin control"
> +	bool "MediaTek MT8195 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_PARIS
>  
>  config PINCTRL_MT8365
> -	bool "Mediatek MT8365 pin control"
> +	bool "MediaTek MT8365 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK
>  
>  config PINCTRL_MT8516
> -	bool "Mediatek MT8516 pin control"
> +	bool "MediaTek MT8516 pin control"
>  	depends on OF
>  	depends on ARM64 || COMPILE_TEST
>  	default ARM64 && ARCH_MEDIATEK
> @@ -211,7 +211,7 @@ config PINCTRL_MT8516
>  
>  # For PMIC
>  config PINCTRL_MT6397
> -	bool "Mediatek MT6397 pin control"
> +	bool "MediaTek MT6397 pin control"
>  	depends on MFD_MT6397 || COMPILE_TEST
>  	depends on OF
>  	default MFD_MT6397
> -- 
> 2.37.2
> 
