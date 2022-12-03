Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB0A641200
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiLCA1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiLCA1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:27:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE77F37E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027225; x=1701563225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hmVOZYYzKne42okVvFPsEfB/c5ZW77QuseNyn/+M7Bs=;
  b=ZT16u1137ttk0zvMqwm2qKvRtBzPs3bH8jbLSSyh1G0+rw02M45fzzQm
   9oTywx3B4xsktV2Dd9XialxAdkkxNclS4hv3kq8Ro0qp+ITULWXkmq7ft
   9YXUfDzTCdZFTHWggdOLZ1jp9t0dzmezhZkQx1aa+fiUpd4DBf250zxOq
   Y9IFqueR0ndkUJ0HpunomzU4R6AtaG7jJjC5ytCNghhQUFh9GJUP4MOKv
   guLljgzI7B4ug3NNFFGRN+XVGb7+Z1+cCGgheq4R8jdMwKEBdXxjSk9q+
   GB4We2G87BFR47P2hL8lIMJ3PwA5Y9yIOHMB2i3wh3yUH5/6Q1u5AB9Ot
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="402352852"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="402352852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="733996326"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="733996326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2022 16:27:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 16:27:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 16:27:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 16:27:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e67xH8VozAUiZqJSRJpaxYjamJcMvP46fgpGiFSqwB0/8CtBLNx/fHtcVDMCfd/pYV+B2ZyjUH7cdmtipwm0U6d9WFOMdvhB1ae3qZVag3gwPeVkLVA/jCFNk2L8I1ksNvNkLJDa7h/aQ97/vzGKXnscsgvZ7MGztKQYKgQl7buDsG9bBLMytxNu5ZPGOH1ziwst+SW3E5ZpwJVp5LPQht/B3oa0DD1h6+A+Vdyy8nFhM/WfsH0C28sSuNmi8bzDnj1Xjhc7gk6wroEDQn8l1hViT4mDlynQiInr/mPRqdYsC2Hue1xwYRA3XCvCv7py2Py+HzdocqWN3fh/dYmtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF8H6rMfN3Az7pFlv3RG7gK6pcKVeeIL2ylHKtQayZM=;
 b=OIYWesoAlbv7ocrE0jJLwOeRa3buNWseikK8eLiP7pO9PaQdDyv1Qz7AulwA/2m2+BR+VwdiUu1l/cCRYNAZ166RK8+mFE7ohvSEFBSW3Ppxoq6rRWFQWd+OLI7HSfrahVCMeaCqM2EZzX9WJ/d4eu2AbYoBaL6k14gzkN5yPzmzKmtLdSGfAYnvxru3lDXjan37tmewcZHs3d1S16Zl4yFnCdD3IPtSGLru7B4CXQFZysLfnXqnFNqTMcegLsCal37aEQgbgEaZ6oIrpaKq5p3Ip7ZbRgDTWWmg3Pg3iSQlaTbgc51IQX1ba1Ow2988SkkXQLOBtEFoPeM9ADDKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sat, 3 Dec
 2022 00:27:01 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 00:27:01 +0000
Date:   Fri, 2 Dec 2022 16:26:58 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 1/7] x86/microcode/intel: Remove redundant microcode
 rev pr_info()s
