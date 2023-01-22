Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7AB676CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAVMTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjAVMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:19:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E910DD4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:18:57 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A07B1EC0441;
        Sun, 22 Jan 2023 13:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674389936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=SisZyrBsAJgGSKFyBP3S3ZuMDxTB7/hRZD876qqBLFs=;
        b=g+G6GvB5YK1XmqMvogHPs2/+UAOaCuKVWnKMHUuVy6tcRa2ja1cyR4gb7kDmNogcB/71WT
        tuYkLQvBvSYIInnjVdhv99/VYXIqO04N9EPuqS1vLXD68VXEE4l/tD0cfh+hA1s6saZ+9f
        cbubwoSCRvdBO2ysQfFpRofiy5YK1qQ=
Date:   Sun, 22 Jan 2023 13:18:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.2-rc6
Message-ID: <Y80pqpsa/f2eEcYP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent scheduler fixes for 6.2.

Thx.

---

The following changes since commit 9a5418bc48babb313d2a62df29ebe21ce8c06c59:

  sched/core: Use kfree_rcu() in do_set_cpus_allowed() (2023-01-09 11:43:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.2_rc6

for you to fetch changes up to 5f5cc9ed992cbab6361f198966f0edba5fc52688:

  x86/aperfmperf: Erase stale arch_freq_scale values when disabling frequency invariance readings (2023-01-16 10:19:15 +0100)

----------------------------------------------------------------
- Make sure the scheduler doesn't use stale frequency scaling values when latter
  get disabled due to a value error

- Fix a NULL pointer access on UP configs

- Use the proper locking when updating CPU capacity

----------------------------------------------------------------
Qais Yousef (2):
      sched/uclamp: Fix a uninitialized variable warnings
      sched/fair: Fixes for capacity inversion detection

Waiman Long (1):
      sched/core: Fix NULL pointer access fault in sched_setaffinity() with non-SMP configs

Yair Podemsky (1):
      x86/aperfmperf: Erase stale arch_freq_scale values when disabling frequency invariance readings

 arch/x86/kernel/cpu/aperfmperf.c |  9 ++++++++
 kernel/sched/core.c              | 10 +++++++--
 kernel/sched/fair.c              | 48 ++++++++++++++++++++++------------------
 3 files changed, 44 insertions(+), 23 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
