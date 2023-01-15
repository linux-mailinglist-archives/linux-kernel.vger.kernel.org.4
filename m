Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90566B0F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjAOMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjAOMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:23:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05F4EF5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 04:23:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8108B1EC01E0;
        Sun, 15 Jan 2023 13:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673785408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=eVqigl3LcTOZSwdoHVHXY+3FyyUxSxXfydlJLxZ8mMM=;
        b=lm6gy7OOsP/lGyI26i4tKEXo9zin5vUM712oKmYye3D2ZiVzch00HS2HgV3EJ+DCZ06sLP
        RpeZdEhH2Uv8eGavxZx6l0NAYc2WZKjBT6w/qbbeKRsh3t/OHghsR0+4hTx/csM4qvsOQk
        bX4PNnybs+IZFfX5reBZIQf+pWmFVGE=
Date:   Sun, 15 Jan 2023 13:23:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.2-rc4
Message-ID: <Y8PwPKu2/SfWMdn6@zn.tnic>
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

please pull a couple of urgent perf fixes for 6.2.

Thx.

---

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc4

for you to fetch changes up to 5268a2842066c227e6ccd94bac562f1e1000244f:

  perf/x86/intel/uncore: Add Emerald Rapids (2023-01-09 12:00:58 +0100)

----------------------------------------------------------------
- Add new Meteor Lake and Emerald Rapids support to the model checking
  and detection logic

----------------------------------------------------------------
Kan Liang (4):
      perf/x86/cstate: Add Meteor Lake support
      perf/x86/msr: Add Meteor Lake support
      perf/x86/msr: Add Emerald Rapids
      perf/x86/intel/uncore: Add Emerald Rapids

 arch/x86/events/intel/cstate.c | 21 ++++++++++++---------
 arch/x86/events/intel/uncore.c |  1 +
 arch/x86/events/msr.c          |  3 +++
 3 files changed, 16 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
