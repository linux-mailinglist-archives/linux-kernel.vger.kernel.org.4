Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAF69BB3E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBRRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBRRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:31:39 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D351351F;
        Sat, 18 Feb 2023 09:31:38 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pTR3V-0006Kh-1H;
        Sat, 18 Feb 2023 18:31:25 +0100
Date:   Sat, 18 Feb 2023 17:31:17 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH 1/2] pinctrl: mediatek: add missing options to
 PINCTRL_MT7981
Message-ID: <Y/ELZXqOb8VLWt93@makrotopia.org>
References: <20230218065108.8958-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230218065108.8958-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 09:51:06AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> There are options missing from PINCTRL_MT7981 whilst being on every other
> pin controller. Add them.
> 

Acked-by: Daniel Golle <daniel@makrotopia.org>

> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index f20c28334bcb..67818ba14d4e 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -130,6 +130,8 @@ config PINCTRL_MT7622
>  config PINCTRL_MT7981
>  	bool "Mediatek MT7981 pin control"
>  	depends on OF
> +	depends on ARM64 || COMPILE_TEST
> +	default ARM64 && ARCH_MEDIATEK
>  	select PINCTRL_MTK_MOORE
>  
>  config PINCTRL_MT7986
> -- 
> 2.37.2
> 
