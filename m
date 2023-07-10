Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272874D77D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGJN2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjGJN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:28:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE96BC;
        Mon, 10 Jul 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688995685; x=1720531685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6t0jVEbLrUCC06zmSW6TxzxF6KUYxXryljszP2KEQBE=;
  b=T0dkRUcrwiVkCXIV0/uzPZx0A4UPiQV2SDuRAOy5/cCaisZz2Y7JGEbA
   Z7IKO0ZsykqWfTHji1s1d0DG6M7wmzvHtvdjobmp/NUQRII9zYoXzLycJ
   HnSMHr4yIPpJy8nKQ7KYG9AEBGrxnQZz7W/X3U6w8hDT7I/sbB9cxuysr
   SJgXycYi/N2VQqr5Vl71rfTd2i/f6KgIGv/impwdt+CS2F2Ipv4NUB1fz
   uG+yawm4hA2YPZr4Xlc8a2g45hulhO6c16l6OlXUKBMY5ZmAEVxyAdDtw
   Zopx3iFq4pivDhghZwc4MNDoTipTK7WRtGe8z3JK6rIDjOnBnn238Og1O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354200166"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354200166"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 06:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865356443"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865356443"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 06:28:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 06:28:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 06:28:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 06:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+6+YqqLcrszSH3f8Mlftf6U1eECkkwNsvj63Hgw4tsbzCrHqaLCCYLOPCiMhYm6u5aqF6WPL0BM9SLFAddcLuPwsM4l3iy2BJ+7ZSZoMvGslgpchZalkJJTNaODXX6E/VeldWO6qceemQ7Jz0oCFATZpRdOuoaxlA9LBzyeJWlA7i12FO4c2IsloIQMc8EG9ubjlmxz/Mj0MsYJvKD/r5kXm1KrYieaGQUPr8c4Rjb8z9x+SpKXM4U2iHg7dZhHOp4xIvR+YayiO5lX+arQWvg/U1lYHhHP3Lor5Qw7PTNUJmwtEVI9XkApaSvAz7YQSrLsnKwLI6QjBsD4TeQpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brPgj6N34ix0UU8X1fFTmT6gF6UPG7Jx6o/oKwF41Sk=;
 b=kuJhPMFjsgEZqqWc53a3y22Ie1KB+MbQaepflDXkv8ufb9rmqxDK0IYfOPQ+64iXPoxU2uSEe70cShe4YwqdKuY/NkEb5y60zcgjGjuJQRbb4nlm8TPRouh6sdaNi+cVbo3CNCUDXR4uO5D9CpY3PA/DobbtaEfGS98RCbO578Z3osMaS8MoPK/dGo4kub6jQi53ctmCtbtVLkYGeQU+g5dEk0IL6WrnbMqNbRvEliYslPFOcdbG4QP/fCKcnPYWKlFoVv0D+/xcUsQqknxaDhRq8U2b2+CXZiFdvSSDxkdty9J3xYfxU7zoo9zsVyJP3rWUDrDPwEcKtZeVBbyyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW6PR11MB8366.namprd11.prod.outlook.com (2603:10b6:303:24c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 13:28:01 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:28:01 +0000
Message-ID: <b05d1a35-5bc5-b65d-b57d-5cc1b0f898cb@intel.com>
Date:   Mon, 10 Jul 2023 15:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via
 Page Pool)
