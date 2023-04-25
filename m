Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1790F6EE7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjDYSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:50:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A218E89
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:29 -0700 (PDT)
Message-ID: <20230425183313.888493625@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lI8eS5ZquZQ/AMFm1A5eHZZeDCd9KNgXFYHgrZ2R29Q=;
        b=j2EKBJZ5X7e1Nm5GIqHiop5hf9MbIyUvk9Kdrbd7zpz+e11Vytn077EGh4KEgxK5BwF5MA
        IRFft7VHcxvu05IszyA855/hOG2Vbm4NkJoc5hLHK35V7nYw25a2cznxLDFLGPEH1s1Atl
        qdXXGx2JR0OTA5h1MSc8PGnDES7sxYi/5DUKxW+JJLRn2JRAhy3A+x+BPH5oa37Z4ZE2ex
        pUO2jgJnSnh26UIWaidPZzx487JTIU/DNsqZBrFtkO2Sr5kxfY6gywLIHYliUkreWh4cY8
        fzgCKz+O5gG1HVrVWC4eco+I+S/SJFtIhXkkH1OkCkWodQ9Xf5XR3JDnkDpCfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lI8eS5ZquZQ/AMFm1A5eHZZeDCd9KNgXFYHgrZ2R29Q=;
        b=7gRrfeT744csD7sjDoLvP27jRI8wBPWscgtEWH+bQuW3x6z1k+0DfBSnhm0DT3ctK8zMv/
        +/OvEIcJ9j1gTcAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 20/20] posix-timers: Polish coding style in a few places
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it consistent with the TIP tree documentation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -308,10 +308,10 @@ int posix_timer_event(struct k_itimer *t
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
@@ -395,8 +395,8 @@ static struct pid *good_sigevent(sigeven
 
 static struct k_itimer * alloc_posix_timer(void)
 {
-	struct k_itimer *tmr;
-	tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+
 	if (!tmr)
 		return tmr;
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
@@ -690,8 +690,8 @@ void common_timer_get(struct k_itimer *t
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	struct k_itimer *timr;
 	const struct k_clock *kc;
+	struct k_itimer *timr;
 	unsigned long flags;
 	int ret = 0;
 
@@ -762,8 +762,8 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
 	struct k_itimer *timr;
-	int overrun;
 	unsigned long flags;
+	int overrun;
 
 	timr = lock_timer(timer_id, &flags);
 	if (!timr)
@@ -936,8 +936,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t,
 		const struct __kernel_itimerspec __user *, new_setting,
 		struct __kernel_itimerspec __user *, old_setting)
 {
-	struct itimerspec64 new_spec, old_spec;
-	struct itimerspec64 *rtn = old_setting ? &old_spec : NULL;
+	struct itimerspec64 new_spec, old_spec, *rtn;
 	int error = 0;
 
 	if (!new_setting)
@@ -946,6 +945,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t,
 	if (get_itimerspec64(&new_spec, new_setting))
 		return -EFAULT;
 
+	rtn = old_setting ? &old_spec : NULL;
 	error = do_timer_settime(timer_id, flags, &new_spec, rtn);
 	if (!error && old_setting) {
 		if (put_itimerspec64(&old_spec, old_setting))

