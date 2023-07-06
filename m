Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC074A234
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGFQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjGFQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:30:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E011727;
        Thu,  6 Jul 2023 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688661019; x=1720197019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EeAjabxsMvD/dQHGOtFZ8+cUQtAZYw1+hQog+ak3AyQ=;
  b=g8oZPzG0MeuBGMkl3+HiYwu7XiN9pFQuT9uDjxyTsEpCQyXlhp64d8La
   fhOrkN3fCXc+29eyiAOQKBsG5MITHnwTQhgnPOcLmysKkQCldoNyhmU/3
   NtcijNBwz1K+LAPvpbc2r8Mnif/E2+CLvi3TS8DQpd0t+dijH78hSOnxn
   y1ShwkZV0GFLgRJnTwA7vJiDdvlqjBF4ei6ObMSmHbRjpPWvBlj2V02k2
   kgryriQnflzRbj2qc4yQfriD+Upf4ozlLUEu6A4rIl6qZ4949OUHxY4ab
   JMtAVI3ZbDKZtEmuItAFL8ETcPqatzDWbVq8LeC8KTTzssyp9yjUGpebP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="450009502"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="450009502"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 09:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="719631032"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719631032"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 09:29:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:29:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 09:29:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 09:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYOnPxo3E+DVfk7Efe6BCz+bYbtKjyxQf7uS/hzu9d6uvNQgxW1NYALivMBGl39EZ0LiBEd4GfBv0nrglYStQPaeIsMbbr4XkNrnbOY/eWteraXRNXpaJS2vz9gyYyBKzFsbngRcyrz/P/KMIFIMdizAnqFjbfinykaMmXFMr11nTAUdAr04GUwgXcB/XBCyt3V2GzkbejM3lI8lnrPktEXXJQDGqJ/PGB1xNJeuw35XiPISGz0dbB2tNNG1XejV1uc4Un0E1u6KGOxsC6xtHrVwuwM5yXZehE54QV6+2A14uV5deSwlwdEwdiO3eIs27N29J837DK8VCmC3IjZl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz9D2eIWqLzsUPD/lSe2qpgzvqv55arPyJQh/cPM/64=;
 b=LntOakD3xaMagnFdFU0gs6kKNGzd+Goy77LuwJ8cpfvbdctzEyiLzlk62a89uZpz4QggwBPCRrTB5CPTp+szTASpUxynwmEtsRP9J7/tDT+oz7a9zcQ5dgmx8MrTDEaB1L+qh8JaSS+qmCC6m0GViupxGVlA5SxJ+Rf+oWe6YPWhV72cc4HKf1GIlCP0176Ai+MNxiYmyHM82I3JnN8gms7HSbpR336jsBk/RLzIGmfKmqKkDFdkOLgY80X5ZtOXTlLf4Lg2hJ8IMyEwrRi1VmCbFaAVgRRzgIgbGfAx8k6DyAIMjy2/awJjcil7nc/DogUiRwVZLG8bJHXGpB4yHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:29:56 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:29:56 +0000
