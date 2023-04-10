Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086096DCA99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDJSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDJSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:17:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDCD1BD6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681150638; x=1712686638;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NKJQeTaqXW9JbKMk2Gd/IMbjGlWUgFGfh7PLGNMnbH4=;
  b=D1b5Ugcjdln7cp2x8ZuwxHkMOjyrmFxEK0V/DWcvBqIz4Un9Eic47sj/
   XUOyYR19ugmWR2ioPUq3eygJ6GHFvY7NcB3hilP9RHSOd54rGEseFN6Oz
   NKODq7rJIDjq4LRZAgb6oZ7kDPpl1B8ciCy5wqJZ6rBXqs2rs32gQWDYS
   hfFOofw8urBOeS87NsizAVlD1GAVkTaBsqPjCJ10rRvcsI/lRLO0Hi0Tc
   XVq5SFyyUkA3sGYub84RSWr1txIwFkZ1ewRkzPHZ0qyppzlixoRqq9pPW
   YHzFL8kgRNkDpEuGAQAE6j4hA5ENFyIKxMk3BnnwQ0LNIh4b14W+umx33
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="346087862"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="346087862"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 11:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757537406"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="757537406"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 11:17:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 11:17:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 11:17:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 11:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA9+CiJi8iyTjvtZ2VYQGI9/b7I0yTPGvbe1AU1rOlgmYyu4C1RIlal+wrAQANcdDS/hUtqB7lIe0V9A4vt9KGRTBPmueyFK99XLehwFFdSdVb6bQKPIV4TbG1yJNXt7UQmxlQSxJPUtere3KYVeI3wwhPcqCBhhPngQHyxiwua1iaxMSK5W2NXag5BdMuFgcsullxa9sZ5ZCYq0cC8Cb2vsnuzKlgLAtpQ0sQEmEZtGHwobdRGQ+je7dOuhw1FcSZp5oONzRJ9AVr0dWppZF2BEc2p7nybnwY6MMoBWAIzC1M4WilKks34Fu7CRkbSz+1g4qh1ZwC/YBCH9TFti7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfvRe/nMqwMfAJhvVyDbmovaZEPOavcJ3Lkj/3h1T9w=;
 b=hmpmcnRKpV7oHGdq/FNq3mNfnuqrf12tgLMAQRJLxOd/MGx0RYY4vL6Je8LS6EFdtb/sJCEsh8hNCzRVZrY0d3PVJ4COfXfsQ4VKED6YCzBL9IroC2KaSpLdESzMG0b5jhQhVY2dnw7XUps6SwvvBM1nlIuGlpYY9kodNTnvrSq7NEL8LZq21CutTsL3hv/NOBg2kv2h6+wcMcfGto4i67pc3ylfhoLTfV0eR855LiKTTVHe9vez0rjFW0XEUXbZei1p+3ZZpekslnyjLvJzy3TM9kepLiPZGyVcm35PybPhnIpZKIU1sDgOuXlmBfW06kvSUB+ue8CKwD6aOuS8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 18:17:15 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::dc82:2501:ebd6:4799]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::dc82:2501:ebd6:4799%3]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 18:17:14 +0000
Date:   Tue, 11 Apr 2023 02:16:56 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andrei Vagin <avagin@gmail.com>
CC:     Andrei Vagin <avagin@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Brauner" <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        "Tycho Andersen" <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
Message-ID: <ZDRSmC5tJiKZfMnE@chenyu5-mobl1>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230308073201.3102738-3-avagin@google.com>
 <ZDDddj50KZInqa84@chenyu5-mobl1>
 <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
