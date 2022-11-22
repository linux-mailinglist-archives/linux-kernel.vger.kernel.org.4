Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84C6336F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiKVIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiKVIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:24:57 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7D286DF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:24:54 -0800 (PST)
X-QQ-mid: bizesmtpipv603t1669105400trcq
Received: from localhost ( [255.13.167.10])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 22 Nov 2022 16:23:19 +0800 (CST)
X-QQ-SSF: 01400000002000306000B00A0000000
X-QQ-FEAT: PePGYSBm5rSd2f1oHUuE0Ja94umrCJb0d3H3QW29dpAamSItUoIrcmUk7Fgm9
        3AjiWfaDG5j27Hoj6CNr+ROSTPM2hExW7JNefvKJg/jUwrLA8NzyBavKDO0z0fgyP4u+qtx
        Wh0upz204/lPRXWzf//Phwjl6kbsW4DrVJ/aZ4epVlXZlR4tWEVhkLNb6jsps3f0QMccNYt
        arqkyZWKtfaRdf0WVzlx2VQtcHYbXU3LAsxBdG12HUds/gAbT50gTHeWDTfY7yB4OLsrc4A
        NKmZIgB3X1RVj1ZBk6lCv6coSU51HuZSzgSxWXQeSP30Upqd2F0KLcDHQ6gcU5BgDqa7A+P
        UWc90Fd/jWvflwTwDKH9AD9lXI4otgpxLZJurfzOHZ10V4ogOlVJ9Y9uzBhqw==
X-QQ-GoodBg: 2
Date:   Tue, 22 Nov 2022 16:23:19 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: fix a typo of comment
Message-ID: <77522C532189E547+Y3yG91g6XALbtdJr@TP-P15V.lan>
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

Printk: Fix a typo of commen

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

