Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB1374BD99
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGHNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:17:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77043E55;
        Sat,  8 Jul 2023 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688822254; x=1720358254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vpki3XqpBjiKk+kBj9ICDUP7HzO0VP6vcEPKD+imkWE=;
  b=j4pi8eBb+JoYY4q8U3xtHCAb3yz/xpahirPtCIiWoYneIYOoLRLRWzuh
   64G2I+8gmTK3/Y8KlgrwkmOLJIm6zjpNeMC9IAHbpi6b6O53sP7pINhD5
   7wplgDT+b7ezOCCCsNQtai4+gtBlkIydou0jCUMn5VmaLYaWKx9RIkTl+
   uGsUbsuFa8Q3ziasEq5ZZHYmkjHAd0d1PHRueGG7oCrfzGNB83eKMKRWw
   NWdaqe6fPjUO4D/AnDlesfXqeUIeybLJP+yQdiA/1kSTWn/ldOP7QNHCa
   epk+fQYejlAxaw9IWajOgdGV/DQffaaPWuFaUem0s70jxe/SgQhQAoXDy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="364101555"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="364101555"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 06:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="1050847594"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="1050847594"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2023 06:17:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 06:17:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 8 Jul 2023 06:17:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 8 Jul 2023 06:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkq1hFR4G5ki/kRFqCtHEYK2B6fnP/A0qElu5aoM8juOxjIdczX1h3gwn9DPGqCB+CsvCxoYAaxqs47Sb0CmAAeAnJcsGgh7DgX0hY63ccteIf7jKVbrBttqTl28ytBMTcZt72lYmzuh5sQUtw3V8aSB6JNSpIYDVbv9kM/5+AzYj9IdDd4aqxri3AXynGOSkcTZtb6Wkr5tG18bEzcyMp48xeTK/7agxvOUmK8yzU5pn6TeQok97jJQEtLtqNGS7q22t6z5/ktkkyO6ElFghuJukQfasHAzjzTIO+uLumEiniwQKe4O3sJpdNtnHPt1jZ9ggq7jxUa+3w0gBirG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dviq/BSyKcGMw9kEY+sHnZmm5/VyF3vWPMOqNXiYCE0=;
 b=iKLgfXNmHoxgjEB4nONgz7resDt+TVdBv1eSZWZJmKpj2OKFRcY0126WdtTmypz02xLQVNA6B+noRmoBfTJ4W9vr0C0qFmyJ0UFRP21TT4d3vj0Ax8l1IqtU+hReWAWWyHM5wgvnzrY+dje8uF9iSyDDuCsy7JF8+PJXYWxb9rxUkPRKQkytrpGAjGmD9EZ9nZ4BW4fwchJ5mHj4DP2u0nt/F1AlaVoEf9SIbse+gorsp8uW7lXblItL/17W2RWVIAhI26/if6FGGumaHEVewbEcwANTkNRhvsm7mNwGn/gaYAYZptx3kDboNWBMHxvI+NP6761HzhUhIvffbiD2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4814.namprd11.prod.outlook.com (2603:10b6:a03:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 13:17:26 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6544.024; Sat, 8 Jul 2023
 13:17:25 +0000
Date:   Sat, 8 Jul 2023 21:17:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        <x86@kernel.org>, Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZKlh1u2kkHzHY/nB@chenyu5-mobl2>
References: <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
 <20230705115702.GY4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705115702.GY4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4814:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c6d526-485a-430e-1701-08db7fb5abad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8GIOfPIrN4pDxrVbyabBPrlz3ETIdG/v54WCvr+aT+fNyHwaFJsAxowB2LDxPNFjzF0VEOipy2aZAw5u89idwbmTC/LAwIWFvH8UqaCHpDZHsokATcXCy08XGtyWXHymP4WD2B3P7BL5yCoNTS86dOOXDaQ7KixcmQVLP//7gfAj41yu1zkYhCieDXHACMLqztoNcHozlRo57Ym+ujeFQyUD+W3ZChVOIR0bGowvR0P3DiJTSrYAVbH79tcOyMFhOA79+SRwmpQ9zejIkdOZugRLLF679sYsGDjLsByIeWTysVM2EPIXm7OcBYbhuS6/npw+UNmHS9KHDFhx36gG1wdCwLZEW+Xm5HmDJwwV1N0xCrE3MMudoq49qMORyZ2ggRFasP7UmAFDrXfMMyetcz2d+LP5pM900NdcIZ2Z73dmvm5IdlRZKmMZgNmH7ev/cb+7lwKOFgzWk94NGMglFrjRb2na7pPhSCd9u1TeTrh1TDxxqL51uIEpEf+ctUcAnUTGFrBUhrWvwf/kFaHamEgXrzD1MEfVtgw3oBC/C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(478600001)(6666004)(6486002)(54906003)(53546011)(9686003)(186003)(6506007)(26005)(6512007)(966005)(2906002)(33716001)(66556008)(6916009)(41300700001)(316002)(5660300002)(4326008)(66946007)(38100700002)(8936002)(8676002)(66476007)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dGRerr3griMhIjx0Anhn0Q7ehUvKACZpYUTx7PJ/OjXH9w2RMVwT20lOgSvR?=
 =?us-ascii?Q?d3R7NevEjDDtaEPJWwZ3KWqJjrMdsp457AqUPnaPFTEM7PqnSitcgfkgTXMV?=
 =?us-ascii?Q?wo/GRF816CGjiuqmuzpMTcVkOTYbykMUBHstbXFLN3DiLxKs2FJ7OfGOi7GB?=
 =?us-ascii?Q?fObpo2vjvxTagxOcRP1B8OF6tWSRJKnpUQA2WtV70Op5NQyZAf/jWkKD7boP?=
 =?us-ascii?Q?pWLF2zTNYbL7LC0bzx+1IP+YP+h+iZsTUWVe9jwXbkbA7o3O2VMG6J7LoaEd?=
 =?us-ascii?Q?Ch4jgPZ1DbnU/DpINXOxwkQpgzt+lOtXT0I3nGvksqVWUKwrN6g0JBwiZyvj?=
 =?us-ascii?Q?N3El6VqJMUX0JbVfC90uEPQRVmtd3j78XzJuhZvwbGWTCVYC9X5v7jAqnt8g?=
 =?us-ascii?Q?y/3Z6FnXuw7Jh8SRNizeIKOBNtUkYm1mV8Zz5L/NeJGpOiF9Yd/8THHjbcKw?=
 =?us-ascii?Q?QIs9KUkvRt0WNHZuYnH3aFHjL9vTpvODW1DZNFphLds0U/5fkTteemqOApid?=
 =?us-ascii?Q?jk0bvMheN0Xf+955+0rOxm6D+UXmaQqMFDhISmIgBCnC2Rhw4pQImlxEQmTJ?=
 =?us-ascii?Q?4rY0MvJGsUetGwx1w+7KxvluqgDSaB6NwQqvbARhpqS53NgBv1kIVMYNORdA?=
 =?us-ascii?Q?DTLWiK8vYjorhtLZvx/ri5EWEX+m0XGkQ2Fo+epv6U9z633ztmky0ZZasAzy?=
 =?us-ascii?Q?KCrLAGmfC7wxewzXBH/5zVZePlHd14z533fsrNhBzCVJ/N5oAzWbhdNf2Svs?=
 =?us-ascii?Q?OQghtY/iEjNSVaMFRrImPpuwRWko24TFPWgFIuEgDRAMe4QwTkTZrsvh5PyP?=
 =?us-ascii?Q?1M3XsDE9SF+0FgB7eoybEPN09fCU023MxF4l49baD8xKcYyXxGsvhUdMJ92n?=
 =?us-ascii?Q?Oq8zfGwP0SnU/Mp9xLJXC2wxINE98Jsnlk2jvt3e/smD+crIbF6hIG1lsy11?=
 =?us-ascii?Q?nsiNtN4hB5CEJgFXVPBAYeonv1PtGvFJC126O5PPB+D+klzuikuF2e0/S6D4?=
 =?us-ascii?Q?8pEswR/IoB76WckjNfL9c5ua8nQCZSnl8wPfwB89GHI9iCXh2brZCMP8YhrA?=
 =?us-ascii?Q?LiKJDYyiFUH2BdVMIdH5abCF+6XzsycyWnJnFMnuJwnw10YwHdT5m/PAbz4Y?=
 =?us-ascii?Q?9CVJaz5undCfLiJcqGg/Bba6prLRvR5sQdPcXxQVz1ab4Ub+QslzFE8gfoYU?=
 =?us-ascii?Q?jRj5x5Pq13NbUTdoRu58Rpg00b255Zl6Uh2/uhjK46UMg3+9df2gplZglnP/?=
 =?us-ascii?Q?CogVv6HE5Qhi5tlyFY59tLO2PNr8EfUtw0jGYu7gLmPqXmelOZjOZFUaTO5C?=
 =?us-ascii?Q?b7QKp0EIvkT1gFzwy+S6lSl30lexH0jqyLAGSVOzf5dwACJFvUTW825dwdb3?=
 =?us-ascii?Q?36qOg9kuy3cFQS77Gr+8s9Y6y4QymdqsajJZkhKRgP7HNBQ0xS2Ioc7/5H65?=
 =?us-ascii?Q?D3Ujra+nPZf7V7sW3ea8g/oku7tR8rrXCo3K6YjAfKA8/eXnnzZWs+9s7pGn?=
 =?us-ascii?Q?GpGoSOXLIkZ9Mk/G3OFcAu1Rf4cwnwaoofIEsSCeZ+TPg5a0/PN51FLN4bj5?=
 =?us-ascii?Q?8wCwYvjVKqVIhAEzKtO9zUKLuli7b3Invs2+38pv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c6d526-485a-430e-1701-08db7fb5abad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 13:17:25.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vqfQgHx1xcTykGexYISUgNUEb8x12F0x6mTSJ7dhijE6u/pzqx0ANNINttLSRSLqmkxIYK89MVxiMXuGaEhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4814
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

On 2023-07-05 at 13:57:02 +0200, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 12:04:48PM +0530, K Prateek Nayak wrote:
> 
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -596,7 +596,7 @@ static inline int x86_sched_itmt_flags(v
>  #ifdef CONFIG_SCHED_MC
>  static int x86_core_flags(void)
>  {
> -	return cpu_core_flags() | x86_sched_itmt_flags();
> +	return cpu_core_flags() | x86_sched_itmt_flags() | SD_IDLE_SIBLING;
>  }
I guess this flag might need to be added into the valid mask:

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..4a563e9f7b10 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1540,6 +1540,7 @@ static struct cpumask		***sched_domains_numa_masks;
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
+	 SD_IDLE_SIBLING	|	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
>  #endif
>  #ifdef CONFIG_SCHED_SMT
> --- a/include/linux/sched/sd_flags.h
> +++ b/include/linux/sched/sd_flags.h
> @@ -161,3 +161,10 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT |
>   * NEEDS_GROUPS: No point in preserving domain if it has a single group.
>   */
>  SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> +
> +/*
> + * Search for idle CPUs in sibling groups
> + *
> + * NEEDS_GROUPS: Load balancing flag.
> + */
> +SD_FLAG(SD_IDLE_SIBLING, SDF_NEEDS_GROUPS)
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7046,6 +7046,38 @@ static int select_idle_cpu(struct task_s
>  }
>  
>  /*
> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> + * local LLC comes up empty.
> + */
> +static int
> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	struct sched_domain *parent = sd->parent;
> +	struct sched_group *sg;
> +
> +	/* Make sure to not cross nodes. */
> +	if (!parent || parent->flags & SD_NUMA)
> +		return -1;
> +
> +	sg = parent->groups;
> +	do {
> +		int cpu = cpumask_first(sched_group_span(sg));
> +		struct sched_domain *sd_child = per_cpu(sd_llc, cpu);
>
I wonder if we can use rcu_dereference() in case the cpu hotplug
changes the content sd_llc points to. (I'm still thinking of the
symptom you described here:)
https://lore.kernel.org/lkml/20230605190746.GX83892@hirez.programming.kicks-ass.net/

I'll launch some tests with this version on Sapphire Rapids(and with/without LLC-split hack patch).

thanks,
Chenyu
