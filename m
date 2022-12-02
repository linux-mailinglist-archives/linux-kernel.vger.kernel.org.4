Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D5B640AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiLBQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiLBQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:34:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F3D92FF1;
        Fri,  2 Dec 2022 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669998870; x=1701534870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i9nJZqh4i7qkk3q4WiFzKaVQ8TA+BKmYWEDbS0zPwlc=;
  b=N4e5YxdQUXUUIy7nK0Y9vVieSRb/D0Wc2pJAapfZ+f+shkZTv9J5tDOD
   yeiOmr5DZb6/ny0kZQTWyPWCb+wxh5BtrdVRe/3GF5Hg6l+Kahtwz8/EN
   FKHq/qwOvw5NVBH29UqpwnnOsjRustSVbFe7Eux7MN2OwlirtA/V6PkhC
   sMucgY5AEapMnXQpAFuTnOBAU6oTMbEI9rRfH2V9Hf/UCyDAHdJHtOUQB
   0R9H9Jow85zbd/qn8LEExqcSLPXzz0W4psGvcOzvjrnd8TSFn6uPzWDqi
   ZllDTeY7//dyxahkP3aU8w0uL6WUCBWrl8GstGhQ3V/HPHrtf708o8REh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314691593"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="314691593"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 08:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733862191"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="733862191"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2022 08:34:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 08:34:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 08:34:09 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 08:34:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpsR3q/gTBK6fcoD/pdHKwa3f6OY1Oh89bKWBgED4jS8lt0JlFI72vhJOhPx+MZvwJc9BIgG1zLXmPhHdqNx99vDtfHIaUUh4vGt+5MjztOfeTxw+cx23H4JsIX/zsAUunxkLY+GF9KRw9GfunTua3vE1wA4Ds3lUCewaLhpvOBzdnjxgc+2z5mG4OfmoDUmTkJM7txoLN8wyl4YjK320J2wQb96l9tB7JPh1hfhRcaeQuCelWvbTIYqGUWpsyWtB4TP3e+3s0giK+ltxYEfrhtEa9RHVjew6Aujc4/EcETBV/qIPqu+sstqD5u32lhbEZsBu/qBJ38f8VD7QzxFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smtfa2aakv/G3Yh+dSxiaQ7FMZM3XLJJrdUd83kwI+g=;
 b=gHenE1cDGUNTQ7PzM8Djq2a0y6nEDrk/na2fnqZS/VvfaE1j1bxQzjSIo7po1ARwpWJtJpe51/6I8WVAX7f0dtiHgP/xszpe3BwRzMUHdTKlB6+9G3MXhFcp/PcfTiAZSB4mLP8jhYTwkyWQ6F27ILtrmsYKeczhlEXa2L4BmSjF+6MEbCUihTXeYHYYgPIsbBp7uSUK4CeXEOci9mbcSOhEoESQaT8zH33FSw5K9pYyj3hRfOb5WaTGevgwUiBxlO6MEzcnESRA9P3XGAm+OssCIqvGW1SXuQIMkRqSmSBuUB3VRfVSpk/CcQWGSedZJ3HElGCFOh95uaQQs90zWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 16:34:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 16:34:07 +0000
