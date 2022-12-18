Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB06504AF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLRVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 16:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:02:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C33882
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:02:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so11039730lfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpHLqKVH79TMfENsVoD6e8/Lr+5zSBRRAc4inRZzCrU=;
        b=e1JcGvnD65bW967DfJog3AZxXpOmuu+jYa1ApT5630jyeoOCmlyWuEwO+ZgltGghnY
         t4ur771veL8Pg17VQ1FaBy754bS3dZXsNhSAdrxTZg/Ji1yfZxA9drVx6NLPD4RMqUpj
         YqZpWNB6an6jwEowgAnN60zvfNtIRDH+fPaOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpHLqKVH79TMfENsVoD6e8/Lr+5zSBRRAc4inRZzCrU=;
        b=g7pGZV8v7fqzigRAEG2TSP8XJ9J5JbydKFLRa1A5V24HaFkDBcUrbeie0w35jkTEfy
         FG55xNsMKZOsikNByfhpyZAmOpbdoCCziE7yGKjYa4WS44mn54e32/tb5AkWedbTP3Iw
         pK50p/9cE9Y79judf4SbBsg+FHCh95V53ZsPZIrQbJvDv0ro64pl/1OofGFSpH3+7Pac
         ooytKhgZD7ReseSZp7qzmcv2rdv6zMEHsG8oUyTc6ya+3XZsKyXU9fz/PpXNwf8jddvh
         3NxbGVzKu6uKayG5TG2izoSkUMRkbZUjRH440cMWhnSkLq6a28I09KhZEgDChpRkMGbg
         eecw==
X-Gm-Message-State: ANoB5plwqU2Q1LGpMtHBw7Y8lqUHYoimL/iSnjOjFSiSGbNa8OjNII+T
        Xkz9qQEEZXEHHwb5o1+owN/BUvDUoDaiGiq5YB0Q/g==
X-Google-Smtp-Source: AA0mqf4v47MADKLEMMJUU0yBfI0kj3wTznUdtl6+qpPEE8Ag9BWJn8e4I9EJnZx3Ief+wX9YYfINOwqm2ubUzo0nKaA=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr3182761lfu.84.1671397367405; Sun, 18
 Dec 2022 13:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1> <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1> <Y550Z+MOq1IX3Wb4@google.com>
 <20221218180638.GR4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSy4MyUW55Umtt4LRfX_4Dhdv0h2O=n+Zbq2ijakwGnBw@mail.gmail.com>
 <20221218194434.GS4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221218194434.GS4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 16:02:35 -0500
Message-ID: <CAEXW_YQvbcvxh7u7sU-VjdAYUWpxDzdH-68qk_AjY54hMjNYMg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in rcu_blocking_is_gp()
To:     paulmck@kernel.org
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 2:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > > If not, I would do something like this:
> > > >
> > > > ---8<-----------------------
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 79aea7df4345..23c2303de9f4 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3435,11 +3435,12 @@ static int rcu_blocking_is_gp(void)
> > > >  {
> > > >       int ret;
> > > >
> > > > +     might_sleep();  /* Check for RCU read-side critical section. */
> > > > +
> > > >       // Invoking preempt_model_*() too early gets a splat.
> > > >       if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
> > > >           preempt_model_full() || preempt_model_rt())
> > > >               return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>
> If the scheduler is inactive (early boot with interrupts disabled),
> we return here.
>
> > > > -     might_sleep();  /* Check for RCU read-side critical section. */
>
> We get here only if the scheduler has started, and even then only in
> preemption-disabled kernels.
>
> Or is you concern that the might_sleep() never gets invoked in kernels
> with preemption enabled?  Fixing that would require a slightly different
> patch, though.
>
> Or should I have waited until tomorrow to respond to this email?  ;-)

No, I think you are quite right. I was not referring to
rcu_sleep_check(), but rather the following prints in might_sleep(). I
see an unconditional call to might_sleep()  from kvfree_call_rcu() but
not one from synchronize_rcu() which can also sleep.

But I see your point, early boot code has interrupts disabled, but can
still totally call synchronize_rcu() when the scheduler is INACTIVE.
And might_sleep() might bitterly complain. Thanks for the
clarification.

pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
      file, line);
pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d,
name: %s\n",
      in_atomic(), irqs_disabled(), current->non_block_count,
      current->pid, current->comm);
pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
      offsets & MIGHT_RESCHED_PREEMPT_MASK);

Thanks,

 - Joel

> > > >       /*
> > > >        * If the rcu_state.n_online_cpus counter is equal to one,
