Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C376B6FE6D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjEJWCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJWCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:02:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217B5FCA;
        Wed, 10 May 2023 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683756146; x=1715292146;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l+UNmN8mb38J4NITiJ+vzzuM001zxQvIB/BJP5PtquY=;
  b=AObZCW49rZyccjLbV9K5yAqIi3NkrkTen6LKfndt8+ZPqjco2y/71tmi
   XFkid7VO0a4+TgopqlFCPZC6i4dMRqF0zXfLqCs1B6dMd1tgOWpdlFiMG
   51u1udH9KNGYRivfufMo/Cg7PHpu1xknU3qAnwIB9GsHvofAf1IMQp1pd
   sQgEbR5xLrwhxiYWoAQg372sn9CkKpJld1ahc6Efn+ZvNLeUIB1z/A5Ru
   woTEpW/Wuux65s5Q36otKzpvy3Rag71zouqBlUACYKOKwV2oubG5XvFWf
   L/DWkZXiVVIiEatNwK9P8DAxUJ+Dg5mTsxHaUtaLXhecsoqugWQb/Owby
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="350365638"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="350365638"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 15:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="769063786"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="769063786"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2023 15:02:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 15:02:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 15:02:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 15:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6b2W7LjMb3SmqDJzDuoE61o5CCAkm6UdTzpH4XYOpR6vEha/0w+4TMr8M5YFIJ9pv/X1pyOlLC8AU1+6TmZpZDremn+5IBLPuAwTgMEvZHYj/sCB+3MkPZ3plUc2GULKPMziMI16Gw4uKGxSY1OMU16R96BC9F434dp9tH5P0KhH+6SiPIvcliH+q37re8gIPlcxZ9ZrVEn6WhMY2o+3HL/QqzUCPBcGbKAPC3r/Pqi/5EGab/Za1IB4JKOi7KVBvVQoQbR2KC3zC8rNwaRwcQshzVVYsfo/ZHN7fzBeAo1G5JXdKrP8fhZvArKvpxQQpbASNvuorh1hX+5Al4lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shcsCdbiSuSwbFhsbRUuJOXieyO2GE7tSAb36qjA+xY=;
 b=XdnFI1AftKKYmjpjRo26MpNAsIMYjcYAcd8s5Po+3XLuwySkorQOjm/xJaUT1rx1Kl/a7mjMJAec/2F9+rvXFUsDbtVCETjOIaxGD3xl7Cq/jhXhEoWVkW4Bm+c9LN8FB8tHRbv4tQ6I+wl4Ojg95hj2DoSsUMGVPgqWKNqDmVEPZRE83Tk69sEleCES47smAVrizoJKL02vdFpBEnGw+/DxOqgz1gXrSa0wYjbQ2WrlokgCiXStRrB7U7FR5V8jdx7c0vLRqZNPgEvKouh87+Zs3Ucy+DJInDN6DPPdue4FSGOQhaUF5zQnpTuR6qrDpoKjqIUcSNDi1/TQPTes/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 22:02:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 22:02:23 +0000
Date:   Wed, 10 May 2023 15:02:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Raghu Halharvi <raghuhack78@gmail.com>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v5 2/2] cxl/region: Remove else after return statement
Message-ID: <645c146ba238f_91698294a5@iweiny-mobl.notmuch>
References: <20230509165218.139568-1-raghuhack78@gmail.com>
 <20230509165218.139568-3-raghuhack78@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230509165218.139568-3-raghuhack78@gmail.com>
