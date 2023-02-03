Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE17268A358
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjBCUBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjBCUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:01:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB682A77A4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:01:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b18-20020a253412000000b0085747dc8317so5758333yba.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8PT34t2qDr/GJI8LrC6wOUFBvKY3Hp95WNgfanV6IM=;
        b=r8ITG/RTClzhaLsg3hhm7dmQgWr73lKexW4jM1UsgvmEn8c2l5RzJjOfHXv6tjakn2
         TyaOggZEXSK5y7OvuQlIfPtBI+Y/NnMNQApJjOrnauNZb0hFNwwALksnw09C6QQMV8l3
         3TKDWrCj/La7Fx4mDg6hWF7PWv5c/AfQSA0OX8mFxYyektarfysYI7irdbHZuQHRC613
         qPl3NH5KhmGgXihVgYaVgYri5OtxbH35IgCeiLAlCH5P9Y3M95C+B1AbO9yHFQd6cPZ5
         m6VpdxWu0kOuyOHdnwbxIbXRi06tuASqKc+4/hpDP/Nrra5ZLHvvgK/Uq8Hgq//jjJs1
         TF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8PT34t2qDr/GJI8LrC6wOUFBvKY3Hp95WNgfanV6IM=;
        b=OAbfqkGHe8h9aKuR2g7Ik/86M2k+hJV1hNUJdW8saZgOrYLULoi06MyaZSewEKQQxe
         //JclT01iyf9EJmr3lE3gDf4HzYHKZ0e7ADmOyqZex8pVVWSxN7V+xkNH1emfKPFC1zj
         HmfgC1+r7hHKt8pEa62EceTQBbowaw0UiSMvXiaUIsGhqIzszc3+49pWqSHEeID2KFoF
         e9nl+lICz5iusZRm9GPKF+XR49ngEkNJFtnt7wd//Jt3sEPHOCAU8Zzuvwm4GzxcJ9+5
         P57nSZShscPUz3HJmvrOt5afgTnJqiOnyEgVSP+QkGP4iK2sYP64gce+IxhukJJJxx9Q
         oRbQ==
X-Gm-Message-State: AO0yUKUevaIbwF4F7UJ5XE29CYQ+y49wkqQ/3HvQM62ydoTamsyodgzv
        eXgKbL9Ef/pEEjMd6RFKhvI5HuR7jTkIykMb9DGvZllxsOl/YXzDb8OyZXzxu9881NTQkYGJ9AA
        0I1aU1lM1jPItkMmFE81oesUHUgjJdXnUl4uVGgixAZxuuvGIAPAj02+tiHWNI0Pny981p0Y=
X-Google-Smtp-Source: AK7set9lcZWZzhecNZbvFCaymtAJF43VMXi+9W+6p+PcgBk3N/hvfw1e9N6zIBEI1wOK1tpoA1gmV1AKHXDl
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:4955:0:b0:4fe:a39e:395b with SMTP id
 w82-20020a814955000000b004fea39e395bmr1365791ywa.408.1675454504895; Fri, 03
 Feb 2023 12:01:44 -0800 (PST)
Date:   Fri,  3 Feb 2023 20:01:37 +0000
In-Reply-To: <20230203200138.3872873-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230203200138.3872873-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230203200138.3872873-3-jstultz@google.com>
Subject: [PATCH v2 3/4] locktorture: Add nested locking to rtmutex torture tests
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
 .../selftests/rcutorture/configs/lock/LOCK09  |  6 ++++
 .../rcutorture/configs/lock/LOCK09.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 27d92ce36836..5fb17a5057b5 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -506,6 +506,28 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
+static struct rt_mutex torture_nested_rtmutexes[MAX_LOCKS];
+static struct lock_class_key nested_rtmutex_keys[MAX_LOCKS];
+
+static void torture_rtmutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_LOCKS; i++)
+		__rt_mutex_init(&torture_nested_rtmutexes[i], __func__,
+				&nested_rtmutex_keys[i]);
+}
+
+static int torture_rtmutex_nested_lock(int tid __maybe_unused,
+				       u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nlocks; i++)
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
+	for (i = nlocks - 1; i >= 0; i--)
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
index 000000000000..6c413e3e1bdf
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot
@@ -0,0 +1 @@
+locktorture.torture_type=rtmutex_lock locktorture.nlocks=8
-- 
2.39.1.519.gcb327c4b5f-goog

