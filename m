Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0964B7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLMOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLMOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:53:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06892622
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:53:05 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8179D1EC0513;
        Tue, 13 Dec 2022 15:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670943184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=kVqHCS/WBqVSsA7XfLBebqQZZG7rBmhE1irZlWuGx4E=;
        b=YOUv4sLGRNtj/brthyvAExqo4aHksoP/VXu/c8Y9ynurladBb1gTMM74y3VfFsKFfk2mYn
        SeIQkS5Q33gD/Im/11DpGCNBjBBwZKIoSr8gJMCJ2CGdXkqrWTSlmpOziFkdrWLwXW3j20
        x3j236uD2p9BE5SM4lRH54KJHcz/mBk=
Date:   Tue, 13 Dec 2022 15:53:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.2
Message-ID: <Y5iR0Jnh/1auvH5e@zn.tnic>
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

please pull two small x86/sev fixes for 6.2.

Thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.2

for you to fetch changes up to 2874529b3513bdc90299c90f40713602da685e35:

  virt/sev-guest: Add a MODULE_ALIAS (2022-11-08 15:54:34 +0100)

----------------------------------------------------------------
- Two minor fixes to the sev-guest driver

----------------------------------------------------------------
Cole Robinson (1):
      virt/sev-guest: Add a MODULE_ALIAS

Rafael Mendonca (1):
      virt/sev-guest: Remove unnecessary free in init_crypto()

 drivers/virt/coco/sev-guest/sev-guest.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
