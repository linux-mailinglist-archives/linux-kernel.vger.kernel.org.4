Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591816349DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiKVWMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiKVWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:11:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABFCB94C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=c710bfHCVJLxj5VRun6yMEpv6AIVKSZUeU8J8j9vHJE=; b=tcIo96U5PSpo8+HgUC5u6ChUru
        j2dW6wDEcaYKlRhwaIuwVuBSFo7RG8UF2t32MkFQEvUcpfM3HFttg01XV5DgqJRcqjhplVbA10tqg
        DZflCXU1Wn6rq86FHgiaIavPyFgH4HCcRk64kESUrB761Au54YPgSUnpr+1H5NNGxXrM0/mnEfnXL
        eYTkJAaxf2Vq6s1MK93hx8GktiuPjkaR7Cwg8sgBWmJD7mh0mu2JGynDFLLsDyikoo4NNXTULA/MY
        5oV/pVDtTQUYwwfe/1M/Y0MKm1JyBfz9mzHxYXmVJXUCoiN1vBYJSV2EvZcryBba4Fgzu+3CPj6EN
        XrAgnhag==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxbUH-00C6G5-0L; Tue, 22 Nov 2022 22:11:29 +0000
Message-ID: <b112a4d6-b70d-52d7-8543-8f0aac506b03@infradead.org>
Date:   Tue, 22 Nov 2022 14:11:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int [-Werror,-Wimplicit-int]
Content-Language: en-US
To:     paulmck@kernel.org, Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de> <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/22 14:00, Paul E. McKenney wrote:
> On Tue, Nov 22, 2022 at 04:55:26PM +0100, Petr Mladek wrote:
>> On Tue 2022-11-22 16:33:39, John Ogness wrote:
>>> On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>>> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?
>>>>
>>>> The people wanting it separate back in the day were those wanting very
>>>> tiny kernels.  I have not heard from them in a long time, so maybe it
>>>> is now OK to just make SRCU unconditional.
>>>
>>> Who decides this? Or maybe I should create a semaphore-based Variant of
>>> console_srcu_read_lock()/console_srcu_read_unlock() for the
>>> "!CONFIG_PRINTK && !CONFIG_SRCU" case?
>>
>> I would prefer to avoid it. It would require keeping this in mind.
>> Semaphore behaves very differently than srcu_read_lock (deadlocks,
>> nesting).
>>
>> I am not sure how much the tiny SRCU would increase the size of
>> the kernel. I doubt that it would be more that what printk()
>> added by the various per-CPU and per-console buffers.
>>
>> Well, another question is why we actually need to register the consoles
>> at all for !CONFIG_PRINTK. Only reasons come to my mind:
>>
>>    + /dev/console
>>    + preventing double registration/unregistration (initialization)
>>
>> I could imagine to handle these two use-cases a special way
>> on tiny systems. But I would do it only when anyone complains.
> 
> And here is a first cut.  There will be more patches removing uses
> of CONFIG_SRCU.
> 
> Thoughts?

