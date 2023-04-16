Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134C46E37FB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDPM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjDPM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:29:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5713C19
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:29:15 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33C751EC0691;
        Sun, 16 Apr 2023 14:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681648154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=fKaIRUQl7pI1DaUzepOks/E9LKL4bo19TaO2Ps8rojs=;
        b=pbrTx1O7WmJN2H8CMpGlVTfrp3OySNmOfRPE3uSW38fJ92S0M2AUw64BC80f2y+pPwxDQ5
        tofR+xVCyDuC685dr/gL0gzXgdw46E9NbGDPdQd7twzbgKg1Yd2Jdu5x+//Br6i4tRQ4ZI
        bOC4bn4mub8/uYsGlupk1WKBeS7m6vM=
Date:   Sun, 16 Apr 2023 14:29:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.3-rc7
Message-ID: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent x86 fix for 6.3.

Thx.

---

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc7

for you to fetch changes up to 775d3c514c5b2763a50ab7839026d7561795924d:

  x86/rtc: Remove __init for runtime functions (2023-04-13 14:41:04 +0200)

----------------------------------------------------------------
- Drop __init annotation from two rtc functions which get called after
  boot is done, in order to prevent a crash

----------------------------------------------------------------
Matija Glavinic Pecotic (1):
      x86/rtc: Remove __init for runtime functions

 arch/x86/kernel/x86_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
