Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870786DB892
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDHDVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDHDU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:20:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C5D31D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680924050; x=1712460050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=esBJznkMMjJQ0/C5VWPG3ajKzhfA6r5w7JgdvFbnU4I=;
  b=nl89bCkdJ69hBbY0Qy9GIwulC8VN2k90Co7g2KLHy509K7SM42P9ZhPt
   HO2ZpTGYQJa7R/hKCyWsGG68+pBNtQnLBZeW1FMm6gmLURUeDzZ7UYbMN
   tXZHWU2yRaVpncnq4N3ecwK+zM8lKCgmymu0wrOM9iEMXLob3RCgYOnub
   4lOP00k5wMILJwmjGCxS1No5PWvUyurWYs+qJMpDY6S7GWK0Sj8rs0xZ9
   F8F9W4tLLaZ3kJT46P9/FCLJ3zfpKttIhU3+O9gG1uXO8x18eIRi4yKgZ
   5VqmE7NlatMl26ms3Z9eInr5TYRfMcf+3rqmXBt2GP9PI1iHrUU0/Cxv1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408243890"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="408243890"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 20:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="637888820"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="637888820"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2023 20:20:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 7 Apr 2023 20:20:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 7 Apr 2023 20:20:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 7 Apr 2023 20:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USlyLnaJ7rdvak9dxsPSpJUge2MwcLqJn/S/fcO3wKl/b6m2w3rM0D7IWc4gTE6YqIduZs1z0oRMDJJG1mmdtquALXtxtCksgV9c7oOK2RpZAZUraa2E4eaapeARlCebi05df2zgbUr+GYHS+CUutNQ4RCsiplv3Mg3sVH+mfywH0XLx4M6efj6jpepETfx+1EBprmk2Zo7ZTc8Ue03XMVoy3AwFYH7DJcrBz7iRwtTuVPHo6NNotVBYmN1ieSFU3V7mg6NBblCps7RTpEVQ4+0iTZuMB+ipejYVKcnY07uZyRw3nozzmYPh5XbREgocO6ZrUt49ki2iMfX4NHcdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7jQpVczg1GGM/N2V7mPhmZbKcQYQGMbUc/rJPmGopk=;
 b=VelL8sIvrC4ilm1ugwTeuMSen9ThWUsIqeFHBRFm9jJk7vS/N2mI/7G54udOLmoiaMvmN9+gO1blPXMzuGo7XC/67FNbtfcMu2HksyD9ldkniz4vmKbpO0/Y7jaUyHzLhbUf6/N9xrCPBF9LAh0XBMg8UAjHoErvkYS4/jRhMwxXM6Lvs0U6xwVwDj3jAaZCv2p/4u3RJrW6Z38LNVkginrTbfCjBLBCEqNYeEai/PDkgzanYH0H+Sh+jvHlecNkuPBkpQpSIUivpE7vn5bneObCvU8ksu5WR4Snz1O0/GODZv9U58edm/Ir9BydRJdmwRaS53dLbEhjvU0QhqHYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Sat, 8 Apr
 2023 03:20:41 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Sat, 8 Apr 2023
 03:20:41 +0000
