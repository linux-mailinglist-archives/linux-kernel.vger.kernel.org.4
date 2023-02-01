Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E826862E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBAJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjBAJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:31:03 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CA61D51
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:30:50 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P6Gqp1Ycrz6FN00;
        Wed,  1 Feb 2023 17:30:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 3119UQ3S099088;
        Wed, 1 Feb 2023 17:30:26 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 1 Feb 2023 17:30:29 +0800 (CST)
Date:   Wed, 1 Feb 2023 17:30:29 +0800 (CST)
X-Zmail-TransId: 2af963da313540da8db5
X-Mailer: Zmail v1.0
Message-ID: <202302011730294177177@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <tudor.ambarus@linaro.org>
Cc:     <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtdGQ6IHNwaS1ub3I6IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZWQgaGVhZGVyIGZpbGVz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3119UQ3S099088
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63DA3146.003 by FangMail milter!
X-FangMail-Envelope: 1675243846/4P6Gqp1Ycrz6FN00/63DA3146.003/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63DA3146.003/4P6Gqp1Ycrz6FN00
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

linux/delay.h is included more than once.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mtd/spi-nor/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e9ea14598ec3..d67c926bca8b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -16,7 +16,6 @@
 #include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
-#include <linux/delay.h>

 #include <linux/mtd/mtd.h>
 #include <linux/of_platform.h>
-- 
2.25.1
