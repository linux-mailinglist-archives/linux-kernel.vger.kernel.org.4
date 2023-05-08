Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1D6FA367
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjEHJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:32:30 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363F4233
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:32:27 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1683538337t7l6
Received: from localhost ( [255.223.254.8])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 May 2023 17:32:15 +0800 (CST)
X-QQ-SSF: 0140000000000090C000000A0000000
X-QQ-FEAT: OICyp1OkQRLg/iYF4KHx+yoY9T6DgH1PhwP3ZovWiwKhjocyNsBqWHLHrLnVY
        3UDVGGTyebYDbYZ8Ke4uEHQKJaox0lAKUcxN5WtPJACtbSiLosTwgyk3TL4ZLt9sL2oRhtV
        Jb+66gD11b9Qv7tQ2zogvrrJsubip4gdm3RSsqGh92jQJVfsbDxxDTR0c1bSrgq3m4lKRhT
        us9pVchOVaqZ3x23mj0zr9l3BGCFeErUZt3eoTxljgdLT+wGcCA+hQht9AkIPbYT032ew1k
        4wOjgUA97QjUqy96DHdetw6Adv+75khpQGDNrxvkGkcLJolUe/hH+ZvWwfjTDGQ03cVF/wX
        BpMSnCr1Srx9UsWbAg63p/owiLpUg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15136933522312511394
Date:   Mon, 8 May 2023 17:32:14 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] locking: Fix a typo of comment
Message-ID: <06890F37BC202460+ZFjBnvTGQwXTFVu7@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-2
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As title

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 kernel/locking/mutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.34.1

