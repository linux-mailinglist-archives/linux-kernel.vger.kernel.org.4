Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431155F4574
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJDO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJDO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:28:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018F61111
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:28:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E709F1F927;
        Tue,  4 Oct 2022 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664893726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rxmvYPvLcuVJW+Fx/HApwcQ1ysJU6LO6KKSSyPe8XU0=;
        b=xV83fUCc/HwY5igNjXClePsTVTKoXjYzAC1DP7nkb8/0UzAt2E/baEJkTOC6tpv1+gjVvM
        UnModG4pPtePJqiLXAe3HyeWC4e0frUqCA/caN3V5HQFf46wwhLcqnEcr5iMnI/995pM60
        W/gfm+XiTRG3bjJycFQqJndP/PQdpi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664893726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rxmvYPvLcuVJW+Fx/HApwcQ1ysJU6LO6KKSSyPe8XU0=;
        b=PId2MAwTrGj48cxwteU28xmOjsTMZR5p5z8tdYGiIY/u6A5H5BTaWlz6OdFv8cmij7P5DB
        XAXDU95Fd+X0LcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA4CD139EF;
        Tue,  4 Oct 2022 14:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t7BHNR5DPGNMdwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 14:28:46 +0000
Date:   Tue, 4 Oct 2022 16:28:46 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for 6.1
Message-ID: <YzxDHp4CEWlZwtmE@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86 boring branch for 6.1.

Thx.

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.1_rc1

for you to fetch changes up to 30ea703a38ef76ca119673cd8bdd05c6e068e2ac:

  x86/cpu: Include the header of init_ia32_feat_ctl()'s prototype (2022-09-26 17:06:27 +0200)

----------------------------------------------------------------
- The usual round of smaller fixes and cleanups all over the tree

----------------------------------------------------------------
Jason Wang (1):
      x86: Fix various duplicate-word comment typos

Li kunyu (1):
      x86/boot: Remove superfluous type casting from arch/x86/boot/bitops.h

Luciano Leão (1):
      x86/cpu: Include the header of init_ia32_feat_ctl()'s prototype

Uros Bizjak (1):
      x86/uaccess: Improve __try_cmpxchg64_user_asm() for x86_32

 arch/x86/boot/bitops.h         |  4 ++--
 arch/x86/include/asm/uaccess.h | 11 ++++++-----
 arch/x86/kernel/amd_gart_64.c  |  2 +-
 arch/x86/kernel/aperture_64.c  |  2 +-
 arch/x86/kernel/cpu/feat_ctl.c |  2 +-
 arch/x86/kvm/vmx/nested.c      |  2 +-
 arch/x86/platform/efi/efi.c    |  2 +-
 7 files changed, 13 insertions(+), 12 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