Message-ID: <09a9a9ef-cf77-3b60-2845-94595a42cf3e@intel.com>
Date:   Thu, 6 Jul 2023 18:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via
 Page Pool)
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-6-aleksander.lobakin@intel.com>
 <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0020.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::32) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO6PR11MB5587:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b6d0a3-0984-4206-0479-08db7e3e3bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovCkU/VAHcXZTWChJiKOY+8wIw2k+uPVPaV9scdJUjGc1cjRo8+f3iyIcwsyGNDXTRQ0Jzk3QhmV97+DLwCBMAvstj6n/MLBrGhhfE9euNO2wxjliU0RbvZYheB14ujHuL2IJkxwlAbKHHAxcvGPT3ZjM47L0Mv8geNz7MiTWqBz1T8FM5yQXEQsjhTFkqxwTQDJXiAn53+W2hOJYC5BaLJLjHoUq23KxN3uoZ24U3jZ7f2764HA036XPT5I66Twql2WesbUSb8ZO62HEOkLgLKUiSPUproLDQjJ/xmw+/fi24KOlW6ic+qhaoWlKlPxNIvlZhZR6zTbGobQeWSEnH41KT0DHuO3Fz5MhBbRAtk68E2Hob7LJvMJDZUj9NeOvA2HCXsTPkH2moJHd0xtLJBDcEI0fBV3jlvA8pt4YEVSOlk9TR8kDiIKOIOVEUT3qzqVGBfoWQgnRQ5ndp9bYXZJSHK4xcAu/cydEYjxNwFAhawADewJerY821ahlrUHNdw4jm4PL8hMqSJZ9Z3AWB9EYui4ASJf7pTmsC8NPO4FI7icgDU8E1OOff/F0zVAiHwGFBZBRl0nXDwjUfoOtZ465K99EIs9VvRXioCpPvQ6f2IBQZRvGeK0YVXveHnNsEhU1BDyyfmV5tEl/hkRrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(41300700001)(8936002)(7416002)(31686004)(8676002)(36756003)(54906003)(316002)(2906002)(5660300002)(6486002)(66476007)(66556008)(4326008)(6916009)(6666004)(83380400001)(478600001)(6512007)(86362001)(38100700002)(82960400001)(186003)(31696002)(2616005)(66946007)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVIeXhQc1NtMk14N0J5ckdrM1oxSjU5UWFqU2NVdEQwNUU4VFpPY2I3SWlo?=
 =?utf-8?B?TUZGZkhjRWFROVpBTkxPbHpiczBadTE2bUg4TjgzMzB4cmI4dGs4Z0FDYzZi?=
 =?utf-8?B?MGN3dXRWVndDTkNSbWg3WUI2bXowRVk0N2s5cDB5VTFneStndW9OVjNWcFVa?=
 =?utf-8?B?bkJHQ1lJd0NOd1p0M0hNcFZyeXUyY2VzdXBSanJtUmtEalY5T2NaVHJWVG1l?=
 =?utf-8?B?QXZpdElld1hoWVIxVzVvUE9rK3dnaXdsQ3MxNi9PN2RNZC9pb0c2SnE3OWI2?=
 =?utf-8?B?bzRML29JYTlnNTJzb2NpcVYvVHFFcCt5c1B5OTFFUjdGb1ZUMzZ5bVpDdkd4?=
 =?utf-8?B?Y0FQcDRLTE8vaXVPSUtEanlkOFFhc2FrWXVxdVZ6aXlNczNZazlhVldqWUpJ?=
 =?utf-8?B?a3kzbGxWVGp2TCtNQVcvdnBJeWdrRitCbGk5MlBNbHhlNkFPVDNYOXVRK2sr?=
 =?utf-8?B?dHZRaGFVT3pObHdtMkc0T3lUcHFseWhJOTRVYmNJaEtiTmZoS1lZWVk5dUtZ?=
 =?utf-8?B?MUNjNml6b0RaeUZPVlY4dFg0MjRQMGpMYXBHYWRlNXhiQ3ZkM1duU1NFYnhM?=
 =?utf-8?B?Z29QeUIvVzJ3MThJNExjNXhwNWd3N2VKdUNWcW9wSENsNFM5T2ZoQkUwRTls?=
 =?utf-8?B?blVFTWF4a1liQ3A5NGtLeEpZUkFEWDEwazdsejE4WkFqT01mT1ZpUlBZOTVT?=
 =?utf-8?B?Skd4aTR0QlVZRWs0TElVdHIwSVFENWFBQ3lXZHNaSDYrNS9jQ1gwSm9BUkZj?=
 =?utf-8?B?Vko2M29wc1VDWXorL20waTZvcm9iMkE2RnVNdlRxVEdaekhJQkV0YVg1RzYy?=
 =?utf-8?B?MFpoV2U3T3NaYnJ3MTJ3UnB5WFRlbmpLOERtZDJQSjRFdHpOSUNWQldxb2U0?=
 =?utf-8?B?b2lRc1pZd0ZCQi9jZUpqMkd1MGYvSWtYa0FPZ0ptKzNuemEwVUk5VWo1dnh1?=
 =?utf-8?B?YkRCSFAwM3Q4SzJDcU1DaVZKOU1ENnpFU2pJWGVtNUtsR2M4S1pPYU16Qmcz?=
 =?utf-8?B?ajJsdzNqejBZN2ZDMWNlelNwNENzLzRmbGJkREpvQzVFeGNkeDU0eitKcEhz?=
 =?utf-8?B?WVlHWTVuOFZualFuZytmR081RGZ4T3JGRWNHQW5hcWVkZkwrWDMyUHRWVndK?=
 =?utf-8?B?cEpES1N6aXVLMktqWEtoNTA4YWFQOVRFLzZEMlhxRVFUeEpEaDFGZzdTbDU0?=
 =?utf-8?B?K0ozQisxSDdqNXlvM09qRWR1UjJ0V0dncUh1UVFBb1RHZUx0eWhQZXlYOXFh?=
 =?utf-8?B?aHZyVFBoZ0hSRXhkVG1jbVl5MGNlYjBuWHdVQVJZMXdkalVzMXl2cWlDMkg2?=
 =?utf-8?B?dWtqT0FkWjZEUFlQSWdSaEdkWGtkWFBHYjNqZWxBQWY1dTV1S3QrN2lMU1pq?=
 =?utf-8?B?alFla0xxQlM5YVg5STBZUi9KazNmNlpKWXQ1VndZQ2tWSmx5cVBTdnpWRFdx?=
 =?utf-8?B?RU1TcWpocUo5eFMveXk3RW1aaGZCTGo0YmRxL0ZHL3dheG5sei9GVGtHOWFi?=
 =?utf-8?B?cnlnQnlMQjBkK2VNRlhKTHU1dW9lM0lvczhzQTYwNWY0VUdLa21oUEh1Sy9K?=
 =?utf-8?B?eTJBakZKNkhrSjc3UmVFazY5VTMvazdlRmJ0b2FkTUhpazVSN1pHWTkxejlI?=
 =?utf-8?B?ZmRZaWcvejhGUW50SmVPQmQwbXdmV2c2eFlCVGowOXBlb0dBZ1AzdXVCcWwz?=
 =?utf-8?B?ZXRvMVRWZzU4UXlXNm1KWFhteW1SN0tWbXJTSEo2a1Q2ZDVSRDlMYVZndWY0?=
 =?utf-8?B?YlhCV3dUNjU3dVlHb2ZMcVJpMHFzTXhSOXJZRDFSTTVhQWFxbk1KL2doS3ZB?=
 =?utf-8?B?TWM0VUJmRHJjbDhGaG9IWFFhVjJjb0ZYYkdkQ2ZEQTNLSnZ1R1dXc3I4THQ3?=
 =?utf-8?B?dzBBRWI2bms1OVlpUUd0RTdMQXlhK0ZCZnljcVJ6bnJqQWNQUW9SaERveVFm?=
 =?utf-8?B?NGFNSXZvaU9BUjdnQWNtSE5PWmNNaUtHSmlmaEZZNkgrTUR5aENyUEJtZFFv?=
 =?utf-8?B?eUdPNnRxMzBHNXMvdW13QXBxcTBaV2c5RFZLbmYzajJKeDJEd0lLbzY1S3pU?=
 =?utf-8?B?SFJhMTFlUG5SRm14ZTRmbE5ycWFwOWVhWUxibFIyUFF1SmxXV3NwU2VJMXpF?=
 =?utf-8?B?UXhQVWFqM0VEWWJiVzFyM2pTWFMzVjloKzJ5cTJob3AxU1dEckd0TnF4UTRG?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b6d0a3-0984-4206-0479-08db7e3e3bb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:29:56.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlDOApCzVSBn3UalrfeGuD1T88V4ESwJ2LhVNsIu2o2mV5iWWH1O+bJj+Yi4IZ3OUeaSxBAbklOcYxXuM/aiEfX+8smUsFdLqoYVqo0D5oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5587
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

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 6 Jul 2023 20:47:28 +0800

