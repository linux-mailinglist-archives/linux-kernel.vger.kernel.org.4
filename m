Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E286E331F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDOSYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDOSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 14:24:35 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5744AD
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 11:24:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EF9F0622623A;
        Sat, 15 Apr 2023 20:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eleR2Tx-TXKj; Sat, 15 Apr 2023 20:24:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A7A9063CC171;
        Sat, 15 Apr 2023 20:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7nutnz1XVOKJ; Sat, 15 Apr 2023 20:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 842B6622623A;
        Sat, 15 Apr 2023 20:24:06 +0200 (CEST)
Date:   Sat, 15 Apr 2023 20:24:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1571141363.69401.1681583046301.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI fixes for 6.3-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: v8nQqJi8tbszwXdmGlenVhUJklBsvA==
Thread-Topic: UBI fixes for 6.3-rc7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 0988a0ea791999ebbf95693f2676381825b05033:

  Merge tag 'for-v6.3-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply (2023-03-03 16:33:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.3-rc7

for you to fetch changes up to 1e020e1b96afdecd20680b5b5be2a6ffc3d27628:

  ubi: Fix failure attaching when vid_hdr offset equals to (sub)page size (2023-03-29 23:32:57 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UBI and UBIFS:

- Fix for a stable patch: Fix failure attaching when vid_hdr offset equals to (sub)page size
- Fix for a deadlock in UBI's worker thread

----------------------------------------------------------------
ZhaoLong Wang (1):
      ubi: Fix deadlock caused by recursively holding work_sem

Zhihao Cheng (1):
      ubi: Fix failure attaching when vid_hdr offset equals to (sub)page size

 drivers/mtd/ubi/build.c | 21 +++++++++++++++------
 drivers/mtd/ubi/wl.c    |  4 ++--
 2 files changed, 17 insertions(+), 8 deletions(-)
