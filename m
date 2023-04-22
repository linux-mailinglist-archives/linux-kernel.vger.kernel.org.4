Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5956EB740
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 06:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDVECY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 00:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDVECW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 00:02:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C261FC3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 21:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682136141; x=1713672141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bjNeb5aAGdrJwEj/DCmfhP1dnsAIX2Ll2A5c4pvW9vk=;
  b=CHno+AoYA14Nj6MDsEfJkohRg/ZIttslWgJzy2UPw96TVu7U0zeG3qqn
   9n7ASx3Jniy9/e+o/yjKZfGBrNtK64hy3+j0GURJ5YqWjBj88PSCHOnGA
   jtwC3o+V9cIcZUW2CSrjNixaT2ZBDiRrIlIWaIAnw5kcwoBdf+KIyHeMG
   99GAkXbSN30EX8JLYbzhTCHCZiD+7LcnE4LkQkCuGDSqS9lvbRdbyiXf9
   oiv4qNfxzgFTmSm7BiGy5wokTF5WzrN4WMwYI4a5/CCviBCOu1SrVhNhf
   PIU9KjurHZJE8ecrFa8+Wj8fMnAzY7aDlilzFdX6zPvuuXr1og/2bVXpb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348036158"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348036158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 21:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="725056943"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="725056943"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2023 21:02:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 21:02:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 21:02:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 21:02:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbLgKjvLs7Uj8ngsNYLm7E5c1TZpXvBk6ilHFrapOU0yCzBBl3efOrNd5zILiIxCgleZJOH+snRVfVELDqCBXNuC8GdR9oBkaAzZ4EE4BdLb1UGXzksURr1UtyTYrajCP8yZDRa6GsldfBZdwv2vbqfuPoiClaTtVY4rVXgNYPaEY6Rxvf6VY7b//R3E6G24xky/RNzuy6n8ygeDZuhQxWWR9tmbCWq4Nqnum7QVdiD3os7szIJKWdFUx/8c9s7GCgenpEfWCRslAWDW7/3H4jDNrlZ4NRdlIxOd5Kw3pW7LB0zwVBHjhBoDxUhRDKo0edGVCutJlIJAqkvgzmxs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdk+GpFCgVWWfbi0S5Wo38F1jAFLiK84Xsj4IhHmYxQ=;
 b=GhAIQnWNE+37dbSF/cwHaKEJh1jjTU9xninb6vbfS71uXEjhZHvwe2UIc0c73zzCzjSMRH9twKggQYYN5Ve6aJicoIJA1IsUI+vonu3A/G/1VlAQ4XqTbvjD/wxTjTIBwg1At73q8wofqFAUqiMqMu177lXAd4nJfjDUjoii9HpQ/ooI7vZzkAlHghMsSlE00wEgk3xJ8YTsGj7geQ7YnqJEQNEWm8an0zxz4dpsl/ADM8R2E3nEnGQTSzjnZqOhhLOf5ILFSHtLl0rUZMCtGYzFiyQ9PX6wWqzTAR70lPjUg7y9SN4LGIh7AlCYkUqBQGI8abuNyjfKL52DW568Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5577.namprd11.prod.outlook.com (2603:10b6:510:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 04:02:18 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%6]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 04:02:18 +0000
