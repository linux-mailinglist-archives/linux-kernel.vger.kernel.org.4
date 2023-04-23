Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6674F6EBF83
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDWMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDWMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2051A1FDF;
        Sun, 23 Apr 2023 05:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADD3F611D1;
        Sun, 23 Apr 2023 12:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ACDC4339B;
        Sun, 23 Apr 2023 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682253712;
        bh=YnBrIbmb5UAV+e+e3Hlm9AwckTbkzxsLFA2JOnShUwE=;
        h=From:Date:Subject:To:Cc:From;
        b=oEojJ7fmHncgZL27QlTgIfa3JTeslpH08azlxzWgdkAifGIbGZxN0BM+B6H+PHA20
         lnmqpdad+jT31fyKG7HQYTamjKdQY+/HvbyU28wgNHgOlOmAZHi9T8sMyljf0p4u55
         2nZ6mIQi+EpMETNnTUhDxsU0V4CfJSX2YtHxdx34KL04xBPeETVOGFhF+u77qXLOhy
         y1n0VKzl407w65sEKtoVs0rDkTXIJSbQAatObQAO1X12/qGhM9/i0bSsJYSYFHHU4R
         sBC62UnsNYUFQkrYX5uyNo3FXNFYWl90yn5ZjDDE3rV2sSDi6ccS7+bpEmS4gKCS3C
         wZgW+gthqfWNA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-187c78c6657so2416277fac.2;
        Sun, 23 Apr 2023 05:41:52 -0700 (PDT)
X-Gm-Message-State: AAQBX9cCo1ZBrFKZdMuhLp4DvWIrWO4N+IhtRk3WayPgZmAydW244dD7
        nTxtewK3HwijZQxbzXTIWfobSrGYZ0+8FvfXyJ8=
X-Google-Smtp-Source: AKy350ZOPr+vhVnt1HJRudMJBNy3fHh4/WsxEA9IPdL4IYrpX43bebFCE8g2R/R+ZgTS/qN74UMFulGei05hCxoRvHM=
X-Received: by 2002:aca:1319:0:b0:38e:8d7f:c07e with SMTP id
 e25-20020aca1319000000b0038e8d7fc07emr3346503oii.52.1682253711392; Sun, 23
 Apr 2023 05:41:51 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Apr 2023 21:41:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASokmOqPSzuaAf-vTdNM7jKRW=9Y8S6pZzkEWf_6HLQeA@mail.gmail.com>
Message-ID: <CAK7LNASokmOqPSzuaAf-vTdNM7jKRW=9Y8S6pZzkEWf_6HLQeA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.3(-rc8)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,


Please pull Kbuild fixes.
Thank you.



The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.3-4

for you to fetch changes up to 9cedc5e89a59da72bfecdb76bfaa5a28a273029d:

  kbuild: use proper prefix for tarballs to fix rpm-pkg build error
(2023-04-23 21:23:10 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.3 (4th)

 - Fix the prefix in the kernel source tarball

 - Fix a typo in the copyright file in Debian package

----------------------------------------------------------------
Masahiro Yamada (1):
      kbuild: use proper prefix for tarballs to fix rpm-pkg build error

Woody Suwalski (1):
      kbuild: deb-pkg: Fix a spell typo in mkdebian script

 scripts/Makefile.package | 6 +++---
 scripts/package/mkdebian | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)



-- 
Best Regards
Masahiro Yamada
