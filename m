Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4896075E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJULQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJULPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:15:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE3148F42
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666350916; x=1697886916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ca2jiNXGzu35IK0OUu0vTa0Og0IilXzoKf7lskIkbLU=;
  b=iB8UZllwGwbGsflL1KL9ThT5T9Vrv1fXSZGkOyB+qvXCcGitu6nIjqvW
   OXQLqeJUFxrW5sxclBKJDE9nCNh73oQYGSuw5EplZYpau5tAz6jGsvVC6
   /ZKnJweZ6fp/24j7EKc4nb0Tl/RQZxW8DSIIbd4yrZYlzq/8WKcUqswQn
   jJYoRE4H7qb/J+RhWCNxmxWhbIzLY5RZV5oKk9sTBgoZVyirNtAAWDUpS
   ZF8Alw37Jix19HnUBWVpz6INUOhfCKCu0gqjD3CwX4Pj3lPB3M4vlKg4e
   kOeDhGvOgU6bsMf02Dj0U0Fw0fTegM18NwSLU3wEGiroB/FMZN8Jyq1a9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286695441"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="286695441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 04:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="699295191"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="699295191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 04:15:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 04:15:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 04:15:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 04:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jI1ZHIokazRYH0Lh4JqQK7cG7yZTH196Q7d2NVyG5BmnLw1XlJw4gmGroUfDLDKUsMJd0D73lGVZQ98vAmYadyrvRmbtJrYjSjw8bw3mWJzazXAZKXP/c8ToQsCY+F+i4A0vKyDiMoRwGBUcjb+44f1Xhsym4UN8lrpOQaUMsHiVI6SP1qk73SMogquHlyDd05mQcyp/Aw3KfReZ7WNxxjVyEnRRTFRXyVg64ASlbQxCAsK2Lasx7VrwZgWUXNs0Dvy605UDeRp/cWOxc+yTCdRpb8uWq1QaKra30XeewN2Px1wz7Crrx74hgxcverGO793ooo6XgK9cJgQ7WSXJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2ws9BvsWH+PWCBYuQ+2JQHsoulX5As9xHFu0m8MaCY=;
 b=RiFafrYUaRGMp9y2fV2J5udqWhpRTnOjphqcG6FZDIdAb/qw/OYh4DcBUQEvsS+dkWwyqJdERNWm4UYP7/dZ/n7bGuyN6BViqnjYFPMpBGX8Yjx4LgAaIfN9ddDki4HlGA0nbbZo9QIG8tKyCllw4WtfgBoeeppEAAskeW1UnAb+FNBBwVgmB6OWyPM9GkP8WpqijWMTyljNw5uMJmd22K9L4zn2TPw70gh43zOW0hL3jJIUjSh8jzf9wS/RPO7ovNYMWjR7lxJ9+cyggaiR/85DoaxYgaS8tVkOlyZ7B4QQrFBiYg4+eZT6qH+7dn4Ym5rAxYtC2uQaTETTR5BATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:15:06 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 11:15:06 +0000
