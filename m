Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0209E6A6101
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjB1VLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB1VLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:11:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786A2B2B1;
        Tue, 28 Feb 2023 13:11:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 251AC611D6;
        Tue, 28 Feb 2023 21:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67CEDC4339C;
        Tue, 28 Feb 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677618677;
        bh=hQNwE+IEUbKQvI91yvljJosaVP7JCZ7+8bppV3cOFbg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EWCQE/HQjrWuM9JLi5n8h88COIVDC0Dwj8Ls7hxDeYr4SIALkO/qqCk/UGcAvWK5o
         c02+sh/QcUi/6bE0ILdbEb/C+A8GV+CJaLo8WfaGxJWgLFvkSK7vL/E7uokCa4MOxg
         ngdg3jXiJrkGUm98gEQXAgu/dxa50c+7WgMlmDgNw1PpnJ2oFrWoeU4ingGh4tZ7R7
         NCLLPqaZ1Zn4rnovGjIPX8BlJ6CPAfDs1vwTGYqI9oMCtgbAk9Bh8oF1Q3q6KxteX4
         j5u6Jm2tA55Z1q6NEJRkgLy4vCcaaRiYhIH8qBVhYl9/Ucn2GR4gvjnvRg/iSe5UV4
         UdVCGz5UeLKDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FB70C691DE;
        Tue, 28 Feb 2023 21:11:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH mm-unstable v1 00/26] mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167761867725.10135.3611718470427113262.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 21:11:17 +0000
References: <20230113171026.582290-1-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hughd@google.com, jhubbard@nvidia.com,
        jgg@nvidia.com, rppt@linux.ibm.com, shy828301@gmail.com,
        vbabka@suse.cz, namit@vmware.com, aarcange@redhat.com,
        peterx@redhat.com, linux-mm@kvack.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, aou@eecs.berkeley.edu,
        anton.ivanov@cambridgegreys.com, bp@alien8.de, bcain@quicinc.com,
        christophe.leroy@csgroup.eu, chris@zankel.net,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        dinguyen@kernel.org, geert@linux-m68k.org, gerg@linux-m68k.org,
        guoren@kernel.org, deller@gmx.de, hpa@zytor.com,
        chenhuacai@kernel.org, mingo@redhat.com, ink@jurassic.park.msu.ru,
        James.Bottomley@HansenPartnership.com, johannes@sipsolutions.net,
        mattst88@gmail.com, jcmvbkbc@gmail.com, mpe@ellerman.id.au,
        monstr@monstr.eu, npiggin@gmail.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, richard.henderson@linaro.org,
        richard@nod.at, dalias@libc.org, linux@armlinux.org.uk,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, tglx@linutronix.de, vgupta@kernel.org,
        kernel@xen0n.name, ysato@users.sourceforge.jp
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 13 Jan 2023 18:10:00 +0100 you wrote:
> This is the follow-up on [1]:
> 	[PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
> 	anonymous pages
> 
> After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
> enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
> remaining architectures that support swap PTEs.
> 
> [...]

Here is the summary with links:
  - [mm-unstable,v1,01/26] mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
    (no matching commit)
  - [mm-unstable,v1,02/26] alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,03/26] arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,04/26] arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,05/26] csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,06/26] hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,07/26] ia64/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,08/26] loongarch/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,09/26] m68k/mm: remove dummy __swp definitions for nommu
    (no matching commit)
  - [mm-unstable,v1,10/26] m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,11/26] microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,12/26] mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,13/26] nios2/mm: refactor swap PTE layout
    (no matching commit)
  - [mm-unstable,v1,14/26] nios2/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,15/26] openrisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,16/26] parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,17/26] powerpc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
    (no matching commit)
  - [mm-unstable,v1,18/26] powerpc/nohash/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,19/26] riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    https://git.kernel.org/riscv/c/51a1007d4113
  - [mm-unstable,v1,20/26] sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,21/26] sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit
    (no matching commit)
  - [mm-unstable,v1,22/26] sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
    (no matching commit)
  - [mm-unstable,v1,23/26] um/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,24/26] x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
    (no matching commit)
  - [mm-unstable,v1,25/26] xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)
  - [mm-unstable,v1,26/26] mm: remove __HAVE_ARCH_PTE_SWP_EXCLUSIVE
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


