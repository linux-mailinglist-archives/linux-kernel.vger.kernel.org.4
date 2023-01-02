Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0665ADB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 08:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjABHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 02:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABHab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 02:30:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BD111B;
        Sun,  1 Jan 2023 23:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bLWETpLjeuylqYkvPIWNbfGdf7cs1oR5lWW9NWB/8PQ=; b=d4wyv1ytBKpwRGo0CvDxZ28J17
        FeogQLlsYiP91AEnmE1VKJbO2gZRa6kp43Ek/fNS3Lzzgfa4/whJAeeTQw1XoQP5lJkV4AcpBzbWl
        Eq/X56N2wi/koae7+AfMB2F1xYlJFl5zAt7DmmKO2BVy65tjwydsRnQ2rfk57wMvllHPDVc61hXk2
        6PfbT31wHKr9TAafrGNLIEM/6DN4xf383GNka8LzISIVJgiekCiA07JgBjH3TadODStEUpT4C/jzI
        YL+7K0ls1iABZei9+HOxPkuX4wwaevfcBl3jNvCNnVn1K/HAmmxKZ4A80P5G6brKf6HkLRouGO9Rm
        pzx1uGSg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCFHA-009DSK-Ul; Mon, 02 Jan 2023 07:30:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] async_tx: fix kernel-doc notation warnings
Date:   Sun,  1 Jan 2023 23:30:28 -0800
Message-Id: <20230102073028.28870-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 kernel-doc warnings by adding "struct" keyword:

crypto/async_tx/async_tx.c:136: warning: cannot understand function prototype: 'enum submit_disposition '
crypto/async_tx/async_pq.c:18: warning: cannot understand function prototype: 'struct page *pq_scribble_page; '

Also fix 2 function parameter descriptions.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/async_tx/async_pq.c |    4 ++--
 crypto/async_tx/async_tx.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -12,7 +12,7 @@
 #include <linux/gfp.h>
 
 /**
- * pq_scribble_page - space to hold throwaway P or Q buffer for
+ * struct pq_scribble_page - space to hold throwaway P or Q buffer for
  * synchronous gen_syndrome
  */
 static struct page *pq_scribble_page;
@@ -281,7 +281,7 @@ pq_val_chan(struct async_submit_ctl *sub
 /**
  * async_syndrome_val - asynchronously validate a raid6 syndrome
  * @blocks: source blocks from idx 0..disks-3, P @ disks-2 and Q @ disks-1
- * @offset: common offset into each block (src and dest) to start transaction
+ * @offsets: common offset into each block (src and dest) to start transaction
  * @disks: number of blocks (including missing P or Q, see below)
  * @len: length of operation in bytes
  * @pqres: on val failure SUM_CHECK_P_RESULT and/or SUM_CHECK_Q_RESULT are set
diff -- a/crypto/async_tx/async_tx.c b/crypto/async_tx/async_tx.c
--- a/crypto/async_tx/async_tx.c
+++ b/crypto/async_tx/async_tx.c
@@ -124,7 +124,7 @@ async_tx_channel_switch(struct dma_async
 
 
 /**
- * submit_disposition - flags for routing an incoming operation
+ * enum submit_disposition - flags for routing an incoming operation
  * @ASYNC_TX_SUBMITTED: we were able to append the new operation under the lock
  * @ASYNC_TX_CHANNEL_SWITCH: when the lock is dropped schedule a channel switch
  * @ASYNC_TX_DIRECT_SUBMIT: when the lock is dropped submit directly
@@ -258,7 +258,7 @@ EXPORT_SYMBOL_GPL(async_trigger_callback
 
 /**
  * async_tx_quiesce - ensure tx is complete and freeable upon return
- * @tx - transaction to quiesce
+ * @tx: transaction to quiesce
  */
 void async_tx_quiesce(struct dma_async_tx_descriptor **tx)
 {
