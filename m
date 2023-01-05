Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3465F68C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjAEWPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAEWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:15:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3AB11800;
        Thu,  5 Jan 2023 14:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672956899; x=1704492899;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fyi/gXMWXvIxl9sBRYWvjM65ocXwzhis5qQ1f7IjWew=;
  b=MZKHu0acwmD5dl3lu6pkerFtLzOgCLf3Um0D8+bhmE9W2oZBU4cq6Yy6
   tkPQGFG6ytPAfMd4a+XzV/4vyAqGP3rtausyT/BVndVnP6Sl4N4qq+DJX
   m92PXEZs6lUEINhK27eppnZk5A1Ba9FL614my5n4t/zeXr3RVODcFrDz1
   1KZv5SdlE6Ok5ekqF3GK2PGxFswCo9UoYLfo/Wiq0no5ozzYZbhGQx29D
   oflZkFseiAJ18E0Zp4IP0ASSxLsD7Sk8ftfZtnmuK9qGPJ3Jphrw3LA7l
   e+IsKgIer+MQCf4IQk0WLLPLmhX4O3UVonqqz3mQJAN1wKVKELadrW7a6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="322405168"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="322405168"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 14:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="901088125"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="901088125"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2023 14:14:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 14:14:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 14:14:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 14:14:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3AL9WgM4i7pqdl4QKOH3i0q7HiejOkAza/Wo6yBQwdldVLf4iwDooL/yJ6ZuEo/kun3ob329Q/S0DHqop89iUDKi/MeFWweBBxxDnXH3+FD0OSGgazBQHrHUL0fas6RkMgwpoCQZ1fIerIGNiJ9Y4nz3Leo4R3Vrs9XQu2f1ROjLEstgDMj7RSdaA9DSqAe7aV12yxkad4JIapLomO+0Ks8OhvoRZMcc1TRUI3f83FD/E5TRhgdLsVLaNPLAdn6iD/Zxuc6sGDYSMNb4hf3OcFpu5wwsd5+z37Rg7G1XsN/IFqALXKZTWVH84sj6WQ5/Z//UAo/Jd6/g7em/HlR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyfyiJl7wkBU+X8tY57jmD+k11KTXC2jfiHZ7VYk96Y=;
 b=m2MkgOUMTekdJLWC14GQUSlqRhS5yuZcDBLG+5c5HG+J+elHUrNE9nRtW/4LGtzgEiLFpXkL7ZrJaf56pVezcaeSi2hg6SqIFP3/kTnJvQQHGUouAEoV/nxYyjR6XWFqX46WR8Fc3Wc2LNmvvqbANuVA7Jfdhkyo/Vg2Fn2Lt7pVZSnVNZAnwNsOA6cCjp0b5yEcj88eNNCn+suorcfZ4pweqVCp2487pkZzCUI2mouMQ8g75oVIEOyYrA5p6tCzuABorjxhEwmbjx2ArIbByh+YSUHqDbSSxyZEAa52no+axJx5d76YYzMqtaZtrRhSjYfV8CtP3LbAUjdHx5p2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB4981.namprd11.prod.outlook.com
 (2603:10b6:510:39::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 22:14:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 22:14:55 +0000
Date:   Thu, 5 Jan 2023 14:14:52 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        <linux-mm@kvack.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] memremap: Replace 0-length array with flexible array
Message-ID: <63b74bdc9a6e0_c81f029445@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230105220151.never.343-kees@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105220151.never.343-kees@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e6504b-7263-4d87-bfc6-08daef6a4654
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/a6cZIkC/6JQnYZDWsNC9fftWdy4fCnPQW81JPyZBF65ePU52prGylZUelZqO/eT/xQz1Abe13xNiRT2GzUXhm1QIBv853EzKX3KJb8nLgnbyix1N04MkhKVxfAO1o8hRR7GXLJZQ8n7yVc3xlnpzQI9gHgBbSkyo3E+N9lkFrEQqANo+/bOsp7cUnVC4BP/1OFJeC01Y3t2IPvwD9qYuzQKWGNbT68Jw5a/uuTwzh6l7GOfJFaxup3auP26mR1iH7VIf5QCsF1qj1gwKE2Kf1yqCXP5gRX8wPeAXDuyqRroHvHPiENVIadKSndhbVprCtYlioq+eKQk8KNhUivpoe+CwKLIJx20SV8XTcfT/wdFDH5dt/yrOH4/griC/BbTvI3DB61qd/FSCT7MZM/3QEnC08D/OJPnOeKS2nGB5BaWIExinsE9GgQntWX1XJvgkTg1HoIwiXqLwD/F3zmYBXaggEku4UQr/bjdAsnR08ASSWMYXIbAcq0+29iFcBi4Oxau4G7L6dQzsBQzbKMWa7tE7c2oJt8CZuaiWYVVosWoqGvG/CyPiWsi4ek7wi9zw55+cNilrmuSeWHX01uBuRR1+BLStwyOA0O4+uNf3YXMWMXn97roRZ/oF+EGY7miLjCy3OLLRExGnjCGWuHUZvpwOgZVq5mbZ3XnytPw8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(2906002)(7416002)(82960400001)(38100700002)(5660300002)(41300700001)(8936002)(83380400001)(86362001)(966005)(66946007)(66556008)(54906003)(6486002)(110136005)(4326008)(6666004)(186003)(8676002)(478600001)(6512007)(66476007)(26005)(316002)(6506007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z06wMsH8OMCV12rjL6iTOEvgy3eUWLUZD5hP6ejr3viexLTpJzsTjfxcp9lU?=
 =?us-ascii?Q?mGcLNfkyjFiQaIt9pJFPZ+7KLlvc7Ay6Ya5ogQwPex8C3sIu0ZEcH/QG8tlV?=
 =?us-ascii?Q?aXf8OwCTBPYLy6S9lWgax+CU9uRte2Q8trvDML1iw4lzsNHutzwWSXQCgQ24?=
 =?us-ascii?Q?mbwQTrd+pRb8fdvtynRP9M8nsjjizpkSEWu42br0Dt5+J1dlUFkfnm9u3eUR?=
 =?us-ascii?Q?UJ4m7z/r3o3maWaeVNDcGvXqwI4hXWe7BDdIpZuS9dH+sjXWAT0QvPaD9oJ9?=
 =?us-ascii?Q?j5SMpPQUv4yRSiJ8/iffAF/y3Hg79SR0rRtAxGb3xdr6ONZTRPyzRtqnpZLO?=
 =?us-ascii?Q?w6hNjiLHKiCyI3UGyTXTkMwjAisq9iA03p4pDp7yog1I0dw661+rrkRD7LXF?=
 =?us-ascii?Q?B0/9trXXp1iSUnia+4nPDj5GEri+LcklHGh2q+nl/GrvPtKAC+gx7+ru1RC1?=
 =?us-ascii?Q?Zk2Tysa8yoRFXTzDJ9wRpt5NW9PmZpONrDBDsdNzEhPxEuiXRYUuaiVWDFjG?=
 =?us-ascii?Q?XRFAJ/SqvfF6y+xgIN7AFWlYvxMmolaECWXWEyaH+r4O9UKlWO6apXo36GyX?=
 =?us-ascii?Q?7IVvJWWXDzbUuO9m3Ppnj1Ieo1yl7ePRMHS7lGKd6OVD9gu0Pc/pFIWRilO1?=
 =?us-ascii?Q?bn8hfh/VFrO8MSF68jZmA9/AvzLv2E4erOeWOJdR2MaVrSBEzU6JBkBj9ZEn?=
 =?us-ascii?Q?5zoG7dSL7woO1NoEGHGYCRVwiqGG/Bqe8ucSbUZwNY50dzWbRSaAg7YR3Am3?=
 =?us-ascii?Q?8muRdqrs+KvXgZsWvfFNX0pOUVr1Md18onZWDeq+fukWjGNrpM/SgeWJoPi+?=
 =?us-ascii?Q?lUZ8EVILPQXIqyaS/DTcRNfEayVgUoOig5r+BGf0e5PgPutEB5CM6c0kn61A?=
 =?us-ascii?Q?X01wvTkiXk0vBN9EsFEnTgstUTau3hBGEqTYb4jTgrYVZbCu8/TzPUBQcYtd?=
 =?us-ascii?Q?M13wasOrGbZ6yZLC25hQpD9Y+gRwaCXm+ZF3n5aCw7K4t1hWNP0O7s/QgaBi?=
 =?us-ascii?Q?hxjWCGL7Vjx5IYipJQxZzfQySycmYqElUA3kSkLyWvu+31HDqK/cABLuU3ad?=
 =?us-ascii?Q?CVN1eWcyhab/1oJpcpM9sYB+MKlfBKAS/nfEsKCWjxmae/c8t8Wwx1z4/QJG?=
 =?us-ascii?Q?nCM1ogGm+Rd1/lht3WrJ5dG1UUAzJqlPTwov8bplEolD+mrg9MNpuEhRLozD?=
 =?us-ascii?Q?e8T1AnfCcm+MoePJZBdYnWoET04JDMHj13YtUnMof3RtuiKHTuA4WQWPfL3G?=
 =?us-ascii?Q?D9CrklVp21HSuq9j65fIVcIOj1ILIE9uIChkV8oij3aDyb3RdvumjsHtMv+c?=
 =?us-ascii?Q?x6gZMVDoQ7+CJeYhIZilfuEyQi/teUrCHeB9gdNi+loLNseM5hDxqTNTVdJc?=
 =?us-ascii?Q?sU2QNpXqn8D2vfWisg9bq7pZ87LjlH55kKXAvHSFCDdsiUnm4/laRn6wTSrZ?=
 =?us-ascii?Q?Xwc62pEeEHjXgQeCKufECPxgfKiog6W7F/R4OlAn8c1D+I/FXo2eYYEg4mtR?=
 =?us-ascii?Q?zU3YLBQttrFgpcT9WnnqHyvM6ToM4rluDT+SRTaXVVDFHTlgMCBBI1AjxdF1?=
 =?us-ascii?Q?UN+aiJnyDjdjDRHCnf48OAtOj4uUc84khDwpIyk+d61m8CvjMLtLNQ3OG3Cf?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e6504b-7263-4d87-bfc6-08daef6a4654
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 22:14:55.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh1gxPEErSKpVuSxsBhaw5/0DoKQtmHeRUbioRXyzzpwB7OVJIPy7x6su2qnJ8Vr2ZzGmu94d+hCNyF1T1nY3AY1A/M06xFDg+xJlTnRCTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
> 
> In file included from include/asm-generic/memory_model.h:5,
>                  from arch/x86/include/asm/page.h:86,
>                  from arch/x86/include/asm/thread_info.h:12,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:9,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/mm.h:7,
>                  from mm/sparse-vmemmap.c:21:
> In function 'reuse_compound_section',
>     inlined from 'vmemmap_populate_compound_pages' at mm/sparse-vmemmap.c:407:6,
>     inlined from '__populate_section_memmap' at mm/sparse-vmemmap.c:463:7:
> mm/sparse-vmemmap.c:376:39: warning: array subscript <unknown> is outside array bounds of 'struct range[0]' [-Warray-bounds=]
>   376 |                 PHYS_PFN(pgmap->ranges[pgmap->nr_range].start);
>       |                          ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> include/linux/pfn.h:22:43: note: in definition of macro 'PHYS_PFN'
>    22 | #define PHYS_PFN(x)     ((unsigned long)((x) >> PAGE_SHIFT))
>       |                                           ^
> In file included from include/linux/mm.h:31:
> include/linux/memremap.h: In function '__populate_section_memmap':
> include/linux/memremap.h:138:30: note: while referencing 'ranges'
>   138 |                 struct range ranges[0];
>       |                              ^~~~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alex Sierra <alex.sierra@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  include/linux/memremap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 7fcaf3180a5b..1314d9c5f05b 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -135,7 +135,7 @@ struct dev_pagemap {
>  	int nr_range;
>  	union {
>  		struct range range;
> -		struct range ranges[0];
> +		DECLARE_FLEX_ARRAY(struct range, ranges);
>  	};
>  };
>  
> -- 
> 2.34.1
> 


