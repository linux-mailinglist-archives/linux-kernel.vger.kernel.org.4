Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3475B32AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiIIJBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiIIJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E35112B11;
        Fri,  9 Sep 2022 02:00:20 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IzOiLj+bSvEaGLYW3g1cVbkYw2bffhfabGuSOQsjUKo=;
        b=awIYRVtRWSzLvrt9vaTpPOm9gZU57uvGid5DE5TIQv6YuLXh8FnxSTL2MBqg7nu2zOaFlv
        S+jcQl/cCMUD9b5cjz7w5yVY1JoJ8LL4Q1hSljxmnBuGCeVgq8VRusFalse1tJk6xeZM1n
        eySv0FPjLKX8mqwJ6wqQfUE4YulpdPLsBekWnOn4IOxRRFrkwy+YzBZUF/YtZcFU8pNmuE
        RYb+mFaiEiVpAB96E/IDtqnVxf7jdyNHahZKkQniyJreMuV4JlRq47h5d2HqCrqmuNWajA
        +wru5mlUuPYuZGbDLOmAFaiuDeL3AgObJvIM6ccmpM504EOfbuf4VjNIh5rf/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IzOiLj+bSvEaGLYW3g1cVbkYw2bffhfabGuSOQsjUKo=;
        b=btTSX0dun/m77V8dRnSQ0EpD8wYDrkvfzdZenKtDldhvNsRYNObgXXaO92RItQu5oyCMcs
        sQ6ck+I5DRuWYdBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Widen TAKS_state literals
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166271401814.401.4801009840639646812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9963e444f71e671bcbc30d61cf23a2c686ac7d05
Gitweb:        https://git.kernel.org/tip/9963e444f71e671bcbc30d61cf23a2c686ac7d05
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 06 Sep 2022 13:11:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:50 +02:00

sched: Widen TAKS_state literals

In preparation of adding more states, add a few 0s to the literals as
we've just about ran out.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0facaad..9fc23a2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -81,25 +81,25 @@ struct task_group;
  */
 
 /* Used in tsk->state: */
-#define TASK_RUNNING			0x0000
-#define TASK_INTERRUPTIBLE		0x0001
-#define TASK_UNINTERRUPTIBLE		0x0002
-#define __TASK_STOPPED			0x0004
-#define __TASK_TRACED			0x0008
+#define TASK_RUNNING			0x00000000
+#define TASK_INTERRUPTIBLE		0x00000001
+#define TASK_UNINTERRUPTIBLE		0x00000002
+#define __TASK_STOPPED			0x00000004
+#define __TASK_TRACED			0x00000008
 /* Used in tsk->exit_state: */
-#define EXIT_DEAD			0x0010
-#define EXIT_ZOMBIE			0x0020
+#define EXIT_DEAD			0x00000010
+#define EXIT_ZOMBIE			0x00000020
 #define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
 /* Used in tsk->state again: */
-#define TASK_PARKED			0x0040
-#define TASK_DEAD			0x0080
-#define TASK_WAKEKILL			0x0100
-#define TASK_WAKING			0x0200
-#define TASK_NOLOAD			0x0400
-#define TASK_NEW			0x0800
+#define TASK_PARKED			0x00000040
+#define TASK_DEAD			0x00000080
+#define TASK_WAKEKILL			0x00000100
+#define TASK_WAKING			0x00000200
+#define TASK_NOLOAD			0x00000400
+#define TASK_NEW			0x00000800
 /* RT specific auxilliary flag to mark RT lock waiters */
-#define TASK_RTLOCK_WAIT		0x1000
-#define TASK_STATE_MAX			0x2000
+#define TASK_RTLOCK_WAIT		0x00001000
+#define TASK_STATE_MAX			0x00002000
 
 #define TASK_ANY			(TASK_STATE_MAX-1)
 
