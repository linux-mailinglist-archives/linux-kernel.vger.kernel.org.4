Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E99639A08
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK0LOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 06:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK0LOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 06:14:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC06D50
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:14:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 897B821B79;
        Sun, 27 Nov 2022 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669547642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/hJQt8aogWSZjN5sT9Dyem+5KAdpXY3iOrxHIUUZNfE=;
        b=Et+JiPRJ2UR+9m3ph8Y19TAknEOfw7K3neSm+wyyPM9O7QzSby54Q5ZCa1vyCbQOoxObe6
        PDBAObY209T2vgCc8Cj8hyLcwHN6gEGFPyxvBRWc9nRdkoRjRAPTm6ScHnDUeKBPgzqJMR
        2JcVDUnFXrzCXNXC/SgNq/8Kfcqg4JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669547642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/hJQt8aogWSZjN5sT9Dyem+5KAdpXY3iOrxHIUUZNfE=;
        b=MafNahvWWlZfGYWsL19jYplmuMsPFsYXltI2zOP31JNomSUT9l3d/fOkA17AFVoMOe9oiJ
        IMEAhfwYmaeFKPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7437413428;
        Sun, 27 Nov 2022 11:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I2HaG3pGg2PvdwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 27 Nov 2022 11:14:02 +0000
Date:   Sun, 27 Nov 2022 12:13:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 6.1-rc7
Message-ID: <Y4NGdmo0OcxvZ5H+@zn.tnic>
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

please pull a couple of urgent x86 fixes which accumulated recently, for
6.1.

Thx.

---

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc7

for you to fetch changes up to 4dbd6a3e90e03130973688fd79e19425f720d999:

  x86/ioremap: Fix page aligned size calculation in __ioremap_caller() (2022-11-22 12:21:16 +0100)

----------------------------------------------------------------
- ioremap: mask out the bits which are not part of the physical address
*after* the size computation is done to prevent and hypothetical ioremap
failures

- Change the MSR save/restore functionality during suspend to rely on
flags denoting that the related MSRs are actually supported vs reading
them and assuming they are (an Atom one allows reading but not writing,
thus breaking this scheme at resume time.)

- prevent IV reuse in the AES-GCM communication scheme between SNP
guests and the AMD secure processor

----------------------------------------------------------------
Michael Kelley (1):
      x86/ioremap: Fix page aligned size calculation in __ioremap_caller()

Pawan Gupta (2):
      x86/tsx: Add a feature bit for TSX control MSR support
      x86/pm: Add enumeration check before spec MSRs save/restore setup

Peter Gonda (1):
      virt/sev-guest: Prevent IV reuse in the SNP guest driver

 arch/x86/include/asm/cpufeatures.h      |  3 ++
 arch/x86/kernel/cpu/tsx.c               | 38 +++++++--------
 arch/x86/mm/ioremap.c                   |  8 +++-
 arch/x86/power/cpu.c                    | 23 +++++----
 drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++++++++++++++++------
 5 files changed, 112 insertions(+), 44 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
