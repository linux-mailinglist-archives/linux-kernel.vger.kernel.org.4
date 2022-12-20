Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64565177F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiLTBEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLTBEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:04:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCA65FF6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:04:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l8so10892411ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oD/I6FKTmpuvG8SNtihhznjsvA9ma6Z63rTmzRotItM=;
        b=CQ7R5k6JcuMP6whbWAE7xVbMEBK72Y3xULg7ylWXO8woQJM/mGHSVyGTZOHvJtEpQM
         9h0u5NNs5yN5CxMnG4jfTN1CmlqkvpE4OvYAXi7YlP7ClvpZYw15st5mXDK5gcMkLvCT
         s3fP8TdqRl6u/4EJQHEEEN7XVl3Uf7wIwCklA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD/I6FKTmpuvG8SNtihhznjsvA9ma6Z63rTmzRotItM=;
        b=QM6tet6eMSLFh3/L+tx4Ah2dacl9Q7k/AUpQyHJn1gxoQLsSrT2DFj1P7n36mDqtjk
         1YKFu9zYAOSAmADc6hqvSFZ+E/4IxAJ/EJ7K2j2V/yx3qCATavft9A9cH/njo9bjtkmu
         uwWi0TYwE0WEMPKJuWm2/shEv9VvXk7Fylj+lFrKORVefT3OHP4Q5kzzmS87DemeWHMk
         thn5V1LpQnbkUc2ncobWEqieCwcgkAfYBVKs0rj5FRno0EUX02XY91EURSEsjAvGbirp
         h5qLGjWH9WP7e97cuSTe3S4IZ0AUh97OB2V8qWC7WKgezfToTEJuee/6E/szHG7aob3Q
         VY/g==
X-Gm-Message-State: ANoB5pmptUvGz/Fpf2ZZHB4F+zBZKwSgbKvDR2vDLP5+1J+FCMnNOQ4Y
        ECRfz6o32E6yoodlmeOcYYOBJjNKc4nOb+xy43zAgw==
X-Google-Smtp-Source: AA0mqf7SZMtF0wQFLm4ZeidgYegTzM5fWcb+V6TMjN/aL+7Tt0bElfiKoCHcbh0UIPIUunEMyae1KbdlN057r+pqniA=
X-Received: by 2002:a05:651c:160b:b0:276:4462:2d20 with SMTP id
 f11-20020a05651c160b00b0027644622d20mr23893994ljq.19.1671498278203; Mon, 19
 Dec 2022 17:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com> <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com> <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
 <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com> <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
In-Reply-To: <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 19 Dec 2022 20:04:32 -0500
Message-ID: <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
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

