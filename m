Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5269D092
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBTPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjBTPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:24:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC007A9B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:24:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 399C91EC04CC;
        Mon, 20 Feb 2023 16:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676906629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=/s67nkNVHqTuf5UpgBU18NmigToUYZLEH7nb9lZ35j4=;
        b=fiUUHc+YBo6z5tr3C98eBRYmDjEY+0LQ1DekTNttlp+IfJQLkQnMA+yVfHe3U3ZFyQV2mW
        TwSrsnl7cn9+mk10MdMyFcyNbnrlVLsDPMGAUXBCr2ed8jsVQ1HBbzhBdxkF4tAOmlGFzX
        aOeoDSAmo4wKZkr9TeV9l6ZNDLAIkFk=
Date:   Mon, 20 Feb 2023 16:23:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/alternatives for v6.3-rc1
Message-ID: <Y/OQgYnbYg0OzUMX@zn.tnic>
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

please pull some x86 alternatives improvements for 6.3.

Thx.

---

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.3_rc1

for you to fetch changes up to 923510c88d2b7d947c4217835fd9ca6bd65cc56c:

  x86/static_call: Add support for Jcc tail-calls (2023-01-31 15:05:31 +0100)

----------------------------------------------------------------
- Teach the static_call patching infrastructure to handle conditional
tall calls properly which can be static calls too

- Add proper struct alt_instr.flags which controls different aspects of
  insn patching behavior

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/alternatives: Add alt_instr.flags

Peter Zijlstra (3):
      x86/alternatives: Introduce int3_emulate_jcc()
      x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
      x86/static_call: Add support for Jcc tail-calls

 arch/x86/include/asm/alternative.h            | 132 +++++++++++++++-----------
 arch/x86/include/asm/text-patching.h          |  31 ++++++
 arch/x86/kernel/alternative.c                 |  76 ++++++++++-----
 arch/x86/kernel/kprobes/core.c                |  38 ++------
 arch/x86/kernel/static_call.c                 |  50 +++++++++-
 tools/objtool/arch/x86/include/arch/special.h |   6 +-
 6 files changed, 218 insertions(+), 115 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
