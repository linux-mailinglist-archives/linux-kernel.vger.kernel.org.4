Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1F7194CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjFAH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFAHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:55:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CC6E4D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685605816; x=1717141816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JamNfFfFwjowlCsL09QTiA+m4k/8Lxk17gHkt3D4KMs=;
  b=TK33O1UJ48zVmfrLdFozfh3AN1aXL8MiHNaL8IxC/suIT/cJrmJz+mpm
   Idaj8i9/jezHIUpcLKc8vmitNS9wZmgbSbhEVTl4fAFzj69Bid+iLQZmE
   +siuLgTuZ6VwPnvQQ0nepXtaDmSFowVA0tqacj+22lAWRLjPTLjqXnizO
   x8Xb+87XmrInYyQKlYDXjoRzWMO0yaIA5/noeKyHNcUCK6x1aGKBSOhf9
   coTb3/1TUEx3JBXVnfgjESyatJS/rLXGwFmjFfkHkf8CzeUul4eL0raMk
   ZvCoGGgRRqFUEFYV+757cCEa9cUkgCqtW2znveCfSjlX9zzAyY6U3Uf/H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421267628"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="421267628"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 00:50:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="657658680"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="657658680"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 00:49:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 00:49:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 00:49:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 00:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mthpns5+2FbIIEVD6Xy6gMY0Ge0aS9CWUf/Blkl0aY6Zn2PFSZaLELv51KxCYfKGiyc7bM5LTfpM1ea5PVAVdj952RMC0Mm1OYDr4zafzlxuXC8HVgFDle4xGDXdP/GuELtNHxT26ZZJJRsFVr5tOh/KfMMRMyFJlS1AXSEcQmPA6QxvkvJIIJM+mX9i2H4Ljby7y3P23d/8CsnspOGYPjS5IroG0ozxVBsgCZM68kaDC/eauu250dTlCPQ9hH6fbFB7aaCRGLDvD0e7j7Lq+Ms9FDJyhEIBIgL0ZR3FYip81LhEvANB7nIqJXZ3ZjSraThk5q7qAhXQehatYjgilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbiD7kShnrt3MaxlmymWNEPfsgrn4Hfia0EymOHWyTY=;
 b=iR1WjjlHwTUebLAu7E/yE3Z7T9VXpUuI4iCtVIqQy9HJWgW7wzRhHvMZ6p44Lz9ABTM/RVDwZQN8uFCGSKuCoV/LdbTrQRGdJCRi9+rpwQcLdKe6IpZrFdEy0MZRPKvA3kpA71nvJhloDmbSxAYjsCMwtz15vZEgAopVwBvgDrpYsPwUI8E9nOhF9SV3ha8DC8SkYLSAFBoFTcvvtMyfBpcbkO8+d4A/CT/bkopgVB/4NK0nQifroN6OucOLAOhZToEbWPFLr1fv1ToizjfxrCIdZkDkzgw5GkAOiyMuZ9fvnsBj/DhDFGU2c+BnEr6w3iPXv9eWbXtCfRMFoGcBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 07:49:51 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::a01f:d6e:1b90:3cb9%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 07:49:51 +0000
