Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA65BC183
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiISCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiISCs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:48:57 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE09193DE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:48:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQ4aFBl_1663555730;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VQ4aFBl_1663555730)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 10:48:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] regulator: of: Fix kernel-doc
Date:   Mon, 19 Sep 2022 10:48:30 +0800
Message-Id: <20220919024830.111874-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220919024830.111874-1-jiapeng.chong@linux.alibaba.com>
References: <20220919024830.111874-1-jiapeng.chong@linux.alibaba.com>
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

drivers/regulator/ti-abb-regulator.c:161: warning: expecting prototype for ti_abb_wait_tranx(). Prototype was for ti_abb_wait_txdone() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2206
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/regulator/ti-abb-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index ce00db27589a..115345e9fded 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -151,7 +151,7 @@ static inline void ti_abb_clear_txdone(const struct ti_abb *abb)
 };
 
 /**
- * ti_abb_wait_tranx() - waits for ABB tranxdone event
+ * ti_abb_wait_txdone() - waits for ABB tranxdone event
  * @dev:	device
  * @abb:	pointer to the abb instance
  *
-- 
2.20.1.7.g153144c

