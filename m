Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B250D5FF521
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJNVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJNVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:17:18 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A70ED9B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:17:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AA050642172D;
        Fri, 14 Oct 2022 23:17:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8P4rzkYpvGek; Fri, 14 Oct 2022 23:17:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 55CDA642172E;
        Fri, 14 Oct 2022 23:17:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3J7kKppmRros; Fri, 14 Oct 2022 23:17:13 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 37D7B642172D;
        Fri, 14 Oct 2022 23:17:13 +0200 (CEST)
Date:   Fri, 14 Oct 2022 23:17:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1135185122.30714.1665782233107.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS updates for 6.1-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: FAGGPxqkkN+sUwYBp4ISK0M1p6fJaQ==
Thread-Topic: UBI and UBIFS updates for 6.1-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-6.1-rc1

for you to fetch changes up to 669d204469c46e91d99da24914130f78277a71d3:

  ubi: fastmap: Add fastmap control support for 'UBI_IOCATT' ioctl (2022-09-21 18:29:18 +0200)

----------------------------------------------------------------
This pull request contains updates for UBI and UBIFS

UBI:
	- Use bitmap API to allocate bitmaps
	- New attach mode, disable_fm, to attach without fastmap
        - Fixes for various typos in comments

UBIFS:
	- Fix for a deadlock when setting xattrs for encrypted file
	- Fix for an assertion failures when truncating encrypted files
        - Fixes for various typos in comments

----------------------------------------------------------------
Christophe JAILLET (1):
      ubi: fastmap: Use the bitmap API to allocate bitmaps

Jason Wang (1):
      ubi: ubi-media.h: Fix comment typo

Jiang Jian (1):
      mtd: ubi: drop unexpected word 'a' in comments

Jilin Yuan (1):
      ubi: Fix repeated words in comments

Julia Lawall (1):
      ubi: block: Fix typos in comments

Li zeming (1):
      ubi: block: Remove in vain semicolon

Yang Li (1):
      ubifs: Fix ubifs_check_dir_empty() kernel-doc comment

Zhang Jiaming (1):
      ubi: fastmap: Fix typo in comments

ZhaoLong Wang (1):
      ubifs: Fix UBIFS ro fail due to truncate in the encrypted directory

Zhihao Cheng (2):
      ubifs: Fix AA deadlock when setting xattr for encrypted file
      ubi: fastmap: Add fastmap control support for 'UBI_IOCATT' ioctl

 drivers/mtd/ubi/block.c     |  4 ++--
 drivers/mtd/ubi/build.c     | 14 ++++++++++----
 drivers/mtd/ubi/cdev.c      |  4 ++--
 drivers/mtd/ubi/eba.c       |  2 +-
 drivers/mtd/ubi/fastmap.c   | 10 ++++------
 drivers/mtd/ubi/io.c        |  2 +-
 drivers/mtd/ubi/ubi-media.h |  2 +-
 drivers/mtd/ubi/ubi.h       |  9 +++++----
 drivers/mtd/ubi/vmt.c       |  4 ++--
 drivers/mtd/ubi/wl.c        |  8 ++++----
 fs/ubifs/crypto.c           | 11 +++++++++++
 fs/ubifs/dir.c              | 27 +++++++++++++++------------
 fs/ubifs/journal.c          | 28 +++++++++++++++++-----------
 fs/ubifs/ubifs.h            |  2 +-
 fs/ubifs/xattr.c            |  2 +-
 include/uapi/mtd/ubi-user.h |  8 +++++++-
 16 files changed, 84 insertions(+), 53 deletions(-)
