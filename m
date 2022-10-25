Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4260C5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJYH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiJYH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:57:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB2168E78
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666684647; x=1698220647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WZQNpAlDfL3Q4vxC5j9B5Tw4eHmw4B1KOZF4DwNYuLg=;
  b=AKY3IJbU2CxJFXfh1IHaM76zHY77gXfF+TqhicOj1rSDaTei7c+m5MEC
   6r9e03x0hzMnAZMCdtlEEk7YnbiqaKd04MHtwTMsvS98E/MIbF592WCml
   EFyMhfXni4tYyvl1uQcy5ZB8o1UEJfZsAaHCG5J1B5LRUgdOPgEYorkGU
   6H7f6Be/D0EQWZqMLaJBfSZnijkPdxo8aLa/DoQQLfQjdHG2a8jGbG7jx
   KxVtr9MyABFkknhFnPXOkL6d03kbosEb/hBKfnTCcaDPEBmAdd01gP0KD
   n1PGnqj0wXQJKOSKdWQBEFIGlCYFTmZdDCU0GBGNePjKDdULl883GJ805
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334209192"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="334209192"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 00:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694859932"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="694859932"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2022 00:57:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 00:57:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 00:57:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 00:57:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+1WFFdLMXYEkSz1Npfa4vqhCX8smkfiFPEh7HUImXLNa5Rkyip095IdpKuOUiTMs8fbcCIY702D3Tpgh4EdrqP4RsjOinYIUlGLRLU3yDbHP4Z6yctEG/SzTGy8U8JqBpNrEz3DdfXrb8tIzf6Fsajhr/hcHrXmaCXd1Suu0WUg5Stjdx/a+5SNe/d20uhyvaxAX9SFlTYCQni2dfjAT2K5C8BZDHNMm7QqKsyjq1QQFSKNrX9VtedWWe/Ze79gc2eDGPlN875sCIHIUoZfWp/Tpx1g0dOwIg8rOU5fgBF6/cp+9pJ6Mah1wW5jk51pEFeg8OstzJU0Kr3gLozUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSaoQ0MtbsN9ytIJoXPljiUlxzu799m0YltynfBwmew=;
 b=G9aLOAdlBe7x1YPwkadAB8EvEK2LTzogh+Tq5PkxkYcNnF6hLVgEIvK9+o0D/op/I0nln75imnixC9JJyG/YPLZg2+sNEx95w1gQxEdcwFix0M6nznB6Wgy7s0/a3LibVYJ7nHKfxhVW62RpbKJMAEzxNcMc3TTujSAk59ekoNWA1dZVCaLqiOhUv+qxPh2i1VLaKworkWLdqV/gMbsDScviov4YUPxWQGbO4vJRJpO3FhihIFv9WAc9RNIiT2BMEdTEWcHukn0J3mI9cLfEheFfSWs4DDgJZXbRdFn5srdsP+8zOqZ9QNg3b1Apwk0KN/Y+4ImwSHrNb7UPM/6N4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 07:57:24 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 07:57:24 +0000
