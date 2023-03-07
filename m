Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C556ADB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCGKFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCGKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:05:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E63D936
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:05:11 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pZUBZ-0005Gr-0t; Tue, 07 Mar 2023 11:04:45 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pZQVV-000344-IF; Tue, 07 Mar 2023 07:09:05 +0100
Date:   Tue, 7 Mar 2023 07:09:05 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Davis <afd@ti.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qin Jian <qinjian@cqplus1.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] ARM: mach-asm9260: Move ASM9260 support into
 Kconfig.platforms
Message-ID: <20230307060905.GD11936@pengutronix.de>
References: <20230306163441.16179-1-afd@ti.com>
 <20230306163441.16179-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163441.16179-2-afd@ti.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:34:33AM -0600, Andrew Davis wrote:
> This removes the need for a dedicated Kconfig and mach directory.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  arch/arm/Kconfig              | 2 --
>  arch/arm/Kconfig.platforms    | 9 +++++++++
>  arch/arm/mach-asm9260/Kconfig | 9 ---------
>  3 files changed, 9 insertions(+), 11 deletions(-)
>  delete mode 100644 arch/arm/mach-asm9260/Kconfig
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 495b1d9444ab..2f1713c0f7ce 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -360,8 +360,6 @@ source "arch/arm/mach-alpine/Kconfig"
>  
>  source "arch/arm/mach-artpec/Kconfig"
>  
> -source "arch/arm/mach-asm9260/Kconfig"
> -
>  source "arch/arm/mach-aspeed/Kconfig"
>  
>  source "arch/arm/mach-at91/Kconfig"
> diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
> index ed1f6da11e24..b80a5b49d276 100644
> --- a/arch/arm/Kconfig.platforms
> +++ b/arch/arm/Kconfig.platforms
> @@ -66,3 +66,12 @@ config ARCH_VIRT
>  	select ARM_GIC_V3_ITS if PCI
>  	select ARM_PSCI
>  	select HAVE_ARM_ARCH_TIMER
> +
> +config MACH_ASM9260
> +	bool "Alphascale ASM9260"
> +	depends on ARCH_MULTI_V5
> +	depends on CPU_LITTLE_ENDIAN
> +	select CPU_ARM926T
> +	select ASM9260_TIMER
> +	help
> +	  Support for Alphascale ASM9260 based platform.
> diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
> deleted file mode 100644
> index 74e0f61c74c8..000000000000
> --- a/arch/arm/mach-asm9260/Kconfig
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -config MACH_ASM9260
> -	bool "Alphascale ASM9260"
> -	depends on ARCH_MULTI_V5
> -	depends on CPU_LITTLE_ENDIAN
> -	select CPU_ARM926T
> -	select ASM9260_TIMER
> -	help
> -	  Support for Alphascale ASM9260 based platform.
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
