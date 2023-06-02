Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375AA720BA6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjFBWCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjFBWCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:02:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA121B5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:02:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2569298a074so2299476a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685743355; x=1688335355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwW/YRChR0hQq0w4cIg6VkzOmhI9SHkIawXb2E1L18U=;
        b=0oucoBOJ1hR4/HHB6rax89bQU17jgwXdfFUxvlCc7uziaB4LioNeMF+wyWs6yh5ixU
         7F5JYtJ8X7Xgxjhiqg9Al81UV0OJ3ME4JmbVnCtlwzHxrMgkuUppucCf/CbzlQ3f+TNd
         pU/4AlnrzGvymIjBvoNdQ9ODrhUmHsgYqn5U7vwpNYx6MTyQm92VdWqM/MfLPj3ZCDka
         ncoiA7B6bz3OCWUWemqRsS6zRD3nzJqOmIn0An99az0igtJWnfd0QMV6QKjKWUtKfS70
         BbmjFAEFIwQAfxH7SaeDFIEWqH8NiJGC1s94Zso0E8DMiH5mQIEiEw+8JQJ50kbR6CcS
         1Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685743355; x=1688335355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwW/YRChR0hQq0w4cIg6VkzOmhI9SHkIawXb2E1L18U=;
        b=Q/0NAVwCmxVGxt6f6osikV2yqu0267a6YGkzbP5ZCzYVrur1LdS84eZo0KnecSGsxU
         2lYbiGbB2J/40HVvw+ryP61xfBGiHLnqIZXAppUUg+JoD38o/qTfEfWMV3G3iESPBhfP
         Judhud5cH+ovLI6uldirIAdyQXgF9IdRaCLWR9R5hPztO546F88mrp+2XOsthGPIIuyn
         4QhXq5rHbhXngkoWJHDhhfkIwJ3y+1a333SUq6dPoZM0pIqks2U7xCzD9aicoIxVXsj5
         x1iES0eIzQGXt2Y5PKvlR1dHuR8aPQKq2F5o2ksv+FqPLjMofhVWJvVFsY2Wmszk9U4J
         JNuA==
X-Gm-Message-State: AC+VfDxnwLCKFoGe0ureP2u/wZL5jhLGArT/w7WhEm2JKjdJzFQJBb5T
        8hSWR+WU0p/JRnp6rC5jKMyxPjyoAFvy6byS+xacNNeAvvzVhfFntatrjwl1NzdPpH25LxiPLPw
        HTgHEausxX1Npf/PNO+zyUUwn/Qjbl+gwg5i1BUUrZjJGuiu2Nc+XxJZqhpICT7iC+QPB550=
X-Google-Smtp-Source: ACHHUZ7B0lBnDsteBcNteqyDnWFfPMnmMeHfPLHZKlCOyV1iEOmz5QUsXV+LnUzG6xSjZPLKUd6iFRRIk3IK
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:d38e:b0:256:b9d1:4e34 with SMTP id
 q14-20020a17090ad38e00b00256b9d14e34mr255120pju.5.1685743354752; Fri, 02 Jun
 2023 15:02:34 -0700 (PDT)
Date:   Fri,  2 Jun 2023 22:02:10 +0000
In-Reply-To: <20230602220221.600774-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230602220221.600774-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602220221.600774-2-jstultz@google.com>
Subject: [PATCH 2/2] torture: Add lock_torture_writer_fifo module param
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Modifies locktorture writer to run as RT task.

To use it:
insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^
insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3

This patch has been helpful to uncover issues with the proxy-execution
seires.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
[jstultz: Include header change to build, reword commit message]
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/locktorture.c |  3 ++-
 kernel/torture.c             | 11 ++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 153ddc4c47ef..7cb044fc99b2 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -816,7 +816,8 @@ static int lock_torture_writer(void *arg)
 	bool skip_main_lock;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
-	set_user_nice(current, MAX_NICE);
+	if (!rt_task(current))
+		set_user_nice(current, MAX_NICE);
 
 	do {
 		if ((torture_random(&rand) & 0xfffff) == 0)
diff --git a/kernel/torture.c b/kernel/torture.c
index 8be83fdc6be1..db79197e257a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -37,6 +37,7 @@
 #include <linux/ktime.h>
 #include <asm/byteorder.h>
 #include <linux/torture.h>
+#include <linux/sched/rt.h>
 #include "rcu/rcu.h"
 
 MODULE_LICENSE("GPL");
@@ -57,6 +58,9 @@ module_param(verbose_sleep_duration, int, 0444);
 static int random_shuffle;
 module_param(random_shuffle, int, 0444);
 
+static int lock_torture_writer_fifo;
+module_param(lock_torture_writer_fifo, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -734,7 +738,7 @@ bool stutter_wait(const char *title)
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		if (!ret) {
+		if (!ret && !rt_task(current)) {
 			sched_set_normal(current, MAX_NICE);
 			ret = true;
 		}
@@ -944,6 +948,11 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
 		*tp = NULL;
 		return ret;
 	}
+
+	if (lock_torture_writer_fifo &&
+	    !strncmp(s, "lock_torture_writer", strlen(s)))
+		sched_set_fifo(*tp);
+
 	wake_up_process(*tp);  // Process is sleeping, so ordering provided.
 	torture_shuffle_task_register(*tp);
 	return ret;
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

