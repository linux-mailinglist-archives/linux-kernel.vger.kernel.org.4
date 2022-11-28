Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43433639F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiK1CS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK1CSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:18:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A4C745
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669601934; x=1701137934;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s0Bb9ONHsdewxXYdwpjLWTF4Hw4/nJxX+3CFrWv333I=;
  b=R2IagaL7rVsgRO7PmJkdhzDXQeT0dV0ML4t+ebbQ3uWtuNPqbsDOBBFj
   WjumAgBSDzM880OMSReuERZXmFxa5dw6Gb77zpyKQg9N/sDDWd1XNBJC4
   OZdd96l/Y/JuNa5GMKPjAISW07DJo2rDNsQLzmXgxdV/dEUX4crvveKed
   +YL+2T96pP2JTJPgVuDO4s0JNDiixJlWBjOvgmEcECqu9lzb9voTh0boJ
   hbUbdL5I18p/dg5UsFdCP+mUz7hV8YQWVaQV+r1TtB7Kl2KKEF7PJKdRL
   4UZnW9WIm4MmDDY29lu/76i7UWJWLzA2YmZmc9bQTKA5pVGIrLrv1V3cn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="376873426"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="376873426"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 18:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749195961"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="749195961"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2022 18:18:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 18:18:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 18:18:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 18:18:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+PGYQJwXz0t0qJ3fj5DIv2ByxQzxlsxRm2ifGtWQUz+2VETR2gDzo5jkcB2rY1qv6U6SCQS4WnYSmHtcUWeCmw20cLEzpgThdBcxplLUIk+Jhft6pV87bvFuVjnTQTgJJ8R3slLfs/yrpLmB8dKbBhWZcc6uFNeUgztFKW9nT6BW5AZPVDbk4QIbEoQj6Qnv1dz6jFWKomsSXbUJeYDNRqw/Hf9RW8agEL5eJBA+5l7WRW6x515HLnP63BQvIg8gLMNwpUAOn9quH1ncY+8yk5+tJhO98iCyKrThQycROINMx+GVQBBFZ8j3ROPafVriA3qsTf1VUU3mtLncqG9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t9N7T7DtkAYSqC89MLcefYOeS+LlRNBinP69c9KsKA=;
 b=jvV63MYbpxD+E7sxcsE1tbPKdc5lRZf2FzXZPMNKE6iYp5mpAjmXVFl2UFLGg+l3GsJhRs2qj2CNFwpoMT2VN4livI/y31C5gLTAz5n09yJf7n0WJqLZWJtkh4DfoSkCPlSBmytO4Y/IK4jUOAz69SXSbE9BQn2/wpgOmOLK1P/Nso8EtrW2bOMH2jkl6+3da3uHeRLT7THM+RVH1GAfI+w0LxGdb74coLQEejKTe499hnKuhMj7hxsWT8eSDGK2bn74thu3N2GnOt5GyFiDLo3H/eX0+nd9vJLFfFPPLhIHkqo9mAnPEnSL5gYbXTehWTHdnrlitwTkqpiiPRjEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 02:18:50 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%4]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 02:18:50 +0000
