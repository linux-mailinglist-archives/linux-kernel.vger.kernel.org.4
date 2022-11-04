Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D234618F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKDEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKDEgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:36:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C13DF72
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667536579; x=1699072579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dyOn17XIexxJdt3/yUrLCn7D3ADJnPAId9fkOP/luug=;
  b=YJ6srjLaJt+aDx4trp0Q0XhR2WbQbf7wjMxwgakGbCUq9yNTMldlaz2t
   wp/KQqV56cl9i/yw1TiwxY6iiRSHmi97TOBWyuLPQvj+aihJWH4rRTXwm
   wE24MO8ZCDAXMeJYjQRsi4vNT8CpSzRaY2L8sfu5iugUqGyBDu+CAVfbn
   1y4/3yrDDTi8LhFlzlIyy4n7XMO4LUkYZEJQOJTsKuBaB7wfBDGTJ5qgi
   vxZnhTthGYaIGUzoazMD2VNhY5W8LWSEGWvEeroXrysz3l3uWpohH/3gX
   BjO1PTEfb3Mv8m757MnKHgiOp3Jnl5GQ9vaOTlqPRxbgeyps/IJA3kkTV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308591839"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="308591839"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 21:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="777583843"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="777583843"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2022 21:36:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 21:36:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 21:36:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 21:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW8r8Rn1D9Iygb/ujX0Hdw+nAHz5Kwj18S7/W74XjdAmc4n+qdT5fJBOfn7Vfv9SxkiA2+qqAaqK/wTwPYbpEyebEQBCgSKVYUdt/23H3P37Tti8jKMGhQja24KOr9kKxDunjpdQucbIwbg+Q9RafoWV9xCIIHDhHKgMXRVUSRk3esi9/s24qzYGMHB96qj5hTkKkcTzpN598bjAVxsDY3h959yN4jEGghOLYUEqKicvmGoJy40i5votNWkOds0N+AASyNNGcS2LI6jfTIc4SnhuoGXW8mKMkJwMZdB7VlT81jUdpqYeZTzB1sSmhQUf+q7ZGP90DxjFAgPxO2C3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFH/6cD5CYx4TpMP0xxrkgukFRUa5aH5dIIWdw5AYa0=;
 b=GzPBU2IgRRfH98P1FufSNC8Em5n6qVzZ1ZT2dPPQ0a6OUYoV5cYZtBHVCbf1DC8O7wvDlaOKrPFLbC5vyWYKRt4q2Z6QHmLengJ5EdaBRv53ELUm2cO0T6wEC07wrERmB8p4isgX/kKJGtoXKiRyjWun+AtVhKiY3R2BG856J9V6EwZ/qG5HE6NAtk4cKLLBnkTxKgUHbRwPb4mSiZrbhNh8ZxRrkMXbA9HPm5RLukFt5ZmAuUeM+pUn8L1ganB9WGl6ntpR+0uqOfRRjdkUjBKiZMnlbr4PyS8Mdth/rK0BM/49k3RjoUfgfJHQTW7KpIuYJXnYmZMf/LURtFtKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 04:36:17 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%9]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 04:36:17 +0000
