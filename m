Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46F64191D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLCUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLCUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:49:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD21B7AF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670100563; x=1701636563;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9j3CbUGau1le5ZzBRKdMzEMWUyi37ZdU7Z69hw8EKbo=;
  b=NxtKlx6vnz4l9U2Ec0IesaNa1pN90A0LE0isqtsWrX/3ufiZk9LE/RwX
   nZVbiTFzJ/WpU1oiRMsGMy6F6/F4XHdpt3upJyJEKwCgPk07NIaXkWi+A
   qEOIHwjbuA0pN1r/uCjrGysiSR3GBj8h4fvkkN1tce+iQiyb4LFc5CWBu
   u5kDZTYUacGFMvaOr5fsA0kIDSEA+tfo+YtvIZBSTlcvAqckQTlYOT4k7
   gtfZjF1JxdbHmp0i9POnZ4GG9AoHGeuKQ/0usvaH+cisFjJFWM30TXdOb
   nqi9sF/1EfQ1hGMIB8tDJtz0wtEjrazXyvsR7iS4Xyp/oE3fhk3fnFQTM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="402422642"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="402422642"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 12:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="734168316"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="734168316"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2022 12:49:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 12:49:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 12:49:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 12:49:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adv/BX4su9I1viTTcQ8PXr+5/pXxUSHCnB29SpBe78YYMpambExJqIiOQSW/pOmrWlkOKG7xZRzdtXIJ7InZob7vRlGu+LfQMqJ54bN0NqbXEormk18E5hE7TsxQKVI2zHHfu4nSj8u1VFax1FLQAhFWOh1snxVSXphBGyspaMRqZ1/XAHOqMftj4ZILiIesb14Z6Fp0fDp7yaheG5EXEMSpJmoVTfNTyuWhW0H+rKyXzCcppfJW66kwG96LQ38dCIF+dYNxbG6nY4DLwqGEpRyjZnqlYNxrSbk1+fOii8cckWy8Z/YICEtmzVXe8j9mb3+X/JHtGGM96AFGTSgWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISorOAJ7b2X1B9gvbXrADqwmpVDl7b+W5BOz6MNQMWQ=;
 b=J+6Cz/KD4E5rm3bzL45S6kCIGtFf+GxzVsSRxNmv4et6a3C4ofE/a1d3mvVBFzLTMlylEHmnKOo6TSZZlq5Usv9H6hSsYuuqfS9hT0TFeCJcMDy5lfLrUj3ADKxtS/13IAChH3U3cmniIERQBc4Y7UWoLNL0QopblVGXeCbtIDyD53Kzs0R73jhL9hy2rG2JjnX4dkbMCJEuj/lCi2VQAQK740EAXiqM3nN59bMgarX8vpYUyUz4vTKcCz0i+HqkomTYEld5nG4pMJdfTiV0QESIwPiAGW71AY2tpDZo3FGMnpd0cO77Yx14Ix8zBsAkeJTAkm300VyauHXi1t+CUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Sat, 3 Dec
 2022 20:49:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 20:49:21 +0000
Date:   Sat, 3 Dec 2022 12:49:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <akpm@linux-foundation.org>,
        <joao.m.martins@oracle.com>, <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
