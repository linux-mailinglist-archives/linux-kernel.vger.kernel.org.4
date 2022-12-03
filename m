Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1326414D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 08:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLCHzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 02:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiLCHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:55:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD27F893
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 23:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670054138; x=1701590138;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ikDfcVOBwesz4A9xR86M8ZZ3AA73aQ4LyXaggWhhctU=;
  b=XyitTBFomeba45lqJ7afTzGjXUvXR7N7u18I5x6ykzeiZCPUVYhQN+8g
   u5QV1GIHMOIUkVFP2UXtGKxe25V+gCQkZ229/mKS3JmBZr2vfNvqVmAqX
   uldx5KOInPMl+Ac9tcUv25pOYu7yOTTEq+AGwuKRaBBn+nO2ZUvlGW1mZ
   +byAdTfYWVy1exyzBz89Y3Ad3K6iH6DJjIG2GF7lttpLAyTAEmC+cVFfe
   BtzT5z002BBG0r6vIRG0jLY5skbvoI1Vq9mfQ2OHkdxfWnDfKmYhq+K47
   R2n12Y+EG8g02mxqQQnzKFe/KRU2FUni6ZBbDSQMF2s8wKeEGGK0F9PFx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296461329"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="296461329"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 23:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="638980963"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="638980963"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2022 23:55:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 23:55:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 23:55:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 23:55:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhX/z4f/Ww3nTHax5SK3bE+jjFv3nAIYoFCHLdBoj59rGGwKCyjQoomU78FaKYKVlWIg4kRV+lyVDFbk9x4I4593d/PUJIR9s4la9nzdYqF73pA7LAVJEOBWPk2iNzBVqcOcMW+DrZpLR/oQPxG+6W7ZGJjHZ/G1tMlynwx6c0wEJK6jQK5qr3YAllt7IAkpIrwd4vWk2DmwUBXqpW7EZ3yx7e5tmXLpY4umy9SVQZSUDkm4RR/TWp2erAsPrwkdVUnIhhU79qkDzfZE+f5SufbT+mh7ARACvQRfqRqgWQ+7ORHjC/kecg6okLv248Ft2iMbhrbg9+dBDauSM+Ss1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0ic0fBMpctsOmSfmzBQajN7x3zODTCMZdB5vlmhxSY=;
 b=VASiGFRUB9msBKuQr+XFMVdocxyb1rSd7EjTtbiF/QWzBNzuA7brP3ppvnnLCjujTWXPxbi3aG/Or/Xighh1f3WMprfCAIc1/aFoclkRuz12+ywjnw1BK0Mn7kkBLahq9ZMLllDkH5hdIj3PHrGBNgf/dsLn3yH2r9iPlp8KH1Y/sQIwoNNOwZobx1/iPzZLoZsvy29gNieGL2IswIdluKtoQRkohCBuzAaKCbbBXI94CQHMN3ZANwGltfQCaJEfE5IpO1E3upQ6eEZGwOi+qi7f36lz4Fs161CSTrG2ektUS+0bqCilPLk7rEzGp3JlQnZFzSFmvNTAUX1FY8lmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sat, 3 Dec
 2022 07:55:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%7]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 07:55:35 +0000