Content-Language: en-US
To:     Yunsheng Lin <yunshenglin0825@gmail.com>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-6-aleksander.lobakin@intel.com>
 <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
 <09a9a9ef-cf77-3b60-2845-94595a42cf3e@intel.com>
 <71a8bab4-1a1d-cb1a-d75c-585a14c6fb2e@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <71a8bab4-1a1d-cb1a-d75c-585a14c6fb2e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::21) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW6PR11MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a928485-b873-4955-2277-08db81497b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISvWoUOvFfg0pHUMpUsfNaIYxLUox9C9vSvPVTiO5j5S6OII+nQpo+CxZjWsImkh2hdr1qE2C930zC6ou+L2HsRN9SA3PgrAdtxWeIFlvjgrUxr4vIGirIhEJFxhQKNVZYlJ8Diqle866MZQFQa86fF5GsZB3XlNRInho0QbRckzF+cwAKG48cM1hxC8n/wpKer3nzDI6Mi/5JmilhGekkdcN02SyjvWHScScEEGcbCXoEUNZWJ61gpZaZNdToklDV449vYv9cj2GlUoqAommKJVmRM8m6Km351NMrRrSIWHNDmQymIU+Ll5ZG1ZxeekeyJinrzmU1Xq4QHeCZRzMyB5xUkiVZIg4xrHpQyHq8mP5GuaAa6VgK8YEtBdcE/GPMQgOAdkyOy3sIGsTLBAOfC4wsjvIgqicsGV8E74NJQql+p4UCi+GU7IBLv2N4MfYghKRwt5wqBfYprf7tKoS3Z1HhbANt0DdHKsovVTi+dpoVF1tV9iDoDRHTC8MMcmM8A6wK/FOJsyIwFoqQKG2jXyHV7hLny3ys3wR+vKTykHltOjEKMhgONlH4Vb5UtWttFrHT0zMrLuoLcHrp5DV9lPv/zqgN0ajULr2SWak+HmaB9NR56Utz43lLb05bmSNw1pd9RM2EU9ceS+en2m2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(31686004)(6666004)(6486002)(478600001)(54906003)(2616005)(83380400001)(31696002)(86362001)(36756003)(2906002)(66946007)(186003)(53546011)(26005)(6506007)(6512007)(38100700002)(82960400001)(4326008)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(8676002)(6916009)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1QYWdZdWU2cUNXdFFZc0l1ZnZXWVl1aE9lQzFRWUdxMERLWmdEZngwL3FE?=
 =?utf-8?B?MGNzaXZQbE5KTmsrK3dRRzNFaHRodEJWK0hidFJvamFyaU9XM1BvdUVIVWhx?=
 =?utf-8?B?TndjUmdsRmU2OFkrcTNYRzVDSzBpTGtWUzVEdjIwWVpka2RwWUJ1b29CZmlR?=
 =?utf-8?B?aCszVnMwMUNodGhicExSZVNHMHJGd0hQWnVYREVGcE5LMmZOQ1c2bllKUU5V?=
 =?utf-8?B?VW9RTUFKaVVQMmxMNXAwdVYrWWJJRFNhODVIMTlUOGhBRldSZXlZQm5PZ2tQ?=
 =?utf-8?B?VE5pRWFEcElFMWJtSnhKZVJNbzZRbzJwVE1aVW9YMTMyY0pkOUdCbDJpeUtp?=
 =?utf-8?B?S1hMQWJOWGh5SDVkQ3BTdlVwWlhVMUxCNDVYanFUTkRwem9BMzkzbGNHM2lJ?=
 =?utf-8?B?TmZzcTJFemxOUFlDN213Q3NQbnNOU0tXeWVjSnFMYkJiSUZGcDhRS0JvWFBs?=
 =?utf-8?B?aVNGaXlCR1BIZkFhVFRVeDJsWERHM0xQTlJoZHloWlM3Mkh1OVU5Y09jUEc5?=
 =?utf-8?B?UVR1OXdSOWhDK0dvTEl0eXpsZURZZ3VaVUNKRXVXZ080b0NPZm9LeGVzNE5a?=
 =?utf-8?B?VWozUFQreHJvUEtWcExWRHFZeC9jN0pGMWhqRWJZT3RFbW44TGFDMlNyaGNQ?=
 =?utf-8?B?OFdsK1JCMThWUXVqM2FMbGFTVXExNGJFVXBLMjZUczBHd1JPbEI3MStjeThV?=
 =?utf-8?B?UE9xWHpCN01PV0x0NTVmZllHcFAzWWhpTStpK3RzSGxkWStCaTJiQkxML3Vs?=
 =?utf-8?B?TUVsQlVoR3dKSEgza1JJekQxenprbGJ2NW1BRXRRSFowdVlJQU5USXdWdW51?=
 =?utf-8?B?SEQwN1VQYmxqR1BUZUZQR0xQcTFLMUxVOElheEIzdzgzOXpmYitjeWtuTkpO?=
 =?utf-8?B?eWF6SldYSmsvcmVqL204RzIwaEhoTzgxYVo2M1R1Sk95d1NVUmRUTVJJK2RZ?=
 =?utf-8?B?WVlGelB1dkk1TVhsNmZxaDZtQkxnVDRSYlppOUxGM2tHZ3RnbWxIV0hRaURi?=
 =?utf-8?B?ZzlYRG5Cd1NMMFJoN052MGFZYk9nQUsxaVN2Z2UzS29BclFENkZoTEVXM1oy?=
 =?utf-8?B?SUIvSmpyclpGeUFRdHJ5aVMrWi95TGdkb3c1dVhLazRGU3l1RU9MV0oyaUl1?=
 =?utf-8?B?T2VCNURKaDVibnNYZFViRXZ1bnNHWmhpeWhMZDNMVmR5MFlIMzhLVUxWekcw?=
 =?utf-8?B?UFd4eUlrWWRkbVN0SkFVRk5CZFluWGNNdWR0L3J5UWpzNmFoZTBhZ2dIQ1FE?=
 =?utf-8?B?VTQ1MXRlZDJDMTFGbUE2cWI0ckRoc1NGTnUwS0xKdlByVGVQSHY4Z2VEK1JD?=
 =?utf-8?B?ZjA4L01sY0JqWUhRUytWdGJvOE1BUjUvVTd6TE1JRW1MeEtIWCtyK2tMVjF2?=
 =?utf-8?B?R0tiRUxyeGR5TXJ5NzlMVXRjQjVzcVkzOFVzTkZEcDQzL0p6WVpVNzhKa1I3?=
 =?utf-8?B?a21nTk9wdlRNcS9maVRMa09UcUJ0TzdRdUJwdnhmaG1vVlFmaEN5dkNqK2dY?=
 =?utf-8?B?c1NNd3NuS0oways2eUlNT3NPcm9GQXBYQzFrWnNDZHpaYzNCMjJ4U0prOHVj?=
 =?utf-8?B?aVE2U1NOTk9zeDFDR2t1MTd1ZWU5ek1reUdkNkNYSEpuNkZJQ2pYRGZicjU2?=
 =?utf-8?B?bTdabDJnbDM0d24vZEJYQlhjQ1ZhUjVjaklvMkkyeWxXQndRenN5ZW16Uk90?=
 =?utf-8?B?ZUNYeG1Qajg0OG92VktEbW53VVdOUkEzRG5rbnJLd0k2QVlqR0dEZ01JTkhY?=
 =?utf-8?B?ZXVJRFk1TVpaRW1vVE9qck5ZOWFhL3ZhZjM4WXkzL3pReGtuQTdkb1FIZFBM?=
 =?utf-8?B?cHZqNndTNkw5R1pFeTd3UlY5d2ZUQ2RGMkI2TUdLV3FQcFBucDQydE9mS24r?=
 =?utf-8?B?cnpnRjAzbmhNdXNiTWpVdk44elNHVExrUTBZN2tjYXFuNU53aVRoTnVuMDR0?=
 =?utf-8?B?OGJIUmFPQlZWS1dDV1F6MmNGZTNVM3JBSSs1OXFQWk1YVExFMElSUWhFQUhC?=
 =?utf-8?B?eUdKRXRVMndiQ3JRUjFSY0FSVHFxSXZGNjZmalRlUnZCK0pXUi8xbXB6N3pk?=
 =?utf-8?B?VldTNXcwM0xpdFBrbXl0OEZDVmNzZHBkOEFyV1hDMlhmSjJQZkxRMmhIRUdi?=
 =?utf-8?B?OUhwTkduWkNYcnc0aTAyK2lNb2o0UVByUE5penJhYUZBK3Y4cytOWmFJWnl6?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a928485-b873-4955-2277-08db81497b7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:28:00.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88v/tnkRrgUr0yikMvzc5gHtpIgqJtixOi0YKYQG7uNC78zhsjkT6wS2JIZoo+dCCAuAEAGuOWhnEYrA5aQQBxqpA6un0ezJJbiIeWqpiAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <yunshenglin0825@gmail.com>
