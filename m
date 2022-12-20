Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183665177B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiLTA5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiLTA44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:56:56 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6097E1789E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:56:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so16337197lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXoy9Pl68vMlNNOaV9Wbz1/x0VWfUtAxt4Ykl/YxwEE=;
        b=hdzpL5tK12uCXbeMlqH9Ot9UZBqvL4dx136PQK/nRuBwcbuljR9Y/4Hjq4iCla/xsn
         J/2DX5zvC6KXy4haOWoNcvx/DQ/IuLPkc7/1i0Ia0LVbBUL9wvBucz6tLy9w5bdOza2x
         i97RwFWME1WTt36AuUlbDQPTkADhcCgXSng54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXoy9Pl68vMlNNOaV9Wbz1/x0VWfUtAxt4Ykl/YxwEE=;
        b=WWsvdO8zrQzly/TTHY91pxz239l7mcX8OFKBE0pfJd49ljsnkye+0vPHdFSBhR7UQ9
         d515J6D//HK7URd7Llb8qE/pSiVQTY/iMWaNAySjrH85A8e1hi96B14PQXv6tQ5wydZj
         X7KBqqlb/GiFPB00El0Xq5hKODoA+ulUTH7uaZ3TqZN4whBN35rnMt6rj82IVQyYjaSJ
         DKyftxHVyb5VF3HiS68n96CYyHgSnGMxUAuxhLgsasYAOAKifbS4zTWmjOoSh/4XuoDR
         J/LiQLW7PhNbMWq7vYafXfDmVXztlr5GFiIMH1BwtljnILY7y5euaOfn7/7hOg1pLZyh
         DxmA==
X-Gm-Message-State: ANoB5pkLKn6m+V4+yEtFjY0cMfDFClf+k5Ep8BVGnKwfRIGIWeGxEHHt
        nDT0S+f5WD501gb1qKL5tBKYX9B09b16/7c6ojpzVg==
X-Google-Smtp-Source: AA0mqf5Q1cvOJ/TUbRX7Eud5NRmXREny8KBvoMKi5EH2kr8OTBVLpB7QGz8oMA//zj7MQxOYoBlOHB746/LU4e5R7MU=
X-Received: by 2002:ac2:510c:0:b0:4af:d4e:dfa7 with SMTP id
 q12-20020ac2510c000000b004af0d4edfa7mr28137170lfb.582.1671497765480; Mon, 19
 Dec 2022 16:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com> <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com> <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com> <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
In-Reply-To: <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 19 Dec 2022 19:55:59 -0500
Message-ID: <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
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

