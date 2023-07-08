Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6273A74BBFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjGHFeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:34:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE951BDB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688794455; x=1720330455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8GeLdXR31UPNpBXynk+PziK7Heio6whpuOIbvW5XhVg=;
  b=aVswF17N5jfWN5Z9wME8OwDkgearFp1UoIHkcJdJPRcvPxOd6x5TxOVF
   QT9t78V2/cZxQToUKOqCMzWk9HdpDlkzyPRRURZPooz7/21NwUG5znyP9
   BNhAabQ8dtIBLrxTo3V3f8nisregbfDhFE04eA39TdNLDz9E0QJAHwVKL
   q/c6DTJvvlPiJn1a6BJCezM8xApDY8xeDNaT0o3J4VecspfksZL7KNDf1
   jtqv4Ok9Y700+IWXjXnqPjuV/OI0Mypk3UzJKqv/E0OQmZ4n/PZIRK9VJ
   0EiGsEHUugxZw7E2z99F9ecxKzWpX3DEe4REzfysWeh5tLAO+JeWgekEG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="430101921"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="430101921"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 22:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="697438743"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="697438743"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2023 22:34:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 22:34:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 22:34:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 22:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7nHnJu5TqynZFRYP7WzgGBvfr8d+PCLxsKqklo/HTvtvJBFSALm1APVuSCBnQQbbMhX99dlUJkAv83zowNCXSPXFVXisOTjmF6Q5bWA712tLcLJN2iWS3+XqtqSh+sqfkjF9C9I4oyh7o6KWEmswZ2wOGyDlqBhVqUYgSBLBht0/FCPJeQk8UeIO3Fg1NNp7cpg247pwv4rMNx7edrUopkDmQGee0NN7d7aO0ZUbSBUx19eBpkNSapnEiFJVsigGvILrIm3OsdakzTnSZ3UJJRqTlD6VA6Kt6l4ZvBGJOsZyqtBSoOVm04JP1AkGRpVrvf4HWmH+wUzczr1Ufefwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRn/nPzp9hqb3pZ+q4lB06NwUWBtZNoZsL/6AH9oCFM=;
 b=GkC09oD9IUn+f5AzFAXjbOBFqRS+NkwWLEGH1zq/2Vn9zweby+lQb1MIAE4Klk/5ozqO9y76ui2mrgNv3dJjvcSLY/n3LpffPmHQnZWwcC94ngKs4ptYwS5yR5g+x9IZK0LUSH9qAd2Wjbjcti0gwCpC+7yquL6ZzVEgokWgq9Mql0yLrkv4aEpK5/wJL4GawVq2shoOggSNuDmy54bD+UNVCy4fVJKBuEI4QoXTdkCaiuAOHvg9vjX47rTItgm32HIRds7Wa+uBOS8WDZBQC9f9Qhsn1MjyY/eLKy8CNVKGCTAS0lQBMlAxHKLT+mWF3c9iHuEbGFRZOyCYk1v0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 05:34:07 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 05:34:07 +0000