Date: Sun, 9 Jul 2023 13:16:33 +0800

> On 2023/7/7 0:28, Alexander Lobakin wrote:
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Date: Thu, 6 Jul 2023 20:47:28 +0800
>>
>>> On 2023/7/5 23:55, Alexander Lobakin wrote:
>>>
>>>> +/**
>>>> + * libie_rx_page_pool_create - create a PP with the default libie settings
>>>> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
>>>> + * @size: size of the PP, usually simply Rx queue len
>>>> + *
>>>> + * Returns &page_pool on success, casted -errno on failure.
>>>> + */
>>>> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
>>>> +					    u32 size)
>>>> +{
>>>> +	struct page_pool_params pp = {
>>>> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>>> +		.order		= LIBIE_RX_PAGE_ORDER,
>>>> +		.pool_size	= size,
>>>> +		.nid		= NUMA_NO_NODE,
>>>> +		.dev		= napi->dev->dev.parent,
>>>> +		.napi		= napi,
>>>> +		.dma_dir	= DMA_FROM_DEVICE,
>>>> +		.offset		= LIBIE_SKB_HEADROOM,
>>>
>>> I think it worth mentioning that the '.offset' is not really accurate
>>> when the page is split, as we do not really know what is the offset of
>>> the frag of a page except for the first frag.
>>
>> Yeah, this is read as "offset from the start of the page or frag to the
>> actual frame start, i.e. its Ethernet header" or "this is just
>> xdp->data - xdp->data_hard_start".
> 
> So the problem seems to be if most of drivers have a similar reading as
> libie does here, as .offset seems to have a clear semantics which is used
> to skip dma sync operation for buffer range that is not touched by the
> dma operation. Even if it happens to have the same value of "offset from
> the start of the page or frag to the actual frame start", I am not sure
> it is future-proofing to reuse it.

Not sure I'm following :s

> 
> When page frag is added, I didn't really give much thought about that as
> we use it in a cache coherent system.
> It seems we might need to extend or update that semantics if we really want
> to skip dma sync operation for all the buffer ranges that are not touched
> by the dma operation for page split case.
> Or Skipping dma sync operation for all untouched ranges might not be worth
> the effort, because it might need a per frag dma sync operation, which is
> more costly than a batched per page dma sync operation. If it is true, page
> pool already support that currently as my understanding, because the dma
> sync operation is only done when the last frag is released/freed.
> 
>>
>>>
>>>> +	};
>>>> +	size_t truesize;
>>>> +
>>>> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
> 
> As mentioned above, if we depend on the last released/freed frag to do the
> dma sync, the pp.max_len might need to cover all the frag.

                                               ^^^^^^^^^^^^

You mean the whole page or...?
I think it's not the driver's duty to track all this. We always set
.offset to `data - data_hard_start` and .max_len to the maximum
HW-writeable length for one frame. We don't know whether PP will give us
a whole page or just a piece. DMA sync for device is performed in the PP
core code as well. Driver just creates a PP and don't care about the
internals.

> 
>>>> +
>>>> +	/* "Wanted" truesize, passed to page_pool_dev_alloc() */
>>>> +	truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset + pp.max_len));
>>>> +	pp.init_arg = (void *)truesize;
>>>
>>> I am not sure if it is correct to use pp.init_arg here, as it is supposed to
>>> be used along with init_callback. And if we want to change the implemetation
>>
>> I know. I abused it to save 1 function argument :p It's safe since I
>> don't use init_callback (not an argument).
>> I was thinking also of having a union in PP params or even a new field
>> like "wanted true size", so that your function could even take values
>> from there in certain cases (e.g. if I pass 0 as parameter).
>>
>>> of init_callback, we may stuck with it as the driver is using it very
>>> differently here.
>>>
>>> Is it possible to pass the 'wanted true size' by adding a parameter for
>>> libie_rx_alloc()?
>>
>> Yes, or I could store it somewhere on the ring, but looks uglier =\ This
>> one does as well to some degree, but at least hidden in the library and
>> doesn't show up in the drivers :D
> 
> It seems most hw driver know the size of memory it needs when creating
> the ring/queue, setting the frag size and deciding how many is a page
> split into before allocation seems like a possible future optimization.
> 
> For now, it would be better to add helper to acess pp.init_arg at least
> instead of acess pp.init_arg directly to make it more obvious and make
> the future optimization more easier.

Makes senses.

> 
>>
>>>
>>>> +
>>>> +	return page_pool_create(&pp);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
>>
>> Thanks,
>> Olek
> 

Thanks,
Olek
