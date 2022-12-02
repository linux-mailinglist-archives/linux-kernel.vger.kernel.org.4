Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6179063FD86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLBBNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiLBBNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:13:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CD3FB81
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669943601; x=1701479601;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UsLuMZcXHsopcJJ+djG52/LC/cQkR5QhIbIpVrfUm00=;
  b=JvA96RQ/ClyznMkhkFdIBp6YwcPyJsMcR8B8qeApMJ8sYTRkEh6IGVo2
   y3ssv3pyDlzX9lt0G6kJUxWFbzMTpKDQflQ8OY8gBYTAOH1n5R5Y+0X1T
   FBAb8k0MKPTXT+yGRp42HpoCIJfzArub+RnAGJQU5/yu9Aalu3/K6FOvo
   iAcNCaY6kvLs0X+hMpZyV+gJmdvgrB+dlJ6vZTN0nncWuxMj4pBOiuexn
   zKRs0Gpi7/KCWfGDdTdDe+8R89xIzUVJMg9L6thOhMHNBogYE9o5qeKFg
   cyfzvqqlzT6g6Q8oO8ocCFXbErEb6CJb5ZOPF4/j9OA4JUHU/1B3My8Yz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303444734"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303444734"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 17:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622514170"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="622514170"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2022 17:13:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 17:13:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 17:13:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 17:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnwcjF9vY2Q0ianvhFj5Gg/LG18jR5fv43miLblnspy6BJI0h/YHyFXZmOXJVCaLtnirXOl+Wrq/xcd37mPicFnEyO4TnM/Ez0SrjdSndfF1uh7kMsnUv1q4z4OtK1NMkn6PldYcVt68hIKd2tLiBvSAmqAnK12KMMB+Z2+2Iu4M96DnZAmgsKZML7Wm+Qk7eS67ofjfc6vO8Rh+fcqy1naJ84s5b1lGvVyiZqokMk1i3/9UoWhnb5rgFK6gKtel1d5jj1ZpFTLRbvQY5ZQMeMYzue6Kex+KJEBxGtibe2PAUP542ZIII0R5Hdvq0fORBw03I2jZnLa3Yo3c/VCokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t2TD9LmxgwuyOBUdxsCUbDOJEnfJGgE491t5NRsFLE=;
 b=TE9KZrWIP0JtLBFhIJS6g9r8SLNFJA3P3fVBhX6EVi+EceenJiNOcKMo4ZW/VC001mG9Gpk4CAboDLEGaIw3eYulb75IBXmKWaGp79RSNNGpDkTXvaBLgyRzX27p+Dc6HXLkLo/RYPNa14WorOfs8M+zhARJbiRrJIrLz4gFTYD+XDNcRu3nwhkD88vBGmnxUZMHQKKg23vZorjQR5a9GY6XotxhfVsJX/68MJXOga174ljgnaDl+EGUg4DoH24XdK2Fqibd/PAf7lMc7xpFIi4i0HcSMCX61kmiPYV82n6sSXpiBxqDcsPFs+KKE3kBJo2vpxidXleuQFqPkItpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 01:13:16 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 01:13:16 +0000
Date:   Fri, 2 Dec 2022 09:10:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <corbet@lwn.net>, <Mark.Rutland@arm.com>, <maz@kernel.org>,
        <kernel-team@meta.com>, <ak@linux.intel.com>,
        <zhengjun.xing@intel.com>, Chris Mason <clm@meta.com>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4lQdKaKh2P7eLBG@feng-clx>
