Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788776A4F04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjB0W4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjB0W4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:56:11 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 935E82006E;
        Mon, 27 Feb 2023 14:56:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pWmPg-0007zQ-03; Mon, 27 Feb 2023 23:56:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 372F5C0F89; Mon, 27 Feb 2023 23:55:37 +0100 (CET)
Date:   Mon, 27 Feb 2023 23:55:37 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     arinc9.unal@gmail.com
Cc:     John Crispin <john@phrozen.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH 1/2] mips: remove SYS_HAS_CPU_MIPS32_R1 from RALINK
Message-ID: <20230227225537.GC23071@alpha.franken.de>
References: <20230221092435.22069-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221092435.22069-1-arinc.unal@arinc9.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 12:24:34PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> All MIPS processors on the Ralink SoCs implement the MIPS32 Release 2
> Architecture. Remove SYS_HAS_CPU_MIPS32_R1.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> 
> The RT2880 SoC is MIPS 4KEc, the remaining SoCs are MIPS 24KEc. All of
> which implement the MIPS32 Release 2 Architecture, if I understand
> correctly. My incentive for this is to automatically have MIPS32R2 selected
> as the CPU type.
> 
> ---
>  arch/mips/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 37072e15b263..0e8dab9a57de 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -610,7 +610,6 @@ config RALINK
>  	select DMA_NONCOHERENT
>  	select IRQ_MIPS_CPU
>  	select USE_OF
> -	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_HAS_CPU_MIPS32_R2
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> -- 
> 2.37.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
