Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312073DDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFZLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFZLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:44:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C918D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:44:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QqQwr5ZDjz1HC6b;
        Mon, 26 Jun 2023 19:44:12 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Jun
 2023 19:44:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: memory-failure: remove unneeded 'inline' annotation
Date:   Mon, 26 Jun 2023 19:43:43 +0800
Message-ID: <20230626114343.1846587-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
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

Remove unneeded 'inline' annotation from num_poisoned_pages_inc() and
num_poisoned_pages_sub(). No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 66e7b3ceaf2d..aada6ac72fe5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -75,13 +75,13 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
-inline void num_poisoned_pages_inc(unsigned long pfn)
+void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
 	memblk_nr_poison_inc(pfn);
 }
 
-inline void num_poisoned_pages_sub(unsigned long pfn, long i)
+void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
 	if (pfn != -1UL)
-- 
2.27.0