X-ClientProxiedBy: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: d28c8a9d-6d42-47c9-9eee-08db51a23bed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/XNV2JI2HvL2Q20UlcHlU4yvZ4hvCh9BWNULDc/wmO0NubjuDPhUZvk5opssNLYM2Qvx5FOo4Xy+bgxdyfJwSGmv0vT7IIVeLEtFCPcUq1qJS/dj7L1/hgbTbABNVeO/ZVyxMr4Ej4BnuH6BuG4H+4lL6SJ6uJrNra1mF9bZjY40Dpf10VhVTkmQkPjUkeYo2KsVHjTKCRRLFwrYkaK/KiKb/McTTrHCX3t7Yvot7IUsINljz5shsX3vpaNV8nGLWI7Ss18d1Mz/gFtmnvigZLvEh2ydt3zmth5mLi9DbO9gSqoKXvsoxOERf9QXMm6cYhGp0sCGOf09dWv+WrECvBpAF7lKK6X8WzTXMY774nQwX6YRYZuGmncJLE3h7pQhzuNfJ2kPt8wRl0LjlmbRzSmIBgjExpwARStcIZSibwvhjaF92sLZkH9+CLc7bPUDJOvsVU1LIoj8ni++bf+QpHhhTbmMsf0bQKDs7fbWu2hi1GKISeddgEiI28+SI319IfKEd4Dw5FgRMD8i8KlIaasn79YvTvcqnAJuZVyKbFKo1Q501jdEPg11xwtKuBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(44832011)(8936002)(5660300002)(8676002)(86362001)(83380400001)(6486002)(6666004)(110136005)(478600001)(66946007)(107886003)(41300700001)(4326008)(316002)(6636002)(66556008)(66476007)(26005)(6506007)(186003)(2906002)(6512007)(9686003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XSIVB+DrpOVTuJnACKfIxevtB5lEwGDqVDm4ByOpZI7GBUKFOXIJ14qxhvZ3?=
 =?us-ascii?Q?Ogq01bqWfXNibfxTw10ldZuXFlv2gnCz9i18T3gSOK4lXoOpBgGqNGUNmAeX?=
 =?us-ascii?Q?eGOA+KMfE80xuo+dJSOoujKZa0Tc2QibfbUYXKUeCLvcSwIwBYdyKWIKLjBB?=
 =?us-ascii?Q?rHm9vOKvecgLgn8b8SBvD0vqnoLYAgiC/PNcN9oyfhG5TrzK9GsRrgasO1LK?=
 =?us-ascii?Q?R4CjJ7KtlA+8bBvOXvqzM9bkCU7IIajo+fEkq/9YG8s92T/5sWx6gVGsDxcf?=
 =?us-ascii?Q?GQIjN/Fq9eAArUVZN6i+JGzVJU1fC677XDrluQQbZBrqfG0vVimCYC/3oOpj?=
 =?us-ascii?Q?L2ZX/raanZN5stVIUJpK/nmJ6XHplISBTsrIAK/QI3MpJoP0kYZIPm324V5X?=
 =?us-ascii?Q?QWH7FIThlbx22lGN/56xgV3rZvkh7Njbfg5tPq1HcjI69bviNCrRq+MxEdE5?=
 =?us-ascii?Q?SsR3Ji6E8DLmqLTsiO18O9Cy0vi5aF33GwIs7O3H/VhCIJWXSHFtuQql0MaF?=
 =?us-ascii?Q?u9SzSaxfXt5ZFByIQo/ZxotKqcaNfc0bjzkq/AJmMZOQ6/WYlRzJQoVXZqyx?=
 =?us-ascii?Q?8RAg0CWGhnf0On8Co6I2e3sfjtGI2E9u10J9NcsRZAkegebE+Rm1qHcXFNXc?=
 =?us-ascii?Q?WnYeitlZ45Lnq6Td1GSkou85oJH6NUjBP/jO8SKekPME35gdO+WcCb1NZaJM?=
 =?us-ascii?Q?nunI68YgofiXUrHnwsKpHymblZ2i2SnSzF5M5VDTmmWcGyow4GqqXOJI5zRc?=
 =?us-ascii?Q?BPAKcO4nbCEOPWKwFQRGW63YtyeDg4bPNTNGDqPZFRM4ldnU5HMOrBBvTqQ7?=
 =?us-ascii?Q?AgmZe8bkyK2V5bMlMHMY5w+pndZ6JO065Sx2gWCM5fIPUduAmn4U7sDJ7jnm?=
 =?us-ascii?Q?t/ozYCnKXF+jvyNNV+7+TfsNLvne8bOYM7omqV8DKgyN839tHZud43OGCPYQ?=
 =?us-ascii?Q?uM72IGzITqqS4lhvZQajYp3WDMJTtLJlB6Eq31Xb5u7kv64tdOcS14GJtDah?=
 =?us-ascii?Q?9T5puzxRM6wgnxGfhUHbv0y0wTlTu7Je/ogyD2RB0DA92rLGLyG7hFmb7M6Q?=
 =?us-ascii?Q?+zjuR8/3AMFXNtXb71dDlDGvZdStL8Eq4iHqspVvhQSxLwUOosRjI1ZcBfy6?=
 =?us-ascii?Q?YyBEApuS/DkWtztX+E9/4VUK2Hgqbk5Bt7buj+E9FfOr7EJO/e854GRZHHsq?=
 =?us-ascii?Q?sNVJG36KqAL6aiDjUmh+yy5w2IyhxHozc98lRyHlaqZqmE/onqAH/CY3w7lD?=
 =?us-ascii?Q?pUja7L2lqf5hvhUWhrqaGaYgCFfN857H1e/+iJemOj9TFE5T0Uc6306uPn8C?=
 =?us-ascii?Q?YRrDb5qbSvSAt3V8G07TvH85PLjsBuvCEoD5jotVWeJWkY1e61Zr01xUGgTJ?=
 =?us-ascii?Q?hDO+wyA52PLrwVXEKDjwxvFOGNqKst7tPrrSBpBlBy7pBRy1szrDjYICXq58?=
 =?us-ascii?Q?+KPKs/qKMqyI2RnuIdvnPGr90LdB9AnGgegByUlKfPxZDK4Vh6vmn3O/sAkH?=
 =?us-ascii?Q?lI4HO5Thz5xGfAKlO/F9+Z1ImO0epJJKLrQ1lNnlVTg5mNxMcpog7BXm4jk5?=
 =?us-ascii?Q?iBBLluWCvhf+hsCWewEFG8ChRUejae2CdBxrn1vJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d28c8a9d-6d42-47c9-9eee-08db51a23bed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 22:02:23.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVRz0271Kk8uQ6heelyreLV2T1hRfh3p+Z9iz1O/hzMAM8FSH3HeVQ6vgwljXrOyMnSBHioj+mJ0Mu1BZ6v45g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raghu Halharvi wrote:
> Issue found with checkpatch
> 
> The else section here is redundant after return statement, removing it.
> Sanity and correctness is not affected due to this fix.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..a46d6ad9ef0a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2666,11 +2666,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>  			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>  		}
> +
> +		dev_err(&cxlr->dev,
> +			"Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>  	}
>  
>  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> -- 
> 2.39.2
> 


