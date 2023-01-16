Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00D66BA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjAPJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjAPJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:26:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0A15574
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673861198; x=1705397198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6Y5GZ+mFadA9/OiFHav1m1EgaKqXYxNgzXdIhIehEG4=;
  b=Q1UGovbOFSTKi+PZDjPTcdSl1Ix3Fz/x8bFPYiwJKcx3o202Dvq0aG6k
   SpPcn26v5w0touipsrP99Yv4AgtIIPYd6XiMqsBdFJEvqy+nfxrmzlEIy
   JQ9KiL16GdQagZlyaV62yfTSa+R+6qjzDju5wA5a/w6Wd9UhRtFncmdNR
   olpIIOuSVHj31O00OTxRMCWJgtYz138mhiyOQRXyLpSSjna8AWQYaCtd0
   ElQsn59IuS6qz4fkonxT/Getl2yJ9TYKYK7lhWB15G6n83zjOBY+BelP7
   MBwro4pL3nXQD4rrJO482uPuiYRSUxwCdBqqnnFbKNZHwCEpyjXrCSibs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="324482875"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="324482875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 01:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="658955546"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="658955546"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 16 Jan 2023 01:26:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 01:26:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 01:26:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 16 Jan 2023 01:26:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZAe+ljA0vnGQIDebxDGJ5H1sRfjjrQKP2JWBGFe/ct3EbX76xi7+uNCjUbkkR6A3Bgjk/uV6eR3dC2UNcVCEhXj28lkHY+c1D+XWSaf789b+Q4/7RRepU3PwxH3QddqB8+STm+38fxIao+/2mf9ktv58ABZNK1cgzmnStSWVUACuNOxRVmtTCxyEPZJ3OID1MbctaSbhFe++nLO6TWzqtqLndUgHg7ad8hKF0rEI6fVH3h3ivmj7KW5eUrpEtrGKAkrhDexvlWUCpljHbjmYCm6p0QW4F5br7dWzvbbI2qwLTpSpuHC8eRGPLIceZBT1Abgvz4ndT9ok15sD3Hylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGdFfCMAL2GEvbSJE7H2/usTyzRHrHsc0uV1DJlCnj4=;
 b=RoWbNPVdyQ8MhvYszgE1BnfJ/dz7UcpHCYLUBS0OcfM7B81kiwNy0tG7+9qc5SjZ+bVIoaMO1xrl1ffbTXaKPky4bhaWeQXv8wvoKgbkblNKIFdOsw4b4OCZVSvlHXYo52XLI/6W+PiHYt9P9zoLtgcfs8cQl2Ab/HmViDiz6q810DA3r6uEWhEdYw1JkCkjz7dNxpfU3jiD9QzoAYsPQCRvXHo+6ul0jcSJ2rgR+M2djCA6sYqXEMRkePC/gtQ51/k6pc3OdIDpvjub1FryrMbY1O4pexcxnCEMEic7ltbPCA3tlm/8s/qhxEE1dUbAiF4mz9jXyo/HLEG2iT3hjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:26:19 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5986.021; Mon, 16 Jan 2023
 09:26:19 +0000
