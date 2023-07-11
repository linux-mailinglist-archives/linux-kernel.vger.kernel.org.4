Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677A074F5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGKQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGKQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:40:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83A12F;
        Tue, 11 Jul 2023 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689093633; x=1720629633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nPtF4ygpIMFsnI9VerWPKwSynlDGmIp0fRN5xi0NpN4=;
  b=XPvgsMT93UcpriJNRl0LlXPg1M0GG37XVtFSaDik+sXToX4ZRAv6xIop
   bS2OU/88Syg0FAD2AUIJevOJUs6xJh9t3go01OgGpG8uj4/f/9RI+8XTV
   NLIeV1hrmejMWga0q28Ljgect5Qb9a2cxyqYHAfRA9DeYtYpNVUwjyG/p
   FvlBTv3yb21RAwIT6nWnkGJZmsrW32C4fi8QEeI/91FuTVgCNBpVCT1E5
   Gb2FUXgyUm+7buRFBkhQPR7mBbYRZreF3mhS9fof5NBT58xFn3eVY8v8K
   zc1Z0ZFCbKXk11VkyOHv1eY3XYGn8ivOuuk+Yjdy1QIBCnmjlSxK6I/IK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362134844"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362134844"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 09:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="791261230"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="791261230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2023 09:39:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 09:39:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 09:39:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 09:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5+ssIS0tbyUuCzI5E7UIDZJvsWBm97XBVITfPntB9S1ar9jyAcQjvsjmI9X4Mgen5EtEBlmgphJTgMRR3pIWlUZocPPgkna7OcnnAHgDOhSHfyDzSWRfC5iJlvAExKTXMyHRmnxXBEEdb0onRUQyWIYLwypbmh38XMXEmHneWXq2ei6D8hvGlKIyunuZVHie9KxCu0LFGc1pFLJ+JsuNdxEIJccx1UDezuumPJvKFY2s84Cuk7ByXqlFRgjzxBreaKJZAYC45qEMAlM8RupHha4HwOU55kA9OLlWNuum23XT3iGb1ztzvaFPkVRDwKo7gHnCDBLlrRrHZb++xQFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXKFSQcRgB1353FI6zb14M1qdXoPyz78We8nDuznqoo=;
 b=SF1Vx6jjLIEZMR1UkGx0xK6o7w63ZgfYqdUmpyiIAwrvT9Vb0LpA5CpFeK91TaSVeAEDUkJZZql14YtPveoVnSNBDFw85utulDczVw8kMT5OAscBm9k8vyOMEZAYFzceEILIYQYGnB2dWw8Fp6c/YXaQO23d9ilJQC9hh3jEj4zncaIYoYWQ1sYMg2VZLgENnuGbvXuCcq5YTV18CRw/i0kbBf16lCGfjZZRoPfjBPyQ0QCHeszwABZ4fNyF/TI9QbpkU8BOlefz9IL8D4tUry9IHXyVFQNZ0ePX8fh7EuesRlfL01+lH4Flb867o8hMtWGn80OGPyg7TVwlvRLMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Tue, 11 Jul 2023 16:38:56 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:38:56 +0000
