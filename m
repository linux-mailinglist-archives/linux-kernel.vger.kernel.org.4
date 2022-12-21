Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E287652AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiLUBEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:04:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683265F3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671584685; x=1703120685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rkrLwcHIuzQWsqed/IW/i8/rAGiyKIYK/QHmgkzqab8=;
  b=Ae3oLsIsLpKVLV4PudYd8umRwDhUnSdqj/mKhGW/+U0TPgsdgKEI68l8
   ribROKVnyfp83VtQ9K78PP2NHDwPsMtLaPhhVKF5lOfNR1WUOPvGAMC3c
   WG35GX7eHrxOgs1XO/vozQfL13X+PhV4yVe9BYiaoJ6OHLO26BbAzs5CZ
   zOgJ38Oxu3FU51+aCM6jbr6m/v4Dy0jf36eMdyhpa22wefrQi8pbz7UZx
   kG143deby7WPpzHwntwzRYjE/tFSgYyeMqus+YnBEJAnXLJnV74bgUNiW
   oGBAZFdTGRLJqjeErLXcmAgnQomiIn/eAF4e7Y/BeWcjPqMerhxDdMuUS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="307438317"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="307438317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 17:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="714646067"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="714646067"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2022 17:04:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 17:04:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 17:04:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 17:04:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgFyjlZDayDtuZKJ8LxoQmlTWMjPV+CC+8iGZ0NwNKwTL4XlIr2igHc7tB9yJJc1EEwAL0TC4HYHHER6gb7NdsB5vEhgRLhIWtDBKLCsZYfUTM4A8hW+FYq+FGnftXP0YbaLT61svj6nUwEkoShRjTtTJIIOUlbMb35TN6IC/8g7EckMWtMcPMHQojpL7fgvSmEV0RtgIwrRICN9xXLWQ6PYGn81CJNKKaAJkir8n2AEx3exUxK2oOwuecT7fWe5sgHLLwlyEYKsFynazbEnZi1gw8EuOAo8ZVepw40q3kf0s3DULAGvA/TdSaen3JokKT1Boq5d1c3slLA+1MsMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb3frUrs3r8J/eJXrxixSTMFDAwv5Ia8/7dGiAb8HOA=;
 b=UILPskMWbLGSgmH3oTwpskglPy8kMXrnW88llIJDwKvPfu75bOO5vsHP9GYKTlJWHRTOcAKhqDWUJIkfyZfWKyXvblxD4Gwhs0dTpDGHK/tdWIzjetEeO3tv2+sJ1MD/UOdEbCxyFhM+De1/eOZB+pfUkcqWSnFBrBrDj0AVRyZF+tDwnuO7EdLtpf7raM73JYz2CMGcXiedCPKBmA0yB2d5YfHYEIWDK7CQfQAzK3b14oJM34M+pRe9WxWOPA21pEz2Qe3wE4UWomIfFlBtJ9JpcsKlJ21gwY3liY6F4xNSz/7CijaEgPlqhznGXjED6IC7jGMjR4/Zi29+BcBzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 01:04:41 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 01:04:41 +0000
