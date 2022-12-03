Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47164130D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiLCBrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiLCBrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:47:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF90D80EB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670032037; x=1701568037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VwrUSWbo2GtY4IursRxFRNhPrk6EqXlOUw79/XQzt80=;
  b=SlRjVScuHlqQ+chEhrQ6OeJhpQe8SRbLjWq2F8N/MPD41DSxNMRceQj3
   a5RNWoPJ4hnKempX5dzGGKGUiTVaRO/PRabb6lPEVdv+Xjbj2kYAlwSOr
   8k+A6xc/i7NVt43f3dNml6dUMS3EUrtwGaHJYbLa4t2LyZEm3BKQi0sH4
   HZY0e4dM3SSZ3p+GK0YpFOu3ubvuBtc37u4Rr3dLaUlG9yDMb0BllYdh4
   +CvNSJgYSGTPwK8OXptmYXqj7z6PcJphD4VfPz09TqknkqEZHJ7nkORkv
   EwyX/VKpa9DqUKvX03FL2NqiCpX9cGhdz+XKXfbWfdEB6VKki4KfL3T3B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313720642"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313720642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="676026186"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="676026186"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2022 17:47:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:47:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 17:47:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 17:47:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIAix1NqonlACnm/W6BGACTv/QQEsUu2KBdk7aqFFwTGzwbuj7CQ08Rx8xLbIimN2U2u3dRDUDaJrbvD9JwXj/z6s+NeYs0PAWQ8CxqCy7Wki+GsuFvazskunvxRdot4jfpCQ8lN+cHMzjjs6cx9TVVRJ9loAaFm56XB/y7U0p2dxw2e6KD3eaDKNKAjzyrJBMKDD/333i9YXrK0/p540+JUX7qfhA938GjpizCFdariiFK5WA9mnKx+MK1flAmaewQqYOxTmLWCDxLRi4qiNfYe5mLSP3zvM8zTut+yDCWuj3fxI37Wv4YRMI/qG1VpaG24v9siEd3Tb2LLDU13rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qLANXu9zxsi1SnfzWFRx2mncad3UC6t30O/4Ik3fd8=;
 b=ZGMBmDX96DSIcpWJNvNlSv//6dVRCFH4TmuT6bLUxE2XznAtXFGyKoMLl4BZbtASqIhAebHozPmf7bxFL/8gzDMYzbjgoBXuvGUpimHYnq6asEjw+gZ/kbm7L8QhOZz+Md65DQ4BwmpCZN6wXwJ63lTCBXvNDnQV5JFNzGbT4MIUyzgqOpTFdCMIN6If/mxK2ftATyAZWOBfUutR1m7qDX0vQ5QKnqN2LB4Oti3cczH/fNMFIhgtDGcxJvRvj0x3LsL6n03Fa4bTKlYtOBFYOwa9EM4OSXfO+HGKj/dBcNT4pUM7p+OjcQS0EHnqHUXFCF67mKeWkQe+IcZShimZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 01:47:08 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 01:47:08 +0000
Date:   Fri, 2 Dec 2022 17:47:05 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 2/7] x86/microcode/intel: Remove retries on early
 microcode load
