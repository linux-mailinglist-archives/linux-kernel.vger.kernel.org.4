Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73D26C9450
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCZMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCZMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:40:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6824C16
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:40:57 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F75C1EC04CC;
        Sun, 26 Mar 2023 14:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679834456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=2KQJN76mhcj6nBH7HYevzxUnCx+YM+c9VR8TwQzmrYY=;
        b=FAX3BjsBUxhh/eJl2+o3PqphTw1aN7k9BlGPD7RwyV9ex0SfFekYyJkxQVig/gfFnOujiH
        ovE9DmrAiuk2hnDhvBkQaBXvNeuLchMT8e3/hh15qkvXXASigIn+DAKqNMWx8SEmgNxw93
        xOaoLkr0QvRav5ylDRPIwjUXXJ+W7YA=
Date:   Sun, 26 Mar 2023 14:40:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.3-rc4
Message-ID: <20230326124050.GAZCA9Um6kWZByUU2q@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of x86/urgent fixes for 6.3.

Thx.

---

The following changes since commit cbebd68f59f03633469f3ecf9bea99cd6cce3854:

  x86/mm: Fix use of uninitialized buffer in sme_enable() (2023-03-16 12:22:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc4

for you to fetch changes up to 62faca1ca10cc84e99ae7f38aa28df2bc945369b:

  selftests/x86/amx: Add a ptrace test (2023-03-22 11:00:49 -0700)

----------------------------------------------------------------
- Add a AMX ptrace self test

- Prevent a false-positive warning when retrieving the (invalid) address of
  dynamic FPU features in their init state which are not saved in
  init_fpstate at all

- Randomize per-CPU entry areas only when KASLR is enabled

----------------------------------------------------------------
Chang S. Bae (2):
      x86/fpu/xstate: Prevent false-positive warning in __copy_xstate_uabi_buf()
      selftests/x86/amx: Add a ptrace test

Michal Koutný (1):
      x86/mm: Do not shuffle CPU entry areas without KASLR

 arch/x86/kernel/fpu/xstate.c      |  30 +++++------
 arch/x86/mm/cpu_entry_area.c      |   7 +++
 tools/testing/selftests/x86/amx.c | 108 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 126 insertions(+), 19 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
