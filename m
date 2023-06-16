Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488A9732733
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbjFPGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFPGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:17:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670FA268C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686896254; x=1718432254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8yvKDu8ZhWAa2cU96+r5j2ruWD9K5auemHwgZ3FtN/E=;
  b=gnRuU4DELa46mvHZsN47+5lUhOaoA99jnVGtqr5Tm3p3BIPVZuvUVF5r
   pkg/KatkydoZFMa5oeKDUOzoK+ouFNuNdsTU5VhX+drGNIDVdjq063Muu
   G/fx7HWkCMhSMHklZf0KtAdRt/oNtXF8D1Z/SsDSmsWP52gMOh1MLNmKI
   1GRZVYHN1fsdqlgRoXwA5TmgMBOu+2J9bIAsPZWi/rnP1n0Rr6bNks8eP
   VrQGBKgXDHyL9Axb4hfN59mwt5z1322TFA+owk7UR/YnFL796HrQB92vX
   US4wbE9iyQ3oaQhzc5ZbRwYG1AtpyAxPlkpg1QGJ5xsctgVlNgXcA7lFT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348848238"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="348848238"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715895005"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="715895005"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 23:17:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 23:17:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 23:17:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 23:17:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRWDu/Qm1/bL/QKMFLTwqcRPSTckW7l9SIxJAt+Pa6u3L9qBxR4y2D6oUJKd4EwguWmWVrxIXtgp97V6iicv/nmjl6pB3qXF7HQzuL3mKrbwacPvsPH+GC6UsAOyXr0NblUz1I+AuPOI2+H21H3J4C7fSDy7urY0pGTVmYc6qrWDZ+hOeO+m+gK8U4Q+qXT+x/rzdXTI8tk0Bg0dX5iF0fVOlvSqSNZe84rncRy96EKuVo0RYcdc44eXbh1hTxt7//q6S6PdP8zGft8RoUJbV1ieHZQsZ1P2/XY+0HJlAeVkJ/mx8oixe7OMH5abOJbj+mhEtKTqCpS9dtLWYocB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExGnXGSSBDJ/tv1XXpxcFDcvbGHLFzxNtfAXKa9kMls=;
 b=jIfpxEi9OQv5zdSeiZTvOd9kejf9bGYS1vRe1aUPu/pr7PIY/F53Wz/YZRsE78XeLDeibuYKbzUfi5zmBb/iGe6RYhTcijNg6KO7h2gOtCxKwT++pVcijQT3qionXE1kfuAPkzSJBHEsTn0+/UJEJhB0nFDnAozCj3O6OkM9e9H9rASOTfoccd3TwH/TQ9YHX5JmTaVJrqeJfQOdwEhES+LKUUOjyF6GMpYylfAUBpVuK0HUcDKBRkfrKMCWFujlryHbHGmYkcYKxqqAgBYGzaCjFo8ub8GXPwEnXGP9AvyD27kLrpfku/b+pNC0GfKTCrrSWf176N+623nkUVzrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CO1PR11MB4819.namprd11.prod.outlook.com (2603:10b6:303:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 06:17:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 06:17:16 +0000
Date:   Fri, 16 Jun 2023 14:17:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZIv+XK830mDeq/JL@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CO1PR11MB4819:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c5f865-3a4d-4577-9425-08db6e3154d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYEcMEtJy+9mDP3e81RuZXN2DoXBwYopOAFQpktkI99NqYyTUXdKy8uKAUl7TpK+Kl4yDV8FdHH0QOnJ8NLORRidZY51FfxpGmjA3q1E4cpdlsHXWHESNrGXAL1DlmBUkhyGGf5NBaRHvJP7obSMq4BxQV+i7QpMN0+dpkcz4NppZ2A8TA+YIusAW6z+N77YimINNNOfoOS7bkNuug5VXQNxl4mFzqFRSDwYqhU9XNi6ayckm5DIrz55yqN9ok5phxi1kmOyeK10+R9dpkO5A2sO0F1uS+zfS68jXASi/zf8HBa+9PfdSFSWuMTvlMm48sSDUG+CJlYB+WYjFLtS7DAxDzQlrJEmFfGQtlxAzS/ww2ymKk4M8wvQmh7bDYX6jv21H4ajg/lzN/IemD1vtZ2vdIOPkGq9wrtUWac5UqXrpiH7JvmaFf/S6bhCny9RDcqmMW7uALoH5SK4/GAAJ83Ms7ilvkbByNnDfJul/uU7ad44bwPt4FCw3ezEALR3LAAPO4CPlC+/mr4+ay6p1XONs721CBkd4NjFteDTwb5zv88QgrqGoFQqL61oMAjX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(478600001)(38100700002)(86362001)(8676002)(8936002)(41300700001)(6486002)(82960400001)(4326008)(54906003)(6666004)(316002)(5660300002)(7416002)(53546011)(6506007)(186003)(6512007)(26005)(2906002)(66476007)(66556008)(66946007)(6916009)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfQ49fbQ7UHHwwGSXM5iEHyBNbKlybpnEmDm88lV0iOxOnmBNPw+abhzlDiF?=
 =?us-ascii?Q?AMUMLoolVaEpNfZX80eDwgp6FtK9HWQzg2pU3+Uq2yw1LnDecCzsQvLruh0B?=
 =?us-ascii?Q?flS0gVEFCyWWmul4MAvTn7KaWSJmytwHi+E9ySEVxJeNyFh0cy0YkFWnUAuR?=
 =?us-ascii?Q?TWUqV/fQrbZmFYEAaCh3uaYmrONYIzS9wlOO9OaJfl6Y86A16hL0Oh1pQCPR?=
 =?us-ascii?Q?7AqcFfEv3Ve0p6OUc4grnyT1KNuBAW3Z81f06RUSmyqRmhUF0Co5rrIEAbQd?=
 =?us-ascii?Q?IUkQVpU0ZdJ5NDSvJNntGGSYV1ngkHVmW9HmRcN6+HglBByY8Tinn5ypDgK8?=
 =?us-ascii?Q?fGnIt8SihL1AkOxDtf2psrYWajuSwahq8FNo4QATikzybJSkaj+sqqro6Hpc?=
 =?us-ascii?Q?a7buF2rGmU98ej7ZO1umBFZvFR8fJmNafDY8C6iW6e12EB8q5mm9G3dJcdPT?=
 =?us-ascii?Q?sQYzcXvWMnpKRMrnHypqXFf2aELb+0/qMW4yRox0nu7pGnEDDfHIPTuis3Ul?=
 =?us-ascii?Q?ZZbAU6gyD9P43jbjVVGPIYkC6hFewoQNfwS5yzdPHKsLQn5R4iMO2fa/wtYR?=
 =?us-ascii?Q?aeqAjVuU6JiriyFmYcdMp5QScnBkqnqazRqQkJCerHTQnje63uapEY5OGapV?=
 =?us-ascii?Q?xchkVjDXWWQPirz07ZnjTXjea50O+OtgxIHZgbfF7+zrNAzi/N5nXkPN0QVY?=
 =?us-ascii?Q?QXhHw1xwq0ovcH9I7VLTWev1/VwxTK0ZK102KSB3CnTL10BMdIdrpX5u7bKO?=
 =?us-ascii?Q?Ueag2epfUiYKCPtLXu74XqsKsfprU329reG7/p3YofI9pdz6ADQgRFa4EQyQ?=
 =?us-ascii?Q?WBOQ9/2YWeq2k7t6FRfKf5Vm0r8avV1Dd0jlKFcH9yAR4L4ouv/fHQFST1Gq?=
 =?us-ascii?Q?e/Pc0VVVrkJbUdtWhdmjc/A2OQhm3XqY6Qcu89MH3ynlMvZ3v2YANWYW3v1K?=
 =?us-ascii?Q?D+VSEbhSRSV4gsfIj3RqvzUGZfYbq2Fpv60LBIfw0Fy2AcvuJyxxmuMOHG+p?=
 =?us-ascii?Q?nMxQvXI8qMC9xYrPSyLFNoE1bguWS6nTSomlBCLlURUNmJa0a6xdS0s273uY?=
 =?us-ascii?Q?PQlUYSMZyIgS/dUNyoIw9etlniYUt6K7L8RglOpJYh9eeafp+F1OWYw4t0v5?=
 =?us-ascii?Q?gEG15PTlpvc+YiIN43EBMf7RkaC/XmEl5LkE7xzncwRBdP/mDWT1e7qIlpQ3?=
 =?us-ascii?Q?8rQAl3qZjxub/qWjX2bV7d4TqY0yUa4BJma4MVcXPsLeT27ShMgqkhemL1gf?=
 =?us-ascii?Q?ICd4q3dx4f8nacQzRQWVF6RxRwXyzyxhWFlalJm65753pcStUFfQeAhhszJi?=
 =?us-ascii?Q?+t+SzYYkHhrRqE4me6yBDm7Y8Knf5wKdSazOI4qqFPuubaEj+YufcRKKQJVw?=
 =?us-ascii?Q?HV1fA443Jvt7EKxS1E7qm87yy1hMZ34H5ae0rzXLTQKes/9Ux5lGODjTBb2/?=
 =?us-ascii?Q?6JasNYsAX2xP3GB+QzSxWwcwYWdQw0WYD3eLROXIbZFZsIKDUyPCsNlZc7vH?=
 =?us-ascii?Q?Xkux4zKC/YUkJA5SCWzmci5ZTSoCKlyqNHIJpcVMgha/9PIWLmVe+wyPJdKk?=
 =?us-ascii?Q?JnMKV2DoymTVeETRp22T6JwqlQ7wGuaisjgIjg51?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c5f865-3a4d-4577-9425-08db6e3154d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 06:17:16.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NNBjx8p9WLa4DctaXaZeEDfua3dTDdxh/DpGIFuWwB38LmbwyiopPXGGPuq+FKYzvlFYZPrKkirgodt2EECFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4819
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

Hi Gautham,
On 2023-06-15 at 11:31:07 +0530, Gautham R. Shenoy wrote:
> Hello Chen Yu,
> 
> 
> On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
> > When CPU is about to enter idle, it invokes newidle_balance() to pull
> > some tasks from other runqueues. Although there is per domain
> > max_newidle_lb_cost to throttle the newidle_balance(), it would be
> > good to further limit the scan based on overall system utilization.
> > The reason is that there is no limitation for newidle_balance() to
> > launch this balance simultaneously on multiple CPUs. Since each
> > newidle_balance() has to traverse all the CPUs to calculate the
> > statistics one by one, this total time cost on newidle_balance()
> > could be O(n^2). This is not good for performance or power saving.
> > 
> > For example, sqlite has spent quite some time on newidle balance()
> > on Intel Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
> > 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> > 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> > 
> > Based on this observation, limit the scan depth of newidle_balance()
> > by considering the utilization of the LLC domain. Let the number of
> > scanned groups be a linear function of the utilization ratio:
> >
> 
> Is there any particular reason why this is being limited only to the
> LLC domain ?
> 
Thank you for your interest in this change. The original thought as you
might know is that our LLC has a huge number of groups.
And since SIS_UTIL has done similar thing for LLC, we want to propose
a simple prototype to demonstrate the idea.
> On architectures where the LLC domain may not be so large (POWER9/10,
> AMD), the additional cost is usually paid at the higher domains where
> the number of groups is greater / equal to the number of groups in the
> LLC domain and where sd_span is pretty large. It would be good to
> explore avoiding the scan cost on those domains as well, right?
> 
Exactly.
> > nr_groups_to_scan = nr_groups * (1 - util_ratio)
> 
> If we can extend this logic to higher domains, on a Zen3 1 Socket
> server with 128 CPUs at the DIE domain containing 8 groups, we can
> expect a significant reduction in the time spent doing
> update_sg_lb_stats() at higher utilizations.
> 
> util_ratio     nr_groups_to_scan        nr_cpus_scanned
> ========================================================
> 0.9              1                       16     (-87.5%)
> 0.75             2                       32     (-75%)
> 0.5              4                       64     (-50%)
> 0.25             6                       96     (-25%)
> 0.1              7                      112     (-12.5%) 
> 
> 
> On a Zen 4 1 socket server with 192 CPUs at the DIE domain containing
> 12 groups, values will be:
> 
> util_ratio     nr_groups_to_scan        nr_cpus_scanned
> ========================================================
> 0.9              1                       16     (-91%)
> 0.75             3                       48     (-75%)
> 0.5              6                       96     (-50%)
> 0.25             9                      144     (-25%)
> 0.1             10                      160     (-16.7%)
> 
Thanks for this information, I think we can extend the scan limitation
for not only LLC(MC domain) but also higher domains. I'll think about
it.

thanks,
Chenyu
