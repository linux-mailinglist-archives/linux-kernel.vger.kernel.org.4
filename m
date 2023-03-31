Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB756D2026
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjCaMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjCaMYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:24:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7C1FD11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:24:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id cm5so8844512pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680265449; x=1682857449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=clsagZH1IzV6mZqufirnmuxwVgE4mGAL1lL14PTuQ+4=;
        b=iN8qlYT5wNxoNS2qn8M0mxaV8gs52GYPc0QkRua3ybKEX4braC2vT9cF5NxBQb36C2
         o8HIQqsptHaYHevc5+hS9EiruhZk5r/Jh3EdFWjrleiqUl7N77y1IE+5GYGsUHEQYP1u
         kh9W5FEFpyWzg+8dKVqvD7FAME5J+TCo1miw8sCslRFoBwwNOZaMICaovzeJGyn6vjqW
         IrArF5IQLfnBqBOoO621/UgS6IBXsXhjLKK04dXTjOje4CRwyn1wSK7Iby5ZZ5PAXdnk
         mRV+vV6N8twXRPWaA4bmSmRFYZ89I+/Ztea3oMMmmCMhUo++fVaydK1xz2H35uyGdQ5K
         rPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680265449; x=1682857449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clsagZH1IzV6mZqufirnmuxwVgE4mGAL1lL14PTuQ+4=;
        b=MBkjTSnLXSRrgUE54HSmv6Lv7VxATJ74f2RWDZVW++R4JWltrTBx+Con9PZbMtPhqO
         TeF07inCjODEcs/ItEtfeKBF0D8zdurJ8ThoTSj35d3qH2639zNSipdwwdR0OrYKl+SK
         zbnboRjefgVwF/PzNQRFmB0k2/bYuq11cg6DRNc0A0zBNOcNGYn5MdzNUMasAm7Dri6s
         wGmBbgjCc9mzQ0CApAm8Dwu/6bTXa01H6T+e2ZJzMhaiBdS5Q7Rcoj1dsbgkjfCtLQ7b
         FQapbfPEwakg9MIZ/UPa6t9fMeXuT4gD13un2+lq9qUbDxCvuzw1cr7pvShJZzfTIdAK
         9AhQ==
X-Gm-Message-State: AAQBX9fK3EB82SFNAWK/uW230PkjRae9qmqBXf5s3tcvTfLmMop5x1ow
        zWFq3DVj2vFA6CQqAY1VSqnt6iQIapGicECXrzeLnA==
X-Google-Smtp-Source: AKy350a2wr3Q2CoMvwfvL505VAT9USptyWSt1TaxP4iekhbCIgfZfUcgTN1p+vJsBWlzv33HA+8DpXNgkTQ5dO4hns4=
X-Received: by 2002:a63:4f42:0:b0:513:a24c:f45a with SMTP id
 p2-20020a634f42000000b00513a24cf45amr1576366pgl.11.1680265449447; Fri, 31 Mar
 2023 05:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-11-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtAciJr-ZQWcJN3bHZHyHmjmSOuDYZz9UwfK2EnMVPX6aQ@mail.gmail.com> <20230330021431.GB26315@ranerica-svr.sc.intel.com>
