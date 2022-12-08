Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04940646D13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiLHKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLHKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:33:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643183EA8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:31:54 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id j28so282101ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ekXDW6NKqQAtjK+zDFtGFfwc8w0TI9ziiAyFM4g2xo0=;
        b=nRHE+hC42Lrzix3djG4QgHIHW2WW7ZzruP5AAyy2x6XQzERMd1gtJsYBaOp3gVX/1s
         YZTtPIXvzdwur5a7Uz8X7i68sLqEJgztKmIieu9O9mTxB4SoWQr2z+TQjRrzkGTM2aqH
         4wdp2azsMX85Mq9s2LVBig4SyUYzOe68adt8UBeLRtcqhXCMWG8Dnxy9I8ElkUnfeFV+
         PqesVAsyfADFYeiOd1cRLpRFklfIn5Z+Zu8FHKbSJpTb3XtNDrmUpAar8MfTxJezMFA6
         KZFV3ZW/mH1XykGp6TQCq0EKsOKxWwB2riwgMdFfiBDP2HmWHP9MO10fRR6GZ1PWVMi5
         RjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekXDW6NKqQAtjK+zDFtGFfwc8w0TI9ziiAyFM4g2xo0=;
        b=43HqdKnZ21cnIC6Ovd7lNZvA+/Ff3d//QoY5lekRuRdrrubEzkdC8EuFXuuSY+TcHs
         hFnzVhe6JwwUUolv8hHMDBfmFA7M7KyRnZ+SjrwFVUZOQ/yw8ec7HjRZXVPufkXbbses
         aZ2HXFTIYjc7L448PYUxbMLMr4nf3NFiYTcYKkPWx7inl3KaMfpYA4lJyE3pLUBZ9WqK
         WIpU70X7J69Um8Z8acZotDPLamXfS81FjSsT/tY3OnSA79CV37daazdnK0nvGwyqYlwS
         Tve6M3wGEjbmafqMIH2va5WLGx3+5sf0m/hQXzmuxMpCGCQLlSIUjuxFRg9sY8kScA5K
         Btjw==
X-Gm-Message-State: ANoB5pmwWoM0etmx38vOC9Jh/wRxDQUJXob01IcPubb1ozPkZoiTp7Wq
        YUlaxz7G0ouXlaBMhSAbgmpx//X/UjqY9FfnbehQxA==
X-Google-Smtp-Source: AA0mqf6g60r6Y9owqdzC7cwzUZ723g9PHLsEAJbP82mnxJAxyZo2RQRYDwk7I6+JzYOCP03sS8961i9AZSbfuXwNXTQ=
X-Received: by 2002:a92:870e:0:b0:2fa:f47:d960 with SMTP id
 m14-20020a92870e000000b002fa0f47d960mr34171199ild.19.1670495507923; Thu, 08
 Dec 2022 02:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20221207101705.9460-1-lukasz.luba@arm.com> <20221207101705.9460-3-lukasz.luba@arm.com>
 <CAKfTPtB8f0RH4qToLrWS+HSZhm8pyUe42DijiXZqo+mQQPWetQ@mail.gmail.com> <7428f6dd-9403-180b-d4b4-7ef1aee3dcb1@arm.com>
