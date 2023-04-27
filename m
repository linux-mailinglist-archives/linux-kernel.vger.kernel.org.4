Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819F6F07D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjD0PCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbjD0PCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:02:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327A1A2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:02:12 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 363851EC0529;
        Thu, 27 Apr 2023 17:02:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682607731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=FPDj5Tpp3Im7RrjtQivimG81M9Ie5yFwjX4bQXA+V/0=;
        b=PIZeZybG0EGeVLg6zwZBg+uwh1dQDDC7H4JChEJfMuvUYLhe4abdS9Y9/4tdkY9lLjaRm1
        THySwmTO7scfyn27GFy2CJTI/4OWMb/1SkfZKJcPrO3ed3WZqnoxFhX9B5qV+Gj9AlyU59
        u/i/iJboM/wbqGQy340y8rDx95yeFjw=
Date:   Thu, 27 Apr 2023 17:01:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.4
Message-ID: <20230427150153.GBZEqOYe5N/NbeqsaQ@fat_crate.local>
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

please pull my favourite tip branch: the janitorial pile which cleans
up stuff. All for 6.4.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.4_rc1

for you to fetch changes up to 5462ade6871e96646502cc95e7e05f0ab4fc84de:

  x86/boot: Centralize __pa()/__va() definitions (2023-04-04 13:42:37 -0700)

----------------------------------------------------------------
- Unify duplicated __pa() and __va() definitions

- Simplify sysctl tables registration

- Remove unused symbols

- Correct function name in comment

----------------------------------------------------------------
Andy Shevchenko (1):
      x86/platform/intel-mid: Remove unused definitions from intel-mid.h

Ira Weiny (1):
      x86/uaccess: Remove memcpy_page_flushcache()

Jingyu Wang (1):
      x86/entry: Change stale function name in comment to error_return()

Kirill A. Shutemov (1):
      x86/boot: Centralize __pa()/__va() definitions

Luis Chamberlain (2):
      x86: Simplify one-level sysctl registration for abi_table2
      x86: Simplify one-level sysctl registration for itmt_kern_table

 arch/x86/boot/compressed/ident_map_64.c |  8 --------
 arch/x86/boot/compressed/misc.h         |  9 +++++++++
 arch/x86/boot/compressed/sev.c          |  2 --
 arch/x86/entry/entry_64.S               |  2 +-
 arch/x86/entry/vdso/vdso32-setup.c      | 11 +----------
 arch/x86/include/asm/intel-mid.h        | 21 ---------------------
 arch/x86/include/asm/uaccess_64.h       |  2 --
 arch/x86/kernel/itmt.c                  | 11 +----------
 arch/x86/lib/usercopy_64.c              |  9 ---------
 9 files changed, 12 insertions(+), 63 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
