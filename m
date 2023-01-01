Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1965AA50
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjAAPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:14:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4EBEA1
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:14:52 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C389F1EC0104;
        Sun,  1 Jan 2023 16:14:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672586090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=8WTBXOJ7kDhaJ6BH3e5mWzHknjWYDO/53zFnNqqheYc=;
        b=rk1Dc2nqn2dpB/3jLs7Pi1nQQ/7naHfw7oCf45it4OU9L6dbaQ6CtJ1ug4/iPHNhm7tDuI
        Zj6+pFS/ODb52BkoFIMUlpyOXFKlnq5akigYD74E4bIdw7G1iJjvH8Xt41OTEsJwbfLdzW
        /1b/j7WJfxoLiQtReskBkbV54igz3fo=
Date:   Sun, 1 Jan 2023 16:14:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.2-rc2
Message-ID: <Y7GjauqO+sohqfZl@zn.tnic>
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

please pull a bunch of urgent perf events fixes for 6.2.

Thx.

---

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc2

for you to fetch changes up to 0a041ebca4956292cadfb14a63ace3a9c1dcb0a3:

  perf/core: Call LSM hook after copying perf_event_attr (2022-12-27 12:44:01 +0100)

----------------------------------------------------------------
- Pass only an initialized perf event attribute to the LSM hook

- Fix a use-after-free on the perf syscall's error path

- A potential integer overflow fix in amd_core_pmu_init()

- Fix the cgroup events tracking after the context handling rewrite

- Return the proper value from the inherit_event() function on error

----------------------------------------------------------------
Chengming Zhou (1):
      perf/core: Fix cgroup events tracking

Colin Ian King (1):
      perf/x86/amd: fix potential integer overflow on shift of a int

Namhyung Kim (1):
      perf/core: Call LSM hook after copying perf_event_attr

Peter Zijlstra (1):
      perf: Fix use-after-free in error path

Ravi Bangoria (1):
      perf core: Return error pointer if inherit_event() fails to find pmu_ctx

 arch/x86/events/amd/core.c |  2 +-
 kernel/events/core.c       | 54 +++++++++++++++-------------------------------
 2 files changed, 18 insertions(+), 38 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