Date:   Fri, 4 Nov 2022 12:35:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y2SWraIliUCXHUth@chenyu5-mobl1>
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <1a34e009de0dbe5900c7b2c6074c8e0c04e8596a.1666531576.git.yu.c.chen@intel.com>
 <Y2O8a/Ohk1i1l8ao@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2O8a/Ohk1i1l8ao@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 973c043e-9599-4423-817f-08dabe1e1ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YxiHORaWtVrp0+Ne6Pd9PAe1P3geSBYQyvwyc4yp6Ph6BSZUvmO8IfIyNGGGzDL5FqdQy04JRoaHbfC+BzkkB26JRtnVsP2T3DW22MUxjAMH54Y7eiOxI1coy+y3dBQeFdUqeBmOqMle5/5FEa7ER1e/C3oYpm6DFz6Z7MyWRbEvthouOk/A6Lr2bGuTUOCCkm6Q89e/lXh/YhrZ/MTuWXD09K0NWLcC4HlVWOhOHgorPr8TR+Vjx/0VWHZRr+gMjOTUTP3z06PJAtcS4iG3UDiiD3dlQBmWtGYJ8jiN3/9gfNJLjdu4oFtparaZVNKQrsLcEpVhtp0/laMEuu6THHxnP0VANj5Cf7skFjmtG5/DrxsoIlzPcuFpSc/NxNcw88poF1721ianUQMZ/R2fl+Dax88jZGeIlyEzQzGZIyK4gzoPCbGIeWcYIiQz5adlSe0rcnWl0u8M1SOTR7CBGaa7aGMVWISOwSDW8xZRaLuNUhunqbW6+O+iYGkQqrLZA67rEoBdbbRpOUNgOnoRkOG3BYO9guiy5dBmgSL1PjqQWt5hlvIP/ptFgz5YQ8ykCx6mm8aiBZ3dhjE8QsQd5n+c+LTS9eCs3GnOo75ogSbFq4w8zlmiGt04oegGby9iD6+bRYOtWPRg/KRcjaQqFbhsSx5xtu+VR6AmSyELh2BZYzGlGpCKiQcTb1+eX6S2+nfHETFyYLMTeffsbtz4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(478600001)(6486002)(86362001)(6506007)(33716001)(6916009)(54906003)(6666004)(316002)(66556008)(66476007)(66946007)(53546011)(83380400001)(186003)(8676002)(4326008)(2906002)(41300700001)(9686003)(6512007)(5660300002)(7416002)(38100700002)(82960400001)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/hbNQWi4FlO078WBNCLq4Dhl+QpMh7VnK4RBqgotbRBeUH/Mn0Yfy4/yr9m?=
 =?us-ascii?Q?85fmo+OxCb2DYfJQVn8nyDOalJsBgKQUAHcrBBGaCM12Etapj/7fqosk8Hvg?=
 =?us-ascii?Q?0cSNnLZ/K3GoGuwGPIJccjMZg2GOrk/4Kv7ZiWSyDUbA06dktEjuNSSDtETt?=
 =?us-ascii?Q?rn8+vESIA6gdbBYr24L/w73vk9xkt29eJk+2AfgmMoyCRnN8BoqjMp2XpTXl?=
 =?us-ascii?Q?wxjrJrE9eRMn3w+K6xS1mRfVLdnbvKi8MCMFdqr6WaNZOpUQ5zfaduhyAXqI?=
 =?us-ascii?Q?G58RNVqQbLyxaEHNXWf2564OS+DbdNdm3uP2PNBdKc/BgHG+5EmT5LI+QPuh?=
 =?us-ascii?Q?gGUZeAOMz6DCCDGS0ZjrikAv8SbNpYUS5h95KlB+EqgiRGiiksCg2mD+kd8n?=
 =?us-ascii?Q?uSTlmlhnYO4RvXIUpC/7fOT9EX2j4oe4zS1EtsgLocrCP3a/43aoClcCW/GT?=
 =?us-ascii?Q?pgzkRTGvuNXfM+wl3llQJ78/N0LcCsZLyNg4BXyTIKa+x76ZeT1JKE8olJRQ?=
 =?us-ascii?Q?R/wp0lxIOAVIBFmPhrEaDiJMZ0kbUzWHmDRXrbfEisMTImO+8DRIlCRFikXk?=
 =?us-ascii?Q?b8H1Lt+OAt3LRXEqQV+JlESkBC+yGFFKA4SPuhk8dlxSyCAfe2lG87NUh5rt?=
 =?us-ascii?Q?fNqcGRWnQrptYCcEUdhWqsnOVCiEmifyjKiJnAhBX1x1+9/nm78jmpa4qt8K?=
 =?us-ascii?Q?4goBdGv9e56acH2s/vuuAoH8dbbre1LuMEQwEsKjjnEAMqA90DqHjNeFU94O?=
 =?us-ascii?Q?WCiTvyWVmE3+roi03G6+FSiNqcTJcvu3ZH0xxuZ/PZ0sLrHZhnz0AfHQ2x/4?=
 =?us-ascii?Q?NplW0fzO3kLnH6Vo8RMxrJY4wUl4uHSnPX5y6JOHCiR31j7mnzJRdZqgdcZY?=
 =?us-ascii?Q?7ZooT+hkQmq923s4hdHVNkZYk+lNfCeP4smVIXGmK6buHZs2cIPqw/P6I5q1?=
 =?us-ascii?Q?BchKjDY92Y/Yc98HxfUWkLPrb+SeRkxyLysKPRk0D7V2W0gqIeErPI6k2oC0?=
 =?us-ascii?Q?mNwrYaYgV+zMhoqM8x0OoCV4ZCy1hwp8CRhbwXjE746U2t1zvfE4DGI+mTKD?=
 =?us-ascii?Q?vzHkRIt7R9aOdEqgPt6aCXWfUNvPvadpj8kzdmNMUq/AckHeclEVqg9Fgzzm?=
 =?us-ascii?Q?K8h/9vMyGrn+KyruOYXQqum+qdzBFq+Y95aWLPd3XkCXl6nt4293Lyo3IdlQ?=
 =?us-ascii?Q?iKFcS3XyrSRIlhz9RsK1/GgCqwrlt/4K2h65E55YYYb9i2LzNsHiHe9O/YKK?=
 =?us-ascii?Q?7AaINJs33grapShuNmwrY+toat334xemXaQ+yWB0razEeXci59b6mgaJYiGm?=
 =?us-ascii?Q?uTG4vAsrQ0WNhVR0Fe7UBQ+ze8RCCwUGghdz2Wpo+KHLU81t93Psy8S0YIvG?=
 =?us-ascii?Q?aSdWob9YpSguUs5+hR1q6bEcMHFxy06Gzc6PNktp16/Qf05FzNMfWYcnXJQq?=
 =?us-ascii?Q?DQDv2arPDFpCJjsJQhg4BLqpGE7Ks9cyKOnM0eMOV19jdGwJdC1urqQiZjN1?=
 =?us-ascii?Q?x1L4yYW5TIRVoFTxERt5Brh7HybET5JouSSejy8/qmuz4p52SeskWMlkv82e?=
 =?us-ascii?Q?GTnziIu67dq25z3hEZhp6YxV8seW5dKAIz8FNvFZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 973c043e-9599-4423-817f-08dabe1e1ce7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 04:36:17.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIOiv1vwnbLwt+mvBHW2VKKXDcdZZWhApekqsLTeNBBsbs2ON0cne5P/i5bMetjll7kHRA1a7p7KqrbXZpsIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-03 at 14:04:43 +0100, Peter Zijlstra wrote:
