Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F435B33EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiIIJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIIJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC5956B3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP9Wb5xM9znVBC;
        Fri,  9 Sep 2022 17:22:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 05/16] mm/page_alloc: add __init annotations to init_mem_debugging_and_hardening()
Date:   Fri, 9 Sep 2022 17:24:40 +0800
Message-ID: <20220909092451.24883-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220909092451.24883-1-linmiaohe@huawei.com>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only called by mm_init(). Add __init annotations to it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h | 2 +-
 mm/page_alloc.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 364bcadb4d20..c2277f5aba9e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3093,7 +3093,7 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
 				   unsigned long address, unsigned long size,
 				   pte_fn_t fn, void *data);
 
-extern void init_mem_debugging_and_hardening(void);
+extern void __init init_mem_debugging_and_hardening(void);
 #ifdef CONFIG_PAGE_POISONING
 extern void __kernel_poison_pages(struct page *page, int numpages);
 extern void __kernel_unpoison_pages(struct page *page, int numpages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c81f06d8a4f5..3497919f4ef5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -903,7 +903,7 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
  * order of appearance. So we need to first gather the full picture of what was
  * enabled, and then make decisions.
  */
-void init_mem_debugging_and_hardening(void)
+void __init init_mem_debugging_and_hardening(void)
 {
 	bool page_poisoning_requested = false;
 
-- 
2.23.0

