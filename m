Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429AF66D331
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjAPXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjAPXdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:33:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414D1F4B8;
        Mon, 16 Jan 2023 15:27:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB84361181;
        Mon, 16 Jan 2023 23:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4742C433D2;
        Mon, 16 Jan 2023 23:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673911633;
        bh=V632Bd28v2EMXk0Fei3rjmAUh17bwMYhoHo8d1S5aSQ=;
        h=Date:From:To:Cc:Subject:From;
        b=MtojZflews1UjvQBHqIM/JsLiZym7kdv1szmh31jd1ofKm+uz7uUqQFX0G6M/2UZ6
         MihBwRnpCuHRPl74BLCEH4XxHc2Qb2AcSOZadjYkUZD3KjEXnKO5KWHRM0DT28q1MZ
         3FyJWmi2jm9Gm+yi4RNnIN2ngEeeB4pZ+pXwP8FI=
Date:   Mon, 16 Jan 2023 15:27:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.2-rc5
Message-Id: <20230116152712.612b60d26b497d1d5749f4dc@linux-foundation.org>
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


Linus,

please merge this batch of hotfixes.  As usual, mostly MM things with a
handful of non-MM material.

Thanks.


The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-01-16-15-23

for you to fetch changes up to 19fa92fb72f8bc542f1673862058f3b078114004:

  init/Kconfig: fix typo (usafe -> unsafe) (2023-01-11 16:14:23 -0800)

----------------------------------------------------------------
21 hotfixes.  Thirteen of these address pre-6.1 issues and hence have
the cc:stable tag.

----------------------------------------------------------------
Alexey Dobriyan (1):
      proc: fix PIE proc-empty-vm, proc-pid-vm tests

Andrey Konovalov (1):
      kasan: mark kasan_kunit_executing as static

David Hildenbrand (3):
      mm/hugetlb: fix PTE marker handling in hugetlb_change_protection()
      mm/hugetlb: fix uffd-wp handling for migration entries in hugetlb_change_protection()
      mm/userfaultfd: enable writenotify while userfaultfd-wp is enabled for a VMA

Hugh Dickins (1):
      mm/khugepaged: fix collapse_pte_mapped_thp() to allow anon_vma

James Houghton (1):
      hugetlb: unshare some PMDs when splitting VMAs

Liam Howlett (3):
      nommu: fix memory leak in do_mmap() error path
      nommu: fix do_munmap() error path
      nommu: fix split_vma() map_count error

Lizzy Fleckenstein (1):
      init/Kconfig: fix typo (usafe -> unsafe)

Lorenzo Stoakes (1):
      mm: update mmap_sem comments to refer to mmap_lock

Nhat Pham (1):
      Docs/admin-guide/mm/zswap: remove zsmalloc's lack of writeback warning

Peter Xu (1):
      mm/hugetlb: pre-allocate pgtable pages for uffd wr-protects

Randy Dunlap (1):
      lib/win_minmax: use /* notation for regular comments

Robert Foss (1):
      MAINTAINERS: update Robert Foss' email address

Ryusuke Konishi (1):
      nilfs2: fix general protection fault in nilfs_btree_insert()

SeongJae Park (1):
      include/linux/mm: fix release_pages_arg kernel doc comment

Suren Baghdasaryan (1):
      mm: fix vma->anon_name memory leak for anonymous shmem VMAs

Zach O'Keefe (2):
      mm/MADV_COLLAPSE: don't expand collapse when vm_end is past requested end
      mm/shmem: restore SHMEM_HUGE_DENY precedence over MADV_COLLAPSE

 .mailmap                                     |  1 +
 Documentation/admin-guide/mm/zswap.rst       |  4 +-
 MAINTAINERS                                  |  6 +-
 fs/nilfs2/btree.c                            | 15 ++++-
 fs/userfaultfd.c                             | 28 ++++++--
 include/linux/mm.h                           |  6 +-
 include/linux/mm_inline.h                    |  3 +-
 include/linux/mm_types.h                     |  2 +-
 include/linux/page_ref.h                     |  2 +-
 init/Kconfig                                 |  2 +-
 lib/win_minmax.c                             |  2 +-
 mm/hugetlb.c                                 | 99 ++++++++++++++++++----------
 mm/kasan/report.c                            |  2 +-
 mm/khugepaged.c                              | 16 ++---
 mm/madvise.c                                 |  2 +-
 mm/mmap.c                                    |  8 ++-
 mm/nommu.c                                   |  9 ++-
 mm/shmem.c                                   |  6 +-
 tools/testing/selftests/proc/proc-empty-vm.c | 12 ++--
 tools/testing/selftests/proc/proc-pid-vm.c   |  9 +--
 20 files changed, 146 insertions(+), 88 deletions(-)

