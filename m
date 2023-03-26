Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079F26C9468
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCZND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCZND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:03:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A557D9D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:03:55 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76A2F1EC054E;
        Sun, 26 Mar 2023 15:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679835834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=VzRwCAUMHul3+jSJOsYrSBAWvbL7w6l0y/VD30xVwxY=;
        b=hGtlKpCaaJyDWH/Fle4bi4Zznryl8tfyfDxucPyS96S+omqSX3wuYC14OD0/xbp7ilHoZS
        c3ARBirsz+yTdRclp52mcqYVxGw6pTH9VR0k1fm8fNDEXNlUgHjL5M8gVdTwgcfN4X3Ees
        L2R3uSC3zoavjI1GPx/JZ/C3ixVR8Nk=
Date:   Sun, 26 Mar 2023 15:03:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.3-rc4
Message-ID: <20230326130354.GDZCBCum4r9MJ8thhi@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull an urgent sched fix for 6.3.

Thx.

---

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.3_rc4

for you to fetch changes up to a53ce18cacb477dd0513c607f187d16f0fa96f71:

  sched/fair: Sanitize vruntime of entity being migrated (2023-03-21 14:43:04 +0100)

----------------------------------------------------------------
- Fix a corner case where vruntime of a task is not being sanitized

----------------------------------------------------------------
Vincent Guittot (1):
      sched/fair: Sanitize vruntime of entity being migrated

 kernel/sched/core.c |  3 +++
 kernel/sched/fair.c | 55 ++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 11 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
