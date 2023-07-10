Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2074D7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGJNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGJNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:36:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BAE10D;
        Mon, 10 Jul 2023 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688996196; x=1720532196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SGQX7u4npo2HlvWnDiqxeD+J6BOLfyB5QlgSg71RnT4=;
  b=ZL3Vp9t2Q30RWD6UrWXsOAK3ulzxTCitmj32IlvdyK3qUPOlhf6e/p96
   5Dz+ACalAHSEHl7W2OOp39yH3V4RUSFZhiBp0oxnnU4GKzOBOlLuY48f/
   FKN5SOXDMFGOFkmP45Y1gtjqG7v56X0gwxbWZjhG7A/lW3hAXyO2k7SO+
   HeOdOYqCBq927YHPVrcilbAA0qo+WIn4PuApkdqkFq0ssOPVw3HEpLF6x
   5TzeLrsqZv4+Ydut925zq0ilBF34yCjJyb1rgSo2ixPfo1H/KHdnL4JB0
   MtBMMIOab2obNUbt6Wc7pPpynWCbJsTSBnMaNx8nf9G7/RDIZug5PXU8q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="363210942"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="363210942"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 06:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="786174569"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="786174569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2023 06:36:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 06:36:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 06:36:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 06:36:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmsLThwQ7vG8RWkyenKnQ5Yl4vgI8QjKfTiThlAjhiG5F4zYuKD+66IMqz//cMgZHmdCcgxj1Ek5k6cbeUHF1zSSuiwZMc24d9OmoGX3WgxAPPZ7egk9s/IyBwZzLS1+7pQgJpbklESrdprR+uFwj4bZQLWXDC7SCog8Vg2580zjMGV3WatAPHM6U/5eI+wYzkQmcz5jG2LlmL7otS8olw6ZhIrwf5Am+s661BTKOnxc6XlofpuohrXteD/xDjKrwmWx0A2Gbm/hQ1k28aR3zfKF98bWF6mtBlZyZbYO1kf7B2Icw60F5AFHThHwxdKbPDllxFWU+x5BAwfCmYJRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH9IEQECgW7FF7q41NWLbCMjUtZqj7CDHO7iGV790S4=;
 b=LQauX/NaEwFoWCNYQ1Jgihm29B4+X3ICrmiS9KusaxIIvlUHBn5kmEtCiE4Xffb0zMxKOnUXFM8T8xajRqan+Rs61qiFOuvvKQLIQgf+0DtlC/nIOEm+NpXLD2zClbVEdNSGOSSwjHVMs9R/63RBYNUc3hiKFqQDUtHmzkzJRt0kw0+BAAXCii8YBOmf1Qu5MCdk8vgLdHwKPgDsqsSB58k/JBDWWjfvEYxBGY1JG47ra69r+bKcmL9rEfMsOFGiHgsmFoogB3ogB0BPZHnrAUK5zFM7fq9pQ8iPBqQXoYGKm0pb8iPj2xQEvb+WaqQoT4LFbjlLOUA+tPWwfv8GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:36:31 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:36:31 +0000
