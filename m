Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A16802C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjA2XLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjA2XLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:11:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5451ABED;
        Sun, 29 Jan 2023 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=Q12Y5QY2RHdOdj2O/7X6A5JVjbRKxpcv3Q7sikmYOrE=; b=bA4cKVggoDWmlybjfhWX24yU1q
        a1QaO766kjKLJmJ2/iMIFkHBcMX3mPrmmkBmHkhk3lN33+hnnAEHrtkO2BZdYCktSa0MdQgOj0nQc
        Go/L0veXY53vU3Hg4j5wOow9mF8cWuGOwopv4ggrvveByQS8BQE/YxRJdWdcQx7SZKpO3zuHa0f15
        s1WOEq3w4ct2zgBHqK9jRSZ2/Q7At8i5maEg+yNon+kSsA7gKcq2ETlkAWoEx+9KbCi5boujUHwuq
        C+AWT9wwX1Dq1xVOPiAryN3wR2eRYF1p852Fgoy3UU4o9jIEd/zFyDTxAAqUWBSrqgNrQRW6LN2Kx
        T9FmvG1g==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGp9-0020M2-Cl; Sun, 29 Jan 2023 23:10:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 5/9] Documentation: RCU: correct spelling
Date:   Sun, 29 Jan 2023 15:10:49 -0800
Message-Id: <20230129231053.20863-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/RCU/ as reported
by codespell.

Note: in RTFP.txt, there are other misspellings that are left as is
since they were used that way in email Subject: lines or in LWN.net
articles. [preemptable, Preemptable, synchonisation]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: rcu@vger.kernel.org
---
 .../Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst |    6 +++---
 .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst        |    2 +-
 .../RTFP.txt                                                   |   10 +++++-----
 .../UP.rst                                                     |    4 ++--
 .../lockdep.rst                                                |    2 +-
 .../torture.rst                                                |    4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff -- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -277,7 +277,7 @@ the following access functions:
 
 Again, only one request in a given batch need actually carry out a
 grace-period operation, which means there must be an efficient way to
-identify which of many concurrent reqeusts will initiate the grace
+identify which of many concurrent requests will initiate the grace
 period, and that there be an efficient way for the remaining requests to
 wait for that grace period to complete. However, that is the topic of
 the next section.
@@ -405,7 +405,7 @@ Use of Workqueues
 In earlier implementations, the task requesting the expedited grace
 period also drove it to completion. This straightforward approach had
 the disadvantage of needing to account for POSIX signals sent to user
-tasks, so more recent implemementations use the Linux kernel's
+tasks, so more recent implementations use the Linux kernel's
 workqueues (see Documentation/core-api/workqueue.rst).
 
 The requesting task still does counter snapshotting and funnel-lock
@@ -465,7 +465,7 @@ corresponding disadvantage that workqueu
 initialized, which does not happen until some time after the scheduler
 spawns the first task. Given that there are parts of the kernel that
 really do want to execute grace periods during this mid-boot “dead
-zone”, expedited grace periods must do something else during thie time.
+zone”, expedited grace periods must do something else during this time.
 
 What they do is to fall back to the old practice of requiring that the
 requesting task drive the expedited grace period, as was the case before
diff -- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -168,7 +168,7 @@ an ``atomic_add_return()`` of zero) to d
 +-----------------------------------------------------------------------+
 
 The approach must be extended to handle one final case, that of waking a
-task blocked in ``synchronize_rcu()``. This task might be affinitied to
+task blocked in ``synchronize_rcu()``. This task might be affined to
 a CPU that is not yet aware that the grace period has ended, and thus
 might not yet be subject to the grace period's memory ordering.
 Therefore, there is an ``smp_mb()`` after the return from
diff -- a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -65,7 +65,7 @@ checking of rcu_dereference() primitives
 	rcu_access_pointer(p):
 		Return the value of the pointer and omit all barriers,
 		but retain the compiler constraints that prevent duplicating
