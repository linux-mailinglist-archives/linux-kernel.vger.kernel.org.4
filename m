Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB01C74680F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGDDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGDDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:45:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E284183
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688442328; x=1719978328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhMPyk904/FauAsJHkdTEw8cEHgSQa8MvppdWObT730=;
  b=h2V4BBff4qyNiI8V1qByf85WggxJ45fJumT9CE4oLBzvUvADT6Hk0j8H
   OucLQY/ZbH5NTX7kouiZSrlInEzcD5VkfWF84hjqjooYSNqgcEZvASizr
   xh3wnlMy+mpLK9yTDMdPLTsF8uSLvG0Bym/dxLkMQbKa6MauvtziRZQxn
   EJDHpOJp653MbK35aFDoDgkodROO/wwRW6K5Adui5YqKUJgxCrYXHApEp
   z5IKZZYO3HVOYQNIVfyVZzOa1Ixx//mrjwQuh9FAzVdyoVwOGOTr2kZRm
   Q9FzPYn5e7tlCz3uWqg7wYIyqFhH5UtDCc0txdY73+3kL+Yipkkj4jtQi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366505016"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="366505016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 20:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="718775634"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="718775634"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2023 20:45:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 20:45:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 20:45:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 20:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE2e/EuAJfdFs2jeQ4eYZfmKuUUc+o8dhzUfeESDXxdkzIdqgSyzElKas6zbLCAqoUfVeL8yzt7FNOepqEhS5EqLeGquc41FgSsKGnl8I98kYvgwuguNVqBSPcxR9qnmdigBMpwiFqdCu0i3SEazisH3jmz8dc8YjckLcItWYyxzeak5bMnQ4srCV+mG4rVJyiLs+B6PEvXhJ7xMeHCIBzk0PuaqCz37k098FXIUmRnBHo3UmbeK/CCU/s+Tr4WNZb3M8W0S+bIQS5JHMqX1tCQTPsE9kirwrYd8BQErvRUwMGYnl0ent8vd4wtzmymOoivUltAGhxOkWi86NtIWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROY3tiJ+8sfmGYmCbc0PqSD2zquMUnrEaUlxFKvHmyE=;
 b=S5pJKrsSBCfjqTK6q3pKouwqrF4l8CvDka0DS14eO2ccvdq5x+hy/Atf5KOy55DQ2CI5E+HS5vOBKQAskcbEKIW/ygSKft5TzX9r9MgfdyaL6Afr/zmZ/kW8GZ2nizL1DnQ3wr418F7+7swFkRQw7ddvyujODvAzvSYxN3l2TaD/3G1zEAvaOTPkqrl/pqbgvRp1XK2GeNONgY5/awS9MZrvTE5bwh8dXamYuxEeA+REGCwlsEAWDhCtdMnI5Wg8/H9s7VqC2lyQt+zXXuEaHAAlShERB3JOK1pfNaINUe6CX1Au67B1rL8nf81AnAAi3rH8IBCeZi2lyU77jGhPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 03:45:24 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 03:45:24 +0000
