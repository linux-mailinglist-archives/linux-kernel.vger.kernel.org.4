Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3A654B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiLWCOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiLWCO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:14:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3169037F87
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671761549; x=1703297549;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W20KOLXC/0rAuya1hg6EYw1/S3GzDcF/BPNrbQnPaeQ=;
  b=i0ZXZvUS+cSwKBzj/eYl206KTffbCODFwwKlLjpKeSn9lGYs+2oB+Q3Y
   oa4xjNoB4ZBPFiKIEgZjnG4SIG3hKKkkBY8tjGzrh5yFjWqVJdY7GGCB/
   lRTvyO5/deh42BUhrS3xSlB9KChQOL1sxsZf/HFbTApkDpwcx62RkmnVo
   ee8S4nVR4xkxRGqAUoTlgRVIVqHnMSGUNwyX4gKqcXb1o2iDFjoHnQFRH
   CV7jdHaBIEvgP4uM/twXiCSFpwCsfZCIoSk62pwywZA90ljZTAap3b79H
   g5rhk4rv8YRskYZEYllFxIvz/KfhWJsdU1n9rfWSXSXhus7ytIwCfnEUh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="384643681"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="384643681"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 18:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="720502648"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="720502648"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2022 18:11:59 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 18:11:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 18:11:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 18:11:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naltYzRl0cHnQUTT6SdlHo2ce3sd2IjP0+vMlFYRPu0oelsJ7IQMnh0nfoX9rsLO113lQRLdUdOvYf/nX1VyQ1mws3V4sX2d77z7mQTeCu9w9q4NOlsEBFmMmR/HwPZa4RWiYrZmYqx/s1oXdesUzDjX3xRA2OqKlzrrmGR9bs1S97bhB6bYpHBbylmAQYBxgBRjvYqvjdUA9HePp/4XX8Uod+Kc7pD1FeaZ15/HcJ4rK/ghTaktcx74MWxRjd3TM0tFlYKAt2hxzqdYHZLsKdRvfC9g1LKniIRSmsY8zDBJirXtImj+8/lhpsRegnowBn8++35/F89uKNEIWhvBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks449Q/Xa2u8n+MpmaP89U0a0OPkv9MytyVy6RI5HL0=;
 b=Ar3udSVyNSgqRpS+2l8VgA3RFM98hMxhi+FIDyU9pyj2boxfg/UUbW7R3WqQbuJf7DYz0KccfHsV98WvYdjHCfy403Dcw372hiTGTHYiMtTODyLaV8GFagoCQuoHqE8g3oGcMvTo70qelb6KFpgdMm6bRo7HkPonTFf1SwPKhMpk8rspGRNUNwyN7R22kVv+gT3lePsmJ78HR/wWlUDVt/U2fBVMiY+i6+AXLLhQe9uTmYoS98Va50piMWXBqUIGxjIKpiBIxTXTacLq+iHkdI+8McxtTnu/KeKMt4kZDezEsBSl18fkfzzbIYGTcLcSgmDnvF0crpNsCqT8O1+DqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 02:11:56 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 02:11:56 +0000
