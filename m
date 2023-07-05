Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250F748890
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjGEPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjGEPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:55:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A915173F;
        Wed,  5 Jul 2023 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688572501; x=1720108501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1U0ehJCctb13awsqcZ4gpaHik9Hv3PJO6pvZOAst0IY=;
  b=Gv0cR/qkAtyaJAC7OeW3U0DaKFGT3h+Dyd5SpxazSLxNyIhx3otygcsw
   J6Y2DOPfnaKq3taARyI2KJTfiUOmYMchvQhykmTJ0p8ozcLEqPfmWAV4e
   ck6rO3zeI+j8ww3gZoyn4pHfE66f9ylEPbo7gaiSXn0t0iVZTlnIxvV6r
   OGi6QyRknzuJISwQVeNEYdFNa64X0csnNq+SNbTrRs1crat1Akw7fPzQK
   bvzRPbemvs4eZPkIa85JI15FtxgQ9iw5S+gj0VZ9P0Qri9w2ywPusxiKB
   gJ86EZ0+IhdGF8VrL/BY12sjPRC1Lb2m42HtLopQgVbmg7HvnQ9uFVpEd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427059950"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="427059950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863772636"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="863772636"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 08:54:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 08:54:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 08:54:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 08:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO518zB+Vk3T3UeHQK0weq0vti28xicpOgQRC220aXgmojhaG+ZONWEc5clIgv8VOgFcTUlPApnsx/x3/q4gNsWRjcaa6OoT4LWrsd8i3p0DWG6nmgoSUImU1XlZMpxllAmZfGgroizC3cNXxTBtqsj/MQGQKmKRXt5ivbfy1Lal/uc1MyJSmaB4er7t/DERFADbhTIqngW4lQeu9mmXKkq0OB5fx6oX1XsdDu2vYj8W/UDq1ktMy1DLbH9cTne8YTteF6nfn3RE8MJqqpdOmEvpPhH9rt8YIKngvDUUYyRFmNgFWxjLKExLPlU5XdIBq9eFwql5/qr5D/dCJr+F0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UdTfHuPO86hR6bRPYxsL8DekkcB4DSS7tbqqaNyyhw=;
 b=QSiQ5a6C0BiiqQs2reBXnzNfXS8Q8KuU3mJKInAq5ecUP/mtZrQigyfSupkAFZmJRtQsjPhuChg8KsD3beqEeUait/QGyTD95n7h49le5VJr84oTsf09V0W46DJnUYhoD7sGVEVbwtEzRGHVyMKNSRGGpK5FrfuREgKmbhzC3GFVAFtWz1YbG8Rg7obbbi1V0mcyoeI9Mv4ojAEM1xKz+z/1rCGzXa2jqsTTDp2RJBFWzT+xJdU7L4KjyFszZkVQrMSDV2i2DZRhhIDiQHoKoCeU6OhO3QkSlH09bB3nZlmISKGs5J3EtVQJjxTqJ5AyQOowebRM7nyWyl6htMuzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 15:54:56 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 15:54:56 +0000
