Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37870440D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjEPDmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEPDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:42:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7A755A4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:42:22 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5340957c397so1202533a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684208541; x=1686800541;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfakjCCfwFt+mIB9AT5nkofxGKZ/CvaVo69e1r5gk1A=;
        b=EhBoZybb/5zbx0jCyhuVRYEzB7CdoPFz543LQUtWqQM4QQ9lH/RWwABYlF/w/TQE+s
         MFWKqc8gbVDGpEgNZFNL53EaqKEk/FCXjQlVgQhPFj9GmcGt0pPW2gbem3ExJPbstLQI
         yRh8OS60LDRcMiNPhHJr0v6VnHy4JHCu4v45DeBlPT3fFTCEE3YaI09rfNi7mxuGF4EY
         mwMSWA0z5Fm8VgAX7MIyiOX1xcvYfBJcPNwTqHEGj1yZUzwjsQNtSQodV6g2bY7Un1h/
         KA6Ihza/OO8L4T+UWSiXz52SMp6Y/cKWBpU8JQKOmoarsnm0mWcX0Lz9o6+djmDisua6
         HeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208541; x=1686800541;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfakjCCfwFt+mIB9AT5nkofxGKZ/CvaVo69e1r5gk1A=;
        b=BGWXJ7ayDJyf6tDLfeYPDPz3lqS1BJlnZL31se7YgSv11hcF6gmL+FqafYT5nFRBaW
         ekvqEfWKjAHFHCuMrej31dsKhyft+JJprqDM5LfWFeyVBKXgKfZ/gLEoHap6vO6iJ2Ez
         Ks1V5vHhMQL/tMG4Ou8et8mZF4BpV0bNkykTT5vety6p7ecZReqXwg8IvWYM1JprcxqX
         Ej6Nh/RPQVs/YFtLZdrKt4SZ6a+PVvzukcEc90jnbdLe7LCLVSx2HA8NrBRdVUdlMgY3
         1H0+CBuB11F+4fLBSG3ai0f1N0Ls/b6uh9yk/d9VQp1g1/OUhQ+T9CuwSXA9V7n6jg8v
         XvRw==
X-Gm-Message-State: AC+VfDzWUOrVu3ELvdrZ0iiGgHLp6fqmF4gp8pe3OP7N0oDs73wtlAml
        ujpyRgetRdeNqCfMGpdo7XX9oA5byvUCRrbsG3MHj/tXpxI1m/ga0zZ/5Q+1HAkQGZodxDGPTMc
        hlkAjhvl8tRsvfZM13UfsHHd2mOGo8hjUuQeHIAzQKWjMi+fmQrKyYwDom9ZANn8NtmTydBE=
X-Google-Smtp-Source: ACHHUZ4sqKNlx2tjDfNXgCMyzJzsAbqTNhgzIsDUZkSJ4N44sAU8G6n9vZXNnCtVtQA1z5AuAm/bFtuVfZkv
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:8ac1:0:b0:52c:8878:65dc with SMTP id
 y184-20020a638ac1000000b0052c887865dcmr10381889pgd.1.1684208541169; Mon, 15
 May 2023 20:42:21 -0700 (PDT)
Date:   Tue, 16 May 2023 03:41:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516034207.3847143-1-jstultz@google.com>
Subject: [PATCH v2] sched/wait: Fix a kthread_park race with wait_woken()
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        android-kernel-team <android-kernel-team@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>

kthread_park and wait_woken have a similar race that
kthread_stop and wait_woken used to have before it was fixed in
commit cb6538e740d7 ("sched/wait: Fix a kthread race with
wait_woken()"). Extend that fix to also cover kthread_park.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: android-kernel-team <android-kernel-team@google.com>
Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
[jstultz: Made changes suggested by Peter to optimize
 memory loads]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Commit message tweaks, suggested by Peter
* Move logic to kthread.c & optimize to avoid duplicate memory
  loads, also suggested by Peter
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 10 ++++++++++
 kernel/sched/wait.c     |  7 +------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30e5bec81d2b..f1f95a71a4bc 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -89,6 +89,7 @@ int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
 bool __kthread_should_park(struct task_struct *k);
+bool kthread_should_stop_or_park(void);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_func(struct task_struct *k);
 void *kthread_data(struct task_struct *k);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 490792b1066e..07a057086d26 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -182,6 +182,16 @@ bool kthread_should_park(void)
 }
 EXPORT_SYMBOL_GPL(kthread_should_park);
=20
+bool kthread_should_stop_or_park(void)
+{
+	struct kthread *kthread =3D __to_kthread(current);
+
+	if (!kthread)
+		return false;
+
+	return kthread->flags & (BIT(KTHREAD_SHOULD_STOP) | BIT(KTHREAD_SHOULD_PA=
RK));
+}
+
 /**
  * kthread_freezable_should_stop - should this freezable kthread return no=
w?
  * @was_frozen: optional out parameter, indicates whether %current was fro=
zen
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 133b74730738..48c53e4739ea 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -425,11 +425,6 @@ int autoremove_wake_function(struct wait_queue_entry *=
wq_entry, unsigned mode, i
 }
 EXPORT_SYMBOL(autoremove_wake_function);
=20
-static inline bool is_kthread_should_stop(void)
-{
-	return (current->flags & PF_KTHREAD) && kthread_should_stop();
-}
-
 /*
  * DEFINE_WAIT_FUNC(wait, woken_wake_func);
  *
@@ -459,7 +454,7 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsi=
gned mode, long timeout)
 	 * or woken_wake_function() sees our store to current->state.
 	 */
 	set_current_state(mode); /* A */
-	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
+	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !kthread_should_stop_or_park())
 		timeout =3D schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
=20
--=20
2.40.1.606.ga4b1b128d6-goog

