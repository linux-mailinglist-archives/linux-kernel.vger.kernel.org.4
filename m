Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C673271A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbjFPGK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:10:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDC18D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686895852; x=1718431852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VQgAJlNcjyuZTTqKsYSjY/9EiKLU/chrycUHoYMleMQ=;
  b=Vd4a3LGpj2JJL+aWZu6KbqgwZowPcRufb7b55Vki+nlBaOWUSZZ20+Wu
   HhhBpjF0cuW+dzh3PjxF+TDjBd9DfmSttn/vs6uWgj7Lzilo7Tnx7WI7V
   9L5PSQY9SFSiXWqxpDjX3KaGtyoHf0VtXEjNz6rz+P5CA9wtjFzaTBTpz
   3TG71YXy04NX/8FTS9tfFvJP4vfUKWLbsGq5uYCRLg4m4E8Z/vrHtwLXR
   DtCu7VujNEo+hU58MEHMPPDsLcFKOyyf4q7PbrfEfJGyTbdPyiUb886DV
   7IuuvMYP35eARpmbHtRx9uvtjZFyD5xi8gYQAbd4NbmdJtulqMfsXezM7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359140809"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="359140809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857260345"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="857260345"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2023 23:00:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 23:00:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 23:00:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 23:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoiwL7q/P/pPqkAdO2ZbYl10iCPU/2wGGe3dlmP4i8LEPudX9tFjHVZRS60e+axtqkhm5dlZFXlaWeg+1OvqesWczBgijluMGUCoJKsnLrbHNAo7nYILleKJgWTVc9O3oR7GFajtO1HD3OthopH7m1wsKdDhCLo3WuY6Pon/MYlAJzAI+BnACvpjE1/FivF3t87w7MiDTBTqmenGvgBfus7gzg9sMGX7loh6/6zyphTlhwFuZUl+Hm0zT5HPeURDmHZF3xH9IgAtFffcPzyN36Ne8ldpmhLuC4CExICtmUvbrVFXDIyeEnZgJeAIUpEp6kue656dRokZMl3Vq9Xcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4NS7tNd5KNP+y/q5iyZncGBZ+20TCuqTKHPF3e7CbE=;
 b=fAk1W6XeGxlEIAT7KIZLyX4r8MZInhBhv/hQwNyRCPCWwY7OLoFsHVIxoVbjpX3G3bX+B9nKsxJ6hBGjuRwDyAhlegtvJzcu7yHjF2M4fJdDv8iu/jEh2fgb6wkJApheIsiO1i6bNPHp/AGU53EO+trJN6ii05kKAu7Ap/G/cFRRk+0J242eX8F/15ZIzNd7vMtBf8imv8tCa/F+C8lyAOheAnY42ZdTVlMy4ZK0MGcKmuvjwWXzmtSZjDrKY1ElU1ixivUnqPyP5fM+A4WMoQ2OAyQZRC8ZPS01uSjNpStRGmGeFSsZdZsLr8hyX7RmGTFOeNW94L8t6MMzBAGYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM8PR11MB5704.namprd11.prod.outlook.com (2603:10b6:8:23::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Fri, 16 Jun 2023 06:00:28 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 06:00:28 +0000
Date:   Fri, 16 Jun 2023 14:00:09 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZIv6adoFpZUfe5Y5@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230530115527.GC156198@hirez.programming.kicks-ass.net>
 <8fcba5d4-eea5-d7c4-2bf7-482321b333b7@huawei.com>
 <ce714341-af58-2522-69a8-321f02c82893@huawei.com>
 <ZIFKf2PkIkiRmUaK@chenyu5-mobl2.ccr.corp.intel.com>
 <85e29dd8-60f6-1e84-b3e4-061e5a2a0037@huawei.com>
 <ZIMEEnozzC+Uyluv@chenyu5-mobl2.ccr.corp.intel.com>
 <f534ead9-56cc-d834-90a3-67f8532230ff@huawei.com>
 <be1f2bcd-fe03-2b0a-0754-1054a09663a2@huawei.com>
 <ZIhkr5xIijJG6AKF@chenyu5-mobl2.ccr.corp.intel.com>
 <e7a0461d-fc28-b752-605c-bd8e89f5a844@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7a0461d-fc28-b752-605c-bd8e89f5a844@huawei.com>
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM8PR11MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: ed832da6-8c07-48a9-4827-08db6e2efbed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AO5DBW2BBL8jPzFJigMTvJWOPzuUq7HDXnJo4vIp3I7lrXRjs2HSX3lsHf1VJ0y/XN7fZtJK1EO0XTV0WTgWgza1WDb6kAbMZ4EjKBsfbsnKy1YHtjCXtpkvOx4WlBDYKcwv82YQZCuYHy7O9nrV/aYiHvE+rPK5R/8RAzxILd5MCxioUJPL6zsRfIh+H7de6tqyYAC3YA026sYHHaZR/eUj0J9FNf8zetRnUw1omY7uc3SvZOgRHoAfpvGKfH4/m7K7VI+lNJ0kt4TZgAUm5S+KVpVDzVlnH2bh2J906wRF3OImjAcqSSwB9o0nuSiyH8hVB4P8z5E2Ytdin65U+hKfu7QO4CaPJOM2tXi2pBMrJjRsEqNV3/akMmPB5ardIn/W29DU8MJFdZhewzy9zp+S0dYO1VI7D3LdBkRI2cSOJ9Z3wNV3sv9jSmpcAPDT68EpuSVAjQaiGa8g/VMvhnGEACoFZKsXCmkK3hIjGP6vHkXPDGwEawtpyDzoxS9BOXQVXfUFG8QZmeiQNsXIDR9jpwjkd0rpggRcFOa4dX9TxFgtqKOhQNaJRRfT0Vx03zHYdrkeTFWjNCNxly3+WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(5660300002)(54906003)(8936002)(41300700001)(6486002)(8676002)(316002)(966005)(6666004)(186003)(53546011)(6506007)(7416002)(26005)(6512007)(30864003)(478600001)(4326008)(6916009)(66556008)(66476007)(66946007)(86362001)(82960400001)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22tMK1CgxHNyET+2nOb3xyHWIs0SmICyE88sAR1ZrVKXABZW/Sy9i7GQKBcR?=
 =?us-ascii?Q?fmbvlE6w8hyypoh6W+3H+mWw6Hvo/fQcBgrHK7E+5ILMN5/HH/x7z6A1kpKq?=
 =?us-ascii?Q?5T0XqitP8GQY6RUYnM+VoWJ2oS7W/6qzRByrhKPaqxXXhyVXbRy+TQS+wNEL?=
 =?us-ascii?Q?OIPNVz8O377vMe7z6TvBhdO7hkiXOIssdSFaB52Dltl+lrvZA85DgSQTyvy1?=
 =?us-ascii?Q?oxpBOlcht5uWglj98ZG4RT8+ITRVIwV/DzodEhAXmPWM/4ptt/8M+2uNSALW?=
 =?us-ascii?Q?FZguaf09xegM62J/mTN11myn4oA81MLYAHp39xTcd+y/MrBXNl4/dwRFM3NI?=
 =?us-ascii?Q?0PVwjBtT3nIf8z8ti+J2oKePj8vs1GzqiBlHxaXWEI1BApjLA0UcZrxZRgLr?=
 =?us-ascii?Q?7mn3a8ZrZj3GgxQZlvn1lNb7j9o0QqNvNCdnkqh2nWaBzpRXO+TXAM6NWdy8?=
 =?us-ascii?Q?Llfvp9TOs4nwI0FvRdUpw/M+SCdfJ6/8jqXv9V2mRGsNR3PKM7prZ23Z/o4y?=
 =?us-ascii?Q?sErOzcvr7ib2tohfWPZHdINKPrKn7g992YxaImH6JS1o+EPHXnLI+6RL1x/r?=
 =?us-ascii?Q?jK79eiM2ICYOd3xx6cj7pLg2PKJEb4wzG+L8ZEmFhQWiPZgytKK7hNX3MsO7?=
 =?us-ascii?Q?id5AwaiIcb+pE5TteCLecCFLUUpCrrbCAww5A+3CPmd+axGmXxW9wGdGbRiD?=
 =?us-ascii?Q?MWyuIj+jtQYVITgLT+BdR6eHiZqqN/7MDifo9yYgwtDQ5JModY8hUdSmMH0P?=
 =?us-ascii?Q?LfGhQhAU+xKfrYhgUzHkb9g/B9JYsgKvoyyoRDaDdkzGMXNO4aqSyfj9ecAA?=
 =?us-ascii?Q?5fKKt3fDRs1Ezs1scNNYeG7xuTP672RQxIusi/GTIq2/8nUz5juv0SiQBWpI?=
 =?us-ascii?Q?inGcVh89Lgt8Rb1qv/ryAsGD/SnlBPcEbShGHq85K8D8lTCvoKHgTMZBXUSF?=
 =?us-ascii?Q?qNCc6u5csZoTzIzEcSA6K+qirBh57yT6Dz6XbWbKeROi+z7BDT1bhGzAXNyV?=
 =?us-ascii?Q?sxAZwuA/LsFhTVBgFP3MgSl/+MRXRZFfS3JWKoq3fHy6PS5CamXhT2N0LrPu?=
 =?us-ascii?Q?E6/N+2gAbzURRzO7h7n5lTOpNzPXYFxopyf6WvoaV01pFw43Jz7qJ15el02V?=
 =?us-ascii?Q?pnyzUl+F9mJ2G0iuO+SYQL3EGRMPtnAOmy5MxkrEHwnsqeYRU1m9aOACLkFA?=
 =?us-ascii?Q?Erl4jxxI7Ei1VAF+4oyFeFd7uK3PTAuG15MsOBp2DxudUzjQsWDo5ois7Oeb?=
 =?us-ascii?Q?vpI4x3j8tceBsnj+ykyPgdjImO00mZCG5LuHJ9blVVT1v61izlxq5HxBGTVn?=
 =?us-ascii?Q?Oo86BuHtObERCFDKy6im0IGaNeLGC/xGigyTxz1C0cjSvbmrBEFMS9IqIG7Z?=
 =?us-ascii?Q?ZLZoqE+VHylILrS+rqvwWYzF5qV8KGiQiVQ1iCLItSQFf59+lsBBviaVvRh7?=
 =?us-ascii?Q?8jQoOJtXEjRYe6ZrpdcKdbWMn7ln1xYx8o/wEYBje5GelRae+kGlMYmymkiC?=
 =?us-ascii?Q?8/u7e3DU8Ohr7MRlyJbg+twJgTi1BHsO+jemaATw353HL3KvA4oEhOf5DMxR?=
 =?us-ascii?Q?and8WbXeNLIQjaY9/AAuS0J2FARbS3Sx6rSgwAmt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed832da6-8c07-48a9-4827-08db6e2efbed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 06:00:28.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNwD4KLyowyy2TO+slRteDAEunP63zIjTI8DRVWSyUdJrxEx2BUPZJYMdceAozDQFgKey2jMUOhenTz2tFMiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 at 15:59:10 +0800, Yicong Yang wrote:
> On 2023/6/13 20:44, Chen Yu wrote:
> > On 2023-06-13 at 16:09:17 +0800, Yicong Yang wrote:
> >> On 2023/6/13 15:36, Yicong Yang wrote:
> >>> On 2023/6/9 18:50, Chen Yu wrote:
> >>>> On 2023-06-08 at 14:45:54 +0800, Yicong Yang wrote:
> >>>>> On 2023/6/8 11:26, Chen Yu wrote:
> >>>>>> On 2023-05-31 at 16:21:00 +0800, Yicong Yang wrote:
> >>>>>>> On 2023/5/30 22:39, Yicong Yang wrote:
> >>>>>>>> On 2023/5/30 19:55, Peter Zijlstra wrote:
> >>>>>>>>> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
> >>>>>>>>>
> >>>>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>>>>>>> index 373ff5f55884..b8c129ed8b47 100644
> >>>>>>>>>> --- a/kernel/sched/fair.c
> >>>>>>>>>> +++ b/kernel/sched/fair.c
> >>>>>>>>>> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>>>>>>>>  		}
> >>>>>>>>>>  	}
> >>>>>>>>>>  
> >>>>>>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>>>>>>>>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> >>>>>>>>>> +
> >>>>>>>>>> +		if (sdc) {
> >>>>>>>>>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> >>>>>>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>>>>>>>>> +					continue;
> >>>>>>>>>> +
> >>>>>>>>>> +				if (has_idle_core) {
> >>>>>>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>>>>>>> +					if ((unsigned int)i < nr_cpumask_bits)
> >>>>>>>>>> +						return i;
> >>>>>>>>>> +				} else {
> >>>>>>>>>> +					if (--nr <= 0)
> >>>>>>>>>> +						return -1;
> >>>>>>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>>>>>>>>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >>>>>>>>>> +						return idle_cpu;
> >>>>>>>>>> +				}
> >>>>>>>>>> +			}
> >>>>>>>>>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> >>>>>>>>>> +		}
> >>>>>>>>>> +	}
> >>>>>>>>>
> >>>>>>>>> Would not this:
> >>>>>>>>>
> >>>>>>>>> --- a/kernel/sched/fair.c
> >>>>>>>>> +++ b/kernel/sched/fair.c
> >>>>>>>>> @@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
> >>>>>>>>>  		}
> >>>>>>>>>  	}
> >>>>>>>>>  
> >>>>>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>>>>>>>> +		struct sched_group *sg = sd->groups;
> >>>>>>>>> +		if (sg->flags & SD_CLUSTER) {
> >>>>>>>>> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
> >>>>>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>>>>>>>> +					continue;
> >>>>>>>>> +
> >>>>>>>>> +				if (has_idle_core) {
> >>>>>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>>>>>> +					if ((unsigned)i < nr_cpumask_bits)
> >>>>>>>>> +						return 1;
> >>>>>>>>> +				} else {
> >>>>>>>>> +					if (--nr <= 0)
> >>>>>>>>> +						return -1;
> >>>>>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>>>>>>>> +					if ((unsigned)idle_cpu < nr_cpumask_bits)
> >>>>>>>>> +						return idle_cpu;
> >>>>>>>>> +				}
> >>>>>>>>> +			}
> >>>>>>>>> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> >>>>>>>>> +		}
> >>>>>>>>> +	}
> >>>>>>>>> +
> >>>>>>>>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>>>>>>>>  		if (has_idle_core) {
> >>>>>>>>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>>>>>>
> >>>>>>>>> also work? Then we can avoid the extra sd_cluster per-cpu variable.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I thought it will be fine since sg->flags is derived from the child domain. But practically it doesn't.
> >>>>>>>> Tested on a 2P Skylake server with no clusters, add some debug messages to see how sg->flags appears:
> >>>>>>>>
> >>>>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>>>>>>> index 69968ed9ffb9..5c443b74abf5 100644
> >>>>>>>> --- a/kernel/sched/topology.c
> >>>>>>>> +++ b/kernel/sched/topology.c
> >>>>>>>> @@ -90,8 +90,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
> >>>>>>>>
> >>>>>>>>                 cpumask_or(groupmask, groupmask, sched_group_span(group));
> >>>>>>>>
> >>>>>>>> -               printk(KERN_CONT " %d:{ span=%*pbl",
> >>>>>>>> -                               group->sgc->id,
> >>>>>>>> +               printk(KERN_CONT " %d:{ cluster: %s span=%*pbl",
> >>>>>>>> +                               group->sgc->id, group->flags & SD_CLUSTER ? "true" : "false",
> >>>>>>>>                                 cpumask_pr_args(sched_group_span(group)));
> >>>>>>>>
> >>>>>>>>                 if ((sd->flags & SD_OVERLAP) &&
> >>>>>>>>
> >>>>>>>> Unfortunately the result doesn't match what I expected, the MC domain's sg->flags still marked
> >>>>>>>> as cluster:
> >>>>>>>>
> >>>>>>>> [    8.886099] CPU0 attaching sched-domain(s):
> >>>>>>>> [    8.889539]  domain-0: span=0,40 level=SMT
> >>>>>>>> [    8.893538]   groups: 0:{ cluster: false span=0 }, 40:{ cluster: false span=40 }
> >>>>>>>> [    8.897538]   domain-1: span=0-19,40-59 level=MC
> >>>>>>>> [    8.901538]    groups: 0:{ cluster: true span=0,40 cap=2048 }, 1:{ cluster: true span=1,41 cap=2048 }, 2:{ cluster: true span=2,42 cap=2048 }, 3:{ cluster: true span=3,43 cap=2048 }, 4:{ cluster: true span=4,44 cap=2048 }, 5:{ cluster: true span=5,45 cap=2048 }, 6:{ cluster: true span=6,46 cap=2048 }, 7:{ cluster: true span=7,47 cap=2048 }, 8:{ cluster: true span=8,48 cap=2048 }, 9:{ cluster: true span=9,49 cap=2048 }, 10:{ cluster: true span=10,50 cap=2048 }, 11:{ cluster: true span=11,51 cap=2048 }, 12:{ cluster: true span=12,52 cap=2048 }, 13:{ cluster: true span=13,53 cap=2048 }, 14:{ cluster: true span=14,54 cap=2048 }, 15:{ cluster: true span=15,55 cap=2048 }, 16:{ cluster: true span=16,56 cap=2048 }, 17:{ cluster: true span=17,57 cap=2048 }, 18:{ cluster: true span=18,58 cap=2048 }, 19:{ cluster: true span=19,59 cap=2048 }
> >>>>>>>> [    8.905538]    domain-2: span=0-79 level=NUMA
> >>>>>>>> [    8.909538]     groups: 0:{ cluster: false span=0-19,40-59 cap=40960 }, 20:{ cluster: false span=20-39,60-79 cap=40960 }
> >>>>>>>>
> >>>>>>>> I assume we didn't handle the sg->flags correctly on the domain degeneration. Simply checked the code seems
> >>>>>>>> we've already make sg->flags = 0 on degeneration, maybe I need to check where's wrong.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Currently we only update the groups' flags to 0 for the final lowest domain in [1]. The upper
> >>>>>>> domains' group won't be updated if degeneration happens. So we cannot use the suggested approach
> >>>>>>> for cluster scanning and sd_cluster per-cpu variable is still needed.
> >>>>>>>
> >>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/topology.c?h=v6.4-rc4#n749
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>>
> >>>>>>>
> >>>>>> Is this an issue? Suppose sched domain A's parent domain
> >>>>>> is B, B's parent sched domain is C. When B degenerates, C's child domain
> >>>>>> pointer is adjusted to A. However, currently the code does not adjust C's
> >>>>>> sched groups' flags. Should we adjust C's sched groups flags to be the same
> >>>>>> as A to keep consistency?
> >>>>>
> >>>>> It depends on whether we're going to use it. currently only asym_smt_can_pull_tasks() uses
> >>>>> it within the SMT so I think update the lowest domain's group flag works. For correctness
> >>>>> all the domain group's flag should derives from its real child. I tried to solve this at group
> >>>>> building but seems hard to do, at that time we don't know whether a domain is going to degenerate
> >>>>> or not since the groups it not built.
> >>>>>
> >>>>>>
> >>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>>>>> index 6198fa135176..fe3fd70f2313 100644
> >>>>>> --- a/kernel/sched/topology.c
> >>>>>> +++ b/kernel/sched/topology.c
> >>>>>> @@ -713,14 +713,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >>>>>>  
> >>>>>>  	/* Remove the sched domains which do not contribute to scheduling. */
> >>>>>>  	for (tmp = sd; tmp; ) {
> >>>>>> -		struct sched_domain *parent = tmp->parent;
> >>>>>> +		struct sched_domain *parent = tmp->parent, *pparent;
> >>>>>>  		if (!parent)
> >>>>>>  			break;
> >>>>>>  
> >>>>>>  		if (sd_parent_degenerate(tmp, parent)) {
> >>>>>> -			tmp->parent = parent->parent;
> >>>>>> -			if (parent->parent)
> >>>>>> -				parent->parent->child = tmp;
> >>>>>> +			pparent = parent->parent;
> >>>>>> +			tmp->parent = pparent;
> >>>>>>  			/*
> >>>>>>  			 * Transfer SD_PREFER_SIBLING down in case of a
> >>>>>>  			 * degenerate parent; the spans match for this
> >>>>>> @@ -728,6 +727,18 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >>>>>>  			 */
> >>>>>>  			if (parent->flags & SD_PREFER_SIBLING)
> >>>>>>  				tmp->flags |= SD_PREFER_SIBLING;
> >>>>>> +
> >>>>>> +			if (pparent) {
> >>>>>> +				struct sched_group *sg = pparent->groups;
> >>>>>> +
> >>>>>> +				do {
> >>>>>> +					sg->flags = tmp->flags;
> >>>>>
> >>>>> May need to test on some heterogeous platforms. Does it always stand that child domain of CPU from
> >>>>> remote group have the same flags with @tmp?
> >>>>>
> >>>> Good question, for heterogenous platforms sched groups within the same domain might not always
> >>>> have the same flags, because if group1 and group2 sit in big/small-core child domain, they could
> >>>> have different balance flags in theory. Maybe only update the local group's flag is accurate.
> >>>>
> >>>> I found Tim has proposed a fix for a similar scenario, and it is for SD_SHARE_CPUCAPACITY, and it
> >>>> should be in tip:
> >>>> https://lore.kernel.org/lkml/168372654916.404.6677242284447941021.tip-bot2@tip-bot2/
> >>>> We could adjust it based on his change to remove SD_CLUSTER, or we can
> >>>> replace groups->flag with tmp->flag directly, in case we have other flags to be
> >>>> adjusted in the future.
> >>>>
> >>>
> >>> Thanks for the reference. I think we can handle the SD_CLUSTER in the same way and only update
> >>> local groups flag should satisfy our needs. I tried to use the correct child domains to build the
> >>> sched groups then all the groups will have the correct flags, but it'll be a bit more complex.
> >>>
> >>
> >> something like below, detect the sched domain degeneration first and try to rebuild the groups if
> >> necessary.
> > Not sure if we need to rebuild the groups. With only
> > 
> > if (parent->flags & SD_CLUSTER)
> > 	parent->parent->groups->flags &= ~SD_CLUSTER;
> > 
> > I see the correct flags.
> > 
> > My understanding is that, although remote groups's flag might be incorrect,
> > later when other sched domain degenerates, these remote groups becomes local
> > groups for those sched domains, and the flags will be adjusted accordingly.
> 
> Maybe worth a try to build the groups correctly at very beginning rather
> correct it later when needed. Considering we've used it in several places[1][2]
> and this time we're going to use it for cluster.
> 
> [1] 16d364ba6ef2 ("sched/topology: Introduce sched_group::flags")
> [2] https://lore.kernel.org/lkml/168372654916.404.6677242284447941021.tip-bot2@tip-bot2/
>
Do you mean clearing the SD_CLUSTER during degenerating? Yup, that could
be enough for now. I guess you are going to send a new version with this
SD_CLUSTER flag cleared  + using group->flags to detect SD_CLUSTER rather
than percpu cluster id. I'd be happy to test once you send them out.

thanks,
Chenyu