Date:   Mon, 16 Jan 2023 17:26:03 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tio Zhang <tiozhang@didiglobal.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y8UYKzBJeejHCpgO@chenyu5-mobl1>
References: <20230113105413.GA30243@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113105413.GA30243@didi-ThinkCentre-M930t-N000>
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f901cf5-aeec-464a-c71f-08daf7a3b97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V59kOgl+b/DxxCh1/5s/ub3xSqD+5U5lFHxIvd10kEDN3yyoiJDIXyExanco+hrT8Qgu7csZHcJBKzbgUaGbKLrjzgjT0yfHWbfpHb0DdKaIlwtsMnf9HYweK3GusbGfHmy8EN0eNPPAjGxMd5eSAvkh4x6lxaPxinzpWcSvXvqqyGCjZ/kcrsYMjqv8+xY4ROGRYBWC/uAzFoLBul3wFk2OIWGMCFd/c/cO8/TiNdA0D9lHEpvOeuazF4LOMxHCNc41247q/TMoPc1/JDViac261PRX1EXZS1uIw/dfopy0IRHKcCSsqhPC7Oh8p8C91IoTpjW/5nA4ok9rEZRKO/F35NGrFQnkiLpKSiIYfMiafxcV1VHnnB1BNclJJCt4mbewDQGDFZduWH7iW5H4kO9W1jdhH3dCaraGkj5+Z7Kt8paEgl0LppTHAeaYd8Yqjk9UL+FlWV5XMbawLWgDBAxTRNM1wzNJ/8poH51sHOgaLD877YZuKHwd3Y/WHmpLOVBNm7sS7Yhca3ne7jtto0lGhrTjIWwxqwCyub9rPZV7hBZts/QEa0/lzkL70kM/8Vh7LhXueXmvJDyE8iFBo6AvKBLbGZUfK3x9nzQyiKi+c+LvPq9MMocXR4JIZBVg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(2906002)(5660300002)(8936002)(316002)(86362001)(83380400001)(66476007)(66946007)(66556008)(54906003)(6916009)(4326008)(41300700001)(8676002)(6486002)(26005)(186003)(53546011)(9686003)(6512007)(6506007)(82960400001)(38100700002)(6666004)(478600001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OefILhTBopJ6i/ku61efpQqR3PU8lBOUxvBozUtGCdnFhFIi8ibu00RNyAUy?=
 =?us-ascii?Q?7SVMAdx0hqlBKCpxsIIVyaOAqAFIoeSntxCuC3ff8yZTX2A6TmrPM5UqE0Ug?=
 =?us-ascii?Q?+UIbYNxHxJy0tQwrcfjlAs1QNrEDJYVs3N4x2lJg/jFnNrBOElZv9aBjShsy?=
 =?us-ascii?Q?v8Lrnh9UXz31kKzolUSTtP2rRYtpTZHP9h9c/JoDGypaN4jqo15oNVMWTtRx?=
 =?us-ascii?Q?8LlpBqay/vL4Ys3skTKHnXV4EJH2Juow7yrHrW4ImZriEjZiNzON36fFyDLf?=
 =?us-ascii?Q?w6TOxpcq9/83Ht1ZuDMzsolK+oOFT2IGb3lmN962WYiYUuxjzG3Aq024GS/n?=
 =?us-ascii?Q?XcFo08a4ZUww/nzMjjhFydCunznmganG2cBoyAR3dioipwLjNUKU3SCQiTpC?=
 =?us-ascii?Q?Loxe+zfH1MC0+EajkdUlaeUi7eAypDm8l0nKxfZrS4Wwo3h33ktJK/5vSgHw?=
 =?us-ascii?Q?NmWMUN+hBwymYJPfnMOVnA4hdIUkbNqRex6LnTKgWDu//tk5igezQsm1NYas?=
 =?us-ascii?Q?nq4FzsRa6AIyHZ71yn2cR/kWcpR+MyE9Qb0i2UO5+W30L9K0X3NsR1W9wT/9?=
 =?us-ascii?Q?pX8A/CcNJbQqcVHPAGTZb+JhyBNTxv0XHN+k64uS3ldXEjHndGlOIItKSEuV?=
 =?us-ascii?Q?ZwLWNA9GjyCgDa84GdcDXUHSXw7CPe6w24NJ5nZutkL84y2BVIOyhWqjQmHL?=
 =?us-ascii?Q?EHHAPJuUtAfRtMSazsk8wcykQYTPB9Htho9Oi1lAzmedrAkVs3+Oi3MLjFzU?=
 =?us-ascii?Q?mw5rzq+DLE7PmHe+lUjrMYe6rDVdJ5R6MiRV2jx9LGVtQNtJV7w7pTbN2eN1?=
 =?us-ascii?Q?Nf0FWnFe3mJMZfpZI6eYcQH5kQWXKB/ytFStkD6vRXeB3GBXQxPHz77MTJSI?=
 =?us-ascii?Q?Xvg8FesoPPIvwMNgBbtaYldpieDxAHIHNz4VoUNDzS/C8Un+9ZVf9Z1n8FRF?=
 =?us-ascii?Q?B/StpHWgunzviX3aOJJIThX2H5T2F4eXVCxTUD7hWkosAUbCHGfrP6cxVJjS?=
 =?us-ascii?Q?nMymENyuA4N2ZOX+yvclaKIh4xPJhYqaHMiTQDX5zfvAopt7fRH8IMaUyYyq?=
 =?us-ascii?Q?Fojh5rbrUgWOUw6EcWVh0NwOIByg9MNm8gScYe5bEIgtagS9QWJ4AFw5QyZ0?=
 =?us-ascii?Q?vPGwxJsO3T4k6lIiMGazzjC8yOKU2esIr30hAA4Pif9cU6jjv+2VT0u8lacp?=
 =?us-ascii?Q?UDaxQKM2qM9Q+rFZXQQRL9V5hgMd3k2z9Si25RcihUZGjsMMUaQTH1x2ngq1?=
 =?us-ascii?Q?CneCur+jbSVWXC5htL2aA5EzsGC7Kpi3LFOBlYHUvgBPa7laGTZ6xo812j1m?=
 =?us-ascii?Q?LUbWwNG84VfBl9AfkWIIKWmxE596pOMYbp7u8z8+Tz1d9+rYtMN1eEIQzNS0?=
 =?us-ascii?Q?S5eTgJPV+/JTQU9IaE7x9Twagw1OFl44QNsaAsYNgEAopN55PkOoq9lichF0?=
 =?us-ascii?Q?MHmVfJZVchqu2YHbOXWwirPZpOOVnnlSC2lUaWwwcPExw3u+emZDY+rXliUm?=
 =?us-ascii?Q?5xesJy4VZXAorU84vI93lizaTLYPwYn1cf8/zQmPOwmBeBnam60N8v5fv8Go?=
 =?us-ascii?Q?9JFjBJKApXaFWR5stk/5hAz3X/bn0SDk+x7a73IZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f901cf5-aeec-464a-c71f-08daf7a3b97f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 09:26:19.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwS8miSoj2EPYsLrHtfZ4zz2OJAONXdUUxlJ/vUnV347/n2624nyCwD2oWeTddHJL4ef+0KL8KaZGBJONNYPtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tio,
On 2023-01-13 at 18:54:13 +0800, Tio Zhang wrote:
> Knowing who the parent is might be useful for debugging.
> For example, we can sometimes resolve kernel hung tasks by stopping
> the person who begins those hung tasks.
> With the parent's name printed in sched_show_task(),
> it might be helpful to let people know which "service" should be operated.
> Also, we move the parent info to a following new line.
> It would better solve the situation when the task
> is not alive and we could not get information about the parent.
>
Maybe generate the patch via git format-patch -v2 because it is a second
one. Also Cced corresponding sched maintainers as they will make the decision.
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> ---
>  kernel/sched/core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cb2aa2b54c7a..5be3f476ee5b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8853,7 +8853,6 @@ SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t, pid,
>  void sched_show_task(struct task_struct *p)
>  {
>  	unsigned long free = 0;
> -	int ppid;
>  
>  	if (!try_get_task_stack(p))
>  		return;
> @@ -8865,14 +8864,16 @@ void sched_show_task(struct task_struct *p)
>  #ifdef CONFIG_DEBUG_STACK_USAGE
>  	free = stack_not_used(p);
>  #endif
> -	ppid = 0;
> +	pr_cont(" stack:%-5lu pid:%-5d flags:0x%08lx\n",
> +		free, task_pid_nr(p), read_task_thread_flags(p));
> +
>  	rcu_read_lock();
> -	if (pid_alive(p))
> -		ppid = task_pid_nr(rcu_dereference(p->real_parent));
> +	if (pid_alive(p)) {
> +		struct task_struct *parent = rcu_dereference(p->real_parent);
> +
> +		pr_info("parent:%-15.15s ppid:%-6d", parent->comm, task_pid_nr(parent));
This might change the original scenario: if !pid_alive(p), the sched_show_task()
will print ppid = 0(init task?).

thanks,
Chenyu
