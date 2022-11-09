Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02306221A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKICGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKICGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:06:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7168292;
        Tue,  8 Nov 2022 18:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667959601; x=1699495601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y4NzXkeozZomTE8d5q+YCEdg55QTUg5ZfhPCW8lXHqM=;
  b=djKRYwaq42YSChGe5S/7BOdn0lizTgeav+UY6vyXvC1POaK5LaozpsHu
   fqQFRWZeGBJdhovRUviDGFtndfDLFEFtZitfStytfHyG/xZFEffuOQtoa
   wOUufRwmyRxITuXp6/jRFGSSslLKdHRFEnQVFa894xK+Sd7kEpj1rfI55
   U+RyK/svaeiUdP7sFBcFFcbc9ca/fkVNWunBaneuKdD+Y+p/U02bLXI2r
   4aCnWle7I0oW9T7vcBkGwqGq0TuXNFY8vSaYQdsHtFGO8zHkSMZskWguH
   OL8AOL/pEQFoJFF7LdSglzijDP1/DDHdhzNLH2THtnMGB0iMp9lviYh3x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290581216"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="290581216"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700161736"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="700161736"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 18:06:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 18:06:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 18:06:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 18:06:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV7Y6BTM9AvrzIOQC1DVqeoK3VMfqiSTVUpRQmOTWMcwmoUo4Kwtoaf7/ZFgRDkBUVXk+sXZ7JS3gtg1/iKiKUqSP+u9dHXgR5CdpDO6VwCZs0a9jS8mtugDEdaO3vuv4yQV5cjZolVZxrjLcHWY0SCMjubAqVgFFlH+YsoNUPAc8YtqdKIOHPBqfcFev/iofLFFtCdq5JNrUB2t7EStDZ8K5aVkBLnpzj7nOqqqWxKpkRjuf2iRRY8d7MInSXRLP4qRVJLUWekhpkF7EhabamWN3NIzOLFQWKOwIv8j8ODKVOnofiqlE9QDr+irEJFVbL/WIC3b+oTtZVn6S8xNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2QPc4Z8noh3DfhNl/kLMZna2U3tmNGznSm1KO9btVU=;
 b=YPisOdxjiCejPVkYYa2QodWNOJqdtO8FBXgjfYubXNr+eMtJAZGaKyGPHMxJRrAqXwI+s/PYxM9RRBwbvA4Ye1+FYhJcXvmK7zU4Zg4UiCV0frlujKNwlm7kO1q/0JoPYM4HdANPw6IXpmDf4fzy0QVhYSamZlKCi/B2Vsdix4+G1S3pdpA8M5h2PeWUPH4Yz1Ldve+ARqlpmfuhDajkjh0rN3CkkNWk0YqVP+YlJCc1kTIyNONBJPKtu4ul9qhwW5jaqy+n+npaR1w4DZoJJhvuCWt0Ao7vpRGr65gYgT90Gy9sYPRr8lDfgluRIYA2/TmqepLujyNkp+6hGox2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 02:06:37 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 02:06:36 +0000