In-Reply-To: <7428f6dd-9403-180b-d4b4-7ef1aee3dcb1@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 8 Dec 2022 11:31:36 +0100
Message-ID: <CAKfTPtDoZ2paL7DW+JsML8aKeVzwu4oSnojij1osqJzNhO4ceA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: schedutil: Optimize operations with
 single max CPU capacity
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 at 11:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 12/8/22 08:37, Vincent Guittot wrote:
> > On Wed, 7 Dec 2022 at 11:17, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The max CPU capacity is the same for all CPUs sharing frequency domain
> >> and thus 'policy' object. There is a way to avoid heavy operations
> >> in a loop for each CPU by leveraging this knowledge. Thus, simplify
> >> the looping code in the sugov_next_freq_shared() and drop heavy
> >> multiplications. Instead, use simple max() to get the highest utilization
> >> from these CPUs. This is useful for platforms with many (4 or 6) little
> >> CPUs.
> >>
> >> The max CPU capacity must be fetched every time we are called, due to
> >> difficulties during the policy setup, where we are not able to get the
> >> normalized CPU capacity at the right time.
> >>
> >> The stored value in sugov_policy::max is also than used in
> >> sugov_iowait_apply() to calculate the right boost. Thus, that field is
> >> useful to have in that sugov_policy struct.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   kernel/sched/cpufreq_schedutil.c | 22 +++++++++++-----------
> >>   1 file changed, 11 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> index c19d6de67b7a..f9881f3d9488 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -158,10 +158,8 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >>
> >>   static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >>   {
> >> -       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> >>          struct rq *rq = cpu_rq(sg_cpu->cpu);
> >>
> >> -       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >>          sg_cpu->bw_dl = cpu_bw_dl(rq);
> >>          sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
> >>                                            FREQUENCY_UTIL, NULL);
> >> @@ -317,6 +315,8 @@ static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
> >>   static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> >>                                                u64 time, unsigned int flags)
> >>   {
> >> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> >> +
> >>          sugov_iowait_boost(sg_cpu, time, flags);
> >>          sg_cpu->last_update = time;
> >>
> >> @@ -325,6 +325,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> >>          if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> >>                  return false;
> >>
> >> +       /* Fetch the latest CPU capcity to avoid stale data */
> >> +       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >> +
> >>          sugov_get_util(sg_cpu);
> >>          sugov_iowait_apply(sg_cpu, time);
> >>
> >> @@ -414,25 +417,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> >>   {
> >>          struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> >>          struct cpufreq_policy *policy = sg_policy->policy;
> >> -       unsigned long util = 0, max = 1;
> >> +       unsigned long util = 0;
> >>          unsigned int j;
> >>
> >> +       /* Fetch the latest CPU capcity to avoid stale data */
> >> +       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >> +
> >>          for_each_cpu(j, policy->cpus) {
> >>                  struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> >> -               unsigned long j_util, j_max;
> >>
> >>                  sugov_get_util(j_sg_cpu);
> >>                  sugov_iowait_apply(j_sg_cpu, time);
> >> -               j_util = j_sg_cpu->util;
> >> -               j_max = j_sg_cpu->max;
> >>
> >> -               if (j_util * max > j_max * util) {
> >> -                       util = j_util;
> >> -                       max = j_max;
> >> -               }
> >
> > With the code removed above, max is only used in 2 places:
> > - sugov_iowait_apply
> > - map_util_freq
> >
> > I wonder if it would be better to just call arch_scale_cpu_capacity()
> > in these 2 places instead of saving a copy in sg_policy and then
> > reading it twice.
>
> The sugov_iowait_apply() is called in that loop, so probably I will
> add a new argument to that call and just feed it with the capacity value
> from one CPU, which was read before the loop. So, similarly what is in
> this patch. Otherwise, all of those per-cpu capacity vars would be
> accessed inside the sugov_iowait_apply() with sg_cpu->cpu.

Yes make sense

>
> >
> > arch_scaleu_cpu_capacity is already a per_cpu variable so accessing it
> > should be pretty cheap.
>
> Yes and no, as you said this is per-cpu variable and would access them
> from one CPU, which is running that loop. They will have different pages
> and addresses so cache lines on that CPU. to avoiding trashing a cache
> lines on this running CPU let's read that capacity once, before the
> loop. Let's use the new arg to pass that value via one of the
> registers. In such, only one cache line would have to fetch that data
> into.
>
> So I thought this simple sg_policy->max would do the trick w/o a lot
> of hassle.

For the shared mode, everything is located in sugov_next_freq_shared
so you don't need to save the max value with your proposal above to
change sugov_iowait_apply interface.

This should be doable as well for single mode

> >
> > Thought ?
> >
>
> I can change that and drop the sg_policy->max and call differently
> those capacity values. I will have to unfortunately drop Viresh's ACKs,
> since this will be a way different code.
>
> Thanks Vincent for the suggestion. Do you want me to go further with
> such approach and send a v3?

Don't know what Rafael and Viresh think but it seems that we don't
need to save the return of arch_scale_cpu_capacity in ->max field but
directly use it
