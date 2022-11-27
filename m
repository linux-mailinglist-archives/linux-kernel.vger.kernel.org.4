Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4D6399F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 11:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiK0KrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 05:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiK0KrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 05:47:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FADEB2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 02:47:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E4071F8D7;
        Sun, 27 Nov 2022 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669546022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SRSJflPmt4CP1/dJzK0iOWgfJdXK+iZBa3gXikB22aw=;
        b=EkAPzWLGuIvYeZzoRBU62f8tzS+ECpLBe7mKdO/45CGCcH8s+tTtecL+tt9iZPilGURi7F
        /LsKre2FsALkgHj4jm4XccT/LosXhmcwjAmChZR0d+LrUwUsIrQgM2Wj6rfvJyOmbV3UI1
        zcFEPmUA23wlYB/66KC6jAc3NZnb2yI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669546022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SRSJflPmt4CP1/dJzK0iOWgfJdXK+iZBa3gXikB22aw=;
        b=UDshJOJ5lxtu1xkWRwVSI98EKn9MljslZkLBqWZRWRXHL6Ke4SkGIql06xhqxrDnayoCKt
        WCCxKgWGV7aftfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50E9B134CE;
        Sun, 27 Nov 2022 10:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id laXcEyZAg2PebQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 27 Nov 2022 10:47:02 +0000
Date:   Sun, 27 Nov 2022 11:46:57 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 6.1-rc7
Message-ID: <Y4NAIQk1VAPoC/vx@zn.tnic>
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

please pull two urgent perf fixes for 6.1.

Thx.

---

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc7

for you to fetch changes up to 030a976efae83f7b6593afb11a8254d42f9290fe:

  perf: Consider OS filter fail (2022-11-24 10:12:23 +0100)

----------------------------------------------------------------
- Two more fixes to the perf sigtrap handling:
 - output the address in the sample only when it has been requested
 - handle the case where user-only events can hit in kernel and thus
   upset the sigtrap sanity checking

----------------------------------------------------------------
Peter Zijlstra (2):
      perf: Fixup SIGTRAP and sample_flags interaction
      perf: Consider OS filter fail

 kernel/events/core.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
