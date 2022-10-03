Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100185F3803
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJCVpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJCVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE31A819
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:15 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m16-20020a17090ab79000b0020abf0d3ff4so1085762pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=CJ9H8CBxKRJhGb0mR/hcQ6BYPBA27hx15DUelORRnZs=;
        b=fFFXrcOsme29dcf0SBMdtGRw+Z2z/5WbDMWzaUwqECnq7yfvXqkJ4MI09tebTl5oaY
         cuMGa+jCVkzCTIajVNDpg6UwKha/QIzFvjSLplviyY5KKTyu9UG1Ii9wGVz9aYbi7+uh
         s5AQmiWZQt+1yn4Gml95Fp+lDcekS25o7JdcRwBUic9IEtOl5C+ni+OGitSAqvH3vr5f
         WYKrFRnJ6pX6XxxuSABy+g0aNeCxvKAlopz7E/S6MHKzfXflGzVJihWNftfJE6NSOdJz
         9F4oMpST2xFk+GKJGtEx7h/Cs4DTKQqxgJstDnumpg+6gBSZM1Pj5z5bBVl7xeIpL249
         8dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=CJ9H8CBxKRJhGb0mR/hcQ6BYPBA27hx15DUelORRnZs=;
        b=mcnk+sGmhS8PKHrgpCJ40uxANt3LD1HZbcaPzJkEYTOWO01fTUBowuJ6OgEaI5twI7
         TumrbMSRIOgUctRqM8vwkzjDxYELXgigJ5CzivYev2paDkklZFz3EolL0U4mODrj9XtR
         JwwpTMwN5dzAlmCm2Fa7GJdOQ0NHA+GNhgq6wTfNFTVLMfFyVOXrtUC0vTVHMPCXwul0
         ZQzFjpbUCirli4HeAKcOWi/cW+K6RcUYQAmT7hUdFdWRp5Kva9dzsauCBvge0PZkjrrn
         dUtO5n22QfK3xNSXFs8I+uHSJyiC4cwnVgn7cLiAd8hlkn/UCvGepByd106jTg23Z0Q3
         SD0g==
X-Gm-Message-State: ACrzQf3DuTbMiNA87umpcBOwSK9vYP61uoBOQtqdSq+SE/m6UZyOUsO+
        80QhMcdv6bK/FCZdjxgzb5ug18OyfMM17NwmoXsuxe0aQXNqaK05eLaP1ZXXREMP84U/Rbue6ID
        5ccJHObsCq5bh6Tw+Z0O28VnB9YVjDZWasLdKQNFnjXhg2iFRYniAiUFrrswBR13qE9keU+hT
X-Google-Smtp-Source: AMsMyM5VdBKm1gvBotqA+C+aC0HGWsrGXde5B2h9pqCoy2pfupi+zEHWeQiSJQUfcNd3QqGUFd0F4NTY0S/V
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a17:902:c40f:b0:17f:6737:9527 with SMTP id
 k15-20020a170902c40f00b0017f67379527mr3751625plk.19.1664833514103; Mon, 03
 Oct 2022 14:45:14 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:56 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-7-connoro@google.com>
Subject: [RFC PATCH 06/11] kernel/locking: Expose mutex_owner()
From:   "Connor O'Brien" <connoro@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
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

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Removed the EXPORT_SYMBOL]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
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
index f39e9ee3c4d0..325fc9db5004 100644
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
2.38.0.rc1.362.ged0d419d3c-goog

