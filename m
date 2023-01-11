Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511FB665B54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjAKMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbjAKMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:25:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80113DEA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:25:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0523A177FF;
        Wed, 11 Jan 2023 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673439902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vZMspio6CqflV2FoZGlGgB3ql5H0jWaCysfX0yUnYDQ=;
        b=i1j/ru4dgYR90bYOPjq+JSLrzSFu3i9s/RaWWGUijp2M6fS3/bNXgZgzTq+7/Wkoxb+Vco
        YrOwY5iy3Qm217kyCcQYgZQdqOPNNKWA09rKXzprgg7CG/OpT7LMAK+Y7t62I9v+Y5dJbC
        qnsseM3aCsLj/JhMkaXRg2Vdz86A4+o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D519413591;
        Wed, 11 Jan 2023 12:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xE+2Mp2qvmMUSAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 11 Jan 2023 12:25:01 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.2-rc4
Date:   Wed, 11 Jan 2023 13:25:01 +0100
Message-Id: <20230111122501.21815-1-jgross@suse.com>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.2-rc4-tag

xen: branch for v6.2-rc4

It contains:
- 2 cleanup patches
- a fix of a memory leak in the Xen pvfront driver
- a fix of a locking issue in the Xen hypervisor console driver

Thanks.

Juergen

 arch/x86/xen/p2m.c                  |  5 ----
 drivers/block/xen-blkback/xenbus.c  |  4 +--
 drivers/block/xen-blkfront.c        |  3 +--
 drivers/char/tpm/xen-tpmfront.c     |  3 +--
 drivers/gpu/drm/xen/xen_drm_front.c |  3 +--
 drivers/input/misc/xen-kbdfront.c   |  5 ++--
 drivers/net/xen-netback/xenbus.c    |  3 +--
 drivers/net/xen-netfront.c          |  4 +--
 drivers/pci/xen-pcifront.c          |  4 +--
 drivers/scsi/xen-scsifront.c        |  4 +--
 drivers/tty/hvc/hvc_xen.c           | 50 +++++++++++++++++++++++--------------
 drivers/usb/host/xen-hcd.c          |  4 +--
 drivers/video/fbdev/xen-fbfront.c   |  6 ++---
 drivers/xen/pvcalls-back.c          |  3 +--
 drivers/xen/pvcalls-front.c         |  7 +++---
 drivers/xen/xen-pciback/xenbus.c    |  4 +--
 drivers/xen/xen-scsiback.c          |  4 +--
 include/xen/xenbus.h                |  2 +-
 net/9p/trans_xen.c                  |  3 +--
 sound/xen/xen_snd_front.c           |  3 +--
 20 files changed, 54 insertions(+), 70 deletions(-)

Dawei Li (1):
      xen: make remove callback of xen driver void returned

Jiapeng Chong (1):
      x86/xen: Remove the unused function p2m_index()

Oleksii Moisieiev (1):
      xen/pvcalls: free active map buffer on pvcalls_front_free_map

Roger Pau Monne (1):
      hvc/xen: lock console list traversal
