Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA76723491
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjFFBeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFFBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:34:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330AE6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686015241; x=1717551241;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6SbPRYpdS/0qRq7cEGGrNEYW95q/RQyWFS5zqu7EdTU=;
  b=BNnZAUJcck2WxqevolSOggssLJptQ20qeEOcCL7ZjVgjVTEVwvyEOqYJ
   qnTTZkgBIQ0sFK2I5C8RuGlM5sFQbfB5TjBpclKbNKogpnQa2PJW2nWew
   C4f1YP8+tkrrjkOaIfe6ddF85ZJik6JKj1RQ6HuRTOtuvSnNpWCzMFCHx
   QLu23hEweiaXA1lD8T9un2+pPn66PDLNb4n2gxWzCaqLbQZKUDZ2jiOUa
   A6jTVwCGTJlgkxr2ciuWQCDFnrBxlazHwmUyBi2b8gJ6IW+/omzI7efRe
   PI9HCfftsVnsYWinwGQBP3WqhgJkWXsFtWujVzvL5VygfSXUA9J0vbZlV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="358984175"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="358984175"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 18:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955546905"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="955546905"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2023 18:33:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 18:33:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 18:33:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 18:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9028b93ufxjjM+rqqYdcW981zaBJXFOPkMX79m2LSf3eWpfHtF7I2keVms9KKyVhU4PPdwkMOBSidNaPefm5EO05SKkcptVM38Riqn9NWEH9xSJxwIokb/T39jHFc5QuP9Ia+pgPrKm/eX0/f6hJJbEGGlr9mBvmpF31iaYMHTl0PHGhzLOKLWICiVUPjMwM1W6UXGUIH3GrJ/X+8WITDaNN+NHCCHFGBcwflHhZE1c7PDMqChhoBa0zcMA21NwBDc6pu0zadBN1kEDvege9f/N/belAfE0mOMVfnTgeJJyYzn0RlJq+87HAwzzBZ9cA9eTVfACcrd08V+wJSomYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjfj0b2KYZJI66ZP2Khqi4Q2tHf7k0ALW/ZqKMpC0VE=;
 b=IV1zWH9OVvsLmyloX18RZVJ06Tv/Y1lEW3hA36anxlc8zg/suQ/rvxw7PJpkQb6wr4bjpoePbUvbhX1JgbwUtHQ60CTP2CWvsvBOdC2TDdF8YBeauUwRMfh7/KN4SCnxTYXv9hdYgLPcHCJ1ZCyqwPm3NA+4liLIwPpId7ajShNg6wuX+UUFMyIYd0DEl/Z8N+4Emyaf+9kFjNHDjxKdLhOkbt51EUUtbt1IZrqG+oODFsaSg7jNZiVAN0L+XGgRNCDb0dILnEC2dhOlNE2qURBQ1ngEaUa7ehcLpUVvztxTQ9xrRGoLqvzkmKTW7ZCcUFuUITGdPJguXNouKxKAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 01:33:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 01:33:38 +0000
