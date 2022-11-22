Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E76349B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiKVWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiKVWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:00:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE32716E3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4056B81D99
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCABC433D6;
        Tue, 22 Nov 2022 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669154453;
        bh=geDoaciLUjawMSEdzM1GZFYfzU6DwfAcdb+M34ay7Sk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ci1GqW/dDGALtbuaAWWfSOqEW+kqnqvRez2/6QJ9DCHsKSznGTN118yZvwJtf84hk
         RO2MYpeXGGtwt80VzZodqKidW8k5AxCQ1ok6PeVo+ieBD2b6RZETN71Oc+zXxlwGHS
         F5otJpaagmaxX3XbzQTTM3gu8SKPO4yjd9JWuyJKIE5r3/GtwwFt/GRjNDGDuOo6tz
         Mx6jkDlllZjXakFWLoOhcxTf7qUmQPcbbAPcqGfQJdyGyZocAfLuWTw98gwPh/ezYI
         AOttcMpQNmjv76OkT/gO3spe+xn0YCGvzHHOwVSGXm8Qwov3LmW/zXyI9AW7vknqep
         7HwJ2m7BFXCag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F4CE5C0B52; Tue, 22 Nov 2022 14:00:53 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:00:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
 <Y3zw7nv5KJ32P4FG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zw7nv5KJ32P4FG@alley>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:55:26PM +0100, Petr Mladek wrote:
> On Tue 2022-11-22 16:33:39, John Ogness wrote:
> > On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?
> > >
> > > The people wanting it separate back in the day were those wanting very
> > > tiny kernels.  I have not heard from them in a long time, so maybe it
> > > is now OK to just make SRCU unconditional.
> > 
> > Who decides this? Or maybe I should create a semaphore-based Variant of
> > console_srcu_read_lock()/console_srcu_read_unlock() for the
> > "!CONFIG_PRINTK && !CONFIG_SRCU" case?
> 
> I would prefer to avoid it. It would require keeping this in mind.
> Semaphore behaves very differently than srcu_read_lock (deadlocks,
> nesting).
> 
> I am not sure how much the tiny SRCU would increase the size of
> the kernel. I doubt that it would be more that what printk()
> added by the various per-CPU and per-console buffers.
> 
> Well, another question is why we actually need to register the consoles
> at all for !CONFIG_PRINTK. Only reasons come to my mind:
> 
>    + /dev/console
>    + preventing double registration/unregistration (initialization)
> 
> I could imagine to handle these two use-cases a special way
> on tiny systems. But I would do it only when anyone complains.

And here is a first cut.  There will be more patches removing uses
of CONFIG_SRCU.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 3721d024963fc35adf92983657dc00edde184d5c
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Nov 22 13:53:57 2022 -0800

    rcu: Make SRCU mandatory
    
    Kernels configured with CONFIG_PRINTK=n and CONFIG_SRCU=n get build
    failures.  This causes trouble for deep embedded systems.  But given
    that there are more than 25 instances of "select SRCU" in the kernel,
    it is hard to believe that there are many kernels running in production
    without SRCU.  This commit therefore makes SRCU mandatory.  The SRCU
    Kconfig option remains for backwards compatibility, and will be removed
    when it is no longer used.
    
    Reported-by: John Ogness <john.ogness@linutronix.de>
    Reported-by: Petr Mladek <pmladek@suse.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index e89d2f7d0f79f..7f17acf29dda7 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -152,11 +152,7 @@ static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 	return false;
 }
 static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
-#ifdef CONFIG_SRCU
 void rcu_scheduler_starting(void);
-#else /* #ifndef CONFIG_SRCU */
-static inline void rcu_scheduler_starting(void) { }
-#endif /* #else #ifndef CONFIG_SRCU */
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f0814ffca34bb..7d680ff27505b 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -78,11 +78,7 @@ static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 }
 #endif /* CONFIG_NEED_SRCU_NMI_SAFE */
 
