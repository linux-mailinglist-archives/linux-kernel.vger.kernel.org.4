Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1601732463
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFPAx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFPAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:53:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A711B2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686876834; x=1718412834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L0IM7kkxQlfEwpTPPKmAYtf1b2iUfi4K1E4aQFdArl0=;
  b=Qp1jqOnjJTx6Legi05YGQ2WOb5py+8MwL/3EprpMBpcuozny7oq5F303
   Lha6+wlH/d1BLDYeqm6PUG9Fw238QsOX3T8JnjzXgxZ7naNIFlAkrkANT
   LeXGKxCppSHrQpCCM9IUk2UsLX3WIUWgaH5bsDZCgWOIZcMpXvgIR5qpM
   NC94uAcYp8OIZwuzUE93X1+AGFknsCdM9QWU30NBuuaC+I4+oaUl7DpEr
   GeqTSau2jHM0oKDsisaoAfHtDFe1zZLW38gOF9avWLMxjWqVyw03mMVIW
   XMKnY4mGnXBgQK9Y+0ouQeZMJXh8US5FA5WgxqAsgc0sNMgJlnGN/TK+z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356569696"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="356569696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 17:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="690009794"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="690009794"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 17:53:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 17:53:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 17:53:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 17:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPE0+WHCi27GDIf92tW/dlGxQEJuAs2BPjqUi//PirHRWGnTvHYVnci51/YEHamMTY3W9UPn59lMMeCpDS7Gt+GtGc1rw7SJiwsqvPstfUsaxMd9Jc8mwI8eEeOd+1OGszhe1vSNX5lqeGxeNwjTebvguNg5OdwmZf/q6JAAgPWXVYUJtWmqFhB7V2PF8n7UTkXYTgHAH2ybcm2xmPKIXPd+suzasUWF4rSyk83qzHSiBgJ8KszeY6wndvRCdtsgYPZ5lVdk+7CpIg0xeqiGPtIgmIcCTsiqLlTUwe9/idNXDtac48U9qOkFTYLBSrlrAH6UmcQkrUwYQpv6t4XXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRGD7vBeTsF5XTpdoT9M25aeCvMX66OmkKaPWNW9GLs=;
 b=Q6QaEkeZSk86BJ/gwT48xzgIJUnix5NaWQ4PYI7UXkkEhYwmTQCIoSWgKezxHcfuwjks0N7WYUAPTMmFYI2dq+uGoZH/RZD8z4FmAhr5hPtyphuYbOUCsOdtSze5N7R+vxN0VhEkwbPVQltM63nl26aIE5/Fho5FsIOoBQrtWI7coq422yZQvPeilCUjtbVihsgJUGe4anQa/MUHZPK4lKH9ArCNJv8DdiWzU8UOLGCMNjkyXB6anFI/WqLE1l81FGk7+uyp1gGOA5drX9ARzcGOK3kGChkonTRifQl5Lg6if3xsR3Hveawhzq2LBjogeSAan+VSxrQcuZpofCbqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 16 Jun
 2023 00:53:51 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%4]) with mapi id 15.20.6477.028; Fri, 16 Jun 2023
 00:53:51 +0000