Message-ID: <340c77d2-4fd7-d08a-c9a5-fdb5541e9371@intel.com>
Date:   Tue, 6 Jun 2023 09:34:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230605140344.66pwpdg5zgb6rfa7@revolver>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: e14ef3fd-6715-4639-b198-08db662e0d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ld8I4qEFqMIQoCZgpy2+vOa5rc+5/J1DQPnbQYNJdEK/2oa23dSCSvnvotDCRnAhaif260IBGP9lJoDhkNg9iu2Xi7x0mytEEFqNzk42a0qjUTZbkIOjd56uwqQgGpS9tn2VaqxFVmegETR4gZDd7ZIYJNTxCEahJaRSmGZvU1GmI+r4+VChErzRrGg3YYxGSGKcfGPl9yaPpnAaApZix9/uFAaoHIdr4SmpmaW5Xb0GWppuyUp52Led6Ho+Zq64t1uerszEzDgJVuY783jcYqJ2lC5rdjVJFA3/UDMGpVheGW3zZom2rc/eRXzAkNIqm7YAQYV5uRXICX7M1HW73lyC6zz0tTIoiCyBuMrW0Z28xiXSHa9cWTDms2mkdntrSX+T16FGlKm2zjAYbDsLwz6bIoGuUQGBTCSI15/qXBkMfAsIVIuknmfSLMhmTNcX2CWxBrvf6nlghx7AFNGIcaQIAym2LKrQXSUsuf4Kw+q7x3cz4JWOv0oe4HHNvZPcZvZDwsWOJKLIdL8boqkt9L/gfDzgknT9YgROkuLBvassdcO8cdPT9AvPPiVtMbSGKLVA2IigqZJ9JH85BW3AJCIeFg6ESxeT/P8SweEIYe2nSFK1FTjcb914/wy7QPtstGLX8BuMvG+lnCNeyGtR9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(83380400001)(110136005)(38100700002)(82960400001)(966005)(66476007)(66946007)(6666004)(66556008)(478600001)(6486002)(186003)(36756003)(2906002)(2616005)(8936002)(31696002)(41300700001)(8676002)(86362001)(316002)(5660300002)(31686004)(26005)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhUTUtqb01DOC9hVG9Pa1Nid0xoUm1CUXlRd0VYTk5jL29CNGFmUjkyY1l3?=
 =?utf-8?B?VUNUbDRVcjJuL3U4OFVVMlJSL0E1dStUSU9jMFZWd3M2VkZiVGJLazVYeTE4?=
 =?utf-8?B?ZGxOanM1WmNKMjAxdjlNT2RXSld4WjdBUkpYSWxvSzVyUXNSVXgwRDkwaWxp?=
 =?utf-8?B?Z3ltcU5Ec0U3dVhYWHRtV1hQdzVKdm5lYWd1Umcrd3B2aDU5L3NheUViSlIw?=
 =?utf-8?B?K1RJeG01eWdwTjJRTFlLN0RyWjhpdWw4TWpFZlp1eE5sU3pjZnJvWGhZc0hn?=
 =?utf-8?B?STl6MVdCOWVsSFJpYk9EcUEwbnVub1lGL3g0STZ4dHQ0VStjYmQwVXpJTzZI?=
 =?utf-8?B?V2E3NnlYNlVMY2x4SGxEaERVSjh2TXl4NjMrRGc2ZFpmOWJWOU5sMXl0N05o?=
 =?utf-8?B?QUQxU3pQSXlpdTVYMWk3MnJxQkJkMk1TVXoydlJMOVJWc2ZtaTZhajVLcW9y?=
 =?utf-8?B?Z1hENmxKMnVTaVZiRzRDck82aytPWEYxbFZEQ2xSSGpGZUs0Yk1CalJGTlRu?=
 =?utf-8?B?ZG9JaklYQWdiazhCdGgrc3ZIcDYzZkhuTG4xdzc4OXJXTkJyMnpUdzdXNEc5?=
 =?utf-8?B?OGlnT3RBM1BIMkUxb0ExZGcwRXg1OGhhNHBZOUJkMnY2QWpSbEVYcjZ1bWFx?=
 =?utf-8?B?T1F4NzhPd3pNSHo5b1g5WnkzTXFVNGhkQURLak8zRVU2elh4UTRWK3FaVWov?=
 =?utf-8?B?ekRnSWlDNlJhbWpCT3ZLVHpWQ1FlL0loaU1NVURnUmhmOUVXTllXMkhSNDZN?=
 =?utf-8?B?SFY0Z1dpcTlxbi9vWW9TbmtOajdRRXdmWnA0WUFPY3RUeHl6enVTVnJlYzI3?=
 =?utf-8?B?Q1dxUFJ0RysrU0g0YlN1Y2tZVkRmZ243dmJwN1Q4Nk11TzBnclhGWlpiY3dq?=
 =?utf-8?B?OUhUV3hZVS8xeDlvU3NoaUNUMis3MjJvRXJzaVpySmpTbWVUTnlSMHhuUDQ1?=
 =?utf-8?B?ajQwQ251a05JWkxZSzVabFFPcEN4dzkyYkQzRU9JQWdJeXNmMU5kTjk3TWlp?=
 =?utf-8?B?S0FoNlJtNUdieVFrM1hZcUxrdmh2TVVXc1A5Vm00Y2lnTFRVaXRvelpTWkRs?=
 =?utf-8?B?R1hXcEd0bHhiMnRQbGhkNzlVYUdUOVo5d0czeXowZDNOTjNNUTV4d2xEYmhY?=
 =?utf-8?B?M3c4KzlyUlhrUUdNQ2xzRlQxNmUvcnczcHkzZjhMVGVGWk51Rkh0YjdZQXM4?=
 =?utf-8?B?Sk1lR1FRYXY3bnRZSkFNWkszem9MNjFDLzcxZnBtbjc5eW5HekRUay82ejFh?=
 =?utf-8?B?MVlZN0J3Y3JPbU15bExqRTdXNW4xSSs2Smo0cGRUdXZuc0FEYTB5NGZUUVBa?=
 =?utf-8?B?TWsvY09tNThLQkFnanJ2Z1NKRDAyRnAwM2l2Yi8zd0dqQzNSeU92RlBRTGxK?=
 =?utf-8?B?U0RSS0JmaXZsR0JGb0pZRTBjc2J0KzFIYTBpWWZvVHpYbTJ0WnpWQ3Uydmxn?=
 =?utf-8?B?SktRTFpkbmdSMUtjQ3F0R2Rjc1g3dVVKa1ZoKzRGcTBTUkUvZEdKWFp6OFhY?=
 =?utf-8?B?bmtIWGlPRVlSZEpuZE1OalVndjRFekFQY04xNDZBV3BWQ1VXQTMzWkJCUlJS?=
 =?utf-8?B?bVJwRjh5Q2pyUjhKWlZWaFlmc1pITmNhU0pvbnR3UmNWNGdyb0luUWtGUVMz?=
 =?utf-8?B?NStwTTA5bHdJSUFmaE9jdjd5Q1NPSmpSUkJ4RzE0U2lqTlkrSUxkc3dpeUg3?=
 =?utf-8?B?ek1oRy9aL1FSa0VmR0ZSWm1rNGcwakxKNVBtRnk0ak5NcVlOY2xLY1gxVkVp?=
 =?utf-8?B?Umx2ditDT2Y4Rmx6NlBSMnZtSzNxN1BRdkVjTVdHZ010Sk1Sb0xocWgvVGlL?=
 =?utf-8?B?SWtLWDdydSs3ZEViQ2tYbm1nQTc1bjJHT1FVd3d2M0JWWjBjclR1L1NnQzlN?=
 =?utf-8?B?Zm1ZN01QdjdMRm8rY0NEWUNzWmxjOW1rQXJnQXl1S3FBVDhmUUpiZThTK2p6?=
 =?utf-8?B?TUFMeUFXMlBFQUVZcEFXalFCWXZVWnpDMnc2NVVBRFlaTHVoK1Jxb2p4NG12?=
 =?utf-8?B?WXY2TGRNdW5JdVoyWGtRd05SMWhOYnE2TUgxRHp5TFh3VlRVNFVrQTVTMERv?=
 =?utf-8?B?aEkyUTJ0YnBZS2xySldQN3dkOHpIT2JuUGpHaXpNT2liMEM4UzhjNXljS2dX?=
 =?utf-8?Q?MGwE7gyY4tK2SQbaIJ0UogZGE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e14ef3fd-6715-4639-b198-08db662e0d18
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 01:33:37.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp1UlfjX/jrCiiTFG6bE7alBr5RZg2hCztfXAPwgiov2EDvQX9M4QotX8qQxRmWZ8H6ymHMVcrjfPgU8w+lIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/23 22:03, Liam R. Howlett wrote:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230605 03:59]:
>>
>>
>> 在 2023/6/5 14:18, Yin, Fengwei 写道:
>>>
>>>
>>> On 6/5/2023 12:41 PM, Yin Fengwei wrote:
>>>> Hi Peng,
>>>>
>>>> On 6/5/23 11:28, Peng Zhang wrote:
>>>>>
>>>>>
>>>>> 在 2023/6/2 16:10, Yin, Fengwei 写道:
>>>>>> Hi Liam,
>>>>>>
>>>>>> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>>>>>>> Initial work on preallocations showed no regression in performance
>>>>>>> during testing, but recently some users (both on [1] and off [android]
>>>>>>> list) have reported that preallocating the worst-case number of nodes
>>>>>>> has caused some slow down.  This patch set addresses the number of
>>>>>>> allocations in a few ways.
>>>>>>>
>>>>>>> During munmap() most munmap() operations will remove a single VMA, so
>>>>>>> leverage the fact that the maple tree can place a single pointer at
>>>>>>> range 0 - 0 without allocating.  This is done by changing the index in
>>>>>>> the 'sidetree'.
>>>>>>>
>>>>>>> Re-introduce the entry argument to mas_preallocate() so that a more
>>>>>>> intelligent guess of the node count can be made.
>>>>>>>
>>>>>>> Patches are in the following order:
>>>>>>> 0001-0002: Testing framework for benchmarking some operations
>>>>>>> 0003-0004: Reduction of maple node allocation in sidetree
>>>>>>> 0005:      Small cleanup of do_vmi_align_munmap()
>>>>>>> 0006-0013: mas_preallocate() calculation change
>>>>>>> 0014:      Change the vma iterator order
>>>>>> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
>>>>>> this patchset.
>>>>>>
>>>>>> The result has a little bit improvement:
>>>>>> Base (next-20230602):
>>>>>>     503880
>>>>>> Base with this patchset:
>>>>>>     519501
>>>>>>
>>>>>> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>>>>>>     718080
>>>>>>
>>>>>>
>>>>>> Some other information I collected:
>>>>>> With Base, the mas_alloc_nodes are always hit with request: 7.
>>>>>> With this patchset, the request are 1 or 5.
>>>>>>
>>>>>> I suppose this is the reason for improvement from 503880 to 519501.
>>>>>>
>>>>>> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
>>>>>> mas_alloc_nodes() call. Thanks.
>>>>> Hi Fengwei,
>>>>>
>>>>> I think it may be related to the inaccurate number of nodes allocated
>>>>> in the pre-allocation. I slightly modified the pre-allocation in this
>>>>> patchset, but I don't know if it works. It would be great if you could
>>>>> help test it, and help pinpoint the cause. Below is the diff, which can
>>>>> be applied based on this pachset.
>>>> I tried the patch, it could eliminate the call of mas_alloc_nodes() during
>>>> the test. But the result of benchmark got a little bit improvement:
>>>>    529040
>>>>
>>>> But it's still much less than none-regression result. I will also double
>>>> confirm the none-regression result.
>>> Just noticed that the commit f5715584af95 make validate_mm() two implementation
>>> based on CONFIG_DEBUG_VM instead of CONFIG_DEBUG_VM_MAPPLE_TREE). I have
>>> CONFIG_DEBUG_VM but not CONFIG_DEBUG_VM_MAPPLE_TREE defined. So it's not an
>>> apple to apple.
> 
> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
> have it as a different commit id in my branch.
Yes. The f5715584af95 was from next-20230602. I will include the subject
of the patch in the future to avoid such confusion.

