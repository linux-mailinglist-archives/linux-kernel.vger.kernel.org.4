Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E16ED0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjDXOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjDXOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:52:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C183EE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:51:55 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9A961EC01E0;
        Mon, 24 Apr 2023 16:51:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682347913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=kRfXjm6oJuFn21YYJPdLjS5GN6k0sWQs8QRAEWCIZDI=;
        b=pb9Y6jHjTQOnwMVfCsNc52yDTpNVx5abZlKlrpAXwia02hSLd3vZB13oqBSg3q/HbX+nte
        5JlFHpDnMWkT8kglLsp6Hl2C/QamFH0tPopGqyYKu0xiq0VgeOIwtSKYfrD+NCtoTmISn8
        4ICaxce8yCdwMfvcqPU3ivsqe1Zd4rM=
Date:   Mon, 24 Apr 2023 16:51:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt updates for v6.4-rc1
Message-ID: <20230424145148.GFZEaXhA07fMrO9ooE@fat_crate.local>
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

please pull a couple of x86/paravirt updates for 6.4.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.4_rc1

for you to fetch changes up to 11af36cb898123fd4e0034f1bc6550aedcc87800:

  x86/paravirt: Convert simple paravirt functions to asm (2023-03-17 13:29:47 +0100)

----------------------------------------------------------------
- Convert a couple of paravirt callbacks to asm to prevent
  -fzero-call-used-regs builds from zeroing live registers because
  paravirt hides the CALLs from the compiler so latter doesn't know
  there's a CALL in the first place

- Merge two paravirt callbacks into one, as their functionality is
  identical

----------------------------------------------------------------
Juergen Gross (2):
      x86/paravirt: Merge activate_mm() and dup_mmap() callbacks
      x86/paravirt: Convert simple paravirt functions to asm

 arch/x86/include/asm/mmu_context.h    | 11 ++---------
 arch/x86/include/asm/paravirt.h       | 14 +++-----------
 arch/x86/include/asm/paravirt_types.h | 15 +++++++++------
 arch/x86/kernel/paravirt.c            | 30 +++++++-----------------------
 arch/x86/mm/init.c                    |  2 +-
 arch/x86/xen/mmu_pv.c                 | 12 ++----------
 6 files changed, 24 insertions(+), 60 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
