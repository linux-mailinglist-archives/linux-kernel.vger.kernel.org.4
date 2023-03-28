Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC56CB763
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjC1GnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjC1Gmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:42:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52932D61
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679985769; x=1711521769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Kzazn/wqoBvmlMOCZ2p80Lfkpj2IU/4ipt47sfOQFPw=;
  b=Ae3qF1JnqSKlYSE3tMB5dZr3v1F5SqRCCcd4FbHZBTNpK5rAEArLFydg
   7J90Sz1JY4Dg3iT2cLFkvT8373PuBA83O16F82NkqjpQjVFanjRqlqqh6
   XhM8hCxU+rKoQfBXHC38maNw/NS7wnU36ohQ4WgeL6tSkk6VagUjEFIj0
   WABc8pmBYEFzkjHJSBR9gWkp5/Wk9CIrNyocBmcLgiFsT0Pos5K2ierE2
   6BP2wL2d3BKljo79d+UPUKjwM1tC8856KE2ZqcyW15Qgu1++V73SVTgHe
   PjvazQy7SIlgPI9KlZdvzjgK8Q3k5t8u3d/traOs5fbHaQPFoINIl3yQi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="368243762"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="368243762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 23:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773026358"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773026358"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2023 23:42:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 23:42:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 23:42:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 23:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrgvojpszB8N7M/24umEPM2TuFwrIwgxeP//FQzuV4fvXJbYPrmaoAyJvE0bxVsmrtqPJyHkS5W5MTso7s8oHFy+VK4JSwAKwXADb7KGPrSrZDwb6mt1ytwKBOXb32LuS0SNW0r5JBYGODNfgJDzHgnpISWvHKmMGuVI3zxfrjr0OdIK3Bj00k2s3o4agjA7Vu8VfOmdS7IsoBohj0lda4rAWuGMJQB6tkc6qd5NL/vjuiWkWrjeZWuHBdzr1szTDP/MD4lavrM4CKFjCbkkQ+3b+fZDx9OuZY+fbeAiAyh+zqtlUjzTZz6Tz1LeBGrlMn5t2kMAYhYaROS2e4Jhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqWjU19pjKy128vZ2BDIqYmFELsG07nt8ic2sO/iby8=;
 b=kVc7k8o7umEKUPFNbDm3MaehZY7d5Jkj7HbticAyp1hz3S4qMtilLizgujjaZjx6P0mphpRVdMKdkZCodOSsluGtVEO2jRtS3RNVhKTcDS4yQw7lDQkdJEmJOtPIM/8KZfF6m+ULB3PJNWvG7FK0M4FqvirBC7acuTkPjCoMqRQUqzrXuEk3bHpyUAbwMVKLAZSKhMgtWUEXEt37e6cCQtG2smnUO3FYc42VvctW004b5RnefMPSA+zxGzDk37tBFCKo9yiVyXGdjwP/MWoKzE2ILFwkJddHTYfGrh74crLNK+KDOyRa9b1HgqynZaY0xsm12zEl9bQDrRYFaFPQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 06:42:45 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 06:42:43 +0000
