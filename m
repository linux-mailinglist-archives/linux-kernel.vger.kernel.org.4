Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3B69BE90
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 06:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBSFde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 00:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSFdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 00:33:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474112BD9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 21:33:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52189205B9;
        Sun, 19 Feb 2023 05:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676784807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=832f7y/DEQYVNUWLP48lxy1p/M35cveOY0myYlavc1w=;
        b=upN1/SCIPXlb6jyI32YIG7qFUWroZV28TAjKX8jrvE9zckezEYa3l3FXqDepsPlucEVfKS
        TL0lBYsQ4RYmu0bTmjgGRPNsith4+Rmygwdlj2bg4s1jCWL5rOy2sXASDdZinwE7Q6fT3h
        Fq3tTX2JhVkBspHc8eL5HSbx6v+mmJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28EE9139D3;
        Sun, 19 Feb 2023 05:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6O+aCKe08WMDVAAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 19 Feb 2023 05:33:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.3-rc1
Date:   Sun, 19 Feb 2023 06:33:26 +0100
Message-Id: <20230219053326.4980-1-jgross@suse.com>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc1-tag

xen: branch for v6.3-rc1

It contains the following patches:

- A patch to help deprecating the /proc/xen files by making the related
  information available via sysfs.

- 2 patches for making the Xen variants of play_dead "noreturn".

- A patch to support a shared Xen platform interrupt.

- Several small cleanups and fixes.


Thanks.

Juergen

 Documentation/ABI/stable/sysfs-hypervisor-xen | 13 +++++
 arch/x86/xen/setup.c                          |  4 --
 arch/x86/xen/smp.h                            |  2 +
 arch/x86/xen/smp_pv.c                         | 17 ++-----
 arch/x86/xen/time.c                           | 38 +++++++++++++-
 arch/x86/xen/xen-head.S                       |  7 +++
 drivers/xen/events/events_base.c              |  9 ++--
 drivers/xen/grant-dma-iommu.c                 | 11 ++++-
 drivers/xen/platform-pci.c                    |  5 +-
 drivers/xen/pvcalls-back.c                    |  3 +-
 drivers/xen/sys-hypervisor.c                  | 71 +++++++++++++++++++++++++--
 drivers/xen/xen-front-pgdir-shbuf.c           |  2 +-
 include/xen/events.h                          |  2 +-
 tools/objtool/check.c                         |  1 +
 14 files changed, 151 insertions(+), 34 deletions(-)

David Woodhouse (1):
      xen: Allow platform PCI interrupt to be shared

Gustavo A. R. Silva (1):
      xen: Replace one-element array with flexible-array member

Jan Beulich (1):
      x86/Xen: drop leftover VM-assist uses

Juergen Gross (2):
      x86/xen: don't let xen_pv_play_dead() return
      x86/xen: mark xen_pv_play_dead() as __noreturn

Krister Johansen (1):
      x86/xen/time: prefer tsc as clocksource when it is invariant

Oleksandr Tyshchenko (1):
      xen/grant-dma-iommu: Implement a dummy probe_device() callback

Per Bilse (1):
      drivers/xen/hypervisor: Expose Xen SIF flags to userspace

Thomas Weißschuh (1):
      xen: sysfs: make kobj_type structure constant

Volodymyr Babchuk (1):
      xen/pvcalls-back: fix permanently masked event channel
