Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6F72B742
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjFLFWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFLFWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:22:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285CAB5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686547360; x=1718083360;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bYHAoqytSrENnyOZuFhaE/1Pefmxu8A8RWj1ENfr0WA=;
  b=e8jcWWc+C0OHxG4yRdhQa1DWYXR8dpmkiQvp+3W86T3/japwGL5gN4QT
   +RY+QsUmPTIF1w0J7gCc3ZVDr2CylJc51jF+77TYX8ml+ZABex0L8GZab
   w9BJ3CHevOVT1+ChBOICcbOsdptdNo6A8uJaBvsnM0dpbwokuclpv6EUT
   p1VuMwVXCczzIBwDeoeMi7z+ESlI4mRtKLtbLmYncEh7zbp5va/tLWnQc
   cCWtGVc2S1fp+lqSETq4n0yM46kVFhosM46Lz6MOU5GTmImk/pujiY46R
   x6JMsUJynBoALAK9rWoRataxF+tioh/Tw7SVwdCv74/1eZTPUJZ/RThiA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="421541024"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="421541024"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 22:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835338218"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="835338218"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2023 22:22:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 22:22:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 11 Jun 2023 22:22:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 11 Jun 2023 22:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOI0z5QUSLK7YbC/larrDOfJ2LInZrgJkTFxZHcslHqOGefzne4HqGI5kt/gfFD8691BwS4O6ubeeIGBgKTePpdnFAvKP/Ot/PoTDK5AWtokk7AcmhUZGYwA2BZpZtixf9X17RZbs6J0v0NYRMoLdLHJczeTPhn4xeoiR97Rgilj6t8MFoaQq7TvfOMcXeQnTR00uts6tMhLEMXxLwTkjDqK0PzX0YFfEBXycXb+3Z+34cGVxjIflnwM70HZbSX0NasrzssOFgArm2xsLgtwK9RwfMmhzj2NBkiBJ7gSoA4ViYRrTNtd37sc10rcHp3JAFDvdA0Q5ZZ3z3PmdnWqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiEewr3VffbR/+DWNprTEyhqu5dBpvwUDP4+fgy6V1g=;
 b=VYQ2tZfxMpXgiCfM0jKNRjk/l6bpv0KIfeKkGjNZ4JdcpG/U7AVbSw8PnKtE34FlkdDYlCQ72nExgzPRnKZbUlBYMAqczm5qw+TJClPdHTm3A35/H0o4Uv5V5DIDnrlfEdzPYRH9CpYcuIavsmGg9cyKM/9Hc2MI50rM6Bi3ZGwFohTbwp8/Inr33/Q167ZG8nUSYxMoEcTnBeWrig/1stSRLre6pUOsAluG9nwTNu5PQyZA0uo1/QB1+SLJr5U6VY4AL/acWowybavJ6WNxBOCpSKmhKr8GAJspx/oLruPzbz4o2t1DAj4tAAtydNUrGyc+cgLcdixtAfZQGVJ8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 05:22:36 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 05:22:36 +0000