X-ClientProxiedBy: KU1PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:802:19::34) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bf2391-d8ca-4109-125c-08db39efcf8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlN5hnOaU5VKRHUdUyOcQIeH5X8exZRQJPIFGb8C+W8TdEPKsBFxWBtqfhwBmZSS6zC8OjNUj8HyHpqF6Njp4v2LNfCH6Q6gt+lcBeSTJrWlMISSk98TV/rVKzBN2kNkuShXg4OOn8jPMvGvqszEwcnPsR9umZM4ndrP9gmIS0mv3JGpPwF0CV1VYvVBdy2wpz4CoRrC7gzQa6fLIKJ+HfqVl+BVAd0NTOdbCrbA9pPL2SNPU/g9ChBZ5GqXN2hHGtgQgc7vO7deNERq0fA/NkfM61wAk1LRwWlYfxqvP2P4BRgbUATxPR6EwxHMM3L+6HN2bH9RpNVXWZ5OWOFAVLai/dPGqILBLIMJEXPhDR0/XqGvetuU1I15mb2rW8O7AOF/anhBhZsoczitTU7ZPpUSpR4ABu/oL7oOtTv6wUJOnNBbeWJLb37B0fGZhJBk6Wzy42FZn6H7AuGFOIzcTMZM0yTDML5WNFIxTGF9N4GMoTdC9a6leJ/bgCIDBApLrfAp9jb1sbFfxRd1eyaGWwd6NPRXcqkWJ4WqWyIPA3ckmHwURbyOqJODzz/NuZskfd3mSn81Pb5N3vSQH42++bVNgH19kodIdPAYds8vc9F75qZxna9r92Vd56AzaSVho7ZRhtvgUn8fbAR1y7Sx2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(6666004)(83380400001)(4326008)(66899021)(186003)(86362001)(6512007)(6506007)(53546011)(9686003)(6486002)(478600001)(26005)(6916009)(2906002)(66946007)(38100700002)(8676002)(82960400001)(41300700001)(66556008)(54906003)(33716001)(316002)(8936002)(7416002)(66476007)(5660300002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFCcnVTY3Q0dmxrKzB6aXZmTFdwL1UzSzhLeWRkUjYyeGZNNmtWYTdzd1FX?=
 =?utf-8?B?blY5YlFuRWozU2xMTDFCWXFlNlh6Ti9wLzdlN3JMMnltZVVaUzJwTXRNVE95?=
 =?utf-8?B?RlN1b3lZMkIySGxseW4rZjAvTXhnNUVkU01aRVNUekVBYTNGSmhXYlpreUQr?=
 =?utf-8?B?d1VDb1J0WGV2eEFXVmI4c1pGNU44MU9QRkhVYUFNN0ZuazQwV3c1NXVrWkFt?=
 =?utf-8?B?U1hNZnVCNDc1aU5uOC9YM3YxcFR2ckxTelpVUTh3VUF3aEgrOElkeGtnRUcr?=
 =?utf-8?B?Sm5sL2gzRGphZUd1RU1qSmVXZTdWb2pDMlkreXg4U2NuMi9OZ24za0xndzJX?=
 =?utf-8?B?aHRHdjZibHVpRnQ3NE5KYlNhei9Rc0l1VHdPRnlsQ29aNTEvYVpyNFh4b0pr?=
 =?utf-8?B?cmhZMkVLL3dtM29pSHdPMGx6cmw2VHl0OWlWajkwTlV3c0JGMXlNYlNBSFY0?=
 =?utf-8?B?WDRTQ0hXVlM3RTF2ZGhpcytvRkNyTXVLQ1dmdGNua3R5VXFsUGd5QVozOEtn?=
 =?utf-8?B?Q2RxVjBJeUdIU2o5UE03UTJaampyOFE1RExsZHdYMC96L0p6UmZYWUJCc21Q?=
 =?utf-8?B?OVJleFR6K2NBakNEQTRwM3ZWYWJBN2V1OENkYWFPQVBtT2hlTGM3dVkxdE9R?=
 =?utf-8?B?dkl2SEJHWkhwTFFGRXNaM00vZ2JRa1NwdTVmNE1PS3doalNBek05alNsdWxl?=
 =?utf-8?B?ZXpSanEyV29ZWGVrSGFNWGwvQmFkYmIwR2NtcW1WRkdUMGlZN3hlUDBkU3Mz?=
 =?utf-8?B?VjZVYWhzd2gydldGQngwOXBLK2lSWm01azRXT0crTndkcDg3VVRuZEhyNlA2?=
 =?utf-8?B?VHgxbjI5R2w4a1YxSjlQNGZQcGhuMXI1Z2Nxamc1a2EwTENNRytJQzBsemhp?=
 =?utf-8?B?QWRsRkh1dHpoamhIMnBQcDlDVWorbUphV2FtYTU0T1BtU3FTbU04MldoYXhx?=
 =?utf-8?B?QmtvMGJFVnRvdzJYMi9MUW1sK2JEQVIwM3FRSlhoY3hhNEVBQUVGVEM4SVE5?=
 =?utf-8?B?SElTSjNwOWZTbUY4dmhNRVZRaWFrWnc2bEZoWUl0b0x1MjZBVmlkVVRiNVkz?=
 =?utf-8?B?ZjdMbWcvOWNTMjVJOUVHa0w3eEZIK09LN1pnaGduOW5FQi9lNFplUDVzSDBt?=
 =?utf-8?B?RDJJbW52WFlUSTJ1RGhXK0x1YU5HRXNmbFlCdTBOVHZDQ0lUQzBNVnlNU29C?=
 =?utf-8?B?eEJ3RDNrcE5aT2hRQ1dSVS9UaWV5QWU1ZTRidE16aWRQUk01bUtXbGNxTEJ4?=
 =?utf-8?B?azRTZXl6T3VzVlB0UlV3YXRCMjE5YkxPaVBSMXhpc0FoUmc5aWxKQkFLT1Ni?=
 =?utf-8?B?QnBuYlAvUUdkaTZNTDllZExBYzZZYlU1bm1pc2xWZGk4NmtUTlh2ZGZRaUZK?=
 =?utf-8?B?cGFreXRneFk5eWZ0L0FTNll5Y2JUYXRQSTBNWGNZV0hFR0NtRXJ3ZS9DTXd0?=
 =?utf-8?B?QmgrODNDc1dPWXpaTnBRaUl4R2RVUlpvWHFsaldTTk5PVVZzT2pjeituRWw5?=
 =?utf-8?B?UlJRWDdZR1lGajIyRUxleWlPVVJxWDBhTGp4NVRLSjF5MTF4TFZXM2t6UnBi?=
 =?utf-8?B?QWdvaTFSUnl0blBmak04THdUajVlRWZXbkdZeVVGOXdCMTdJTzltV2l6K0F0?=
 =?utf-8?B?cVRWOTF0bXdVQVNuR3lCNHdBRVdLa1lTQURjckgyd3BQN0U0dFZsMVNTQm1k?=
 =?utf-8?B?bEQ2dmg1enZzS2lzakJiYVpVcjcxOUxoS0xlZ0pkM3pIcllNZjJlMEVkQUlE?=
 =?utf-8?B?aXZabXVXNGJHSmRVcmJ2N3ZOcWUvcjIxL2xPdzF1SXlzT3ZEMnpBbjY4SU5J?=
 =?utf-8?B?ak1wdFhabTZPaFhWdlJ1WGFTZjhESDZPVmlESG1WS2JOeWxZcGpYU1FLclE3?=
 =?utf-8?B?N0tTVjA1eEYxaC9VeHpLRGlWUm5UV3gydTF1a213MHBOeTlmYkprMWV6aSti?=
 =?utf-8?B?Z3JrVVZvZkNNTWFlcW5kdVlESktrMnZzQkNMaGlKUmJDSmhKd1MzdElZaWxC?=
 =?utf-8?B?bmN2TnRPUHNxeUJFYmxpVVp1bnhDNGdRa0pLN0tOcjZOQ2xTM2JmaDNIZDBS?=
 =?utf-8?B?NTZ5ak9CRDhBTThBUGtUVjdyVHZ0MDNCNFZzTGt2SUtHWXpOZlNhQ2YxQ1dw?=
 =?utf-8?Q?orc9kcjpt4UK2QGPH3wed1ie0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bf2391-d8ca-4109-125c-08db39efcf8d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:17:14.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQR9ickOSFfG0ByOTmdMSzXi3sEOsudluRtpFsaZDDKL5/l3gJLN0ifHDLW6ufq/TUrVMusvM7feC3INELLwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-09 at 21:56:26 -0700, Andrei Vagin wrote:
> On Fri, Apr 7, 2023 at 8:20 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2023-03-07 at 23:31:57 -0800, Andrei Vagin wrote:
> > > From: Peter Oskolkov <posk@google.com>
> > >
> > > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > > move the wakee to the current CPU. This is useful for fast on-CPU
> > > context switching use cases.
> > >
> > > In addition, make ttwu external rather than static so that
> > > the flag could be passed to it from outside of sched/core.c.
> > >
> > > Signed-off-by: Peter Oskolkov <posk@google.com>
> > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > >       if (wake_flags & WF_TTWU) {
> > >               record_wakee(p);
> > >
> > > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > > +                     return cpu;
> > > +
> > I tried to reuse WF_CURRENT_CPU to mitigate the cross-cpu wakeup, however there
> > are regressions when running some workloads, and these workloads want to be
> > spreaded on idle CPUs whenever possible.
> > The reason for the regression is that, above change chooses current CPU no matter
> > what the load/utilization of this CPU is. So task are stacked on 1 CPU and hurts
> > throughput/latency. And I believe this issue would be more severe on system with
> > smaller number of CPU within 1 LLC(when compared to Intel platforms), such as AMD,
> > Arm64.
> 
> WF_CURRENT_CPU works only in certain conditions. Maybe you saw my
> attempt to change how WF_SYNC works:
> 
> https://www.spinics.net/lists/kernel/msg4567650.html
> 
> Then we've found that this idea doesn't work well, and it is a reason
> why we have the separate WF_CURRENT_CPU flag.
>
I see, in seccomp case, even the idle CPU is not a better choice. 
> >
> > I know WF_CURRENT_CPU benefits seccomp, and can we make this change more genefic
> > to benefit other workloads, by making the condition to trigger WF_CURRENT_CPU stricter?
> > Say, only current CPU has 1 runnable task, and treat current CPU as the last resort by
> > checking if the wakee's previous CPU is not idle. In this way, we can enable WF_CURRENT_CPU flag
> > dynamically when some condition is met(a short task for example).
> 
> We discussed all of these here and here:
> 
> https://www.spinics.net/lists/kernel/msg4657545.html
> 
> https://lore.kernel.org/lkml/CANaxB-yWkKzhhPMGXCQbtjntJbqZ40FL2qtM2hk7LLWE-ZpbAg@mail.gmail.com/
> 
> I like your idea about short-duration tasks, but I think it is a
> separate task and it has to be done in a separate patch set. Here, I
> solve the problem of optimizing synchronous switches when one task wakes
> up another one and falls asleep immediately after that. Waking up the
> target task on the current CPU looks reasonable for a few reasons in
> this case. First, waking up a task on the current CPU is cheaper than on
> another one and it is much cheaper than waking on an idle cpu. 
It depends. For waker and wakee that compete for cache resource and do
not have share data, sometimes an idle target would be better.
> Second,
> when tasks want to do synchronous switches, they often exchange some
> data, so memory caches can play on us.
I like the name of 'WF_CURRENT_CPU' too : ) and I was thinking that if this could
become a auto-detect behavior so others can benefit from this.

If I understand correctly, the scenario this patch deals with is:
task A wakeups task B, task A and taks B have close relationship with each
other(cache sharing eg), when task A fall asleep, choose A's CPU, rather than an
idle CPU.

I'm thinking if the following logic would cover your case:
1. the waker A is a short duration one (waker will fall asleep soon)
2. the waker B is a short duration one (impact of B is minor)
3. the A->wakee_flips is 0 and A->last_wakee = B
4. the A->wakee_flips is 0 and B->last_wakee = A
5, cpu(A)->nr_running = 1

(3 and 4 mean that, A and B wake up each other, so it is likely that
they share cache data, and they are good firends to be put together)

If above conditions are met, choose current CPU. In this way, WF_CURRENT_CPU
can be set dynamically.

thanks,
Chenyu
