Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E447A626B40
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiKLTfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 14:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 14:35:28 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6192D140AF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 11:35:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v1so10643697wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSDqT7HKoa6xfAycV0dGpq11W5vUP2HfP9u/U2LDhHE=;
        b=uQv1cACKXaw14g+DA585hYXWVJo4NPQBaWuW/t4arxuVgrVlQSMWH+C0oFGTLElTop
         qllde0piINJ9hnp1T3vPzPdtu+F3YOLi9Z2bFfXL4CPzDs8+rAnS56i0orf3p1X0czYo
         uNS+SrqXDZc6sOfWGvdOPNClcgcI9ppRd0599Ig/DcL1pFiZU8N/saUUDALXESUxJZ40
         ZgBrSEsu4cO7myUqhv5kZFTUBfiwffwjR7JHmadW9tf8ngXD2t449awhDMN/sEdj3QIN
         2pqTO+X8pwglBYvjtGUXwnpdOqQpgAtAQMPI841k1bsqyGtZovXXqfPFijKZwJZt9ebk
         7DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSDqT7HKoa6xfAycV0dGpq11W5vUP2HfP9u/U2LDhHE=;
        b=NwgJ1Xo3JUZ5V/xGTaUVxzyrsrzEbW8L11O1L0mOMM/5qb7UFBUKkH0S6oBDX4Happ
         yVUvRUS2lsCFLgPHplTSa5ep/TAWFYpRh7yK8AxfUOsn5E+IOnNdp/qDqCLzXO2x2F02
         seRLdUcD4wrtTl02ezTcW0TozvOTWhRKcUgwA/dZsD5UoF6OIA2mUyXRyw71mHiJrBvD
         E49cFw2uu9+pnBWnomlWLTX7JCGamqVo9NtiAXvEEzz/Tlt7TL5SGfd7hP6LFwSx465s
         WCC5lTVSXnlNw64Mp8Xk1pHdIAdfkkD+YzL6VRrSBJPDP2uVMeiU01Jqa8oWsYxJFyn1
         9uBw==
X-Gm-Message-State: ANoB5pn4+SC7DWb8JolEg1BjDLrSi8DrrhBt5/WCtoKp+nJvachy8q1O
        XzKu+kwSByfALA/eje7dZQR8ew==
X-Google-Smtp-Source: AA0mqf4zjbrShS0BIcSD7695IiWE9eqEowI1CPK4OBOBGQf5310aSBvruP5OZllStxWIqGUOnNSyqg==
X-Received: by 2002:adf:f386:0:b0:234:e918:6ba2 with SMTP id m6-20020adff386000000b00234e9186ba2mr3949118wro.23.1668281724788;
        Sat, 12 Nov 2022 11:35:24 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id s13-20020adfea8d000000b00228d67db06esm5098863wrm.21.2022.11.12.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 11:35:24 -0800 (PST)
Date:   Sat, 12 Nov 2022 19:35:22 +0000
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
Message-ID: <20221112193522.g4hhpdlywndvik7r@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-9-qais.yousef@arm.com>
 <68f22089-b3bb-f1da-1fd8-d8a1be34654a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68f22089-b3bb-f1da-1fd8-d8a1be34654a@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/22 11:42, Dietmar Eggemann wrote:

[...]

> > +	/*
> > +	 * Detect if the performance domain is in capacity inversion state.
> > +	 *
> > +	 * Capacity inversion happens when another perf domain with equal or
> > +	 * lower capacity_orig_of() ends up having higher capacity than this
> > +	 * domain after subtracting thermal pressure.
> > +	 *
> > +	 * We only take into account thermal pressure in this detection as it's
> > +	 * the only metric that actually results in *real* reduction of
> > +	 * capacity due to performance points (OPPs) being dropped/become
> > +	 * unreachable due to thermal throttling.
> > +	 *
> > +	 * We assume:
> > +	 *   * That all cpus in a perf domain have the same capacity_orig
> > +	 *     (same uArch).
> > +	 *   * Thermal pressure will impact all cpus in this perf domain
> > +	 *     equally.
> > +	 */
> > +	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> 
> This should be sched_energy_enabled(). Performance Domains (PDs) are an
> EAS thing.

