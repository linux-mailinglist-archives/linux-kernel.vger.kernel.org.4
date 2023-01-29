Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A667FF74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjA2Noj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjA2Noh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:44:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317F01F905
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:44:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAA451EC0513;
        Sun, 29 Jan 2023 14:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674999874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=pgbQAQjkL59D6mY/N6zg1Km8jdfeZ9ovz0vP3MWXjzo=;
        b=KpxShjjslEQFaKbEuSp43m9z5ZpgLa6ck+Fq0R1ZlrX/8ge76XuxAgGcYrevRUlzN/ajcE
        /glp2ilCIG77h6fkKHO/VjF0LpKWggsUJPYlQSFo2MKWyu1N7IOOYDnkxAyjNauE4IW14/
        qU9rwJSTtsPHX8VDQWkUs4mDBokZRaE=
Date:   Sun, 29 Jan 2023 14:44:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.2-rc6
Message-ID: <Y9Z4QtDi7sdMlnnD@zn.tnic>
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

please pull a single urgent irq fix for 6.2.

Thx.

---

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.2_rc6

for you to fetch changes up to ac8f29aef2f1695956ff6773b33f975290437f29:

  genirq/msi: Free the fwnode created by msi_create_device_irq_domain() (2023-01-17 22:57:04 +0100)

----------------------------------------------------------------
- Cleanup the firmware node for the new IRQ MSI domain properly, to
  avoid leaking memory

----------------------------------------------------------------
Jason Gunthorpe (1):
      genirq/msi: Free the fwnode created by msi_create_device_irq_domain()

 kernel/irq/irqdomain.c | 2 +-
 kernel/irq/msi.c       | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
