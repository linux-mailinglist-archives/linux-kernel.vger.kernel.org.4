Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7960923B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJWKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJWKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 06:03:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643123472D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 03:03:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D2ED21B19;
        Sun, 23 Oct 2022 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666519437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qaRjfuW7QEYZpNGsXhKdgIorrWebcB5XJibJvmeitzw=;
        b=bL9dZDCfIEgeAU4otbT7lrazwNCJ9zUigg4AN7DqPXw4VnKkcZpASE/YkN+ZBv1Ly3agr2
        e4WvCiw7uTK5MaXMhQ6lsPGJZVT85EMXkO+CT0KNHVRIzp4RMroQsE1U8a/E47MmWOJOEK
        flVsya9J8dWc2Tma5n9PrHE5xfGHeyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666519437;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qaRjfuW7QEYZpNGsXhKdgIorrWebcB5XJibJvmeitzw=;
        b=YypzU4OioHGkjF10g1cmfiLv67X+XAE7GJMvRkH4/EX+fJnampIZ8Zz+rxKSmiM3wyupUa
        hOzSAnOUSt4juCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08459139F0;
        Sun, 23 Oct 2022 10:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BXKCAY0RVWNOPgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Oct 2022 10:03:57 +0000
Date:   Sun, 23 Oct 2022 12:03:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for 6.1
Message-ID: <Y1URjLOJ+levWPkw@zn.tnic>
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

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.1_rc2

for you to fetch changes up to 8e5bad7dccec2014f24497b57d8a8ee0b752c290:

  sched: Introduce struct balance_callback to avoid CFI mismatches (2022-10-17 16:41:25 +0200)

----------------------------------------------------------------
- Adjust code to not trip up CFI

- Fix sched group cookie matching

----------------------------------------------------------------
Kees Cook (1):
      sched: Introduce struct balance_callback to avoid CFI mismatches

Lin Shengwang (1):
      sched/core: Fix comparison in sched_group_cookie_match()

 kernel/sched/core.c     | 24 ++++++++++++------------
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/rt.c       |  4 ++--
 kernel/sched/sched.h    | 32 +++++++++++++++++++-------------
 4 files changed, 35 insertions(+), 29 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