Date:   Tue, 25 Oct 2022 15:57:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tim.c.chen@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <liaoyu15@huawei.com>, <oliver.sang@intel.com>,
        <ying.huang@intel.com>
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Message-ID: <Y1eW2L5y7jx69v0g@feng-clx>
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
 <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
 <Y1ZArguS/rVEjXOb@feng-clx>
 <397f513f-9273-76d1-a0ba-9d1d403020c5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <397f513f-9273-76d1-a0ba-9d1d403020c5@intel.com>
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c66762-edff-41e2-7960-08dab65e8d22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soNneFp8znpdZ64c+lnTBWOzXafG3+9Cjd/wQbSY0KW1KKsymTnYyjmb0Y6j9yee9anjcaz7KgPrqEdRdgb6qchAolK1T7IEBgzSB/UaKg4zQ/1H1EjU7x1mx5pcucjhf832KtGhtqKHg/qdto9j2E0H7MZX1+E/lrd+WFCV6HkANgvi+XW4fr05zdhSG0owvwB7OWMXiiSVI4x72lM8r1r0F64+SxGfcUo12w5DZSSyjOsduF7omsjcZFXLOC655my8HkLvYhbeRp7L6eMr6kaSi81k4o+E9EUTE5azMILVMuH41DyBx3vWZeX00rA8dIibD0C0a1t2PqmqvQgQmifG7a/qtKpNdr5AO2NUvt0so1r2jTO2hfAGbbhsuVkZUigsNfMBo5QRZn07eGoCK9Lx1W7vgYdP87EOWOnJ3JUSBwtHFzMg5BQ0+txWqHxTz4YSL7fFDfSr80QziKlcVR5KLdxk4Pu6CeJ/u/4dchUcWQmGb3X/jImdPJ4iSrOWewHuZONwiHmPGo/eQ/OalZRiwMebHda63vrbaa+HBfz4yJkoBDY7VsL8oXR/SaJ3eewskcmfXYdVQJ11131Zkc1+GjOG5FYk9jsDYfoc9ZIOXwlDav7LnHmQQHutIOT8eQ9RVvGXjOZFgZLjQ/V2Ez29BMvOaIlv/CuHPQJD8YPAs1Xa91pUoA9W1L7YazF8VRV4myydI1IUvbgTEQJhAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(82960400001)(8936002)(5660300002)(66556008)(38100700002)(66476007)(66946007)(83380400001)(86362001)(110136005)(26005)(107886003)(6512007)(478600001)(186003)(9686003)(316002)(6486002)(2906002)(33716001)(44832011)(41300700001)(4326008)(8676002)(6506007)(53546011)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+e5+EkxFdrHvktFMHjw2CcLFrhT5QdpC39f9dFog04BnbCbgPsxwKucOeYsO?=
 =?us-ascii?Q?8nDSqG9Vf9nMes6uxcaMxSOCH7Y5Hnu42F8fcMbGAd3gc/miEm2XrSzYFkIZ?=
 =?us-ascii?Q?/Z/ftcebaK0AJSFPn3uoVYT+BfZ860b5ohW8gEi4wVGLMEeJCkfMQC5fLMjb?=
 =?us-ascii?Q?ms85jVYAAHM1KiSNZy5RjM0UdbXYU5ICtvxqRbENZESiYdDlnyXgPkl8qnGV?=
 =?us-ascii?Q?xQ+IDHXJU1eQt6vGq7rmZ1NS5KfaLRfHCOIGHG/EGhSQZW5zX6ay5OTbuXDa?=
 =?us-ascii?Q?k6gPvHLEATyyk90CIy76S3FR4aKRLbTCX4OFe2o/JSWOzH2IhEYjgZhCAYwu?=
 =?us-ascii?Q?2tvaAWF6BzBxD+2rFBax1lJfQgXmARI14ni6ZA0FLQM/N2tk9mnomn2C0kNS?=
 =?us-ascii?Q?ZphLr+AeTRsYpYAY2CovwX4n/haJPm9R/jLw+ssmTtTsXuWYxf2aI1mxXSGm?=
 =?us-ascii?Q?fX3EbvESM0o/g81RkqYhIKEh7lmuad0BQAqE5xr82D0K4eoh8qhU8aHj7XJX?=
 =?us-ascii?Q?MF/oZJ5ukmobm0kjFIx8oUl2hlAQNbvUnhJm2IC8DXddb3y3oXqQsk4oxc1s?=
 =?us-ascii?Q?E0DymMcCPOdv4hrFWJvNYm97K/qhzTsJ/a9SHx0miaoAbrGevoQzbiTCneo9?=
 =?us-ascii?Q?9uVnsvQn8i/AfLt9L/982Rem3zeOHI94NFx6uIG3dtCoDbGiQzGawUobdmnJ?=
 =?us-ascii?Q?pJBxeoXoLJoa1mEdhg+Mh5RD+Uh69+ezMHT6F9b2SmIvOCLUU4KZTZQ/pA+6?=
 =?us-ascii?Q?n5/Xy3RjHSOzSHlfB/+w1HB+VklEIcABqTKi6lSz7kx/ib8JSAnPzsAXsPZC?=
 =?us-ascii?Q?+/xjpB33w1e1WTz3TBR/JzijfMEYyDSdxtE4ePpkuzU7TMdF+/O7BCR8HGjm?=
 =?us-ascii?Q?mE339uSUMezWpAa8C9fqn9L4FXeSknyjgsVW2OccW2O6UcqtSM2h6Xx7IeVK?=
 =?us-ascii?Q?E3vabBSvsdR4UzAgRYP/rfba/Es+XOfqS1f0ifxkUMS1lLwBtkD+jM492AsA?=
 =?us-ascii?Q?g8ERTECKJvONaApE4Xy8jWvj4wO0Dt7rfAG4YccPyfa8NSfTPcb7gZRyU1Fa?=
 =?us-ascii?Q?Wiutere+asXyT+r3yGwPO+MdzaUxdzWPmHBJB4Fnr/O4fowsA6JdDGyzRoEZ?=
 =?us-ascii?Q?8dc7R6oUHkXMgfxbN466+c+kTt5AxEtDDjeqk84kHzkMB1j9brD6A9rWdOw0?=
 =?us-ascii?Q?00hHZZcxcUdm38ZRCyRbsEbXG28WvaThXgK23GFG9bQZX2MWz6/f/I3bBE/5?=
 =?us-ascii?Q?GpLOxbIsz9vyykFXx7ciQabcsMmbWrOcqVrJttBhQTxBcjeo7EExAhCg5uvF?=
 =?us-ascii?Q?f9O8SNSZwKIuNbbWFEd0OKoSGt+93QncghkMUZPHHZMydfpjcibhBUn92tdW?=
 =?us-ascii?Q?yTzl58KqIrU1KEOM2KxfGcRnKfNI77oQcwZ04vqjUR2F22Fz1RCdsCnvXm1V?=
 =?us-ascii?Q?6S15KMH6rZLmEuZH6EVb6XalbbzSthqrAyRaJy3lljJ1MzoZ5fPHVmqFRwPy?=
 =?us-ascii?Q?m6bHFoPNPWk/Egoj7NlpuYZD5TQ3gPtdI8dUKOZwCpv89P3oyTXXBJIlJqMO?=
 =?us-ascii?Q?uzuUQANBWjL3A59Kur08YreB3YY89xgAMPIeJUCz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c66762-edff-41e2-7960-08dab65e8d22
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:57:23.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1MD1zQcDPF6QPgdmEoUf5OHeNvzOEeuUY3lTwFwW1o6Q4WTWtdwp7xbOIfz/mIugr7IXDxtsrAlDa89E1kIHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:43:33AM -0700, Dave Hansen wrote:
> On 10/24/22 00:37, Feng Tang wrote:
> >> For instance, I can live with the implementation being a bit goofy when
> >> kernel commandlines are in play.  We can pr_info() about those cases.
> > Something like adding
> > 
> > pr_info("Watchdog for TSC is disabled for this platform while estimating
> > 	the socket number is %d, if the real socket number is bigger than
> > 	4 (may due to some tricks like 'maxcpus=' cmdline parameter, please
> > 	add 'tsc=watchdog' to cmdline as well\n", logical_packages);
> 
> That's too wishy-washy.  Also, I *KNOW* Intel has built systems with
> wonky, opaque numbers of "sockets".  Cascade Lake was a single physical
> "socket", but in all other respects (including enumeration to software)
> it acted like two logical sockets.
> 
> So, what was the "real" socket number for Cascade Lake?  If you looked
> in a chassis, you'd see one socket.  But, there were two dies in that
> socket talking to each other over UPI, so it had a system topology which
> was indistinguishable from a 2-socket system.
 
Good to know and thanks for the info.

I have to admit I haven't checked a server's internals before, and
thanks to Oliver for helping checking some Cascade Lake boxes of 0Day.

In one box where 'lscpu' shows 4 sockets (96 cores in total), it does
only have 2 physical processors in the chassis, just like you
mentioned, it has 2 dies for each processor. And in another box,
'lscpu' shows 2 sockets (44 cores in total), it also has 2 physical
processors but with much smaller size.

And fortunately the 'logical_packages' for these 2 boxes are both
the correct value: 2.

> Let's just state the facts:
> 
> 	pr_info("Disabling TSC watchdog on %d-package system.", ...)
> 
> Then, we can have a flag elsewhere to say how reliable that number is.
> A taint flag or CPU bug is probably going to far, but something like this:
> 
> bool logical_package_count_unreliable = false;
> 
> void mark_bad_package_count(char *reason)
> {
> 	if (logical_package_count_unreliable)
> 		return true;
> 
> 	pr_warn("processor package count is unreliable");
> }
> 
> Might be OK.  Then you can call mark_bad_package_count() from multiple
> sites, like the maxcpus= code.

This should work! we can just add one more check:

	boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
	!logical_package_count_unreliable &&
	logical_packages <= 2 

And when some new case leading to a imprecise 'logical_packages' is
found in future, we could just apply to this to it.

> But, like I said in the other thread, let's make sure we're agreed on
> the precise problem that we're solving before we go down this road.

Sure.

Thanks,
Feng


> > and adding a new 'tsc=watchdog' option to force watchdog on (might be
> > over-complexed?)
> 
> Agreed, I don't think that's quite warranted yet.