Message-ID: <89dc48ab-0800-b12f-7124-cecc709364d7@intel.com>
Date:   Tue, 11 Jul 2023 18:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via
 Page Pool)
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Yunsheng Lin <yunshenglin0825@gmail.com>,
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
 <b05d1a35-5bc5-b65d-b57d-5cc1b0f898cb@intel.com>
 <2ebd75df-51ff-4c62-2a68-d258dbf32b49@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <2ebd75df-51ff-4c62-2a68-d258dbf32b49@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS7PR11MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a0e759-91c9-4dc9-aebd-08db822d5220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmvkM5hCfbCtenvSmodSS+vhVp/sfnhSSZwAEUIn274acyHxusqIp5Dos6qbf3RIxck+ADSqJDdu0y6EUQ2X8XV7hUdL6KB6dHsbJbR9gs6j2l3V2m81trWlTtwFq8IwFqhfgJigt3+8Gb2mpWwku8xQOmh+35tyb3jI/U565HSY83WNkp+UbjapxDVOm4PNVc/EEwWEp+A9ILSulPERW3QR9Ou9lKbrZiP/uorlDSQJe2IwFpKRnS+ExlzDXlzyUluXmHVcUsF2r1HovwmKlNRlYMP4O7zEqq4y+zzgo3HqJDGDEuMC8Rmo+BUlM4MSihrH2m3NZ7j4kr/TvLaTt4Gxtv9v17ocKfPqOjulvEhz7DYliUExa9Qr8FeiPXPfjagpAbYBaZvTlQEvznaQO3m9RoZH3KPpvUgrWb+4BeO3gb5Idn5e4m5rMpF9r6Ai/fGfBVY9mh3AphOJhJuFgrXOwECsohTl0v1XLfZ7/AexIjVHS5cCWcymVbqzFu31PTJrqGmkR3MOrbMAphIKylGu/a8av5VBY/k5ga4G0PYswllRemXFWap96RqOziNx0rA1rvzdB5WOBTyK8tWHPueUN5sxe6o56+Aw48vmwgqYdJPCDQ5kzcGQTjJmKP0QGFXWuJPnw4SGiLxib8ZM7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(31686004)(83380400001)(41300700001)(2616005)(7416002)(2906002)(186003)(36756003)(38100700002)(5660300002)(82960400001)(26005)(6916009)(4326008)(8936002)(6506007)(53546011)(66476007)(66556008)(8676002)(316002)(86362001)(54906003)(31696002)(66946007)(6512007)(478600001)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNvb3JGdVQ1endQa21YRTVlOUxBUU5oSU9STmp5aUt1ZnZWcS9lTTVBVDlv?=
 =?utf-8?B?Rk9JblV1VGwrQ1VHUHVBT040WkFzWG9LcGlxT0wyeXpSbFZFRWlnS05uTHp0?=
 =?utf-8?B?UW9wMTR5Z0RJU3BrYmRIbi9QVmdvV3lINGVEaC9yTnNXSHZxZzRmYXg4WFZr?=
 =?utf-8?B?S2J4YXNYZXUrZDFkcS9ZcWZEaC96SE9mY1ZvVDl4MVh0OFZTWG1rcEVIVU4z?=
 =?utf-8?B?cnNlcm40OExnQXJhQXlEZDRiQnJNRG9zOHQ0QW5CNlVKQkNBVmw4NlY4YWlK?=
 =?utf-8?B?cmFzdjJtYWdkVFBoYXN0U3gvci9DcTFrTmROTy9FMmVuK3hwZHphbVZkMGZR?=
 =?utf-8?B?N2xnYjJ5QzBuRzNOR3oyVi9nRnZOQ1FOSStpMGZqSmxBZHV0SWdxZ0h5Rjc2?=
 =?utf-8?B?Ky9idzJaSjZxMFRUSjhoY2hNZU9jVXhDYTBZN0hSR3V6VlN3YWxiZmsvb3k4?=
 =?utf-8?B?YXJSU3NPckY4a3crWnU5TnNqWkwySlI4dWovVWorKzBENkloSHREaFBPNk1v?=
 =?utf-8?B?clFzVU9sekxOQno3aFJrZG5ieTY2YnJueE1IMEZ6RTkrblRaVFROQ0YwcjVl?=
 =?utf-8?B?UUhwRXUrT2ZQS05LMVBTSzJDbDhpWDZlbHViU2djd1lHdE5CZnpPcUJHbXhT?=
 =?utf-8?B?Rkxwa3UwQzVYMzF6ZDlUYWdseFZUVkJxYXMzRk1wQVR6OTZPazBVU25kblV6?=
 =?utf-8?B?c0V4S1BOU1BOdUxxV3Brcmd3bS9kZTdHQ2NJOTExNXB6TVhMblVWT25jVWdR?=
 =?utf-8?B?RU42ZldSZzA2aTVXdGVmQms3emN6MFBMUzd0TzExendpOXRsL0xPcXRmYWVv?=
 =?utf-8?B?L3lneUlWOGlqbEJhSkh6M0hCNkhJY0thZnBzbEhZSU5KbVdrWkcwYkR1ZnhT?=
 =?utf-8?B?TlQraFUxZ1R4a0NKVU1yL1djWlFBV2h4aHh5MjJrK1I4L0hwbkFvOUk5TEFH?=
 =?utf-8?B?dkVOSHYwQm9kcnI3OEx5MEg2K3VieHE3bE5CdlJWdGlDUmtSWFpPb3BVN2c3?=
 =?utf-8?B?RjZuTkI4MVB6cjBJUTEzcUpOTis5YU1KUzV3MVlsVXAvRE5wWVViM1Y5SlFy?=
 =?utf-8?B?Y0NTazVyZG45b2RIdG8rbzdURGZJdms0ZWdnSUd0dnFiRVB3bmxpZGJxQTNo?=
 =?utf-8?B?azMvOG1QR0l4aElUZWtuczlFYVU1a200VU8zeG9jUmRZWkN4SU14NGlJNUpM?=
 =?utf-8?B?T1VMSlNFVU5hTjd0dmQ1MHVHQWhsZHBicjV4SUI2aFgzV3JUZyswNzl2Ung1?=
 =?utf-8?B?VXZTWkZqNGFTMkRSaE5rckhKTXBzSFNmNHBEa0VOaURiMTFVbXAvRk1Jb3dx?=
 =?utf-8?B?RmFKc1pid2JHK1M1RTJxNVBzNVJicXlHbzZoSGJrMVdCM0dBU1BnQjU0WGRZ?=
 =?utf-8?B?OExUZ3NScG8xNDhtVkZwVjBqMjMxeklOZTNrejV0YWV4dmRFc2VJdm9uTURW?=
 =?utf-8?B?T3A1aFJibWtEbUI2MmEyY1ZLVUlUVWlxQkREQUljdFZad2w3RjZXSC8yUllJ?=
 =?utf-8?B?aHNEbm55UVAzSGgwWWVNWjhSWHNhRjFTcTZTK0ZVUHdpUVVkQzJYWXhCVjBC?=
 =?utf-8?B?NzNiN004OXBYbU9wdWVVcFBDRkxINlJQSU9FeW10amRoUU1BcDk1SmJQSy9h?=
 =?utf-8?B?b3RHZ0UrUXhqcEJqSjhCZE5XNEVxSHB1ZE5zK1BUMEtaVUZ2cWpWQ3M2RTAr?=
 =?utf-8?B?MFZVR0dwcXBCajBGOS9zeGFmbEN3a0duMnNwQmpMUkNycVpIbWI2VVR2dTZP?=
 =?utf-8?B?SE51VWZWanVsbU8waUV4bTFFNzY5aUZHQ1RrY2hxNDlhYWZpUmNMR1dWbkdZ?=
 =?utf-8?B?VjVXWnNwS0FXNzhZdlE4ejc0QnA1NHRKVW9lckRMYkNEMnNUVmYwL3ZMZ3pM?=
 =?utf-8?B?WGE0ZythRDFIZFNteDdFZDI2RlUzalhCb1N2TVJsb2pTVHBGNlljVEZ3RDJ6?=
 =?utf-8?B?T25tdXBSRm1mTERuZXl2WDFsUDhia0RBQ0tGNkRKbFFDMWdtUkpwOWw1Vy9w?=
 =?utf-8?B?YTNwUnU1cVJibjVTWEtrM0ZGYXVaVWVNbmliWS9lcXJtRzRJL3NnRWtDTm9G?=
 =?utf-8?B?QWtWWVJaUHdqOEozWW9EUUFEekJtdUNpOC95dFNHQVlaRis4SjdjMWU4bHpn?=
 =?utf-8?B?U3JNcThrbVVtQzkwQVFvc0RXZDBRQThPN05ma285dXBuTEcram8zUDllbTNZ?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0e759-91c9-4dc9-aebd-08db822d5220
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:38:56.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9w9LhM/2gSzgrBYqkCjiowWt3H5hb9jM1LFitvGeu1onDMBJe1IjDy7bTserRtc8QgzDdpUChZxoAbCIpWUvbdeZiF5YVBotCL4LNlvDJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 11 Jul 2023 19:39:28 +0800

