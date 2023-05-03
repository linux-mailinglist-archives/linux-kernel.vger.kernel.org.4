Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C136F5F11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjECTZw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjECTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:25:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C619559A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:25:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C817D62E1A81;
        Wed,  3 May 2023 21:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ncu617pyWvvk; Wed,  3 May 2023 21:25:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 47FD062E1A88;
        Wed,  3 May 2023 21:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gScMev-CUfm9; Wed,  3 May 2023 21:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27A7A62E1A81;
        Wed,  3 May 2023 21:25:45 +0200 (CEST)
Date:   Wed, 3 May 2023 21:25:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1235201236.2692346.1683141945109.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS changes for v6.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: o2rRX15G+ItHzV6XoUeNlh7n8Se5Dg==
Thread-Topic: UBI and UBIFS changes for v6.4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.4-rc1

for you to fetch changes up to b5fda08ef213352ac2df7447611eb4d383cce929:

  ubifs: Fix memleak when insert_old_idx() failed (2023-04-23 23:36:38 +0200)

----------------------------------------------------------------
This pull request contains updates for UBI and UBIFS

UBI:
	- Fix error value for try_write_vid_and_data()
	- Minor cleanups

UBIFS:
	- Fixes for various memory leaks
	- Minor cleanups

----------------------------------------------------------------
Mårten Lindahl (2):
      ubifs: Free memory for tmpfile name
      ubifs: Fix memory leak in do_rename

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Yang Li (1):
      ubi: Simplify bool conversion

Yangtao Li (1):
      ubifs: Remove return in compr_exit()

Zhihao Cheng (2):
      Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"
      ubifs: Fix memleak when insert_old_idx() failed

 drivers/mtd/ubi/build.c |   2 +-
 drivers/mtd/ubi/eba.c   |  19 +++++--
 fs/ubifs/compress.c     |   1 -
 fs/ubifs/dir.c          |   7 +--
 fs/ubifs/tnc.c          | 142 +++++++++++++++++++++++++++++-------------------
 5 files changed, 102 insertions(+), 69 deletions(-)
