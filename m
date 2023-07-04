Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92D74690E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGDFkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGDFkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:40:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DEABE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688449207; x=1719985207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=exU8PduRWwnEehJG2w+Iv+7gfFqysth1d1muzlTMB1g=;
  b=HoBFIgsjOPoUwAg4Umvz2Ajz8k0ojHXppZiOQU2nYttavH45NEVuOlR8
   eQ2ljUblW5gWdtxXMpwo8/6BoKjzjFV2XJ28dS6GpZ/cm75zyEZaxetet
   wa0SIdOmIu/HTkjOVrImeK8XjgDH4W2e4CCfTSRrQj8lSGU78v8OBNq/P
   L1KMyx+kHtAfPrPw56wxOXQgM96gLA/qFX/WZ+ogFZuzwDGoLtX+52ypE
   FaAS8ZXCxCrQBqbLwBsLqDyI1PltaTbOSR6dRSXd3IOkx3hXcZcktEe2N
   FPufG183dZKkspNNEKHXlH6aeVmc6vqSxGavMqj3dSb/ZFbQkpjfVgogg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="352867999"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="352867999"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 22:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788746519"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="788746519"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2023 22:40:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 22:40:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 22:40:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 22:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBGutQRMh2Z8C/TLmPY5raUCg7PT5sZmxZLxRUMtQdyzxYaVntKvKBOw9SRVoaYY/HfNGYrLjhcusAdYdVA7MXw2G2MHqB/DbJYmxWKTLVxXO38Swbvlo/IZrSaYOPzIIW9CCO8KyevMquzXq0Of+d9QZ0Cujsibr5TIWY035Z6uWT3Lu+0Tlwkdvzk/bKJyHmk7BABIBAt1AUrJMTOhzmFLaP3It4TeNViHwASwKjPWLXtyw/MD3vmINW0w37JSDY8uL77DG+z1aRy7bW0Ut1OOSrAash7a6lEydxWiDIw6YXg9bvNI3wM0iKc9zc+UyVcsnTsbpuhqOY1tTsS7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+8dwFnNCpnneV+frebxCKP+R4L77EaxCoOVr+Tswy0=;
 b=JypoyGVyM+svo/hp8IQHF3P2775yGMv09Ho9MJq9Z4DXTEsVsFIeSkv3WXiUBn9ty1A7zo9e6BQ6a6FpIdA/Ec3OgHgFiATjE0qPAUgHNlssq8Y21h5BKaweTmfbCRxUnuoLHE0B2AOZQmULXCpELyvmU/GFrDs+eFAR8NHsRwjCNKDsVyPKChG7b+hij44UbD5DJgWb9UfHSA904c88ijeV3tfHvwQfJ/hGnDXKj5GmQK8c+B/RRXhlX4NMp8JhXARmJL0OY9HwPSu+wd73HqUKm2iOXLjidjyyXIXuChJ3KoIke3FBjuco4Ns1DS923FnIOxe9pPrfhSedxUMXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 4 Jul
 2023 05:40:02 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 05:40:02 +0000
Date:   Tue, 4 Jul 2023 13:39:46 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <paulmck@kernel.org>,
        <quic_neeraju@quicinc.com>, <joel@joelfernandes.org>,
        <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <qiang1.zhang@intel.com>, <jstultz@google.com>,
        <clingutla@codeaurora.org>, <nsaenzju@redhat.com>,
        <tglx@linutronix.de>, <frederic@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sched/core: introduce sched_core_idle_cpu()
