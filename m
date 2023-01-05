Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1355865E154
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjAEAKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjAEAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE843A2D;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE396188F;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92851C433AA;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=ho1bxeu1IhGy97GpWjdnxhE2TC9LF5q8tcAiwvvPzeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJ3zgjmmeVYRUZWKz3Hc3b4JA/1xhMBBNSCPzttQ53K1KG0VdevBIr+rUJdITVKnZ
         dHtVC2CfB3z+rzT4NEKQO++KJFVpV7lhTcRIPd7Xtw44wTFG2I8J6LGbeKK4lXASsP
         x/L9YC7/SOGNohGoUdj2eY7/DTOfW3Lj5ZG/QpoUlA2ifquhafpk9t8TwyIdxAvcou
         gtb/BQmMP5ov+Rvz7wW1MuFOAuUNgk5eSA684ynLxPYjMJQll70kEM57xJ8OY5iuD0
         YxpXeTw/5Tf2nj3ulELuWxc5ylVvv4i+7WqQEP3CaXA3hJfL7U95mEBUlx+ccg2r/n
         iLKQm+rkenU+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DBD785C1C98; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/15] docs/RCU/rcubarrier: Right-adjust line numbers in code snippets
Date:   Wed,  4 Jan 2023 16:09:54 -0800
Message-Id: <20230105000955.1767218-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

Line numbers in code snippets in rcubarrier.rst have beed left adjusted
since commit 4af498306ffd ("doc: Convert to rcubarrier.txt to ReST").
This might have been because right adjusting them had confused Sphinx.

The rules around a literal block in reST are:

  - Need a blank line above it.
  - A line with the same indent level as the line above it is regarded
    as the end of it.

Those line numbers can be right adjusted by keeping indents at two-
digit numbers. While at it, add some spaces between the column of line
numbers and the code area for better readability.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcubarrier.rst | 168 +++++++++++++++----------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 9fb9ed7773552..6da7f66da2a80 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -72,9 +72,9 @@ For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
 call_srcu() on srcu_struct_2, then the following three lines of code
 will be required when unloading::
 
- 1 rcu_barrier();
- 2 srcu_barrier(&srcu_struct_1);
- 3 srcu_barrier(&srcu_struct_2);
+  1  rcu_barrier();
+  2  srcu_barrier(&srcu_struct_1);
+  3  srcu_barrier(&srcu_struct_2);
 
 If latency is of the essence, workqueues could be used to run these
 three functions concurrently.
@@ -82,69 +82,69 @@ three functions concurrently.
 An ancient version of the rcutorture module makes use of rcu_barrier()
 in its exit function as follows::
 
- 1  static void
- 2  rcu_torture_cleanup(void)
- 3  {
- 4    int i;
- 5
- 6    fullstop = 1;
- 7    if (shuffler_task != NULL) {
- 8     VERBOSE_PRINTK_STRING("Stopping rcu_torture_shuffle task");
- 9     kthread_stop(shuffler_task);
- 10   }
- 11   shuffler_task = NULL;
+  1  static void
+  2  rcu_torture_cleanup(void)
+  3  {
+  4    int i;
+  5
+  6    fullstop = 1;
+  7    if (shuffler_task != NULL) {
+  8      VERBOSE_PRINTK_STRING("Stopping rcu_torture_shuffle task");
+  9      kthread_stop(shuffler_task);
+ 10    }
+ 11    shuffler_task = NULL;
  12
- 13   if (writer_task != NULL) {
- 14     VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
- 15     kthread_stop(writer_task);
- 16   }
- 17   writer_task = NULL;
+ 13    if (writer_task != NULL) {
+ 14      VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
+ 15      kthread_stop(writer_task);
+ 16    }
+ 17    writer_task = NULL;
  18
- 19   if (reader_tasks != NULL) {
- 20     for (i = 0; i < nrealreaders; i++) {
- 21       if (reader_tasks[i] != NULL) {
- 22         VERBOSE_PRINTK_STRING(
- 23           "Stopping rcu_torture_reader task");
- 24         kthread_stop(reader_tasks[i]);
- 25       }
- 26       reader_tasks[i] = NULL;
- 27     }
- 28     kfree(reader_tasks);
- 29     reader_tasks = NULL;
- 30   }
- 31   rcu_torture_current = NULL;
+ 19    if (reader_tasks != NULL) {
+ 20      for (i = 0; i < nrealreaders; i++) {
+ 21        if (reader_tasks[i] != NULL) {
+ 22          VERBOSE_PRINTK_STRING(
+ 23            "Stopping rcu_torture_reader task");
+ 24          kthread_stop(reader_tasks[i]);
+ 25        }
+ 26        reader_tasks[i] = NULL;
+ 27      }
+ 28      kfree(reader_tasks);
+ 29      reader_tasks = NULL;
+ 30    }
+ 31    rcu_torture_current = NULL;
  32
- 33   if (fakewriter_tasks != NULL) {
- 34     for (i = 0; i < nfakewriters; i++) {
- 35       if (fakewriter_tasks[i] != NULL) {
- 36         VERBOSE_PRINTK_STRING(
- 37           "Stopping rcu_torture_fakewriter task");
- 38         kthread_stop(fakewriter_tasks[i]);
- 39       }
- 40       fakewriter_tasks[i] = NULL;
- 41     }
- 42     kfree(fakewriter_tasks);
- 43     fakewriter_tasks = NULL;
- 44   }
+ 33    if (fakewriter_tasks != NULL) {
+ 34      for (i = 0; i < nfakewriters; i++) {
+ 35        if (fakewriter_tasks[i] != NULL) {
+ 36          VERBOSE_PRINTK_STRING(
+ 37            "Stopping rcu_torture_fakewriter task");
+ 38          kthread_stop(fakewriter_tasks[i]);
+ 39        }
+ 40        fakewriter_tasks[i] = NULL;
+ 41      }
+ 42      kfree(fakewriter_tasks);
+ 43      fakewriter_tasks = NULL;
+ 44    }
  45
- 46   if (stats_task != NULL) {
- 47     VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
- 48     kthread_stop(stats_task);
- 49   }
- 50   stats_task = NULL;
+ 46    if (stats_task != NULL) {
+ 47      VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
+ 48      kthread_stop(stats_task);
+ 49    }
+ 50    stats_task = NULL;
  51
- 52   /* Wait for all RCU callbacks to fire. */
- 53   rcu_barrier();
+ 52    /* Wait for all RCU callbacks to fire. */
+ 53    rcu_barrier();
  54
- 55   rcu_torture_stats_print(); /* -After- the stats thread is stopped! */
+ 55    rcu_torture_stats_print(); /* -After- the stats thread is stopped! */
  56
- 57   if (cur_ops->cleanup != NULL)
- 58     cur_ops->cleanup();
- 59   if (atomic_read(&n_rcu_torture_error))
- 60     rcu_torture_print_module_parms("End of test: FAILURE");
- 61   else
- 62     rcu_torture_print_module_parms("End of test: SUCCESS");
- 63 }
+ 57    if (cur_ops->cleanup != NULL)
+ 58      cur_ops->cleanup();
+ 59    if (atomic_read(&n_rcu_torture_error))
+ 60      rcu_torture_print_module_parms("End of test: FAILURE");
+ 61    else
+ 62      rcu_torture_print_module_parms("End of test: SUCCESS");
+ 63  }
 
 Line 6 sets a global variable that prevents any RCU callbacks from
 re-posting themselves. This will not be necessary in most cases, since
