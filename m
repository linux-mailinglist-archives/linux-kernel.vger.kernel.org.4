Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C06633779
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiKVIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKVIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:50:50 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968302EF4F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:50:48 -0800 (PST)
X-QQ-mid: bizesmtpipv602t1669107037tdwg
Received: from localhost ( [255.228.79.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 22 Nov 2022 16:50:36 +0800 (CST)
X-QQ-SSF: 01400000002000406000B00A0000000
X-QQ-FEAT: ThitmV5dBHUc8+R4PS/wwIIXz1rmlpqArenoIu8cpinLThO+kAJB9ZMrdr1hF
        Jg2W5s258Dc9x9rtH7HssxJ7nlnCrIF4o3/QQvMJvGYmISu6AjFpXG7vjDDhCaXMoBgI70q
        pgWTNVAajuano/NvFyheXZSuX1ww1XWm6Wf+Q/C5fHfUZ6brOxxzN7ZwRRr0PfxaXVbRcIV
        OZr6EKkC0Bg1AWYlp0IBYF5IudKbtfkSYFdVltN/U2iJWnnmI0A/uv+YtfQI7fCIUbAI9EJ
        t6A5oxkVwwBt0jYo3WmgrPQ9WhJvYtll0p3xMrmq9hM3DoHOMiAZ5PyFqrp54P/9R6TLc6F
        jmW1F4v9AIv+Ncbqs4DMe2+nOgG7foEfcGzK6dADTlxINHI+eU=
X-QQ-GoodBg: 2
Date:   Tue, 22 Nov 2022 16:50:36 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] printk: fix a typo of comment
Message-ID: <0C7C980DB815FAE1+Y3yNXJCqZ3Nzxa5V@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo of comment

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
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

