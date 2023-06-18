Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76CF734861
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFRUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFRUuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB33AE49;
        Sun, 18 Jun 2023 13:50:08 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:50:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVSIjk+yc6ILF9K42y1xy8dftnlzkecrXrQkd8YW1eY=;
        b=H8kmFWiJMpxJwJ0SAfNQcvCxBgIHjNvbObLfOxpKonZMXi9R0hKxSYWxHp2f6bRW4KcATv
        DqAhjKlFrGflnSZ2a1oXO8TpXKer78jkn1R/hQxwjKn3tfDGFFhoUWczHOX57SA32L+kEv
        vUsnydk69/y9Qmnj5uk+u/Qm8XClKXpweMfhhqrCSFk0e88Zb6pivUVey3jNa3suk5M9lP
        miuXtaXxc7wuODuQRxIj7Pv3FVs9A1kk4JmA9YhvU3IkNd961HpCT545fb0hscyk/2Ex+a
        mT+L7rRQMPbGzBgi/n5G/PWVYIy7yUjvt8z1WZ+dRQnRCTXnNzOZKP/ovvEXWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVSIjk+yc6ILF9K42y1xy8dftnlzkecrXrQkd8YW1eY=;
        b=OvWLZeqo4kI6CgJpkcWB+vmfmc8XEoaeL67KHZ/luGO3SurGzqbLIVNqitVdIMcId7OuqT
        xJg1ogdI1RTXL6Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add comments about timer lookup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.091081515@linutronix.de>
References: <20230425183313.091081515@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712140656.404.4260184240973018058.tip-bot2@tip-bot2>
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

Commit-ID:     ae88967d71f1b4ffb6e48043993d37a106da8109
Gitweb:        https://git.kernel.org/tip/ae88967d71f1b4ffb6e48043993d37a106da8109
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:49 +02:00

posix-timers: Add comments about timer lookup

Document how the timer ID validation in the hash table works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.091081515@linutronix.de

---
 kernel/time/posix-timers.c | 39 ++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 79909a2..d7890ac 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -506,6 +506,12 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		return -EAGAIN;
 
 	spin_lock_init(&new_timer->it_lock);
+
+	/*
+	 * Add the timer to the hash table. The timer is not yet valid
+	 * because new_timer::it_signal is still NULL. The timer id is also
+	 * not yet visible to user space.
+	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
 		error = new_timer_id;
@@ -551,6 +557,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		goto out;
 
 	spin_lock_irq(&current->sighand->siglock);
+	/* This makes the timer valid in the hash table */
 	new_timer->it_signal = current->signal;
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
@@ -597,13 +604,6 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clock,
 }
 #endif
 
-/*
- * Locking issues: We need to protect the result of the id look up until
- * we get the timer locked down so it is not deleted under us.  The
- * removal is done under the idr spinlock so we use that here to bridge
- * the find to the timer lock.  To avoid a dead lock, the timer id MUST
- * be release with out holding the timer lock.
- */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 {
 	struct k_itimer *timr;
@@ -615,10 +615,35 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	if ((unsigned long long)timer_id > INT_MAX)
 		return NULL;
 
+	/*
+	 * The hash lookup and the timers are RCU protected.
+	 *
+	 * Timers are added to the hash in invalid state where
+	 * timr::it_signal == NULL. timer::it_signal is only set after the
+	 * rest of the initialization succeeded.
+	 *
+	 * Timer destruction happens in steps:
+	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  2) Release timr::it_lock
+	 *  3) Remove from the hash under hash_lock
+	 *  4) Call RCU for removal after the grace period
+	 *
+	 * Holding rcu_read_lock() accross the lookup ensures that
+	 * the timer cannot be freed.
+	 *
+	 * The lookup validates locklessly that timr::it_signal ==
+	 * current::it_signal and timr::it_id == @timer_id. timr::it_id
+	 * can't change, but timr::it_signal becomes NULL during
+	 * destruction.
+	 */
 	rcu_read_lock();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
+		/*
+		 * Validate under timr::it_lock that timr::it_signal is
+		 * still valid. Pairs with #1 above.
+		 */
 		if (timr->it_signal == current->signal) {
 			rcu_read_unlock();
 			return timr;
