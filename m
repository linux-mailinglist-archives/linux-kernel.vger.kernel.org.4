Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B15BCDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiISOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiISOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:02:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B8EE16
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663596125; x=1695132125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zcqmAomUaoJZpQk1J5OTazXF26pH8JxVl33bB8VJmBg=;
  b=YHD6JhmEHI02utlWkBVTmVR1ON86WnMiCbK2qf+vmSN0SYy0Fn+lMSEg
   XhBeVnim8OkWV9Kr6a1G7iCGdWFnhAFlGCLaGEqjPeFH7dUPjuGHx2XeS
   GwxcoCjtTacksKT2JW81Lj6+zg1Z23/r3aHUQ+s/tP0STZvHyMVZnNKiq
   ljWgigiNOsGz72Nf7PCuHg5fFAaCJzzBClHiX/VATj1htChiKqIcNNMH4
   zh/HO/Cv3T5oX3EfqOzq5So4mpFUtk/mhwENqKFfMsOlmwRgrnLmjsLHw
   zoMVxW7lhBJfP2dlUX++6t0CQ2DOUU6XrZ9NiXzh5BOkhj0yqoRUDRyd8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279134996"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279134996"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="614006047"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2022 07:01:57 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 07:01:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 07:01:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 07:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FudVOanm6OBXNq+nNNxvWs6qgXmwIQ3+OidprXjo8k/aNXqyuARjjeDHT3B3NChBxcGnL5mCMO7v92NucOhKKrtrh47KnXpUIHY+BjCMqrsJE0nl6xrPL5rOfoWzoh/ydMXnv/Jy10Y7PvzjyH2lhuzfwRV9LvMz/qe1EUK642tzlyGL9GMwD8dX/5BNAp7+WABLPqs4HmoxLGpx6CmggpC34isW4ZrmH+DYOttkK633E5fQW5xdj+mw6POT/eNSldM0Sk7m6c16ILQA1R6NnJszkEswsPO+1cT8yczvlA7R+lW+oDqQZ3LUveqC3zOoLmmUXLkwqQsUiL/NsaEL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEOaEw7tWbDzoADWLPyRJ5xdkjIuPbq1OIjN0kbQOoo=;
 b=T+C3ewVLkeCJVxH4Tko3W3uvZersxQOFenpBC3pO/o7o1yOYe/eJXut3DEPqMhqoYsG1QTC5k1P4mptKV4460P58iMIdmO5k4UivIQwnlus+M9j4TknLvGsGm9AqRO8GVbl68T8BY5jLyuC51PfaN1JKx6j38vEWswqkJfld0Z2vOao0MeMtlZT5Om9YmtZrws5wpV1Mt+qmUu6bBHkSC+kQM++fEaiaBeJwHfxoEkgaX229QXLkXGaDzD8m6BCECZgyDEVy9bq7A/0MyFy6oaffyDTNhWmkEfeDb05C8yYvUZ1s6UsRnHA/BNnsQ3T5OZ1uT9WaSO98gdoUeqP4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:01:50 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::3068:ad4d:42b5:6b0]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::3068:ad4d:42b5:6b0%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 14:01:50 +0000
Message-ID: <7090732d-291f-de14-21d2-afb4dc5e0d8c@intel.com>
Date:   Mon, 19 Sep 2022 16:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [topic/core-for-CI] Revert "iommu/dma: Fix race condition during
 iova_domain initialization"
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <intel-gfx@lists.freedesktop.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20220914124045.903883-1-karolina.drobnik@intel.com>
 <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan>
 <c539a4fb-795b-0b33-2543-6a3e94164676@arm.com>
 <fbca082a-7fb1-bdb5-af93-69061e597b34@intel.com>
 <20220916203238.g364hpyrcuoo4h5m@ldmartin-desk2.lan>