Message-ID: <2efdc34b-555f-bce9-7e81-6ff2f3d2d8dd@intel.com>
Date:   Thu, 1 Jun 2023 15:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove the dead code in init_iommu_hw()
Content-Language: en-CA
To:     Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-2-yanfei.xu@intel.com>
 <3d7ce5c1-c248-a14a-2dc4-79449da9aa43@linux.intel.com>
 <35cff015-2408-b7bf-976a-b0ac8cfd6857@intel.com>
 <c8c0a8f6-751b-b9e7-ffd8-72859c0e3b12@linux.intel.com>
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <c8c0a8f6-751b-b9e7-ffd8-72859c0e3b12@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To DM6PR11MB4138.namprd11.prod.outlook.com
 (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|BL1PR11MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ba4aff-ab23-4cb5-fdf6-08db6274c7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwxPhD/c1hirg9FeLcUzMtRlXB87WYZy0qYa4sf9XNw7gvd3CTYpJDyzG9G3RXUQwktRxdK7VXC/uWBadWeRFA0MK9FKBpdxdlKQ0oQ1slAxNL5B//nKeCEhgoea7uRLN/0lAiU27qgU9VzhN/+qTI1ILrQD1CtyuQkvcUf7HhkM7oA57913hXOeXJhpgurLUarakXUBWaMf8/cFQzH9eYg/2/pr8d/uEsH2hnGw3pEH3ZH0sRzKNlAEVEEGXZWVaNZz0cOZrPZVpEboprsVWMDwCn6CFsciD8INU+olTo5OI+QtUrOJvkBlDTd9JuInc4Rp0Y4OQIAK4bbsuvbOZc2UU5CPoXcGq4Il37xnVJtJtJmQBL/Dt9XPfDxtNBTJVyU1ndVx/DjYOpf/1y3S+VPx1Rr+SGWr1A/rPArJVRXglryBW/wWsR+S7K65jjq3d8hjPaZoodccpJvzceN31YONgHCsdBMVv1aPleNBGaLIJgbSrjOzMJi7uI1uthOl2dn0Dnj9FLL+K/hu2ibOJylpNM8IfED+8veERre4Ja9tC3Ohr6MDuLNHIfYCNXqBhUR1yl6g2q6zkJlhFF+jouwB9a/C3da+B9/J4wpdEN5tWGLKrTEFXPDtVc5xhKm9FWbesdcEnz4P0SeqjtVjmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(86362001)(31696002)(36756003)(2906002)(186003)(26005)(5660300002)(6512007)(53546011)(6506007)(44832011)(6666004)(6486002)(2616005)(478600001)(83380400001)(66556008)(4326008)(66946007)(38100700002)(31686004)(41300700001)(66476007)(8936002)(8676002)(316002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVJM21JT2ZhZjF5bkgzYitmckI1MzNYLzZTSnpKVzRRMG13RXIzb3FIcE5n?=
 =?utf-8?B?UnBMc2NscHFjVVJ1c0hYSFlVRHJWMDVpZHVlM2tWeklWZnMvbDVubmRQa2VY?=
 =?utf-8?B?YytmamVIYzlMVEZaRGtPQm1WZ2RVa2R6eGx3NFVhNXlDcjJPazd3TVozTHNW?=
 =?utf-8?B?RlMyOGRBczhyU0laT1FBc3hSVGFpT3djSVRYeUo1OHYwbUNkK2UzOFNkZlln?=
 =?utf-8?B?dWMxcTcrZFJrN2xsK1pYME1VRlZVbXpSemUyT0lVem5VaXp2dWoyRG01cFdo?=
 =?utf-8?B?TlVCOTZaaUpJRHMyTzBoQlV0Q3VNMEJ6dm1uMWVwMEM4UjNTYjVhamh5d0tD?=
 =?utf-8?B?akRFVmlnRVd5YjBJcjVMNXFLK2hlLzFvOHJ0M05UZHpXSEZrN0syc085NndD?=
 =?utf-8?B?YzRzQ3VtQy9Lc01jL0REb0lkSDNSanN1emJHZkpTaDAxMGcxN3BRbVNzaFdj?=
 =?utf-8?B?bnc2TFo3M3lCcmVyR2tMSTdZZmxhTzRmS0ZtZHdOOWV5YS8wcy9zazg3djNz?=
 =?utf-8?B?L2pDRHA1b050emc5ZkFmVXpmVy9Uc0R4N0xqdnlBYlY1Q09IUEJzVjBmQnZO?=
 =?utf-8?B?bTFmSGtpMm1QWHpaMFN1TXh4YzN0ZWxVR1ppZGdGU2VQaHB1MkUwSjdCWmFs?=
 =?utf-8?B?cHRSQmR2anBOU0NXMmNDRVc2SE93Q1kvbVBaWkJaN0grWTk5WXNHTHhQbHBo?=
 =?utf-8?B?OVdlQUgvMWFvQ0ZuMU5KL1ZnSStBKzdOLzZVbzlFME9MVjdraDhLRUgwRVl0?=
 =?utf-8?B?dVROT2NFd2xrQzVWdCtxTWcrN1V0UmMvbVhXalIyUStjQi9uQThDNldlTVBC?=
 =?utf-8?B?TVNma3ArMTdXR2RnZStwcUpnWTBqbmFIdUs0dHYrR0xWRU1YelNjalYwMTdO?=
 =?utf-8?B?a0JuMi9mQ0hrVGFxVUVIMkVqYnFycStUa05LNkNldit0bUM3c1FkL2VwZ3Bv?=
 =?utf-8?B?dGpyMmg3REtnMENtcTU1YVphRFA3ZG45SnZyTk9WcVlZS1BXekNUOFd0Nmg0?=
 =?utf-8?B?TVlXYmVkb0tnUHlUV3h3NFY2VnA5eUwvZEpxZlRObS8yMFdZMjIyQ0o0MEhP?=
 =?utf-8?B?bU40bXJkdHFHci9veTE2MUVIQVVEVFZCWG5qQVRYR0ZGMngyUFZ3Z3VBOElY?=
 =?utf-8?B?aDA1T3hYSWpyYWV6QkVISm81dFpOWitqSEFLLzNQRHdpdjZzaXI5Ui9VYWJ4?=
 =?utf-8?B?ZDBrZ25aeDIwM0RLQUh0Wm9EUGN1Vi8ycE1NK0dmSVlXVmswNndzVjBPeGla?=
 =?utf-8?B?ZG5jOC9UaDQzRjdtREorUnduRmtrejVLdGVDcEZFamd6MGJhdXdIdWlsREEx?=
 =?utf-8?B?NHBLWXNYU2NrUFd6eHdjOEd6RFVEd2xxY2ZSTDVJdFBPMHlrQlZkbElwY2xh?=
 =?utf-8?B?RW8zV0gvU0hCVTBzTVlZTVRoWFJOYzdpSzdzK3RUalJ5M2duYThyTUIzYjlP?=
 =?utf-8?B?TDY2aGQ5QUFxNTNFRVZtdklZY0dSTUNXbE5aOGVIN1Npd295YkVERVpTYVdH?=
 =?utf-8?B?ZC9jRW5ZcmZxUlBYelQ0ZHJrRUFsaWkvV3krYVVhZ1pLOUk3SlBWK1RCRlBR?=
 =?utf-8?B?dFdMdHR3V2NmN0ZsOU0xQkF3bVk1WThuc0NNWXI5UEkzc1QxaFpPQXhleTJt?=
 =?utf-8?B?NHh4VzhxZXdXMVpCVTZIOWQ2YnBuNUdpOHZxRGtLd2hEMnAzMUNwOW9PVjQ1?=
 =?utf-8?B?Tm5jVFh2VjVjTGtxWlpLdEhOYTc5SjdSNVFKcXdXd2FLZ1BoM0gzWFhWelhB?=
 =?utf-8?B?VFlUYzZuNzFQNnl4RFQ4SW5TVEV3SG8waFZYTDVxQkZSMmtvcXB2SDNYbDNX?=
 =?utf-8?B?TkphaUdLY3RYVmVSYjN3YXJyRWk5bHZCbUJWRUhId3dIT3RoM24wYmJEYUtK?=
 =?utf-8?B?S0VGSTBzZGdza1huZkRjenNDbElCNVlmVHFkdElHcmpyMWZaOU5uWHJqaEN5?=
 =?utf-8?B?eTdpVFQxSHJYNTQvYnBKbGJHaXg1SlhRSWNRSGVlNDlQeDlIZTJJbGdmMUU5?=
 =?utf-8?B?c3RWUkVobDR3c3NCb0lVMDdxYWMzWC9ubG5UcXJ4aTNNMlRRdFd5Q1JCSG0w?=
 =?utf-8?B?SHJ5Q0c3NVh1Ylp4S0RKcHNKaHFtNEVObUtuUUlRUTZsZng2ZFZaY2RTdSs4?=
 =?utf-8?Q?j7VkdLEiufABkcff/OUqEXomy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ba4aff-ab23-4cb5-fdf6-08db6274c7ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:49:51.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+ErXqURusNQMNtIiybHoprDFMakOplF0+Nm5PlByCPdqk4sCVKiu4eKN9wy0DK+ZowYU2/tD1h7M/qJMFAugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2023 9:15 AM, Baolu Lu wrote:
> On 5/31/23 2:55 PM, Yanfei Xu wrote:
>>
>> On 5/31/2023 11:24 AM, Baolu Lu wrote:
>>> On 5/30/23 5:25 PM, Yanfei Xu wrote:
>>>> After 'commit 2a41ccee2fdc ("iommu/vt-d: Change
>>>> iommu_enable/disable_translation to return void")', init_iommu_hw() 
>>>> only
>>>> returns 0. If statement for return value of this function is 
>>>> meaningless.
>>>> Hence change init_iommu_hw() to return viod and remove the dead 
>>>> code of
>>>> if statement in init_iommu_hw()
>>>>
>>>> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
>>>> ---
>>>>   drivers/iommu/intel/iommu.c | 12 ++----------
>>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index 8096273b034c..e98f1b122b49 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -2963,7 +2963,7 @@ static void __init 
>>>> init_no_remapping_devices(void)
>>>>   }
>>>>     #ifdef CONFIG_SUSPEND
>>>> -static int init_iommu_hw(void)
>>>> +static void init_iommu_hw(void)
>>>>   {
>>>>       struct dmar_drhd_unit *drhd;
>>>>       struct intel_iommu *iommu = NULL;
>>>> @@ -2988,8 +2988,6 @@ static int init_iommu_hw(void)
>>>>           iommu_enable_translation(iommu);
>>>>           iommu_disable_protect_mem_regions(iommu);
>>>>       }
>>>> -
>>>> -    return 0;
>>>
>>> 2966 static int init_iommu_hw(void)
>>> 2967 {
>>> 2968         struct dmar_drhd_unit *drhd;
>>> 2969         struct intel_iommu *iommu = NULL;
>>> 2970
>>> 2971         for_each_active_iommu(iommu, drhd)
>>> 2972                 if (iommu->qi)
>>> 2973                         dmar_reenable_qi(iommu);
>>>
>>> dmar_reenable_qi() still possibly returns an error number. It's better
>>> to pass this error number to the caller of init_iommu_hw()?
>>>
>> Event dmar_reenable_qi can return error number, but there is no caller
>> check it. As below, only these two places invoke it:
>> 1. init_iommu_hw->dmar_reenable_qi
>> 2. reenable_irq_remapping->dmar_reenable_qi
>>
>> I think we can also convert dmar_reenable_qi() to return void:
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index a3414afe11b0..1432483c79e8 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -2112,13 +2112,10 @@ int __init enable_drhd_fault_handling(void)
>>   /*
>>    * Re-enable Queued Invalidation interface.
>>    */
>> -int dmar_reenable_qi(struct intel_iommu *iommu)
>> +void dmar_reenable_qi(struct intel_iommu *iommu)
>>   {
>> -       if (!ecap_qis(iommu->ecap))
>> -               return -ENOENT;
>> -
>> -       if (!iommu->qi)
>> -               return -ENOENT;
>> +       WARN_ON(!iommu->qi || !ecap_qis(iommu->ecap))
>> +               return;
>>
>>          /*
>>           * First disable queued invalidation.
>> @@ -2130,8 +2127,6 @@ int dmar_reenable_qi(struct intel_iommu *iommu)
>>           * invalidation.
>>           */
>>          __dmar_enable_qi(iommu);
>> -
>> -       return 0;
>>   }
>>
>>  From my understanding, dmar_reenable_qi() is used in suspend/resume 
>> case,
>> so the extended cap of an existing IOMMU hardware is unlikely 
>> changed. As
>> for the check of iommu->qi, if dmar_reenable_qi() can be invoked all is
>> depended on the no-NULL of iommu->qi at first. How about using 
>> WARN_ON for
>> both of them to simply this function.
>
> This seems to be heading in the opposite direction. Actually any
> operation may succeed or fail.
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b871a6afd803..ecc2007a96f9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2967,10 +2967,13 @@ static int init_iommu_hw(void)
>  {
>         struct dmar_drhd_unit *drhd;
>         struct intel_iommu *iommu = NULL;
> +       int ret;
>
> -       for_each_active_iommu(iommu, drhd)
> -               if (iommu->qi)
> -                       dmar_reenable_qi(iommu);
> +       for_each_active_iommu(iommu, drhd) {
> +               ret = dmar_reenable_qi(iommu);
> +               if (ret)
> +                       return ret;

For confirm, you mean this?
@@ -2967,10 +2970,14 @@ static int init_iommu_hw(void)
  {
         struct dmar_drhd_unit *drhd;
         struct intel_iommu *iommu = NULL;
+       int ret;

-       for_each_active_iommu(iommu, drhd)
+       for_each_active_iommu(iommu, drhd) {
                 if (iommu->qi)
-                       dmar_reenable_qi(iommu);
+                       ret = dmar_reenable_qi(iommu);
+               if (ret)
+                       return ret;
+       }

If drop NULL value check of iommu->qi, dmar_reenable_qi() may
return minus value to break the loop of dmar_reenable_qi as
one of iommus doesn't set up iommu->qi.

Thanks,
Yanfei

> + }
>
>         for_each_iommu(iommu, drhd) {
>                 if (drhd->ignored) {
>
> Best regards,
> baolu
