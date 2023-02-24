Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576E6A14A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBXBem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBXBek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:34:40 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB0580E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:34:18 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h16so13076242qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ncCV+PVAJVMNXuMPGVnWa4vUqdu5p4hyabzhLxYsS0=;
        b=Pqoj0fMdntvd3HyeSKNrs4eEPMqjg0GgSPcDYnpscZ+DydKHXkHnnff5zr2vxKhake
         Q0anxwiASBo9ViORwp9tSgr3w7N86dNyfzDYskdSENQw15LUBUsVkkw0V0wKjnmGNq9d
         ztSZOTCc75msh443Q+EBsOpYX8EMX9korxORvOXWL2+4u/4BYlPL57G1Hz6e7cOwSfbN
         WlNk/UhjkD8OiTo0JU3YgMeVMov9V/bqB1yMa64PI8Wj20+zGdKXfppLow602brBdepz
         wgFphQrUX1mBwlYqhOTnVqzj7fl22PHzadk9/+uSNcdt8JglAofmHZIRhyqGyMHF/phZ
         9IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ncCV+PVAJVMNXuMPGVnWa4vUqdu5p4hyabzhLxYsS0=;
        b=LK5Y9PsO1Re5m/c2W/qQk+oODSzbZKHbXMuDMv8N61xcWHftMeP60ykP26f/GxriC9
         nUlODLwUNKkWLKpvCoq69bxqi38ZLV8bP8BnPEWnN/2OfLVK095wSmKrVznj2CrtIgI8
         1haQo0m1QjTMvuM5mO8xx1xt2NEcnHQYhnFvEMEH1UEjfhZNzNQtjm7OZzzItwUyb+yZ
         AOujNdEPGdst02tNR0fBSt+zV9J3IDZGDMKtaJygOQCgMr0TPf1m6gcPqQfGidGEWT2Z
         lkhpCwtWBjOqDsW24TF5htzEMl3S0G/I9byT+YyUzcVYRL/fd13lRGtjjZoCWyMp5xT4
         doxA==
X-Gm-Message-State: AO0yUKUUWQ3uYJbs1RcECGz4VH7wr3ey31Rqv3zlVOv4Ja60ZXZH2BXn
        Upc+4TCm6LEVrx5Vpb6puTU=
X-Google-Smtp-Source: AK7set+DPkodySWkBRYbUjgXrd4TxuLeM2E8CG6OYQO/dSNs4K0kZR4E7bbu00dTGt4KCJNpXluPRw==
X-Received: by 2002:ac8:5f96:0:b0:3bb:7677:2cb8 with SMTP id j22-20020ac85f96000000b003bb76772cb8mr12373177qta.33.1677202457354;
        Thu, 23 Feb 2023 17:34:17 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m16-20020ac866d0000000b003b835e7e283sm5516895qtp.44.2023.02.23.17.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 17:34:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 78D9127C0054;
        Thu, 23 Feb 2023 20:34:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Feb 2023 20:34:16 -0500
X-ME-Sender: <xms:GBT4Yz8oZnVawbCc4qLJOXffCzZYNY_iZ8btNRYDfJ4SAYmlnbJhWQ>
    <xme:GBT4Y_vYscg0nMfzXyy3WnAr1WGvk82CEROrS4tgsuqSA-F_6owaGHpP4k4_TXrtr
    QKbPiL-AlKpeyQENw>
X-ME-Received: <xmr:GBT4YxA9b-VtLJFPnm1ahbgTAKqASAJozKSufytdhGURTVwfJutQtwb5iHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekvddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:GBT4Y_fL3BBk2hwoB4Rw8Eufi_dzKMa7yB9m0Svu4YImzW9fj4VitA>
    <xmx:GBT4Y4OGOgM1cpa29K2c7ps_AELM84h5D4ClxyyettWFMyieH0MuIw>
    <xmx:GBT4YxmUbxDbfSTwrZ68tc2o4sA_97jiEH7ah2kweKOjxgpV75L3NA>
    <xmx:GBT4Y1ofav_nT_FZ0Oz901wMnnenQ1YAD6YJkZ1etYkcfOdnDOLa6w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 20:34:15 -0500 (EST)
Date:   Thu, 23 Feb 2023 17:33:53 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     longman@redhat.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] locking/rwsem: Unify wait loop
Message-ID: <Y/gUAdaFf20PDUkO@boqun-archlinux>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.608133045@infradead.org>
 <Y/e/I1aqDAjoq2Rs@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/e/I1aqDAjoq2Rs@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 11:31:47AM -0800, Boqun Feng wrote:
[..]
> > +#define waiter_type(_waiter, _r, _w)	\
> > +	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
> > +
> > +static __always_inline struct rw_semaphore *
> > +rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
> > +{
> > +	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
> > +
> > +	/* wait to be given the lock */
> > +	for (;;) {
> > +		set_current_state(state);
> > +		if (!smp_load_acquire(&waiter->task)) {
> > +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> > +			break;
> > +		}
> > +		if (signal_pending_state(state, current)) {
> > +			raw_spin_lock_irq(&sem->wait_lock);
> 
> Move the below __set_current_state(TASK_RUNNING)s up here? I think we
> need the preemption protection when changing the task state here.
> 

Nevermind since we have the preemption protection for the whole
function... but merging two __set_current_state()s into one still looks
good.

Regards,
Boqun

> > +			if (waiter->task)
> > +				goto out_nolock;
> 
[...]
> > +
> > +	__set_current_state(TASK_RUNNING);
> > +	lockevent_inc(waiter_type(waiter, rwsem_rlock, rwsem_wlock));
> > +	trace_contention_end(sem, 0);
> > +	return sem;
> > +
> > +out_nolock:
> > +	rwsem_del_wake_waiter(sem, waiter);
> > +	__set_current_state(TASK_RUNNING);
> > +	lockevent_inc(waiter_type(waiter, rwsem_rlock_fail, rwsem_wlock_fail));
> > +	trace_contention_end(sem, -EINTR);
> > +	return ERR_PTR(-EINTR);
> > +}
> > +
> >  /*
> >   * Wait for the read lock to be granted
> >   */
> > @@ -1071,38 +1109,7 @@ rwsem_down_read_slowpath(struct rw_semap
> >  	if (!wake_q_empty(&wake_q))
> >  		wake_up_q(&wake_q);
> >  
> > -	trace_contention_begin(sem, LCB_F_READ);
> > -
> > -	/* wait to be given the lock */
> > -	for (;;) {
> > -		set_current_state(state);
> > -		if (!smp_load_acquire(&waiter.task)) {
> > -			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> > -			break;
> > -		}
> > -		if (signal_pending_state(state, current)) {
> > -			raw_spin_lock_irq(&sem->wait_lock);
> > -			if (waiter.task)
> > -				goto out_nolock;
> > -			raw_spin_unlock_irq(&sem->wait_lock);
> > -			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> > -			break;
> > -		}
> > -		schedule_preempt_disabled();
> > -		lockevent_inc(rwsem_sleep_reader);
> > -	}
> > -
> > -	__set_current_state(TASK_RUNNING);
> > -	lockevent_inc(rwsem_rlock);
> > -	trace_contention_end(sem, 0);
> > -	return sem;
> > -
> > -out_nolock:
> > -	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> > -	__set_current_state(TASK_RUNNING);
> > -	lockevent_inc(rwsem_rlock_fail);
> > -	trace_contention_end(sem, -EINTR);
> > -	return ERR_PTR(-EINTR);
> > +	return rwsem_waiter_wait(sem, &waiter, state);
> >  }
> >  
> >  /*
> > @@ -1150,37 +1157,7 @@ rwsem_down_write_slowpath(struct rw_sema
> >  	}
> >  	raw_spin_unlock_irq(&sem->wait_lock);
> >  
> > -	/* wait until we successfully acquire the lock */
> > -	trace_contention_begin(sem, LCB_F_WRITE);
> > -
> > -	for (;;) {
> > -		set_current_state(state);
> > -		if (!smp_load_acquire(&waiter.task)) {
> > -			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> > -			break;
> > -		}
> > -		if (signal_pending_state(state, current)) {
> > -			raw_spin_lock_irq(&sem->wait_lock);
> > -			if (waiter.task)
> > -				goto out_nolock;
> > -			raw_spin_unlock_irq(&sem->wait_lock);
> > -			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> > -			break;
> > -		}
> > -		schedule_preempt_disabled();
> > -		lockevent_inc(rwsem_sleep_writer);
> > -	}
> > -	__set_current_state(TASK_RUNNING);
> > -	lockevent_inc(rwsem_wlock);
> > -	trace_contention_end(sem, 0);
> > -	return sem;
> > -
> > -out_nolock:
> > -	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> > -	__set_current_state(TASK_RUNNING);
> > -	lockevent_inc(rwsem_wlock_fail);
> > -	trace_contention_end(sem, -EINTR);
> > -	return ERR_PTR(-EINTR);
> > +	return rwsem_waiter_wait(sem, &waiter, state);
> >  }
> >  
> >  /*
> > 
> > 
