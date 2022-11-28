Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E570B63A0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiK1Fqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1Fqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:46:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052AF12A80
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 21:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669614407; x=1701150407;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IR2J8ON8tW8//LsCm7GA6bLSU9+3ZdcQx/mxUa+tC8c=;
  b=FXoYQBO8e6cMmWyL/D2k51fvrHsPvMmp8YcxccsUaaWQO2iHcdA+Qquu
   qaf1GsdO8Qf+kvgdpXHSP8H5mLB7CT/LvFzXdJ2xGrOTRm1gdKG9yQZql
   7sK2W0573rZclywdUWC0Yaw1iD9N1u5oHpFQp3OefugwJG+OD6Qr4WGAW
   kKuNVfDVsgHv2kaQcnUMx/5IDEbl7uWFH21dMQCmmmO7wjMKKks7Dne3O
   LdO8GzV5cPJbUESNcjjzEKhn9niipyW3zauYMfGv75UHYMGAqkU4sfQ5V
   4ewXvTUb0SXhGbs8NwlQ3K0IEQhWBN/FYSOQZOh6GL/B8koCTCZk6YVZs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="316577989"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="316577989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 21:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="593749859"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="593749859"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2022 21:46:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 21:46:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 21:46:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 21:46:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffGlpz+IqUVg7+UfNlOnHaL4G5BIizUtj4pv0W4G7HFyWi+BWJ3c8+PaJKxGdrb3RhO3zSsCT+EWSDMLrI98yoDTA4JbLTMO54gdPERekRri/UdVE193yo/rEHVNESPFZ+G02sApZdrGFeCKgTx37PHL6dzhvzYzvxEETlQC1C7e7a2800wkTssmj4iouLaREfiGQeUCUfic1Ow4kGJrJcqIM7DVAr2CKPLQV0D/opRUg0DOHHEbobAMXKphDq1rbStaO/I/VNdhyvBbcHu86alpfxDf6eScto1UtsxkdkmMBs0Oyfb3JYLtlrzYiuUBlECEozfM2OPdRPenqed7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHdtn/hdRQLlXtJqUiiYGRECHeIwIRYb6/tJSjUUdHg=;
 b=CCAOtmtr2eLlvxwxYAWhSX4tmTFu/GkEziSL/oDXyG8yFVJwL/9KO3LDzRUNiIEg+/swsnA+Hb/ROTw3/letvZixCECGMvPO+H54gjNPaOiJ55QCYS1spuA+Vf3WwDKwdTKhHv8twcJHdS7BIsScdRczw/9rfEjke6XzTD8KF/nGnhNjlX9kedcW/qtq9NqdSQMGddY6f+Xq9+VwdkCrkgKL6qNC1sk1vjI0sZqRu9xJqVRY+8unQayTCibqX6cJ18CnSR82VdCPqPsFDrnv2cOulho1lXa2USWleqRP7P+GE9g6R43qAX4AIB4aAdewv8/h7tYRSpfvbbzWjz1oHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 05:46:42 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 05:46:41 +0000
