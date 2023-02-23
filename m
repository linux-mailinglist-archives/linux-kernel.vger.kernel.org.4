Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA06A1094
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjBWTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBWTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:32:13 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DFA59E50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:32:12 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ne1so11987412qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsd5iGrbEszrkMrjuzdea1yZD9Nul4l0D1c1At7ffEw=;
        b=Z01rQvpqc1CObYBoVlZn1kNkpjMTP0dTcDuUJIsMdIViovGozHTKGPDAtryR1zD0GV
         RHVBBthXfoGbAaKROn7MuuS7/bshlLmFm7tHKdHUlOawztoe5W6OhbCmgUvXD59hhQSA
         nDwh+vfnewDHE8mV3HEOa8K5kajZeVCSfCEYawgj/klOY9ypXqWSJsHBtmRORddJ4cHi
         xkvjh0lJ6rucVXoq+nX4YcYqzOrNd1gKjkYqq9Ea44iv/dXJCwmRSDgpybbqBpe4eX71
         Ck5PB3oOwsWDFhRJbYOXJL1YE/+0m7qB18f6xzbbkA/IVkboSTFq9nFnLdqKjPojLl+v
         AClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsd5iGrbEszrkMrjuzdea1yZD9Nul4l0D1c1At7ffEw=;
        b=08U3/uZAlLA7hGgEPUoCWOBBSsfQwHpxKKM2Lq0Wwbw8ojUirmlBD5IBFaATsaMtSL
         MJaH3x0YFPbDYJgiOTahVyuqx5cEOfjbFSBYnXswOaJKJHgVn2O/n0UMI66vlpzBqGOq
         DQRVdmFl+6BuA7GpRSr0spvnqTFSiLe7n3fnSJ9BWa+zoaz0pFbpE3lC0NvlvsY5JUli
         mP8CHerLNeYyllLqTeUSlG4BYBfPQy4Ebmr3hLF0xUVh0Ez8ieGdFpjRbU07a9RJo+Vf
         kiy22riu8qmxoiDRYPe8qVpCoEGLQPQwwcJ+l6HmHv6BBz+3hseAeUCG7k1nCqV+54tw
         +A8g==
X-Gm-Message-State: AO0yUKV/9fw6WRKy77G54Zkvry2MrTr854EwL/lmmL+88LuPRvc4J2C5
        aB8DxsBvJ/Upkfa4UzpDSJU=
X-Google-Smtp-Source: AK7set/b0gGpZkkaGWCy5I5j2ze6EflsyrOUmUWOjL/o9ifBU0bGgmjGKok1PBbekSOUUrhVU7i2hw==
X-Received: by 2002:a05:6214:2268:b0:538:a431:862e with SMTP id gs8-20020a056214226800b00538a431862emr28166772qvb.19.1677180731493;
        Thu, 23 Feb 2023 11:32:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 12-20020a37070c000000b007416c11ea03sm6035029qkh.26.2023.02.23.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:32:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4C7BC27C0054;
        Thu, 23 Feb 2023 14:32:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Feb 2023 14:32:10 -0500
X-ME-Sender: <xms:Ob_3YwUjWZeyZHt7goRl8TPmt2msSbsT_7-j_pEQq1v8FgJc66GYpQ>
    <xme:Ob_3Y0mD_GzzA9-C1RadQ2ebPvBEdDUzsXhGoSi-v6dc-wVRR4KQdNnCHPcKCfju6
    8y-VRKklP8vRS2A_g>
X-ME-Received: <xmr:Ob_3Y0bUI5KlWRPCIUV9CAV-YFwm4R-xfCDiJJrQPx8KTvLokym2830XwrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ob_3Y_WxYxPFd_HmkWdklZhKjjiiRTkk8Ra5n09E6YrId4kSWSULXA>
    <xmx:Ob_3Y6mndJP7k5QrmVTOwdrYicDNtiUDiuZKHlhTfiAYvmisQpWf4g>
    <xmx:Ob_3Y0fV_zUA0WGi11smkkHfzXxZRYttVgzggG0Kr8-AaK8YDG-tFw>
    <xmx:Ob_3Y7DwpqyK9jsmSv2vbQpMSSlP8fMhSponA-qQgSOb7ddy_b9F7A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 14:32:09 -0500 (EST)
