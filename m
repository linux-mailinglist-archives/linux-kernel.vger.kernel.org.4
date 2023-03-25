Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725866C8986
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCYAQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYAQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:16:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1521B335;
        Fri, 24 Mar 2023 17:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9904DB8265B;
        Sat, 25 Mar 2023 00:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1673CC433D2;
        Sat, 25 Mar 2023 00:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679703358;
        bh=BW8SQr2zzqi7ZboMY2ElZDz0/thF7NPYW/14LLI73Uc=;
        h=Date:From:To:Cc:Subject:From;
        b=raZ6uaVNUnEs5m40Le/bHMB0dCXnyL/y97MyZ/FqtjvecBbieHLceOHNe5BEQR5yg
         6A4dDiMEMrcAfFi6wMTrHQdQQE8Q+YLHOq3AINtfI8Hula6VT8pm6zd1Kb296XgbvW
         gQuX+FOS1T10Vl7I4URKBFh2VTLSiApFDbIV6HtU=
Date:   Fri, 24 Mar 2023 17:15:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] more hotfixes for 6.3-rc4
Message-Id: <20230324171557.a80213794c8101d0561d9e3e@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of fixups, thanks.


The following changes since commit 1e760fa3596e8c7f08412712c168288b79670d78:

  Merge tag 'gfs2-v6.3-rc3-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-03-23 15:25:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-24-17-09

for you to fetch changes up to d0072ca529674c36421023ffe90837a7de9387f3:

  mm: mmap: remove newline at the end of the trace (2023-03-23 17:18:36 -0700)

----------------------------------------------------------------
21 hotfixes, 8 of which are cc:stable.  11 are for MM, the remainder are
for other subsystems.

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      mailmap: add entry for Enric Balletbo i Serra

Geert Uytterhoeven (1):
      lib: dhry: fix unstable smp_processor_id(_) usage

Joey Gouly (2):
      mm: deduplicate error handling for map_deny_write_exec
      mm: fix error handling for map_deny_write_exec

Konrad Dybcio (2):
      mailmap: map Rajendra Nayak's old address to his current one
      mailmap: map Sai Prakash Ranjan's old address to his current one

Liam R. Howlett (3):
      maple_tree: fix mas_skip_node() end slot detection
      test_maple_tree: add more testing for mas_empty_area()
      mm/ksm: fix race with VMA iteration and mm_struct teardown

Marco Elver (3):
      kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
      kfence: avoid passing -g for test
      kcsan: avoid passing -g for test

Michal Hocko (1):
      mm, vmalloc: fix high order __GFP_NOFAIL allocations

Minwoo Im (1):
      mm: mmap: remove newline at the end of the trace

Muchun Song (1):
      mm: kfence: fix using kfence_metadata without initialization in show_object()

Peter Collingbourne (1):
      Revert "kasan: drop skip_kasan_poison variable in free_pages_prepare"

Peter Xu (1):
      kselftest: vm: fix unused variable warning

Richard Leitner (1):
      mailmap: add entries for Richard Leitner

Ryusuke Konishi (1):
      nilfs2: fix kernel-infoleak in nilfs_ioctl_wrap_copy()

Tiezhu Yang (1):
      checksyscalls: ignore fstat to silence build warning on LoongArch

Tobias Klauser (1):
      mailmap: add entry for Tobias Klauser

 .mailmap                               | 11 ++++++++
 arch/powerpc/include/asm/kasan.h       |  2 +-
 arch/powerpc/include/asm/string.h      | 15 ++++++++---
 arch/powerpc/kernel/prom_init_check.sh |  9 +++++--
 fs/nilfs2/ioctl.c                      |  2 +-
 include/trace/events/mmap.h            |  4 +--
 kernel/kcsan/Makefile                  |  2 +-
 lib/dhry_run.c                         |  6 +++--
 lib/maple_tree.c                       | 24 ++++-------------
 lib/test_maple_tree.c                  | 48 ++++++++++++++++++++++++++++++++++
 mm/kfence/Makefile                     |  2 +-
 mm/kfence/core.c                       | 10 +++++--
 mm/ksm.c                               | 11 ++++++--
 mm/mmap.c                              |  7 +----
 mm/mprotect.c                          |  2 +-
 mm/page_alloc.c                        |  3 ++-
 mm/vmalloc.c                           | 28 ++++++++++++++++----
 scripts/checksyscalls.sh               |  4 ++-
 tools/testing/selftests/mm/mdwe_test.c |  3 +--
 19 files changed, 140 insertions(+), 53 deletions(-)

