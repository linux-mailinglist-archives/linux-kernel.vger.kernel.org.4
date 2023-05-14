Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71223701D15
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjENL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjENL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:27:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8101984
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 04:27:38 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 419C61EC0506;
        Sun, 14 May 2023 13:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684063656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=9KXVgzvY+UYh2SMb/G0j1RC5IUoXBC1KNaqjy8R8nu0=;
        b=M0o14Cpt+TrPKhv1c3ZgaLDgmeGnflX0D8giVcl8LfmaT2jxmZW+b+gJCQ+WCPYP+MU9gp
        3p7JFCQGrFBlpWALIlgnR7hjFJJGF+cY8eu14EAnNzznS34R7SVsxSgS0EYf6p4NQVmncm
        wI4+gMcqi8Q/ZxqoLxchV+JPc8XMXF4=
Date:   Sun, 14 May 2023 13:27:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.4-rc2
Message-ID: <20230514112728.GAZGDFoGTLmNPf7gW2@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent timers fix for 6.4.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.4_rc2

for you to fetch changes up to f9d36cf445ffff0b913ba187a3eff78028f9b1fb:

  tick/broadcast: Make broadcast device replacement work correctly (2023-05-08 23:18:16 +0200)

----------------------------------------------------------------
- Prevent CPU state corruption when an active clockevent broadcast
  device is replaced while the system is already in oneshot mode

----------------------------------------------------------------
Thomas Gleixner (1):
      tick/broadcast: Make broadcast device replacement work correctly

 kernel/time/tick-broadcast.c | 120 +++++++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 32 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