Bummer. I had a version that used cpumasks only, but I thought using pds is
cleaner and will save unnecessarily extra traversing. But I missed that it's
conditional on sched_energy_enabled().

This is not good news for CAS.

> 
> > +		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> 
> rcu_read_lock()
> 
> > +		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> 
> rcu_read_unlock()

Shouldn't we continue to hold it while traversing the pd too?

> 
> It's called from build_sched_domains() too. I assume
> static_branch_unlikely(&sched_asym_cpucapacity) hides this issue so far.
> 
> > +
> > +		rq->cpu_capacity_inverted = 0;
> > +
> > +		for (; pd; pd = pd->next) {
> > +			struct cpumask *pd_span = perf_domain_span(pd);
> > +			unsigned long pd_cap_orig, pd_cap;
> > +
> > +			cpu = cpumask_any(pd_span);
> > +			pd_cap_orig = arch_scale_cpu_capacity(cpu);
> > +
> > +			if (capacity_orig < pd_cap_orig)
> > +				continue;
> > +
> > +			/*
> > +			 * handle the case of multiple perf domains have the
> > +			 * same capacity_orig but one of them is under higher
> 
> Like I said above, I'm not aware of such an EAS system.

I did argue against that. But Vincent's PoV was that we shouldn't make
assumptions and handle the case where we have big cores each on its own domain.

> 
> > +			 * thermal pressure. We record it as capacity
> > +			 * inversion.
> > +			 */
> > +			if (capacity_orig == pd_cap_orig) {
> > +				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
> > +
> > +				if (pd_cap > inv_cap) {
> > +					rq->cpu_capacity_inverted = inv_cap;
> > +					break;
> > +				}
> 
> In case `capacity_orig == pd_cap_orig` and cpumask_test_cpu(cpu_of(rq),
> pd_span) the code can set rq->cpu_capacity_inverted = inv_cap
> erroneously since thermal_load_avg(rq) can return different values for
> inv_cap and pd_cap.

Good catch!

> 
> So even on a classical big little system, this condition can set
> rq->cpu_capacity_inverted for a CPU in the little or big cluster.
> 
> thermal_load_avg(rq) would have to stay constant for all CPUs within the
> PD to avoid this.
> 
> This is one example of the `thermal pressure` is per PD (or Frequency
> Domain) in Thermal but per-CPU in the task scheduler.

Only compile tested so far, does this patch address all your points? I should
get hardware soon to run some tests and send the patch. I might re-write it to
avoid using pds; though it seems cleaner this way but we miss CAS support.

Thoughts?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89dadaafc1ec..b01854984994 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8856,16 +8856,24 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
         *   * Thermal pressure will impact all cpus in this perf domain
         *     equally.
         */
-       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
-               unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
+       if (sched_energy_enabled()) {
+               struct perf_domain *pd;
+               unsigned long inv_cap;
+
+               rcu_read_lock();

+               inv_cap = capacity_orig - thermal_load_avg(rq);
+               pd = rcu_dereference(rq->rd->pd);
                rq->cpu_capacity_inverted = 0;

                for (; pd; pd = pd->next) {
                        struct cpumask *pd_span = perf_domain_span(pd);
                        unsigned long pd_cap_orig, pd_cap;

+                       /* We can't be inverted against our own pd */
+                       if (cpumask_test_cpu(cpu_of(rq), pd_span))
+                               continue;
+
                        cpu = cpumask_any(pd_span);
                        pd_cap_orig = arch_scale_cpu_capacity(cpu);

@@ -8890,6 +8898,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
                                break;
                        }
                }
+
+               rcu_read_unlock();
        }


Thanks!

--
Qais Yousef
