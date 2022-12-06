Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02B6447E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiLFPVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLFPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:21:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A31115
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:21:24 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43FCE21C4D;
        Tue,  6 Dec 2022 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670340083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kPuCccgoTLlFNCJvR/fqktliZ98ALKfAAhpa4hrTvpI=;
        b=W10qM1Mqu2DObaVhOl6OVXFJfm86NMEOvU4mPtU8/ZaIShyoImwOh9J8JIV2WTR7eGz5Qg
        bIRVp7ODMpcQyLFLjbmPnFQ8PhMmpPGqov/tiNaNKo8zMmhb9WuM4DSfSnNbiqESbQUMcJ
        wYighZ8Mx91Y2hVB8jWiua0MAwOFrR8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1565F13326;
        Tue,  6 Dec 2022 15:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id g/n8A/Ndj2P8QQAAGKfGzw
        (envelope-from <jgross@suse.com>); Tue, 06 Dec 2022 15:21:23 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.1-rc9
Date:   Tue,  6 Dec 2022 16:21:22 +0100
Message-Id: <20221206152122.17024-1-jgross@suse.com>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-xsa-6.1-rc9-tag

xen: 2 0-day security fixes for xen-netback driver

It contains 2 zero.day fixes for the xen-netback driver (XSA-423 and
XSA-424).


Thanks.

Juergen

 drivers/net/xen-netback/common.h    |   2 +-
 drivers/net/xen-netback/interface.c |   6 +-
 drivers/net/xen-netback/netback.c   | 223 ++++++++++++++++++++----------------
 drivers/net/xen-netback/rx.c        |   8 +-
 4 files changed, 133 insertions(+), 106 deletions(-)

Juergen Gross (1):
      xen/netback: don't call kfree_skb() with interrupts disabled

Ross Lagerwall (1):
      xen/netback: Ensure protocol headers don't fall in the non-linear area