Date:   Fri, 21 Oct 2022 19:14:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, "Mel Gorman" <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] sched/fair: Introduce SIS_CORE
Message-ID: <Y1J/JzKNOx4lQfG9@chenyu5-mobl1>
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <20221019122859.18399-4-wuyun.abel@bytedance.com>
 <Y1IZ/DZ1SWMn0QDs@chenyu5-mobl1>
 <9ec8a474-d923-953c-0b73-02ba2fd6ea82@bytedance.com>
 <Y1IhQPWMX3TX+sYo@chenyu5-mobl1>
 <03be9c79-bc59-cd4a-869b-ed4c85c61224@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <03be9c79-bc59-cd4a-869b-ed4c85c61224@bytedance.com>
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH8PR11MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 061e0a4b-18e8-4af8-378b-08dab35581ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYexdwRuZpp/DV/2wvVsfNPL6eU9L91V/FS9O4Wpjyl8JzMK927WRsyu6/a2ehrpIA+7uB3ljyrdpc1461TpeYh5c+kz4YRDc1zlBZCM1903wRQFYcbnIBXURQ2yqnN5UJZtOWB8MRcIFc3ZlnaZdfr/Y7MUaK877zaJZf4To2EZcigqSBwDRMBGeG49UNysugvl5mrIezEbqKndnkKv8gSv1Qy2gSVju4heNpGQ7I3bfeaoQDk5gPKT1RHlCZSu/blJn/eU/P/oPn8MBY3sn77MzNU8k00ubglia1as5NgxTBeBf7X4H80lLbYC1FRiv6usRmcVIxAeLd/PKZ4G/Nmg6yzIu6cnmrSp1eElOyEm5ckYNe9enaObEmRicoKn68UWtbhxxkNzwlmMvQpmCoqXnTxyniGtv8ki1iiYgr0xNUqoZyDphLtfHUzlF9xb1IXbE3+5GGiTsn51CFQ1TRo88xyykMknd4+HQ3OZWxAmB8UOAd0tMDmFAJj+cYMcmjBwVDVprTCqiqc5VW08CPS9z+427HauHKBcWMY9BjfjlOxo2iR+Vy1msuqES5+uN9xCVsXfD0B/JzeSig06e/Zl4k+SSASsyvQk41+eHMcHcWQ3pEU2vChVfBvN19WvRh1bkKxVVJWjkcjjqWAexlZQZTZRRJDejsCrUiEFh0vUyij1UyemmXBco4C9siS9dv3/wC9sv3NhdrKsuurVHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(6506007)(4001150100001)(7416002)(8936002)(5660300002)(86362001)(4326008)(41300700001)(478600001)(53546011)(6512007)(186003)(26005)(33716001)(9686003)(66946007)(6666004)(8676002)(83380400001)(66476007)(66556008)(54906003)(2906002)(6916009)(82960400001)(38100700002)(6486002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jCwkN7/ptkowvjNJA5w92mOm0+DvBtjxQT3LGC+Pg0Sqn6ifnE75JpdJR83?=
 =?us-ascii?Q?fKrBlQEz+Z+V6qL/uwCDOwTfkOIG+qPt5gaTOZstq77zzOmXb5fmgciXOOQD?=
 =?us-ascii?Q?kPsvkrRBPAkwpoN9QjAfAb621joNRAb2gxR3X4XR+BE/j4kEdFbFYGmlCe6J?=
 =?us-ascii?Q?AG3fQX+n6UbEqaG6YTfrS8dr9z5fyF27Ayydj2TGKB/HtryXaE5AmswzI2er?=
 =?us-ascii?Q?PVoFidpBel+tRF1PsOmqLZ3fNN8KgaepBH+EsnqHTSjbeqtTjR+Gpr+oiu8D?=
 =?us-ascii?Q?qjLe0XBhkiMm70IWMBeRND/G5jRb3MLdjxY+qSlhV0rqz1KfDa4H3eMHvcCr?=
 =?us-ascii?Q?xHcjS/t96HucCMQQDBT+SbJ3XjVfLh8sMDyo3hAtg+uKBgmwwwBnmxJHpi2y?=
 =?us-ascii?Q?/CjieXV/p3D0ar5pyyzpOAG16mK4euK055t6pBi6KCw58bEaR60YqlSWjr1V?=
 =?us-ascii?Q?dhC/YzCMijGcOlJucPErr5C+ZhD90HERCSPys7vqeEjwieSlvrHPBwkZKK8N?=
 =?us-ascii?Q?sCXQAKytScZCBWuEHvetXOx/49hVSfkzt+z1tt1zMu0PDqvaB0b9kTkZ5W4K?=
 =?us-ascii?Q?poXuipBWxo9Z6iD+wQo3hOHxxRoq62aS2lrlr6ivY5w7JyC5o0/R+C7a/wMA?=
 =?us-ascii?Q?11LB0iNmsIiPlh34wK0ZfC5ejQEWBLS9g2YOoqBwYjRHYBbGI++HwLRYgXLx?=
 =?us-ascii?Q?2HT9yPWyGJRzrIHUoyBtDniADrbXnxeYUvlZuq/ImP5iu6ghFoJ0bNjrHR3g?=
 =?us-ascii?Q?NKglOjkBtQCG1WdXOqDcfwFmYNH2npqNrGQ3UmaA5XpIuOV2HTHKKkPCnISF?=
 =?us-ascii?Q?zRgyw90r18IhwBs1pNGvaNxdXJH8AQrjNhEamH0xwiC9IFzVwczWnoYNJw6i?=
 =?us-ascii?Q?1Lfk5g5YJ3bB3xdk/upxfgmzcFwsAnlyoDI0fkKQZ9tyUxUTeZ1TWZNDbjEp?=
 =?us-ascii?Q?l3KpR5g/0rPDQA5icMftEQbt0sY3mV8+w9u3Rq9GMxdhdxsKShwzFvJRfNqr?=
 =?us-ascii?Q?9jV5KnyBFRfXyO5H0SsfwIdQcVWPFxgoHujgfHZbJPMgYJ5Y5ZPQz64f7r9j?=
 =?us-ascii?Q?ngih/F1r5LaDKQeip0oH9bf8lgCcVP7ypPyUFRWqNHEW+WKv9Tz+MSJCztnu?=
 =?us-ascii?Q?e9ZYce8ybtakM6W5ymFpSUNKrcfPXYJakS3qqFg1WtdR9TvaXanCjRzPMUw7?=
 =?us-ascii?Q?/dtJHljhfMUhqQbr/8PXUPA7/NwDm1uOiIvDIiRbWOvZYK5Ii9p611K6za1O?=
 =?us-ascii?Q?/5D3zKNK5Th+eZUABSh+uXwZnMnqi62yGf/pa9m5mXs9Bc4pctlFte8Jvc8O?=
 =?us-ascii?Q?rToNg7B9ArlcvuRwmzcsa6fB/b+//no9IyXdEHSSgi09z783DJZ5oAVRsdzH?=
 =?us-ascii?Q?IL2oNoZ9zT6UCLXm6h6R8y6669ukvZtrdppHBrM/FR6VFhD64JtPA7r49eLz?=
 =?us-ascii?Q?vowPnDVONQe1dA/7vIqLdf7loLhrhZvrJYy9gMg7Z7mlu00nWuig+IN1fzt9?=
 =?us-ascii?Q?+aesIV5VK591iQpMDC30mT0llwXFIPgEiALeRZNmrdE7lkbNFaOabpoCe38v?=
 =?us-ascii?Q?ebjupMDvx5yTbkwg6o/rlHDEm/G34K/zd3fhSQ/M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 061e0a4b-18e8-4af8-378b-08dab35581ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:15:06.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyNeJRhTvInUOIfojMvDnt7R8V96+Fg9ug7f5dO8vcuLuUTbl7dyvX+UsOYNsrP75euNQ13avP+B4BFC+K4Gxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-21 at 17:35:06 +0800, Abel Wu wrote:
> On 10/21/22 12:34 PM, Chen Yu wrote:
> > On 2022-10-21 at 12:30:56 +0800, Abel Wu wrote:
> > > Hi Chen, thanks for your reviewing!
> > > 
> > > On 10/21/22 12:03 PM, Chen Yu wrote:
> > > > On 2022-10-19 at 20:28:58 +0800, Abel Wu wrote:
> > > > [cut]
> > > > > A major concern is the accuracy of the idle cpumask. A cpu present
> > > > > in the mask might not be idle any more, which is called the false
> > > > > positive cpu. Such cpus will negate lots of benefit this feature
> > > > > brings. The strategy against the false positives will be introduced
> > > > > in next patch.
> > > > > 
> > > > I was thinking that, if patch[3/4] needs [4/4] to fix the false positives,
> > > > maybe SIS_CORE could be disabled by default in 3/4 but enabled
> > > > in 4/4? So this might facilicate git bisect in case of any regression
> > > > check?
> > > 
> > > Agreed. Will fix in next version.
> > > 
> > > > [cut]
> > > > > + * To honor the rule of CORE granule update, set this cpu to the LLC idle
> > > > > + * cpumask only if there is no cpu of this core showed up in the cpumask.
> > > > > + */
> > > > > +static void update_idle_cpu(int cpu)
> > > > > +{
> > > > > +	struct sched_domain_shared *sds;
> > > > > +
> > > > > +	if (!sched_feat(SIS_CORE))
> > > > > +		return;
> > > > > +
> > > > > +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > > > +	if (sds) {
> > > > > +		struct cpumask *icpus = to_cpumask(sds->icpus);
> > > > > +
> > > > > +		/*
> > > > > +		 * This is racy against clearing in select_idle_cpu(),
> > > > > +		 * and can lead to idle cpus miss the chance to be set to
> > > > > +		 * the idle cpumask, thus the idle cpus are temporarily
> > > > > +		 * out of reach in SIS domain scan. But it should be rare
> > > > > +		 * and we still have ILB to kick them working.
> > > > > +		 */
> > > > > +		if (!cpumask_intersects(cpu_smt_mask(cpu), icpus))
> > > > > +			cpumask_set_cpu(cpu, icpus);
> > > > Maybe I miss something, here we only set one CPU in the icpus, but
> > > > when we reach update_idle_cpu(), all SMT siblings of 'cpu' are idle,
> > > > is this intended for 'CORE granule update'?
> > > 
> > > The __update_idle_core() is called by all the cpus that need to go idle
> > > to update has_idle_core if necessary, and update_idle_cpu() is called
> > > before that check.
> > > 
> > I see.
> > 
> > Since __update_idle_core() has checked all SMT siblings of 'cpu' if
> > they are idle, can that information also be updated to icpus?
> 
> I think this will simply fallback to the original per-cpu proposal and
> lose the opportunity to spread tasks to different cores.
OK, make sense.

thanks,
Chenyu
