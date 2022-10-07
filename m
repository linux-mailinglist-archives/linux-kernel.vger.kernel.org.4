Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA8D5F7AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJGPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJGPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:45:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F5B6BCCD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665157556; x=1696693556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VuFmAkClbZafiHmPmevb08e9wxmyfIIz+PHdLsaP7DQ=;
  b=QYudQWFV0LFu3C0rSdkIxfeVn5SOycgavUCfcddJOB3YkjsGcmaqm5O1
   fA2mrIOr7KmZq5R0WIVSRd2/N56K2fHDa+uyOYZWQtng/xXRPKYv1UcBL
   Uh3751wus9/fL4OE27g4dwn3UaLy+h1D5tcHP0SBXj5wlVnjX3RYFU2Td
   8t1vGND1boMITZfWWOX0XcmTyxIpBNbsc4++RqikQ2igqSOvsUgp7f8QS
   c7et7bUgPgDJMlgKfcvRCycqyiUVX1BGGltZU44lL8ln3ZTdXJXmKhZLx
   8mxzE6uKJfVdsnirLwPbSvJFO6JMysssmyIz5TFL8iDdqTiy1Ea2neyq6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="286989640"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="286989640"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="576275909"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="576275909"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2022 08:45:49 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:45:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 08:45:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 08:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAbZHMQ+x6j6Y++Jsfa35/hKIUxe2CA6dpuFZFemzoKxtxE6oFykGNdXFJyb7AOsjd0gEjFrZohcbk3XG9LQabI8C4d8izm+JIkNhSDoseMGcrR27X8EOOwPlyu7KOJXPIYXh4l6eepy7CNQ20Sv5jggPegBJbyjadzFftb5djO9T+e4Rbq4hZBtna6JSwZkLcVfBJsyuZoLow8JW4Gqqj253Xd1MngMakIZ1uzID6sYoI+EECXTqR8cwWP18rrHwocAlgEdjkvtSZcFIoP+VVebP2rvrKOXy/2tDD7W9LUTWz49IxzXvkZrC+N2f76K8UB/gNyo4lv50upcDGHTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuFGPIJxW5VZzfbqd28kHQL0m9+f6T2efdNJ/r8a+Ns=;
 b=iu++WmtElEZGtmecnTfUWgwz32ep3TabRcolT09GVBxx+BunLc9gf3a/8nYlXa8QXfG/rNgZHzOyjgHk78/Zv5lL0PHA37mEcVOyYwDOf6MWslyBo4BbJG6JTe5ur97jZYRyRalOTbzI5iCXfrOwOwYtpi8qNPKyhh7X2pa+/6hEklU8PqfeGtf3bFDXvarBCIq62D2vVaOxhNOBFv9cSNheZrZ9TAfRk0h7ZdGFfnxEVMXbgpTEInvBn3NmZ9noorsRPtQWiPByfMDMoXxRGHQZn2VcieVAwMUaglIuSQxn0EHCX7MmyrD3xxGU53fZDy4gZaznr2sPl3fIRPdUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 15:45:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 15:45:45 +0000
Date:   Fri, 7 Oct 2022 08:45:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] highmem: Fix kmap_to_page() for kmap_local_page()
 addresses
