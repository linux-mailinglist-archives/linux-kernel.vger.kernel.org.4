Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6163567E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiKWJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiKWJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:30:44 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD4112C40;
        Wed, 23 Nov 2022 01:29:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 9so72503pfx.11;
        Wed, 23 Nov 2022 01:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6QNzC9ocFbEzOB+8PUforSOIJ9U2Z9Tj4lmWNCBNrQ=;
        b=HsPZQ6MeK2HGmFt1PkmV433jHTU3aRoWz+5zpoNsHNJYfMFsP+aQHWjRdg+3u/1K98
         ulQzbK5GpR+1HiDlVs0FLsSs0t3DGRyesyoEAdWOHookfZ0CqSqPKRhYzIOzT9QrEEJH
         9ug60lEEvOLhZ97v2F8TzPaflJetangVDohD5TYef3Z6QVRF7EHj8QlZpEfCc4oPFTxN
         WLooMweToI/4CDTbByrgMRy1iy2ql6qoNe5yAyedPY3vfOBraghA3xK4jXqHqOWIgEh3
         /HaG80OEoFC6UWnjjXee7+51Oq8NcYHXjr4HmaR8rFh+EQxoom9t+3Js+Z2bgj8uxcsQ
         624w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6QNzC9ocFbEzOB+8PUforSOIJ9U2Z9Tj4lmWNCBNrQ=;
        b=QbK7+KniqkrIfmDNFlmOi6XFF4mqKTdeMlm1WX/2Uhlf8wHL+Bxx67kihyysu/N/j1
         PfOht78Q53jRw0t7r5tsuVwD9pln9EGa4SGBxL3qqPGbotJh/3J+KNuDn0q89Ua+VfiQ
         AW/1hMBehVwfKaf+zzTdnWd7YMsJm9hiK5vtO8Ds54QgLtfMeI6it7wwB2j6d7U4Mt8N
         tNZfckGOCwEwWm9VOzOAJfRTaXydcdQypcuEekwzpcfXzUSyestYMDnW3OGFI+Q/H3RD
         kwMX+dIK3uhygcvDCaCSb/IGNx2QtvgO3P5k2zwAQCJDpYseixy1fvvmow6sfJ61caxm
         fPwg==
X-Gm-Message-State: ANoB5pmeB5kadcg1xtlQ6Z5On05BFBIBINvdDSIh3Eb6t6XCXDD0vuk7
        p1UCu5Xu8+br4XG7Q6IKLqH+oVo9XPU=
X-Google-Smtp-Source: AA0mqf7VMggc0XycomC3EhXcNKF+oNFN0Jg9O68Tig95wp2kPtkH7Ak4yfGvygRUtI0RTmn8q6wmAg==
X-Received: by 2002:a63:3d8:0:b0:476:eee6:d394 with SMTP id 207-20020a6303d8000000b00476eee6d394mr15101648pgd.228.1669195744501;
        Wed, 23 Nov 2022 01:29:04 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902784e00b0018661d627d7sm13620444pln.59.2022.11.23.01.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:29:04 -0800 (PST)
Message-ID: <e458e625-9a4e-da3f-13cd-a5b56fc36edf@gmail.com>
Date:   Wed, 23 Nov 2022 18:29:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: [PATCH 2/2] docs/RCU/rcubarrier: Right-adjust line numbers in code
 snippets
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <b74e2e19-0317-e717-cc15-a7854b04adf4@gmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b74e2e19-0317-e717-cc15-a7854b04adf4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Documentation/RCU/rcubarrier.rst | 168 +++++++++++++++----------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 9fb9ed777355..6da7f66da2a8 100644
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
2.25.1


