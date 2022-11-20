Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44886313DC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 13:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKTMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 07:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:16:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A085A16
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 04:16:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3B791F45E;
        Sun, 20 Nov 2022 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668946599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kowm+fU+qS4rQkwaGUsStx5sfLW8K8BCAryHXBPTWXw=;
        b=LRMSTOdKS7KIgjZMtP+fdcHVlkjoRy39HKrgCThN1YPesQreb53zILXj6lGFdJmDzD9pfp
        E8BlY/MOzhcbkdHZ/lY6iddYeNjNXKyafYwNZgH8Ky0d7C/AXM7QLg0snpDesSX8xZA9Pb
        e9Kpngvql1XtzcaDUUQqwHNZry+d9HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668946599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kowm+fU+qS4rQkwaGUsStx5sfLW8K8BCAryHXBPTWXw=;
        b=lIQGD/PEyNHxo4l0/zStvKGbsWuWzwkSOlKohdzlvFyh5PDTgcIOtCt64+KL/5CQp320kh
        IXowvsTglKySKlCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97A8C13216;
        Sun, 20 Nov 2022 12:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VZIAJacaemMacQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Nov 2022 12:16:39 +0000
Date:   Sun, 20 Nov 2022 13:16:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 6.1-rc6
Message-ID: <Y3oao37SUu9tluFY@zn.tnic>
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

please pull two urgent x86 fixes for 6.1.

Thx.

---

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc6

for you to fetch changes up to 36b038791e1e2baea892e9276588815fd14894b4:

  x86/fpu: Drop fpregs lock before inheriting FPU permissions (2022-11-10 16:57:38 +0100)

----------------------------------------------------------------
- Do not hold fpregs lock when inheriting FPU permissions because the
fpregs lock disables preemption on RT but fpu_inherit_perms() does
spin_lock_irq(), which, on RT, uses rtmutexes and they need to be
preemptible.

- Check the page offset and the length of the data supplied by userspace
for overflow when specifying a set of pages to add to an SGX enclave

----------------------------------------------------------------
Borys Popławski (1):
      x86/sgx: Add overflow check in sgx_validate_offset_length()

Mel Gorman (1):
      x86/fpu: Drop fpregs lock before inheriting FPU permissions

 arch/x86/kernel/cpu/sgx/ioctl.c | 3 +++
 arch/x86/kernel/fpu/core.c      | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