In-Reply-To: <20230330021431.GB26315@ranerica-svr.sc.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 31 Mar 2023 14:23:58 +0200
Message-ID: <CAKfTPtCUVbiVJxRHx_AcXbfm-SeW1ATE8QZ-jOqyfMh+PLwAjw@mail.gmail.com>
Subject: Re: [PATCH v3 10/24] sched/fair: Use IPCC scores to select a busiest runqueue
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 at 04:03, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Tue, Mar 28, 2023 at 12:03:58PM +0200, Vincent Guittot wrote:
> > On Tue, 7 Feb 2023 at 06:01, Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > For two runqueues of equal priority and equal number of running of tasks,
> > > select the one whose current task would have the highest IPC class score
> > > if placed on the destination CPU.
> >
> > You failed to explain why it make sense to compare current task score
> > whereas we will most probably not pull this task at the end
>
> Thank you for your feedback Vincent! Please kindly refer to my reply to
> your feedback in patch 7.
>
> > >
> > > For now, use IPCC scores only for scheduling domains with the
> > > SD_ASYM_PACKING flag.
> > >
> > > Cc: Ben Segall <bsegall@google.com>
> > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > Cc: Mel Gorman <mgorman@suse.de>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > Changes since v2:
> > >  * Only use IPCC scores to break ties if the sched domain uses
> > >    asym_packing. (Ionela)
> > >  * Handle errors of arch_get_ipcc_score(). (Ionela)
> > >
> > > Changes since v1:
> > >  * Fixed a bug when selecting a busiest runqueue: when comparing two
> > >    runqueues with equal nr_running, we must compute the IPCC score delta
> > >    of both.
> > >  * Renamed local variables to improve the layout of the code block.
> > >    (PeterZ)
> > >  * Used the new interface names.
> > > ---
> > >  kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 72d88270b320..d3c22dc145f7 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9399,6 +9399,37 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> > >         return sched_asym_ipcc_prefer(a_stats, b_stats);
> > >  }
> > >
> > > +/**
> > > + * ipcc_score_delta - Get the IPCC score delta wrt the load balance's dst_cpu
> > > + * @p:         A task
> > > + * @env:       Load balancing environment
> > > + *
> > > + * Returns: The IPCC score delta that @p would get if placed in the destination
> > > + * CPU of @env. LONG_MIN to indicate that the delta should not be used.
> > > + */
> > > +static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
> > > +{
> > > +       unsigned long score_src, score_dst;
> > > +       unsigned short ipcc = p->ipcc;
> > > +
> > > +       if (!sched_ipcc_enabled())
> > > +               return LONG_MIN;
> > > +
> > > +       /* Only asym_packing uses IPCC scores at the moment. */
> > > +       if (!(env->sd->flags & SD_ASYM_PACKING))
> > > +               return LONG_MIN;
> > > +
> > > +       score_dst = arch_get_ipcc_score(ipcc, env->dst_cpu);
> > > +       if (IS_ERR_VALUE(score_dst))
> > > +               return LONG_MIN;
> > > +
> > > +       score_src = arch_get_ipcc_score(ipcc, task_cpu(p));
> > > +       if (IS_ERR_VALUE(score_src))
> > > +               return LONG_MIN;
> > > +
> > > +       return score_dst - score_src;
> > > +}
> > > +
> > >  #else /* CONFIG_IPC_CLASSES */
> > >  static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> > >                                     struct rq *rq)
> > > @@ -9429,6 +9460,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> > >         return false;
> > >  }
> > >
> > > +static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
> > > +{
> > > +       return LONG_MIN;
> > > +}
> > > +
> > >  #endif /* CONFIG_IPC_CLASSES */
> > >
> > >  /**
> > > @@ -10589,6 +10625,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >  {
> > >         struct rq *busiest = NULL, *rq;
> > >         unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> > > +       long busiest_ipcc_delta = LONG_MIN;
> > >         unsigned int busiest_nr = 0;
> > >         int i;
> > >
> > > @@ -10705,8 +10742,35 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >
> > >                 case migrate_task:
> > >                         if (busiest_nr < nr_running) {
> > > +                               struct task_struct *curr;
> > > +
> > >                                 busiest_nr = nr_running;
> > >                                 busiest = rq;
> > > +
> > > +                               /*
> > > +                                * Remember the IPCC score delta of busiest::curr.
> > > +                                * We may need it to break a tie with other queues
> > > +                                * with equal nr_running.
> > > +                                */
> > > +                               curr = rcu_dereference(busiest->curr);
> > > +                               busiest_ipcc_delta = ipcc_score_delta(curr, env);
> >
> > Hmm, i don't like this at all
> >
> > Also, curr is the least probable task to be pulled which means that
> > all this his useless
>
> but when doing asym_packing balancing nr_running = 1, need_active_balance()
> returns true and we will pull the current task, no? This is also true for
> fully_busy groups with one task per CPU. These are the only two cases that
> currently use IPCC scores.

hmm, for sure it's not true for fully_busy and I don't see anything
about asym_packing mandating that  nr_running = 1

You should have a look at misfit task which seems to better fit your
situation where you have one task that doesn't fit  its cpu instead of
adding such condition
>
> If there are more than one tasks in the runqueue, the group will be
> classified as overloaded and we will not use IPCC scores nor active
> balance.
>
> Thanks and BR,
> Ricardo
