Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1147688E05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjBCDcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBCDcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:32:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB146ACA0;
        Thu,  2 Feb 2023 19:32:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1FD8B81D79;
        Fri,  3 Feb 2023 03:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B4C433D2;
        Fri,  3 Feb 2023 03:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675395135;
        bh=tVLLWQkfnuhs07CaJsUvIHPfgCGpR0jx28Ktw9IQ+e0=;
        h=Date:From:To:Cc:Subject:From;
        b=etXq8oaVU9ZJCURm3jzZo8FjPu4KcpXlVB4LIatts01rnvu649/g2rzAcQ+s9sG/9
         kQ6wHgoBMsOrdLNrPDdmGxS1nheW70k8431K9YK8G2bzpskGvUCiZkcmVBQb52nYGh
         q4rJ6VJrtP8cPSKtLZiP++hTwZXaO4v06yfQiGxA=
Date:   Thu, 2 Feb 2023 19:32:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.2-rc7
Message-Id: <20230202193214.646203447dc16ea4c6b835a4@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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


Linus, please merge this batch of hotfixes, thanks.

The following changes since commit 49d6d7fb631345b0f2957a7c4be24ad63903150f:

  mm/uffd: fix pte marker when fork() without fork event (2023-01-18 17:02:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-02-19-24-2

for you to fetch changes up to ac86f547ca1002aec2ef66b9e64d03f45bbbfbb9:

  mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty_slowpath() (2023-01-31 16:44:10 -0800)

----------------------------------------------------------------
25 hotfixes, mainly for MM.  13 are cc:stable.

----------------------------------------------------------------
Eugen Hristev (1):
      .mailmap: update e-mail address for Eugen Hristev

Fedor Pchelkin (1):
      squashfs: harden sanity check in squashfs_read_xattr_id_table

Isaac J. Manjarres (1):
      Revert "mm: kmemleak: alloc gray object for reserved region with direct map"

James Morse (1):
      ia64: fix build error due to switch case label appearing next to declaration

Jann Horn (1):
      mm/khugepaged: fix ->anon_vma race

Kefeng Wang (1):
      mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty_slowpath()

Liam Howlett (1):
      maple_tree: fix mas_empty_area_rev() lower bound validation

Longlong Xia (1):
      mm/swapfile: add cond_resched() in get_swap_pages()

Matthew Wilcox (Oracle) (1):
      highmem: round down the address passed to kunmap_flush_on_unmap()

Michal Hocko (1):
      Revert "mm: add nodes= arg to memory.reclaim"

Mike Kravetz (2):
      mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
      migrate: hugetlb: check for hugetlb shared PMD in node migration

Nhat Pham (1):
      zsmalloc: fix a race with deferred_handles storing

Pengfei Xu (1):
      selftests/filesystems: grant executable permission to run_fat_tests.sh

Peter Xu (2):
      mm: fix a few rare cases of using swapin error pte marker
      selftests/vm: remove __USE_GNU in hugetlb-madvise.c

Phillip Lougher (1):
      Squashfs: fix handling and sanity checking of xattr_ids count

Randy Dunlap (1):
      freevxfs: Kconfig: fix spelling

Tom Saeger (1):
      sh: define RUNTIME_DISCARD_EXIT

Vlastimil Babka (1):
      mm, mremap: fix mremap() expanding for vma's with vm_ops->close()

Wei Yang (1):
      maple_tree: should get pivots boundary by type

Yu Zhao (1):
      mm: multi-gen LRU: fix crash during cgroup migration

Zach O'Keefe (1):
      mm/MADV_COLLAPSE: catch !none !huge !bad pmd lookups

Zhaoyang Huang (1):
      mm: use stack_depot_early_init for kmemleak

ye xingchen (1):
      Kconfig.debug: fix the help description in SCHED_DEBUG

 .mailmap                                           |   1 +
 Documentation/admin-guide/cgroup-v2.rst            |  15 +-
 arch/ia64/kernel/sys_ia64.c                        |   7 +-
 arch/sh/kernel/vmlinux.lds.S                       |   1 +
 drivers/of/fdt.c                                   |   6 +-
 fs/freevxfs/Kconfig                                |   2 +-
 fs/proc/task_mmu.c                                 |   4 +-
 fs/squashfs/squashfs_fs.h                          |   2 +-
 fs/squashfs/squashfs_fs_sb.h                       |   2 +-
 fs/squashfs/xattr.h                                |   4 +-
 fs/squashfs/xattr_id.c                             |   4 +-
 include/linux/highmem-internal.h                   |   4 +-
 include/linux/hugetlb.h                            |  13 ++
 include/linux/memcontrol.h                         |   5 +-
 include/linux/swap.h                               |   3 +-
 lib/Kconfig.debug                                  |   3 +-
 lib/maple_tree.c                                   |  22 +-
 lib/test_maple_tree.c                              |  89 ++++++++
 mm/hugetlb.c                                       |   3 +
 mm/khugepaged.c                                    |  22 +-
 mm/kmemleak.c                                      |   5 +-
 mm/memcontrol.c                                    |  67 ++----
 mm/memory.c                                        |   8 +-
 mm/mempolicy.c                                     |   3 +-
 mm/mprotect.c                                      |   8 +-
 mm/mremap.c                                        |  25 ++-
 mm/swapfile.c                                      |   1 +
 mm/vmscan.c                                        |   9 +-
 mm/zsmalloc.c                                      | 237 ++++++++++++++++++---
 .../selftests/filesystems/fat/run_fat_tests.sh     |   0
 tools/testing/selftests/vm/hugetlb-madvise.c       |   1 -
 31 files changed, 429 insertions(+), 147 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

