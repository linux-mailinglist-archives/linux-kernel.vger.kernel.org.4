Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB570B01C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjEUUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 16:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 16:10:10 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F0DE
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 13:10:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2E940616B2CC;
        Sun, 21 May 2023 22:09:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CuOYgnqiKr9i; Sun, 21 May 2023 22:09:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CD371616B2E1;
        Sun, 21 May 2023 22:09:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ERJ2vz2BOpEY; Sun, 21 May 2023 22:09:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A9873616B2CC;
        Sun, 21 May 2023 22:09:57 +0200 (CEST)
Date:   Sun, 21 May 2023 22:09:57 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fix for v6.4-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: HEGKhk+vvLUmoYlurGDS4VID8LjNRw==
Thread-Topic: UML fix for v6.4-rc3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc3

for you to fetch changes up to 73a23d7710331a530e972903318528b75e5a5f58:

  um: harddog: fix modular build (2023-05-10 00:21:30 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Fix modular build for UML watchdog

----------------------------------------------------------------
Johannes Berg (1):
      um: harddog: fix modular build

 arch/um/drivers/Makefile           | 4 +++-
 arch/um/drivers/harddog.h          | 9 +++++++++
 arch/um/drivers/harddog_kern.c     | 7 +------
 arch/um/drivers/harddog_user.c     | 1 +
 arch/um/drivers/harddog_user_exp.c | 9 +++++++++
 5 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/drivers/harddog.h
 create mode 100644 arch/um/drivers/harddog_user_exp.c
