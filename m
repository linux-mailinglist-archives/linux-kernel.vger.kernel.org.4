Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD0F658965
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 05:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiL2EZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 23:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiL2EZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 23:25:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8C1262D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 20:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672287940; x=1703823940;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=7uFpdykziItR+pUXJgHc8/2I1Ba0rutSZ2NSnYL9ZGI=;
  b=e19Io/RRm0Azo2ds/dJv1ZLFoPM+Z/Y3h+FVSvFhalUER6hXD2rTEqhn
   C+Q8B5vtzM/ckPhVP0jm0hFPOvCkMYJyZKbofT7vucONgxRsfWwlOyAOq
   Md/do9dCsAbZ4XSjmv1Mv9aL0PbzOnkX1fcPm/NBl6aXovL+zI7QWdTpj
   n2JbySrCN3N8vH0arzDwIApuXCtEmUK75pogbZ9nBTCF7UKGVeQuIfEk8
   o0A2ZZP9bHAqIp7X7wQbxp5PoH97dk+ZXtZezH+Ip1QTDInnloeOM4M+r
   TEOQfPdk14dE+eOygsC1eEprNIruF0aWPY4F2M1nlU9tmLTsrVMl5qxXo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="348186897"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="348186897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 20:25:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="685867912"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="685867912"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 28 Dec 2022 20:25:39 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 20:25:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 20:25:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 20:25:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+gCZEsxMlSiOcjSZUMF/yqg7iFfYQk+kBP0p31fdMCmW5mgIheXwF5Awh/gXE1QaEKZfXVvJIz2LnXBPSNAjYGAoDQHfINIOv8WWsLQ5e97jhzKMdTcitcoQwN6ngadhhLQQfE78ev0M73E+rJcdUSFMBaGE2jHNNSwfbBv2M85n/OlpSXE/O2MZscA27wlK/DNjw+NnwGrnRidVjiPQMQAt3M9JC+naGe3FFbQzflqTgTwqbB5uSlqllHVKV9flX7bzzXQGScPpFDe41Piy5iMR3V3t7gIrd57OgAT7+EFaFKq81qkpkTutU6lo50m2gF/W9myIVE75Z17jZNyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQTxfdd1YgZVJ2oKSfHOP/UmQoL3eSsqg5USExNcNFM=;
 b=H8ji7t7AxC8P5fG9Md85Pbb7U0Me5TVcvRBrpOgWC5b15/ojpijaZG6FqIpNSmWHNT0tQeduhrrgz1QHXDy+EnR9v1CwKtYzTcqyqKplxRHo2IA33w2QwmRsza88WdCf1mbRtSdTEWP4+aZNRAO5oQE58bzkKBH25JdxwJ224XF5vpRMxEgjeM/bccKJQK/st8rBuK+YGQNq/Qb8Bs6MFO/NKIyLDi5isVxbGg3Vemug9AxqMqQh1nKUVZOezUgm+C9pINWyV+FuWbLaSl0go3HfkQa4+y/yYh79DPIiZhFrJRPs24ZgWxLKy/kdHGBY/UUiH4PHGtVvvXE/UfITOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 04:25:37 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5944.015; Thu, 29 Dec 2022
 04:25:37 +0000
