Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4B7132A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjE0Ffv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0Fft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:35:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A5114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:35:47 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2DAF1F381;
        Sat, 27 May 2023 05:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685165745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oSTN1BPSP9tLeSFNLAlCJe9fSQGY+JofX+1sr1rhixA=;
        b=Ivl0RidbdCzC08rHVPLS4MR+BjtZ+BzVdtqVjHybO8r+ulA5IboiwPUlZ04IM4FzA84dIe
        59yYLh39GkLsYjvNIncm6vW7hLlOfUmkNVaYBP5CAS1XGs/ciXQngBpBqXhLi/heor+AJi
        bkuzGtfS8JdheiVtx9RVgVQ0s2QBjK8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C6564134AB;
        Sat, 27 May 2023 05:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id bi9+LrCWcWTnVwAAGKfGzw
        (envelope-from <jgross@suse.com>); Sat, 27 May 2023 05:35:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.4-rc4
Date:   Sat, 27 May 2023 07:35:44 +0200
Message-Id: <20230527053544.31822-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.4-rc4-tag

xen: branch for v6.4-rc4

It contains 3 fixes:

- a double free fix in the Xen pvcalls backend driver

- a fix for a regression causing the MSI related sysfs entries to not
  being created in Xen PV guests

- a fix in the Xen blkfront driver for handling insane input data better

Thanks.

Juergen

 arch/x86/pci/xen.c           | 8 +++++---
 drivers/block/xen-blkfront.c | 3 ++-
 drivers/xen/pvcalls-back.c   | 9 ++++-----
 include/linux/msi.h          | 9 ++++++++-
 kernel/irq/msi.c             | 4 ++--
 5 files changed, 21 insertions(+), 12 deletions(-)

Dan Carpenter (1):
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Maximilian Heyne (1):
      x86/pci/xen: populate MSI sysfs entries

Ross Lagerwall (1):
      xen/blkfront: Only check REQ_FUA for writes
