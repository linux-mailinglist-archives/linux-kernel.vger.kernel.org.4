Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE762BD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiKPMH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiKPMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:06:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114982BB15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:00:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE7B11F920;
        Wed, 16 Nov 2022 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668600056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TaAYGyrK+gIkH4bFpXR1icxkafDb9eg/FxEUQ9skTfs=;
        b=SOtoES5Q5ipivJ35qSqTxfv5+AoEThrnnoou+X6m6xTHbdx+vgUMXn3AdSOX+DDuTMSZYZ
        xtKuWmoSxGRceSkOn/CPK4OXP0zsj2gYpnIJAS6Q4wVexRs6McRVEMsFZSifBKyADXrC65
        33z0+a3A44nNJCREnmrTDKMc7M2v3oM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 958F5134CE;
        Wed, 16 Nov 2022 12:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id udgsI/jQdGMmfAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 16 Nov 2022 12:00:56 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.1-rc6
Date:   Wed, 16 Nov 2022 13:00:55 +0100
Message-Id: <20221116120055.4299-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc6-tag

xen: branch for v6.1-rc6

It contains two trivial cleanups, and 3 simple fixes.


Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c                     |  3 ++-
 arch/x86/xen/setup.c                            |  3 ++-
 drivers/xen/pcpu.c                              |  2 +-
 drivers/xen/platform-pci.c                      | 10 +++++++---
 drivers/xen/xen-pciback/conf_space_capability.c |  9 ++++++---
 5 files changed, 18 insertions(+), 9 deletions(-)

Christophe JAILLET (1):
      x86/xen: Use kstrtobool() instead of strtobool()

Juergen Gross (1):
      xen/platform-pci: use define instead of literal number

Marek Marczykowski-Górecki (1):
      xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too

Yang Yingliang (1):
      xen/pcpu: fix possible memory leak in register_pcpu()

ruanjinjie (1):
      xen/platform-pci: add missing free_irq() in error path
