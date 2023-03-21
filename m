Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366E36C2FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCULM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCULMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:12:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356553E1C9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:12:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15886663pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679397138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aFm2bVhMnmdLT8TBnJW2RkUaD0t/LuQwcgQAtupO00s=;
        b=LT3wPyTQyYRItyBqKfzpiKtfA/xZLZqwxUyX0U8pbX0KVlmbN2VaL+vO4VVw6Zqc8D
         JH0H5bubLUI0i1JNgc5/upC9JJ08iLIh4ClBxv8COcHYvaDe69n88ifPDHr7mmrdDM06
         xN+BtkORi89bUBrfbq8qNQCjE1mzvZA6o9MSvUU9sTt0xcpq3hnT3IGjQPa5HSV+b2/L
         6cpNH10oQAi3iRIHzspx6G4Miy7JkCIQUtXM2Nf6OI4j930MvYYDc8ZzjKpWACr9zqW+
         lkE6PlPTFiMaZF8XNj3CZjKEDd05Ktruo8Hy45DaMHLzHbrbGl9Fa/nDbwwAh4HjQa8Z
         YKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFm2bVhMnmdLT8TBnJW2RkUaD0t/LuQwcgQAtupO00s=;
        b=weS+v1V6L7CGW+Crqh3hR4c0yBA1ym4e9xhK+OOVlwRXIM7aN0eEhT5F5mkNkH3d3M
         mixl4fzLSJVO4CEQQSDH/gD2UmQiEUV4Dh010sYPDnXSVvl1ZvGRWgPbgh+3ZAvJ6nJx
         DxwLzvl1ZX4adNGOQFx8x9z5EpLqvpFFhzDOgMmrn3HfX3h7koMUhYA3lxtA5uhWM6Fe
         EKxCaAj7me9C5A/RanGbTBx25XKpqQ7wqBdIoh/0YEQD8TMVJ5SxiJzx6E0HpqiPYsn6
         q1r991u1+uRBWPv+7Bv4xjLeB7bi7CP5feBiirbUPf87bPWSP+PE+TfV90CawMm9Nt+m
         TUPQ==
X-Gm-Message-State: AO0yUKXZnyPHJCuzuAGMs2P832GoLGyj6sD2Ex0IaBfar4cpMo8CLY2m
        1lA5Vge1KrnBfmiK8QNuexVn38HDEk2VioRwz3elxBuBacyRfc5sV6g=
X-Google-Smtp-Source: AK7set8PPOXF3EsDqEpb+b5nkEUYnuYetnD8KL3lY4WY5ZprY/xpg5oTrUgZF6jT2PowFrbyJ8LGkHrBmqLyMVdvWi0=
X-Received: by 2002:a17:903:2303:b0:1a0:5402:b17b with SMTP id
 d3-20020a170903230300b001a05402b17bmr750510plh.0.1679397138642; Tue, 21 Mar
 2023 04:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
 <20230321100206.GE2234901@hirez.programming.kicks-ass.net>
 <7bba69e0-5261-9921-16b7-c8592b5d213b@arm.com> <20230321104949.GI2234901@hirez.programming.kicks-ass.net>
In-Reply-To: <20230321104949.GI2234901@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Mar 2023 12:12:07 +0100
Message-ID: <CAKfTPtArC+A+=TtzK5igMiwCaq-K6_oTyQX4k6-oaJJz-91OAA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 at 11:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 21, 2023 at 11:29:13AM +0100, Dietmar Eggemann wrote:
> > On 21/03/2023 11:02, Peter Zijlstra wrote:
> > > On Fri, Mar 17, 2023 at 05:08:10PM +0100, Vincent Guittot wrote:
> > >> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> > >> fixes an overflowing bug, but ignore a case that se->exec_start is reset
> > >> after a migration.
> > >>
> > >> For fixing this case, we delay the reset of se->exec_start after
> > >> placing the entity which se->exec_start to detect long sleeping task.
> > >>
> > >> In order to take into account a possible divergence between the clock_task
> > >> of 2 rqs, we increase the threshold to around 104 days.
> > >>
> > >>
> > >> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> > >> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >> ---
> > >
> > > Blergh, this just isn't going to be nice. I'll go queue this for
> > > sched/urgent and then we can forget about this for a little while.
> > >
> > > Thanks!
> >
> > Don't we miss setting `se->exec_start = 0` for fair task in
> > move_queued_task()? ( ... and __migrate_swap_task())
> >
> > https://lkml.kernel.org/r/df2cccda-1550-b06b-aa74-e0f054e9fb9d@arm.com
>
> Ah, I see what you mean now... When I read your and Vincent's replies
> earlier today I though you mean to avoid the extra ENQUEUE_MIGRATED use,
> but your actual goal was to capure more sites.
>
> Hmm, we could of course go add more ENQUEUE_MIGRATED, but you're right
> in that TASK_ON_RQ_MIGRATING already captures that.
>
> An alternative is something like the below, that matches
> deactivate_task(), but still uses ENQUEUE_MIGRATED to pass it down into
> the class methods.
>
> Hmm?

Yes, this seems to be the right way to set ENQUEUE_MIGRATED flags

>
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2084,6 +2084,9 @@ static inline void dequeue_task(struct r
>
>  void activate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> +       if (task_on_rq_migrating(p))
> +               flags |= ENQUEUE_MIGRATED;
> +
>         enqueue_task(rq, p, flags);
>
>         p->on_rq = TASK_ON_RQ_QUEUED;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8726,7 +8726,7 @@ static void attach_task(struct rq *rq, s
>         lockdep_assert_rq_held(rq);
>
>         WARN_ON_ONCE(task_rq(p) != rq);
> -       activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
> +       activate_task(rq, p, ENQUEUE_NOCLOCK);
>         check_preempt_curr(rq, p, 0);
>  }
>