Date:   Fri, 16 Jun 2023 08:53:38 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joshdon@google.com>,
        <roman.gushchin@linux.dev>, <tj@kernel.org>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230616005338.GA115001@ziqianlu-dell>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230615232605.GB2915572@maniforge>
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c7ceaa-d796-440f-c877-08db6e042681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNtep9SaKsqxVyHIVG4PXNpFEMDifzAvzvHsgIbB9V5gqAaROT/gtkZenPW2V0ZLuXjDmKb8m3gv26OnZfc/q5YblOh3g3Ku4hvCi9PfrH2jFW/jI6b4AwNnZ8Bry+PvxzU90JWWNo8o6RVhpT1NR5NfbNLT+Bd43Ybbsi84TZp2/jpDa76GdndRcAg9tRsEOa12r3IP0bKDKN7L+nLS7xNM5I1VnkUWuE1giarUa7OfuMhsTph/yjmjt9BeLQxPicBBJpK5JFigGbszvqRx7UhzYt33xIsqG894ckGaRmnQCnaEWHCVD8RtkvjDZ9z6fPLBZsGfaVCNNehVk4YnU1RhluWCvnofO9xnCRtmzSqRfzBTfiN9OZkM04O6TaKJVfApG+hjDwtFcXtlCzBEiqen/cXE/yYe1Rr5Ab3amDxPWQyIY5uDt7SmcK2Fwj884DEQszAttsO66Q09OSQcoMYf0JGmhGAmZDzYyx3+oyU7x1x/t4olzHqzofSLgJbb+Cwo684ho2kHZ4NFUmk1ukt6XDjrQgm4EtoM25kV4Rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6486002)(6666004)(966005)(83380400001)(38100700002)(82960400001)(86362001)(6512007)(33716001)(33656002)(1076003)(9686003)(6506007)(26005)(186003)(2906002)(5660300002)(8936002)(316002)(7416002)(44832011)(66946007)(66556008)(6916009)(8676002)(41300700001)(4326008)(66476007)(66899021)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MjaCUN9nn/4/xNvpfsTNXVMPqPAPZp0Xl5yw/QfuNcaUHOFsMEvKBSQpYeEH?=
 =?us-ascii?Q?s9XaT7Ex9MHX7qT9N9rUrFwseEmnifqh3vWituWtHdrc9HdOp3UlNu3iQ6Ss?=
 =?us-ascii?Q?pkIKGDOIPuIlvwmu4cVZ38JDbALsPHXYeZN4JHrEBXSyFtg4iOkdsUbbbiZU?=
 =?us-ascii?Q?7Uc3V2EQg/etUTNrtF65xYi1QzpjYkwtggrPOf7sSVzk3bcX+uuiNTMAFkAi?=
 =?us-ascii?Q?x//TqM9rmkOBC301vjlaEoijHROcHkbTfw+1IkMr20a82uuj2fAgNfl9Uo9K?=
 =?us-ascii?Q?ZYMzohvt5+b3UE9WM4OfzPxDV+jgxpp1hJl+U0/eF0mg9RlFdjuFNea39rKA?=
 =?us-ascii?Q?CnNF8nM72H9hSeNq+88InMF/Z1oZMv/dfJ0tVYMvamdQT85Z8NXG70g1sHVi?=
 =?us-ascii?Q?dUIobM8guUB8R1vucsFKI4vQGCi66q2lrd4Yi/WFwBycM1B+Cgi7yog5ir+Y?=
 =?us-ascii?Q?cvYJRSoo/sw439GC1vodVNVUJaADTBgB+WJybOsBF5i4kejax0zjqG+lc4SH?=
 =?us-ascii?Q?5XJ5Jnmc0faOSGeuVtTvGE5SSGAvoFvNqCJYRl/eRy/attGCul2G0DR31ErP?=
 =?us-ascii?Q?YBCLJB0CxdXgzPCM//NxDZoBLFF7BEtMm1fTDf/eld4T1xXkRRSUmf2a1uPx?=
 =?us-ascii?Q?aJe5MlWPT5WjG5mcvO6Gfm0Sfl9dUOGoEAyst0cAWXXt98qmIVlbS7H/p5Is?=
 =?us-ascii?Q?i3w7nzRd0beY63lX74bDg66kg6zbEdYSMuXBfQld59OSabbtP4HUFwXdAQDM?=
 =?us-ascii?Q?IO0uGFcwulKO9AHGVH6RCb66BDmG7isgWs+uKeepk9ueF+4Mgqdm+9Av/y/Q?=
 =?us-ascii?Q?8bDseVoUrmCP/+t0MgswQ39DSVNfoMohS0Z8mCv5YkE5HOga51ukgLhrKa0N?=
 =?us-ascii?Q?asqM4DQl+DqR1/QDsQwHVl3EZ0gQwd7tBtKNoO42phcDdHrslA+12uVAMgDT?=
 =?us-ascii?Q?JGF1T8hW+OMMUMeFeSXSyf4kXkezi92O8I+80znQIPmn+//27quTsum1jD2O?=
 =?us-ascii?Q?x0a+eL/sZjZT7aTAVMA1zds5Tu7LTL0Ts/KM5121b3uxk/kpWAYFr8cvkh3t?=
 =?us-ascii?Q?jS7FQnjWhNfRuCAzAoT16IXc7H83PDHwCxIDPVKFKutrUoAFbngCt/YL4KsY?=
 =?us-ascii?Q?4aeZuGWpaESEY6Dl7onRHaTfxN2D5l7FJ26lkzWmO2KIPgzCkrihswORIsXk?=
 =?us-ascii?Q?2+KkWs5BF7G9MWCcG/Nqq4kT6/EBpnaTU7vKCj+Ecrv645AQRwT1DGNhofGB?=
 =?us-ascii?Q?bEcrFN6XFzM04wZyGzt0tmS4yz5CURIgecHlHFteAXu0kmYGX9Wo8j5SMQK4?=
 =?us-ascii?Q?aGdjFXR1vheGK69wFXgbA3OdZWk7nn0cu6TXIwcemJWNDClPVBsjqM0f7M3H?=
 =?us-ascii?Q?LuivKc+YhhLQztfa/dOFQO4qYNSuGHJBPzv1OxHE1R4QZ0rJ2Cxl5tZSZxzK?=
 =?us-ascii?Q?X3lCAxP1Fq6xWjwoNp+z/aubMSgFxR92YYDSnYfq/PJdMD9nij4b/riwiefP?=
 =?us-ascii?Q?5L3bCnXFagYl0nTQuRuEmbtkhazO1TnDjQvxs2n5ffuLXSXfMwsmK26RPK6y?=
 =?us-ascii?Q?kzDcnqpPUzMhK25zavAOerEbYfnle3Sds6w0Fw84?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c7ceaa-d796-440f-c877-08db6e042681
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 00:53:50.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/LpiZbDH9kSeXNY5FYmldiVhUCKny/c8GF9W8VPpJ8Wh5zFHuayo7YIPQr6yGQWYU4J0xZj16EDvnlwS5sM/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:26:05PM -0500, David Vernet wrote:
 
