Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BD6BE164
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCQGkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCQGkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:40:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA89224C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:40:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12F561FDD8;
        Fri, 17 Mar 2023 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679035224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oXhQ00jPveWGt6xvfgqkrGOY8fgVyIZGH7STWyheHWY=;
        b=E1t/Sg7Ji8i0b2pYewTrDjtoAbUewcg/C5VkVXR9piZ0rjNgQLg9gzt99o1W0Vosl/rP6T
        8Ndj7sJyl7xhgjhtsCXV+2rRxks2BF9P9A8LwWnKKnMXcPVvnULAUrDpXixWjmLC9bS7ls
        GgZ5NxXpUshiyN+P/oUavsDn/ONtHsY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF10113428;
        Fri, 17 Mar 2023 06:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wksJNVcLFGQhfwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 17 Mar 2023 06:40:23 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.3-rc3
Date:   Fri, 17 Mar 2023 07:40:23 +0100
Message-Id: <20230317064023.1229-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc3-tag

xen: branch for v6.3-rc3

It contains:

- a small cleanup series for xen time handling
- a patch for enabling the VGA console in a Xen PVH dom0
- a small cleanup patch for the xenfs driver

Thanks.

Juergen

 arch/x86/include/asm/xen/cpuid.h | 22 ++++++++++++++++++----
 arch/x86/xen/Makefile            |  2 +-
 arch/x86/xen/enlighten_pv.c      |  3 ++-
 arch/x86/xen/enlighten_pvh.c     | 13 +++++++++++++
 arch/x86/xen/time.c              |  7 ++-----
 arch/x86/xen/vga.c               |  5 ++---
 arch/x86/xen/xen-ops.h           |  7 ++++---
 drivers/xen/xenfs/xensyms.c      | 10 +++++-----
 include/xen/interface/platform.h |  3 +++
 9 files changed, 50 insertions(+), 22 deletions(-)

Jan Beulich (1):
      x86/PVH: obtain VGA console info in Dom0

Krister Johansen (2):
      xen: update arch/x86/include/asm/xen/cpuid.h
      x86/xen/time: cleanup xen_tsc_safe_clocksource

Yu Zhe (1):
      xen: remove unnecessary (void*) conversions
