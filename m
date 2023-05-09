Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882226FC503
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjEILah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjEILaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:30:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A3A26B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:30:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26707FEC;
        Tue,  9 May 2023 04:31:18 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69BFC3F67D;
        Tue,  9 May 2023 04:30:32 -0700 (PDT)
Date:   Tue, 9 May 2023 12:30:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM/arm64: Mark all accessor functions inline
Message-ID: <ZFou1SdT8SQaqpQu@FVFF77S0Q05N>
References: <cover.1683561087.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683561087.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 06:05:17PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds missing "inline" keywords to the few perf
> accessors that lack them.

Will, I assume that you'll pick these up as a cleanup/fix.

Thanks,
Mark.

> BTW, I tried converting my local timing code to the new unified system.
> This works fine on arm64, but broke on arm32.  Is read_pmccntr()
> supposed to work on arm32? I get an undefined instruction exception on
> Cortex A15 and A9.  Before, my custom code used "mrc p15, 0, %0, c9,
> c13, 0" (as is also used in arch/arm/kernel/perf_event_v7.c), for which
> there is no accessor yet.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (2):
>   ARM: perf: Mark all accessor functions inline
>   arm64: perf: Mark all accessor functions inline
> 
>  arch/arm/include/asm/arm_pmuv3.h   | 6 +++---
>  arch/arm64/include/asm/arm_pmuv3.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
