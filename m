Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17D273485D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFRUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFRUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490F123;
        Sun, 18 Jun 2023 13:50:03 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLza2EuRT8Pc9gGBN+8vDyqrzm6IJK5zD9DGw50QT6U=;
        b=nPuc6awDZWgANksgHs7s7QSQtDmMAlRwwFZLiGDe7a5tIHh3zj9F0usTFO4yv7AwqNfFh3
        z3kXhEOmgtq08gjrAAnNUZaomNgSN7Ln/8aipVMBKqr7nH0QW4SmSVvmoj+WHs3F0Op2fd
        erMHa/GVGldK0yAJh7h1DS9vW4uhFxVC3nQuFqQRwJIqCeJt/3UIwLd0015PspeHPRHgSt
        szWkxeG+zF2C+Pbw5qXto8Q+Y5qgk7W2scKwI4TWaHgLjyiMpduvqYwiOMNa20xCmbNDLv
        //FK9MZ8ThTDEiAV4ntwhPtc7w6L+7IfZhI/3n+MX9S+YYDHqXGA2yc+7O1wrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLza2EuRT8Pc9gGBN+8vDyqrzm6IJK5zD9DGw50QT6U=;
        b=4e9YSEuAE14f9GlL/UUHr9vHLdDBNbsqVX+1GH752svLc0oOtyv9+z9o+dmXqIqS9Y0Tsq
        EObs7cFjykAV5ECQ==
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
Message-ID: <168712140125.404.806739037272052051.tip-bot2@tip-bot2>
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

Commit-ID:     65cade468dee537885b51897ba41ba05a4dcf6ca
Gitweb:        https://git.kernel.org/tip/65cade468dee537885b51897ba41ba05a4dcf6ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:50 +02:00

posix-timers: Document sys_clock_getoverrun()

Document the syscall in detail and with coherent sentences.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.462051641@linutronix.de

---
 kernel/time/posix-timers.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e1af74c..191ecf5 100644
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
