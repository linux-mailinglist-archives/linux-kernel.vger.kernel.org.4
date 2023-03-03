Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE96A9595
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCCKwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCCKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:52:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43B5CC2E;
        Fri,  3 Mar 2023 02:52:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C91A8CE210D;
        Fri,  3 Mar 2023 10:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A72C433D2;
        Fri,  3 Mar 2023 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840728;
        bh=Sh1lIVBe9d7qycBK73lEYNcJit9sdcVlFnNQEz+J6LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNJHdPnWbI5zSuYmAJXqBKn7xALTP8bvRw53WmYyL1WQKQG4EZq22+S/oS4vnZJQf
         q+dJFEb3bgSk4s9HMDpCsgNK/17HlWPuyGq8ioDvg50+lGYeHMAR3qtNX78MLYas64
         FarUWY+AptW3xK3DelqfMdDq/URsJXEcHidgE0g3jL7HriH1m+gz+l2y+SJJrWHp6H
         vkvJnz1m9SAaFAvMw1J2CzhT2Ba1shsYyY5WFq4cyNwRLUJzpMe5Wz02Ca49yKPCRk
         FOcUJiFh/Eb/TE5EVHrNNPQnibfL+2vADGgBUEU2hYwgP8d6y282CfQog2TxgxYiHt
         iUOWYPUfXmaBA==
Date:   Fri, 3 Mar 2023 10:52:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
Message-ID: <20230303105203.GA2420672@google.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-27-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230224150811.80316-27-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023, Nick Alcock wrote:

> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/mfd/omap-usb-host.c | 1 -
>  drivers/mfd/omap-usb-tll.c  | 1 -
>  drivers/mfd/twl4030-audio.c | 1 -
>  drivers/mfd/twl6040.c       | 1 -
>  4 files changed, 4 deletions(-)

Please adapt the subject line(s) to include the drivers changed.  It might
also make sense to separate out changes to cover one driver per patch.

mfd: <device>: Succinct subject-line describing changes

> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 787d2ae86375..7f5775109593 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -853,7 +853,6 @@ static struct platform_driver usbhs_omap_driver = {
>  MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
>  MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
>  MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> -MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
>  
>  static int omap_usbhs_drvinit(void)
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 080d7970a377..8ca4067da6cd 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -450,7 +450,6 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
>  
>  MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
>  MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
> -MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
>  
>  static int __init omap_usbtll_drvinit(void)
> diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
> index 4536d829b43e..88002f8941e5 100644
> --- a/drivers/mfd/twl4030-audio.c
> +++ b/drivers/mfd/twl4030-audio.c
> @@ -285,5 +285,4 @@ module_platform_driver(twl4030_audio_driver);
>  
>  MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
>  MODULE_DESCRIPTION("TWL4030 audio block MFD driver");
> -MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:twl4030-audio");
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index fc97fa5a2d0c..e982119bbefa 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -839,4 +839,3 @@ module_i2c_driver(twl6040_driver);
>  MODULE_DESCRIPTION("TWL6040 MFD");
>  MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
>  MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
> -MODULE_LICENSE("GPL");
> -- 
> 2.39.1.268.g9de2f9a303
> 

-- 
Lee Jones [李琼斯]