> 
> I 'restored' some of the checking because I was able to work around not
> having the mt_dump() definition with the vma iterator.  I'm now
> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
> have added these extra checks.
No worries here. The problem is in my local config. I enabled the
CONFIG_DEBUG_VM to capture VM asserts/warnings. It should be disabled
for performance testing. LKP does disable it for performance check.


Regards
Yin, Fengwei

> 
>>>
>>>
>>> I disable CONFIG_DEBUG_VM and re-run the test and got:
>>> Before preallocation change (7be1c1a3c7b1):
>>>      770100
>>> After preallocation change (28c5609fb236):
>>>      680000
>>> With liam's fix:
>>>      702100
>>> plus Peng's fix:
>>>      725900
>> Thank you for your test, now it seems that the performance
>> regression is not so much.
> 
> We are also too strict on the reset during mas_store_prealloc() checking
> for a spanning write.  I have a fix for this for v2 of the patch set,
> although I suspect it will not make a huge difference.
> 
>>>
>>>
>>> Regards
>>> Yin, Fengwei
>>>
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>> Thanks,
>>>>> Peng
>>>>>
>>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>>> index 5ea211c3f186..e67bf2744384 100644
>>>>> --- a/lib/maple_tree.c
>>>>> +++ b/lib/maple_tree.c
>>>>> @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>>           goto ask_now;
>>>>>       }
>>>>>
>>>>> -    /* New root needs a singe node */
>>>>> -    if (unlikely(mte_is_root(mas->node)))
>>>>> -        goto ask_now;
> 
> Why did you drop this?  If we are creating a new root we will only need
> one node.
> 
>>>>> +    if ((node_size == wr_mas.node_end + 1 &&
>>>>> +         mas->offset == wr_mas.node_end) ||
>>>>> +        (node_size == wr_mas.node_end &&
>>>>> +         wr_mas.offset_end - mas->offset == 1))
>>>>> +        return 0;
> 
> I will add this to v2 as well, or something similar.
> 
>>>>>
>>>>>       /* Potential spanning rebalance collapsing a node, use worst-case */
>>>>>       if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>>>>> @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>>       if (likely(!mas_is_err(mas)))
>>>>>           return 0;
>>>>>
>>>>> -    mas_set_alloc_req(mas, 0);
> 
> Why did you drop this?  It seems like a worth while cleanup on failure.
> 
>>>>>       ret = xa_err(mas->node);
>>>>>       mas_reset(mas);
>>>>>       mas_destroy(mas);
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Yin, Fengwei
>>>>>>
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>>>>>>
>>>>>>> Liam R. Howlett (14):
>>>>>>>     maple_tree: Add benchmarking for mas_for_each
>>>>>>>     maple_tree: Add benchmarking for mas_prev()
>>>>>>>     mm: Move unmap_vmas() declaration to internal header
>>>>>>>     mm: Change do_vmi_align_munmap() side tree index
>>>>>>>     mm: Remove prev check from do_vmi_align_munmap()
>>>>>>>     maple_tree: Introduce __mas_set_range()
>>>>>>>     mm: Remove re-walk from mmap_region()
>>>>>>>     maple_tree: Re-introduce entry to mas_preallocate() arguments
>>>>>>>     mm: Use vma_iter_clear_gfp() in nommu
>>>>>>>     mm: Set up vma iterator for vma_iter_prealloc() calls
>>>>>>>     maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>>>>>>     maple_tree: Update mas_preallocate() testing
>>>>>>>     maple_tree: Refine mas_preallocate() node calculations
>>>>>>>     mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>>>>>>
>>>>>>>    fs/exec.c                        |   1 +
>>>>>>>    include/linux/maple_tree.h       |  23 ++++-
>>>>>>>    include/linux/mm.h               |   4 -
>>>>>>>    lib/maple_tree.c                 |  78 ++++++++++----
>>>>>>>    lib/test_maple_tree.c            |  74 +++++++++++++
>>>>>>>    mm/internal.h                    |  40 ++++++--
>>>>>>>    mm/memory.c                      |  16 ++-
>>>>>>>    mm/mmap.c                        | 171 ++++++++++++++++---------------
>>>>>>>    mm/nommu.c                       |  45 ++++----
>>>>>>>    tools/testing/radix-tree/maple.c |  59 ++++++-----
>>>>>>>    10 files changed, 331 insertions(+), 180 deletions(-)
>>>>>>>
