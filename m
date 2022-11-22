Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934A16333B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiKVDHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiKVDHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:07:14 -0500
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 19:07:12 PST
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F511209A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:07:11 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000005
Received: from localhost (unknown[2409:8a00:1832:dc00:2ea6:d2e9:4f09:cd3])
        by rmsmtp-lg-appmail-34-12048 (RichMail) with SMTP id 2f10637c3c25e14-477af;
        Tue, 22 Nov 2022 11:04:06 +0800 (CST)
X-RM-TRANSID: 2f10637c3c25e14-477af
Date:   Tue, 22 Nov 2022 11:04:05 +0800
From:   Wang Honghui <honghui.wang@139.com>
To:     linux-kernel@vger.kernel.org
Subject: Correct syntax error
Message-ID: <Y3w8JZjR5LygcClz@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="emLd45ZwqBqQW4n1"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--emLd45ZwqBqQW4n1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

printk_ringbuffer.c

--emLd45ZwqBqQW4n1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Correct-grammar-errors.patch"

From 8d1e2b96c62d06bb691802a06501762da606e97e Mon Sep 17 00:00:00 2001
From: Wang Honghui <honghui.wang@139.com>
Date: Mon, 21 Nov 2022 16:58:00 +0800
Subject: [PATCH] Correct syntax error.

Signed-off-by: Wang Honghui <honghui.wang@139.com>
---
 kernel/printk/printk_ringbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 2b7b6ddab4f7..2dc4d5a1f1ff 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -203,7 +203,7 @@
  *	prb_rec_init_wr(&r, 5);
  *
  *	// try to extend, but only if it does not exceed 32 bytes
- *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id()), 32) {
+ *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id(), 32)) {
  *		snprintf(&r.text_buf[r.info->text_len],
  *			 r.text_buf_size - r.info->text_len, "hello");
  *
-- 
2.34.1


--emLd45ZwqBqQW4n1--

