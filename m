Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D561E078
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 07:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKFGAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFGAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:00:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF621D2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 23:00:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DA1A1F950;
        Sun,  6 Nov 2022 05:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667714399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8hVb6BAyWvekO938dQSC+RJ8T7govWTrExn1p5zb8JU=;
        b=nbO5SOj8oSk1Wc6NC1zqUlHYUboewu/rFh7gRlQxz5QNG6n0JrCA1nTPpK98nAWanzV0ak
        UljRMSzvy6qoaeujTPcpcfsWzvT3ybfV3taCt7SmU52+d02nsrEfbM5XA6tZuw1bXiwGI+
        uBjL8FaLKaMNp4sGw4Sn99D8r037Ct4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 268D8132E7;
        Sun,  6 Nov 2022 05:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jppJB19NZ2ODJwAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 06 Nov 2022 05:59:59 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.1-rc4
Date:   Sun,  6 Nov 2022 06:59:58 +0100
Message-Id: <20221106055958.14139-1-jgross@suse.com>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc4-tag

xen: branch for v6.1-rc4

It contains only one fix for silencing a smatch warning, and a small
cleanup patch.

Thanks.

Juergen

 arch/x86/xen/pmu.c   |  2 +-
 arch/x86/xen/setup.c | 23 ++++++-----------------
 2 files changed, 7 insertions(+), 18 deletions(-)

Juergen Gross (2):
      x86/xen: silence smatch warning in pmu_msr_chk_emulated()
      x86/xen: simplify sysenter and syscall setup
