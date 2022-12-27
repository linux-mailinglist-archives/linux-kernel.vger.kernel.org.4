Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B7B656855
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiL0ISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiL0ISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:18:17 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2F6457
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:18:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VYCurfl_1672129087;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VYCurfl_1672129087)
          by smtp.aliyun-inc.com;
          Tue, 27 Dec 2022 16:18:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mfd: max8925: Remove the unused function irq_to_max8925()
Date:   Tue, 27 Dec 2022 16:18:05 +0800
Message-Id: <20221227081805.54185-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function irq_to_max8925() is defined in the max8925-core.c
file, but not called elsewhere, so remove this unused function.

drivers/mfd/max8925-core.c:472:40: warning: unused function 'irq_to_max8925'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3561
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mfd/max8925-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index eb3f061c8ee6..0246bbe80354 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -469,12 +469,6 @@ static struct max8925_irq_data max8925_irqs[] = {
 	},
 };
 
-static inline struct max8925_irq_data *irq_to_max8925(struct max8925_chip *chip,
-						      int irq)
-{
-	return &max8925_irqs[irq - chip->irq_base];
-}
-
 static irqreturn_t max8925_irq(int irq, void *data)
 {
 	struct max8925_chip *chip = data;
-- 
2.20.1.7.g153144c

