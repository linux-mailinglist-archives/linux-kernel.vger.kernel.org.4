Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBDA701D62
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjENMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjENMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:33:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804040EC
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:33:06 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE33A1EC0535;
        Sun, 14 May 2023 14:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684067578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=YwaxH8GWpf1ewf8ESUhYNuU76J+BqVePqtIVuisvF5Y=;
        b=k3gAqOT51B+vTHjZZ4xe3FkuzxL8i5/OWdjv2NixIgT6PXkIY2sjXZdnUsA3d7ljRx8Ybt
        MAvOw1Cg+E7IrpTWpkoeK7xVpKtoiB5A9vgJE+NWrlcO66tbHHruPGog7OwoyWP3VO2EhF
        R4Czi9YbnnLKBCKuyCaRFMByZg0aYz0=
Date:   Sun, 14 May 2023 14:32:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.4-rc2
Message-ID: <20230514123254.GFZGDU9thNmJ4jmf7V@fat_crate.local>
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

please pull a single urgent locking fix for 6.4.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.4_rc2

for you to fetch changes up to 92cc5d00a431e96e5a49c0b97e5ad4fa7536bd4b:

  locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers (2023-05-08 10:58:24 +0200)

----------------------------------------------------------------
- Make sure __down_read_common() is always inlined so that the callers'
  names land in traceevents output instead and thus the blocked function
  can be identified

----------------------------------------------------------------
John Stultz (1):
      locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers

 kernel/locking/rwsem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
