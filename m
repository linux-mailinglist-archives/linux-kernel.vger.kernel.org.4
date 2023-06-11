Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAD72B183
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjFKLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKLGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 07:06:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCD10D8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 04:06:01 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 565DA1EC0715;
        Sun, 11 Jun 2023 13:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686481560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=C4muo8+GUIaRqlTLOnM6cE0j08IYIH2gN4dsKgDQYNs=;
        b=dAXKJxbWWVQpqmUf0/7dSAVIymaVzY1pSZ2VaLtSQV2lg1FY6RS/ynfpEhjy6cNrauYX/r
        H2rtWY/B40b5G/In4rginI4JStKRn5IAFTvLKGrfldvE73Q+ZCvWyzh/VWJa9T9t5hF6Ex
        2bMJQlh3MJg29PFs1M+KYOyK1eNYpVQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686481559; bh=C4muo8+GUIaRqlTLOnM6cE0j08IYIH2gN4dsKgDQYNs=;
        h=Date:From:To:Cc:Subject:From;
        b=O7eS04UXX5PEdUXGMu0+9MdnCvNc7K2JUUQDJAkZGyGCl3hm/Qzw6eSDSeVJNi1Pu
         bohBOoi2+nvlLFkMZQmypU8zCbN5WdEvnNzdS7xqBDkRiCunfUt3C5l3NjY6ac1QVv
         /d4vqintA+J4l5jTanCHYC0I9kI4CIKzQFP1c6xD565PmuK7OUZOMt+3U8TLMJ1YgP
         0vLW9EZ3gPIYNzyR0bmXDAUJk3pkCIjvG0pXuJXAdyvVY4u0oj1naGmbUA/G7NTqAR
         ocTqxcZThVEKcBGGZjxI+WXs48t+BxKImly9awugd5rcEIXyp47YbMkZEqxteixJk2
         IhFz0r8YNk5tteXVHDu6AmK//bcNcQyYNBoZKebj11KtT4NBOPqlCKXqUmnJlWJsxk
         Vwe9stJ7nxDg+caPhRJzAmdR4BhjfHBbylLeYFu9QIZe28Drdv7RSCXX9eIPJob99o
         wlXGjgF/LsyBe+OKJ06XbULnkCFdPHwS0LVOrKllJUmDf6koMxmOvjS2+1zn9/7AM5
         zKrpVhZ+pxhQyuV2B87KNVr435q1PlshVxWAR4ZfOOgtrqUH9H+ZvV1s0pm69PRzDR
         fBnlZRCsc66b5zxxjfZ1/xBEqEqyFAQo08SyQg5VlSSzTjOD5huZpsuVKAPscsktze
         qBKEq1OBlRfKeTrK9Gwjfpvw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92B2140E01E4;
        Sun, 11 Jun 2023 11:05:56 +0000 (UTC)
Date:   Sun, 11 Jun 2023 13:05:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.4-rc6
Message-ID: <20230611110551.GEZIWqj1EgUPmZbPne@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent x86 fix for 6.4.

Thx.

---

The following changes since commit edc0a2b5957652f4685ef3516f519f84807087db:

  x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms (2023-05-25 10:48:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4_rc6

for you to fetch changes up to a37f2699c36a7f6606ba3300f243227856c5ad6b:

  x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed (2023-06-02 16:59:57 -0700)

----------------------------------------------------------------
- Set up the kernel CS earlier in the boot process in case EFI boots the
  kernel after bypassing the decompressor and the CS descriptor used
  ends up being the EFI one which is not mapped in the identity page
  table, leading to early SEV/SNP guest communication exceptions
  resulting in the guest crashing

----------------------------------------------------------------
Tom Lendacky (1):
      x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed

 arch/x86/kernel/head_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