Date:   Fri, 2 Dec 2022 08:34:02 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Message-ID: <Y4oo+rxYAyBoHexo@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-5-ira.weiny@intel.com>
 <6389676c60d39_3cbe029487@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6389676c60d39_3cbe029487@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: fd00dcb8-3ce8-4c9b-c5b2-08dad483083f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/eMKdbqQqqfqcyGzAQER0LzXR1/yZNVpB48Fki9A14TZdnAKgYCTm97PV42hi+9YM0gv0FG7DwamiGB3r0yQ7jsJ+vKVqCCpza0dnTxUBF8G4ETNURGJT8bRcpZQKEN4aSBUHik7cBufSHXVq5uR6wqdKE+SoFL+GMfVUfAdrEdzDklu10Y9SUbq2W+uM34fiYUKBuDsV0B/Y7IGwGrYz5vIgNfqfQamGzjWC+rDrHeaGJ0/3Mg9LdZl1D5YQu9HmU9WiiL9Qh4+FWquu74ML69ooSKzhzYrNHngSoDC/LiITG+gZPBKwbrm1njDIQu3lTzKUNNFuDU8AOOiafjkUDw0KxaFS772kfo/Tpc605CJ0WLqrof0jROx3SinG1FsjZg0gyVom5cOQJ2gWZgUrH1WHnzM8wFZz8cDugdRtxVxoXF/jkIyWVd0oPTyHzsNNF6jLOBRcou4c4S8DQTYP8+x8ythrq8uF+fvnAxEfaSYxEJh/mY8H4nlQr4Ts9oxmgCJqVM+jLF/SMwSfWbXKUiyBhEbWmPbEkZPmaZfWK9ahEb6/zPmgBGH/w1pPxZF14DjZH0uD0J6V4uqX5y+Q46e8Rm8P7XhJfw3nRrUnNuW2xnDav4dcKBcyyNUptH5e+4z4ezRneBIVDItah7xrY8VDdrZOZScn7plDlVQMcNZgOuabMvSKUuAqhu67T5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(82960400001)(6512007)(38100700002)(86362001)(33716001)(316002)(6636002)(54906003)(9686003)(66476007)(8676002)(66556008)(6486002)(6666004)(66946007)(478600001)(186003)(26005)(6506007)(2906002)(83380400001)(41300700001)(4326008)(44832011)(5660300002)(8936002)(6862004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3uhVxzNloiSZ/tzbxJzajuQA7pHlCTJAUPX1yY/xe+VeMhyO23Pf+Gbu1aUZ?=
 =?us-ascii?Q?DjmzFKSeQj0nK8jGKRJJVM4WcvP3j3QaRtXmLZ277XcNhNc7lUUHQxU7H430?=
 =?us-ascii?Q?yu5hx71/IxwMqOoTwP59ZoHtcCqqux2vjbwxQ0aSIEUG9vFdGMp1rNBk7gj2?=
 =?us-ascii?Q?cW7G2Pit1s8nLUs0pm1eug0VkV9lmkccN0aBwBu5UrWeNTnpgUBSZWD3YjxZ?=
 =?us-ascii?Q?QZ/nkTDf2Jt/skGElVaq3OZYag3m5VPVg2juiSPojF//bGWfaC8dnHUzQWxx?=
 =?us-ascii?Q?tnrwVQ8JatF9XGURztXELvVkV/HmJ8+To5N/Ux5r1fBjOS0q++CWlSyCfB5U?=
 =?us-ascii?Q?+k0w7LAVqvLSdLSH86zipbhfmfdo4GqIFbQW6YmQFzis0IeZ5p20inkLlvTI?=
 =?us-ascii?Q?/IotJm8IdYCUWJiqaPWHvRvXmU0dUUpAB+ZYXifylI1+8oSgVY802cOl2/bh?=
 =?us-ascii?Q?8SCgrlrxVem3CUx3XLV34vGpbafiUELnpC8Xjrul79kgqHz3/oYvB9rHCOV6?=
 =?us-ascii?Q?sofYxig3XTkbzDkxphVjuXAhaZ8o939fgLWiApLYSMjKo2H8YsDFPAQBpwx1?=
 =?us-ascii?Q?NNVaQYPrKaL3CNLDKSXd0m4IQskispmfJPCHnRy8nqOooy4IFjULpNjJ+P0U?=
 =?us-ascii?Q?2wCAiP8tIc3TIXroBSdf69KvyFETHYsdsEKmNB3BAlMkh0rfGHdc5oGG8bqW?=
 =?us-ascii?Q?owGQeOWxpgUZQ799ZgN9Uc0uZ5KoaIPItzUPuaedP/Udcs0Vp0TqVBCMLQn3?=
 =?us-ascii?Q?R3dEKlQDJmV7Ekuizz9c2i/ihQAvYPKfkkb0diBQ9le5k6w65xn+8i9XjAkj?=
 =?us-ascii?Q?O3ydM+wOH+cKbFWhIO+ae8HgNPLY56jxjbmqeeb7Qj7eej5y/AscQrfTxLS3?=
 =?us-ascii?Q?IK1kN3bUjrKV4KgwlLbOTEZLuPmqZnZYkogKSjheq7+Q7iG1dpE7SOp87vDj?=
 =?us-ascii?Q?4MJwsrAeDArvLF7BdkAfqgO1xdDWBaU48sjCxymlqZoDNRKzB08/tZPfYjEZ?=
 =?us-ascii?Q?rpk2xy6u/vm2wrI4KjYxr+tlRz+p8PNW2HxHdcPwrd3Sq61iBbYwAwJ3DA8m?=
 =?us-ascii?Q?YdzN8mCfSkjMZPZ13JlEfupa13rmrClUBgwLX4D4dDkZH4l6Enxn8+nDXLK1?=
 =?us-ascii?Q?urBxCgbrpbk3X/oAGXmWpWkXsJfGqN9kD9v8aRzoQCjPsyvn4cKQTPstKNd2?=
 =?us-ascii?Q?N1UA/XS4Q+OPHbyOX9Iee4CnyiZ7cEgzxisoAUVtAw9ZzuhBYIKJavWIHiyt?=
 =?us-ascii?Q?BqMUadkUbszW7S4O9N1vYNXIVmaWEZjOLoEFmBC8Jj4dYKM4UDfOzK/0Y4L2?=
 =?us-ascii?Q?m6zu9W5aD7F3h+gP/NgKQsBBYdV1sjKSEH0hoNPCWmOpmVarXdjvPIoIMahc?=
 =?us-ascii?Q?YgBuIWLbmOupFkzOjw0QDlUz93J5oMUCLZfGy/9QnSIZxEzFNOe1ijIq1AJP?=
 =?us-ascii?Q?bkUPToWUrAcrtHNrOhD8rnbxlR7+1OoKxekJcjVIxALPwKCcWC8+VfQ5VlVQ?=
 =?us-ascii?Q?18sTzWTpkXm6VXi31iZcazH/dff4+uulUug3TcXTmo60mxJVheUYZFYD9y9s?=
 =?us-ascii?Q?0irv5tYTCxIxJ9O8yKSj3xHLP8ThfDwoPVE47Ide?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd00dcb8-3ce8-4c9b-c5b2-08dad483083f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 16:34:07.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NagE9lddz4kwaeO8XU6qW0zOc3BWUQU9qXEIQtbfVmmMZDnlYw6HLjvsW/oA1kLYyj066/GjNvYg9ExzeuD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 06:48:12PM -0800, Dan Williams wrote:
> cxl/mem is cxl_mem.ko, This is cxl/pci.
> 
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The information contained in the events prior to the driver loading can
> > be queried at any time through other mailbox commands.
> > 
> > Ensure a clean slate of events by reading and clearing the events.  The
> > events are sent to the trace buffer but it is not anticipated to have
> > anyone listening to it at driver load time.
> 
> This is easy to guarantee with modprobe policy, so I am not sure it is
> worth stating.

Fair enough.  But there was some discussion early on regarding why reading and
clearing on startup was a good thing.  This showed that we chose to do that and
why we don't care.  I'll remove it.

> 
> This breakdown feels odd. I would split the trace event definitions into
> its own lead in patch since that is a pile of definitions that can be
> merged on their own. Then squash get, clear, and this patch into one
> patch as they don't have much reason to go in separately.

I agree that splitting the Get/Clear/and this patch was odd.  However,
splitting Get/Clear made the discussion on those operations easier IMO.

As a result this did not really belong in either of those patches on their own.

It is also very clearly a do one thing per patch situation.

> 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/pci.c            | 2 ++
> >  tools/testing/cxl/test/mem.c | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8f86f85d89c7..11e95a95195a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -521,6 +521,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	cxl_mem_get_event_records(cxlds);
> > +
> >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
> >  
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index aa2df3a15051..e2f5445d24ff 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	cxl_mem_get_event_records(cxlds);
> > +
> 
> This hunk likely goes with the first patch that actually implements some
> mocked events.

If this patch was squashed into the other patches yes.  But as a patch which
does exactly 1 thing "Clear events on driver load" it works IMO.  I could just
have well put this patch at the very end.

Now that the Get/Clear operations are more settled I'll split this out and
squash it as you suggest.  Jonathan suggested squashing Get/Clear too but again
I really prefer the 1 thing/patch and each of those operations seemed like a
good breakdown.

Ira

> 
> >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
> >  
> > -- 
> > 2.37.2
> > 
> 
> 
