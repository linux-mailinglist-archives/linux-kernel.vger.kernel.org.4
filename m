Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF970480D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjEPIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjEPIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:41:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D63C01
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684226511; x=1715762511;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IQ/BywgpWPSlVGVBO6xfjb18Ebn7WIRzh6u8Mut5n/E=;
  b=QAAkpJ4h6PktD41lBNLgny7zZ4ep1BRZtl1KhGdo0cJibK0DhiYFnU9T
   oSIwMJZMgqFpMcRSxyRRXEUaXCNOn3XzPbjrIqxNaCymHRgipf3g/eXD3
   4zJ5OJPZFdTPZ0R9De/OCKzFlbBIOzZwIltncddwTOe+1e8SuGZ5gieVA
   tqZZxcA7R2q1V8VFjgiIxCcNpHP18jOj9Do+nG1oHujRjjUA0T3lkI9XV
   bG4Y7UbN747C0m1kpOCi4dBd/WCChNdd/Bxmgyl2CQhg/AOv5KO8D8c5Y
   Q9bf6mOaGMa4AiD4xudqh22VfixzOcvvUT+a0w6GXXlGXRJXqmlrKhWio
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379594767"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379594767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="678764885"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="678764885"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2023 01:41:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 01:41:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 01:41:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 01:41:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6YE/HxZjFAapzdcHCNz89WwNyEAr3vNrOpINkaH5f0F+26adoOWT2QmA3WQ+HIidfACQ2fyXz9jBiM6nGRfWLirDJMQuXXbpEMLgkzN5suDjdxv3YfsrBuqx2ItuLXIs0XfC6WbtPB/8N4trJScxPYR0b6pZTnWt2zWIa+pzNYH6Q/JY2ysw+ElT6SFR51HuCpwStEw2HHLTXeM/xSrLQvm2m7IQUlaBapT6IWWhaeBCocWHdpi5J1edodJYubym8KqaI73Fe40knduI+lVcokgYOkl5KPaqrX1g4UYtW25Inf8DdloMhiZ6TrOrpWJflLA6VtVmOZljIV5c0rDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRpaaK+iN3yzR7ZmaaUe4Pkd3ZoclK5BHTEktC6VUo8=;
 b=FFZV5bsJO2Fs8lWVLsvhkRqdEKz/t5RvBdPW1wVsJwHRE4Rg9x90oVBVxScQvXeaKcgaiYbmRSy/7kl4raUsYFooWGYNzaXOnnBkBM0XR7+kjm0TWVUuW3Oa7JBtlZxV0CRUbPZXkjJFc8SvZ6dHELOZLGMArXsOL4l1nV/CoELh3Kk8Vb0WJdqtmPhGN84NUBYcaoXX0/kF6ViFxr5ne76OCtJP+xubExWtOuoS5Hu/duC/uvJH+8fnspNczZfRalbSfbeSR6y1mB9Fuq8PP6ErRwDvlsxAyMtc4QBDpzYekr+7dH7byNFaetI8jyOXhTZhOZ8gepzhDpTmVODyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:41:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 08:41:47 +0000
