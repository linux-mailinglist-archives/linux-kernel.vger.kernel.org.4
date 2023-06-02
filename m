Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DC720950
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjFBSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjFBSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:43:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926CD1B3;
        Fri,  2 Jun 2023 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685731411; x=1717267411;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=muCzTYUP1eD9D+qMVlCT/eKLnOxfZOpMagA32DN7imc=;
  b=aOTNpoRPjB0T0sVli93SQ+5yNCx0+LnFRT9uBu4Y1iff6vgCp3S9vyrE
   QdPuGXiliyo810RKkuxivV27niHQU9YzCIOjPQxyb2XHQ8CTjJzofzH/E
   XP5R1Bagm/DNgFlEKsFsVYqcRftd/1HztsRvfU8pUI2O5kSVbNkrd9r7D
   BZaA2yiAe5V5jDirvRNVBBSeTdWkVZv5mAzqOJB3Q//wgYbZ3FT91K+ei
   VgeyRtmxQpDe1i+9fBGwMmR0Vp8xW9RLRFkQG1jM/YtKYVpm4xIjMs0YE
   IA3izrLzjJfduOZukaHMbLYLVdki3xaqKzcvt/7KvC59Aswu5zoVTjuO5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442315036"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442315036"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="658363423"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="658363423"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2023 11:43:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 11:43:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 11:43:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 11:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5ckEHePigGFcQkl855+UaHXUfCUcXjS3alhT1xEJDIzbAmnRWyWAeobfY9scu+bt2xk6tMV8uhfXpfq+mutF2mnH+75DBAt6ogNn6D9FNNHxWWCbv0aTL/YqTLWeT1vl1c9NNGxlxN512TDgQBtIlHbi/rKtJUuHK6PgBjuDf0jAJOdq8ImGXvS1pxBmyYG7CsMEw18bws55gQc+z6UdmkYsa6d2occiujUqKMBV/LLd9J5aRnYK8JgRaAez4em8RwSvYD6Lfk4H1w0ULLdZVFqpNkdXLVIiQozQFqzSuHNXgesyJKHFLGMOZqHBXpWc7/CGrWhnecHccA+iZ3Ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r1pidnvbJ3yqUDBQnOeAZ7zejwy5IdAUSwbMeCaOWM=;
 b=lxTEcI3Dzs4NC3Dxk+8e+M1j1HWQ8PDb2mGQIXXZjJM0etmAI7vML5E9Vi24TBcff9c4VbC19jvUvlTvFPC9sbhKbXosuTHCbj79mBFczaMTEVDeiVN2RIhTNig0MOX3QLIexSxy0V/VWDIlbb5Ddrckpi02b3954RkY3UXLiOsUDgRVPEjx6DSEX2562B45jqmrmrmOtdXCdsnKp1kKq9NUvIlC/P92bC9In7AjCdilM+ainh3YsNT2VYoMVXbGAENnYDkzFfk6TAO02UGsMgf8xgxcQOvPfIRtcdm/yUDkizhqOyQv0jZe5JC+wAMET3DtV7rN/isrfYyMG1JzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 18:43:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9679:34f7:f1b:1e7c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9679:34f7:f1b:1e7c%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 18:43:26 +0000
Date:   Fri, 2 Jun 2023 11:43:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Paul Cassella <cassella@hpe.com>, Ira Weiny <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>
CC:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <akpm@linux-foundation.org>, <joao.m.martins@oracle.com>,
        <zhangxiaoxu5@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
