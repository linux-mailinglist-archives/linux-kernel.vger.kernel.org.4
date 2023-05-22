Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5270BF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjEVNIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjEVNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:08:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6C1B1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684760869; x=1716296869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZNzQv8eUXk33RYdg1DwsBK4btx9Cc2+y4U5E7iG1YMo=;
  b=bxH109DocCkKD+R+BOBn2i+cTBHbRdq94KkFgJsRZNBj34f1AB0dcgOE
   azLT47Uk5v6Pl4yoG13Yr1elOe3l1D8zPIpXkGBZqacm4LeAmBlRiTVzq
   F5jaEmLmUWeXu01g7PPPZ9DDBuFWCRy3ACWdOXff8gl3c4AWEaodmG33x
   e1573bknRPioYdpmal7QEx1xb0VjdjYxHbCNjiH/8WUC2omoJUXukgXJm
   LYOcblaHwnKe7CQrkiluLoPffRp0CL6SDXb06WMIGW4Q7M9eKc8v8HP+v
   FD927BU/nl9gbzvi0/Dyma+TUqaX0jyPA1TwSKKk9Z1fECKJ0LYpAOGvA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337503413"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="337503413"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 06:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="950077867"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="950077867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2023 06:07:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 06:07:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 06:07:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 06:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKZqwoT1fn0A9SW8+EIMUp6typ1zxN7yvcy/A7A5F2xwK53/YYLDJnjQWrqcW9WEKwpoWpQVxIxjXC3uE9GCW+38Qk7It3e/87FOoBcjpi7dkA49bZQxn9hjNvnHIfljL57ccqxS/PYXjd1j/5yWIKMPOg5OwzzedyJAFZRUJB1+6iIO4oNJLzVTaO3QdsGW5xHMsh4ofv9mPtEHgPTWBP6Um/rEnVsyCKTBNz/yhAsH8wNOJNI/zOK15LE+DVdIdBDg1BEVMVvSOz6w1nIvrfsX4Vy0hvhP5IabzpYyt+WVHSxUXpi4UrcbLOLAErEW3R05uj6ZnpvK5uwT9rPEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpjQ27ZMTsifHUNNlFzA4blmR/PqKyISxm1jroRzoG8=;
 b=bWbb36WzECTfv3HacX3Ovmswl+N6jBVin+RKneXbmvbYpfsIInltis+6Ei9cmhXOnEt8f4ABz+Rzj2TKAA2murVEEbnJcZkKd7SoPvOzVP89zVRjfAQ9uv677BOsLA3KmOwOAyIV1TNOx6pW4yUdN0qJw/DmMJ8sCXbAsCV6cKjKHj/bLH73jdJa4+261uhGJOSqpZju1YBERIUXvWPtITd6q7yYhcba8/r43yrmjIXIrRS7uMwJolra3IwTcv2V4f9vmkcjtS5gNXFa1m4hlFeXwop8Diwq3jUrIjc4RWF7g69MPD04bcNJMyjGTTlI41e9/b+LOXfzQmgqi8OGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7432.namprd11.prod.outlook.com (2603:10b6:510:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:07:02 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 13:07:02 +0000
Date:   Mon, 22 May 2023 21:00:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <paulmck@kernel.org>,
        <rui.zhang@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <ZGtnUQJy+1Nrazhy@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <ZGssENXFKmOk/zL7@feng-clx>
 <87zg5wwppa.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87zg5wwppa.ffs@tglx>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f8d747-3762-47fa-557c-08db5ac56ede
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ge1ysy0E5rHnYtiJVUMCspKzoODYxQhUfBeDEYcYBax1ziA75RC/Dr0CjHleTe5ozk8T3BYeyVjqgTdakq2t8eCV5Eqbjizn3aa0Cec3AdNSpClo7jUxikOQrPNI4vmZ/gZHkOcWrpyHQBe3/UdH+7HXNAPB0/zohjBupwhYwSS4UnHBQkyEHmtvua+i7+uP2O2j5zhfNqpgmYtt1285h/zsq5bYrO1Z87fXHwzXbb2iq1tNFuc8up+rvVSMjR3IoHF3+sMTvWCvyHm9qn8X8u0/eY38riiK3t/wqaRpeNr5YD40YMxXulSqTmFpsij+2BQZFs+Sh62C65zQ+MP31P3c9E9aixXv68EJygNY4zxGnpqD1esGrVsXAGPdk3+O45Gd2FhhVroce0LAnx2hKPoMX3xZl+01Ezz73nrF+VWULAJGVo9198Y516YeZW+9fqtYeoKO/8Fu04AIX7ZY7GSFlEKkfWdbssc/k6XOk4tbvaXH7Yq8OcY2jyhHUZegXncrkGyzHpfO8G89OLU3RUL8bmwaRrsUY8tYnhOD7V2ECD1uieSNWfhS4r1Xu+n2GPXMDa1wIM6GUt09gpOjz48jO2FXCFLJVoAxUfUy6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(316002)(478600001)(26005)(6512007)(6506007)(9686003)(54906003)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(8676002)(8936002)(5660300002)(44832011)(86362001)(2906002)(83380400001)(38100700002)(186003)(82960400001)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hsVv6NjsC0kmIzYNoHjs9CQCSa8fLKXsjh9fhly+lf8x4dTzi1xcjILAfSp?=
 =?us-ascii?Q?tAFFPSxawTq7NdhBhGLbKLRj55noed++TXTTT6rkdYy73kSSjinbjBAcsPia?=
 =?us-ascii?Q?tJ5L7XW49q4OVPA75bqsd7ikWrI+JHLsBto44q7/qg5J5Hfrk30cJnomty9/?=
 =?us-ascii?Q?nAcW/buRSNiVStk+EAPZC+N6tk72YCOOCihbMcn8x7BIylP9cjuszDw2nUWL?=
 =?us-ascii?Q?D/im1Kf34awpAbHoxh2oF8vfLNIf/l1Vu151O0MkXXe8vuUqShaHJTZslcqV?=
 =?us-ascii?Q?lo4cuuD/+LX2j3ZFen3n/VtCx+r56z5E43QVIkyAGrhahQIYQlCOt5kw+V9v?=
 =?us-ascii?Q?wmHCDmAmwYrVvOMLPTiyyEZWuMAdkRhnfhIR90rfTDYeDOrDVz0V6iWSQiiF?=
 =?us-ascii?Q?fG2ZoNGByKU2V+qaIjBqfjCFb+B3G4KraOKuP+AvPgDPxLZkwWGzJkMqRE4d?=
 =?us-ascii?Q?qX6NbRQzAVsVYXt5YK9uNjYjE60p2TaA5EGH0eanq4BRjbjhrhbx/oynOfvr?=
 =?us-ascii?Q?w5GIzIrZsftield6BmSuw5i7NQDDb1k3zJadXFzQI6Nx9i3zTLHkKe4MTsrV?=
 =?us-ascii?Q?yIrcrqpQB3UBy8f/y5JlewCdniMJqXl/gfJBRc/2ZRL1q/EOFq+vC0SvRf0g?=
 =?us-ascii?Q?9/0pcqsLV3fbPF++UHQ1IJq18AlN6E+b8SKEGrfcGZ78h7cS2Djqtum/8KpN?=
 =?us-ascii?Q?GtZRQVZ0UQzrlQu5U6lBmH2/AhKyjgOacB8eP1gkST09QcdOtYASul2mPY/1?=
 =?us-ascii?Q?fOXtlmTgdDaCDvK3PZ4hZA2rmYhirP99K13Z9ArsYxq9J3hf2WhGoal5tQfM?=
 =?us-ascii?Q?WKXcSeudHPbsLuBF+N93Ma9+lqKY9wOW22Ahc1kr3lV64AO2BhLWfYCuEdv5?=
 =?us-ascii?Q?zBJnRGn72VWrlj9HsWEixoMQYfa1Q8MfIFX9ktVYJr0d29py3xo7F9gon9CF?=
 =?us-ascii?Q?fsTvyx8/GmZEZrJba/qf7f7rGSq5H8nWQB5VG1DiGTArJb44xUhzK0wpg1n4?=
 =?us-ascii?Q?cOOy9pR3T3SB5gMqO8UmOAYZ6TcafSIn3EcetUIcHvRQTrajl1qNqWcfrY6k?=
 =?us-ascii?Q?9C7sMP8Coo2YZtbZSvIuZ8GrQb/Q8RdW+5qGPeqqKYdSECWH30N+PUNTNhi6?=
 =?us-ascii?Q?IPALHBxu4PZnt/kixEMGL/TXgDTe8j8zhFuVb6fxWg/+kRJDUQCj6MuMNP/Q?=
 =?us-ascii?Q?2wjijypdDPi1SIizg7WMiSPbJ/2STebiVfLCexcls5JEUjRlRv/rFdKedJyO?=
 =?us-ascii?Q?GvqWpiGPO/r24M35RubZvJiji9gWV1/5awtt6zGYILUXkXQnSBHGZO5ZetwK?=
 =?us-ascii?Q?v0Tlj37DPnj0I71r3ZqS85co3ImV3O/GZ46GlTCLXSonBRp7Kck7n8c/v8DX?=
 =?us-ascii?Q?8jCWeOZxEiVFj2jCaHGg1K7AZFWq+lz29hbqTXpb4oe3jbpcOMifenxwDkWo?=
 =?us-ascii?Q?ntSxcd2nLysg1+uFk53HkXV9JFASeZSMxvK4mOPfeDVppKvLADEuSycGRinE?=
 =?us-ascii?Q?yYZDtGPScP031QLRd26RsWG62gwFuFO+V9OM+3yrhbrg+7xlkEeMn/LmzOel?=
 =?us-ascii?Q?BA8wBmITi3wDgAwSm2WRJ1mt41TP21w3Y/Yh8hy0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f8d747-3762-47fa-557c-08db5ac56ede
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:07:02.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4wWMO/sOk89qkWfrO6JLqkQMnf4vFGq+FDbUX5UZO/p8vmAlEmrNXOQwZdN0jPwmhxFY1MraaMdN9pNcHWhYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:49:53PM +0200, Thomas Gleixner wrote:
> On Mon, May 22 2023 at 16:47, Feng Tang wrote:
> > On Mon, May 22, 2023 at 10:14:08AM +0200, Thomas Gleixner wrote:
> >> On Mon, May 22 2023 at 11:30, Feng Tang wrote:
> >> Are any of these affected platforms shipping already or is this just
> >> Intel internal muck?
> >
> > Paul and Rui can provide more info. AFAIK, those problems were raised
> > by external customers, so the platform were already shipped from
> > Intel. But I'm not sure they are commercial versions or early
> > engineering drops. 
> 
> So its at a company which knows how to update firmware, right?

Yes. And the recalibration may help to exposed the bug quickly.

> >> So why do you force this on everyone?
> >
> > How about we keep the optional parameter, and enforce the check for
> > bare metal platforms which got TSC frequency info from CPUID(0x15),
> > like:
> 
> What prevents a hypervisor from providing this info in CPUID(0x15)?
> 
> > @@ -670,8 +670,10 @@ unsigned long native_calibrate_tsc(void)
> >  	 * frequency and is the most accurate one so far we have. This
> >  	 * is considered a known frequency.
> >  	 */
> > -	if (crystal_khz != 0)
> > +	if (crystal_khz != 0) {
> >  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > +		tsc_force_recalibrate = 1;
> > +	}
> >  
> >  	/*
> >  	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
> 
> and five lines further down:
> 
> 	/*
> 	 * For Atom SoCs TSC is the only reliable clocksource.
> 	 * Mark TSC reliable so no watchdog on it.
> 	 */
> 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
> 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> 
> So its reliable and needs recalibration against hardware which does not
> exist.

I misunderstood it. When you said 'SOCs which lack legacy hardware',
I thought you were referring those old Merrifield/Medfield things,
which may have no HPET/ACPI PM_Timer but an APB timer, and mainly go
through MSR way (tsc_msr.c) for TSC frequency.

In this native_calibrate_tsc(), which touches the INTEL_FAM6_ATOM_GOLDMONT
and INTEL_FAM6_ATOM_GOLDMONT_D, I dug out one Apollo Lake and one
Denverton platform (which comply to those GOLDMNOT model), and they
both have 'hpet' and 'acpi_pm' clocksource registered. 

Thanks,
Feng

> 
> Thanks,
> 
>        tglx
