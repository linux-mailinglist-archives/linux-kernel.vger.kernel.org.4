Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF25BB8B8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIQOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIQOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:15:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCEC2E685
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663424150; x=1694960150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lciklIZLvGnqqgZZNAmdP48fyGGq0bJgj22hwt0915Y=;
  b=kx8FeGwbRByhBcJgY2wvkpOr7U12iPF6MrjNT4QE4mVBuvlml8m9tlYz
   P/7s6EI4x/xdJ9zLSYZHAj7qCegYNy4ZBhuBJjaolc3bzV7WUQ4Y7j5uG
   hl6r8hr6o7l1WB9limdqwZ0JFfyiUO97r6FiX8HkibIKMOyI1+Y4obrZ7
   7QamwtVFjTyzjKREe7uf41A+5v5rq/qzmJvw3zQyT3LrgRojls6jFJdpF
   2r+gLvi4zXF8pS9r4m0GAqaCkJ8VSYOo7fA3O93ZPiUGRn+93X7ATND65
   BcHRXjaFQqOm3oM4+m+m8nac/wDOYr3lyDvFYjc7AW2ypihNIWuhixLxL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="296745106"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="296745106"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 07:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="648582346"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 17 Sep 2022 07:15:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 17 Sep 2022 07:15:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 17 Sep 2022 07:15:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 17 Sep 2022 07:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyYYdY4BOd8qmSFVen15Y3V6hDOkfKhKWSdOZDfHpnpevuGTC9Zqpb5otjZCxSZa8J1O5BubFOe5ugQ0vx1V0GuCToyzl4ltdsjWmvooY4u2I6zg040uqz4mOWi/8jiFfe7i9xwTv46UvgnS/vhyfLoRhGlmnchoy/G4Q609KQyynpWIkIx+XrnZAXRdpahZ2D/U0OmhVoYlDVQTkyKjfthzqhOEmm5quY/69dW0wQ7W61l+S30CkDWrVu0hCkNiQdelXOLMDxgNWQNbrCpodiYdeq7jfkEyOkMkr4a2hzFXZA/yZ5EmT6VqSIkV/Zs/Xdu3aice0dvdkkQmsTtjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uggOPST/nht85a9Ts00pwoxmxiqZQGQsIEJxyS96cxA=;
 b=REInq0ITLddFJ3ylpkK5umczuOElQvIVmRn8y+/UW7XsY84UuAw+/PEOnACa3AoW/niN5N8rRYMezjkjLfOkM623THsewmAyBq+d5bO28wNi5Q9IuL2n4gQIjqdhVOMhbZAvBwhSdluVR9wOsCn2IfdBdl96KIIv21psS17jmlM0O3Zezk4IjnagsNvAQ9WsWheRi2zOr6Cdwqo1C0jSrefVPGTzvBZJkvW+ipeerV1u/XHbWbZpB3o3HGMdDnMDHgj3pE6wNDYGM52teF12jEjq91xeDZh/Un3j+RblCInZRaKVCKewbBxiL8POlnNbIjT0DMv3tneqiH/IR3Eghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4814.namprd11.prod.outlook.com (2603:10b6:a03:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Sat, 17 Sep
 2022 14:15:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5632.018; Sat, 17 Sep 2022
 14:15:46 +0000
Date:   Sat, 17 Sep 2022 22:15:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YyXWfmH6cJayun3I@chenyu5-mobl1>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <YyRiZTTi2KQfJebc@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyRiZTTi2KQfJebc@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f766eb7-e67f-45a5-d1fb-08da98b71d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Axb512RWVIXHuZo0++4iQUQWRsF82POlRYgi86YL3XaJ/DEPKT6k7g8A0D5xu4aakAjtliYEPFjWGCxRV5Y0Z/vMbhEniiINCpdDmGqWOeJi5AGknggM8BuE3okCYnDZb6qcVDO+w3KsdfbV0U6uM8oxj32OsbiysRJ0XLOtlbtAhubQGxkARoF6FWQHsyW0EpN5m8SmubiD2ALDCZjCnZoHXWef2/InEbY/dtT1h3sHFmDKUdrQZQ15OQHh4BxHWUHRghjCzzT34D+HvCP/v6Lg0QImCcKOo0BlBhJog4U+9HKcgIcja9OCeWVJ7DeTQVAnPrFOUPmH2XL+fYVg6v9MkNSXGQEvl5OX3O+Hx0h5XTzuQWBCEehIJ/WkvekHiTaDT43iUms6WP6pJEQy1xM8de9yM1L0UUGopIeRoN/NwROhFmPteSGG1z9jn1/5TRD7GRMmeY2ZXDmKkwvxFklpksA2PFPbVIMYcOysLLDflg28tuxsf1qyf/xCHpBg2LkRVe7gqdbuMBWqcs+D8/W5IwAA9ABreNQwcIqRzWI5gXFT1nM8OW3Mm0tY3C7vawSVvVWQw3JH/rv+PtBAAxrBsJt71IKeZo7hunKrUbrKYdtNcOxlcnafF3uwmiD8kg8kdGcSJ3wCqpW5pgPkMUmWgZh+jrEuWVBdiQkPwcTSW+Vz5Ya4+IGWCtFewBYpL+Pr7JjLwErx8Ma3Sw6FUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(6506007)(66476007)(86362001)(53546011)(6666004)(41300700001)(4326008)(8676002)(8936002)(26005)(6486002)(66556008)(478600001)(66946007)(6916009)(54906003)(316002)(186003)(2906002)(83380400001)(5660300002)(9686003)(7416002)(82960400001)(6512007)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IiYNPQoWx3IY6B681FgYcgkmANrzzYRzYMY1IT0q6515wMBX88TbXweTW32?=
 =?us-ascii?Q?DFnxzhB75Y3O7ZGkRG6tJ7NJ0ZhP9YeWOojQ/iqfRJgkfC7r3iSF5nMKPgyN?=
 =?us-ascii?Q?ziUB9kblEeGaRxYYeSV9apGuk8PUczQHijxVxj6MmcwUcbP69vr4jHZEPlf5?=
 =?us-ascii?Q?MnVGEtgYdNPEBascOdgryn9a4QqwI/FbUrFm2DAFAlGkCEarxNKtGRKqqeO1?=
 =?us-ascii?Q?RI+0lHslwpTInm4ep5hxra9fdoh9VWp4GN0dMnNx5Am6LE0I0ZrcZ7kw5apP?=
 =?us-ascii?Q?H0RDkA7OjPnQ0x9QyUleXk6bP6p7L8Buc0XeMI+MnhQcf5TcM9mYwAmzIY9/?=
 =?us-ascii?Q?yEaPi+k3141WeC/pK3axT4wBZzglAAOR5XOTHW7lc+P2oOM175L4tyvxNJxN?=
 =?us-ascii?Q?1xxeXeu0RXXLrh1BV/Lyb2SBplyQJdzfkX1Pgyi4R7D8qA/WgFf2f7DXVdPc?=
 =?us-ascii?Q?2f0kFMo1QHMqxGoBe0sVnTs27O/lRT6UsmLKXmSZjVkERA9rE+m1ZlMhJHoH?=
 =?us-ascii?Q?p6yDJmidY6bzQ6OTKlkTGSFpYDWquFJGoUv2TGEq1swhvjhIHap5i3vWgWNP?=
 =?us-ascii?Q?FTWgtDWv8xMqPj9x8HqeiVsgRwVZ1wNf9w7jw8o5/61hlp+eOioLvQaf49WU?=
 =?us-ascii?Q?RNMuvvhP53oiXiX8h/z8i5wLVq6aqVllgUM5Q3IxAsEUKqYkK2WH1i9SYAY1?=
 =?us-ascii?Q?bC6/NXx/7edYaOoELTAyWbocZOiOGngGldZOsmdnzW25inz2MDdLZq9EuAOW?=
 =?us-ascii?Q?M67qiFA98w1eiv6rRJQij5nCFlWrf+8o9fYk2EqtbOCUscXxgx/oVJAdVbZ9?=
 =?us-ascii?Q?mnRrcZROwGot6BtsSmGhjxyMxhjvHCp8wAqooUnDTExdEYHXUMqjuvLXGwt6?=
 =?us-ascii?Q?pHuqLZPzBWloVb0yADZNYH15EiwBiRU9QvO7KletVQ7IC2gFtBefmDiuRJWh?=
 =?us-ascii?Q?ReuPpV9NO5NV6zWYHOgV3zDKZTi6jG51/P4iyam1bO2W8jh/kiXKB/RqgdZg?=
 =?us-ascii?Q?+MiLro1sC16W0vvjVDqnSPfWMj52spblEU9RbpVEHAnhtwljZaoE1uBcoqOU?=
 =?us-ascii?Q?iVsi6e15Z7qi+/hTrLHG3ssiliJ5e3362vabv0PV+2wqiuhAXClHldFY49QF?=
 =?us-ascii?Q?RKUszai4IPXlzJ9HrBw/vqlYpniNeYPxaS7G2XkRzPVoQ5QTeLPXB3dKPc7T?=
 =?us-ascii?Q?hjOpBccwBpN0CSCOzv4t1XEN2HP/3wCs3d/eYFuZsEtH2f/2RrQ/oU89sPm6?=
 =?us-ascii?Q?VDojn/YwkiJ6DobQjS4GXpj0l7qCx2YXIDG1EuSIHjYyHactyTyPArjDwMWa?=
 =?us-ascii?Q?kEqgnG9lYZnN7TrlBKgnVRTDcpVVwFPIBVyPQOf/nxtnGKYyGWLEtFN476iD?=
 =?us-ascii?Q?lrCJPbM+QVrAE2q8HcGCThfe5nNecirMJW/FDeUYO+ey1TRKUYrPItFh5C1N?=
 =?us-ascii?Q?gRQLw/e/MxAjrm1biTR3Q8tk0xJM7JUYxOEv6vj1gOUbC2tKUOzmQv8Uoqpn?=
 =?us-ascii?Q?QTsQoZmgPNDLvRJP1/J51qT5jciFV5ZxoCO36Qxixxi0q1vCxV3Dk8jASIzC?=
 =?us-ascii?Q?mc995H1JzngU8R/R5e43PDGu1QfA3EQL3nx7hFpU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f766eb7-e67f-45a5-d1fb-08da98b71d47
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2022 14:15:46.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n68nRBL+a7VpDJZM2hyn7zHvH1ReFUNMONizhbpKoQT4gIDJN9aUYlhmh6/rtLKzyG4Wp475O+B1WM3nsH8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-16 at 13:47:49 +0200, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 12:54:07AM +0800, Chen Yu wrote:
> 
> > Current proposal is a variant of 2:
> > If the target CPU is running a short-time slice task, and the wakee
> > is also a short-time slice task, the target CPU could be chosen as the
> > candidate when the system is busy.
> 
> Since this benchmark only has short running tasks, the result is that
> you always pick the local cpu and therefore the migrations are reduced?
>
Yes, local cpu is preferred.
> Doesn't this inhibit spreading the workload when there's geniunely idle
> CPUs around?
Yes, there could be some idle CPUs undetected, although this strategy is
in effect when the system is busy. And maybe we could raise the bar to
enable this strategy. For example as Tim mentioned, if the target CPU is
running a short-running task, and the nr_running is 1, meanwhile there's no
ttwu_pending flag on this CPU, we can choose the target. I don't have
good idea on how to extract the criterias to descibe the scenario, for
example, how to detect if the sched_domain has too many context switch and
we can safely inhibit spreading the workload.

thanks,
Chenyu
