Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B20614B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKAM6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAM6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:58:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789781B790
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667307526; x=1698843526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ddZKtSz0qPK09c4NO4lTIrOGMK6IssNGJ6GR6AzhVAs=;
  b=SSu6pBwVoKSjyUYe2pBvycg+Rj1C5/BKjzV36UEMtU/hy+2uW8DRBGnP
   ul/dHbeutMLCLcjxqvh4cgsplCrTdRtQlarcj7aDRIvixhUmzcY8/iZqY
   oHlsxOAMlzo/LW9oFFQG9Cx9rTICXyLw/49HfqkqzD6awp6kLKnoHFyeY
   W9P1Hzy1FRYrPpq/KYwdSb0YwvArOkph3+swGf812e6eL2RQbwx2tN0ju
   wTuwyDWJ+xJUuoChX1MP2lUxFG47qLu1Lxoa8nb684dpy82Umiz68avIc
   Y3DcgBihXVHs+q0DEqKbU5PuftlZFbAzsXDurDc+etuVw3V/zqhefepU2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296554889"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="296554889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 05:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="776484329"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="776484329"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 05:58:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 05:58:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 05:58:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 05:58:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 05:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPcVqV2dgAOD70kbmDsOiRF/wa87cRyAoFUeSvcpYvFF9QLclqCsnO5VJOPlHch9OAsg18zmVdI27LRZABrQtxr2w6u6N5fubSaUSgQLM0fVMb3zprxGmqFwHEMZq9B3G+yPjV4fynCNpCIlcf9JWM4wsJkhpir9M1ztBS5sLVKKUyoNYPClEcxDb3Y8sj1Z7YLaYO77VkbXOInOWn1CWl7AJS1/z40Lv9R/vVfolbU42CwK757kIotDPG2d8ZmeIBPEDcSdnMsGLKvyD6Z9P20n7nUKS39k1Z2vzcvqO2XxSQWRFVUhvwmFGD1NRg9CJ+8LrTbUwax//4ZvjKMQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B4k8V1j3IGpp4XLDQOCmcB8+LBTnv9k9MJ7S/M1pBU=;
 b=L8A3SYX+XMSyJJProM5uSFqmYm4AyZgne7KPJLeQLcDLdgJsGkyDp4WWLY8gyxUMeHOItnCVLEHQBas2NmuqAvik1czAZclFoDS33OF4RkTJs2hFVstZ+mGmQ9Fr5mBg6ugzvolPVIqkDC9hmkNBxdlGLiVx/lgD+gVa3outOpp+YLThx1NRa6A2Wlkr0CUCIW+UHJaPiBMKNpaetpwyqui+Z9oJCsiKZqaNtd3rYCB1q7XDk7heGGvIobucmffS7DMTC5fQbHbZQC2vvXJ1rrk7a1BAeT1MIgzjg6ckKynriUfsIB4X0TLn9Y+RIvlO8AaoWR5YH2j7dg6glz19yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB6193.namprd11.prod.outlook.com (2603:10b6:208:3eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 12:58:38 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%7]) with mapi id 15.20.5769.018; Tue, 1 Nov 2022
 12:58:37 +0000
