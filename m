Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029B72931B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbjFII1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbjFIIZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C62B43C1B;
        Fri,  9 Jun 2023 01:24:52 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-07; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B03E5C02EE; Fri,  9 Jun 2023 10:22:57 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:22:57 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Paul Burton <paulburton@kernel.org>,
        Siarhei Volkau <lis8215@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net
Subject: Re: [PATCH 2/4] mips: ingenic: Remove useless __maybe_unused
Message-ID: <20230609082257.GH8160@alpha.franken.de>
References: <20230604122655.69698-1-paul@crapouillou.net>
 <20230604122655.69698-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604122655.69698-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 02:26:53PM +0200, Paul Cercueil wrote:
> These flags are useless in this case as the code referencing these data
> structures is always seen by the compiler (and not behind #ifdef
> guards).
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/generic/board-ingenic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/generic/board-ingenic.c b/arch/mips/generic/board-ingenic.c
> index c422bbc890ed..7a4fce06875d 100644
> --- a/arch/mips/generic/board-ingenic.c
> +++ b/arch/mips/generic/board-ingenic.c
> @@ -117,14 +117,14 @@ static void ingenic_halt(void)
>  		ingenic_wait_instr();
>  }
>  
> -static int __maybe_unused ingenic_pm_enter(suspend_state_t state)
> +static int ingenic_pm_enter(suspend_state_t state)
>  {
>  	ingenic_wait_instr();
>  
>  	return 0;
>  }
>  
> -static const struct platform_suspend_ops ingenic_pm_ops __maybe_unused = {
> +static const struct platform_suspend_ops ingenic_pm_ops = {
>  	.valid = suspend_valid_only_mem,
>  	.enter = ingenic_pm_enter,
>  };
> -- 
> 2.39.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
