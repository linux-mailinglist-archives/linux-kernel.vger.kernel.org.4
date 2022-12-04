Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE991641D55
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 15:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLDOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 09:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiLDOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 09:04:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DDF15811
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 06:04:21 -0800 (PST)
Received: from zn.tnic (p200300ea9733e799329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e799:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BF3A1EC06A7;
        Sun,  4 Dec 2022 15:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670162660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=XJkxRxWDE1af5YcVu3KMDkR2MCkalKSBSM39S0EjwwU=;
        b=Tr9ttFAk//DWS0BQsRsv9iMUqw/OEtsRiMbnRKNZfXTWMkyKLJNHVtmO7s4PQVU0UK6K0r
        OtFXGfEKWLVIvUtFVntIzNxc/Gpr/HLM3nRu/0O1rGhgF8IS+Zvzw9Hab/wGbfgJoQtKe2
        +LCcnkHbxoddTEdQbKDjj77A051oY9Q=
Date:   Sun, 4 Dec 2022 15:04:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 6.1-rc8
Message-ID: <Y4yo4EiAIGASFgX1@zn.tnic>
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

please pull a single urgent perf fix for 6.1.

Thx.

---

The following changes since commit 030a976efae83f7b6593afb11a8254d42f9290fe:

  perf: Consider OS filter fail (2022-11-24 10:12:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc8

for you to fetch changes up to 517e6a301f34613bff24a8e35b5455884f2d83d8:

  perf: Fix perf_pending_task() UaF (2022-11-29 17:42:49 +0100)

----------------------------------------------------------------
- Fix a use-after-free case where the perf pending task callback would
see an already freed event

----------------------------------------------------------------
Peter Zijlstra (1):
      perf: Fix perf_pending_task() UaF

 kernel/events/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
