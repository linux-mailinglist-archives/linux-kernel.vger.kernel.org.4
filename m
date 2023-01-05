Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052965F244
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjAERJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjAERHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:07:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B4B671A1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672938238; x=1704474238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WGsLEEJNqz+irOyKr5WCgOERgXylDgXa+Ae2PSBcdgU=;
  b=N63HNgSiDq5O3+15tn2q8aykON6/t+WTgriLYdyuCxwbo7gvcoACieAX
   6KR8kYSjwxanP3Yn5ahzXlep5TBqNillFxuiMg3uXEiWiDIYV/ryRv+2X
   tQBaPcsMqjxsKCbfnrZMoUzS/EuHFNfNncZnBa2VhZegiwjjr5xchpPBJ
   BAF6p12lm+JbQY52Te3QpcaYfK4PnFLEUI1BovACsIIX18yrvosgusv9M
   gEUYpLV3JOrj4D5VbU57JW4/oNj4ucOYRL/rV1ChnSn4ZzNEH8L18If32
   M+9sh2Exn4fyUnUaWgD/aRcGh9MLBhpBrVJJQrNGduKw56vzfymkGgekD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="324278832"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="324278832"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 09:02:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605624798"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="605624798"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2023 09:02:36 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 09:02:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 09:02:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 09:02:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5VqFdZGHLy23/Ksr70KwN/gE35GDQQKz88PT1VZPC/4oRrnnYo0nvINZxdWU+VGFpdzu4b2mFuk8ln1oNRzPgCyHGmgYiW8JEOMgtT1lvYqBRBwVDRt34ovSPK9OBwXfz9ubyVgsGMcVf6Nps/UmcYVhsdgJiFRExh7rhbDqavMK22m4dYvnDVpOC/cS6j2hK4RpAZFeydJkIBXRXa+T1+93lNeHHlDkvtOyWAuuaehnxJTBC7NWGu6rvQL/2IDvH2QQserZowV58RFZDpuB1iBkU34C3Yr6jRQXK5Qojymzj+S+ZHs8MxjuOYwwPDrkTeCmdgyknZZsylFjipD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hBuA6QBzVy3PxbvWepJqx4VZR8patAoeQ81PLACVtE=;
 b=N1BMOpA6WFVPrUKE5l/qCdaWVDHm9F79IDa8inpW+TA0iBuh6dTel+TlCk2gC0/VnYUXWJBfNjfJfVZ2U42A0uhv2XwDWeWpH9FRjsXnXNwvNhSNK5VA02fyK6uZyTagvbuMsCJrG4FCIrLkQHQj241Rn7p27iAKDTm9LCBfPXn8wG1NcqCFeFDwMUGZj2njhjIZCVwlHzyCqdhZ6l2DeKLvbCoBJslEbI4JitR32p2dIoHamDxIwxPRrsaOg2OBTLgHBBEIv5cmsenKdmoeWx4le3/GeAJWIbH+SznR+BOUicMrVn9umOxlTQ6y2leS2uz/5Vl00SWzF1qp8FwxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:02:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 17:02:34 +0000
