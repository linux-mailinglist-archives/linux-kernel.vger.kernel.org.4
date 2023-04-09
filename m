Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6646DBFA3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDILIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 07:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDILIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 07:08:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362E35BC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 04:08:50 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0CF11EC042D;
        Sun,  9 Apr 2023 13:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681038528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=BEGL9TQQVwBDLfeTAuMeNRy2yAFQSPGoKYbErAHFD+w=;
        b=NCN/tuKGqBI/4k6Q6Ob3VrgBKmoafpLr8OIlAFw86zztuy3Cs/nxKMaHMtAlrdWTzG+M3I
        dgmy60jrf4P7FmwBDi7Y7tVX8HMPtj6nBdvpkXu2DVVE6zva2qS5RcUze417Z5Q+IH6HvX
        Ac7wUbyRnwcA51025rA57Vq9JiNshCs=
Date:   Sun, 9 Apr 2023 13:08:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.3-rc6
Message-ID: <20230409110843.GBZDKcu+oZLHL7V8VL@fat_crate.local>
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

please pull a couple of urgent perf fixes for 6.3.

Thx.

---

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc6

for you to fetch changes up to 24d3ae2f37d8bc3c14b31d353c5d27baf582b6a6:

  perf/core: Fix the same task check in perf_event_set_output (2023-04-05 09:58:46 +0200)

----------------------------------------------------------------
- Fix "same task" check when redirecting event output

- Do not wait unconditionally for RCU on the event migration path if
  there are no events to migrate

----------------------------------------------------------------
Kan Liang (1):
      perf/core: Fix the same task check in perf_event_set_output

Peter Zijlstra (1):
      perf: Optimize perf_pmu_migrate_context()

 kernel/events/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
