Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615436C25B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCTXh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCTXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2336685
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso14424180ybu.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bMyxMo2OrU8zdLjC4DVnVi1YjKD+2xFoy9FGGeajpo=;
        b=qR8HRj/uNpfNeexzdD3NSFaYQWdRoJDVXPizK+wXOQWFYtX8R1+aVjZdU1/ib5VwkW
         o9bIMNcgC6U84WI611cMZ3nMGR9lOmlNY1EQhi82VZbDdFW/yXZF40jXonjZiLi64YtT
         m6e81g6eATsubVyjsLc1gajg52/Otu95UYKZpdJNog4uqyQoC+DxyntBgL40uO4GxP2S
         kXhooO86PZE/PSev2YsGtyaVxzG/RPaLyHu8bf6ufuy4YMx5cdDBFiG6j/wqXnCg6mZQ
         dWmsqe1nTDvTZyesWKeDcXYmP2C26cRfJhwlNHXclJm0tumQxdmwQHgp0rvpM9O03z+N
         TcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bMyxMo2OrU8zdLjC4DVnVi1YjKD+2xFoy9FGGeajpo=;
        b=mFw1/OPw4/26NFrQ3it3mTbnJ6pOheuYkTx3O6QBv7U26A5O+pWHqCv2sltgm/eml4
         7hH+1x1v6mrNjm7bBJPM40yuhVzGti16ibGFq6enKgG1Df5hTO5PEeEVLjlupNZ+ulfl
         3gxfYY6jsCY7ZsT+gIonGQ3pNcEtZK8Rnn4RnRwQiomiWJ6h8tEcXVlD9dURTmQsnmXV
         JtMYwVoMudZDJjFnkDCujVURNZh9FL7i2nodFux24LuINXKkEC6dkqGcBAgrlR/ODfG3
         EY/wK8YC+uRtB1aXErB5sSReBmHxn5jfRjZdfn7x4eUo/D/FDPNHn7K6KxMnXkZRr48y
         MwrQ==
X-Gm-Message-State: AAQBX9dNNzL3j0fI+2kkzxKG3vexrNL+8nGQzX/NSOWo0Mef3oc2Ivyk
        WlSWML7zV3k5g+EVKB65TVjTXS+BwHzZvjBGn+VpE8uC/DodKIQ8yo/W9qZc9nvk3v2C58dIaZq
        J+i6yPT3NCZgLcsKX9h1Nb6SBXuMRblHy+wIG/bTolV8KWodefor/as8A/ztgrjIg3kXonbo=
X-Google-Smtp-Source: AKy350ZWvQI1r4cFZayiWToXAyK6ix2uPUisadol0MyIfiVJguT9ukdRPWq+kcpfQrCaDTrYWi60+CJocdJ4
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:2d8:0:b0:b36:c001:d0a7 with SMTP id
 207-20020a2502d8000000b00b36c001d0a7mr178103ybc.8.1679355459670; Mon, 20 Mar
 2023 16:37:39 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:13 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-6-jstultz@google.com>
Subject: [PATCH v2 05/12] locking/mutex: Expose mutex_owner()
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
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
Cc: kernel-team@android.com
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
index d322f7c1c8fa..ead4213232cc 100644
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
2.40.0.rc1.284.g88254d51c5-goog