From:   Karolina Drobnik <karolina.drobnik@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220916203238.g364hpyrcuoo4h5m@ldmartin-desk2.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0054.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::31) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|CO1PR11MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: a28bba6f-92e2-457f-13b0-08da9a477f7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3N0jeJuVj2v2QIW3R34AEoJOD20yWRup/4ECaqvd3d+rzlmOFKVZvNyVZ4GFH+bJV5p/bfEIW1tliPJDGYK3I1amnn3KsPyyyCE2ql4Yj9cUS3W4QdYkhEdHIGrQmkneP3zCN4nOoZ/+P/RaWkxflks3TpdvRordtQyO0J0AdkRgHFxDDJOzjNZZB4tlKoM6Mw85ddYtkytdPBb8HnChnDpGnr89vcAmF6JspjcysK7NVLcjeWmDgSMvcEEkEr6ZzijJzsCSX6jwJ/IftZ5CVzh/6AakhcSAEUg6djczCNPLTuZAj50NFvtSaUu7HubEAm1EWqbBFvdyhMe+lscr7QOOHctt9MhkY/85oiZSFI3IUshfRtVzi5X2pTQz7O729zH+rMR+Ej37JZjQ4VKVA23Vg/79+peC02mvBlNZsxso3bYJAGD62flVWoTo3J3ErPz4ogBaOmf3jnOiGFd4pmPOAsDVqSfDmGAIZiXsqAJju9e3g/eFJmh2Pll2g+Ii7jKT0o1R4p+uHe78V+3YORSbtHZ/6wmSpx4PLTTTIvpoCOF8ZiP/XiNfk4BKe5JYOLz+qFnng8gVHF1mR/TEFUqbPtTWAHVjZGC6O/mt5WkV2Ob8dgLRUO/QFV0syiM+JQQ3GnIqEKuJ8xwvJWgixkZFVyp/emP/j/YkbW8Q1GZxoKEFjwsjETZOoXuoCHqgX9xYwCZ848aCmhIcH0CHywlGoW8OsI53yOFElZeqwqKpZRbVRubkUUk2S6dHkikVfqa3/sbKKCp06KxSXje6mPt7agYVvuN+3Yc6JjBoif5c0rXOF7yZSjqvhMFTFH4uHQhl18sO/uneiTKygxhq6rDofpIpnicjvF3IAeradgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(2906002)(2616005)(54906003)(966005)(44832011)(53546011)(36916002)(41300700001)(6506007)(6666004)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(316002)(37006003)(6636002)(6486002)(5660300002)(36756003)(31696002)(186003)(6862004)(8936002)(478600001)(86362001)(6512007)(38100700002)(26005)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFIZDE1dXhXMXJwWmhFSmRhMzhNZDBTbG5ZYkp2aXVYbGN1NnpFV25BNFk4?=
 =?utf-8?B?QnBxN2xZRnp5VGU2eWd3c1JJU2VaR0Fwekc3eWtmOFo2S3o3K3pieTJ2YW5Y?=
 =?utf-8?B?anh0M0hBVkFkMVFIK290aWNmODd5Wm5Od05EdUJtQ2xzdlAwYzQwbEVXaGdh?=
 =?utf-8?B?VHdoY1ptSjdSL0o1TUdZZXNQNlBTZGt3NlZSS2lWSG9TaVN2Yk5Xa0VlOVJE?=
 =?utf-8?B?YkZ0RVNTZkh5Q202VHo3SE9BWHRZc3JJNnZnNXNqNEkvMmZoeXZYT0JOZ09u?=
 =?utf-8?B?QkFBNGVYMWpmN1hUN0JpZ3VJRkFnSWJQQ3kxWnNzMXROVHM4dVNibFhzc3Nr?=
 =?utf-8?B?UHplb09YSERGZlFyL3JYd3dEWnZyRGt1amxXa3RZZzZtaVZoVGdVTC85Y0xC?=
 =?utf-8?B?cXZDd3pxMDZidm9IbUxjYkEvV1E3Y3ZsajBkSzFObGZxWXN3Z0xSQk9mOU1z?=
 =?utf-8?B?cEFLbWlNWHNxRDNDSHNGeVpQTXFBVk4yMklBWTVZYjNpZk5iUDRXRTB0ckc2?=
 =?utf-8?B?bU9JRnVWWm9DNzlKYzQyQkZDRjlyVkxjSnpMOE5paEc0ZGNzZG5NWldDb1Fx?=
 =?utf-8?B?amRpbkg3Q3A3OVFjaUdGczMwRDBJR29HVThQM01uMGloV3ViNmdNMUVDdHEv?=
 =?utf-8?B?YVVReEhFM1lTOFdTdGttR2l6OUdvZ2t0dCtjdkp3dXBmeHBxVmNXMVFDcU9X?=
 =?utf-8?B?bWNkcFBLbVBPU3JodWsxS3BKN1R2c0toUTB4NU5xTWRUWmswTlpxUlZ2cHVC?=
 =?utf-8?B?Z21HVWdGVndlTzBmQkQ1aHBGY3NZUjAvUHp4QVBtcFJtV0ovMXIvQWdLdWJU?=
 =?utf-8?B?Wi9OMzdhemIzdzRUMmMvZXViTHJQVk16UHplMkY3dzFBY1Bac1BFdGRWaEJY?=
 =?utf-8?B?THdPd1poQlBuc3plMlFjVWQwRy9HbUhCczZ2YklVc3c1RFZnL1pPbE5iKysx?=
 =?utf-8?B?Zm9ETldEd3puN2k4KzhZMmNnMVg1ekhtM0hpdzg3by9PaFhkWW9WOU9aczJJ?=
 =?utf-8?B?RGxLOTdPdGZvTC9PcStHay8xY25kRjlTNW1kakF5dTZsR2xjaWJENmZ3endW?=
 =?utf-8?B?a2VxVHc0TCt2Y2QydlFhem5NWU05Q2EyK0RjbzRCT3ByRGFaTW81OXlNRXdv?=
 =?utf-8?B?SHZNam1qV2ZZUGdFQXgwNWR4Z1VNQjZWTHdZSVNlaGRUUVlValhKbUZ0cmFt?=
 =?utf-8?B?M3dSc3pYMkVhMjhOa25nbjN6MmxadjUwaTQzZlorZ2JBOFBWeWt5NnJhR2ti?=
 =?utf-8?B?THJmSHZFT3Y1SWF6UHAzYkVwOE16T3VyOXlLcTNINVVieE9hZUpKUVdsbWdZ?=
 =?utf-8?B?c3Z2dWR0QkJCSFNheTl4UXMxMDhwTVh6SFBZZk45aVU2ZjNDY1NyY3M1RzNH?=
 =?utf-8?B?emluMUNmUWtqdG5TTTVqWjhaZUJjVkFQdTcxckh6YnVxUkJJTXM2OXI3U2M5?=
 =?utf-8?B?dUs1S1NLeDFkWWhOUUFLTW1ObDQwcE5ZcUlMMzZubmU5cFppU2pUYUVIWEVl?=
 =?utf-8?B?VE1Wbnc5V1duU2xZRlVyMnQ5cWQ1RlJDUFllSlQzdXdOMGtxYWI2bllZcFJt?=
 =?utf-8?B?MWxvaUlZdEhJQjYzV3Z5Y2xmbEdxQ1dDRUkyQkVOZWdwL2ZwbzkrK1hRMDlP?=
 =?utf-8?B?RHRBRVhSbSt0cUdNMlNEZkl4bTNMT3ZwMEVqVVpRamVpeEhxTkpJQlRJRTlr?=
 =?utf-8?B?S1h3eE5UMmdXRmdrY1NYaHorZzdwOGtXaDREVnVPUUxNZEw0YUhDemtVSVRu?=
 =?utf-8?B?b3YwTlZyTlhnNWxSVVRLRU5aUW1JTjI1R3pPYU9hSGpXNEhoQ3JtNk1DRnh5?=
 =?utf-8?B?YVQyYitkVFNmTHNJZ0VFNTBBblIzVVdFdVJEY2syNmt4RzJrZG5kRlErMGl0?=
 =?utf-8?B?QWFnQzg4Z2xHbTFkSmJ1VDV0K05ZaXZ3amhXcXRsOWdldld3V2pUV0lFOTZP?=
 =?utf-8?B?WSt0UC9wamo5ZVd5cmRQWi9BRW94cTRsYmNhWkhsd0hVdGoxWTlMYU9VQmhq?=
 =?utf-8?B?SlU0NTBuZm9QSzE3U2gxdlhjVXN4M1o4UlBlNXU5ekN0aG52czNSWjNtU3Rm?=
 =?utf-8?B?RGRDREY1VWg1cHhHVmFIOGlVYzBOcFc1OUdMbjdqYm9EYWNxSjQ1ZE9oZVVy?=
 =?utf-8?B?TE9VMjRNZDl2THZTbm15akFSdFVoQmdWL2ExMWs3M0pDTGFHTWhwN3NBK2hN?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a28bba6f-92e2-457f-13b0-08da9a477f7c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:01:49.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60O0I8BZy+mlFTWzgJh0hAJpLJVLI17iuXDWwgx/7VIIdvVLqLrFGxbpTS5KhWYp+gvYZCoGLJlzX5l9OMLpJXroqpOydAoFjLlPJY2k6Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2022 22:32, Lucas De Marchi wrote:
> On Fri, Sep 16, 2022 at 02:24:00PM +0200, Karolina Drobnik wrote:
>> On 14.09.2022 17:54, Robin Murphy wrote:
>>> On 2022-09-14 16:01, Lucas De Marchi wrote:
>>>> On Wed, Sep 14, 2022 at 02:40:45PM +0200, Karolina Drobnik wrote:
>>>>> This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
>>>>>
>>>>> This change introduces a regression on Alder Lake that
>>>>> completely blocks testing. To enable CI and avoid possible
>>>>> circular locking warning, revert the patch.
>>>>
>>>> We are already on rc5. Are iommu authors involved aware of this 
>>>> issue? We could do this in our "for CI only" branch, but it's 
>>>> equally important that this is fixed for 6.0
>>>>
>>>> Cc'ing them.
>>>
>>> The lockdep report doesn't make much sense to me - the deadlock cycle
>>> it's reporting doesn't even involve the mutex added by that commit,
>>> and otherwise the lock ordering between the IOMMU bus notifier(s) and
>>> cpu_hotplug_lock has existed for ages. Has lockdep somehow got
>>> multiple different and unrelated bus notifiers mixed up, maybe?
>>>
>>> FWIW nobody else has reported anything, and that mutex addresses a 
>>> real-world concurrency issue, so I'm not convinced a revert is 
>>> appropriate without at least a much clearer justification.
>>
>> I'll share more background on this regression. We've noticed that no
>> tests were run for Alder Lake platforms. This may happens when, for
>> example, there is a kernel taint or lockdep warning.
>>
>> Links:
>> https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlm-1.html
>> https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlp-6.html
>>
>> The CI logs (which can be found for example here[1], boot0 file)
>> revealed a lockdep warning. One of the recent changes in the area was
>> commit ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain
>> initialization"), and I sent a revert patch to test it on CI[2]. This
>> proved to be effective, as the tests started running on Alder Lake
>> platform:
>> https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_108474v1/index.html?hosts=adlp 
>>
>>
>> To be clear, that revert is just a way of unblocking CI testing, the
>> problem requires a specific fix.
>>
>> Lucas, would it be possible to merge this revert to the topic branch to
>> unblock Alder Lake until this issue is fixed? I'm afraid that some
>> regressions could slip through the cracks if we don't do it soon enough.
> 
> Yeah. Let's have CI running with the revertt so we can see if on next runs
> it will really show it was a regression or if it's something else. I
> think it will help us understand why it's failing.