Message-ID: <20230704053946.GA658436@ziqianlu-dell>
References: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 42efb470-7d05-442d-74dc-08db7c511cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGV7nzKz3NQD+NPb+nUOWc13CZ0lXqgWw0dXzSqlVQ0t3LU+jleqfnJViYQ8BRa9z6CJPVwZi0NumLt8ZIixznH7ioDCgQTcLQSY1xEJmIP7ldQRUS6qkNodyRiJVNTYHIxGjh30VJ8SFpKKe2ZUUBuCX9GA2QnGnUvMOUuvPt/HR87ztBB3VVIrILPuD3j5JcccOIjkr/Zi9rbZUVBP3urmwiXUfs4Ak67G/S8QKcHE62DkfyrfD8RWli9CR4jaM6jLX0HjQfnAPsPa9g+s5Ny8EasBGuu4vVemrlc/h/P+UQc+b9owJREjuHW5KXLxLmDOSYT/XN0MIgovUW86WQf7HolOqzIne67p1BDahVIMB2h39fiIUvR6HqCCoK/VwviaY65BvAVu3w1TyOiMFcAcQnKrubSDbS/wSh6IbSSwZz7dn2jNz24qVic6JMkZJcLmy+YCuv8IC+ge/OmYc/ztkMO9fk6MYC459RnImb0aueDS5zz3stA6Zrb7IPyPGmB1k4xdfJCU5TuJ3ia3vIzMlc3yytnuNC2Q2KIZLuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(26005)(4326008)(6916009)(66476007)(66556008)(66946007)(6666004)(478600001)(33656002)(966005)(6486002)(1076003)(9686003)(83380400001)(6512007)(186003)(6506007)(38100700002)(82960400001)(86362001)(33716001)(41300700001)(44832011)(8936002)(8676002)(7416002)(2906002)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXWtfkLSwPE0mTTy5r4BIhQ1rGYnR1M1UVmaU3AMBWLbNRAlXAHRI+fluyrY?=
 =?us-ascii?Q?5BTD1iy2E7pNJoSAg/oXW5Vwjp4JMeBgzzHpOd+yRDoa31rvFj/iUSPI4sSj?=
 =?us-ascii?Q?n1FJHGDYItJayLDHZKSJhzU7gYYC3SJMnlt2ZSHsQ7LzVcB1MjFCui2NXUbY?=
 =?us-ascii?Q?74p5+8XisppOl/z1EOHkDJTQJajNY5ZmUJ1MwXLBS+k/lBbgIcJQKwRmuwzA?=
 =?us-ascii?Q?rN7ERXIvJO7eQKO8whiHG4rsBVba6B7LaJ60hk9dR2EPQjO1Wdz7beFYn8r4?=
 =?us-ascii?Q?1TVB87daLO/3UJ4cEZgBdENsOGu/pJCGBDg1ARDo2VYbHl1nbd3EbWXu05mG?=
 =?us-ascii?Q?e/LsfDCGFKblRWJeSgRLt8sFulIU70xPUwyB8WlpU9RHBkTF7yytv6mOQknz?=
 =?us-ascii?Q?4nczlfw0fd5+fckDu2+quJ3mCYHucXXxk+33ZyQF5Qhk2Vh9oxraVXd3+h+V?=
 =?us-ascii?Q?wcfYc7X1uUNp9UYj7XRpNwOoov8PS2TWRHIq7VW/H3qK7fgHSDBg/uRYWKh4?=
 =?us-ascii?Q?oT08tvtk+4GG8PGBQ5csL8Mqk3ixSZRQw7uigNa+e4YVDiW/fK4cZxN2fBcH?=
 =?us-ascii?Q?ja5T5E5bJE8QJPqBuk0XJBbkiVq/60Wy8jW1hJvCQ7uYoLall1ESs8IF9SuT?=
 =?us-ascii?Q?BBzg1+u6Ms3Pkl1pIKDl14AVQL8pFQThqeKANsoJ2lQoM7eRel1zXhuHdu1X?=
 =?us-ascii?Q?TdlWC3yxctClho4+CkOZK1UcRK/kXpmbBSgQhpnvK1lTWmtkBBxJoFgWOmxO?=
 =?us-ascii?Q?rr1tIVyDN8uaY+B3gig6ml16/wdHCpXM+t38Cv9ugE3N9jtddkB/NjOg1doD?=
 =?us-ascii?Q?gH9ZVIvlY4yL1cBU2vMNxtVaulAS/aGz0n7iaMKLkusNbQw96wnR5peyCkp6?=
 =?us-ascii?Q?DPBU/UcU5QTzQ8J00kegI3T6riTXQxdQaGWhIwVmj/sDDIClyoYCmMux69ZG?=
 =?us-ascii?Q?WV8dsqUQbSDO4vd3m1i4gAmUhfotvsRwyXkcgt1+LueieSexg3vo+ajhqMxG?=
 =?us-ascii?Q?E/ALegwmixYYdg0/rTeJa3RMx++rbIqAxbjgubt+2qCqSSz0peBtsuifRiDZ?=
 =?us-ascii?Q?jyHMAHG3wZ+khNtJCLjXnbNv92E/0+PVehnHbynSTg4q6dolO1M7t7OsVU5F?=
 =?us-ascii?Q?tKpj3PZecmuwqtb7iwnVwrAx995YJClV8Ul0c5M8MEGjcafHmIt8IjVYizNP?=
 =?us-ascii?Q?cvrlusPo40gWsQQ/llLyVhh9cEPi1eOf2LtGvK1J5+L6TtVjZn4FEBMq6qxB?=
 =?us-ascii?Q?Yye+gg0H/h1YKi/igmO+/3ANCvQTcxN0UUggzZhGO6nWLlDQHpv5icrihXIf?=
 =?us-ascii?Q?tfyip5CF5u9YHOxgDN25VQWufc5CBjW15YkFFLP3xJinN5rPZRE3LNKKJVuu?=
 =?us-ascii?Q?n8CMiMD8TyCKFyu8g/uHojsHA5S35FphFrSZyg/N24IFaF+7I1sKitmB8fRs?=
 =?us-ascii?Q?ql74G1qgRvI4mRHJBu/4tDuEiQ16Pc5562eq2uPzcBoiPiqEEFaaVlNp9kfW?=
 =?us-ascii?Q?A194RNgdluL/v1IVS+Cf5J++MXMNvlGm1jTvwcp2mnPSNwI6ulTBXvYCY7Ch?=
 =?us-ascii?Q?LoDRD9ZR/d+51Zwb29VVhDk8qWPH46EqRM2l2cyj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42efb470-7d05-442d-74dc-08db7c511cab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 05:40:02.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42GVEP+8LEvcySDfPyd9jAwyzsQjCowECa55wA9YNPH/AlwNKnnwjaVgFyT9OEC9HwJyD6sceQZGGGWGfNM87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:02:04PM +0800, Cruz Zhao wrote:
> As core scheduling introduced, a new state of idle is defined as
> force idle, running idle task but nr_running greater than zero.
> 
> If a cpu is in force idle state, idle_cpu() will return zero. This
> result makes sense in some scenarios, e.g., load balance,
> showacpu when dumping, and judge the RCU boost kthread is starving.
> 
> But this will cause error in other scenarios, e.g., tick_irq_exit():
> When force idle, rq->curr == rq->idle but rq->nr_running > 0, results
> that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
> is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
> not become 1, which became 0 in tick_nohz_irq_enter().
> ts->idle_sleeptime won't update in function update_ts_time_stats(), if
> ts->idle_active is 0, which should be 1. And this bug will result that
> ts->idle_sleeptime is less than the actual value, and finally will
> result that the idle time in /proc/stat is less than the actual value.
> 
> To solve this problem, we introduce sched_core_idle_cpu(), which
> returns 1 when force idle. We audit all users of idle_cpu(), and
> change idle_cpu() into sched_core_idle_cpu() in function
> tick_irq_exit().
> 
> v2-->v3: Only replace idle_cpu() with sched_core_idle_cpu() in
> function tick_irq_exit(). And modify the corresponding commit log.
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Reviewed-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
> Link: https://lore.kernel.org/lkml/1687631295-126383-1-git-send-email-CruzZhao@linux.alibaba.com
> ---
>  include/linux/sched.h |  2 ++
>  kernel/sched/core.c   | 13 +++++++++++++
>  kernel/softirq.c      |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b09a83bfad8b..73e61c0f10a7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2430,9 +2430,11 @@ extern void sched_core_free(struct task_struct *tsk);
>  extern void sched_core_fork(struct task_struct *p);
>  extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>  				unsigned long uaddr);
> +extern int sched_core_idle_cpu(int cpu);
>  #else
>  static inline void sched_core_free(struct task_struct *tsk) { }
>  static inline void sched_core_fork(struct task_struct *p) { }
> +static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
>  #endif
>  
>  extern void sched_set_stop_task(int cpu, struct task_struct *stop);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 71c1a0f232b4..c80088956987 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7286,6 +7286,19 @@ struct task_struct *idle_task(int cpu)
>  	return cpu_rq(cpu)->idle;
>  }
>  
> +#ifdef CONFIG_SCHED_CORE
> +int sched_core_idle_cpu(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (sched_core_enabled(rq) && rq->curr == rq->idle)
> +		return 1;

If the intention is to consider forced idle cpus as idle, then should
the above condition written as:

	if (sched_core_enabled(rq) && rq->core->core_forceidle_count)
		return 1;
?

Or as long as a single cookied task is running, all normal idle cpus are
regarded forced idle here and 1 is returned while previously, idle_cpu()
is called for those cpus and if they have wakeup task pending, they are
not regarded as idle so looks like a behaviour change.

Thanks,
Aaron

> +
> +	return idle_cpu(cpu);
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_SMP
>  /*
>   * This function computes an effective utilization for the given CPU, to be
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..98b98991ce45 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -630,7 +630,7 @@ static inline void tick_irq_exit(void)
>  	int cpu = smp_processor_id();
>  
>  	/* Make sure that timer wheel updates are propagated */
> -	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> +	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
>  		if (!in_hardirq())
>  			tick_nohz_irq_exit();
>  	}
> -- 
> 2.27.0
> 
