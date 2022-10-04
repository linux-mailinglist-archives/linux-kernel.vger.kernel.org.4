Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C695F3E66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJDIbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJDIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:31:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C6357D3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:31:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59E2721980;
        Tue,  4 Oct 2022 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664872293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=caCSoBr3LpmOdpvzdPu1wPXf4ahXAE1hXbWCLIN8xhs=;
        b=NP1TseQEFWMc7dPCJApWIM9CukAr3eyaelgBPkJC0a7qNOOm1mAuU5aNcuv6Ga+4BQlh0S
        bJDyy6xlVdLf9TxrpMYchJ3q58y/xzb0OlGhKAvZEca9EYlpRbBt7a6nkvILnoKSop/gOI
        k9UUczF8CCExmzkJLWIyjdEk/AhAXQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664872293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=caCSoBr3LpmOdpvzdPu1wPXf4ahXAE1hXbWCLIN8xhs=;
        b=gUC7Sk2OnnPkbtC/GrVMl5K17AzjraVRYHagtFdhoc37aWoPpJjw6rNlfFZls8jUW62iQb
        2WcKDb4r/9/Ti1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E335139D2;
        Tue,  4 Oct 2022 08:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XO4lE2XvO2PmUQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 08:31:33 +0000
Date:   Tue, 4 Oct 2022 10:31:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for 6.1
Message-ID: <YzvvZGHP/o/i0e+F@zn.tnic>
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

please pull a single x86/sgx fix for 6.1.

Thx.

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.1_rc1

for you to fetch changes up to ee56a283988d739c25d2d00ffb22707cb487ab47:

  x86/sgx: Improve comments for sgx_encl_lookup/alloc_backing() (2022-08-15 11:51:49 +0200)

----------------------------------------------------------------
- Improve the documentation of a couple of SGX functions handling
backing storage

----------------------------------------------------------------
Kristen Carlson Accardi (1):
      x86/sgx: Improve comments for sgx_encl_lookup/alloc_backing()

 arch/x86/kernel/cpu/sgx/encl.c | 21 ++++++++++++++-------
 arch/x86/kernel/cpu/sgx/encl.h |  2 --
 2 files changed, 14 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