Message-ID: <Y4qX0uGWhqWO3vee@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-2-ashok.raj@intel.com>
 <87cz91pr8d.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87cz91pr8d.ffs@tglx>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS0PR11MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cb10b3-29fb-4bcd-cd15-08dad4c518a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lQ/eCu7s7JPTcHfFfrKWNwI37yEqo8wz5kaH1XYuywPuoR5+gNNCZhiIrZDoiD8tNSlM6Y+lmGfnYSREO2ga2W9wQteGRpQONUCAwgPnLdTkPitaTxX+SXa7Q9mBlDHIUNgTLr2+MZJRwc+c8bP9vWOQjPFVD0HXkxYqDuYSutfnWKmZzVP6x2YOzzJyfWWHd9ivWNU+lECrjHQy9mv9IKgbNC8BZX0V3MbXiZNgLFhKHtgtSSODd9PxY/5LqFZ+Q5guBwFMzYVRGC2frWgzgyN/JaZsZYvLvniKxDm6BlhgoRGmbyfNgqTLrxEfPU8EwVX+Fns93d2NLBsgA6ZpnRzkKFp/kyP1u89CTtQJYytgRQH9vWPQ+A0LFTavDpZ+C0LAu3VAYwW9F96eHRZLmHXFWykF0YZOgMHjHp6yuDZ07nCgS9lx0hvA2uV7jSDyx82ACPBtLTm6y5FoprZr0Ww25fso6g4Xj92CR5pMnP7GP82v6Qs77c3J2p6iplFwgz2mezOPm8yTNqHjgOSBajikNkzgEmxLZ0gxOri6TNxkJpnLiPCMOzcFAJz7BvruyZjV+oZDDfIapixM/ANoPyJWXAyJs+XYFYgjlRNwtbXWM1qzTMuX3Wn4SYZIw7agi1C/UW6pe6oGrt3WpR9rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(82960400001)(26005)(38100700002)(6916009)(86362001)(5660300002)(6512007)(316002)(66556008)(66946007)(4326008)(66476007)(54906003)(8936002)(107886003)(6666004)(8676002)(44832011)(2906002)(83380400001)(6506007)(478600001)(6486002)(186003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qzyLV/zH6vbU9GETdvNQ9vwlgXY+sM3fPDarLnBT/YUiqmo2p2KkvmiMlra0?=
 =?us-ascii?Q?Hk8TAnNDLJoxLrh9c608Fc7Tw1/XNCa8M5cWqlsX1hXfqkE7XgaEW7QfGGyX?=
 =?us-ascii?Q?c5sse9iyx1q9B9NUCH6n4Aw0xIirY5gf3ddxEa7rdBMklhkDD617um6m7FBL?=
 =?us-ascii?Q?Y02AHzSmLfpIBRJd+7UsgZw8mtUSExza5s1oUwc1BqSpcjkU2a5cnQMHt0c7?=
 =?us-ascii?Q?RIDIZDR1LggPEne1UC4vc7U4fYVINf5oq5KjNTEThGGqv8V5dsces2AWslvy?=
 =?us-ascii?Q?mdurwQe5fIrZ+Yj4OKTF1c0kKPJmAhlom/L3gQo7P++Ac84fepZdkU1GM3wY?=
 =?us-ascii?Q?VyMKu5EB3Jx8sBzQ1QN3iMGSgnmFv7VNxFl3G0mBrVXmZszAr3D4Cu78bK9I?=
 =?us-ascii?Q?6b14A4b0Ps5du8LgCxeTX5nd0foEzSyw3aXytZ9Qe7bI8e4XKLIkVH1gN0Xh?=
 =?us-ascii?Q?gn0qe2aOFSEgUH41KifxvYdCsgINm7r9M1UGOvpd9dgJjTUPp1/jL6rLqF40?=
 =?us-ascii?Q?RSaZZ/m01Vf4HKQiu0V/teZeKeOLk6IL/LPjYXET/FiiQ0GMGnWSeRoHcVBS?=
 =?us-ascii?Q?3hvHtc58TMuEdCN7sPh8WoLirb08bcSxyF+bbZScF2UKPZLA9U5H6u5+g3qY?=
 =?us-ascii?Q?WDG4i8T/B/1m02+A6S6YCbfgp4hoKgPDuGYVZx0AExOzi2jdowgvh3jGMLAp?=
 =?us-ascii?Q?kfepkJ0ObMG2jwmEa2uN/I5AGLYS9kc9DfmZ1E0tUtTnxEG48zilFtH8goo1?=
 =?us-ascii?Q?S3qhQnt0tgKcqgCoz+6hSxRlVR8zZjobWcW78rkiXrmX9/lslplU77MV6oqF?=
 =?us-ascii?Q?gDDXMcLWymu+pRamp+s4lje9VzUqi92P455c7IGI8wLt6qARGujycct/27nR?=
 =?us-ascii?Q?SYaKby7evzYTA1Kfh6sFphX23msXRtt5jgELgZIQp0l3Cp8+nyDk2seAAh61?=
 =?us-ascii?Q?iFjnW9vRnf/fwtO2/cDR2XkbxWUSH5rUzZQlv+KC8d6LZG4SkHDYdNyVC2cn?=
 =?us-ascii?Q?fRXEFS1WrH9B2EZTPG062+1dzITvNyJOOFizqfuGb8wlV3lVkZv2FvhBDdmU?=
 =?us-ascii?Q?fqmolNHJNsU+2kB12hTwKoXCMtBGDYOofuC1hK2DwGKHOWQb1m2IXcwJjS+O?=
 =?us-ascii?Q?frM6h3a6ip8Gl3P9oqbkjlfK+9tI6wpV8IU8MZwZS3xTv6wUtb/Gk259YL3y?=
 =?us-ascii?Q?K2D3hY6F+opHq7e1/WnOMw5T9oqpc5vd4BRhg3z9uXSvLM3q0BWCejkfJwk0?=
 =?us-ascii?Q?NM95bv/IOH3rAyQY5XBQqGwKAWc8/QyVRi29232gSvqP1yBcJN/uPYFpV+71?=
 =?us-ascii?Q?pilyu+MkynkTD6bFM7hKDvQHnR8UgkIiLJhk+bi1xUSEwHTu7/w57UzySJdu?=
 =?us-ascii?Q?0jO9NdiDJKlHqdLsJW7qo7ak+Z54BMpw5aLXMpiBGX8x2rCHZ6gMhJZrTmJR?=
 =?us-ascii?Q?KFcz8oQm0hLBVMV1RqCv8M6GVjhDPYgpn6nP7SxfVCi0hBlkRhXOgh1hnyRX?=
 =?us-ascii?Q?ARH5IDZxZ/x2Lidno1jWAiZ2fOam40qK0O9V2X8EdDMlhNNsd06VD2TOXsy3?=
 =?us-ascii?Q?ApUFfai7sXrcCCifVF3/2qmEaCoig+952BUVVjjg4E7h14kTMlS0uct/kHsQ?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cb10b3-29fb-4bcd-cd15-08dad4c518a2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 00:27:01.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOrSCIC/U3wpct236FZvJou9Z3bvrR0TZi7r7WoI1sVhTmGTR0xPgYr2MrN0alYS1AHhePBrHfZQV4lgV6Xugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 07:58:42PM +0100, Thomas Gleixner wrote:
> Ashok!
> 
> On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> > There is a pr_info() to dump information about newly loaded microcode.
> 
> There... Somewhere, right?

I'll make it clear, updated commit log below.

> 
> > The code intends this pr_info() to be just once, but the check to ensure
> > is racy. Unfortunately this happens quite often in with this new change
> > resulting in multiple redundant prints on the console.
> 
> -ENOPARSE. Can you try to express that in coherent sentences please?

:-)

