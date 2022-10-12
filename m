Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5C5FC123
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJLHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLHQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:16:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99B4DF0F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:16:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 814C31F8AC;
        Wed, 12 Oct 2022 07:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665558979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uVN9aIUqx34P/45tcMyef9ckHEUfMNnGUM08QJbEcWE=;
        b=FZS6AM6zDQA0sW9E4AD+vHPONn2WtBOhg/pbZ/EKi9wcFoL2lpkJUc5MYMKmtT0BbNORyO
        rotC6zeIWH9kOkSQTxynPjX+Nlds9dAUuDfgnEezA+dCLuotphLFB882Cs/ODXkVenqH9X
        mujfc4JLFRWQQQk+D2ikhwVu/4ADcq4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4873013A5C;
        Wed, 12 Oct 2022 07:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KZxSEMNpRmNROQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 12 Oct 2022 07:16:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.1-rc1
Date:   Wed, 12 Oct 2022 09:16:18 +0200
Message-Id: <20221012071618.8859-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc1-tag

xen: branch for v6.1-rc1

It contains:

- Some minor typo fixes

- A fix of the Xen pcifront driver for supporting the device model to
  run in a Linux stub domain

- A cleanup of the pcifront driver

- A series to enable grant-based virtio with Xen on x86

- A cleanup of Xen PV guests to distinguish between safe and faulting
  MSR accesses

- Two fixes of the Xen gntdev driver

- Two fixes of the new xen grant DMA driver


Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 arch/x86/xen/Kconfig                            |   9 ++
 arch/x86/xen/enlighten_hvm.c                    |   2 +-
 arch/x86/xen/enlighten_pv.c                     | 101 ++++++++++-----
 arch/x86/xen/pmu.c                              |  71 ++++++-----
 drivers/pci/xen-pcifront.c                      | 161 ++++++++----------------
 drivers/xen/Kconfig                             |   2 +-
 drivers/xen/gntdev-common.h                     |   3 +-
 drivers/xen/gntdev.c                            |  80 ++++++------
 drivers/xen/grant-dma-ops.c                     | 112 ++++++++++++-----
 drivers/xen/xen-pciback/xenbus.c                |   2 +-
 include/xen/xen-ops.h                           |   6 +
 12 files changed, 313 insertions(+), 242 deletions(-)

Colin Ian King (2):
      xen/xenbus: Fix spelling mistake "hardward" -> "hardware"
      xen: Kconfig: Fix spelling mistake "Maxmium" -> "Maximum"

Jason Andryuk (1):
      xen-pcifront: Handle missed Connected state

Juergen Gross (8):
      xen/pcifront: move xenstore config scanning into sub-function
      xen/virtio: restructure xen grant dma setup
      xen/virtio: use dom0 as default backend for CONFIG_XEN_VIRTIO_FORCE_GRANT
      xen/virtio: enable grant based virtio on x86
      xen/pv: add fault recovery control to pmu msr accesses
      xen/pv: fix vendor checks for pmu emulation
      xen/pv: refactor msr access functions to support safe and unsafe accesses
      xen/pv: support selecting safe/unsafe msr accesses

M. Vefa Bicakci (2):
      xen/gntdev: Prevent leaking grants
      xen/gntdev: Accommodate VMA splitting

Oleksandr Tyshchenko (2):
      xen/virtio: Fix n_pages calculation in xen_grant_dma_map(unmap)_page()
      xen/virtio: Fix potential deadlock when accessing xen_grant_dma_devices
