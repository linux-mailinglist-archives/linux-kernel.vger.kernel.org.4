Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ACD6504B6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 22:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiLRVTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 16:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiLRVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:19:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36789CE13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:19:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so11130643lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ArF/hNCkka4Q7GmG8OAXZMd8vi/1dRX9Scjd3gEhvuE=;
        b=C4OUeddWTE/ou50N5jqsOOvjYcZ4GqcOphIlMaUhd38NlQbcfuWoXFCet+EY/t4GW6
         OI0ykoYrWgbwrcXMduB8xF7oT+5yaYTopDUvEvZSZ5iD0AW+EbRt/KkCBjnDYqybEg/Y
         Ms+d8sQdqkUNNhDpcvK1lnJublXYzbqG16L6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArF/hNCkka4Q7GmG8OAXZMd8vi/1dRX9Scjd3gEhvuE=;
        b=tnjgpYd9ijJzbSRLXh+B7+mvg2y5OsecJX/svr2LBT/WktCFv1tRTqQATjOqWki/Am
         ehrK8fx3JFJO+dfw4Jc9uc+A4gppKAFEoLysjYMGc13sbz390/TIhvnctlXxfEr6x8lf
         Mx2iPeeXZVe5bfudcB3OKVMnDm6uJUYNYaBTIJFIOiiM6JXwGgTvRTBKRip68QbZmcwW
         9gGs6y+mdN4YSJDgs2mD5qyzBdyATtljRy4ktl4v5wJ5DE38/doEk1Ag8SUvZEg/5MXE
         cL1lPC6tpmaS5k7TL0HsT5ep8QyBm6dAWcA71TJyMFv9rmce18TP/ACCSZz5ljhaxUre
         rLgQ==
X-Gm-Message-State: ANoB5pntifAWi07E4h1KSuHZdfEaNKRTb7twr4aB4QTUt784eX2ILRk6
        EFZTE6lErWA1WFEJdbYYaSxJPPjwWhe1bGzBtWsKvA==
X-Google-Smtp-Source: AA0mqf7eD0aSXGl+QmVr0R7hMy5mlgRJb8GqtX0/Q8mVS9Ch0ETqqz2xr3IMPTsWChjMo2v+wj/NTKTkNuE1GCPfLNk=
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id
 c8-20020a056512324800b004aa148d5168mr32025495lfr.561.1671398359262; Sun, 18
 Dec 2022 13:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <20221218191310.130904-2-joel@joelfernandes.org> <db4cccb8-e7fd-3d54-c5c8-3df90c5ddc49@efficios.com>
In-Reply-To: <db4cccb8-e7fd-3d54-c5c8-3df90c5ddc49@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 16:19:07 -0500
Message-ID: <CAEXW_YRSKRkVc=+HiknQYkLrBGwWfUn3cCp3Btj5AAeqY7KKZw@mail.gmail.com>
Subject: Re: [RFC 1/2] srcu: Remove comment about prior read lock counts
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,
Thanks a lot for sharing details of side-rcu, I will review it over
the holidays! I agree we can/should borrow from that implementation
where possible. I replied to the comments below:

On Sun, Dec 18, 2022 at 4:07 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> > The comment says that if an updater saw lock count updates, then
> > ensure the reader does not see the new srcu_idx.
> >
> > However, there is no memory barrier between a READER reading srcu_idx
> > with respect to incrementing the lock count for that srcu_idx.
> >
> > So what is really happening is, both "B" and "C" will order the current
> > reader's unlock count update, and the _next_ readers lock count update, with
> > respect to the write to the currently active index.
> >
> > Consider first the case of the unlock count update being seen by the UPDATER:
> >
> > (for brevity, the pseudocode shortens "srcu_idx" to "idx")
> >
> > READER                            UPDATER
> >
> > rcu_read_lock() {
> >      idx = READ(idx);
> >      lock_count[idx]++;
> >
> >      smp_mb();    // B
> > }
> >                                  srcu_flip() {
> >                                      smp_mb(); //E
> >                                      idx++;
> >                                      smp_mb();
> >                                  }
> > rcu_read_unlock() {
> >      smp_mb();    // C
> >      unlock_count[idx]++;
> > }
> >
> > Consider that the updater saw the unlock count update, and due to this, we
> > expect "E" to make sure that the reader only used the old srcu_idx.
> >
> > However, say the reader used the new srcu_idx because we dropped "E".  That is
> > totally OK because both unlock and lock counts of this reader will negate each
> > other during the next scan of the srcu_idx. So we don't have to guarantee at
> > all that the reader used the old srcu_idx, that does not buy us anything
> > because if it used the new one, we would just ignore it during the next scan
> > anyway (the reader is "done").
> >
> > Now lets look at the following case:
> >
> > READER                            UPDATER
> >
> > rcu_read_lock() {
> >      idx = READ(idx);
> >      lock_count[idx]++;
> >
> >      smp_mb();    // B
> > }
> >
> > rcu_read_unlock() {
> >      smp_mb();    // C
> >      unlock_count[idx]++;
> > }
> >                                  srcu_flip() {
> >                                      smp_mb(); //E
> >                                      idx++;
> > rcu_read_lock() {
> >      idx = READ(idx);
> >      lock_count[idx]++;
> >
> >      smp_mb();    // B
> >                                      smp_mb();
> >                                  }
> > }
> >
> > Consider that the updater saw the lock count update of the second
> > rcu_read_lock(). It does not matter that we guarantee that the reader sees only
> > the old srcu_idx. This is because, a reader could totally just sample
> > srcu_idx, and stay preempted for long periods of time. So, during any scan, we
> > already have the issue of a preempted-reader randomly springing up with a copy
> > of the index which we consider the "new index". So guaranteeing that the reader
> > saw the old srcu_idx instead of the new one if we saw its lock count updates,
> > also does not buy us anything.
> >
> > Due to these reasons, drop the argument that the reader has to see a certain
> > srcu_idx since we have no control over that anyway, and guaranteeing that does not
> > buy us anything.
>
> I don't understand why this first patch only removes a comment about the
> need to order things, when in fact it's the entire memory barrier /* E
> */ that is useless.
>
> I suspect we should just remove the comment along with the barrier
> without this added step.

Yes, this is what I do in patch 2/2. I just wanted to break it down
because the change log would be too big otherwise. There were 2
reasons given for the "E" memory barrier, so I split it into 2 patches
for that reason so both patches can be discussed possibly separately.
But no issues with squashing as well and merging change logs.

> What SRCU fundamentally does is detect quiescence of all SRCU readers
> between the beginning of the grace period and its completion. In order
> to ensure forward progress, it does so in a two-phase algorithm. What
> the grace period does to detect quiescence is to observe that each of
> the periods (0/1) have no active reader at a given point in the grace
> period.

Yes agreed! By deactivating an index, it is possible to ensure new
readers don't show up on the deactivated one, and so we are bound in
scan time / forward progress. (Except for the special case where a
reader was preempted after picking up the index, and then suddenly
shows up in the scan).

> Then the fact that the period is flipped to send new-coming
> readers into a different period is just to ensure forward progress, and
> is basically irrelevant (order-wise) with the fact that the grace period
> scans both periods and validates that both periods are observed to have
> no active readers.

Yes.

> I'd favor just clarifying the SRCU model in this way, and then remove
> the useless barrier, and also implement improvements to the SRCU
> algorithm and skip the "flip" entirely when we notice (early) that no
> active readers are present in both periods. This is actually similar to
> what I implemented in side-rcu.
> Thoughts ?

Agreed! Thanks so much for sharing this, and I will take a look on my
side and study it. Interesting on that optimization to skip the flip!

Thanks,

 - Joel


>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   kernel/rcu/srcutree.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1c304fec89c0..d6a4c2439ca6 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -983,12 +983,10 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
> >   static void srcu_flip(struct srcu_struct *ssp)
> >   {
> >       /*
> > -      * Ensure that if this updater saw a given reader's increment
> > -      * from __srcu_read_lock(), that reader was using an old value
> > -      * of ->srcu_idx.  Also ensure that if a given reader sees the
> > -      * new value of ->srcu_idx, this updater's earlier scans cannot
> > -      * have seen that reader's increments (which is OK, because this
> > -      * grace period need not wait on that reader).
> > +      * Ensure that if a given reader sees the new value of ->srcu_idx, this
> > +      * updater's earlier scans cannot have seen that reader's increments
> > +      * (which is OK, because this grace period need not wait on that
> > +      * reader).
> >        */
> >       smp_mb(); /* E */  /* Pairs with B and C. */
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
