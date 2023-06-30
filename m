Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED5743EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3Pfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjF3Pet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:34:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A991BD6;
        Fri, 30 Jun 2023 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688139287; x=1719675287;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jrqTPvYLA5Q4Letouo3s8zFmCUV1PTas5BNMIGdHnWk=;
  b=oFHQ8AhCCXVfiia96+gDQ2d7gXUAiC4m8eZS2o0n2cf72flYSZVQCd89
   pXs/ljskIp4LohmCl8qOTbO7g7SaSbycOnv2RE2NtvTB4sMQc6ZaMPTHJ
   SoHy+ipx9i1Hkc2Els2G5KvN0IETPLueTjjkbncDGqBnNFGdywzsJ5Vbs
   j7LFInY9uTt8sHsabuPuMXqygk6ZU2aePzqbsMfedz0Mis38MV3JZEWdw
   8caB4lLIoRhBHZRm7MAC51Ss70lLE2pWIAQ7N+JUH2quS87KCnH7vSgqh
   fb03mX1D9sVDqy0ZIyfolSn8jn85B5WGFlNqEf29wzS69aVYfNFN9SeFM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="342757115"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="342757115"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 08:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="695055141"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="695055141"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2023 08:34:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 08:34:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 08:34:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 08:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe0HII8eQTwg/u5fQLMrUBlPlZsrL5Wr12C7k5WEnsR6oGhfRX7ZrO/XdiDqCKFSSqS2xJJLkPwmX42w25WHnYTzQyePlZN9QwbAbRY9HQx72OFShrelvtZNuvZvY0ItspYjOUYow7+JgfVvM7iw2v96F8zgwy/ace2Ij7JRVw+2eZrZKJ1VW9atXAe85K0obh1Rrm0cFPOl6nH9gVg/xPu1XuzeKkKcfcpVTAjSOXzq522USfCYa/gsdKgpqfZy9iutWqTOnS8r4R3L1qPXIcnPEBXx3wVSJiThRQNzzttKnpm9XiJoBZOWIMKA1uQn71iWbTVqqhRnK2hmdCM7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXcqaPTa4e0DKWPR76/nnV2bGnSaqd4IUviNqTGj+ZI=;
 b=AQoAIMkMrwgeKKzTfMUumSR259DLh06qOs1NUvrLwVwNkKMdgL22kFEewi4v9DUCEKeVsISSp3VifbgfR1be3r+vv9EgYybJPdjhvGYkm+Qw5KFDxGxGZDfepU0f6pwEcNnB31TgRAGNOkgNOHsUtqYR/5XFxwpAvXlrsARnRqMVk5Rl/mTVnyvLxZxOs0dxukh5bnoRIgXYBvilvArkNUi+sdDqhM5zpryYjMyzx4pQoqkDuKZmnqgrwG9++vI9TY34Wubjx+rstL3kBRGgcxwHE9/XOt32VDj049TSij9zx8WOmAtYMkTNhTeYM6klZpnfYu6R9d8st/ZfB/LKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:34:42 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 15:34:42 +0000
