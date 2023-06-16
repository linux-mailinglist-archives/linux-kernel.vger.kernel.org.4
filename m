Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E47324BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjFPBiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFPBiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:38:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040A2948
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686879480; x=1718415480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C3MN5jBLXznoOsj+lSNMhHc+MPSCe4YFplmc0c+hVbQ=;
  b=DGR6wmv+e8aq9kAfCmKITos8a/H1TOyuuP9kwdrIdD7VgW4nEh4/u60R
   s/Y5teMOj84s2ymtrmHZM2byz9MHPXNW35MOjDJjFMGNlQ5yvqmQB31I4
   ZQOXIc7pdrdTd4A22ZxIc9u6xsq3xUNS8Ivcq5ISMIoTkZSQb6BFSQwmE
   fVlVfcBG6nx+QRc8ZBlaRva22Fkkt4vThW5fvd1YmeoZn7H2yuoAYZX++
   8KGn5NhPeiRbKrvXO7WXRXKveC5oynwJuD7uWOY200l3hdEV6c22yAPCb
   gHJXLjT1Y0hVmJ2rnWrYLacGUDzTBSwrRyGBcxJFZDHni5uzEZ/zzQ5AT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362505560"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="362505560"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 18:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742463107"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="742463107"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 18:37:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 18:37:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 18:37:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 18:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRQNNej8FP9joPeUk8orUJmL4PiJFbDXSbwYNOr5DXdb+HhAqFY+jYKt2GqZfcE+aLpPz0+BZgilfrhak/bLfDXomBtYd1pnBF8vPvqiyzJ/gMhRbEgag2YRmN5/eUNbZ60+QM9mFKEWh/yypAszLp1v50oxYpdweio3zss4kqdOVhw2wU120TwvIU00e3ynyLtB7XQcm95HszZruwk0sRHlIn4m1swucOvKJt8KevsXrJHe4Mllkg2U+GnTb0XMldoPinutUU+6tg41uq3aac6Rw/XM2dDnvWnN1ZZakSnOqmY62CK2lPDjMWOW+M0eneyOVbk51kT2naodbaqONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecqc11MCJ8k+p0y39f+QUpf5HaKqraTOk38IRQYTUKc=;
 b=ZWDHeJb+KaSh7AS5FsV1GqftdbaASYd7O/xPasGCmRMEcsJXLggpWuoOLyA0llGFuGCoVkjdypw/BZcHMhTdST3VG6cJIeDBlMxyRdtCtAophSMBXNXwbA6XVpQkZGW12DuwHtiskpCeeRjs/hdGiRQ+JX2YgXYDXaU4sN/Hq+8Ck99Y4kjMMFCwnE7P267Ovbo8uRCJZQFRFwaBjTuyd+5z22tPWCLwqnjTbx7J3YbGRaAQslntLsEyrQT7LJzXTr/7JIpJvUb03Ivr7OddJq8pWGUtGSz3Z0ES2A++fOe7LFLQ0YbdXUNAY7uUyfn0QO3b4v0b1vcHJyjml2B03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 01:37:55 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::1a30:fbe1:9dc6:4e1a]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::1a30:fbe1:9dc6:4e1a%4]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 01:37:55 +0000
