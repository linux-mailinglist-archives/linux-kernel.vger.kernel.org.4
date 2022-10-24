Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAD60BB33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiJXUvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiJXUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:50:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695E4F6152;
        Mon, 24 Oct 2022 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666637865; x=1698173865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4HNDXePTRP0Chmi/v+wAZzBHpzS2igY2kTkVJK06Gb0=;
  b=eEFRJgFsm6o1qChnfnzRu5u5v2HvJowPEeOw1pjahw77GfQua1XXxIpX
   tvQRNZ6+46x6VxFQQ/M82va+JlxzQkfNvJsihTwYOK7gsHWUbgvwwSCSJ
   rd63uMuTtJl+jHvXbe8NzMk5ktRMvk8itQY/oMRrNqf2nzzdw0xOjtZgq
   xzV4hEF0qnGsU+t5Krp9gCCVuidFe0nWrq3p9DVepaDA2brTidoDD4It8
   bUT8Mz39myZmCbRSKfIRHokWAzvpt+FSb5IAwOXcsM+qVgRPx1QiASbZc
   zunyLegCawA0w5YFoU38btcoQvFKLQNCaRRb00P19IyTPL04rPJLDMZ0N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308589999"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308589999"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 11:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582510031"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="582510031"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 11:56:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 11:56:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 11:56:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 11:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KosY/MC1rpQYmhtqF1hP6rp5TxG+EgOuswvPZkZGmSzOjy8saH4YKjyTfURaOb6ImaZHrq7jzoZIs6pjT/ck1amxhZPs0ju2FJZzeFde9hVqdb/zxa06hc7nej+M+F0N/8BDoLWc8wruHHqNh/CD0dLrcGu5Fxc1GHMSpIPIhvzmR5TXUczzWBUs781z/11jnvVc3qzHw+8F8lXe8cMHBGf1O3ZSp2G98p+yhKQNUcMv5riSWpo87S9ijpR2vxs81vbhCZNrmkf1JnlEnBUg2SazzQRnwtmcQUWHJzlf8UbgaspVOr0se0qO/gc+rmP3KE8aJ7z1XnplUsvoLrnceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRJSUrmwEn0oW1/f/lHliKiPhiUvut15U+14ShuJQWo=;
 b=jnHkWNE9d4xIT6RaaRz3OdbsPql8PWB+k57MHCl6CRkdSg6fD1wl7Myaw9AhLjnLoZTN1vojV3mlTKyYyDTX6n4tmH7YYDn1hhbk8oWL5flUX4rTq/BVN2RxHbDsbepWNOXJnZAxGD1YMs40zo8BDsHfOtC++p4HgdowgT+CD4IJyCfcO6x6m5E58OUlS/+zsJFFHVFeGZLsgAFZT3182T6a87VHN/C7PUH6Dp2MTdATXHikMmtg+wQqJTShWyIxmOLrHl5XGQHNazyTMAfuIse8enNXuRULRm801f5aoGkwMryBvtseglVzvCV07uDjkEl+dmfB5zen52B7pTioXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 18:56:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 18:56:42 +0000
