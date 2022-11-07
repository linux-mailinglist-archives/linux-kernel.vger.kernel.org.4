Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCA6203DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiKGXko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKGXkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:40:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467F140C6;
        Mon,  7 Nov 2022 15:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667864442; x=1699400442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dqtp+nWfa0U/xS4yWOHV7E6ETGxyRgk2P0kvxmB5OUs=;
  b=JzCQeI+oT/npGi9qCaSfguL6MPkNxLDbreT9tsvIk+7oB0jKQG7AW1Bb
   imz+zNpPrRidHBxnmi+Tgr1aHYJuPST/X3FpxI8ZMv3nIQri8bhr4S3YO
   /9EqXWfCqvCIqcVfJFfuOWAnM/MuiftJNj8O8bbLFrDX3yKkS0hSMIypt
   ya6CGYhGDZs7sG/JYyO2nLaR/L8wfZ1zPncPrHa7JxASAPHb5CxzErPHt
   KkfWCuqU0BUUKl727m2spoX9YltVzodGc6Mbke6AjUZIuI7b9IbAeByNy
   9HnNvQ2AO8j89mXv7QHT1xxkL1bHVCMEBM2a1wus/UShJB93UzW7fROYb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396849907"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396849907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669330425"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669330425"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 15:40:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:40:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 15:40:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 15:40:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyIy0yGw2OrfTtsj8fynqjR7piIW6qdJywqW6B7shcvLgDm9GSRQvNNJXQyRkwSQj1QKUiRIi7+IggMK158RpKrYYtJ8zCYyh/d7dknLP10lbOTz59oAMxfHvtRlC3x64l6SLvQnEy1L9G2lXLbLeZ5+O6SG/iIAS9Hb5OWR90WSKufJ4qyBMhER4Y5VUrNOUpzgyf+IpmXVGH5u2vc6rUq0pWfkCUFxqtswbiGobkbF1uPlXM2pW0bIrbzDTakqepaZ4tbto8vYFWHJ46Mc6+q2bePEtk5b5AiOacK838ndNA3JjxkS1LCPFd3ycrEyr2t7QwDsVVWgtSE4ojMR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHxboicUjyPVJqFpR5qFSTshU27C+SHzhhDuGttf2nw=;
 b=RtUHPnuKSocSPWhyLdMhxCj5gkIWl2wjFAsm4NqoniiDxQ9Hu6ZUH5qXXHbATutKgvwoAIuJfi9lfNtmJElwSWlPCZBblmOOkhPNo0UV1Gb9fI9+1w4HjzeH44A+Vf2/uNKa2kAwSaTro5h0bXote8IbkcAlwCsDgIJHHdUzQdQZtlJxVyjpRTWLn4tknlpwUfih7rYoIKQI+uLGgINxI9MP6VparFIr9/sO+Ppy40ro96a2SGJ2KrkH8CeHqbHnPOtIKFalKsw67C6rN5W+6xXQjCLHXWVVZ5aRKnOqutUCfPgNQ1SQolZH7wXTZ4Xp7NeJe6d2fLCckdTgimZh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6227.namprd11.prod.outlook.com
 (2603:10b6:a03:45a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 23:40:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::11a0:d0ce:bdd:33e3]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::11a0:d0ce:bdd:33e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 23:40:38 +0000
