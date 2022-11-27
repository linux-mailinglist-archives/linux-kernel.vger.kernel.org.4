Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A005639A21
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 12:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiK0L1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 06:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiK0L1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 06:27:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE76145
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:27:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A82641F894;
        Sun, 27 Nov 2022 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669548456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEG5/m+he7bhgZgAY7bQAmRLsnASBRgFz+Fp9ug50bE=;
        b=MBUsSROq0xw/NkB5D47ZIVIR58BakpA55QkYAw7rOJHFbmYUt/stnbJ0VLW90UBLer7h+v
        It/gG/ErU6SqJA9UahDGxX8Rcv1MnAvaj+fIWd2Uv2YG8O0NTbVo07n3nn7Pgbv/j3fYCE
        MtlXmVtsc6DLMyp48C3jkxkhaXebqhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669548456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEG5/m+he7bhgZgAY7bQAmRLsnASBRgFz+Fp9ug50bE=;
        b=geBmnNKmsrzDMjuNZj6/4Tn+9I+g6WgmYK6O13ikjXTebNCsvBFcrm8COqSGGqH09+6Ymz
        hXZoAy9Rvfcjm8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B2C313428;
        Sun, 27 Nov 2022 11:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UEDXJahJg2PKfAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 27 Nov 2022 11:27:36 +0000
Date:   Sun, 27 Nov 2022 12:27:36 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for 6.1-rc7
Message-ID: <Y4NJqBtjsoZJtIsm@zn.tnic>
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

please pull a single urgent timers fix for 6.1.

Thx.

---

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.1_rc7

for you to fetch changes up to 839a973988a94c15002cbd81536e4af6ced2bd30:

  clocksource/drivers/arm_arch_timer: Fix XGene-1 TVAL register math error (2022-11-21 16:01:56 +0100)

----------------------------------------------------------------
- Return the proper timer register width (31 bits) for a 32-bit signed
register in order to avoid a timer interrupt storm on ARM XGene-1
hardware running in NO_HZ mode

----------------------------------------------------------------
Joe Korty (1):
      clocksource/drivers/arm_arch_timer: Fix XGene-1 TVAL register math error

 drivers/clocksource/arm_arch_timer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