@@ -193,16 +193,16 @@ which point, all earlier RCU callbacks are guaranteed to have completed.
 
 The original code for rcu_barrier() was roughly as follows::
 
- 1   void rcu_barrier(void)
- 2   {
- 3     BUG_ON(in_interrupt());
- 4     /* Take cpucontrol mutex to protect against CPU hotplug */
- 5     mutex_lock(&rcu_barrier_mutex);
- 6     init_completion(&rcu_barrier_completion);
- 7     atomic_set(&rcu_barrier_cpu_count, 1);
- 8     on_each_cpu(rcu_barrier_func, NULL, 0, 1);
- 9     if (atomic_dec_and_test(&rcu_barrier_cpu_count))
- 10       complete(&rcu_barrier_completion);
+  1  void rcu_barrier(void)
+  2  {
+  3    BUG_ON(in_interrupt());
+  4    /* Take cpucontrol mutex to protect against CPU hotplug */
+  5    mutex_lock(&rcu_barrier_mutex);
+  6    init_completion(&rcu_barrier_completion);
+  7    atomic_set(&rcu_barrier_cpu_count, 1);
+  8    on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+  9    if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+ 10      complete(&rcu_barrier_completion);
  11    wait_for_completion(&rcu_barrier_completion);
  12    mutex_unlock(&rcu_barrier_mutex);
  13  }
@@ -232,16 +232,16 @@ still gives the general idea.
 The rcu_barrier_func() runs on each CPU, where it invokes call_rcu()
 to post an RCU callback, as follows::
 
- 1  static void rcu_barrier_func(void *notused)
- 2  {
- 3    int cpu = smp_processor_id();
- 4    struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
- 5    struct rcu_head *head;
- 6
- 7    head = &rdp->barrier;
- 8    atomic_inc(&rcu_barrier_cpu_count);
- 9    call_rcu(head, rcu_barrier_callback);
- 10 }
+  1  static void rcu_barrier_func(void *notused)
+  2  {
+  3    int cpu = smp_processor_id();
+  4    struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+  5    struct rcu_head *head;
+  6
+  7    head = &rdp->barrier;
+  8    atomic_inc(&rcu_barrier_cpu_count);
+  9    call_rcu(head, rcu_barrier_callback);
+ 10  }
 
 Lines 3 and 4 locate RCU's internal per-CPU rcu_data structure,
 which contains the struct rcu_head that needed for the later call to
@@ -254,11 +254,11 @@ The rcu_barrier_callback() function simply atomically decrements the
 rcu_barrier_cpu_count variable and finalizes the completion when it
 reaches zero, as follows::
 
- 1 static void rcu_barrier_callback(struct rcu_head *notused)
- 2 {
- 3   if (atomic_dec_and_test(&rcu_barrier_cpu_count))
- 4     complete(&rcu_barrier_completion);
- 5 }
+  1  static void rcu_barrier_callback(struct rcu_head *notused)
+  2  {
+  3    if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+  4      complete(&rcu_barrier_completion);
+  5  }
 
 .. _rcubarrier_quiz_3:
 
-- 
2.31.1.189.g2e36527f23

