Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B199720E21
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjFCGeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 02:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:34:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D76E58
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 23:34:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QY97M6j6dzTktS;
        Sat,  3 Jun 2023 14:33:51 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 14:34:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: remove obsolete alloc_migrate_target()
Date:   Sat, 3 Jun 2023 22:25:13 +0800
Message-ID: <20230603142513.787000-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's only declaration left in the header file. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/page-isolation.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 0ab089e89db4..4ac34392823a 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -45,7 +45,4 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags);
-
-struct page *alloc_migrate_target(struct page *page, unsigned long private);
-
 #endif
-- 
2.27.0

