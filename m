Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB05686648
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBAMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjBAMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:52:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9974672E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675255967; x=1706791967;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=chmq5GSMv8KEzG3t3zq2Bl2YFz2OnecobSfPb6HbS5I=;
  b=QWWx5p3jF/Zj1eYe0FAwuz9bL3o5qd+6Ac+gadGXxtXTCBUCeIxzYqjH
   H/Y+9ubv7uuvMhKOV8sDhdX/INIAKKbT5pa7aewlkql9Pf/2itZgwMdux
   zRyJ5Xbdaj3XRi9JXnZLJpjK7Pwy0Zmq4xeXYGAuUji9nVIHlK9eG1wgn
   mpzWsUeeVEC1dsf0wf7LSYqBacjVnPlTkbcfmAu1GVSR3PuiBs4vvzQ8Q
   DwD48CmbcoJ26bJGrPjt3T+OIOFEO/A1zY3yLoRyfEjmy2e3ackToJNhS
   m4LQqiw1VWYwFAjWTH9AH+iZ6eOPToAXAp9TPy0o6G45eicfu/oH3O7dM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325833639"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325833639"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 04:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="614843470"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="614843470"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2023 04:52:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 04:52:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 04:52:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 04:52:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AemKLdc8KgX+2IpZa8Wq844HVAZDpQaqRlULSCgolAG177TMTcggqZkfJa34Pba/B/PwWr5VZVAebnpNDRynrjDwLsGwcXgvob7er5gDh1U2UGH4TZT2IKPecxlA3jDazK9Q1SpBNLYtg5CxKsa5Skv/4ty3NHyB/BiAbYMDTu+V/C83YI6TE3p/9pqbsbcj0ZNusVE2pVzxQ/wesicT3yvcpR/cPa8K8G1RkWPXnQDkA9osi+hZjZ0xWedi2Nr5CFA7qTQxW0bCQNQ3C3GvQpEMfbZK3EURimZ49Fc+L5vhD+114enJ/r9Ev/8mcfD5hVdtU3aLEQFhT08s2m5SdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85qVhq3zW8+vttFJpT3WioYwcRGfNXJx4X/CpZhsBtY=;
 b=YRKCL677T25FOjH9OR3d5qmd5uxARYDetBLzFgbpVFwBAPetevS1UuWmGDehuZ8nJNlSw2RPC2msVxIiLT2+Vod9HCRwwh9yRkZEFh4t4HBNHfuxnl7uu16xTRSL6Z+v4eJ8yXkEvGKiArllOFsA2C9vDNG3/K+2SX+Bh9Q7SKFExTQrB9ezbWZphxvMhV9XR3gW/5SSEHqsjI8zpPPHU4+x6VZ2dOCgpaMoB4z0z4p1rSCqiHosbXf+1ZhuxLmoZ+kMz6DMmWCvkydyEwTMxviE1DTlAKo1XNnXPk35wRhEmzUHVuivMLikDeGk1VIEGsrKehWVLWQbqH7DXs4low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB5886.namprd11.prod.outlook.com (2603:10b6:510:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 12:52:43 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 12:52:43 +0000
Date:   Wed, 1 Feb 2023 20:52:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9pgitjZHTkbssxV@chenyu5-mobl1>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
 <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
 <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <Y9iJLQxyXp9+x2aF@chenyu5-mobl1>
 <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtDUMph262w5OSiSQi-BVcNRf2gN=PdmxYCKEuk-8aYhgA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtDUMph262w5OSiSQi-BVcNRf2gN=PdmxYCKEuk-8aYhgA@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8e1256-d49e-4562-dfb4-08db045335af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru9XiepzCsvNAvRhVjO/KnvhxQoHYK3Wqbee9xprZEEDcmqlhxhrhG1YhJePF8dudj91S3XpM3ASF5BGxu4DrVyS0CsciKTqWCSASoqq0n30rA/j9JZQ8q6rLWSpvYlc9jOcw/r84YGtDPo8FUkX7d3LBceI0mfiqUdwZIhAHqkDxeZ929jKo4PX/QC7a1LzB6F90BQfViXQtlVvB/gXVTRuPpxZw4OPLniHw9w6Rzji2oXzMuHYyrQYvZZwNScfgA6gHEjQ++fbfpNjM3t7p8JSIioGZfxwe67NPfTq752v1h1+Fs2nTLHh6tihpJ11VJqN0eXskfnD95QSPphoijw/EG4t+m2p4OKvBmYV1KuPi3yzS7ddRyPvBq2IsvIPQT7Pm8yi0JNAh9w+k5S+8j4hPagTzgfNEXJzatSH4cWiqW7Qu0PLMGPiF60kKEddU3qLAD61H0M54Xrc+bL9IXsicdJDWilqkjlKbY6bT9fBBAcT93fn14QGyWMEF1kWOUYaPy5GzYlnCVUtEaQnl7oUkHfBp/4PC5xEKO/omtBHniB+XU1QRvePvFza1M5BEmaU3+C1SfRkqxMG3QIeylXkMiXI1GqpVqeOCnlLX7ssjYHDVQLpZ1tUtqh2XpkbTmyPc1+UFARjkNha29X5iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(41300700001)(66946007)(6666004)(83380400001)(86362001)(82960400001)(38100700002)(316002)(66476007)(4326008)(66556008)(54906003)(53546011)(6506007)(6916009)(9686003)(26005)(6486002)(478600001)(33716001)(186003)(8676002)(2906002)(6512007)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxN7FMTtTYW6XWLFEsFgK1SDUUuwrspVen8Ggk9MgPmkdkfrxuGZY+/zlbKv?=
 =?us-ascii?Q?sIcD5JZGNDUu5qYxwaSKvWEhyu5I1Pe3mWxUmIPXvdv6Js9qCs6lOhgI2L1T?=
 =?us-ascii?Q?NNXFt4ioe9wcRpjgaON70ffz815M1QbHQFhWyuCtwKIHmlF715FT4h+s/Mpj?=
 =?us-ascii?Q?9ZL5O3kcpy+V1y41+yfPbi0uxOypKaZNHZZU03Ewztmi/0mXRNd5YVzaPp2g?=
 =?us-ascii?Q?TjwHjHrg7qppQhz2sEKW/htN5ECLSnJOsKVIpKI3ecOYR8MBA/hC4ySy+JU9?=
 =?us-ascii?Q?BoBXti6CtEYkUMqZaQZ8261CmPVEmDLTiLyf3ZVKMrblw2qWk37t01nrr4OY?=
 =?us-ascii?Q?ZYF4WyI7u7Ob9WHp4EHpeQuwHZc29xGyRrya5LqMACraSYWkG0KRnODcoYbl?=
 =?us-ascii?Q?N8t9YB6zySeujs/qXmVqRwoddIyVy07xsjkS5iZogdYQoL3YQnxqvcK3nzyX?=
 =?us-ascii?Q?B26JHLGwnoL2a0oh+UzJ3F2tUrAWHuUX6EbaE10p2qP7FETTKymW9rIwbW5t?=
 =?us-ascii?Q?DdA9PTzDT9ahMcwkZ6pAFSPT9yKp67dOxtyS92Yyr36Ar5AxZ9tFGS19L2aK?=
 =?us-ascii?Q?/6AsKKEPngE1gMq7IbocjKFkweK55g/NAZW0ECj59CGmZy8cNvCBzpbHK2Jm?=
 =?us-ascii?Q?jZWKbguZD4BOF2PYlqVs2Xi/VltNHaL7hGUwQyCxNCktzkpxZLX7R6yxo7zv?=
 =?us-ascii?Q?O5SZJWdZPVtYRrJYMKA8x1LREMhY4/f5AyH2smq6yrHQcgfl5e1gVRWmP3b2?=
 =?us-ascii?Q?op7MaHWbt/9cJMX553T/ge2pgorbPhdo2FY9EAnT7rJoK5vWSQSqFlynEMqJ?=
 =?us-ascii?Q?yqi10p70zmbhgABF6nyRQAeyffPGpZxtNUanRXovk9/8CjSFhZYW/L1m/Y4y?=
 =?us-ascii?Q?l1pwaptPe8uG3eQA18RPjkpH7mdkMKrUlMz2b31lfYFYlATxRr9+aNzI/3nc?=
 =?us-ascii?Q?u7mOwpGdsPPtA3MHdqsvilP84qedwAqd+tI1Bw8Ay4fiiloLXvoDB/I9gtXx?=
 =?us-ascii?Q?FOv92/Db5bVZvrBKG9xYnpgiGvrGJ3hS6YuiCdDYW1NGinRDZd/cPnQiAm8y?=
 =?us-ascii?Q?v9P700n/nlUhKJMAmdHUkQolNLdN5KB4cTY+Z6DwdNhxTDSV8ZvJWEyId5HC?=
 =?us-ascii?Q?EXJL9ICtgw5eAOERmlQBR1vLkeeusTeyWG0WmTWHytM4QvE/KmPYZf8C5ET/?=
 =?us-ascii?Q?Yuc94mdVKIFrwWORkPJndWR7dz6B0NSpxoRONh3I1mSWxsumVohtYjoyOz98?=
 =?us-ascii?Q?pf+4AyygQFB3LETJJ1tYUkAAwYVOgqmEzFUzEJ/hbl1qEQos1aoZHOqJOe8v?=
 =?us-ascii?Q?N7PdH/SpKauK3mMdnzT+sObaeYlqS+ONM4ubbKtglKQ2JQOSmhVzN1AeS0FP?=
 =?us-ascii?Q?4U6X8Ya51AOmBueEGi+J2I9sHZ3CZIgaWIp9IJbDKsIOOyW/4T1kE77yc8Ar?=
 =?us-ascii?Q?rKhe3OR6/Wyn4ElDTLpDPVFBZC+4/geLycDjTASDaxry3pZ2OSOQtziCbh+g?=
 =?us-ascii?Q?rnGF+gpzIyu2avqnOFvLqH4jPsuFzv+QQEHIKtCO8p5XL5UUzoQL+P7bojy3?=
 =?us-ascii?Q?ywKUBGP3GhRxvpVA4zOj5ec/xoOwDD5riFKRi69A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e1256-d49e-4562-dfb4-08db045335af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 12:52:43.5071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqsS411nyday5Plv/bpoBzQ8a7tQOeSOZXjVA8Zh8eTRc+8da1tHlR1sI/7oyXMdH2wWYaVWn3pFZzA+y+860g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-31 at 12:10:29 +0100, Vincent Guittot wrote:
> On Tue, 31 Jan 2023 at 11:00, Roman Kagan <rkagan@amazon.de> wrote:
> >
> > On Tue, Jan 31, 2023 at 11:21:17AM +0800, Chen Yu wrote:
> > > On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> > > > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> > > > >
> > > > > > > All that only matters for small sleeps anyway.
> > > > > > >
> > > > > > > Something like:
> > > > > > >
> > > > > > >         sleep_time = U64_MAX;
> > > > > > >         if (se->avg.last_update_time)
> > > > > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > > > > >
> > > > > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > > > > others were suggesting?  It appears to better match the notion of sleep
> > > > > > wall-time, no?
> > > > >
> > > > > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > > > > but that should hopefully also not be *that* long, so either should
> > > > > work.
> > > >
> > > > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> > > >
> > > > Another thing to take into account is the sleeper credit that the
> > > > waking task deserves so the detection should be done once it has been
> > > > subtracted from vruntime.
> > > >
> > > > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > > > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > > > maximum credit that a waking task can get) so threshold must be
> > > > significantly higher than 2 sec. On the opposite side, the lowest
> > > > possible weight of a cfs rq is 2 which means that the problem appears
> > > > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > > > value instead of an arbitrary 200 days
> > > Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
> > > 1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
> > >    'vruntime bonus' when enqueued.
> 
> This means that if a task nice -20 runs on cfs rq while your task is
> sleeping 2seconds, the min vruntime of the cfs rq will increase by
> 24ms. If there are 2 nice -20 tasks then the min vruntime will
> increase by 24ms after 4 seconds and so on ...
> 
Got it, thanks for this example.
> On the other side, a task nice 19 that runs 1ms will increase its
> vruntime by around 68ms.
> 
> So if there is 1 task nice 19 with 11 tasks nice -20 on the same cfs
> rq, the nice -19 one should run 1ms every 65 seconds and this also
I assume that you were refering to nice 19 task, and also the following
'-19'.
> means that the vruntime of task nice -19 should still be above
> min_vruntime after sleeping 60 seconds.
So even if the -19 task sleeps very long, the cfs_rq->min_vruntime can not
take the lead, the overflow of s64(min_vruntime - se->vruntime) will not happen. 
> Of course this is even worse
> with a child cgroup with the lowest weight (weight of 2 instead of 15)
> 
> Just to say that 60 seconds is not so far away and 2^54 should be better IMHO
> 
2^54 could be the "eailiest" interval that could trigger the s64 overflow(because other
weight > 2 will not trigger overflow when sleeping for 2^54).

thanks,
Chenyu