On Sun, Dec 18, 2022 at 8:49 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
[...]
> >>>>>
> >>>>> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> >>>>>> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> >>>>>> can say to remove it, other than the possibility that it is unnecessary, is to
> >>>>>> not have extra code that does not help. However, since we are issuing a fully
> >>>>>> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> >>>>>>
> >>>>>> For this reason, please consider these patches as "informational", than a
> >>>>>> "please merge". :-) Though, feel free to consider merging if you agree!
> >>>>>>
> >>>>>> All SRCU scenarios pass with these, with 6 hours of testing.
> >>>>>
> >>>>> Hi Joel,
> >>>>>
> >>>>> Please have a look at the comments in my side-rcu implementation [1, 2].
> >>>>> It is similar to what SRCU does (per-cpu counter based grace period
> >>>>> tracking), but implemented for userspace. The comments explain why this
> >>>>> works without the memory barrier you identify as useless in SRCU.
> >>>>>
> >>>>> Following my implementation of side-rcu, I reviewed the SRCU comments
> >>>>> and identified that the barrier "/* E */" appears to be useless. I even
> >>>>> discussed this privately with Paul E. McKenney.
> >>>>>
> >>>>> My implementation and comments go further though, and skip the period
> >>>>> "flip" entirely if the first pass observes that all readers (in both
> >>>>> periods) are quiescent.
> >>>>
> >>>> Actually in SRCU, the first pass scans only 1 index, then does the
> >>>> flip, and the second pass scans the second index. Without doing a
> >>>> flip, an index cannot be scanned for forward progress reasons because
> >>>> it is still "active". So I am curious how you can skip flip and still
> >>>> scan both indexes? I will dig more into your implementation to learn more.
> >>>
> >>> If we look at SRCU read-side:
> >>>
> >>> int __srcu_read_lock(struct srcu_struct *ssp)
> >>> {
> >>>           int idx;
> >>>
> >>>           idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> >>>           this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> >>>           smp_mb(); /* B */  /* Avoid leaking the critical section. */
> >>>           return idx;
> >>> }
> >>>
> >>> If the thread is preempted for a long period of time between load of
> >>> ssp->srcu_idx and increment of srcu_lock_count[idx], this means this
> >>> thread can appear as a "new reader" for the idx period at any arbitrary
> >>> time in the future, independently of which period is the current one
> >>> within a future grace period.
> >>>
> >>> As a result, the grace period algorithm needs to inherently support the
> >>> fact that a "new reader" can appear in any of the two periods,
> >>> independently of the current period state.
> >>>
> >>> As a result, this means that while within period "0", we _need_ to allow
> >>> newly coming readers to appear as we scan period "0".
> >>
> >> Sure, it already does handle it but that is I believe it is a corner
> >> case, not the norm.
> >>
> >>> As a result, we can simply scan both periods 0/1 for reader quiescence,
> >>> even while new readers appear within those periods.
> >>
> >> I think this is a bit dangerous. Yes there is the preemption thing you
> >> mentioned above, but that is bounded since you can only have a fixed
> >> number of tasks that underwent that preemption, and it is quite rare
> >> in the sense, each reader should get preempted just after sampling idx
> >> but not incrementing lock count.
> >>
> >> However, if we scan while new readers appear (outside of the above
> >> preemption problem), we can have counter wrap causing a false match
> >> much quicker.
> >> The scan loop is:
> >> check_readers(idx) {
> >>     count_all_unlocks(idx);
> >>     smp_mb();
> >>     count_all_locks(idx);
> >>     bool done = (locks == unlocks)
> >>     if (done) {
> >>           // readers are done, end scan for this idx.
> >>     } else {
> >>           // try again later
> >>     }
> >> }
> >>
> >> So if check_readers() got preempted just after the smp_mb(), then you
> >> can have lots of tasks enter and exit the read-side critical section
> >> and increment the locks count. Eventually locks == unlocks will
> >> happen, and it is screwed. Sure this is also theoretical, but yeah
> >> that issue can be made "worse" by scanning active readers
> >> deliberately, especially when such readers can also nest arbitrarily.
> >>
> >>> As a result, flipping between periods 0/1 is just relevant for forward
> >>> progress, not for correctness.
> >>
> >> Sure, agreed, forward progress.
> >
> > Adding to the last statement "But also correctness as described above".
>
> Exactly how many entry/exit of the read-side critical section while the
> grace period is preempted do you need to trigger this ?

It depends on how many readers are active during the preemption of the
scan code. Say the preemption happened after per-CPU unlock counts
were totalled. Then AFAICS, if there are N active readers which need
the grace period to wait, you need (2^sizeof(int) - N) number of
lock+unlock to happen.

> On a 64-bit system, where 64-bit counters are used, AFAIU this need to
> be exactly 2^64 read-side critical sections.

Yes, but what about 32-bit systems?

> There are other synchronization algorithms such as seqlocks which are
> quite happy with much less protection against overflow (using a 32-bit
> counter even on 64-bit architectures).

The seqlock is an interesting point.

> For practical purposes, I suspect this issue is really just theoretical.

I have to ask, what is the benefit of avoiding a flip and scanning
active readers? Is the issue about grace period delay or performance?
If so, it might be worth prototyping that approach and measuring using
rcutorture/rcuscale. If there is significant benefit to current
approach, then IMO it is worth exploring.

> Or am I missing your point ?

No, I think you are not. Let me know if I missed something.

Thanks,

 - Joel


>
>
> >
> > thanks,
> >
> >   - Joel
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