Message-ID: <Y0BJpOiAlStJJ5CM@iweiny-desk3>
References: <20221006040555.1502679-1-ira.weiny@intel.com>
 <20221006133331.dabd345508f7d62a887dfb4d@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221006133331.dabd345508f7d62a887dfb4d@linux-foundation.org>
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1b764a-fda7-4e48-e786-08daa87aff7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxTqVMOXjTi1IRAse9cSuuEOHBpvW9DqipmKgnAdqz49Z5DPOJri7m13ddiFCaaNwFsLOX5QS4+7BdBp5RJBeQZH/bDG1Q0s/3ghcUJFRj0+lRx0+y7pJJwjL2sQabjUBpZR1JJ4KMOO3sJkz9jUG4Ux9yLc5GPjo7QUBBnrpyt/ndqy0CLupspivLPRTl3Du3bdUqKKdktpgMdoxN6HFKWbUx6e5n1iyALaEtGHaMME5PZZuRXKAy9B4ZrDZsqFv2sJnrHN73ZIWPtqPihfsKSJcxgDecKKZF/4aDpYh5qebnivCAB4FNlGIAzD9tFtlVqrY9kRIW8iuUnTD6NT8SpqA3mxCU5zvBaa38mCEE8VSrCyNDYkd0ms6PKRN2cLBAXI69JXS2OTYkwD42G3uwNOC/PANfT6bRaiRhnwpRkLoKYqX0kEWFpDCCLuqm3ny8IECE6vZpODCOaQqrzJlKqmMhD2bhGFIab+U5uw+l6KCBx0GObyYiSU+m7I3CAYQdq23eIRhLWdLT2GZezLOBFNZ2nhqdhSvLqPLfC8EMpfER7ynxWZrGyQq1l5LIvgN3/9KduMjyOCXBmYyxzKC/idVR02hIaatFiDYa8fVilAHGYR4V1SmyKOp+EwDgVsMB1QSRmbCyw9Lrvz8Ofs3BEIZY+MHe/xE+aM/5bSFCcQjn+7Z3jFky37X2CYaZZEvLGjvoBlahGln5gS+pQ20BXrPdqlTdxjRttjv791ycxfkwvDCQRXyJh9N/g67Y52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(966005)(6486002)(6506007)(478600001)(8676002)(66946007)(66556008)(66476007)(316002)(54906003)(6916009)(6666004)(4326008)(38100700002)(186003)(26005)(9686003)(6512007)(82960400001)(33716001)(86362001)(8936002)(2906002)(44832011)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bar97cD3lbXEGvf5z+108l/B3OPI8FRojimDYqbEqHDL79M64Ot21wW/sWc3?=
 =?us-ascii?Q?eopYVUg78p6QSdwpV6x/TRu1lDp2wxmQnr2WSMP9B/Lp5+DC947p6qA5VLxr?=
 =?us-ascii?Q?bNFUnSrXnys1PN0HQW/hAW+TtlvdqZ8u5jLwVb3G/lAr4vRitDkjGBdAcfYc?=
 =?us-ascii?Q?VkaTFFUxkoh/qOaKfFw9ctEZobkrmSqY8Fc0PoAwtGhM25wzoFT42n7xjzqF?=
 =?us-ascii?Q?gXZyyJm0ziO13/p+vRj5U7r/ok8nqD9t5dR2mR1dl9KGIS0rOTA9v3NATDPk?=
 =?us-ascii?Q?nINFYMIZE5KdCTPKLkJI/IVr0pbtDBqGaA8U8/77hBtCLEAPUGE3t89tvRdk?=
 =?us-ascii?Q?FbDS9FjdD2OOjkYrdQ+ebjhhPIpmcCPFlmOaqasyVPyT6p7i58caY6sF0xvn?=
 =?us-ascii?Q?Uwa0hBpobp/cyLWym3Qq2yDiSzATlOJvfZvHIygPYDYzbWQT0qb6aXDstpFO?=
 =?us-ascii?Q?Rae8pNdpOqBQZP0CDQ/0oQk1cHe3CWSFOiTUZSc3L+/VQdTubyrzRJdeY2ts?=
 =?us-ascii?Q?OrSAbUGhd6HS4PG/4A5tPyhfW/OkYjekvbgGKKIxYoEKjEFyG1ah7t2MqcX2?=
 =?us-ascii?Q?+xa9L+0POtm1hf809kddPP2XrMU9ZlyoLZEsvI0RTLXLCySSyPR2rIyfjFwu?=
 =?us-ascii?Q?KywC4CfQkBfVXyV1EMhERTMkv1Xb1J51EXkolJQW8zYj9lrKl1wFF/FSslqt?=
 =?us-ascii?Q?L4YvXl6Kzh/5nO1UzQ+5LPvo+/CA/42hHRXNy21EpM1rNHE554o6EKFhrd8W?=
 =?us-ascii?Q?nBqrwf1Hy+rS05dEHeQuZKA9Om/y2pS0665SFQZdkrWG8Ks6I6WfS6JGDap/?=
 =?us-ascii?Q?z5JxWxujbyVs+PsGCZKKyKjnDSTLNmOoVRDFkgvC8mrqMaFUoUkG8UBrkxpY?=
 =?us-ascii?Q?44nF15hJ0+eSf2oeEY1vC+/jPQIc+J1OtIJT9ixGQ5Sp4Q1NyHbrrsFof8lv?=
 =?us-ascii?Q?qIUpKYRd4Tw5u8BJDoHZdggPKkxSLx6D6W57IJ6N+D2hmqDNccdbORwMjS1n?=
 =?us-ascii?Q?4rLqm/hRi3YhzXb6ZLLEqhpFqdjoacmuDeQMfeCChiqqjvlKNRyhuKrnpcXV?=
 =?us-ascii?Q?jfi1Szua1egyKhdUIGZBy8KAvJfs5xAe9J0+DU8HNmTBDvp8F8YHp2XqDf1i?=
 =?us-ascii?Q?7qEzSZTUrSbhWXKnhFPABWPaG1Z4eEDJO2JjfZbvowlshGR0aYFEFt7RWMK/?=
 =?us-ascii?Q?A1b7Cq8bjXb2dYyEZMJkD8HBuLOP9qWmTVdS/dh0wQFDWmwfdkG4cQY/qEVr?=
 =?us-ascii?Q?ybnagM1Ozis1iWcJJpWZ03VQ2Hec/DVToRduX//tlZf/1dCfAIfo0Yp9sBYq?=
 =?us-ascii?Q?KflMuV8PhOUGbGGadEQWxaANhpQq8/wtr+BenYPksoZlnhGxcgm6DFimS6+q?=
 =?us-ascii?Q?vwzVp6rMx/esxEf5aCLYsxsfQiseMKzJ4gBW0pWVCSSmKrCsYUQYq2/D6bGp?=
 =?us-ascii?Q?LD8y9CKDW6l208T4W5my/OYizOMp8Om3UYBb8Ld+61h4nGbfAP8LPH5wmaWX?=
 =?us-ascii?Q?7fRCBDvouD4j+v9mfSLM+CvVGHtUYOrg3W5hbDE4RA4OUlbEih8A9OPlCGcL?=
 =?us-ascii?Q?P/sMFjvoFsA253E58YsqM4o/zDWnvoWaZrUWqkA/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1b764a-fda7-4e48-e786-08daa87aff7e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:45:45.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOkBGYWoM8QrZz9dNAfZO3QyBDvl8QgaF1XvW3GvyHdPV+keKrJuyrs5xfT0hdp8f+j2rmlm1oLlz0+8BSr7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:33:31PM -0700, Andrew Morton wrote:
> On Wed,  5 Oct 2022 21:05:55 -0700 ira.weiny@intel.com wrote:
> 
> > kmap_to_page() is used to get the page for a virtual address which may
> > be kmap'ed.  Unfortunately, kmap_local_page() stores mappings in a
> > thread local array separate from kmap().  These mappings were not
> > checked by the call.
> > 
> > Check the kmap_local_page() mappings and return the page if found.
> > 
> > Because it is intended to remove kmap_to_page() add a warn on once to
> > the kmap checks to flag potential issues early.
> 
> What were the user-visible runtime effects of this?

No one actually hit a bug with this because AFAIK only one kmap() call has been
converted to kmap_local_page() which then eventually calls kmap_to_page().

	https://lore.kernel.org/lkml/YzN+ZYLjK6HI1P1C@ZenIV/

However that has already been fixed by Al in that thread.

> 
> Are we able to identify a Fixes:?

I suppose this could be added as a Fixes: to the original patch introducing
kmap_local_page()?  But one could argue that kmap_to_page() was only intended
to support kmap() addresses because it does not work with kmap_atomic()
addresses either.

I'm proposing this as a stop gap to ensure that work can continue on converting
kmap() uses to kmap_local_page() without fear of causing breakage while
simultaneously we evaluate and hopefully remove kmap_to_page() as well.

Ira