Date:   Thu, 29 Dec 2022 12:25:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, <zwp10758@gmail.com>
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y60WrwuM43HcNVC7@chenyu5-mobl1>
References: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA2PR11MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e500a29-28a1-4a93-357d-08dae954bc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQCocpJOT2bVsMw4h96bZ6u5rGpPYp9jv6VEqNl+Je6WFw49kFhI8ma1a/3s2ndF3YIenQNcc/hclqKFNqygUf+hdAJ2oFUJnJNwRrIKynZMx6H9gsSoyGkNjr7XXtgTqCbT+Sv0OlCJsdmtXb60KCmQiFnwoC+E4WjwinUYk4cDLjTvQ42PP1IMesrHj528Uws1V8KU6Xd/NKj1T4kXwSTps4J/F6geFEdE6mIBYvmLjpFKrSqtcR3YzsoAx1DFhXDPWFqzo+S0QzV0VU6yTIZJniwKH5JQNHjByUje/T33JWu9843jHjlAPjk7KyYqpGJNhoMeQ5OtNZZLyzU5coOWEqVyNBqRkroc07XfzEvfdyVHNXs98AjeyepgjFjgDRHxifqCOds6sBXlWdZJRqPidhzoF4dHZRli+sFunrD04gjO9xA+tkuS2QXqcyZFf2c6YOn6YqG4wouFR7unUdzerZ8+Pw209jRYT6mJyVZtpSXggCpoHOx601uiRdRGHP+q+yIS0puCLWMz8v9rsS3tXXCg/tbJSQluJnYp54FEb2mGyRUvLtKDEL6dPt6X+LpTzjY9Nkm/mCrsrRctTtgwLcer/J8a/Husnl0Y7m0nO+WryQAHWDkXIT7SvEJwFM68iwM8m4fAD9hbWodfkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(66556008)(66476007)(66946007)(41300700001)(8676002)(86362001)(316002)(83380400001)(38100700002)(82960400001)(6506007)(53546011)(6666004)(478600001)(6486002)(2906002)(8936002)(5660300002)(4001150100001)(26005)(186003)(6512007)(9686003)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z5JkBkxJqdJKR8HQMe3t/AAjAD8B4TYoBiYemTjyvJI9C/T44Oi/Z9PKOGbc?=
 =?us-ascii?Q?MGxpmm3xUciRSzPKySLkrdE4PPGt/WOdIcXQKnJRnw+u7mFFVoxJ338nkVAD?=
 =?us-ascii?Q?Twf6icKyxs98fesTbVOWZ/SLkc77cLD4n8l8J1qa3n+2MXX6Q6U9ZdPDOoc0?=
 =?us-ascii?Q?oH2wVbfbyVCB+ElOZf1Y71/aD5xSQMpDjDCYhUOPPqPGXQngWRRPMC+JQ5Jn?=
 =?us-ascii?Q?/X72HyR50x2Gcpswv7IUoRWoc3f3aUOBVDf5eOTK0jEegQiSQghQ6g4bb1Gb?=
 =?us-ascii?Q?1+t6I41lRibZ02OGj5uzytnzgDEVga3RuJ5hdIPUt3gECuQspWkbnG3x79tx?=
 =?us-ascii?Q?ZkMlXWIjNwZSYJnp80Kj2LlWcwbagoHwbYt1TNVgInuNtbEbKnKzwh+Lnv8N?=
 =?us-ascii?Q?BXLN2kbuyHxH6R7v+1U+PDfukymXI5OBB/7vz+rSM4YDJuU6WvcvNtj5w1MJ?=
 =?us-ascii?Q?OsX+d4Sd2B1hJTnLtqhuLOMyrCmkFj2UuHqnZg99TfZzIimmOUBjav8M8pDo?=
 =?us-ascii?Q?zCdOrJdRAWjv7oinEp/Wzi6zYzBnahxxS4ejbvTgyVsc94LlVjPsZk5jJ5LX?=
 =?us-ascii?Q?FV6eRJu2Jw2Y0++s/loxIJJylk8LtD/DDJ36l3zJLfqLL/x3wHB4CAtlb9w6?=
 =?us-ascii?Q?e8UkTYyfk63rc1KsSUY64aPcUVRb5UX21cuyoXVQWQ9o27Zr/lsSfF2U5z0C?=
 =?us-ascii?Q?xh4Wi8xLSIuMNVI1YS7hVWT9byAv6Jb3AFGM1HtvWSAxMcMkRC7oqHpD2Ifr?=
 =?us-ascii?Q?j2sxKQT8LvTqgWJLOCQ4I75qrasUEcP7FfXEA8V5Y/71+3hUXzkf5roB6MCH?=
 =?us-ascii?Q?uVxwxjfymEbDaiHm0u4RWgYjB0VNNerO88/bY1UIfu2AiMVKMRiSeIkyq24N?=
 =?us-ascii?Q?Wwb43IserZUnr1ljGSFuyalSh8nHyHFVnYagSJ+yJ8+poNXCTTGUEnnh93TC?=
 =?us-ascii?Q?jrhowoZSEkdk3SoU7Hy+4OMM+vLY5rDomrkLVDnRO41uO90I39g+ORAiSRmr?=
 =?us-ascii?Q?/meYjFA5rWXajwh00QZ8kRogu6XgJ40pKXl3QpzTEmLw6VfE3exNqMdmXwV0?=
 =?us-ascii?Q?ZuuqZY3qnrS2tP1UnfelVY+ovkRN/n6genRsGhMEODpfQ6hND925qdD1hB+9?=
 =?us-ascii?Q?4hUqSHe1ZKSjOXkoDkNd1pdmDZIKWjXwBTHW+6xhf6HUMzCUZid7L65D+5f+?=
 =?us-ascii?Q?e5RcL2+gQyAj3OGOC49wS9tsJDAT1BEePwSmEFg1BSGcllKL9VRHFLNIz+v7?=
 =?us-ascii?Q?cmZiPQRN39uh+TS7yoTIJBNWSXAqzPiuTG64BwxP1yfwBtuzwQrzAOQ33qsO?=
 =?us-ascii?Q?7HZKwTNhQjB0dFXVUzokYdCBBZ4lDkHA8rFVo39bVbuH67pFMl+FDW6Vc4lT?=
 =?us-ascii?Q?g8JOOIM6oRYaeQfkivzVSTR8D3TDyj3uyKyxJ+CLiBV4bbW5UBjufedDf9gf?=
 =?us-ascii?Q?f9egoYyl4DqISOwQ+6wX4XT3BeN2BMZBIZapggJV1MfDwCZf7t2iRX0tq4/9?=
 =?us-ascii?Q?RSmOJ24IHKbwSr/p8vgs4e1uiL16YIKiZhSv4op0jRnZ270VItqarFM1cT67?=
 =?us-ascii?Q?/1ZgFIyyYm8eKALIRbU4hy7kb1lwWvcCLOa3HOAJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e500a29-28a1-4a93-357d-08dae954bc23
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 04:25:37.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LX/dy8qc8fHBJIO5FhujRCiDg89rrlPicKrc7EK9JgcZQ3WAwCMIb0B6w5KosnBgNphPnv87+k9JIf20hBQhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-28 at 00:14:00 +0800, Tio Zhang wrote:
> Knowing who the parent is might be useful for debugging.
> For example, we can sometimes resolve kernel hung tasks by stopping
> the person who begins those hung tasks.
> With the parent's name printed in sched_show_task(),
> it might be helpful to let people know which "service" should be operated.
> 
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> ---
>  kernel/sched/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cb2aa2b54c7a..6f4aef0fed58 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8854,6 +8854,7 @@ void sched_show_task(struct task_struct *p)
>  {
>  	unsigned long free = 0;
>  	int ppid;
> +	char pcomm[TASK_COMM_LEN];
>  
>  	if (!try_get_task_stack(p))
>  		return;
> @@ -8867,11 +8868,13 @@ void sched_show_task(struct task_struct *p)
>  #endif
>  	ppid = 0;
>  	rcu_read_lock();
> -	if (pid_alive(p))
> +	if (pid_alive(p)) {
>  		ppid = task_pid_nr(rcu_dereference(p->real_parent));
> +		get_task_comm(pcomm, rcu_dereference(p->real_parent));
Maybe struct task_struct *parent = rcu_dereference(p->real_parent);
and use parent directly to get its pid and comm?
Maybe off-topic, what if the parent is a kernel thread/worker? It might have extra
name information such as kthread->full_name or worker->desc according to proc_task_name().

thanks,
