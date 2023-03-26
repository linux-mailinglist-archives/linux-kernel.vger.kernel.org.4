Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F26C9456
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCZMrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:47:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759537D9A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:47:37 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12CD71EC0681;
        Sun, 26 Mar 2023 14:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679834856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=bWmnuzKEUGY/2w36Dgsuu7GRUOm4ynEheBLo1nH46Z8=;
        b=jxna6RT+wIiK4Hpq9dkVMb/lyDdHj9HlM308QnZ/NEVvEV0jyOJmI+hYcFnctEQlrJI5Uy
        dZwVkjovxI5Le7a9fQcWEdyDmRcLYqxhhi23jb6fjxEEcaF8FAEVfr2c+46S9jh2S7rrOy
        /2QP3HHMzVB/5GNsEUTvF1OUj2lmP9c=
Date:   Sun, 26 Mar 2023 14:47:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/urgent for v6.3-rc4
Message-ID: <20230326124735.GBZCA+58Z/H1QD3b7W@fat_crate.local>
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

please pull a couple of core/urgent fixes for 6.3.

Thx.

---

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v6.3_rc4

for you to fetch changes up to b416514054810cf2d2cc348ae477cea619b64da7:

  entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up (2023-03-21 15:13:15 +0100)

----------------------------------------------------------------
- Do the delayed RCU wakeup for kthreads in the proper order so that
  former doesn't get ignored

- A noinstr warning fix

----------------------------------------------------------------
Frederic Weisbecker (1):
      entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up

Josh Poimboeuf (1):
      entry: Fix noinstr warning in __enter_from_user_mode()

 include/linux/context_tracking.h       | 1 +
 include/linux/context_tracking_state.h | 2 ++
 kernel/entry/common.c                  | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
