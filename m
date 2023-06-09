Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD02772931F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbjFII1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbjFIIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:55 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE89149EE;
        Fri,  9 Jun 2023 01:24:53 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-04; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7DCFAC02EE; Fri,  9 Jun 2023 10:21:47 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:21:47 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Alchemy: Enable PATA_PLATFORM support
Message-ID: <20230609082147.GE8160@alpha.franken.de>
References: <alpine.DEB.2.21.2306011327300.59991@angie.orcam.me.uk>
 <alpine.DEB.2.21.2306011331530.59991@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2306011331530.59991@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:56:19PM +0100, Maciej W. Rozycki wrote:
> We have limited demand for platform PATA support across MIPS platforms:
> 
> $ find arch/mips -type f | sort | xargs grep -l pata_platform_info
> arch/mips/alchemy/devboards/db1200.c
> arch/mips/alchemy/devboards/db1300.c
> arch/mips/sibyte/swarm/platform.c
> $ 
> 
> certainly not high enough to justify enabling support for PATA_PLATFORM 
> port-wide.  SiByte platforms are handled selectively already, so just 
> make a similar arrangement for Alchemy DB1XXX platforms.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  arch/mips/alchemy/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> linux-mips-alchemy-pata-platform.diff
> Index: linux-macro/arch/mips/alchemy/Kconfig
> ===================================================================
> --- linux-macro.orig/arch/mips/alchemy/Kconfig
> +++ linux-macro/arch/mips/alchemy/Kconfig
> @@ -14,6 +14,7 @@ config MIPS_DB1XXX
>  	bool "Alchemy DB1XXX / PB1XXX boards"
>  	select GPIOLIB
>  	select HAVE_PCI
> +	select HAVE_PATA_PLATFORM
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_HAS_EARLY_PRINTK
>  	help

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
