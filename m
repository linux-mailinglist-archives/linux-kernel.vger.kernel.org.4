Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523A6032A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJRSiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJRSiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306489D535;
        Tue, 18 Oct 2022 11:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBE5616B3;
        Tue, 18 Oct 2022 18:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E577C43470;
        Tue, 18 Oct 2022 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666118294;
        bh=gvTaZypEgGGido85MgcyNS4DS7bHb03iQAm+R660AJM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h4X44UYm3ssdYIwEMDeIKB+A8Wu3y81H9L1q7UHCTRiH81BO6Fwyh+r3HRDXObFgM
         YSGuG344wbamHqscdLZNrOsnxltHOjZQ7S6KQ7aGvr+77Sk1f6DTK/KJuDVhiXWDva
         7e0PdZ+3qytT7OlWGb2x98uIkofmpQv/nuG9Uj7oTl1ND8JE2dgbTp2SQWMQ34J6Ix
         WGb34uKpa/YphSZF1jeeAt95+5oIxfZhgcXWOP9R2WYiK0FnK7F6TFyJHJedOBSsB/
         Ez3XK2Zt0lNEkhwjy3fU7pDNiypgxbckClGsac0TX9JtIf/7Sgw7deTkf4y671tGmt
         laVGf1xJGyiBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D16295C0990; Tue, 18 Oct 2022 11:38:13 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:38:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20221018183813.GW5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221018094152.39787a20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018094152.39787a20@canb.auug.org.au>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:41:52AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   arch/loongarch/Kconfig
> 
> between commit:
> 
>   c78c43fe7d42 ("LoongArch: Use acpi_arch_dma_setup() and remove ARCH_HAS_PHYS_TO_DMA")
> 
> from Linus' tree and commit:
> 
>   839fc1e464eb ("arch/loongarch: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option")
> 
> from the rcu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you, Stephen!

For whatever it is worth, this will go away once I test my rebase to v6.1.

							Thanx, Paul

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/loongarch/Kconfig
> index 903096bd87f8,c8864768dc4d..000000000000
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@@ -10,6 -10,8 +10,7 @@@ config LOONGARC
>   	select ARCH_ENABLE_MEMORY_HOTPLUG
>   	select ARCH_ENABLE_MEMORY_HOTREMOVE
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
> + 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  -	select ARCH_HAS_PHYS_TO_DMA
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_INLINE_READ_LOCK if !PREEMPTION