Message-ID: <95c5ba92-bccd-6a9a-5373-606a482e36a3@intel.com>
Date:   Mon, 10 Jul 2023 15:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
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
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
 <bc495d87-3968-495f-c672-bf1bab38524a@intel.com>
 <4946b9df-66ea-d184-b97c-0ba687e41df8@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <4946b9df-66ea-d184-b97c-0ba687e41df8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0278.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: b523e307-0173-4889-4747-08db814aab93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOp5XhV5SBBq7ixT4tPW0jNQCVFkRhN0r/N+TEVIedwxrBBAoBMtDGfkdcmHGlCUB9tlJn1j2JRfYvVpq8ToVdHFSrGRHDPAuoRmHPStOySMdlCT3bDU/XLZfChYRZOBAG4x/m47SDXtdexb4KQAd0256RFPTtq4KVAE5YGRe8XhnoirH476hptZOmPSUGG19ECJcDgcqOp7RshrZa2ww0VdAeArAr7zMSqgvy+N++6Mls1Hs5aCb+1JYb3hSUnUlflO3u8YzlTJmDrT0ppVRcrPIYX3ISXUTFV6mawbPqpjnPIK+19u83DNufjJxgEkNQF/6umJo18Hg+L/SWqk8zQYx/RTUY0EXRK9N97bxHSZOMP4lup1cpUvbKiLBe7wAbeys1uCtgJTCCmtRvdfwbfRTQwhx7CqlYNYX+RAzF327Ht01E0FRIy67QHRqhJ8DXM6bf8mz/RoXu0P1tnLujaGLrOwk9KMZhrrHJsgUtA0HBjov11/PNQtFNGZ6cWD79lgTE28m73fzml+LIt9AHm7WMp9NH5/AZ3BmfgYXKW3cXJlNzB19rbzydx75HQ8dVgr4QzpePmeQ3d4SnjH3OGLn4twbba44On4iVMjXzUuCq43dRaNXEmj3kQKt1eNy1vuI/CORf4rtBkJtZGJdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(31696002)(38100700002)(82960400001)(31686004)(36756003)(6666004)(6486002)(54906003)(6506007)(53546011)(26005)(186003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hRUFpYelhzR0xvK0lnSVMxRndxL3ozRUdLMXpGK05mRUpPZmRNQzlJSTI2?=
 =?utf-8?B?MDQwMVFERkhyL2Z3Z1FYbHBvT2hyMEIvUUpHall6bnFjSHNxbkp6N05ETGpG?=
 =?utf-8?B?V1hOWTJkS0FOQStFVTZ1bit5a2Z0R2dNd1NPY2xvQUlreGQ0UDB4ZG1EbmtW?=
 =?utf-8?B?L3hhS0hmTTAxVGY0dGx1Nk5XNk1nYWE4MS9kUzQzUHpCUEtRYXdzY3BYTGhU?=
 =?utf-8?B?NlU1aXkvUlJ2YW5aaEM4ZDlNbmxiMGx4TFVHdDlvQlNHazJiRWlPZ0M2dENo?=
 =?utf-8?B?dWRwRWdyK0VCczA5bG9hNU8yWTdGcGNLREFBNnlCenVDVS9oVW55dGRZT3RF?=
 =?utf-8?B?b1EzUCt0TW1IRHQrZG9ZdTlMOU45SjE5Z0dMQnJBbTR4YXVtMTBRaXViVkRQ?=
 =?utf-8?B?S2dvMVdYcVJlTFhYQXdCUm5uT3hBMktzOGorM0h5WWlsNTZSNitoTno1NXNh?=
 =?utf-8?B?b25LWG84MEJ5dDVZa3ZXQThKeFFHaHJ4ZkF0U01hamRUNUpKc1JNWEVkSTVw?=
 =?utf-8?B?SDJ5UTBIa3ZYYlJkV2s2VDk0eVd5WTZhVXpaQWc1eUo2VEZFRlExZFVmVUN6?=
 =?utf-8?B?a3EvNWh0dnR2Y1RBdENiZjloSy9ReDd4aVZFb0M4VWFaUURMOENtWXNlMXhC?=
 =?utf-8?B?OStpMXNOMTJySnRNRHlDLzg1KzlJYWptVUQ5eGd5NGhETjVFZy84alRlUE53?=
 =?utf-8?B?ZVR6b25QcWZWZGhmQ0J4d3RLZnFmWTlUQ25CaEdiTUVrSmxwV3lTOVFJUDRv?=
 =?utf-8?B?aFEyeUJGcnRTaFlBKzRORjZwWEtPNG9EenVPYTFnaGhsN1JJUWVlZTI4dEwz?=
 =?utf-8?B?dEsrcE5uOWI4aVhjcmkxb1NFeHNZVlRQdElvOENBU2x3Q2xDVm9BczNTbHh2?=
 =?utf-8?B?ZnFpR2hOME1aM3A0TEtiMzh1dFlkTDRMbjNCTkFiYXdPdFNGdHYzVG9nKy8r?=
 =?utf-8?B?Y3NBa1REd0E1WUZxQXMvdng0QnNUTXhXTFA0amg5Y2pYOEVmaXd1dHBnMFU5?=
 =?utf-8?B?eW9QSjVMSjgrVDJTa2xNM3JFSXhqNzdRZG13d1E3TER4ZHZJMDVHWjVNWmxw?=
 =?utf-8?B?VmxUUUlTUFNIVFQ5QTBHYkJQY3I1cDJxanlFZHBmdEl3ajJYSEhPRVpKaGxQ?=
 =?utf-8?B?OHcwVWRpSDZDVitPSlFvWmRYRzFNTmZVTEJCSVpkN3lnNk1takhSM3JtYVgw?=
 =?utf-8?B?eTROajNrV1ZKTHBwWUl6WjIrbFkyb1FEWGtDZmlFendYVFd4YUhBZTZLYTBL?=
 =?utf-8?B?ZUNESGlUbmJzM2h1OWVvY2tpeTRSQkkrMHlpU1JLVkdCWkF1VUwvQ1A3ZEs4?=
 =?utf-8?B?aEd6LzExanNuay9sVzNuVGYxVE9kcmoyM3NVbDYyMDQwNk0vWGZLOUZJMmxE?=
 =?utf-8?B?QkNXdFpxSmNra0lnRDAyNWtaL290bjF2SmhTZWlvZ09iajVjRi8yT3Bkb3o4?=
 =?utf-8?B?bkhvQzAxdWFhZHZiZUd2RzlDbmpqb2o0cFk5enl2cXh5c3ZOZEkxL05Fa0N1?=
 =?utf-8?B?K2dKQjVJWTdsOFBhUzJLd21UbmhCaFBvUFlKcVRDckZLSzNMa3ZEUTVJWXZP?=
 =?utf-8?B?aWQyRmEyaVZrWUwzOEl2UVk4WkxCRGNGd2NHVE5BM0xWNmYvT0JBUTZNdXRp?=
 =?utf-8?B?WlJ4ZDREMHF5NU43bkcrTFpza3RZd1JnU3p1OUhRcXhKeHFJV0dMSkd1dDBk?=
 =?utf-8?B?QjZCeVJjeWFSTndKMi80QXNLSnVUbjR3NFV3dnZWbjFEMG5rTlh6VUxxU0FI?=
 =?utf-8?B?SFJMWjY4SllUMkNJazV1OFppT29wZmp3TndJanJFYTh4QW5jZHlLcUJJSlcy?=
 =?utf-8?B?UHkzYnYwSEVseEJMRFY4a2Q5U2d5TXZPMDdyZWVBM0VEUTRRMzA5eDQ2NFBw?=
 =?utf-8?B?VEl4QUFSNit5TTN4Q1I3cUVYb2czWVVQaG9zV2c5NENCN2NvcXgxR2Z4S1Ju?=
 =?utf-8?B?alVsQ3VXQ3gyeGZOZlh3WGVOb2owYW04d3YrUlFyWHhZR1lITVgrTGFyQUlz?=
 =?utf-8?B?YWRmUEFtK0xZRUJCVmZhU29NUGhST2twd3MvUkNiL0lnR3VKL3ZmVmdQZmpn?=
 =?utf-8?B?OHlKOU1iUmdYMmhHOG5DQVp5ZWc4YU9ha0k4ZnU3eEpTOEhDcXBpNXJqdk5Y?=
 =?utf-8?B?VXY3b2hGZkRUS0hMcnExRnpBbGJWNTBMcFZ4Tkc4YTNFZUNRT3k1UVBZVits?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b523e307-0173-4889-4747-08db814aab93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:36:31.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9Y09MGQ+RpOuOqnso1CcVC6BSgslzH2xpXQ2qhioUZcFTlYJUMZsZJi5kcJ4I0UTeu4iL8ys7prZLgmdi5miEqpdghVSyinrSFg0i3Bt5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <yunshenglin0825@gmail.com>
Date: Sun, 9 Jul 2023 13:16:39 +0800

> On 2023/7/7 0:38, Alexander Lobakin wrote:
> 
> ...
>  
>>>
>>>>  /**
>>>> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
>>>>   **/
>>>>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>>>>  {
>>>> -	struct device *dev = rx_ring->dev;
>>>> -	int bi_size;
>>>> +	struct page_pool *pool;
>>>> +
>>>> +	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
>>>> +					 rx_ring->count);
>>>
>>> If a page is able to be spilt between more than one desc, perhaps the
>>> prt_ring size does not need to be as big as rx_ring->count.
>>
>> But we doesn't know in advance, right? Esp. given that it's hidden in
>> the lib. But anyway, you can only assume that in regular cases if you
>> always allocate frags of the same size, PP will split pages when 2+
>> frags can fit there or return the whole page otherwise, but who knows
>> what might happen.
> 
> It seems intel driver is able to know the size of memory it needs when
> creating the ring/queue/napi/pp, maybe the driver only tell the libie
> how many descs does it use for queue, and libie can adjust it accordingly?

But libie can't say for sure how PP will split pages for it, right?

> 
>> BTW, with recent recycling optimization, most of recycling is done
>> directly through cache, not ptr_ring. So I'd even say it's safe to start
>> creating smaller ptr_rings in the drivers.
> 
> The problem is that we may use more memory than before for certain case
> if we don't limit the size of ptr_ring, unless we can ensure all of
> recycling is done directly through cache, not ptr_ring.
Also not sure I'm following =\

[...]

Thanks,
Olek
