Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0CE6C01EA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCSNEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCSNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:04:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DFD322
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:04:10 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA7CD1EC0657;
        Sun, 19 Mar 2023 14:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679231049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=GYIjtVSHjCLan5d/fozqT0mZqE4Mua2bYWSBgO3KBUo=;
        b=nbsX+tdZIlgToelYrtCo0jzU9VVo/Xsz8jWOq5Is9SqXKmdvnH7jcR+MO7x6EMTOIU23lm
        RQF65iv4VrnCGkCpbjwG/JeJDqaKTv/ieK8RM7DJy5V4Ej1r31VIoA9IbmFQNpxe1d+7l2
        AQkJXIE/c3BZj5scrOSVz1G/yDdomVU=
Date:   Sun, 19 Mar 2023 14:04:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS/urgent for v6.3-rc3
Message-ID: <20230319130408.GCZBcISGmEgDSRM50y@fat_crate.local>
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

please pull an urgent RAS fix for 6.3.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_urgent_for_v6.3_rc3

for you to fetch changes up to 4783b9cb374af02d49740e00e2da19fd4ed6dec4:

  x86/mce: Make sure logged MCEs are processed after sysfs update (2023-03-12 21:12:21 +0100)

----------------------------------------------------------------
- Flush out logged errors immediately after MCA banks configuration
  changes over sysfs have been done instead of waiting until something
  else triggers the workqueue later - another error or the polling
  interval cycle is reached

----------------------------------------------------------------
Yazen Ghannam (1):
      x86/mce: Make sure logged MCEs are processed after sysfs update

 arch/x86/kernel/cpu/mce/core.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
