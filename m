Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3865631E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiKUKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiKUKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:20:44 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C427CE0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:20:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VVKKCcj_1669026038;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VVKKCcj_1669026038)
          by smtp.aliyun-inc.com;
          Mon, 21 Nov 2022 18:20:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mike.kravetz@oracle.com
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/hugetlb: stop using 0 as NULL pointer
Date:   Mon, 21 Nov 2022 18:20:37 +0800
Message-Id: <20221121102037.75307-1-yang.lee@linux.alibaba.com>
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

mm/hugetlb.c:1531:37: warning: Using plain integer as NULL pointer

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3224
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 222937d512c4..b6c2fc882f21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1528,7 +1528,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 	}
 
 	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
-	folio_change_private(folio, 0);
+	folio_change_private(folio, NULL);
 	/*
 	 * We have to set HPageVmemmapOptimized again as above
 	 * folio_change_private(folio, 0) cleared it.
-- 
2.20.1.7.g153144c