Date:   Mon, 12 Jun 2023 13:22:16 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC:     Yicong Yang <yangyicong@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZIariDV8sztoPbv0@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
 <ZIams6s+qShFWhfQ@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIams6s+qShFWhfQ@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL3PR11MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2e088b-5e37-4a84-5acf-08db6b05081a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAWLAZfau+sZg1rmmmdVqtxAlLA8py80V/J5/HKbQYnW8QusMTPHlD6zstQaIuS7lB0/F44h1quH8XSsCSoR2AASw4Yc8dOgAt12vo9g4u13iOgFFRFPx8sizgDfMTW0WdUuIrncS9Cm8A9CTbpca6xdycJdgAA4li3lhK5lb0EJRLgSxjhcpj5onwmAfw6uSeR1KRMtA668yNTeCVBTb1IjEO64M9zmVmcn+qAndIgv1N7LOFTeika6gD4XiVihfoFEQGMZs0xBOiN2GwmeFzCGLCmUYE9AVi4Qgh/2mEl1fiByZ0yoRUlCgJtgLyDGvFkG1Moas/eXYibWXkxa2J4LpDssqaca8G8XdzSlFjooSRTKvA6BEdqsFUZ6LBWoSOxhqB2WUt+7d4GnHlHmkMaiY3ByCaA83zzW18E4ic/51I3eFN5wfiiEFqqJzAFSkTmAjOtuvh+2/3DuaXiYHNJ3n1JEZxkoqnvP8fKLGdLJLHn7amF3DMZ7blEntjVba6U5IYug8AK0JDfW5yT/KzgUAbd5Q7BCKBAgNZi7fMoS3amQ9j7LNSq+S92Y08kk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(5660300002)(7416002)(8936002)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(6666004)(6486002)(4326008)(26005)(6506007)(6512007)(53546011)(316002)(6916009)(41300700001)(186003)(82960400001)(83380400001)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H0id/RSeeb78ys5MhGU2CyzCrjMYhpgtZnLRwFXEVZXs0Xb6XYy2/RCTDkwU?=
 =?us-ascii?Q?ZpG2JtFG9aT+SJvrUu/va66d1DcbyzUUsy/RcvvWvmA/csvZl1QC6ykjmBEd?=
 =?us-ascii?Q?TSnd0Xetmku1FgfAxcLu8UBJIm78FdX2qG2xbDvrHee55BEHYprHabq5PrcU?=
 =?us-ascii?Q?2dryZH6X1sp6pIVCihrXyQJgybPLjIQd6z/O1jjYxzHVSccJYFE4VJJgLnfF?=
 =?us-ascii?Q?mkpeHPpHbp00YGS3YEidlTP1cPnIpJK0DOR4ZQkgxYxbEs/ORVZ9C06rDcU8?=
 =?us-ascii?Q?9HAkcSntVbCnCiq/3mr2cvWhkfBU4WYn5XKCxheFkIHmncSRInEfTKpzz4lU?=
 =?us-ascii?Q?VFlygSm/GIFToDaXIFn80rtXesnije5hcKWqMoN8BMk61XBjRjeuSv9o+98n?=
 =?us-ascii?Q?w80BgODCspolZdYCbl3+Et4tfVpVLoAzVHpxAh/oDMIHVU1wu1O5Y8EYgLJo?=
 =?us-ascii?Q?otpRpQ4EZVv/n9+tZLygPqT8guvFAyvrzJXQZyqLz0K7nbrkL/pJOHH4QxDQ?=
 =?us-ascii?Q?Qek2aq0vyTCySW9zKOVey1hDtTfCRE55fu16RIK8ZLTawdXMkazjxeVJVKOj?=
 =?us-ascii?Q?NVETdF0fChcWqMqgM1M7kcfosjoMKMamnR4MRDPh7GBlCQq8rJ+lK1hBDUPp?=
 =?us-ascii?Q?D5etGpCCcFS6l3x63FIfATQ74wG4+5rAqHwbGl3S9g8tc5mGMBX39HJyCKNC?=
 =?us-ascii?Q?AgI1OwQJn+tejnhJtqIpZGjR45xIwAzsSVYwo6ytBNs4vEFsLRlxLdM3Y6Kx?=
 =?us-ascii?Q?kcfkoMgKD1m/3wC5C5Fxl0/0P/H+/XtVlotsLCjMNuWNpdz3cVjf6DzSGLoa?=
 =?us-ascii?Q?YzLPFr+qm1soTYWEUeh5qM8MiDGYB34a2ogJ47c9uAqSAL552deVF4q3KRI7?=
 =?us-ascii?Q?Sq67fxAUxym3JWhZ4hUkMoX5+PauOEcru67ygDuU9ZssCj8qOPj5Jo2/CBmf?=
 =?us-ascii?Q?ZIZdZMygI94GcY6+yb2fAFYeZj4AldfpRMUyvJ7IDkzQJr2pERia6o7tcRXg?=
 =?us-ascii?Q?H9c4bKnQnDJnLtax2QWyTerIWZVW0qRUuau6XL6Df60oIkZlcTBhBFCj7x4t?=
 =?us-ascii?Q?DylMdKkiLxCmcu6L/v5NiHhu4Z9zGTX0fizicvyrCYheuh7ooCxHtBvB3W5G?=
 =?us-ascii?Q?2BP3zGviUeyOvfAr+Yl/ITCN4T7jt3Rpo80BmXz+izHYm3gDqGkxx7ZWpwVH?=
 =?us-ascii?Q?BXKlZ1ZrMSQ2pgT+yu8ORgZjRfEr1OSIjIwm05a+s/YuWnbw6Da/ScQ9TchA?=
 =?us-ascii?Q?n34Xw2ie7AJKcDBzwRRI94W1D0xrwI6VmItUqZvIcTY2KPxXIYPasuheIusu?=
 =?us-ascii?Q?MoX7zfV4tlnAB8jhYl8aBF0zz2+OQxBP8ENparGVIhJ1DJGpafrzHNgXgLhn?=
 =?us-ascii?Q?ZlmoxwczcGml3HGKEAgs0DoferOrmtco0+6xt8gzVhIsl7OYg7reRBoAaDl/?=
 =?us-ascii?Q?VZvti7MI2OAHPnRhsGmRC9P2fv8QkP0TBURdxWdhKH9C8KJRHGYt0BNLdDxB?=
 =?us-ascii?Q?z1OzLMK8wdZWb27WbE95Mob8tBbxYbBeAvIwMZdDnjQSO5IxlZ36AKzQe/1B?=
 =?us-ascii?Q?CVj4Qf9mR6GLAHU2sbdEnUPy4YX+BP73DRVkvFkz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2e088b-5e37-4a84-5acf-08db6b05081a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 05:22:35.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCuGW1f/ooUoc8HKMiHrwYnLg6ePIOjszdJSTCcbDM0u8/mmoDrTzfdZwjob7kRF3cUo0ZP0bl7+mArwB1yOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
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

