Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F896FBD1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEICZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjEICY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:24:58 -0400
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFED4239
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:24:48 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1683599070twsm
Received: from localhost ( [255.228.96.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 09 May 2023 10:24:28 +0800 (CST)
X-QQ-SSF: 0140000000000090C000000A0000000
X-QQ-FEAT: ao4JQgu0M38lHU/H/3o1aXxUjmoBJEkmkRCKEFE813Pkr5Yl6eV4sNXnsgGGx
        6A6ntSioZDI9nX/W49HgFAOnlaYEeBdw6d75ktUJc+ucDZPChbx8+MNyCVPZMJS96SGARMX
        mnUMbagrjnX1J/XliPGwMJFPGDw1Xb08trmGyCSPXksj2Nb9iop5DcF0le6MnQ1DJV80KYa
        AfvHyPI9MwmOlvezSgGykfwMRb54AiP72RgHiH90VIb/qhZQs3W9DhbDEbcNAKJqi2sOPJj
        vR2wBKmNB4UUL8+SFrw+THPsDWawTbP9w8t4ZqEPCW0qN7a/znoTMEUbX3Um0q1f+3i+WUx
        zNbPPNMnoebn39xahZI7MThbO8eOw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11852908852472917791
Date:   Tue, 9 May 2023 10:24:32 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] locking: Fix a typo of comment
Message-ID: <BE152DE8EF273104+ZFmu4JjPKLhla6Y9@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-2
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