-		or coalescsing.  This is useful when testing the
+		or coalescing.  This is useful when testing the
 		value of the pointer itself, for example, against NULL.
 
 The rcu_dereference_check() check expression can be any boolean
diff -- a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -201,7 +201,7 @@ work looked at debugging uses of RCU [Se
 In 2012, Josh Triplett received his Ph.D. with his dissertation
 covering RCU-protected resizable hash tables and the relationship
 between memory barriers and read-side traversal order:  If the updater
-is making changes in the opposite direction from the read-side traveral
+is making changes in the opposite direction from the read-side traversal
 order, the updater need only execute a memory-barrier instruction,
 but if in the same direction, the updater needs to wait for a grace
 period between the individual updates [JoshTriplettPhD].  Also in 2012,
@@ -1245,7 +1245,7 @@ Oregon Health and Sciences University"
 [Viewed September 5, 2005]"
 ,annotation={
 	First posting showing how RCU can be safely adapted for
-	preemptable RCU read side critical sections.
+	preemptible RCU read side critical sections.
 }
 }
 
@@ -1888,7 +1888,7 @@ Revised:
 \url{https://lore.kernel.org/r/20070910183004.GA3299@linux.vnet.ibm.com}
 [Viewed October 25, 2007]"
 ,annotation={
-	Final patch for preemptable RCU to -rt.  (Later patches were
+	Final patch for preemptible RCU to -rt.  (Later patches were
 	to mainline, eventually incorporated.)
 }
 }
@@ -2275,7 +2275,7 @@ lot of {Linux} into your technology!!!"
 \url{https://lore.kernel.org/r/20090724001429.GA17374@linux.vnet.ibm.com}
 [Viewed August 15, 2009]"
 ,annotation={
-	First posting of simple and fast preemptable RCU.
+	First posting of simple and fast preemptible RCU.
 }
 }
 
@@ -2639,7 +2639,7 @@ lot of {Linux} into your technology!!!"
 	RCU-protected hash tables, barriers vs. read-side traversal order.
 	.
 	If the updater is making changes in the opposite direction from
-	the read-side traveral order, the updater need only execute a
+	the read-side traversal order, the updater need only execute a
 	memory-barrier instruction, but if in the same direction, the
 	updater needs to wait for a grace period between the individual
 	updates.
diff -- a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -216,7 +216,7 @@ Kernel boot arguments can also be suppli
 rcutorture's module parameters.  For example, to test a change to RCU's
 CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
 This will of course result in the scripting reporting a failure, namely
-the resuling RCU CPU stall warning.  As noted above, reducing memory may
+the resulting RCU CPU stall warning.  As noted above, reducing memory may
 require disabling rcutorture's callback-flooding tests::
 
 	kvm.sh --cpus 448 --configs '56*TREE04' --memory 128M \
@@ -370,5 +370,5 @@ You can also re-run a previous remote ru
 		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
 		--duration 24h
 
-In this case, most of the kvm-again.sh parmeters may be supplied following
+In this case, most of the kvm-again.sh parameters may be supplied following
 the pathname of the old run-results directory.
diff -- a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
--- a/Documentation/RCU/UP.rst
+++ b/Documentation/RCU/UP.rst
@@ -107,7 +107,7 @@ UP systems, including PREEMPT SMP builds
 
 Quick Quiz #3:
 	Why can't synchronize_rcu() return immediately on UP systems running
-	preemptable RCU?
+	preemptible RCU?
 
 .. _answer_quick_quiz_up:
 
@@ -143,7 +143,7 @@ Answer to Quick Quiz #2:
 
 Answer to Quick Quiz #3:
 	Why can't synchronize_rcu() return immediately on UP systems
-	running preemptable RCU?
+	running preemptible RCU?
 
 	Because some other task might have been preempted in the middle
 	of an RCU read-side critical section.  If synchronize_rcu()
