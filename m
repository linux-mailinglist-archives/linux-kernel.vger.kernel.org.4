Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9F69C902
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjBTKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBTKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:50:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6A416305
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:50:44 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 307981EC04CC;
        Mon, 20 Feb 2023 11:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676890243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=TOppnNc4tBGmBSdjmsVIGSbEoHSvcNOuM7aGlgKJqUQ=;
        b=Tl4PScXtLocOWlLQIRr/ggQMGk1C7tBm06MsxwllK5dD8U+gBex7P+mXEAh1v6dDSOK1Ro
        1RpSnGFRN506r1lgwKjVEwjSu5mhbuxCjLb48hT+KDMyJtzc8wvpGB4VFtZDqNpyIqz/3B
        7YR4PAVJ3VBVuLyd+eej9S4pOXIqvJE=
Date:   Mon, 20 Feb 2023 11:50:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 6.3
Message-ID: <Y/NQfnRa82W0vCoy@zn.tnic>
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

please pull some x86 RAS updates for 6.3.

Thx.

---

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.3_rc1

for you to fetch changes up to 8a01ec97dc066009dd89e43bfcf55644f2dd6d19:

  x86/mce: Mask out non-address bits from machine check bank (2023-01-10 11:47:07 +0100)

----------------------------------------------------------------
- Add support for reporting more bits of the physical address on error,
  on newer AMD CPUs

- Mask out bits which don't belong to the address of the error being
  reported

----------------------------------------------------------------
Smita Koralahalli (2):
      x86/mce: Define a function to extract ErrorAddr from MCA_ADDR
      x86/mce: Add support for Extended Physical Address MCA changes

Tony Luck (1):
      x86/mce: Mask out non-address bits from machine check bank

 arch/x86/include/asm/mce.h         |  3 +++
 arch/x86/kernel/cpu/mce/amd.c      | 12 +++--------
 arch/x86/kernel/cpu/mce/core.c     | 32 ++++++++++-----------------
 arch/x86/kernel/cpu/mce/internal.h | 44 ++++++++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.c          |  2 +-
 5 files changed, 62 insertions(+), 31 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
