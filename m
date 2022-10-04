Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD32B5F3ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJDIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJDIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:50:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0F140F9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:50:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A14B21987;
        Tue,  4 Oct 2022 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664873417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pQXjHZV02kOKPknWCc2iLdXkjIMwoNzNmRL6P5zP9r8=;
        b=c19npNWfw+Rkw52gxo8pKqXkSa4TbsbGFnDdtdNUykyKP/Y/jr6MYAJfDGc4oMsCuYqG2t
        U4aBCG0FysHkCdgBEII+yD191DYEegCJvyj6eg/353PMBV95Stq7gIQ68HBM9XV7gDIgm6
        bRcdbAU91SDe7qf2whBPOMDyAQrM2Vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664873417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pQXjHZV02kOKPknWCc2iLdXkjIMwoNzNmRL6P5zP9r8=;
        b=P8ixQC5fXVKINFHzfgRgFdYEW23VxtQanZdQlmah4EGEFAXBpDHzcY3F3RlG8zs3vMx7m7
        6QW0H6z4yOHXfnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CC35139D2;
        Tue,  4 Oct 2022 08:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gySIGsnzO2PlWgAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 08:50:17 +0000
Date:   Tue, 4 Oct 2022 10:50:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for 6.1
Message-ID: <YzvzxYCBAPX47PTf@zn.tnic>
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

please pull the x86/cpu lineup for 6.1.

Thx.

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.1_rc1

for you to fetch changes up to c926087eb38520b268515ae1a842db6db62554cc:

  x86/mm: Print likely CPU at segfault time (2022-08-24 12:48:05 +0200)

----------------------------------------------------------------
- Print the CPU number at segfault time. The number printed is not
  always accurate (preemption is enabled at that time) but the print string
  contains "likely" and after a lot of back'n'forth on this, this was the
  consensus that was reached. See thread starting at:
  https://lore.kernel.org/r/5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com

- After a *lot* of testing and polishing, finally the clear_user()
  improvements to inline REP; STOSB by default

----------------------------------------------------------------
Borislav Petkov (1):
      x86/clear_user: Make it faster

Rik van Riel (1):
      x86/mm: Print likely CPU at segfault time

 arch/x86/include/asm/uaccess.h    |   5 +-
 arch/x86/include/asm/uaccess_64.h |  45 +++++++++++++
 arch/x86/lib/clear_page_64.S      | 138 ++++++++++++++++++++++++++++++++++++++
 arch/x86/lib/usercopy_64.c        |  40 -----------
 arch/x86/mm/fault.c               |  10 +++
 tools/objtool/check.c             |   3 +
 6 files changed, 198 insertions(+), 43 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