Date:   Thu, 23 Feb 2023 11:31:47 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     longman@redhat.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] locking/rwsem: Unify wait loop
Message-ID: <Y/e/I1aqDAjoq2Rs@boqun-archlinux>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.608133045@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223123319.608133045@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 01:26:47PM +0100, Peter Zijlstra wrote:
> Now that the reader and writer wait loops are identical, share the
> code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/rwsem.c |  117 +++++++++++++++++++------------------------------
>  1 file changed, 47 insertions(+), 70 deletions(-)
> 
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -650,13 +650,11 @@ static void rwsem_mark_wake(struct rw_se
>   * optionally wake up waiters before it returns.
>   */
>  static inline void
> -rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
> -		      struct wake_q_head *wake_q)
> +rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
>  		      __releases(&sem->wait_lock)
>  {
>  	bool first = rwsem_first_waiter(sem) == waiter;
> -
> -	wake_q_init(wake_q);
> +	DEFINE_WAKE_Q(wake_q);
>  
>  	/*
>  	 * If the wait_list isn't empty and the waiter to be deleted is
> @@ -664,10 +662,10 @@ rwsem_del_wake_waiter(struct rw_semaphor
>  	 * be eligible to acquire or spin on the lock.
>  	 */
>  	if (rwsem_del_waiter(sem, waiter) && first)
> -		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
> +		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>  	raw_spin_unlock_irq(&sem->wait_lock);
> -	if (!wake_q_empty(wake_q))
> -		wake_up_q(wake_q);
> +	if (!wake_q_empty(&wake_q))
> +		wake_up_q(&wake_q);
>  }
>  
>  /*
> @@ -993,6 +991,46 @@ static inline void rwsem_cond_wake_waite
>  	rwsem_mark_wake(sem, wake_type, wake_q);
>  }
>  
> +#define waiter_type(_waiter, _r, _w)	\
> +	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
> +
> +static __always_inline struct rw_semaphore *
> +rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
> +{
> +	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
> +
> +	/* wait to be given the lock */
> +	for (;;) {
> +		set_current_state(state);
> +		if (!smp_load_acquire(&waiter->task)) {
> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> +			break;
> +		}
> +		if (signal_pending_state(state, current)) {
> +			raw_spin_lock_irq(&sem->wait_lock);

Move the below __set_current_state(TASK_RUNNING)s up here? I think we
need the preemption protection when changing the task state here.

> +			if (waiter->task)
> +				goto out_nolock;

I originally wanted to suggest renaming the label to "out_locked", but I
think we can just move the labeled code up here? And even open-code
rwsem_del_wake_waiter() since it only has one usage.


Regards,
Boqun

> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> +			break;
> +		}
> +		schedule_preempt_disabled();
> +		lockevent_inc(waiter_type(waiter, rwsem_sleep_reader, rwsem_sleep_writer));
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +	lockevent_inc(waiter_type(waiter, rwsem_rlock, rwsem_wlock));
> +	trace_contention_end(sem, 0);
> +	return sem;
> +
> +out_nolock:
> +	rwsem_del_wake_waiter(sem, waiter);
> +	__set_current_state(TASK_RUNNING);
> +	lockevent_inc(waiter_type(waiter, rwsem_rlock_fail, rwsem_wlock_fail));
> +	trace_contention_end(sem, -EINTR);
> +	return ERR_PTR(-EINTR);
> +}
> +
>  /*
>   * Wait for the read lock to be granted
>   */
> @@ -1071,38 +1109,7 @@ rwsem_down_read_slowpath(struct rw_semap
>  	if (!wake_q_empty(&wake_q))
>  		wake_up_q(&wake_q);
>  
> -	trace_contention_begin(sem, LCB_F_READ);
> -
> -	/* wait to be given the lock */
> -	for (;;) {
> -		set_current_state(state);
> -		if (!smp_load_acquire(&waiter.task)) {
> -			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> -			break;
> -		}
> -		if (signal_pending_state(state, current)) {
> -			raw_spin_lock_irq(&sem->wait_lock);
> -			if (waiter.task)
> -				goto out_nolock;
> -			raw_spin_unlock_irq(&sem->wait_lock);
> -			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> -			break;
> -		}
> -		schedule_preempt_disabled();
> -		lockevent_inc(rwsem_sleep_reader);
> -	}
> -
> -	__set_current_state(TASK_RUNNING);
> -	lockevent_inc(rwsem_rlock);
> -	trace_contention_end(sem, 0);
> -	return sem;
> -
> -out_nolock:
> -	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> -	__set_current_state(TASK_RUNNING);
> -	lockevent_inc(rwsem_rlock_fail);
> -	trace_contention_end(sem, -EINTR);
> -	return ERR_PTR(-EINTR);
> +	return rwsem_waiter_wait(sem, &waiter, state);
>  }
>  
>  /*
> @@ -1150,37 +1157,7 @@ rwsem_down_write_slowpath(struct rw_sema
>  	}
>  	raw_spin_unlock_irq(&sem->wait_lock);
>  
> -	/* wait until we successfully acquire the lock */
> -	trace_contention_begin(sem, LCB_F_WRITE);
> -
> -	for (;;) {
> -		set_current_state(state);
> -		if (!smp_load_acquire(&waiter.task)) {
> -			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> -			break;
> -		}
> -		if (signal_pending_state(state, current)) {
> -			raw_spin_lock_irq(&sem->wait_lock);
> -			if (waiter.task)
> -				goto out_nolock;
> -			raw_spin_unlock_irq(&sem->wait_lock);
> -			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> -			break;
> -		}
> -		schedule_preempt_disabled();
> -		lockevent_inc(rwsem_sleep_writer);
> -	}
> -	__set_current_state(TASK_RUNNING);
> -	lockevent_inc(rwsem_wlock);
> -	trace_contention_end(sem, 0);
> -	return sem;
> -
> -out_nolock:
> -	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> -	__set_current_state(TASK_RUNNING);
> -	lockevent_inc(rwsem_wlock_fail);
> -	trace_contention_end(sem, -EINTR);
> -	return ERR_PTR(-EINTR);
> +	return rwsem_waiter_wait(sem, &waiter, state);
>  }
>  
>  /*
> 
> 