Date:   Sat, 8 Apr 2023 11:20:22 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andrei Vagin <avagin@google.com>
CC:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>, <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
Message-ID: <ZDDddj50KZInqa84@chenyu5-mobl1>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230308073201.3102738-3-avagin@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230308073201.3102738-3-avagin@google.com>
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: ed51d2f7-e149-48b8-1a39-08db37e03b5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8uteIchTtp08QV5lsPqpHmXopcSXxw5CSjLGe9pBklpzB/p/LZaXmNEEh7rfpyGmHH7VkcSd+Q0MdrAdlQUfrNl+uayAhLW03sit/j56d+XmzHo5u22TzwhBYM0v8kGK/o5wZfgRPjMqPhYrR0fZtCMiuoeU8Uml+/TypvlizyIdVc21I5Zr3IEQTeg4a6Y9IrMaO46XW/ORvJwqoE/u9sX+/xYSlm4tb6y2eVEiDCFV/6Hym35+c04qIkz45nR2z0EpcHyb7tX+wFcz7g9FKXZKA48H8McNXF1HlDl8fJ3m7pXpD3hc0HZE1EM1cweEQV//+sE1f22X7DdA2kVxCVxyMg8IBiq1ast/y4pdLyK09nzjqk06Y+WWv+kKNnauz1spfc/eTXyGa1q1bACLtsiGx5EMwz4otbIqPa8g1Ovb/8tQjUhuTIvRQoEndCPsUv1p1G9k7Hj5Z2KH/zI+z0gZbcb422tBQYFTN9lmFQVgMahQ0fbppEF9hAKYG1nqn2zHFfBURbUeXGPj8ulIixpK2xLPFwFOvfBvOJOZqeS8DVBJMWYZuBtivibmI/0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(6666004)(6486002)(478600001)(6512007)(54906003)(26005)(186003)(9686003)(8936002)(316002)(6506007)(86362001)(53546011)(2906002)(7416002)(6916009)(41300700001)(66476007)(33716001)(5660300002)(66556008)(66946007)(8676002)(4326008)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahLH0Qs32aSQUnQXdspABRK8X1WGrbEI2fE2a59FuAlX8IjKv5Jz0AjIzNTf?=
 =?us-ascii?Q?aWq2lVPnK9YGR6ki2vlppRndeNKQExJXuOGuRVe8tEOEBsKmDnp6v9OL/aFv?=
 =?us-ascii?Q?341FZl/2ZH+gWQWchdptODF0Oefku6d0jdgeT+pn/7f3kUt7tocHwDdFf70N?=
 =?us-ascii?Q?+Nn00MUBF/xq6nM7rFPloNHd319oO3wHUcWRn8xeIyK5ZVJHh6r1aJ24DuDq?=
 =?us-ascii?Q?0vkhQv/lhECP2340yEZn8XG8H1LCdQeno1om95f8h5de5beySy7GhPz6zxUd?=
 =?us-ascii?Q?Ep3J6NXdJ1VYsGo1aFWvidcBZn4YbdBpqTctq7Ncn++ZYrjFKQojs3wj+y/C?=
 =?us-ascii?Q?BmZTrZUpq/9URLitbh/tw7cPCx3wZJT7Nd4q64shfrDITSU5v4i0sMzKHJby?=
 =?us-ascii?Q?BoKmksTZhp01v22eYWvJBWbo/QhHBvCiTLxUrRBiEydyrd+2A2TelRh2LB+E?=
 =?us-ascii?Q?oyb/03dy9OI8gI1cgQ6wNGTYydZ6OF2JGchwresDzNVtuyy2UoxcUT6NIDuD?=
 =?us-ascii?Q?7godlF0DtgPVAEk/Bmvtg0wLGxZX8Zj74RcoO9FVujzul/UiCCTG1S/CeyC+?=
 =?us-ascii?Q?FvoTBphAYzm6xvOy0mW7H4I008kyIS4fna/u7DeLlMedDNb9wC0YS+brvfWu?=
 =?us-ascii?Q?FN0VGyiV0d5+ADisFj/Oi0rxmdDyLxr5pDzXnLUsSehmYK9lonTFP2WwJb5F?=
 =?us-ascii?Q?+i4W6t9wk4RbeJw/Gf3t1MBtqQEhLmrigOuwB5sPbjna5yEW2fTBsnHwqrcF?=
 =?us-ascii?Q?ZK0hysBGAn9ZDgMvqX9e8BaCbRxz3/6efqIe2IgbzgJIyWxch205DYK46H8K?=
 =?us-ascii?Q?igH590QKq0kTujq+52cTLCnnGxEbPqO75Vx5gZHbMLtIUPDIzz8s98u9IBvN?=
 =?us-ascii?Q?jZi4o3i0/2zB+Jl7+G0LMrR+m34yBP4DShXGcxerRIZHSwGjokqnwIAA6FCP?=
 =?us-ascii?Q?v+anGsvJBFdFR0N1GOHMtxnGLsP7UM9ffcGka/ARZDIMW+3399XMLm+7hAmT?=
 =?us-ascii?Q?uTjZZmXCbgx6kLVCKYqGycAA3jJ8OS2TvPnMVDa6DQne03YVRo75yDHogOLY?=
 =?us-ascii?Q?6KNVRFBfLtz7yFjl9JZuemu9K7vIZDAXKHdwOtPbyrYMfPYRbaWxFPdGNk0e?=
 =?us-ascii?Q?7+ttGDO/xzz9MnAxtZ6+8Fq4HAlTGNEwQcpsXYfVU2PuhNRf1viWVQ9bUZHH?=
 =?us-ascii?Q?pklhszlSIVYNNts+gnLok8DrBKAfnE17cSDOP3m+fC5glSfVnubstH552Pc0?=
 =?us-ascii?Q?tRVZzalCr0IzujRE1w3A6dSZixwh0q/HLp8v/bpUUtT+bmaMwiDDUJdR9NtX?=
 =?us-ascii?Q?iNIuc2GQF8SAVnnw82ZX0dPKopzqbMqsolEdoLdTMFgW2Bm+D7AI0dDwnDN2?=
 =?us-ascii?Q?AFOKSGP+xdUvVZHpwt2z6PZKncyPP2eYNppY73vV6nIL+YJu/DqddSK/AiYO?=
 =?us-ascii?Q?DIwSsniMS+tD/19YfVdpwpV+m4aD/GhpxMJgb8LHIfmIVzyOZG2b+7jyH9Jh?=
 =?us-ascii?Q?vs0yR5hOwXVf6GvHegwSKrG/hn8PC6siXpwJLJNaPELnk9WSc6Q+MVukVyIe?=
 =?us-ascii?Q?+k4QsEHT7yX+bCVameCgqmHOZSsayVM2WzoVK7UA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed51d2f7-e149-48b8-1a39-08db37e03b5c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 03:20:41.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJtNy0XE5Q475ASNSL577iAs1Auzu5w6jEpdmvv+xqR+wlBPzluMoBUS9ncioT2A3Q2Gqs/qYm9zzMQWaPWSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-07 at 23:31:57 -0800, Andrei Vagin wrote:
