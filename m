Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727DC66B0D5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAOMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAOMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:00:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653B98
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 04:00:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 134EF1EC01B7;
        Sun, 15 Jan 2023 13:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673784033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=f63fuRhyer5QOihlUykuO+2+2w/JRZDJBfXRSMw6+SA=;
        b=RYUS8u9kdVgzB0glM/fVfuwDA6SLJU0ANdz4Sbmweba9+rtGgdUM95SUa/6RXVSIne0oUi
        TB/6BxFq2g5b1M+z5UxQeDwgyEAgKaOlkBUVKRWxlXRkGEFBc9/jWrRZJ20APCMBjMDBuS
        rsgJIy3SL5DAWUIbZ5PFcw07jh5p40Y=
Date:   Sun, 15 Jan 2023 13:00:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/urgent for v6.2-rc4
Message-ID: <Y8Pq3aWbIf8ewu31@zn.tnic>
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

pls pull a single objtool fix for 6.2.

Thx.

---

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v6.2_rc4

for you to fetch changes up to cad90e5381d840cf2296aaac9b3eff71a30b7c5b:

  objtool: Tolerate STT_NOTYPE symbols at end of section (2023-01-09 17:53:46 +0100)

----------------------------------------------------------------
- Have objtool ignore STT_NOTYPE symbols at the end of a section

----------------------------------------------------------------
Nicholas Piggin (1):
      objtool: Tolerate STT_NOTYPE symbols at end of section

 tools/objtool/check.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