Date:   Mon, 28 Nov 2022 10:15:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4QZzzk+FdGj4AXm@feng-clx>
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
 <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a117bbf-aa67-4055-85ff-08dad0e6e320
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXAxEUxIt3GVNDTnhvBOS3Q7TrhQIfM7GMbd73Y4LfMAHG917Ts/EKZ3ni2jtVc4uTX0bPvTTac1BdIMOnTeHoUSWkVyKJ/9USn4Wo6tfPy5rL5FdR/8YtuyyBJgzRwSDBak11BnFZtAjqUfVTvLt6El9fy5u6BMJLUpN999gchaHZav+Uh/JDyoYzgOzUZvgezRLCYVbBGZn13XVeXscD2c01n5FM2E6Ul4Rj711Le+fbkdfvLn+F454YSK1SPhCtt0XAHHX7xFYLFLGvHcPu8pG+/JakybkuGALLG7/fOD0AvP14Dc5Nm/yTmVNvRyvwpkFZ+bL80dogi36zF0Il2StEoQNrNOaA0IHDu4XddKJDOMMmLfO2Wv1tqgPZYTr6V4CX7XUza6M2F3l83zCc+l7CP4qB6AuVmGgA3As4hvu48TbJxJAY5O3u1d1OkiTpZf6dKpN5PHxUy/iDMUbUzB8MqQ+HwhGI4KoU0YxSOpHTzDej3wIr5EYF9byCbEgBrcM/f4kt68PURPRrS2Vrb/XDHkssJOLmL+fFYaq46bT2wn2PJL75nruwkWuUWnzGYhuA4LlODoX/dKgY4pHPHqgnJbTYXI4D6UI4yeeJuPruNQqpAhAYmmuYDTjKAiJn2Cs3eWdBfLQe3eJkiVVTLpnTj7FMh76CxcC+jPBS/PncgVX6mxocKlchUxY4QkQKQWIf5MysdgcxeXk6ZOCbfqy6bRKR6PouvWI8GH8VQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(33716001)(8676002)(4326008)(83380400001)(6666004)(66556008)(6512007)(66946007)(66476007)(41300700001)(9686003)(6916009)(186003)(86362001)(316002)(26005)(7416002)(5660300002)(44832011)(6506007)(2906002)(8936002)(54906003)(478600001)(966005)(6486002)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNNjnhyvb5QxAiODsjKYXnwQsnyiQkO0AjHsgwzhN7XucWUWf1YcEOhmipEw?=
 =?us-ascii?Q?A2Gi9Yx6KWbcwDMgUEgKTGGZREmb5xjinIdWkfrGl6BEEqBiAISUeURY6jLV?=
 =?us-ascii?Q?w6wsJCtrxDstFgO1i+3wuOuMhVsfbSs1nFt/h2RydDasuQzbCUArqHeMohIa?=
 =?us-ascii?Q?Vpl/2hzmfh/JhD2DMhovBmFhXjvptkR7Lq85Eqt8KKJBWT8xEPz75HDtN8BK?=
 =?us-ascii?Q?0IV4HGFy9GyWmE0fjWsARZh35Vehs/GoKfH71CWwoq52B/iKbMVR3m7DQovz?=
 =?us-ascii?Q?FKHJGDBTpaEAgQpiiqe+5aIQHsLUUNDk0bm3D2acWC21R9MSv1b8QnCaGL/6?=
 =?us-ascii?Q?v+QRdnJBddcn9ibpqfAF/Ho4Zek/1aujWcAtgiRTVqkAgQ8feUnZtkWrgK8H?=
 =?us-ascii?Q?i6vJp3nlW3Tz1n4/bjA3hUncIMyopGIXoIipeepapHPMer8wpiniN8mjN2RQ?=
 =?us-ascii?Q?p9YONNDhRi3OJas29p/B0x2ILtRNdd76TeUN2HV9aSqcV88G7tXrUoJTQilu?=
 =?us-ascii?Q?9V3U/GdKPMGprgY9V/d6yjoRkCXBYEUAOJwyqXrMFH7UAw5Qc3jv7Cg4sN4f?=
 =?us-ascii?Q?89v3EKzk6pKNNBmDtNn2vI5pwk/P4bKJ6jW+6OI0MZR5lD/QTUtZ7HXifrHa?=
 =?us-ascii?Q?bVvpiUSgkghJIlt1pdgiMBHZTbvPljCtwaIjjTzf75pEFle1fWRnABp/SB5/?=
 =?us-ascii?Q?DkKVDnsEARC86H6myLhLDcZLmy1Ot0FDoQRWwnk62S1HLKkcnVc32ebdV+9Z?=
 =?us-ascii?Q?dvkZT9IYY8yqjkuLcNERZs2yczi3nJFihQQUK9FDBbpoF+2P8/9BqiJ6EJcx?=
 =?us-ascii?Q?G2KmINZ/odPg2tLCPulEPnYzrhRngxuS4c0RF1Bizl/SgPdkdk0zBZkHKnu0?=
 =?us-ascii?Q?KY4qczYYYGu51bZ2HAM9Ayi43HJKA/iBgyLzGNGDcDYK3qTWjUHkeFQoqKj2?=
 =?us-ascii?Q?QofOPf5VESnpxpl0IomJbziPkrE0Ezo9xwcbbIuUW+ehvEvasjfx/T2qGUVA?=
 =?us-ascii?Q?W3mnlzeR2qdfC2XgqKaXhbVCCDd3GsAol1J30i5b5zXQccJzkKiRCwxoNZVR?=
 =?us-ascii?Q?KODM7NqKmyFRG4g9PLLlMWg/RbNIHxfTaW8IPh9t2HqWqqA9ulzTXsPIgzWH?=
 =?us-ascii?Q?sNacy6TC1yXqWQ97pG4RrW2HQsnuRhPyQVDE3sKz65bZjrDFkKZHD/58NRC6?=
 =?us-ascii?Q?C1ch7r5ZFn2be0O9ju+BeSgUYc61ywtGOeYSU5oTY1G1bB/zTt+WmbM/Mmd1?=
 =?us-ascii?Q?WZKpdc9CLxd2mhDCXDeWZ99D+Dn3TyoiW2K4oPrejhQLF+nJ0a2GYvvMZGam?=
 =?us-ascii?Q?z/JJJ7ueF4Bc9NCfORkcE4+Za3L5gNoDdhGy3krAOXBN/WIzlVW27x1JURqg?=
 =?us-ascii?Q?pl5NlvhVVY3WF/4AfFAAjLCOk/lPrti8MCVG5fmWo7jatKQgdGUMaL5W4ZyG?=
 =?us-ascii?Q?VaSkiabZtrXXNB72dYBDWNRdyOT0mVLmvnGZUuHU8+9lHob6l1x25WeE55Uw?=
 =?us-ascii?Q?LORHZPW2dZmNkQdVwTbWgZuk8/ewcBQjQJBE5oltiOH/kreihMkzU9wKkzFs?=
 =?us-ascii?Q?aMC8zu8QF1lOoE3ChD58SbAzdCCDqViTwgsnTU7T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a117bbf-aa67-4055-85ff-08dad0e6e320
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 02:18:49.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axNNfUS+WjIO6+9d+H9N38js4CJOCCtdp9gG+fvndLlp4a+gODYarhbUKB7myJjCTh1iOuMmQR7Akkqp0sscnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 01:23:48PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 10:36:04AM +0800, Feng Tang wrote:
> > On Tue, Nov 22, 2022 at 02:07:12PM -0800, Paul E. McKenney wrote:
> > [...] 
> > > > > If PM_TIMER was involved, I would expect 'acpi_pm' instead of
> > > > > refined-jiffies.  Or am I misinterpreting the output and/or code?
> > > > 
> > > > It's about timing. On a typical server platform, the clocksources
> > > > init order could be:
> > > >   refined-jiffies --> hpet --> tsc-early --> acpi_pm --> tsc 
> > > > 
> > > > >From your log, TSC('tsc-early') is disabled before 'acpi_pm' get
> > > > initialized, so 'acpi_pm' timer (if exist) had no chance to watchdog
> > > > the tsc.
> > > > 
> > > > > Either way, would it make sense to add CLOCK_SOURCE_MUST_VERIFY to
> > > > > clocksource_hpet.flags?
> > > > 
> > > > Maybe try below patch, which will skip watchdog for 'tsc-early',
> > > > while giving 'acpi_pm' timer a chance to watchdog 'tsc'.
> > > > 
> > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > index cafacb2e58cc..9840f0131764 100644
> > > > --- a/arch/x86/kernel/tsc.c
> > > > +++ b/arch/x86/kernel/tsc.c
> > > > @@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
> > > >  	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
> > > >  	.read			= read_tsc,
> > > >  	.mask			= CLOCKSOURCE_MASK(64),
> > > > -	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> > > > -				  CLOCK_SOURCE_MUST_VERIFY,
> > > > +	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
> > > >  	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
> > > >  	.enable			= tsc_cs_enable,
> > > >  	.resume			= tsc_resume,
> > > 
> > > Your mainline patch b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
> > > for TSC on qualified platorms") mitigates the issue so we are good for
> > > the immediate future, at least assuming reliable TSC.
> > > 
> > > But it also disables checking against HPET, hence my question about
> > > marking clocksource_hpet.flags with CLOCK_SOURCE_MUST_VERIFY at boot time
> > > on systems whose CPUs have constant_tsc, nonstop_tsc, and tsc_adjust.
> > 
> > IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> > report that the 500ms watchdog timer had big impact on some parallel
> > workload on big servers, that was another factor for us to seek
> > stopping the timer.
> 
> Another approach would be to slow it down.  Given the tighter bounds
> on skew, it could be done every (say) 10 seconds while allowing
> 2 milliseconds skew instead of the current 100 microseconds.

Yes, this can reduce the OS noise much. One problem is if we make it
a general interface, there is some clocksource whose warp time is
less than 10 seconds, like ACPI PM_TIMER (3-4 seconds), and I don't
know if other ARCHs have similar cases.

> 
> > Is this about the concern of possible TSC frequency calibration
> > issue, as the 40 ms per second drift between HPET and TSC? With 
> > b50db7095fe0 backported, we also have another patch to force TSC
> > calibration for those platforms which get the TSC freq directly
> > from CPUID or MSR and don't have such info in dmesg:
> >  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> > 
> > https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> > 
> > We did met tsc calibration issue due to some firmware issue, and
> > this can help to catch it. You can try it if you think it's relevant.
> 
> I am giving this a go, thank you!

Thanks for spending time testing it!

Thanks,
Feng