Message-ID: <6865a59e-9e40-282d-c434-b7c757388b65@intel.com>
Date:   Tue, 4 Jul 2023 11:45:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230703135330.1865927-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH0PR11MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e19383-5f84-485f-335e-08db7c411928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTUJ1U8P/oNBG+kPQ6NkjZUqibP1u2XuKL+xc4fRn87rlxKzcpaIgs10agXuskL3Zy5fZJLsP6/hyiCHou02qropMcvcLJdfzTzDHyOeWeWImF98Qwbj23WDBzne7JMLFnuzbTFm7D408PWxOFMUS6IhUFuHiW59sSYefI9KKFHilNz9c5N2j7Ptma85lymospW7o6Xsax9PubS32+7DH0sBcrjC9s2BamLKOPW5qIHjGXTZrHVD8iHe6MzoPri0flEXtrhNa6/hZVgYB4Ka9nYkiSHN9Gxy/10c1R8wbiCnVMrBu5W+LKZE52lcIeDLH4lTLdEt9uFfKHvLVb3Nl8TeW/2m1Q7emIlzmXgvWpgHQ0ya0Axwrx4z4JWDtN/1IKgWJ2pZI8UMAFZFVRF3Zq7J7Qzvd4a+fIuy7uZfjAMwWLVS2L9taNfL5XB6LBRhZlyvZYekueGtETQsc++PLVPhYDF+Wks3aav4LsC8eyZWsxDziYKm9JG88WmhcnfCkvwdFcCumfDVSE+5RAlvvEFWtKLRO8UTWOkYbACq68hM+TDt5vMRfkE1xKclyaWna8SmmWpuqwVIBjcJ7CwGWw+2vs3hl0QN59gYpS9m2zaszz8+cMU/06XutW1VaAwIl9bbs1ShQDAAZLyuWesODcfJ6GM8I0TAXR+bOP1nDbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(921005)(26005)(478600001)(82960400001)(31686004)(6506007)(6666004)(6512007)(86362001)(31696002)(2616005)(186003)(38100700002)(66946007)(66556008)(66476007)(4326008)(83380400001)(110136005)(53546011)(6486002)(316002)(5660300002)(8676002)(8936002)(7416002)(30864003)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ams1QnRqNWdsNG1DcllTSmRTZUMxbnFpUVJ1YWUwQ1NMd0FKdEJ4ME14YnlB?=
 =?utf-8?B?UXVxRGVrMmV6dXptR25ncW1sOE9wMERLSlErVUFzSWxyVjFkc0dKSm9jUUxP?=
 =?utf-8?B?YTNqVWlTMElSQ3l3aytZdmQ4RlNKS0tOZ25XTEJLVHkzOUhaNjBUdDlRa1pV?=
 =?utf-8?B?dksvN09Cand4R1NuTkZKSGlILy9HT1lwdWgvTVhGRW1HYk54bm15L3RXaTcy?=
 =?utf-8?B?Wks2T1p1TVNsNDB1UlRVNkRKZ3ZoOU00YnQxK1loT0s3aDE5V2hmTWJlM2Zr?=
 =?utf-8?B?aUxWaUJ0YlRwV2JqNWxKYW5JeFRuZDVEUm8veWlscmVjKzRlbDhaZmtQRlZm?=
 =?utf-8?B?bVY3YnNueFhTVmk3UnEzeEVvSE55WmVCNHpSRFV0QUJuQW9URTBHVFVJK1VU?=
 =?utf-8?B?UjYvenc5UWZlUmpNU2xHMjFJK3JHa0lSMllEY0RqN09sczhhRXVleURIL3pn?=
 =?utf-8?B?Rms1R2k0amswai93OS9FcnA3YzZLMURXUjJiYkJjYWx0Z3djbExsRUVLTWpN?=
 =?utf-8?B?WUFaQWdyaXpMVlNaN1ZYN2QzUnllckt2a1N6cjhhMVhTSDhBWkVtS3kyRlR5?=
 =?utf-8?B?Y21rNjVUK0l1V3IwV1lmUStkV29Eb2hCK3FJbjhDejd6RmNLVHFQSUFhQmVs?=
 =?utf-8?B?M0g1dHRXb0dtY2c4T3QrRkJWb0xRaTh6a3NCQW1ZbnFRZ0JIQ1daNjZaaWNo?=
 =?utf-8?B?WFF5QmxIUHFjK21zbEZYbzNkMkZOUDN3R0pJbUZNM1l6dDFaQkpZbEMxQWFP?=
 =?utf-8?B?ZHVlWHpxcHEzTTBFSFhhdzRCTm1SZlZnVTM3TUh5OCtoQUtHR01XOC84ZzRE?=
 =?utf-8?B?YnU0Rk5TNkJNZGZDZGlZajdudlg4OWxnVjBwL096Q1lVSEZmUmt3YTN6VTQy?=
 =?utf-8?B?emVvSDBFNWsydHlsY3N3K2s2eEwvQ25MYW9QWGZQSkIrYlRoaVNLRkNNSGIr?=
 =?utf-8?B?aDRCUzlGbWJYVWs1NWlyQmNiSzlQOEhWNTJleTl3bUNvdjgzOGlMZzc0NjRm?=
 =?utf-8?B?aXgxUSs1YXZMdW84b3BhNVpJMEpMZ2ZSbVdUdmhIL2I5M1dGcEViN1NrNmg4?=
 =?utf-8?B?WjlMZmQrM0tBbVNUT3d5T3hkbDNQUkhRd051bWkydkI0b3BMZ0xPZnM4Q1A2?=
 =?utf-8?B?QnlxdGFCd3NjM09rYXBWWWZWUkhTUyt2K0pjYkpTVzRBeDBIV0VlUGVyRkxJ?=
 =?utf-8?B?VGMyaDRjaVBPeHJadS9kMy94Njh1d1BZOHppMUhBN3haWDdlZTE4b1llYXF4?=
 =?utf-8?B?eWVlY2FGcUhLTkFTMnUvTHdlMFNhN1hoZVR1andUcHd1cURFdFc3WExrYWZV?=
 =?utf-8?B?SW03TkFCRExFbVpDWXFEeVBxL3V4cjJYYjZjRCtuT1pwQmxQSzhiTHEzRmRY?=
 =?utf-8?B?ZW9aSC9NdUlPNXVOUlIxNmxGdDZ5dGVrSmhwbUppZks3b3prUEJFMDA2Ni9J?=
 =?utf-8?B?cjNZd051ajZUaldiRW55dFZ2RjBNd0xLeUE1OE5XZzY4ZnIrR2drSmhic2Fm?=
 =?utf-8?B?NGVmdVE4OTREbisrT2sza2l1bENyWjQ1STUxSEdHT2s2WDcyY1JXamIzVkY1?=
 =?utf-8?B?TUNVNWRxeHVXN3o3Y2NsVTRESWdXb2Y3Rnl3bmpZdEFPSkw5dEFlc1lmWDR3?=
 =?utf-8?B?eU40ZnBhMmh0SUdtT0xPOTRyWUNzR3p4MHEwWXdRRWg3US9NQ05EcjhWWndw?=
 =?utf-8?B?K1l6YlpoV1IvcU5XVnJTRHdSNlhPdFgrVWRYMVp1ZTc0dVNmY29KN3pPZ3dn?=
 =?utf-8?B?RDhHNmd2M3B1M21saEFSQW9idXNHN3N2WE9sekZ5L1pKSGtFTi9VUnVrM0FB?=
 =?utf-8?B?YlNwKy81MTlEa1hUUnhLWDBPNTVOWGNiS1kwdHZpUXBpT3c2NjdHaXluWVRa?=
 =?utf-8?B?UUFxbGpXL000T1Y0Y3FjS2E2K2NBMVZBM1Q2YXE5cnliczFXK1Q4eGJpUHBm?=
 =?utf-8?B?NEtBd3FLMm51VFI3TTg4NVcwZ2ZzczI5LytEbVhmZnZjc2h6SURpRnJoSGZi?=
 =?utf-8?B?TE93eGt2bUpNRUlOTmdzVzN4ZHdtU1NWWC9ISmhZL2syV0xaTkdaYXovTzJE?=
 =?utf-8?B?bnZKYzNSN3hMYTdYVFd5RjlldTlXYk5aRmJTOW1Ub2NaSkJGaTBLZTdsZ2N0?=
 =?utf-8?Q?Y+IMrD4UE3YtG3qX9YUzryX9n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e19383-5f84-485f-335e-08db7c411928
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 03:45:24.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIQzMAD33AnAmZhJHjHY/zgxh9pnYaAXat7+55/CRFBZim61t/nf6NvCrtQYx4e58CnE/gcblE+xSg1+8yx5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
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


