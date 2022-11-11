Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AC6253FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiKKGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiKKGoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:44:55 -0500
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE466172;
        Thu, 10 Nov 2022 22:44:51 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id FHD00048;
        Fri, 11 Nov 2022 14:44:48 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 11 Nov 2022 14:44:47 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <dan.j.williams@intel.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] async_tx: Fix some kernel-doc warnings
Date:   Fri, 11 Nov 2022 01:44:41 -0500
Message-ID: <20221111064441.2926-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221111144448bc1def9f749add3061855c42b4d1d967
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
  crypto/async_tx/async_tx.c:136: warning: cannot understand function prototype: 'enum submit_disposition '
  crypto/async_tx/async_tx.c:264: warning: Function parameter or member 'tx' not described in 'async_tx_quiesce'

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 crypto/async_tx/async_tx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/async_tx/async_tx.c b/crypto/async_tx/async_tx.c
index 9256934312d7..8840731cefbb 100644
--- a/crypto/async_tx/async_tx.c
+++ b/crypto/async_tx/async_tx.c
@@ -33,7 +33,7 @@ static void __exit async_tx_exit(void)
 module_init(async_tx_init);
 module_exit(async_tx_exit);
 
-/**
+/*
  * __async_tx_find_channel - find a channel to carry out the operation or let
  *	the transaction execute synchronously
  * @submit: transaction dependency and submission modifiers
@@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(__async_tx_find_channel);
 #endif
 
 
-/**
+/*
  * async_tx_channel_switch - queue an interrupt descriptor with a dependency
  * 	pre-attached.
  * @depend_tx: the operation that must finish before the new operation runs
@@ -123,7 +123,7 @@ async_tx_channel_switch(struct dma_async_tx_descriptor *depend_tx,
 }
 
 
-/**
+/*
  * submit_disposition - flags for routing an incoming operation
  * @ASYNC_TX_SUBMITTED: we were able to append the new operation under the lock
  * @ASYNC_TX_CHANNEL_SWITCH: when the lock is dropped schedule a channel switch
@@ -209,7 +209,7 @@ async_tx_submit(struct dma_chan *chan, struct dma_async_tx_descriptor *tx,
 }
 EXPORT_SYMBOL_GPL(async_tx_submit);
 
-/**
+/*
  * async_trigger_callback - schedules the callback function to be run
  * @submit: submission and completion parameters
  *
@@ -256,9 +256,9 @@ async_trigger_callback(struct async_submit_ctl *submit)
 }
 EXPORT_SYMBOL_GPL(async_trigger_callback);
 
-/**
+/*
  * async_tx_quiesce - ensure tx is complete and freeable upon return
- * @tx - transaction to quiesce
+ * @*tx - transaction to quiesce
  */
 void async_tx_quiesce(struct dma_async_tx_descriptor **tx)
 {
-- 
2.27.0

