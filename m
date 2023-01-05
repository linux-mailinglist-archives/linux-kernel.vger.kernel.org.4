Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FE65EFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjAEPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjAEPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:13:35 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6F54DB1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672931613; x=1704467613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gu3pfVdI/OMeBw4AFv8xRMOegKXMAOQ+wbpUqK+mOwc=;
  b=XNh6J0TtYHjzDaVURrZgA3nitDzjF6e8k47d8a1yremutXxk8AIvO9qa
   h9urq8V719BpDucy5+mHrlu5xkKw/+mB7n8q+MaJ7h80KIXWPUHL85PkH
   MsDlRny43xhR+D16dcUwbt5fcN9grb5z397s7Ue0BqiPr+iwkqeMio0aF
   pXkSkRyy3bEV9nDm1ulNEygHOWxdaVchJMmJinKijSBkPYMYYnyTKYN5U
   bnSnV9s6jNWLgqssictfLPBPJpclxTShmov0DEK3/LKF9jMY4Ow92PcKh
   dFCzj50xuNa944Ol5YpsxAE70t9LQfPtVes/04wswbqC7Rt1/lv0Umalm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384536135"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="384536135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 06:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900956849"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="900956849"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2023 06:59:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 06:59:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 06:59:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 06:59:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnOuqg7YNjRWrFZoSjDjTVYx1VVGX0sy271pXzuQJ3VY6l2OUdQu+pKkNwM6tn5SWEKJ220u5vvuqzuYhL4yKL9slsKdNYxBgY2IRTywYEgl0kl90w3dyeDyQMBiUQW0bSTJtl6h6tAyKZQSZ/cOawIJj8rvER1zrZW24Me+so48jc3KvEfIC7aTrkjNzdeCHqcUTLxmWhkFMA5Wt4YozW5ogxppzRoBDLzeBHkqw4WXQHtHBWpdVPeItPCLVKGjZ7WVuJwW4CDpiMkLCHFSp6z9o7i8dNjnlAjl1D7AB513OvGXA5arh7pjAEN2SMnqSzZfUX9a8c17WI+DQO7e1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inUBoSXUtfLxbe5s25WOQ87rlu8EEAX+VSu2EDMR8Ew=;
 b=K011NOtrzZCS5VXTh/J4SKraGdjbnRQ/DloHed3QfhBHAb8z9o+M2ujNsXEV8GrxxDyhjhefNQtHbzdg+R8M0UlhbQPSAlGtCjBfE9IT2Tlpnh4O4deDMYZTlDEk7JZsVliOA4FoSCB11Clp42TuBhkin9CvuEnG4hNhllreYTxXElfE9gWBC24WCX6+97twhQkqd3B8ZmSBWNFy9N2ZsEdrJLvys0+NGX0qh3aY3DXOgOXOPLHc+rPA7M9ejeOEViAwUE1xkFTsTbWpvI5AbysOk/b4wnMqGTuohYC5hKoNnd183uB+ODTv9+MMNX4+iflj+9OzSDfbS+ZGF4AX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:59:35 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:59:35 +0000
Date:   Thu, 5 Jan 2023 22:56:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <len.brown@intel.com>, <tim.c.chen@intel.com>
Subject: Re: [PATCH v5] x86/tsc: Add option to force frequency recalibration
 with HW timer