Message-ID: <77943714-b988-bf14-8795-c72ff0424418@intel.com>
Date:   Mon, 24 Oct 2022 11:56:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH] x86/sgx: Reduce delay and interference of enclave release
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <md.iqbal.hossain@intel.com>,
        <haitao.huang@intel.com>, <linux-sgx@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <06a5f478d3bfaa57954954c82dd5d4040450171d.1666130846.git.reinette.chatre@intel.com>
 <Y1WemizNZgFOVxja@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Y1WemizNZgFOVxja@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c787644-1bfa-43d3-8b4d-08dab5f17d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrIG8fDpX8qd1HSJmtYLdYhbySTdXXOWpBfY3lgIE1jH8dpxEEsAJAu/v68Bf5COyDAwKpQo2T7i5sT4w5Et3jGSwdw2kGWfU8KRFdTLDYtxuS2jfZOVAAWPvzILcWKHbS908WU9lwwAa1O+wyq/sSCRrk8scGbKURiC53UsiHfGreAxQI2Xwrp8ebwJqS/l0d9/qxBFzdQLTuNQOme9SMk7aq0IQ9tqZv+sJuRANKLBxH9H2h8cKTyl4xXyTFnKZ3WOxd/gNqSWBW/wW5f3R3IbeyiX3qx3JcmkBGjXflP/nDmk3b2z6+AP+NerwgQystmbEJtCqsT8h9p7g7HibvsIwKAZpFwd0RtGIfzLiy1+Fdg/eiTy7R1SBCoa3YjtDFig6ulVG+dKRzV5ws0WcfIz5Q/UcY4scZxPNfanZ6CzbaP0h1BhVaSzaUziJsIxJcrIYdReqOUL7uhTKeUSYWRWnvibFmpoKZhu2EMmfmigeSOvmlGBXP0GfI6bYoPUjG43P2OD0qkYop9+yA/fnetvgqQLUQAjf1p1+V7CeDJb69VmpFEiOQCLdgjm8zKv4eAnr6/FeT5fUdMuJkWw16sIX6oc1SrGa+3pvRlalnfIO5W2gHHrQ+JMccQB/N+JmHlvtNR+7yM1NNLAjIiEEDPqMn97zgOozqYI9qEZCwtgGQep2NAMWDvX+ITZsT+E6hBWdacAVv9SXzu6vYoIKVv/XOFPp9CWVuLA6k0UGrKk5/bglu2l4BrnIobB/vwr/RXJijW3nwHo/XfgJLkv28rwWS5Z0itXsCYTjZItrMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(31686004)(36756003)(38100700002)(31696002)(41300700001)(82960400001)(83380400001)(86362001)(186003)(66556008)(26005)(6512007)(6506007)(53546011)(2906002)(6666004)(2616005)(8936002)(44832011)(4326008)(8676002)(5660300002)(478600001)(6486002)(6916009)(66946007)(316002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NQRkJXZ3N3L1l0QVFqQ2NsaUd3b3hTZFE2Q0R0Z1pWKzF5bFB0dEJHeWRM?=
 =?utf-8?B?VEo2d1QvaU5lOUdRMS93Zy93K1g5ZG5iYlRmRndoS3RuOWYyaUh0aGJ6L1dk?=
 =?utf-8?B?WEpqTkF4aGY3Z04zRUt6YW5JVisyU1pDdmtFWnRqWTd6NTF0TjVsa1FSUXRI?=
 =?utf-8?B?ZHRscHBVRFJJVUpkYmYyQzhyNGFjTmo3UEJrUjZ2eTNqYTJuY2NhYkRnM1Rn?=
 =?utf-8?B?ZXlUclVvQXdNbWVkeGtPWUpWM2RMdnVsT2Z6cjMzVTZzMFZIY1lsRjNaRlhS?=
 =?utf-8?B?RTNKRzlFbGY4SzY0anlNNnZ0eFFZWnVzOVNPcDJZWUJ5UWhMbVY0S2ZDeUJz?=
 =?utf-8?B?NEhoTmdVT1hpY0luZk1hWWwyT0lTVW9KUkx0S3N3MVFnZDNzTnBDMmErVlRC?=
 =?utf-8?B?MU00ZjE4YTlOSFBOckJCY0l0eGdweW5NYzJvdjZhWG5PbGJWNDZWdENBTVpy?=
 =?utf-8?B?K0RXbjNaNHcwRnRPZzh6akw2ZlVwZFVZMTN0VERNVHM0elo2QitLOHhPelFD?=
 =?utf-8?B?K2diQ1lXZXdLVzVXR2RrK2Z0TlBMajlhaDYxVzgraFgzK0ZxNXZjZjhkaU03?=
 =?utf-8?B?YklKcDluemcyWkF3anFPUUgxVW42VU43Qlk1eDd5eTZaRi9FUXRITVl5aDVk?=
 =?utf-8?B?VDBxUTk5T05FdXd5QldQTjVPWjZBdGRTdFIxZVZVSnlJdlFZejJBemRwTGRN?=
 =?utf-8?B?cEk4TE8waE1wNkkrN1JOamhBZ1QveUQxVWRPZjBReE1wZ1FyRDV5NHJYSzRy?=
 =?utf-8?B?NFJRUkxHdndQSDlpUnRhODB3dlhMeWk0UE1FTmJYWWQ5TzI3U0t4S3I4SzE4?=
 =?utf-8?B?NFlNYWc1WUFlcndPTE1OaDZpNUpPNThSdDkxQmVDMEFPSFRoc1EvZXZ4M0xZ?=
 =?utf-8?B?aVcyeDNHMXlWaXJkdi9Fb0ZRMjd0YVY2anNxamhlZXFYNHFQbEh5S1ovM0pH?=
 =?utf-8?B?OUhjV3pueUdkTCtESW5FQVo3SDEvanNEU2dqRVNjWms4OUJQeG5QcmZDQnRV?=
 =?utf-8?B?RGJTdGRBc2tVOG50QzdXck02ODM3ZGxNSHF2dlIzL0pyNlpBd1dlK3p5c2E2?=
 =?utf-8?B?SXh5YUR0cEJ6ZVArUTh4NklMYXA0QlIvWHRZY0JVL0pNL0tyZlFPdjhPajZ3?=
 =?utf-8?B?ZEJYQWdZcjJMYlBWM3hJWldUVFBoVzZOU3QxQWZzZ25oZ0YwQm9yN1FiNkdv?=
 =?utf-8?B?ZjVaTUdaYVllbTU4Vmw3NUFXTDBIeW9vS2ZuVU5PbGRYWTdoOWdKOXByZWp0?=
 =?utf-8?B?Um1Jd0dHczhUejlUQXc2SDBjZXYyS2N3UlpZaFNmL2RWNnNvVGpNY25iTVR0?=
 =?utf-8?B?WEV0NGJTSDcvT1BBVUl0Z2M1eVllaGRjSloyM2dDMlhuN0JJYTdkZkN5M3RP?=
 =?utf-8?B?M1AwMWRRdExLMHEvVDR0ak1hckk1alpwa2Frd2hGeW4xWGdiellsUnYyZnZH?=
 =?utf-8?B?bDUrejNIVC8xbWtrNjc3eE1RWnYwak1mY1RpMkZWMk1LVE5ZNzJUeEtPaEo5?=
 =?utf-8?B?YVloQ2EyNCsxVGQvZXFmTHRCcHIrNk9Vc2JweDFkdUdLMTJsbEtxS2dFaWZm?=
 =?utf-8?B?Y1kvL1hLVTV6N1JjTW5qbndJZTR5TVJ4TGJEWlhaT3JKOE5wUVU3TnpTQ0JL?=
 =?utf-8?B?czlhTmE2QVpGVFIvc0tQMWJaK3FhNW0yRzJ0Njh2bWdqVWU0RlptUDZRZ1p0?=
 =?utf-8?B?NU9HSmg4SlNyak9uaUJ2aHROZk1XZlUvT21KcWozT2IyOXlzTnlMSjA2VmtM?=
 =?utf-8?B?UUVMVGxtTEp5Mk8wUVRnK1l2ZVpXUndkaVYvdFNkL3BGbmYyc1llZ21tSzRr?=
 =?utf-8?B?UTV1dmYrdnl4RFZ1Nzl1NXdrK3BrTFFXYVg1RFFtaUJEdVluVm5KTGROOE5X?=
 =?utf-8?B?VGdyRklCTUtPNDZYMzk5NFNEL2t2dmh5SGVUeFd6d1d4UnYvTUlOMGRlUzht?=
 =?utf-8?B?bDNhYy9UVE1jQitLbHg5MDV1WFpUSlgvcFZEQytybDFFblk2d0g4b3RVR3Ix?=
 =?utf-8?B?TzVqTE8ycEhlVkl0SWYyeVBTZlhZSDdVS0ZnTmhPVkJqclpjT1dUa25yR0Fs?=
 =?utf-8?B?anYvOGlkUE1UUlVGSnVKMHJlVXU1V2krMTk5ZGFtVGc3c2pKME43WlU1VXBQ?=
 =?utf-8?B?MkdxR0Jvdmo4UjdvUUNRUFh3ZHJCN3l2ZnhhTFpjai8vZVFMaWlGVm44bEx4?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c787644-1bfa-43d3-8b4d-08dab5f17d3d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 18:56:42.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S6mTnSJRwYjYKUDdleqtXBrzUWiVa4bo/tH6sUoZ9rVsyssKUbXE69fuRrJYUOAEwhp+kGOatRI5YKXqLoZApJV1lG2zX/i6hlmkM8PHUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 10/23/2022 1:06 PM, Jarkko Sakkinen wrote:
> On Tue, Oct 18, 2022 at 03:42:47PM -0700, Reinette Chatre wrote:

...

>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>> index 1ec20807de1e..f7365c278525 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>> @@ -682,9 +682,12 @@ void sgx_encl_release(struct kref *ref)
>>  	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
>>  	struct sgx_va_page *va_page;
>>  	struct sgx_encl_page *entry;
>> -	unsigned long index;
>> +	unsigned long count = 0;
>> +
>> +	XA_STATE(xas, &encl->page_array, PFN_DOWN(encl->base));
>>  
>> -	xa_for_each(&encl->page_array, index, entry) {
>> +	xas_lock(&xas);
>> +	xas_for_each(&xas, entry, PFN_DOWN(encl->base + encl->size  - 1)) {
> 
> I would add to declarations:
> 
> unsigned long nr_pages = PFN_DOWN(encl->base + encl->size  - 1);
> 
> Makes this more readable.

Will do, but I prefer to name it "max_page_index" or something related instead.
"nr_pages" implies "number of pages" to me, which is not what
PFN_DOWN(encl->base + encl->size - 1) represents. What is represented is the
highest possible index of a page in page_array, where an index is the
pfn of a page.

> 
>>  		if (entry->epc_page) {
>>  			/*
>>  			 * The page and its radix tree entry cannot be freed
>> @@ -699,9 +702,20 @@ void sgx_encl_release(struct kref *ref)
>>  		}
>>  
>>  		kfree(entry);
>> -		/* Invoke scheduler to prevent soft lockups. */
>> -		cond_resched();
>> +		/*
>> +		 * Invoke scheduler on every XA_CHECK_SCHED iteration
>> +		 * to prevent soft lockups.
>> +		 */
>> +		if (!(++count % XA_CHECK_SCHED)) {
>> +			xas_pause(&xas);
>> +			xas_unlock(&xas);
>> +
>> +			cond_resched();
>> +
>> +			xas_lock(&xas);
>> +		}
>>  	}
> 
>         WARN_ON(count != nr_pages);
> 

nr_pages as assigned in your example does not represent a count of the
enclave pages but instead a pfn index into the page_array. Comparing it
to count, the number of removed enclave pages that are not being held
by reclaimer, is not appropriate.

This check would be problematic even if we create a "nr_pages" from
the range of possible indices. This is because of how enclave sizes are
required to be power-of-two that makes it likely for there to be indices
without pages associated with it.

>> +	xas_unlock(&xas);
>>  
>>  	xa_destroy(&encl->page_array);
>>  
>> -- 
>> 2.34.1
>>

Reinette