Message-ID: <647a384743e5d_c35b294af@iweiny-mobl.notmuch>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com>
 <Y4u2TK4yPU9dfiDr@iweiny-mobl>
 <d0819e2a-f584-3287-61ba-88ea78a9885b@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0819e2a-f584-3287-61ba-88ea78a9885b@hpe.com>
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 08831b44-640b-424a-d866-08db6399402f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUF//93U+DCeOEnprtA8I6f3+hk2Oqot8sxIII9CHPHYMDe5DMrmf/zRSlz82hqBxRlyZiTukPd4/FZmo++kNWroMXTFED6Rjo6FIPXPhhz+wkPOD3wJ07NjzepzdQgZOK67mWcRrbzbvzr9EZLyqWSunQ2pc+ekI+acckGbeKXbUTrZ85+8K01TIz9Rj++oe+Xspu6WAJdMsG5HuY9JCGizqAHRr3mI5CLhTlIIiFggdFeGJMrCyOTJM5qP13tJnrqHbe6mFgiftKQJ48/aws2aq0fng+BXbeciz5t0VYtKbVAagTxtWRK+uh90JXG8b1+uwvoY58rYiSEFkvZCgT0D7bkM3imu9Bk+N4mgVb+InTU9oBI1goGtvigRkSxFfo4Tm+j47k533cmP1M6yIXNSR85xTzSmLeVhAIHagq8i5Ur/BR10tzAfhzcC3GGWbjhXtWIVclX8AlOtQ/NgeN3QPVGSfCSrsmzzoz+8ZwyQ8B6IHpHMrzI6agHQPzjRBpkxx8zaDjcr9T8oGwEC9VQJhk9O/9lkpmupgSurlhaUHt+z2273X7ee9UdS5MnT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(82960400001)(38100700002)(86362001)(8676002)(5660300002)(9686003)(6506007)(6512007)(53546011)(44832011)(26005)(41300700001)(296002)(66556008)(2906002)(186003)(83380400001)(316002)(66946007)(6666004)(6486002)(8936002)(66476007)(110136005)(478600001)(4326008)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6biWOBYAUdPDzODSlNQeCBYqHpluHy9S+dmQ4bh2aoyDYXKG8Kebob3lzBG?=
 =?us-ascii?Q?Bhl7na5AjmrXZO6d2mpjOXY9JAlIqO/ACVZ/FOHriSw7THELyQrcmwnGh2v/?=
 =?us-ascii?Q?GzpBknDQQRoVvJBIkuUSGtStQM5pcwyXCdu/mq5rUfn/XbUNN9YS82iPkrjH?=
 =?us-ascii?Q?wvBHUhhn3MQVFZiz2GX9npp3zStuSL2yX9zt7/iiOp0tUt2HrfFg8vlU5fBL?=
 =?us-ascii?Q?ITJCJIuuKaD3xq9HJltztpqBa5OvOacVWXntStSnHPqgiwYZ1eBtLqo/FHhO?=
 =?us-ascii?Q?mSCsiUzEW3MJG/184XZRoYhOGvycUibkTYE/5ctJNEUdgS7Fbml0QRVlxGql?=
 =?us-ascii?Q?MkQFOAtDUkQNV8y++kFMDu9qg80MifQ4mT1Ewr4Kv+HY5M71GEZGCQyZqaOf?=
 =?us-ascii?Q?e6bvPSMHDgGdLHaR64ZFxi3LVC+SndVQ9Y1wCGzHmBDhXup4Gu7p/chULHNw?=
 =?us-ascii?Q?KLl+Hm5McvoV96uFxtG9r72ahqgeByK7VLWERyGcb28r3POtYVwE1y3XP4KF?=
 =?us-ascii?Q?9kJSgmN4jrcrseDywmV7xdt1rT9nkeq5+78ROKfZhsV5dtWoYDMQG11U5izX?=
 =?us-ascii?Q?uhtPbpx4MzJhHTuu1y9tana1CvFS+haIbuZ8n8VT46H+IP4sqRNGqB+0f4QH?=
 =?us-ascii?Q?PFAYYk6vdDaYaMF1pSwNks/7vHVm4hWkkPFnfD+FnlJ4etmqXp19k04/C3ZO?=
 =?us-ascii?Q?rj8b/YIQu/kvrOpIW0O+lB049O8efEwcAX1s76A79tu87nXhpwNHW+/EitFq?=
 =?us-ascii?Q?zATzqB89G7P8Z3L61Wa+L7UYCmDnbxxGxz3XfvubESa3bbeJyR0tWYbOrwb9?=
 =?us-ascii?Q?c6aV9Wx+ewFUCAM0jvYl7Mtq+B9HrXx/spfS6N+ZnfS4ARITSxtA24WjQey8?=
 =?us-ascii?Q?RG3XFQz9fegjpSuK5TUapRX/BotPGgtaSy2Ih+NwOPgUYtQEg9KuvK2LXNTF?=
 =?us-ascii?Q?b2G4EzUQZ0xGI49zBxrgSUOJPRTh3SaHI+EG6R2bg6mfh8pBICQRcyv5U6Fm?=
 =?us-ascii?Q?i8O6XRxdiDCo9bhe4FHUo/0YbGyk1L4jBcEi7mn8D8SKArFA3dgq0hmZ2GTE?=
 =?us-ascii?Q?vo8+XMtPpdhlngUFilJQ54hF48SJkhezOhcNRP8jn5vyn/Y3kPjAPZ03wlDV?=
 =?us-ascii?Q?/Mf+M+N221UHVIPKSe7TlH99SEuDiw4LKICzl9PUJ3kTA7KnnamH1MflS1fr?=
 =?us-ascii?Q?tKtmwJlFCa30qeq+sgGS/O2MDC094VUojvkgvD6ATPX0k25Zl5iRLHPzzn9K?=
 =?us-ascii?Q?oFVFjT3HofGOgCmYxchEeNbkeUexLawhJpWrSSImS0l0NPOOLkGQEFJNslXq?=
 =?us-ascii?Q?P8Otza46M3GeFQIyMHk2iWKnyus3KGLI8DdJZ+2jNc86raXJwasXDZpIMA/V?=
 =?us-ascii?Q?4ScoTQn7cqZuvMCMFCT+gFqQhBSIlRatSuakD7NLkSV8/vjhmuJaLb7ht0N4?=
 =?us-ascii?Q?NIPx2JKI4sYczV8Tl1YXlv0+ROQ5Wbw5tyzgCzUya2+GjK4imY1xNXk+eLp9?=
 =?us-ascii?Q?u0FPeUEnXMoLN7mDwl2siacpQgArtkhNkwnLp9wC+01LMX+q3mfvHQ1W8lBt?=
 =?us-ascii?Q?3o6NLFCD/oWbUAKKE0MJ+iqw7HH6VewykIOUSlO3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08831b44-640b-424a-d866-08db6399402f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:43:26.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNcNoMOD3Wb0EhGUzq+M3vUOP3vJv7i5fQTh9BAl+bmOUF2eyR+OOHYz2DDxncGJkEjrwxLRz893AwolcY3Cww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cassella wrote:
> On Sat, 3 Dec 2022, Ira Weiny wrote:
> > On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:
> 
> > > We should always call dax_region_put() whenever devm_create_dev_dax()
> > > succeed or fail to avoid refcount leak of dax_region. Move the return
> > > value check after dax_region_put().
> 
> > I think dax_region_put is called from dax_region_unregister() automatically on
> > tear down.
> 
> Hi Ira,
> 
> Note the reference dax_region_unregister() will be putting is the one 
> devm_create_dev_dax() takes by kref_get(&dax_region->kref).   I think 
> dax_hmem_probe() needs to put its reference in the error case, as in the 
> successful case.

Looking at this again I'm inclined to agree that something is wrong.  But
I'm not sure this patch fixes it. anything.

When you say:

> ...   I think 
> dax_hmem_probe() needs to put its reference in the error case, as in the 
> successful case.

... which kref_get() is dax_hmem_probe() letting go?

Here is what I see with the current code.

dax_hmem_probe()
	alloc_dax_region()
		kref_get(&dax_region->kref)
		devm_add_action_or_reset(... dax_region_unregister, ...)
				... kref_put() later...

	devm_create_dev_dax()
		...may return error...
		kref_get()
		[dev_dax_release() set to call kref_put() later]
		...may return error...

	if not error
		dax_region_put() => kref_put()

I think this is an extra unneeded put???

Dan I see this pattern repeated in cxl and pmem.  Is the intent to remove
the need for dax_region_unregister() to be called when the platform device
unwinds because the platform device is not intended to own the dax_region
after success?  If so it seems like the device managed call should be
removed too.  Not just calling dax_region_put()?  :-/

