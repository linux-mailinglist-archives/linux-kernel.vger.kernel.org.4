Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AC6A4F02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjB0W4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjB0W4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:56:11 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9368421287;
        Mon, 27 Feb 2023 14:56:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pWmPg-0007zQ-04; Mon, 27 Feb 2023 23:56:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B5DE8C0F89; Mon, 27 Feb 2023 23:55:48 +0100 (CET)
Date:   Mon, 27 Feb 2023 23:55:48 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     arinc9.unal@gmail.com
Cc:     John Crispin <john@phrozen.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH 2/2] mips: ralink: make SOC_MT7621 select PINCTRL
Message-ID: <20230227225548.GD23071@alpha.franken.de>
References: <20230221092435.22069-1-arinc.unal@arinc9.com>
 <20230221092435.22069-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221092435.22069-2-arinc.unal@arinc9.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 12:24:35PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Currently, out of every Ralink SoC, only the dt-binding of the MT7621 SoC
> uses pinctrl. Because of this, PINCTRL is not selected at all. Make
> SOC_MT7621 select PINCTRL.
> 
> Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handled under
> the PINCTRL_MT7621 option.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/ralink/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index 06031796c87b..83e61e147b90 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -54,7 +54,7 @@ choice
>  		select HAVE_PCI
>  		select PCI_DRIVERS_GENERIC
>  		select SOC_BUS
> -		select PINCTRL_MT7621
> +		select PINCTRL
>  
>  		help
>  		  The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc
> -- 
> 2.37.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
