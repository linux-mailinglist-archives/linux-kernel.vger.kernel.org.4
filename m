Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916FA6DCF84
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDKBvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDKBvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:51:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647E10CE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681177874; x=1712713874;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QTfwiHyAxqrkQTk4pqv/zrH56iiIpQAzEqszYSVqXJo=;
  b=glAEyjrgoO30rIHUr5upow9XeRmQQHMSzlgBtNn6r4MsBJCWc1jcfxIy
   Qalh6SKoKOOlrEJnDF/vduV+LAuFKOq1gwOmdzKkuGLEZEop0RDuLT0V+
   XAtb5qNM8RyNxHsuDri+3LLrwrkyKxNcPq0mMbRHrLKLFBjG7xWJvYIyf
   abAiHbudzZLp5dfVQ8ZyXTohuWjfr/4WzBcJk/zmYtKAKp/3D0cew7bJa
   dkjmf8Gv7yF0d5UfsDs+wP0t9+5Kp0m4ldd/3bBOdo9PXkzfbRPa1+CAC
   FRzHEwLAJJiSVEarQhy7UkgVS0EVfsp2V/GEVjC/lzB6+qNCdwq8lmdx/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="345288145"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="345288145"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 18:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="934548035"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="934548035"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2023 18:51:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 18:51:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 18:51:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 18:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBq65t8Arg7vlon00tvJ/SPtdGaJGSCScNkynNQzbvnyp3AynpU0TiO+ftY4mLfY+bEaR0S1Li+jCaBGVvUPXBsiFXYzuvy3OwoJSC/SgBqHC1wyVcJDEUhXdYhASzUqv+yNcrf5pDq38IlAbtXWGRMcmKzOu1YbYGooE/mZF0zUzH2r2+mPSkhxYBtgINXVFy+8qoFqSEEhFSpRxA+p5WNDTsWV9C6Lu9qKxwz1/jiFW7Mp8iE81nhYUwQCQIXTKKtS/LZU5yEySd9uPQW9a/adrjhPvcnsu6tUorYbgs58i/KRuzX1OxWmNFnZ1QuZu+5TN0AyxmZ5Qo3Ct/gDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOaTj8/NhJwE6WysrkenSPqw5SvYLp7A/EVjDcCRo1s=;
 b=GfpOH+R6Qu28lKUOO0Ih6Ee2Bprd3Xr8fX6+Vq4+K6z75JWyuse4CGnnOl0/bqy40qqETPsOY+MEUyr8mkt/QcW5zJsnnmuxZjMTulil5ULRF3sF/mfVzZV2UO3AUFVhEiL1Qe8AbEdI6lfTSg1v8xhUSmCxy4656dr+fqV64CtMNOuTIA6asfYrb0g+Y+Gs87/lFcHuII5Lut6WiVKiE10UyWKODslJn795rO4dnyYzjSnvxN4oq4XtEc3Pqbklni0TPMUB4ybteZeMcPHZEfLE9dAh03QMsp/tpMv2cj2qQtTSlZWtSRfyeSYZhE7I5OPHIht4o65uVBRYNeONsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS0PR11MB7623.namprd11.prod.outlook.com (2603:10b6:8:142::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 01:51:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::dc82:2501:ebd6:4799]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::dc82:2501:ebd6:4799%3]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 01:51:08 +0000
