Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9347275B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFHD1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFHD1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:27:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246E269E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686194840; x=1717730840;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qw/c4BHpVozuC0Cg0RZdPVRvdV/PIigQ/X5zxBaozHs=;
  b=KlkdAX1jTXZC+2K9B4miIH9Hjrlnj9sT2ClJKu6EPRQZA7Pgg/xfBlVk
   hYudm2ORaHD21A2Lk1nrViPU34PevGXNmjqvV9MGMRC4QiQDBEkCPH+Ww
   6renWLdIFgRVhdbToduR1HtM81na0bVYCUBwysD+ypTPH/sT9BZ+a+Qmd
   nQqi9MyPG40MWrd70aVwoUltdPwZzbXh8/Q/tMwolZQIh52v88u9Ng0/M
   bS2TchONZDWgM+qVv3ZcMr8bxt7mKeTpsb/b/Gu30P6octUMkHj0khEHM
   l9G974eU5kpNiCe0akFoU7bzEfSePBUvNNrxg5t3LybmZzwnq9VD5WTY9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="357193472"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="357193472"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="822427857"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="822427857"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2023 20:27:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 20:27:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 20:27:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 20:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sor4r702bpo2EYgWZ6ChP37ivISLXp5rQHg7eRWWwrju4g53wRTguPvWDWkEsT5gOvHEcMH21knFlXurucsPcdXOSOvrlD7VFWtTgw0ElgZ6UDqEDGq2mCg9178WboNZHuJoDu73SznBcgcIIRTe6nTbGm43TM/W1dE1c458UJ+Z0wr1g6lunRyZVtitZ3YHrrcHIQimlwe85XhM5eIo9Bk1MI0l8DDGmqbW0OJk8DaYyPbm+RbgmYG2l8eVwnHIT5R2r2zH9cQCOwgyJvXh9f4MZ+NUBuxYspZo0rCZf7Ql6S+H7pYai1OKUZi3NL9MUzoTvLOoPWjAU3PXL2apEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn42vknPbRBsgRGipli8e0BPpmEhNiDArwP9XfIX4fQ=;
 b=PVsTs4eFOBFjsWx5djiLLIOQQ80SWyGTIsx0SsrPvO3/cZgy8L55FNSf9fF/Dcx6vt58/LmRjanlPxGksXIHBexrmdt9c+YbfSzv37xsuXHpahmIGfmOdFlIMoQUE5/xF3EIT5gztYypH8Ki6QpHtIrMcGPrl5CxQXD/ZzR7R29y4ZxZ9SIFw6z+NDebpBmJ6CwiD9n6qwRPzowqzdI5wax79BmAYrTCeGqiRs1coWnU2VQO1pSyEzCmNA0C7fDuaqt+74Ni+mrgqpUMDEn6yCjgyx1szRSqX6K3T6fO4yXH5cbc1FDXhac8xOoRDTTDDRzozhP4JeN2wg2QUOsWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 03:27:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 03:27:16 +0000
