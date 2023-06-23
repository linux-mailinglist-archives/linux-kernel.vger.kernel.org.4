Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6121373B891
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjFWNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFWNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:16:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 880202683;
        Fri, 23 Jun 2023 06:16:40 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qCgeU-0002sj-00; Fri, 23 Jun 2023 15:16:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 180D8C02FD; Fri, 23 Jun 2023 15:08:57 +0200 (CEST)
Date:   Fri, 23 Jun 2023 15:08:57 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: ralink: match all supported system controller
 compatible strings
Message-ID: <20230623130856.GA11636@alpha.franken.de>
References: <TYAP286MB03151148AF8C054621DD55C3BC23A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB03151148AF8C054621DD55C3BC23A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:17:48AM +0800, Shiji Yang wrote:
> Recently, A new clock and reset controller driver has been introduced to
> the ralink mips target[1]. It provides proper system control and adds more
> SoC specific compatible strings. In order to better initialize CPUs, this
> patch removes the outdated "ralink,mt7620a-sysc" and add all dt-binding
> documented compatible strings to the system controller match table.
> 
> [1] https://lore.kernel.org/all/20230619040941.1340372-1-sergio.paracuellos@gmail.com/
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  arch/mips/ralink/of.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> index 53a2ae9ee..1c6c953d5 100644
> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -40,10 +40,15 @@ static const struct of_device_id mtmips_memc_match[] = {
>  
>  static const struct of_device_id mtmips_sysc_match[] = {
>  	{ .compatible = "mediatek,mt7621-sysc" },
> -	{ .compatible = "ralink,mt7620a-sysc" },
> +	{ .compatible = "ralink,mt7620-sysc" },
> +	{ .compatible = "ralink,mt7628-sysc" },
> +	{ .compatible = "ralink,mt7688-sysc" },
>  	{ .compatible = "ralink,rt2880-sysc" },
>  	{ .compatible = "ralink,rt3050-sysc" },
> +	{ .compatible = "ralink,rt3052-sysc" },
> +	{ .compatible = "ralink,rt3352-sysc" },
>  	{ .compatible = "ralink,rt3883-sysc" },
> +	{ .compatible = "ralink,rt5350-sysc" },
>  	{}
>  };
>  
> -- 
> 2.30.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