Date:   Wed, 21 Dec 2022 09:01:46 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <Y6Ja+kYQAi4pppV6@feng-clx>
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW3PR11MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: ca142399-55d4-4f61-7e40-08dae2ef56b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGac658uSg1aRlhl8nRodFFR0cFeS4OqNARrNKaeAs3HHUkq1KFvZPZFetQ7zwgpRkkX7CIqMemkzBFpmn8Z5W7NRXcdvT3UfULpbMfM25IJU9ja8ba5J7rsu45NgrbEsBIaLKVB0ljLIE//zdC/szjnBMJtIwJGZl4muKK1XKEHQK7p3KeOuAjrzepmTt7Gzp/oSgXf43eakgT8Im8HoP78NSwVJNSKXDMKQD8ZELL97Lc7tT+Whc5nSBagLwlhL7ekjJ1klqU+PijddFX/cRiRauCEr0ERKJXvNr6WIRwX6q6xMgWoqPPYeUMLfejTs35wymQDQYV0g9zzhZWb5naxQOTUerA/PBo2TFemFGlcp8oPhg/mZ8fKID0vQUEvVt5sCp2jh8ExOW8s8vzZIC8cZ4TStrCRFR50xJpSNKaLtoTw91LYq2Rcm0KwhpoIg5DQMxtOvXvli1SwBkKz9J1S6d1gG1oymzIC4YyLOr+P3nlF8RdgxEqJOktgjJ92795jZFLxfeIH40BAgC4I1MWJkqenAt+UB/vDdf2wEtJ2UOn+ck6AIvuXg8ZpGWdwtiJdih3S9UTRHJS+S+j8B/3uvjda2Ib6u2aKhCdtoJb6Ati/1m5WGWIs3rOvKu9afw9GbbE6a/+CEUDx4t7eV6ntyvz2mDrFIoMPZ6GmHUkkoZIce8oVxcu+OtJN4kl6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199015)(82960400001)(2906002)(38100700002)(15650500001)(186003)(9686003)(86362001)(478600001)(6512007)(8676002)(66946007)(4326008)(6506007)(53546011)(66556008)(26005)(6486002)(107886003)(54906003)(66476007)(316002)(6916009)(44832011)(83380400001)(8936002)(41300700001)(5660300002)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roAWUUsAidUR1b3+g07Ut7IRjw+x1wmRn87C6hJvOx6fD+ttzDHcc/Qm2xRv?=
 =?us-ascii?Q?w80QWa+d3J2p17vB79xJ+q+yJBtrOofaKyF4co/YrcI2YwtVwe+z/0KUJxyo?=
 =?us-ascii?Q?WkuGRVBGNVCohgKht5p/4i+8GLAqP+/w8uoPs0JiCstyf23w/sWBaoyIV+p5?=
 =?us-ascii?Q?/kVuvrWZAUioWDxtaJT/HchaFA7RVZ+XkEljsKIX/jRR+Lx+iOvP6nd31mkx?=
 =?us-ascii?Q?Br/WhnLSEIH2haSEr52Gz7etJhNt8G4hUli4pmlkXaj+wNe1OupJ03PE2WRN?=
 =?us-ascii?Q?QXKqVUDbY5uSO0CZVMlb7cMr/UltrhHtMv3wOtrE9idGZro0vSSnq+JqbIpK?=
 =?us-ascii?Q?VIHHm0GALg7sZRhHrBpdDW5Lgk89JY2ZQHe4MBb0oBYZWRfd4ggxwenwAWup?=
 =?us-ascii?Q?4nwoBSHhEhU0YTmf5C4/McSONSaJxRHN2naCO4GlPSujhH94PR4gEyFLaWY8?=
 =?us-ascii?Q?vA0uouhAx748wLwXh2XrYXG/3u7Fq6gpKlILh0iQUqyydUGh+qjfDky6IpX1?=
 =?us-ascii?Q?8Dtq6cSpZ5Omluc+F/kcw+W4QsXfW68VXMIImC4CCbMjDraw4LmzP7L76BPG?=
 =?us-ascii?Q?gyCkHHiY0s+3m1gsYwmPojy1bx+EiPNYSAbt/VUg7M2BrnsI09ctUeMoQn1O?=
 =?us-ascii?Q?oai4sxnOCk4AvdAWgYdm06Vi/QifVQQOia7WtfI8OCIjpJGeHTO8xXB3ZqQf?=
 =?us-ascii?Q?rsE0gwtV6DmEcRnBvxScITYllIpU+T0eVEot9G3l4RB28r30gdwkd5X8TvNI?=
 =?us-ascii?Q?ytWUAxw2Sn/hxiBU9+U5u+vla36Zqt7UnHTpvmYA5tHMb6jORMx6AqsNzAEP?=
 =?us-ascii?Q?/wibhWTYqh4pHgn+GpywLxZQYRjtev/HTWUqqsV0z41MivOZIYVHnwPYeO94?=
 =?us-ascii?Q?cD2RI7PSPhpJx83sPj4fbOLq0VhmI9RP1KvK1DthCsoBaK3utgU7v8wWqbyb?=
 =?us-ascii?Q?GZvY1u4u27XWHkVaTmOTGTAf7yYXeBvyBeqc2Cg8gxNLYl1mwDv7pV3jmRGf?=
 =?us-ascii?Q?91evPdTezBXZuO/S/s7ou+nwsG1soVbN+UiE0E+2gtr/TNdDly0wo+Zzxt26?=
 =?us-ascii?Q?pa5jvoEDu0dxkwbZijPGyoycniDua9yBqGNYZBiaX53tm13JE7+W5PSkiVG6?=
 =?us-ascii?Q?QQNQb/BEKq+CcDAz/Yh3TrS0EHAIYR85wlFxCEO6/jRu5udhcdE4UJDX23qd?=
 =?us-ascii?Q?oQ9/1xH5jYCfbvxq22hsxswbIBJrpm7Y6tVsPyy25wugiGvgiU6SO0qURbGw?=
 =?us-ascii?Q?NO6MonCWJyXUN90OBgP9TIj0VRlBM88kuPXKxMN7ReUiV479zcpOzcAPjkar?=
 =?us-ascii?Q?ZEo4XnrboEQlfcPGH8brumG1yHVzaF1ySBIfyGM/g+EZnE5YUU8LB2K8h3CM?=
 =?us-ascii?Q?44ifL8L6y07xlprkB3ulIvHu6WkRwb6qa4oOmVCM9euTef5CijwKzMHpUxF4?=
 =?us-ascii?Q?srvrE4p2qab6BFWDr0QxTyjis9u8RK5G2q/b62MfuUy0Q9JtDpeoDQOa4sD1?=
 =?us-ascii?Q?+CzAWvlyiT3+Nt0yoGk1NzaELzBo0v9VZNVDVZblepWdTQfMM9ZpBuOF2Qgp?=
 =?us-ascii?Q?kl0uDX43b3d6OIbf52NSovHAUHC1ChbmpyF2eLFa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca142399-55d4-4f61-7e40-08dae2ef56b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 01:04:40.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnVEp5lIn4dKWtEvSmlMFktIT1Rb83ou+GA1aWsztiZeGYmGCHeE84HQ+3GoXfT9rlrqma9ZDdZhI9Cj3HX3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using correct email address of John Stultz.

