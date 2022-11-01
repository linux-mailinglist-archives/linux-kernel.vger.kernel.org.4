Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1B61445C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKAFnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKAFnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:43:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091C13E12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667281423; x=1698817423;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5zmVOGv5VvXF4SlLQJVIKvOMd6rNuaUJao/QEMl4XEo=;
  b=nbfOiyGeqT6dUBCiI+PqLdE205kx9zixzwsMnT6E0ya2E5j1irlG95wt
   ZXiR9mDWuIhd16dPwANLgv5VjNTP5o2M9JLUxt7X02SNh//qJkORqQhiv
   jcxLR8diX38Y/9+S/+GslgnDa0z2CsaTILtdV6opgFRlCJRLUyEB6nyc3
   eE33esbTh4OQSA1NSGOxJ2wIYhRbXrBLkWm4YyE23dSgqj9HVrvcyLIyp
   eF6qmKYJ/jNazir21I/nroOkSBKNfgP/BIRHe5EpaqMTnCjMiJ74529j8
   K4DSkyMgVFNPOzN4yWUpK9ZfYqhCX2RyUrfQv2FryEGF3ESpgus/TD/Wl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395384426"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="395384426"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 22:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="702776884"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="702776884"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2022 22:43:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 22:43:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 22:43:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 22:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyH3N7zy3KYs9w5kDY06iRiHwQ6qiTV7k3Ewd8DE2rBFkZSGj4OMoGE1hFY+C4a7TcV2+OYtLDXL4Vjv79W/nlSAZNpcEC14/eMxzONvHwb0vSd18m6QdVBBjv6DBam6/04bORfzULK9DVOOIFQWnzAS5Kkg4NUsCkzSAmwnN0ALE1Guem1JyF0d6QDBZbhwSRueQ7plK0/M863FUAsDGLm8P6bNZby8rNCd14Ph6m0HCw+u0300ua3oop6yX5t1QioDasuDI0CeTDdCsWCEM9JtVrpJOCzKw55EaKS3LNl+/1JucH6GdgqpIeu63pMk9cEcAXt+bBkru0u1qRH1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkKGJtZFjIIR76mE0eN6wN6iomZuHMhEMBre6cf1hsA=;
 b=GrzDQV9J/u0XtC10953Er3DB10Z7xa7NF0QQv1RRT5HOvHWd5rayAJd7qT6/yazCoHzXJYAc2VUcFSOvgPhg+zwRQ+yZwucgXOnw79WAzyCjkig8RtcZ+vhznARaWO7yBjHyJ5Z1f1fB/r1Tn9bl7VXYdJ/BwhySai7SeGCr7JPQD4ACW8RcCiMYzRZABgq5kq9ey5gdxZgz7XxV69zbZ2v5x2tq61wguiTR2LZh9A86bBln3na1yV0ONLdAxbKrUvfQ46ExuHNNXzNAnud1mby/FOuP21cOYBGktR6voQ3zFf/jan1w1Ctpu0sVvFWTkVDGG482hzIr7qX8vLSNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 05:43:39 +0000
Received: from CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::714c:d1b1:fa93:7d74]) by CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::714c:d1b1:fa93:7d74%7]) with mapi id 15.20.5769.015; Tue, 1 Nov 2022
 05:43:39 +0000
