Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70468C83B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBFVGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:06:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57846EA6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:06:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h1-20020a17090a470100b0022646263abfso5177079pjg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjg1wQcr6HPBZFA4eCrjoL4w1V6/fgx7gki8zaICVCo=;
        b=JksLUcD+s/K5QbXrCBKe9Fq7MMs3hW/WK8+8zMYpjOJ0oezih8H66ZI0/EORvVlZGN
         HlqO2tKE0qGs6Y8l3l0Kg9P9tzx+iz8fupo4QWOHmQ1+xIfF8BkWJYZZRi3571XKOXLB
         WYv8zeAvmS+wjUpyrDN8+9btjNsl6fGOxIw7lmYnz8H6PUl9citH2pv0kteAeJULCLrb
         diK0TIULo6HqBusnp62jgTT7bUB/6g8jOj2NPULBCfSM0v7fFEGgLfORGsOAzQ0KbSv4
         xuwhstWN6wA7KpAzwFrS20dCX4S589S9jLc5OMMJ+4LwYXVjmHCcSw9IjPk7Ink+hATM
         QALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjg1wQcr6HPBZFA4eCrjoL4w1V6/fgx7gki8zaICVCo=;
        b=XgGpxLkD3c4tErw9Y2Lc62jcp9hv1GlOUTF61Xo8kPSkthBZHgCzf8f1t8NA3ErCWc
         Oa1fTcxstVII3ozXRLaY9fK5yWpYVnsL6YYlmKWwC1epawy9h5ofKw4/XZLKN81C7A68
         qp7Cvg/N5/2vG70Pa4kiB7GMeI3AcKCbKEx+DIMAvCI/qhxjVHiTw8lZms11DnNkZnlr
         AGcSDfD6qKYn8sXuigX+b99jDHPrMzO4QNS/aaj+ZWTHw7tXDHsj03EXgkUG2MsXf/qO
         cDWTqe+EniRmEkqhTGQNTE6wNaMoThoI3QBnQ2vJk06XlLSvm6IKBrpG+lHIi8Hb4h5y
         x1Qg==
X-Gm-Message-State: AO0yUKVmwZxUmSfJ2G5qToNNEYE+0WTW2R/7uzKCIRote5IQWBdG98jG
        pFSRJ8ro28tVg+ENxf0SuDwrnVpZLYbRISbpLtJPqnVmXBc5j6RPcBFqBVIsWMOwWk/BJ2lSAdt
        JbfNevfp6mIqJ19c8Ev2HpmQXODNhScdYaWLFRnuCHoxAhdszSz8iXofoOSJzfhi9bBPZT5k=
X-Google-Smtp-Source: AK7set8aCvHxlGuQ1IjC6Jx6z5o8q1nWKNZUsVoEMLNUp8BtkWI7mOIXo2Xg+MYrE+qsK3yqA1rIkVhI00Bb
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:124a:b0:198:debf:d122 with SMTP id
 u10-20020a170903124a00b00198debfd122mr66079plh.16.1675717568179; Mon, 06 Feb
 2023 13:06:08 -0800 (PST)
Date:   Mon,  6 Feb 2023 21:05:54 +0000
In-Reply-To: <20230206210556.660318-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230206210556.660318-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206210556.660318-2-jstultz@google.com>
Subject: [PATCH v3 2/4] locktorture: Add nested locking to mutex torture tests
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

This patch adds randomized nested locking to the mutex torture
tests, as well as new LOCK08 config files for testing mutexes
with nested locking

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
* Add LOCK08 config file suggested by Paul McKenney
v3:
* Minor commit message tweaks and naming changes
  suggested by Davidlohr Bueso
---
 kernel/locking/locktorture.c                  | 35 +++++++++++++++++++
 .../selftests/rcutorture/configs/lock/CFLIST  |  1 +
 .../selftests/rcutorture/configs/lock/LOCK08  |  6 ++++
 .../rcutorture/configs/lock/LOCK08.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 6fe046594868..8a08c004aa80 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -332,6 +332,28 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 };
 
 static DEFINE_MUTEX(torture_mutex);
+static struct mutex torture_nested_mutexes[MAX_NESTED_LOCKS];
+static struct lock_class_key nested_mutex_keys[MAX_NESTED_LOCKS];
+
+static void torture_mutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_NESTED_LOCKS; i++)
+		__mutex_init(&torture_nested_mutexes[i], __func__,
+			     &nested_mutex_keys[i]);
+}
+
+static int torture_mutex_nested_lock(int tid __maybe_unused,
+				     u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nested_locks; i++)
+		if (lockset & (1 << i))
+			mutex_lock(&torture_nested_mutexes[i]);
+	return 0;
+}
 
 static int torture_mutex_lock(int tid __maybe_unused)
 __acquires(torture_mutex)
@@ -360,11 +382,24 @@ __releases(torture_mutex)
 	mutex_unlock(&torture_mutex);
 }
 
+static void torture_mutex_nested_unlock(int tid __maybe_unused,
+					u32 lockset)
+{
+	int i;
+
+	for (i = nested_locks - 1; i >= 0; i--)
+		if (lockset & (1 << i))
+			mutex_unlock(&torture_nested_mutexes[i]);
+}
+
 static struct lock_torture_ops mutex_lock_ops = {
+	.init		= torture_mutex_init,
+	.nested_lock	= torture_mutex_nested_lock,
 	.writelock	= torture_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_boost_dummy,
 	.writeunlock	= torture_mutex_unlock,
+	.nested_unlock	= torture_mutex_nested_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
 	.readunlock     = NULL,
diff --git a/tools/testing/selftests/rcutorture/configs/lock/CFLIST b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
index 41bae5824339..a48bba0d35a6 100644
--- a/tools/testing/selftests/rcutorture/configs/lock/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
@@ -5,3 +5,4 @@ LOCK04
 LOCK05
 LOCK06
 LOCK07
+LOCK08
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK08 b/tools/testing/selftests/rcutorture/configs/lock/LOCK08
new file mode 100644
index 000000000000..1d1da1477fc3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK08
@@ -0,0 +1,6 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot b/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot
new file mode 100644
index 000000000000..b8b6caebb89e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot
@@ -0,0 +1 @@
+locktorture.torture_type=mutex_lock locktorture.nested_locks=8
-- 
2.39.1.519.gcb327c4b5f-goog

