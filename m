Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E175F3FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJDJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiJDJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:29:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4B356D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:28:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34D8F21959;
        Tue,  4 Oct 2022 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664875722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kwEVHg21B4ZfIC3lp5b7PeIw0QWCGztHLL28PfD8gdo=;
        b=tEY1p3arDQHMpoAsqN0jV6mKuDWs6KSzPqQBozZ7BTwmUOKMhH/X6HsdT2RulC4N9+g8L2
        IXSgnRsQoSPqz/YM/zDaiFA5qsAivM9ol3fNIl//vpZVhCF1Y7HfmRgmHXi+s8lmlBsrxq
        Q5yyDJlOPbiH7UTvqUkQasNPsTC8Ph4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664875722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kwEVHg21B4ZfIC3lp5b7PeIw0QWCGztHLL28PfD8gdo=;
        b=emOFwtwbiV9SvTGZls8fMVuVY+yqoCZQPdcSmucWchQqezECWDMZ5Qdgl4pKzrzDLo1qCA
        4X+dFLPYitT35eDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 299DB139D2;
        Tue,  4 Oct 2022 09:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z6YiCsr8O2MobAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 09:28:42 +0000
Date:   Tue, 4 Oct 2022 11:28:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/apic for 6.1
Message-ID: <Yzv8yRMxwmNDbqWy@zn.tnic>
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

please pull a APIC change to support locking it in X2APIC mode.

Thx.

---

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_v6.1_rc1

for you to fetch changes up to b8d1d163604bd1e600b062fb00de5dc42baa355f:

  x86/apic: Don't disable x2APIC if locked (2022-08-31 14:34:11 -0700)

----------------------------------------------------------------
- Add support for locking the APIC in X2APIC mode to prevent SGX enclave leaks

----------------------------------------------------------------
Daniel Sneddon (1):
      x86/apic: Don't disable x2APIC if locked

 Documentation/admin-guide/kernel-parameters.txt |  4 +++
 arch/x86/Kconfig                                |  7 +++-
 arch/x86/include/asm/cpu.h                      |  2 ++
 arch/x86/include/asm/msr-index.h                | 13 ++++++++
 arch/x86/kernel/apic/apic.c                     | 44 ++++++++++++++++++++++---
 5 files changed, 65 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
