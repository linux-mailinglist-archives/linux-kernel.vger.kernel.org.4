Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA41F701B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjENCtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENCtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 22:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423A268B
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 19:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D43260907
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACED8C433EF;
        Sun, 14 May 2023 02:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684032544;
        bh=I3ckGPSv+PDZQ9OAjujJOxlnelLqUmr79NbB+vT9g6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovo8yTupAoLfqCtPZJnn+KkmqMFtf9J6ugxUsgss3X5JPDoGRYgOONDqHB8In95C6
         BZNhNAo6pNWDNciI8ISVTVLxjzCMWRjPonT3G8tBuU5p+F2saPkoGnJ0w71+b8gQ2O
         EcOFbWRItRuaVUmUBGSKDz5Jhd1Q+CAndlDi/A9xNKbEx9fiLdXrHSuJN2fjLzKEV6
         BH+IdiS/3mcwZy2x5YyJ1/or1LdhRG4cAL1BR+bA2lcbE6F8Kau1p7Ev7pl0Pc4HU2
         HppH3OUqcCd4JlMPAyeFM656gg+UZ4K2g3J+gqvlHFtXvCEik4yRxwxVw8cRo13cKB
         4V2RUJBayTNag==
Date:   Sun, 14 May 2023 10:48:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add entry for TQ-Systems device
 trees and drivers
Message-ID: <20230514024852.GI727834@dragon>
References: <20230417064306.16074-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417064306.16074-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:43:06AM +0200, Alexander Stein wrote:
> This includes the arm & arm64 module + board DT files as well as x86
> platform GPIO drivers.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

I suggest you send it to Arnd (Cc-ed) for applying through arm-soc tree.

Shawn

> ---
> Changes in v2:
> * rebase to next-20230413
> * Explicitely add corresponding maintainers
> 
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f74d8571ac9a..5418f1a77a932 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21344,6 +21344,20 @@ S:	Maintained
>  F:	Documentation/hwmon/tps546d24.rst
>  F:	drivers/hwmon/pmbus/tps546d24.c
>  
> +TQ SYSTEMS BOARD & DRIVER SUPPORT
> +L:	linux@ew.tq-group.com
> +S:	Supported
> +W:	https://www.tq-group.com/en/products/tq-embedded/
> +F:	arch/arm/boot/dts/imx*mba*.dts*
> +F:	arch/arm/boot/dts/imx*tqma*.dts*
> +F:	arch/arm/boot/dts/mba*.dtsi
> +F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
> +F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
> +F:	arch/arm64/boot/dts/freescale/mba*.dtsi
> +F:	drivers/gpio/gpio-tqmx86.c
> +F:	drivers/mfd/tqmx86.c
> +F:	drivers/watchdog/tqmx86_wdt.c
> +
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> -- 
> 2.34.1
> 