Message-ID: <167af652-b36d-e06e-b6ad-f89ee30385b4@intel.com>
Date:   Tue, 8 Nov 2022 18:06:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 04/14] x86/microcode/intel: Expose
 find_matching_signature() for IFS
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-5-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-5-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: f8312563-0b23-4525-fdb0-08dac1f706a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHcp9uJxHx1EL+ST5hKStWJ5rIk9R5iy3AyBufCzDFOh1GrFoxtgb6QHltzsbpWzop0pc6H+vDC69RMnzbfs6knDwXgR+lmxEl3x3zc2FkwVTrrqQSlWh8vmGbBESM9e7rEZIR98wZnJx47P9X8EyKQiQKhcqoAmBnMVhK9CaYCEIRu3l42vTV1qG2i8y7ugBW0cUDqk9+dui1kIb7ugnoRzpoRvnaXQsUC4LeSTqtK0d6fZUUN1eqID/9xcdJm5NRP8pyi9JRu9z9B0Wx5MJc2Hr3cRTsau3KWy6LGHW72/DTj77bffPKq8Bf4KusG/+f5XiLIY1gOdSH6ew7EEAKcZC6bp6dVmvdnOQsezbkoxe8Or/9chS7pqDJP9SbZRwDUT/m5fwRJ+RUWkt+lmt+tSBqKuWQlNSkkWRuNBZ+kTuJVjwQx1i/20XuYxmoPWB9l/BJzHADqYxlWfvqNt3fJoljyaoEYe2IYvS4qnppXkr2w5ZivzsPGri1bukHDaqjBSlyhNncwGTI0OuzkpbTSNaX53wmBxMOeci1hsz7wFLJBHvzGx86A3uUNCZdTkkdfECbwXqpzr9Iq14W9K48J6Zx8lPekEvOXFlRIFP3MnbpW50DmWM03vCRvB1LCcH5aVBOp7T45wXLlpmsQppL50A6MFS1zzqBeoES85vkHgALLVb/d6KU+CUBLY+PDlhpXr5DLSA5GYAhfLMoUzD/S+M5B/d/yUcQ2q82Pj8F7JNOIrA/R2K0cG7YsT413yRRXXSGoM8sVsEu6Q48SIWyA2yBvAGduX7P/NnmA6Fk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(186003)(6666004)(2616005)(53546011)(83380400001)(26005)(6512007)(38100700002)(41300700001)(2906002)(44832011)(7416002)(6506007)(4744005)(478600001)(5660300002)(316002)(8936002)(4326008)(6486002)(66556008)(66476007)(8676002)(66946007)(36756003)(86362001)(82960400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9Zcm5JRGdaMHFGbDBOYUFQWVJ0YmpXbzB4RW5zZnFWSmpWejRybTAxeC9G?=
 =?utf-8?B?TmhwUmIyZDhiOHlOMmxQQ1M5VnRqRjdmQSs5d3JKSjFldjhyUHcxMzcrRGZQ?=
 =?utf-8?B?K2xTakV1aVJSMWwxY05yRmVWN3o3bU1CRHZhSm9HOEZDYjNObS9HVTdiOEs2?=
 =?utf-8?B?QURRdXgwQnBMRi9hVG5CSzU3M3UwRW00UHdwN0RKajVrL0F1dlJVenYwUmZr?=
 =?utf-8?B?N3I4Z0JHVkNDbzlFVHAwTVRuTmQzR2FNRFk0eHhSWTc1c2l0VnZrUkZjZU5I?=
 =?utf-8?B?d2dUcWRaYzdwcmNPM2hxa0l5ZVQxUDV0WUVjR0RoSkVPMVNmR2MvdTUvZHVR?=
 =?utf-8?B?c1k2ak50b1VkOC9IWmZOZjlzTmJxci9FbnlodmhLTG1uNGNnakdJR2xPYzMr?=
 =?utf-8?B?b0J5RG5ZZXppWnFGOGlvaEcwcVFWeFJzdGhJZzFLQytzVkkyYnE3Sms4NVdS?=
 =?utf-8?B?MndyMVdsRTdBWEFvRlN0b29sYi9RclBBOUE4RDd4aVRIM1U0d0xaVEcxaGpQ?=
 =?utf-8?B?cVFFRFljUmh2T0RwZHVkbXgzNThaNnlhN1FDY3h0c3lrOGFzdWRnaWh1TVNl?=
 =?utf-8?B?ZWhvdTlRYUJPYkIrLzJES1V2bjUrRExuNUdYMG1QdFlObm9EY0hZSUNCY1Qy?=
 =?utf-8?B?M2RNZ2FmL2VFSW9oWENDcjB2UGlWQm1ZYUt4ZWZOK3pOZWpPY0lQeklyRmRL?=
 =?utf-8?B?eEd3SFpIL3REVEUvU3J1MkcxODlkWjgrQmZ4dEVlQkZhYkMyL0pvdHkyR1ht?=
 =?utf-8?B?VU1pL2xBbHpaMHBDZjRZSHJrbDB1ck1FU01vQUk4TXhhUktzU211c1BHQnJL?=
 =?utf-8?B?Tndmamt4VmU2V05rNjVaeUxyd2U3K2VOQnd3UUhNd2YxaGtJc2swdWRCdHd1?=
 =?utf-8?B?ZmpmaGxTdHNpK0RRcGtpaXZPVlJaS1hUUnR2L1Y3L1liODNyWHhWeXlYdnQy?=
 =?utf-8?B?dTNBeHk2YnBFY2Eyc2pSVCtJZTVpRUd2NjhvUXlYK3kvN0g0S0FCOFFxNlZU?=
 =?utf-8?B?UEVUSXl3bnBjVXpOZUtFU1dtYlB6SEJzeTVUMTU4bXJZUk1RaEFCR0xlZFUw?=
 =?utf-8?B?ZlYvQW9mbjNKV3dRdTBhRmoyeU82NmttdmNiWm9yT3dVVE1tYTlwdDNIdFVJ?=
 =?utf-8?B?MVFUb0ZPSEM3QU93VERnYXFtMTdORWprbXdvd203bzR2L0k4TDVWdWsxWUJt?=
 =?utf-8?B?QVRJMm52V1V3RFRlbnptUDIyNHMrWnJLMERCenRGWFNXWWR5L3ZCK0V3cUFs?=
 =?utf-8?B?bzFpQ3pZdVlXTkdwa1dLbk1RSS9hTS9KVEN5ekZGL1VQYjgremYzMUt0eStz?=
 =?utf-8?B?Z2lOZWJWalZ3Vm5yQXdrZ2s3Zi91TCtRZEY3bWhncGNud0VyT3N6b3JZMksw?=
 =?utf-8?B?N1d6cS9tR0RHYkFRUitEU0xiaFBXSkh4SFU2c3dnYVZldTFlRWdCT3J5N242?=
 =?utf-8?B?S0xBM2p2Tm1kMmhiK1hDV1gxRy9KNG04b2NRNFFoYjVqRkQzbHQvS0ZTT0wx?=
 =?utf-8?B?eFRBODByREFxSjdRUnNLU2Rhb2VlVmVRNUk2d2lLT1BoM2VjUmVxNmtmMkJ6?=
 =?utf-8?B?clZyYmlsV0M1dHVaS3VycG56anRodWRTY09LZUVjOUxBR2JEK2VaZTE3Q2xY?=
 =?utf-8?B?L2poTTMvSVFST3FxclA5Vk5XRWxvL3IzbnVNVEUyNnU0TU9taG5JZThkM2dQ?=
 =?utf-8?B?UWhWK2FJZ1YySTNHeVFuRTlJMjdqbkVLbVIxR0RwM2syaUh3YjRQTnpoeEdF?=
 =?utf-8?B?VkJNTllaSnRCYTQrMkl0UXhHNXBOUUN0bXZ6NzIwalBoNUZRYUtBbFFaRWpI?=
 =?utf-8?B?dTVSTFIwMzFocXg4SWFFays5YjBvN3MxZ3VrYjZiNnNVVFRPZmI2emJERHVC?=
 =?utf-8?B?eGF2aXhQOWc4b2U4bUNXNE1iMVpTRXpjdGR0YkdCcjZrY21VZ2ZKL2pWKzNY?=
 =?utf-8?B?bUtsMHNYWThvbjVnT3hlTEtyK3ZNQWF4WExzVy9UVHZ4ckVmTW1Icm84c2Vi?=
 =?utf-8?B?UEJvN1MwQnRJa3F0TjNka3dYZFBXMndoT1QzVElWODBvbjFKLyt1MXltUTFt?=
 =?utf-8?B?YzR3UlBaeW9QQXRHSVY3bHRnZGI5Y0ZWL3NqK3pMMktGZU83UGxscVlTRy9C?=
 =?utf-8?B?QzU2Um1zK2plT1MrSzNISzUyTjRRSForNDl1U1Z3RnlhN1FrMUx1ZThrNmtq?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8312563-0b23-4525-fdb0-08dac1f706a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 02:06:36.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCzgOXnkYd+Q4BO1yzFthQCy3FPhQ4R3InadeU+IGw2ZMmyAsh0j3MWRzh4S8KZLK39bJpPFVz76VFx3Zj7tHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> IFS uses 'scan test images' provided by Intel that can be regarded as
> firmware. IFS test image carries microcode header with extended signature
> table.
> 
> Expose find_matching_signature() for verifying if the test image
> header or the extended signature table indicate whether an IFS test image
> is fit to run on a system. Move the function to cpu/intel.c and
> add intel_ prefix to the function name.
> 
> No functional change
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
