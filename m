Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450865F084A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiI3KNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiI3KNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:13:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C8314A7A7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664532819; x=1696068819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aO5f9FjVvpi4UxDLKCN87jfiYF0JWaWCY3bW4Sk8Iiw=;
  b=IRxunMw4c0XUkHQBQUQA7VkjjD+G8MVWr7Xrhhz1QxjAl7LS29fH2qFP
   SjDfPs5ZP0HaKJO5QOOo2DmCK9X9EVO5dWhc4Xmw3L6cLektAbVwlhRn1
   5n9BUarrNFFGfVtfrUrNv8xAHihYLUG6eHUFzJbLCC8n6yhugSNr4D9ab
   nzTb5PDk36UVe8NXCo39UsuCc6F6fSmMMedn8APDOw1hwM6yI9/LGtABu
   Ib95fBOI1wYBTjv8EmCMWnp5bLh8we/+6YnUL8ihgdA5zwbV3eL3JPjZJ
   1UGogTfObF+ZDg9IgZZShDjq9f+2T8gCe8MTPs65YScmK/rNwKk3Zwpoe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328539260"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="328539260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691198722"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691198722"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 03:13:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 03:13:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 03:13:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 03:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imT8VIQnOt55GHhdoOkkRe9PWjOkGuV+ptynW9crhYYF0ms4o/Bwsl82TRcvMVbkRlJYA6AYX92+fiPKjcW9rxftXL7mTtzc00eFVKJ5BGik/qK4NZTtEIbnP8RK1NfH5mTIqTmjaM5aB3O9D4yzuNg+Yr2A5Sy6HAxkHnpG8zw8Hi0091FcVV++AWwyOCNdqhlThREWdlqf42Nczcry/MiF2im/2CeUGwmbgVKXYKcUnii+juYIw0tDSt/Act5Y2BeLNYk0J7M8iFr7zkDy7f1pAbLpZoSRh9jLHsHmU1Cxcll10fFqiq5vXyBctb/yyedxDXZms/qqSfc5bgN9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUlfPIZOBDm3LSI/u6z9huvh+g8j82Ip1aVNRnHYDN0=;
 b=dV0BeuIuAy4igm62DrGiES+8KQAUValWdIK2f54Zvt1tOeaQbljqQSxFjKxZTWHD8BOzfcD4P3RjgU7z81Xf70pCMpoN1PQ3qfV/litVG5YZpWEbS73xIkq8tJNxFxkcPASpKMngD7tE6pIPKibrTTmJtEIvtEHAvmQg8dsW6Kd1Hi3nOhVuk6NkBG5Z82iX6w4Y9sI7A3dkGXQyufBWtBqIMgmeNhDfnOVZTd3KJ1rtsPMYSmbX1trExcL7ljcbvy4xJq7DV4nhWcqMlRUE4Hss9BC/7/iqDVRYHmcmprRNkObc83Al/4lkiVb3fr3SBB0DKeULVN5EFdY94HjIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Fri, 30 Sep
 2022 10:13:37 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%6]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 10:13:36 +0000