Date:   Sat, 22 Apr 2023 12:01:59 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
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
Message-ID: <ZENcN3suKMCaHm1w@chenyu5-mobl1>
References: <20230327053955.GA570404@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327053955.GA570404@ziqianlu-desk2>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5577:EE_
X-MS-Office365-Filtering-Correlation-Id: 62507b4e-204e-4686-ee0e-08db42e65c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIoP3hlHJqmZRjkbymI620kli4m1pvIf3IPY23mHBnzxZDimpAlhK0OCC8sEP8mn4zRd7WEmEoQwrakc/4HZP4u6x1H3zPUHzNh5+X1dFbfvKASYgne84B14/yv8fxSgCyGcbKYeFkopZU2jLZdyYRk7m/UO5jzBK1osU+WAqr+ii1ttFRT4zptDcrmQzgvRfBOwxrbqwCMN91Kn++Tzo68PtvSJ313EGeGBplIoXVFeMu3Lu3f4A8CslPiXZAfBmGt91npp7DufJp/qS4xW/laWsuLroP4Dv08QoSHPTTZZTOqBP6Ss/Pfz4Du3vTmGRNj49J78B9flePdOpZfvT9pK4igRsWTBcNJ43zDtsSxbM2h0A9uQuU3nv5An71YZUdywrn90xD0bM1O+FMJ70aO6TszJCPu+wEn3HGocXCV8NKS7IwzG6dpEhrlgkb1Dgd4zwK1JAzkWPHJfUNSWoXzNgzmRWlK/gWlCY+cjKFCcUDlfzKJAIv6aXpICpN/6KATrcaRwYZ0T8Dnjs2wPBPEqlRLaKQ0HzYu/8KwD9WuYHz06YPb8tR2GJ7s1uGES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(186003)(38100700002)(33716001)(82960400001)(6666004)(26005)(478600001)(54906003)(86362001)(6512007)(53546011)(9686003)(6486002)(6506007)(6636002)(4326008)(316002)(66946007)(66556008)(66476007)(41300700001)(8936002)(8676002)(6862004)(83380400001)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lf1wCJSkBkKhQnl5Y3hQ0+lE6B/jgFui8rituWsYt9LCL9kSz1fhmPE96eBN?=
 =?us-ascii?Q?Q4sHsvv/5srvSnpODnhBUyu+jK3WYFxRNiKYEVZEtQIb/kJtT0zJQcQelu0b?=
 =?us-ascii?Q?UuEuXTR0DX/m0aMsml2+K1oaOqHNruQfHq59pTcvog61QCBtRobMPuZgv/AC?=
 =?us-ascii?Q?kK1Trti16/Bpt1M6U/MQJKQMuUJddHemohB5HkqUeNYWtw629Vz3iKH9V3ms?=
 =?us-ascii?Q?JvQ4ivHIkYC5QOookCEPk9TSB/imOHPJkjDcIlFNN5UfwaRB2jOsCai76ZVf?=
 =?us-ascii?Q?Ci1hG/vp7rpRX9k95Ymv/LBSmC9s3pcv9hBgzhNWIdSv+scVIH+c3kfiy/vW?=
 =?us-ascii?Q?n1MEDgse/DTbWQ+yRT/9g95XSDtVMFYNPNePKYXlU0yDvjlJfs0YFnvIhBuY?=
 =?us-ascii?Q?rLjbXZXDUSO1LK7le8sBM6vqAF2fTRLpP4cDMof2JbL8/GV8RaMT2LnwHJq0?=
 =?us-ascii?Q?T7xfNebmYfPmCxaR2bd438PWSF6kI94GaZVTic6zH94OlvFd33ixRXWD+3Yv?=
 =?us-ascii?Q?IISN1F3sAwew9lxvd82lihrT0p0eeJp/2JBgEINFba7zx2LhpcC7GpDA44Mg?=
 =?us-ascii?Q?YuYfD9RNsxerf8E4XJlfx8T51YFPmiXnGFWwyryvCkiJQDgiuMlAQ7Lh6iZ5?=
 =?us-ascii?Q?vz+mwyawhhmMmm9AhPTEiO4i0nUnvDDLKiqzJUgNjasg3mVC0Rl07fHsTosL?=
 =?us-ascii?Q?Tah2GMSLcg74FZ1ymOYz/sP94tndiDQN8DX3S3xSMIudXwwyO9SPWHiSU+P8?=
 =?us-ascii?Q?UYaxO+YzXBAO8eV4FycpSYScOofSx6slzq9LueZUjIFb58/UM139ZKCoJ/s0?=
 =?us-ascii?Q?ysEpesWtxBygmSM2Z9qdxxBG8NOW3tQgCpF+b3CcvGCdp01+MbO6KcJospNS?=
 =?us-ascii?Q?nrz/1ahtYB1dD2Hi+rrNsnRUCczA/Fymkcf5pIg1bNbVl2qSVfuenXh7I6JZ?=
 =?us-ascii?Q?xb64QXnm7Y3frs2nlgymMBNzrZiCHoYDDv0axtMkQl3sFiLfI4rymsAkEVTs?=
 =?us-ascii?Q?SQNisQ89Gcw6M9wDccJ526zMww9pwcL3o+wj5LVoQGjBZRqbebTRQ3LezrDT?=
 =?us-ascii?Q?+bKt0Gvk1CP1kpyEs6XIZRNo8WcokVyjPMWxXvycv6zTx3LmODHIgIEznXm5?=
 =?us-ascii?Q?bcSCa6h6htJbh5PMPzdD/ls7spQ0bjsAkwwsbssWAruxCMaGhx0K+aGEOXsl?=
 =?us-ascii?Q?HlQ63f064CxWBD5tK7KhqXp8L/XgGTk9JgZ/GdP82x1O26hwWwCIbZX1zAB4?=
 =?us-ascii?Q?oJ5Xmr4HN9ngvvVJGlONJXuS8RZN5q3mFhZtdO6gu9uVjKBhA8BNRMS4u4qI?=
 =?us-ascii?Q?NLqvM9pOay2hQkjiI/QVCH1kyGl6T3bcG2EGon+HUVN9AjgHyTR1enaDrXnq?=
 =?us-ascii?Q?ltiSCvDUqPcY1yVUwxpPgpOFhANpvFzxFQg1e5fmtht3gzwkvR2TIEF4Lzr8?=
 =?us-ascii?Q?r2NtNHs5szOZc3xCcE97Nf1/vsIG3EMEekL5B7D6NyE1Q031Rw/BV0oNorcH?=
 =?us-ascii?Q?t1YeiS8qtX33Lt1ZgRhHLDXkNCHTshdcgkuCLd6iQN0F078dnFfzKrNu5R+5?=
 =?us-ascii?Q?QVPo+4uoLMVunrg4nb5YDyOrDpChIVXDWSkHw3Pp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62507b4e-204e-4686-ee0e-08db42e65c9c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 04:02:16.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFIaI4ki1LL5i9DzQrYAYgO5P7qBtez3OWtlpdImJQK7W/zqFVUOa4arzmaYpVb4PoXH6PlbVtTpPLt3Jc7rjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 at 13:39:55 +0800, Aaron Lu wrote:
> 
> The reason why only cpus of one node has bigger overhead is: task_group
> is allocated on demand from a slab and whichever cpu happens to do the
> allocation, the allocated tg will be located on that node and accessing
> to tg->load_avg will have a lower cost for cpus on the same node and
> a higer cost for cpus of the remote node.
[...]
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>  	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +	int node = cpu_to_node(cfs_rq->rq->cpu);
>  
>  	/*
>  	 * No need to update load_avg for root_task_group as it is not used.
> @@ -3616,7 +3617,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  		return;
>  
>  	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> -		atomic_long_add(delta, &cfs_rq->tg->load_avg);
> +		atomic_long_add(delta, &cfs_rq->tg->node_info[node]->load_avg);
When entered enqueue_entity(cfs_rq, se) -> update_tg_load_avg(cfs_rq)
the cfs_rq->rq->cpu is not necessary the current cpu, so the node returned by
cpu_to_node(cfs_rq->rq->cpu) is not necessary the current node as the current
CPU, would atomic_add still introduce cross-node overhead due to remote access
to cfs_rq->tg->node_info[node]->load_avg in this case, or do I miss something?

thanks,
Chenyu
