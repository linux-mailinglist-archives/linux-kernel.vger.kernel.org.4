Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601C6F6341
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEDDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEDDRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:17:40 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39BB10D9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:17:37 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1683170117tlj3
Received: from localhost ( [255.98.72.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 May 2023 11:15:15 +0800 (CST)
X-QQ-SSF: 0140000000000090C000000A0000000
X-QQ-FEAT: U9wPccABgDghcOsVBxQLT/HrFuzkpGxzB5B5oUBHEAipXRA8u5jCGXjIo10R8
        73/tMLPooeDpWpvlrau06sqODgNFMYCSsrlEDl+SLAtGCN4RcSLee8jKGV/7ZnanDtaegdO
        hcvqeRKQbR59V3QeD08EXvCpkdiIMWEo0Urx93fS6KaDoSc+qHRB8QmzOgXSp6iqZFM6gXQ
        OCRT8vEJJIKbww1EN2EmNmjvcFmYvhkltJK/yE0ULclaDvK4LQIvwgOK9g88WMBlwIwJWND
        nSP5+nqpVpMs561fdT37ctK/WXCMYGXYINymPeMOcCYer4RicHS160EL9DhMrfZPEvuIVho
        8rGX9AwulYo9ZzE9tvarPZym/vsMQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13721817484134586107
Date:   Thu, 4 May 2023 11:15:14 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] task_strcut: Correct spelling mistakes in comments.
Message-ID: <152717F136F81E85+ZFMjQo/4GpnuOIDs@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling mistakes in comments.

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 kernel/locking/mutex.c | 4 ++--
 kernel/locking/rwsem.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d973fe6041bf..fe7335fb63d4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -362,7 +362,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 		 * checking lock->owner still matches owner. And we already
 		 * disabled preemption which is equal to the RCU read-side
 		 * crital section in optimistic spinning code. Thus the
-		 * task_strcut structure won't go away during the spinning
+		 * task_struct structure won't go away during the spinning
 		 * period
 		 */
 		barrier();
@@ -401,7 +401,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 
 	/*
 	 * We already disabled preemption which is equal to the RCU read-side
-	 * crital section in optimistic spinning code. Thus the task_strcut
+	 * crital section in optimistic spinning code. Thus the task_struct
 	 * structure won't go away during the spinning period.
 	 */
 	owner = __mutex_owner(lock);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a1..f2085ce74c15 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -715,7 +715,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	/*
 	 * Disable preemption is equal to the RCU read-side crital section,
-	 * thus the task_strcut structure won't go away.
+	 * thus the task_struct structure won't go away.
 	 */
 	owner = rwsem_owner_flags(sem, &flags);
 	/*
-- 
2.34.1

