Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8471778D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjEaHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjEaHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:10:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F795EE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685517010; x=1717053010;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J2shFVh/fOzNRnd4K62Mp7K3sSrwcdmQ6enJbZ0arzU=;
  b=h3N1GGWFUU9rhQNeHYrCf9q+DBpn7OBAVJFBYRNx8CIVvRlL/jLxoLPy
   seInV0K+XF68sUO717nBdspoPZvwTMLFHtO4/Z9yE8ENlT3b5byP0efFm
   RnGUI6DGgc0GTYmXNpONKOxyr68OcmnWKlvLnmvkdnyXzqJH4w/MtcRli
   AWOENIZ7XkyGzXx/Fi2S5AvJ+gQBDigWnUthdKZxW7+ZXe4YcCYbVVAgg
   cce461BaMKZ68Krngr8QriNtmWuqU36X5LypNsj+nu4x0/1eXTFGr+JWJ
   I9GKPlbyPWS0q6wwo+2Oko6tvOWqUhyXh5SRP1gpiIIfc3eK/013nNDVN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="344665613"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="344665613"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036927564"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036927564"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 00:10:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 00:10:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 00:10:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 00:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjVS63iJqvSBcZg3GC48D8iKf3ooNLbTm7YuTifsGw90rN6qINzNv9jZk0OsojJF2Ey6IAfMpLUa2VjngvGpG02c51qlC+MRaGJ/GRmS4y/AFu4kYjFUrC+h2gxBgkF02FLWXWjGBACQoqPYEy38I+tw2IDiakm/MFwHK6bN+PGZlHt4HFTcV08tQDwloZGDV4t2W0oZMnPUYKAQ9HcbXqhw/j7HBd9XHHDUWNISbS9CIHfGh98wDfyrVDQrXAksU+QXaYcy+Oya5UHVj8u0OLugSP/1/okxxwYxkFyJZSZqSkD5U29hCJEE9sjAIGreh/Zp5riv+xSTCiTzSwCAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U68nWKrQeUOI3G/Ti1M8HxRAEoW33UIg7+RZHajvNhc=;
 b=diayIpB7+SJ5/rXJTmzJB2erZczuIVrl6Baa3NrFgj8i5ZJxjU+I/CdAw/GIOvwumOUnqD/UV6bzfLBQ/PxEu0PuI42eJF8/LgYy7N699lem4zjV45iTWpMIpzjVeI/+40lUveMsxPS3vWdGwZDdCtXUumiDr0l9n04vDCxzf3uB7hq3t0xEbeKdAf70ydOSon/ItFgbPKeaJc7eATONZvUX/S/+v2FMFCHqkdlqDdaxYTI56Xhut73rrM1YIvdZMnF9fnFepplliuY3RpAGKmFJTTeKhDHjCkYc5v1ITpZ/GNp2uXi9gHVsc2dw7NmZqlSmNX3FCuKdOPx1tmvWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 07:10:06 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:10:05 +0000
