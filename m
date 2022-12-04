Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8C641D4A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLDNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 08:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLDNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 08:53:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019C13D40
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 05:53:32 -0800 (PST)
Received: from zn.tnic (p200300ea9733e799329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e799:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DE411EC0529;
        Sun,  4 Dec 2022 14:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670162010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=2WAm3Bu3fQoyv6WfX5BaCTG0jKSF+C2DCSKLhMjB4fo=;
        b=fMn3JyKKwU3jIacwXdqlM1GB6qbOhX9HnVoIj3nDm6vYZPybpXqDcqpDpN7IOOB2fUIUTC
        L3SWsYGqECXelgzFKoYtyjEpmB1EkGXl5klue+XOsd2ejRzWJyPO7bYFKvozHS0Ng1IGeD
        F3ia05cE+AD0NbPiPcbldz0mMa1OhfU=
Date:   Sun, 4 Dec 2022 14:53:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for 6.1-rc8
Message-ID: <Y4ymVQuBVF2RZslZ@zn.tnic>
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

please pull a single urgent timers fix for 6.1.

Thx.

---

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.1_rc8

for you to fetch changes up to d9f15a9de44affe733e34f93bc184945ba277e6d:

  Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend" (2022-12-01 12:05:29 +0100)

----------------------------------------------------------------
- Revert a fix to RISC-V timers supposed to address an uncertainty
whether clock events are received during S3 or not which locks up other
RISC-V platforms. The issue will be fixed differently later.

----------------------------------------------------------------
Conor Dooley (1):
      Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend"

 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
