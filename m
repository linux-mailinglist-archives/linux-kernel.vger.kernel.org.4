Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9074BEA5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGHRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 13:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA2E72;
        Sat,  8 Jul 2023 10:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA58D60E08;
        Sat,  8 Jul 2023 17:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A57C433C8;
        Sat,  8 Jul 2023 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688838419;
        bh=rygTkWcXlaZb+F5yaCQ6zI7Et78F2m/A5X5+Pp2BRr4=;
        h=Date:From:To:Cc:Subject:From;
        b=q5l+9/gqyhNI55fA1nL96JHjDYLbpILCIwZY/S3E2HmOnYY4cRkxEY3ZJrT1HW95U
         D3eGqQfWrUxZAALSERdYwXJ3GxQVp5mRbOvtCSEmlBbGUcn46FNiVix6dXwFrZHHEC
         5WQitD+DnJWo+uyOIA3OdJ8ZVPChBfO3ALhMJYG4=
Date:   Sat, 8 Jul 2023 10:46:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [GIT PULL] hotfixes for 6.5-rc1
Message-Id: <20230708104658.927e647f75d55c4a5d99cbf5@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.

This includes the disabling of the CONFIG_PER_VMA_LOCK feature, which
needs some additional work before being suitable for use.


The following changes since commit 3fbff91afbf0148e937b8718ed865b073c587d9f:

  Merge branch 'master' into mm-hotfixes-stable (2023-07-02 18:53:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-07-08-10-43

for you to fetch changes up to 8ba388c06bc8056935ec1814b2689bfb42f3b89a:

  lib: dhry: fix sleeping allocations inside non-preemptable section (2023-07-08 09:29:32 -0700)

----------------------------------------------------------------
16 hotfixes.  Six are cc:stable and the remainder address post-6.4 issues.

----------------------------------------------------------------
Andrey Konovalov (2):
      kasan: fix type cast in memory_is_poisoned_n
      kasan, slub: fix HW_TAGS zeroing with slub_debug

Anthony Iliopoulos (2):
      MAINTAINERS: update ocfs2-devel mailing list address
      docs: update ocfs2-devel mailing list address

Geert Uytterhoeven (1):
      lib: dhry: fix sleeping allocations inside non-preemptable section

Heiko Stuebner (2):
      mailmap: update manpage link
      mailmap: add entries for Heiko Stuebner

John Hubbard (1):
      mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte comparison

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page

Markus Schneider-Pargmann (1):
      mailmap: add Markus Schneider-Pargmann

Matthew Wilcox (Oracle) (1):
      writeback: account the number of pages written back

Peter Collingbourne (1):
      mm: call arch_swap_restore() from do_swap_page()

Randy Dunlap (1):
      MAINTAINERS: add linux-next info

Suren Baghdasaryan (2):
      fork: lock VMAs of the parent process when forking
      mm: disable CONFIG_PER_VMA_LOCK until its fixed

Vincent Whitchurch (1):
      squashfs: fix cache race with migration

 .mailmap                              |  7 ++++++-
 Documentation/ABI/obsolete/o2cb       |  4 ++--
 Documentation/ABI/removed/o2cb        |  4 ++--
 Documentation/ABI/stable/o2cb         |  4 ++--
 Documentation/ABI/testing/sysfs-ocfs2 | 12 ++++++------
 Documentation/filesystems/dlmfs.rst   |  2 +-
 Documentation/filesystems/ocfs2.rst   |  2 +-
 MAINTAINERS                           |  9 ++++++++-
 fs/ocfs2/Kconfig                      |  6 +++---
 fs/squashfs/block.c                   | 27 +++++++++++++++++++++++----
 include/linux/bootmem_info.h          |  2 ++
 kernel/fork.c                         |  6 ++++++
 lib/dhry_1.c                          | 11 +++++++++--
 mm/Kconfig                            |  3 ++-
 mm/hugetlb.c                          |  7 ++++++-
 mm/kasan/generic.c                    |  3 ++-
 mm/kasan/kasan.h                      | 12 ------------
 mm/memory.c                           |  7 +++++++
 mm/page-writeback.c                   |  8 +++++---
 mm/slab.h                             | 16 ++++++++++++++--
 20 files changed, 107 insertions(+), 45 deletions(-)

