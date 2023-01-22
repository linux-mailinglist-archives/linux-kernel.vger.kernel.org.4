Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54FD676CA0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjAVMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAVMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:01:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E216319
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:01:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACC461EC0441;
        Sun, 22 Jan 2023 13:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674388870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=PKII81MG7lmsoGh0jUh3GaVYqevmClsHgGMpsF9aI9Q=;
        b=DA+W81YXI0P0EKwAqByZ93Uj8L3dTe62TIJNWNrXzgTcejK9oiRKxgkqV/QiGUkObNRspD
        CnKHXSGYRpzyG8DyybxWs9LO7Z2r4AkAK3WqX533aXsUupOylniUzHcWBExxxYxf0zoJNt
        dNzAofUu5Dblq6QstTGywoGuLXOqYZo=
Date:   Sun, 22 Jan 2023 13:01:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.2-rc6
Message-ID: <Y80lgQ26uCQCdG+b@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent perf fixes for 6.2.

Thx.

---

The following changes since commit 5268a2842066c227e6ccd94bac562f1e1000244f:

  perf/x86/intel/uncore: Add Emerald Rapids (2023-01-09 12:00:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc6

for you to fetch changes up to 5a8a05f165fb18d37526062419774d9088c2a9b9:

  perf/x86/intel/cstate: Add Emerald Rapids (2023-01-18 12:42:49 +0100)

----------------------------------------------------------------
- Add Emerald Rapids model support to more perf machinery

----------------------------------------------------------------
Kan Liang (2):
      perf/x86/intel: Add Emerald Rapids
      perf/x86/intel/cstate: Add Emerald Rapids

 arch/x86/events/intel/core.c   | 1 +
 arch/x86/events/intel/cstate.c | 1 +
 2 files changed, 2 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
