Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651276DF74C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDLNe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjDLNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:34:17 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A00F83D7;
        Wed, 12 Apr 2023 06:33:39 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pmabN-0000FF-00; Wed, 12 Apr 2023 15:33:33 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4E6A6C2449; Wed, 12 Apr 2023 15:27:06 +0200 (CEST)
Date:   Wed, 12 Apr 2023 15:27:06 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] MIPS: Remove deprecated CONFIG_MIPS_CMP
Message-ID: <20230412132706.GA11717@alpha.franken.de>
References: <20230405185128.15237-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405185128.15237-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:51:27PM +0200, Thomas Bogendoerfer wrote:
> Commit 5cac93b35c14 ("MIPS: Deprecate CONFIG_MIPS_CMP") deprecated
> CONFIG_MIPS_CMP and after 9 years it's time to remove it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> Marc, if you prefer an extra patch for the irqchip change, I'll
> split this. Otherwise I would take it through the MIPS tree.
> 
>  arch/mips/Kconfig                    |  34 +----
>  arch/mips/include/asm/rtlx.h         |   1 -
>  arch/mips/include/asm/smp-ops.h      |  16 ---
>  arch/mips/include/asm/vpe.h          |   4 -
>  arch/mips/kernel/Makefile            |   3 -
>  arch/mips/kernel/rtlx-cmp.c          | 122 ------------------
>  arch/mips/kernel/smp-cmp.c           | 148 ----------------------
>  arch/mips/kernel/vpe-cmp.c           | 180 ---------------------------
>  arch/mips/kernel/vpe.c               |   2 +-
>  arch/mips/mti-malta/Makefile         |   2 -
>  arch/mips/mti-malta/malta-amon.c     |  88 -------------
>  arch/mips/mti-malta/malta-init.c     |   2 -
>  arch/mips/mti-malta/malta-platform.c |   2 -
>  arch/mips/ralink/mt7621.c            |   2 -
>  drivers/irqchip/irq-mips-gic.c       |  26 ----
>  15 files changed, 3 insertions(+), 629 deletions(-)
>  delete mode 100644 arch/mips/kernel/rtlx-cmp.c
>  delete mode 100644 arch/mips/kernel/smp-cmp.c
>  delete mode 100644 arch/mips/kernel/vpe-cmp.c
>  delete mode 100644 arch/mips/mti-malta/malta-amon.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