Date:   Tue, 1 Nov 2022 20:58:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mel Gorman <mgorman@suse.de>
CC:     Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, Andrei Vagin <avagin@gmail.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
Message-ID: <Y2EX7MlnK5rKT5aj@chenyu5-mobl1>
References: <20221027202603.670616-1-avagin@google.com>
 <20221101094157.a3gh2ko6otaa6cyw@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221101094157.a3gh2ko6otaa6cyw@suse.de>
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: a74b523b-7623-44f0-08fe-08dabc08cad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhqOw6gIRH/e6E3GA7MYifV/eqEYgRmorKMOWLRm97y6joOfUE2bQU2uc7nImIdvA75T4MZyQ+5hoon6SQIIfLlOL+3u+bwKe/Q+JLrHMYjZrhj1aicVt8yCYXdZpolaM5nHsKxxQYG1bsSCvd2drGVdWSrXtCoQgia5md5YGQcMR0Wv38AcDS6Zy3CNFho4v5VKpVaRqcO1fg683qnmfLH4Iv0cL04xw4aF83P9jgzBHAHv2n6a6gjp22JqWBT/zqs3xrOw9e6WwJTdB23hfvBZP6nSS5Ebl38ecq+pE99cw1sypIkkwEP3YM5wy1fmFOGqFh1y+rmYA1094ZsNe0cAvyZHWMjp+2f5kMctaaVOTXPUy12NQDs6Ndcdgo/CPA0INev30J7JqPyHVB93ogBEpsHn1l0647jd1x1l595ccZ8QyVNN0sVGzWffUcaThf176QHIKSG+z0ZAP6+8kY9wKj/DoXNe8w04YxtFHfTFh8hwewTAquQiI1GaxXMaN7ZUIpn73SsedmFV97sHbJkDi951f+AzAuYmtyTsOqOkFb0IVrExp8YuYeUK91+7Gr8G9VxZdRXRyy6i+EQjap6YfnHT5+lN3cNe1ZQEbgVkhhQtu2W/0abVBlxjIY4Jc0g748IEpfHHzfrkvh3ukCz0K8htFTlS0fL63NJTME64gGvGUIHZl6urFgNQ9sesIW59nTlO4Xe7rNkp+oNZ3oXPiAdlbspAREoxTCeOOUA2x0yQSXg/rijWAFfAtNMQzPxMREq98RGk3WbQzpvFyIasRVOciyoH8If8qcd2Y28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(966005)(6486002)(66476007)(7416002)(5660300002)(66899015)(478600001)(6666004)(316002)(6916009)(54906003)(2906002)(66556008)(66946007)(8936002)(6512007)(53546011)(9686003)(41300700001)(26005)(33716001)(86362001)(8676002)(4326008)(6506007)(38100700002)(82960400001)(186003)(83380400001)(37363002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJ7dqYqqHCc6LjMpZYDNzHmulNoePcf5Hz1/Lo2c2TpM+j/hSzv5nt+2cAT/?=
 =?us-ascii?Q?+48PdH6elw9c5gk330v9kxsPnOusriQ5fs/ZaW3wJITAKp9BGfTT8YR6k82l?=
 =?us-ascii?Q?aJV7hr9NfFhDiqMygPzLP59m8/uYYbKPcvHHMHAuhrt/KlLa8rrJu3eSuL+K?=
 =?us-ascii?Q?6lAH9j6fw0AHLcmKFCoG84qMU1hanCW8keUW9jNUXDNVW1t4AFdJ+rI8mRK7?=
 =?us-ascii?Q?bhbQezfQGYdWY6kYAo0M5KGxt9P6U/iDW4fi7pa99HQK2prIYdFp2RqNQmAX?=
 =?us-ascii?Q?AKQMRxYy4sFwLGz6mjo4tHGNdwxU560dHhP6HQ7s3NDKMX2Xv6nFSQTSSeyM?=
 =?us-ascii?Q?d2DmJ1qxhyOuWH7ia1P+O9FgGbEQYqr6kYyVyqWTpV24Eh+OICOprFUIlW9J?=
 =?us-ascii?Q?lOdDLm53UCHQAEEmK32LkVqAVkb5So3nH0IT6xv6HFcZFfnmMbnI92LlHSgz?=
 =?us-ascii?Q?oTDeFuziCtRdhLrQMT99qGWwM18wa4X5MS90okhH9rqdY8IXsayZx+zU0dBJ?=
 =?us-ascii?Q?u4OjYK0NnFcczsjgvbpxK7smExa1oGXbJVdtk6+gXGCuqWQJ3DidApdBFSm0?=
 =?us-ascii?Q?LO1zELCVY7+WG+b6JBvsDV07aB7BPN8AIhNI/eHfvImQbs+Uv+BuyPkyh4ZU?=
 =?us-ascii?Q?O5eU/UQM0AqfahO+QABwiZuFFYgYHnrmiUDjOC1Wnyc5KL2NMPjnrgKf4ows?=
 =?us-ascii?Q?VVoB+TjfUvy85hKjrY1UML1894ZbNJc5QHsEcIay76IY5UF2Jaq40JJ0XFz/?=
 =?us-ascii?Q?/zbVNrlG/JIi+aLfuU83TAmU0EpNa83K2SSHLls7GM96dnlC4r7N2QKcDk6Y?=
 =?us-ascii?Q?dEwA58bNHYkfmwZvK7zFBrGHTJMW4IaRaqtYxcJN8jkhR6qUE+wupITWop6r?=
 =?us-ascii?Q?SY7tsue72klJ4XuPF1tXuFCL1fb4OK3kx3ietmzLSNkpzf0SqfuvbwLIimTY?=
 =?us-ascii?Q?GVdZ9wdhtaNZMzlhlIub2o3qmyuTi7B0wxvSxdWIytCHXJEA2zahmXOstKmq?=
 =?us-ascii?Q?bXSWAVtD7Lmxp6VvIW61oUk3lgSDsB2n1gXrS3hG3lW/IRvICqeADJ7coZMx?=
 =?us-ascii?Q?jFDa0ztELpZOvmXtRSQUCitxqDXfFOPYseva/aubseFNkqJ0hXkswCrigAwi?=
 =?us-ascii?Q?dAtXakVtlxW9rVlT6AJN53fgLbmPnDvDOYciVI5SP6Z1VX8bAwpQVI4yq3Lw?=
 =?us-ascii?Q?skCp7qxmVCbcPxXro+J8czY1I0Yx6LHrYG8FUpb9D40kmeOwBu3SLm1lPB10?=
 =?us-ascii?Q?OXBRmJAUTxwKJ3R4As7AtQrPoZjJdNFQc6twmtTtwfCBZSxnPLfd6ob6NWjy?=
 =?us-ascii?Q?dQsaLkIVou+XE0m7xb/+qEicxJymNupaMhAazRI+5driS0mi3dUxq5fjypVh?=
 =?us-ascii?Q?Mb/PPI+GiMQ9el5fU23WaBxbaXa3Ll2pJCZzA9rSn7YGcabGUcV5+luYmIVO?=
 =?us-ascii?Q?49z4O4E8PmSFp7GT/mqV6I6tffdbsj8Xi9y8HaLfEMq94nux8D2gyRXB8IDn?=
 =?us-ascii?Q?SurAbo4PwgH0nQ/QeqJql+gSryK7KdHEwM0GP2N6REkZtl+JEAhybrgc904z?=
 =?us-ascii?Q?NRrG51bvZqT1UmbRrYHBjIYycTScZ3lj0gsjsqbs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a74b523b-7623-44f0-08fe-08dabc08cad3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 12:58:37.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkKzuRUM5RnbPqZQwmmkb9LvuCJEtMOZJVpk6RzD6ZA++XDwANTK9o1mj0iuWr/RM3Bou2jAlyUffIpwvRC2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,
On 2022-11-01 at 09:41:57 +0000, Mel Gorman wrote:
> On Thu, Oct 27, 2022 at 01:26:03PM -0700, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> > 
> > WF_SYNC means that the waker goes to sleep after wakeup, so the current
> > cpu can be considered idle if the waker is the only process that is
> > running on it.
> > 
> > The perf pipe benchmark shows that this change reduces the average time
> > per operation from 8.8 usecs/op to 3.7 usecs/op.
> > 
> > Before:
> >  $ ./tools/perf/perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> > 
> >      Total time: 8.813 [sec]
> > 
> >        8.813985 usecs/op
> >          113456 ops/sec
> > 
> > After:
> >  $ ./tools/perf/perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> > 
> >      Total time: 3.743 [sec]
> > 
> >        3.743971 usecs/op
> >          267096 ops/sec
> > 
> 
> The WF_SYNC hint in unreliable as the waking process does not always
> go to sleep immediately. While it's great for a benchmark like a pipe
> benchmark as the relationship is strictly synchronous, it does not work
> out as well for networking which can use WF_SYNC for wakeups but either
> multiple tasks are being woken up or the waker does not go to sleep as
> there is sufficient inbound traffic to keep it awake. There used to be
> an attempt to track how accurate WF_SYNC was, using avg_overlap I think,
> but it was ultimately removed.
avg_overlap was removed 10 years ago because of accuracy problem that
"we are missing the necessary call to update_curr()" according to
commit e12f31d3e5d3 ("sched: Remove avg_overlap"). But in current code
I think this issue described in above commit does not exist anymore because
in current code the put_prev_task() would invoke update_curr() for each
entity, then calculating the avg_overlap is always using the update-to-date
runtime? If it is true, is it applicable to bring avg_overlap back?

Some benchmarks suffer from cross-CPU wakeup which introduces rq lock
contention. Similar to this patch, I tracked the average duration of the
task and place the wakee to a CPU where only 1 short-running task is running,
which is another direction to mitigate cross-CPU wakeup[1]. Not sure if we
could deal with more accurately?

[1] https://lore.kernel.org/lkml/6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com/

thanks,
Chenyu
