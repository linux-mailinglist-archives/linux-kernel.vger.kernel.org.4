Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359886B97E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCNO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCNO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:27:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482326876;
        Tue, 14 Mar 2023 07:27:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21FA21F899;
        Tue, 14 Mar 2023 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678804070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8TxNKtpI04XLAnLEmz7M3NSUXuLRT6vG3gdFIDxCXU=;
        b=TEKm+kbgBv5DNKUVg3fZVCjzh4vkguPjGhL+guVf0uW/1MQ3c4bjHWJmBRM27+NYVtaBmX
        sT9vW4z1vPpy6G3G/6ScEW8hEFfY0ksYLNNh2M8vmtkYhI3oK4SwXcpNajGIcuJ4Vm/qRn
        pIbfX21rDC/9PIkVGDg7vXXuGPjZi+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7DEC13A26;
        Tue, 14 Mar 2023 14:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id itxPM2WEEGSlHQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Mar 2023 14:27:49 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 1/4] xen/blkback: fix white space code style issues
Date:   Tue, 14 Mar 2023 15:27:38 +0100
Message-Id: <20230314142741.24917-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230314142741.24917-1-jgross@suse.com>
References: <20230314142741.24917-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
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