On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
THP is for huge page which is 2M size. We are not huge page here. But
I don't have good name either.

> allocated in large folios of a specified order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.
> 
> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
> defaults to disabled for now; there is a long list of todos to make
> FLEXIBLE_THP robust with existing features (e.g. compaction, mlock, some
> madvise ops, etc). These items will be tackled in subsequent patches.
> 
> When enabled, the preferred folio order is as returned by
> arch_wants_pte_order(), which may be overridden by the arch as it sees
> fit. Some architectures (e.g. arm64) can coalsece TLB entries if a
> contiguous set of ptes map physically contigious, naturally aligned
> memory, so this mechanism allows the architecture to optimize as
> required.
> 
> If the preferred order can't be used (e.g. because the folio would
> breach the bounds of the vma, or because ptes in the region are already
> mapped) then we fall back to a suitable lower order.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/Kconfig  |  10 ++++
>  mm/memory.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 165 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7672a22647b4..1c06b2c0a24e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -822,6 +822,16 @@ config READ_ONLY_THP_FOR_FS
>  	  support of file THPs will be developed in the next few release
>  	  cycles.
>  
> +config FLEXIBLE_THP
> +	bool "Flexible order THP"
> +	depends on TRANSPARENT_HUGEPAGE
> +	default n
> +	help
> +	  Use large (bigger than order-0) folios to back anonymous memory where
> +	  possible, even if the order of the folio is smaller than the PMD
> +	  order. This reduces the number of page faults, as well as other
> +	  per-page overheads to improve performance for many workloads.
> +
>  endif # TRANSPARENT_HUGEPAGE
>  
>  #
> diff --git a/mm/memory.c b/mm/memory.c
> index fb30f7523550..abe2ea94f3f5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3001,6 +3001,116 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_FLEXIBLE_THP
> +/*
> + * Allocates, zeros and returns a folio of the requested order for use as
> + * anonymous memory.
> + */
> +static struct folio *alloc_anon_folio(struct vm_area_struct *vma,
> +				      unsigned long addr, int order)
> +{
> +	gfp_t gfp;
> +	struct folio *folio;
> +
> +	if (order == 0)
> +		return vma_alloc_zeroed_movable_folio(vma, addr);
> +
> +	gfp = vma_thp_gfp_mask(vma);
> +	folio = vma_alloc_folio(gfp, order, vma, addr, true);
> +	if (folio)
> +		clear_huge_page(&folio->page, addr, folio_nr_pages(folio));
> +
> +	return folio;
> +}
> +
> +/*
> + * Preferred folio order to allocate for anonymous memory.
> + */
> +#define max_anon_folio_order(vma)	arch_wants_pte_order(vma)
> +#else
> +#define alloc_anon_folio(vma, addr, order) \
> +				vma_alloc_zeroed_movable_folio(vma, addr)
> +#define max_anon_folio_order(vma)	0
> +#endif
> +
> +/*
> + * Returns index of first pte that is not none, or nr if all are none.
> + */
> +static inline int check_ptes_none(pte_t *pte, int nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (!pte_none(ptep_get(pte++)))
> +			return i;
> +	}
> +
> +	return nr;
> +}
> +
> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int order)
> +{
> +	/*
> +	 * The aim here is to determine what size of folio we should allocate
> +	 * for this fault. Factors include:
> +	 * - Order must not be higher than `order` upon entry
> +	 * - Folio must be naturally aligned within VA space
> +	 * - Folio must be fully contained inside one pmd entry
> +	 * - Folio must not breach boundaries of vma
> +	 * - Folio must not overlap any non-none ptes
> +	 *
> +	 * Additionally, we do not allow order-1 since this breaks assumptions
> +	 * elsewhere in the mm; THP pages must be at least order-2 (since they
> +	 * store state up to the 3rd struct page subpage), and these pages must
> +	 * be THP in order to correctly use pre-existing THP infrastructure such
> +	 * as folio_split().
> +	 *
> +	 * Note that the caller may or may not choose to lock the pte. If
> +	 * unlocked, the result is racy and the user must re-check any overlap
> +	 * with non-none ptes under the lock.
> +	 */
> +
> +	struct vm_area_struct *vma = vmf->vma;
> +	int nr;
> +	unsigned long addr;
> +	pte_t *pte;
> +	pte_t *first_set = NULL;
> +	int ret;
> +
> +	order = min(order, PMD_SHIFT - PAGE_SHIFT);
> +
> +	for (; order > 1; order--) {
> +		nr = 1 << order;
> +		addr = ALIGN_DOWN(vmf->address, nr << PAGE_SHIFT);
> +		pte = vmf->pte - ((vmf->address - addr) >> PAGE_SHIFT);
> +
> +		/* Check vma bounds. */
> +		if (addr < vma->vm_start ||
> +		    addr + (nr << PAGE_SHIFT) > vma->vm_end)
> +			continue;
> +
> +		/* Ptes covered by order already known to be none. */
> +		if (pte + nr <= first_set)
> +			break;
> +
> +		/* Already found set pte in range covered by order. */
> +		if (pte <= first_set)
> +			continue;
> +
> +		/* Need to check if all the ptes are none. */
> +		ret = check_ptes_none(pte, nr);
> +		if (ret == nr)
> +			break;
> +
> +		first_set = pte + ret;
> +	}
> +
> +	if (order == 1)
> +		order = 0;
> +
> +	return order;
> +}
The logic in above function should be kept is whether the order fit in vma range.

