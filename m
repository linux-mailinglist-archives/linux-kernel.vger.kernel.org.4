Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101D674BBE2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGHFB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:01:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92131BC3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688792483; x=1720328483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fbYiVDNMz7gTSbUf2t9pffPk7INAilbb6+rZRvLL3/U=;
  b=hB4Wx58qa2xu/1NvBOEkObC24z2ef3ctiNycs/pVCCY/44sYXUEaHKKX
   gyYDivPKW3mgB7BH2uxYIQfSxuiN+D2MLn7rHYPS7NtdVZIdYkuAtZl7i
   wgM7kkpqdHrjWzc20KZqSQ2VNZkbYku3p/cmHUw1KmzTR3Ks/1gWq2+2/
   siQ2LYZhZsDhfILAprKAZWrIZz/J5DH96YVdRlwiwfuLUtdCqLOT0KzXT
   CfP71ukp/bWstuqalDYjQAxdXmeY7Qo7Vz/uK+WyjhkTQsVIrdpupcnp9
   TtkWd80lJqbr8N5+q2rhcjP8EdaKtBu8pZcGeHIjq9WDeZmVg65Hu+q84
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353884325"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353884325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 22:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="894204246"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="894204246"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2023 22:01:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 22:01:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 22:01:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 22:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nph+zdSoAmEPD+wdGQL+eQIQEXz/kAWHYOB+ptordem+IJCePnxhod67HfTGXJ25RHXH5SLG6pxNIS8q6dl46TW3ZxV0UfwgKB3rxVCRgzDVz2o29j/66jnkw6DIr8SHKZrtspesmM6ii5tdFrW94OR14ZA7MbJKk1I5XJ2JYhwu129U/koiKU3LcGvA9Q7RJ8/SStUYQSnFd2kW77IP8V1Kp04W2bpAphnpy1w3P/zq8MnbXWBHuZjVXI92WTWuYbZm64rz0fvdVa9SMHupH/O/RVFqJc5U+AyJIE4m8c7X38jTxawhxm0IES0wR5kTBNc3WLY19GIIFv4W4ZjjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFpU5j5hlNZ5LUH8Ohn3AF69lG+OtGsqfv50fgE5bx4=;
 b=UzHM6a1kgPsI5Y/cCe1npPL7EaC8G7BLHLkDM7t7u+B40j3PcDDFeAvDV8WjIAT6QGuTL2H4tP/I4ky5gqQyUqOOW2hSeAbA72dF7IL1QJDaniH4r2EYYGO0k+B+ngeUiwAGjWyunK5R0EDOCLD5xdxAG995ML6X3aFNpmAMtnjPiJBQ7j6a66qgsaiioiOrfzHVrkW8DBZOgwEpKwYB6rehe21rVkSaywY59i32F4T700dzrMR6Wl2g2eXOFcL+3Otf+9PWZz1f/+RnvlefPJELer4QgovKC8jlPEfcEOxf6RN21zFRfWHrXk+gEWGQLr5ciAJbv8balpDIozFP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7659.namprd11.prod.outlook.com (2603:10b6:510:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 05:01:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 05:01:15 +0000
Message-ID: <ca1df2b0-3a36-2762-f20e-b4a235087c9d@intel.com>
Date:   Sat, 8 Jul 2023 13:01:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <CAOUHufY++PUYp3qcmX2rK5AQrgu9rPT3tYOpj=44BX4K67Znrw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufY++PUYp3qcmX2rK5AQrgu9rPT3tYOpj=44BX4K67Znrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 484afe70-5b8b-41dc-1240-08db7f705bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI0GnXvCYsO8yamtkuyEzIrYp1DQd3Sp3cq+hsPd57bbWF1j1q5mFeh8wJ2l0AanQNW8Lu9ZI9wExTX+QyutCgPWR/08rkxInDXyKM491eT4bea3sLfzCa6mQCw5OCA7csiz59ZLnE/nAGPXNw5UK6nGYz9+EzR6W8WycWLnnVhrA9sDRI9/bws2S7V7cuvL0ZnI6wGOWRZfzFWL1bfa0RfZw8rFeQElR0qWvxnCS4WZxj3VIP4SscaL83/HHCnPKE5xg9464euexIQMSeVkEVjcMeTwvWPyj2cIJdR4vgssD821Fq+nv2zQG+OMSNzusU8fQ7XirgYl1o4tOP45JhJJCNut3tZM95MQ7IBcPpjaoxaObcsdi5WZoN99qQyPfsmjudkACcRuLmPYfDxIvntrotBYcGMfIA9qiO1LFNccLaQ+YO9pGqUOxMdD2LXeFV6yxKNiMEi48nfYth8HdozWZeGSp5ZF5ZpZpilx3CeTgv962adcbtGUM1GjnI8aNMhED+QXDNMOLsG9Bxsp5o++a3A91zxFL8Pt6CDaZMRZ4gKljnCf/5KbiD488N2Kr8Z2SPobLNsLek1LAgDY1QPFHSR4X1BwtU+4ijPLsGXT19+2UHjdj7rg0W1B7WoT0c/XAqtHC7lKtGiwrJ83xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(83380400001)(2906002)(2616005)(6916009)(6486002)(478600001)(4326008)(66556008)(66476007)(66946007)(316002)(6666004)(53546011)(6506007)(5660300002)(26005)(186003)(41300700001)(8936002)(6512007)(8676002)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGYrL2pLelQzY3pKRFNmT0NCbEFGNVpXZnBjR0xnazMyLzRmREpSYmNjQW8y?=
 =?utf-8?B?THhVNktOV25CckZiREhtazA3aHVSbmdWWEticENPTDlDbDdsSDN4eURzYWFj?=
 =?utf-8?B?eEVhNHA3b2FMcnhKbGNtclp4L3dDQ0FvbVZMd1RodGhYVkJtaklNMnY1bGZ5?=
 =?utf-8?B?UUYzM290Q2VVUnJjMElud1dZbHl2NDlodzA1NjR1Q0UvSjV1NVh5eEQ0YVBa?=
 =?utf-8?B?WHVyaW1QS01BRHlGM3hYUWR5REZXRjFKSURyZmd5ME85N0daN2FWazl2UUlx?=
 =?utf-8?B?bzdza1dRakplUEVKdjUvZ25xVlJBMlNkZE1ReldFM0MyMnJJakxVbXUrMHFV?=
 =?utf-8?B?SUNMSzJhbzRyNVV6eXlOZlhxTWk4cHJ5cUdHUzlxZm9yZDFlR0o3T3BRMkND?=
 =?utf-8?B?aDdWSDZ4VkF3QnVhSWltdWVNdFo0U3V6eEwzeGJvaEVPaXh2UWNvcWtQR0hU?=
 =?utf-8?B?bGdkYmtlK3BHem15M1dyQk9nbHI5UWNCc25vR3VSOGVsVzBHS3M5R3NTUmpP?=
 =?utf-8?B?M1dnMHY1VVR2ZnRXMmNRcTMySzhpZm9OdmhqcHVKZ3Z3eitObkxZMHp4azBL?=
 =?utf-8?B?M05maTFKOFFsK2pDWm1PblZWWmdSdkFYTitZQ0hnWVllZG1jcHZ3Sjh0dTJE?=
 =?utf-8?B?L3BrSDRqK2hLS29SVFowWjZCN2NLRjNCSkdkZEtuQkl0NmkrWE9IZEdmcWdq?=
 =?utf-8?B?MVBpWjVqdWg4RTlPeVl1V1paWWMvTC9UL0hqQzc5dnlhUXR0QVB6MTU2dVEy?=
 =?utf-8?B?cU5wNXB5K0RHYTNCOFZKMkh6RFRoVEp4N1JidWxwcFRvWmwzcm1yb0RIZU00?=
 =?utf-8?B?V25tdFJMTEZKeDFQc0ZJTElJMHorVGdRNGUyTWovVnllbDZWdStPSzl3MzRq?=
 =?utf-8?B?Sjl1bGxibzRQcDQrcGZiaTM1OXZyNDZZOW9qSlZ4YWx0ZC9SbDVHRTdWR3gy?=
 =?utf-8?B?T1VYclVrcXpCTzNxeHlMNlJOWDJkR1ltdjdzRFExQzlsSkI0Y3lzWC81NzdP?=
 =?utf-8?B?NEYrY1J1ZmNxdlR1cXZJWVhxSm1BeWYxL014OXVoTzVITlhTNi9ndlBWT1hE?=
 =?utf-8?B?by9Wc1Jxdlc2OVRCOE1SY0lKZ3F1U1JiZGZhcG9QR0xDRnM2aFdua1JiNlFK?=
 =?utf-8?B?TDRsTllhemxYMG9hWS91aGN1cnNaU24ybkp5OStRaTdYSlVCeGREZ1R3dFVJ?=
 =?utf-8?B?TzNTUlRYSEtOVStvRFQzb2ltSzMzd1JFd2JwdlA3QnZOUlBJd2kyVXVjdDNZ?=
 =?utf-8?B?Tkg1WnV3cGFTRmpSeTZvY0ZVeldxcWlBdCs5Wk5WazYxdVp5QlRZR1JCa0Nz?=
 =?utf-8?B?cExHeG5hMkEycDlObnFWS3o5Q296bGRQNVZ6bldFbktLVUhNbzFQeGVvTVVG?=
 =?utf-8?B?RzZqT1pINWdKTnp4dUFMZXBidEQyQW5Zbjg4N3VXcm04cjZBWk0xOVR1NHg4?=
 =?utf-8?B?ZEdNNUN5aUFvd2pVWUxJUmN1N3BLeHI4ZGhhazJxTWpGV3RyeUx2M3AzK0w0?=
 =?utf-8?B?ZGV1azNoRHp6c2Zva1J1Umo2ZDFSNGdqUUx1ZDVpMGpCZnRyc1Y2cnl5bFVi?=
 =?utf-8?B?SmpGcTRERFB6YjU5dnNNaGJjWWI4SmlOVWtnNDJ4ZVJ3eXJjd21EVlAzZ1FW?=
 =?utf-8?B?WHY4S0xjc1gwQkVpdnk2bHdyU2lIdDZ2WDRydmNQbi9jZDZ6ZjhFcVBuSkpO?=
 =?utf-8?B?MjZ1ZTJMZit6eDVaNjExMlBBcXBxMlE4MUpQVUpMbCtxR0JuWlhJd1dlSGxH?=
 =?utf-8?B?Vk4wMnpZbU1lZ293aDM4QUkveVNuTDlRL3N3Y2Z5UGJ1RlJVK2RWRzVCcFcw?=
 =?utf-8?B?TTdDSzdpRXJIb3M0Y3dvaUdhNTYvYkFCcWxvZEdRb3RiMmxpUCtES0hrd2xa?=
 =?utf-8?B?WFFRYlp3Si9aODBHQUMwSmg0U05iKy8yUVJnQTlXRlF5RGpxUjh2Y21hMmU4?=
 =?utf-8?B?dDFNQXRyWjV6Z3BBcjVSZFNyTUtpc3dEd2p1cjNtU2lGeWhxbTlPWXRHQUVh?=
 =?utf-8?B?Zk9MaWR4Zkc4VXRTTmlaa1k3WGhvUkpONWZJeG9obUpEZXl4ZEY2Z2ZrMlc4?=
 =?utf-8?B?TGNBVWJ1VnAxaDFLUjdnWmY3b0VzU3J2aHBVS08zRXYxNnExVlhqbHNRSXdp?=
 =?utf-8?B?QU5QRmtzazNYOUErUS9naFBqMTJYV0IrNDBqZVowbVdiTzh2c0dCeEtvczNi?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 484afe70-5b8b-41dc-1240-08db7f705bbb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 05:01:15.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1PREuxiXC7AlvMKphMiR3mO7hUeZni/wzDOMIIxPQnhVW/WVD/A4aXHjDNxub44pmBT2jtlMLJA6Ol2X82UcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7659
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



On 7/8/2023 12:45 PM, Yu Zhao wrote:
> On Fri, Jul 7, 2023 at 10:52 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> Yu mentioned at [1] about the mlock() can't be applied to large folio.
>>
>> I leant the related code and here is my understanding:
>> - For RLIMIT_MEMLOCK related, there is no problem. Becuase the
>>   RLIMIT_MEMLOCK statistics is not related underneath page. That means
>>   underneath page mlock or munlock doesn't impact the RLIMIT_MEMLOCK
>>   statistics collection which is always correct.
>>
>> - For keeping the page in RAM, there is no problem either. At least,
>>   during try_to_unmap_one(), once detect the VMA has VM_LOCKED bit
>>   set in vm_flags, the folio will be kept whatever the folio is
>>   mlocked or not.
>>
>> So the function of mlock for large folio works. But it's not optimized
>> because the page reclaim needs scan these large folio and may split
>> them.
>>
>> This series identified the large folio for mlock to two types:
>>   - The large folio is in VM_LOCKED VMA range
>>   - The large folio cross VM_LOCKED VMA boundary
>>
>> For the first type, we mlock large folio so page relcaim will skip it.
>> For the second type, we don't mlock large folio. It's allowed to be
>> picked by page reclaim and be split. So the pages not in VM_LOCKED VMA
>> range are allowed to be reclaimed/released.
> 
> This is a sound design, which is also what I have in mind. I see the
> rationales are being spelled out in this thread, and hopefully
> everyone can be convinced.
> 
>> patch1 introduce API to check whether large folio is in VMA range.
>> patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
>> large folio mlock/munlock.
>> patch3 make mlock/munlock syscall support large folio.
> 
> Could you tidy up the last patch a little bit? E.g., Saying "mlock the
> 4K folio" is obviously not the best idea.
> 
> And if it's possible, make the loop just look like before, i.e.,
> 
>   if (!can_mlock_entire_folio())
>     continue;
>   if (vma->vm_flags & VM_LOCKED)
>     mlock_folio_range();
>   else
>     munlock_folio_range();
This can make large folio mlocked() even user space call munlock()
to the range. Considering following case:
  1. mlock() 64K range and underneath 64K large folio is mlocked().
  2. mprotect the first 32K range to different prot and triggers
     VMA split.
  3. munlock() 64K range. As 64K large folio doesn't in these two
     new VMAs range, it will not be munlocked() and only can be
     reclaimed after it's unmapped from two VMAs instead of after
     the range is munlocked().


Regards
Yin, Fengwei

> 
> Thanks.