Message-ID: <b0f61801-be09-7c9d-0f73-b4e95cdc6b00@intel.com>
Date:   Wed, 5 Jul 2023 08:54:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl: fix CONFIG_FW_LOADER dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230703112928.332321-1-arnd@kernel.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230703112928.332321-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4974e7-3094-4ba7-b2d9-08db7d702dbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRGUjmpHDEFjjV965bnVfK8f8V8uuyGlG0Xv+Lj0O8McbAuTwxBt9QSuHxTU4SU/alnphqLtQ4CfCROhDrpbBApaqM4+CSSVzdwhlJ0Wn6J3eYgmU9BtWMEi2V89+5RBUvfECAmb0fFEg3uH9wB8r7A7czChomb9f7x3Y7lA2vT7RtJXqM5x8Aiz3Ti+aoiT+TuP+3flk1ElN5SmMKSUf3FacBSMHRl2tPagPXR9lryUpC9HQGhrWvofVJK89FDkdgCxPaKLbxMmlAPovqqkUjggfIN78PFog3EBzNRH4gBZSwdW9kMZEYbE5r7iS5fBP2dMZaX0ZEyIODAcICGBiqRq+corrodEDFRmbnnu1I61pXcjbPx3S9X42lyX/5TQsaMW5+U5zKORY+JevQ2+c+5ZnvAkZjPn/ZmKpxDLxSFkIdTS4b9W/E3HGuYYvvEm/FqtrCbRTVq0CYO2+j74KYb7CZt4JjuXbwF7XKNMJCKbKvUSKqEwNEV4xKAEA3vVo6N4Y0TiyGnV/2au9khfSz7eA8KSsajzDfXBWYCt45V/xdlm6DE8ayDNecnMjHTOc9aLlICaph9U2VEYlJ2WX1JDWMdLcELRrJdyb2beaO/Vjgx4RB3PxUc70VhoUtm4e5iSCuOsk/b8CDym2ttIvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(2616005)(83380400001)(110136005)(54906003)(44832011)(31696002)(36756003)(86362001)(41300700001)(31686004)(8676002)(8936002)(2906002)(5660300002)(316002)(66556008)(66476007)(66946007)(6486002)(478600001)(6666004)(38100700002)(4326008)(82960400001)(53546011)(6506007)(26005)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEc2RnpoREtubVY2ZWNKSzRDd2xGUnJSTVZ4M0pCSjhCanh3ekZhNThzWDBG?=
 =?utf-8?B?WGk3L1ZFamtLSlVITDJDWjlmcDFNSkthMWdMQ2NwSi9kc0ZQMkpJMXdFOFBC?=
 =?utf-8?B?ZklxaTU1TmR5THNJK3hsSmZ3bnBZdm93WVAyandWT0lDQ09WMUZIdnhvYmJQ?=
 =?utf-8?B?blJkVk9oS2NoTDRVQmsydkxSZklTYUFXTWVwaWtpMlJuYW1tQjU0OVpabllk?=
 =?utf-8?B?K2tFQ3JVMExFTUlxRFdPWHhObWFSL1ZNNFpCVTNCcHh6dTJYY0cwVGhVeHQ4?=
 =?utf-8?B?dnB1YlQ4alI5LzRaeHJsVGc2dVNlRDNBUHBHYW90OU43UUgxbEVNNktLWHBQ?=
 =?utf-8?B?UDl2Q3hSZUN1SVMxaXI2N0NOM21PRlVDM1VpNkhqMElOaEI3WVhsV1ZoTmd5?=
 =?utf-8?B?TVFXVWlRVnpCZmhZTGlqU1VaRjNtZ1ZGdjl4alk3Mkdicll6a0Y2ZEJscTJQ?=
 =?utf-8?B?STFzSC9qUE1TNmlZRDJGbGVydmQ2ODd1czZZTEI2LzBaZnpmeGYyQ084cmV3?=
 =?utf-8?B?WFdSQkkwazlNY244OWUvOTdHbEFDMjh5N3dZTnFVYmJRbmYvSVF6TTcvemVN?=
 =?utf-8?B?TTZjSmcwVGtmV1ExK0M2WU43a3pzaDhkSUwxcmFJMFRKdWZjcjVCdE1GTTls?=
 =?utf-8?B?Zy9Jc3FQd0pOSm5SRGY1SklFdVhGWnNoN1RBSkp3RmoxS3JlMUM1MTZnZkNB?=
 =?utf-8?B?ZnJWMHVOR0g5dWNSdXNoRGpwVXFFc0Z1N3Z2c3d3d1llZ29qcnd5cFZBVUkx?=
 =?utf-8?B?emZkYmpXdHV0NmgrOTFTNnJmMys4WHRwQzdnK2hncXhTUGxRM2pyUGo4Umxn?=
 =?utf-8?B?Ykc1MFF0c1RiU0RpZ1RML0RUajRXamRzNk8rUUsvcUJwVG1UWTFlUTRSWmVR?=
 =?utf-8?B?OElsZzNHRnZmVXA2TTNra0pGU0cyc1NqMjJlZUI0Z2NOL0tvcVdiemFUb1Nm?=
 =?utf-8?B?OElXeGZZZjRUU3JKbHB3Z2hjUnV4Y08vb0ZDeFhveXhEa0J4UEpCN3AvM1VK?=
 =?utf-8?B?cXh5TUZhK1BVWHVVM1QrdHpoOE5mbEVEeWxhSFkyWG1USWovWDZDYnVoTmNu?=
 =?utf-8?B?YTZKZGpVM1RJRGM1Z2RLbnVXc2FZNHcvZGx6eDZtZVM3UG82NGdYczBsRHU1?=
 =?utf-8?B?bkphS0U2cnZQTFBBL2NPaGkvVjUzRkpCOUUvRkhjOFV3UXd4VkRaaExHRG5y?=
 =?utf-8?B?WWpyM3Yvb0k1NjdPWFNIZXZETTc5ejVxWEZhOWFrSzROdkFMdkJGbHhYSGg0?=
 =?utf-8?B?ejR5emtlb2o0VEtOQjY0eDU3bTVHalk4dEZ1V2ViZmNOWHpUbTBHMlF5NnlQ?=
 =?utf-8?B?TUhHaWYwNENWaktDb1JCOG1CWFo4SEtvMk5ITmhZMmxIQkFiMWZKNmdYWHBr?=
 =?utf-8?B?NHFleUJ5ZnY5bGdlTHVNWE9oRDBvcFNQemFjMWtXajVLWGY1M2E3UjdweWJu?=
 =?utf-8?B?d1RJTUVOaFlXdWlrZlBzeEgyaHJuUjNVZ3FUbnNBNE5YYTE3eVU5VS9ibnlo?=
 =?utf-8?B?NmNGbXZ6b09mS0hjck05bkVUL294d3pGbXZFOUlpTXN5Q0Q3dmZsdVVSeXFI?=
 =?utf-8?B?cGJDZjgzUU9NczdDWFQvd2gvZTdaek5lVmk3SHpNb0puSVU5dHE4RUJKelVn?=
 =?utf-8?B?SHBuUTFqRGloQnJaczBBUDFGT2c5TDFMa0Q0cks4MERlajB3SzhRWEpqcnl6?=
 =?utf-8?B?bkVnTDF3MjJrZ0NNWERCUHFqcEtsYVYvTHY0Z1hidk05cjJ4M3Y2K3c0MXZt?=
 =?utf-8?B?N1FCdTFTSGFWbm9hL3VHWUFtTDBHY1B2TUZlUzJKcldxaldYRFYrTFhYOVB1?=
 =?utf-8?B?RFpYQk8yV00zZGRXZVVva3JEczdnelB0aXZtTnEzclRhaUxkT3M5Qk0vdDRu?=
 =?utf-8?B?VjBlNWp2TW5zWEJVVTduQU4vMmNjNHU1OUJ4QXR0TjE1WEI0bkwrR0ZlZUtm?=
 =?utf-8?B?OVVaS04yTVg3Y3Z3T01BY01rVDU5eXFRRGJxTyttTUlsTEFSdEtJanVGeHFU?=
 =?utf-8?B?WXVuVUdqTi9RWDg2ODRnUFYwbWcyWXNpd3hHTitUNHZxVWRUM2NUYkp1ZUUr?=
 =?utf-8?B?RXI2MFFGYThiUThwVU1RejdlaU52eUlNbTArK1JyVU9tU3RvQXRXVlFHZmFj?=
 =?utf-8?Q?3E93buDq4QCBAXGSMzkWRODr6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4974e7-3094-4ba7-b2d9-08db7d702dbd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 15:54:56.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfgXQf49GaWirwG/ECCUQJ77w34Ji30dn6/jXxpjOwRdAReQX2iz+hJVebiv5B/4167YOWSOE35zBOVTiDHgeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 04:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When FW_LOADER is disabled, cxl fails to link:
> 
> arm-linux-gnueabi-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_setup_fw_upload':
> memdev.c:(.text+0x90e): undefined reference to `firmware_upload_register'
> memdev.c:(.text+0x93c): undefined reference to `firmware_upload_unregister'
> 
> In order to use the firmware_upload_register() function, both FW_LOADER
> and FW_UPLOAD have to be enabled, which is a bit confusing. In addition,
> the dependency is on the wrong symbol, as the caller is part of the
> cxl_core.ko module, not the cxl_mem.ko module.
> 
> Fixes: 9521875bbe005 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index fcbf8295fde37..8ea1d340e4385 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -2,6 +2,8 @@
>   menuconfig CXL_BUS
>   	tristate "CXL (Compute Express Link) Devices Support"
>   	depends on PCI
> +	select FW_LOADER
> +	select FW_UPLOAD
>   	select PCI_DOE
>   	help
>   	  CXL is a bus that is electrically compatible with PCI Express, but
> @@ -82,7 +84,6 @@ config CXL_PMEM
>   config CXL_MEM
>   	tristate "CXL: Memory Expansion"
>   	depends on CXL_PCI
> -	select FW_UPLOAD
>   	default CXL_BUS
>   	help
>   	  The CXL.mem protocol allows a device to act as a provider of "System
