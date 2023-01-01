Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06AD65AA40
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjAAPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:00:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B1D5B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:00:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D9CF1EC0104;
        Sun,  1 Jan 2023 16:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672585201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=/U8OrUDqmDmDYNaR7ObxZo1L2SJaapyWaOwdL7xPmwE=;
        b=C43WTrGUdEUEGryrxYXiVVTSoEDcrUbM/2v8UDCJ7zjzWbuyi4BiE7U7hgpIaWxVwoVXKP
        baT/3XsUMTUpmVsHKgZ5wZIJxxuHubhN+hzSANIHFLtiF0JIhliKK1Yn38yA7Y16Y8t1xc
        5nkfzJwOXktGfP6RflPsTmkATKQZK34=
Date:   Sun, 1 Jan 2023 15:59:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.2-rc2
Message-ID: <Y7Gf65Z5S++WefTw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent locking fixes for 6.2.

Thx.

---

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.2_rc2

for you to fetch changes up to 94cd8fa09f5f1ebdd4e90964b08b7f2cc4b36c43:

  futex: Fix futex_waitv() hrtimer debug object leak on kcalloc error (2022-12-27 12:52:02 +0100)

----------------------------------------------------------------
- Prevent the leaking of a debug timer in futex_waitv()

- A preempt-RT mutex locking fix, adding the proper acquire semantics

----------------------------------------------------------------
Mathieu Desnoyers (1):
      futex: Fix futex_waitv() hrtimer debug object leak on kcalloc error

Mel Gorman (1):
      rtmutex: Add acquire semantics for rtmutex lock acquisition slow path

 kernel/futex/syscalls.c      | 11 +++++----
 kernel/locking/rtmutex.c     | 55 ++++++++++++++++++++++++++++++++++++--------
 kernel/locking/rtmutex_api.c |  6 ++---
 3 files changed, 56 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