Message-ID: <928bb406-f09b-358e-c3cb-72ddd53a2793@intel.com>
Date:   Sat, 8 Jul 2023 13:33:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <20230707165221.4076590-3-fengwei.yin@intel.com>
 <CAOUHufZWYo4DMNgu4VtGsPtHR3LQmYRH9rC9inMAn+-4oZSyCw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZWYo4DMNgu4VtGsPtHR3LQmYRH9rC9inMAn+-4oZSyCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8153cfcd-dafa-40c3-2220-08db7f74f2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5UrfMXSAf69QCEGr/pl1qQkRAOzChlHx2N0wOamfTJiIOjnEZ8qnRAF6UXMI1Bu4yrbNyGq8Kb6Lf7vjum0gnrs+TzN2dH6Hg4PTO4t8cNXJmF/UI8YWHJnt5iCi+Jp95Pw5Uu/rB+jhiysi2IXAnyWdroJhfDybLznHYQhaas66LUXSJIna/mV9fKomj52Vg0qbxHLD5mfGS9K9SCFKGFy+6MZE0AH+NYZFZ0C03O2tTt74jBCAK8KzM1Q2ASi5jw4YnPlpTgQ0FkqBHUS+O0gYJMGnxZxaMajdFYbYbbUBwKUO74oRnFaiVQnr6etvEDLcWRJ/IH24IOIFJFvqvp98cRs7E+2iQWKPqOxse+h3U2IHSkrnicYD9DUvaEtyC3X86vJ9SM9RMTBkdPf+/1sYMywTc+WvCGpXAZZL2kcr/6DCeKakT4aLDFzDi072wwS27xjH0pmH+rFtdAyTAC3irOQ/z77UjGEJpgTX/Og3iIHOqnUJpc0GHoxGUMCx7TX4FS7yC8PMTu2+n1V121yXS1+3QU+7IlRPXoVjIsYpSNfl1TK89Zqbw6OE1cqc6MO4jcpcI8bS4xGoc4WtCcYCXjkOgqq/rV+eQ6+F85i/sZgtsyBZT6seKJH5cODNzYTxq4IQyg7skf0CqA36w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(8676002)(8936002)(6512007)(41300700001)(26005)(5660300002)(6506007)(186003)(53546011)(2906002)(2616005)(83380400001)(66946007)(6486002)(316002)(6666004)(478600001)(66476007)(66556008)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2w4V3pTaitNcmswbkprYXA2Q1BEVjdralZDNm9Zb0RkV3NBV0dGQXFNY201?=
 =?utf-8?B?Mm5IN2VCVHh4ZjZyKzMrd20xY1E5bEdvUEcvVExlVENyRjFnQVczTkhrZGVj?=
 =?utf-8?B?ZzM1NWNOeUpEZVNQUWdqQU9vMy9hcjNSK2tXQzhvdnhQNjdERDlIWEZQaXpk?=
 =?utf-8?B?bnlDTXpqaUN1MmgwYjFpSWZzUHFIMnRwTjE4akZ6U2RHWWNMQTlsS2xQVmQv?=
 =?utf-8?B?TzlJUDUyM3JITjV6cHp2bkN2Y0JYZzdyWWw0OVl5WHRNZHFxSVVwMGs3THR5?=
 =?utf-8?B?QWxOeTkzSGJYRVBDNXAyNHVhN2p6cVlUOEtESE9jenNTU2xUYnRudFhkbkhU?=
 =?utf-8?B?MUVCcHJiaTc5SWI5WDE4T29MdDcxVWJBYXVITjBQOEl3eE9nY2VnNkZaWmcx?=
 =?utf-8?B?MHBIbXFsQk00ZklhYkFDeGpWZVRnNlY5YzJBaUlrQkFXU2JFOFFSY21ZOEpp?=
 =?utf-8?B?ZUF6RnY5bDA1NXZ4WXNteDh6MjRvZG1zbjU3QmdrdGlHY3pXb3QwU0l0U0dV?=
 =?utf-8?B?M09ndjNCMithNzNzRkJTcGFXYkcvcTBPMC9FS0plaXVEa3d5eXI1NkdlMWhZ?=
 =?utf-8?B?MkExUWhITmxtK3YyMzd1S1dLaERqaSs5byt6NWNvSWlLUnM0VHVkN3pJZVkw?=
 =?utf-8?B?MVRkTmVOc1FSQTFZRU44TTZob0lNR2JpZWkrMTZYbGl4Y2hVQ1QvczdNU05V?=
 =?utf-8?B?RW1vMk9VeWpVM25raDh4bVdrazFmeGM2UituaHp4eHZjeHhzN0I5SnJlS2Z0?=
 =?utf-8?B?bmdjQXVtYXpycjhrMEMzMFdXZW9FcEJyd29qeWsxMjdFRk9tWkUxcU1Bd0lO?=
 =?utf-8?B?Z0JQQTNkdzhUOG9mVjdMZ1FwaDNZNkdYbUo4aW5DcUh3WWRNNHZnT3Jra0VI?=
 =?utf-8?B?bzZVMGRod2RySUxzUlNwNHNoM2UxYjdmWWFqR213RmJ6VFpwS2RMSDI5b0M3?=
 =?utf-8?B?WXZiQzAxZ1VFVVdEQnZ2N0hSNjRqWTlOU00yV0ZWN1JiTmRtcU54L3RXK1Jp?=
 =?utf-8?B?bnJFOHdqMVA1S0Y3NDNZdGZEeEhocyswbCtFc3ROZStKRTFEaDNNZWVTdjlX?=
 =?utf-8?B?VkhkUW5qTEp6dkNrVENwZ3F0aWYzUDRUbk9BRjRCakMwdEtucDdCNEhtQXgz?=
 =?utf-8?B?b04rQmtocE0xRWJ2NEVWNitSRENEdUZhdmw5UkRrb1RzSzdxcWJaMUhFWWhk?=
 =?utf-8?B?VUcrQXFERWYvallpcW9zODB0aGFIVGNEUTlnaUhnMDd5Szg2bHlqRmduTW9F?=
 =?utf-8?B?bU9vUDBZYVhsbUdxTFkrUkZwcTN6REhlZTNKQ0szM1I0ZG5UZkZRMFdjUzQr?=
 =?utf-8?B?OWpyRk1sVVpWR2l1Q1psYWlSVmR6dncyVUhQYURqaUI5eDdEVkxCZVlzNmp5?=
 =?utf-8?B?WjVLcXlPaU5ON0JnVWg2bWZyMjE3TnlkcmdrdCtrMHQ1cXVQeldaTVV0c2d0?=
 =?utf-8?B?a08zYWtBTVRtZXNwRElGS0R1ajc1M2xIT1VScERiQktYUklseW1tUVh2d3FL?=
 =?utf-8?B?eTF6aEFEenM5UjUxeVRkN3RmY3JjeUxCNkVZYk5SdkE1ci9QTVF0YjlZOXdE?=
 =?utf-8?B?c0xveWJMQjhxVkFMWjc0S3VqZ1BUWkRKREZUWGxjYW04YUltWUpEMEt2WDRV?=
 =?utf-8?B?MG0xUmsvNStVdzRjeTg2eUJ1S3dCRzhyUUcrQVhFNUZnNE9lSmpJNEpCQ2pj?=
 =?utf-8?B?ZDNINGpzRVdsZW81d2RSUzZ4VVQ3eU92Zy9MTmVwWVhsL3RmQ2hTSXVGaFZC?=
 =?utf-8?B?ZHBYWU9sUWszUnVyZERIdXpjbHFJZzRLQWNCbEZORnVBYUY0TjZGNEJ1QjhG?=
 =?utf-8?B?dDdCWE0zLzBrb3JpNlhIbVV6WWdwR1psSm5SZUVwZGNObFBzOFZhVDE1NXkr?=
 =?utf-8?B?TFBCeW9IQm8yclF3QXZsdU95OWsycFpOMkhUTENIaDI0VFRJM1RORnJBMnFw?=
 =?utf-8?B?VEZaT3RsZVh3cktySnFBdlB3RVRKZ2xFYnFud3pmZGJscUt4QWRDeW1JYVZ6?=
 =?utf-8?B?Tk5rMkJjbjJxRjc0ajJaMVdVY2JrdGhZK1NWZDFpbXdGQ29KYUpFOC9lTEpx?=
 =?utf-8?B?K2dFV2FNSnlXVzcyWmt2VzdOVkI5K3lWK3VKZFNiYlcrazZkbmIzY0o5NGZu?=
 =?utf-8?B?ZDZ0SGw4Tlo1N2JmZlBEWWl5UFQ1d2h2bjl4WmNBV3F2WUFpaGgweFp6STRI?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8153cfcd-dafa-40c3-2220-08db7f74f2d0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 05:34:07.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiHhaFqvZR4tfeiJUFPWbJjsWwclVwBpBZakdrU39rzp6AiwXDlvHWg2gRGwCLjxwUuCpv6IiPYQmyyxTT8XOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
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



