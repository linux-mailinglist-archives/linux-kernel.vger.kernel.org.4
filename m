Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C864A88B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiLLUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiLLUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:13:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78F18E0A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:13:02 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE2981EC069C;
        Mon, 12 Dec 2022 21:12:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670875980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=cqJgmQMYmHFf0BNUVp+gstAYUNpjVNWOBmUyvP0UhuA=;
        b=UmgA2yqMFwQCXQ6P6siSbvRL3QhpBPjsRidEoU9EL2mKGxJD9xRgKxJyAs7zWdVdWaOWLa
        YaElk8Gl+Q1vnEo1OHICtNRERmtFARn0cvfiFnIZRa1YmST1yjBGoyZRF65HZullcqhaJs
        UJ4JXoRediQUto+1YyIQd1Vf6VYq69U=
Date:   Mon, 12 Dec 2022 21:12:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/alternatives for v6.2
Message-ID: <Y5eLSzV52mf/NySl@zn.tnic>
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

please pull a single alternatives patching fix for modules, for 6.2.

Thx.

---

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.2

for you to fetch changes up to be84d8ed3f04e9154a3a55e29a27dcd416f05b31:

  x86/alternative: Consistently patch SMP locks in vmlinux and modules (2022-11-22 15:16:16 +0100)

----------------------------------------------------------------
- Have alternatives patch the same sections in modules as in vmlinux

----------------------------------------------------------------
Julian Pidancet (1):
      x86/alternative: Consistently patch SMP locks in vmlinux and modules

 arch/x86/kernel/module.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
