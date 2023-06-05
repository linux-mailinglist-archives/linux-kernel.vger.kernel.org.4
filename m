Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC90722A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjFEPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjFEPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD204EA;
        Mon,  5 Jun 2023 08:08:26 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8OW7mNLB3v0H4YFi6rliOeKhkABoAx15A5MO4MS50I=;
        b=E0xqgxC2VTZvipboSYI7RTh8oNURjcetGVs3OHTp6pELrxPJg5+UUsRjW9A453HYTN6wed
        Ba0h4rK7ftrGl73ObYCaV7S/n7aQxtNdKyDq8B2u848UilnF4RSfPzIyjcYVs75ncECfLF
        NWVyaS6OsxokwB/UZn11pF6v3o4G8kFRYXAOgL/p1/VmRaK6UeCu3LtT8EHucVibsOXWc9
        wAtIZRRrdj9p2bu+UP9OqA0qUHocTHs6GA0MfP0zy4kBxmkKX9N12gpvzFMLgpDIjLrUev
        wOCnjoVVUNeZK0oyzugeyd5txqlGL/xwukByDnQROhVcJxOyuMqk4Q5rN2gN8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8OW7mNLB3v0H4YFi6rliOeKhkABoAx15A5MO4MS50I=;
        b=Yjy2j4uy/w0xJYi1KC2hF6T32einOMYvyMef/djO0OYvzzLfcHMTy6qNcwDbUuZ3U3W+vP
        5W1zb0l4QnPDolDQ==
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
Message-ID: <168597770464.404.17603246020123754187.tip-bot2@tip-bot2>
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

Commit-ID:     1263a2a9d71bac5ffabf9603c36e36cb6edbcdcf
Gitweb:        https://git.kernel.org/tip/1263a2a9d71bac5ffabf9603c36e36cb6edbcdcf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:39 +02:00

posix-timers: Polish coding style in a few places

Make it consistent with the TIP tree documentation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.888493625@linutronix.de

---
 kernel/time/posix-timers.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fde1ca9..276f231 100644
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
