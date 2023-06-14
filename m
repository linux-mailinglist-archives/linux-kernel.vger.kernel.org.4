Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84956720DA4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 05:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjFCDe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 23:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFCDez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 23:34:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6EDE48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 20:34:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QY53N4vLnzqTfF;
        Sat,  3 Jun 2023 11:30:08 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 11:34:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm: page_alloc: remove unneeded header files
Date:   Sat, 3 Jun 2023 19:25:58 +0800
Message-ID: <20230603112558.213694-1-linmiaohe@huawei.com>
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

Remove some unneeded header files. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 19d97dde4558..e991c6b4d252 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -26,7 +26,6 @@
 #include <linux/kmsan.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
-#include <linux/pagevec.h>
 #include <linux/ratelimit.h>
 #include <linux/oom.h>
 #include <linux/topology.h>
@@ -36,8 +35,6 @@
 #include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/vmstat.h>
-#include <linux/sort.h>
-#include <linux/pfn.h>
 #include <linux/fault-inject.h>
 #include <linux/compaction.h>
 #include <trace/events/kmem.h>
@@ -52,7 +49,6 @@
 #include <linux/memcontrol.h>
 #include <linux/ftrace.h>
 #include <linux/lockdep.h>
-#include <linux/nmi.h>
 #include <linux/psi.h>
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
-- 
2.27.0

