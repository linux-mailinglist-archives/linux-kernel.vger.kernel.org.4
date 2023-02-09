Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D341690E29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBIQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBIQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:17:02 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38255A906
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:16:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id x31so1895447pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hc4MeX1c+Bxvwl6tFU8f2oU+92oNePBGel71EpETfPc=;
        b=jcu+3GcCXR7bVLxo8bzuoII2qpLLGKPdA8JF6ryIu3Qzg0kOfrqG3wH2uILWl6YHvl
         DMSYBgage5rS/fx8NEEauT7emjsU1dNlVXUMwk8HEvpk7OtxoyS521CamkkzthnAFP67
         9ZiGUBtZT364mrcSAkZFlx0NfccVARwlHuiR0i4bZ3YS2vc3hD0oTMAnu7+zfPQ/ZC+q
         3ZLOQL6Huova4/duqOvm9jw4Ct2nhgupMkfrPQqnuLlDFTL2ibCiiDM8DTuTxMjCOXrs
         6Mcg+tPnjUq97sKLJJOYsQGYUHCS6aYMUfixNK5P/xtI0V55GSSZuHCu83mhKA0mfH4m
         Q9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hc4MeX1c+Bxvwl6tFU8f2oU+92oNePBGel71EpETfPc=;
        b=XxU/dO87hZlzfsDHFd5Bf697kUdlSfeb9m22sWqZ3MY42UBGENy+DpcOd7EJ/rEfd7
         IZpeJWF67Bk2YNjDFVgoVX8KZAtQsUCnbvq1OWkck6xktNQ2zcqkON1Lc/IM/5sRGXfh
         GKil3u618sDZFZLQWybLljmByGe3KNMxNMIbMmguwxq8SjCeCAgZm7nuAebRZRX2BDIH
         CQrtNSZB0XZEcRkTU0Ye2Wi592Hf9NieI/gCllF7xh8wziohSdsNaBz+1IouFZyslu5j
         2D7qKwS6AnyHDvDo0vZ6s0E+DK/qRLAvdqB0b6JavOys6GVS60qavaqaG670N1y4+L0Z
         KMug==
X-Gm-Message-State: AO0yUKX9/ZhAIuR2DiVUTUYt7Hem3LmDJXstz4UGUIDsiysakQTS5usT
        eX31883m5DdaNLNN/Sw810rejUCos3Pqcf0iRwlEOA==
X-Google-Smtp-Source: AK7set8Ovi6WSfofHcrSKkIfgFXghsv+8xHZN7k8Uef6nmxa10/d7pgautfCychgN0JIR9NBP/aCs8dHTOw5/cKwL4E=
X-Received: by 2002:a62:1407:0:b0:5a8:4b2b:33d4 with SMTP id
 7-20020a621407000000b005a84b2b33d4mr1036124pfu.5.1675959418381; Thu, 09 Feb
 2023 08:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net> <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net> <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
