Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C6605955
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJTIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:09:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8587318
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666253359; x=1697789359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KQvcmijFsVkudS+7DiLGpNkzsMW1fgNMWfhrv0VNxoc=;
  b=QOsBBzDp8EDjGiAP3+5o/Pph+4K1vEsWWWS+J9VksbPf1GjOIXrjw5qg
   IfJ9au2OG/BwqpZrlaVj3vGITH+pLM9mjWvSzQr4QeYU7maFy7GHFyERk
   zZtO5mzxMCpL6ATPa7kaJsysAij/FV123rk06Bwm7e7AtSbe/NYmirIZc
   Li7gDHPogx1t+mw/hoWXchSBmN5cA2h9DJYrFRPd8K1A8M6vDXzRkKqy+
   6htKIm17uwVzqyOIcrkHjToAM0AEfgysIzgjTADllJQW9wb7LJ5miZ1ER
   kpidXs5hQPkywAs/8oQSX4eNVRCNCmcq4xK+nX62BvW8E1H1iiDyfvqmC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="392947066"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="392947066"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="692837038"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="692837038"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 01:09:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 01:09:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 01:09:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 01:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4TDFM1aguLrk5dt59QBubXC70Cgznljiq6J/PJvny/RS2cwUQw49MbJs5c5ioZ4yIBcTtMwvBCpHwc8pOgAT5bg6hkuWpb5HbR7UTZZ5vv170PN+lgZPfVRyL/+QQENWyIbfi0nzTn/55Tma3PgvzhtjXlY9Um6VNH0nB8emwYGi7erqAsmDUf5Y1guQdH6ChATvOKEeLXg+PaiQPd1PbJxngZ8FdkqD7luz2oIzr5cLeIy8AujFkkqpMn2h+JESk3wWA90H1iKYOzqBotDfD+cLT1FrXsBz8kn/r7sEKKeo5tri1eQF0myQ0DPX59LjGk0w8Xm/7kGnyIxblnOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyyXkVNQTy0XoTC+Ll58pGCtH4cvfl52OyRXAV1plso=;
 b=TpcMoc7+3DJTmnejZTBC22QE5mhEzaNkvJHJaYPf2KDKSl+6fkgKOpW6y1VrYU9QjuBHmbonBfbBdLN8Mhlio++Z+Gqo6aHP4jve1kUtUN8ERXyMIUtPArdajqilsonJ+ILjutrnHS7DpyrJFya3qaSp4e0lFU992xkK2hFGjct9JzYrgTAtXELQvQ01MJCKAgMdaj8Tp99QUL4UkTE/40JxvNlx8WyfCYboTTRjI6F9k3OmmrnvziKxhRka/YkJHQmX91lS7g9REPpljoDwWJiUecR+USD4BTV1uhwuBLqpRkY9ZyJuAKAJ74dMmbTbmWg/jfoRSVjFJGKGXIssig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB7630.namprd11.prod.outlook.com (2603:10b6:8:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 08:09:13 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 08:09:13 +0000
Date:   Thu, 20 Oct 2022 16:09:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <clm@meta.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <longman@redhat.com>
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <Y1ECHVUHilqgKD9o@feng-clx>
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 36818e28-26d6-4305-2a39-08dab2725fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBc/rnb5XcWM1Mx+/213Ehf++7XsaVsYy3eZz67M74nnKxwePNrI5HyqiaBakc2YR3rPvPVAOi2mwj+LdI7dTVYdFITBXExvmMfQAp+ZuRJNYivoV4GH5JIDE46GHVbq59rUugXVunHsvjY/nN6YR7s71n4E4bSW2OaImZlIpFuSV+W0wLZ0tyGuIAT2KMrEeBn0k5X1jZWsOnak8Ey5TvgcRJ/rgT89ILzRrWL2HPM7cXTFcANjttN6LOuOnZHhika3itlfqa9VMiThcAZ3padMIoVukzW+m3Cby6tAudw9wzE09rsjXVgaQB8xxtfIo5j0WVNE/r3ARsoEZ4ykGCkwF1PSRMoPHubCdsdZrOXSLWshYyqv67eBpozPmJtNmV6PEe5IrSzrBD/9t0f2Sv03vVq0y+Il6pdiGQvH3RKbawLPGckf97suIbNJVbtypiD87xmGUFOJIpM0dZQXf+9p+fBpXJlEs9XTQy+3KhMgo4FwQP8+njpxdpBjMlq0OUqqyrzmtgl++L1QJAxduS6FEkZtNqbJii4DdW/Lv4fmJxljUFO0IjFZxxRdbWCAV1s39mA4F+cHXcqSyMHaOGbnBCjzS3nYppR5rmRVGEmvlA3kycZsIjcWME24rdTG8Qm4Ry7N41Xxm6C9ArZUkNyh6JyU4KaPnLVtVmF0LZgPav0rOkuLXIbVBRMrERe0hPy0UEzzEEwaAPYDV/PzJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(33716001)(2906002)(316002)(83380400001)(6916009)(86362001)(82960400001)(38100700002)(44832011)(478600001)(66556008)(66946007)(66476007)(4326008)(6486002)(8676002)(41300700001)(5660300002)(8936002)(9686003)(186003)(6666004)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvIMFHcsW0jTZ/LNyKtrH+QKT5zZIrG2UwO7urGv6Y2g8gx2UT5NRxqSmKDT?=
 =?us-ascii?Q?QZt5moxpKmuapsRO3S7YjkwkcO1NAKr2fz5x//994PxEYYAL472+LUzBkEct?=
 =?us-ascii?Q?wLLvj+6KIvyujxDZCV4OpvvsZqyWyx3bDa5B9mYYl1mBizW/7zPdSE6LUWps?=
 =?us-ascii?Q?MhRhCBz4RzbTVFS4x3R5wiaf8Md7BzxtLd3q66giOKqXfnPF4JhEKBYspNGx?=
 =?us-ascii?Q?Kas2jGwXTJ6N3ORvVkCN7NaAS5WTdVdDKuO2qUPXLkIrTFdlbiT5BVwWNAfL?=
 =?us-ascii?Q?TrYDtK9RyEpYJNdnO4orI0X7Ur3zm8Yk2n2zGn2oPCQY1AGuPUrbNZQsaFx0?=
 =?us-ascii?Q?VE+bNYSZM6RpOJAwBRHWRzBIBucZcqbig0XfACe1IbJA7aiYHbj+zM3DayWc?=
 =?us-ascii?Q?XVjcz2qpAra6HfU8S0XuHRU5SHwIl14L3KLDzzcem7GUd6f9fbY0ktPWNJOU?=
 =?us-ascii?Q?soOteUg61a+zBEdr4IX+1gwf5tdl7NeRySIHa6UnpCpfgovXpV1rNoNIAd3Q?=
 =?us-ascii?Q?o8enuxPCsIchTKqVzQJUnAcKwzSC/frLHLKexAt0XqpZ1NFnmuZQgtrSQAWC?=
 =?us-ascii?Q?0z6mOU7owaToC9VvG4HLdJHXPA91qaaJkgNmGtkRPBVkBP3m1cEq0w7l7JD1?=
 =?us-ascii?Q?LaGjridp7zu7ijYQ5nH7lRWftB8Mh69a0yghqAc9KtluEQ0FDN3WVFlLM75n?=
 =?us-ascii?Q?CO/vug/z3ZhE4AhX6ImtKFGUPi1sW1g9grxAECZ92hRoIFZRdEuJ+d7YIQEY?=
 =?us-ascii?Q?vTj7aTtaHpFj6AgmM0AJ1WDLVQ5q7QMqIxOYOzzM+DEFpsgQmuyXo4q1Ur7p?=
 =?us-ascii?Q?+tnYM2Nse73715kKtJ44v06QRbXCUURULBHx33m65p1gqJMgcdc96xS075Hz?=
 =?us-ascii?Q?5KEXvj+NCulaBrhOYgse+PJEGyCDLK/EjUJGyYZYUlXPvGRzH3+Dw02qR2Yr?=
 =?us-ascii?Q?Lsi8AL+yvyl5vjg8tWfxIJ9pBWBQ2u++UTMiWOk4YIeUeEi7JONOJEhOv5qv?=
 =?us-ascii?Q?Btqv0jAgFxtRHTlKKjbHKGlBBAYb5dsPwP+sQh1RE1QMcxCJoZj7VKXK53PS?=
 =?us-ascii?Q?D1d9P83kZuDSlZ47ynFH3hpkjiJI+ZJSIeKtq1sb3dluyS3GK1N22QKXYgRE?=
 =?us-ascii?Q?A5sOd9DH0HD8KSKsiStoP9bb9cm8UXhgsFocEuTRAJxdKvNLx1KCPda5X+Ar?=
 =?us-ascii?Q?E40t8EoRvGh23E7yWRcqVwCqw58gm+juvM2CE/TFFjPngamoO7IE62/YI2QZ?=
 =?us-ascii?Q?Nfg4z5DI0WkKBOobN+7d2HR5HWZ6QK61oISsniTFAvW8bdJwR5squnCy34JA?=
 =?us-ascii?Q?EV4ddx5DgIX99sAixv9k0i4yLEpuIMhF0w4L1aovg3MuL8M96qToXaPO03Fo?=
 =?us-ascii?Q?u35XV0t4hVicjx/mUqZ3wYUJgsJ9itYDIefwj7oMg7wpomt+OPoM6W39y6b6?=
 =?us-ascii?Q?mOprJcfJScznIbNdGc5wKMuFs1Djo4GJShVqYoeqDEkcryhrIpuaxD3uzZwW?=
 =?us-ascii?Q?oWQtV+vacgC9gWaEpvHwrJ2b7ll54AFb/DlVixeWmPgtNipWdm8e7Tl9XjAK?=
 =?us-ascii?Q?7mDEDonDckeMy7uGIQb5GkklfwO0O8iCiSeoZ4vx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36818e28-26d6-4305-2a39-08dab2725fb9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:09:13.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlyLxEJ7cOLvH24WhGw3nODdlQ+pExRChm0dYoceCcxudQxfcFSqEo7lw5W7Yy25Q6Pak/clacWaM3KPl1mybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:09:04PM -0700, Paul E. McKenney wrote:
> One remaining clocksource-skew issue involves extreme CPU overcommit,
> which can cause the clocksource watchdog measurements to be delayed by
> tens of seconds.  This in turn means that a clock-skew criterion that
> is appropriate for a 500-millisecond interval will instead give lots of
> false positives.

I remembered I saw logs that the watchdog were delayed to dozens of
or hundreds of seconds. 

Thanks for the fix which makes sense to me! with some nits below.

> Therefore, check for the watchdog clocksource reporting much larger or
> much less than the time specified by WATCHDOG_INTERVAL.  In these cases,
> print a pr_warn() warning and refrain from marking the clocksource under
> test as being unstable.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 8058bec87acee..dcaf38c062161 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
>  
>  static void clocksource_watchdog(struct timer_list *unused)
>  {
> -	u64 csnow, wdnow, cslast, wdlast, delta;
> +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
>  	int next_cpu, reset_pending;
>  	int64_t wd_nsec, cs_nsec;
>  	struct clocksource *cs;
> @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		if (atomic_read(&watchdog_reset_pending))
>  			continue;
>  
> +		/* Check for bogus measurements. */
> +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> +		if (wd_nsec < (wdi >> 2)) {
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}

If this happens (500ms timer happens only after less than 125ms),
there is some severe problem with timer/interrupt system. 

> +		if (wd_nsec > (wdi << 2)) {
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}

I agree with Waiman that some rate limiting may be needed. As there
were reports of hundreds of seconds of delay, 2 seconds delay could
easily happen if a system is too busy or misbehave to trigger this
problem.

Thanks,
Feng
