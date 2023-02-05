Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67568AF00
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBEJ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 04:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 04:28:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE072B7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 01:28:43 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1CB9C1EC042F;
        Sun,  5 Feb 2023 10:28:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675589322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=PbAq0F9390dJGnWsZlv6KZLL6S1XO8qFyjpos1R9I6k=;
        b=ZPgJeftFAZKTpN7ZLocm8DHOzRBfLqi2QLpUYN/lz0msVbJrjpPVuoVTQ08ejPqb6ZrqOz
        Oekf9WdDWM6MVdvybdmHyFK891nJ8XmzTRBw8viGZUcnLF3/B0pH5mgy3cd5m4CE3UumP6
        ICjV8iVJd0/D3I75bvBZjwRF+qKWAjo=
Date:   Sun, 5 Feb 2023 10:28:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.2-rc7
Message-ID: <Y992xcV7/Zg/30va@zn.tnic>
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

please pull a single urgent perf fix for 6.2.

Thx.

---

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc7

for you to fetch changes up to 4f64a6c9f6f11e8b7314f8e27e2c4568706009e6:

  perf: Fix perf_event_pmu_context serialization (2023-01-31 20:37:18 +0100)

----------------------------------------------------------------
- Lock the proper critical section when dealing with perf event context

----------------------------------------------------------------
James Clark (1):
      perf: Fix perf_event_pmu_context serialization

 include/linux/spinlock.h |  9 +++++++++
 kernel/events/core.c     | 39 +++++++++++++++++----------------------
 lib/dec_and_lock.c       | 31 +++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 22 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
