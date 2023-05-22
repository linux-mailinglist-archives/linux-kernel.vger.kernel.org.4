Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22970C2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjEVPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjEVPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:54:14 -0400
Received: from out0-208.mail.aliyun.com (out0-208.mail.aliyun.com [140.205.0.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C2AF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:54:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.T98SThD_1684770845;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.T98SThD_1684770845)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 23:54:05 +0800
From:   "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        <christophe.jaillet@wanadoo.fr>,
        "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>
Subject: [PATCH v2] sched/headers: remove duplicate included header files
Date:   Mon, 22 May 2023 23:53:41 +0800
Message-Id: <20230522155341.9420-1-yanyan.yan@antgroup.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These headers are included more than once, some also appear in
kernel/sched/sched.h, so remove them.

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
---
 kernel/sched/build_utility.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96f454f..b9ae5fe42f7b 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -13,16 +13,10 @@
 #include <linux/sched/cputime.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
-#include <linux/sched/loadavg.h>
 #include <linux/sched/nohz.h>
-#include <linux/sched/mm.h>
-#include <linux/sched/rseq_api.h>
 #include <linux/sched/task_stack.h>
 
-#include <linux/cpufreq.h>
-#include <linux/cpumask_api.h>
 #include <linux/cpuset.h>
-#include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/energy_model.h>
 #include <linux/hashtable_api.h>
@@ -32,18 +26,12 @@
 #include <linux/mempolicy.h>
 #include <linux/nmi.h>
 #include <linux/nospec.h>
-#include <linux/proc_fs.h>
-#include <linux/psi.h>
-#include <linux/psi.h>
 #include <linux/ptrace_api.h>
 #include <linux/sched_clock.h>
 #include <linux/security.h>
-#include <linux/spinlock_api.h>
 #include <linux/swait_api.h>
 #include <linux/timex.h>
 #include <linux/utsname.h>
-#include <linux/wait_api.h>
-#include <linux/workqueue_api.h>
 
 #include <uapi/linux/prctl.h>
 #include <uapi/linux/sched/types.h>
-- 
2.40.0