Date:   Tue, 28 Mar 2023 14:42:31 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230328064231.GA4899@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <ZCGsJB36YYbgsgBW@chenyu5-mobl1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCGsJB36YYbgsgBW@chenyu5-mobl1>
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: b74dcce4-3490-4841-057f-08db2f57a1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBHBrRg9F+0FZ3Db6Ed/2HL7BIejUO7qlwz6sgyW66xZJKJdDL20LsYEWKpOVj47B0HIams94if7BR3r1Q2uFk45QSb09gEHhaU4jCCoVx7WU2CeMkMquNn1PwRD1kRYRZXbm1mx7O6xFIJWm+ll3OR3bEYUShchJs3znrQ4cCHq6jXLQT7IJqhLX0ue9LJ7cQ8n6biVKSV0PrxRm3XIRjFszTtaGRpoVK/iAl6k7gf9sLAWLuUYrUkA36vYZ1aOKY7Fonc6s0Qd0GMElc6+Ly1xAPpaoJGQafrlZjq4GnCTmGA3HUZSIxBR9lb9WDcfvnJRiss5J6fvK+X11Fp8uShXVTMrWP8UT1Ab7a6cG3483Sev6Ru6fFuAbOWBb5LBqc8TCrhfV5u0rZ68oRpVeoR8nZMDdB5b3vIFfNQ5izYLKdVrOZIcQUAmEwjJy4QyBD/s5SZc/vdIfnQnCrpHCpDFtz6homivimBP7uYd7RdIAb1VEVtijcfyYRCiuW5TyWiwxp0+moix9VtW6aD2yCKiCBFpM4+ajDW/Oii5VthSc0hX75YkQNZjd1qWm9QQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(83380400001)(8676002)(66946007)(66556008)(2906002)(6512007)(4326008)(66476007)(6636002)(478600001)(54906003)(316002)(186003)(9686003)(1076003)(26005)(7416002)(53546011)(6506007)(6666004)(44832011)(33716001)(86362001)(41300700001)(8936002)(6862004)(6486002)(82960400001)(33656002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3cxfUphSIQMM4f0RVoSxav7jKVBktncKCiQTBnLUXp7QWpmT9Fr7DAFSLVUH?=
 =?us-ascii?Q?QJAMxUayyJaM6S7ak7vAySpYDG4T5YimMCBS1bZ0ouwQJjU9D2TzHAUftIfk?=
 =?us-ascii?Q?GyOEGrfc94qa1NbJk7QCJGVmvpjSBZvXxXhTRDRw+KNMt2wNKX0pn6ZthRPd?=
 =?us-ascii?Q?iNeyovxk9ZeBGhzPwmz6Px3AHXlm9COKBIqxlEuXGy5NNsJ3yxGZYKhjYxPa?=
 =?us-ascii?Q?E8avBrP0bBxFqEBY5CYc918TElABzx6c9Dw0SzyYlwm0gsifM2OHrN9SvMuW?=
 =?us-ascii?Q?Wb1gDh+9M0IakuF4CGAFy8p9KW351qxbLa2Fg7QwU1rNES0om/08vvBaA9ao?=
 =?us-ascii?Q?Lw+/cgtmx85sEn73lF/zQOzatxdXwyldXb2GBwqMwaYHK1bksqZTqJtSuMV9?=
 =?us-ascii?Q?UkaOzdciTiAbWSdRvxMoQ51ZLRTD4w+rk9q1e6LoaL2H92p8la2Qtf9+KvhS?=
 =?us-ascii?Q?8k8QVIF4++l6q6bEvSKL7sLLllJZh34lHLvGiWtUJDyItO21SjtY1Gfx5U0K?=
 =?us-ascii?Q?LxD56ru6XKxcY8qLWhiMlAxMFVOQBi3e2Itv7qj8vzLrRkdTBQttFRxAJivt?=
 =?us-ascii?Q?GPIxdhIszNmcmFdp3FP5YEUTUdUdNkjaNqEyKjIax7qp2uxSRJM/7Jw9HWoR?=
 =?us-ascii?Q?3P1blyT/77DrL4mBlT1ilKZ5Vryrm5QsdyywCzoLVqkTSFQWnGjRSyyOjRQ7?=
 =?us-ascii?Q?T/ytbFdeygAuTT3KI80j0JTgY20UY6Cj59atg3CQsWliluCPKZJG92hy6uVS?=
 =?us-ascii?Q?fE+fgQCNsYCe6cDQp/teHjB879OfVid9GvU/HpNOA+kcLym73k9sLGAC5KHv?=
 =?us-ascii?Q?JsxAo1E6+3b/d5y5C3iPb4A5jhOV7wH0ClP8cOo19mj7EShWfHHiHOw6WX/W?=
 =?us-ascii?Q?nH29Nvh8oXkwo52IjsuKSl/3oGDXSgk0eFDA/NzB6b+EVj4SCLGEA0LvWehb?=
 =?us-ascii?Q?juO7QyZuTwxpJr3m9IA5BwfTKqYzRLZ7Qt+P8F24+v4NydcwcEzmkncD1q83?=
 =?us-ascii?Q?a8RVpco7zlxWqJEg2A89S3VNOOesjlhs66Y4SrzO4KPkwZ82Z3XrymcUGHEb?=
 =?us-ascii?Q?2q0HHsj90zJ5Nbfl58UbEzarkwuStShEflGvVlSlgSJ9oqxqhIRVSbhIe0bC?=
 =?us-ascii?Q?VV7zHDVYsSjsnVC02ortzFF51DxAXHxJbpxwO4CXG4ORNxTlrzswizexyqKb?=
 =?us-ascii?Q?aHqz4zlPZYWJX9mcJUx3YyVb0Lvk76djbrzaFb/s5OJBPa2Xxq6EVOiiRJ5+?=
 =?us-ascii?Q?m91CmcVoiQKw1eD29t5LmVLfYjnpRJu+RdTweh0BaPIFLK4ml+5wtE002fXf?=
 =?us-ascii?Q?RrgFKussTXj4+w4/APKcMxqJAURGpVvW8u2HplBah5HnzTOUmOfDVxthsZoP?=
 =?us-ascii?Q?0EZt38CaLtCQWvbY+A7jWaDmBPj0qugSuI+dgKsZeZqiXuYwihbBiS7I20Nc?=
 =?us-ascii?Q?uiJQdMeSTuEoIjDGbOV53+SBcdD9JBnb0qoWXM9Moi5Ph9TzZjOJLHrColqL?=
 =?us-ascii?Q?eUvnSESP83aC+L7DuzT47x1alnzHf8ja+MV/I4oJzC73+POZXbHCi8yPiK3g?=
 =?us-ascii?Q?V8iHZei7OKhWos3d2HjckfBkw+Vxl4r/qZO6S45T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b74dcce4-3490-4841-057f-08db2f57a1e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:42:43.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wzz/8yGs6Ny5FSbM1OeOM5pkBchoJxF09RSePelGbklBYKGnutRmLE0EhnV1q18s6mOpDcHTjJvwfiP7eIRU5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Thanks for taking a look.

On Mon, Mar 27, 2023 at 10:45:56PM +0800, Chen Yu wrote:
> On 2023-03-27 at 13:39:55 +0800, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> > 
> >     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
> >      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > While cpus of the other node normally sees a lower cycle percent:
> > 
> >      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
> >      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side.
> > 
> > The reason why only cpus of one node has bigger overhead is: task_group
> > is allocated on demand from a slab and whichever cpu happens to do the
> > allocation, the allocated tg will be located on that node and accessing
> > to tg->load_avg will have a lower cost for cpus on the same node and
> > a higer cost for cpus of the remote node.
> > 
> > Tim Chen told me that PeterZ once mentioned a way to solve a similar
> > problem by making a counter per node so do the same for tg->load_avg.
> > After this change, the worst number I saw during a 5 minutes run from
> > both nodes are:
> > 
> >      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
> >      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> > 
> > Another observation of this workload is: it has a lot of wakeup time
> > task migrations and that is the reason why update_load_avg() and
> > update_cfs_group() shows noticeable cost. Running this workload in N
> > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > task migrations on wake up time are greatly reduced and the overhead from
> > the two above mentioned functions also dropped a lot. It's not clear to
> > me why running in multiple instances can reduce task migrations on
> > wakeup path yet.
> >
> Looks interesting, when the sysbench is 1 instance and nr_threads = nr_cpu,
> and when the launches more than 1 instance of sysbench, while nr_threads set
> to 1/N * nr_cpu, do both cases have similar CPU utilization? Currently the
> task wakeup inhibits migration wakeup if the system is overloaded.

I think this is a good point. I did notice during a run, when CPU util
is up, the migration number will drop. And 4 instances setup generally
has higher CPU util than 1 instance setup.

I should also add that in vanilla kernel, if tg is allocated on node 0
then task migrations happening on remote node is the deciding factor of
an increased cost of update_cfs_group() and update_load_avg() because
remote node has a higher cost of accessing tg->load_avg.

> [...]
> >  struct task_group *sched_create_group(struct task_group *parent)
> >  {
> > +	size_t size = sizeof(struct task_group);
> > +	int __maybe_unused i, nodes;
> >  	struct task_group *tg;
> >  
> > -	tg = kmem_cache_alloc(task_group_cache, GFP_KERNEL | __GFP_ZERO);
> > +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> > +	nodes = num_possible_nodes();
> > +	size += nodes * sizeof(void *);
> > +	tg = kzalloc(size, GFP_KERNEL);
> > +	if (!tg)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	for_each_node(i) {
> > +		tg->node_info[i] = kzalloc_node(sizeof(struct tg_node_info), GFP_KERNEL, i);
> > +		if (!tg->node_info[i])
> > +			return ERR_PTR(-ENOMEM);
> Do we need to free tg above in case of memory leak?

Good catch, will fix this in next posting, thanks!
