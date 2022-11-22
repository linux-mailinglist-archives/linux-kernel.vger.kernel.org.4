Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4016333C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiKVDMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiKVDM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:12:29 -0500
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16D5312
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:12:26 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[2409:8a00:1832:dc00:2ea6:d2e9:4f09:cd3])
        by rmsmtp-lg-appmail-02-12080 (RichMail) with SMTP id 2f30637c3dfd103-4a606;
        Tue, 22 Nov 2022 11:11:59 +0800 (CST)
X-RM-TRANSID: 2f30637c3dfd103-4a606
Date:   Tue, 22 Nov 2022 11:11:58 +0800
From:   Wang Honghui <honghui.wang@139.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Correct syntax error.
Message-ID: <Y3w9/vvMQW3Fc3dG@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


