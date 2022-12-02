Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D076640FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiLBVZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiLBVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:25:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D1EDD50
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:25:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6129AB822BA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 21:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04DE9C433B5;
        Fri,  2 Dec 2022 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670016340;
        bh=ZSNmLjAEQTy4eBPjv6LPuyzN7BpFgsze+bz+aijm7bU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oC6oulAVFXlo1KgpkTuEdT1+fVqew0hfcsRBuD11uLPEgGslFSqLa1Lcvspf6KShu
         E/yaqnJD2OPc5alOucAYpYSS+HAh1ZFKG7DBoe0l8X0lNZdaar6uaUwIXGWYxDxg0R
         2WfmLW17eyDtca/Brnys7riUu4kNLf/SUPDk+LCmC7ZutwGPDu98fMJfVEqAgJzkhH
         HwUU+Y7t8Bgop284Rh9ySPm0yvf3aIpPCba1YOAVJZG92S4efKtXeFLLeUav6xhKiW
         vADjcBN5gDN3Q4c5q+6CdnviNoUak6wUclzP4DTsf4MToJwYFd73l4rQTBBMeOgKsM
         6hQ7BLpcPZsRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D74B4E21EEF;
        Fri,  2 Dec 2022 21:25:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next 0/2]riscv/mm: two modifications on hugepage
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167001633987.19139.13919979874169762631.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Dec 2022 21:25:39 +0000
References: <20221024094725.3054311-1-tongtiangen@huawei.com>
In-Reply-To: <20221024094725.3054311-1-tongtiangen@huawei.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Oct 2022 09:47:23 +0000 you wrote:
> Tong Tiangen (2):
>   riscv/mm: hugepage's PG_dcache_clean flag is only set in head page
>   riscv/mm: add arch hook arch_clear_hugepage_flags
> 
>  arch/riscv/include/asm/cacheflush.h | 7 +++++++
>  arch/riscv/include/asm/hugetlb.h    | 6 ++++++
>  arch/riscv/mm/cacheflush.c          | 7 +++++++
>  3 files changed, 20 insertions(+)

Here is the summary with links:
  - [-next,1/2] riscv/mm: hugepage's PG_dcache_clean flag is only set in head page
    https://git.kernel.org/riscv/c/d33deda095d3
  - [-next,2/2] riscv/mm: add arch hook arch_clear_hugepage_flags
    https://git.kernel.org/riscv/c/d8bf77a1dc30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