> Ok, it seems that the issue is that I wasn't creating enough netperf
> clients. I assumed that -n $(nproc) was sufficient. I was able to repro

Yes that switch is confusing.

> the contention on my 26 core / 52 thread skylake client as well:
> 
> 
 
> Thanks for the help in getting the repro on my end.

You are welcome.

> So yes, there is certainly a scalability concern to bear in mind for
> swqueue for LLCs with a lot of cores. If you have a lot of tasks quickly
> e.g. blocking and waking on futexes in a tight loop, I expect a similar
> issue would be observed.
> 
> On the other hand, the issue did not occur on my 7950X. I also wasn't

Using netperf/UDP_RR?

> able to repro the contention on the Skylake if I ran with the default
> netperf workload rather than UDP_RR (even with the additional clients).

I also tried that on the 18cores/36threads/LLC Skylake and the contention
is indeed much smaller than UDP_RR:

     7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath

But I wouldn't say it's entirely gone. Also consider Skylake has a lot
fewer cores per LLC than later Intel servers like Icelake and Sapphire
Rapids and I expect things would be worse on those two machines.

> I didn't bother to take the mean of all of the throughput results
> between NO_SWQUEUE and SWQUEUE, but they looked roughly equal.
> 
> So swqueue isn't ideal for every configuration, but I'll echo my
> sentiment from [0] that this shouldn't on its own necessarily preclude
> it from being merged given that it does help a large class of
> configurations and workloads, and it's disabled by default.
> 
> [0]: https://lore.kernel.org/all/20230615000103.GC2883716@maniforge/

I was wondering: does it make sense to do some divide on machines with
big LLCs? Like converting the per-LLC swqueue to per-group swqueue where
the group can be made of ~8 cpus of the same LLC. This will have a
similar effect of reducing the number of CPUs in a single LLC so the
scalability issue can hopefully be fixed while at the same time, it
might still help some workloads. I realized this isn't ideal in that
wakeup happens at LLC scale so the group thing may not fit very well
here.

Just a thought, feel free to ignore it if you don't think this is
feasible :-)

Thanks,
Aaron
