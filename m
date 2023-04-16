Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002066E3802
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjDPMeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDPMeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:34:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE32127
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:34:14 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF42F1EC0691;
        Sun, 16 Apr 2023 14:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681648452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=WAnbRfVoXqO7IvMEUDHdoaHD4nOKKWCYtAZ1bqH7QoE=;
        b=lkqP3gJSgRfnW6EfkK349M6QeaVr7c79hfy1n3JoM4FemuzkAUgXhvSzkhH/dO1Gm1YVE3
        q7B1nvI197C4H6h5kFipsuGBJ9E3JKTdRSFU0KaDBuHJ0iG/0XIPQB7uyBuYqpU6pxW6G+
        s+81t/WMIAbJymx5XXxXjuIm2kUBHNE=
Date:   Sun, 16 Apr 2023 14:34:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.3-rc7
Message-ID: <20230416123412.GDZDvrRCv9VvvmXuPz@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull an urgent scheduler fix for 6.3.

Thx.

---

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.3_rc7

for you to fetch changes up to 91dcf1e8068e9a8823e419a7a34ff4341275fb70:

  sched/fair: Fix imbalance overflow (2023-04-12 16:46:30 +0200)

----------------------------------------------------------------
- Do not pull tasks to the local scheduling group if its average load is
  higher than the average system load

----------------------------------------------------------------
Vincent Guittot (1):
      sched/fair: Fix imbalance overflow

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