Date:   Fri, 30 Sep 2022 18:13:14 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yu Liao <liaoyu15@huawei.com>
CC:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <len.brown@intel.com>, Xie XiuQi <xiexiuqi@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <YzbBOuX37XpUiP4y@feng-clx>
References: <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
 <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
 <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
 <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
 <YzY6e0UwDAyU1GrX@feng-clx>
 <44206484-620d-abaf-4fb9-fc4ef1c9184f@huawei.com>
 <YzZDLBKbDTbNr45b@feng-clx>
 <119b669e-aafb-4d73-e94e-ef119f909cfa@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <119b669e-aafb-4d73-e94e-ef119f909cfa@huawei.com>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a784013-c085-48d5-13b3-08daa2cc7014
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ityGOSJN/0fBp62gmnmVffadzPg8qOjjoitdSjsaMjD6/8Elhx/8kQs86wimpI3wfc/zpcFnNFbXQY2dyccZohapzD/msZyPZl8G7rER5V+rT/IowwtfPWLEc3It+EByojfa24NlMTNLCX0Qzu9WLw24QosfCJXBumSN10FqphEwkiOOZ/XrYyL479eKFyY07TcnjqKFghjNf1e4p5c36A5ggKL2fu6SsG2XnLJcz7BRVyc3w9yUbkn+zgeezxTtigGYWg9apg5aELW/cHbsRHE0FSkh3YikjUMZdunQ2zIIDNPEgEauLMhR11S2Tf2FxgVHunBAFbxuunjEqBUz8nj5mvhr04PhaQy35ZeZFrsP11ulks9Ck/2rCEQz9u7UP/igNqtMBZ6IjImL3jSE4bU8lo3f+wll4ZR5PbhV1rqPd/e7Mn09/mVJZuAxDdxN9AyPMN+LldUmlDgYqqXJ1HDqpiDYfGKdpxH8RuTbH6gVPGK41h+0RkjjaU437hsEftUD2+qHesMzPEA3lQeGFFLMPD0arSO6rDT/WOF2/0Hi07oyZVWB9uiI9/fj5z5k6GM9C8HYDAGK/xBaK7SRbl+Z91bRg3YrLUjUp+PDkxMj3pWhgo+9KELAm30h6pumR3jTiMo8dYYHDbREf86aAJrso89HJ3Ni3zB7duEJXI7wMojFlZHKNh0qKV1Xaiad+NAkv+AP4st4xkEk49xi0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(82960400001)(86362001)(38100700002)(316002)(83380400001)(7416002)(6512007)(186003)(44832011)(6506007)(33716001)(2906002)(8936002)(26005)(6916009)(478600001)(9686003)(6666004)(66476007)(6486002)(54906003)(8676002)(4326008)(66946007)(66556008)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYcieiyvVBCnd+D8+TW9sn6YBMZcDNmrXPMh6bKUqrarJVnM4PjetCYbDj14?=
 =?us-ascii?Q?/vPDGbO+2BUfcFtDqkTq6V4mHVJASZm+CePXkWBEqhX2QwIL6I/4V2vfBnhl?=
 =?us-ascii?Q?+VxRxosd+eqxYkxQtR8dMxk3NBR17AAgZ7vdP/iAS/AfjPR8MCHtdJUC26kU?=
 =?us-ascii?Q?r1qAVvx+W9as6vlXP2PPk5e+qhzvLJx00HGZCyzSd0pW2gCFqwcLnGW6UZll?=
 =?us-ascii?Q?CRhGt76bg+4DijMNbY9JNd7XOE1UEJUpe1eXadMMSXlD+uG8xPi1Ek8uAwpZ?=
 =?us-ascii?Q?t5A770Dx475WetYpAliu84JUWxbG0K6ikzX57A5o3/Wy/7W5h7M+2UNBthCw?=
 =?us-ascii?Q?oPTUIGFQ57ZvX1+xK7WJrQ5k/pG3xon1Sp0ZpkVPcznnqTWEJ1Px+5O36Usm?=
 =?us-ascii?Q?8SrIsfrEAFlyPxBehwP7KUj13SB/vgdqPYAeTiryHMUak9+Sbm/rU8uQqBGP?=
 =?us-ascii?Q?DqUGIMDK8NPv/kOSl4tyOMq404ujh8Kcc9KDgfxOuelWU98jiyWBE8LiCSXK?=
 =?us-ascii?Q?3WS5N74JLZ7N4ZxUpRAVaaPgpFeQgKzIDEeKPv+C1l1LqmvPLXx/pkTQjIeq?=
 =?us-ascii?Q?0B39M7ZdQ1jmA7OcbTuu252BHG0uQiT1l0Qlb1gQ/j4C4wnSlC2McmSzaBbr?=
 =?us-ascii?Q?beW62I4nmInb8+Pgnfbm1hXkJszao41IpM0OZzfDHbfOjTbwOWbanv35T4Cb?=
 =?us-ascii?Q?A1BFtpNbCNWUVv8Z6HnO4sEMHxBQLv5NLWI7EWYJ+h1uNOpOEHmnu55+HDLc?=
 =?us-ascii?Q?VyQB69JVcbEkD0RYobbYh64pmSrWFPwvUJg5Cr0Lf0hr/quxUPLopUQ2fPft?=
 =?us-ascii?Q?b2yhHuhyBopZRd8HaQ/zIBkWjnGWm5KGAdF4jxfQjPeip8Ro4jnyc/YWE4uV?=
 =?us-ascii?Q?D4/WRQkSXKwopKm8uPU3r0fD00sxu996My2O7tJfEpEyCzoJlgkdHkuHdL7/?=
 =?us-ascii?Q?BBJntVGZEoJbU3T4pLCO2k3uDNJmk1jPMX4zc+z8cyO/Fv36uCUh79IhGVJq?=
 =?us-ascii?Q?b2vRlaH9US7PKoDJ4Z54M215A40pGAPvrSwocpAS6CZ8AHBNT2QVF4woDuP5?=
 =?us-ascii?Q?KT2GNgrW66c4t5e/My/k2Yd1UY/TFZw4b0SZY4tMY5TZy60km9eAJvzWJ1pv?=
 =?us-ascii?Q?AVXXdB3fw25xTQ+kvCEZohNk++JozOp+iMc/ADHI+p3egsuDQz/Oz5dPm6fb?=
 =?us-ascii?Q?9Jpr4c50UQpmhqDHxaRLvMLxn2bsIwtvUkjju8c3Fms6UZyk8SsaCBvfcNIS?=
 =?us-ascii?Q?L7HYZ+yp7mWgjwe9Yk0D74cpCuh/opJRx4ukEXFJKKzg9psj4Yt+IYk2T+19?=
 =?us-ascii?Q?vQ4t5lRcBUYRC1VrAHQgU9yLMEvlRsNxcqjNmYFr2LmyIjIj4DrYSyiwKKeE?=
 =?us-ascii?Q?raG+uspGNmXI/riOQAudt/a6xH+gRSOD0pvrrgkL0Awgv+GEUmgPTWT/dqRk?=
 =?us-ascii?Q?80DC+6V0OqHkMTHt1coiwfVCADXKcdiwLamWpEllAeYOnxkt44Kp6eKvetzr?=
 =?us-ascii?Q?68ejLKK6DFTGo9gWRgEKpRuhtHJkKAJyIMK0EDZGgBwb3/1p/QgTo+NJllJw?=
 =?us-ascii?Q?hZWyQBGJUM2RkuMEWjEpVMIkZn9Mdg9nirRDJLzp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a784013-c085-48d5-13b3-08daa2cc7014
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 10:13:36.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ltfAwmL5+wMX9asRwd9NsWNVoTxID31TUgm3MimI2erZ+NJ3/ht+6dQQHm4Ed0tKVx9WYn1BxLxveygfk/6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 05:45:29PM +0800, Yu Liao wrote:
[...]
> >>>>
> >>>> Hi, Zhang Rui, we have met the same problem as you mentioned above. I have
> >>>> tested the following modification. It can solve the problem. Do you have plan
> >>>> to push it to upstream ?
> >>>
> >>> Hi Liao Yu,
> >>>
> >>> Could you provoide more details? Like, what ARCH is the platform (x86
> >>> or others), client or sever, if sever, how many sockets (2S/4S/8S)?
> >>>
> >>> The error kernel log will also be helpful.
> >>
> >> Hi, Feng Tang,
> >>
> >> It's a X86 Sever. lscpu print the following information:
> >>
> >> Architecture:                    x86_64
> >> CPU op-mode(s):                  32-bit, 64-bit
> >> Byte Order:                      Little Endian
> >> Address sizes:                   46 bits physical, 48 bits virtual
> >> CPU(s):                          224
> >> On-line CPU(s) list:             0-223
> >> Thread(s) per core:              2
> >> Core(s) per socket:              28
> >> Socket(s):                       4
> >> NUMA node(s):                    4
> >> Vendor ID:                       GenuineIntel
> >> CPU family:                      6
> >> Model:                           85
> >> Model name:                      Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
> >> Stepping:                        4
> >> CPU MHz:                         3199.379
> >> CPU max MHz:                     3800.0000
> >> CPU min MHz:                     1000.0000
> >> BogoMIPS:                        5000.00
> >> Virtualization:                  VT-x
> >> L1d cache:                       3.5 MiB
> >> L1i cache:                       3.5 MiB
> >> L2 cache:                        112 MiB
> >> L3 cache:                        154 MiB
> >> NUMA node0 CPU(s):               0-27,112-139
> >> NUMA node1 CPU(s):               28-55,140-167
> >> NUMA node2 CPU(s):               56-83,168-195
> >> NUMA node3 CPU(s):               84-111,196-223
> >>
> >> Part of the kernel log is as follows.
> >>
> >> [    1.144402] smp: Brought up 4 nodes, 224 CPUs
> >> [    1.144402] smpboot: Max logical packages: 4
> >> [    1.144402] smpboot: Total of 224 processors activated (1121097.93 BogoMIPS)
> >> [    1.520003] clocksource: timekeeping watchdog on CPU2: Marking clocksource
> >> 'tsc-early' as unstable because the skew is too large:
> >> [    1.520010] clocksource:                       'refined-jiffies' wd_now:
> >> fffb7210 wd_last: fffb7018 mask: ffffffff
> >> [    1.520013] clocksource:                       'tsc-early' cs_now:
> >> 6606717afddd0 cs_last: 66065eff88ad4 mask: ffffffffffffffff
> >> [    1.520015] tsc: Marking TSC unstable due to clocksource watchdog
> >> [    5.164635] node 0 initialised, 98233092 pages in 4013ms
> >> [    5.209294] node 3 initialised, 98923232 pages in 4057ms
> >> [    5.220001] node 2 initialised, 99054870 pages in 4068ms
> >> [    5.222282] node 1 initialised, 99054870 pages in 4070ms
> > 
> > Thanks Xiaofeng for the info.
> > 
> > Could you try the below patch? It is kinda extension of 
> > 
> > b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC on qualified platorms") 
> > 
> > which I have run limited test on some 4 sockets Haswell and Cascadelake
> > AP x86 servers.
> > 
> > 
> > Thanks,
> > Feng
> > ---
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cafacb2e58cc..b4ea79cb1d1a 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > -	    nr_online_nodes <= 2)
> > +	    nr_online_nodes <= 8)
> >  		tsc_disable_clocksource_watchdog();
> >  }
> >  
> > 
> Hi Feng,
> 
> I tested this patch on a previous server and it fixes the issue.
 
Thanks for the testing, please do let us know if there is any TSC
problem after long time or stress running.

Plan to send the patch for merging.

Thanks,
Feng

> Thanks,
> Yu
> 
> 