Date:   Fri, 23 Dec 2022 10:09:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <Y6UNwAOQIGWyDfsX@feng-clx>
References: <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
 <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6P7JPHf9wDse0XK@feng-clx>
 <20221222182446.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec7bf2b-67ab-448f-5a9e-08dae48b10f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf2Gq5OKt/UCBqsqtmKQ7XSW/TwOnAHTSiKU301ejWJJauVsJF9BoDpikpRo6ijpMkONKnPiLofdkmDCqx2UXNSEEmri+fbiBwSAHKnWVKS7XBvnN0j7UEAJl5dVfBUHFGHxXyM8G7fci+tS7Ug/OTFa4pi6gbMO0ar9AweZ6WYWk0aDqbmrK6JHJ56Se7Mve+ZMuEktYg7XvW8PL1SWyjTvA9bKdKPSnTbDYH5Tld1vAh/GJiNAVL9glKwNPpd2k+FCn7OpNWAtbn3Ku4O+EUdIGG0v0jQwX1b5ilxGAJxAn6x2lsy6EzY+8vw6tzaf+yWp4PMy5VxXb/KJFPsGZoVUhzHcvRsn9WoT1Lymq3HskRBPRKDianQJmlwu72Y3CNm4/XJqbPrFbnchrdwEeJzn7JBXq3BsvGih0FH5DHDZlQ3kIeURY0WVjunAnI4e0My4JdBIvyL6q4E6Uz3EQB/Nb+FavzHmbsTJyekRUQ4CdrcPUApMLI9wNV41DRS1K7RCO1UpogDgth5XSxVcNApW44wUEpO+9nCDgQlPBOdlq7dvZW9m0xgLLFQbqDPpoEtQ3NRa8R09COlPrXH2PiUKfiD9LkiMNka0pC1dKe5BKPUXzeuGJuJI07wfFAmOmC0+qqF4DmJ4+cr3bQLusTl/aORwQJ8tHoxJ4JMp7A4dV/oEiUH9HmEObY5x1AYegunv0B7EmBqH2fnq2/2h6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(8936002)(38100700002)(41300700001)(82960400001)(5660300002)(66946007)(33716001)(66476007)(8676002)(4326008)(66556008)(15650500001)(478600001)(6486002)(83380400001)(54906003)(6916009)(44832011)(2906002)(316002)(26005)(9686003)(186003)(6512007)(6506007)(966005)(86362001)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wVmYG4AQEKMRwKlU9fEjTo3ZWWQ+vgKjxaxE21XaNsisKCp+vJQllwofmcVV?=
 =?us-ascii?Q?BCYpqXuCd3PTD0oQu6SN6B8b1Ik2nBFP3JUFeP/Enys4eanSQyw4PY7ahrP8?=
 =?us-ascii?Q?97Np6cb63R3TgA6R9iG/+sOqQWu/+sxQxgjda1Ejjam+p70Dk4lYQtgBqSoR?=
 =?us-ascii?Q?AHcU814qcKP7IpQEtcbC7zGl/cOhC1snv06eOzIOOn9v18o59UBKjiipYOjs?=
 =?us-ascii?Q?zM/YyBqzNPb4xa5GwOpdwgFtdy4zWLzddNgnw/LyF6qWCVTV1cmITP3cbrAH?=
 =?us-ascii?Q?m0gulwiGBOEjWvGMURa5pjnLXHhoARLuLfdU4nga9zA07J6HSeDOOy9wW4sw?=
 =?us-ascii?Q?G3XOU+jtnPyQ9w//zdJaPyFufrpaDlb7KAIHOOm6u859MclC2ETM+xcUyr/C?=
 =?us-ascii?Q?uILqIfwlGxVcdD/sZh/8pClTrDKSI8npCijdnD9B6pKS6o2paGrFSmd3+Cmy?=
 =?us-ascii?Q?f25+HJEtbWnG3FrtZ6FdxF5xzrQjdoiR/MH16CHWauB3tghGjGdpQS05OvOw?=
 =?us-ascii?Q?LDKx1uUaqTb+HyAj4JVtpHdpt8Oo7ySvOI+mw732un/Ni0QEV8r1H2oyhoY8?=
 =?us-ascii?Q?7pkOv76cRWcDbaKc2n63U1QE+wziTBlI95VZIuVkkfOvYYVAR4UMxNuUaDrE?=
 =?us-ascii?Q?P0c6YbcCnT95uydSOf03OzAV/DtVcKTth205Qtv9XiGlyU8n5C90cQBLDar0?=
 =?us-ascii?Q?9AP5EgbMzSn6/jUIQjD695e24zSnpzeBheF+CIbblilXGUqdXkW9DP7liHLb?=
 =?us-ascii?Q?8wzMBVBq7YyVrks63i7UugqyieQ4tC3Gb27Tj7heCnMYriC/s3cQpcqmz/kQ?=
 =?us-ascii?Q?JN201oYc1qv7E7svcr3X/sAPuEuShUxqpNTQTnQ0E7hgOGOyap8XOTp3YOfA?=
 =?us-ascii?Q?NZxUGx+kC/jVrtHsm3Jwg2iBdR7F9By+VCWGyF/9H9dH/sKg9t2UqqV1SciF?=
 =?us-ascii?Q?ji2fM0LMdAemijnIRTSWqFV+j5Nbm0AEuUguPSOG3EV8+6N31PMRQBF5RG5C?=
 =?us-ascii?Q?eakfiUO7EFSrDUy20Xufkwikmhq6wazIWH7rpqHZPJQRU6HG1siYxnDihZpZ?=
 =?us-ascii?Q?soiOHfaZ6wMIbYTeIqMRRCIRB/rLb1QUD2ecobDGcGVJqmPvoZ9zeycWcbzL?=
 =?us-ascii?Q?DhJuvc9tnzVZmLGwc2k1cttq+7fg9lAA+Z4DPPHqDQ+zYcJg9Tq2LlD7jRXa?=
 =?us-ascii?Q?Q735KX7nXA2fHFer9nITMIYSLsv3J9N8RuAfxRrldRlaBzQLkfsYhw1mixEQ?=
 =?us-ascii?Q?B5456xeNu1vjGzZWaUHwr42mIXn5/gKoNnlDuR2j+nZ3TRSY4RzhcYCKWSAD?=
 =?us-ascii?Q?jJhLaw3T40UIZySkMpD+rDmXJCZxAwT9wv4ldOUX+vq1WXNyhMC0FI/2stcz?=
 =?us-ascii?Q?/MkUp2KwDZfwQBMh+UCDr2Ck/Aj2J55HADmbwDiqKiQx6uKNU7bryVHxBfbS?=
 =?us-ascii?Q?6Q6d6ptkwORXCKKsaPteCTVMAhOIG6dH69wBpQ807Fwb5d6/nBrV5N8OhPUq?=
 =?us-ascii?Q?RhE9iCH39DXUxJtbRqY0aGQP5DXJO/vyMVj7NVw4HCiWpZP/sgMN9KcBvWtf?=
 =?us-ascii?Q?VaBdhNTg2NJN3hLJISgP/NkvLrg+Ni65PeVbhZyY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec7bf2b-67ab-448f-5a9e-08dae48b10f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:11:56.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvxTvuqJj+jGtOpUvVSqpKmqc/fH09A5Au65eZ1MXHn00cOiEC/4THT3JiazELa259lrdJ5ad69jaEVyx4AXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:42:19PM -0800, Paul E. McKenney wrote:
[...]
> > > 
> > > > > Also I've run the patch on a Alderlake system, with a fine acpi pm_timer
> > > > > and a fake broken pm_timer, and they both works without errors.
> > > > 
> > > > Thank you!  Did it correctly identify the fake broken pm_timer as being
> > > > broken?  If so, may I have your Tested-by?
> > > 
> > > On that Alderlake system, HPET will be disabled by kernel, and I
> > > manually increased the tsc frequency about 1/256 to make pm_timer
> > > look to have 1/256 deviation. And got dmesg like:
> > > 
> > > [    2.738554] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'acpi_pm' as unstable because the skew is too large:
> > > [    2.738558] clocksource:                       'tsc' wd_nsec: 275956624 wd_now: 13aab38d0d wd_last: 1382c1144d mask: ffffffffffffffff
> > > [    2.738564] clocksource:                       'acpi_pm' cs_nsec: 277034651 cs_now: 731575 cs_last: 63f3cb mask: ffffff
> > > [    2.738568] clocksource:                       'tsc' (not 'acpi_pm') is current clocksource.
> > > 
> > > The deviation is indeed about 1/256. And pm_timer won't be shown in /sys/:
> > > 
> > > /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc 
> > > /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
> > > 
> > > So feel free to add:
> > > 
> > > 	Tested-by: Feng Tang <feng.tang@intel.com>
> > 
> > Thank you very much!  I will apply this on my next rebase.
> 
> But first, here is a prototype of the limited-time clocksource watchdog.
> Thoughts?
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit dfbf67806c4c7f2bdd79cdefe86a2bea6e7afcab
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Dec 22 13:21:47 2022 -0800
> 
>     clocksource: Permit limited-duration clocksource watchdogging
>     
>     Some systems want regular clocksource checking, but their workloads
>     cannot tolerate the overhead of full-time clocksource checking.
>     Therefore, add a CLOCKSOURCE_WATCHDOG_DURATION Kconfig option and a
>     clocksource.watchdog_duration kernel-boot parameter that limits the
>     clocksource watchdog to the specified number of minutes past boot.
>     Values of zero disable checking, and a value of -1 restores the
>     traditional behavior of always checking.
>     
>     This does change behavior compared to older kernels, but recent kernels
>     disable the clocksource watchdog completely in the common case where the
>     TSC is judged to be trustworthy.  This change in behavior is therefore
>     not a real issue.
    
