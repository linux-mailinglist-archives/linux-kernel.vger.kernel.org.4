Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66BB6313A3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKTLYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTLYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:24:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E34046D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:24:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABDF122486;
        Sun, 20 Nov 2022 11:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668943478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8NLUue1qdWi3gbbn4CDCrTs4np4/mrBW7r8jTMowM/c=;
        b=BIDFESSqZrh8Yw8gWQ6i7IdxIoR77FejWycwv2JEFpnj8exfvcbKuvH9mjmzNVjEWY27Ay
        LAuWu3gj50lRp/eKCCJdEcVcBigP8AAFaHOK0Y20oKlkPhca9kBRPZTkdYnQ9SLUuz4cgI
        LQvCOeBdX3n9juMqUi6ENvdp73uh53M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668943478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8NLUue1qdWi3gbbn4CDCrTs4np4/mrBW7r8jTMowM/c=;
        b=EMrzvNJm/w2Z6H3kC1BtqBg0u8c4nh5mGQeEKq3zh/5ZgsKIMiJqEXL8Pzc0QnbdNq8zpU
        oJW5foxzZxpCTtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F78113216;
        Sun, 20 Nov 2022 11:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aWjqJnYOemONXQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Nov 2022 11:24:38 +0000
Date:   Sun, 20 Nov 2022 12:24:34 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 6.1-rc6
Message-ID: <Y3oOcqhGQqpH7xtd@zn.tnic>
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

please pull a couple of urgent perf fixes for 6.1.

Thx.

---

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc6

for you to fetch changes up to ce0d998be9274dd3a3d971cbeaa6fe28fd2c3062:

  perf/x86/intel/pt: Fix sampling using single range output (2022-11-16 10:12:59 +0100)

----------------------------------------------------------------
- Fix an intel PT erratum where CPUs do not support single range output
for more than 4K

- Fix a NULL ptr dereference which can happen after an NMI interferes
with the event enabling dance in amd_pmu_enable_all()

- Free the events array too when freeing uncore contexts on CPU online,
  thereby fixing a memory leak

- Improve the pending SIGTRAP check

----------------------------------------------------------------
Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling using single range output

Marco Elver (1):
      perf: Improve missing SIGTRAP checking

Ravi Bangoria (1):
      perf/x86/amd: Fix crash due to race between amd_pmu_enable_all, perf NMI and throttling

Sandipan Das (1):
      perf/x86/amd/uncore: Fix memory leak for events array

 arch/x86/events/amd/core.c   |  5 ++---
 arch/x86/events/amd/uncore.c |  1 +
 arch/x86/events/intel/pt.c   |  9 +++++++++
 kernel/events/core.c         | 25 +++++++++++++++++++------
 4 files changed, 31 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
