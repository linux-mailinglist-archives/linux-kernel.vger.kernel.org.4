Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A972CF72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbjFLT2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjFLT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5C10FC;
        Mon, 12 Jun 2023 12:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 545DE62D9D;
        Mon, 12 Jun 2023 19:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997A8C433EF;
        Mon, 12 Jun 2023 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686598033;
        bh=lSpYaMyG6ik/eNMtm78Mfwqh28u7fTZv7+iyrRa8J+U=;
        h=Date:From:To:Cc:Subject:From;
        b=KgzcOsAGO/AUnZ7JaM/3SVTq1vybaKq/+MbCPG5M3mTFXq1p7WFt3bgF0tz7JtwQC
         hZYk6e0r8TC+rwafT4gBnEUtlJcpJHt8ygIFG5xcsfWgvcrkpsyPC/MxEZXSztjznc
         k6TuC7vvyu4rjo8a5qXvwvjYBwkDVuRBLfACAqP8=
Date:   Mon, 12 Jun 2023 12:27:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.4-rc7
Message-Id: <20230612122712.f495e24b80f88f58557ea470@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 8b817fded42d8fe3a0eb47b1149d907851a3c942:

  Merge tag 'trace-v6.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/trace/linux-trace (2023-05-29 07:20:13 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-st=
able-2023-06-12-12-22

for you to fetch changes up to 0bdf0efa180a9cb1361cbded4e2260a49306ac89:

  zswap: do not shrink if cgroup may not zswap (2023-06-12 11:31:52 -0700)

----------------------------------------------------------------
19 hotfixes.  14 are cc:stable and the remainder address issues which were
introduced during this -rc cycle or which were considered inappropriate
for a backport.

----------------------------------------------------------------
Arnd Bergmann (1):
      radix-tree: move declarations to header

Benjamin Segall (1):
      epoll: ep_autoremove_wake_function should use list_del_init_careful

Haibo Li (1):
      mm/gup_test: fix ioctl fail for compat task

John Keeping (1):
      mailmap: add entry for John Keeping

Kefeng Wang (1):
      mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()

Lorenzo Stoakes (1):
      lib/test_vmalloc.c: avoid garbage in page array

Lu=EDs Henriques (2):
      ocfs2: fix use-after-free when unmounting read-only filesystem
      ocfs2: check new file size on fallocate call

Mike Kravetz (1):
      page cache: fix page_cache_next/prev_miss off by one

Nhat Pham (1):
      zswap: do not shrink if cgroup may not zswap

Peter Xu (2):
      mm/uffd: fix vma operation where start addr cuts part of vma
      mm/uffd: allow vma to merge as much as possible

Ricardo Ribalda (4):
      kexec: support purgatories with .text.hot sections
      x86/purgatory: remove PGO flags
      powerpc/purgatory: remove PGO flags
      riscv/purgatory: remove PGO flags

Ryusuke Konishi (3):
      nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_ke=
y()
      nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
      nilfs2: reject devices with insufficient block count

 .mailmap                          |  1 +
 arch/powerpc/purgatory/Makefile   |  5 +++++
 arch/riscv/purgatory/Makefile     |  5 +++++
 arch/x86/purgatory/Makefile       |  5 +++++
 fs/eventpoll.c                    |  6 +++++-
 fs/nilfs2/btnode.c                | 12 +++++++++--
 fs/nilfs2/sufile.c                |  9 ++++++++
 fs/nilfs2/the_nilfs.c             | 43 +++++++++++++++++++++++++++++++++++=
+++-
 fs/ocfs2/file.c                   |  8 +++++++-
 fs/ocfs2/super.c                  |  6 ++++--
 fs/userfaultfd.c                  | 13 ++++++++++--
 kernel/kexec_file.c               | 14 ++++++++++++-
 lib/radix-tree.c                  |  2 ++
 lib/radix-tree.h                  |  8 ++++++++
 lib/test_vmalloc.c                |  2 +-
 lib/xarray.c                      |  6 ++----
 mm/damon/core.c                   |  2 ++
 mm/filemap.c                      | 26 ++++++++++++++---------
 mm/gup_test.c                     |  1 +
 mm/zswap.c                        | 11 ++++++++--
 tools/testing/radix-tree/Makefile |  5 +++--
 21 files changed, 161 insertions(+), 29 deletions(-)
 create mode 100644 lib/radix-tree.h