On 2023-06-12 at 10:31:39 +0530, Gautham R. Shenoy wrote:
> Hello Yicong,
> 
> 
> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> [..snip..]
> 
> > @@ -7103,7 +7127,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	bool has_idle_core = false;
> >  	struct sched_domain *sd;
> >  	unsigned long task_util, util_min, util_max;
> > -	int i, recent_used_cpu;
> > +	int i, recent_used_cpu, prev_aff = -1;
> >  
> >  	/*
> >  	 * On asymmetric system, update task utilization because we will check
> > @@ -7130,8 +7154,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	 */
> >  	if (prev != target && cpus_share_cache(prev, target) &&
> >  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> > -		return prev;
> > +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> > +		if (cpus_share_lowest_cache(prev, target))
> 
> For platforms without the cluster domain, the cpus_share_lowest_cache
> check is a repetition of the cpus_share_cache(prev, target) check. Can
> we avoid this using a static branch check for cluster ?
> 
>
Sounds good. 
> > +			return prev;
> > +		prev_aff = prev;
> > +	}
> >  
> >  	/*
> >  	 * Allow a per-cpu kthread to stack with the wakee if the
> > @@ -7158,7 +7185,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> >  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
> > -		return recent_used_cpu;
> > +		if (cpus_share_lowest_cache(recent_used_cpu, target))
> 
> Same here.
> 
> > +			return recent_used_cpu;
> > +	} else {
> > +		recent_used_cpu = -1;
> >  	}
> >  
> >  	/*
> > @@ -7199,6 +7229,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	if ((unsigned)i < nr_cpumask_bits)
> >  		return i;
> >  
> > +	/*
> > +	 * For cluster machines which have lower sharing cache like L2 or
> > +	 * LLC Tag, we tend to find an idle CPU in the target's cluster
> > +	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
> > +	 * use them if possible when no idle CPU found in select_idle_cpu().
> > +	 */
> > +	if ((unsigned int)prev_aff < nr_cpumask_bits)
> > +		return prev_aff;
> 
> Shouldn't we check if prev_aff (and the recent_used_cpu below) is
> still idle ?
> 
>
When we reach here, the target is non-idle, and the prev_aff is idle.
Although there is a race condition that prev_aff becomes non-idle
and target becomes idle after select_idle_cpu(), this window might be
small IMO.

thanks,
Chenyu 
> > +	if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
> > +		return recent_used_cpu;
> > +
> >  	return target;
> >  }
> >  
> 
> --
> Thanks and Regards
> gautham.