Date:   Tue, 16 May 2023 16:41:27 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Abel Wu" <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Message-ID: <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6b660f-1fce-44e3-6467-08db55e96243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmczo+1MDA4fHc971CWYCPkCrtFCXGS6vYt0TnN7fYSsQF1NT+oFU8KnbB916OcaIinQ35PVsB+63Wx8VVXfXLLK/Zbnw1S0WbzaB82IkiZEHD32lq+3suwKAaZOEhRUnDAEckHMX2iE+uCaPQ4103kakXtzAjlNkwUSImSTLZ4xAqefAmJTwwMNowkl51guVozt1/4JVf8JbVLnphsxPydxDgMIU7g76LdNNMyVlWYKSM/0lEGr1Dmm2vTOMkCpmorqsIi/CjiFc27YzUHr9YG8MtZ/DjNHIc0PgkwsEJvWbkZ14HBu2jpgS43S/zfIHbeTDqTo4MGeqONaPbDfR7A/4caaThsiSAw12G/3nGYh2kg9t1VslCsXasKn88DUV36VyJXosn3LcXKqV6eotTQotzWPLwbpujENYvwxqRqEjlYT7RlXEv2Sm0geqYFvvn1AfaOUmganMA6W+wnJRU7IyCQgnVW1clwDG9ID/o6VRdZ4i75p2MQR/EQR42IYRvEEoG6vdQb6mQKyErxPQb7L2Cdmlt48BqtMVfaMg1CS3ybcfqOqmcbjI2ZkxcSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(5660300002)(41300700001)(83380400001)(2906002)(86362001)(33716001)(82960400001)(38100700002)(186003)(26005)(7416002)(8676002)(8936002)(53546011)(6506007)(9686003)(66476007)(66556008)(66946007)(6512007)(478600001)(6486002)(6666004)(316002)(6916009)(4326008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aEllmXGVPvIruvE1kmMXfR36YZCKDfXw0fDIpYSmpB25g2aLW8fsHDC7ds?=
 =?iso-8859-1?Q?FR1AB1/aOYv1WL09j/0JvQHRI8pqFBZ8fJ7pDrtzt+2+EIBrhaUmcr40fv?=
 =?iso-8859-1?Q?7mp1pvXchSwCQgMdGPtIn/guMVZt8IIbwywcS5pQnPfRLPjNCb3a0zgHpu?=
 =?iso-8859-1?Q?qn4j9dT7WcsX8Zpuy5u7qm/0qbHVp8WA07MqIyrjGfmFdLR811WKx4vZB7?=
 =?iso-8859-1?Q?joJkRevjNWxuWEu0i6SaRevfvDMF92PDe4S8P5cvhoTOXz0Y7ok7CTdkU4?=
 =?iso-8859-1?Q?yeHd9kz1Cd4oktYRb+s5cTiF8Hrea4MFuLxKUw9TPalG6/XEoWLiPi46f9?=
 =?iso-8859-1?Q?weDtmvqkfcZBentIawZ1RxUs6y4rtW0DdavkzNSY4tOOpYoCjqzWI+ZdKs?=
 =?iso-8859-1?Q?RFeEiTXHd5LxMj2SMkf6vr041KP+BgFcn+9iVMGmlDY0mE6XsJk6RYtkcq?=
 =?iso-8859-1?Q?ERMD57tqinmdf0wKYCYsl7IUL4eyxx4b3W01deFLec7TUK9GKGn1iXbAcm?=
 =?iso-8859-1?Q?zVkc1OeTh44lOVVXij/fzWpmiDdanJavgeyiLdAQqfp5q9APKh3KTLGzfC?=
 =?iso-8859-1?Q?xAtTAExSYJ8aaFG1M4rnb42IlogbFIPd09W5t2BzonRQkBvtevz/Z+K0AX?=
 =?iso-8859-1?Q?aFgcm4UtmGabYRxjl9Y05sTJZqkbadtdAbG/DFg2d75VHS+2LX6mWLtJim?=
 =?iso-8859-1?Q?1MS8cc/yj9aVBpvmnpVVuG/3CH42e/sOYRoEWn+vFYNn5MQok/yM2fzT4Z?=
 =?iso-8859-1?Q?Nbtdxa34BEyEylzB9i5u+sY+zwhMAZWfhOIu2B1IriZX6ltBc+u2vutyPp?=
 =?iso-8859-1?Q?LzghqTckrUQ6AQfeutSZtHyGQB8fcfJFt3e25LYt22IATHWXpkOjaJXx0J?=
 =?iso-8859-1?Q?ojArOCHzupAC5KY3ZTinfYykeb3CchpJiPJCzKmL/Nxo/g5gQmoWXLk9nw?=
 =?iso-8859-1?Q?qodXy+Vso4dqtGUKWWzEFOeJYSX2/tNNvxThOOiLbeZME4eksHS5tB7rZC?=
 =?iso-8859-1?Q?R/ETYcgk3w3rgj1SY/r7L38SFIyWi5c2q9g67YcFH9OEuWX8JRRt8W9rKz?=
 =?iso-8859-1?Q?tgZQVi0elPr5ad2cfRjXtldOwl6q/r8iXznPK+TTkB+umRDySAqwg1sU7p?=
 =?iso-8859-1?Q?auNnaQisqN7Mz1uot5Jls+ROGOlv1itCYmiYBnfL9JyemIG4gSiWcPCkz5?=
 =?iso-8859-1?Q?NrRv4idYSrU2a1bKU5kTMK0SvRR3WO+/aP4ez9fIym1AVl4pAXawUoYNbJ?=
 =?iso-8859-1?Q?Z1yKHRGLcPbQCBQK7suHdMt+MxiE7mD8DLWjERLflhIqeChL8Ddf4GUzU/?=
 =?iso-8859-1?Q?KKJ/jKWhs2gJSwRabENKfxet4eC16u6Eoekuyn4UYgtR09QHDbfDmiDsze?=
 =?iso-8859-1?Q?u6kPEntcAry1BpzOLYLv4kVjvbLSlDzBhz28q5V5IPKzDfis6LnnXv3ju6?=
 =?iso-8859-1?Q?ESx6chUSRE7W/h/JQrRSriNN/pJQVeSrPJifOgXq/ZfjHS4QY/WmYV6A08?=
 =?iso-8859-1?Q?DreONNJAdHhup8aiEzFWobdiBgY4LVlPrWAX0qCmHGWztfw3rDQMJF7Uhv?=
 =?iso-8859-1?Q?clKXHNrAj7XG0LI/ZZtQ/e75Keu8p2VMK6SwSgBznyCb4NZ1VHsxc74Dkd?=
 =?iso-8859-1?Q?1UndWcLhGyi3CeUXGT5WKZi3yDOUNqY1RZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6b660f-1fce-44e3-6467-08db55e96243
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:41:46.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsxPSPyyjxX4YhtraoAysHhjanorrx3nObFbJKz8NAYuJhBjU1zOrYmnoXmub5Mqlv/quBuovHfajRto1egFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
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

