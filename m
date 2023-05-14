Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DEF701D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjENMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjENMS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:18:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136C26A1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:18:55 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 763A01EC03CA;
        Sun, 14 May 2023 14:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684066734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=qTXktbqXS45MBDFBy/187juUSotYRCIXBGZUvrruIIU=;
        b=TjpOF1rU3KkhiwbWz3TlG2nrQEaQMpkdPd234DursV228WD7OIiJryWc9zP4uqbhLHOfHv
        +DtQa1+Ksvbnh0/3ClSE4QmmQE1qz0E3CTE+U4PhKsOLtE/oQzxAV1ZVpaSMirPGztpVG1
        gqzoSc5mPNPutNSWFqrM6MB//8vUkZg=
Date:   Sun, 14 May 2023 14:18:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.4-rc2
Message-ID: <20230514121850.GEZGDRqgvc53SmWNDS@fat_crate.local>
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

please pull a couple of urgent perf fixes for 6.4.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.4_rc2

for you to fetch changes up to b752ea0c28e3f7f0aaaad6abf84f735eebc37a60:

  perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG (2023-05-08 10:58:27 +0200)

----------------------------------------------------------------
- Make sure the PEBS buffer is flushed before reprogramming the hardware
  so that the correct record sizes are used

- Update the sample size for AMD BRS events

- Fix a confusion with using the same on-stack struct with different
  events in the event processing path

----------------------------------------------------------------
Kan Liang (1):
      perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG

Namhyung Kim (1):
      perf/x86: Fix missing sample size update on AMD BRS

Yang Jihong (1):
      perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()

 arch/x86/events/core.c            |  6 ++---
 arch/x86/events/intel/ds.c        | 56 ++++++++++++++++++++++-----------------
 arch/x86/include/asm/perf_event.h |  3 +++
 kernel/events/core.c              | 14 +++++++++-
 4 files changed, 50 insertions(+), 29 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
