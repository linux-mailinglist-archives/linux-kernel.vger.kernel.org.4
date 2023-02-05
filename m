Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C468B0EA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBEQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBEQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:19:45 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C3A65A4;
        Sun,  5 Feb 2023 08:19:43 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pOhjy-0000RS-00; Sun, 05 Feb 2023 17:19:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2A8C2C2638; Sun,  5 Feb 2023 17:02:22 +0100 (CET)
Date:   Sun, 5 Feb 2023 17:02:22 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     arinc9.unal@gmail.com
Cc:     John Crispin <john@phrozen.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH] mips: ralink: make SOC_MT7621 select PINCTRL_MT7621 and
 fix help section
Message-ID: <20230205160222.GA4459@alpha.franken.de>
References: <20230204214249.134937-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230204214249.134937-1-arinc.unal@arinc9.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 12:42:49AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The dt-binding of the MT7621 SoC uses the pinctrl driver. Therefore, have
> this driver selected by default.
> 
> The help section for SOC_MT7621 exceeds 80 columns which is the preferred
> limit of a single line. A tab character is 8 columns. Rearrange the text
> accordingly.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/ralink/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index f9fe15630abb..06031796c87b 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -54,10 +54,11 @@ choice
>  		select HAVE_PCI
>  		select PCI_DRIVERS_GENERIC
>  		select SOC_BUS
> +		select PINCTRL_MT7621
>  
>  		help
> -		  The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc dual-core CPU,
> -		  a 5-port 10/100/1000 switch/PHY and one RGMII.
> +		  The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc
> +		  dual-core CPU, a 5-port 10/100/1000 switch/PHY and one RGMII.
>  endchoice
>  
>  choice
> -- 
> 2.37.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