-#ifdef CONFIG_SRCU
 void srcu_init(void);
-#else /* #ifdef CONFIG_SRCU */
-static inline void srcu_init(void) { }
-#endif /* #else #ifdef CONFIG_SRCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 05106e6fbd0ed..ab62074174c32 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -54,21 +54,17 @@ config RCU_EXPERT
 	  Say N if you are unsure.
 
 config SRCU
-	bool
-	help
-	  This option selects the sleepable version of RCU. This version
-	  permits arbitrary sleeping or blocking within RCU read-side critical
-	  sections.
+	def_bool y
 
 config TINY_SRCU
 	bool
-	default y if SRCU && TINY_RCU
+	default y if TINY_RCU
 	help
 	  This option selects the single-CPU non-preemptible version of SRCU.
 
 config TREE_SRCU
 	bool
-	default y if SRCU && !TINY_RCU
+	default y if !TINY_RCU
 	help
 	  This option selects the full-fledged version of SRCU.
 
@@ -77,7 +73,6 @@ config NEED_SRCU_NMI_SAFE
 
 config TASKS_RCU_GENERIC
 	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
-	select SRCU
 	help
 	  This option enables generic infrastructure code supporting
 	  task-based RCU implementations.  Not for manual selection.
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index ea654fdae9a06..49da904df6aa6 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -27,7 +27,6 @@ config RCU_SCALE_TEST
 	tristate "performance tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
-	select SRCU
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -43,7 +42,6 @@ config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
-	select SRCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
@@ -59,7 +57,6 @@ config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
-	select SRCU
 	default n
 	help
 	  This option provides a kernel module that runs performance tests
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 70c79adfdc704..886e6b0943ab8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -287,7 +287,7 @@ void rcu_test_sync_prims(void);
  */
 extern void resched_cpu(int cpu);
 
-#if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU)
+#if !defined(CONFIG_TINY_RCU)
 
 #include <linux/rcu_node_tree.h>
 
@@ -438,7 +438,7 @@ do {									\
 #define raw_lockdep_assert_held_rcu_node(p)				\
 	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
 
-#endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
+#endif /* !defined(CONFIG_TINY_RCU) */
 
 #ifdef CONFIG_TINY_RCU
 /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 76f9848a21cd5..7b1e183b0eb23 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -224,7 +224,7 @@ void rcu_test_sync_prims(void)
 	synchronize_rcu_expedited();
 }
 
-#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU)
+#if !defined(CONFIG_TINY_RCU)
 
 /*
  * Switch to run-time mode once RCU has fully initialized.
@@ -239,7 +239,7 @@ static int __init rcu_set_runtime_mode(void)
 }
 core_initcall(rcu_set_runtime_mode);
 
-#endif /* #if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU) */
+#endif /* #if !defined(CONFIG_TINY_RCU) */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key rcu_lock_key;
@@ -561,10 +561,8 @@ static void early_boot_test_call_rcu(void)
 	struct early_boot_kfree_rcu *rhp;
 
 	call_rcu(&head, test_callback);
-	if (IS_ENABLED(CONFIG_SRCU)) {
-		early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
-		call_srcu(&early_srcu, &shead, test_callback);
-	}
+	early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
+	call_srcu(&early_srcu, &shead, test_callback);
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 	if (!WARN_ON_ONCE(!rhp))
 		kfree_rcu(rhp, rh);
@@ -587,12 +585,10 @@ static int rcu_verify_early_boot_tests(void)
 	if (rcu_self_test) {
 		early_boot_test_counter++;
 		rcu_barrier();
-		if (IS_ENABLED(CONFIG_SRCU)) {
-			early_boot_test_counter++;
-			srcu_barrier(&early_srcu);
-			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
-			cleanup_srcu_struct(&early_srcu);
-		}
+		early_boot_test_counter++;
+		srcu_barrier(&early_srcu);
+		WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
+		cleanup_srcu_struct(&early_srcu);
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
 		WARN_ON(1);