UML (x86_64 and i386) was also having this build error.
This patch fixes both of those for me.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ------------------------------------------------------------------------
> 
> commit 3721d024963fc35adf92983657dc00edde184d5c
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Nov 22 13:53:57 2022 -0800
> 
>     rcu: Make SRCU mandatory
>     
>     Kernels configured with CONFIG_PRINTK=n and CONFIG_SRCU=n get build
>     failures.  This causes trouble for deep embedded systems.  But given
>     that there are more than 25 instances of "select SRCU" in the kernel,
>     it is hard to believe that there are many kernels running in production
>     without SRCU.  This commit therefore makes SRCU mandatory.  The SRCU
>     Kconfig option remains for backwards compatibility, and will be removed
>     when it is no longer used.
>     
>     Reported-by: John Ogness <john.ogness@linutronix.de>
>     Reported-by: Petr Mladek <pmladek@suse.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index e89d2f7d0f79f..7f17acf29dda7 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -152,11 +152,7 @@ static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  	return false;
>  }
>  static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
> -#ifdef CONFIG_SRCU
>  void rcu_scheduler_starting(void);
> -#else /* #ifndef CONFIG_SRCU */
> -static inline void rcu_scheduler_starting(void) { }
> -#endif /* #else #ifndef CONFIG_SRCU */
>  static inline void rcu_end_inkernel_boot(void) { }
>  static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
>  static inline bool rcu_is_watching(void) { return true; }
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index f0814ffca34bb..7d680ff27505b 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -78,11 +78,7 @@ static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>  }
>  #endif /* CONFIG_NEED_SRCU_NMI_SAFE */
>  
> -#ifdef CONFIG_SRCU
>  void srcu_init(void);
> -#else /* #ifdef CONFIG_SRCU */
> -static inline void srcu_init(void) { }
> -#endif /* #else #ifdef CONFIG_SRCU */
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 05106e6fbd0ed..ab62074174c32 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -54,21 +54,17 @@ config RCU_EXPERT
>  	  Say N if you are unsure.
>  
>  config SRCU
> -	bool
> -	help
> -	  This option selects the sleepable version of RCU. This version
> -	  permits arbitrary sleeping or blocking within RCU read-side critical
> -	  sections.
> +	def_bool y
>  
>  config TINY_SRCU
>  	bool
> -	default y if SRCU && TINY_RCU
> +	default y if TINY_RCU
>  	help
>  	  This option selects the single-CPU non-preemptible version of SRCU.
>  
>  config TREE_SRCU
>  	bool
> -	default y if SRCU && !TINY_RCU
> +	default y if !TINY_RCU
>  	help
>  	  This option selects the full-fledged version of SRCU.
>  
> @@ -77,7 +73,6 @@ config NEED_SRCU_NMI_SAFE
>  
>  config TASKS_RCU_GENERIC
>  	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
> -	select SRCU
>  	help
>  	  This option enables generic infrastructure code supporting
>  	  task-based RCU implementations.  Not for manual selection.
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index ea654fdae9a06..49da904df6aa6 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -27,7 +27,6 @@ config RCU_SCALE_TEST
>  	tristate "performance tests for RCU"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> -	select SRCU
>  	default n
>  	help
>  	  This option provides a kernel module that runs performance
> @@ -43,7 +42,6 @@ config RCU_TORTURE_TEST
>  	tristate "torture tests for RCU"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> -	select SRCU
>  	default n
>  	help
>  	  This option provides a kernel module that runs torture tests
> @@ -59,7 +57,6 @@ config RCU_REF_SCALE_TEST
>  	tristate "Scalability tests for read-side synchronization (RCU and others)"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> -	select SRCU
>  	default n
>  	help
>  	  This option provides a kernel module that runs performance tests
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 70c79adfdc704..886e6b0943ab8 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -287,7 +287,7 @@ void rcu_test_sync_prims(void);
>   */
>  extern void resched_cpu(int cpu);
>  
> -#if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU)
> +#if !defined(CONFIG_TINY_RCU)
>  
>  #include <linux/rcu_node_tree.h>
>  
> @@ -438,7 +438,7 @@ do {									\
>  #define raw_lockdep_assert_held_rcu_node(p)				\
>  	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
>  
> -#endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
> +#endif /* !defined(CONFIG_TINY_RCU) */
>  
>  #ifdef CONFIG_TINY_RCU
>  /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 76f9848a21cd5..7b1e183b0eb23 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -224,7 +224,7 @@ void rcu_test_sync_prims(void)
>  	synchronize_rcu_expedited();
>  }
>  
> -#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU)
> +#if !defined(CONFIG_TINY_RCU)
>  
>  /*
>   * Switch to run-time mode once RCU has fully initialized.
> @@ -239,7 +239,7 @@ static int __init rcu_set_runtime_mode(void)
>  }
>  core_initcall(rcu_set_runtime_mode);
>  
> -#endif /* #if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU) */
> +#endif /* #if !defined(CONFIG_TINY_RCU) */
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  static struct lock_class_key rcu_lock_key;
> @@ -561,10 +561,8 @@ static void early_boot_test_call_rcu(void)
>  	struct early_boot_kfree_rcu *rhp;
>  
>  	call_rcu(&head, test_callback);
> -	if (IS_ENABLED(CONFIG_SRCU)) {
> -		early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
> -		call_srcu(&early_srcu, &shead, test_callback);
> -	}
> +	early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
> +	call_srcu(&early_srcu, &shead, test_callback);
>  	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>  	if (!WARN_ON_ONCE(!rhp))
>  		kfree_rcu(rhp, rh);
> @@ -587,12 +585,10 @@ static int rcu_verify_early_boot_tests(void)
>  	if (rcu_self_test) {
>  		early_boot_test_counter++;
>  		rcu_barrier();
> -		if (IS_ENABLED(CONFIG_SRCU)) {
> -			early_boot_test_counter++;
> -			srcu_barrier(&early_srcu);
> -			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
> -			cleanup_srcu_struct(&early_srcu);
> -		}
> +		early_boot_test_counter++;
> +		srcu_barrier(&early_srcu);
> +		WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
> +		cleanup_srcu_struct(&early_srcu);
>  	}
>  	if (rcu_self_test_counter != early_boot_test_counter) {
>  		WARN_ON(1);

-- 
~Randy
