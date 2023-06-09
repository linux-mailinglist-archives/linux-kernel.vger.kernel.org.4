Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6230C729366
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbjFIIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbjFIIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:38:37 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85221E50;
        Fri,  9 Jun 2023 01:38:11 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7Xca-0004UX-01; Fri, 09 Jun 2023 10:37:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 201F2C02F4; Fri,  9 Jun 2023 10:36:42 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:36:42 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 2/3] MIPS: Select CONFIG_GENERIC_IDLE_POLL_SETUP
Message-ID: <20230609083642.GB9563@alpha.franken.de>
References: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
 <20230521223124.21911-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521223124.21911-3-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 11:31:23PM +0100, Jiaxun Yang wrote:
> hlt,nohlt paramaters are useful when debugging cpuidle
> related issues.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>  arch/mips/Kconfig                               | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 515cd1f88ea2..9c502d3aa0cd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3694,8 +3694,8 @@
>  
>  	nohibernate	[HIBERNATION] Disable hibernation and resume.
>  
> -	nohlt		[ARM,ARM64,MICROBLAZE,SH] Forces the kernel to busy wait
> -			in do_idle() and not use the arch_cpu_idle()
> +	nohlt		[ARM,ARM64,MICROBLAZE,MIPS,SH] Forces the kernel to
> +			busy wait in do_idle() and not use the arch_cpu_idle()
>  			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
>  			to be effective. This is useful on platforms where the
>  			sleep(SH) or wfi(ARM,ARM64) instructions do not work
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5f52bdecb4c9..e437bf43ecfc 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -45,6 +45,7 @@ config MIPS
>  	select GENERIC_LIB_UCMPDI2
>  	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
>  	select GENERIC_SMP_IDLE_THREAD
> +	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_TIME_VSYSCALL
>  	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
>  	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
> -- 
> 2.39.2 (Apple Git-143)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
