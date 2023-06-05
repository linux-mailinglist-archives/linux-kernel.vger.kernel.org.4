Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B45722A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjFEPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjFEPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C12F3;
        Mon,  5 Jun 2023 08:08:30 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xau9hnP+xB/FyBTuzfYxEESPSpayrKGs3N53kYahp90=;
        b=WXTNLZEx6XNVozuyardP+0hnkhacI/FxbQ38zclWzJfChtI7ByMLNGTf4dbmm9unoPQKrE
        BZbpKcxj5gE+LtlSQjK6QJ38M3FerjasX+WKW2CyPO1CGFP7XHqHs4+bhSzGgDqhqOLq34
        4f0d7Q/a1C0bySi/t0Up3a8/DkEVeQqNDaosWX3Ui2GyTmHltSTqlxvQVOcUDqEWI494zq
        U+nTuAYuqTfk0r1TlrGG8TxYgUsMrBlEv2LSKMYgPohKksBkCXy3zmbuZDO4pDEqI1YISI
        JmYF6ykzcr5idG8LWgyDCoZUdNr8fK1TG3JUhV5JVbzgQM2RQo8jmFJOTgBKcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xau9hnP+xB/FyBTuzfYxEESPSpayrKGs3N53kYahp90=;
        b=BIllHdgV3oA2aoc9HUFKFp5qBH2W2Xy4Ts62MoHlfV4TRSVn+0AUnqgpZ7ytjwtE9CRSqZ
        pXIZWUJArFhL9/Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document sys_clock_getoverrun()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.462051641@linutronix.de>
References: <20230425183313.462051641@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770840.404.11783761312188039507.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1adc8de86737c3d134c2da5ed8e56c2de4729923
Gitweb:        https://git.kernel.org/tip/1adc8de86737c3d134c2da5ed8e56c2de4729923
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:38 +02:00

posix-timers: Document sys_clock_getoverrun()

Document the syscall in detail and with coherent sentences.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.462051641@linutronix.de

---
 kernel/time/posix-timers.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 663d3c6..67c1d4d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -783,14 +783,23 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
 
 #endif
 
-/*
- * Get the number of overruns of a POSIX.1b interval timer.  This is to
- * be the overrun of the timer last delivered.  At the same time we are
- * accumulating overruns on the next timer.  The overrun is frozen when
- * the signal is delivered, either at the notify time (if the info block
- * is not queued) or at the actual delivery time (as we are informed by
- * the call back to posixtimer_rearm().  So all we need to do is
- * to pick up the frozen overrun.
+/**
+ * sys_timer_getoverrun - Get the number of overruns of a POSIX.1b interval timer
+ * @timer_id:	The timer ID which identifies the timer
+ *
+ * The "overrun count" of a timer is one plus the number of expiration
+ * intervals which have elapsed between the first expiry, which queues the
+ * signal and the actual signal delivery. On signal delivery the "overrun
+ * count" is calculated and cached, so it can be returned directly here.
+ *
+ * As this is relative to the last queued signal the returned overrun count
+ * is meaningless outside of the signal delivery path and even there it
+ * does not accurately reflect the current state when user space evaluates
+ * it.
+ *
+ * Returns:
+ *	-EINVAL		@timer_id is invalid
+ *	1..INT_MAX	The number of overruns related to the last delivered signal
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