Message-ID: <Y7blMPSZZph2r86N@feng-clx>
References: <20230104081938.1014511-1-feng.tang@intel.com>
 <20230104143227.GC4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230104174634.GA1735127@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230104174634.GA1735127@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY8PR11MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe1f2d1-1ad4-4786-5b8d-08daef2d7582
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vd1g4dUW8VYRtY7UnGeSt+vmiXzxf6DQ3/Qcu3gCxiDh6GV1vDsNQZWtJI6rkHOlTlxv749JoY6wXH2nyB+QCmDnS+AQea1r5Q0PZeRxc1tNkLWlpN90q9bjv1NjlWG6tvDWdPKMeqCSrsP4DGpGbB35zr8E1VebZ0VF0IozkOzIlO0puZ73YMZ/DGJzqvEujv9XwmMOQ32QyvZ3GP3vMKLJbkuDWUqGic0QVl40hZmLGMYSID7qVp4zBlDX9hPFuRs69bUIYO42jOmCT1gm/G1lSVHtsqrbqB6n95jTQL0KcZbmFV1hovKcKFBMPxTHtT7kEYk5KD261MMJ40vviGZWYDMifupAogDvsExxuDBiEkmhfQ7cTx2FQwCVZEvmA0mUAPk9qKrfUjFYXm+RPhoeZBZe781tl6gMjZHSH8oiFBY0Ozisj+gUBd/3Uw3LxFAft2MeCwf55LosL80REvrnSNNzNiuMrZeteoOvG8zYot+uu1TXXANnkraWjIwYO7j9Ydp6NyGsVyo98OF12Qwb8VP+tRoHFpN58ZRXyGQFVf0aNk8bolCmtoCunCILwHJq9xTfmp7OPh+JA+/ScdqDn+fXSgJmTnL14CZnAtWepbLSRJZeTNpZMK7x/jGaCZ99Q/Ndll1So+klT3yCKb60j8oTPknTsJO7P4OCs6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(316002)(54906003)(6486002)(966005)(186003)(26005)(107886003)(66476007)(6506007)(6916009)(4326008)(6666004)(9686003)(478600001)(41300700001)(44832011)(8936002)(5660300002)(83380400001)(2906002)(66556008)(66946007)(6512007)(8676002)(38100700002)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qo9iscC5luldyor43poZL3nhL8AeV2XxPLPq4jiZXZtkSnES5NELArFjdyHx?=
 =?us-ascii?Q?OrAI86dh6L1vW0qBaYfexP38blsQ6HM2JffaSeCbu6hHHV2TIxYZZp318xGD?=
 =?us-ascii?Q?nXFaVT1wNu9KZJPm9VKDvL966T5zrGvBYFeFLlhLw1a40om8n8po27Fhpnd2?=
 =?us-ascii?Q?MpQoLRe3FStF56rVPi9yOCXRlgkG8OPyRkI7YBnh/ir9CYqBge6lDv6S7PTM?=
 =?us-ascii?Q?jx+2vmD4CVnWJx2FFuYUahD2BSxO3mncSUlYATp9dg4UYlAECOdoo1cm3YSP?=
 =?us-ascii?Q?RG6O8YTmR0ei6HByl7EobyVVTfmijTSsGFHWaG4fb728ZW0iwIKDaDzxgSvZ?=
 =?us-ascii?Q?fezP67Qrbb5HFM0K/ECxCYd7zuS1/ROX3ABSAveg7JmuSv1kUYLcs1A6jaU6?=
 =?us-ascii?Q?rNuMy0J/8N6PSNLA2IRs1GR2wljiRLsxY12yjUlclYyh+l4Tmtg+la2FP/ho?=
 =?us-ascii?Q?Hf+H2cQI84HzRy1uRGUFPMAkDBT/AKZL7VQybV6fXCCpxdqerznKNDSYd9Xb?=
 =?us-ascii?Q?kU05GqvxjhO7smnEjn+XQMV7n16dRJ+PB9E0o21SeZw/Ds3MpcgAEQx7gN0C?=
 =?us-ascii?Q?ZQIA4RlbnIFPyWxvw0t10NDQqFv1VY17YG8QLf/xy8+Lj7AC0bpqzo9cu7ew?=
 =?us-ascii?Q?KxRku293lFRKG4suy1lO83VEBAPMvH8g2pXl1UiFtjtJMB9iQwvhVs0+u3z9?=
 =?us-ascii?Q?lVFFfUTJr9VQtiyiUhg4YTquqjB2s7J8mhHXC9UHwRQHAS1HesvSOcCPu0yI?=
 =?us-ascii?Q?VJ4sHIWurziYVdI+wcO6vdO9HdpYNDGig5N7ullXlkyd5p+nmiJuzOK+gmJf?=
 =?us-ascii?Q?0qF8iOL05L7+r2/Tg3/tP9HJfFMrGUDV+ayiwIpdtHblszqY+SZbZnyNz/+y?=
 =?us-ascii?Q?hl/FZmHgGKqo3X2JyBGkavZ4IO0GwOG6TPDNe/hDl6zWwbLGpfK0MdKPIYhK?=
 =?us-ascii?Q?d++/JhGhD1lf0r7yW27s1s2SmQfronMTCog+2URFd3TJhmKxOsh0C6ltTweK?=
 =?us-ascii?Q?1ZdbK3I89bt4QTug1Z5zC2m/Db4uBMHQS987Khb7C2GLZ3FZWCphRpOokSoU?=
 =?us-ascii?Q?xT6O9tNOnSSqsZq2+rDZYfQ29wxvYIjvaCissfMGbK2SwCZBMdiR6n8B6eru?=
 =?us-ascii?Q?nIZVedn6uoRvBUqJfK0RhA5R38is/CmHN9SnJwRdql1dSKtspcXjx8mJitQA?=
 =?us-ascii?Q?aZrK4Ba7VkP3HSBTw4cAp9S5gNT8NhN00TX1LiPTQd+WSQAyYKs14VIWy57q?=
 =?us-ascii?Q?2mXSRnQFGsv853yGNZjCnIX/UQPQFRosQtZ9vpBMuJFsVZJz98xQPukfbYSF?=
 =?us-ascii?Q?qmQfeWW+QPwbmrXnfSPlQSGULAcs3ci4cg4m/TSxVc1a/juH8zNn3Exxkkkb?=
 =?us-ascii?Q?54jflVR1Oevni3pQ674T+kyWQac/kxUhDp3voVReo3rPx5Q/dclrv+YGHHZk?=
 =?us-ascii?Q?AVSU28+eD8WTb98ii+4fFKSheGLg6jvBMcHh8fpIpbsd/kFk+FEwVcMNq66H?=
 =?us-ascii?Q?X4fzuGv0CaVetpCmthMyUA+IBtuqeSCAQtsi+9haAulEQ7lScEw7TsUmab7I?=
 =?us-ascii?Q?4c9KSpIPsVlr0GCSE7lFx2P9h71JD/vTT2ryoze1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe1f2d1-1ad4-4786-5b8d-08daef2d7582
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 14:59:35.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACCOuOwu1dXIvsiheKPlUJ43ay++iDzfx2jZ4NZI5NedBhRQVpawG3FaTWCC4sSJiSoZvSQT67gwKBr9mmNo8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:46:34AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 04, 2023 at 06:32:27AM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 04, 2023 at 04:19:38PM +0800, Feng Tang wrote:
> > > The kernel assumes that the TSC frequency which is provided by the
> > > hardware / firmware via MSRs or CPUID(0x15) is correct after applying
> > > a few basic consistency checks. This disables the TSC recalibration
> > > against HPET or PM timer.
> > > 
> > > As a result there is no mechanism to validate that frequency in cases
> > > where a firmware or hardware defect is suspected. And there was case
> > > that some user used atomic clock to measure the TSC frequency and
> > > reported an inaccuracy issue, which was later fixed in firmware.
> > > 
> > > Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> > > tsc freq recalibration with HPET or PM timer, and warn if the
> > > deviation from previous value is more than about 500 PPM, which
> > > provides a way to verify the data from hardware / firmware.
> > > 
> > > There is no functional change to existing work flow.
> > > 
> > > Recently there was a real-world case: "The 40ms/s divergence between
> > > TSC and HPET was observed on hardware that is quite recent" [1], on
> > > that platform the TSC frequence 1896 MHz was got from CPUID(0x15),
> > > and the force-reclibration with HPET/PMTIMER both calibrated out
> > > value of 1975 MHz, which also matched with check from software
> > > 'chronyd', indicating it's a problem of BIOS or firmware.
> > > 
> > > [Thanks tglx for helping improving the commit log]
> > > 
> > > [1]. https://lore.kernel.org/lkml/20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1/
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > 
> > Nice!!!
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> And I have queued this on -rcu for further review and testing, in
> particular, to get it into -next sooner rather than later.  Hope that
> is OK!
> 
> I was thinking that this recalibrate patch made mine unnecessary:
> 
> b32498162f5c ("clocksource: Verify HPET and PMTMR when TSC unverified")
> 
> But upon further thought, I remembered that what we here at Meta need is
> for TSC to remain in use on systems for which it is deemed trustworthy.
> The reason is that even a short switch to HPET can terminally annoy some
> of our systems.  So I must therefore keep b32498162f5c.