Message-ID: <a745c910-f4be-62f6-cb02-a610c04f4698@intel.com>
Date:   Wed, 31 May 2023 15:09:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Content-Language: en-CA
To:     Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
 <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DM6PR11MB4138.namprd11.prod.outlook.com
 (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|IA1PR11MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: e1abf316-0070-45e1-de73-08db61a60f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvLrcDA9ddnxzX0oraCifnLK/g2WnowibqxlZ66NWtWxu/37on2kJ0x0uji4aSKscZEOZi5nYkNrbwueBrUks8iiu8bPfORPbNhCMxtMVRJ3NBB+XDM7CTajTCr8Ec/S667GBEjOw4X2pDNN4gTF6doaqEu2eyylYErSK9JdLd6YecTx7LXlWnL41aO1CHKtoIVei19WcT2+N2O14TR89ehqMWHVeMR+lfCoBkWxg+wlav81Ost2MMEksudw+0DWdIpxwalXY4sraP2ygkQNDtAkpjnNQcxM+BoKP1UdkzOpBnNjbeDOSSORiPrj2VobTje0gJmer1Q1OdFQz/h+uNos42WaioJlrjzeMEquLDpjzEtYp3TVeYihgd0YJak3+R1ifjDCtbhD4I/z6vWYJe7YiIOPGw4Uvt7lf47uILAP3BZkiNTxNoxIPY0phfwXvu05m2uSsX7E2i5b09ppr8UnhY/l9/Bkt9Ief3C0q/0/D3WYfz96DIyW6qLMtnhsqtmlANxH4chq+mOSu+B2vRYnf/HQTfpeD2BgJRHblIz0Q2LUPBboH2PRKm9MtNWmtsxxnmc0MP/yIqGYJxPjHBB0y1oUTTlw95SHHPnDwEYQWoE419jH5MAvCne5+6HJxZ0cAiCLlW9/gD+gb8U7dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(38100700002)(82960400001)(31696002)(86362001)(36756003)(6486002)(2616005)(26005)(6506007)(6512007)(186003)(53546011)(8936002)(8676002)(41300700001)(5660300002)(2906002)(44832011)(66946007)(6666004)(31686004)(478600001)(4326008)(66476007)(66556008)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0IrM2VqeVRKWWpIdm9ZTjlnVU8ydTN6SG9meGFvYkttNGxZcGJ0dW5mTTg2?=
 =?utf-8?B?YkRmb0M2RE9COGs1K3J3YlF5RVVFbGF1djk3M2ZqakUwVjFESXJDbXlKNGxn?=
 =?utf-8?B?bkNtbUUyK0pzUEU0SjF0MzVyLzdOQVlkUW9JUWI2ZytNTThrbXphTWZZZHVJ?=
 =?utf-8?B?bFRaMGgreUFRWkxHZFhoMEcwN0paTWl6aytvYVVneW55T0hDS1N4Y2c4bHlz?=
 =?utf-8?B?aExkOHVPRjhqQXl6ejlXd0VzNkFaRG56bitmWFBnenZqc01YK2FNWGRlS254?=
 =?utf-8?B?OHlhNGs1czVrNnVFa3g5bi9FdUhyeHN6SjBlV2oyTDQ5VkEra3gvN0d6YlQ0?=
 =?utf-8?B?Q1NUMklUUUM0TFNPOTZXbUxCdXRsUUlnbkVOTWxsMFM3NDFTY2s3d3RrcFVK?=
 =?utf-8?B?UlhNb1c5cDlZbVlWdEYvdVRkV1IyWGtod1g1OEhKR2VDcHdTeGNzNHpuQW9n?=
 =?utf-8?B?RHc3THBMTjlVK0YxaGNFY2QyNkJQbkRPcXlWNnFxRWN5VmNJMDZ1eXplbndY?=
 =?utf-8?B?T2xWT0JoVmxPVXJFUmx6cEFGUFRjMXUyNUl1amM5OEh0eUJzdXNMcVFrSVRM?=
 =?utf-8?B?eWVPS2w3UkxjRWZyc3BJOE1Kd1ZkTWNob09DT29wdzFlMTZNVkFWSlp4djRZ?=
 =?utf-8?B?YlJQblFEWnZCTHRZTmVTUDQ4b09HY3lXWHRNY2tFcGlQZHRCTlBRNlZicTNK?=
 =?utf-8?B?YVIvdEtIYm1Gd0xIbkFpZkREaVpJMDk0Z0ozekNTcHo2dW5CODhNVHg0Mlpp?=
 =?utf-8?B?V3ZnRllFdEZFdjVrR0JBSmdCSzNnRUZVbjZDRlVBVkM3YkFLMGxmQkZaY0s5?=
 =?utf-8?B?UHd3cytsVXJJMVoyL3c2eENxLzZDeWhSSGxqTFpNUC9WT2JBV0gweFdKK0FG?=
 =?utf-8?B?MW5KbUg4aTVRanZxbFAwSXVSNUtOY1pYT3R3enBMNFVLbUd5amtsNmpBRG1S?=
 =?utf-8?B?enJnN2RiSVAzZmthNkQzeDFDRzE1RGxSZ29TaEJEelJ5M0RWSWkvKzZxekw1?=
 =?utf-8?B?N2t1UHZaa2s1eTdUNG1YdjJ5QUZqcCtsQmp1TTNKYnVNa0hDd0xSZmFUM3dZ?=
 =?utf-8?B?QkF6RUV6bzZjQ0RDYTJ5dEkzWkpNYWVTYnk2b0ZDVkIwa0VidEEwZmpUS3Vt?=
 =?utf-8?B?Vy94dzRHQ2VLK2JKdEt3eXZWNVp3cS9rT25xbjFoQzRVMUJMd25qVWFOanNZ?=
 =?utf-8?B?TURuZFcxMkUzSk92NHdsbGJZMXplZ1lxNGxpQ09Sc2RkcUFJUkpmSVI1Ymlu?=
 =?utf-8?B?aGc4dGZrU1dqL1NPSjEwdEFIaGtoRGVUME1RbG1ENitYeUg0czJOd2pCb0xF?=
 =?utf-8?B?T1VLMXhzb3VOMGtNb0tGZTZaQnF4c1hxTkZEbGlBeUphVDltTUJrdzZ4alJQ?=
 =?utf-8?B?bFRPTmFQSmh3VGdSRkMyVnVvakxacTFoNzN0bEJVZ1M1M0FacVFqYnF0YXdm?=
 =?utf-8?B?T3cyczdXb2EydHZmeXBVUzhJNVhmMHNYajVaOGxZMzdRWTVvcDdKVXNNR2VJ?=
 =?utf-8?B?a25JcHk1NHhOaUNvb2tpREYzNlBIZGNnNTl6bERHQnYyd2VOMVZVTFFqZUVF?=
 =?utf-8?B?L2tqYmtaSXl2R1JNSzZCRU8vQWtPSUNMdUFyZGxtNm5CbEkwc25XcnhmWFNJ?=
 =?utf-8?B?b0ZFa1Qzb3ZCbWFTZ2hUTndEZUI3TDRhK250VHo3MGg2Z3BqUk1qZHI1V0ls?=
 =?utf-8?B?RHpmaFIrWG0yWUx6L0taek5SUExHWm8vOGhxSnQ3MU1ZbW1NZkx3c1JheFc0?=
 =?utf-8?B?N3NEMkd3bTU1ZlZXNGlueUEzRHVNUlBsQW1YcE1GQ2M0VVRwd09XR293blBq?=
 =?utf-8?B?WG8rMllIeXlBWGdSY3ZHUVNYaHg4aURzVkEydmYxKzErNzFENWwwK29NM05F?=
 =?utf-8?B?S2N2T3hGSlpkNE5hL3dNUjk4d0phbXAyazBkbkdQbWIzVUdtVHhlVDZMWHFC?=
 =?utf-8?B?MVVJS0R5ZElCbHF5RHJRMlNaSmpqaExZWmpJcEs5T2FLd2tiSTcyOWVmQVI0?=
 =?utf-8?B?aWIyUE1ETDBKVUoxejEvRnRXRWordm9uaUlPemdsV04xRjdRd0d0MHVNL1BB?=
 =?utf-8?B?ZmhQNUE3UW9Lc2gzcHgvV3dQdE5ET0k1Ti9NMzhxeVVMdGk2bE9oMEVjMVlx?=
 =?utf-8?Q?UvVIvCXe8EFgv8gYLC34xJg4b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1abf316-0070-45e1-de73-08db61a60f46
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:10:05.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGchnVJlYqtWpIuhIoCj5C/XdS5G+Bn8ADRLurSwvE4CEhrU5KGLkW24U7jr/APxT0UZDuLRxqKz2r0giMkXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 5/31/2023 11:26 AM, Baolu Lu wrote:
> On 5/30/23 5:25 PM, Yanfei Xu wrote:
>> Checking NULL value of 'table' variable deserves a BUG_ON as the
>> following code will trigger a crash by dereferencing the NULL
>> 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
>> plus NULL pointer dereferencing can simplify the crash log.
>>
>> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index e98f1b122b49..8aa3bfdb7f95 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct 
>> dmar_domain *domain,
>>       if (sm_supported(iommu)) {
>>           unsigned long pds;
>>   -        WARN_ON(!table);
>> +        BUG_ON(!table);
>
> BUG_ON() is not recommended. Perhaps,
>
>         if (!table)
>             -ENODEV;
>
Agree:) It is always better to handle the error than crash kernel.

How about:
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c..7f077e3a4128 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1944,7 +1944,10 @@ static int domain_context_mapping_one(struct 
dmar_domain *domain,
         if (sm_supported(iommu)) {
                 unsigned long pds;

-               WARN_ON(!table);
+               if (WARN_ON(!table)) {
+                       ret = -ENODEV;
+                       goto out_unlock;
+               }

Thanks,
Yanfei

> ?
>
> Best regards,
> baolu
