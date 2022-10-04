Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C05F3F59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJDJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiJDJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:19:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D9631ED7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:18:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19164219BC;
        Tue,  4 Oct 2022 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664875133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6lu502ezjzUoaUi3b7B7mnyUpngSbGGcrW9JjRrD9mk=;
        b=GKCS5Y8wcXxx7MqPRgj1RfpAnECrdv5oCpNikM/+Eb66bSkRbfgjxAtQQY+JEJGhRBWHPE
        JXghu2iYtKdT7ub5Kk05mex8Dk+PBjY91Bz9aejS+FVaJEdluAvvyVO6I7l1LcQ33YQvaE
        15ClBWGeUi1iclHkZD9uxUkkWLXNbwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664875133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6lu502ezjzUoaUi3b7B7mnyUpngSbGGcrW9JjRrD9mk=;
        b=OjC64JqhkAdGGc9uPHhn7HLsuWwBxJOgAUjU8VugM/v7khkAvPCzLsYgHsH0UVpYSH6HhI
        pZp7UDLh2zSu5sDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D89D139D2;
        Tue,  4 Oct 2022 09:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qsRHA336O2P7ZwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 09:18:53 +0000
Date:   Tue, 4 Oct 2022 11:18:48 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for 6.1
Message-ID: <Yzv6eCHCFWFp0adu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86 RAS improvements for 6.1.

Thx.

---

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.1_rc1

for you to fetch changes up to f9781bb18ed828e7b83b7bac4a4ad7cd497ee7d7:

  x86/mce: Retrieve poison range from hardware (2022-08-29 09:33:42 +0200)

----------------------------------------------------------------
- Fix the APEI MCE callback handler to consult the hardware about the
granularity of the memory error instead of hard-coding it

- Offline memory pages on Intel machines after 2 errors reported per page

----------------------------------------------------------------
Jane Chu (1):
      x86/mce: Retrieve poison range from hardware

Tony Luck (1):
      RAS/CEC: Reduce offline page threshold for Intel systems

 arch/x86/kernel/cpu/mce/apei.c | 13 ++++++++++++-
 drivers/ras/cec.c              |  8 ++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
