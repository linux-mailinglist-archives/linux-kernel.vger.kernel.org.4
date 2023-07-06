Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5F74A2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjGFQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjGFQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:58:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E01FF5;
        Thu,  6 Jul 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688662676; x=1720198676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=isdWrwTRO/OGZ444SzTF696Gjt5FXgzC4HbgJn1SzEo=;
  b=Dh+5fHDG9C1m1qZ4mFRBJ2TI9BF7ljZNMaoz73mmQMJQUrTaub9XqxO4
   6fq6tYOK/4qLhE4bOZiQ04qnBY9IIn/C7CrLWDxQTLQZg5iYpOnjib2Tx
   J2KWZeEGe9RyxLenp3teWbWmkUxHFVaLiJjJBNM6zngd5NZGu/dBGqnIJ
   DjPJprhJFABgwmBQowjkLYd22qtDtZ7AGVAD26ZoEOWuTd5jYWpjyOSSx
   mCObp/uIqJ3z93EokUREG9lqP/2Zx7N7B2HRPl9/lLlQ+IjK3Xfz4up/7
   UmVBeV8Bf7v0bmIUMCgJDZaMT3a0jfQDpoExfRxckl6qy38k6nXhUn09I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427339124"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427339124"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 09:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713654001"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="713654001"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 09:57:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:57:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 09:57:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 09:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbq5y/Y03DlTbSpMO953RbgNZmvadqd2Ks+W53BJ4f8rGizCtvR3w7BjR50Zeqb4ddKRNPhwAY58FED39Cmz4dt2+jjy009gXC1Qq2SKMKEG0YM836OG5RyfAsDqDm6Bo1mSSogyfjUUrHAD7Jckp/8gsP47qIOsnqdEFKfRE2mPlDcJp8hWniH1BWIEq/vE54SQ9yuDj2VlGOa29wRks8/95rEKN8MKQiWnh1Q9oZMnLksr4CSs/+Hp8SMfJm43MSf/tsnNoc3vp1mjgNJ90balvenpaoe805qOAaN/6yrg6/MoX8qOjM0XoTuzK5Dn2L8yT+4ZOzFb53QJ4Q3gPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJFhr21g+kVAMocx+pPGQEAc7ej0xF5Y+ZM84Fy5vlE=;
 b=NSIhFNqzdz7lniOvSAHkU2aQBQFRPvZmu0iR1pVB8XI1aTvKn2LSIPLOfqQk0kawNH4vShoFkXX9kc5yL8l0EokOWvT+Fk8EiXQozPOFaxCqgdLpK1Jrrgu+sHHajAEvbSiklxkELYQrJ4SppxIfuI2rrbIubuCGCGyDPaOXsYSrtKz2k+p0bqDokqtIuals1llaLKOmPD6LjXhNwAxPg3APPrEF+il4gwMjJbTOfF+GswSq8S0W0fCRBv6VP+QJALQmTrSvBdshIuDVMME6WWG9OwhioUY24Hu3G9WdiWSoZhix06y0tGg6trqu5lf38a8m4TL5PRFzg/93KQ52Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 16:57:52 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:57:52 +0000
