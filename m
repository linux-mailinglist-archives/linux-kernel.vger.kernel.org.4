Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF865C8A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjACVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjACVJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:09:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB9014D3B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 13:09:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n190-20020a25dac7000000b007447d7a25e4so31145164ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANpneqDCJ+3KDxQkFjUAT/0LVWtajW2dqlpEiVRJX78=;
        b=Pvg1wppJZjphjhVqhO4J2TPpxFkdSWTgKMmeH0BKOHsuygBXm2vWF7hueOOYSYCSjk
         uC2F88QoX9eqkruEZnO+f55CKVsGBkkiYIaeM80M0fk18cSJxBskzD0UI9lb4b9hs9SZ
         ki5tIy4tJRzzJsHYjcTndIdIXU5cN+BZSSeABj5ET+bucob2VW88IEhHc+2xW/ASK5a5
         30ceE47WYlSktl++FWoyUJatifclk3bmBuNGDDzWLT8EJlvum53QNbPeiSsJEhUZTPu6
         qHDastODrUkdwLlLt+m7Ac12FbK+/dD5aimCTFh2mRxBq7y5YLt9govY4THwFuFqgBMZ
         euwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANpneqDCJ+3KDxQkFjUAT/0LVWtajW2dqlpEiVRJX78=;
        b=DEzfnOY4irWWoiMuxTl8kAWkli95smMyB4qypQP5NnE+jrfkeVhYPYsYGH56MAoHNR
         bW0Z+29EV6L9sl+ynxm+D1MHT3esx34xXYxmDfuK5bl1ovvnOPci4xjzu9kiIkgpAGdK
         iP5hn43oIkTPjzA+kYjcSdb7YZs7v03890jln1lYXc2FJBtSQB7D2s57lO+pyqM1lpal
         SqEHWdhGeJJzcvMs0IkJgDpAs0MUjkPhzYsKLtAsKHr1LJHiiRoHQOJJfuxExvz9sxCf
         nZlz+q6a4cYgYooFjWBb3Heo6qd+jTbpDZm/zDM7w51eRAW9XRdKEay/qHjLz099Ahhx
         iSQA==
X-Gm-Message-State: AFqh2ko/lXZH+6VMmosVfGaM3Uk1ZdolNQ192guLpkCS229B87b1HxPI
        NYi1G6pigJVYr3xzf0xzfUd/y4QIi3Ak/G2Vdk1FZ24rzLJBG/27WUUpFnkwdoGWgQQS7/e/cWV
        lLC8WhnNFKlZs5SBT2s8eOFDLfPepH/ShXYdCWaL96BSKEN6IlnpUHFbD93Fq1aVh+83Hd5Y=
X-Google-Smtp-Source: AMrXdXszQLI356iJi0FQ13NMGufYQBDGhT7dkHTMZzShwnc54wCpbF9hn1nlqPkTj+uK6jGD+ZdKYhHRuIqB
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:452:0:b0:713:a3c8:7baf with SMTP id
 79-20020a250452000000b00713a3c87bafmr5283850ybe.641.1672780189166; Tue, 03
 Jan 2023 13:09:49 -0800 (PST)
Date:   Tue,  3 Jan 2023 21:09:33 +0000
In-Reply-To: <20230103151554.5c0a6c6f@gandalf.local.home>
Mime-Version: 1.0
References: <20230103151554.5c0a6c6f@gandalf.local.home>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230103210933.2979081-1-jstultz@google.com>
Subject: [PATCH v2] trace: Add trace points for tasklet entry/exit
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
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

From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

Tasklets are supposed to finish their work quickly and
should not block the current running process, but it is not
guaranteed that. Currently softirq_entry/exit can be used to
know total tasklets execution time, but not helpful to track
individual tasklet's execution time. With that we can't find
any culprit tasklet function, which is taking more time.

Add tasklet_entry/exit trace point support to track
individual tasklet execution.

This patch has been carried in the Android tree for awhile
so I wanted to submit it for review upstream. Feedback would
be appreciated!

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Connor O'Brien <connoro@google.com>
Cc: kernel-team@android.com
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
[elavila: Port to android-mainline]
Signed-off-by: J. Avila <elavila@google.com>
[jstultz: Rebased to upstream, cut unused trace points, added
 comments for the tracepoints, reworded commit]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Added tasklet pointer to the trace event as suggested by Steven
---
 include/trace/events/irq.h | 47 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  9 ++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..a07b4607b663 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,53 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func),
+
+	TP_STRUCT__entry(
+		__field(	void *,	tasklet)
+		__field(	void *,	func)
+	),
+
+	TP_fast_assign(
+		__entry->tasklet = t;
+		__entry->func = func;
+	),
+
+	TP_printk("tasklet=%ps function=%ps", __entry->tasklet, __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..1b725510dd0f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -793,10 +793,15 @@ static void tasklet_action_common(struct softirq_action *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
+					if (t->use_callback) {
+						trace_tasklet_entry(t, t->callback);
 						t->callback(t);
-					else
+						trace_tasklet_exit(t, t->callback);
+					} else {
+						trace_tasklet_entry(t, t->func);
 						t->func(t->data);
+						trace_tasklet_exit(t, t->func);
+					}
 				}
 				tasklet_unlock(t);
 				continue;
-- 
2.39.0.314.g84b9a713c41-goog