Message-ID: <413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
Date:   Fri, 30 Jun 2023 17:34:02 +0200
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 973889a0-833c-4c43-8ee5-08db797f8607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7V27eeMS79mgZFJP0ucLzInJk/s81v4rhxNqPt2ZzpXiG5Uehq9JBX7UauRwKzEQlErSz3dlK3l9IjtwWbCR7WPPlg5jcHFZF+nkKXVksSlI7D4d6UHtl5lbzS6n2X5l7xOffo4gzMndnj88PnS1eBlMOODj3wvQR7gO2sQu5kvaNwiJdpH1pj4+DWWBgNCOPqLI/cZEEye6agz3ULmTC34Ah9W//l8BKOODUaE9Kt2WM9d3j/q4E221oZj8W2b8ZX1LYjsf0bbfqORXuGevHwu3DeXfQOiOLx+vA2V4Cwd6V9ndUovhFH12vI4RbhjFtW+Cv7AEivS1kFR4DPqfnn6Tch1nCxGWQwTFfXD5v+GOaC4hMgUbZd3GNA4PLIrGnJ4OO100Y8Zq8A1K7TLuy4byhq0nIt3sblP51cQ3lvWjNnujE08+C7vMUzjo8a6aApr9HSAz5Crb/wWq2zc3Yf3n7ogN/BTGdvRelZEkrDgIc7kZvm1Z78xzDljOX4plMeEfhF3k7sN1w/UWLbJ/EdTKD7fOvvDOUm1JT80HLKDY/Zr8+nsWm8ozKIQihQVwiRehvA81aXlett5qPOHR3x21Wfj5uPcTjDIhCFpEOC4ebYFxzOzIms2eOwHaO3rd/y35/ApA2EAnFS5Hk0QMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(31686004)(66946007)(54906003)(66556008)(66476007)(2906002)(7416002)(36756003)(478600001)(8936002)(316002)(38100700002)(41300700001)(4326008)(6916009)(83380400001)(6486002)(82960400001)(6666004)(5660300002)(86362001)(6512007)(31696002)(8676002)(26005)(2616005)(186003)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZ3ZWFvV2V3ZnlIdWlYQWJSdzVpRHQ0TGdtOXpKK1lwRDRYSTVOSXFzRFMz?=
 =?utf-8?B?UmlDL3JvbmRnVHpaVE1hVENVdzJNY2JoYVdYZW5oc0ZOa25KNVBHQWtzT2dG?=
 =?utf-8?B?djM4Q3dBYUpvT2htcGRrbzYyZkVTUWpYQW9sMjFHMkZwVzlEL3QwN3B3U2Ix?=
 =?utf-8?B?b2l6bFRvWVR3cjc1eUg0c2p2OUw0eFNYVkdEV1YyS1hoNWxjOGY1TTIwRWhQ?=
 =?utf-8?B?cGJQdHJSM3FTMzZ4MTErSXhqY092WHoycDBsRXN2ZFJoeUJwbm8vUnNXaURk?=
 =?utf-8?B?RHpEd01uV1o0b2M2SXJ3TG83Vkl3MTdZWDJvc0ZzZzhUOVhsdkVVMml2MlZX?=
 =?utf-8?B?SXo1R21YbFpTSTloV0FXcGZiUC8vRXZMQk5NSEdFNjB2OVFicFNjV1dxM1lF?=
 =?utf-8?B?MEMxdjJEMlFRWWt4RGE0b0tEQi81bVBmK0ZHekZsYnFhR1JJck10MkNHZzVB?=
 =?utf-8?B?VHZWSzJjMVFqSU1ncFB6d2VZdHk3WFdNelJTb0lua0R3LzVZcE14R0ZvNU01?=
 =?utf-8?B?REQwMVJTdFhUWXdNeEhwVm53WWVXa3I1SFVMR2FkNE43ZEpna1ZQRUhXdko2?=
 =?utf-8?B?ZXVESjBtOUFXMmlNbVBXOWd4Vlg2ZFQ4aW43RUVpSmRoSUZvYmV2MmxsWDVz?=
 =?utf-8?B?MUJySmhRZGlVK0pmOTZHMytPNFVoQStOVlJja1RiU21sWUxTTTY0M0JObXF1?=
 =?utf-8?B?TGdXWTRqZk9FenpyemVhTnZXaXpCclBjaVZYRjRPYVc1ZXppaU5LbWpwTjRM?=
 =?utf-8?B?cC9aY2ZKc2h2R2ZsQUVuSVhmeHZxU05wUm9JWktRQnBjcFJNZ1RaaG9xTVV3?=
 =?utf-8?B?K3FTWC9lRHVLM09ienNLL1A5aDh3dFIwL0J5Z3ZrTlZRRVM2WUtNajB5Q29H?=
 =?utf-8?B?ZHQvckZHdnhJRnhLUitna0x4NVd4TUFHYXM3TFNNenBYTFBNYUFxWWFJRE0v?=
 =?utf-8?B?aFVLeUVqeXl1OEJXZUlweE5lUWdhNnZBeHk2em5vdHpLaHpJa0FONVY4NEZF?=
 =?utf-8?B?Skg2ZENMRlpkQ2lYQTNnczljKzlta3E2eWdGNUgyYzJSdkdWdFFhamVrQWJX?=
 =?utf-8?B?OHQ4YzhmRDVlVUN3VVR6UGt4TURHZzZlN0F4QlNIemVYMWZxbFNuTFF3cjZ5?=
 =?utf-8?B?Y080YngwanBJRGNSUnoyMjZmMlhERHh4ZmlkV0tZR0hTNGRjVjZrSnJNcTZK?=
 =?utf-8?B?UlNpUUFmeFBpWVNobTNob2x0SmhubFVGTkpEaGVFYlRDZnRpMVNkZmtSbU1y?=
 =?utf-8?B?YVc2SytZQ0RXMjVaR2xEWTJEWnVmM0E1WTdWTFhCZEhGMGc2ZDhvcFozN1hE?=
 =?utf-8?B?NzlWY2FYNDAvMmtHVk5KY0ZUQy9kNWpKbWkrMTFUTWFRdkwvOHg5dG1QL25J?=
 =?utf-8?B?bm44dXJwSE9hb1E1byt1SWhjb1AvL0ErNGpEd2NUREMvNzhXNUU5ZWpqZm5y?=
 =?utf-8?B?eTRRZVZVRDF1UFRHZnowcDJUSnBCaC92RkdBbkwrVVc2QlBzVnhzUnp4aDZE?=
 =?utf-8?B?YjIxN3Nod3pLSVB6aWwzVWswcEVDd05QdG1ReU5WcVR4dTBmSlBFVG9EZnAw?=
 =?utf-8?B?MU5mRG8xODZrbHJoTFBtTlFkNDBsN0I0SlFvMTFLam0xQm1idFo2R3piSlIy?=
 =?utf-8?B?VENqU1NIRnNmYWlSelFtSnExM1RjdmFia1FrZEhlQ294dGRzUEVQa25iMFNI?=
 =?utf-8?B?KzNDMHBPR1hpQUpYYnBnWmtqcXhKclJsRjRnSXBwamJPN200dk5neExBMzRp?=
 =?utf-8?B?ZXVFcXdpQll4Tk9yWERuYjV1N2JwS2FPRjlKVDB0cnJSOGJsdUVWMm5Kci9U?=
 =?utf-8?B?OHdpN1QwVlJoc0pDM3JpakZUZjNDT2lhUkZyeWh2QllaTFp4TWNDc2xBSzNu?=
 =?utf-8?B?b2lkNXdYRUd5dmpXWFRMaVZaQ1p5QjJtQjlieGdEQVJKb0o4Umh3bXZVK0xi?=
 =?utf-8?B?dFVoVTh0M3dOS2M4YUlVbnZtNFNrOURzdkVFdjVjQTJTODZTQUZFUmFhNy9k?=
 =?utf-8?B?ZGd4TkQ3cFNZVXFERDl4Z3QwNU56ZTZwWWRaYWxWZkprbGppK2VBSXV2M3VQ?=
 =?utf-8?B?aFZUaFBCUGtDdWx5dkNRSTVSNVNScjVMY0NRZ1FPdHQrUE1VR1VxdWgrU0JW?=
 =?utf-8?B?YlNHN1FtWHdkalVhS3FPN3R0WGVOcVJGZWR3aTJ3UEo1Z3IzU1hxWUZCRGcv?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 973889a0-833c-4c43-8ee5-08db797f8607
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:34:42.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxaOlqgP/k1WeBIwae5Pid38cCNVU+CT1jancyeM2cGKXG+rPiRUAUUEV8Bb7QvwCyRpmeJ8OqEP/FuW3hZt2s4cqr5EIK1orB162wqpUX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
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
Date: Fri, 30 Jun 2023 07:44:45 -0700

