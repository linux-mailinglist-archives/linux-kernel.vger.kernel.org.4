Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C95F4520
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJDOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJDOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:06:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681C2A961
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:06:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7F8C1F8AB;
        Tue,  4 Oct 2022 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664892372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ofD/Lxes09W6F4/E5QFyg8I0cfZPZuiE1g5YhGyNbPg=;
        b=JC96KDt7U7ju5Lo7x53Mf+xChlYXsJlh+gTmlVGMzFF/mClt9h/GY8h7takLPhgZID6H93
        TfK/iaNo9mXO76SORNYwGkdi/CYV8wbMOqzNCkpQFMoOmPAw0eGoqEQqPBIxJoODBXncMe
        4+iI6hRKlR2GXe0CMVd6bTGY0dBUqIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664892372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ofD/Lxes09W6F4/E5QFyg8I0cfZPZuiE1g5YhGyNbPg=;
        b=D50IWgEcciy0MKrrvHDX1DwhbJy2nMCl/DwPWbhc/Ne7MbzO498y/Q7GmTpVZJoyirgwhf
        VKGC7bfioj6ifcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B094A139D2;
        Tue,  4 Oct 2022 14:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hiLwKtQ9PGO0bQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 14:06:12 +0000
Date:   Tue, 4 Oct 2022 16:06:08 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/asm for 6.1
Message-ID: <Yzw90P8nmIUQQtl2@zn.tnic>
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

please pull a couple of x86/asm improvements for 6.1.

Thx.

---

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v6.1_rc1

for you to fetch changes up to fdb6649ab7c142e497539a471e573c2593b9c923:

  x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions (2022-09-20 15:35:37 +0200)

----------------------------------------------------------------
- "Slap" the __builtin_ffs/ctzl() compiler builtins in front of the
kernel's optimized ffs()/ffz() helpers in order to make use of the
compiler's constant folding optmization passes.

----------------------------------------------------------------
Vincent Mailhol (2):
      x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions
      x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions

 arch/x86/include/asm/bitops.h | 54 ++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