In-Reply-To: <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Feb 2023 17:16:46 +0100
Message-ID: <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 09/11/2022 16:49, Peter Zijlstra wrote:
> > On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
> >> On 11/07/22 14:41, Peter Zijlstra wrote:
> >>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
>
> [...]
>
> > So one thing that was key to that hack I proposed is that it is
> > per-task. This means we can either set or detect the task activation
> > period and use that to select an appropriate PELT multiplier.
> >
> > But please explain; once tasks are in a steady state (60HZ, 90HZ or god
> > forbit higher), the utilization should be the same between the various
> > PELT window sizes, provided the activation period isn't *much* larger
> > than the window.
> >
> > Are these things running a ton of single shot tasks or something daft
> > like that?
>
> This investigation tries to answer these questions. The results can
> be found in chapter (B) and (C).
>
> I ran 'util_est_faster' with delta equal to 'duration of the current
> activation'. I.e. the following patch is needed:
>
> https://lkml.kernel.org/r/ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com
>
> The testcase is Jankbench on Android 12 on Pixel6, CPU orig capacity
> = [124 124 124 124 427 427 1024 1024], w/ mainline v5.18 kernel and
> forward ported task scheduler patches.
>
> (A) *** 'util_est_faster' vs. 'scaled util_est_faster' ***
>
> The initial approach didn't scale the runtime duration. It is based
> on task clock and not PELT clock but it should be scaled by uArch
> and frequency to align with the PELT time used for util tracking.
>
> Although the original approach shows better results than the scaled
> one. Even more aggressive boosting on non-big CPUs helps to raise the
> frequency even quicker in the scenario described under (B).
>
> All tests ran 10 iterations of all Jankbench sub-tests.
>
> Max_frame_duration:
> +------------------------+------------+
> |             kernel     |    value   |
> +------------------------+------------+
> |   base-a30b17f016b0    | 147.571352 |
> |    util_est_faster     | 84.834999  |
> | scaled_util_est_faster | 127.72855  |
> +------------------------+------------+
>
> Mean_frame_duration:
> +------------------------+-------+-----------+
> |             kernel     | value | perc_diff |
> +------------------------+-------+-----------+
> |   base-a30b17f016b0    | 14.7  |   0.0%    |
> |    util_est_faster     | 12.6  |  -14.01%  |
> | scaled_util_est_faster | 13.5  |  -8.45%   |
> +------------------------+-------------------+
>
> Jank percentage (Jank deadline 16ms):
> +------------------------+-------+-----------+
> |             kernel     | value | perc_diff |
> +------------------------+-------+-----------+
> |   base-a30b17f016b0    |  1.8  |   0.0%    |
> |    util_est_faster     |  0.8  |  -57.8%   |
> | scaled_util_est_faster |  1.4  |  -25.89%  |
> +------------------------+-------+-----------+
>
> Power usage [mW] (total - all CPUs):
> +------------------------+-------+-----------+
> |             kernel     | value | perc_diff |
> +------------------------+-------+-----------+
> |   base-a30b17f016b0    | 144.4 |   0.0%    |
> |    util_est_faster     | 150.9 |   4.45%   |
> | scaled_util_est_faster | 152.2 |   5.4%    |
> +------------------------+-------+-----------+
>
> 'scaled util_est_faster' is used as the base for all following tests.
>
> (B) *** Where does util_est_faster help exactly? ***
>
> It turns out that the score improvement comes from the more aggressive
> DVFS request ('_freq') (1) due to the CPU util boost in sugov_get_util()
> -> effective_cpu_util(..., cpu_util_cfs(), ...).
>
> At the beginning of an episode (e.g. beginning of an image list view
> fling) when the periodic tasks (~1/16ms (60Hz) at 'max uArch'/'max CPU
> frequency') of the Android Graphics Pipeline (AGP) start to run, the
> CPU Operating Performance Point (OPP) is often so low that those tasks
> run more like 10/16ms which let the test application count a lot of
> Jankframes at those moments.

I don't see how util_est_faster can help this 1ms task here ? It's
most probably never be preempted during this 1ms. For such an Android
Graphics Pipeline short task, hasn't uclamp_min been designed for and
a better solution ?

>
> And there is where this util_est_faster approach helps by boosting CPU
> util according to the 'runtime of the current activation'.
> Moreover it could also be that the tasks have simply more work to do in
> these first activations at the beginning of an episode.
>
> All the other places in which cpu_util_cfs() is used:
>
> (2) CFS load balance ('_lb')
> (3) CPU overutilization ('_ou')
> (4) CFS fork/exec task placement ('_slowpath')
>
> when tested individually don't show any improvement or even regression.
>
> Max_frame_duration:
> +---------------------------------+------------+
> |             kernel              |    value   |
> +---------------------------------+------------+
> |     scaled_util_est_faster      | 127.72855  |
> |   scaled_util_est_faster_freq   | 126.646506 |
> |    scaled_util_est_faster_lb    | 162.596249 |
> |    scaled_util_est_faster_ou    | 166.59519  |
> | scaled_util_est_faster_slowpath | 153.966638 |
> +---------------------------------+------------+
>
> Mean_frame_duration:
> +---------------------------------+-------+-----------+
> |             kernel              | value | perc_diff |
> +---------------------------------+-------+-----------+
> |     scaled_util_est_faster      | 13.5  |   0.0%    |
> |   scaled_util_est_faster_freq   | 13.7  |   1.79%   |
> |    scaled_util_est_faster_lb    | 14.8  |   9.87%   |
> |    scaled_util_est_faster_ou    | 14.5  |   7.46%   |
> | scaled_util_est_faster_slowpath | 16.2  |  20.45%   |
> +---------------------------------+-------+-----------+
>
> Jank percentage (Jank deadline 16ms):
> +---------------------------------+-------+-----------+
> |             kernel              | value | perc_diff |
> +---------------------------------+-------+-----------+
> |     scaled_util_est_faster      |  1.4  |   0.0%    |
> |   scaled_util_est_faster_freq   |  1.3  |  -2.34%   |
> |    scaled_util_est_faster_lb    |  1.7  |  27.42%   |
> |    scaled_util_est_faster_ou    |  2.1  |  50.33%   |
> | scaled_util_est_faster_slowpath |  2.8  |  102.39%  |
> +---------------------------------+-------+-----------+
>
> Power usage [mW] (total - all CPUs):
> +---------------------------------+-------+-----------+
> |             kernel              | value | perc_diff |
> +---------------------------------+-------+-----------+
> |     scaled_util_est_faster      | 152.2 |   0.0%    |
> |   scaled_util_est_faster_freq   | 132.3 |  -13.1%   |
> |    scaled_util_est_faster_lb    | 137.1 |  -9.96%   |
> |    scaled_util_est_faster_ou    | 132.4 |  -13.04%  |
> | scaled_util_est_faster_slowpath | 141.3 |  -7.18%   |
> +---------------------------------+-------+-----------+
>
> (C) *** Which tasks contribute the most to the score improvement? ***
>
> A trace_event capturing the cases in which task's util_est_fast trumps
> CPU util was added to cpu_util_cfs(). This is 1 iteration of Jankbench
> and the base is (1) 'scaled_util_est_faster_freq':
>
> https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/util_est_faster_6.ipynb
>
> 'Cell [6]' shows the tasks of the Jankbench process
> '[com.an]droid.benchmark' which are boosting the CPU frequency request.
>
> Among them are 2 main threads of the AGP, '[com.an]droid.benchmark' and
> 'RenderThread'.
> The spikes in util_est_fast are congruent with the aforementioned
> beginning of an episode in which these periodic tasks are running and
> when their runtime/period is rather ~10/16ms and not ~1-2/16ms since
> the CPU OPP is still low.
>
> Very few other Jankbench tasks 'Cell [6] show the same behaviour. The
> Surfaceflinger process 'Cell [8]' is not affected and from the kernel
> tasks only kcompctd0 creates a mild boost 'Cell [9]'.
>
> As expected, running a non-scaled version of (1) shows more aggressive
> boosting on non-big CPUs:
>
> https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/util_est_faster_5.ipynb
>
> Looks like that 'util_est_faster' can prevent Jankframes by boosting CPU
> util when periodic tasks have a longer runtime compared to when they reach
> steady-sate.
>
> The results is very similar to PELT halflife reduction. The advantage is
> that 'util_est_faster' is only activated selectively when the runtime of
> the current task in its current activation is long enough to create this
> CPU util boost.

IIUC how util_est_faster works, it removes the waiting time when
sharing cpu time with other tasks. So as long as there is no (runnable
but not running time), the result is the same as current util_est.
util_est_faster makes a difference only when the task alternates
between runnable and running slices.
Have you considered using runnable_avg metrics in the increase of cpu
freq ? This takes into the runnable slice and not only the running
time and increase faster than util_avg when tasks compete for the same
CPU

>
> Original patch:
> https://lkml.kernel.org/r/Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net
>
> Changes applied:
> - use 'duration of the current activation' as delta
> - delta >>= 10
> - uArch and frequency scaling of delta
>
> -->%--
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index efdc29c42161..76d146d06bbe 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -97,6 +97,7 @@ SCHED_FEAT(WA_BIAS, true)
>   */
>  SCHED_FEAT(UTIL_EST, true)
>  SCHED_FEAT(UTIL_EST_FASTUP, true)
> +SCHED_FEAT(UTIL_EST_FASTER, true)
>
>  SCHED_FEAT(LATENCY_WARN, false)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 0f310768260c..13cd9e27ce3e 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -148,6 +148,22 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
>         return periods;
>  }
>
> +/*
> + * Compute a pelt util_avg assuming no history and @delta runtime.
> + */
> +unsigned long faster_est_approx(u64 delta)
> +{
> +       unsigned long contrib = (unsigned long)delta; /* p == 0 -> delta < 1024 */
> +       u64 periods = delta / 1024;
> +
> +       if (periods) {
> +               delta %= 1024;
> +               contrib = __accumulate_pelt_segments(periods, 1024, delta);
> +       }
> +
> +       return (contrib << SCHED_CAPACITY_SHIFT) / PELT_MIN_DIVIDER;
> +}
> +
>  /*
>   * We can represent the historical contribution to runnable average as the
>   * coefficients of a geometric series.  To do this we sub-divide our runnable
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1072502976df..7cb45f1d8062 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2961,6 +2961,8 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>         return READ_ONCE(rq->avg_dl.util_avg);
>  }
>
> +extern unsigned long faster_est_approx(u64 runtime);
> +
>  /**
>   * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
>   * @cpu: the CPU to get the utilization for.
> @@ -2995,13 +2997,39 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>   */
>  static inline unsigned long cpu_util_cfs(int cpu)
>  {
> +       struct rq *rq = cpu_rq(cpu);
>         struct cfs_rq *cfs_rq;
>         unsigned long util;
>
> -       cfs_rq = &cpu_rq(cpu)->cfs;
> +       cfs_rq = &rq->cfs;
>         util = READ_ONCE(cfs_rq->avg.util_avg);
>
>         if (sched_feat(UTIL_EST)) {
> +               if (sched_feat(UTIL_EST_FASTER)) {
> +                       struct task_struct *curr;
> +
> +                       rcu_read_lock();
> +                       curr = rcu_dereference(rq->curr);
> +                       if (likely(curr->sched_class == &fair_sched_class)) {
> +                               unsigned long util_est_fast;
> +                               u64 delta;
> +
> +                               delta = curr->se.sum_exec_runtime -
> +                                       curr->se.prev_sum_exec_runtime_vol;
> +
> +                               delta >>= 10;
> +                               if (!delta)
> +                                       goto unlock;
> +
> +                               delta = cap_scale(delta, arch_scale_cpu_capacity(cpu));
> +                               delta = cap_scale(delta, arch_scale_freq_capacity(cpu));
> +
> +                               util_est_fast = faster_est_approx(delta * 2);
> +                               util = max(util, util_est_fast);
> +                       }
> +unlock:
> +                       rcu_read_unlock();
> +               }
>                 util = max_t(unsigned long, util,
>                              READ_ONCE(cfs_rq->avg.util_est.enqueued));
>         }