Yes, this changes the general semantics. Last year, I've posted a
patch to limit the watchdog to run for 10 minutes, and at that time
Thomas mentioned one of his machine may show tsc issue after running
for one day depending on work load [1].

As the intention is to validate HPET/PMTIMER, which are not as
delicate as TSC, maybe we can add a per-clocksource verify-period
field, and only set it for HPET/PMTIMER?

[1]. https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/

Thanks,
Feng

>     Link: https://lore.kernel.org/all/a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com/
>     Reported-by: Waiman Long <longman@redhat.com>
>     Reported-by: Feng Tang <feng.tang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index bae8f11070bef..2676e011673d5 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -209,5 +209,17 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
>  	  per million.	If the clocksource is good enough for NTP,
>  	  it is good enough for the clocksource watchdog!
>  
> +config CLOCKSOURCE_WATCHDOG_DURATION
> +	int "Default time to run clocksource watchdog (in minutes)"
> +	depends on CLOCKSOURCE_WATCHDOG
> +	range -1 1440
> +	default 10
> +	help
> +	  Specify the default number of minutes that the clocksource
> +	  watchdog should run after being started.  Specify -1 to run
> +	  indefinitely or zero to not run at all.  This value may be
> +	  overridden using the clocksource.watchdog_duration kernel
> +	  boot parameter.
> +
>  endmenu
>  endif
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index b153fce8c0e4b..c920c6c22e0fb 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -213,6 +213,9 @@ module_param(max_cswd_read_retries, ulong, 0644);
>  EXPORT_SYMBOL_GPL(max_cswd_read_retries);
>  static int verify_n_cpus = 8;
>  module_param(verify_n_cpus, int, 0644);
> +static int watchdog_duration = CONFIG_CLOCKSOURCE_WATCHDOG_DURATION;
> +module_param(watchdog_duration, int, 0444);
> +static unsigned long watchdog_end_jiffies;
>  
>  enum wd_read_status {
>  	WD_READ_SUCCESS,
> @@ -549,7 +552,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>  	 * Arm timer if not already pending: could race with concurrent
>  	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
>  	 */
> -	if (!timer_pending(&watchdog_timer)) {
> +	if (!timer_pending(&watchdog_timer) &&
> +	    (watchdog_duration < 0 ||
> +	     (watchdog_duration >= 0 && time_before(jiffies, watchdog_end_jiffies)))) {
>  		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
>  		add_timer_on(&watchdog_timer, next_cpu);
>  	}
> @@ -559,8 +564,10 @@ static void clocksource_watchdog(struct timer_list *unused)
>  
>  static inline void clocksource_start_watchdog(void)
>  {
> -	if (watchdog_running || !watchdog || list_empty(&watchdog_list))
> +	if (watchdog_running || !watchdog || list_empty(&watchdog_list) || !watchdog_duration)
>  		return;
> +	if (watchdog_duration > 0)
> +		watchdog_end_jiffies = jiffies + watchdog_duration * 60 * HZ;
>  	timer_setup(&watchdog_timer, clocksource_watchdog, 0);
>  	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
>  	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
