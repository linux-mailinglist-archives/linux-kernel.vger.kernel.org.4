Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102F96313C2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKTLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTLwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:52:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE728E34
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:52:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C897F2219F;
        Sun, 20 Nov 2022 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668945129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jstBk1jpfi1zQI3nljLKZIizn0ZnlfDG21YLx11JGPM=;
        b=Yqvq9ArJ0UHTianeeDPVGkxqh3lFqRw92yMUYUe/iEeLfNF8kKOBp+Hq3eAQ/28Z5NzjD3
        61YVZhmXo28aSVa303PCrxHe6q7GCqNvAlSw20gH9+H6wIsLqec1RBjegKZC/KeVzewTmI
        ZmkNefwH4GPLWX29whnvvDYrJvgWvtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668945129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jstBk1jpfi1zQI3nljLKZIizn0ZnlfDG21YLx11JGPM=;
        b=G7bu4tq4O41IBgqtH3fejl3qyvyQAZ7zx18os3yjvBaMal0VGOPzhS8lTJ+S0/66JR5Q76
        aeTDaUFBMSXiBFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAFCF13216;
        Sun, 20 Nov 2022 11:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /F+/LekUemO6ZwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Nov 2022 11:52:09 +0000
Date:   Sun, 20 Nov 2022 12:52:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for 6.1-rc6
Message-ID: <Y3oU5cB9LOcBLfSS@zn.tnic>
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

please pull two urgent scheduler fixes for 6.1.

Thx.

---

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.1_rc6

for you to fetch changes up to 91dabf33ae5df271da63e87ad7833e5fdb4a44b9:

  sched: Fix race in task_call_func() (2022-11-14 09:58:32 +0100)

----------------------------------------------------------------
- Fix a small race on the task's exit path where there's a
misunderstanding whether the task holds rq->lock or not

- Prevent processes from getting killed when using deprecated or unknown
rseq ABI flags in order to be able to fuzz the rseq() syscall with
syzkaller

----------------------------------------------------------------
Mathieu Desnoyers (1):
      rseq: Use pr_warn_once() when deprecated/unknown ABI flags are encountered

Peter Zijlstra (1):
      sched: Fix race in task_call_func()

 kernel/rseq.c       | 19 +++++++++++++++++--
 kernel/sched/core.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 52 insertions(+), 19 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