On 2023-05-16 at 08:23:35 +0200, Mike Galbraith wrote:
> On Tue, 2023-05-16 at 09:11 +0800, Chen Yu wrote:
> > [Problem Statement]
> >
> ...
> 
> > 20.26%    19.89%  [kernel.kallsyms]          [k] update_cfs_group
> > 13.53%    12.15%  [kernel.kallsyms]          [k] update_load_avg
> 
> Yup, that's a serious problem, but...
> 
> > [Benchmark]
> >
> > The baseline is on sched/core branch on top of
> > commit a6fcdd8d95f7 ("sched/debug: Correct printing for rq->nr_uninterruptible")
> >
> > Tested will-it-scale context_switch1 case, it shows good improvement
> > both on a server and a desktop:
> >
> > Intel(R) Xeon(R) Platinum 8480+, Sapphire Rapids 2 x 56C/112T = 224 CPUs
> > context_switch1_processes -s 100 -t 112 -n
> > baseline                   SIS_PAIR
> > 1.0                        +68.13%
> >
> > Intel Core(TM) i9-10980XE, Cascade Lake 18C/36T
> > context_switch1_processes -s 100 -t 18 -n
> > baseline                   SIS_PAIR
> > 1.0                        +45.2%
> 
> git@homer: ./context_switch1_processes -s 100 -t 8 -n
> (running in an autogroup)
> 
>    PerfTop:   30853 irqs/sec  kernel:96.8%  exact: 96.8% lost: 0/0 drop: 0/0 [4000Hz cycles],  (all, 8 CPUs)
> ------------------------------------------------------------------------------------------------------------
> 
>      5.72%  [kernel]       [k] switch_mm_irqs_off
>      4.23%  [kernel]       [k] __update_load_avg_se
>      3.76%  [kernel]       [k] __update_load_avg_cfs_rq
>      3.70%  [kernel]       [k] __schedule
>      3.65%  [kernel]       [k] entry_SYSCALL_64
>      3.22%  [kernel]       [k] enqueue_task_fair
>      2.91%  [kernel]       [k] update_curr
>      2.67%  [kernel]       [k] select_task_rq_fair
>      2.60%  [kernel]       [k] pipe_read
>      2.55%  [kernel]       [k] __switch_to
>      2.54%  [kernel]       [k] __calc_delta
>      2.44%  [kernel]       [k] dequeue_task_fair
>      2.38%  [kernel]       [k] reweight_entity
>      2.13%  [kernel]       [k] pipe_write
>      1.96%  [kernel]       [k] restore_fpregs_from_fpstate
>      1.93%  [kernel]       [k] select_idle_smt
>      1.77%  [kernel]       [k] update_load_avg <==
>      1.73%  [kernel]       [k] native_sched_clock
>      1.66%  [kernel]       [k] try_to_wake_up
>      1.52%  [kernel]       [k] _raw_spin_lock_irqsave
>      1.47%  [kernel]       [k] update_min_vruntime
>      1.42%  [kernel]       [k] update_cfs_group <==
>      1.36%  [kernel]       [k] vfs_write
>      1.32%  [kernel]       [k] prepare_to_wait_event
> 
> ...not one with global scope.  My little i7-4790 can play ping-pong all
> day long, as can untold numbers of other boxen around the globe.
>
That is true, on smaller systems, the C2C overhead is not that high. 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 48b6f0ca13ac..e65028dcd6a6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7125,6 +7125,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >             asym_fits_cpu(task_util, util_min, util_max, target))
> >                 return target;
> >  
> > +       /*
> > +        * If the waker and the wakee are good friends to each other,
> > +        * putting them within the same SMT domain could reduce C2C
> > +        * overhead. SMT idle sibling should be preferred to wakee's
> > +        * previous CPU, because the latter could still have the risk of C2C
> > +        * overhead.
> > +        */
> > +       if (sched_feat(SIS_PAIR) && sched_smt_active() &&
> > +           current->last_wakee == p && p->last_wakee == current) {
> > +               i = select_idle_smt(p, smp_processor_id());
> > +
> > +               if ((unsigned int)i < nr_cpumask_bits)
> > +                       return i;
> > +       }
> > +
> >         /*
> >          * If the previous CPU is cache affine and idle, don't be stupid:
> >          */
> 
> Global scope solutions for non-global issues tend to not work out.  
> 
> Below is a sample of potential scaling wreckage for boxen that are NOT
> akin to the one you're watching turn caches into silicon based pudding.
> 
> Note the *_RR numbers.  Those poked me in the eye because they closely
> resemble pipe ping-pong, all fun and games with about as close to zero
> work other than scheduling as network-land can get, but for my box, SMT
> was the third best option of three.
> 
> You just can't beat idle core selection when it comes to getting work
> done, which is why SIS evolved to select cores first.
> 
There could be some corner cases. Under some conditions choosing an idle
CPU within the local core might be better to select a new idle core. The tricky
part is that SMT is quite special, SMTs share L2, but SMTs also
compete for other critical resources. For short tasks having a close relationship with
each other, putting them together on a local Core (on a high count
system) could sometimes bring benefit. The short duration means that the task
pair have less chance to compete for instruction unit shared by SMTs.
But the short-duration threshold depends on the number of CPUs in the LLC.
> Your box and ilk need help that treats the disease and not the symptom,
> or barring that, help that precisely targets boxen having the disease.
> 
IMO this issue could be generic, the cost of C2C is O(sqrt (n)), in theory on
a system with a large number of LLC and with SMT enabled, the issue is easy to
be detected.