Message-ID: <52963031-76be-b215-052e-a200f01d7130@intel.com>
Date:   Thu, 6 Jul 2023 18:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 6/9] iavf: switch to
 Page Pool
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        "David Christensen" <drc@linux.vnet.ibm.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <CAKgT0Ud4h32UFwiUhcpLxSrPRMhbKYSDncL2YiursWgS7Qg7Ug@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0Ud4h32UFwiUhcpLxSrPRMhbKYSDncL2YiursWgS7Qg7Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: d120de3b-2549-47c7-ce60-08db7e42228c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0w4cgx8psNQIE4kuBqiMCsLAXoUmD7dRndcFr7z4Hnzbhd39nK5ODY4ZHajJ2IZOXijp4JqlHrKZW916qwTrl7JHUZl7DUrAvGftbZ3yJzinKx5+4uYea6HBOXl3REfWm9bwp6O/klNGiCxE5bhImDqH5Kaj3E+sChx69bVNOvajLUzIeNAQeN4cD2DVBOTaDblE460GUkGNHFG9LSebJYDCP2EicwK0xiRiBFy5ocqYs3ETCpBQ0Z3PMOJMaB7dd/XSoosXRN5OQBlHdsY46KaFJn7WvciQ9BCNzCRNDlVuZnpd7e8gZRmhtNWxt3MIiEEqXwM+UUGuC3WeVUJOk9XmK3tfAwCDo2tIF5mlS5y9IGwXE5e0u8Hh35OmurstrL/xCGkXsyg6z5bLgfnYtGyKYGGOSRGbA4Nu/WT0DrGI/+KQnE5VzI2EM1Dbwubnj9DjDcxKEhMH4MrBXmb8rMk6/Wq0cdRIkrR60rW25qF50HSpMzQ7q1zkrf0ne+gI7kmkg2t5+rorrqv7V9WeWII+nAddcU15MQ6wezYUzJO3Fo1HpMe/0S8yNZlMPhOuvfcV4Q1Pmd4xqgnDPhU62ARoIiaXzdwDtM1uPYux+lp9zFpbTobOjScBv+7DOOGozT1/en6HBf6xQLGPRjeQMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(31686004)(38100700002)(82960400001)(66946007)(7416002)(54906003)(26005)(6506007)(53546011)(83380400001)(478600001)(2616005)(86362001)(66476007)(66556008)(31696002)(6916009)(4326008)(2906002)(5660300002)(6486002)(316002)(8936002)(8676002)(6666004)(186003)(6512007)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG9xeTNoQkhvbzJaK0kwdkRLbmNDb0RJY2wrazdDNGVnRTNOUVltcUU2Wlg0?=
 =?utf-8?B?ZFB6dXZJV20zWmF1cHJxUzU1YWZSTzlwME9VcUtPOVZMUmRQN3lWMXVLOE9G?=
 =?utf-8?B?UDFRTTlJQmhLYVV6U1NjbHdnQndvdWZkN1MwWUpZMUYrSklsSnc0UndJenlX?=
 =?utf-8?B?Rnd3RjBPbXB3UUIzMzh3U1Y4UnB1Y1BKRStNUXpFOUgzckZOWWpKbjU1dk5G?=
 =?utf-8?B?bW52NUJlbUlqakYzUEhRU0I4bnZjZzJRNUpaVENqalZ3S2E4R1FGeHlJTkNx?=
 =?utf-8?B?WFNqSFd0TloyQW1YVmVTU3dBcjdVeVN2aU8wS05hdTBTcG4vYmxxUGt1OTVu?=
 =?utf-8?B?MkJaNFFnbGlpWVAxSXU5TnJQUmdqV09Fdm53anZTbWJTMjFWTWxDcDZuRk40?=
 =?utf-8?B?MktoSnRQZ0NhcVM3OUg3Rnh0em5sR1lGbzVrbURGekJLQjd4Sll0Mm5PY2hu?=
 =?utf-8?B?bjhaMURCeGdQQTdtTGl4aUVLaHhSd1VTVzY2S1R2SlRPU1lFM250NUZLZmkx?=
 =?utf-8?B?Z2ZFVDFlaU1kK0JyQ2FIVk91ekM5NGVjOGx4YXRyKytXSWtyZmpKUm1ZUDN0?=
 =?utf-8?B?OEJUdHhGMVNwUHVtQkRJVVdaQnJybHdOWmZJV0hGNnIxMkpEU3lvKytvTXhx?=
 =?utf-8?B?bW5kcHRQT2lCYzE5d2RKS0FqeW13eHpGeDd1Szh1dFMwZjhOaVJZTzFTRUQx?=
 =?utf-8?B?dk1oOUhHQ0RaeU5GYXRucFFzYlpQQ09VOUNsbmp1SGRmZ3FmMVZHZjBEazZs?=
 =?utf-8?B?SFRmMHFOU0wxZVNyaFI1UkZOMW9xSXpjT0RMTHQ1UThMblQ3OXlQT212WUVX?=
 =?utf-8?B?NThhSnlvajhmc0xjWWVGVno5Ym1NS0t6ZjYrazBZeDZyTHpvQ1AreWxPQUVE?=
 =?utf-8?B?T1N2eW1HaUlBQ3dmYTJJd1MxWXNRN1pDd2R0MUNBWWMwcmNrYmpBQmlOcDJY?=
 =?utf-8?B?NHhaU3VaUFNGOVlQOGNrbkV5NmFKWDRZWEZrZ2NtZG50ZzhIOTNvR1g4UmpH?=
 =?utf-8?B?V0RUTDdrUk1hMHJpUTI4aTdIbTdUMkcvQXkyTkUwTW9VZzIrYXQ2U09RRGp3?=
 =?utf-8?B?b1g3NkU4R0dEcnpaa2JmQTdNZW1YckMwSzVIZzB5d2VSZFV1RGpiRDk5cjBr?=
 =?utf-8?B?NEdEaGFnWlhiSkpaSjBwdTdqMTlXeERidFI3N1VLcnBMbkMxcFdpZjcvZ25N?=
 =?utf-8?B?RVNsNGNvdmhSWmpyTUJrNlQxOTNMRjNXckRjNXdLREp3alUra255RHpCbHBO?=
 =?utf-8?B?QlhhQVdJNkdhR3JRUkJTdG1la1puQ0hMakgrOUE3NWNXNEN3MUJMQU41bnh6?=
 =?utf-8?B?NnkrNU9qYmFReFgrUVFTN2dZUXVpQ0xpamtnSldyU1hLQ05xcDhmUW51Vk1F?=
 =?utf-8?B?MzZWM2FOYk5sM2hxbDJDRUwzOVFJdVFyZUx4cXVOTEd5ZVpHd2w3bVY4MGt0?=
 =?utf-8?B?TDJRMU5KYWxrYTN4cFZJdTZnaTFrcEhQajA1Zi9jVy9PL2p0OFFnVG5jNk5r?=
 =?utf-8?B?QkdMSnArR1ExK0VQV3BkNWZlc2RIRzAxMElIYlZoUEtFWUtrS3NGaUpMaDhT?=
 =?utf-8?B?VCtacVI3MVIyZlhhclhkYm9hd2pBYUsyblhKWDlUSnM1UzJyTVBFdW4vZGla?=
 =?utf-8?B?djJGQmQrTTM0dWRUb2tQeC9wM3VDRFBxY3N3bTJxL0NqakJDazhIREpTbUtR?=
 =?utf-8?B?VjBaQVNEcjltbkRtLzBqdXZjMnViK3pkK1R0MEF1NzBOYldOd1pKSDhOL01Q?=
 =?utf-8?B?WC9OK2VJa0RWRTVheFo2bG54WU1HTEpDRFJGRGV4WUF6SHdOQ0lpKzNVTWE3?=
 =?utf-8?B?UkVNUEVQbXliQkYySzBpV1ZnK2NnN3JhaWFmbTRuZjErdWNSTU96cjhlSTda?=
 =?utf-8?B?dkZFbmFRdDEwRGZORHhOYW03QmxxTVhLM2NtcEIzSCthOXJaTkV0TmNRL1ls?=
 =?utf-8?B?NWJteVpxSk01SmJPaXpUUHo4cDVlZVM5aVQ5TExzekhicVFIcWpNZ0hLNWJO?=
 =?utf-8?B?OHpnQnh1WWpNVnZRaklMNVdzeEZ1S3pWTDN3eFkxVFoxdWEvazhXSlUrMnRw?=
 =?utf-8?B?MlJJQXRJOHlrdlhxMXRiWkZ3amx5VTR2ampWYTJhVC9hQ3JzM0QwZUpsbS9o?=
 =?utf-8?B?OVNRZ3BQbnlSa093Tmkxd3l5K2dFODRuRjFQNDJIM2FiQVI5QUV3YklhTTIr?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d120de3b-2549-47c7-ce60-08db7e42228c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:57:51.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOylhhrsww6beXuGb/quFO0aDYaBnTexHDLQ10gPeLPauNNTLuo3CUPdc++2srQCmIcz7GaX2wnblugZIeD7RgPqdttanNqETuoikBSup74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
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
Date: Thu, 6 Jul 2023 08:26:00 -0700