References: <Y4QZzzk+FdGj4AXm@feng-clx>
 <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
 <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bxZCEAmPnALsRV@feng-clx>
 <20221201172405.GI4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201172405.GI4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b33eb63-2370-4a6c-869d-08dad40263ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbfWMgCGnf+FMuNr51aWoFfZtrXd9Fh7YLo9jcW7QDBlzpix3CQqkJnOnl/4X+8n/VCS4mtChUDOdYVTxHOz5CdaQ5ZIiZ3Qsn1zkhSEeTdJ8Xjnti7Cp+x/mPKCDjn9bZFEuEm82jOPqwTg3z+ssNQpcfzEKiKYtlWpfRwLU0xFoZPTxWnvqtW3g43cJZt8Ev5CbQ8UTHvhDvPrk3Gjqs/y1jK9TOUnrZMgE2LjJ5Gu8t1nkkNVNI5BOViiiNogJqQN/yLUFthnjMZnUb0MezWfboRZvBUKaY+2O24gLG0gquYwkMbbVRQI0LSz5jwVLSuGC7i+BLu/YuUh2VHXuOCSdpF6j2HjdZXr4T/EiQmt2aWNaiR9vAar4kFUXHad9Vwpb8zeRvpKibmKHHtP4aSyZT023J9OgeDIlEx26ihHx4BVuw7f65SE1jJswlRWGyJT2s8nc56PVTFDxoc6vXbnZph2ZZ2WF0Fp0r0g2WrVLxp6LEq1hnEmuFFwGkPSJXUy7+tzm8v59PkDNuckcpSj8BpEE0XMuP+++E3W2Gq5/7Cp508oTdP5pFFwP6x+wqSLHjLLThh5huxu8uBjPu86hcTf+OedsO+RUIx1ga5OY0SvW1yREnrHKIlYZSRa/SBk7noS3ceoWnRweXDAnEkeDVRdqNVOLcUlXocFxrPAEfG5E2fYqHf8yQCGLb7v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(9686003)(316002)(6512007)(26005)(6916009)(54906003)(8936002)(2906002)(7416002)(44832011)(83380400001)(5660300002)(41300700001)(186003)(4326008)(66476007)(66556008)(66946007)(6486002)(8676002)(33716001)(6666004)(478600001)(86362001)(82960400001)(38100700002)(6506007)(57894002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3B5eEs5U0R0Q0xXUXJKRjJZRzRHZ3lmRFVnbHdWVkIyMGt1aGhvMHFzckdo?=
 =?utf-8?B?Q2NrTkl1Wk05a0taUERtRzF4WUZubGdqeGV4RjNmK1JtakptVlhpSUJBaTcv?=
 =?utf-8?B?dkJrT2hFTVNtVkhHTkYxQ0JxTUxZK3lUYm92WWtHL1dBOC9GQW9Va3A1WWZk?=
 =?utf-8?B?Z2lPTjRCbUtjSmF2ODg0U0Fza1BsWVJaRVVWdkNMSGNJS2ZHOE02ZSttdHR1?=
 =?utf-8?B?Q1pHak9naXhMTSs0bG9uenIzRE1kdmJnQkEvb0xQUTEwdzVoeHhDNWgvZ2RY?=
 =?utf-8?B?a1BITFVzWlVqVSt1Z2IrNTdaUkVKT05TZG5PajYxL1ZjaWh5NDdSbGNQMWU0?=
 =?utf-8?B?QzkyU2hGaExBckJTWDdHeTBLdkdpOEY5MzZDQnRvT2IvQnhlbmJZbmxjVTRq?=
 =?utf-8?B?d3IrVkYxbmYzUXpxamsyc1loQlU3S2dQYU9OSDB5WjJFWVNCTTU3M3J0enpU?=
 =?utf-8?B?cXRTK3FLU3YrLytEZ2pyMzJNaytvUytSK2dwNWl1Y3dHa2hNa0swaGd4UW5s?=
 =?utf-8?B?eldVWmNZVFBVbnVLa2FyU21VSmppTHI0MmpSdm54dkNJM0R3bmlRbkNZd0FU?=
 =?utf-8?B?UWE3RnQ4Q3dPNjVhTGExdW95dndTcDJzQkswSnZvMlNScG5zUjJUNFB4YjBk?=
 =?utf-8?B?cHdlNEtCNnRxZlMyc0IzUVczR3lLdTIwOVJ1SFZIWlM3bk4xWlplRjM0ak5s?=
 =?utf-8?B?TlRPbXdSaHVzVkx3d0pTWno4L0sxV1dkT0FpQmpBanpvOXFTUDJkQUNOd2Fa?=
 =?utf-8?B?UDBKL2xVZmtqL0ZkeDl2Qlg2aWs0NHpFM09DbXF1NjZUN1J4ZnlseFNMbjd3?=
 =?utf-8?B?VVZsQlZYS01nZmJjOE9PbVliMVV5OGQrdFNtVFBVNjdHWDUvcG5ZSC9UNytD?=
 =?utf-8?B?MFphdUNQS1l0ekpqUW5qT0tIaXJza1ZGbE1JVTJDZW1lL3RSdm96KzRiUUF0?=
 =?utf-8?B?WXoyQkFGRDJzMUdrOTlyT3JwZVNwejZROVAvbUtBM0ordjJFVlQwd3ZaSkNS?=
 =?utf-8?B?ZUFIUzFMWjdReG5nTXBSMHRSNjNpR0pXZnM3d3NlYmQ4a1EyY2V0UkkwNnNh?=
 =?utf-8?B?SnRhYUpLclo2WkQ2SVZEYS85L0FNdnJFTG9PNktTZVVsK2pNS1RPcGw4d0g5?=
 =?utf-8?B?QkxsbFFNYUw0U2o5UjdBSGZsRTFyVmtySDVXenpSZ1JIS1N0NXNJSjdkUTZo?=
 =?utf-8?B?UWF3cWNybTcrbit4OXBLODJ4ZVF5QTJkdWdBeUptYjhQL3YrNjRFZ1BpQmZL?=
 =?utf-8?B?WEM4cmxUanJ2a3lrSWlxWTRHSWJLMlpINHpEOUdtOXl1YlZMSi9LWk5CZXMr?=
 =?utf-8?B?SDRneEd2cndOQ2QrYndKcVVGNkhKaTQzWUtlMmM1ai9SUW9FSTNRNjhIZUdh?=
 =?utf-8?B?QlQ0SXJ4SENhVDZrNENoOXBYWGlaVmF4ZWYvbjJ0cWpuRzJuWkV1VWVEYnpj?=
 =?utf-8?B?TkJtWFBTR0ZGdkMvVGEybEREVkY2N1A1aUNJRE50cjNSZWNvZCtMNng0YWNB?=
 =?utf-8?B?c2pyWWFlZEFFSEdESmplSkNMUnk0dWRtaW54WUVsT24vTnhVK3Q1bm4xVDZE?=
 =?utf-8?B?RzEraEg5OSthbkRHa3VnUXdzU0t1VnBZYnJKWURVdnp0QnlVd2RGcThTTWdW?=
 =?utf-8?B?TlE5a0RvNVZ3Z0M4Y3VSazB4M0R0Tm1TTEJCbVQ5NjJha2VBUXdTelV2Rndw?=
 =?utf-8?B?eW1TUmFXSHIvS2ZSQ05lU01LaWJhMUQ1TDFWVjNsVlpjdUhTTit6ZDk2QVdT?=
 =?utf-8?B?NGRCQnZINmJtNFVpR0o0TGJrb0dZbkFPREdzWk9FSTBucWJrWi9JYkxTNnVj?=
 =?utf-8?B?RmptK3BJcGxCRTFFeTFLVXpXc3BNRzkvM2Y3WjBLMzl6Z0FEK0dyOCtKSmZk?=
 =?utf-8?B?TVdZa3RpWVdBekhEWjJPT1JMTWUrVlJMcm9WNzlJQURQODdtL2ZaMHNRTDk1?=
 =?utf-8?B?UFFpUDVNTnRydkdZakxLVGcxMHVkM3FoZ016U0R1NU91VjB4K3dqV0NMYkRG?=
 =?utf-8?B?aHJ2QS91T0dHQ0NNNWlxRmtVT3hBcGF6NDZ4MlFZYnRtWVBFbHMrMVViTkNC?=
 =?utf-8?B?NG96M2VjRGJOL3BEWW5aVldBVVU3ZFcrc1BsamFmQ2lsVmdnakRpdUhpUWJ0?=
 =?utf-8?Q?kykQmPnp/q5gM4Dy5XUkyke1J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b33eb63-2370-4a6c-869d-08dad40263ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 01:13:15.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0Xxj0w7RWcGACTwHWJY+mknU4rWUkgmEsvjiEJmg5UqbC27BYmBn79uH60dVlneu/+8mCpmjrpKg9zGkeLnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
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

On Thu, Dec 01, 2022 at 09:24:05AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 30, 2022 at 02:00:04PM +0800, Feng Tang wrote:
> > On Tue, Nov 29, 2022 at 09:50:24PM -0800, Paul E. McKenney wrote:
> > [...]
> > > >  
> > > > Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
> > > > and it matches the 40ms drift per second you mentioned earlier, this
> > > > seems like the CPUID(0x15) gave the wrong frequence number.
> > > > 
> > > > Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
> > > > which has deviation.
> > > > 
> > > > Either way, I think the HW/FW could have some problem.
> > > 
> > > And this time with your printk()s:
> > > 
> > > [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > > [    5.268858] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > [   25.706231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > [   32.223011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > [   57.823933] clocksource: Switched to clocksource tsc-early
> > > [   58.144840] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > [   63.613713] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > [   63.637323] clocksource: Switched to clocksource tsc
> > > [   64.673579] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > [   64.703719] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > [   64.716816] tsc: TSC freq recalibrated by [PM_TIMER]:         1974.999 MHz
> > 
> > This confirms the tsc frequency is calculated from CPUID(0x15).
> > 
> > > What would be good next steps to check up on the hardware and firmware?
> > 
> > Maybe raise it to vendor? I have no idea how to check thos black boxes :)
> 
> Done, but no high hopes here.  (What, me cynical?  Better believe it!!!)
> 
> > > (My next step involves a pillow, but will follow up tomorrow morning
> > > Pacific Time.)
> >  
> > Really thanks for checking this through late night!
> 
> No problem, and I guess it is instead the day after tomorrow, but
> I thought you might be interested in chronyd's opinion:
> 
> [root@rtptest1029.snc8 ~]# cat /var/lib/chrony/drift
>         40001.074911             0.002098
> 
> In contrast, on my Fedora laptop:
> 
> $ sudo cat /var/lib/chrony/drift
>             2.074313             0.186606
> 
> I am (perhaps incorrectly) taking this to indicate that TSC is in fact
> drifting with respect to standard time.
 
This info is very useful! It further confirms the CPUID(0x15) gave
the wrong frequency info. 

Also I don't think TSC itself is drifting, and the drift some from
the wrong match calculation(1896 MHz), if we give it the correct
number (likely 1975 MHz here), there shouldn't be big chrony drift
like your Fedora laptop.

Thanks,
Feng


> Thoughts?
> 
> 							Thanx, Paul