Yes, my patch only adds an optional kernel cmdline parameter, and it
can't use both HPET and PM_TIMER to do the calibration in one turn.
Also, the purpose of the 2 patches are completely different.

Thanks,
Feng

> 
> 							Thanx, Paul
> 
> > > ---
> > > Changelog:
> > > 
> > >   since v4:
> > >     * add the real world case, where the patch helped to root
> > >       caused a BIOS/FW problem of inaccurate CPUID-0x15 info
> > >     * rebase against v6.2-rc1
> > > 
> > >   since v3:
> > >     * add some real world case into commit log
> > >     * rebase against v6.0-rc1
> > > 
> > >   since v2:
> > >     * revise the option description in kernel-parameters.txt
> > >     * rebase against v5.19-rc2
> > > 
> > >   since v1:
> > >     * refine commit log to state clearly the problem and intention
> > >       of the patch by copying Thomas' words.
> > > 
> > > .../admin-guide/kernel-parameters.txt         |  4 +++
> > >  arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
> > >  2 files changed, 34 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 6cfa6e3996cf..d9eb98e748d5 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -6369,6 +6369,10 @@
> > >  			in situations with strict latency requirements (where
> > >  			interruptions from clocksource watchdog are not
> > >  			acceptable).
> > > +			[x86] recalibrate: force to do frequency recalibration
> > > +			with a HW timer (HPET or PM timer) for systems whose
> > > +			TSC frequency comes from HW or FW through MSR or CPUID(0x15),
> > > +			and warn if the difference is more than 500 ppm.
> > >  
> > >  	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
> > >  			value instead. Useful when the early TSC frequency discovery
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index a78e73da4a74..92bbc4a6b3fc 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -48,6 +48,8 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> > >  
> > >  int tsc_clocksource_reliable;
> > >  
> > > +static int __read_mostly tsc_force_recalibrate;
> > > +
> > >  static u32 art_to_tsc_numerator;
> > >  static u32 art_to_tsc_denominator;
> > >  static u64 art_to_tsc_offset;
> > > @@ -303,6 +305,8 @@ static int __init tsc_setup(char *str)
> > >  		mark_tsc_unstable("boot parameter");
> > >  	if (!strcmp(str, "nowatchdog"))
> > >  		no_tsc_watchdog = 1;
> > > +	if (!strcmp(str, "recalibrate"))
> > > +		tsc_force_recalibrate = 1;
> > >  	return 1;
> > >  }
> > >  
> > > @@ -1374,6 +1378,25 @@ static void tsc_refine_calibration_work(struct work_struct *work)
> > >  	else
> > >  		freq = calc_pmtimer_ref(delta, ref_start, ref_stop);
> > >  
> > > +	/* Will hit this only if tsc_force_recalibrate has been set */
> > > +	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> > > +
> > > +		/* Warn if the deviation exceeds 500 ppm */
> > > +		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
> > > +			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!\n");
> > > +			pr_info("Previous calibrated TSC freq:\t %lu.%03lu MHz\n",
> > > +				(unsigned long)tsc_khz / 1000,
> > > +				(unsigned long)tsc_khz % 1000);
> > > +		}
> > > +
> > > +		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
> > > +			hpet ? "HPET" : "PM_TIMER",
> > > +			(unsigned long)freq / 1000,
> > > +			(unsigned long)freq % 1000);
> > > +
> > > +		return;
> > > +	}
> > > +
> > >  	/* Make sure we're within 1% */
> > >  	if (abs(tsc_khz - freq) > tsc_khz/100)
> > >  		goto out;
> > > @@ -1407,8 +1430,10 @@ static int __init init_tsc_clocksource(void)
> > >  	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
> > >  		return 0;
> > >  
> > > -	if (tsc_unstable)
> > > -		goto unreg;
> > > +	if (tsc_unstable) {
> > > +		clocksource_unregister(&clocksource_tsc_early);
> > > +		return 0;
> > > +	}
> > >  
> > >  	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
> > >  		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> > > @@ -1421,9 +1446,10 @@ static int __init init_tsc_clocksource(void)
> > >  		if (boot_cpu_has(X86_FEATURE_ART))
> > >  			art_related_clocksource = &clocksource_tsc;
> > >  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
> > > -unreg:
> > >  		clocksource_unregister(&clocksource_tsc_early);
> > > -		return 0;
> > > +
> > > +		if (!tsc_force_recalibrate)
> > > +			return 0;
> > >  	}
> > >  
> > >  	schedule_delayed_work(&tsc_irqwork, 0);
> > > -- 
> > > 2.34.1
> > > 
