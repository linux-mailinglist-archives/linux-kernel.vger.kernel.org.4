Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF076A6890
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCAIHH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Mar 2023 03:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCAIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:07:05 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFF437545
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:07:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A9A0B6382EFF;
        Wed,  1 Mar 2023 09:07:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JJYUEG33GHQY; Wed,  1 Mar 2023 09:07:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5042C6382EFB;
        Wed,  1 Mar 2023 09:07:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wTWnOLs0gHPD; Wed,  1 Mar 2023 09:07:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3819A605DED8;
        Wed,  1 Mar 2023 09:07:02 +0100 (CET)
Date:   Wed, 1 Mar 2023 09:07:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS updates for v6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: roGm/tvZ5HdHDuKdZoGvK25uWKzwXw==
Thread-Topic: JFFS2, UBI and UBIFS updates for v6.3-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.3-rc1

for you to fetch changes up to 8fcf2d012c8641c18adcd139dba6a1e556338d36:

  ubi: block: Fix a possible use-after-free bug in ubiblock_create() (2023-02-14 15:17:55 +0100)

----------------------------------------------------------------
This pull request contains updates for JFFS2, UBI and UBIFS

JFFS2:
	- Fix memory corruption in error path
	- Spelling and coding style fixes

UBI:
	- Switch to BLK_MQ_F_BLOCKING in ubiblock
	- Wire up partent device (for sysfs)
	- Multiple UAF bugfixes
	- Fix for an infinite loop in WL error path

UBIFS:
	- Fix for multiple memory leaks in error paths
	- Fixes for wrong space accounting
	- Minor cleanups
	- Spelling and coding style fixes

----------------------------------------------------------------
Christoph Hellwig (1):
      ubi: block: set BLK_MQ_F_BLOCKING

Daniel Golle (2):
      mtd: ubi: wire-up parent MTD device
      mtd: ubi: block: wire-up device parent

George Kennedy (1):
      ubi: ensure that VID header offset + VID header size <= alloc, size

Harshit Mogalapalli (1):
      ubi: block: Fix a possible use-after-free bug in ubiblock_create()

Jiapeng Chong (1):
      UBI: Fastmap: Fix kernel-doc

Li Hua (1):
      ubifs: Fix build errors as symbol undefined

Li Zetao (3):
      ubi: Fix use-after-free when volume resizing failed
      ubi: Fix unreferenced object reported by kmemleak in ubi_resize_volume()
      ubifs: Fix memory leak in alloc_wbufs()

Liu Shixin (1):
      ubifs: Fix memory leak in ubifs_sysfs_init()

Mårten Lindahl (1):
      ubi: block: Reduce warning print to info for static volumes

Randy Dunlap (1):
      ubi: use correct names in function kernel-doc comments

Thomas Weißschuh (1):
      ubifs: make kobj_type structures constant

Yang Li (2):
      ubifs: Fix some kernel-doc comments
      ubifs: Fix kernel-doc

Yang Yingliang (1):
      ubi: Fix possible null-ptr-deref in ubi_free_volume()

Yifei Liu (1):
      jffs2: correct logic when creating a hole in jffs2_write_begin

Yu Zhe (1):
      jffs2: fix spelling mistake "neccecary"->"necessary"

Zhang Xiaoxu (2):
      jffs2: Use function instead of macro when initialize compressors
      jffs2: Fix list_del corruption if compressors initialized failed

ZhaoLong Wang (2):
      ubi: fastmap: Add fastmap control support for module parameter
      ubi: Fix permission display of the debugfs files

Zhihao Cheng (13):
      ubifs: Rectify space budget for ubifs_symlink() if symlink is encrypted
      ubifs: Rectify space budget for ubifs_xrename()
      ubifs: Add comments and debug info for ubifs_xrename()
      ubifs: Fix wrong dirty space budget for dirty inode
      ubifs: do_rename: Fix wrong space budget when target inode's nlink > 1
      ubifs: Reserve one leb for each journal head while doing budget
      ubifs: Re-statistic cleaned znode count if commit failed
      ubifs: dirty_cow_znode: Fix memleak in error handling path
      ubifs: ubifs_writepage: Mark page dirty after writing inode failed
      ubifs: ubifs_releasepage: Remove ubifs_assert(0) to valid this process
      ubi: fastmap: Fix missed fm_anchor PEB in wear-leveling after disabling fastmap
      ubi: Fix UAF wear-leveling entry in eraseblk_count_seq_show()
      ubi: ubi_wl_put_peb: Fix infinite loop when wear-leveling work failed

 drivers/mtd/ubi/block.c      | 109 ++++++++++++++-----------------------------
 drivers/mtd/ubi/build.c      |  32 +++++++++++--
 drivers/mtd/ubi/debug.c      |  19 ++++----
 drivers/mtd/ubi/eba.c        |   2 +-
 drivers/mtd/ubi/fastmap-wl.c |  12 +++--
 drivers/mtd/ubi/fastmap.c    |   2 +-
 drivers/mtd/ubi/kapi.c       |   1 +
 drivers/mtd/ubi/misc.c       |   2 +-
 drivers/mtd/ubi/vmt.c        |  18 +++----
 drivers/mtd/ubi/wl.c         |  27 +++++++++--
 fs/jffs2/compr.c             |  50 +++++++++++---------
 fs/jffs2/compr.h             |  26 ++++++++---
 fs/jffs2/file.c              |  15 +++---
 fs/jffs2/fs.c                |   2 +-
 fs/ubifs/budget.c            |   9 ++--
 fs/ubifs/dir.c               |  18 ++++++-
 fs/ubifs/file.c              |  31 ++++++++----
 fs/ubifs/io.c                |   6 +--
 fs/ubifs/journal.c           |   8 +++-
 fs/ubifs/super.c             |  17 +++++--
 fs/ubifs/sysfs.c             |   6 ++-
 fs/ubifs/tnc.c               |  24 +++++++++-
 fs/ubifs/ubifs.h             |   5 ++
 include/linux/mtd/ubi.h      |   1 +
 24 files changed, 274 insertions(+), 168 deletions(-)
