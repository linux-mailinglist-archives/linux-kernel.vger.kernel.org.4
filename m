Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5964A864
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiLLUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiLLUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:05:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42551178A0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:05:47 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9086C1EC069C;
        Mon, 12 Dec 2022 21:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670875544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=jlQcQtosWgVLltDqKXLfrqn4T86TR6jlKeOQ7vGHwYM=;
        b=MZSlkLwz3pKd064Zoc6XxwdihUpHC9i61S1pTDCSuKTzs9ECJirBIiiooz94ZRJKaBBTaS
        CzLC925f9JgwZ+LUWwaK6CLCRCvnXDVFADGTQOLtmzF58eMl9TZJKDSohSb/UGg5JTDnrO
        gMI/eEL55O6gXXwT0fYnhCUKwJd60iA=
Date:   Mon, 12 Dec 2022 21:05:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.2
Message-ID: <Y5eJk3Tqh3Ip3oCx@zn.tnic>
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

please pull some updates to the RAS side of things, for 6.2.

Thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.2

for you to fetch changes up to 50865c14f34edbd03f8113147fac069b39f4e390:

  RAS: Fix return value from show_trace() (2022-10-31 18:55:18 +0100)

----------------------------------------------------------------
- Fix confusing output from /sys/kernel/debug/ras/daemon_active

- Add another MCE severity error case to the Intel error severity
table to promote UC and AR errors to panic severity and remove the
corresponding code condition doing that.

- Make sure the thresholding and deferred error interrupts on AMD SMCA
systems clear the all registers reporting an error so that there are no
multiple errors logged for the same event

----------------------------------------------------------------
Tony Luck (2):
      x86/mce: Use severity table to handle uncorrected errors in kernel
      RAS: Fix return value from show_trace()

Yazen Ghannam (1):
      x86/MCE/AMD: Clear DFR errors found in THR handler

 arch/x86/kernel/cpu/mce/amd.c      | 33 ++++++++++++++++++++-------------
 arch/x86/kernel/cpu/mce/severity.c |  8 +++++---
 drivers/ras/debugfs.c              |  2 +-
 3 files changed, 26 insertions(+), 17 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
