Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30688701D24
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjENLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjENLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:47:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB51BFB
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 04:47:52 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 829D81EC03CA;
        Sun, 14 May 2023 13:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684064871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=chPdmNYvE50R9rUNje5D2NJgSyCY6Em7ZT0ESOg3B0U=;
        b=m8pMd/iN/gHM6I2FJeVXDDDLf5rFY4GNoqF8RDy8Q4/YRyb/SCW4qGxlMJBD8QPw3LitT/
        bz/TeqaYtXQG4uGsTuexc6rFCuZpLNUaJFIYc5CBTmbLrFWC1f6xXijOk8c/CXoAluQLT3
        MvyBm45inAahLAl37XhR6HbH5OlQk/s=
Date:   Sun, 14 May 2023 13:47:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.4-rc2
Message-ID: <20230514114747.GCZGDKY0ismqgQJXIt@fat_crate.local>
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

please pull a couple of x86/urgent fixes for 6.4.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4_rc2

for you to fetch changes up to 7d8accfaa0ab65e4282c8e58950f7d688342cd86:

  hwmon: (k10temp) Add PCI ID for family 19, model 78h (2023-05-08 11:36:19 +0200)

----------------------------------------------------------------
- Add the required PCI IDs so that the generic SMN accesses provided by
  amd_nb.c work for drivers which switch to them. Add a PCI device ID
  to k10temp's table so that latter is loaded on such systems too

----------------------------------------------------------------
Mario Limonciello (2):
      x86/amd_nb: Add PCI ID for family 19h model 78h
      hwmon: (k10temp) Add PCI ID for family 19, model 78h

 arch/x86/kernel/amd_nb.c | 2 ++
 drivers/hwmon/k10temp.c  | 1 +
 include/linux/pci_ids.h  | 1 +
 3 files changed, 4 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
