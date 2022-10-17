Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E32600F52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJQMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJQMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:40:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1234C2D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:40:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HArf3W027013;
        Mon, 17 Oct 2022 12:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4m7dzX8yPlsHt8XOOX5vaqqomTo4uUCKgHjCA3Qa9lE=;
 b=sS8/A6kpwOf6ai86W+G5jgOA9ZXU26yHZJt0hnCkd1gtfFRvNT8fH2Zz4mE3lj6YvXFE
 C1CyD4S1B6EFdctjyydEYS9FuROXOanaYNJ8UcoE1Ki0+DEwZIRCl9+uu0gA5fAFvLYa
 CCbZcosiB+GMcXh6NinebWEiglctlgEO0t17jz5OfmGexz4VkpRRAnj92S2C5oKmJrk7
 0QAxNkghBzgPOYQ5JxatUJCapb09e3Vvd7AYIxuWjxpPU0dWJn0YdKrJ8rbQEMMi5f/m
 wR5cfTdMie5Wi8YyX836/IURg3LVCCG8p09kIKr6b+lNYhhQb3EGNsJd4T4OyHfNt340 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86sjs3f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:40:36 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29HBpljs012796;
        Mon, 17 Oct 2022 12:40:35 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86sjs3e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:40:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29HCZ23M024623;
        Mon, 17 Oct 2022 12:40:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg930bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:40:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29HCeUI54915792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 12:40:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D66C11C050;
        Mon, 17 Oct 2022 12:40:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2F4711C04C;
        Mon, 17 Oct 2022 12:40:29 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.81.76])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Oct 2022 12:40:29 +0000 (GMT)
Date:   Mon, 17 Oct 2022 14:40:28 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003232033.3404802-3-jstultz@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ip4SiZGkVfD96mbB_iThYA6lAHPmLWsH
X-Proofpoint-GUID: qYTDIWWWQQx3TwkzzBMZJVRmKMUQ7XOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_09,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:20:32PM +0000, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>

Hi John, Connor,

I took a cursory look and have couple of hopefully meaningful
comments, but mostly - questions.

[...]

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 55f39c8f4203..3c628db807c8 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1599,6 +1599,44 @@ static void yield_task_rt(struct rq *rq)
>  #ifdef CONFIG_SMP
>  static int find_lowest_rq(struct task_struct *task);
>  
> +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> +#define __use_softirq_opt 1
> +/*
> + * Return whether the given cpu is currently non-preemptible
> + * while handling a potentially long softirq, or if the current
> + * task is likely to block preemptions soon because it is a
> + * ksoftirq thread that is handling slow softirq.

What is slow softirqs in this context compared to long?

> + */
> +static bool cpu_busy_with_softirqs(int cpu)
> +{
> +	u32 softirqs = per_cpu(active_softirqs, cpu) |
> +		       __cpu_softirq_pending(cpu);
> +	struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
> +	struct task_struct *curr;
> +	struct rq *rq = cpu_rq(cpu);
> +	int ret;
> +
> +	rcu_read_lock();
> +	curr = READ_ONCE(rq->curr); /* unlocked access */

select_task_rq_rt() takes the lock and reads curr already,
before calling this funciton. I think there is a way to
decompose it in a better way.

> +	ret = (softirqs & LONG_SOFTIRQ_MASK) &&
> +		 (curr == cpu_ksoftirqd ||

EOL is extra.

> +		  preempt_count() & SOFTIRQ_MASK);

Could you please clarify this whole check in more detail?

What is the point in checking if a remote CPU is handling
a "long" softirq while the local one is handling any softirq?

> +	rcu_read_unlock();

Why ret needs to be calculated under the lock?

> +	return ret;
> +}
> +#else
> +#define __use_softirq_opt 0
> +static bool cpu_busy_with_softirqs(int cpu)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
> +
> +static bool rt_task_fits_cpu(struct task_struct *p, int cpu)

To me, the new name is unfortunate, since it strips a notion
of the reason. Instead, "CPU un/fits, because of capacity" it
reads as "CPU un/fits, because of ..." what?

> +{
> +	return !cpu_busy_with_softirqs(cpu) && rt_task_fits_capacity(p, cpu);

I guess the order needs to be swapped, as rt_task_fits_capacity()
is rather "quick" while cpu_busy_with_softirqs() is rather "slow".

> +}
> +
>  static int
>  select_task_rq_rt(struct task_struct *p, int cpu, int flags)
>  {
> @@ -1894,14 +1934,17 @@ static int find_lowest_rq(struct task_struct *task)
>  		return -1; /* No other targets possible */
>  
>  	/*
> -	 * If we're on asym system ensure we consider the different capacities
> -	 * of the CPUs when searching for the lowest_mask.
> +	 * If we're using the softirq optimization or if we are
> +	 * on asym system, ensure we consider the softirq processing
> +	 * or different capacities of the CPUs when searching for the
> +	 * lowest_mask.
>  	 */
> -	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +	if (__use_softirq_opt ||

Why use __use_softirq_opt and not IS_ENABLED(CONFIG_RT_SOFTIRQ_OPTIMIZATION)?

> +	    static_branch_unlikely(&sched_asym_cpucapacity)) {
>  
>  		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
>  					  task, lowest_mask,
> -					  rt_task_fits_capacity);
> +					  rt_task_fits_cpu);
>  	} else {
>  
>  		ret = cpupri_find(&task_rq(task)->rd->cpupri,
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..35ee79dd8786 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -60,6 +60,13 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
>  
>  DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
>  
> +/*
> + * active_softirqs -- per cpu, a mask of softirqs that are being handled,
> + * with the expectation that approximate answers are acceptable and therefore
> + * no synchronization.
> + */
> +DEFINE_PER_CPU(u32, active_softirqs);

I guess all active_softirqs uses need to be coupled with
IS_ENABLED(CONFIG_RT_SOFTIRQ_OPTIMIZATION) check.

>  const char * const softirq_to_name[NR_SOFTIRQS] = {
>  	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
>  	"TASKLET", "SCHED", "HRTIMER", "RCU"
> @@ -551,6 +558,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  restart:
>  	/* Reset the pending bitmask before enabling irqs */
>  	set_softirq_pending(0);
> +	__this_cpu_write(active_softirqs, pending);
>  
>  	local_irq_enable();
>  
> @@ -580,6 +588,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  		pending >>= softirq_bit;
>  	}
>  
> +	__this_cpu_write(active_softirqs, 0);
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
>  	    __this_cpu_read(ksoftirqd) == current)
>  		rcu_softirq_qs();

Thanks!