> On 2023/7/5 23:55, Alexander Lobakin wrote:
> 
>> +/**
>> + * libie_rx_page_pool_create - create a PP with the default libie settings
>> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
>> + * @size: size of the PP, usually simply Rx queue len
>> + *
>> + * Returns &page_pool on success, casted -errno on failure.
>> + */
>> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
>> +					    u32 size)
>> +{
>> +	struct page_pool_params pp = {
>> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>> +		.order		= LIBIE_RX_PAGE_ORDER,
>> +		.pool_size	= size,
>> +		.nid		= NUMA_NO_NODE,
>> +		.dev		= napi->dev->dev.parent,
>> +		.napi		= napi,
>> +		.dma_dir	= DMA_FROM_DEVICE,
>> +		.offset		= LIBIE_SKB_HEADROOM,
> 
> I think it worth mentioning that the '.offset' is not really accurate
> when the page is split, as we do not really know what is the offset of
> the frag of a page except for the first frag.

Yeah, this is read as "offset from the start of the page or frag to the
actual frame start, i.e. its Ethernet header" or "this is just
xdp->data - xdp->data_hard_start".

> 
>> +	};
>> +	size_t truesize;
>> +
>> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
>> +
>> +	/* "Wanted" truesize, passed to page_pool_dev_alloc() */
>> +	truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset + pp.max_len));
>> +	pp.init_arg = (void *)truesize;
> 
> I am not sure if it is correct to use pp.init_arg here, as it is supposed to
> be used along with init_callback. And if we want to change the implemetation

I know. I abused it to save 1 function argument :p It's safe since I
don't use init_callback (not an argument).
I was thinking also of having a union in PP params or even a new field
like "wanted true size", so that your function could even take values
from there in certain cases (e.g. if I pass 0 as parameter).

> of init_callback, we may stuck with it as the driver is using it very
> differently here.
> 
> Is it possible to pass the 'wanted true size' by adding a parameter for
> libie_rx_alloc()?

Yes, or I could store it somewhere on the ring, but looks uglier =\ This
one does as well to some degree, but at least hidden in the library and
doesn't show up in the drivers :D

> 
>> +
>> +	return page_pool_create(&pp);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);

Thanks,
Olek