Date:   Sat, 3 Dec 2022 15:55:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <vschneid@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>
Subject: Re: [PATCH v4] sched/core: Minor optimize ttwu_runnable()
Message-ID: <Y4sA5xDe+sBfQUnG@chenyu5-mobl1>
References: <20221202080644.76999-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221202080644.76999-1-zhouchengming@bytedance.com>
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: e348da0a-1f88-40c0-8ac4-08dad503c257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5CbbwBvjdjAiKza6EqoETqFual+6UX8RhzzCL2keLTw6gqWhehDndptan5uetd+gJABft7+eNFCDiDnho7mEpyy/bvmjMXhkrbtwA410+6SYwiPYgxOfgKxfSO9ArG6+Ii5TkKvcMx8dXjEFe2nIHyzM7svDVyl4xjc89489goG10RTwl+Mh0zzeqaJCo9UFHEGtVF7gabwsn+P7OZv0oghDZzEoWWvkpKhz2JOVIx0gyUOVQcW646hHncgjzL4/pVihMHDq3oSH3e7uJg5By0pwNdVoIjxjeXtl4qaxHMLx4A9ipgyquhK9a6dmnx9KJLLrYgYjvfgT1R7oeUlD7angxejnB8jCzJyvEqs+4tKNajSw9kk2izl9GZmAxMBSS7gnna0WNl/wje/48i70Z4l2YLPv64aUdEdl7Q3+FGOhYPNbXH4CLJRfPozEeVQaKmW51lmg9du+SPJwrFm7dkvMtQAWJLSakP5P8f90qIyPWR0Qq6Utz/32l2xJr8zDvKMSsK1m+Sg1bIucHJjPF3aXi02iAjQY7x5rKlMKpt1tUU/iRManL8v/MbLFNP2PyUesW7EFD4ZCueKX8VfJMEubCjdEXelOKp/1XnIX7x6KGrIYgHAprVkfR3pAi1BDwrasg5rXkbZwyCirdNlhzfTRVXmm52A6mWy30/wPU0FReTwHXCLTFn9edAIrCz+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(83380400001)(86362001)(82960400001)(7416002)(38100700002)(2906002)(4326008)(41300700001)(8936002)(5660300002)(33716001)(53546011)(8676002)(9686003)(6512007)(6506007)(186003)(26005)(6666004)(6916009)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VHWWVrXEgoWlP7wVBrVpDcHoWSFoCts+k3cRazUPUrBUtpFZKBko6v1atbou?=
 =?us-ascii?Q?nF92h9cOZxC4jZwROhVqmq09L69/Zv16IbStd1Yv0DMfTU2z7JmITmT5NXo7?=
 =?us-ascii?Q?ZCEK0i9la+tlcd6L3dH44BgC6lDbhTTq/lg4xP6HaZOF5q82PtTWhplj5PSJ?=
 =?us-ascii?Q?ZdrZa8zyzrn28UYhRCeCbi8eDmr0GMPwUI+I01DBPdrL2W4pWWNn3UuaVXZ/?=
 =?us-ascii?Q?tEGu0GwC7c/iUivEIIwWDbZIM3uW2LxKgJn/dnKJHkFHiTh3Q+6cyMLXUG8D?=
 =?us-ascii?Q?FV/CnXX+66SIdkKg6njXwZAoprvjTSaCAZg+osgSM0Gvra4IqrVNokJkrMb9?=
 =?us-ascii?Q?0QGKQRwHI0Hwf2RrDRm3zmla8zhU9eXsfZc5/2SZTWg9SJc5CzqbplBaMgyW?=
 =?us-ascii?Q?lDeL++htoP0neXDb1BUI74MALn00nH1U6gXdH3iL/kCg/yOX13K/nRa7pByS?=
 =?us-ascii?Q?b5Mrf5/qgSzHtuRk8kTnFvkonsg+/nCI4eTr7Eqlb13Pybb3i1cH5SA3WITe?=
 =?us-ascii?Q?DC6wXNifoM42V4jkr9PNG7KCV95TRUPXyVfaUz0PoapU3okAxqtnjnAx7cFx?=
 =?us-ascii?Q?pkz7q3Kf6nSHTkvO4wSo7X60lPdhqjE0FaHKiJOMLyHamNWRYKT4oGy9M5M3?=
 =?us-ascii?Q?7M5O1mD90/rgQ1n6eaxZL4/ri6fuFDsOolzvsQ+3ZFqGAsAhBcIvfhn1CRrP?=
 =?us-ascii?Q?5WdEHNHeW9a6SZPAix5/xjw6OvtS3mifjLj8SUP4qRN7gyC68UWApLGVPzuy?=
 =?us-ascii?Q?8AKFpOvYcfUXTC3I+K2QIeVqiFg9+lm3/yIerxPHIWTMv+91wuMeUcy0Pn0m?=
 =?us-ascii?Q?FW/BWWUDKjXmmBLvGw0TNNqgTYiGs3y0DhcZAseewnt5WtmNLzNrpq0sJDFc?=
 =?us-ascii?Q?KZpxfmohh5gikwCkY+1uMiRR39bBXyRHk4aVCQKs+0XWx7vcPv3LSNEDoLnS?=
 =?us-ascii?Q?WcSzJ9+M6C5j/rVftdaTbdJmSAaSneFqtBLpsL3ZV6rGtupd7gh+ZX6/hEiv?=
 =?us-ascii?Q?rYzt+BFkLar3H/vvZm5j5UkEc6iD457lYp7Fc5n/G5hREbCtb6SuaR8He2ei?=
 =?us-ascii?Q?1vUdqQdjRFw5ZC5kueWBxFgD+bvIFP6jsrxf9orbLEKdUo4W8CxMBsTXIDNg?=
 =?us-ascii?Q?BLaMrEb8FG+Pf4r17aqE2EmxIWVa0iYECpZQGjtqKUCdK/GhGfYA8fHquF2C?=
 =?us-ascii?Q?zBpKejOuX9TsjfFNYbuhFkSeQ7qZyrkeaB9ek0+3dyWo+tDuYqdBOkM+RYKk?=
 =?us-ascii?Q?zsGctkLXQ2YXIoAicjJ9dt3PpnptxMySkvmQAkqNL4HTUwUt0mel5szGTTRd?=
 =?us-ascii?Q?VqowY3l+BwgyLnNAW6M8s9j9U48qAXZ4gRoAdM1toIyzOJBVY3EN4yKMyxQA?=
 =?us-ascii?Q?njCdTkMolNr2qgsu9B6Z1i8dEsQbRdQSKP7t/Su8M5RgJfGOvC6zsj2ZNPYJ?=
 =?us-ascii?Q?QXclTcVOswCVdssI8w3seyPbmoE4QViL+mG5QON+1G+d5pBc/CnSDuzAo/7f?=
 =?us-ascii?Q?h9VdVN1H5IJQ9BJMFbQR82yHO875AUVy99SBlHTTgvUYERg06QUA6UVnaBs0?=
 =?us-ascii?Q?iQT1aUM1/Y4UkhqxDAXW/xIfne70fz89K8uJV9p7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e348da0a-1f88-40c0-8ac4-08dad503c257
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 07:55:35.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRjQL8zgIvCQY2QMfZ0XQtAcchSFoKDJbbfZNlRPxB4iJvrdV+ZgvxOAMWhM0TfieGX6Yzp1a8Gqn4GUK8OW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-02 at 16:06:44 +0800, Chengming Zhou wrote:
> ttwu_runnable() is used as a fast wakeup path when the wakee task
> is running on CPU or runnable on RQ, in both cases we can just
> set its state to TASK_RUNNING to prevent a sleep.
> 
> If the wakee task is on_cpu running, we don't need to update_rq_clock()
> or check_preempt_curr().
> 
> But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
> the task got to schedule() and the task been preempted), we should
> check_preempt_curr() to see if it can preempt the current running.
> 
> Reorganize ttwu_do_wakeup() and ttwu_do_activate() to make
> ttwu_do_wakeup() only mark the task runnable, so it can be used
> in ttwu_runnable() and try_to_wake_up() fast paths.
> 
> This also removes the class->task_woken() callback from ttwu_runnable(),
> which wasn't required per the RT/DL implementations: any required push
> operation would have been queued during class->set_next_task() when p
> got preempted.
> 
> ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
> the rq cannot be idle in this scenario.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> ---
> v4:
>  - s/This patch reorg/Reorganize/ per Bagas Sanjaya. Thanks!
> 
> v3:
>  - Improve the changelog per Valentin Schneider. Thanks!
> 
> v2:
>  - keep check_preempt_curr() for on_rq && !on_cpu case in ttwu_runnable(),
>    per Valentin Schneider.
>  - reorg ttwu_do_wakeup() and ttwu_do_activate() code, so ttwu_do_wakeup()
>    can be reused in ttwu_runnable(), per Peter Zijlstra.
>  - reuse ttwu_do_wakeup() in try_to_wake_up() (p == current) fast path too,
>    so ttwu_do_wakeup() become the only place we mark task runnable.
> ---
>  kernel/sched/core.c | 73 ++++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 314c2c0219d9..d8216485b0ad 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3623,14 +3623,39 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
>  }
>  
>  /*
> - * Mark the task runnable and perform wakeup-preemption.
> + * Mark the task runnable.
>   */
> -static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
> -			   struct rq_flags *rf)
> +static inline void ttwu_do_wakeup(struct task_struct *p)
>  {
> -	check_preempt_curr(rq, p, wake_flags);
>  	WRITE_ONCE(p->__state, TASK_RUNNING);
>  	trace_sched_wakeup(p);
> +}
> +
> +static void
> +ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> +		 struct rq_flags *rf)
> +{
> +	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (p->sched_contributes_to_load)
> +		rq->nr_uninterruptible--;
> +
> +#ifdef CONFIG_SMP
> +	if (wake_flags & WF_MIGRATED)
> +		en_flags |= ENQUEUE_MIGRATED;
> +	else
> +#endif
> +	if (p->in_iowait) {
> +		delayacct_blkio_end(p);
> +		atomic_dec(&task_rq(p)->nr_iowait);
> +	}
> +
> +	activate_task(rq, p, en_flags);
> +	check_preempt_curr(rq, p, wake_flags);
> +
> +	ttwu_do_wakeup(p);
>  
>  #ifdef CONFIG_SMP
>  	if (p->sched_class->task_woken) {
> @@ -3660,31 +3685,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
>  #endif
>  }
>  
> -static void
> -ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
> -		 struct rq_flags *rf)
> -{
> -	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
> -
> -	lockdep_assert_rq_held(rq);
> -
> -	if (p->sched_contributes_to_load)
> -		rq->nr_uninterruptible--;
> -
> -#ifdef CONFIG_SMP
> -	if (wake_flags & WF_MIGRATED)
> -		en_flags |= ENQUEUE_MIGRATED;
> -	else
> -#endif
> -	if (p->in_iowait) {
> -		delayacct_blkio_end(p);
> -		atomic_dec(&task_rq(p)->nr_iowait);
> -	}
> -
> -	activate_task(rq, p, en_flags);
> -	ttwu_do_wakeup(rq, p, wake_flags, rf);
> -}
> -
>  /*
>   * Consider @p being inside a wait loop:
>   *
> @@ -3718,9 +3718,15 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		if (!task_on_cpu(rq, p)) {
> +			/*
> +			 * When on_rq && !on_cpu the task is preempted, see if
> +			 * it should preempt whatever is current there now.
> +			 */
> +			update_rq_clock(rq);
> +			check_preempt_curr(rq, p, wake_flags);
> +		}
> +		ttwu_do_wakeup(p);
>  		ret = 1;
>  	}
>  	__task_rq_unlock(rq, &rf);
> @@ -4086,8 +4092,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  			goto out;
>  
>  		trace_sched_waking(p);
> -		WRITE_ONCE(p->__state, TASK_RUNNING);
> -		trace_sched_wakeup(p);
> +		ttwu_do_wakeup(p);
>  		goto out;
>  	}
>
Just wonder if we could split the reorganization and optimization into two patches,
so we can track the code change a little easier in the future?

thanks,
Chenyu
