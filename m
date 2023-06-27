Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3C73F43B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjF0GJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0GJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:09:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF712B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:09:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F71421864;
        Tue, 27 Jun 2023 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687846147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=49rhAYE/xDlCYNBwhU7TuEWvhe0toiSWL8jdPfXh+RE=;
        b=cz72qwCW1DHGJlJCOq5CadsH+lvtWSSZsLPRBS9gsiuaIbaeOz+kojb79E0r1dlgemJ3Y/
        kXeUBRLWE6lLbHvpv4FzDGwvpH79MFNS6Jj5TGx4ZtYpW8aTDCf7CXAwXtImocaolSnIp0
        MivRQy1UhE+TjukfCoo6B/fdvwdlu0A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02BE813276;
        Tue, 27 Jun 2023 06:09:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pJK6OgJ9mmQ3dQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 27 Jun 2023 06:09:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.5-rc1
Date:   Tue, 27 Jun 2023 08:09:06 +0200
Message-Id: <20230627060906.14981-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5-rc1-tag

xen: branch for v6.5-rc1

It contains the following patches:

- 3 patches adding missing prototypes

- a fix for finding the iBFT in a Xen dom0 for supporting discless iSCSI
  boot


Thanks.

Juergen

 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/xen/efi.c                 |  2 ++
 arch/x86/xen/mmu_pv.c              | 16 ++++++++++++++++
 arch/x86/xen/setup.c               | 28 +++++++++++++++++++---------
 arch/x86/xen/smp.h                 |  4 ++++
 arch/x86/xen/smp_pv.c              |  1 -
 arch/x86/xen/xen-ops.h             |  5 +++--
 drivers/firmware/iscsi_ibft_find.c | 26 +++++++++++++++++---------
 include/linux/iscsi_ibft.h         | 10 +++++++++-
 include/xen/events.h               |  3 +++
 include/xen/xen.h                  |  3 +++
 11 files changed, 77 insertions(+), 23 deletions(-)

Arnd Bergmann (2):
      xen: xen_debug_interrupt prototype to global header
      x86: xen: add missing prototypes

Juergen Gross (1):
      x86/xen: add prototypes for paravirt mmu functions

Ross Lagerwall (1):
      iscsi_ibft: Fix finding the iBFT under Xen Dom 0
