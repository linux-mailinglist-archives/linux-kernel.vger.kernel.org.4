Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D726383F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKYGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYGUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:20:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E4240B1;
        Thu, 24 Nov 2022 22:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C2D5B8296C;
        Fri, 25 Nov 2022 06:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD7C433C1;
        Fri, 25 Nov 2022 06:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669357198;
        bh=lwUIOPkS2nkRiCcVVbf1phCqilu19fGrO7QVgbS+Ag4=;
        h=Date:From:To:Cc:Subject:From;
        b=T54rKLt0/2gVIlmTERS2EZn18vBFPN2fa5qi0m4X7O/o+lCsI24sg9t1ZWF3tGWrr
         Au/C4JZ8Wad2ceRONb3TYvuNtbABuhXnJLLOWs6XVrifeekALWKAWXoOyuZzKXykca
         bDWsbkxH2esaH0nZ930TaaIsWed3SAHbUkuZzkKk=
Date:   Thu, 24 Nov 2022 22:19:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1-rc7
Message-Id: <20221124221957.e1237518cd877725e5e7f698@linux-foundation.org>
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


Linus, please merge this batch of MM and non-MM hotfixes.

Thanks.


The following changes since commit 436fa4a699bcd1c368bea9199e22b0a1b9cf9e0f:

  docs: kmsan: fix formatting of "Example report" (2022-11-08 15:57:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-11-24

for you to fetch changes up to de3db3f883a82c4800f4af0ae2cc3b96a408ee9b:

  test_kprobes: fix implicit declaration error of test_kprobes (2022-11-22 18:50:45 -0800)

----------------------------------------------------------------
24 hotfixes.  8 marked cc:stable and 16 for post-6.0 issues.

There have been a lot of hotfixes this cycle, and this is quite a large
batch given how far we are into the -rc cycle.  Presumably a reflection of
the unusually large amount of MM material which went into 6.1-rc1.

----------------------------------------------------------------
Alex Hung (2):
      mailmap: update Alex Hung's email address
      MAINTAINERS: update Alex Hung's email address

Alistair Popple (2):
      mm/memory: return vm_fault_t result from migrate_to_ram() callback
      mm/migrate_device: return number of migrating pages in args->cpages

Aneesh Kumar K.V (1):
      mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1

Charan Teja Kalla (1):
      mm/page_exit: fix kernel doc warning in page_ext_put()

Chen Wandun (1):
      swapfile: fix soft lockup in scan_swap_map_slots

Chen Zhongjin (1):
      nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty

Gautam Menghani (1):
      mm/khugepaged: refactor mm_khugepaged_scan_file tracepoint to remove filename from function call

Ian Cowan (1):
      mm: mmap: fix documentation for vma_mas_szero

Johannes Weiner (1):
      mm: vmscan: fix extreme overreclaim and swap floods

Li Hua (1):
      test_kprobes: fix implicit declaration error of test_kprobes

Li Liguang (1):
      mm: correctly charge compressed memory to its memcg

Marco Elver (1):
      kfence: fix stack trace pruning

Mike Kravetz (2):
      ipc/shm: call underlying open/close vm_ops
      hugetlb: fix __prep_compound_gigantic_page page flag setting

Mukesh Ojha (1):
      gcov: clang: fix the buffer overflow issue

Qi Zheng (1):
      mm: fix unexpected changes to {failslab|fail_page_alloc}.attr

Sam James (1):
      kbuild: fix -Wimplicit-function-declaration in license_is_gpl_compatible

Satya Priya (1):
      mailmap: update email address for Satya Priya

SeongJae Park (1):
      mm/damon/sysfs-schemes: skip stats update if the scheme directory is removed

Yang Shi (1):
      mm: khugepaged: allow page allocation fallback to eligible nodes

Yosry Ahmed (1):
      proc/meminfo: fix spacing in SecPageTables

Yu Zhao (1):
      mm: multi-gen LRU: retry folios written back while isolated

 .mailmap                           |  2 ++
 MAINTAINERS                        |  2 +-
 fs/nilfs2/sufile.c                 |  8 +++++
 fs/proc/meminfo.c                  |  2 +-
 include/linux/fault-inject.h       |  7 ++--
 include/linux/license.h            |  2 ++
 include/trace/events/huge_memory.h |  8 ++---
 ipc/shm.c                          | 34 +++++++++++++-----
 kernel/gcov/clang.c                |  2 ++
 lib/Kconfig.debug                  |  1 +
 lib/fault-inject.c                 | 13 ++++---
 mm/damon/sysfs.c                   |  4 +++
 mm/failslab.c                      | 12 +++++--
 mm/hugetlb.c                       |  4 ++-
 mm/kfence/report.c                 | 13 ++++---
 mm/khugepaged.c                    | 35 ++++++++----------
 mm/memcontrol.c                    |  2 +-
 mm/memory.c                        |  2 +-
 mm/migrate_device.c                |  8 +++--
 mm/mmap.c                          |  2 +-
 mm/page_alloc.c                    |  7 ++--
 mm/page_ext.c                      |  2 +-
 mm/swapfile.c                      |  8 ++---
 mm/vmscan.c                        | 72 ++++++++++++++++++++++++++++----------
 24 files changed, 173 insertions(+), 79 deletions(-)

