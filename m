Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328E95BC19C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiISDEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISDEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:04:45 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF808B87
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:04:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQ4furg_1663556672;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VQ4furg_1663556672)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 11:04:39 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] spmi: Fix kernel-doc
Date:   Mon, 19 Sep 2022 11:04:29 +0800
Message-Id: <20220919030429.2303-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/spmi/spmi.c:414: warning: expecting prototype for spmi_controller_alloc(). Prototype was for spmi_device_alloc() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2207
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/spmi/spmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index a456ce5141e1..9c07a4ca5d50 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -404,7 +404,7 @@ struct spmi_device *spmi_device_from_of(struct device_node *np)
 EXPORT_SYMBOL_GPL(spmi_device_from_of);
 
 /**
- * spmi_controller_alloc() - Allocate a new SPMI device
+ * spmi_device_alloc() - Allocate a new SPMI device
  * @ctrl:	associated controller
  *
  * Caller is responsible for either calling spmi_device_add() to add the
-- 
2.20.1.7.g153144c