Date:   Tue, 11 Apr 2023 09:50:54 +0800
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
Message-ID: <ZDS8/lKrllN6Mjjl@chenyu5-mobl1>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230308073201.3102738-3-avagin@google.com>
 <ZDDddj50KZInqa84@chenyu5-mobl1>
 <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
 <ZDRSmC5tJiKZfMnE@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDRSmC5tJiKZfMnE@chenyu5-mobl1>
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS0PR11MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea8a65c-6638-4ea2-6496-08db3a2f3851
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhJlYmU757RCJb86J9C5+AJXpRPiReg/DSm2wX2u3SLVUMed0OG1aROTZaERvHNIFleCxqgGr5/wZurTt4LxvI8c6e/Or18SZdyi6rN7DuJ7wK3HkwOelRBRrhrNxsL2vS7zEn8VL5/+iUvZgyDPix62ybojnnOo2zp6jbmB9e5WJjoFBcTxTjLgEDQleETIscNEtkIXheotu2c9I1y2YXmqB7fwK0lCYdMCI7edYIDa+2wayL6E6oHoXC3oq+H282i4tklS54+15I8sPLqn+xoSFlkiGYeToywJwsLJGbqF4Sk3539CtAo30nbp8WUnILOMUFEDaR8ulX+rJ1YkJCqZrBTcCv856A01rbbRKSldEXlsvaQHueVc6D3Pr82F0CqtQUDnXBz8lSjwRC9BS3MAYvQ0VwMsnCLqHtpZn1foaEV7BoVGUl84HhkgP4Ea6ikMEkLEzsnr47dj5JZhzkweRNZWN6XJBVFgFQdiXjAGYsCw52LeJ+cN5E3tXZAmHguxYthATTRSv+fZVJZ1sNn7JC4MUbVWVf34J1Ed7wMfKxpKHlL46oijEJg7M9Pp1moLfTztVOdfm3/eEuuycQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(6916009)(4326008)(41300700001)(53546011)(38100700002)(186003)(66476007)(9686003)(82960400001)(6506007)(6512007)(83380400001)(33716001)(26005)(66946007)(66556008)(86362001)(6486002)(316002)(966005)(478600001)(54906003)(7416002)(8936002)(8676002)(5660300002)(2906002)(6666004)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJOTTlUUzdRRk12a2RLTzhGN3hXNGp5djlCTis1SldtQkZ3ZHNRZDlpTWxh?=
 =?utf-8?B?S1NoU0pFV1lGT2pielR6TGZaNEY1UDZWdWRYWDViekgrTWxKQ3k0WTJUVTY5?=
 =?utf-8?B?eDlTY3pHdU5aTHRscGplakZHR043TExPNWlGcFVVV043N013VnRGQWs2Wml4?=
 =?utf-8?B?SlJmSUJuemFJKzhqa1hrbW8xSU50V2llblFVaVBzSlR5TW5rNUVFSFE2a2xz?=
 =?utf-8?B?djZzWDV1SWFwK1JlUkNsVC90a2VYWStPZGI1SkhyTFNNM1liRjI2QWlDTEwx?=
 =?utf-8?B?Q24rK2d3a0RtNnhQbUozWHlrVytwSXRQbE96T0pXZUh2ZkJjOEdKQTlNdVpP?=
 =?utf-8?B?aG9ub2drTjB3Uno4MG5qdVBSS0VEZVFiS3F6bkY2MUNZUXdkYmV1Q2gzdFZt?=
 =?utf-8?B?RzloL0xJZkI4cXpnUmpFSXJqc1dUQ092RUNHOWVDM3FiRjNHV1ZROFY2RWJC?=
 =?utf-8?B?aXV6ZlVuUFd1YVgzcjUwNjM2Vk9tTml5UVBwaGRPOWRTOHFidmFBZzhMN3BT?=
 =?utf-8?B?dVNzZXhrRm1FYzR1Q0FDa21vRTdTcWkxdVZLU1k4QnErU3RBQlUwNjgwZTVD?=
 =?utf-8?B?Qjl4VjYvcGZZd1Ivdzk0VHBNQ0NiRkZiYXFXeUkrNnR1U1c3dU52ZHVXZnpW?=
 =?utf-8?B?TjNheGFDbUVpVmRNWUUvYlVTRFhpejQ1OTgzNTN0b1BBRkk0RWhNSE5JOG1x?=
 =?utf-8?B?bm1SUEpMVDlPazRWR09RMUQ2b2R1YXNidWhYNFZtcHZQb0pwemw4aWVJU3NV?=
 =?utf-8?B?UXBzYzRyMmltNEtQYnhmWEpYL3VhcnlVUFJ4NkNXRHhGUENvemJWcXRySThX?=
 =?utf-8?B?N21ybnFYN2ZaakRKbWUyNi8wYjhwNDdRTWI2V05CbkZqcVV3Q1RHQkdwU1Rm?=
 =?utf-8?B?V1BuYUZoWlNwTXl0SXQwZ0tvVmZrUkVsNml6Ynl4Vjc4WU9lQjA3NjB6S3py?=
 =?utf-8?B?L09UZXJjc1k2UlJJeUt2bko1OU91WTg3K1pjN0tmbVBJNXdnT3VYQXVxb0hq?=
 =?utf-8?B?RFM3UzBreTcrUXBic0dhUXMvTHZYaDliZ3VMT1Y4cENjK1A0TFhWWXZCc2tl?=
 =?utf-8?B?d1p3VktDNVNRa3IyUEhPbyswVGxWemtOaldVM1hLMzd1VS9wTmNzek1ZQmV3?=
 =?utf-8?B?MFpEUS9XVzdXbXFDeDFMRTBDZDNlQ00vNkZQeTF6N0JBUmFUU0xlOFlXOG5Y?=
 =?utf-8?B?ci9udkpScVhTaHVvWHdhZnlIcVVnMkVQREl2R3dWT3FUNTRtMTVPSWxHQVJI?=
 =?utf-8?B?bFNzaFZJRUdob2xRU1grMVlydlZpemVlMmtnSXVHL2c4Q3NVRXBuQ0RWRVpm?=
 =?utf-8?B?YmNpZE9LZ1JVY0dZaUFxTm5NNDRUK0d2cC9LdjA5SEhGZEYvMStQa21QamZF?=
 =?utf-8?B?dS9ETThRNTJEbjhKZmc5RktWM1RzMEhJZGlkVFRoQ2IxQ2dRZFl0VzlBMzdJ?=
 =?utf-8?B?TTRqV3lCRXhtSzBkMWJEeG5oNDVvZFd4SGpuSGVnejZ3MVZBNTRaZ0VZU2ZZ?=
 =?utf-8?B?SGREeVNjN25iSnROejUzYlBXSFY1RitDOUVObHpwRFFHRWRxSGNsWWl2VGVw?=
 =?utf-8?B?aHpydG9hT2IxcEk0SVU2aExIaTF1cUpMWXBnU2hybnNhRWZkRWw4SytJczZl?=
 =?utf-8?B?ckNnM0lBRVh6ZXh1Y3FtMDhYYXNoOW90OEcvM1FmQW5sNnErQy9oQUkxaTN1?=
 =?utf-8?B?Y0NOYnZaMXZRcUtQMCtLcittUE5Lak9paW5yem45Z2tmVWg0M1MzNlpVZ2cy?=
 =?utf-8?B?N21RaVM0ektoMGVnMU1rNHExZjRVd3pZRGRmSG9ZMWdhZldZNkpTVTgxSUNj?=
 =?utf-8?B?N3VCOHJnQ1ZXTWxaaWlLK3JZTFFiakNIT2w4ZXh3NGFqcU9pYWtnS3hlbkx3?=
 =?utf-8?B?SHRCUEFSelRnWkc1RlJNcXZvY2E0MU03NFRUYTZuTDJLdVlzTG9nWkJESktt?=
 =?utf-8?B?MEdGRHViZXpvTU04UDYrODI0Z1U0M3luak9keFM1UDgrL1I5VDBWQ3N4c0JX?=
 =?utf-8?B?REZaWWMzcEdWRHVpQjU0bXJYUUlhZE5VakswTE9GTVZ4eDRRd2d1UzdpNjFN?=
 =?utf-8?B?M0VZOEVNa3BjZldMSTBWOGRVZXRDSWdUWGg2MjluNlBrSzhJUm1zY2lhNjJp?=
 =?utf-8?Q?DQt3xaoI1KRfoPuOLALlpAZnC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea8a65c-6638-4ea2-6496-08db3a2f3851
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 01:51:08.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zETmpSDRNH1BYYj3vuaWRtpEAqUgVqA/gbTghC8xZNISwOaSPyRZc3biW19mEuFsDWGZYOEgTprBp9Ma8+8Bsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7623
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

