Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C064ED43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiLPO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiLPO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F55E088;
        Fri, 16 Dec 2022 06:58:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E26834319;
        Fri, 16 Dec 2022 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671202705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p34lXTXH9ojVsTIXuK1Z0GIkt5wxYDiGjhLtCnvUauk=;
        b=AngV43GSjP+EgZTw+CQomnAcO316/D35yfh/mfBKQ5hF4BdyCtiwaz7XtMvsvlXtA/c1xA
        5yE4jmHwbvtFR3rtls0oq7hPzQmFM+JuYtDOQPNab6b39P/kVA26097d3KntzSou1AUQ24
        LYMy0SHyMyqHH5dVQpG/hN1PdAc4s+c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EBA6138FD;
        Fri, 16 Dec 2022 14:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Woe6FZGHnGO1eAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 16 Dec 2022 14:58:25 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH 1/4] xen/blkback: fix white space code style issues
Date:   Fri, 16 Dec 2022 15:58:13 +0100
Message-Id: <20221216145816.27374-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216145816.27374-1-jgross@suse.com>
References: <20221216145816.27374-1-jgross@suse.com>
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

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/blkback.c | 2 +-
 drivers/block/xen-blkback/common.h  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index a5cf7f1e871c..6e2163aaf362 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -891,7 +891,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 out:
 	for (i = last_map; i < num; i++) {
 		/* Don't zap current batch's valid persistent grants. */
-		if(i >= map_until)
+		if (i >= map_until)
 			pages[i]->persistent_gnt = NULL;
 		pages[i]->handle = BLKBACK_INVALID_HANDLE;
 	}
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index a28473470e66..9a13a6b420a6 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -296,7 +296,7 @@ struct xen_blkif_ring {
 	struct work_struct	free_work;
 	/* Thread shutdown wait queue. */
 	wait_queue_head_t	shutdown_wq;
-	struct xen_blkif 	*blkif;
+	struct xen_blkif	*blkif;
 };
 
 struct xen_blkif {
@@ -315,7 +315,7 @@ struct xen_blkif {
 	atomic_t		drain;
 
 	struct work_struct	free_work;
-	unsigned int 		nr_ring_pages;
+	unsigned int		nr_ring_pages;
 	bool			multi_ref;
 	/* All rings for this device. */
 	struct xen_blkif_ring	*rings;
@@ -329,7 +329,7 @@ struct seg_buf {
 };
 
 struct grant_page {
-	struct page 		*page;
+	struct page		*page;
 	struct persistent_gnt	*persistent_gnt;
 	grant_handle_t		handle;
 	grant_ref_t		gref;
-- 
2.35.3

