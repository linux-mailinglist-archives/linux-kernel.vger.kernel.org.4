Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA366B8531
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCMWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCMWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:51:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D843674DE3;
        Mon, 13 Mar 2023 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678747844; x=1710283844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+cVChuuiiqj5rstf77aJyCGEfW+hO7WBCTpN7RjSSck=;
  b=etZuu4R/TwFxQc6MK4ltIwG5yd9xatj8zXakMT1W1YaVFZbjDWBLpixP
   THfZ/AduorM/F4b/DrzPHBm02KPgVD07aJiwXuC6btmm1zofJGQ6etxpk
   tSPctX4ZRRT0uJ5ZnRxgErud/2w1rGNJzcTsLG6/ykTriiW3PvSqLhsJX
   rWKAw0caBLlUD1IY4SCnTiNq6eVlF7G7hS+zYuSS/d9VXvz8wpzS8TccH
   5zFiqlL88VbvRoKb/FPOeimq4WYsMCHI7YBktbtXtXjKkYn82XTSw3ZfR
   VX+NYAK5XXawJe4sxQ71zVHs8cE5m9R82Rit0+giiGAV/LyVlpEqiGnxA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317662869"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="317662869"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747766176"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="747766176"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 15:47:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:47:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:47:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmFhhKS99Ndn5nVdKYs2gXQU6KrpvNjVO5ku3QOl6U/W6h6x73brSGvGuxLgkeV6E3q4pGtZp8TIfXEy3iKeFnKBs94B+vKsMIcFVul+vjM2YC2wKVlXxHBuwH/7iQpQXx8Ic9lCBjN9N+tuGWDdcOf/+JWvo7t9hbJ0m/oMpQ4uTke6Ua53FUviA/K0pu2HwypToxvNBrEGKOd8arW1MfI5jJmajcxsVKKY23NhKlEBSyiD/Am6DQIlLin1E6TRMLm9jQAqFlGgiTBbVlDSb4tmOsmqBMYgnbXZgEHzInLdnGgvEZ2bkGGzdlAux4TUTS1RkORIWGe/SW4TgM+Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRctIdSN+k4FkVTGjdfMd7zPCm7f7yRs9bOWMZXvmp8=;
 b=jU3GL+LrjbJdgEYIcrihfcdmGl598FLC5C+e1UHC/A07ZFrbyxAk/YrqFrgcZIJmOgSdjDQlTjxNmhnroX4xwDVW88ymQVhiwYtYjwKbhHCpnf7qhGa+Xf7sb2eP9xjnI1nus7xvht5Be8Aab1omz9rS8NhWGTTPEXatIzkZxgjaPU10oJ2estjv3naGAZRO4CqCawEUIpuDKMMP4XgkuqERoyzweGMXKqKeLEVCXXB9ROISt3MKgt8W7AjBJbf6rt+Zz389xPC2e09/F/iNnFk2Q0JgqYblrxcetbxVl405mqtiKBEUQc3ijuG0oMPjKI0nkhBCwlblx8wNAlCnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Mon, 13 Mar
 2023 22:47:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:47:39 +0000
Date:   Mon, 13 Mar 2023 15:47:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 2/6] cxl/trace: Add TRACE support for CXL media-error
 records
