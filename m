Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603E268A357
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBCUBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjBCUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:01:44 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C8A6C07
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:01:43 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h4-20020a17090aa88400b0022c8dfc9db4so2878946pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 12:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SS9njUMJOmQ8htY8Ip0UFz+DAaIXbVEtUJNiEBJ9FB0=;
        b=Nl/hIjpeflwlcE1OUDo5VXhIMnYa6u/CpDe5qKpM2CVsBi1quwv/ehJSNvcbnG0kZ8
         B0LJ6KVotUDFFkJ0iryEulNtLCCWy6vUkcLdoQvEGnpxiTKlUVg0ff+hJ532Jh3oP/nE
         uietnXlvtWom6jlLHduXukJP29lJVtWo0hNiyRUkiHGFPZmuT8kCCzKe92nY85BorkkO
         qO98V4oIUk9XE5lWAsSDFOtmC9iUCyHh9sS8PFHN0hbnkQ3CkUulSo31y1SjjxKt5RIa
         5ZNnpO4WfEYvd+VtdSke2CGVycW8xjxcUNJo2ERuY9/QnColbgCCioOb3kK1yAkssmuQ
         d4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS9njUMJOmQ8htY8Ip0UFz+DAaIXbVEtUJNiEBJ9FB0=;
        b=RleH55MikkbBOIfLGHgooa1w+0JV+/p9Cx+5Ef4xi0G5GLO7XW/6mWCfWYa/jvwofL
         X4wuh36By5cyKxbWm9HA4VoH4J2gzLoFAiA2m20IGyYeqpA+RWekNf8xvCLS92ProAkZ
         d4xe3u0IjYpQoadOGIyus1yr1ce+yJGMyeUMdCSneBVs+cPW2ZPn2aidAbO8M96DECQE
         uZf4ubzDp9kyCv3VVVJC8Zq57Q4KqIIKWL47H+IkPAf/H0MxQNFoeJTlR+kCvTgG/DlP
         z1pT9uvouBD1LEph3SXmJiOE0lBPizPkxl+V9/+mSAWCX22QTsljQWuiWfQconwzVmE6
         mLwQ==
X-Gm-Message-State: AO0yUKUdsfJTbWOQaUBa5mZK/j1rOtjuJvJUK3288Tc1LdKKTLt7m1L7
        8uTqYWCf241Hc0Zrrae6vv+NgfP1LVoOpivWvILoyaRttNVU7uKcuuR9WKbw0eGprpeNez2q5/b
        aVUv0WSxo6dpXbNw5VywHKVWfrdbxfoqgpf35VJRX6Aj8hDdGa7dUIPdRdIZmI0/GZgSA82I=
X-Google-Smtp-Source: AK7set+c8Tqz3SGJ/9TXFGCKH1pXn5gttje78PZTQalYsvuJqFQoKKFvRQxZqsCrwTC/R59KpJTHP6gr94Rj
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:4208:b0:58e:2111:9c42 with SMTP
 id cd8-20020a056a00420800b0058e21119c42mr2692517pfb.22.1675454503197; Fri, 03
 Feb 2023 12:01:43 -0800 (PST)
Date:   Fri,  3 Feb 2023 20:01:36 +0000
In-Reply-To: <20230203200138.3872873-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230203200138.3872873-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230203200138.3872873-2-jstultz@google.com>
Subject: [PATCH v2 2/4] locktorture: Add nested locking to mutex torture tests
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

This was inspired by locktorture extensions originally implemented
by Connor O'Brien, for stress testing the proxy-execution series:
  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/

Comments or feedback would be greatly appreciated!

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Add LOCK08 config file suggested by Paul McKenney
---
 kernel/locking/locktorture.c                  | 35 +++++++++++++++++++
 .../selftests/rcutorture/configs/lock/CFLIST  |  1 +
 .../selftests/rcutorture/configs/lock/LOCK08  |  6 ++++
 .../rcutorture/configs/lock/LOCK08.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index f4fbd3194654..27d92ce36836 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -332,6 +332,28 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 };
 
 static DEFINE_MUTEX(torture_mutex);
+static struct mutex torture_nested_mutexes[MAX_LOCKS];
+static struct lock_class_key nested_mutex_keys[MAX_LOCKS];
+
+static void torture_mutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_LOCKS; i++)
+		__mutex_init(&torture_nested_mutexes[i], __func__,
+			     &nested_mutex_keys[i]);
+}
+
+static int torture_mutex_nested_lock(int tid __maybe_unused,
+				     u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nlocks; i++)
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
+	for (i = nlocks - 1; i >= 0; i--)
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
index 000000000000..e59a369b470e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot
@@ -0,0 +1 @@
+locktorture.torture_type=mutex_lock locktorture.nlocks=8
-- 
2.39.1.519.gcb327c4b5f-goog

