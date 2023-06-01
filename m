Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15B7192DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFAF77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjFAF70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:59:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57F1AB
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659c7dad06so7674347b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685599150; x=1688191150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ6JJUxxg/evvLbMiOXiQLvIE2NeWkgAOuvpFCCCZeI=;
        b=nFzjfejdNuWfdbeW4COw8TITHM2+jzSeY30W6HIzeIEw0KdLMx6fFyQFq8IVguNPLE
         sPRZrxLlxrcuAkAn1vOhW4h19JugrwPcwiK09MKVkdGSDKX6+5riWbw+VMIk9JYqlJoh
         EWjQLwxPIYklx5Bd7nRr8pzjpd0lZVcph9z3qrvCzH3frC6vLVnBSXl2d4uMGnrnSEr0
         0lfXsKiXUSM0M4F3tqVNqhQIg23UqzLOGE4jfjQpY/22dJDgcwOs2QAdIu8UL/BsUHw7
         gLyl5SMnIg27SOZUO2XgQR1SvSq+WQ3LJUpZ/7jDB3n3UJC9wa0ijIm72rstIVv2ucAT
         1Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599150; x=1688191150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ6JJUxxg/evvLbMiOXiQLvIE2NeWkgAOuvpFCCCZeI=;
        b=e5veZnNCV+71lZOR4ssDZf7wHjvQDVpR7B2gHS/Gu+e4CLIh+bqJqO4pIPXkqJ/LcA
         9GuKdvI4c8IxCKpJYjF7MiALAwNkdQc8HsqYbs1TskILoCy3WOvG748FDEJToJO82jGx
         1oAHqh7ftobGQSjLAx0021Ga9kLdpTPkUVOrExPTXH/UsBmppV0F214zwFqumTt9kvW/
         s78VWTKivY9+LhF/E+XDDdCDKdskZ7RmvLc7dWcTq/NPKbSS+V3BfHsyN9awoh8K/PvU
         yiHR3pBNH8xmki32DTAqqDsfYxjdyj/6bvhNfomjU6uLPKKQy/iw5lk37swWc83z2DiY
         NquA==
X-Gm-Message-State: AC+VfDwRlhOw0AHUQ09YeINYLBhtcaM/qDSgeegC888s93/ytydTgd1J
        6uCwW4tpTCH4OKXbiK+wPDyvaSwxw7ECp255ndYZ0F1GOdPrkwQWGQbnPDaYjKGZKrjGGAY7Mes
        4P/ZVX9a7KgPXPpSnrLktkzrw8UOi8ckud2jhWrRQFH1gzXrX+i0iljyvLa2FVYcoZ9QL73I=
X-Google-Smtp-Source: ACHHUZ55SvZRPwcIQBjeAyn4cjvyPhWUBLUQTmafrND5OdDeR79g7o65gDgAOKUv95QJXsS3h6RWKeseG75S
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:ad5e:0:b0:565:b765:3fb with SMTP id
 l30-20020a81ad5e000000b00565b76503fbmr4718726ywk.9.1685599150121; Wed, 31 May
 2023 22:59:10 -0700 (PDT)
Date:   Thu,  1 Jun 2023 05:58:11 +0000
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601055846.2349566-9-jstultz@google.com>
Subject: [PATCH v4 08/13] sched: Unnest ttwu_runnable in prep for proxy-execution
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

Slightly rework ttwu_runnable to minimize the nesting to help
make the proxy-execution changes easier to read.

Should be no logical change here.

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
 kernel/sched/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ace75aadb90b..3dce69feb934 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3799,18 +3799,20 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			update_rq_clock(rq);
-			check_preempt_curr(rq, p, wake_flags);
-		}
-		ttwu_do_wakeup(p);
-		ret = 1;
+	if (!task_on_rq_queued(p))
+		goto out_unlock;
+
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		update_rq_clock(rq);
+		check_preempt_curr(rq, p, wake_flags);
 	}
+	ttwu_do_wakeup(p);
+	ret = 1;
+out_unlock:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
-- 
2.41.0.rc0.172.g3f132b7071-goog