As an example, I did not choose a super big system,
but a desktop i9-10980XE, launches 2 pairs of ping-ping tasks.

Each pair of tasks are bound to 1 dedicated core:
./context_switch1_processes -s 30 -t 2
average:956883

No CPU affinity for the tasks:
./context_switch1_processes -s 30 -t 2 -n
average:849209

We can see that, waking up the wakee on local core brings benefits on this platform.

To make a comparison, I also launched the same test on my laptop
i5-8300H, which has 4Core/8CPUs, and I did not see any difference when running 2 pairs
of will-it-scale, but I did notice an improvement if wakees are woken up on local
core when launching 4 pairs(I guess this is because C2C reduction accumulates):

Each pair of tasks are bound to 1 dedicated core:
./context_switch1_processes -s 30 -t 4
average:731965

No CPU affinity for the tasks:
./context_switch1_processes -s 30 -t 4 -n
average:644337


thanks,
Chenyu

> 	-Mike
> 
> 10 seconds of 1 netperf client/server instance, no knobs twiddled.
> 
> TCP_SENDFILE-1  stacked    Avg:  65387
> TCP_SENDFILE-1  cross-smt  Avg:  65658
> TCP_SENDFILE-1  cross-core Avg:  96318
> 
> TCP_STREAM-1    stacked    Avg:  44322
> TCP_STREAM-1    cross-smt  Avg:  42390
> TCP_STREAM-1    cross-core Avg:  77850
> 
> TCP_MAERTS-1    stacked    Avg:  36636
> TCP_MAERTS-1    cross-smt  Avg:  42333
> TCP_MAERTS-1    cross-core Avg:  74122
> 
> UDP_STREAM-1    stacked    Avg:  52618
> UDP_STREAM-1    cross-smt  Avg:  55298
> UDP_STREAM-1    cross-core Avg:  97415
> 
> TCP_RR-1        stacked    Avg: 242606
> TCP_RR-1        cross-smt  Avg: 140863
> TCP_RR-1        cross-core Avg: 219400
> 
> UDP_RR-1        stacked    Avg: 282253
> UDP_RR-1        cross-smt  Avg: 202062
> UDP_RR-1        cross-core Avg: 288620
