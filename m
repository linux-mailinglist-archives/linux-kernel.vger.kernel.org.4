Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CE665B77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjAKMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjAKMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:34:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE19E029
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673440485; x=1704976485;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ck/okKpPiwh90xXaZFvE5h8jz3taaVHvPK+BrW9nL5I=;
  b=UzF7Sb6B0RFIs0s8wf3xbeZb6iPGFphKHyMLJzyHpxG54ncKXjXnaKHQ
   EwHEzIZhWq2pbp3/6nEIVTyqN8C9xjGv+LXrFFAdtVdMwuBeV4z6slRX+
   FkA8uiI9HliJht0cYVyPvv/R5D34Ok1Rkf/31v3xNR68zteeXE0JnjQrp
   inns89WkSO7KT8AaCaIsCs2/yRh+yGYodSKE6h3BXsj1THur6TjBvHv/D
   LZYvcyUSGCHhuhbl7BO2kPJb7uBj/KKtJlgvD8RcMN3M+4BWkts1CujPx
   yO4qhONHUBK83IGOM3UrG0jN6JPHiOkyWAQBVVyTiMUA5+OhW0X1jI59Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303772277"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303772277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:34:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689754726"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="689754726"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 11 Jan 2023 04:34:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 04:34:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 04:34:43 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 04:34:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNKwwEi0DjUnhw7a0qFIR8H5WMHepKOdXAQm4waIqjyfTENJn8/Uczgyktu9nUALVRQNBLrhCSXepnEtGItVhoYJc3BHgQ07uMVhIe/w1nP8DrSeMRbJH1GhUkrHhU+u6Cnq5H8LKCzzcdx+B4q7nUA/BlVOrw4oOaOxO4cfnkDsuFNlo0wyEpxF0bMKIpnnV3gbY4xn6MEQcLJOOryZLHQrykcV7HBaNn73hLYbvSwbNLHriJCOyhbhrhbJbmKf/wqMxMd4hzbmdJWBD+PVwRzDZya4CpA9Jg4pK776Q0hZjYhsPLAJY31GEzGaQN6lWvCr3Slarvpe4Gw+3Mik4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvH9mamk2eCNA7I/xZdKrxYcWCzLf2B4ykJr2M+1wz8=;
 b=Ckhsap/n1UY/bokKwzVwx7ttTwwdi4XsZj70JZ2y9k8mKilxvQkGfl7Ow4Nm2MbNivO2CylUPFFEVxQNwSRJrEnafgo6kl5KW/TNKwU8JdtzIyToneD9lqyMe+3ub02txBjWEfsFRbBwofofwv6JlExCNlMk+Ff6qh1W7Go7fhhfwt3sLu90+ZWPB6ULDvhEBMGx8KYooTrxs0LvuS6c6tlyvFpvbyw52/vurJChs22O5qN2Gj0Exqdq4CmRSIzZ2jYn5qzRHTaqtfhQQNnGnuJAYOqK+1xxiHjiRgH5VQpAqLeKrz05IrXlNq5xdIktSMXg/ANdYgvVOXruTOmdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY8PR11MB6986.namprd11.prod.outlook.com (2603:10b6:930:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 12:34:41 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 12:34:41 +0000
Date:   Wed, 11 Jan 2023 20:31:58 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 5/6] clocksource: Suspend the watchdog
 temporarily when high read latency detected
