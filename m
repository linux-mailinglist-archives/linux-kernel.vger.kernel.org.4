Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99766743F73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjF3QGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjF3QGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:06:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D51421A;
        Fri, 30 Jun 2023 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688141175; x=1719677175;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uuQneu2RK0Kym2uVj5a4q+takR1Zc79GlG+Xyp0C/8U=;
  b=eyQOJkShYVG5BH3H7i2hhchNHO5iOqgN0TVXdC9pk7/8sT6QzUKJL4p9
   UDEuB683KMko61Z1jEo+EsZ+MQD+W4BX9jjawHAQg8u5gSVPoNkPvj0Aa
   tQ3oQ/54xstYUZv6DddQranVm1uChu4vb/epMBbPdayIbFaDR4uEyaiYD
   PY7Gk6MN8qlQRKyUngZFwesR6GB3EyQ6Hl/JJjrIib7YxpIyMGLFRgq+K
   SqpD1/uquUPXsbbdui6C5IFDu4pPLSmkcp2G5br3jWoSILqPdo8jC3jp3
   fNopPKN/qy9lxKQVCDRgoY6t24sqFxnyEEu09q9Fq0Z2hhOvB65eRqIS9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365914819"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365914819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 09:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="695061045"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="695061045"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2023 09:06:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 09:06:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 09:06:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 09:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZHQnmxJxYjv9LXIZzN1FPBRBsBrZsuIVwnf7vLD2D3pwwllEwsYtN4+FGd9+5y26FQdwbHCVl2We72wSA1UUY/sIvXWOybtYa3ytdj2UyHCYtPbu7a/JOIZGMQCxQQvxKt00XExqjh+kik1Pru0eae0PgREo+ldWcq9VhjyQwrZTtGP9S2YmpdN7bJdm8WrL9lufZ8WOlMfq8ahwrxx4d6CiJ+KfHXW1IvkKCfYfVI/mwoFMuMvWgPw5i4bsXq8fdopyAFUWEfVB0obv/eMhrneaLQIVTughAHQ08g8S35frux4L9uqsvu2Ul5P2IrqJlUxcPMtHFF6yZy2XQLXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLBMs5LXRBKudPF20xHI8bUNDCo4MkUXeIKN+5Ibjnk=;
 b=DhpgajgkiV1etWxP3KPhYcmpXHefugHPocDbRQCfgx8PbGI05G8sAjqvbKmEF4J7ixy9n2iPmSQsgQHOgXkJK/FwC22ReD5nCJyWq1E+juARcKkm5DL8oXfb56R4YEHcksPB4e27b0GMWovsa7wfwYKGcPTVqdNnVNxofIWRqdQyj6kPu/1ViCGD9XXsTFzK3I26EVty94jKHj1X1OLeQWYiKVsdKBHqb/JHAHY63VQOYoXq7sSaDkvIOzWeEw55ODXb6TSUPFfNQ7NRWmHU92+GyDGDNSn/iKkzJqViJcpWfirHE2zXvgCSk8ZAwA1ez2MoyFTw1cbqrPi5Wwh6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 16:06:10 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:06:10 +0000
