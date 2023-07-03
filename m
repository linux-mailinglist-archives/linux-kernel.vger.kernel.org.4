Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C51745D98
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjGCNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGCNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:39:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BEDE41;
        Mon,  3 Jul 2023 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688391548; x=1719927548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVTzr0b8h32AEcUNNzAZVQOc8I8GksHmsXct9r0NuL4=;
  b=Ju5gFZ1zBh6fJKa4mNJD2+LEVByv9mncgtHZSLoDWNllqUdmeq7VfzZC
   Q981CTlPwiGhpCzyabtoiOxRpnFZVrysq4ycTJ8SK4hwnlvUbieefB2l6
   r+NYTQVMasZ153qohhcgcncSp15Mj1ZVOpDklM7DSNXlb3ECY4zStvM7K
   z+tWfpv6iYJVwYHIK8JlUYFbHC8XO/ypl8ywIAKKHYtuIXtDvwn/2IMSB
   7Y3GHm4UYL4c3Wpnk09r2EuK/6Ka7exBZoDPIYqYm3Kg5bhPhB3AW5PWh
   bzQubISKJMSPQOueq2qT7Qn0xu5znwln26dBzNc+HpYjxiD5Q0Og+K9Bd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362920622"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362920622"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="783905595"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="783905595"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2023 06:39:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 06:39:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 06:39:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 06:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFDRAtHvcFIcNloEBmxTjD3UlYuk0lTYWU2PCMk71JWMK4wHgo5lCDIMewBz77BYWT+tmsfp9a1bsw49K83gH/eDdr3jJBircOHVEOjF4Qk5Z8d6ztR4NximYMIxfGWg+mCc7buekRTnaW9byxigdz34L6oMj7GMpf3206S6WZH4jnI3O8Zfh9B0+GK6I1177Gbjiz8cbCE+1Bwc2Q2566vZCawOyUqu4x5sgAvXcv8X/xNgLLXfyTdq6iBDEJ/vsXVIrwQ6SeShw7cOYHqTXf9VTqXs/EaPUlhgLPJw88MKHOJplW6Yu4Ojvr8m5y1pYTBRdcOUWG1pXMvZrUaoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZTG2JeT0C22OjG1BY+ZcjOKfu8tyIIcxelgVyxpZBo=;
 b=JBKwU8WC7Tgi3OZxbN3MoFACg0mn8xkCwn9GlD3RLvqEPw4x/X59FkQi9NoYXGeaVLTqmPDoYYt+XnQQnk4puhzeWXhBndZT/9q0i4gZCnvf5hNY2PwhiXi8n7rn7drJDgW2ZEQPWEZu8Y+rt9A4/o/BvOvaWY4PfTWCLbO06NQbadBkOTAOhjTCN7QEJDyd5GH7ctnamMQT5TLSq2KHq+YOg+5nDyLkkpOEpArwnpATl0vZQ94zpYtDBLzXi0U23RxXicduPr3LaBcSFhXrgObJ7p/rQoJ0RSBOWflBYQkDvy8Gv2NYki7+mVTC7WfoYb96QjJpGu0wrcwOeGVLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB8501.namprd11.prod.outlook.com (2603:10b6:510:308::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:39:04 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:39:04 +0000
Message-ID: <84115706-6eac-d4c9-a815-6def8675fb56@intel.com>
Date:   Mon, 3 Jul 2023 15:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op
 externals when possible
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-3-aleksander.lobakin@intel.com>
 <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
 <ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com>
 <CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com>
 <413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
 <CAKgT0UcNRCiMDbM7AwXA+dRnikS31tDGZdZhnkBs1u-yi4yN8g@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0UcNRCiMDbM7AwXA+dRnikS31tDGZdZhnkBs1u-yi4yN8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc139f2-61db-486e-e206-08db7bcaddc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYxkkr0OYMZgpRSbV8RPESKBdPUeEMr65FH7eQr08qfuP4m7flgIaU+T4YOOmCgyc7/NDfKydvuH8OU0XucR/+jLoAvA+6c4qZpOmQ/fIyQFwXszeEoWZDBpnoEyjgNqO8miWCRLQHofSm+sJsELH62i8ecgq4a1ryn6rBu6+cbwf1mPxKQpChghSy72OtsV4aRIHJnw0a7be8gGUOx2S91kSdpiaRoXQKUR+lcE5BqvgRY+BHwlK+zjnrGgKwk7JXPRs3j/KAAVwreOwZ4TqR/He4hmKkl/5e4Dxz0LBTpkBM51SP9CNbTCH/3S8RYHv+4sYYmrU7u35PDQuhrCH78Oc5XQ2fDe3ncHPwpV6khp3F4l2fwGqS/R2vrg5zKQqLxNJfwtIBeJVaxbvDmiH4qDP9e1gzSYGir/c95NtdJ8+/ueWMCN8LSX3CddL8RaMlsdLpmgEHIbDVN6apEB3WIerGdfhVdptb2pF9jUa5MkO66P1njwXkReKhPYtt7+z/7v1h/6O4jQwvaMMyRtcgSVVFlQ3SOJyBCrMhndz8JbIzILcLb3WTh4cmtojp9MYIO7H8tdpTMHPFTezncPQhECp0L8RNhxqUdTDj7uDNhOhqllicE+D8VrU8fNCOADhYWqKJqA+CSFvOWb9twj9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(7416002)(31686004)(6916009)(4326008)(66556008)(66946007)(66476007)(478600001)(316002)(36756003)(2906002)(8676002)(8936002)(5660300002)(41300700001)(6512007)(86362001)(31696002)(54906003)(6486002)(38100700002)(6666004)(53546011)(6506007)(26005)(186003)(82960400001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0pabTJJdTV2N0lkc3ZydUNNSmlhbjBTMklxSllmNzdtbHpBUitkOGtsTGhk?=
 =?utf-8?B?NnhFR0JaVm9BQWVuSkNQb1VkRlRQaEx3VGpRSGZ2ellySjZqUHBaOUJvbHpq?=
 =?utf-8?B?cm1sZXgwVFg5bTcxTTNQTTZDbkFVQTl4QWMyVEtJZ2xxOTdJekxGLzVhSGxy?=
 =?utf-8?B?SDB1WVZoQlI2b1lGK0NsQi9rbG5EYkdZNlFRK1puZVBvWHZlMldlQU1UTXlJ?=
 =?utf-8?B?bmhMZ1JhTzBaSWtTK05weS9hMkJaQ2RBaWtmeXp5bXJHZE1pRHJqbzZPYUsx?=
 =?utf-8?B?WWY3NGQ0ZEczZW9nNVBHZVI0azZROTgzRVRpSVRPTzd4S1BOMGN5VExmRnNB?=
 =?utf-8?B?eFU2VDhNZWRzMjVQT0dBQXRTL1d1TnlWeExMOUVvc1pxaEtCMmhFb1FmRFlW?=
 =?utf-8?B?bUNKRUFhU0lQQVNsdEozNHFvWHFMYVJuNUlyTmR0TjMxSXlsZCtQbllEM005?=
 =?utf-8?B?V2EyVHdjZHZ0eXYydlVpdVNoOExiS3ZrT05ySkVhRDA0bUdkZktVK3IxUDBV?=
 =?utf-8?B?YmN1dklac3B1QlFWOEFtWk9OSU1wbHJKTUsxcXQ0d3Yra0llbzZtcjV5Um1L?=
 =?utf-8?B?UXMyOWxIcVFnRnd1NUxNMHhRSFZLcnpCdHJGVmFDS0pRa1NKWWhuNUQwdDRm?=
 =?utf-8?B?dXhObEFPRmZzTGFKb3F4N2U2ZHVwUjdrMHFMcUtDb1lvVUVQeXRIemg1ZEVF?=
 =?utf-8?B?UGp1SUFlUHZJZW1Wc1dGM2NhSG4zLzhWbTlad2lEdGhuV3l3ejBOd1Q1ZDNl?=
 =?utf-8?B?WGcvbnRnNFhSSzZuME1GejF5OGhRRDgxQk5uUmxyS0VhTlN4eWVNdnpDUDk2?=
 =?utf-8?B?MGd4emNSRzZFT3MrWWtFSmdXbnRtYWpzWitFWVZqZ0Z3UnZuWTdZTHNteU9Q?=
 =?utf-8?B?UlJnZ0QvNUdEOUptaVVxS3VqZk5sU3pZam50aHR0MG80b1d2ZS84bmRTNnpI?=
 =?utf-8?B?QXo3czNwQ25Sc1lTaFRRcGZjWUpQZllWVEl6SVBzbDEycnFXanJlQkwrb0RC?=
 =?utf-8?B?MC9SajJ6WmtxTjFOQ284dEE2ZmZFL005ci9XSmREcjNTdlpIWmlNK1FEVkV2?=
 =?utf-8?B?a2xqbVFrMU9CdmNhOGdHWDliK1U3UjJFQTRyd2pSS2EwKzFVQmFUb2ZrN1lS?=
 =?utf-8?B?bFh0VFRRWmo2RjJIL3Nwd2VrdGhoaWI3bnVBY2IzeTZPWTdWaVIwMk81ZStO?=
 =?utf-8?B?QkwwQjZBWjcwenlpQ0RnMnM0dVRyc3pvSzRGbXVocE5BVlI5M2xyM2RFV2V3?=
 =?utf-8?B?YjBRRjh5WnIwVDBmUjU2NVk3VEtiV3JPTFk1K0ZFSDJIanFaaDBadGtPZnZx?=
 =?utf-8?B?RXVPaGtsMnoya2NQMEw0WWkwTXMyWnpQaE9FRi8rSk5HbGhuNVBpVmxQcGVQ?=
 =?utf-8?B?ZVVqdFRiVmhqNCtRTG1VcnJvUTVNbzRlb1lyTkRWVDQ1eGNhU3RMbjc4MzVC?=
 =?utf-8?B?TDAwTGo0N3JVR0hhZklCTkh5bjZocGpnSTRSaVZBcHRhWlgwK1B2OFdka1V4?=
 =?utf-8?B?WTdkRXF4elRmNDVTMmVBQlJKREdoR0NHbG9VNzVWMUxQNWY3dnoxcnZZRkF6?=
 =?utf-8?B?NGhnN3VDWGlWeWJVTWFEOVdBVWRkclpCTzdsTEFlK0U2NWhYSHpQUFJXMnB1?=
 =?utf-8?B?eHdZRmVoQVFGY05iR3pBTGxDWUJNcmhHQnlmSU9pVUFMV1N1eG5JTEtSU3JZ?=
 =?utf-8?B?SnRFQ3AvWFNmcDV6dU1vZWRWeXd5REQxQldGYWU1K3Vxa1NqMUIrNFk3MStJ?=
 =?utf-8?B?aWNrenltZVpkU0N6UkRSYlNzVVhFUGFaN1pFMXBRYmdLOVEvNlVDbFIxZDJ0?=
 =?utf-8?B?dTFIZE9oaEl0b3Zhamw5WmMwTVRSTWxobnFFOUdSck9XWlZyeHV4TTZPRWVh?=
 =?utf-8?B?U3UyTGRLbXVwSHZNaTg5VGEvM1M4aWY2NitlQ1c5TG1MOUg2Zkg4c3FRTXdT?=
 =?utf-8?B?MWlPTkJlZEJkbVdPV2c3Ym9yTkRYTVEzRXF5SWNVbTl0ZDhOdWtTaU1zbmY2?=
 =?utf-8?B?Z1VrSU1lVmpudmIrZURmVWZFNVlSQVo2MTE3T0NMeGhuR0I1dVdWcE5NdERH?=
 =?utf-8?B?MDl2ZnJGN0JneVVsWEVVWVQwNFZKTlFJVmFrYkh1OFJNZWhZb2Y3bjRVRjJk?=
 =?utf-8?B?b0cvaFV4eVU5dVRvT2NYS2MvZk8xNzNhNnB5eCtMZzFvOEZ3TUhKRzZGS2tI?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc139f2-61db-486e-e206-08db7bcaddc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:39:03.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czjbjqk0cAJOQM+EMb/1PwtPqQ3OVBqBv2I1GWu5OOt5h97P6ztik++EWfJU5URQR/YOcCpXG8uqJ7TzyeYdl7FrogHAdCXGeYDAOd7HGEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 30 Jun 2023 11:28:30 -0700

> On Fri, Jun 30, 2023 at 8:34 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:

[...]

>> On my setup and with patch #4, I have literally 0 allocations once a
>> ring is filled. This means dma_need_sync() is not called at all during
>> Rx, while sync_for_device() would be called all the time.
>> When pages go through ptr_ring, sometimes new allocations happen, but
>> still the number of times dma_need_sync() is called is thousands times
>> lower.
> 
> I see, so you are using it as a screener for pages as they are added
> to the pool. However the first time somebody trips the dma_need_sync
> then everybody in the pool is going to be getting hit with the sync
> code.

Right. "Better safe than sorry". If at least one page needs sync, let's
drop the shortcut. It won't make it worse than the mainline anyway.

> 
>>> dma_need_sync for every frame then maybe we should look at folding it
>>> into page_pool_dma_sync_for_device itself since that is the only
>>> consumer of it it or just fold it into the PP_FLAG_DMA_SYNC_DEV if
>>> statement after the flag check rather than adding yet another flag
>>> that will likely always be true for most devices. Otherwise you are
>>
>> What you suggest is either calling dma_need_sync() each time a page is
>> requested or introducing a flag to store it somewhere in struct page to
>> allow some optimization for really-not-common-cases when dma_need_sync()
>> might return different values due to swiotlb etc. Did I get it right?
> 
> Yeah, my thought would be to have a flag in the page to indicate if it
> will need the sync bits or not. Then you could look at exposing that
> to the drivers as well so that they could cut down on their own
> overhead. We could probably look at just embedding a flag in the lower
> bits of the DMA address stored in the page since I suspect at a
> minimum the resultant DMA address for a page would always be at least
> aligned to a long if not a full page.

As for drivers, I could add a wrapper like page_pool_need_sync() to test
for DMA_SYNC_DEV. I'm not sure it's worth it to check on a per-page basis.
Also, having that bit in the struct page forces us to always fetch it to
a cacheline. Right now, if the sync is skipped, this also avoids
touching struct page or at least postpones it. page_address() (for
&xdp_buff or build_skb()) doesn't touch it.

As for possible implementation, I also thought of the lowest bit of DMA
address. It probably can be lower than %PAGE_SIZE in some cases (at
least non-PP), but not to the 1-byte granularity.
But again, we need some group decision on if it's worth to do on a
per-page basis :)

Thanks,
Olek
