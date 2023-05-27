Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C747134E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjE0NGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjE0NGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:06:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE5F3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 06:06:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QT27b0HwxzLmKS;
        Sat, 27 May 2023 21:04:43 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 27 May
 2023 21:06:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched: remove unneeded header files
Date:   Sun, 28 May 2023 04:57:31 +0800
Message-ID: <20230527205731.2283720-1-linmiaohe@huawei.com>
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

Remove some unneeded header files. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/sched.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6408385c7e3f..d3db1a67ad6a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -26,7 +26,6 @@
 #include <linux/bug.h>
 #include <linux/capability.h>
 #include <linux/cgroup_api.h>
-#include <linux/cgroup.h>
 #include <linux/context_tracking.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
@@ -34,8 +33,6 @@
 #include <linux/file.h>
 #include <linux/fs_api.h>
 #include <linux/hrtimer_api.h>
-#include <linux/interrupt.h>
-#include <linux/irq_work.h>
 #include <linux/jiffies.h>
 #include <linux/kref_api.h>
 #include <linux/kthread.h>
@@ -44,19 +41,15 @@
 #include <linux/lockdep.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/mutex_api.h>
 #include <linux/plist.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/profile.h>
-#include <linux/psi.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
-#include <linux/seqlock.h>
 #include <linux/softirq.h>
 #include <linux/spinlock_api.h>
-#include <linux/static_key.h>
 #include <linux/stop_machine.h>
 #include <linux/syscalls_api.h>
 #include <linux/syscalls.h>
-- 
2.27.0

