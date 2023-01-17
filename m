Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622E66DD77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjAQMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjAQMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:22:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6336B15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958176; x=1705494176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1O5gH2xTitVwyIMAkneN1JfBvy3Jr0by8R0QTznjTOU=;
  b=EbDgH/5FdEVqiz5ilDf8CTfwyBr2xiddDWHtsPLAOEk2cs/oY+UkoPyk
   8tTeSFgOlx3kROGyloiBo+MTxQQnrhEEOE9oB4gdjRtLO9sFwXDLIg9Zt
   xClWHkqTW3LI1rS1mssqmbjRTjUxwE/UmIcAUQs0Eyo6D0L0bVuBPUk3S
   4RH/6Vj88GJpWIaXlImVrH6rx3CwPzbRlNPMy5mMTKYgszdKEaa1WpvTs
   CgHB8p6G/9imXdgye2Br+ZZ+KsI54Nsni7o4/0rfgXI/g18BelNcGVVPv
   AtWzwTAJY8miXMdBpPtBpCBeeVN+5x119Ee8JwR3W/qPXAYyd92GvdgeR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305056468"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="log'?scan'208";a="305056468"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722637207"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="log'?scan'208";a="722637207"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 04:22:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 04:22:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 04:22:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 04:22:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRv+kX524PrzxkLrsv+xxu8QTue3EYdl2Ud7DyLdqGOtsEraGqh/clNf/oAHERJoTrsYfzoeYFtI0dFeBGfhd5JT7+nbgsJICDo6yiJtjrD4jBr2vDVbBsITOg8xqrkvowAS3BX7poN+LXpawEzIcfaNq6tvGcDUvSPxlFCqYfFm9d0/VV6WxdZ37/zzoIqcLhWfhHof+zczket5M27KiiXzTOlWoP0XavKvK7gT4qB9Ao0IkTLniQXqaB9DahPvXuZxD2bn1T3p38wxg2iCzsIF4HHP9ERvEaUUm+I2OQM45XOX0+JTXxfUu8wg+HM8D0YzY+B+xDdkL5UdeHnjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdzOzDtXc13b9hWsMgJkYoaUhq0QYTjV0+fn5cmefk8=;
 b=E/6Cd1QDvJKPIcMa/KfoDA9R1T44+xOPnounqWiU9Inpd/VVhfP3EU21jW5hKcV6oKCQ9Yj9dOdY/O4gZii7vtXvhwP8mJGRGDKXRWGUmVkdtdj+m0+skQrwABnoiIWTaHN7DmTRo5280gl608k48+o82v+4DogJ7irZtuOOpEh85fNxzJnAGmtNdFvVD+xwjbeRkdfar0dbdwqFAFGLSbwlNhlDi2GjE/lpxQNoS1nM5kClTdvvrkyx0F5ULLvmJMuI3zC3hSF35cq9O01bo7gFFBq/YzF+bQQTOtkLtRIhiYyucZ/txG5olBBMJq1o7hDFSV3gE5TtziXlO2T27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5917.namprd11.prod.outlook.com (2603:10b6:a03:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 12:22:49 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 12:22:48 +0000
Date:   Tue, 17 Jan 2023 20:20:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, <hongjiu.lu@intel.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8aSc5xGO+rW2pyo@feng-clx>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx>
Content-Type: multipart/mixed; boundary="e86ghA1MZ1LLkSXT"
Content-Disposition: inline
In-Reply-To: <Y8ZVxJSZdtEk8Nco@feng-clx>
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 920d9280-7dac-4d45-f3d1-08daf8858b90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyIwOA5e+hNo/2Gbph+AlZYUnjcFs3nJ3yuN5+cEQe9f+7MbeLBIlyWYguxoATCGcqqURhPbqwS3JQIR64U+STN/XUcNmUjK/HwYEFVXrQPAmjNywr5Zvs4bLcbikUNUna0aMGmwcxKwit9RPOotNFxTpqYy7Cc7VlEPAe1WUn3zo//0aUzGrSN/td1FL/spVlaVOy6X1Y+aTs42Bbz+D+/iV6MLTvsPmRbNL3M1F1jU47Ite0JSIcxzx2aE27ZK38x15X7rwgQCml1l3FuGcXYPPro9Q86f50larCgdzqiyUbOAuZcv1IO5oPVq9/N9rGTn+OYZzl/mlj/lvga9rG4ngIKer3TaXMI80fvSqKikV66lz/FTkBZobu6/jY87SHhPjZWkitb+qWuAuvW/x05xfOQ3Bt3rqU3jWM1LJAoFIn6121PVQXD+7Yjc+r2rHYYrobj67+IYJLVckkzjwiigbAw7TCksg8Kbi2ZaUsKS1cs6F8Vb+dInlt4YhmRcr1hBcpHbidbc72nr7K2/ujUdgIC7NhW8YOhkidTgQeHrvX7+A9Qyr8lbd0DfkkXNKfmZd5iK578iJBpYCc5ZRSvU51mIu58DxcgBT2fmu+/j2t7NmWHblG3FKWWlvAfYaMJQTpJAcWDwB0zahluk/dM5O1NAZmsOzLbNNGwqADwMtZAqBJ/R1ZCn/ePLtl2mB/vZS4LGmD/OqUk6XqwM3Ugmh3bnBBzbxvI8uPfdgK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(83380400001)(26005)(6512007)(7416002)(9686003)(2906002)(53546011)(186003)(6666004)(107886003)(21480400003)(44832011)(6506007)(44144004)(33716001)(54906003)(6916009)(5660300002)(478600001)(38100700002)(8676002)(6486002)(4326008)(235185007)(82960400001)(86362001)(66476007)(41300700001)(66556008)(316002)(66946007)(8936002)(67856001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1AyVLctTtR1AUT3Xdj+HA4kGpf3Me4RtTg9HOuKdGyxo/oA4bNYe/I9D58V?=
 =?us-ascii?Q?wkIX1w/8jEg8GKD1oVs9RSWb2/pldY3dwjn6tOZPn57a6KmrarEk6Wt1EhXs?=
 =?us-ascii?Q?tAZqiSxpYntLEHZDY4ofTsKMI+4nviKqXVFZGC+9mojorjI048SS158qsQpN?=
 =?us-ascii?Q?HBHHeY9tVV2jGOxH7aLpWWznfQbR+RRD16sF+7kVo8x/JFMO9J9+UlEBk3ZG?=
 =?us-ascii?Q?zYVQFQcQqCXf4rpM7oJUJ+wwjzPyfYxcg+Z98O2TjFw6ITMwkzzhVyrkPk5G?=
 =?us-ascii?Q?s7v4sBNh/Tf/HS5itfTsyPsNjQ+YAuJ693czZx4HBwvoU7RP+uDbodTjgtb8?=
 =?us-ascii?Q?6vkfaO5O3eQxzrrQfoby4fM8AmoDd57OdD8U5sobkQz3H2G2LGBu+C9nxuV0?=
 =?us-ascii?Q?O22cqXs1LOfNweRiS3kr4XeZGZgdOIx7A6f2qxhAjijo3AsdjU0Z9OOjBwY1?=
 =?us-ascii?Q?2XBodIriOtppkQNMQXbqJyUN7BpCMSye6Rmo02Y3eNkTAORks9s4krgGCZOI?=
 =?us-ascii?Q?nrF6DB2Fa5Ah8EtWgqmVs//IcZ9p1tp84mo2gc+ZV5tf7OZlp65lhDhfpPz3?=
 =?us-ascii?Q?IwFS9o0qiwBenoGFSn+Pp1t02KwnISyIbxQz7GVAl+h4HXj2NP55Ooz+BeNu?=
 =?us-ascii?Q?AK/+yBOLaQPE4ORe4WZ5xgxsEL2xlXKqmUhVf44eZgHhjUVHnCYNUNU/CgFT?=
 =?us-ascii?Q?aPEhz8MsLQkq1MoBr6FfxjC6/9KH3V2t2rvBAfHkubWOoe1qSG0w3eI0jjUr?=
 =?us-ascii?Q?bLX5eRlxkF64GQZRvcjkUmxeofWYnLhyqBYPyZBLRdUAnglYUioweyGz6CTG?=
 =?us-ascii?Q?S8pUvFJ/XhIR9cFojC55f0qD8rRzMwE5xlEWuhP0HUjrtE9G1ywkHIZcbIZ9?=
 =?us-ascii?Q?1Gj3nUP8vpq+XX8P1sIjPmfsHwe7k5tkdX5oEjIaNNL71vaU2pzOw9uGvXkX?=
 =?us-ascii?Q?2rWNpiz9kxvU325ThuI48gx6/WsVGnfEQywozHLKxCTxPgrpEO/T4BfMXIbG?=
 =?us-ascii?Q?Y5ZbPtkvlwoOdpAcD03BkV1V6rvR/U90lTGK+nomn1zunix7BaJd/s1F8Bfv?=
 =?us-ascii?Q?aqcbhszUU7AkBSS2G4ttUjp7WMFqTJf0RXUlHx759lKkuDmuM4zr1lmViW1b?=
 =?us-ascii?Q?QH7EjRSdYMeFV0A9Jc+kT9GsmXvh2UmRHWDqr9JW4mGSHUv7OvtloXOMCzj0?=
 =?us-ascii?Q?bSelWNPE/eEdwiZ+ITXsmbnSZMk3GEO/LT7A4Xo/Ng9d0v73lWeVdY3IBqOV?=
 =?us-ascii?Q?waOOSQKwLxPTZYLVcHiKipHNZ7EZWXO35Q6jueF+3KkDFHVnsSsYWBpSqxgL?=
 =?us-ascii?Q?mUwUCKnSE92lNsDXbtr29++DWs2YUh8Rn2Y6Du9/astEfmaqc61PdjoeG6ZM?=
 =?us-ascii?Q?BmOGhbaPyIbQTgiTvLRkvHD07xoARFdL1ynM6ZlDtMctLwBoOVT6gYl/SI6y?=
 =?us-ascii?Q?ot/Xnl+HEDlJGynlBj1WCIRfzsqYMNRTAxgluVAtIBMPA127GnvGk0/36lgq?=
 =?us-ascii?Q?n6H2MHRsSImDo9L7umA+3Fz5+mh/qPMqgseuGiamsAXGZRcMDdOjlw/MtoZQ?=
 =?us-ascii?Q?MgBuh44VBH0xn+2r/vYz4OvTpXpBbxglDwns4Hjr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 920d9280-7dac-4d45-f3d1-08daf8858b90
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 12:22:48.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7QmXMjry6nIaarKfgiOcT35gRbfq8WgMiCgjwHhEW9x5nO/ZkBFlAJxAh0fVJzxM4HcXEcvcMzEaWewcd+eDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--e86ghA1MZ1LLkSXT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jan 17, 2023 at 04:01:08PM +0800, Tang, Feng wrote:
> On Tue, Jan 17, 2023 at 03:39:15PM +0800, Vlastimil Babka wrote:
> > On 1/17/23 08:10, kernel test robot wrote:
> > > 
> > > +Vlastimil Babka, Hyeonggon Yoo, Feng Tang and Fengwei Yin
> > > 
> > > Hi, Mike Kravetz,
> > > 
> > > we reported
> > > "[linus:master] [mm, slub] 0af8489b02: kernel_BUG_at_include/linux/mm.h" [1]
> > > 
> > > Vlastimil, Hyeonggon, Feng and Fengwei gave us a lot of great guidances based on
> > > it, and, perticularly, after enabling below config per Vlastimil's suggestion
> > >   CONFIG_DEBUG_PAGEALLOC
> > >   CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> > >   CONFIG_SLUB_DEBUG
> > >   CONFIG_SLUB_DEBUG_ON
> > > by more tests, we realized the "0af8489b02" is not the real culprit.
> > > 
> > > the new bisection was triggered and finally it pointed to this "7118fc2906".
> > > 
> > > though reporting for different issues
> > > ("kernel_BUG_at_include/linux/mm.h" for 0af8489b02 vs.
> > > "kernel_BUG_at_lib/list_debug.c" for this commit),
> > > Feng and Fengwei helped further to confirm they are similar.
> > > They will supply more technical wise analysis later.
> > > 
> > > please be noted the issues are not always happening
> > > (~10% on this commit or 0af8489b02)
> > 
> > Great find! Looking at the commit, I'd bet the only part relevant to our bug
> > is the "by the way we remove setting refcount to zero on tail pages which
> > should already be zero":
> > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index db00ee8d79d2..eeff64843718 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -754,7 +754,6 @@ void prep_compound_page(struct page *page, unsigned int order)
> > >         __SetPageHead(page);
> > >         for (i = 1; i < nr_pages; i++) {
> > >                 struct page *p = page + i;
> > > -               set_page_count(p, 0);
> > >                 p->mapping = TAIL_MAPPING;
> > >                 set_compound_head(p, page);
> > >         }
> > 
> > So either the assumption of refcount being already 0 is wrong (shouldn't be,
> > AFAIK?), or this atomic operation effectively prevents some very subtle race
> > (although IIRC atomic_set() has no barrier semantics defined, it could still
> > affect a specific CPU?
>  
> Yes, "set_page_count(p, 0);" seems to be what matters here. Restoring
> it make the list corruption issue not reproducable for 300+ runs.
> 
> And back in debugging 0af8489b02, the thing was similar that if we
> added some code inside prep_compound_page(), the issue also can't
> be reproduced.
> 
> So this 7118fc2906 seems just 'expose' the problem on i386, and is
> not the root cause.
> 
> I suspect it is related with i386 compiling, based on the debug and
> memory dump. I'm doing some compiler option and adding memory
> barrier in prep_compound_page(), and will update when the test run
> is done.

With the following patch to use 'O1' instead 'O2' gcc optoin for
page_alloc.c, the list corruption issue can't be reproduced for
commit 7118fc2906 in 1000 runs. 

Oliver has reproduced it for v6.0, applying the same patch can also
make the issue gone.

As is can't be reproduced with X86_64 build, it could be i386
compiling related.

I also objdumped 'prep_compound_page' for vmlinux of 7118fc2906 and
its parent commit 48b8d744ea84, which have big difference than the
simple 'set_page_count()' change, but I can't tell which part is
abnormal, so attach them for further check.

---
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e293..2b3780208e65d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -36,6 +36,8 @@ KCOV_INSTRUMENT_failslab.o := n
 CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
 CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
 
+CFLAGS_page_alloc.o += -O1
+
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \

Thanks,
Feng

> 
> Thanks,
> Feng
> 
> > I guess we could
> > - try to restore that set_page_count(p, 0); on current kernel to see if it
> > kills the bug
> > - instead of restoring it, add (only locally for purposes of the test) a
> > BUG_ON() if refcount is not zero already, and find out why if it triggers
> > (unfortunately might also appear to fix the bug even if it doesn't trigger).

--e86ghA1MZ1LLkSXT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="7118fc2906_objdump.log"


c13b3b90 <prep_compound_page>:
c13b3b90:	55                   	push   %ebp
c13b3b91:	89 e5                	mov    %esp,%ebp
c13b3b93:	57                   	push   %edi
c13b3b94:	89 c7                	mov    %eax,%edi
c13b3b96:	56                   	push   %esi
c13b3b97:	53                   	push   %ebx
c13b3b98:	83 ec 14             	sub    $0x14,%esp
c13b3b9b:	83 fa 1f             	cmp    $0x1f,%edx
c13b3b9e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
c13b3ba1:	0f 87 33 31 ed 01    	ja     c3286cda <prep_compound_page.cold>
c13b3ba7:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
c13b3bab:	bb 01 00 00 00       	mov    $0x1,%ebx
c13b3bb0:	d3 e3                	shl    %cl,%ebx
c13b3bb2:	83 3f ff             	cmpl   $0xffffffff,(%edi)
c13b3bb5:	0f 84 65 02 00 00    	je     c13b3e20 <prep_compound_page+0x290>
c13b3bbb:	83 05 d0 28 6c c5 01 	addl   $0x1,0xc56c28d0
c13b3bc2:	83 15 d4 28 6c c5 00 	adcl   $0x0,0xc56c28d4
c13b3bc9:	0f ba 2f 10          	btsl   $0x10,(%edi)
c13b3bcd:	83 05 f0 28 6c c5 01 	addl   $0x1,0xc56c28f0
c13b3bd4:	83 15 f4 28 6c c5 00 	adcl   $0x0,0xc56c28f4
c13b3bdb:	83 fb 01             	cmp    $0x1,%ebx
c13b3bde:	0f 8e 80 00 00 00    	jle    c13b3c64 <prep_compound_page+0xd4>
c13b3be4:	8d 47 01             	lea    0x1(%edi),%eax
c13b3be7:	8b 15 fc 28 6c c5    	mov    0xc56c28fc,%edx
c13b3bed:	89 45 e8             	mov    %eax,-0x18(%ebp)
c13b3bf0:	a1 f8 28 6c c5       	mov    0xc56c28f8,%eax
c13b3bf5:	8d 4f 28             	lea    0x28(%edi),%ecx
c13b3bf8:	89 7d e0             	mov    %edi,-0x20(%ebp)
c13b3bfb:	83 c0 01             	add    $0x1,%eax
c13b3bfe:	89 45 ec             	mov    %eax,-0x14(%ebp)
c13b3c01:	83 d2 00             	adc    $0x0,%edx
c13b3c04:	a1 f8 28 6c c5       	mov    0xc56c28f8,%eax
c13b3c09:	89 55 f0             	mov    %edx,-0x10(%ebp)
c13b3c0c:	8b 15 fc 28 6c c5    	mov    0xc56c28fc,%edx
c13b3c12:	83 eb 02             	sub    $0x2,%ebx
c13b3c15:	31 f6                	xor    %esi,%esi
c13b3c17:	83 c0 02             	add    $0x2,%eax
c13b3c1a:	83 d2 00             	adc    $0x0,%edx
c13b3c1d:	01 c3                	add    %eax,%ebx
c13b3c1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c13b3c22:	11 d6                	adc    %edx,%esi
c13b3c24:	8b 55 f0             	mov    -0x10(%ebp),%edx
c13b3c27:	89 f7                	mov    %esi,%edi
c13b3c29:	89 de                	mov    %ebx,%esi
c13b3c2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
c13b3c2f:	90                   	nop
c13b3c30:	a3 f8 28 6c c5       	mov    %eax,0xc56c28f8
c13b3c35:	8b 5d e8             	mov    -0x18(%ebp),%ebx
c13b3c38:	83 c0 01             	add    $0x1,%eax
c13b3c3b:	89 15 fc 28 6c c5    	mov    %edx,0xc56c28fc
c13b3c41:	83 d2 00             	adc    $0x0,%edx
c13b3c44:	83 c1 28             	add    $0x28,%ecx
c13b3c47:	c7 41 e4 00 04 00 00 	movl   $0x400,-0x1c(%ecx)
c13b3c4e:	89 59 dc             	mov    %ebx,-0x24(%ecx)
c13b3c51:	89 fb                	mov    %edi,%ebx
c13b3c53:	31 d3                	xor    %edx,%ebx
c13b3c55:	89 5d ec             	mov    %ebx,-0x14(%ebp)
c13b3c58:	89 f3                	mov    %esi,%ebx
c13b3c5a:	31 c3                	xor    %eax,%ebx
c13b3c5c:	0b 5d ec             	or     -0x14(%ebp),%ebx
c13b3c5f:	75 cf                	jne    c13b3c30 <prep_compound_page+0xa0>
c13b3c61:	8b 7d e0             	mov    -0x20(%ebp),%edi
c13b3c64:	c6 47 30 01          	movb   $0x1,0x30(%edi)
c13b3c68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c13b3c6b:	83 05 b8 1a 6c c5 01 	addl   $0x1,0xc56c1ab8
c13b3c72:	83 15 bc 1a 6c c5 00 	adcl   $0x0,0xc56c1abc
c13b3c79:	83 f8 1f             	cmp    $0x1f,%eax
c13b3c7c:	88 47 31             	mov    %al,0x31(%edi)
c13b3c7f:	0f 87 4f 02 00 00    	ja     c13b3ed4 <prep_compound_page+0x344>
c13b3c85:	c7 47 34 ff ff ff ff 	movl   $0xffffffff,0x34(%edi)
c13b3c8c:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
c13b3c90:	b8 01 00 00 00       	mov    $0x1,%eax
c13b3c95:	8b 77 04             	mov    0x4(%edi),%esi
c13b3c98:	d3 e0                	shl    %cl,%eax
c13b3c9a:	83 05 00 29 6c c5 01 	addl   $0x1,0xc56c2900
c13b3ca1:	89 47 38             	mov    %eax,0x38(%edi)
c13b3ca4:	83 15 04 29 6c c5 00 	adcl   $0x0,0xc56c2904
c13b3cab:	f7 c6 01 00 00 00    	test   $0x1,%esi
c13b3cb1:	0f 85 b9 01 00 00    	jne    c13b3e70 <prep_compound_page+0x2e0>
c13b3cb7:	83 05 88 1a 6c c5 01 	addl   $0x1,0xc56c1a88
c13b3cbe:	89 fe                	mov    %edi,%esi
c13b3cc0:	83 15 8c 1a 6c c5 00 	adcl   $0x0,0xc56c1a8c
c13b3cc7:	a1 a0 15 6c c5       	mov    0xc56c15a0,%eax
c13b3ccc:	8b 15 a4 15 6c c5    	mov    0xc56c15a4,%edx
c13b3cd2:	89 c1                	mov    %eax,%ecx
c13b3cd4:	83 c1 01             	add    $0x1,%ecx
c13b3cd7:	89 d3                	mov    %edx,%ebx
c13b3cd9:	89 0d a0 15 6c c5    	mov    %ecx,0xc56c15a0
c13b3cdf:	8b 0e                	mov    (%esi),%ecx
c13b3ce1:	83 d3 00             	adc    $0x0,%ebx
c13b3ce4:	83 05 90 1a 6c c5 01 	addl   $0x1,0xc56c1a90
c13b3ceb:	89 1d a4 15 6c c5    	mov    %ebx,0xc56c15a4
c13b3cf1:	83 15 94 1a 6c c5 00 	adcl   $0x0,0xc56c1a94
c13b3cf8:	81 e1 00 00 01 00    	and    $0x10000,%ecx
c13b3cfe:	75 4e                	jne    c13b3d4e <prep_compound_page+0x1be>
c13b3d00:	8b 4e 04             	mov    0x4(%esi),%ecx
c13b3d03:	83 05 98 1a 6c c5 01 	addl   $0x1,0xc56c1a98
c13b3d0a:	83 15 9c 1a 6c c5 00 	adcl   $0x0,0xc56c1a9c
c13b3d11:	f6 c1 01             	test   $0x1,%cl
c13b3d14:	75 2a                	jne    c13b3d40 <prep_compound_page+0x1b0>
c13b3d16:	a1 08 29 6c c5       	mov    0xc56c2908,%eax
c13b3d1b:	8b 15 0c 29 6c c5    	mov    0xc56c290c,%edx
c13b3d21:	83 c0 01             	add    $0x1,%eax
c13b3d24:	a3 08 29 6c c5       	mov    %eax,0xc56c2908
c13b3d29:	83 d2 00             	adc    $0x0,%edx
c13b3d2c:	89 15 0c 29 6c c5    	mov    %edx,0xc56c290c
c13b3d32:	83 c4 14             	add    $0x14,%esp
c13b3d35:	5b                   	pop    %ebx
c13b3d36:	5e                   	pop    %esi
c13b3d37:	5f                   	pop    %edi
c13b3d38:	5d                   	pop    %ebp
c13b3d39:	c3                   	ret    
c13b3d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
c13b3d40:	83 05 a0 1a 6c c5 01 	addl   $0x1,0xc56c1aa0
c13b3d47:	83 15 a4 1a 6c c5 00 	adcl   $0x0,0xc56c1aa4
c13b3d4e:	83 3e ff             	cmpl   $0xffffffff,(%esi)
c13b3d51:	0f 84 2d 01 00 00    	je     c13b3e84 <prep_compound_page+0x2f4>
c13b3d57:	83 05 48 1a 6c c5 01 	addl   $0x1,0xc56c1a48
c13b3d5e:	8b 0d a8 1a 6c c5    	mov    0xc56c1aa8,%ecx
c13b3d64:	8b 1d ac 1a 6c c5    	mov    0xc56c1aac,%ebx
c13b3d6a:	83 15 4c 1a 6c c5 00 	adcl   $0x0,0xc56c1a4c
c13b3d71:	83 c0 02             	add    $0x2,%eax
c13b3d74:	83 d2 00             	adc    $0x0,%edx
c13b3d77:	a3 a0 15 6c c5       	mov    %eax,0xc56c15a0
c13b3d7c:	8b 06                	mov    (%esi),%eax
c13b3d7e:	83 c1 01             	add    $0x1,%ecx
c13b3d81:	89 15 a4 15 6c c5    	mov    %edx,0xc56c15a4
c13b3d87:	83 d3 00             	adc    $0x0,%ebx
c13b3d8a:	8b 15 0c 29 6c c5    	mov    0xc56c290c,%edx
c13b3d90:	89 45 ec             	mov    %eax,-0x14(%ebp)
c13b3d93:	a1 08 29 6c c5       	mov    0xc56c2908,%eax
c13b3d98:	f7 45 ec 00 00 01 00 	testl  $0x10000,-0x14(%ebp)
c13b3d9f:	74 4f                	je     c13b3df0 <prep_compound_page+0x260>
c13b3da1:	83 05 70 1a 6c c5 01 	addl   $0x1,0xc56c1a70
c13b3da8:	89 0d a8 1a 6c c5    	mov    %ecx,0xc56c1aa8
c13b3dae:	83 15 74 1a 6c c5 00 	adcl   $0x0,0xc56c1a74
c13b3db5:	80 7e 31 01          	cmpb   $0x1,0x31(%esi)
c13b3db9:	89 1d ac 1a 6c c5    	mov    %ebx,0xc56c1aac
c13b3dbf:	76 49                	jbe    c13b3e0a <prep_compound_page+0x27a>
c13b3dc1:	c7 47 58 00 00 00 00 	movl   $0x0,0x58(%edi)
c13b3dc8:	83 c0 01             	add    $0x1,%eax
c13b3dcb:	a3 08 29 6c c5       	mov    %eax,0xc56c2908
c13b3dd0:	83 d2 00             	adc    $0x0,%edx
c13b3dd3:	83 05 10 29 6c c5 01 	addl   $0x1,0xc56c2910
c13b3dda:	89 15 0c 29 6c c5    	mov    %edx,0xc56c290c
c13b3de0:	83 15 14 29 6c c5 00 	adcl   $0x0,0xc56c2914
c13b3de7:	83 c4 14             	add    $0x14,%esp
c13b3dea:	5b                   	pop    %ebx
c13b3deb:	5e                   	pop    %esi
c13b3dec:	5f                   	pop    %edi
c13b3ded:	5d                   	pop    %ebp
c13b3dee:	c3                   	ret    
c13b3def:	90                   	nop
c13b3df0:	83 05 68 1a 6c c5 01 	addl   $0x1,0xc56c1a68
c13b3df7:	89 0d a8 1a 6c c5    	mov    %ecx,0xc56c1aa8
c13b3dfd:	83 15 6c 1a 6c c5 00 	adcl   $0x0,0xc56c1a6c
c13b3e04:	89 1d ac 1a 6c c5    	mov    %ebx,0xc56c1aac
c13b3e0a:	83 05 b0 1a 6c c5 01 	addl   $0x1,0xc56c1ab0
c13b3e11:	83 15 b4 1a 6c c5 00 	adcl   $0x0,0xc56c1ab4
c13b3e18:	e9 04 ff ff ff       	jmp    c13b3d21 <prep_compound_page+0x191>
c13b3e1d:	8d 76 00             	lea    0x0(%esi),%esi
c13b3e20:	83 05 c8 28 6c c5 01 	addl   $0x1,0xc56c28c8
c13b3e27:	ba 98 c9 e8 c3       	mov    $0xc3e8c998,%edx
c13b3e2c:	89 f8                	mov    %edi,%eax
c13b3e2e:	83 15 cc 28 6c c5 00 	adcl   $0x0,0xc56c28cc
c13b3e35:	e8 36 16 fb ff       	call   c1365470 <dump_page>
c13b3e3a:	83 05 d8 28 6c c5 01 	addl   $0x1,0xc56c28d8
c13b3e41:	83 15 dc 28 6c c5 00 	adcl   $0x0,0xc56c28dc
c13b3e48:	0f 0b                	ud2    
c13b3e4a:	83 05 e0 28 6c c5 01 	addl   $0x1,0xc56c28e0
c13b3e51:	83 15 e4 28 6c c5 00 	adcl   $0x0,0xc56c28e4
c13b3e58:	83 05 e8 28 6c c5 01 	addl   $0x1,0xc56c28e8
c13b3e5f:	b8 c0 d4 5e c4       	mov    $0xc45ed4c0,%eax
c13b3e64:	83 15 ec 28 6c c5 00 	adcl   $0x0,0xc56c28ec
c13b3e6b:	e8 58 6b f3 01       	call   c32ea9c8 <__ubsan_handle_builtin_unreachable>
c13b3e70:	83 05 80 1a 6c c5 01 	addl   $0x1,0xc56c1a80
c13b3e77:	83 15 84 1a 6c c5 00 	adcl   $0x0,0xc56c1a84
c13b3e7e:	4e                   	dec    %esi
c13b3e7f:	e9 43 fe ff ff       	jmp    c13b3cc7 <prep_compound_page+0x137>
c13b3e84:	83 05 40 1a 6c c5 01 	addl   $0x1,0xc56c1a40
c13b3e8b:	ba 98 c9 e8 c3       	mov    $0xc3e8c998,%edx
c13b3e90:	89 f0                	mov    %esi,%eax
c13b3e92:	83 15 44 1a 6c c5 00 	adcl   $0x0,0xc56c1a44
c13b3e99:	e8 d2 15 fb ff       	call   c1365470 <dump_page>
c13b3e9e:	83 05 50 1a 6c c5 01 	addl   $0x1,0xc56c1a50
c13b3ea5:	83 15 54 1a 6c c5 00 	adcl   $0x0,0xc56c1a54
c13b3eac:	0f 0b                	ud2    
c13b3eae:	83 05 58 1a 6c c5 01 	addl   $0x1,0xc56c1a58
c13b3eb5:	83 15 5c 1a 6c c5 00 	adcl   $0x0,0xc56c1a5c
c13b3ebc:	83 05 60 1a 6c c5 01 	addl   $0x1,0xc56c1a60
c13b3ec3:	b8 b4 d4 5e c4       	mov    $0xc45ed4b4,%eax
c13b3ec8:	83 15 64 1a 6c c5 00 	adcl   $0x0,0xc56c1a64
c13b3ecf:	e8 f4 6a f3 01       	call   c32ea9c8 <__ubsan_handle_builtin_unreachable>
c13b3ed4:	e9 26 2e ed 01       	jmp    c3286cff <prep_compound_page.cold+0x25>
c13b3ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi



--e86ghA1MZ1LLkSXT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="48b8d744ea84_objdump.log"


c13b3c90 <prep_compound_page>:
c13b3c90:	55                   	push   %ebp
c13b3c91:	89 e5                	mov    %esp,%ebp
c13b3c93:	57                   	push   %edi
c13b3c94:	56                   	push   %esi
c13b3c95:	89 c6                	mov    %eax,%esi
c13b3c97:	53                   	push   %ebx
c13b3c98:	83 ec 0c             	sub    $0xc,%esp
c13b3c9b:	83 fa 1f             	cmp    $0x1f,%edx
c13b3c9e:	89 55 ec             	mov    %edx,-0x14(%ebp)
c13b3ca1:	0f 87 33 2f ed 01    	ja     c3286bda <prep_compound_page.cold>
c13b3ca7:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
c13b3cab:	bf 01 00 00 00       	mov    $0x1,%edi
c13b3cb0:	d3 e7                	shl    %cl,%edi
c13b3cb2:	83 3e ff             	cmpl   $0xffffffff,(%esi)
c13b3cb5:	0f 84 85 02 00 00    	je     c13b3f40 <prep_compound_page+0x2b0>
c13b3cbb:	83 05 d0 28 6c c5 01 	addl   $0x1,0xc56c28d0
c13b3cc2:	83 15 d4 28 6c c5 00 	adcl   $0x0,0xc56c28d4
c13b3cc9:	0f ba 2e 10          	btsl   $0x10,(%esi)
c13b3ccd:	83 05 f0 28 6c c5 01 	addl   $0x1,0xc56c28f0
c13b3cd4:	83 15 f4 28 6c c5 00 	adcl   $0x0,0xc56c28f4
c13b3cdb:	83 ff 01             	cmp    $0x1,%edi
c13b3cde:	7e 69                	jle    c13b3d49 <prep_compound_page+0xb9>
c13b3ce0:	89 75 e8             	mov    %esi,-0x18(%ebp)
c13b3ce3:	8d 46 28             	lea    0x28(%esi),%eax
c13b3ce6:	bb 01 00 00 00       	mov    $0x1,%ebx
c13b3ceb:	8d 4e 01             	lea    0x1(%esi),%ecx
c13b3cee:	89 c6                	mov    %eax,%esi
c13b3cf0:	83 05 80 18 6c c5 01 	addl   $0x1,0xc56c1880
c13b3cf7:	c7 46 1c 00 00 00 00 	movl   $0x0,0x1c(%esi)
c13b3cfe:	83 15 84 18 6c c5 00 	adcl   $0x0,0xc56c1884
c13b3d05:	3e 8d 74 26 00       	lea    %ds:0x0(%esi,%eiz,1),%esi
c13b3d0a:	83 05 90 18 6c c5 01 	addl   $0x1,0xc56c1890
c13b3d11:	83 15 94 18 6c c5 00 	adcl   $0x0,0xc56c1894
c13b3d18:	83 05 a0 18 6c c5 01 	addl   $0x1,0xc56c18a0
c13b3d1f:	83 15 a4 18 6c c5 00 	adcl   $0x0,0xc56c18a4
c13b3d26:	83 05 f8 28 6c c5 01 	addl   $0x1,0xc56c28f8
c13b3d2d:	c7 46 0c 00 04 00 00 	movl   $0x400,0xc(%esi)
c13b3d34:	83 15 fc 28 6c c5 00 	adcl   $0x0,0xc56c28fc
c13b3d3b:	43                   	inc    %ebx
c13b3d3c:	83 c6 28             	add    $0x28,%esi
c13b3d3f:	89 4e dc             	mov    %ecx,-0x24(%esi)
c13b3d42:	39 df                	cmp    %ebx,%edi
c13b3d44:	75 aa                	jne    c13b3cf0 <prep_compound_page+0x60>
c13b3d46:	8b 75 e8             	mov    -0x18(%ebp),%esi
c13b3d49:	83 05 00 29 6c c5 01 	addl   $0x1,0xc56c2900
c13b3d50:	8b 45 ec             	mov    -0x14(%ebp),%eax
c13b3d53:	c6 46 30 01          	movb   $0x1,0x30(%esi)
c13b3d57:	83 15 04 29 6c c5 00 	adcl   $0x0,0xc56c2904
c13b3d5e:	83 05 b8 1a 6c c5 01 	addl   $0x1,0xc56c1ab8
c13b3d65:	88 46 31             	mov    %al,0x31(%esi)
c13b3d68:	83 15 bc 1a 6c c5 00 	adcl   $0x0,0xc56c1abc
c13b3d6f:	83 f8 1f             	cmp    $0x1f,%eax
c13b3d72:	0f 87 7e 02 00 00    	ja     c13b3ff6 <prep_compound_page+0x366>
c13b3d78:	c7 46 34 ff ff ff ff 	movl   $0xffffffff,0x34(%esi)
c13b3d7f:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
c13b3d83:	b8 01 00 00 00       	mov    $0x1,%eax
c13b3d88:	d3 e0                	shl    %cl,%eax
c13b3d8a:	89 46 38             	mov    %eax,0x38(%esi)
c13b3d8d:	8b 46 04             	mov    0x4(%esi),%eax
c13b3d90:	83 05 08 29 6c c5 01 	addl   $0x1,0xc56c2908
c13b3d97:	83 15 0c 29 6c c5 00 	adcl   $0x0,0xc56c290c
c13b3d9e:	a8 01                	test   $0x1,%al
c13b3da0:	0f 85 ea 01 00 00    	jne    c13b3f90 <prep_compound_page+0x300>
c13b3da6:	83 05 88 1a 6c c5 01 	addl   $0x1,0xc56c1a88
c13b3dad:	89 f7                	mov    %esi,%edi
c13b3daf:	83 15 8c 1a 6c c5 00 	adcl   $0x0,0xc56c1a8c
c13b3db6:	a1 a0 15 6c c5       	mov    0xc56c15a0,%eax
c13b3dbb:	8b 15 a4 15 6c c5    	mov    0xc56c15a4,%edx
c13b3dc1:	89 c1                	mov    %eax,%ecx
c13b3dc3:	83 c1 01             	add    $0x1,%ecx
c13b3dc6:	89 d3                	mov    %edx,%ebx
c13b3dc8:	89 0d a0 15 6c c5    	mov    %ecx,0xc56c15a0
c13b3dce:	8b 0f                	mov    (%edi),%ecx
c13b3dd0:	83 d3 00             	adc    $0x0,%ebx
c13b3dd3:	83 05 90 1a 6c c5 01 	addl   $0x1,0xc56c1a90
c13b3dda:	89 1d a4 15 6c c5    	mov    %ebx,0xc56c15a4
c13b3de0:	83 15 94 1a 6c c5 00 	adcl   $0x0,0xc56c1a94
c13b3de7:	81 e1 00 00 01 00    	and    $0x10000,%ecx
c13b3ded:	75 4f                	jne    c13b3e3e <prep_compound_page+0x1ae>
c13b3def:	8b 4f 04             	mov    0x4(%edi),%ecx
c13b3df2:	83 05 98 1a 6c c5 01 	addl   $0x1,0xc56c1a98
c13b3df9:	83 15 9c 1a 6c c5 00 	adcl   $0x0,0xc56c1a9c
c13b3e00:	f6 c1 01             	test   $0x1,%cl
c13b3e03:	75 2b                	jne    c13b3e30 <prep_compound_page+0x1a0>
c13b3e05:	a1 10 29 6c c5       	mov    0xc56c2910,%eax
c13b3e0a:	8b 15 14 29 6c c5    	mov    0xc56c2914,%edx
c13b3e10:	83 c0 01             	add    $0x1,%eax
c13b3e13:	a3 10 29 6c c5       	mov    %eax,0xc56c2910
c13b3e18:	83 d2 00             	adc    $0x0,%edx
c13b3e1b:	89 15 14 29 6c c5    	mov    %edx,0xc56c2914
c13b3e21:	83 c4 0c             	add    $0xc,%esp
c13b3e24:	5b                   	pop    %ebx
c13b3e25:	5e                   	pop    %esi
c13b3e26:	5f                   	pop    %edi
c13b3e27:	5d                   	pop    %ebp
c13b3e28:	c3                   	ret    
c13b3e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
c13b3e30:	83 05 a0 1a 6c c5 01 	addl   $0x1,0xc56c1aa0
c13b3e37:	83 15 a4 1a 6c c5 00 	adcl   $0x0,0xc56c1aa4
c13b3e3e:	83 3f ff             	cmpl   $0xffffffff,(%edi)
c13b3e41:	0f 84 5f 01 00 00    	je     c13b3fa6 <prep_compound_page+0x316>
c13b3e47:	83 05 48 1a 6c c5 01 	addl   $0x1,0xc56c1a48
c13b3e4e:	8b 0d a8 1a 6c c5    	mov    0xc56c1aa8,%ecx
c13b3e54:	8b 1d ac 1a 6c c5    	mov    0xc56c1aac,%ebx
c13b3e5a:	83 15 4c 1a 6c c5 00 	adcl   $0x0,0xc56c1a4c
c13b3e61:	83 c0 02             	add    $0x2,%eax
c13b3e64:	83 d2 00             	adc    $0x0,%edx
c13b3e67:	a3 a0 15 6c c5       	mov    %eax,0xc56c15a0
c13b3e6c:	8b 07                	mov    (%edi),%eax
c13b3e6e:	83 c1 01             	add    $0x1,%ecx
c13b3e71:	89 15 a4 15 6c c5    	mov    %edx,0xc56c15a4
c13b3e77:	83 d3 00             	adc    $0x0,%ebx
c13b3e7a:	8b 15 14 29 6c c5    	mov    0xc56c2914,%edx
c13b3e80:	89 45 f0             	mov    %eax,-0x10(%ebp)
c13b3e83:	a1 10 29 6c c5       	mov    0xc56c2910,%eax
c13b3e88:	f7 45 f0 00 00 01 00 	testl  $0x10000,-0x10(%ebp)
c13b3e8f:	74 7f                	je     c13b3f10 <prep_compound_page+0x280>
c13b3e91:	83 05 70 1a 6c c5 01 	addl   $0x1,0xc56c1a70
c13b3e98:	89 0d a8 1a 6c c5    	mov    %ecx,0xc56c1aa8
c13b3e9e:	83 15 74 1a 6c c5 00 	adcl   $0x0,0xc56c1a74
c13b3ea5:	80 7f 31 01          	cmpb   $0x1,0x31(%edi)
c13b3ea9:	89 1d ac 1a 6c c5    	mov    %ebx,0xc56c1aac
c13b3eaf:	76 79                	jbe    c13b3f2a <prep_compound_page+0x29a>
c13b3eb1:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
c13b3eb8:	83 c0 01             	add    $0x1,%eax
c13b3ebb:	a3 10 29 6c c5       	mov    %eax,0xc56c2910
c13b3ec0:	83 d2 00             	adc    $0x0,%edx
c13b3ec3:	83 05 18 29 6c c5 01 	addl   $0x1,0xc56c2918
c13b3eca:	89 15 14 29 6c c5    	mov    %edx,0xc56c2914
c13b3ed0:	83 15 1c 29 6c c5 00 	adcl   $0x0,0xc56c291c
c13b3ed7:	83 c4 0c             	add    $0xc,%esp
c13b3eda:	5b                   	pop    %ebx
c13b3edb:	5e                   	pop    %esi
c13b3edc:	5f                   	pop    %edi
c13b3edd:	5d                   	pop    %ebp
c13b3ede:	c3                   	ret    
c13b3edf:	90                   	nop
c13b3ee0:	83 05 88 18 6c c5 01 	addl   $0x1,0xc56c1888
c13b3ee7:	89 f0                	mov    %esi,%eax
c13b3ee9:	89 4d f0             	mov    %ecx,-0x10(%ebp)
c13b3eec:	83 15 8c 18 6c c5 00 	adcl   $0x0,0xc56c188c
c13b3ef3:	31 d2                	xor    %edx,%edx
c13b3ef5:	e8 56 3e 08 00       	call   c1437d50 <__page_ref_set>
c13b3efa:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c13b3efd:	83 05 98 18 6c c5 01 	addl   $0x1,0xc56c1898
c13b3f04:	83 15 9c 18 6c c5 00 	adcl   $0x0,0xc56c189c
c13b3f0b:	e9 16 fe ff ff       	jmp    c13b3d26 <prep_compound_page+0x96>
c13b3f10:	83 05 68 1a 6c c5 01 	addl   $0x1,0xc56c1a68
c13b3f17:	89 0d a8 1a 6c c5    	mov    %ecx,0xc56c1aa8
c13b3f1d:	83 15 6c 1a 6c c5 00 	adcl   $0x0,0xc56c1a6c
c13b3f24:	89 1d ac 1a 6c c5    	mov    %ebx,0xc56c1aac
c13b3f2a:	83 05 b0 1a 6c c5 01 	addl   $0x1,0xc56c1ab0
c13b3f31:	83 15 b4 1a 6c c5 00 	adcl   $0x0,0xc56c1ab4
c13b3f38:	e9 d3 fe ff ff       	jmp    c13b3e10 <prep_compound_page+0x180>
c13b3f3d:	8d 76 00             	lea    0x0(%esi),%esi
c13b3f40:	83 05 c8 28 6c c5 01 	addl   $0x1,0xc56c28c8
c13b3f47:	ba 48 c9 e8 c3       	mov    $0xc3e8c948,%edx
c13b3f4c:	89 f0                	mov    %esi,%eax
c13b3f4e:	83 15 cc 28 6c c5 00 	adcl   $0x0,0xc56c28cc
c13b3f55:	e8 16 16 fb ff       	call   c1365570 <dump_page>
c13b3f5a:	83 05 d8 28 6c c5 01 	addl   $0x1,0xc56c28d8
c13b3f61:	83 15 dc 28 6c c5 00 	adcl   $0x0,0xc56c28dc
c13b3f68:	0f 0b                	ud2    
c13b3f6a:	83 05 e0 28 6c c5 01 	addl   $0x1,0xc56c28e0
c13b3f71:	83 15 e4 28 6c c5 00 	adcl   $0x0,0xc56c28e4
c13b3f78:	83 05 e8 28 6c c5 01 	addl   $0x1,0xc56c28e8
c13b3f7f:	b8 c0 d4 5e c4       	mov    $0xc45ed4c0,%eax
c13b3f84:	83 15 ec 28 6c c5 00 	adcl   $0x0,0xc56c28ec
c13b3f8b:	e8 b8 66 f3 01       	call   c32ea648 <__ubsan_handle_builtin_unreachable>
c13b3f90:	83 05 80 1a 6c c5 01 	addl   $0x1,0xc56c1a80
c13b3f97:	8d 78 ff             	lea    -0x1(%eax),%edi
c13b3f9a:	83 15 84 1a 6c c5 00 	adcl   $0x0,0xc56c1a84
c13b3fa1:	e9 10 fe ff ff       	jmp    c13b3db6 <prep_compound_page+0x126>
c13b3fa6:	83 05 40 1a 6c c5 01 	addl   $0x1,0xc56c1a40
c13b3fad:	ba 48 c9 e8 c3       	mov    $0xc3e8c948,%edx
c13b3fb2:	89 f8                	mov    %edi,%eax
c13b3fb4:	83 15 44 1a 6c c5 00 	adcl   $0x0,0xc56c1a44
c13b3fbb:	e8 b0 15 fb ff       	call   c1365570 <dump_page>
c13b3fc0:	83 05 50 1a 6c c5 01 	addl   $0x1,0xc56c1a50
c13b3fc7:	83 15 54 1a 6c c5 00 	adcl   $0x0,0xc56c1a54
c13b3fce:	0f 0b                	ud2    
c13b3fd0:	83 05 58 1a 6c c5 01 	addl   $0x1,0xc56c1a58
c13b3fd7:	83 15 5c 1a 6c c5 00 	adcl   $0x0,0xc56c1a5c
c13b3fde:	83 05 60 1a 6c c5 01 	addl   $0x1,0xc56c1a60
c13b3fe5:	b8 b4 d4 5e c4       	mov    $0xc45ed4b4,%eax
c13b3fea:	83 15 64 1a 6c c5 00 	adcl   $0x0,0xc56c1a64
c13b3ff1:	e8 52 66 f3 01       	call   c32ea648 <__ubsan_handle_builtin_unreachable>
c13b3ff6:	e9 04 2c ed 01       	jmp    c3286bff <prep_compound_page.cold+0x25>
c13b3ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
c13b3fff:	90                   	nop



--e86ghA1MZ1LLkSXT--