> On Fri, Jun 30, 2023 at 5:30 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander H Duyck <alexander.duyck@gmail.com>
>> Date: Thu, 29 Jun 2023 09:45:26 -0700
>>
>>> On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
>>>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
>>>> even when on DMA-coherent platforms (like x86) with no active IOMMU or
>>>> swiotlb, just for the call ladder.
>>>> Indeed, it's
>>
>> [...]
>>
>>>> @@ -341,6 +345,12 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>>>>
>>>>      page_pool_set_dma_addr(page, dma);
>>>>
>>>> +    if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
>>>> +        dma_need_sync(pool->p.dev, dma)) {
>>>> +            pool->p.flags |= PP_FLAG_DMA_SYNC_DEV;
>>>> +            pool->p.flags &= ~PP_FLAG_DMA_MAYBE_SYNC;
>>>> +    }
>>>> +
>>>>      if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>>>>              page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>>>>
>>>
>>> I am pretty sure the logic is flawed here. The problem is
>>> dma_needs_sync depends on the DMA address being used. In the worst case
>>> scenario we could have a device that has something like a 32b DMA
>>> address space on a system with over 4GB of memory. In such a case the
>>> higher addresses would need to be synced because they will go off to a
>>> swiotlb bounce buffer while the lower addresses wouldn't.
>>>
>>> If you were to store a flag like this it would have to be generated per
>>> page.
>>
>> I know when DMA might need syncing :D That's the point of this shortcut:
>> if at least one page needs syncing, I disable it for the whole pool.
>> It's a "better safe than sorry".
>> Using a per-page flag involves more changes and might hurt some
>> scenarios/setups. For example, non-coherent systems, where you always
>> need to do syncs. The idea was to give some improvement when possible,
>> otherwise just fallback to what we have today.
> 
> I am not a fan of having the page pool force the syncing either. Last
> I knew I thought the PP_FLAG_DMA_SYNC_DEV was meant to be set by the