Date:   Tue, 1 Nov 2022 13:43:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <clm@meta.com>,
        <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <longman@redhat.com>
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <Y2CyBGNM0rMI6nCG@feng-clx>
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
 <20221028175245.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <Y19kStu4zBFyvKPK@feng-clx>
 <20221031174212.GB5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221031174212.GB5600@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To CY5PR11MB6308.namprd11.prod.outlook.com
 (2603:10b6:930:20::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6308:EE_|DM6PR11MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: fde34ff4-d0b8-42b1-588c-08dabbcc071e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFGVaIDqDFifjdqqyx5+bPlmWFpB+0WVk+uPxL+KD6e1cCUnDAYcp8fdIpxQQccTVJFhVAc6fGj0L/QcVoWQa4+7tuGlZwHqurgYXO70MzQ1mpaRiIzM5SSBf07cknlulPOYqP6RhmL5rGNrNTz5U5Gk1d5OYxxwlrrfAwDRQEVvHGp9v07i8QY62t9LnkUObaFkKjetlIfAlnJinCWoYPFN38T3t4tiTURKwbxEsJsIR+VrvQHwlrVYzb7l31T9mAKKAMMK7/Zm0Rs8W5BDWtQBxMVSe0ITa2JagI4jsUy3HN4dJ7iMtd/8a/b4QPtAtPdRcX0gMkOpriBJyP9WcQJs0VR7dA3HmUcUuOAx/KQYAn7ZAsblLk3CrX1XGJXI/d2uY3an4mXEHDDaxVpHaYPBy32SDanoYR1Z9wcre0di/FOE0AaDiZPWkQkY/Kxbe+BPz9WCSTe2YRELmmO2J5LlMkzPHxP96KbF42/Gd0gpG7EIUj0wZhL6XYuSPovCRmmQLcH+OzyUgunY81kw/KAhrBrSYBB+J2PG40d6s+W6ixWDSisqerEW0uBMJM2XYVU4Xkivn2slnjkYS0CvRLDzUZlEYFk8hub1dU4xZRDJbKn8j8TVnej+1FA4jNf9rrc6+unE6r/1arRlcY+5k/NZy6jq1ZWYP4N3XLA3Rik1y6wtY04oFs0Nqdd7vaix+wzarGa1XaQuJGM332i+IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6308.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(6916009)(316002)(4326008)(33716001)(66946007)(66476007)(66556008)(82960400001)(44832011)(5660300002)(186003)(38100700002)(6506007)(6486002)(2906002)(40140700001)(8676002)(86362001)(6666004)(83380400001)(26005)(8936002)(9686003)(6512007)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nj6Ms4gdH/3Q2czeGuE8l2qQc87I6gw/YszpdCx3VzJmlOiwjCvkfwBGR2As?=
 =?us-ascii?Q?iSMP4SG6ZyyWf7aelZx8kAF6aL4VP3rh7gzKII4QiRfl3mTF7P27IVLDdlJF?=
 =?us-ascii?Q?JK0jOgYvEQgvM7NaUkbvq1xqOsuC2BZAAdeta0YoNGOfs59I5dvOT7PZxc9F?=
 =?us-ascii?Q?dZkIqDTSIli6j/yChucXRtwNBPCmnIkCBH2KC8/YiTV0VoHla+p+W+URAWtW?=
 =?us-ascii?Q?1BFtCq7bVXqRpn9/UfbPI9eoGTsb/TgwzZTB7xjORxJ0KdQrzd931F8rFPuV?=
 =?us-ascii?Q?m3/dqS1EdnOSBZk2ghdmOSJnyonJvMwZm/hjvO+orSWREovS0woFFSWChIRk?=
 =?us-ascii?Q?VnxVrBs+NlaZ4/nwj9illeYy/RVu44RUFDUJZJuR/LEnsVHIE4PuRd9sxpAS?=
 =?us-ascii?Q?3zm69PRz2JJOj1VYk1YOy5q+gfn01pGK3FLjR+3unqQFo1sN4L3zRYdWaxl9?=
 =?us-ascii?Q?w5RUVr63JJCCNicfFFCNYKHePaTmbqFY4pFdjkGdssIhvhGCePgIdYyOKiLs?=
 =?us-ascii?Q?zuIkFZMNMuwb9hyoFtuotTCYRu73TZHKzEtsklh30MLn5FQF76a8+wvySROV?=
 =?us-ascii?Q?nzvK8zuqAKNltK+Q5uRDHQK3UngW/9l/an0sbpGJ+wxV4Mcod+hUUQSzs4LC?=
 =?us-ascii?Q?2tgdNrLwEHcYIWWeOdTP0bUmyNP8GIyR+seXTgKefEmuh4J8Vz5imWg/AfVe?=
 =?us-ascii?Q?wORxdZRZ0J7qUJzs4DOJzkig5HgJV2RN8v6iIS9vaDntUIoferehMxgWjDUQ?=
 =?us-ascii?Q?B3JSoM1ghZoAm2xzWDDGX5TEUCJunIs+EDR08m538nWTZqnuA4ZIJHSRhbVf?=
 =?us-ascii?Q?5ZBc9sarUPyVLZPGdN0zoiWOAcHDG95FXL8kIBnCsEa69HxhxNhF1szzkPRj?=
 =?us-ascii?Q?XC8wIKcS7yBG86Bml/zK1x7k4+hP2ZaQ2GG2zudPg84UrZ6gybFS1Xz9jGZb?=
 =?us-ascii?Q?KT/z+kUHedMlzGEaJ2Vtj3WqANWzGoG3XFo4n+JNjQ9gn30oPMRJ5fGk01dS?=
 =?us-ascii?Q?0T3Z8XJ7Y/IkAASwEmXrlTv45mDLdjahY5DfTPI3Krj2slS47JILfx0HZk7M?=
 =?us-ascii?Q?rFKc6qvxRZRe6jHP7jS4gBguH94GDkx5d2v33cM3GD2yxZVvmo2pmCqV/tKZ?=
 =?us-ascii?Q?f26RLPDfWbP7k7RN14MvLXA9I1+1mY4QB1/cyFYfe8y5J9sZ+giuaiKv7lIM?=
 =?us-ascii?Q?kGdDaijQiI5d4Y4MUIMTcfcj+ToVtU7u7rq0uZ5sjP4YdgmNpDTkPubvf3an?=
 =?us-ascii?Q?5dEupJuhDq6UFJgXbWWH68MPOqSuKvyXlAd4xsslsKSwee3Fz3s1bFWKv2Wv?=
 =?us-ascii?Q?Uty+k4J23+aKClw+BIKtyO3u6fBn3wRwWlu0AHnvhGKN58o7aoYWSfKRS+lk?=
 =?us-ascii?Q?hxHdyrzAoaQbEdDw47hbBv8UNxmzPRG6jDO7b6NlNwz0GjdRI+gcIGtra+jx?=
 =?us-ascii?Q?4oKQqROvzZeYVwASVdGLgkFlyLT3pqnOmj3cqYaPCacprKK+875uSQdduNWg?=
 =?us-ascii?Q?li9GVig1Sdf8mvHOT6/OmooBbe8dNY1//vwpzuXJarklS7F1IZU7ysuMW9DV?=
 =?us-ascii?Q?4OFee0gVJBdPuEbsuEkJi7SLRtZar9losL26VyvK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fde34ff4-d0b8-42b1-588c-08dabbcc071e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6308.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:43:39.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuFmhXoYdQ1zbwed2j8jq5YLCvgqISN+Thwi04v1cJpNI5NRobWHa5ql/njRmB+1W8VEEyKsG1jzMkMTLdgKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:42:12AM -0700, Paul E. McKenney wrote:

[...]
> > > @@ -448,8 +448,26 @@ static void clocksource_watchdog(struct timer_list *unused)
> > >  			continue;
> > >  		}
> > >  		if (wd_nsec > (wdi << 2)) {
> > 
> > Just recalled one thing, that it may be better to check 'cs_nsec' 
> > instead of 'wd_nsec', as some watchdog may have small wrap-around
> > value. IIRC, HPET's counter is 32 bits long and wraps at about
> > 300 seconds, and PMTIMER's counter is 24 bits which wraps at about
> > 3 ~ 4 seconds. So when a long stall of the watchdog timer happens,
> > the watchdog's value could 'overflow' many times.
> > 
> > And usually the 'current' closcksource has longer wrap time than
> > the watchdog.
> 
> Why not both?

You mean checking both clocksource and the watchdog? It's fine for
me, though I still trust clocksource more.

I checked some old emails and found some long stall logs for reference.

* one stall of 471 seconds

 [ 2410.694068] clocksource: timekeeping watchdog on CPU262: Marking clocksource 'tsc' as unstable because the skew is too large:
 [ 2410.706920] clocksource:                       'hpet' wd_nsec: 0 wd_now: ffd70be2 wd_last: 40da633b mask: ffffffff
 [ 2410.718583] clocksource:                       'tsc' cs_nsec: 471766594285 cs_now: 44f62c184e9 cs_last: 394a7a43771 mask: ffffffffffffffff
 [ 2410.732568] clocksource:                       'tsc' is current clocksource.
 [ 2410.740553] tsc: Marking TSC unstable due to clocksource watchdog
 [ 2410.747611] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
 [ 2410.757321] sched_clock: Marking unstable (2398804490960, 11943006672)<-(2419023952548, -8276474713)
 [ 2410.767741] clocksource: Checking clocksource tsc synchronization from CPU 233 to CPUs 0,73,93-94,226,454,602,821.
 [ 2410.784045] clocksource: Switched to clocksource hpet


* another one of 5 seconds

 [ 3302.211708] clocksource: timekeeping watchdog on CPU9: Marking clocksource 'tsc' as unstable because the skew is too large:
 [ 3302.211710] clocksource:                       'acpi_pm' wd_nsec: 312227950 wd_now: 92367f wd_last: 8128bd mask: ffffff
 [ 3302.211712] clocksource:                       'tsc' cs_nsec: 4999196389 cs_now: 9e811223a9754 cs_last: 9e80e767df194 mask: ffffffffffffffff
 [ 3302.211714] clocksource:                       'tsc' is current clocksource.
 [ 3302.211716] tsc: Marking TSC unstable due to clocksource watchdog


> 
>  		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
> 
> > > -			/* This can happen on busy systems, which can delay the watchdog. */
> > > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > +			bool needwarn = false;
> > > +			u64 wd_lb;
> > > +
> > > +			cs->wd_bogus_count++;
> > > +			if (!cs->wd_bogus_shift) {
> > > +				needwarn = true;
> > > +			} else {
> > > +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> > > +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> > > +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> > > +					needwarn = true;
> > 
> > I'm not sure if we need to check the last_bogus counter, or just
> > the current interval 'cs_nsec' is what we care, and some code
> > like this ?
> 
> I thought we wanted exponential backoff?  Do you really get that from
> the changes below?

Aha, I misunderstood your words. I thought to only report one time for
each 2, 4, 8, ... 256 seconds stall, and after that only report stall
of 512+ seconds. So your approach looks good to me, as our intention is
to avoid the flood of warning message.

Thanks,
Feng

> And should we be using something like the jiffies counter to measure the
> exponential backoff?
> 
> 							Thanx, Paul
> 
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index daac05aedf56..3910dbb9b960 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -125,7 +125,6 @@ struct clocksource {
> >  	struct list_head	wd_list;
> >  	u64			cs_last;
> >  	u64			wd_last;
> > -	u64			wd_last_bogus;
> >  	int			wd_bogus_shift;
> >  	unsigned long		wd_bogus_count;
> >  	unsigned long		wd_bogus_count_last;
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 6537ffa02e44..8e6d498b1492 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -442,28 +442,18 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  
> >  		/* Check for bogus measurements. */
> >  		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > -		if (wd_nsec < (wdi >> 2)) {
> > +		if (cs_nsec < (wdi >> 2)) {
> >  			/* This usually indicates broken timer code or hardware. */
> > -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > +			pr_warn("timekeeping watchdog on CPU%d: clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), cs->name, wd_nsec, WATCHDOG_INTERVAL);
> >  			continue;
> >  		}
> > -		if (wd_nsec > (wdi << 2)) {
> > -			bool needwarn = false;
> > -			u64 wd_lb;
> > -
> > +		if (cs_nsec > (wdi << 2)) {
> >  			cs->wd_bogus_count++;
> > -			if (!cs->wd_bogus_shift) {
> > -				needwarn = true;
> > -			} else {
> > -				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> > -				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> > -				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> > -					needwarn = true;
> > -			}
> > -			if (needwarn) {
> > +			if (!cs->wd_bogus_shift ||
> > +			    (1 << cs->wd_bogus_shift) * wdi <= cs_nsec) {
> >  				/* This can happen on busy systems, which can delay the watchdog. */
> > -				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> > -				cs->wd_last_bogus = wdnow;
> > +				pr_warn("timekeeping watchdog on CPU%d: clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), cs->name, cs_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> > +
> >  				if (cs->wd_bogus_shift < 10)
> >  					cs->wd_bogus_shift++;
> >  				cs->wd_bogus_count_last = cs->wd_bogus_count;
> > 
> > Thanks,
> > Feng
> > 
> > 
> > > +			}
> > > +			if (needwarn) {
> > > +				/* This can happen on busy systems, which can delay the watchdog. */
> > > +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count - cs->wd_bogus_count_last);
> > > +				cs->wd_last_bogus = wdnow;
> > > +				if (cs->wd_bogus_shift < 10)
> > > +					cs->wd_bogus_shift++;
> > > +				cs->wd_bogus_count_last = cs->wd_bogus_count;
> > > +			}
> > >  			continue;
> > >  		}
> > >  
