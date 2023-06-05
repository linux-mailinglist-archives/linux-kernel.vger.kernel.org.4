Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927F272330D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFEWRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjFEWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:17:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B2AF;
        Mon,  5 Jun 2023 15:17:35 -0700 (PDT)
Date:   Mon, 05 Jun 2023 22:17:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686003453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YI5W3YjQ1K9oa7fcUmMupvk4A5HHThGVA4WIB5FmNV0=;
        b=tLf8QJaP52B4ViOiaFyu3uUffM8/9oE2XWtnAXSE6H1rTSyklhBaL42hkjUxD2aH/qcIAi
        z6KeshfZrxaDPK4Qcxdc/isjIwG2rcI0zq1hZW4iLqb0PHCWlC0cSC3hmwq4eJp7P5GhTI
        21rI/1na7U4CujdOB1PFOU6YYm+E6gbYix64diFNy1ST5jYfK5xJqDdjGMDMH5Ex1yxQJu
        r0oUTxOi4k6qaHKvvlhgnozDVVPrbZ6B2ZvxOkejt28fPxWxQr80VLPKWIbPq35ElEx5C0
        gm/7tqjeW5DPrhxg9XdfYfBBWQlhnTwtwHQbVsFEr+GVGdVlxJauwyaXzlCslQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686003453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YI5W3YjQ1K9oa7fcUmMupvk4A5HHThGVA4WIB5FmNV0=;
        b=Bqb3Q7rwPOQCjzUcAzuyMddvCa6blC0rRLS+4ig6G88GfBcJJaTMGd8LpssNSJsBc9jFCG
        wkYoPEjWqVyjmdBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Polish coding style in a few places
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.888493625@linutronix.de>
References: <20230425183313.888493625@linutronix.de>
MIME-Version: 1.0
Message-ID: <168600345197.404.4874809035786394442.tip-bot2@tip-bot2>
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

Commit-ID:     6fbe3a3b4fa1fe5cf05f91193d81d930c6820eda
Gitweb:        https://git.kernel.org/tip/6fbe3a3b4fa1fe5cf05f91193d81d930c6820eda
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Jun 2023 00:12:55 +02:00

posix-timers: Polish coding style in a few places

Make it consistent with the TIP tree documentation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.888493625@linutronix.de

---
 kernel/time/posix-timers.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bdd718c..8bb0dcf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -309,10 +309,10 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int si_private = 0;
-	enum hrtimer_restart ret = HRTIMER_NORESTART;
 
 	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
@@ -400,8 +400,8 @@ static struct pid *good_sigevent(sigevent_t * event)
 
 static struct k_itimer * alloc_posix_timer(void)
 {
-	struct k_itimer *tmr;
-	tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+
 	if (!tmr)
 		return tmr;
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
@@ -695,8 +695,8 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	struct k_itimer *timr;
 	const struct k_clock *kc;
+	struct k_itimer *timr;
 	unsigned long flags;
 	int ret = 0;
 
@@ -767,8 +767,8 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
 	struct k_itimer *timr;
-	int overrun;
 	unsigned long flags;
+	int overrun;
 
 	timr = lock_timer(timer_id, &flags);
 	if (!timr)
@@ -941,8 +941,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 		const struct __kernel_itimerspec __user *, new_setting,
 		struct __kernel_itimerspec __user *, old_setting)
 {
-	struct itimerspec64 new_spec, old_spec;
-	struct itimerspec64 *rtn = old_setting ? &old_spec : NULL;
+	struct itimerspec64 new_spec, old_spec, *rtn;
 	int error = 0;
 
 	if (!new_setting)
@@ -951,6 +950,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 	if (get_itimerspec64(&new_spec, new_setting))
 		return -EFAULT;
 
+	rtn = old_setting ? &old_spec : NULL;
 	error = do_timer_settime(timer_id, flags, &new_spec, rtn);
 	if (!error && old_setting) {
 		if (put_itimerspec64(&old_spec, old_setting))
