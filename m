Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6408C720D8F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 05:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjFCDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjFCDNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 23:13:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308201B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 20:13:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QY4b629nNzqSTC;
        Sat,  3 Jun 2023 11:09:06 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 11:13:48 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] sched/fair: remove unneeded header files
Date:   Sat, 3 Jun 2023 19:04:55 +0800
Message-ID: <20230603110455.158944-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

There're some useless header files in fair.c. Remove them.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305280847.ss7JHZEe-lkp@intel.com/
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2:
  fix warning reported by kernel test robot.
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..1b626310cf8c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,16 +21,11 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include <linux/energy_model.h>
-#include <linux/mmap_lock.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/jiffies.h>
-#include <linux/mm_api.h>
-#include <linux/highmem.h>
 #include <linux/spinlock_api.h>
 #include <linux/cpumask_api.h>
-#include <linux/lockdep_api.h>
 #include <linux/softirq.h>
-#include <linux/refcount_api.h>
 #include <linux/topology.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/cond_resched.h>
@@ -42,8 +37,6 @@
 #include <linux/interrupt.h>
 #include <linux/memory-tiers.h>
 #include <linux/mempolicy.h>
-#include <linux/mutex_api.h>
-#include <linux/profile.h>
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
-- 
2.27.0

