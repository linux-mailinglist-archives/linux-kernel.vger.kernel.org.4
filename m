Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C193568C83C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBFVGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBFVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:06:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBB46E83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:06:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a9-20020a25af09000000b0083fa6f15c2fso12717550ybh.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCwxWvSr3s2unKl3mPkOoa10/6N4Osd9n10mDC6raKw=;
        b=qdIm713de6oE+5cCGu2bZQAIQcuVSxv1n1cc1tNVznp2fnmL+UPKHj836nDy9xAPNv
         sZAmnDutiEO9qq9QttDEevr2jQqeHBbPQCAIZ759ZiU+tbEVl6z8r6Wmu7vJoAJ2Pj+y
         M5NbNMqMmkU/6u8O3QkyhkN5QoS+oT4cc431rtkZ8Gf5wBwT3urB/OoFVipgCX8Lqq+c
         aCF1trWYV90q2qd+MULryufESqkCldjoEjkFFW5AppZIA64NfeeK7yJVOe7Rr+vuCAT1
         kWidct0eOnKnzVWu8k9hQ9gQNarHrfqoGBlOUktTiYFAxIjmXTfrABlGehmp+BQTyXeI
         ndyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCwxWvSr3s2unKl3mPkOoa10/6N4Osd9n10mDC6raKw=;
        b=olxFngcpYafshjAWHkFYRrJAtJwqrFQOPo91I9WlLpb8CqGCx33xBzXO3gI111M9Hu
         aBdHTUX29PxHWWRxHFeBhzHKmQRKmoNjE6wUTgJ0ZAtgqEabvUDxVbmmqF1xW7/AS6ei
         a2WwqhHmoyv2DaYmDN5BHx3CeiKtC3AvYrN+Hegem+e72q5/gMHBKIj6h8AVZtb7S+4I
         59DNEXsWFNd3/mfKx/w/vC181MVEwfhb80mPsZO02IMRBDTiHWy3V/xEH/O4NR6S0RnD
         Cj5MRXP3XXA9f3kBn+LR0GKbYOHtodX89aNGUnot2qub4UxmZrjS30MLmHLFg4LVKkUw
         2lUw==
X-Gm-Message-State: AO0yUKXefkyVrUuQM/NzaiR0fG/I3GImKYGhEJYRqSYE6e5IJy+85XSr
        npyDznPorgcgbFUmCFJ0tG28rWOChrtMBDM2GbQZnXj5ovKqvETCvLVBDaKr5aceIUNeWxPIujU
        BfBUJYyl1pw23gnr+FxzRwfqahYQWOBAzIzzINNq3ZuYsSVQ9dlSBFuL6t1iu55cUYozo0t0=
X-Google-Smtp-Source: AK7set87++UuO/2pR9DYyGlfUsZYtZlsnJBp/Mu4EY1r6ro7CVuD1lJGbV7xzFn/xHFRTpFFcCMG3tQYt7S+
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:5203:0:b0:527:acad:5564 with SMTP id
 g3-20020a815203000000b00527acad5564mr72638ywb.35.1675717570016; Mon, 06 Feb
 2023 13:06:10 -0800 (PST)
Date:   Mon,  6 Feb 2023 21:05:55 +0000
In-Reply-To: <20230206210556.660318-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230206210556.660318-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206210556.660318-3-jstultz@google.com>
Subject: [PATCH v3 3/4] locktorture: Add nested locking to rtmutex torture tests
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds randomized nested locking to the rtmutex torture
tests. Additionally it adds LOCK09 config files for testing
rtmutexes with nested locking.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Add LOCK09 config file suggested by Paul McKenney
v3:
* Minor commit message tweaks and naming changes
  suggested by Davidlohr Bueso
---
 kernel/locking/locktorture.c                  | 35 +++++++++++++++++++
 .../selftests/rcutorture/configs/lock/CFLIST  |  1 +
 .../selftests/rcutorture/configs/lock/LOCK09  |  6 ++++
 .../rcutorture/configs/lock/LOCK09.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 8a08c004aa80..fd8b2b007c26 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -506,6 +506,28 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
+static struct rt_mutex torture_nested_rtmutexes[MAX_NESTED_LOCKS];
+static struct lock_class_key nested_rtmutex_keys[MAX_NESTED_LOCKS];
+
+static void torture_rtmutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_NESTED_LOCKS; i++)
+		__rt_mutex_init(&torture_nested_rtmutexes[i], __func__,
+				&nested_rtmutex_keys[i]);
+}
+
+static int torture_rtmutex_nested_lock(int tid __maybe_unused,
+				       u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nested_locks; i++)
+		if (lockset & (1 << i))
+			rt_mutex_lock(&torture_nested_rtmutexes[i]);
+	return 0;
+}
 
 static int torture_rtmutex_lock(int tid __maybe_unused)
 __acquires(torture_rtmutex)
@@ -570,11 +592,24 @@ __releases(torture_rtmutex)
 	rt_mutex_unlock(&torture_rtmutex);
 }
 
+static void torture_rtmutex_nested_unlock(int tid __maybe_unused,
+					  u32 lockset)
+{
+	int i;
+
+	for (i = nested_locks - 1; i >= 0; i--)
+		if (lockset & (1 << i))
+			rt_mutex_unlock(&torture_nested_rtmutexes[i]);
+}
+
 static struct lock_torture_ops rtmutex_lock_ops = {
+	.init		= torture_rtmutex_init,
+	.nested_lock	= torture_rtmutex_nested_lock,
 	.writelock	= torture_rtmutex_lock,
 	.write_delay	= torture_rtmutex_delay,
 	.task_boost     = torture_rtmutex_boost,
 	.writeunlock	= torture_rtmutex_unlock,
+	.nested_unlock	= torture_rtmutex_nested_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
 	.readunlock     = NULL,
diff --git a/tools/testing/selftests/rcutorture/configs/lock/CFLIST b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
index a48bba0d35a6..28e23d05d5a5 100644
--- a/tools/testing/selftests/rcutorture/configs/lock/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
@@ -6,3 +6,4 @@ LOCK05
 LOCK06
 LOCK07
 LOCK08
+LOCK09
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK09 b/tools/testing/selftests/rcutorture/configs/lock/LOCK09
new file mode 100644
index 000000000000..1d1da1477fc3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK09
@@ -0,0 +1,6 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot b/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot
new file mode 100644
index 000000000000..fd5eff148a93
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot
@@ -0,0 +1 @@
+locktorture.torture_type=rtmutex_lock locktorture.nested_locks=8
-- 
2.39.1.519.gcb327c4b5f-goog

