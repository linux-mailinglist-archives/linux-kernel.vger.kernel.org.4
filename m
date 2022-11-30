Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10063CFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiK3Hru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiK3Hrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:47:48 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EFC29C88
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:47:47 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMWX16KH7z4xVnf;
        Wed, 30 Nov 2022 15:47:45 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AU7lXpD096474;
        Wed, 30 Nov 2022 15:47:33 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 15:47:35 +0800 (CST)
Date:   Wed, 30 Nov 2022 15:47:35 +0800 (CST)
X-Zmail-TransId: 2af963870a97ffffffffe135a4fe
X-Mailer: Zmail v1.0
Message-ID: <202211301547353578204@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <zhangqing@loongson.cn>
Cc:     <chenhuacai@kernel.org>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHJlY29yZG1jb3VudDogdXNlICIhUCIgaW5zdGVhZCBvZiAiUCA9PSAwIg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU7lXpD096474
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63870AA1.000 by FangMail milter!
X-FangMail-Envelope: 1669794465/4NMWX16KH7z4xVnf/63870AA1.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870AA1.000/4NMWX16KH7z4xVnf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

comparing pointer to 0, use !P instead of it.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 scripts/recordmcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index cce12e1971d8..8d01decd12e9 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -139,7 +139,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 static void * umalloc(size_t size)
 {
        void *const addr = malloc(size);
-       if (addr == 0) {
+       if (!addr) {
                fprintf(stderr, "malloc failed: %zu bytes\n", size);
                file_append_cleanup();
                mmap_cleanup();
--
2.15.2