But wouldn't that cause an issue with the sysfs entries created?

> 
> Consider, devm_create_dev_dax() has error paths that return without 
> involving dax_region_unregister(), prior to kref_get() and device_add().  
> dax_hmem_probe() is clearly responsible for freeing the region in those 
> cases.

No the devm_add_action_or_reset(... dax_region_unregister, ...) will cause
dax_region_unregister() to release the reference when the platform device
unwinds.

devm_create_dev_dax() configures a reference release through the
dev_dax->type release.  So when the dev_dax device is put the dax_region
will be released through dev_dax_release()->dax_region_put().

> 
> 
> dax_hmem_probe() drops its own reference in the successful case because 
> (per the comment) "child dev_dax instances now own the lifetime of the 
> dax_region".  That ownership is the reference that the error-case 
> dax_region_unregister() is dropping.

No dax_region_unregister() is not just an error case flow.

>
> dax_hmem_probe()'s initial reference 
> also needs to be dropped in the error case, as in the successful case.
> 

I don't follow this.  Doesn't this now result in an invalid reference
release in dax_region_unregister() when the platform device is unwound?
Furthermore, that reference is required I think for the sysfs entries.

> 
> > > Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")
> > 
> > I'm also not sure how this patch is related to this fix.
> > 
> > Ira
> > 
> > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > ---
> > >  drivers/dax/hmem/hmem.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> > > index 1bf040dbc834..09f5cd7b6c8e 100644
> > > --- a/drivers/dax/hmem/hmem.c
> > > +++ b/drivers/dax/hmem/hmem.c
> > > @@ -36,12 +36,11 @@ static int dax_hmem_probe(struct platform_device *pdev)
> > >  		.size = region_idle ? 0 : resource_size(res),
> > >  	};
> > >  	dev_dax = devm_create_dev_dax(&data);
> > > -	if (IS_ERR(dev_dax))
> > > -		return PTR_ERR(dev_dax);
> > >  
> > >  	/* child dev_dax instances now own the lifetime of the dax_region */
> 
> This comment should probably be updated now.  :)
> 

I think removed...

Dan what do you think of this patch?  Am I seriously off the rails here?
I worry about this code being around for so long.  But since it is in tear
down perhaps it is just a race which has never been lost.

Ira

---- 8< ---------------------

From f63969c761b04fb5e646e7ba7df77a48bc26ba1c Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 2 Jun 2023 11:17:10 -0700
Subject: [PATCH] dax: Avoid extra kref_put() of dax_regions

In alloc_dax_region() sysfs attribute groups are created against the
parent object the dax_region is being created under.  A reference to the
dax_region was thus obtained for the lifetime of the parent device via
kobj_get() and released via dax_region_unregister().

The ownership of the dax_region was intended to be transferred to the
device dax device but this transfer is not necessary and could be
problematic if the sysfs entries are used after the dax device is
unwound but before the parent device is.

For the dax device the dax_region reference taken during creation in
devm_create_dev_dax() is sufficient to ensure the dax_region lifetime
for both the parent device and the dax device.

Remove the extraneous dax_region_put() from all call paths with this
pattern.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/cxl.c       | 3 ---
 drivers/dax/hmem/hmem.c | 3 ---
 drivers/dax/pmem.c      | 7 +------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index ccdf8de85bd5..d3c3654842ba 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -31,9 +31,6 @@ static int cxl_dax_region_probe(struct device *dev)
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
 		return PTR_ERR(dev_dax);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
 	return 0;
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index e5fe8b39fb94..d22d56964120 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -41,9 +41,6 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
 		return PTR_ERR(dev_dax);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
 	return 0;
 }
 
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f050ea78bb83..efbdaac51e5f 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -65,12 +65,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.pgmap = &pgmap,
 		.size = range_len(&range),
 	};
-	dev_dax = devm_create_dev_dax(&data);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
-
-	return dev_dax;
+	return devm_create_dev_dax(&data);
 }
 
 static int dax_pmem_probe(struct device *dev)
-- 
2.40.0

