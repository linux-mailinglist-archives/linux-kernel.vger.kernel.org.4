Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A686C945B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCZMzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:55:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47392421C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:55:10 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 719261EC054E;
        Sun, 26 Mar 2023 14:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679835308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=zjyOtPjSMWNvxwQJSBsC4Fciu0/QGTaW9h4odJiVT8M=;
        b=DCv/GHVkk1mPgPrERUyZWlG6S7TgQdXJ/sHclKyxgd/55qbgEjJixgmdTPyZ2HZtc1OCwd
        /ya6wlynumqjsSQMMp502LmSjDvRcGFqjX5fokV6Pr+66A6mrISBRjTjwdEYmFPHrjeFb1
        8xb9wCvIzX6gAKRuUFq0WoUhAVz1GWY=
Date:   Sun, 26 Mar 2023 14:55:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.3-rc4
Message-ID: <20230326125508.GCZCBArK0pT7CwrpRt@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent perf fix for 6.3.

Thx.

---

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc4

for you to fetch changes up to 263f5ecaf7080513efc248ec739b6d9e00f4129f:

  perf/x86/amd/core: Always clear status for idx (2023-03-21 14:43:05 +0100)

----------------------------------------------------------------
- Properly clear perf event status tracking in the AMD perf event
  overflow handler

----------------------------------------------------------------
Breno Leitao (1):
      perf/x86/amd/core: Always clear status for idx

 arch/x86/events/amd/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