Message-ID: <640fa806f2321_22c07f2944f@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <a77d5513c55177361749a27544409cb6a0c94dd5.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a77d5513c55177361749a27544409cb6a0c94dd5.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:303:6b::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfffc06-20a5-4753-7732-08db2414f249
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFSKqJ/Bl8NI+iNGltj5XuPfFCNKBtKjQFyFwwFO9Q6EASN+v+1zbUCbj7us6hps1f6noA4OCsQxmSOu6oYNK+JB5dk0gtpgv26GUAoXqA5FCUYofuvaLwc0HG3hqhOKomaOBTeQ/0FBgMLJ8EZHMfe4wkUY/K+Xr+H1fWlOhVN8Xei5l2moqE/j+dnNIz2fax6i7v20pdFm6Q9FDoAqDZZFKogoJT9XOmwkwdbQaCwcu6LTEDmFPWXMOrCESWPGOefZr+dAe5a2kFoJklfrunRQ1i7i5dpaxY1zVmDkuR5kpRlBkWjTtlqsPTMAlK/LpuhxiXuXPIkmx9iR4BXUmiVjlRxklqzBfrVP5fGrpZZ7R4U3ICLBVHaCN57wKxJoFhsDa5MQfaN7t/S9NgL/F+dE/o5S6cA7z/Wm0bcHgEl+JyYk6X8A7IAYsbOe+tziKyxP0PwpKmipdTfELsYEbj1jA6O5q3H0Kl4KP8lbv05Ro6ndagWE16RZDsX5AimtxsgexqB2MMmK5KQjBLAlFEfv8GLY5DS+3IQJEisitL1+MIl35PI+IniSiP3CQeOI5QAnQaEWkoCem2OnHfJPZ1bj51lxCj3MppdIWV1N8tprIOPawvaDrqhqNXrNJwuo6h4Bmiej/MmetaPCCmIYDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(186003)(82960400001)(6486002)(54906003)(478600001)(316002)(38100700002)(86362001)(110136005)(6506007)(6666004)(83380400001)(6512007)(41300700001)(26005)(9686003)(44832011)(8936002)(5660300002)(66946007)(4326008)(66476007)(2906002)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rGQr3Jt64M435nIGj3KxwKX5XegBktkzlXdVOKnrOaeJj8MZZENoHmZoCee?=
 =?us-ascii?Q?8Wex+27YyI7tVcWtbJESpkLqxMm9jVxXXSrMnJ6MoG1RtDFOFT9h/9Eg+WQO?=
 =?us-ascii?Q?vUXg//3ne2bAWjYVqV5/TZOvAoEpCjU9tneZ+mElrmnOpaHLm0KuVxqbeRuV?=
 =?us-ascii?Q?v58UCOOLolvLZVcF5792TriykgSvZL1SL9myTjhnBh961cgXH9qLq1TUMUd+?=
 =?us-ascii?Q?5Q/N3WvxDsLukg4fpOGj9UVrWA1kYkm03gylVx5hQoiJK4qWW5p1FbUYFf0T?=
 =?us-ascii?Q?K57qgEUylg7wQNi4+DjqI/E0KQnhQfTsSZls96iTVVZl9mc9RBD62Fw7Vj5A?=
 =?us-ascii?Q?wsOeSrVJRpmd2vSVA81h+aGkknfZ8uDiyiAaaTUZqXntJ05pdeuIwHIH1UPm?=
 =?us-ascii?Q?Hsn7WnMp+pVJucRTfzDOArkQgUzARwPJOKLBjwYwgZLnEbEHs/SWpopxjFyT?=
 =?us-ascii?Q?af2KOhxb/WLBaN3jGqDQDerlR6sWRgnMtULaiLTmSv0r/o9lgI1SkPiigWtz?=
 =?us-ascii?Q?SYjRQTYvhobGaqt4aL+rGEQsZrczTqIZUbnZ9u9+wvsfhN9k61w4Jtrx6N3E?=
 =?us-ascii?Q?JbzrqKc9S9iKW0qedHTNxpJRLAieFBdXTafikVJsOxYb3ISszdQy0PCGoQGz?=
 =?us-ascii?Q?9X/5T0a/DlcMlHAUYLZIjBcc9oYvi+bNAvEY9+Uw3jwfC6FdtANoy+gX7BbN?=
 =?us-ascii?Q?fFI1JRDzPcH7Jc9fJshcvdUU5iokPR58+mMiPW0D3DaRSH8V6JpH2we2Jcvn?=
 =?us-ascii?Q?QQIe87Mj3WnL4yKMnlqyVm1HCGnINUU05wU6hgUKPOe21+uFEe22MHv4I74k?=
 =?us-ascii?Q?nF50gEf/9ysH4/sf3m2jiZ/r9QuC9AcDth7CAKI3B1zVheuVnvvm7BAc75ZQ?=
 =?us-ascii?Q?ADFYsNokfH8THckopWqPBOTSp5tmuVJl9o43Uc0FNySze+pAoqST9zTci2Kl?=
 =?us-ascii?Q?+9W/ONmiZUlnY7YNHJZoO/aEz1eRvDj3JCl0szyWwZxX1ICn0H/9J74FjzgR?=
 =?us-ascii?Q?Wz4gsAhZyFj80+BC6bFpgaltDU/HNHd7ttKMzfSMppzcWvbFLBqlVNEv+cHe?=
 =?us-ascii?Q?33B/XainzXzqRtfDPOPXvseY+g741AWjnQ3rVmRpkqVFaSMjfBKblgmpQUyR?=
 =?us-ascii?Q?R1XsYJTvjgoJ9JN49ExhiIxTPUSWGQQFDvjrNR8MNSnDGzAa2Ku1Yrbj4SMs?=
 =?us-ascii?Q?7SfWmRZjxlQyvWkD23mKa1+3EgpxasPNhKc2feAWQOdGdslUwwEKBKUbM7tR?=
 =?us-ascii?Q?RVZcj2iMsHqpm7T8EOBBM7GR2c2laUL7xjjOSan+vJtyY4aT769STU/OYZfP?=
 =?us-ascii?Q?7mwTOFLSoVVhwkypgPOa7Xk8w/ZwIFt4ooqQkhZ1SgSu18+AxVz+l7RoGgQM?=
 =?us-ascii?Q?7crzAyhxrF9+tb2To2ykiKQeyIETXRTCOsT4D1/b5GEg6FFsq+N1riX4iLC3?=
 =?us-ascii?Q?akqobuzornWHem/QUBtIrnwROuTbIk6N0uinEHWnRbTHKxBVj1zoVGvBJTlz?=
 =?us-ascii?Q?m7oDVJhQeK8ks8NKeVO1+KQqDrlwq9KcxeW4ExTHtRQDW7dVyqgclquduY8+?=
 =?us-ascii?Q?ITmpb3qtQC4BEN6nsJ3AxKSUUPo+8LS3VEMr3sXT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfffc06-20a5-4753-7732-08db2414f249
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:47:38.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmsibvbarmbcvIiY1HsAeYhtKHMR6qYjNc0WZQeEb4UkNXS1v4wtfiWEtJ1HE/Nh8DasfdnH6ZvNzN937utWoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may support the retrieval of a device poison list.
> Add a new trace event that the CXL subsystem may use to log
> the media-error records returned in the poison list.
> 
> Log each media-error record as a trace event of type 'cxl_poison'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c  |  4 +-
>  drivers/cxl/core/trace.h | 84 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0da0a30511f2..77fc811bdfed 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1147,7 +1147,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		if (rc)
>  			break;
>  
> -		/* TODO TRACE the media error records */
> +		for (int i = 0; i < le16_to_cpu(po->count); i++)
> +			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
> +					 po->flags, po->overflow_t);
>  
>  		/* Protect against an uncleared _FLAG_MORE */
>  		nr_records = nr_records + le16_to_cpu(po->count);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 9b8d3d997834..33a22d26e742 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -7,6 +7,7 @@
>  #define _CXL_EVENTS_H
>  
>  #include <linux/tracepoint.h>
> +#include <linux/pci.h>
>  #include <asm-generic/unaligned.h>
>  
>  #include <cxl.h>
> @@ -600,6 +601,89 @@ TRACE_EVENT(cxl_memory_module,
>  	)
>  );
>  
> +#define __show_poison_source(source)                          \
> +	__print_symbolic(source,                              \
> +		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
> +		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
> +		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
> +		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
> +		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
> +
> +#define show_poison_source(source)			     \
> +	(((source > CXL_POISON_SOURCE_INJECTED) &&	     \
> +	 (source != CXL_POISON_SOURCE_VENDOR)) ? "Reserved"  \
> +	 : __show_poison_source(source))
> +
> +#define show_poison_flags(flags)                             \
> +	__print_flags(flags, "|",                            \
> +		{ CXL_POISON_FLAG_MORE,      "More"     },   \
> +		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
> +		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
> +
> +#define __cxl_poison_addr(record)					\
> +	(le64_to_cpu(record->address))
> +#define cxl_poison_record_dpa(record)					\
> +	(__cxl_poison_addr(record) & CXL_POISON_START_MASK)
> +#define cxl_poison_record_source(record)				\
> +	(__cxl_poison_addr(record)  & CXL_POISON_SOURCE_MASK)
> +#define cxl_poison_record_length(record)				\
> +	(le32_to_cpu(record->length) * CXL_POISON_LEN_MULT)
> +#define cxl_poison_overflow(flags, time)				\
> +	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
> +
> +TRACE_EVENT(cxl_poison,
> +
> +	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
> +		 const struct cxl_poison_record *record,
> +		 u8 flags, __le64 overflow_t),

FWIW I made event overflow a separate trace event.

Will this make all of the poisons in a single GetPoison command marked
with overflow in the trace buffer?

Ira

> +
> +	TP_ARGS(cxlmd, region, record, flags, overflow_t),
> +
> +	TP_STRUCT__entry(
> +		__string(memdev, dev_name(&cxlmd->dev))
> +		__string(host, dev_name(cxlmd->dev.parent))
> +		__field(u64, serial)
> +		__string(region, region)
> +		__field(u64, overflow_t)
> +		__field(u64, dpa)
> +		__field(u32, length)
> +		__array(char, uuid, 16)
> +		__field(u8, source)
> +		__field(u8, flags)
> +	    ),
> +
> +	TP_fast_assign(
> +		__assign_str(memdev, dev_name(&cxlmd->dev));
> +		__assign_str(host, dev_name(cxlmd->dev.parent));
> +		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->overflow_t = cxl_poison_overflow(flags, overflow_t);
> +		__entry->dpa = cxl_poison_record_dpa(record);
> +		__entry->length = cxl_poison_record_length(record);
> +		__entry->source = cxl_poison_record_source(record);
> +		__entry->flags = flags;
> +		if (region) {
> +			__assign_str(region, dev_name(&region->dev));
> +			memcpy(__entry->uuid, &region->params.uuid, 16);
> +		} else {
> +			__assign_str(region, "");
> +			memset(__entry->uuid, 0, 16);
> +		}
> +	    ),
> +
> +	TP_printk("memdev=%s host=%s serial=%lld region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> +		__get_str(memdev),
> +		__get_str(host),
> +		__entry->serial,
> +		__get_str(region),
> +		__entry->uuid,
> +		__entry->dpa,
> +		__entry->length,
> +		show_poison_source(__entry->source),
> +		show_poison_flags(__entry->flags),
> +		__entry->overflow_t
> +	)
> +);
> +
>  #endif /* _CXL_EVENTS_H */
>  
>  #define TRACE_INCLUDE_FILE trace
> -- 
> 2.37.3
> 