check_ptes_none() is not accurate here because no page table lock hold and concurrent
fault could happen. So may just drop the check here? Check_ptes_none() is done after
take the page table lock.

We pick the arch prefered order or order 0 now.

> +
>  /*
>   * Handle write page faults for pages that can be reused in the current vma
>   *
> @@ -3073,7 +3183,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		goto oom;
>  
>  	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
> -		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +		new_folio = alloc_anon_folio(vma, vmf->address, 0);
>  		if (!new_folio)
>  			goto oom;
>  	} else {
> @@ -4040,6 +4150,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	struct folio *folio;
>  	vm_fault_t ret = 0;
>  	pte_t entry;
> +	int order;
> +	int pgcount;
> +	unsigned long addr;
>  
>  	/* File mapping without ->vm_ops ? */
>  	if (vma->vm_flags & VM_SHARED)
> @@ -4081,24 +4194,51 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>  			return handle_userfault(vmf, VM_UFFD_MISSING);
>  		}
> -		goto setpte;
> +		if (uffd_wp)
> +			entry = pte_mkuffd_wp(entry);
> +		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> +
> +		/* No need to invalidate - it was non-present before */
> +		update_mmu_cache(vma, vmf->address, vmf->pte);
> +		goto unlock;
> +	}
> +
> +	/*
> +	 * If allocating a large folio, determine the biggest suitable order for
> +	 * the VMA (e.g. it must not exceed the VMA's bounds, it must not
> +	 * overlap with any populated PTEs, etc). We are not under the ptl here
> +	 * so we will need to re-check that we are not overlapping any populated
> +	 * PTEs once we have the lock.
> +	 */
> +	order = uffd_wp ? 0 : max_anon_folio_order(vma);
> +	if (order > 0) {
> +		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> +		order = calc_anon_folio_order_alloc(vmf, order);
> +		pte_unmap(vmf->pte);
>  	}
>  
> -	/* Allocate our own private page. */
> +	/* Allocate our own private folio. */
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto oom;
> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +	folio = alloc_anon_folio(vma, vmf->address, order);
> +	if (!folio && order > 0) {
> +		order = 0;
> +		folio = alloc_anon_folio(vma, vmf->address, order);
> +	}
>  	if (!folio)
>  		goto oom;
>  
> +	pgcount = 1 << order;
> +	addr = ALIGN_DOWN(vmf->address, pgcount << PAGE_SHIFT);
> +
>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>  		goto oom_free_page;
>  	folio_throttle_swaprate(folio, GFP_KERNEL);
>  
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
> -	 * preceding stores to the page contents become visible before
> -	 * the set_pte_at() write.
> +	 * preceding stores to the folio contents become visible before
> +	 * the set_ptes() write.
>  	 */
>  	__folio_mark_uptodate(folio);
>  
> @@ -4107,11 +4247,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
>  
> -	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> -			&vmf->ptl);
> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>  	if (vmf_pte_changed(vmf)) {
>  		update_mmu_tlb(vma, vmf->address, vmf->pte);
>  		goto release;
> +	} else if (order > 0 && check_ptes_none(vmf->pte, pgcount) != pgcount) {
This could be the case that we allocated order 4 page and find a neighbor PTE is
filled by concurrent fault. Should we put current folio and fallback to order 0
and try again immedately (goto order 0 allocation instead of return from this
function which will go through some page fault path again)?


Regards
Yin, Fengwei

> +		goto release;
>  	}
>  
>  	ret = check_stable_address_space(vma->vm_mm);
> @@ -4125,16 +4266,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  		return handle_userfault(vmf, VM_UFFD_MISSING);
>  	}
>  
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
> +	folio_ref_add(folio, pgcount - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, pgcount);
> +	folio_add_new_anon_rmap(folio, vma, addr);
>  	folio_add_lru_vma(folio, vma);
> -setpte:
> +
>  	if (uffd_wp)
>  		entry = pte_mkuffd_wp(entry);
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, pgcount);
>  
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(vma, vmf->address, vmf->pte);
> +	update_mmu_cache_range(vma, addr, vmf->pte, pgcount);
>  unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	return ret;
