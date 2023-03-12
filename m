Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EC6B657E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCLLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjCLLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:32:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677541043B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:32:25 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA4551EC02FE;
        Sun, 12 Mar 2023 12:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678620725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=XDj2C/OhXZ4L1lDVOAiNAHAUP7jaMEt0ROBkzh4X89Y=;
        b=bf3wixeBlqt0+ZdGi9K1owVotiQZIsqSeWgkXaHmMrKBeChe1pSlMr1n83ovK5GOpXkHgd
        f7QBauhLPhFIWSn/EQIG+1OsJRksdWL/HhaWsd833dP3rJCNW9HnEVqVgygzVVPyiTHrjP
        no1BR5uk1Y66DRHZe2sArWx+dh5oyow=
Date:   Sun, 12 Mar 2023 12:32:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 6.3
Message-ID: <20230312113201.GAZA24MdYiw4Cq97sJ@fat_crate.local>
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

please pull a single erratum fix for AMD machines.

Thx.

---

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc2

for you to fetch changes up to b0563468eeac88ebc70559d52a0b66efc37e4e9d:

  x86/CPU/AMD: Disable XSAVES on AMD family 0x17 (2023-03-08 16:56:08 +0100)

----------------------------------------------------------------
- Disable XSAVES on AMD Zen1 and Zen2 machines due to an erratum. No
  impact to anything as those machines will fallback to XSAVEC which is
  equivalent there.

----------------------------------------------------------------
Andrew Cooper (1):
      x86/CPU/AMD: Disable XSAVES on AMD family 0x17

 arch/x86/kernel/cpu/amd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