Message-ID: <Y4qqmcM8iijFaemO@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-3-ashok.raj@intel.com>
 <baf496c4-afb5-bb89-02eb-17a319618833@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <baf496c4-afb5-bb89-02eb-17a319618833@intel.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ba5746-2cc2-4a6c-d252-08dad4d049fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhVSzenxVzqPqDjlxi7Wdqm+iOhyr2aYlFKP/bONMusx4sOYCVl7NSpsgucqAfK5lyI95LKgSZ2ETyJFTaXfjHx5i3JSq1xjMIIZ8D9nDI9peZaEze9yTMS+W34BQ1JfTMYglG9sfakkJYTKFbPUPZy1+i8v2v9a01XMg2hLwNDGbqyYecOyCk40kL5fXbdnM905CMTLpxuNjb+rxXMkMCNyC5q8+SzvLswa75wK/3uDqga+l6XeHcVHIHSiJ4qMZqb8+cvSTH5SARRPk2rSf5tgdstv0jDquV4XSgef4yQNSNIGmTbEIcNYsDocjkOa2qj5g7B+MNQWwLjITQV3aanynv7iXkvzUtkwKJGTeuGIdiAQtbH8w1XcsTyk+6yOrkaCOIU5ee9fJbVHHueJbZGhp59lTl65v+ZiiH8WM1yu0qo9xo/mVT6exJeOQmZg5rRjAvsOhEzTg49P7a1+KNspVKkNVYXgiu8/l9qah9dOv5L5IPYdW0DF2S1cANqzqiEf7BQECZByA1nbSX94qbKkJ0z58ZUdegtOSAIaWHsu70hXaklMklrZqOh9I+YTJmmh5XQW3WmMPPBWMgyutQqOloJ5FPeR0g3En/MGuAGjKsHbvK4Q15jhT0+cyrRJ5e7f00Prog/vgxfL63Za9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(6506007)(2906002)(6486002)(478600001)(26005)(53546011)(6666004)(6512007)(107886003)(54906003)(6636002)(4326008)(66476007)(8676002)(66946007)(66556008)(41300700001)(186003)(6862004)(8936002)(316002)(83380400001)(44832011)(5660300002)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E3FhL9dzzhdT9bwZceSmNzcLU1fGsByoG0um6ZgfU9mxnNaMVIzodutGHVn1?=
 =?us-ascii?Q?EBCY+eJISWirvWokF3osfvALSR3zJw6pxnTqQoK5nQLfRN3Ame+FZI+m+rwh?=
 =?us-ascii?Q?Dh1KtLi1eG0g96WOGDA405TV1K0TOxP2L0OlayjLi79roGFpdbqo9P2pNlPq?=
 =?us-ascii?Q?lIHVujPQUTlMTIpK3r6uoU3kHxwdlhW3/uRIQZ2IuE3PwaEQn6uh7mMNcQuj?=
 =?us-ascii?Q?zqynMuYXJzGJQz9r92pmL7y5njrdrD8lmoZt8a4gNZwgFTtVrT4y0KsapKG2?=
 =?us-ascii?Q?gGszd1m+wr3XbWB2wgC981hWLim1eGMT3g8sZ/ZRq8IRn21DO0hbgUCneoCl?=
 =?us-ascii?Q?fSfyeaDDc7nLGe9QbMaPuCs4K5VgjiGTbX05knOolej1VviCS9maLUvTipfd?=
 =?us-ascii?Q?Tae9eo9iwMQgvwdMQVRrAq3W/bMc3JAP8M6+eVeP2EfmEIMS0E5CttEWO23w?=
 =?us-ascii?Q?HvybjEz79Ht/N9twqEvP2mfef1QzZMgF2cuKJvyn1B6lTPHgUCJCrO6BfzL4?=
 =?us-ascii?Q?72BQYHBDhWgaefK6hicAHhsFUxT8vDTMZ4FM/GX2ieL/VU60/hRMSl5AQ3ic?=
 =?us-ascii?Q?4578IIiwgY678leQ8TVzkFfTppFvL7dgvgg9W4hdArJPjubUN+zwtaviq513?=
 =?us-ascii?Q?C4xWJxlHIhJMnDx5OXZ+SdNOFMgBvHFEnNPuynxZ1m9Y/wcfXrE2Sc+UCwRQ?=
 =?us-ascii?Q?8Y2Lfr1qJX1M6efKegnDxv1jlRYsfQsYCTqgg7MK3ngMk4xT/EfSs2wWr08J?=
 =?us-ascii?Q?o2xBDYM9tg416pgGqV7HNIcv0CXJCd6oEm5YDTRrDv4ydCDEhFYGw8mzANv3?=
 =?us-ascii?Q?+ye+dVWJQdszqzSDPIzyUpalIZXij0CxQoR//MrfDPfIahbrrnV6IFlzrl6d?=
 =?us-ascii?Q?WAP20KFtD3Ip59mWiTj0V4qO+p9DBDwZ8iXPuTiHhx+tx8XJcil8ftmtFaw/?=
 =?us-ascii?Q?VA3hnBiP0huqGhm85qDFxOC9qdxHW6LkaUWBu6ATLjJxEaGC5q7X+iN68YFM?=
 =?us-ascii?Q?XpzXkCiucgEK5eeR8Sw5q3Z+vHm27toJrhLtzpv5dlbIQRqbD23UJZu5F7DU?=
 =?us-ascii?Q?xFBrwk8rd+DZflcSLwGyyHrjU8JzMwGpp9MwrrhruJPuSuI1cedR7cJX2+JZ?=
 =?us-ascii?Q?38DZrSEseeWjIBF+pOa7wqyLUCmkytRlYKPRxLsK8fGJOg9i8D2ZVqtD/7Mg?=
 =?us-ascii?Q?GTZqK9I6Ckfr4j3Zdy4FEQpfe277vu+658GpzgHcuRw8Ej5wr9moCDvrZOEy?=
 =?us-ascii?Q?EA2SfwIOpWOJuhzZXrxBmSDrRoxZyGZJyLRKkEsbUYzTtc8bl4pOA1wLugpz?=
 =?us-ascii?Q?pPfgo13foDst2/C7iBYyNeZbewvaVoI0kH3DQYE9+aU6zOnNuUv3sJQCHYzI?=
 =?us-ascii?Q?O0dK0S9bytnQ5zLxuFGs2BVOg1Ce0uWnhdyjmDwrLceiaZlsFGPSUZj/UTk8?=
 =?us-ascii?Q?sQnW/Emd7LW5WcEa0aRb6o98F18af1S498rHAZmIllsSOefaQA7pElzH/dtH?=
 =?us-ascii?Q?zkGKAeT0sVuzcq2TJryPBk6SP3+xgPDqhz77PMVAYkgWpTUbGN0DOBcEPQYS?=
 =?us-ascii?Q?YVnOqepD2qCXjWP3dUOt72Z82ykzd/uxYNxvtKnyq5Hbfu0u4OkgwMc/wxYp?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ba5746-2cc2-4a6c-d252-08dad4d049fd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 01:47:08.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ1oLQTnj1X1hr1JQ6Z4iJF7DCh6CzVhKpgNKcTZ3SkhVTUvC2rLFEc5nDRbNyv0CvzVUFdomoALvcUu4F5x5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:53:52PM -0800, Mehta, Sohil wrote:
> On 11/29/2022 1:08 PM, Ashok Raj wrote:
> > -
> > -	if (apply_microcode_early(&uci, true)) {
> > -		/* Mixed-silicon system? Try to refetch the proper patch: */
> > -		*iup = NULL;
> > -
> > -		goto reget;
> > -	}
> > +	apply_microcode_early(&uci, true);
> 
> After this change, none of the callers of apply_microcode_early() check the
> return code.
> 
> In future, do we expect callers to care about the return code? The rest
> patches in this series don't seem to suggest so. Also, the expected error
> printing happens in the function itself.
> 
> Should the return type for apply_microcode_early() be changed to void (in a
> follow-up patch)?

Good idea.. But I think its early, the return code could be used for
something useful. I have some additional cleanup patches that I need to
fixup and we could use this for real.

For e.g. early loading failures are now reported by each vendor, if we can
consolidate this, we could do it more at a core level, but I'm worried it
might be too much change right now, and this can wait its turn. 

Cheers,
Ashok