Thanks for the merge. It looks like all adls are doing better now
(revert went in CI_DRM_12147):
https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlp-6.html
https://intel-gfx-ci.01.org/tree/drm-tip/bat-adln-1.html
https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlm-1.html (CI_DRM_12149 
seems to show a different problem)

All the best,
Karolina
> 
> Lucas De Marchi
> 
> 
>>
>> Thanks,
>> Karolina
>>
>> ----
>> [1] -
>> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12145/bat-adlm-1/igt@runner@aborted.html 
>>
>> [2] - https://patchwork.freedesktop.org/series/108474/
>>
>>> Robin.
>>>
>>>> thanks Lucas De Marchi
>>>>
>>>>>
>>>>> kernel log:
>>>>>
>>>>> ====================================================== WARNING: 
>>>>> possible circular locking dependency detected 
>>>>> 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1 Not tainted 
>>>>> ------------------------------------------------------ cpuhp/0/15
>>>>> is trying to acquire lock: ffff8881013df278 
>>>>> (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
>>>>> blocking_notifier_call_chain+0x20/0x50 but task is already holding 
>>>>> lock: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at:
>>>>> cpuhp_thread_fun+0x48/0x1f0 which lock already depends on the
>>>>> new loc the existing dependency chain (in reverse order) is: ->
>>>>> #3 (cpuhp_state-up){+.+.}-{0:0}: lock_acquire+0xd3/0x310 
>>>>> cpuhp_thread_fun+0xa6/0x1f0 smpboot_thread_fn+0x1b5/0x260 
>>>>> kthread+0xed/0x120 ret_from_fork+0x1f/0x30 -> #2 
>>>>> (cpu_hotplug_lock){++++}-{0:0}: lock_acquire+0xd3/0x310 
>>>>> __cpuhp_state_add_instance+0x43/0x1c0 
>>>>> iova_domain_init_rcaches+0x199/0x1c0 
>>>>> iommu_setup_dma_ops+0x130/0x440 bus_iommu_probe+0x26a/0x2d0 
>>>>> bus_set_iommu+0x82/0xd0 intel_iommu_init+0xe33/0x1039 
>>>>> pci_iommu_init+0x9/0x31 do_one_initcall+0x53/0x2f0 
>>>>> kernel_init_freeable+0x18f/0x1e1 kernel_init+0x11/0x120 
>>>>> ret_from_fork+0x1f/0x30 -> #1 
>>>>> (&domain->iova_cookie->mutex){+.+.}-{3:3}: lock_acquire+0xd3/0x310 
>>>>> __mutex_lock+0x97/0xf10 iommu_setup_dma_ops+0xd7/0x440 
>>>>> iommu_probe_device+0xa4/0x180 iommu_bus_notifier+0x2d/0x40 
>>>>> notifier_call_chain+0x31/0x90 
>>>>> blocking_notifier_call_chain+0x3a/0x50 device_add+0x3c1/0x900 
>>>>> pci_device_add+0x255/0x580 pci_scan_single_device+0xa6/0xd0 
>>>>> pci_scan_slot+0x7a/0x1b0 pci_scan_child_bus_extend+0x35/0x2a0 
>>>>> vmd_probe+0x5cd/0x970 pci_device_probe+0x95/0x110 
>>>>> really_probe+0xd6/0x350 __driver_probe_device+0x73/0x170 
>>>>> driver_probe_device+0x1a/0x90 __driver_attach+0xbc/0x190 
>>>>> bus_for_each_dev+0x72/0xc0 bus_add_driver+0x1bb/0x210 
>>>>> driver_register+0x66/0xc0 do_one_initcall+0x53/0x2f0 
>>>>> kernel_init_freeable+0x18f/0x1e1 kernel_init+0x11/0x120 
>>>>> ret_from_fork+0x1f/0x30 -> #0 
>>>>> (&(&priv->bus_notifier)->rwsem){++++}-{3:3}: 
>>>>> validate_chain+0xb3f/0x2000 __lock_acquire+0x5a4/0xb70 
>>>>> lock_acquire+0xd3/0x310 down_read+0x39/0x140 
>>>>> blocking_notifier_call_chain+0x20/0x50 device_add+0x3c1/0x900 
>>>>> platform_device_add+0x108/0x240 coretemp_cpu_online+0xe1/0x15e 
>>>>> [coretemp] cpuhp_invoke_callback+0x181/0x8a0 
>>>>> cpuhp_thread_fun+0x188/0x1f0 smpboot_thread_fn+0x1b5/0x260 
>>>>> kthread+0xed/0x120 ret_from_fork+0x1f/0x30 other info that might
>>>>> help us debug thi Chain exists of &(&priv->bus_notifier)->rwsem --> 
>>>>> cpu_hotplug_lock --> cpuhp_state- Possible unsafe locking scenari 
>>>>> CPU0 CPU1 ----                    ---- lock(cpuhp_state-up); 
>>>>> lock(cpu_hotplug_lock); lock(cpuhp_state-up); 
>>>>> lock(&(&priv->bus_notifier)->rwsem); *** DEADLOCK * 2 locks held by 
>>>>> cpuhp/0/15: #0: ffffffff82648f10 (cpu_hotplug_lock){++++}-{0:0}, 
>>>>> at: cpuhp_thread_fun+0x48/0x1f0 #1: ffffffff826490c0 
>>>>> (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0 stack 
>>>>> backtrace: CPU: 0 PID: 15 Comm:
>>>>> cpuhp/0 Not tainted 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1
>>>>> Hardware name: Intel Corporation Alder Lake Client 
>>>>> Platform/AlderLake-P DDR4 RVP, BIOS 
>>>>> ADLPFWI1.R00.3135.A00.2203251419 03/25/2022 Call Trace: <TASK> 
>>>>> dump_stack_lvl+0x56/0x7f check_noncircular+0x132/0x150 
>>>>> validate_chain+0xb3f/0x2000 __lock_acquire+0x5a4/0xb70 
>>>>> lock_acquire+0xd3/0x310 ? blocking_notifier_call_chain+0x20/0x50 
>>>>> down_read+0x39/0x140 ? blocking_notifier_call_chain+0x20/0x50 
>>>>> blocking_notifier_call_chain+0x20/0x50 device_add+0x3c1/0x900 ? 
>>>>> dev_set_name+0x4e/0x70 platform_device_add+0x108/0x240 
>>>>> coretemp_cpu_online+0xe1/0x15e [coretemp] ? 
>>>>> create_core_data+0x550/0x550 [coretemp] 
>>>>> cpuhp_invoke_callback+0x181/0x8a0 cpuhp_thread_fun+0x188/0x1f0 ?
>>>>> smpboot_thread_fn+0x1e/0x260 smpboot_thread_fn+0x1b5/0x260 ? 
>>>>> sort_range+0x20/0x20 kthread+0xed/0x120 ? 
>>>>> kthread_complete_and_exit+0x20/0x20 ret_from_fork+0x1f/0x30 </TASK>
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/6641
>>>>>
>>>>> Signed-off-by: Karolina Drobnik <karolina.drobnik@intel.com> Cc:
>>>>> Lucas De Marchi <lucas.demarchi@intel.com> --- 
>>>>> drivers/iommu/dma-iommu.c | 17 ++++------------- 1 file changed,
>>>>> 4 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c 
>>>>> index 17dd683b2fce..9616b473e4c7 100644 --- 
>>>>> a/drivers/iommu/dma-iommu.c +++ b/drivers/iommu/dma-iommu.c @@ 
>>>>> -65,7 +65,6 @@ struct iommu_dma_cookie {
>>>>>
>>>>> /* Domain for flush queue callback; NULL if flush queue not in use 
>>>>> */ struct iommu_domain        *fq_domain; -    struct mutex mutex; };
>>>>>
>>>>> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled); @@
>>>>> -312,7 +311,6 @@ int iommu_get_dma_cookie(struct iommu_domain 
>>>>> *domain) if (!domain->iova_cookie) return -ENOMEM;
>>>>>
>>>>> -    mutex_init(&domain->iova_cookie->mutex); return 0; }
>>>>>
>>>>> @@ -563,33 +561,26 @@ static int iommu_dma_init_domain(struct 
>>>>> iommu_domain *domain, dma_addr_t base, }
>>>>>
>>>>> /* start_pfn is always nonzero for an already-initialised domain
>>>>> */ -    mutex_lock(&cookie->mutex); if (iovad->start_pfn) { if (1UL 
>>>>> << order != iovad->granule || base_pfn != iovad->start_pfn)
>>>>> { pr_warn("Incompatible range for DMA domain\n"); - ret = -EFAULT; 
>>>>> -            goto done_unlock; +            return -EFAULT; }
>>>>>
>>>>> -        ret = 0; -        goto done_unlock; +        return 0; }
>>>>>
>>>>> init_iova_domain(iovad, 1UL << order, base_pfn); ret = 
>>>>> iova_domain_init_rcaches(iovad); if (ret) -        goto 
>>>>> done_unlock; +        return ret;
>>>>>
>>>>> /* If the FQ fails we can simply fall back to strict mode */ if 
>>>>> (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain)) 
>>>>> domain->type = IOMMU_DOMAIN_DMA;
>>>>>
>>>>> -    ret = iova_reserve_iommu_regions(dev, domain); - -done_unlock: 
>>>>> -    mutex_unlock(&cookie->mutex); -    return
>>>>> ret; +    return iova_reserve_iommu_regions(dev, domain); }
>>>>>
>>>>> /** -- 2.25.1
>>>>>