On 7/8/2023 1:11 PM, Yu Zhao wrote:
> On Fri, Jul 7, 2023 at 10:52 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> If large folio is in the range of VM_LOCKED VMA, it should be
>> mlocked to avoid being picked by page reclaim. Which may split
>> the large folio and then mlock each pages again.
>>
>> Mlock this kind of large folio to prevent them being picked by
>> page reclaim.
>>
>> For the large folio which cross the boundary of VM_LOCKED VMA,
>> we'd better not to mlock it. So if the system is under memory
>> pressure, this kind of large folio will be split and the pages
>> ouf of VM_LOCKED VMA can be reclaimed.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 11 ++++++++---
>>  mm/rmap.c     |  3 ++-
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 66117523d7d71..c7b8f0b008d81 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -637,7 +637,8 @@ static inline void mlock_vma_folio(struct folio *folio,
>>          *    still be set while VM_SPECIAL bits are added: so ignore it then.
>>          */
>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>> -           (compound || !folio_test_large(folio)))
>> +           (compound || !folio_test_large(folio) ||
>> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
>>                 mlock_folio(folio);
>>  }
>>
>> @@ -645,8 +646,12 @@ void munlock_folio(struct folio *folio);
>>  static inline void munlock_vma_folio(struct folio *folio,
>>                         struct vm_area_struct *vma, bool compound)
>>  {
>> -       if (unlikely(vma->vm_flags & VM_LOCKED) &&
>> -           (compound || !folio_test_large(folio)))
>> +       /*
>> +        * To handle the case that a mlocked large folio is unmapped from VMA
>> +        * piece by piece, allow munlock the large folio which is partially
>> +        * mapped to VMA.
>> +        */
>> +       if (unlikely(vma->vm_flags & VM_LOCKED))
>>                 munlock_folio(folio);
>>  }
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2668f5ea35342..7d6547d1bd096 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -817,7 +817,8 @@ static bool folio_referenced_one(struct folio *folio,
>>                 address = pvmw.address;
>>
>>                 if ((vma->vm_flags & VM_LOCKED) &&
>> -                   (!folio_test_large(folio) || !pvmw.pte)) {
>> +                   (!folio_test_large(folio) || !pvmw.pte ||
>> +                   folio_in_range(folio, vma, vma->vm_start, vma->vm_end))) {
>>                         /* Restore the mlock which got missed */
>>                         mlock_vma_folio(folio, vma, !pvmw.pte);
>>                         page_vma_mapped_walk_done(&pvmw);
> 
> It needs to bail out if large but not within range so that the
> references within the locked VMA can be ignored. Otherwise, a hot
> locked portion can prevent a cold unlocked portion from getting
> reclaimed.
Good point. We can't bail out here as return here means folio should
not be reclaimed. My understanding is that we should skip the entries
which is in the range of VM_LOCKED VMA. Will address this in coming
version. Thanks.


Regards
Yin, Fengwei

