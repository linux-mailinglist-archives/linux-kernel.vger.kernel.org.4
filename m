Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348DE69A509
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBQFYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQFYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:24:44 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB85B751
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:24:42 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t16so1901700qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp0sDaGiaTYadbEh+nJMezShCNhNGSevRvqTglEj8Og=;
        b=JzzfErXlB6Np+R5CR7+ExzXKeZDcp99sx5p2oYYo8XZxolL22VOg4JnyshVPL9lNYN
         73j0j6LxrvZb/xiSmHzJSp7StefXRGNRF9bmWHIhCccPl8F5DvQobXREdsJ3VuHg8LK4
         IYl66TL+Rw4GBw9ia0rYbue2LDEtOhEbHenBUMJ3VDVrwkB14IgtZOiGVS1CeWjyKhKJ
         5GyI5yGX8ZBjNEKmbh03PeSdUWZutEoKcEXFpKfHuLmoMl8mdqtRAxz/cN/iQAYc3TK/
         GUjog8mO7jXb1i60xjqPQSzilWJ4yTeMex6+pfmY6XMB1uBuO+ejprG0ypSV9iq6NT4Q
         nkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp0sDaGiaTYadbEh+nJMezShCNhNGSevRvqTglEj8Og=;
        b=RzM6++K645UE5AVbEYwlTUMUIdVHUltZaFVzAUrPr4RB7gN/uVkAwwjtgVG45yLWOI
         XGoFbU0HjbVPRRD3zWaCIBFqeJss5Wrrk3793jD9AMi33kLto/dfe43C+MIOToInFR8M
         Wn1iS69aR8rDEHg0LMhq5P+k5kE1b+9gfKKM015MIYDQAZRVQbv/Ut+n34PAJee0lKgs
         OMRmCrNkvojI3VqelFhtWrpv+HFoSeuxdREtRJGMgTNT1wUeheGaahnZSZwyVlJJE7LE
         a0GNGP84mcqEiiCgzXaAuiQI7CqNQ7yZOZ19gE19q8H/sXZGasErKqeg4mnDb91EzhEf
         rEhg==
X-Gm-Message-State: AO0yUKXZbCKweCMJQHlb8UU67IeM/PmHGWKa0x+LZG6mEdNsqYJJxkwo
        t31DpVKxDG1VjF4n0ONwvZc=
X-Google-Smtp-Source: AK7set+kqE00dfO98Gqd6ThOnTYcqSPez11sxIfCbNCjogP91pNJr/MmDGybXuAZNRQz85nIb5rkaA==
X-Received: by 2002:a05:622a:1653:b0:3b8:6c80:c113 with SMTP id y19-20020a05622a165300b003b86c80c113mr187426qtj.66.1676611481825;
        Thu, 16 Feb 2023 21:24:41 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k14-20020ac8604e000000b003b63dfad2b4sm2641677qtm.0.2023.02.16.21.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 21:24:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 99CEB27C0054;
        Fri, 17 Feb 2023 00:24:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 17 Feb 2023 00:24:40 -0500
X-ME-Sender: <xms:lw_vY7Df1vetQOkFn2A47UxGNl06mW3ij51jysAfts_1ODC4eDI73A>
    <xme:lw_vYxh6q7GWpHTad-YCrsSwCcFp16ta4qH2E-hCqWKYif5jf_jDRF_h4TFM6SF4n
    0udrVOCxkvbSh2PtQ>
X-ME-Received: <xmr:lw_vY2nkNAtdA8uvQkAaVvmSQSkvwbiQBOIqIxtODMYKRobAsQoVM5TpzzAUi1QvP32qKRhzwCaDJLCL_rK7pr9PbSJzEq9dego>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeikedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lw_vY9wCay5ZPLu9k5qxJqqeSQKhpBNP-NQxSUaQMR3LYEr-nZ-Opg>
    <xmx:lw_vYwSkNY-WFEPi9ggTs5joUz-MNY7auQEZa2xB0nN79_aJY8vO0g>
    <xmx:lw_vYwYKyVdI4d_1ift8X8sbRiclMZf-8GVEgXjZqIOS5Pe3CZ_yjg>
    <xmx:lw_vY1K9hY69Pflb0VdlBkqEQc8MVGC32wKoGvSv9C4sIlgjLb5YWw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Feb 2023 00:24:38 -0500 (EST)
Date:   Thu, 16 Feb 2023 21:24:36 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 2/3] locking/rwsem: Enable early rwsem writer lock
 handoff
