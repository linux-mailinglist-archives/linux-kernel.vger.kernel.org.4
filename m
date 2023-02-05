Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0E68AF04
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 10:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBEJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 04:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBEJh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 04:37:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF81B557
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 01:37:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F116E1EC056A;
        Sun,  5 Feb 2023 10:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675589877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=iNRv+XNFUGpbbFtdbMf5SZlorQmjxBgkmZ9DbjRHv74=;
        b=HDBv5wfoEIfdlpB+hujBm0fh9txJprpSkD53FtoUvdTqELNlRp9X9ulAT8TP7kx5cHY5XQ
        Xv8K31AOCCnMMQAE26FuLOcKCqCHWYFkA1dtZ+mAbWDFn36zDApG091VgQE5nD3td1N/TF
        H0ty+czS9D5ukE2UgwvWMflLd6Z4oIM=
Date:   Sun, 5 Feb 2023 10:37:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.2-rc7
Message-ID: <Y9949A/s6DB4oVwF@zn.tnic>
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

please pull a single urgent x86 fix for 6.2.

Thx.

---

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc7

for you to fetch changes up to 9d2c7203ffdb846399b82b0660563c89e918c751:

  x86/debug: Fix stack recursion caused by wrongly ordered DR7 accesses (2023-01-31 12:51:19 +0100)

----------------------------------------------------------------
- Prevent the compiler from reordering accesses to debug regs which could cause
  a #VC exception in SEV-ES guests at the wrong place in the NMI handling path

----------------------------------------------------------------
Joerg Roedel (1):
      x86/debug: Fix stack recursion caused by wrongly ordered DR7 accesses

 arch/x86/include/asm/debugreg.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
