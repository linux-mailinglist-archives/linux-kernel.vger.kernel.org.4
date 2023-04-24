Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA76ECE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjDXNde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjDXNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:33:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9C83C2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:32:56 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85F7C1EC05DE;
        Mon, 24 Apr 2023 15:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682343155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=nCGECdLlWbF9Mm2/K5AC4sr2AMlob7cAwjaQtjwS9e4=;
        b=C/4vVRJcCO5GUHy74c/RgFe/pd4yOqjW6+Olm7TIRCUChPWJNizpwcXU0tmUDWM2JYKMNf
        9Kw55Eq1OH/chJ01+m3pqi2gKqW8gzbdsOU++Dz+FFYNlYP3vEgiQBjYVUUljek09ejrze
        iOCg7tCaMI1ciU6HK59ZXazm409q1YU=
Date:   Mon, 24 Apr 2023 15:32:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v6.4-rc1
Message-ID: <20230424133230.GBZEaE7j5O76K4PIdK@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a boring RAS updates branch for 6.4.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.4_rc1

for you to fetch changes up to 4c1cdec319b9aadb65737c3eb1f5cb74bd6aa156:

  x86/MCE/AMD: Use an u64 for bank_map (2023-03-19 19:07:04 +0100)

----------------------------------------------------------------
 - Just cleanups and fixes this time around: make threshold_ktype const,
   an objtool fix and use proper size for a bitmap

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/mce: Always inline old MCA stubs

Muralidhara M K (1):
      x86/MCE/AMD: Use an u64 for bank_map

Thomas Weißschuh (1):
      x86/MCE/AMD: Make kobj_type structure constant

 arch/x86/kernel/cpu/mce/amd.c      | 16 ++++++++--------
 arch/x86/kernel/cpu/mce/internal.h | 10 +++++-----
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
