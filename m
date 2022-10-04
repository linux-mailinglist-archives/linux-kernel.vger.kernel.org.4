Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F35F4070
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJDJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:57:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7F5F46
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:57:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD724218FA;
        Tue,  4 Oct 2022 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664877460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Bhvpxgx3BUaCeTj+0KNE2UTmWMgXv3W1wsrSLpLsMw=;
        b=EzufDIGSbgTKWRV+3AwkwNy5chxmnZXjnmKWlAz7S7PbP8M9Y1hxZMa1/yn0mrYxwaFYlK
        50Nuvb7mYRQtST6jdv6gKRptIo0d/1zw0bezI/pqvomLguE8AgmUurmPv/LJ5zwsuQA4PL
        IL38vkBgcQQ6eNawjCMBfPLtnWMyhHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664877460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Bhvpxgx3BUaCeTj+0KNE2UTmWMgXv3W1wsrSLpLsMw=;
        b=Hmsmu869A0lZUbnUQmOgp6mJ39tdBy/eqNDDHOuQgKGMxhgWvn1JeJ3F0Dc7WsP7AenbMA
        HS+1DH/bUjLpq1Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A20C0139EF;
        Tue,  4 Oct 2022 09:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VICJJ5QDPGNTeAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 09:57:40 +0000
Date:   Tue, 4 Oct 2022 11:57:36 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for 6.1
Message-ID: <YzwDkPQtUXDQU5km@zn.tnic>
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

please pull two x86/core fixes for 6.1.

Thx.

---

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.1_rc1

for you to fetch changes up to 8c03af3e090e9d57d90f482d344563dd4bae1e66:

  x86,retpoline: Be sure to emit INT3 after JMP *%\reg (2022-09-15 16:13:53 +0200)

----------------------------------------------------------------
- Make sure an INT3 is slapped after every unconditional retpoline JMP
as both vendors suggest

- Clean up pciserial a bit

----------------------------------------------------------------
Peter Zijlstra (2):
      x86/earlyprintk: Clean up pciserial
      x86,retpoline: Be sure to emit INT3 after JMP *%\reg

 arch/x86/kernel/alternative.c  |  9 +++++++++
 arch/x86/kernel/early_printk.c | 14 +++++++-------
 arch/x86/net/bpf_jit_comp.c    |  4 +++-
 include/linux/pci_ids.h        |  3 +++
 4 files changed, 22 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