Message-ID: <01388e7b-0178-924f-c0e1-a0c8b0cded8b@intel.com>
Date:   Fri, 30 Jun 2023 18:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH RFC net-next 1/4] net: skbuff: don't include
 <net/page_pool.h> to <linux/skbuff.h>
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
 <20230629152305.905962-2-aleksander.lobakin@intel.com>
 <b7dda3fe88bb3d302b1cbb2016387d5e98e2f946.camel@gmail.com>
 <6d79614b-1258-08be-1bd8-cb02ffd9dc6e@intel.com>
 <CAKgT0UcDZ50FCk7bbvbQ5=6kLuXx8EG9mWcy18iLfuik2yb1cg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKgT0UcDZ50FCk7bbvbQ5=6kLuXx8EG9mWcy18iLfuik2yb1cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY5PR11MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c8f137-b43f-4683-1b51-08db7983eb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gkymgYaewJz+/fdvc9NXENrUgZi6nHfn3iq/5cCuuGmApBrkWxERY3ujEB6wV8h5cPtqdLYqiW+6Ta9KmhbiTwPu3G34/m/T+RvwK7dH2ZO0lqpPj57jBWdTaICLLjRffFQIjEOpbStkj84ObsuzsUjjjIEvPV92UzxGe+taTIYaKfyFqYm/kW35Npqb4gHHpUQTRvyb+niqOYmlQN3do5KOm7S/x8eUGlL3YsTO2KObgp1Cd8Zsgpv4xZQZ0Rv06YD5YheeVbyo1u8Z1FH02De/J8f3mBly+/tgG9NmajLK8Brmxs5Kn9H2lU6kRSsjh1wdBoRtiIuOq/27+sY9AZAtPk0FGTQ1erkVXmHh8oAsXcDllkZHUnflQ2UwNVdK4/gztB5NTpdG3FUlypmdSyHXZ54n/imc2vaeKq5FXdMsFAwCCj0OR+8XCZMLsYgE6ttUHgI+8GmzYnPsOdaBpqiu5Jrk4SMv/dnzxYC2POjPiKZdgEOH0sqnPU74qOzZI4+MWqzQ+ODv0su4NQy1YCWC18lB0A/W97fvDeP4iSCgE4cVFWXJDkRX7UtvAX8iaMeSfCE69uFh1qtHu46Q26iC0Qf0vJQL+a8+NkIJYO+5FsybWezg4I7PEHbbGSUiYx3HEfsEn5lmZfzsdHX8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(82960400001)(38100700002)(36756003)(83380400001)(31696002)(86362001)(31686004)(54906003)(8936002)(6486002)(66556008)(6666004)(41300700001)(66946007)(66476007)(8676002)(316002)(53546011)(26005)(6916009)(4326008)(6512007)(6506007)(186003)(2616005)(478600001)(5660300002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzQzWjhzeTFKRVpEclRYOHhVUzFZK0NXOTRUNHBCbFNxeVQrelRxdTZveHpk?=
 =?utf-8?B?Skl3aDlBTUxDVGFFZGppZkkrdUNDNkJReXc2ZW9OM1dmR2RUdWx4ekdEbnJP?=
 =?utf-8?B?Y0NKUzNpanAxMzlrVlBSZjc2UzgzREpOY0xlS05CS1R1b3A0ak1zR08rYi9r?=
 =?utf-8?B?OUdhRVIwaFJMV1ZGNStDekxaLzZLaEMyUlV3eFFUWVAzSE9PRnZvUjR5emtw?=
 =?utf-8?B?aHJyWm5idGFtUFUvd3FEUGc5S3dEZWE0VXRuaTEyNXZTMmF1TmlqM2tZcVdB?=
 =?utf-8?B?V2JOY3pQUndYVnpvTkhTRHpvbWtRbjdCNzQzSlJibXp0SlNlQUxMaGRxQXUy?=
 =?utf-8?B?TGhUUGd0bEsrZG81MWJzcFB5TGdQWXpvOW1aYVhNOVA2aWFtcHJpTE9VT2Vy?=
 =?utf-8?B?cXQ3ZlJQSHVlRk42aXRRNkpSU0V1ZC81OTc0ZXkxd0JiVW1teFl5aWo0Z2tt?=
 =?utf-8?B?dm9zZ0c4MlFGUmhzS2EwZ2RkS25CYkV2cjZuV294ZWZCL2t6a2NxOVgwbDg0?=
 =?utf-8?B?MUcvVjJ6eE1LSm5RUjhmdTBvRlJBM3VVWUhEUWI4RVFoNjZ6Uk1QeisvNGtD?=
 =?utf-8?B?cnJtK0E5cFZiTFJ6SzNaTEJvNCtoT3NQank5RmUzVUl2K3BaQmpmNHJVVldz?=
 =?utf-8?B?bStvY2JhTGR4cmhQSnRQR1B2N2R2dDdwVkV6bVR3d1RSSDlqc1AzTUtuTHhH?=
 =?utf-8?B?OWlQaVBkbk1MWS82bHNyNHk5T1krV3h1WDBUMXhjZzRRcXYrclZqOHdxTWpG?=
 =?utf-8?B?dktOZXZ5Zlo1ZUJVbWljelM1cDk0WWVKUFlmNSs2NHk2dkU5dGhrYklySWpr?=
 =?utf-8?B?VXJtQlBXU1VVQTJpMFM3c0JkL3RxcVp1UW93M0RLU2JuK1EwVzN3NUswQ3NO?=
 =?utf-8?B?R05XcUNNbkdjMWF5RzFVcGptOStTenAvYjBwMG5YQmVaS2dtYzc3RGFXOGJY?=
 =?utf-8?B?MTBmbExpUlJSSVVHV1JiNm42QWYvMldwL2UzSHhhelhBL0x5enNyc2FleXZG?=
 =?utf-8?B?RDgxYXdRVzdueXhPZnIxeWg4d2RjNXRkSFJpWktWQUowelNjUitUd3Q3Wjh5?=
 =?utf-8?B?Mmw1WlBaQ3I4dXZoWE5OTWRJTmtycWF6VEY1dnFSN0dmQk1scWI4TzJJQ1dR?=
 =?utf-8?B?ZmZrdVYyQnBQWS9IZjloQTFncHZraEJSSVFOWkQ4Tk1zY2hEbWtsVFFRazFm?=
 =?utf-8?B?eHFBbUp0dS9Ia1UrRDlHQkRZRXJhQ284blF5MVZvclZaZ0FScGx2OHdoTmtP?=
 =?utf-8?B?QS9qU0dHYTBaRUVWTmM3aWhRaVQwVWY2REZPZ1lLNUxZSDkwNEtIdENCSEJX?=
 =?utf-8?B?RFE5SWlQN3BTWDNXaFl1UVZhcEljWDdCcEw3UFpob2pIYld1MWVUYWtWU1o0?=
 =?utf-8?B?YVRuL3FaakNvREcvd1gzZnRycE95WElXR0dUTnRRUXBHSlUwamp5dFB2SXpr?=
 =?utf-8?B?Ukp5enJUeERZUWlTK0JSVjhORS9iRTBETUFmRXZOT0NQazZSV2YyUWZyVnBX?=
 =?utf-8?B?RkxYQTcvQ0duVkNhY2d6VjlFbnhuVHdIMndmV0hEdUxYL1FMejJsVHNadCth?=
 =?utf-8?B?UlRrZHhmNHRyZlNNQmd6dzdidCtOakFNcmR3NjJqcS9kYWdrWGRXa0d4bGc5?=
 =?utf-8?B?NWVYb09EZThqMXNHMDVxc1g2cHNkL00zYldMcDFSQmUvdlVjUm1KZ1RmcG8w?=
 =?utf-8?B?SUhqMTJ4cmhOZ3JzZzB2TU9zUHY1OGNnRllMRm5HNEVaM3FGOE94cmhNUHBi?=
 =?utf-8?B?SWs1aDNDNm1oVytrb0loWVhleG16WEZxQkFva2NSRFVDYTJpYWtJUU5qUkls?=
 =?utf-8?B?OWVzajBreVg5aHdVMHhnZTE3K0NGVnRJTHgxNWVWdUx4T0dXS0FUVjRWOEEy?=
 =?utf-8?B?NTh0UVpLSWhuVDhUeXhwZFZVQ0xoTkFzRW1MVUxYM3ZjRWVveVVLRzdTTkt4?=
 =?utf-8?B?R0tLa1RHSWVPelJ5OWN4dmF6U2dnRHdIbjBEWlhuck1Ya3hobU9iSHFpR3Vk?=
 =?utf-8?B?V3BvYklrSUZKTWViMzQvUFhMTFZQUjd3bThjelFlSTNhN1h1MjN6QjRBQlIy?=
 =?utf-8?B?ZzZFYW1JazNQSDA0R00wUkxTdEVQTW9JYy9sUUc3WEM1ekF6R1k4eEFnbnY3?=
 =?utf-8?B?eHl1bEhFZEI2QlMxQWxIUmlSWDh3WmNnbTZOQ0hYS2JOUUtBeHZlSTZ6a0VW?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c8f137-b43f-4683-1b51-08db7983eb95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:06:10.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NziYqJSNWeemLfvgKEBQJ4OtnpgPtz+OU7q83vGYpe1cH4ihzlEvcv+fZzCimP7OpxY/KprqSoIwYXBae8ck9Wwb9NWEWdO7BwVmYnuZKcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
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

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 30 Jun 2023 08:11:02 -0700

> On Fri, Jun 30, 2023 at 5:39 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander H Duyck <alexander.duyck@gmail.com>
>> Date: Thu, 29 Jun 2023 09:55:15 -0700
>>
>>> On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
>>>> Currently, touching <net/page_pool.h> triggers a rebuild of more than
>>>> a half of the kernel. That's because it's included in <linux/skbuff.h>.
>>>> And each new include to page_pool.h adds more [useless] data for the
>>>> toolchain to process per each source file from that pile.
>>
>> [...]
>>
>>>> +bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>>>> +{
>>>> +    struct napi_struct *napi;
>>>> +    struct page_pool *pp;
>>>> +    bool allow_direct;
>>>> +
>>>> +    page = compound_head(page);
>>>> +    pp = page->pp;
>>>
>>> So this is just assuming that any page we pass thru is a page pool
>>> page. The problem is there may be some other pointer stored here that
>>> could cause issues.
>>
>> But that is exactly what you suggested in the previous revision's
>> thread... Hey! :D
>>
>> "I suspect we could look at pulling parts of it out as well. The
>> pp_magic check should always be succeeding unless we have pages getting
>> routed the wrong way somewhere. So maybe we should look at pulling it
>> out and moving it to another part of the path such as
>> __page_pool_put_page() and making it a bit more visible to catch those
>> cases".
> 
> Yeah, I have had a few off days recently, amazing what happens when
> you are running on only a few hours of sleep.. :-/

Aaah I see :D

> 
> Anyway, as I was saying it might make sense to wrap the whole thing up
> as a page pool accessor that would return NULL if the MAGIC value
> isn't present. Alternatively one other possibility would be to look at
> creating an inline function here that could check to see if the
> skb_frag is page pool and then just keep that in sk_buff.h since it
> looks like it should only need to rely on the page struct and
> PP_SIGNATURE which is a poison.h value. With that napi_frag_unref
> could avoid an unnecessary trip into the page_pool_return_skb_page
> function entirely if it isn't a page pool page and we could look at
> dropping the return value from page_pool_return_skb_page entirely.

I like this one. This is rather simple check and shouldn't cause code
size inflating, but I'll recheck with bloat-o-meter just in case.

> 
>> Anyway, since some drivers still mix PP pages with non-PP ones (mt76
>> IIRC, maybe more), I feel the check for magic is still relevant. I just
>> believed you and forgot about that T.T
> 
> Yeah, sorry about that, my bad. I was a bit too focused on the main
> drivers we use and not thinking outside the box enough.

Not a prob!

Thanks,
Olek
