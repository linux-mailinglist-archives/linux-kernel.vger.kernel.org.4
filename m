Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F310611D73
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ1WlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1WlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:41:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E1D18D3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:40:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j14so10029408ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2iFxEcy96ABH7Iba5WWLYbYHaTqbSSxPqiw5Y/aiOg=;
        b=SS/sXtNZ4mCsMNkII3nGH/EEb4DM98o+e2kLyMv/pmYw7TKvb14MxtRj3D5GTULCvk
         A4JMZh6MgpaqhMfY/82qg1yMhECcJHxoXxLfCwEJaKyvbUlI0IeMI0S2npWI8WANbyoO
         BH6O+H568uvB2s9ln1e+IrNh7fMVu3RbTJ9xuyCUsR3g7YeiFflLVXfGB4z6dFhtTRHv
         x9GYpbWqqPd9fUFKjebYvRjMvHivClwb4XHWtlhCOtbQ9IlkPRfliDptnEQcR+EeryKn
         h+mafjbR+tY49Rf4crpeO4Yrefgdzp1/YIxG/n1bvi1xpDEAZtJoHaVRxvwa0SXDNSju
         p5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2iFxEcy96ABH7Iba5WWLYbYHaTqbSSxPqiw5Y/aiOg=;
        b=A7WwiWC8/+EpJaYCnckQL3VQwlrm+zcdoeoPL4sXGN5aIX7/mZzjsiaI8v/jW0nfFH
         IX5Ttnn9Sf5/pVJRTx/QU+aXWI33TFKn7Uj/oYsLtu8CpGmsDyWFMjnUcDhSkRBS2B8i
         XEXkbPvpOJPM8/5jK5689rUMSBpuiPYKaZZRtOL26OWgG6mObSvMlQHhvgkXPDKj3Ql8
         5xzBFHMUwt3I8EXtUy7K8GNI3s75xWno0YIdpmAKhGix04oBuUpuUSBVN8ulZvNuDsRu
         hn1orhDXGAzpubNFUPfZpcishdFJciKG+D3iq8I3m4hzDAvIBa6VkcjY5RKbq6iJQ+rZ
         JPkA==
X-Gm-Message-State: ACrzQf2gH+SDgzIAi95sbYPd5wRvoCEpaHYG7rZnt3i0LgcDRatorbyX
        WJ+mR8wh7wqFMtYLuU0c5leyJncb4qLDBDBiZr18vQ==
X-Google-Smtp-Source: AMsMyM6PvTkkmi6ENOq6+HduP8EEGVXMGbxpsucoe7H4iYgILgnolyC8hVdJ7rEk4h19gnfa2qsB3dsqPlXAYN3/U64=
X-Received: by 2002:a2e:3e14:0:b0:277:a3b:49dd with SMTP id
 l20-20020a2e3e14000000b002770a3b49ddmr617097lja.342.1666996856469; Fri, 28
 Oct 2022 15:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com> <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
In-Reply-To: <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 28 Oct 2022 15:40:44 -0700
Message-ID: <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 8:57 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>
>
>
> =E5=9C=A8 2022/10/28 07:34, Josh Don =E5=86=99=E9=81=93:
> > Hi Chuyi,
> >
> > On Thu, Oct 27, 2022 at 1:16 AM Chuyi Zhou <zhouchuyi@bytedance.com> wr=
ote:
> >>
> >> The non-idle se dominates competition vs the idle se when they
> >> are belong to the same group. We ensure that idle groups would not
> >> preempt non-idle group in wakeup preemption(see check_preempt_wakeup()=
).
> >> However, this can happen in tick preemption, since check_preempt_tick(=
)
> >> dose not check current/se is idle or not. This patch adds this check.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   kernel/sched/fair.c | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index e4a0b8bd941c..f3324b8753b3 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4750,6 +4750,7 @@ static void
> >>   check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >>   {
> >>          unsigned long ideal_runtime, delta_exec;
> >> +       int cse_is_idle, pse_is_idle;
> >>          struct sched_entity *se;
> >>          s64 delta;
> >>
> >> @@ -4779,8 +4780,17 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struc=
t sched_entity *curr)
> >>          if (delta < 0)
> >>                  return;
> >>
> >> -       if (delta > ideal_runtime)
> >> +       if (delta > ideal_runtime) {
> >> +               /*
> >> +                * Favor non-idle group even in tick preemption
> >> +                */
> >> +               cse_is_idle =3D se_is_idle(curr);
> >> +               pse_is_idle =3D se_is_idle(se);
> >> +               if (unlikely(!cse_is_idle && pse_is_idle))
> >> +                       return;
> >
> Hi Josh, thanks for your reply,
> > This would make it so that we never have tick based preemption of a
> > non-idle entity by an idle entity. That's a recipe for starvation of
> > the idle entity, if the non-idle entity is cpu bound.
> >
> > Beyond that though, I'm not quite sure the issue being solved here.
> > The large difference in weight between the idle and non-idle entity
> > means that the non-idle entity will not be preempted for quite a while
> > due to its ideal_runtime being quite high. The idle entity will
> > quickly be preempted on the next tick it takes due to the smaller
> > value of sysctl_sched_idle_min_granularity.
> >
> Actually, I did some tests and traced this issue. the result shows that
> this can happen with small probability. I also do some benchmarks. The
> result seems it has no performance harm, and we can reduce 2%=EF=BD=9E3%
> context switch when idle group & non-idle group are present at the same
> time. In addition, for throughput concern, I think we better let
> non-idle entity consume it's ideal_runtime. However, as you said, it may
> cause starvation of the idle entity.....

I don't doubt it improves the performance of the non-idle entity, but
it is never advisable to indefinitely starve threads. That's a recipe
for hard lockups, priority inversion, etc.

Does your non-idle entity have a reasonable number of cpu.shares? You
can push out the round-robin interval by tuning CFS parameters without
completely starving the idle entity.

> There is another question I would like to take this opportunity to
> consult you. In our production environment, in some cases, we want to
> adjust the weight/shares of the idle-cgroup which means we need to
> change the logic of sched_group_set_shares(), and it can increase the
> probability of the above issue. So, for what reasons did you prohibit
> users from changing weights of idle cgroup.

The reason for limiting the control of weight for idle cgroups is to
match the semantics of the per-task SCHED_IDLE api, which gives
SCHED_IDLE threads minimum weight. The idea behind SCHED_IDLE is that
these entities are intended to soak "unused" cpu cycles, and should
give minimal interference to any non-idle thread. However, we don't
have strict priority between idle and non-idle, due to the potential
for starvation issues.

Perhaps you could clarify your use case a bit further. Why do you want
to change the weight? Is it to adjust the competition between two idle
groups, or something else?

>
> Thanks again for your review.
>
> Best,
> Chuyi
> > The wakeup check is useful for latency sensitive non-idle tasks.
> > However, in steady state competition between idle and non-idle, we
> > must allow some amount of round-robin.
> >
> >> +
> >>                  resched_curr(rq_of(cfs_rq));
> >> +       }
> >>   }
> >>
> >>   static void
> >> --
> >> 2.20.1
> >>
> >
> > Best,
> > Josh
