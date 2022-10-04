Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E85F481C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJDROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJDROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:14:33 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02425D120
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:14:29 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MhkpC3gK8zMqLgs;
        Tue,  4 Oct 2022 19:14:27 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MhkpC1d61zMpqBK;
        Tue,  4 Oct 2022 19:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664903667;
        bh=O1Eep5R1Uhm24Ad2jxVeSqkWoP3tf66+7U1e7K0UzTk=;
        h=From:To:Cc:Subject:Date:From;
        b=DtqOoLFC4cI0WV0k5pqaZ5btMl32HUJq+SRLiCjYAG04czucOPuJvJ+QT+uEA9dBd
         xzorlzP5WHYmqxecqbu/jYV+VRuPi//Auy8Oaaxvwvw8m+KoMp+gxpy45tpLCoyJaO
         BB/tfBScQkO7fFNaJ1BWc24+0uqVkjAm0khKrvC8=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.1
Date:   Tue,  4 Oct 2022 19:14:14 +0200
Message-Id: <20221004171414.974585-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This changes improve user help for Landlock (documentation and sample).

Please pull this Landlock changes for v6.1-rc1 .  These 3 commits merged
cleanly with your tree, and have been successfully tested in the latest
linux-next releases.

Regards,
 Mickaël

--
The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc1

for you to fetch changes up to 2fff00c81d4c37a037cf704d2d219fbcb45aea3c:

  landlock: Fix documentation style (2022-09-29 18:43:04 +0200)

----------------------------------------------------------------
Landlock updates for v6.1-rc1

----------------------------------------------------------------
Mickaël Salaün (3):
      samples/landlock: Print hints about ABI versions
      landlock: Slightly improve documentation and fix spelling
      landlock: Fix documentation style

 Documentation/security/landlock.rst      |  8 +++----
 Documentation/userspace-api/landlock.rst | 33 +++++++++++++-------------
 include/uapi/linux/landlock.h            | 10 ++++----
 samples/landlock/sandboxer.c             | 37 ++++++++++++++++++++++-------
 security/landlock/fs.c                   |  2 +-
 security/landlock/syscalls.c             | 40 ++++++++++++++++----------------
 6 files changed, 76 insertions(+), 54 deletions(-)
