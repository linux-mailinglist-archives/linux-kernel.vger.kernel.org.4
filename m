Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7C6DBF9D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDIKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 06:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 06:54:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7C3C12
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 03:54:56 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FAEF1EC042D;
        Sun,  9 Apr 2023 12:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681037695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=m1Fz184pyoEDvYgV2tyG3hJetkl4tkxy3KN+FQDAjbY=;
        b=OebuHSoC/uoQWRYXLJPDisBcz2Dza8tbXVygml6wMMwR3FgzB+61Hh6syl0CGUEinnz+4p
        m8+eWyV0Zly6gvqmt99A2+SNAGSJKPxY+/T3/UvB7x3XEpCNyuH7Tk64UITp43np49tGF/
        2w8Tk/i8vJa+hN4pV3LBAi5tvOZ7ae4=
Date:   Sun, 9 Apr 2023 12:54:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.3-rc6
Message-ID: <20230409105446.GAZDKZdk7yLXG227S5@fat_crate.local>
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

please pull a couple of urgent x86 fixes for 6.3.

Thx.

---

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc6

for you to fetch changes up to 81515ecf155a38f3532bf5ddef88d651898df6be:

  x86/cpu: Add model number for Intel Arrow Lake processor (2023-04-05 13:36:26 +0200)

----------------------------------------------------------------
- Add a new Intel Arrow Lake CPU model number

- Fix a confusion about how to check the version of the ACPI spec which
  supports a "online capable" bit in the MADT table which lead to
  a bunch of boot breakages with Zen1 systems and VMs

----------------------------------------------------------------
Eric DeVolder (1):
      x86/acpi/boot: Correct acpi_is_processor_usable() check

Mario Limonciello (1):
      x86/ACPI/boot: Use FADT version to check support for online capable

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake processor

 arch/x86/include/asm/intel-family.h | 2 ++
 arch/x86/kernel/acpi/boot.c         | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
