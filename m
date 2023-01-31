Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7638682AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjAaKhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjAaKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:37:19 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8A1422A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:37:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mf7so21533010ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkWS2t3askpu1D7njdrnxi2kq/eX1xIz2nN0Yek+dUc=;
        b=QM4ra/ODfPrJMHjZGkJ6rPmbVMINty+GnU53XszIATo24rZUeMOy4Sh8xtIyWNjTJs
         4WCvkPXn2uo/0tc28HFMBR5G/srRq4YrvDXkj0P60HKCgzg3Mr09FMeN5bgeDzBHYZYC
         aGqtr4y783oBbcSnbACvGBfoF40AYPREy4BT1r5HObc+V7YRBwEvlyfjpQAPb0Xfkqzd
         ftiruzXvhxN9ASesfp5JwL/6+x0GD/Os4rP1xjqHVPUtISyqNKl6MVmltI4UWY8QM9/S
         +RlN60Il79Du2Yh5IEBfV9kvjYvMzHYv2Fn1QasW6FKOvx5efa0fD57USwkiiHbk9di5
         oEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkWS2t3askpu1D7njdrnxi2kq/eX1xIz2nN0Yek+dUc=;
        b=BGfh6BC6PynZHi/P8dMAHQDNoJslQVe+Zfgm6Sm40RXlJ1Y7rLlFXRfNnX0dcfsNEW
         isdhFs9o6bgp/XgN2h3KIArwlahMSe7SqpDDaCk6lPyX1P9bBvEzIAi23Vy2I1Pnc4sG
         DbAVKrVJeY8hMIo9m/5b2QrtyWHGWSvzwfaLFzELHfu2mJIj6K/4cVXrIhmtVUa4pN4F
         ELd6MtdlczE6YQF+73/FyQPOIa27H3IX8xb/dfQ190S8ElPUogCtrfsRzWuIzICvAeEn
         3GAtAoBhm/yfD1J/J/3ig6oVsKQVl1XBtzW4ucrdZBwPDzsmgDhjENrzCygGu0HaGiuU
         3Ejw==
X-Gm-Message-State: AO0yUKUXbh4kBKJ/7ab2apyvyOjObwIJVDIQ9RiCIvhATFuaK0gfPeMt
        oZL9hVGq/UQGYUsmtriIi9I=
X-Google-Smtp-Source: AK7set+/Evrct/q5eyTYLP4mtR8MHvyRTe1ex5lQxVcKS2c95D/hv6KUV8+znRsz2ww4wJZVuee/vQ==
X-Received: by 2002:a17:907:da1:b0:888:7ce4:1dc1 with SMTP id go33-20020a1709070da100b008887ce41dc1mr9407525ejc.26.1675161436727;
        Tue, 31 Jan 2023 02:37:16 -0800 (PST)
Received: from gmail.com (1F2EF55F.unconfigured.pool.telekom.hu. [31.46.245.95])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b004a219af6a94sm5901485edv.47.2023.01.31.02.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:37:16 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 31 Jan 2023 11:37:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, arjan@linux.intel.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [RFC PATCH] hrtimer: interleave timers for improved single
 thread performance at low utilization
Message-ID: <Y9jvWCGGICsKGPFt@gmail.com>
References: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* shrikanth hegde <sshegde@linux.vnet.ibm.com> wrote:

> As per current design of hrtimer, it uses the _softexpires to trigger the
> timer function.  _softexpires is set as multiple of the period/interval value.
> This will benefit the power saving by less wakeups. Due to this, different
> timers of the same period/interval values align and the callbacks functions
> will be called at the same time.
> 
> CPU bandwidth controller (CPU cgroup) uses these hrtimers to implement period
> and quota.  Period timer refills the quota and allow the throttled cgroups to
> start running again.  When there are multiple such cgroup's, if their period
> values are same, then these period timers will be aligned.  Hence multiple
> cgroup's timer fire at the same time and ends up unthrottling each cgroups
> runqueues. Since all cgroups start, they would compete for CPU and use all SMT
> threads likely.
> 
> There is performance gain that can be achieved here if the timers are
> interleaved when the utilization of each CPU cgroup is low and total
> utilization of all the CPU cgroup's is less than 50%. This is likely true when
> using containers. If the timers aren't rounded-off, then the unthrottled
> cgroup can run freely without many context switches and can also benefit of SMT
> Folding[1]. This effect will be further amplified in SPLPAR environment[2] as
> this would cause less hypervisor preemptions. There can be benefit due to less
> IPI storm as well. Docker provides a config option of period timer value,
> whereas the kubernetes only provides millicore option. Hence with typical
> deployment period values will be set to 100ms as kubernetes millicore will
> set the quota accordingly without altering period values.
> 
> [1] SMT folding is a mechanism were processor core reconfigured to lower SMT
> mode to improve performance when some sibling threads are idle. In a SMT8 core,
> when only one or two threads are running on a core, we get the best throughput
> compared to running all 8 threads.
> 
> [2] SPLPAR is an Shared Processor Logical PARtition. There can be many SPLPARs
> running on the same physical machine sharing the CPU resources.  One SPLPAR can
> consume all CPU resource it can, if the other SPLPARs are idle. Processors
> within the SPLPAR are called vCPU. vCPU can be higher than CPU.  Hence at an
> instance of time if there are more requested vCPU than CPU, then vCPU can be
> preempted. When the timers align, there will be spike in requested vCPU when
> the timers expire. This can lead to preemption when the other SPLPARs are not
> idle.
> 
> Came up with a naive patch, more of hack. Other alternative is to use a
> slightly modified API for cgroups, so that all other timers align and wakeups
> remain reduced. New hrtimer api is likely better, i can send out the patch
> quickly.  Here i am trying to misalign by setting the softexpire at multiple of
> interval/10 instead of interval. Ran the stress-ng with two cgroups. The
> numbers are with patch and without patch on Power10 machine with SMT=8. Below
> table shows time taken by each group to complete. In the last column, both
> cgroup's are run together and data shows average time taken by cgroups to
> complete. Here each cgroup is assigned 25% runtime.
> 
> workload: stress-ng --cpu=4 --cpu-ops=100000 data shows time it took to
> complete in seconds for each run.
> 
> Without Patch:
> period/quota    cgroup1 runs    cgroup2 runs    cgroup1 &cgroup2
>                    alone           alone         run together
> 100ms/200ms         120s            120s            155s
>                     120s            120s            155s
>                     120s            120s            155s
> With Patch:
> period/quota    cgroup1 runs    cgroup2 runs    cgroup1 & cgroup2
>                    alone           alone         run together
> 100ms/200ms         120s            120s            131s
>                     120s            120s            155s
>                     120s            120s            121s
> 
> There is no benefit at higher utilization of 50% or more. There is no
> degradation also.
> 
> Signed-off by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/time/hrtimer.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 3ae661ab6260..d160f49f0cce 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1055,6 +1055,17 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
> 
>  		orun = ktime_divns(delta, incr);
>  		hrtimer_add_expires_ns(timer, incr * orun);
> +		/*
> +		 * Avoid timer round-off, so that all cfs bandwidth timers
> +		 * don't start at the same time
> +		 */
> +		if (incr >= 100000000ULL) {
> +			s64 interleave = 0;
> +			interleave = ktime_sub_ns(delta,  incr * orun);
> +			interleave = interleave - (ktime_to_ns(delta) % (incr/10));
> +			if (interleave > 0)
> +				hrtimer_add_expires_ns(timer, interleave);
> +		}

Any reason why you did this in the hrtimer code, instead of the 
(sched_cfs_period_timer?) hrtimer handler itself?

Thanks,

	Ingo
