Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246455F3E10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJDIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJDIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:17:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE56149
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:17:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A112219A8;
        Tue,  4 Oct 2022 08:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664871447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L0YjjBisnipxKpS2vck7T7itNH8/c2am2xys8kce7L4=;
        b=H3z4WfmukaoZGrEU39RBmsSMhOm5npVNHj6pvpT14W7areVkEs5ZFUJwMrwOwh+JDDWaLb
        6eCFPFZILpfUPrquslLKCYfMRrc5vL72qoOVYU5YQD6UYxgcmteoNV5hUkjdg+ynSwVLwh
        KZKSIpROLgdFQCwStcwFSvf1uMLNBZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664871447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L0YjjBisnipxKpS2vck7T7itNH8/c2am2xys8kce7L4=;
        b=AOty0tUTC/V3xHBb/R4213yPu9zegNqPCOk9Y3SxdNb8BIXywKEFHZP+NUf8WKOJxLeiRW
        0kdwfhEM9DV/FTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3051139EF;
        Tue,  4 Oct 2022 08:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vZtkOxbsO2OeSwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 08:17:26 +0000
Date:   Tue, 4 Oct 2022 10:17:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for 6.1
Message-ID: <YzvsFowRDiuf6ThG@zn.tnic>
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

please pull a single x86/platform improvement when the kernel is running
as a ACRN guest.

Thx.

---

The following changes since commit 9de1f9c8ca5100a02a2e271bdbde36202e251b4b:

  Merge tag 'irq-core-2022-08-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2022-08-01 12:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v6.1_rc1

for you to fetch changes up to 81a71f51b89e84f39df2a3b1daf4274ae6b7b194:

  x86/acrn: Set up timekeeping (2022-08-04 11:11:59 +0200)

----------------------------------------------------------------
- Get TSC and CPU frequency from CPUID leaf 0x40000010 when the kernel
is running as a guest on the ACRN hypervisor

----------------------------------------------------------------
Fei Li (1):
      x86/acrn: Set up timekeeping

 arch/x86/include/asm/acrn.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/acrn.c  |  3 +++
 2 files changed, 17 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