Date:   Thu, 5 Jan 2023 09:02:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Fix two spelling mistakes in highmem.h
Message-ID: <Y7cCprZBVrNO3aZ9@iweiny-desk3>
References: <20230105121305.30714-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105121305.30714-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: d2281425-c49e-4d6f-e2b8-08daef3ea408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Tv4wmcB07TUVBlyw7ljjHqJ3HM/PQbOn+8l7U/wz+yeHkMK5CKy70qR80ImrEqswbXdSJvDoiKU0+xbAYjUEIOwbKrHuUvavvsbiyCRJCqwn/pS6SnD8m1BrPBqmCyfrx/WjIJJuCd9xVhEaED5BUtIPNPeW58Kob1I53NG4A3oNGFMSkAbtmVux+TeJYg0Q8FIjA5ejZNFVKz4XwBdrHF5PWGFL9T0O6KqZdfNmzH0eTLrtbnckXxRXTWs6Ckj6YOkJmvYUjbVKV048UzUg4nelk61xX+NsqusJyeyQ7FRa71pYnteGHpS+vfky42pA3agArFlWb1J0GXasn3NZhm76oUdjXuZlllNlcIY/lBHhzyEvA6GE6Nc1p6zgChqHvHjFQ9t9iUJCW8tUkdYnAsAlgnvqNQP9sCvGPbBlrZo9IVd68Umxse35TuwIgYaDomWVR7MfgjPCAtxzqQwFnvTk3unQvOlv+ahxA8C8gSnUTtlCQvQxcfYFOfGn+hNJeMadGItDOQUSFcw2R1K/0VCfbLOl2jJQzyaZXTTJGxazYnRbzNIk61/MSLkFgeAKsRcdN/HZLrCRR54RSjSYRh+P9tk0ZwMO6RPQ4j7LnR7QrnlwcVl1Yk7wPcgEr5EbgRWo0pTzjivkIMtO53qbpK1MfuxNp2MFaZGkeBiMmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(83380400001)(26005)(9686003)(6666004)(186003)(6506007)(6512007)(86362001)(82960400001)(38100700002)(33716001)(8676002)(41300700001)(4326008)(2906002)(8936002)(44832011)(5660300002)(966005)(66556008)(6486002)(478600001)(66946007)(316002)(54906003)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hIxHlKqZEJkmN9VFk3EqMcMla1wvgUpEkHJtO3Q09M/4XwsB0m71pE3tJcg?=
 =?us-ascii?Q?5C42s1XlGfnIEe+mtt1SgfiwiEB8gB058HT9BshAFErjBV7HG0nxlZXR0VvK?=
 =?us-ascii?Q?b+6FtXN9ucn41T+O+YcyreuKMA1gOdKkPlTGTzGxmdl1ww6HdUlO6YFfkHQQ?=
 =?us-ascii?Q?oitgTucP2k/QsqPwTclvkwCTVlrkDKEabXDf24qsKJHM4zNoWJV/I9uk2Mow?=
 =?us-ascii?Q?6gp+OZH0r8Yc+IT4FPqXNUELzkaYJGd6oBnwJo5H1UHbJMw4WzJFDmYmhC6F?=
 =?us-ascii?Q?nrU0VmcF9AUkl7w8HwLcDJfB9h6XrxwMikga15NHQ76x7Cjf1v3+ht4SKrLG?=
 =?us-ascii?Q?I4Jxzg+mqSqjG3dwgYGBtlK2xWUCjC1/GuNaVmDFdGtGTxYUG9maPWlmm4Ft?=
 =?us-ascii?Q?TkA89PrdsC2k+rQnGc29CkAKB5U/xsTRyIN5PQGSwpGuDBo6WOICshO4HCdM?=
 =?us-ascii?Q?yMJC8sAM5HQoT0vGyMl0dOLXBZ7sOnxh79LL4afqIIQ7sxvfHgYPRqXB0V4o?=
 =?us-ascii?Q?ejPq2YN3rheCjqB0Nv48XXa9BzjtKS/6jKcfgwCZotsVj+Il7a/Pl2A4QznF?=
 =?us-ascii?Q?QPeQhK+2tCZ0xyXarlx7L+JoJUabicW9IxWz5GDK/QvBfzIIF8C2kHdnDGd9?=
 =?us-ascii?Q?p+qLsPXOpV4kAFkN+FUEnYVAezrcXIcDNDZSYnpDy1mxh+AgBCXioLRdbNy4?=
 =?us-ascii?Q?VMDHOCgvRAQTifK5r8a30lFdVNletVlFvo/fNi9Qj1H4W8jKbtaYmZyNVEAL?=
 =?us-ascii?Q?hTgInOOTlwSfHOh4WCLIJCX1TRPhoG8pd03NwggfPE4GlXJNJv3SEqpcapvA?=
 =?us-ascii?Q?nwhJ9qGVGMC6bnEuCaOL54gMAv8bGn7Yn0KZXqUDK4wmg4U7ttQlUljQAYX0?=
 =?us-ascii?Q?BYoR3QYohcFLgzFNhufpdyG8FdhJxUVDDzg+m7Y7KK/Wyh24soAtHHhMfZyu?=
 =?us-ascii?Q?Z7WmZmZsW9Qg8UkACkrSXaKN3cukxKLebhJ00blEx48cCtJid4XqQ5M56otP?=
 =?us-ascii?Q?hwDMABJUI5brU1XgHDWCupAiaxlM0/b6b474vd+MdzzvZJC1SR2ecI5gc1ND?=
 =?us-ascii?Q?vB7h+Z3rwwnsKF/e/Nq2Ptft89VDLMXa2G3CSIPBCIVqCNm8uInIwO+jdJB6?=
 =?us-ascii?Q?ettEZ+3CZVuXAy79JvrHXsbgz8h6OgZGgwkcXwSefIoGe3P8gbdSzPjJYWSk?=
 =?us-ascii?Q?sclWc7IEVof87ocZefCjwLAME2LKSngy/YuHjugrNmewK4sp8I7FfhupQNgL?=
 =?us-ascii?Q?46qIvANpvpsUzXUvnV3z0P0z/uwuX9JlD9oXPog9PoC9wGAwOvGkfGiHodn1?=
 =?us-ascii?Q?yQjTutIQsTYvrxQlH2zr8OvmPbGF9J1usqWFPFvUGYv6nGJLnQ8SmDepTI8Y?=
 =?us-ascii?Q?DwNWNUvXiEjGwOkBpxj8Tt4LbvqISQZUhpo6yR54EJjW0TobKweC2Uxvpe8Q?=
 =?us-ascii?Q?lxyipALa6nsWZtsEAmyEHHetlBEn9g9XmDtzLc21rvRuZwv1/jZLResWZAhe?=
 =?us-ascii?Q?/Ce1PdNOANrib2ZqvgheTdODBEVyMdPVw3H9ElqM5VmjGU0tGDKgSYSjJM3i?=
 =?us-ascii?Q?iTc2Dt6wouMSts1I8gfxyfCV4/xIFFuj+M0vY6+L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2281425-c49e-4d6f-e2b8-08daef3ea408
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 17:02:34.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i26R7BwswE4i0340y9b2j+3XmrwSztv2dT6bZ1W15NSwoytxEXwbcd5vUSBbUx1co4SpbG6WyKywr5wHwv96Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:13:05PM +0100, Fabio M. De Francesco wrote:
> Substitute two occurrencies of "higmem" with "highmem" in highmem.h.

The change looks fine but for Andrew's benefit I believe this patch is based on
the other one you submitted to fix kmap_local_folio()?[1]  Is that correct?

[1] https://lore.kernel.org/all/20230105120424.30055-1-fmdefrancesco@gmail.com/

With that note:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 7b0085a61e67..ae1670ccdf45 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -86,7 +86,7 @@ static inline void kmap_flush_unused(void);
>   * virtual address of the direct mapping. Only real highmem pages are
>   * temporarily mapped.
>   *
> - * While it is significantly faster than kmap() for the higmem case it
> + * While it is significantly faster than kmap() for the highmem case it
>   * comes with restrictions about the pointer validity.
>   *
>   * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> @@ -119,7 +119,7 @@ static inline void *kmap_local_page(struct page *page);
>   * virtual address of the direct mapping. Only real highmem pages are
>   * temporarily mapped.
>   *
> - * While it is significantly faster than kmap() for the higmem case it
> + * While it is significantly faster than kmap() for the highmem case it
>   * comes with restrictions about the pointer validity.
>   *
>   * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> -- 
> 2.39.0
> 
> 
