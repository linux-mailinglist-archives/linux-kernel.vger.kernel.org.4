Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD326EBE82
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDWKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:21:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC9E74
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 03:21:11 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5118C1EC026E;
        Sun, 23 Apr 2023 12:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682245269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=WUtXUBJ3iCjRpGVEMPw6AVqWffxZjWzgVZjREn/sSpA=;
        b=AiwwzYGfvf6ZXotmG6j+f23qtzofRhteRhdqAXld/qNZr5Mn6BH55XN5pZmgA1bQm8FCXm
        QVIa99dkIGlYt/CMyMRl3k1Sbi73NPrjK+fEmfchX3CzAXsbRF7bsiCUbbm1B9xIr93xQx
        eKcwiXFMMMjMs4JMc3rAXsH9SFJfFQk=
Date:   Sun, 23 Apr 2023 12:21:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.3
Message-ID: <20230423102104.GBZEUGkAvxx4Yx/Ehc@fat_crate.local>
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

please pull one last urgent MSI fix for 6.3.

Thx.

---

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.3

for you to fetch changes up to e3c026be4d3ca046799fde55ccbae9d0f059fb93:

  PCI/MSI: Remove over-zealous hardware size check in pci_msix_validate_entries() (2023-04-16 14:11:51 +0200)

----------------------------------------------------------------
- Remove an over-zealous sanity check of the array of MSI-X vectors to
  be allocated for a device

----------------------------------------------------------------
Thomas Gleixner (1):
      PCI/MSI: Remove over-zealous hardware size check in pci_msix_validate_entries()

 drivers/pci/msi/msi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
