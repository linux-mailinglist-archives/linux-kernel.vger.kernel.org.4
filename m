Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2CE5F227A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJBKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:19:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F532F005
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 03:19:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 331441F8B6;
        Sun,  2 Oct 2022 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664705966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ykrfC0p5twvUtMpoKMfrfj1B3l8+idA1SeLFQrim8wA=;
        b=DpMllSTGK7t8EMAMNlWRh8zAfWeNeZxNzsDv6x63zphv4unoOFOvO7fsbJ6+nZiSNLn8pK
        j6P7E7STRb6eVgaKfww9j1jIYtiYuMs7TQv16XqfAfIW6MssPYa5wFHTbRMzmz8kD/9MgQ
        oOWaLYeLg05CqfeMTcKbVG7tL1wT14o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664705966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ykrfC0p5twvUtMpoKMfrfj1B3l8+idA1SeLFQrim8wA=;
        b=gAlqcZZ2mlYr0vabeox4/nORve01BORishXNaPflEKMEtfAL01ZPUY40lzgzeHT31JeOiM
        xWU+CwcaFRXNs8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26A3413A5D;
        Sun,  2 Oct 2022 10:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h4laCa5lOWNCWwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 02 Oct 2022 10:19:26 +0000
Date:   Sun, 2 Oct 2022 12:19:25 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.0
Message-ID: <YzllraQ0SCkNe8v1@zn.tnic>
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

please pull two more x86 urgent fixes for 6.0.

Thx.

---

The following changes since commit e400ad8b7e6a1b9102123c6240289a811501f7d9:

  ACPI: processor idle: Practically limit "Dummy wait" workaround to old Intel systems (2022-09-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0

for you to fetch changes up to df5b035b5683d6a25f077af889fb88e09827f8bc:

  x86/cacheinfo: Add a cpu_llc_shared_mask() UP variant (2022-09-28 18:35:37 +0200)

----------------------------------------------------------------
- Add the respective UP last level cache mask accessors in order not to
cause segfaults when lscpu accesses their representation in sysfs

- Fix for a race in the alternatives batch patching machinery when
kprobes are set

----------------------------------------------------------------
Borislav Petkov (1):
      x86/cacheinfo: Add a cpu_llc_shared_mask() UP variant

Nadav Amit (1):
      x86/alternative: Fix race in try_get_desc()

 arch/x86/include/asm/smp.h    | 25 ++++++++++++++----------
 arch/x86/kernel/alternative.c | 45 ++++++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 32 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
