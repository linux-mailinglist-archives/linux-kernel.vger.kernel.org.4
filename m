Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42AF69A74B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBQIq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBQIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:46:57 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FB5F811
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:46:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vbs.Evp_1676623608;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vbs.Evp_1676623608)
          by smtp.aliyun-inc.com;
          Fri, 17 Feb 2023 16:46:53 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] maple_tree: Remove some unused functions
Date:   Fri, 17 Feb 2023 16:46:47 +0800
Message-Id: <20230217084647.50471-1-jiapeng.chong@linux.alibaba.com>
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

These functions are defined in the maple_tree.c file, but not called
elsewhere, so delete these unused functions.

lib/maple_tree.c:331:21: warning: unused function 'mte_set_full'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4105
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/maple_tree.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 646297cae5d1..f89b61e37d93 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -328,21 +328,6 @@ static inline void *mte_safe_root(const struct maple_enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void *mte_set_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
-}
-
-static inline void *mte_clear_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
-}
-
-static inline bool mte_has_null(const struct maple_enode *node)
-{
-	return (unsigned long)node & MAPLE_ENODE_NULL;
-}
-
 static inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
-- 
2.20.1.7.g153144c