Date:   Mon, 7 Nov 2022 15:40:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fan Ni <fan.ni@samsung.com>
Subject: RE: [PATCH] cxl/region: Fix memdev reuse check
Message-ID: <63699774d1af_18432294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221107212232uscas1p20a000834b76db7a7e459708b06638120@uscas1p2.samsung.com>
 <20221107212153.745993-1-fan.ni@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107212153.745993-1-fan.ni@samsung.com>
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ1PR11MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dede30a-cb7e-413b-e206-08dac1197968
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1FrX6MoN2QJWhPuF9/FU7C5hYrNxPkZ0+Gq3+VfMHsU5qqZFkiRFnOiUFZmeDDbiuQy9Cgf675bIoWdi3IMh2/FP7SD4GLQeDrAiLTZFAjmFiWJFpPrxL4vVxufBxjjVDOTZpEFKBnX+jZi5oUs8OI6nEsMOr3g0WTBc6gNw4igo9dMEUUbkWeMNDe20v2qNmtD2OYU7Cs8JROLxqe0KNhFTgvwA8kGXLx4wH99AdOr8GUnCUzcjH3aBfs1T08LCrvjRKPNaAbl/TFoT2G+31EIVdPkAFepLJFRt7Ga9dnal1/UQK9E60qb5my5daS1BsT+6ELyPMW1YM91yUFDMFkBFj5sJckW5gqDhXEdED2o8FDooZ7KnFPrsPQCIo/J20R95ILVtb5oNRFn9fZbc53zMpFfJCCCd9bnGplcsSRnS0U081KUH36a8P8MW5/XYwlbSQ9+wizztdDk3651QAaKpdHlYylApyKv9hwGXDsjF5ure4Kyyu/KvrQREf0FPOsPU0V6s52LH30I+GK0YzerSGv+MZPWF/QWNERlMLNVyTCO4as3yXgvEKa2oXq9dadcttRAHs+a/B55C0W6ML3WO9UQ2lrUX7EhAylkSpPT5yx8paeVfjFlyvi7wHrfG+uvjQHTKyelokLU0rt4jdkuqG0qq8qItHfy47n6vF040aPsXSGnoKhnW1N9//q4UnjCIhq5DywnCdk8NVogFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(86362001)(26005)(6512007)(6506007)(6486002)(9686003)(478600001)(38100700002)(2906002)(82960400001)(186003)(83380400001)(8936002)(110136005)(54906003)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsgvIwhqGzuttKK1G3pXCUQTp0LTuFiZjqJlDsG5m/2hh0eaEueP+FjEY+ea?=
 =?us-ascii?Q?dHTwOUWLYYI5fIYI9XY7clbXF6x2BtjFiJa/xEu7VqWaaaKefSjROhCiHGuh?=
 =?us-ascii?Q?cs+Ohcw+LqjiF8dHbGSi08AeTcQkLzVE/dpcZoCsbvcDu18n8kIGArGkg2Xy?=
 =?us-ascii?Q?0lHjngd3MjLHpOd9ZypqZk6hhbiC283bPkjojJUxBQ8wpDAxPA2XmQO9pCJX?=
 =?us-ascii?Q?X6xone7pqg8sDWb7JnKsDAlBz38JzlUqPU6TyICaA3mdyLjqvuZLK/luvNYC?=
 =?us-ascii?Q?CsmlqEsXXRqwfmpdzTmj3SWk/ica909MxM4F0IaPePs9Xs480TTqnqSLKyaw?=
 =?us-ascii?Q?oPrAHBaeybdDBIXnIlDFnZT61osdZcoY4Xo9xJgJOdV39k957okdxUEXUBI3?=
 =?us-ascii?Q?DDNeRB8l0X/8ojWthyqTTg8bzcKVXnCLJ3yCD3leb3OHD49dAzAHEiTLgO1A?=
 =?us-ascii?Q?4FUfMJ5T/V1vao6NgKfpEW0K/JG+SnrDPZCI/7PGtYDT5ghxc87okdMJq+g+?=
 =?us-ascii?Q?zu0R30PFY+yXgaEip6wRmDcNeQHhtre0+mtWGskkQsEGB/wQCRJDO5W7EI3m?=
 =?us-ascii?Q?ix8pPBG68F84VbW070a0hFsHDnaNLD/TcxTYiHAFdyZLNdt60Fo54/gq12Ad?=
 =?us-ascii?Q?aEN1tKlU9jhL/99i8VjOhKpAAI93/DW6BjPGGqNBQAea+xpxhljaDbR+O5/m?=
 =?us-ascii?Q?TuxMBnNwc9bdxR3dW/8k2tO5saQVsQnin3fHYROHGU68ZB99H1mK7bpUNc4n?=
 =?us-ascii?Q?mSL87rvw4RpiVULQ+2s/PSaRsrMck46SzuCP6tZ5egY06+5K0k+vkc+ey0Nb?=
 =?us-ascii?Q?2Et900DHjUdwuIjESC0DO25D7iezkmOeYVP7QPx5hK8FjMcsoGqc0E5D77yY?=
 =?us-ascii?Q?33yZbuIgXn+okMFyFclvFkNWoMeecVlSHowRQf63wfRaOIyb954408OKdnSt?=
 =?us-ascii?Q?/l1agE+IX6xBvKlp/L47NpAFGiA5CVl9/lAKxyhtkv09fwZtrxF8LDq1yYlb?=
 =?us-ascii?Q?u3z78ShsA6HL2/58f1/7Do5hW7gDtPfJqt/HyViArTPoeZAmI0z7Cujf3fDm?=
 =?us-ascii?Q?mCp7DVXzg5CJ/tDzcsCQaATtD7tXWzVYD6Z6cIMFjfO3YVwCId4L55GUKnkG?=
 =?us-ascii?Q?V8KQQ8XS9C1ZnvKhYWp8832FNLAICf9RTup+94OXSenMyfAsMjOUK/qKRDgP?=
 =?us-ascii?Q?3VYe+VfME7IJh073GD0sv5O7nC64Ls0hkkxfyFN2IIyCf2/CDNkdFn+K2SLK?=
 =?us-ascii?Q?F69eY+IDRaxZODkGDaCQu44NhrQBuAnz2pSte2OPUp3oZXpnL1XG4OG6yjVZ?=
 =?us-ascii?Q?AD9mXz+aL2fZjI/7mngDaMGXLu9yaKUGARjsHKQ0uMGsh8QTl3q9Gor/43UI?=
 =?us-ascii?Q?hDMtUuhPFx1dgaUx2828vEP4XseNxd2rlfHUdFfhaCVHdxxm47Xmb9XOhX7I?=
 =?us-ascii?Q?xf2q/4IyzMkKy/2cy9BXGiPzEJjev79a/w7uCs0XL30nsBeKskg7NYVmj/Vs?=
 =?us-ascii?Q?gW14NG/ZYuistDS85eMzgaarBGEnVYbE/6br+erl3iB1ks8w0qQkQiv2kvmr?=
 =?us-ascii?Q?z8MJMp3cNbEn25NgqFiVsoclnhc8leuhW3yyZXBaOX42qau6lYAiTDNGlVXe?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dede30a-cb7e-413b-e206-08dac1197968
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 23:40:38.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZfR1sCpJNNje9v0rhaSfj7ZkqvBNuAq9Hm6KrvTEZoRdA11m9HkzwDbS24zV7Kpwv10G8K5lFX+5c3Wr9eqGqFIMb0jRO9qFxAN1zwhpi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fan Ni wrote:
> Memdev reuse in a region currently does not iterate over all of the
> interleave targets. Fix this by using existing iterator for memdev reuse
> check.

Not enough detail, what does this actually fix in practice? For example,
if an end user encountered this bug, what would they see as the
symptoms?  I could probably figure out, but for bugs I should not have
to, and more importantly downstream OSV kernel maintainers, who do not
have the same context as CXL developers, also need that information to
decide if this is a fix they want to backport into their kernel.

> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f9ae5ad284ff..c7152b4bd9eb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1226,7 +1226,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		struct cxl_endpoint_decoder *cxled_target;
>  		struct cxl_memdev *cxlmd_target;
>  
> -		cxled_target = p->targets[pos];
> +		cxled_target = p->targets[i];
>  		if (!cxled_target)
>  			continue;
>  
> -- 
> 2.25.1


