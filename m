Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9616222E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKID5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiKID5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:57:10 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C7178A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:57:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VUMCMKQ_1667966225;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VUMCMKQ_1667966225)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 11:57:06 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] lib: objpool: Fix some kernel-doc comments
Date:   Wed,  9 Nov 2022 11:57:04 +0800
Message-Id: <20221109035704.88975-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the description of @oh to @head in objpool_pop()
to clear the below warnings:

lib/objpool.c:425: warning: Excess function parameter 'oh' description in 'objpool_pop'
lib/objpool.c:425: warning: Function parameter or member 'head' not described in 'objpool_pop'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2821
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 lib/objpool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/objpool.c b/lib/objpool.c
index ecffa0795f3d..96cd43eb53e1 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -414,7 +414,7 @@ static inline void *__objpool_try_get_slot(struct objpool_slot *os)
  * objpool_pop: allocate an object from objects pool
  *
  * args:
- * @oh:  object pool
+ * @head:  object pool used to allocate an object
  *
  * return:
  *   object: NULL if failed (object pool is empty)
-- 
2.20.1.7.g153144c