Message-ID: <Y4u2TK4yPU9dfiDr@iweiny-mobl>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221203095858.612027-1-liuyongqiang13@huawei.com>
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aa6290-edf6-4db2-bc8c-08dad56fda4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFucD8eyjAjfZthtADtuoB0W6yx0VY6dlRFcGtvr39ZN86sn1lr8uRWBeym7nOTL7wM2RD/2lbChLCsaM5pu31BVMay6EAi/yUcPTX57pKSRDVlnT3pekj16Ua+p75bxuQQIEyzB7GcUzYNAqtoxnovJGQa2TWYToh/S+h2SxIk3RUwnUo3RSwA9zuWw1kUkAgV19o1k0cZRbnaBEo8pL7y+ZWKRc6KoOGhjKeeA91A55tzQYBJhy9Bp4gmp4p+zNz4jR5VUK31COWxtJ6XB0Q9XR7vldBcqSTmWdKBFRWBejylGuVJKBIJcKvEDQimJUuUFA7hWRFgjn5h4hnGcFxVjwb69wZdKhdoQbSh2kEHScEt/y+8b989l9aqk5u8cZN6Ut56EjyIH3gDdC6R6pYoisiooWlKg9mZ0CuEr0r9owdIQ8dvT/qfZ3XrQbexcyaz4q6pht9yXR0Q5cnOD5xgm2BnrhAeMlOLht/e0bWBrkImuh0CqngGusiVo63bawH1f4Z20LH6O9O2gsVqajEiV7X10OsusjHWPDvuYgsyGA/cBcSTdkjdt0EvSSKgINh0b6oZxbcemJxC16U51e+W4dazCOagFzKG8aup7PFj7g3b7Hrin5KwcY+obqNg5aGPY/s8w6NlLOCzqd0iiGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(82960400001)(33716001)(86362001)(478600001)(6506007)(6486002)(83380400001)(38100700002)(186003)(44832011)(5660300002)(41300700001)(6512007)(26005)(9686003)(6666004)(66556008)(66476007)(8936002)(66946007)(4326008)(8676002)(316002)(6916009)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zp8KQ/wCSOdTFC64r2+Qvcn09ih4duoniEgGoLIfeloym42khe2fc7zkwttx?=
 =?us-ascii?Q?w5KKgC6Zip4v53gRLFB2x9iuVAyHqebqvVCUJHIzEgh1qcgfthE6F0Aj02LT?=
 =?us-ascii?Q?1r7EDrj7ZDOYt2FLqUJbdk4sLURzaMdPMvOXfRG5iUvQpRsxdqWOXd8gDji7?=
 =?us-ascii?Q?am6ZnM0GbZcirMtTHSptqjeDg6A3bUgoEL2cfKRyX5P5Ab5UVEFtLw4e1+8s?=
 =?us-ascii?Q?f+m2JSdEvd4y829UHBlaJ2RiX7DKTypjWtW5lAdOWGsojLTmnpLHkkNgMgwB?=
 =?us-ascii?Q?YLNnG/9GQArjDu7O1JpvgPsUh3CNuoePMSZ1CkVxyd7rwsRntIMXkIxkkayS?=
 =?us-ascii?Q?mmaEJE/dJZrd5ITQ7dlhr203YL3HSkxGBo3kaBlYnQEmfg1JlaVGUtFf4blt?=
 =?us-ascii?Q?AUGICn52C7G8BpZJjMlyHZ1tLWga0Vd2vWFZiRZn4G2KHJ5jkP4XPwlyi+yc?=
 =?us-ascii?Q?N65lDBxp3yxorgaimCwj0qfxF93jZpAq3mmFx67ajo1cGbhoR1/8f+tN/pnh?=
 =?us-ascii?Q?Hy8U7qUmcS16Fn+uv0xADS0k8kHQZLHLuIWi9xwKdiHxnPPxa0B3CwSGSZ4g?=
 =?us-ascii?Q?YyaPVOzJQNeNV8XGavEyL1n/KyAaDmwEDyl5oUazrtINe6eMBkvwFsJcUGqQ?=
 =?us-ascii?Q?AmfE0j1P+d8vASHMh4BLnxYsLWuNjCEZtAUrThKTnj4W2AMM0YJI3qOxomZ3?=
 =?us-ascii?Q?L2QJ8nEBBtimBEGu7Rmab5fOosLCdfcA0C8N4ezlWBYgF/H0xyHesVlGIf7S?=
 =?us-ascii?Q?8xxuBCovyRXdg6prSRuWGwlYy0LIrE7AGepfet5ntlmrdLqzTVBmv7UvjYRE?=
 =?us-ascii?Q?EiGZ9D0pMBTKiB59lvM7xoNerOSSQyJ/CoPsOM/apDJfopu34sL9XUI+1FyP?=
 =?us-ascii?Q?7MYc2OUvFo6Dvmr2YW3hvue0yHpAWo74oBqIcVydNvtAmmscofRkFPhxULH0?=
 =?us-ascii?Q?FDx5NnH9wDFCC5O3ytZHvlgfI4Gh36LjJDsc0N5gu3K9y4TsIAKcZd+2XN3i?=
 =?us-ascii?Q?EQTgWIq2W1ZP6aduLuIq3ldweivjdfuEbMIdfAYwXv2guOvAtDKLxlgQYNOk?=
 =?us-ascii?Q?cRNwUJU5MusaDCVChC7KlE47At0BK7Y+f10OmxoAh1YIRkY5Js1NzqJGExnf?=
 =?us-ascii?Q?QKSUrPQipZ7/I0xNM2dLi1GGROgpEMTW2a/2wXEWfjF40ElM0a+TEPJjxKAu?=
 =?us-ascii?Q?d9fzWv9ZLZEIrorZjtLEtsXgeS+Y2csmOe4iDwTC+yx9g0ih2+OJisxJpGUX?=
 =?us-ascii?Q?Be1N3pDJLRXu91WvXgS0hnx1qOqRb/ZkdTEtpf5ZxSP66tPS7+A7LCgxq1ex?=
 =?us-ascii?Q?UJENaM7Pk/48IGNojXRc9i55SG0ICqvMoitJEcYmngeL91Aj0LUi8eQ/BX0/?=
 =?us-ascii?Q?Lf2LoInto+vcDxrGNv5igcYvMNFXlbbwgRW2He1hURueElo4L4y3K9y4QoFd?=
 =?us-ascii?Q?vo8J4G3pufvDU9/4f1M1pzoxXANagGHz5PeBvF8S/kCX/cIEgGprcHOnC6Ua?=
 =?us-ascii?Q?vD5dnMES3kswd0ptmwmgXCRjTrH5BuEbdtXBY0p10shPvTxvs7wn1loYWvGT?=
 =?us-ascii?Q?1iJodL/sGNEhgrw7c15Ply40lO/Exp8f5WmzwIVP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aa6290-edf6-4db2-bc8c-08dad56fda4f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 20:49:20.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n70Lytf7X3YEaCi0r1KriDdU/bwozhAHQjcfquQsnWmqtBtG3JXGE7EEJgofbJBEvPL61zP0ax50/usSCXQwvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:
> We should always call dax_region_put() whenever devm_create_dev_dax()
> succeed or fail to avoid refcount leak of dax_region. Move the return
> value check after dax_region_put().

I think dax_region_put is called from dax_region_unregister() automatically on
tear down.

> 
> Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")

I'm also not sure how this patch is related to this fix.

Ira

> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  drivers/dax/hmem/hmem.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1bf040dbc834..09f5cd7b6c8e 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -36,12 +36,11 @@ static int dax_hmem_probe(struct platform_device *pdev)
>  		.size = region_idle ? 0 : resource_size(res),
>  	};
>  	dev_dax = devm_create_dev_dax(&data);
> -	if (IS_ERR(dev_dax))
> -		return PTR_ERR(dev_dax);
>  
>  	/* child dev_dax instances now own the lifetime of the dax_region */
>  	dax_region_put(dax_region);
> -	return 0;
> +
> +	return IS_ERR(dev_dax) ? PTR_ERR(dev_dax) : 0;
>  }
>  
>  static int dax_hmem_remove(struct platform_device *pdev)
> -- 
> 2.25.1
> 
> 
