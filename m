Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06926ECFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjDXNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDXNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:54:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D1CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:54:14 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38C621EC067C;
        Mon, 24 Apr 2023 15:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682344452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=7qRDSbrAxErS2nReaSpGyM5IlA7BO5epqgoryfuspPY=;
        b=njQ05qTe3ShrhFCZ+ZdoWE/AmOymNx0vLdZXge/EUXNumFJ5iwkmoec/f9eq3qFpoWrXHM
        ZtlQVX1QQfDwCYRlO2Le7EDQXmAJMH0LIK2Lr1mzGuY5l7FaNyvvT90Iz9GoXZoPh173wU
        tNck9TQNPLTngLIhPjn4bd4Jevmd+I4=
Date:   Mon, 24 Apr 2023 15:54:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu updates for v6.4-rc1
Message-ID: <20230424135407.GDZEaJ/7ELCwj7rg3W@fat_crate.local>
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

please pull the x86/cpu updates for 6.4.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.4_rc1

for you to fetch changes up to 36168bc061b4368ad19e82b06a6463c95d3bb9a7:

  x86/cpu: Add Xeon Emerald Rapids to list of CPUs that support PPIN (2023-04-05 20:01:52 +0200)

----------------------------------------------------------------
- Add Emerald Rapids to the list of Intel models supporting PPIN

- Finally use a CPUID bit for split lock detection instead of
  enumerating every model

- Make sure automatic IBRS is set on AMD, even though the AP bringup
  code does that now by replicating the MSR which contains the switch

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Make sure EFER[AIBRSE] is set

Fenghua Yu (1):
      x86/split_lock: Enumerate architectural split lock disable bit

Tony Luck (1):
      x86/cpu: Add Xeon Emerald Rapids to list of CPUs that support PPIN

 arch/x86/kernel/cpu/amd.c    | 11 +++++++++
 arch/x86/kernel/cpu/bugs.c   | 10 +-------
 arch/x86/kernel/cpu/common.c |  1 +
 arch/x86/kernel/cpu/cpu.h    |  8 ++++++
 arch/x86/kernel/cpu/intel.c  | 59 +++++++++++++++++---------------------------
 5 files changed, 43 insertions(+), 46 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