Please follow the logics of the patch.

1. The driver sets DMA_SYNC_DEV.
2. PP tries to shortcut and replaces it with MAYBE_SYNC.
3. If dma_need_sync() returns true for some page, it gets replaced back
   to DMA_SYNC_DEV, no further dma_need_sync() calls for that pool.

OR

1. The driver doesn't set DMA_SYNC_DEV.
2. PP doesn't turn on MAYBE_SYNC.
3. No dma_need_sync() tests.

Where does PP force syncs for drivers which don't need them?

> driver, not by the page pool API itself. The big reason for that being
> that the driver in many cases will have to take care of the DMA sync
> itself instead of letting the allocator take care of it.
> 
> Basically we are just trading off the dma_need_sync cost versus the
> page_pool_dma_sync_for_device cost. If we think it is a win to call

dma_need_sync() is called once per newly allocated and mapped page.
page_pool_dma_sync_for_device() is called each time you ask for a page.

On my setup and with patch #4, I have literally 0 allocations once a
ring is filled. This means dma_need_sync() is not called at all during
Rx, while sync_for_device() would be called all the time.
When pages go through ptr_ring, sometimes new allocations happen, but
still the number of times dma_need_sync() is called is thousands times
lower.

> dma_need_sync for every frame then maybe we should look at folding it
> into page_pool_dma_sync_for_device itself since that is the only
> consumer of it it or just fold it into the PP_FLAG_DMA_SYNC_DEV if
> statement after the flag check rather than adding yet another flag
> that will likely always be true for most devices. Otherwise you are

What you suggest is either calling dma_need_sync() each time a page is
requested or introducing a flag to store it somewhere in struct page to
allow some optimization for really-not-common-cases when dma_need_sync()
might return different values due to swiotlb etc. Did I get it right?

> just adding overhead for the non-exception case and devices that don't
> bother setting PP_FLAG_DMA_SYNC_DEV.

Thanks,
Olek
