Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40865ED84E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiI1I5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiI1I5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:57:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D11DF1A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:57:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C89EF210E0;
        Wed, 28 Sep 2022 08:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664355451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SZWpruz+4WZoQkcxldZTYQlcjavSCWBsF8sf6gY5NAY=;
        b=2L7ihR92SXSwqQ0nO2YdSgUH4+PYHBHrK5ikSjupPDPuTHK+QU/wN2hjphfg/DJ7Yy66ld
        IjA0q2dIMg6QlpbvJ+FSWKcPFpA3p/Jm8laiFwYdfvEEzFEy4C6yGZojFOybkuRnwiykRF
        wZNT1ZsoTCFZ98GqEXXJWhZqRL7+Uww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664355451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SZWpruz+4WZoQkcxldZTYQlcjavSCWBsF8sf6gY5NAY=;
        b=Ef3FRFW7o/2Q5v5dG5DZZrQS7/VZEtpvAMKCX+XZmjpmmI6zMa/JjQ6hTlTw6ith1o9BDW
        afCsjd+jlzfjSZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD96313A84;
        Wed, 28 Sep 2022 08:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QZs+LnsMNGOaYAAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 28 Sep 2022 08:57:31 +0000
Date:   Wed, 28 Sep 2022 10:57:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.0
Message-ID: <YzQMdl0bf305slSv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull more urgent irq fixes for 6.0. Stuff got left hanging due to
the whole Plumbers and vacations commotion.

Thx.

---

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.0

for you to fetch changes up to c0cca6a66458a0daa627774de7ca2b678a6bb3d8:

  Merge tag 'irqchip-fixes-6.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2022-09-27 15:29:33 +0200)

----------------------------------------------------------------
Pull more irqchip fixes for 6.0 from Marc Zyngier:

  - A couple of configuration fixes for the recently merged Loongarch drivers

  - A fix to avoid dynamic allocation of a cpumask which was causing issues
    with PREEMPT_RT and the GICv3 ITS

  - A tightening of an error check in the stm32 exti driver

----------------------------------------------------------------
Antonio Borneo (1):
      irqchip/stm32-exti: Remove check on always false condition

Borislav Petkov (1):
      Merge tag 'irqchip-fixes-6.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Huacai Chen (1):
      irqchip: Select downstream irqchip drivers for LoongArch CPU

Jianmin Lv (1):
      irqchip/loongson-pch-lpc: Add dependence on LoongArch

Pierre Gondois (1):
      irqchip/gic-v3-its: Remove cpumask_var_t allocation

 drivers/irqchip/Kconfig          |  8 +++++++-
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++------
 drivers/irqchip/irq-stm32-exti.c |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
