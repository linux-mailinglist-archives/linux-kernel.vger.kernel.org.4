Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD26A3369
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBZSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBZSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:23:14 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E545CDC6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:23:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c19so4483155qtn.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI2zBOp6CQiGme6aR1wDzWV9TZJd5AGSGHfip44GPWE=;
        b=fkJEE5HnZH6bmOiQ8IQQezgT1odWdDdrKCYe0/pZUw0LavS9g6SueQVDr0vv8RzGnF
         NZukj7mDEHYa0yjczn09+QYzxWlB7H50LTtjt1sE/9E6Ek9JUEyne2DbRdImEoyFilWj
         kMZ2nTnHHXXLIry3XpN4MCA9pLd5PI8o3o4/M8zey/Zyicd0TZ7YXfEXpZQtvz73zoZC
         Ec2C6Y11GlbeW3/rQCizcqtioeQthLFqeslWmeen9PFSl/DjRhuFqTWM0oHWWHry8mTT
         mGE8OmngqDbfD5bska3lwmP6ZrB05Orj0Az6RF34ywIu42poeFKxpcnBguayrwhORuQB
         DWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI2zBOp6CQiGme6aR1wDzWV9TZJd5AGSGHfip44GPWE=;
        b=7IHDSkUjNOcajZTwFdGFdcHjE6ulXW5t4N8wbNTT73lXBcHRSiDZ9DNF1Sq/GIyL96
         nOPyDcLI1SlEFcDsnH8dr1ZZ8LCC5fuSmMv8k9x6HIj9qXLwghpTx+oPNqwR3aSSAL2B
         Z5ZCIliXkvFAxSz9u+iPtt7BOwll37NiTpaC4Zn7f5dagKPSFIe31G8xQG0ies511een
         J6sbnjyqymgx/bgwbt3EauF+xjD6fRZ/m84qv4qJVC7NsVWNZIkqjrg9qVq5R89w8OaD
         r71QNyNk8p8XLJSOS9rK9ygJuRn+MHvP+qXWW913VPA8pVJBaZJuw6bxMbG4BDmsjdNH
         u3ig==
X-Gm-Message-State: AO0yUKUAJoF99QLwtKzZcZ7VOqanMlYA6ZKobGD44d8VDzarDLLaP3qv
        smr3Z1b6VWkPoQYiEoubmT4=
X-Google-Smtp-Source: AK7set+zdWL7QDNHmSHKBLGbp6z/6VZ7NlRN0cFAMyFWENThwQuMB/P9jzpKc0Kxw7OC9LrvcXmK8Q==
X-Received: by 2002:a05:622a:1453:b0:3bf:da89:1946 with SMTP id v19-20020a05622a145300b003bfda891946mr252418qtx.1.1677435792351;
        Sun, 26 Feb 2023 10:23:12 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f18-20020ac840d2000000b003a530a32f67sm3217433qtm.65.2023.02.26.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 10:23:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7A10527C0054;
        Sun, 26 Feb 2023 13:23:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 26 Feb 2023 13:23:11 -0500
X-ME-Sender: <xms:j6P7Y33VsyM6tBjtwaPwffZfSGpxgVt9F508zTcFG2OSVFi-UFZuYA>
    <xme:j6P7Y2FQkkJKx-79tEVoycRwItCjiA-DHWycmu6ym4wRlGfpDBG8jqAd55_OCUO3J
    bErHmZig0SoPjl_fA>
X-ME-Received: <xmr:j6P7Y363T_vmHHiPckJoS6-iKEGBxYU25AWeeyDTMaiJSBmzIK-dLUB_prg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekkedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:j6P7Y83A11D-BXO7W9y7KdI8gQzbLXkAeph1QJM1iiu0Pp1jQWv3_w>
    <xmx:j6P7Y6EJVQKb9xN41uEWIHt6FwjicY2BpXodL0LamDBFdK_Y2RF0Qg>
    <xmx:j6P7Y99bLmSiCwXZHiXvw-g0b2k32M2RjGKAOrzQU2V-tl7XsJyrjQ>
    <xmx:j6P7Y2ju6mpGlPhu4ltAetKnadp_dV22gIyKNL8UHsleCPr7H2FmsA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Feb 2023 13:23:10 -0500 (EST)
Date:   Sun, 26 Feb 2023 10:22:40 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     longman@redhat.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] locking/rwsem: Unify wait loop
Message-ID: <Y/ujcH+trpFeHCAh@boqun-archlinux>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.608133045@infradead.org>
 <Y/e/I1aqDAjoq2Rs@boqun-archlinux>
 <Y/gUAdaFf20PDUkO@boqun-archlinux>
 <Y/tKBn4arzdh8MXV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/tKBn4arzdh8MXV@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 01:01:10PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 23, 2023 at 05:33:53PM -0800, Boqun Feng wrote:
> > On Thu, Feb 23, 2023 at 11:31:47AM -0800, Boqun Feng wrote:
> > [..]
> > > > +#define waiter_type(_waiter, _r, _w)	\
> > > > +	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
> > > > +
> > > > +static __always_inline struct rw_semaphore *
> > > > +rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
> > > > +{
> > > > +	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
> > > > +
> > > > +	/* wait to be given the lock */
> > > > +	for (;;) {
> > > > +		set_current_state(state);
> > > > +		if (!smp_load_acquire(&waiter->task)) {
> > > > +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> > > > +			break;
> > > > +		}
> > > > +		if (signal_pending_state(state, current)) {
> > > > +			raw_spin_lock_irq(&sem->wait_lock);
> > > 
> > > Move the below __set_current_state(TASK_RUNNING)s up here? I think we
> > > need the preemption protection when changing the task state here.
> > > 
> > 
> > Nevermind since we have the preemption protection for the whole
> > function... but merging two __set_current_state()s into one still looks
> > good.
> 
> Even if it were not; I still don't understand the concern. Preemption
> ignores task state.

Because I missed the exact thing you just mentioned... ;-)

I was worried about the following case:

							ttwu();
	set_current_state(TASK_UNINTERRUPTIBLE);
	....
	<preemption enable>
	<preempted>
	  preempt_schedule_irq():
	    __schedule(...):
	      deactivate_task(); // Wakeup missed.

However this is not true, since __schedule() in preempt_schedule_irq()
is a SM_PREEMPT one.

Sorry for the noise then. But good for me to revisit these stuffs ;-)

Regards,
Boqun