Message-ID: <2e467eb4-d680-df7b-9174-b9d6b6071a63@intel.com>
Date:   Fri, 16 Jun 2023 09:37:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
To:     "Zhang, Tina" <tina.zhang@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230615071613.690639-1-yanfei.xu@intel.com>
 <MW5PR11MB5881C833CBC14D106DD9A8B5895BA@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Language: en-CA
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <MW5PR11MB5881C833CBC14D106DD9A8B5895BA@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To DM6PR11MB4138.namprd11.prod.outlook.com
 (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 6714091c-d5df-47ff-3146-08db6e0a4e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlrizRmn9Rf8u+9udY5PigBMtoSAL/0deGwtVVFfAb8rWkS/YxwpoAOxyn8AC3JQ65a6DCYhkQNOqiRf6cxQ/3+XCfDJbl6MlO2NjAvTbX38Z1fqRmNzlSWnqIJUSEziFrEfMQkWK4PIB6IfR/jW6NhRZiu5bVq5zAqV3ew2NPxeqLxBOxTY7xTLnxduQLVsM/v/5hhFKHErBaKubHKW5kwZg3w+3UqmWhY+G3l4g53nWf1AmHUh/494fNVnQPn5WC+sEhEjoH8ScxZ4ZyglVp03S9CgHXe+o0XLqgqgAtOKaAdFkcEe5RbEbwfX1hWEe6eKwjGkW/T0IDQnFbTNFCQ1Za6ELQBkoW5FaEic75plPom2RO8U8ETXK1u1r0ZuYx2TGkXyc/9p2xOx3mjbyuh8Fo70gnB2obkOLb59CTiZ+3XzE5cNe2Wq5munVLtxtmf4UoMVR789LvTp1gHF7f0l8zWkJowjQDPUtqOJtI3wT0tnKH5hl5aeLRzv0r95cLgMktemOT2x8nZcFeqHPBeqzcYVasd/M4Xj7es7cMnV43JLhiXoQyAOlsxmluwGrgMLjIFMsThdGMYxDphMx0I3YewtkKekT3i5R7Tx+D9fHJbfnjAEAL/4ujTNvhCyRGDKY9lfVIE23XGZ1XRlew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(82960400001)(54906003)(8936002)(8676002)(6486002)(316002)(41300700001)(5660300002)(478600001)(31686004)(66476007)(66946007)(66556008)(6666004)(4326008)(26005)(53546011)(6512007)(6506007)(186003)(110136005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJWamFXV0tYZG1weWg3UUR5TEUrZjk0R2oreWpxSFBlb05MbHBkZkxPb251?=
 =?utf-8?B?RjFITDg5MFRZc21JSlBoa2txamRqRUZjZlZsODIvZUZTVDM5OFhrSmRCT0do?=
 =?utf-8?B?RFRzY1MwUDNTNUpVd0pLbUdWemZqTDFpTnAxbkNoTU5DU3pTUFJtazM4TkNT?=
 =?utf-8?B?NjhSRXpFMFprQWxzOHY4UVc4clUzaWM0cnc3Z2NKNjZmYnpocGRSbU9OK2Ji?=
 =?utf-8?B?M0ZHNkVDTjlwb3grSnB4WFYrR1diaTZKaThzNm5mNTBUbDNCNG5jNUltMjdt?=
 =?utf-8?B?a2pvSWF1T3hoWDZEUFpsTFVFKzNpcTUwaW0yMUhLWW9rZW96MkJDblNPQWMz?=
 =?utf-8?B?ZnNWYWdUUXdueWtWazhUem1oTzdBT0FsdzM2c09KVENNZWljcnNKRHpSSDdJ?=
 =?utf-8?B?Z1VXWWZ6KzNNMDg5L2NnMzA2TTg5WTNwamMwUW1RTEN1K3BkakRxdWpaZUxu?=
 =?utf-8?B?MlFiMUJxcHBNc2M2V09qWUFUMnJEQk9XRVFaMlpIQitKU1Iwc05Vcm1UNUI3?=
 =?utf-8?B?d2VuTDVsTnlwSUJUbkVHZG5ZUWtMNlF1N0tSd3M2R0tVSlBld2w4QW1SMXQz?=
 =?utf-8?B?d2Jic21PWXR6cDcrYklISGIvOFF5cWx4V3dYOHpqWU1QL0N3bkQ4Y2l2bm9D?=
 =?utf-8?B?eTV3YXpHOHhFUS9Kd2ROSDFpSHZDSUo4VEd1NlR4cmhJbTU1bVhNSDd0NHdN?=
 =?utf-8?B?NFhwYkg4ZDNjcURCekdaSzlUR3ZVaU5oTDJTKzFqUDNWalVXWDJleTgyd2pp?=
 =?utf-8?B?MGZZbHZTNTR5c0FlRm04QWpCUXg0Vld6eUFaR0Z2UkQ5WGxpS1lnc3hENU10?=
 =?utf-8?B?YWtuOUJiUVVoOWhWYm5MdHQwSW9zdXNLUi9IRjcvUHc0RzJpaDFEa3I3aTB5?=
 =?utf-8?B?a1R5TVhSeE5UaTdkN1lQYmNLM2w2aHoyN1pzVjFpYzBTTHNML1JWbklJU2wv?=
 =?utf-8?B?Q0k5Y0k1L3Z2MVdkRTdOS2VkcWErQms0VXpLWlFwTVdHeEJUa3NtUTQrdHox?=
 =?utf-8?B?dWFzUktpNkRPbFl2U1VuckMzYlp6QzRqc2Y4WCttdjNGVHdNdVI1a2M3aTlv?=
 =?utf-8?B?L3FMSitDL1U4ekg5WXJpaXJLdWNIQXhxcWNLcFlZUWdGY0VSZTA2TUEwVnhm?=
 =?utf-8?B?Zmg3NkxCbllvaThEdjA5a3V4WGlEcStLTnBDZUFIRUhMRzNBOUdBaUxzcnE1?=
 =?utf-8?B?ZzdwQ2lMQkU5Nm9NNllmYks3R2trcFR1RFR5UHA4QjMzSlpybjM5R05RWWs0?=
 =?utf-8?B?STdyY2NRekFaUWpvRmd0TWRNeitEYW1FenhOdklPTGdGaEd5ODkxYk82akpo?=
 =?utf-8?B?WGtYMktZZENra3o2MjVSS0NzeURYcVJiTXYwVjQwR2N3RFpMeHZoR2x1bGtn?=
 =?utf-8?B?U2F6YVdkKytaRUJoUVhwSldFZGhBb1hMNXh0STA2OGw0bjExZXBoY2JXcG9V?=
 =?utf-8?B?VGhRSW1CeWpmbUkxU2Vvckg4alpkT2NYMDBIM3VxazhqWlpYVzNBc1VoS0NQ?=
 =?utf-8?B?UFZOYVhBYXdyK3NQR1QrdzMySnlyMitob3dyNVpiUjhudXptWmZZOVFjRTdE?=
 =?utf-8?B?U2dQS2Z5NUwxZUZPYVM5ZzFScTkxM3VkQU01YkRYenZRWm9lUkZoZWZUUTNM?=
 =?utf-8?B?RjlxZ2UvdS9XbjhmZ1V0aWdmUzF2T2xBRFo0ZTJRSFA0RjNpYlZOVnFsVThL?=
 =?utf-8?B?eHRlK1J6VUZUZTVpS2tzUkhZd2QvVEdVQ0E4c3JSZ1p6R25tb0FVWDlXcTlp?=
 =?utf-8?B?alFSRWFkMmhMUXV6RGE2WXVtbWFVTGVweVd4bVNmczl2eU1Ec3Bjc2s0cmNY?=
 =?utf-8?B?SjF1MnJnR2pvTUdNWng3UEZMcjVQUWpYNWp2eXRJR2tGQ2N1NXA3V1NRTlVp?=
 =?utf-8?B?LzlxSlFVR05JbGZlVlBrSVdLMWRHU3lLRUhjOUtkQkplTk9GeEs3dDA0VlpL?=
 =?utf-8?B?K3BFazVZcExzQ0VaeThDQ2VMelQ1TkVTek9rQ2lNOXFMYWluekdtQVppR3Mx?=
 =?utf-8?B?ekhFM0RLQWl4aktuUjFPcVhLUGdCWnI2bTFxQ3RyTEdhaTZIanlQdkU2Qzc0?=
 =?utf-8?B?TCsveVhlMWJwcE1WdXVaVGNtUlg3a0pHcmVhUGlaS0tRZGlobFNWN1JBKzhF?=
 =?utf-8?Q?WhR4bpxIAv0TNyapKNmCOQlhI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6714091c-d5df-47ff-3146-08db6e0a4e92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 01:37:55.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIVgM2QWFP8coeHeJ/0SLdbkn7Or6QbOpubqQbdW9DAR1AprYOGFk7VpyPqWgRW+VJQXgfdd80eKmkwv+BnUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
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


On 6/16/2023 7:43 AM, Zhang, Tina wrote:
> Hi,
>
>> -----Original Message-----
>> From: Yanfei Xu <yanfei.xu@intel.com>
>> Sent: Thursday, June 15, 2023 3:16 PM
>> To: dwmw2@infradead.org; baolu.lu@linux.intel.com; joro@8bytes.org;
>> will@kernel.org; robin.murphy@arm.com
>> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Xu, Yanfei
>> <yanfei.xu@intel.com>
>> Subject: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
>>
>> Even the PCI devices don't support pasid capability, PASID table is mandatory
>> for a PCI device in scalable mode. However flushing cache of pasid directory
>> table for these devices are not taken after pasid table is allocated as the "size"
>> of table is zero. Fix to assign it with a page size.
>>
>> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c index
>> c5d479770e12..bde7df055865 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -115,7 +115,9 @@ int intel_pasid_alloc_table(struct device *dev)
>>   				  intel_pasid_max_id);
>>
>>   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>> -	order = size ? get_order(size) : 0;
>> +	if (!size)
>> +		size = PAGE_SIZE;
> How about merging the logic of the above few lines into this one:
> size = info->pasid_supported ? max_pasid >> (PASID_PDE_SHIFT - 3) : PAGE_SIZE;

Yes, it would be more intuitive. But the prerequisite is if we can
make sure that the value of max_pasid shifted is still greater than
0. I roughly went through the PCIE spec and didn't find out where
defines the smallest PASID value for the PCIE device.

Thanks,
Yanfei

> Though the logic is about the same, the suggested one seems more intuitive.
>
> Regards,
> -Tina
>
>> +	order = get_order(size);
>>   	pages = alloc_pages_node(info->iommu->node,
>>   				 GFP_KERNEL | __GFP_ZERO, order);
>>   	if (!pages) {
>> --
>> 2.34.1
>>
