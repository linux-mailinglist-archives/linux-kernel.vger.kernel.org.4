Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71C6ECFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDXOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:00:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D12CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:00:31 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A8E21EC067C;
        Mon, 24 Apr 2023 16:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682344829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=cZ3obAoi58TRICJuhY8G00STKxlvKET7rol2j+M1OTU=;
        b=PwbgK/4cajdd+sOmHOWBNuEwVUi07GxJLyoaTqzLrVRJqbsjEt6pkXDA552m8wxaGZY/Fb
        ir5M9T5ZFEjB2rZaWXo+XPWhDwUoewUzS5X7DWLXuNoa5ztm9wQ9BlGrs4tzic4jIqYz/N
        +I9cWRoduoxhM6iCSmw1bgmuodZ9u2o=
Date:   Mon, 24 Apr 2023 16:00:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc updates for v6.4-rc1
Message-ID: <20230424140029.GEZEaLfYPda4W38IHj@fat_crate.local>
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

please pull the pile of miscellaneous x86 updates for 6.4.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.4_rc1

for you to fetch changes up to 5910f06503aae3cc4890e562683abc3e38857ff9:

  MAINTAINERS: Add x86 hardware vulnerabilities section (2023-03-10 11:13:30 +0100)

----------------------------------------------------------------
- Add a x86 hw vulnerabilities section to MAINTAINERS so that the folks
  involved in it can get CCed on patches

- Add some more CPUID leafs to the kcpuid tool and extend its
  functionality to be more useful when grepping for CPUID bits

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      tools/x86/kcpuid: Dump the CPUID function in detailed view

Josh Poimboeuf (1):
      MAINTAINERS: Add x86 hardware vulnerabilities section

Terry Bowman (2):
      tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007
      tools/x86/kcpuid: Update AMD leaf Fn80000001

 MAINTAINERS                     | 11 ++++++++
 tools/arch/x86/kcpuid/cpuid.csv | 61 +++++++++++++++++++++++++++++++++++++----
 tools/arch/x86/kcpuid/kcpuid.c  | 32 ++++++++++++++++-----
 3 files changed, 92 insertions(+), 12 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
