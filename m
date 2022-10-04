Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4BC5F453A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJDOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:14:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727664D0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:14:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C75C721899;
        Tue,  4 Oct 2022 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664892884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1JsWLa7azyKOzXoImT5jAYF73Mc3YXIlmteGy+ee0QE=;
        b=Z4LFv1ITwrrQ2GLG9kFzImfFiiZ3JdX/WdX3fvAkiVpyG0qWdK0cAOoaCxvWE3C39mAx87
        LE/OWTb2fTUXWwKka/dfgNEpQmZ/c0m3+iVEZR53khCT2Ia/13AfTCAJJjQXvZQ8ziu7an
        h4rBUGW28TGqdz1YWFjM5ORYJG+7X8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664892884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1JsWLa7azyKOzXoImT5jAYF73Mc3YXIlmteGy+ee0QE=;
        b=jHZjC/TiLli9QHLIUFtY9cNWyBCaR5PvMEYF7RKmYxQA1YRlozKxHeuRurIhUxZHfPx+8h
        sCvI4dC6NZikV8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC366139EF;
        Tue,  4 Oct 2022 14:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbjxLdQ/PGN0cQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 14:14:44 +0000
Date:   Tue, 4 Oct 2022 16:14:44 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt for 6.1
Message-ID: <Yzw/1M8lEiLriU57@zn.tnic>
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

please pull a single paravirt ops fix for 6.1.

Thx.

---

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.1_rc1

for you to fetch changes up to f92ff8f5dca2acfa475842c71212657b0703c3be:

  x86/paravirt: Ensure proper alignment (2022-09-21 12:30:16 +0200)

----------------------------------------------------------------
- Ensure paravirt patching site descriptors are aligned properly so that
code can do proper arithmetic with their addresses

----------------------------------------------------------------
Thomas Gleixner (1):
      x86/paravirt: Ensure proper alignment

 arch/x86/include/asm/paravirt.h       | 1 +
 arch/x86/include/asm/paravirt_types.h | 1 +
 2 files changed, 2 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
