Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65996D76DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjDEI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjDEI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:29:00 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E12B24C2B;
        Wed,  5 Apr 2023 01:28:53 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pjyVe-0007pG-02; Wed, 05 Apr 2023 10:28:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id DFD7AC2160; Wed,  5 Apr 2023 10:26:54 +0200 (CEST)
Date:   Wed, 5 Apr 2023 10:26:54 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: remove unused function declaration
Message-ID: <20230405082654.GC5556@alpha.franken.de>
References: <20230329210328.9320-1-olek2@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329210328.9320-1-olek2@wp.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:03:28PM +0200, Aleksander Jan Bajkowski wrote:
> The removed function declaration is a leftover of the old gphy firmware
> loader, that has been removed in d5103604f78e1afc29e586785af540c82b573f3a.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> index 4790cfa190d6..c2e0acb755cd 100644
> --- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> +++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> @@ -94,9 +94,6 @@ extern __iomem void *ltq_cgu_membase;
>  #define LTQ_MPS_BASE_ADDR	(KSEG1 + 0x1F107000)
>  #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
>  
> -/* allow booting xrx200 phys */
> -int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr);
> -
>  /* request a non-gpio and set the PIO config */
>  #define PMU_PPE			 BIT(13)
>  extern void ltq_pmu_enable(unsigned int module);
> -- 
> 2.30.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
