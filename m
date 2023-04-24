Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBA6ECF64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjDXNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjDXNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:41:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172993CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:40:51 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10EF01EC05DE;
        Mon, 24 Apr 2023 15:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682343650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=9G+VZPYoAnYPL6qPwmjr1jUSrO9rlMRJrfs8LBen7Vk=;
        b=bBV8DeVjIS4hq4M34gx/r28Fg9wDIbZzBnchTXqwKDvYNT0GlbADzlFZxE+m5R+Ltzj7fE
        NkO7hZXp6sbBxXizorKH+EgYAj51iAjC9+QTWQhY2sLVtGhq1LyMdl7iYJwpjk7FZybJYN
        q+P86nrhoj9Jr49TCJlpyzCaO6+5wPQ=
Date:   Mon, 24 Apr 2023 15:40:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/acpi update for v6.4-rc1
Message-ID: <20230424134049.GCZEaG4ZVMddiZTbtL@fat_crate.local>
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

please pull a single x86/ACPI update for 6.4.

Thx.

---

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_acpi_for_v6.4_rc1

for you to fetch changes up to 22767544e9763e82acb60c233051bc426381b61c:

  x86/ACPI/boot: Improve __acpi_acquire_global_lock (2023-03-22 11:32:39 -0700)

----------------------------------------------------------------
- Improve code generation in ACPI's global lock's acquisition function

----------------------------------------------------------------
Uros Bizjak (1):
      x86/ACPI/boot: Improve __acpi_acquire_global_lock

 arch/x86/kernel/acpi/boot.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
