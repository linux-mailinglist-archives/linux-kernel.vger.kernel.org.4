Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A76632885
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiKUPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKUPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:46:01 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3C2675
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:45:32 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by laurent.telenet-ops.be with bizsmtp
        id n3lW2800L5WXlCv013lW7t; Mon, 21 Nov 2022 16:45:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8zC-0019FQ-EU; Mon, 21 Nov 2022 16:45:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox8zB-00BQQw-Sb; Mon, 21 Nov 2022 16:45:29 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] [trivial] media: dvb_ringbuffer: Fix typo in dvb_ringbuffer_pkt_write() kerneldoc
Date:   Mon, 21 Nov 2022 16:45:28 +0100
Message-Id: <e047cd31c5bb171a04461c6c9636adc4e4fb5677.1669045495.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no such error code EVINAL.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/media/dvb_ringbuffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/dvb_ringbuffer.h b/include/media/dvb_ringbuffer.h
index 8ed6bcc3a56e5ffd..029c8b615e490fae 100644
--- a/include/media/dvb_ringbuffer.h
+++ b/include/media/dvb_ringbuffer.h
@@ -214,7 +214,7 @@ extern ssize_t dvb_ringbuffer_write_user(struct dvb_ringbuffer *rbuf,
  * @buf: Buffer to write.
  * @len: Length of buffer (currently limited to 65535 bytes max).
  *
- * Return: Number of bytes written, or -EFAULT, -ENOMEM, -EVINAL.
+ * Return: Number of bytes written, or -EFAULT, -ENOMEM, -EINVAL.
  */
 extern ssize_t dvb_ringbuffer_pkt_write(struct dvb_ringbuffer *rbuf, u8 *buf,
 					size_t len);
-- 
2.25.1