Message-ID: <Y76sPnnX/73LuGez@feng-clx>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
 <20230105010701.1773895-5-paulmck@kernel.org>
 <87r0w1ia65.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r0w1ia65.ffs@tglx>
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY8PR11MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: d63653ed-b6cc-4b4c-9142-08daf3d03631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hWy8VG/wADOUWeFTrErJDii0unL7/fdiIwo7Hy1PwkRA2bL3qLlXiPBiVa28nQO/x6lz8YvYjJnXPoBhWkN1YHxc8a+T6WZJ3Z85xM5mqvVp32BDO50iVDrTph4tnjGwQIi0dxTg6xEadOXsy0EVWQKqtwtQGVgFaS1vRjiBDZflK/OhuwuI6Q91HZjLjJg8eXW647L7fhiySC3SzBbTf6c+Xxyo+gqwQuEswZhcS06bO1SQux+pkbNIwakyzRU+WSu6uXfHpvfZWsPtPJa9QPNyc18ASgcYiwx+sVMQ1vORk5fy53QR26e1k+BRiYmscVmlx+jPXMBTpKUB+As1rCJuVs5jJ9OJ5CQ2Jw9t0dAsAgNmBlW8ZfEQydtc/6NW/Vd1ATqz+w53J85mshztzcLTQk0Et8SQPrxEpOsXpEajXkHYGHWqEkRuIC8/KDoeancjRfckBGSksz/W2iMy/EdMk3e6tf+KF6qurdbjuleVai9E2qCvQ2Z385yx4Q5z0cztdcvWrTSOYQePQU3mTYre96D6wIm/KTorZjFLsGCoDNfENYyEM1HyHn/u1iGpHhjH/psAjPNU9Cp2/AAOuGIr7CpVI0MCpRjZJpW0iTldfFL3sywmc0eLpCvWNxuLD9S3DMBcuNeY3M+egJOTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(2906002)(5660300002)(7416002)(54906003)(15650500001)(316002)(44832011)(38100700002)(83380400001)(33716001)(6486002)(86362001)(82960400001)(6506007)(9686003)(6512007)(478600001)(186003)(26005)(6666004)(8936002)(66946007)(6916009)(8676002)(4326008)(66476007)(41300700001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYt2m4FoLjQ43eM682IbJB8/zpnnFmJQQA4Onq7sLpoG6Os/Hz97xmPLaBr1?=
 =?us-ascii?Q?ShGCjqX2ThIR76XwJ9KGiSSq/ey4H7uAsHYWWre2heukTbbDDkNWbykcaWvx?=
 =?us-ascii?Q?wmHaw2Q3cRUnfpt3PuibbqY3X3+0nEWpeKP/m3je/xtKykPUFQMP2a906Pha?=
 =?us-ascii?Q?HaxZxzTRj+oqZDAPxbv9wfYxfZVdzXZG2MonA/nhObnnRNBj7eMJxAPBQLfU?=
 =?us-ascii?Q?Jt0CAanTN9yPVVDUwACrrPRop1xTS5Duqykggjrtk10xd0zhs2F0l1iPyqHt?=
 =?us-ascii?Q?eGrsPguYzjB0NZoBVGAJ4VOKb8hrDQMZkhJePb1iTlb5pmWMV5RVRPIA/dej?=
 =?us-ascii?Q?53IOIMGpDoDxlFkDS+uVpocGjqQIAIXGLrH65TNIREN0Hs62Ssc1qOKW3bRt?=
 =?us-ascii?Q?zDWPaUY6WPLAhmo+MQ6GMR3YjMprrxbsj3t6vw4VNSW6UVKIwyRkcWiBtdrM?=
 =?us-ascii?Q?JSOL0y8SZLLhJxUHxitgIBBSWK2Rov1By5KC/7X7mzesRhmBWy1sxU/iGHi9?=
 =?us-ascii?Q?VbbQm3DAmGGxYAQnLNrqhEmczIbDxPwe7HuNpxB4cSbriq49stJrcrcMreCL?=
 =?us-ascii?Q?cas8b5r05YUdvBgT49kjixID/Gj/BOqn5dCPrpJbZydcIW/U0DJsrpv+VodD?=
 =?us-ascii?Q?8KQrRRFMJROBFfsIdz9SA4gb/i+U7TNI1X7TBlQBL1PN2ZsmFV9PelKL4/bo?=
 =?us-ascii?Q?Nm7PyvKQ5SDhraJxVUPcmIR8ad63Tu+Bx/abNoooFcDn2l1Ll5TKJrA5box3?=
 =?us-ascii?Q?yQM19UorNH5Iw4Z4i+/CjQsuKJGJUKvDphmjC02sENE733MSARsB62GbEcoN?=
 =?us-ascii?Q?1RzAeBwOkYmOjjW+/Jim+ne5AVR+Iqer5P6fLgYXQ79nF3W500AV3/136FDI?=
 =?us-ascii?Q?afwbfar+pXUIPQV/JVCuOUM+nHCs4+2apquVs5MB6WuPr1n3HaCM+QE3j899?=
 =?us-ascii?Q?Gc5xfRl9m7hqmva9IDMxVBN4iYExameS7JVWxK1c16NxcKAndE9MzXXGfnwF?=
 =?us-ascii?Q?Z1GoyxesSZjNQAgR4vm/46u6vrd+PgeGPvkJGwDseIhnKQ8s+dnE1sUSkBTD?=
 =?us-ascii?Q?Q58jenkHhXXA9Ifdn0kARHdpFSql+sulqMl5BMhP3xMi4+5AmIOWuPZV702j?=
 =?us-ascii?Q?Q0z+/hBLFfrD3NHnrriqdCOwJDEy95sDmF8n1mYBXJLqaFEleRX8Cy0QpQZQ?=
 =?us-ascii?Q?dLwZU21wkYMb3Duw/Urobl3wN5SxAeRpe66vcT3HZJwy7+QYkXm0ahi09BUR?=
 =?us-ascii?Q?qmsUsADqOeV7b5GoGhi6t8d3GzyXVTiN2gl9GUiwEi+7eTfrwjhFjoYeqbMm?=
 =?us-ascii?Q?e4SEct5C7B9I94uYerPVp4r/Xyrw95wM3fW8sQtVRT2ocOKGnL6iKHKgdTLi?=
 =?us-ascii?Q?fRHg3qtluiW2wBgHV3rt6eVMesqUPF7Ukkfoe74xUZI8QBOh0cUOo1cfol3f?=
 =?us-ascii?Q?xBxCblq4M1ovQMYjrOIZvdi39bPVKY5Bb9zVLFgCUW303bK9YgTbyF+fOJRO?=
 =?us-ascii?Q?oqBIfukyBNFTOSdYCuiWWFoRW7uGRR5luG1g7VUwIS3szHpLbnt+dhHWQ3nf?=
 =?us-ascii?Q?hJajwqWO5rNXb9hYZgDwPuMBwoBtTtfTsS6uNhyv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d63653ed-b6cc-4b4c-9142-08daf3d03631
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 12:34:41.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8NNBb2gs3CR0yoi9B3W2+2m459Lbe/tKX2aUEbwN1mKOBbqokLfK1C41ekTqc2RZ2tIwy7YDQ+qrsHFv6SUiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:26:58PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 04 2023 at 17:07, Paul E. McKenney wrote:
> > This can be reproduced by running memory intensive 'stream' tests,
> > or some of the stress-ng subcases such as 'ioport'.
> >
> > The reason for these issues is the when system is under heavy load, the
> > read latency of the clocksources can be very high.  Even lightweight TSC
> > reads can show high latencies, and latencies are much worse for external
> > clocksources such as HPET or the APIC PM timer.  These latencies can
> > result in false-positive clocksource-unstable determinations.
> >
> > Given that the clocksource watchdog is a continual diagnostic check with
> > frequency of twice a second, there is no need to rush it when the system
> > is under heavy load.  Therefore, when high clocksource read latencies
> > are detected, suspend the watchdog timer for 5 minutes.
> 
> We should have enough heuristics in place by now to qualify the output of
> the clocksource watchdog as a random number generator, right?

The issue was found on a 8 sockets machine (around 400 cores, 800 CPUs),
and seems with the bigger and bigger CPU numbers, the spark latency
of reading HPET or even TSC is very high, which does affect the
accuracy of clocksource watchdog check. And unfortunately, we can't
just disable the watchdog for these 8 sockets machine.

We tried a debug patch which disables interrupt and does consective
reads with 'rdtsc', and check the delta between these reads (when
system is running some heavy load), sometimes we can see up to
300 micro-seconds delta, on a 2-sockets Icelake machine. Similar
thing if we replace the 'rdtsc' with 'rdtscp' or 'lfence;rdtsc'.
And I was told the max latency is much higher on the 8 sockets
machine.

Thanks,
Feng