> From: Peter Oskolkov <posk@google.com>
> 
> Add WF_CURRENT_CPU wake flag that advices the scheduler to
> move the wakee to the current CPU. This is useful for fast on-CPU
> context switching use cases.
> 
> In addition, make ttwu external rather than static so that
> the flag could be passed to it from outside of sched/core.c.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	if (wake_flags & WF_TTWU) {
>  		record_wakee(p);
>  
> +		if ((wake_flags & WF_CURRENT_CPU) &&
> +		    cpumask_test_cpu(cpu, p->cpus_ptr))
> +			return cpu;
> +
I tried to reuse WF_CURRENT_CPU to mitigate the cross-cpu wakeup, however there
are regressions when running some workloads, and these workloads want to be
spreaded on idle CPUs whenever possible.
The reason for the regression is that, above change chooses current CPU no matter
what the load/utilization of this CPU is. So task are stacked on 1 CPU and hurts
throughput/latency. And I believe this issue would be more severe on system with
smaller number of CPU within 1 LLC(when compared to Intel platforms), such as AMD,
Arm64.

I know WF_CURRENT_CPU benefits seccomp, and can we make this change more genefic
to benefit other workloads, by making the condition to trigger WF_CURRENT_CPU stricter?
Say, only current CPU has 1 runnable task, and treat current CPU as the last resort by
checking if the wakee's previous CPU is not idle. In this way, we can enable WF_CURRENT_CPU flag
dynamically when some condition is met(a short task for example).

Thanks,
Chenyu
