Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF62372930E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjFII0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbjFIIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:51 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44D4A4C15;
        Fri,  9 Jun 2023 01:24:48 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-02; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 28227C02EE; Fri,  9 Jun 2023 10:21:02 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:21:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: generic: Allow R5 CPUs to be selected
Message-ID: <20230609082102.GC8160@alpha.franken.de>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <20230529135245.4085-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529135245.4085-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:52:45PM +0100, Jiaxun Yang wrote:
> Since we do have P5600 bitfile for boston board, we should
> allow generic kernel to be compiled for R5 CPUs.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e437bf43ecfc..215fcdc059d2 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -154,9 +154,11 @@ config MIPS_GENERIC_KERNEL
>  	select SWAP_IO_SPACE
>  	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_HAS_CPU_MIPS32_R5
>  	select SYS_HAS_CPU_MIPS32_R6
>  	select SYS_HAS_CPU_MIPS64_R1
>  	select SYS_HAS_CPU_MIPS64_R2
> +	select SYS_HAS_CPU_MIPS64_R5
>  	select SYS_HAS_CPU_MIPS64_R6
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
> -- 
> 2.39.2 (Apple Git-143)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