> 
> > microcode_init()->schedule_on_each_cpu(setup_online_cpu)->collect_cpu_info
> >
> > [   33.688639] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
> > [   33.688659] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
> > [   33.688660] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
> >
> > There is already a pr_info() in microcode/core.c as shown below:
> >
> > microcode: Reload completed, microcode revision: 0x2b000041 -> 0x2b000070
> 
> There are quite some pr_info()'s in microcode/core.c...
> 
> $function_name() prints the new and the previous microcode revision once
> when the load has completed:
> 
>   microcode: Reload completed, microcode revision: 0x2b000041 -> 0x2b000070
> 
> Hmm?

Agreed!

> 
> > The sig and pf aren't that useful to end user, they are available via
> 
> The sig and pf ?!? Come on, you really can do better.
> 
> > /proc/cpuinfo and this never changes between microcode loads.
> >
> > Remove the redundant pr_info() and the racy single print checks. This
> > removes the race entirely, zap the duplicated pr_info() spam and
> > simplify the code.
> 
> The last sentence does not qualify as coherent either.
> 
> Other than that. Nice cleanup.
> 
Thanks!. I'll try to get better at the commit log stuff 

Updated commit log looks like below. Hope it doesn't get a -ENOPARSE this
time. :-)

------------------------

This code in collect_cpu_info() simply checks with a static variable "prev",
but when multiple CPUs are running this in parallel it is racy and we notice
the pr_info() couple times. The original intend was to print this just once.

New sequence shown below:

microcode_init()->schedule_on_each_cpu(setup_online_cpu)->collect_cpu_info

Resulting multiple prints below:

[   33.688639] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
[   33.688659] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
[   33.688660] microcode: sig=0x50654, pf=0x80, revision=0x2006e05

There is already a pr_info() in microcode_reload_late() that shows both the
old and new revisions as shown below.

microcode: Reload completed, microcode revision: 0x2b000041 -> 0x2b000070

The CPU signature (sig=0x50654) and Processor Flags (pf=0x80) above aren't
that useful to end user, they are available via /proc/cpuinfo and this never
changes between microcode loads.

Remove the redundant pr_info().