On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Sun, Dec 18, 2022 at 8:49 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> [...]
> > >>>>>
> > >>>>> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> > >>>>>> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> > >>>>>> can say to remove it, other than the possibility that it is unnecessary, is to
> > >>>>>> not have extra code that does not help. However, since we are issuing a fully
> > >>>>>> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> > >>>>>>
> > >>>>>> For this reason, please consider these patches as "informational", than a
> > >>>>>> "please merge". :-) Though, feel free to consider merging if you agree!
> > >>>>>>
> > >>>>>> All SRCU scenarios pass with these, with 6 hours of testing.
> > >>>>>
> > >>>>> Hi Joel,
> > >>>>>
> > >>>>> Please have a look at the comments in my side-rcu implementation [1, 2].
> > >>>>> It is similar to what SRCU does (per-cpu counter based grace period
> > >>>>> tracking), but implemented for userspace. The comments explain why this
> > >>>>> works without the memory barrier you identify as useless in SRCU.
> > >>>>>
> > >>>>> Following my implementation of side-rcu, I reviewed the SRCU comments
> > >>>>> and identified that the barrier "/* E */" appears to be useless. I even
> > >>>>> discussed this privately with Paul E. McKenney.
> > >>>>>
> > >>>>> My implementation and comments go further though, and skip the period
> > >>>>> "flip" entirely if the first pass observes that all readers (in both
> > >>>>> periods) are quiescent.
> > >>>>
> > >>>> Actually in SRCU, the first pass scans only 1 index, then does the
> > >>>> flip, and the second pass scans the second index. Without doing a
> > >>>> flip, an index cannot be scanned for forward progress reasons because
> > >>>> it is still "active". So I am curious how you can skip flip and still
> > >>>> scan both indexes? I will dig more into your implementation to learn more.
> > >>>
> > >>> If we look at SRCU read-side:
> > >>>
> > >>> int __srcu_read_lock(struct srcu_struct *ssp)
> > >>> {
> > >>>           int idx;
> > >>>
> > >>>           idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > >>>           this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> > >>>           smp_mb(); /* B */  /* Avoid leaking the critical section. */
> > >>>           return idx;
> > >>> }
> > >>>
> > >>> If the thread is preempted for a long period of time between load of
> > >>> ssp->srcu_idx and increment of srcu_lock_count[idx], this means this
> > >>> thread can appear as a "new reader" for the idx period at any arbitrary
> > >>> time in the future, independently of which period is the current one
> > >>> within a future grace period.
> > >>>
> > >>> As a result, the grace period algorithm needs to inherently support the
> > >>> fact that a "new reader" can appear in any of the two periods,
> > >>> independently of the current period state.
> > >>>
> > >>> As a result, this means that while within period "0", we _need_ to allow
> > >>> newly coming readers to appear as we scan period "0".
> > >>
> > >> Sure, it already does handle it but that is I believe it is a corner
> > >> case, not the norm.
> > >>
> > >>> As a result, we can simply scan both periods 0/1 for reader quiescence,
> > >>> even while new readers appear within those periods.
> > >>
> > >> I think this is a bit dangerous. Yes there is the preemption thing you
> > >> mentioned above, but that is bounded since you can only have a fixed
> > >> number of tasks that underwent that preemption, and it is quite rare
> > >> in the sense, each reader should get preempted just after sampling idx
> > >> but not incrementing lock count.
> > >>
> > >> However, if we scan while new readers appear (outside of the above
> > >> preemption problem), we can have counter wrap causing a false match
> > >> much quicker.
> > >> The scan loop is:
> > >> check_readers(idx) {
> > >>     count_all_unlocks(idx);
> > >>     smp_mb();
> > >>     count_all_locks(idx);
> > >>     bool done = (locks == unlocks)
> > >>     if (done) {
> > >>           // readers are done, end scan for this idx.
> > >>     } else {
> > >>           // try again later
> > >>     }
> > >> }
> > >>
> > >> So if check_readers() got preempted just after the smp_mb(), then you
> > >> can have lots of tasks enter and exit the read-side critical section
> > >> and increment the locks count. Eventually locks == unlocks will
> > >> happen, and it is screwed. Sure this is also theoretical, but yeah
> > >> that issue can be made "worse" by scanning active readers
> > >> deliberately, especially when such readers can also nest arbitrarily.
> > >>
> > >>> As a result, flipping between periods 0/1 is just relevant for forward
> > >>> progress, not for correctness.
> > >>
> > >> Sure, agreed, forward progress.
> > >
> > > Adding to the last statement "But also correctness as described above".
> >
> > Exactly how many entry/exit of the read-side critical section while the
> > grace period is preempted do you need to trigger this ?
>
> It depends on how many readers are active during the preemption of the
> scan code. Say the preemption happened after per-CPU unlock counts
> were totalled. Then AFAICS, if there are N active readers which need
> the grace period to wait, you need (2^sizeof(int) - N) number of
> lock+unlock to happen.

Sorry, here I meant (2^(sizeof(unsigned long) * 8) - N) which is 2^32
on 32-bit systems.

thanks,

 - Joel


> > On a 64-bit system, where 64-bit counters are used, AFAIU this need to
> > be exactly 2^64 read-side critical sections.
>
> Yes, but what about 32-bit systems?
>
> > There are other synchronization algorithms such as seqlocks which are
> > quite happy with much less protection against overflow (using a 32-bit
> > counter even on 64-bit architectures).
>
> The seqlock is an interesting point.
>
> > For practical purposes, I suspect this issue is really just theoretical.
>
> I have to ask, what is the benefit of avoiding a flip and scanning
> active readers? Is the issue about grace period delay or performance?
> If so, it might be worth prototyping that approach and measuring using
> rcutorture/rcuscale. If there is significant benefit to current
> approach, then IMO it is worth exploring.
>
> > Or am I missing your point ?
>
> No, I think you are not. Let me know if I missed something.
>
> Thanks,
>
>  - Joel
>
>
> >
> >
> > >
> > > thanks,
> > >
> > >   - Joel
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
> >
