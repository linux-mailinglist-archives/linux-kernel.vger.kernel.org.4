Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D81720AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjFBVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjFBVXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:23:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA9E45
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 14:23:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-258aad18260so1593135a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685741034; x=1688333034;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/1Q2qDDMWaACRPVl1R6+9lO9W70yn5VWzLSuHliJyk=;
        b=VlmUMMHEiDO1nG8h/zvGub43Mqcm0B736wIlUkxKK+ArEJ+wnz+hVFtjbLq5aUi8K4
         uWJt9fFM3KhseewsCZLxak+1pSd3Zd4m8IMQVAyDe0MYYUnbNljGzM2TRUgZTO/opB4N
         YD9RmUNQYR2wiEVEtivLuqBA6FTfKAW78ABjcDMZqpAbk0aCv3+5aanFo+1rdH2v9Viz
         qI/wbb8Dq2yyhLFpUlr1WIdQOKaiUMTCSn0YuVMYqnF2nbNbOGr3jOTjRnISBI9qfIjq
         Xn3fDGaL/p3XEz/tWZDjiuVRkWqyZQRj3dMgXBjlf9oz2sMl648euk4P9ZhxcIQmLTDU
         eEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741034; x=1688333034;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/1Q2qDDMWaACRPVl1R6+9lO9W70yn5VWzLSuHliJyk=;
        b=MTX9PLQdFLaQRDfD6Ike3i9Ror/0mJZGVhLPCz8v+ZRduKZQvbQWJKRCqppdnszFNv
         moxuk+Sb6ng4717eJumPYFZvZYrt0V4WaHsbHRmF1YcxtCS31RxgZFZEP0ANj+Rk7PG9
         hxjpCS4v52mQboo1SCiKPa4zvMsSRTGoRZyFXFBe8GQILmyY11vwz9pueStY8d230KFz
         hiQVYIeQhIU5b+GQjYkvNOe9rzk0ukemFY6jumNTxSkR+nzVSwAFZtdSJe8nMCbhTjDr
         qPeoqni1071egSX8owrAh8qmHQjZwLCL0wieMe+5k5982D2C+rZV9e8Jn7OYXYaIlGP0
         ZzaQ==
X-Gm-Message-State: AC+VfDzF1PlswkbxHlFnB+qc92poWMJvyMZVqm4N3lS72x1b8qv2DJsJ
        0N3imb5d4H2GpqK3YE50jdzoMzH1x/DlMel/w3YPZdAOPCJyNOyI097ODlHn/O6VtAmonM0Zvb8
        Znlqm+qS4obaggYm5ggbT9adhkgTYnL+DSZ5NHdMwCsuXq0T5i5Ejw2p/622mljNiEOItkG8=
X-Google-Smtp-Source: ACHHUZ6jlZmg2Xp87QWHxeVKRtRSMqZQhS75tPBwfz8wLZyys1H8wx8m0Lssjoq+Cl9u0KhZ/vlJmNHIVxQj
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:55ce:b0:253:32b1:e567 with SMTP id
 o14-20020a17090a55ce00b0025332b1e567mr227725pjm.2.1685741034033; Fri, 02 Jun
 2023 14:23:54 -0700 (PDT)
Date:   Fri,  2 Jun 2023 21:23:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602212350.535358-1-jstultz@google.com>
Subject: [RESEND][PATCH v2] sched/wait: Fix a kthread_park race with wait_woken()
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
2.41.0.rc2.161.g9c6817b8e7-goog

