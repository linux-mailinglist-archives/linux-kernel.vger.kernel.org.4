Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB76498F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiLLGYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLLGYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:24:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAFCE1F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:24:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D084333895;
        Mon, 12 Dec 2022 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670826270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PDleQvRrvX4MednzmZMOBosn/u+w5VLSU4we6Gr6Rpg=;
        b=JeOvlfdVQ0v0I9dzki2wi4tBTPrtVnpfK7fhFEf5ZClAg8Gc2aRgtHIna2pcEnPFObuod7
        R86VxHPkycHHJpEM324Vo3EnvroKux4P7x7kgFVis2Rbi0fa3RHfAxX4DXFokOp8EJs7DK
        W2dmF+T2I3R0t2KMkA00IxcaVxp+Fcw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8DED13456;
        Mon, 12 Dec 2022 06:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jEviJx7JlmNdVwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 12 Dec 2022 06:24:30 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.2-rc1
Date:   Mon, 12 Dec 2022 07:24:30 +0100
Message-Id: <20221212062430.10263-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.2-rc1-tag

xen: branch for v6.2-rc1

It contains:

- 2 small minor fixes
- a small series fixing memory leaks in error paths
- a small series adding support for virtio PCI-devices in Xen guests on
  Arm


Thanks.

Juergen

 arch/arm/xen/enlighten.c    |   2 +-
 arch/x86/xen/smp.c          |  24 +++++-----
 arch/x86/xen/smp_pv.c       |  12 ++---
 arch/x86/xen/spinlock.c     |   6 +--
 drivers/xen/grant-dma-ops.c | 105 ++++++++++++++++++++++++--------------------
 drivers/xen/privcmd.c       |   2 +-
 include/xen/arm/xen-ops.h   |   4 +-
 include/xen/xen-ops.h       |  16 -------
 include/xen/xen.h           |   4 +-
 9 files changed, 84 insertions(+), 91 deletions(-)

Harshit Mogalapalli (1):
      xen/privcmd: Fix a possible warning in privcmd_ioctl_mmap_resource()

Jani Nikula (1):
      xen: fix xen.h build for CONFIG_XEN_PVH=y

Oleksandr Tyshchenko (2):
      xen/virtio: Optimize the setup of "xen-grant-dma" devices
      xen/virtio: Handle PCI devices which Host controller is described in DT

Xiu Jianfeng (2):
      x86/xen: Fix memory leak in xen_smp_intr_init{_pv}()
      x86/xen: Fix memory leak in xen_init_lock_cpu()
