Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA370D143
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjEWCak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjEWCag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:30:36 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB4129
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:30:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjI9X3X_1684809019;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VjI9X3X_1684809019)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 10:30:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     morbidrsa@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drivers: mcb: Modify mismatched function name
Date:   Tue, 23 May 2023 10:30:17 +0800
Message-Id: <20230523023017.41226-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/mcb/mcb-core.c:335: warning: expecting prototype for mcb_bus_put(). Prototype was for mcb_bus_get() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5282
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mcb/mcb-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 978fdfc19a06..520160eaa7b1 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -326,7 +326,7 @@ void mcb_release_bus(struct mcb_bus *bus)
 EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
 
 /**
- * mcb_bus_put() - Increment refcnt
+ * mcb_bus_get() - Increment refcnt
  * @bus: The @mcb_bus
  *
  * Get a @mcb_bus' ref
-- 
2.20.1.7.g153144c