Message-ID: <Y+8PlCPWDFiFjE8M@Boquns-Mac-mini.local>
References: <20230216210933.1169097-1-longman@redhat.com>
 <20230216210933.1169097-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216210933.1169097-3-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:09:32PM -0500, Waiman Long wrote:
> The lock handoff provided in rwsem isn't a true handoff like that in
> the mutex. Instead, it is more like a quiescent state where optimistic
> spinning and lock stealing are disabled to make it easier for the first
> waiter to acquire the lock.
> 
> For readers, setting the HANDOFF bit will disable writers from stealing
> the lock. The actual handoff is done at rwsem_wake() time after taking
> the wait_lock. There isn't much we need to improve here other than
> setting the RWSEM_NONSPINNABLE bit in owner.
> 
> For writers, setting the HANDOFF bit does not guarantee that it can
> acquire the rwsem successfully in a subsequent rwsem_try_write_lock()
> after setting the bit there. A reader can come in and add a
> RWSEM_READER_BIAS temporarily which can spoil the takeover of the rwsem
> in rwsem_try_write_lock() leading to additional delay.
> 
> For mutex, lock handoff is done at unlock time as the owner value and
> the handoff bit is in the same lock word and can be updated atomically.
> 
> That is the not case for rwsem which has a count value for locking and
> a different owner value for storing lock owner. In addition, the handoff
> processing differs depending on whether the first waiter is a writer or a
> reader. We can only make that waiter type determination after acquiring
> the wait lock. Together with the fact that the RWSEM_FLAG_HANDOFF bit
> is stable while holding the wait_lock, the most convenient place to
> do the early handoff is at rwsem_mark_wake() where wait_lock has to be
> acquired anyway.
> 
> There isn't much additional cost in doing this check and early handoff
> in rwsem_mark_wake() while increasing the chance that a lock handoff
> will be successful when the HANDOFF setting writer wakes up without
> even the need to take the wait_lock at all. Note that if early handoff
> fails to happen in rwsem_mark_wake(), a late handoff can still happen
> when the awoken writer calls rwsem_try_write_lock().
> 
> Kernel test robot noticed a 19.3% improvement of
> will-it-scale.per_thread_ops in an earlier version of this commit [1].
> 
> [1] https://lore.kernel.org/lkml/202302122155.87699b56-oliver.sang@intel.com/
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lock_events_list.h |  1 +
>  kernel/locking/rwsem.c            | 71 +++++++++++++++++++++++++++----
>  2 files changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> index 97fb6f3f840a..fd80f5828f24 100644
> --- a/kernel/locking/lock_events_list.h
> +++ b/kernel/locking/lock_events_list.h
> @@ -67,3 +67,4 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
>  LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
>  LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
>  LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
> +LOCK_EVENT(rwsem_wlock_ehandoff) /* # of write lock early handoffs	*/
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index e589f69793df..fc3961ceabe8 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -412,8 +412,9 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>  			    enum rwsem_wake_type wake_type,
>  			    struct wake_q_head *wake_q)
>  {
> +	long count = atomic_long_read(&sem->count);
>  	struct rwsem_waiter *waiter, *tmp;
> -	long count, woken = 0, adjustment = 0;
> +	long woken = 0, adjustment = 0;
>  	struct list_head wlist;
>  
>  	lockdep_assert_held(&sem->wait_lock);
> @@ -432,19 +433,39 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>  		 * Mark writer at the front of the queue for wakeup.
>  		 * Until the task is actually later awoken later by
>  		 * the caller, other writers are able to steal it.
> +		 *
> +		 * *Unless* HANDOFF is set, in which case only the
> +		 * first waiter is allowed to take it.
> +		 *
>  		 * Readers, on the other hand, will block as they
>  		 * will notice the queued writer.
>  		 */
>  		wake_q_add(wake_q, waiter->task);
>  		lockevent_inc(rwsem_wake_writer);
> +
> +		if ((count & RWSEM_LOCK_MASK) || !(count & RWSEM_FLAG_HANDOFF))
> +			return;
> +
> +		/*
> +		 * If the rwsem is free and handoff flag is set with wait_lock
> +		 * held, no other CPUs can take an active lock. We can do an
> +		 * early handoff.
> +		 */
> +		adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
> +		atomic_long_set(&sem->owner, (long)waiter->task);
> +		waiter->task = NULL;
> +		atomic_long_add(adjustment, &sem->count);
> +		rwsem_del_waiter(sem, waiter);
> +		lockevent_inc(rwsem_wlock_ehandoff);
>  	}
>  	return;
>  
>  wake_readers:
>  	/*
> -	 * No reader wakeup if there are too many of them already.
> +	 * No reader wakeup if there are too many of them already or
> +	 * something wrong happens.
>  	 */
> -	if (unlikely(atomic_long_read(&sem->count) < 0))
> +	if (unlikely(count < 0))
>  		return;
>  
>  	/*
> @@ -468,7 +489,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>  					adjustment -= RWSEM_FLAG_HANDOFF;
>  					lockevent_inc(rwsem_rlock_handoff);
>  				}
> +				/*
> +				 * With HANDOFF set for reader, we must
> +				 * terminate all spinning.
> +				 */
>  				waiter->handoff_set = true;
> +				rwsem_set_nonspinnable(sem);
>  			}
>  
>  			atomic_long_add(-adjustment, &sem->count);
> @@ -610,6 +636,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  
>  	lockdep_assert_held(&sem->wait_lock);
>  
> +	if (!waiter->task) {
> +		/* Write lock handed off */
> +		smp_acquire__after_ctrl_dep();

I don't think you need smp_acquire__after_ctrl_dep() here, since:

*	The other side is just a normal write "waiter->task = NULL"
*	The "&sem->wait_lock" already provides the necessary ACQUIRE

, but I come to this series so late, I may miss something subtle.

> +		return true;
> +	}
> +
>  	count = atomic_long_read(&sem->count);
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> @@ -755,6 +787,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  
>  	owner = rwsem_owner_flags(sem, &flags);
>  	state = rwsem_owner_state(owner, flags);
> +
> +	if (owner == current)
> +		return OWNER_NONSPINNABLE;	/* Handoff granted */
> +
>  	if (state != OWNER_WRITER)
>  		return state;
>  
> @@ -1164,32 +1200,51 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		 * the lock, attempt to spin on owner to accelerate lock
>  		 * transfer. If the previous owner is a on-cpu writer and it
>  		 * has just released the lock, OWNER_NULL will be returned.
> -		 * In this case, we attempt to acquire the lock again
> -		 * without sleeping.
> +		 * In this case, the waker may be in the process of early
> +		 * lock handoff. Use the wait_lock to synchronize with that
> +		 * before checking for handoff.
>  		 */
>  		if (waiter.handoff_set) {
>  			enum owner_state owner_state;
>  
>  			owner_state = rwsem_spin_on_owner(sem);
> -			if (owner_state == OWNER_NULL)
> -				goto trylock_again;
> +			if ((owner_state == OWNER_NULL) &&
> +			    READ_ONCE(waiter.task)) {

In theory, if there is a read outside some synchronization (say locks),
not only READ_ONCE(), but also WRITE_ONCE() is needed (even for write
inside locks), otherwise, KCSAN will yell (if
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n). This is because plain write may get
teared.

Regards,
Boqun

> +				raw_spin_lock_irq(&sem->wait_lock);
> +				raw_spin_unlock_irq(&sem->wait_lock);
> +			}
> +			if (!READ_ONCE(waiter.task))
> +				goto handed_off;
>  		}
>  
>  		schedule_preempt_disabled();
>  		lockevent_inc(rwsem_sleep_writer);
> +		if (!READ_ONCE(waiter.task))
> +			goto handed_off;
> +
>  		set_current_state(state);
> -trylock_again:
>  		raw_spin_lock_irq(&sem->wait_lock);
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	raw_spin_unlock_irq(&sem->wait_lock);
> +out:
>  	lockevent_inc(rwsem_wlock);
>  	trace_contention_end(sem, 0);
>  	return sem;
>  
> +handed_off:
> +	/* Write lock handed off */
> +	set_current_state(TASK_RUNNING);	/* smp_mb() */
> +	goto out;
> +
>  out_nolock:
>  	__set_current_state(TASK_RUNNING);
>  	raw_spin_lock_irq(&sem->wait_lock);
> +	if (!waiter.task) {
> +		smp_acquire__after_ctrl_dep();
> +		raw_spin_unlock_irq(&sem->wait_lock);
> +		goto out;
> +	}
>  	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
>  	lockevent_inc(rwsem_wlock_fail);
>  	trace_contention_end(sem, -EINTR);
> -- 
> 2.31.1
> 