> On Wed, Jul 5, 2023 at 8:58 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
>> no custom recycling logics, it can easily be switched to using Page
>> Pool / libie API instead.
>> This allows to removing the whole dancing around headroom, HW buffer
>> size, and page order. All DMA-for-device is now done in the PP core,
>> for-CPU -- in the libie helper.
>> Use skb_mark_for_recycle() to bring back the recycling and restore the
>> performance. Speaking of performance: on par with the baseline and
>> faster with the PP optimization series applied. But the memory usage for
>> 1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
>> every second descriptor.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> One thing I am noticing is that there seems to be a bunch of cleanup
> changes in here as well. Things like moving around values within
> structures which I am assuming are to fill holes. You may want to look
> at breaking some of those out as it makes it a bit harder to review
> this since they seem like unrelated changes.

min_mtu and watchdog are unrelated, I'll drop those.
Moving tail pointer around was supposed to land in a different commit,
not this one, as I wrote 10 minutes ago already :s

[...]

>> -       bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
>> -       memset(rx_ring->rx_bi, 0, bi_size);
>> -
>> -       /* Zero out the descriptor ring */
>> -       memset(rx_ring->desc, 0, rx_ring->size);
>> -
> 
> I have some misgivings about not clearing these. We may want to double
> check to verify the code paths are resilient enough that it won't
> cause any issues w/ repeated up/down testing on the interface. The
> general idea is to keep things consistent w/ the state after
> setup_rx_descriptors. If we don't need this when we don't need to be
> calling the zalloc or calloc version of things in
> setup_rx_descriptors.