Date:   Thu, 8 Jun 2023 11:26:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Peter Zijlstra <peterz@infradead.org>, <yangyicong@hisilicon.com>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        Barry Song <baohua@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZIFKf2PkIkiRmUaK@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
 <20230530115527.GC156198@hirez.programming.kicks-ass.net>
 <8fcba5d4-eea5-d7c4-2bf7-482321b333b7@huawei.com>
 <ce714341-af58-2522-69a8-321f02c82893@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce714341-af58-2522-69a8-321f02c82893@huawei.com>
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf07ace-1ae7-4dae-7cb1-08db67d041e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6xgoQbqSGfjpmfLjLLkoYiaEviY6BeTOn3mxAsfXWUsh860R6BCtgM5zxeyA4XST0fRQ42nc5wINifE8A78M5q85runNeTzpO5X9CmfjllIOO+gKaaI03JMhZITYakudhRqy30eN8OVUta6cdLyEJtckfViO2VMb/1E5FlRpO0v+BLlGZALYHazmtcam/JlRmj3e3WJgz9MNFIcj6S8wsYHpIzNAiqeaDd/1FalGldlzRFeZ+vAc6rDVviHtjuKQQM4ENpAf13+29SLxbwOEu0kTez8PS2DFijAgM3qPKe9d18Ulu45b3Zc61PxqF54aA2U+AKJACO8KS/l3VHIQfCU8FaRDozqG+XzoY3rmlXuXtWQvNqJVgHNQ6bBGgm7Zz7WLmaJ4a0NiF86EXIIXinHkVEwRFiTyh19dS/T9fxK+WrlCe3Sed+4W5eerzT9rjxpQi1iVrbM7s58tvuaIsBDNHy++NOyiZ6ucnaPxjSmeHWc1B0w0LloAqU1EtH9TVeCW10vjbDv63vLyDMe60OhAa1DuVOWfIzBHyLOFlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(478600001)(2906002)(83380400001)(6506007)(53546011)(26005)(186003)(6512007)(86362001)(82960400001)(38100700002)(6486002)(966005)(6666004)(5660300002)(8936002)(8676002)(41300700001)(6916009)(4326008)(66476007)(66946007)(66556008)(316002)(54906003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQYFdBeHSk9KjQAdQeImrABEM6vYStYN0pNXOvIQ0cked+/QNKWphprW2PNZ?=
 =?us-ascii?Q?ISWVsR0heR+BmrjBZ+IvhKqu3s+/R46Ff7WwA6ra/m2MljT4xi0vBCA97OfO?=
 =?us-ascii?Q?suRf/dttMVK8bswqaslXcf1hH89EInYezmOGFOwZuLev+sxyztpBqYYm0eKw?=
 =?us-ascii?Q?F0bkaAXhe0nIeitHKI2W9Da8HmeAyM6MuU6la8V1c3JgEpOi6qmog7fMaVQH?=
 =?us-ascii?Q?QNWRuN3YRVe4eWiGrphrAq1z1fWr3DuejvmqeAEWzCDZYvQq7svGMLficVGF?=
 =?us-ascii?Q?ckmYJ54LEoMaJz1D8zm8OVmPzQ4+S5HwE5Nv+hZm7XJTSbE5D9ajaTA+Yd3w?=
 =?us-ascii?Q?fFal3J1xEunqb/WYNKaqPwDuodgh0+6tfrd9So5maTLBmbEVoUnOv+FwHZ6J?=
 =?us-ascii?Q?MjdT+OMi3oaKZ6mfXv0pZsUs8n/eRq2wLAOGRfT13PxLu4ifz85Y/AGIsb4L?=
 =?us-ascii?Q?8qiaLS8SO3noRSMnc4mA4xFF+fSz6YK7IsmJGaEFqPQBeLk5gqTqEtdKBO+V?=
 =?us-ascii?Q?acbWUsVfSxwTjm3b5BkYfEHUE9qCPF2c/yjb+H+BBxaKCgfcODScwolPTuLS?=
 =?us-ascii?Q?INd9Jff3cc8ZO/G0PjyCBY9OFb8kk+nkCS/aSYAYPbjw4OxXIXyf1iUvg/R6?=
 =?us-ascii?Q?FrbjBS7siHlfxTnV1PmzzT91ynkD+d/L/m7+JqXFYpQLDOsg5PLiRdIjx2sD?=
 =?us-ascii?Q?PjcJpNctyjgPDDUupO2S91fw2hxswJOtlKC/MfUimbvQ3iUMXyh3Jfq5hCV7?=
 =?us-ascii?Q?nRGFV9JB+dKLyNlK8B8uHw6+qDsS9xSplSWrwuiibe4rp3EJO2+jvIV7spQa?=
 =?us-ascii?Q?AdZ85fCJEZJwiyATvNhc/cyMGCJ6IFQ63PYf++a9dw6qWnt9Sghr+1RiWwZ2?=
 =?us-ascii?Q?8v9RPLFmz3jWQQkUu5z60L1wG37PSVzIQqAHdDBEUWZWal8bqhqcd5yRJcMO?=
 =?us-ascii?Q?1l4soX3+siYc5wJ+UL0SSAHJqSufJQXUIJmmnO0hCxhSnVYRZ7eIQjEdxKQq?=
 =?us-ascii?Q?yLmxJN1wi18A7ElohaM/D32cZT0yudthrjLGFOJmDoeIC1MVtAxQ28k3MI1m?=
 =?us-ascii?Q?bZyjZzWawYMXza/hD5mFuclINJlrT1R3trSZVtXCuF9zf1U+NoO13nFrPe81?=
 =?us-ascii?Q?n8oIiRMWh0YgzV2DIONA7la8YYhj+QZv/VywX7GHl9BsRt1+m99VijXqoNfd?=
 =?us-ascii?Q?IBS33F/foDt+C56PytxNGtMjYOO7f+EquoHUlNmQvYcM7ydPcycYof2UtMuq?=
 =?us-ascii?Q?qL96M+r7ILzFwSnTk/bj//O/praTadowsf6DVB2ptbE5M39h9gwt56BIoAHi?=
 =?us-ascii?Q?zvziWStS4J+urVjqDynqM99Ph4xPjKNyKRgmDniLltEEMPPOF4Gkw2TLxYSI?=
 =?us-ascii?Q?fYtolNppvBWWmP/WqSVf+0Af1k4a2QGinOLpqyncCWpPf8fgdBqG3pK88m05?=
 =?us-ascii?Q?gNheopkUeNWJmy4UPGq40oQc1zmBI2jFrSBFA2KfT3YyWpkfAuOMQtJGTt2k?=
 =?us-ascii?Q?Y28xQ8u/29TxgSVwxSpvi48r7uhqlncuYbqZ2/A9P3+6sndm/JfH0ZLauT1Z?=
 =?us-ascii?Q?cC0b/fOQ4BBPBZ6beH/cZaJCsF9KAdgiCU1EHgcx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf07ace-1ae7-4dae-7cb1-08db67d041e9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:27:16.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: couGeNIMN3lxGtvkLTTw2zQU+tGi7rNF2bFcVCml89XMy51fNtCkiauAnxski4CfGs9fO+ea8WcKD41fqKbRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-31 at 16:21:00 +0800, Yicong Yang wrote:
> On 2023/5/30 22:39, Yicong Yang wrote:
> > On 2023/5/30 19:55, Peter Zijlstra wrote:
> >> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
> >>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 373ff5f55884..b8c129ed8b47 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>  		}
> >>>  	}
> >>>  
> >>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> >>> +
> >>> +		if (sdc) {
> >>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> >>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>> +					continue;
> >>> +
> >>> +				if (has_idle_core) {
> >>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>> +					if ((unsigned int)i < nr_cpumask_bits)
> >>> +						return i;
> >>> +				} else {
> >>> +					if (--nr <= 0)
> >>> +						return -1;
> >>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >>> +						return idle_cpu;
> >>> +				}
> >>> +			}
> >>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> >>> +		}
> >>> +	}
> >>
> >> Would not this:
> >>
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
> >>  		}
> >>  	}
> >>  
> >> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >> +		struct sched_group *sg = sd->groups;
> >> +		if (sg->flags & SD_CLUSTER) {
> >> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
> >> +				if (!cpumask_test_cpu(cpu, cpus))
> >> +					continue;
> >> +
> >> +				if (has_idle_core) {
> >> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >> +					if ((unsigned)i < nr_cpumask_bits)
> >> +						return 1;
> >> +				} else {
> >> +					if (--nr <= 0)
> >> +						return -1;
> >> +					idle_cpu = __select_idle_cpu(cpu, p);
> >> +					if ((unsigned)idle_cpu < nr_cpumask_bits)
> >> +						return idle_cpu;
> >> +				}
> >> +			}
> >> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> >> +		}
> >> +	}
> >> +
> >>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>  		if (has_idle_core) {
> >>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>
> >> also work? Then we can avoid the extra sd_cluster per-cpu variable.
> >>
> > 
> > I thought it will be fine since sg->flags is derived from the child domain. But practically it doesn't.
> > Tested on a 2P Skylake server with no clusters, add some debug messages to see how sg->flags appears:
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 69968ed9ffb9..5c443b74abf5 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -90,8 +90,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
> > 
> >                 cpumask_or(groupmask, groupmask, sched_group_span(group));
> > 
> > -               printk(KERN_CONT " %d:{ span=%*pbl",
> > -                               group->sgc->id,
> > +               printk(KERN_CONT " %d:{ cluster: %s span=%*pbl",
> > +                               group->sgc->id, group->flags & SD_CLUSTER ? "true" : "false",
> >                                 cpumask_pr_args(sched_group_span(group)));
> > 
> >                 if ((sd->flags & SD_OVERLAP) &&
> > 
> > Unfortunately the result doesn't match what I expected, the MC domain's sg->flags still marked
> > as cluster:
> > 
> > [    8.886099] CPU0 attaching sched-domain(s):
> > [    8.889539]  domain-0: span=0,40 level=SMT
> > [    8.893538]   groups: 0:{ cluster: false span=0 }, 40:{ cluster: false span=40 }
> > [    8.897538]   domain-1: span=0-19,40-59 level=MC
> > [    8.901538]    groups: 0:{ cluster: true span=0,40 cap=2048 }, 1:{ cluster: true span=1,41 cap=2048 }, 2:{ cluster: true span=2,42 cap=2048 }, 3:{ cluster: true span=3,43 cap=2048 }, 4:{ cluster: true span=4,44 cap=2048 }, 5:{ cluster: true span=5,45 cap=2048 }, 6:{ cluster: true span=6,46 cap=2048 }, 7:{ cluster: true span=7,47 cap=2048 }, 8:{ cluster: true span=8,48 cap=2048 }, 9:{ cluster: true span=9,49 cap=2048 }, 10:{ cluster: true span=10,50 cap=2048 }, 11:{ cluster: true span=11,51 cap=2048 }, 12:{ cluster: true span=12,52 cap=2048 }, 13:{ cluster: true span=13,53 cap=2048 }, 14:{ cluster: true span=14,54 cap=2048 }, 15:{ cluster: true span=15,55 cap=2048 }, 16:{ cluster: true span=16,56 cap=2048 }, 17:{ cluster: true span=17,57 cap=2048 }, 18:{ cluster: true span=18,58 cap=2048 }, 19:{ cluster: true span=19,59 cap=2048 }
> > [    8.905538]    domain-2: span=0-79 level=NUMA
> > [    8.909538]     groups: 0:{ cluster: false span=0-19,40-59 cap=40960 }, 20:{ cluster: false span=20-39,60-79 cap=40960 }
> > 
> > I assume we didn't handle the sg->flags correctly on the domain degeneration. Simply checked the code seems
> > we've already make sg->flags = 0 on degeneration, maybe I need to check where's wrong.
> > 
> 
> Currently we only update the groups' flags to 0 for the final lowest domain in [1]. The upper
> domains' group won't be updated if degeneration happens. So we cannot use the suggested approach
> for cluster scanning and sd_cluster per-cpu variable is still needed.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/topology.c?h=v6.4-rc4#n749
> 
> Thanks.
> 
>
Is this an issue? Suppose sched domain A's parent domain
is B, B's parent sched domain is C. When B degenerates, C's child domain
pointer is adjusted to A. However, currently the code does not adjust C's
sched groups' flags. Should we adjust C's sched groups flags to be the same
as A to keep consistency?

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6198fa135176..fe3fd70f2313 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -713,14 +713,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
-		struct sched_domain *parent = tmp->parent;
+		struct sched_domain *parent = tmp->parent, *pparent;
 		if (!parent)
 			break;
 
 		if (sd_parent_degenerate(tmp, parent)) {
-			tmp->parent = parent->parent;
-			if (parent->parent)
-				parent->parent->child = tmp;
+			pparent = parent->parent;
+			tmp->parent = pparent;
 			/*
 			 * Transfer SD_PREFER_SIBLING down in case of a
 			 * degenerate parent; the spans match for this
@@ -728,6 +727,18 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			 */
 			if (parent->flags & SD_PREFER_SIBLING)
 				tmp->flags |= SD_PREFER_SIBLING;
+
+			if (pparent) {
+				struct sched_group *sg = pparent->groups;
+
+				do {
+					sg->flags = tmp->flags;
+					sg = sg->next;
+				} while (sg != pparent->groups);
+
+				pparent->child = tmp;
+			}
+
 			destroy_sched_domain(parent);
 		} else
 			tmp = tmp->parent;
-- 
2.25.1

Besides per your description I found that something is not quite right:
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535e37c8..6198fa135176 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -747,6 +747,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			 */
 			do {
 				sg->flags = 0;
+				sg = sg->next;
 			} while (sg != sd->groups);
 
 			sd->child = NULL;
-- 
2.25.1

thanks,
Chenyu
