Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA36DD0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjDKEZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDKEZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024C10E5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y4-20020a253204000000b00b392ae70300so7594891yby.21
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187129; x=1683779129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7PRxTE/G+TewFJJW+aiwRGrdyvM9ejq86ABZBlhxUk=;
        b=PRdVbcVQdfIvRjuDqKuLiynVWdcAN7tDcV7TDQEKAG5aVZGSCUbH5Ta/p4ZVugRsVq
         WfuN9fGmQhTNNbzm7G2sf0T+YL9tjWRwgSFCQGFO9s5L5e5CmJk58BzV21Rm/QMGEfah
         /CMBT1hG5tiNi0FDGwUnyi/1uKzPFNfX/6Jmx8tVF4CVqg/CeynRI0UihrstmFo23J0l
         jZI0F2SPu5AOYuH2u/sOCW2mBfKvgsSSnmgFtbmR3/9w0g/SAO/EsPnTe64jmwvEk+55
         jpTazCE8KWeokl17MiSSofm95JOyDOiDFw5f2lSo1iUPgg/PEDE5oaFCGeWT3MUIh1cQ
         ZBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187129; x=1683779129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7PRxTE/G+TewFJJW+aiwRGrdyvM9ejq86ABZBlhxUk=;
        b=0zZ5YDmcIW3e1q4JCBs3KdihVGZgSn7mqGEptDGallUJjiPeLfS6A1WA+hArAdCU5e
         mgPQmtx/IF6kPSiLs55Y4ddAotQxZRaJSul5yT26oQEpWLTWH3xWreI5RvlqPK5eNCfs
         b1LNYb2Eo54oyISGh76EREc5CcTM2IqT/fuOacl591Zmfezvi3jSod7FM8LypiOps8mj
         IVx3bAylchp34FUB6Xqe5yzfJ0h71ZcxaNa93XvA8HyB8/3xen4mp6uVHF3IYoiSPdOM
         5e0v8d6GHvhfFZzHFiORu67TK8mWqHWLQgFvpeVEvfeIcQ86geDqI43fIxm8CF0YG/rs
         aaDw==
X-Gm-Message-State: AAQBX9e+sGMHEZd+Hx38pCxIMoRFhQX5XXpwuPR969LcQPJw+ahRNyXo
        m7iCMBczLRJNu9MBPRpdjnONrE0NrSHGsqQG/66/NSTnCsLoPB3cPKk9XbENGl0QPzCiUZzoBge
        S10afamBNDl844AHKOUO48MhMeNATyViztofLOdI9bquYoqz+NUhab2I+y4zhFg0X1AUt6p8=
X-Google-Smtp-Source: AKy350ZAZhWGobfYrb6GHmvIGepMHShBMoVGwWMp6n3Jgy5a9161QujnAr76OYbjAFiV7su1rDTLXo66KC7r
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:73ca:0:b0:b8e:dadc:a081 with SMTP id
 o193-20020a2573ca000000b00b8edadca081mr5070323ybc.5.1681187129167; Mon, 10
 Apr 2023 21:25:29 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:03 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-7-jstultz@google.com>
Subject: [PATCH v3 06/14] locking/mutex: Expose mutex_owner()
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

Implementing proxy execution requires that scheduler code be able to
identify the current owner of a mutex. Expose a new helper
mutex_owner() for this purpose.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Removed the EXPORT_SYMBOL]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Tweaked subject line]
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/linux/mutex.h  | 2 ++
 kernel/locking/mutex.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8f226d460f51..ebdc59cb0bf6 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -118,6 +118,8 @@ do {									\
 extern void __mutex_init(struct mutex *lock, const char *name,
 			 struct lock_class_key *key);
 
+extern struct task_struct *mutex_owner(struct mutex *lock);
+
 /**
  * mutex_is_locked - is the mutex locked
  * @lock: the mutex to be queried
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 45f1b7519f63..cbc34d5f4486 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -81,6 +81,11 @@ static inline struct task_struct *__mutex_owner(struct mutex *lock)
 	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
 
+struct task_struct *mutex_owner(struct mutex *lock)
+{
+	return __mutex_owner(lock);
+}
+
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
-- 
2.40.0.577.gac1e443424-goog

