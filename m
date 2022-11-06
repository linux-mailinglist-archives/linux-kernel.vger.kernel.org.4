Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570E861E237
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKFMwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKFMv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:51:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34FA63B9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:51:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9ABD121CEA;
        Sun,  6 Nov 2022 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667739116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZIoWHBWF0OWUE4BAH9Ynnlz8RQob1L+dtgojW+hxO8A=;
        b=ib/7n8UVORPVvkQgHv+fUI2wD16+nm47SeV3ZooF5FijBofQnB8qA7dzHaLTy1mPJABGxS
        xL9qnzg/kdgHhrWlZqBCau+f+xCsPRHHjIU92UmY64rIiKnh5dcLxxK+quvC69NtUeioTh
        YJCEe7GBzliE6OExSXPUHBaMzNlqFx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667739116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZIoWHBWF0OWUE4BAH9Ynnlz8RQob1L+dtgojW+hxO8A=;
        b=bLIUiQxTgHsA5cXt6SmGv7IlV1kIW6PkgVbG3ltr6fFsQS6/TAUzrcmFeGzVeAsqzzV4yq
        Z6X5y6fJhDwEhMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87B931376E;
        Sun,  6 Nov 2022 12:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XjGkIOytZ2NASAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 06 Nov 2022 12:51:56 +0000
Date:   Sun, 6 Nov 2022 13:51:56 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 6.1-rc4
Message-ID: <Y2et7Ajw3XimvNVk@zn.tnic>
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

here's what the x86/urgent cat dragged in during the last two weeks, for
6.1.

Please pull,
thanks.

---

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc4

for you to fetch changes up to 7beade0dd41d42d797ccb7791b134a77fcebf35b:

  x86/cpu: Add several Intel server CPU model numbers (2022-11-04 21:12:22 +0100)

----------------------------------------------------------------
- Add new Intel CPU models

- Enforce that TDX guests are successfully loaded only on TDX hardware
where virtualization exception (#VE) delivery on kernel memory is
disabled because handling those in all possible cases is "essentially
impossible"

- Add the proper include to the syscall wrappers so that BTF can see the
real pt_regs definition and not only the forward declaration

----------------------------------------------------------------
Dave Hansen (1):
      x86/tdx: Prepare for using "INFO" call for a second purpose

Jiri Olsa (1):
      x86/syscall: Include asm/ptrace.h in syscall_wrapper header

Kirill A. Shutemov (1):
      x86/tdx: Panic on bad configs that #VE on "private" memory access

Tony Luck (1):
      x86/cpu: Add several Intel server CPU model numbers

 arch/x86/coco/tdx/tdx.c                | 25 ++++++++++++++++++-------
 arch/x86/include/asm/intel-family.h    | 11 ++++++++++-
 arch/x86/include/asm/syscall_wrapper.h |  2 +-
 3 files changed, 29 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