On Tue, Dec 20, 2022 at 10:34:00AM -0800, Paul E. McKenney wrote:
> On Tue, Dec 20, 2022 at 11:11:08AM -0500, Waiman Long wrote:
> > On 12/20/22 03:25, Feng Tang wrote:
> > > There were bug reported on 8 sockets x86 machines that TSC was wrongly
> > > disabled when system is under heavy workload.
> > > 
> > >   [ 818.380354] clocksource: timekeeping watchdog on CPU336: hpet wd-wd read-back delay of 1203520ns
> > >   [ 818.436160] clocksource: wd-tsc-wd read-back delay of 181880ns, clock-skew test skipped!
> > >   [ 819.402962] clocksource: timekeeping watchdog on CPU338: hpet wd-wd read-back delay of 324000ns
> > >   [ 819.448036] clocksource: wd-tsc-wd read-back delay of 337240ns, clock-skew test skipped!
> > >   [ 819.880863] clocksource: timekeeping watchdog on CPU339: hpet read-back delay of 150280ns, attempt 3, marking unstable
> > >   [ 819.936243] tsc: Marking TSC unstable due to clocksource watchdog
> > >   [ 820.068173] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > >   [ 820.092382] sched_clock: Marking unstable (818769414384, 1195404998)
> > >   [ 820.643627] clocksource: Checking clocksource tsc synchronization from CPU 267 to CPUs 0,4,25,70,126,430,557,564.
> > >   [ 821.067990] clocksource: Switched to clocksource hpet
> > > 
> > > This can be reproduced when system is running memory intensive 'stream'
> > > test, or some stress-ng subcases like 'ioport'.
> > > 
> > > The reason is when system is under heavy load, the read latency of
> > > clocksource can be very high, it can be seen even with lightweight
> > > TSC read, and is much worse on MMIO or IO port read based external
> > > clocksource. Causing the watchdog check to be inaccurate.
> > > 
> > > As the clocksource watchdog is a lifetime check with frequency of
> > > twice a second, there is no need to rush doing it when the system
> > > is under heavy load and the clocksource read latency is very high,
> > > suspend the watchdog timer for 5 minutes.
> > > 
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > ---
> > >   kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++-----------
> > >   1 file changed, 32 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > index 9cf32ccda715..8cd74b89d577 100644
> > > --- a/kernel/time/clocksource.c
> > > +++ b/kernel/time/clocksource.c
> > > @@ -384,6 +384,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
> > >   }
> > >   EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
> > > +static inline void clocksource_reset_watchdog(void)
> > > +{
> > > +	struct clocksource *cs;
> > > +
> > > +	list_for_each_entry(cs, &watchdog_list, wd_list)
> > > +		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > > +}
> > > +
> > > +
> > >   static void clocksource_watchdog(struct timer_list *unused)
> > >   {
> > >   	u64 csnow, wdnow, cslast, wdlast, delta;
> > > @@ -391,6 +400,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > >   	int64_t wd_nsec, cs_nsec;
> > >   	struct clocksource *cs;
> > >   	enum wd_read_status read_ret;
> > > +	unsigned long extra_wait = 0;
> > >   	u32 md;
> > >   	spin_lock(&watchdog_lock);
> > > @@ -410,13 +420,30 @@ static void clocksource_watchdog(struct timer_list *unused)
> > >   		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
> > > -		if (read_ret != WD_READ_SUCCESS) {
> > > -			if (read_ret == WD_READ_UNSTABLE)
> > > -				/* Clock readout unreliable, so give it up. */
> > > -				__clocksource_unstable(cs);
> > > +		if (read_ret == WD_READ_UNSTABLE) {
> > > +			/* Clock readout unreliable, so give it up. */
> > > +			__clocksource_unstable(cs);
> > >   			continue;
> > >   		}
> > > +		/*
> > > +		 * When WD_READ_SKIP is returned, it means the system is likely
> > > +		 * under very heavy load, where the latency of reading
> > > +		 * watchdog/clocksource is very big, and affect the accuracy of
> > > +		 * watchdog check. So give system some space and suspend the
> > > +		 * watchdog check for 5 minutes.
> > > +		 */
> > > +		if (read_ret == WD_READ_SKIP) {
> > > +			/*
> > > +			 * As the watchdog timer will be suspended, and
> > > +			 * cs->last could keep unchanged for 5 minutes, reset
> > > +			 * the counters.
> > > +			 */
> > > +			clocksource_reset_watchdog();
> > > +			extra_wait = HZ * 300;
> > > +			break;
> > > +		}
> > > +
> > >   		/* Clocksource initialized ? */
> > >   		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> > >   		    atomic_read(&watchdog_reset_pending)) {
> > > @@ -512,7 +539,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > >   	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
> > >   	 */
> > >   	if (!timer_pending(&watchdog_timer)) {
> > > -		watchdog_timer.expires += WATCHDOG_INTERVAL;
> > > +		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
> > >   		add_timer_on(&watchdog_timer, next_cpu);
> > >   	}
> > >   out:
> > > @@ -537,14 +564,6 @@ static inline void clocksource_stop_watchdog(void)
> > >   	watchdog_running = 0;
> > >   }
> > > -static inline void clocksource_reset_watchdog(void)
> > > -{
> > > -	struct clocksource *cs;
> > > -
> > > -	list_for_each_entry(cs, &watchdog_list, wd_list)
> > > -		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > > -}
> > > -
> > >   static void clocksource_resume_watchdog(void)
> > >   {
> > >   	atomic_inc(&watchdog_reset_pending);
> > 
> > It looks reasonable to me. Thanks for the patch.
> > 
> > Acked-by: Waiman Long <longman@redhat.com>
> 
> Queued, thank you both!

Thanks for reviewing and queueing!

> If you would like this to go in some other way:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> And while I am remembering it...  Any objections to reversing the role of
> TSC and the other timers on systems where TSC is believed to be accurate?
> So that if there is clocksource skew, HPET is marked unstable rather than
> TSC?

For the bug in commit log, I think it's the 8 sockets system with
hundreds of CPUs causing the big latency, while the HPET itself may
not be broken, and if we switched to ACPI PM_TIMER as watchdog, we
could see similar big latency. 

I used to only see this issue with stress tool like stress-ng, but
seems with larger and larger system, even the momory intensive load
can easily trigger this.

> This would preserve the diagnostics without hammering performance
> when skew is detected.  (Switching from TSC to HPET hammers performance
> enough that our automation usually notices and reboots the system.)

Yes, switching to HPET is a disaster for performance, we've seen
from 30% to 90% drop in different benchmarks.

Thanks,
Feng

> 							Thanx, Paul
