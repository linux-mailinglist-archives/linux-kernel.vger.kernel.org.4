Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF146354F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiKWJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiKWJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:13:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB611106103;
        Wed, 23 Nov 2022 01:13:55 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHFm21sNqzmW81;
        Wed, 23 Nov 2022 17:13:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:13:53 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:13:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>
Subject: [PATCH] doc: Fix htmldocs build warnings of stallwarn.rst
Date:   Wed, 23 Nov 2022 17:12:46 +0800
Message-ID: <20221123091246.1890-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/RCU/stallwarn.rst:
401: WARNING: Literal block expected; none found.
428: WARNING: Literal block expected; none found.
445: WARNING: Literal block expected; none found.
459: WARNING: Literal block expected; none found.
468: WARNING: Literal block expected; none found.

The literal block need to be indented, so add two spaces to each line.

In addition, ':', which is used as a boundary in the literal block, is
replaced by '|'.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/RCU/stallwarn.rst | 44 ++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index c1e92dfef40d501..0f6a58ebf5d7855 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
 rcupdate.rcu_cpu_stall_cputime=1, the following additional information
 is supplied with each RCU CPU stall warning::
 
-rcu:          hardirqs   softirqs   csw/system
-rcu:  number:      624         45            0
-rcu: cputime:       69          1         2425   ==> 2500(ms)
+  rcu:          hardirqs   softirqs   csw/system
+  rcu:  number:      624         45            0
+  rcu: cputime:       69          1         2425   ==> 2500(ms)
 
 These statistics are collected during the sampling period. The values
 in row "number:" are the number of hard interrupts, number of soft
@@ -412,22 +412,22 @@ in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
 stalls, these tasks are typically kernel tasks, which is why only the
 system CPU time are considered.
 
-The sampling period is shown as follows:
-:<------------first timeout---------->:<-----second timeout----->:
-:<--half timeout-->:<--half timeout-->:                          :
-:                  :<--first period-->:                          :
-:                  :<-----------second sampling period---------->:
-:                  :                  :                          :
-:          snapshot time point    1st-stall                  2nd-stall
+The sampling period is shown as follows::
 
+  |<------------first timeout---------->|<-----second timeout----->|
+  |<--half timeout-->|<--half timeout-->|                          |
+  |                  |<--first period-->|                          |
+  |                  |<-----------second sampling period---------->|
+  |                  |                  |                          |
+  |          snapshot time point    1st-stall                  2nd-stall
 
 The following describes four typical scenarios:
 
 1. A CPU looping with interrupts disabled.::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:        0          0            0
-   rcu: cputime:        0          0            0   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:        0          0            0
+     rcu: cputime:        0          0            0   ==> 2500(ms)
 
    Because interrupts have been disabled throughout the measurement
    interval, there are no interrupts and no context switches.
@@ -442,9 +442,9 @@ The following describes four typical scenarios:
    and CPU time consumed by hard interrupts, along with non-zero CPU
    time consumed by in-kernel execution.::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:      624          0            0
-   rcu: cputime:       49          0         2446   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:      624          0            0
+     rcu: cputime:       49          0         2446   ==> 2500(ms)
 
    The fact that there are zero softirqs gives a hint that these were
    disabled, perhaps via local_bh_disable().  It is of course possible
@@ -456,18 +456,18 @@ The following describes four typical scenarios:
 
    Here, only the number of context switches is zero.::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:      624         45            0
-   rcu: cputime:       69          1         2425   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:      624         45            0
+     rcu: cputime:       69          1         2425   ==> 2500(ms)
 
    This situation hints that the stalled CPU was looping with preemption
    disabled.
 
 4. No looping, but massive hard and soft interrupts.::
 
-   rcu:          hardirqs   softirqs   csw/system
-   rcu:  number:       xx         xx            0
-   rcu: cputime:       xx         xx            0   ==> 2500(ms)
+     rcu:          hardirqs   softirqs   csw/system
+     rcu:  number:       xx         xx            0
+     rcu: cputime:       xx         xx            0   ==> 2500(ms)
 
    Here, the number and CPU time of hard interrupts are all non-zero,
    but the number of context switches and the in-kernel CPU time consumed
-- 
2.25.1

