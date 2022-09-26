Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3205EB169
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIZTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIZThZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270686CF64;
        Mon, 26 Sep 2022 12:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B812660A1A;
        Mon, 26 Sep 2022 19:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935DAC433D6;
        Mon, 26 Sep 2022 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664221044;
        bh=DFdmVNq4koq8KDXiELVv7wxAp32Ip7ewGkU3OOQRus8=;
        h=Date:From:To:Cc:Subject:From;
        b=15koPrK7MKoh7W6MjLRtyhEdDmvGP9FSuUw2WqBW5zeIXfJcmm9LViuH+HFqeBBAF
         X44KispDWdtyoz4noBDpxpNH/wQ82l6xBkh6BQT4bHgoLXAyPlhCBweh0/ydD/nvLj
         6fOWvJWKgwLfcTbQhKwdKRdZyVZwSYNK/uY1TZXA=
Date:   Mon, 26 Sep 2022 12:37:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.0[-rc8]
Message-Id: <20220926123721.2a1edc734b4fc516a9a350b8@linux-foundation.org>
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


Linus, please pull what is hopefully the second last batch of hotfixes
for this cycle.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-09-26

for you to fetch changes up to 59298997df89e19aad426d4ae0a7e5037074da5a:

  x86/uaccess: avoid check_object_size() in copy_from_user_nmi() (2022-09-26 12:14:35 -0700)

----------------------------------------------------------------
26 hotfixes.  8 are for issues which were introduced during this -rc
cycle, 18 are for earlier issues, and are cc:stable.

----------------------------------------------------------------
Alistair Popple (3):
      mm/migrate_device.c: flush TLB while holding PTL
      mm/migrate_device.c: add missing flush_cache_page()
      mm/migrate_device.c: copy pte dirty bit to page

Binyi Han (1):
      mm: fix dereferencing possible ERR_PTR

ChenXiaoSong (1):
      ntfs: fix BUG_ON in ntfs_lookup_inode_by_name()

Christoph Hellwig (1):
      frontswap: don't call ->init if no ops are registered

Dan Williams (4):
      xfs: quiet notify_failure EOPNOTSUPP cases
      xfs: fix SB_BORN check in xfs_dax_notify_failure()
      mm/memory-failure: fix detection of memory_failure() handlers
      mm/memory-failure: fall back to vma_address() when ->notify_failure() fails

Doug Berger (1):
      mm/hugetlb: correct demote page offset logic

Greg Kroah-Hartman (1):
      mm/damon/dbgfs: fix memory leak when using debugfs_lookup()

Kees Cook (1):
      x86/uaccess: avoid check_object_size() in copy_from_user_nmi()

Matthew Wilcox (Oracle) (3):
      tools: fix compilation after gfp_types.h split
      mm: fix VM_BUG_ON in __delete_from_swap_cache()
      vmscan: check folio_test_private(), not folio_get_private()

Maurizio Lombardi (1):
      mm: prevent page_frag_alloc() from corrupting the memory

Mel Gorman (1):
      mm/page_alloc: fix race condition between build_all_zonelists and page allocation

Minchan Kim (1):
      mm: fix madivse_pageout mishandling on non-LRU page

Naohiro Aota (1):
      x86/mm: disable instrumentations of mm/pgprot.c

Naoya Horiguchi (1):
      mm/huge_memory: use pfn_to_online_page() in split_huge_pages_all()

Sergei Antonov (1):
      mm: bring back update_mmu_cache() to finish_fault()

Shuai Xue (1):
      mm,hwpoison: check mm when killing accessing process

Yang Shi (2):
      mm: gup: fix the fast GUP race against THP collapse
      powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush

Zi Yan (1):
      mm/page_isolation: fix isolate_single_pageblock() isolation behavior

 arch/powerpc/mm/book3s64/radix_pgtable.c |  9 -----
 arch/x86/lib/usercopy.c                  |  2 +-
 arch/x86/mm/Makefile                     |  3 ++
 fs/ntfs/super.c                          |  3 +-
 fs/xfs/xfs_notify_failure.c              |  6 +--
 include/linux/memremap.h                 |  5 +++
 mm/damon/dbgfs.c                         | 19 +++++++---
 mm/frontswap.c                           |  3 ++
 mm/gup.c                                 | 34 ++++++++++++++---
 mm/huge_memory.c                         |  6 +--
 mm/hugetlb.c                             | 14 ++++---
 mm/khugepaged.c                          | 10 +++--
 mm/madvise.c                             |  7 +++-
 mm/memory-failure.c                      | 27 +++++++------
 mm/memory.c                              | 14 +++++--
 mm/migrate_device.c                      | 16 +++++---
 mm/page_alloc.c                          | 65 +++++++++++++++++++++++++++-----
 mm/page_isolation.c                      | 25 ++++++------
 mm/secretmem.c                           |  2 +-
 mm/swap_state.c                          |  2 +-
 mm/vmscan.c                              |  4 +-
 tools/include/linux/gfp.h                | 21 +----------
 tools/include/linux/gfp_types.h          |  1 +
 23 files changed, 192 insertions(+), 106 deletions(-)
 create mode 100644 tools/include/linux/gfp_types.h