> On Sun, Oct 23, 2022 at 11:33:39PM +0800, Chen Yu wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8820d0d14519..3a8ee6232c59 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6249,6 +6249,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  	if (available_idle_cpu(prev_cpu))
> >  		return prev_cpu;
> >  
> > +	/* The only running task is a short duration one. */
> > +	if (cpu_rq(this_cpu)->nr_running == 1 &&
> > +	    is_short_task(cpu_curr(this_cpu)))
> > +		return this_cpu;
> > +
> >  	return nr_cpumask_bits;
> >  }
> 
> This is very close to using is_short_task() as dynamic WF_SYNC hint, no?
>
Yes. I think a short task waker is a subset of WF_SYNC wake up, because a short
task waker might go to sleep soon after wakeup the wakee.
> > @@ -6623,6 +6628,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  			/* overloaded LLC is unlikely to have idle cpu/core */
> >  			if (nr == 1)
> >  				return -1;
> > +
> > +			/*
> > +			 * If nr is smaller than 60% of llc_weight, it
> > +			 * indicates that the util_avg% is higher than 50%.
> > +			 * This is calculated by SIS_UTIL in
> > +			 * update_idle_cpu_scan(). The 50% util_avg indicates
> > +			 * a half-busy LLC domain. System busier than this
> > +			 * level could lower its bar to choose a compromised
> > +			 * "idle" CPU, so as to avoid the overhead of cross
> > +			 * CPU wakeup. If the task on target CPU is a short
> > +			 * duration one, and it is the only running task, pick
> > +			 * target directly.
> > +			 */
> > +			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
> > +			    cpu_rq(target)->nr_running == 1 &&
> > +			    is_short_task(cpu_curr(target)))
> > +				return target;
> >  		}
> >  	}
> 
> And here you're basically saying that if the domain is 'busy' and the
> task is short, don't spend time searching for a better location.
> 
> Should we perhaps only consider shortness; after all, spending more time
> searching for an idle cpu than the task would've taken to run is daft.
> Business of the domain seems unrelated to that.
I see, the this_sd->avg_scan_cost could be used for the comparison, I'll
have a try.
> 
> 
> Also, I'm not sure on your criteria for short; but I don't have enough
> thoughts on that yet.
Yes, the criteria to define a short task is arbitrary. If we compare the
avg_duration of a task with the sd->avg_scan_cost then we can skip the
defination of short task.

thanks,
Chenyu
