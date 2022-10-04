Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D635F452F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJDOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJDOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:11:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D015FF47
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:11:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B590121902;
        Tue,  4 Oct 2022 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664892686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aR//JXCMzFeerhATDmPlStlSNVDMBfleeMpQaJ+ntxo=;
        b=OEFsJEBYKRA7zGAwzmGSl7sRHbxEMQjpOCvvNs3BH3GlhK6Se9hNoom4uegWHmeDYh1uYH
        h+7WnqA8+6n6YZkhBg6M3EzwI3dJkkfoKR0U/sm6T8KzGFu18AL1pZC7kJpsIyQpe4jYEV
        /Z3Ne6K07amFqZypNjpcbgePpyke208=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664892686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aR//JXCMzFeerhATDmPlStlSNVDMBfleeMpQaJ+ntxo=;
        b=LU0wzG423VfjLkJNL+wNdMUEO2B+/2jqvETaVXR4HSkq3a0ffzevpUPS2i1GugrakRAxNw
        bPvbIvR11J8FDRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A934D139D2;
        Tue,  4 Oct 2022 14:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WjpLKQ4/PGMkcAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 14:11:26 +0000
Date:   Tue, 4 Oct 2022 16:11:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for 6.1
Message-ID: <Yzw/DmB1aHPjfN/8@zn.tnic>
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

please pull two x86 miscellaneous fixes for 6.1.

Thx.

---

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.1_rc1

for you to fetch changes up to 5258b80e60da6d8908ae2846b234ed8d9d9d4a19:

  x86/dumpstack: Don't mention RIP in "Code: " (2022-09-20 16:11:54 +0200)

----------------------------------------------------------------
- Drop misleading "RIP" from the opcodes dumping message

- Correct APM entry's Konfig help text

----------------------------------------------------------------
Jiri Slaby (1):
      x86/dumpstack: Don't mention RIP in "Code: "

Stephen Kitt (1):
      x86/Kconfig: Specify idle=poll instead of no-hlt

 arch/x86/Kconfig            | 2 +-
 arch/x86/kernel/dumpstack.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