> On 2023/7/10 21:25, Alexander Lobakin wrote:
>> From: Yunsheng Lin <yunshenglin0825@gmail.com>
>> Date: Sun, 9 Jul 2023 13:16:33 +0800
>>
>>> On 2023/7/7 0:28, Alexander Lobakin wrote:
>>>> From: Yunsheng Lin <linyunsheng@huawei.com>
>>>> Date: Thu, 6 Jul 2023 20:47:28 +0800
>>>>
>>>>> On 2023/7/5 23:55, Alexander Lobakin wrote:
>>>>>
>>>>>> +/**
>>>>>> + * libie_rx_page_pool_create - create a PP with the default libie settings
>>>>>> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
>>>>>> + * @size: size of the PP, usually simply Rx queue len
>>>>>> + *
>>>>>> + * Returns &page_pool on success, casted -errno on failure.
>>>>>> + */
>>>>>> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
>>>>>> +					    u32 size)
>>>>>> +{
>>>>>> +	struct page_pool_params pp = {
>>>>>> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>>>>> +		.order		= LIBIE_RX_PAGE_ORDER,
>>>>>> +		.pool_size	= size,
>>>>>> +		.nid		= NUMA_NO_NODE,
>>>>>> +		.dev		= napi->dev->dev.parent,
>>>>>> +		.napi		= napi,
>>>>>> +		.dma_dir	= DMA_FROM_DEVICE,
>>>>>> +		.offset		= LIBIE_SKB_HEADROOM,
>>>>>
>>>>> I think it worth mentioning that the '.offset' is not really accurate
>>>>> when the page is split, as we do not really know what is the offset of
>>>>> the frag of a page except for the first frag.
>>>>
>>>> Yeah, this is read as "offset from the start of the page or frag to the
>>>> actual frame start, i.e. its Ethernet header" or "this is just
>>>> xdp->data - xdp->data_hard_start".
>>>
>>> So the problem seems to be if most of drivers have a similar reading as
>>> libie does here, as .offset seems to have a clear semantics which is used
>>> to skip dma sync operation for buffer range that is not touched by the
>>> dma operation. Even if it happens to have the same value of "offset from
>>> the start of the page or frag to the actual frame start", I am not sure
>>> it is future-proofing to reuse it.
>>
>> Not sure I'm following :s
> 
> It would be better to avoid accessing the internal data of the page pool
> directly as much as possible, as that may be changed to different meaning
> or removed if the implememtation is changed.
> 
> If it is common enough that most drivers are using it the same way, adding
> a helper for that would be great.

How comes page_pool_params is internal if it's defined purely by the
driver and then exists read-only :D I even got warned in the adjacent
thread that the Page Pool core code shouldn't change it anyhow.

> 
>>
>>>
>>> When page frag is added, I didn't really give much thought about that as
>>> we use it in a cache coherent system.
>>> It seems we might need to extend or update that semantics if we really want
>>> to skip dma sync operation for all the buffer ranges that are not touched
>>> by the dma operation for page split case.
>>> Or Skipping dma sync operation for all untouched ranges might not be worth
>>> the effort, because it might need a per frag dma sync operation, which is
>>> more costly than a batched per page dma sync operation. If it is true, page
>>> pool already support that currently as my understanding, because the dma
>>> sync operation is only done when the last frag is released/freed.
>>>
>>>>
>>>>>
>>>>>> +	};
>>>>>> +	size_t truesize;
>>>>>> +
>>>>>> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
>>>
>>> As mentioned above, if we depend on the last released/freed frag to do the
>>> dma sync, the pp.max_len might need to cover all the frag.
>>
>>                                                ^^^^^^^^^^^^
>>
>> You mean the whole page or...?
> 
> If we don't care about the accurate dma syncing, "cover all the frag" means
> the whole page here, as page pool doesn't have enough info to do accurate
> dma sync for now.
> 
>> I think it's not the driver's duty to track all this. We always set
>> .offset to `data - data_hard_start` and .max_len to the maximum
>> HW-writeable length for one frame. We don't know whether PP will give us
>> a whole page or just a piece. DMA sync for device is performed in the PP
>> core code as well. Driver just creates a PP and don't care about the
>> internals.
> 
> There problem is that when page_pool_put_page() is called with a split
> page, the page pool does not know which frag is freeing too.
> 
> setting 'maximum HW-writeable length for one frame' only sync the first
> frag of a page as below:

Maybe Page Pool should synchronize DMA even when !last_frag then?
Setting .max_len to anything bigger than the maximum frame size you're
planning to receive is counter-intuitive.
All three xdp_buff, xdp_frame and skb always have all info needed to
determine which piece of the page we're recycling, it should be possible
to do with no complications. Hypothetical forcing drivers to do DMA
syncs on their own when they use frags is counter-intuitive as well,
Page Pool should be able to handle this itself.

Alternatively, Page Pool may do as follows:

1. !last_frag -- do nothing, same as today.
2. last_frag -- sync, but not [offset, offset + max_len), but
   [offset, PAGE_SIZE).

This would also cover non-HW-writeable pieces like 2th-nth frame's
headroom and each frame's skb_shared_info, but it's the only alternative
to syncing each frag separately.
Yes, it's almost the same as to set .max_len to %PAGE_SIZE, but as I
said, it feels weird to set .max_len to 4k when you allocate 2k frags.
You don't know anyway how much of a page will be used.

For example, when I turn on driver-side XDP, increased headroom makes
truesize cross the 2k border with 1500 MTU, so that 2 frag per page
converts into 1 frag per page. In fact, instead of using the whole 4k,
I use ~2200 and don't need to sync the entire 4k.
Setting .max_len to 4k gives you way heavier overhead to non
DMA-coherent systems that per-frag-syncing would do.

> 
> https://elixir.free-electrons.com/linux/v6.4-rc6/source/net/core/page_pool.c#L325
> 

Thanks,
Olek
