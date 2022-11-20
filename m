Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615D631694
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKTVaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 16:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKTVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 16:30:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D3425EA0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 13:30:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z4so2665253wrr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 13:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfvJoANVWbanhOs/TF+7WwEWoyEpNJLnWZl2PQtH1AI=;
        b=yfjx64Ga4tNFLh73Xt77brWkITWZDwAwy2GRS8NrhRdfI0tIvm2Nax9NzEoWLlWRVX
         jFe86P8lRzxHT9soimm0BWeQjCNtOE0UxYCS15SuPmQh/pRmyZzO+R7yWJe5RTwA96B+
         hpGv9b4+3XWBTYj5V0k8AGCl8a7AAStFwZ0arkG3h2UVNphDhrfjfvHo3MM1FzwMoOx7
         bIXcM81VaBEIOixNjJ/iYTOJKM76VT9jaIM46TAjFGyE/nEO/pCfXfQOgKHFMNxweeAj
         byqzVBQNUZd4bLAbQMMcCK+iwgIZqWcNywE1KxzhCOwf5y4kMzIXSp21SWPECZSmC2hR
         ydPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfvJoANVWbanhOs/TF+7WwEWoyEpNJLnWZl2PQtH1AI=;
        b=L1Tw6V4FlY6srILQ85F/mNZycbsfgPx71C7eftYGZ5sxYKIpNNKoaQvN76p9G76mCy
         60URhvNozu03VPuWtSc4bQGH08Lhv/wCRwxAT42yD4QWZ1zyZONiGTW6GXFqko2iFZti
         zaO+fwJma2Wu6ab2Kd+w7UhoB6fVPQ0O/2gcFAtpaSEseVqv5OoT7ifunL6XiwWy+jJZ
         1PTXKrDL0qtlECnmxnLUJW/smFzcIxOdlHXeHQqA7vAKoZVAnPclIkz24bdTndMklwmI
         r/2gXkYiL33YdyKffSuM5CW3cGa7xvb/RknGgjLAZjPL71ScX6bZ8kPrPYxpNyLMJC+I
         RNUA==
X-Gm-Message-State: ANoB5pl2ZkWlwSyrgXlgylYmJGVQ1Dw+VkVPI/rgY6XuUjiNHaPkacBi
        /5eQHBZHWM1l4lVz/6UvFUtHAg==
X-Google-Smtp-Source: AA0mqf55avG/3hpcTfaACgmf/g99gvBvhEBE9CRcO2O/vZuOVz612v1Wo5FJwJNX2zhkQkoWlYaOWw==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr9060545wrf.546.1668979814876;
        Sun, 20 Nov 2022 13:30:14 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600000c300b00241c8794d38sm5598437wrx.105.2022.11.20.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 13:30:14 -0800 (PST)
Date:   Sun, 20 Nov 2022 21:30:13 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH v2 8/9] sched/fair: Detect capacity inversion
Message-ID: <20221120213013.t67xisvqxmftri52@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-9-qais.yousef@arm.com>
 <68f22089-b3bb-f1da-1fd8-d8a1be34654a@arm.com>
 <20221112193522.g4hhpdlywndvik7r@airbuntu>
 <5ec773d4-0a19-cc04-e3bc-4cb57cf55b09@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ec773d4-0a19-cc04-e3bc-4cb57cf55b09@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 18:45, Dietmar Eggemann wrote:
> On 12/11/2022 20:35, Qais Yousef wrote:
> > On 11/09/22 11:42, Dietmar Eggemann wrote:
> > 
> 
> [...]
> 
> >>> +			 * thermal pressure. We record it as capacity
> >>> +			 * inversion.
> >>> +			 */
> >>> +			if (capacity_orig == pd_cap_orig) {
> >>> +				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
> >>> +
> >>> +				if (pd_cap > inv_cap) {
> >>> +					rq->cpu_capacity_inverted = inv_cap;
> >>> +					break;
> >>> +				}
> >>
> >> In case `capacity_orig == pd_cap_orig` and cpumask_test_cpu(cpu_of(rq),
> >> pd_span) the code can set rq->cpu_capacity_inverted = inv_cap
> >> erroneously since thermal_load_avg(rq) can return different values for
> >> inv_cap and pd_cap.
> > 
> > Good catch!
> > 
> >>
> >> So even on a classical big little system, this condition can set
> >> rq->cpu_capacity_inverted for a CPU in the little or big cluster.
> >>
> >> thermal_load_avg(rq) would have to stay constant for all CPUs within the
> >> PD to avoid this.
> >>
> >> This is one example of the `thermal pressure` is per PD (or Frequency
> >> Domain) in Thermal but per-CPU in the task scheduler.
> > 
> > Only compile tested so far, does this patch address all your points? I should
> > get hardware soon to run some tests and send the patch. I might re-write it to
> > avoid using pds; though it seems cleaner this way but we miss CAS support.
> > 
> > Thoughts?
> 
> I still don't think that the `CPU capacity inversion` implementation
> which uses `cap_orig' = cap_orig - thermal load avg (2)` instead of
> `cap_orig'' = cap_orig - thermal pressure (1)` for inverted CPUs (i.e.
> other PD exists w/ cap_orig > cap_orig') is the right answer, besides
> the EAS vs. CAS coverage.
> 
> The basic question for me is why do we have to switch between (1) and
> (2)? IIRC we introduced (1) in feec() to cater for the CPUfreq policy
> min/max capping between schedutil and the CPUfreq driver
> __resolve_freq() [drivers/cpufreq/cpufreq.c] (3).
> 
> The policy caps are set together with thermal pressure in
> cpufreq_set_cur_state() [drivers/thermal/cpufreq_cooling.c] via
> freq_qos_update_request().
> 
> I think we should only use (2) in the task scheduler even though the
> EAS-schedutil machinery would be not 100% in sync in some cases due to (3).
> Thermal load avg has similar properties like all the other EWMA-based
> signals we use and we have to live with a certain degree of inaccuracy
> anyway (e.g. also because of lock-less CPU statistic fetching when
> selecting CPU).
> 
> And in this case we wouldn't have to have infrastructure to switch
> between (1) and (2) at all.
> 
> To illustrate the problem I ran 2 workloads (hackbench/sleep) on a H960
> board with step-wise thermal governor tracing thermal load_avg
> (sched_pelt_thermal), thermal pressure (thermal_pressure_update) and CPU
> capacity (sched_cpu_capacity). Would we really gain something
> substantial reliably when we would know the diff between (1) and (2)?
> 
> https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/thermal_pressure.ipynb
> 

So what you're asking for is to switch to this?

	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
	index b01854984994..989f1947bd34 100644
	--- a/kernel/sched/fair.c
	+++ b/kernel/sched/fair.c
	@@ -8862,7 +8862,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)

			rcu_read_lock();

	-               inv_cap = capacity_orig - thermal_load_avg(rq);
	+               inv_cap = capacity_orig - arch_scale_thermal_pressure(rq);
			pd = rcu_dereference(rq->rd->pd);
			rq->cpu_capacity_inverted = 0;

	@@ -8887,7 +8887,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
				 * inversion.
				 */
				if (capacity_orig == pd_cap_orig) {
	-                               pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
	+                               pd_cap = pd_cap_orig - arch_scale_thermal_pressure(cpu_rq(cpu));

					if (pd_cap > inv_cap) {
						rq->cpu_capacity_inverted = inv_cap;

My main worry is that rq->cpu_capacity which is updated in the same location
uses thermal_load_avg(). The consistency was important IMO. Besides I think we
need good certainty the inversion is there - we don't want to be oscillating.
Say the big core thermal pressure is increasing and it is entering capacity
inversion. If we don't use the average we'd be avoiding the cpu one tick, but
place something that drives freq high on it the next tick. This ping-pong could
end up not giving the big cores some breathing room to cool down and settle on
one state, no?

I think Lukasz patch [1] is very important in controlling this aspect. And it
might help make the code more consistent by enabling switching all users to
thermal_load_avg() if we can speed up its reaction time sufficiently.

That said; I don't have a bullet proof answer or a very strong opinion about
it. Either direction we take I think we'll have room for improvements. It
seemed the safer more sensible option to me at this stage.

[1] https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/


Thanks!

--
Qais Yousef
