Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783C5721833
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjFDP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFDP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:29:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F082CA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:29:50 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F1D71EC0683;
        Sun,  4 Jun 2023 17:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685892589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=2JhXyOfrE12rw0X1ImypxS0UQbXXSprS/uY05wp6fqc=;
        b=Z38K8UjsHXFeD79dSHACJVgDlP9hjP+F12qD5rCCIQ40exHjXamA1RCANeoLDv5XRXbvjC
        qjJlK4VMY8g1ayPlDUjJQ7dSNJe+e1CFKrUfUnnmbW9xCPSsxj6DXgRPsRhdXZZJYbiBGJ
        1bZAnCg4fZNleMETQF+Ucm0kBmoJn9I=
Date:   Sun, 4 Jun 2023 17:29:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.4-rc5
Message-ID: <20230604152943.GAZHyt59c0xJh2YtBq@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a urgent irqchip fix by way of Marc Zyngier, for 6.4.

Thx.

---

The following changes since commit 4115af49d2c24e840461fb83027315e2d2de6db4:

  Merge tag 'irqchip-fixes-6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2023-05-22 08:11:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.4_rc5

for you to fetch changes up to 2d5b205dfa32b5f0f357ebc9db73931d2186391e:

  Merge tag 'irqchip-fixes-6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2023-05-31 19:42:53 +0200)

----------------------------------------------------------------
- Fix open firmware quirks validation so that they don't get applied
  wrongly

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic: Correctly validate OF quirk descriptors

Thomas Gleixner (1):
      Merge tag 'irqchip-fixes-6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

 drivers/irqchip/irq-gic-common.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