On 2023-04-11 at 02:16:56 +0800, Chen Yu wrote:
> On 2023-04-09 at 21:56:26 -0700, Andrei Vagin wrote:
> > On Fri, Apr 7, 2023 at 8:20 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > On 2023-03-07 at 23:31:57 -0800, Andrei Vagin wrote:
> > > > From: Peter Oskolkov <posk@google.com>
> > > >
> > > > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > > > move the wakee to the current CPU. This is useful for fast on-CPU
> > > > context switching use cases.
> > > >
> > > > In addition, make ttwu external rather than static so that
> > > > the flag could be passed to it from outside of sched/core.c.
> > > >
> > > > Signed-off-by: Peter Oskolkov <posk@google.com>
> > > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > > >       if (wake_flags & WF_TTWU) {
> > > >               record_wakee(p);
> > > >
> > > > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > > > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > > > +                     return cpu;
> > > > +
> > > I tried to reuse WF_CURRENT_CPU to mitigate the cross-cpu wakeup, however there
> > > are regressions when running some workloads, and these workloads want to be
> > > spreaded on idle CPUs whenever possible.
> > > The reason for the regression is that, above change chooses current CPU no matter
> > > what the load/utilization of this CPU is. So task are stacked on 1 CPU and hurts
> > > throughput/latency. And I believe this issue would be more severe on system with
> > > smaller number of CPU within 1 LLC(when compared to Intel platforms), such as AMD,
> > > Arm64.
> > 
> > WF_CURRENT_CPU works only in certain conditions. Maybe you saw my
> > attempt to change how WF_SYNC works:
> > 
> > https://www.spinics.net/lists/kernel/msg4567650.html
> > 
> > Then we've found that this idea doesn't work well, and it is a reason
> > why we have the separate WF_CURRENT_CPU flag.
> >
> I see, in seccomp case, even the idle CPU is not a better choice. 
> > >
> > > I know WF_CURRENT_CPU benefits seccomp, and can we make this change more genefic
> > > to benefit other workloads, by making the condition to trigger WF_CURRENT_CPU stricter?
> > > Say, only current CPU has 1 runnable task, and treat current CPU as the last resort by
> > > checking if the wakee's previous CPU is not idle. In this way, we can enable WF_CURRENT_CPU flag
> > > dynamically when some condition is met(a short task for example).
> > 
> > We discussed all of these here and here:
> > 
> > https://www.spinics.net/lists/kernel/msg4657545.html
> > 
> > https://lore.kernel.org/lkml/CANaxB-yWkKzhhPMGXCQbtjntJbqZ40FL2qtM2hk7LLWE-ZpbAg@mail.gmail.com/
> > 
> > I like your idea about short-duration tasks, but I think it is a
> > separate task and it has to be done in a separate patch set. Here, I
> > solve the problem of optimizing synchronous switches when one task wakes
> > up another one and falls asleep immediately after that. Waking up the
> > target task on the current CPU looks reasonable for a few reasons in
> > this case. First, waking up a task on the current CPU is cheaper than on
> > another one and it is much cheaper than waking on an idle cpu. 
> It depends. For waker and wakee that compete for cache resource and do
> not have share data, sometimes an idle target would be better.
> > Second,
> > when tasks want to do synchronous switches, they often exchange some
> > data, so memory caches can play on us.
> I like the name of 'WF_CURRENT_CPU' too : ) and I was thinking that if this could
> become a auto-detect behavior so others can benefit from this.
> 
> If I understand correctly, the scenario this patch deals with is:
> task A wakeups task B, task A and taks B have close relationship with each
> other(cache sharing eg), when task A fall asleep, choose A's CPU, rather than an
> idle CPU.
> 
> I'm thinking if the following logic would cover your case:
> 1. the waker A is a short duration one (waker will fall asleep soon)
> 2. the waker B is a short duration one (impact of B is minor)
typo:  s/waker B/wakee B/
> 3. the A->wakee_flips is 0 and A->last_wakee = B
> 4. the A->wakee_flips is 0 and B->last_wakee = A
typo:  s/A->wakee_flips/B->wakee_flips/

Sorry I typed too quickly yesterday.

thanks,
Chenyu
> 5, cpu(A)->nr_running = 1
> 
> (3 and 4 mean that, A and B wake up each other, so it is likely that
> they share cache data, and they are good firends to be put together)
> 
> If above conditions are met, choose current CPU. In this way, WF_CURRENT_CPU
> can be set dynamically.
> 
> thanks,
> Chenyu
