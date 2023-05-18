Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524CD707B93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjERIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjERIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:05:26 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063842100
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:05:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VivzZ6G_1684397108;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VivzZ6G_1684397108)
          by smtp.aliyun-inc.com;
          Thu, 18 May 2023 16:05:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm: page_owner: make some functions static
Date:   Thu, 18 May 2023 16:05:07 +0800
Message-Id: <20230518080507.97556-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used outside the file page_owner.c, so the
modification is defined as static.

mm/page_owner.c:748:5: warning: no previous prototype for ‘page_owner_threshold_get’.
mm/page_owner.c:754:5: warning: no previous prototype for ‘page_owner_threshold_set’.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5235
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/page_owner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28c519fc9372..bbec66cd1b72 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -745,13 +745,13 @@ const struct file_operations page_owner_stack_operations = {
 
 unsigned long page_owner_stack_threshold;
 
-int page_owner_threshold_get(void *data, u64 *val)
+static int page_owner_threshold_get(void *data, u64 *val)
 {
 	*val = page_owner_stack_threshold;
 	return 0;
 }
 
-int page_owner_threshold_set(void *data, u64 val)
+static int page_owner_threshold_set(void *data, u64 val)
 {
 	page_owner_stack_threshold = val;
 	return 0;
-- 
2.20.1.7.g153144c

