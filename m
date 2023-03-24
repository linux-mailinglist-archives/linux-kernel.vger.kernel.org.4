Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7C6C7E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjCXNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:13:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3D1D5FD6;
        Fri, 24 Mar 2023 06:13:40 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pfhEh-00010v-00; Fri, 24 Mar 2023 14:13:39 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1C1CCC1B34; Fri, 24 Mar 2023 14:11:29 +0100 (CET)
Date:   Fri, 24 Mar 2023 14:11:29 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Remove obsolete configs IRQ_MSP_CIC and IRQ_MSP_SLP
Message-ID: <20230324131129.GA15824@alpha.franken.de>
References: <20230324100848.13127-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324100848.13127-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:08:48AM +0100, Lukas Bulwahn wrote:
> Commit 1b00767fd8e1 ("MIPS: Remove PMC MSP71xx platform") removes all uses
> of the config IRQ_MSP_CIC and IRQ_MSP_SLP.
> 
> Remove these two obsolete configs IRQ_MSP_CIC and IRQ_MSP_SLP.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index f1dfc2fe2acb..26d254d125b6 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1179,12 +1179,6 @@ config SYS_SUPPORTS_LITTLE_ENDIAN
>  config MIPS_HUGE_TLB_SUPPORT
>  	def_bool HUGETLB_PAGE || TRANSPARENT_HUGEPAGE
>  
> -config IRQ_MSP_SLP
> -	bool
> -
> -config IRQ_MSP_CIC
> -	bool
> -
>  config IRQ_TXX9
>  	bool
>  
> -- 
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