Both arrays will be freed couple instructions below, why zero them?

> 
> 
>>         rx_ring->next_to_clean = 0;
>>         rx_ring->next_to_use = 0;
>>  }

[...]

>>         struct net_device *netdev;      /* netdev ring maps to */
>>         union {
>> +               struct libie_rx_buffer *rx_bi;
>>                 struct iavf_tx_buffer *tx_bi;
>> -               struct iavf_rx_buffer *rx_bi;
>>         };
>>         DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
>> +       u8 __iomem *tail;
>>         u16 queue_index;                /* Queue number of ring */
>>         u8 dcb_tc;                      /* Traffic class of ring */
>> -       u8 __iomem *tail;
>>
>>         /* high bit set means dynamic, use accessors routines to read/write.
>>          * hardware only supports 2us resolution for the ITR registers.
> 
> I'm assuming "tail" was moved here since it is a pointer and fills a hole?

(see above)

> 
>> @@ -329,9 +264,8 @@ struct iavf_ring {
>>          */
>>         u16 itr_setting;
>>
>> -       u16 count;                      /* Number of descriptors */
>>         u16 reg_idx;                    /* HW register index of the ring */
>> -       u16 rx_buf_len;
>> +       u16 count;                      /* Number of descriptors */
> 
> Why move count down here? It is moving the constant value that is
> read-mostly into an area that will be updated more often.

With the ::tail put in a different slot, ::count was landing in a
different cacheline. I wanted to avoid this. But now I feel like I was
just lazy and must've tested both variants to see if this move affects
performance. I'll play with this one in the next rev.

> 
>>         /* used in interrupt processing */
>>         u16 next_to_use;
>> @@ -398,17 +332,6 @@ struct iavf_ring_container {
>>  #define iavf_for_each_ring(pos, head) \
>>         for (pos = (head).ring; pos != NULL; pos = pos->next)
>>
>> -static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
>> -{
>> -#if (PAGE_SIZE < 8192)
>> -       if (ring->rx_buf_len > (PAGE_SIZE / 2))
>> -               return 1;
>> -#endif
>> -       return 0;
>> -}
>> -
>> -#define iavf_rx_pg_size(_ring) (PAGE_SIZE << iavf_rx_pg_order(_ring))
>> -
> 
> All this code probably could have been removed in an earlier patch
> since I don't think we need the higher order pages once we did away
> with the recycling. Odds are we can probably move this into the
> recycling code removal.

This went here as I merged "always use order 0" commit with "switch to
Page Pool". In general, IIRC having removals of all the stuff at once in
one commit (#2) was less readable than the current version, but I'll
double-check.

> 
>>  bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
>>  netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
>>  int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);

[...]

>> @@ -309,9 +310,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
>>                 vqpi->rxq.ring_len = adapter->rx_rings[i].count;
>>                 vqpi->rxq.dma_ring_addr = adapter->rx_rings[i].dma;
>>                 vqpi->rxq.max_pkt_size = max_frame;
>> -               vqpi->rxq.databuffer_size =
>> -                       ALIGN(adapter->rx_rings[i].rx_buf_len,
>> -                             BIT_ULL(IAVF_RXQ_CTX_DBUFF_SHIFT));
> 
> Is this rendered redundant by something? Seems like you should be
> guaranteeing somewhere that you are still aligned to this.

See the previous commit, the place where I calculate max_len for the PP
params. 128 byte is Intel-wide HW req, so it lives there now.

> 
> 
>> +               vqpi->rxq.databuffer_size = max_len;
>>                 vqpi++;
Thanks,
Olek
