Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41BE6FFC03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjEKVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbjEKVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:42:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25315BA6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:41:49 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24df8644eaeso4907388a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683841308; x=1686433308;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43muZZqhwTl5Zf6bR8xbpoiNJBmmJ6GoS2BIrk8XQg0=;
        b=4MsedK4JufBOK2Pya7wQCIDxG0sCQ1VFTXWDgZhatiOWtPY8opQlb3hL15OT5+unZG
         c92gYZtsjWyA0xBBYuP1vjtV9F4vB2xfCoB1TbwZDS6rC9lEcLm8vQnbtah9R9tQVvk8
         3XqKLnL9WIFnp4raTswUlTUXryUFeRB5X3s/tRMH4GmJMbvmyj/r3b8iejmBq+6Dz+Bu
         BpteMnQmPKMuyMxqdEMLiL+po2QzBiS1Jne4oUn4GHrbhRN5fi04GbTI4PMxSqwaTflW
         htw1CwW32Ld/0Udqzx2i3OH+tBT7Cvm3ak2yGnWGLZ4oRNFpkr2Mv5GY3T2/7v1h5+uU
         4Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683841308; x=1686433308;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43muZZqhwTl5Zf6bR8xbpoiNJBmmJ6GoS2BIrk8XQg0=;
        b=c1OYRs8RKrmS/GFh12BfcbgHoB76lNpsfFKDKBIIoBFCubCOLvzcLClqFYO1E3ihzt
         g6xUcg7ZArghCFavVUMPbEjk0iY1vEV6YpKRYqY+HRYB1+vBqy41U2RtwW+VVTM3lekG
         fqpQNNPetcMmpVteCuuSVLBDIfSwggn4NnfE2W6T72/GVvnIC9ENdYMIg+EXjoMhx466
         KR5QRsocooFxYxewBa20/3VxwLgS6MyKro9NOXQ6kETf/nogrgkXQ0aB3ptTzlIDmJiD
         8Xmn76aBxxYxhhadAqJKnncTAcK0zwwxJWNJha3aRz4UU7Bp5j5md9UHOeuJ3pgf94dU
         k8DA==
X-Gm-Message-State: AC+VfDzHTCXmwiYxf7ssDExztS717hZbclkINtdyKE7qNX7JGSvXS+ZT
        xtY2ZIjdPIS19XQ95rpVtFydSVQoQFM+q5tx1qcWUFERhLrTEHprYP2RNbJ0/f39nWoCLq77rDX
        0VqixBtElE4gFKYtk9v16tgYEgDss57iItH+7dg6TARXk8zuqiFZuin15sKfCUHt+qYhcRtM=
X-Google-Smtp-Source: ACHHUZ4s/bA5bbWMEoCZHDspkz2P/SKgGc9ShoCkPP2udc8klgmNRKyV+96ayDFCh+GNSU2whHAGdftp/1LC
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:f517:b0:250:43bb:dced with SMTP id
 cs23-20020a17090af51700b0025043bbdcedmr6155590pjb.5.1683841308026; Thu, 11
 May 2023 14:41:48 -0700 (PDT)
Date:   Thu, 11 May 2023 21:41:30 +0000
In-Reply-To: <20230406194053.876844-1-arve@android.com>
Mime-Version: 1.0
References: <20230406194053.876844-1-arve@android.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511214144.1924757-1-jstultz@google.com>
Subject: [PATCH] sched/wait: Fix a kthread_park race with wait_woken()
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

kthread_park and wait_woken have a similar race that kthread_stop and
wait_woken used to have before it was fixed in
cb6538e740d7543cd989128625cf8cac4b471e0a. Extend that fix to also cover
kthread_park.

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
Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
This seemingly slipped by, so I wanted to resend it
for review.
---
 kernel/sched/wait.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 133b74730738..a9cf49da884b 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -425,9 +425,9 @@ int autoremove_wake_function(struct wait_queue_entry *w=
q_entry, unsigned mode, i
 }
 EXPORT_SYMBOL(autoremove_wake_function);
=20
-static inline bool is_kthread_should_stop(void)
+static inline bool is_kthread_should_stop_or_park(void)
 {
-	return (current->flags & PF_KTHREAD) && kthread_should_stop();
+	return (current->flags & PF_KTHREAD) && (kthread_should_stop() || kthread=
_should_park());
 }
=20
 /*
@@ -459,7 +459,7 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsi=
gned mode, long timeout)
 	 * or woken_wake_function() sees our store to current->state.
 	 */
 	set_current_state(mode); /* A */
-	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
+	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop_or_park=
())
 		timeout =3D schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
=20
--=20
2.40.1.606.ga4b1b128d6-goog

