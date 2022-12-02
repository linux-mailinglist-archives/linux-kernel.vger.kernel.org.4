Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655F640E68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiLBT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiLBT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:26:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF6F289F;
        Fri,  2 Dec 2022 11:26:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F76D61F62;
        Fri,  2 Dec 2022 19:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35CBC433D6;
        Fri,  2 Dec 2022 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670009174;
        bh=O94/OVdITJEtr41IfdX7mAn/HaelBJH8JZrU17U7wxc=;
        h=Date:From:To:Cc:Subject:From;
        b=RDZ3Kv0eirxehIxqmK/Qq/StIOKaZSi/mwqg/GJFtKHer0H3gIRXOkNqfI8Z2qjNg
         d9uqkKuOSD3Oo3ZL1Ui11GnSh7obwnXuxdBZLAhKY0b2F19ErmWXL1NiRMWIZr8Xe6
         MfxsS9ZLNuWdDdLFi9r952aml4Wt6XuVTbxdBzFE=
Date:   Fri, 2 Dec 2022 11:26:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1-rc8
Message-Id: <20221202112613.17a04cff94882b1cd0e9ed4e@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge up this batch of fixes, thanks.

The following changes since commit de3db3f883a82c4800f4af0ae2cc3b96a408ee9b:

  test_kprobes: fix implicit declaration error of test_kprobes (2022-11-22 18:50:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-02

for you to fetch changes up to 1d351f1894342c378b96bb9ed89f8debb1e24e9f:

  revert "kbuild: fix -Wimplicit-function-declaration in license_is_gpl_compatible" (2022-11-30 14:49:42 -0800)

----------------------------------------------------------------
15 hotfixes.  11 marked cc:stable.  Only three or four of the latter
address post-6.0 issues, which is hopefully a sign that things are
converging.

----------------------------------------------------------------
Andrew Morton (1):
      revert "kbuild: fix -Wimplicit-function-declaration in license_is_gpl_compatible"

Gavin Shan (1):
      mm: migrate: fix THP's mapcount on isolation

Jann Horn (3):
      mm/khugepaged: take the right locks for page table retraction
      mm/khugepaged: fix GUP-fast interaction by sending IPI
      mm/khugepaged: invoke MMU notifiers in shmem/file collapse paths

Juergen Gross (2):
      mm: add dummy pmd_young() for architectures not having it
      mm: introduce arch_has_hw_nonleaf_pmd_young()

Lee Jones (2):
      drm/amdgpu: temporarily disable broken Clang builds due to blown stack-frame
      Kconfig.debug: provide a little extra FRAME_WARN leeway when KASAN is enabled

Mike Kravetz (2):
      madvise: use zap_page_range_single for madvise dontneed
      hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing

SeongJae Park (1):
      mm/damon/sysfs: fix wrong empty schemes assumption under online tuning in damon_sysfs_set_schemes()

Tiezhu Yang (1):
      tools/vm/slabinfo-gnuplot: use "grep -E" instead of "egrep"

Yang Shi (1):
      mm: replace VM_WARN_ON to pr_warn if the node is offline with __GFP_THISNODE

ZhangPeng (1):
      nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()

 arch/loongarch/include/asm/pgtable.h |  1 +
 arch/mips/include/asm/pgtable.h      |  1 +
 arch/riscv/include/asm/pgtable.h     |  1 +
 arch/s390/include/asm/pgtable.h      |  1 +
 arch/sparc/include/asm/pgtable_64.h  |  1 +
 arch/x86/include/asm/pgtable.h       |  9 ++++++
 drivers/gpu/drm/amd/display/Kconfig  |  7 ++++
 fs/nilfs2/dat.c                      |  7 ++++
 include/asm-generic/tlb.h            |  4 +++
 include/linux/gfp.h                  | 18 +++++++++--
 include/linux/license.h              |  2 --
 include/linux/mm.h                   | 29 ++++++++++++-----
 include/linux/pgtable.h              | 18 +++++++++++
 lib/Kconfig.debug                    |  1 +
 mm/compaction.c                      | 22 ++++++-------
 mm/damon/sysfs.c                     | 46 ++++++++++++++++++++++++--
 mm/hugetlb.c                         | 27 +++++++++-------
 mm/khugepaged.c                      | 62 +++++++++++++++++++++++++++++++++---
 mm/madvise.c                         |  6 ++--
 mm/memory.c                          | 25 +++++++--------
 mm/mmu_gather.c                      |  4 +--
 mm/vmscan.c                          | 10 +++---
 tools/vm/slabinfo-gnuplot.sh         |  4 +--
 23 files changed, 240 insertions(+), 66 deletions(-)