Date:   Mon, 28 Nov 2022 13:43:34 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v7 0/3] mm/slub: extend redzone check for kmalloc objects
Message-ID: <Y4RKhrwm/tsigYHW@feng-clx>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <f9da0749-c109-1251-8489-de3cfb50ab24@suse.cz>
 <Y24H998aujvYXjkV@feng-clx>
 <Y3sc1G6WEKte4Awd@feng-clx>
 <88abafb9-a961-a217-a95c-744258498722@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88abafb9-a961-a217-a95c-744258498722@suse.cz>
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 815bf22b-c185-4938-530d-08dad103eca3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GB1WUR8DaSjZTXwqrRJsSwVRsThzESTS3swr1gEf6d0sCnzdFeI/eNA5Xu0k3VdtuN0EvRoQwaLCBYhFCZ2IB6ycx4fu3JzJspkXXgiN5t6wy5JR/PVbz3d9rTY/aV6xi1hyljQiV2VehNVIQ1L0Rdvk+EBxTm9KKCZL58U8/pGP+BIn/GKdYJgm1E2jOM6kue9pbtC8fkqzP9FI37dvBGRlnixL8VmSw8k7LXTF5Ft3udq9My5MlGI10RNcGtUjwK1nmr6u65qrwCrg1JyM7xFAt28ojDAqTu1YWFI+hDtrwu3DK0mwWcdHVfzGFtKHHbkhOHyOvwVp/K/+qF6E6GfQ/Pzek0ZDChNrelHlfoBb0FNJQ74Ttw9Gbj7u6zxAYxhAPaMrB55jL+RkU8tzzr/R8UBSDUhu2Ogcyuuij5wgyuKwaThVCMZsv5i20ROoj/Sq6Dd76BhqXJe3Dve/v7eBM/5gDbDxWJIMl+flV3Qj8RvH3I2MAppF1OTGaqEnmhQ/VoaztBPCB6GzKKPNsHJo46AY1pWzFz/R26PvtQ9yUNsB3ZWenQSckZHF9R955yfqkmtAiW15vKBO0mFoJxBs29D+pIyiATvXFs28xUy+JqPXoN3h39I6N2SzKfl8g/SDFqn8NNv9EMg4bUf5gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(86362001)(2906002)(33716001)(44832011)(5660300002)(4326008)(41300700001)(8936002)(7416002)(38100700002)(83380400001)(82960400001)(6486002)(6916009)(54906003)(478600001)(6506007)(186003)(6512007)(316002)(26005)(6666004)(66556008)(66476007)(8676002)(9686003)(66946007)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8z+Eaq7UW6ZKImpAh9HqRDUdB80NL7htjN606blm2KfwcngSzH88XWzDvzWS?=
 =?us-ascii?Q?tA6PEuVdsXpi6nEIbK3sWjwIZKFRfWdWZcZZwBgnM0KzOrDTJ1ffY3bwgRWB?=
 =?us-ascii?Q?uDaBj42XCb9rCRwXL5RdbT+UytUlXQxIfRcUg5lA0PQy625IuWRULGrgykNg?=
 =?us-ascii?Q?g+oXtJECE1OCKm4FMKbFKK24H9Gmtd/15IXWcvXrRjildGmH1azZjq4HD+fc?=
 =?us-ascii?Q?/Ft/r/xTW8h1jxVLmtxrtbVnSLlXuG7QY3JbUQ+nUNDZ1yT/UKimqCs5SDCF?=
 =?us-ascii?Q?Ov8XEpa6kcCg+EgwgFCyLGCWmIx00iUhri8q4h8llvA7sur6FS4+UO1rO1oO?=
 =?us-ascii?Q?eDrPDwABKAAFVNc2XmeTb5bDi9A8Nv8XoO8Pbpp1UD/7PnpOoONBRYNRSOuA?=
 =?us-ascii?Q?yryE0wdAuMgp7W59UbYXJZv5+Omduh3K8ETR7pjiUa48xcEtU8eHfIDiSrT5?=
 =?us-ascii?Q?erYwHOuBXEVB2Rf/JnjzS3ggi972yi458lZhvN5G5MweR1QGxykTJ9Wc9u+Q?=
 =?us-ascii?Q?SzgnTKTsr17i+68Jn/TIFknLyOnxdY69jwNAdxDadfUptL51Pu9dAWyWqh3I?=
 =?us-ascii?Q?iH4Sx/P/mzP0Krmsm3mOjrRA+1fS5IPzcy2f8x7YOj7yI0iv9BZ7vxi2KMW3?=
 =?us-ascii?Q?VifZ9mQMSWFWYCav8UPVHrhnaHGWsrb9IFyBzbbNm+RFa2ruxrMJD3bOuUYC?=
 =?us-ascii?Q?t3nGXWLRNYI0NgwtTnLW1CfavO53IsbuKWTEFYjp0erYOeGwlKBL6zA2ZNxd?=
 =?us-ascii?Q?k93klh35rR8CNVax94f8XFB95NmcAD6+87domlHcwm4to/3qWQ/dQ+g8jFET?=
 =?us-ascii?Q?h0k9OHZ5WWyfAZf99SLINlsYHkXha40FK8gqBqUP93qr+Z1AUamgKKjLImBU?=
 =?us-ascii?Q?8Zs8G8hsmgU5boDgM5RGbWrwNa6ve3fCpQFxQhaPHXekygVym8+tdby/duJr?=
 =?us-ascii?Q?+ECMZh7IHfGXN7bk/gS0OyQs5UsTxguvoDeOFDZ1+wj2Bk2i2mgwIcvr8Q88?=
 =?us-ascii?Q?9zcdx8wQCqBV9dmRbm6Pw/PBaVpuNrkjhBP8SayJBVMwjFKB9TQCDWrbUx65?=
 =?us-ascii?Q?TDOk+NfhpYcfJjE0swHrhm4ihYyHch+/Pj3iFvE6+9lNowoTEFpUwvN4HVda?=
 =?us-ascii?Q?H81SYnd16xN4vV5Bls2Iyd5HPO1ME5Nw2HmxVWl+8LWSp1NozG46nt6QF1b4?=
 =?us-ascii?Q?reqNZq1VFdetWgf/kZlFA8WB0VjJGbxzkRHmnsWbA0KmD9LgioUANag8dL0V?=
 =?us-ascii?Q?C9ll/snbJE2HvmgGLfhKudY6o4jZM0ZQ0QVT5s2UDRCWA5Ap3+EKdc58oe+G?=
 =?us-ascii?Q?WTgmIhFpvxEaXYK0tDvwJFzTlHm2FvTwa08+hwt/Mapr2wJFFNrrYq74pvda?=
 =?us-ascii?Q?05nm2GKN+fWpqV0UC64IwlkIl7D0macPkfehQKvTllVaF6rUGo5NZUwQ7bR7?=
 =?us-ascii?Q?MWow1ceI8KKk4cAoKaPLCCBZ7s1O4XZ0FxEpkmVW+r3C5jOUtc18/a+luOLs?=
 =?us-ascii?Q?v/qxd7weqJTsCTvMI/iYpVfgixWzf5IwD9Jq0E7w+JzVJquG+f316MeAWq+8?=
 =?us-ascii?Q?c7dU+a2fWcUwLC23/3N/qyASTmkZs4GD7SHHJ/cE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 815bf22b-c185-4938-530d-08dad103eca3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 05:46:41.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIJccey9/oTBMPzPWbtm2V484XOk0wP55xZEEj9YH8YfaC2Xw13KU2p1E381tjmSWAX65T8wr/uvroXGLlVG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:48:50AM +0100, Vlastimil Babka wrote:
> On 11/21/22 07:38, Feng Tang wrote:
> > On Fri, Nov 11, 2022 at 04:29:43PM +0800, Tang, Feng wrote:
> >> On Fri, Nov 11, 2022 at 04:16:32PM +0800, Vlastimil Babka wrote:
> >> > > 	for (shift = 3; shift <= 12; shift++) {
> >> > > 		size = 1 << shift;
> >> > > 		buf = kmalloc(size + 4, GFP_KERNEL);
> >> > > 		/* We have 96, 196 kmalloc size, which is not power of 2 */
> >> > > 		if (size == 64 || size == 128)
> >> > > 			oob_size = 16;
> >> > > 		else
> >> > > 			oob_size = size - 4;
> >> > > 		memset(buf + size + 4, 0xee, oob_size);
> >> > > 		kfree(buf);
> >> > > 	}
> >> > 
> >> > Sounds like a new slub_kunit test would be useful? :) doesn't need to be
> >> > that exhaustive wrt all sizes, we could just pick one and check that a write
> >> > beyond requested kmalloc size is detected?
> >> 
> >> Just git-grepped out slub_kunit.c :), will try to add a case to it.
> >> I'll also check if the case will also be caught by other sanitizer
> >> tools like kasan/kfence etc.
> > 
> > Just checked, kasan has already has API to disable kasan check
> > temporarily, and I did see sometime kfence can chime in (4 out of 178
> > runs) so we need skip kfenced address.
> > 
> > Here is the draft patch, thanks!
> > 
> > From 45bf8d0072e532f43063dbda44c6bb3adcc388b6 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Mon, 21 Nov 2022 13:17:11 +0800
> > Subject: [PATCH] mm/slub, kunit: Add a case for kmalloc redzone functionality
> > 
> > kmalloc redzone check for slub has been merged, and it's better to add
> > a kunit case for it, which is inspired by a real-world case as described
> > in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):
> > 
> > "
> >   octeon-hcd will crash the kernel when SLOB is used. This usually happens
> >   after the 18-byte control transfer when a device descriptor is read.
> >   The DMA engine is always transfering full 32-bit words and if the
> >   transfer is shorter, some random garbage appears after the buffer.
> >   The problem is not visible with SLUB since it rounds up the allocations
> >   to word boundary, and the extra bytes will go undetected.
> > "
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  lib/slub_kunit.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  mm/slab.h        | 15 +++++++++++++++
> >  mm/slub.c        |  4 ++--
> >  3 files changed, 59 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> > index 7a0564d7cb7a..0653eed19bff 100644
> > --- a/lib/slub_kunit.c
> > +++ b/lib/slub_kunit.c
> > @@ -120,6 +120,47 @@ static void test_clobber_redzone_free(struct kunit *test)
> >  	kmem_cache_destroy(s);
> >  }
> >  
> > +
> > +/*
> > + * This case is simulating a real world case, that a device driver
> > + * requests 18 bytes buffer, but the device HW has obligation to
> > + * operate on 32 bits granularity, so it may actually read or write
> > + * 20 bytes to the buffer, and possibly pollute 2 extra bytes after
> > + * the requested space.
> > + */
> > +static void test_kmalloc_redzone_access(struct kunit *test)
> > +{
> > +	u8 *p;
> > +
> > +	if (!is_slub_debug_flags_enabled(SLAB_STORE_USER | SLAB_RED_ZONE))
> > +		kunit_skip(test, "Test required SLAB_STORE_USER & SLAB_RED_ZONE flags on");
> 
> Hrmm, this is not great. I didn't realize that we're testing kmalloc()
> specific code, so we can't simply create test-specific caches as in the
> other kunit tests.
> What if we did create a fake kmalloc cache with the necessary flags and used
> it with kmalloc_trace() instead of kmalloc()? We would be bypassing the
> kmalloc() inline layer so theoretically orig_size handling bugs could be
> introduced there that the test wouldn't catch, but I think that's rather
> unlikely. Importantly we would still be stressing the orig_size saving and
> the adjusted redzone check using this info.

Nice trick! Will go this way. 

> > +	p = kmalloc(18, GFP_KERNEL);
> > +
> > +#ifdef CONFIG_KFENCE
> > +	{
> > +		int max_retry = 10;
> > +
> > +		while (is_kfence_address(p) && max_retry--) {
> > +			kfree(p);
> > +			p = kmalloc(18, GFP_KERNEL);
> > +		}
> > +
> > +		if (!max_retry)
> > +			kunit_skip(test, "Fail to get non-kfenced memory");
> > +	}
> > +#endif
> 
> With the test-specific cache we could also pass SLAB_SKIP_KFENCE there to
> handle this. 

Yep, the handling will be much simpler, thanks

>
> BTW, don't all slub kunit test need to do that in fact?

Yes, I think they also need.

With default kfence setting test, kence address wasn't hit in
250 times of boot test. And by changing CONFIG_KFENCE_NUM_OBJECTS
from 255 to 16383, and CONFIG_KFENCE_SAMPLE_INTERVAL from 100
to 5, the kfence allocation did hit once in about 300 tims of
boot test.

Will add the flag bit for all kmem_cache creation. 

Thanks,
Feng

> Thanks,
> Vlastimil
