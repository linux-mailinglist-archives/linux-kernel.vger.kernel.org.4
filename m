Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3295974BCEC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjGHI5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjGHI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:57:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E72107
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:57:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QykcM0YymzPk0j;
        Sat,  8 Jul 2023 16:55:15 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 16:57:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/8] mm: memory-failure: remove unneeded header files
Date:   Sat, 8 Jul 2023 16:57:41 +0800
Message-ID: <20230708085744.3599311-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230708085744.3599311-1-linmiaohe@huawei.com>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Remove some unneeded header files. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 88e48a4801ee..601936f8d30b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -39,7 +39,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/page-flags.h>
-#include <linux/kernel-page-flags.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/dax.h>
@@ -50,7 +49,6 @@
 #include <linux/swap.h>
 #include <linux/backing-dev.h>
 #include <linux/migrate.h>
-#include <linux/suspend.h>
 #include <linux/slab.h>
 #include <linux/swapops.h>
 #include <linux/hugetlb.h>
@@ -59,7 +57,6 @@
 #include <linux/memremap.h>
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
-#include <linux/page-isolation.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
 #include <linux/sysctl.h>
-- 
2.33.0

