Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4B61E23E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKFNDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKFNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:03:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009CEB481
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:03:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A45C21FA6A;
        Sun,  6 Nov 2022 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667739783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RciqdMjiBbBvzQDtzheHe3+hFC3EXWt3Wem2Z/cXTFA=;
        b=KILFQLugdTA4hOc7EPxbN0JxuaIZrGEaFkyTQoMwxb/PRbVVEmDI8QfuxNH3ITIvfNL6Ko
        eMBKqzzvpnLOOSM404Oo8/+lu7/6ysOGjBcrvCZ4lEoaZ44h2q0RbpVsOQdqkQOW5qHlEn
        bWJWcpb4VvXoD7QRWwkb4CSzpbAvosE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667739783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RciqdMjiBbBvzQDtzheHe3+hFC3EXWt3Wem2Z/cXTFA=;
        b=KqM12bNe55j9hL+wwV1Kees/VkQNru/Bp22G4BNXTX3SUoUYMcjyajlIOEg1NiVWspMKKe
        p8m5q5OLN/LdQQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 988701376E;
        Sun,  6 Nov 2022 13:03:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gc80JYewZ2PFTAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 06 Nov 2022 13:03:03 +0000
Date:   Sun, 6 Nov 2022 14:02:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] perf/urgent for 6.1-rc4
Message-ID: <Y2ewgoBWbyIt9oPW@zn.tnic>
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

that same cat dragged some urgent perf updates for 6.1 too.

Please pull,
thx.

---

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc4

for you to fetch changes up to 6f8faf471446844bb9c318e0340221049d5c19f4:

  perf/x86/intel: Add Cooper Lake stepping to isolation_ucodes[] (2022-11-02 12:22:07 +0100)

----------------------------------------------------------------
- Add Cooper Lake's stepping to the PEBS guest/host events isolation
fixed microcode revisions checking quirk

- Update Icelake and Sapphire Rapids events constraints

- Use the standard energy unit for Sapphire Rapids in RAPL

- Fix the hw_breakpoint test to fail more graciously on !SMP configs

----------------------------------------------------------------
David Gow (1):
      perf/hw_breakpoint: test: Skip the test if dependencies unmet

Kan Liang (3):
      perf/x86/intel: Fix pebs event constraints for ICL
      perf/x86/intel: Fix pebs event constraints for SPR
      perf/x86/intel: Add Cooper Lake stepping to isolation_ucodes[]

Zhang Rui (1):
      perf/x86/rapl: Use standard Energy Unit for SPR Dram RAPL domain

 arch/x86/events/intel/core.c       |  1 +
 arch/x86/events/intel/ds.c         | 18 ++++++++++++++----
 arch/x86/events/rapl.c             |  6 +-----
 kernel/events/hw_breakpoint_test.c |  4 ++--
 4 files changed, 18 insertions(+), 11 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
