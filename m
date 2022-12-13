Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D263B64B433
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiLML2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiLML2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:28:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E2B0B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:27:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A8C01EC069A;
        Tue, 13 Dec 2022 12:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670930855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=cFQ7Ub6UfZq1WHS9vQm/3rim4lkYbspu08P3+sMl/Uo=;
        b=XyUIimsiNAApQmJhaxHzA382YFUZzvbMPxvkMbGyzrqtC+JgZooQHtIoGWAeanHHqelkgo
        NBY8dTrHf2LrEQxRdI5IjCEyduJiLzv2r5umFII+P1Tf6yEmrUc7rHoGt/H2u86PtFBNQv
        dG0wK14QRQOHBVX3VhQM81nvDaiR7F8=
Date:   Tue, 13 Dec 2022 12:27:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/asm for v6.2
Message-ID: <Y5hhoqZ7kWJ5KHMx@zn.tnic>
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

please pull a single x86/asm improvement for 6.2.

Thx.

---

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v6.2

for you to fetch changes up to bce5a1e8a34006a5e80213ede5e5c465d53f1dce:

  x86/mem: Move memmove to out of line assembler (2022-11-01 15:44:07 -0700)

----------------------------------------------------------------
- Move the 32-bit memmove() asm implementation out-of-line in order to
fix a 32-bit full LTO build failure with clang where it would fail at
register allocation. Move it to an asm file and clean it up while at it,
similar to what has been already done on 64-bit

----------------------------------------------------------------
Nick Desaulniers (1):
      x86/mem: Move memmove to out of line assembler

 arch/x86/lib/Makefile     |   1 +
 arch/x86/lib/memcpy_32.c  | 187 -------------------------------------------
 arch/x86/lib/memmove_32.S | 200 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/memcpy_kunit.c        |  22 +++++
 4 files changed, 223 insertions(+), 187 deletions(-)
 create mode 100644 arch/x86/lib/memmove_32.S

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
