Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5EB64B7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiLMOup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:50:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0816110B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:50:42 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EE5E1EC0513;
        Tue, 13 Dec 2022 15:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670943041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=II9pl7Gvsnr+Fdcd60jkTeji1fu5rXO3AuJnue+b8MU=;
        b=O6YgRBZN0LgaePMqEU/Y/uNg1lnnmHsfYfyCiaZynhVu8wPgcf21/l0m4W3TTod/ZrQcak
        N2wnmZG9AMXd6Pi1PDaYSmJFaBG/NV/1uLoaRtofwSxddkyGzh4BQMBflb5h9dkw5tbxGk
        KY8PDHz3Gaf9jXibsmJpaJ3ujN8nlaA=
Date:   Tue, 13 Dec 2022 15:50:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt for v6.2
Message-ID: <Y5iRQGixyy51mBLB@zn.tnic>
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

please pull a single x86/paravirt cleanup for 6.2.

Thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.2

for you to fetch changes up to 00e8f7153bcdecc5c31e307c7c17fecf42308fc4:

  x86/paravirt: Remove clobber bitmask from .parainstructions (2022-10-17 10:44:30 +0200)

----------------------------------------------------------------
- Simplify paravirt patching machinery by removing the now unused
clobber mask

----------------------------------------------------------------
Kees Cook (1):
      x86/paravirt: Remove clobber bitmask from .parainstructions

 arch/x86/include/asm/paravirt_types.h | 61 +++++++----------------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
