Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7B606EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJUEdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJUEda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB61DE3CB;
        Thu, 20 Oct 2022 21:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF05E61D7E;
        Fri, 21 Oct 2022 04:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC4CC433B5;
        Fri, 21 Oct 2022 04:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666326808;
        bh=Td7AO4EDjyUFfeBl6K7bjH5WSGUekWP88tr/29ohcj8=;
        h=Date:From:To:Cc:Subject:From;
        b=CXXwnXMpDuMrfD8wNttALqf4i2hXGdQ95Kd7vsL8TO6kX1YfHQushLwQdLhi8EyK4
         /g02r9Y6zvVasUS7XX0hBAvbnlailrF94ZpERKJG8Mno6+B3D0OsLJHVk26TpKbxuF
         ZYK21CCXCfmaH1zCa+fx1vQG/9N2pPpFyyOvyTl8=
Date:   Thu, 20 Oct 2022 21:33:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1-rc2
Message-Id: <20221020213327.2c284af5925b6a8ed915fe9e@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-10-20

for you to fetch changes up to 97061d441110528dc02972818f2f1dad485107f9:

  nouveau: fix migrate_to_ram() for faulting page (2022-10-20 21:27:24 -0700)

----------------------------------------------------------------
17 hotfixes, mainly for MM.  5 are cc:stable and the remainder address
post-6.0 issues.

----------------------------------------------------------------
Alexey Romanov (1):
      zsmalloc: zs_destroy_pool: add size_class NULL check

Alistair Popple (1):
      nouveau: fix migrate_to_ram() for faulting page

Andrew Morton (3):
      Merge branch 'master' into mm-hotfixes-stable
      Merge branch 'master' into mm-hotfixes-stable
      mm/mmap.c: __vma_adjust(): suppress uninitialized var warning

Colin Ian King (1):
      init: Kconfig: fix spelling mistake "satify" -> "satisfy"

Dan Carpenter (1):
      mailmap: update Dan Carpenter's email address

Hugh Dickins (1):
      mm: /proc/pid/smaps_rollup: fix maple tree search

Joseph Qi (2):
      ocfs2: fix BUG when iput after ocfs2_mknod fails
      ocfs2: clear dinode links count in case of error

Liam Howlett (2):
      mm/mempolicy: fix mbind_range() arguments to vma_merge()
      mm/mmap: fix MAP_FIXED address return on VMA merge

Liam R. Howlett (1):
      mm/page_alloc: reduce potential fragmentation in make_alloc_exact()

Martin Liska (1):
      gcov: support GCC 12.1 and newer compilers

Mel Gorman (1):
      mm/huge_memory: do not clobber swp_entry_t during THP split

Mike Kravetz (2):
      mm/mmap: undo ->mmap() when mas_preallocate() fails
      hugetlb: fix memory leak associated with vma_lock structure

Qais Yousef (1):
      mailmap: update email for Qais Yousef

Rik van Riel (1):
      mm,hugetlb: take hugetlb_lock before decrementing h->resv_huge_pages

 .mailmap                               |  4 +++-
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  1 +
 fs/ocfs2/namei.c                       | 23 ++++++++++-----------
 fs/proc/task_mmu.c                     |  2 +-
 init/Kconfig                           |  2 +-
 kernel/gcov/gcc_4_7.c                  | 18 +++++++++++++++--
 mm/huge_memory.c                       | 11 +++++++++-
 mm/hugetlb.c                           | 37 +++++++++++++++++++++++++---------
 mm/mempolicy.c                         | 17 ++++++++++------
 mm/mmap.c                              | 20 +++++++++---------
 mm/page_alloc.c                        | 20 ++++++++++--------
 mm/zsmalloc.c                          |  3 +++
 12 files changed, 107 insertions(+), 51 deletions(-)

