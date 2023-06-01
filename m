Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFCA7192E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjFAGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjFAF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DBE5D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:20 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b03ae23cf7so1285925ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599159; x=1688191159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl83JFmq5DGiAWWnIdFRVnY3DNvwp/CATr/wZmCpEuo=;
        b=ViVgx/PuN9MLmdNybo41KvSJ+mqfr/QrzY3xE1C+mEnv4qvIG8Vh4e4lAZq8o/pi+6
         BuAai3UElvNic61P7FJHBK+0xOElM9YDgRpupsAZv1HIXfQmHojcQ++RThtOAZJB6D0K
         bxY2XDj3I7lytKbMUskON/IwrVL/HImFBiAiwCqo0NzGWFYJDfkXpysgIwln2UjsXC0e
         AvYTEnwtdIZZSq7h5TsIHyjlmWOQDHDKAujHxLqnwpcZ6OY5V+v0PlkibSTLcFnleBdn
         yTvV9sN/zEDtIsOld6sHqGEou51tPudWF8Gc4dGA+lmXHxjeaqBO6R0jETCk7lNAA4cI
         V0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599159; x=1688191159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl83JFmq5DGiAWWnIdFRVnY3DNvwp/CATr/wZmCpEuo=;
        b=XQ2nRmJfQYaYx4GuVvJ5cJvGp2WYSGYwyzlDJJnqABiKd7AjokHv+KdNIoHJVFPvtB
         n7Dfpnu1pcRLE2NQ+44EPZ5PviUu8IX1DP/g+QPbbqG4Rd4AfcVKQstcUBeh1aCuwhWp
         UCjpvjbiYS7RGt6uUjNp1tSqYsdbXTKRZR6JnI+kRDHtF0Qc1EWsH2PpTROdLJuhsI6H
         11hde5t3ITWIAAuWi448tdKZuK5mYk71MYD3fFEO9Qpzwz5mWv7jkER80L8sOgS6fhuR
         /kctzMpdPFtDb9v/rGWykHLp5Yormp5c6+zo+EF00sF6CgmtEjXSjGUBct+COIqOSUnK
         zBaA==
X-Gm-Message-State: AC+VfDz3E9mbcCmXIpVmgsDxlyQTPogAeXHY77aA1i04GeFBvx0wnXnF
        tdc5oTe04ARoxBGPqg1/mK0zvsDhTWx508P5/kHU9AEMaaQZr66yKdxocu6OEvENkynCTVR58ma
        x+0BWsJTasVrPeL4vvL4iR2mhT2LtyO4/40Z0Hs5nDLKDbtTL1v6NPSunVmFrosMe6JqHOTk=
X-Google-Smtp-Source: ACHHUZ5czSEkrQ1QvdESejXEehzuZ9LeefxgyNbdSBV49grdID/qUzTJS4qb46VGW9GXN1fKEWt03ww/lf9w
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:8486:b0:1a6:6bdb:b542 with SMTP id
 c6-20020a170902848600b001a66bdbb542mr1830304plo.9.1685599159247; Wed, 31 May
 2023 22:59:19 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:16 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-14-jstultz@google.com>
Subject: [PATCH v4 13/13] sched: Fixups to find_exec_ctx
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_exec_ctx() would sometimes cause the rt task pushing
to try to push tasks in the chain that ends in the rq->curr.

This caused lots of migration noise and effecively livelock
 where tasks would get pushed off to other cpus, then
proxy-migrated back to the lockowner's cpu, over and over.

This kept other cpus constantly proxy-migrating away and
never actually selecting a task to run  - effectively
hanging the system.

So this patch reworks some of the find_exec_ctx logic
so we stop when we hit rq->curr, and changes the logic
that was returning NULL when we came across
rq_selected(), as I'm not sure why we'd stop there.

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
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e0e6c2feefd0..9cdabb79d450 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3881,7 +3881,15 @@ struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
 		if (owner == exec_ctx)
 			break;
 
-		if (!task_queued_on_rq(rq, owner) || task_current_selected(rq, owner)) {
+		/* If we get to current, that's the exec ctx! */
+		if (task_current(rq, owner))
+			return owner;
+
+		/*
+		 * XXX This previously was checking task_current_selected()
+		 * but that doesnt' make much sense to me. -jstultz
+		 */
+		if (!task_queued_on_rq(rq, owner)) {
 			exec_ctx = NULL;
 			break;
 		}
-- 
2.41.0.rc0.172.g3f132b7071-goog

