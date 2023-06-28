Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B578B74083E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjF1CVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjF1CVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:21:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68530CF;
        Tue, 27 Jun 2023 19:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687918868; x=1719454868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8N+GO04oUUb9Vu0V3+FhmDkPsBK0sdwhgnaJBb29+Kk=;
  b=I8bPvY/q8aDkcUSrJbt8+PDJyfqFSyZ01XGvHokz+rutSIojtBzTQIAf
   bsaDxgBrgHiz8Uy1i0+mUgQD7YjToKluyY3bKRwadbD0KT6MRjogge18h
   ZJk/l08Ehc65hN5rrv9uBtD0QvvbRIiD3IZnrC8F/WONUQHQSj9rztZIZ
   DWmEbWJJ9xqQHImKB5DJirfFzdN4I6aHegrkPOLpBRAA3CBSAxSNwWJuN
   FRUhuk5NkqZ48eldqcH9g/h1etMs6M5aWc5WXo0ZENSBpql5lBP47JPoJ
   xVDi3a/nEvuOQlxmBWyHUfKqeQH7dCRosi91oMx0I0OQ0f0o6UY7H4z7L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448114404"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="448114404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="782091391"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="782091391"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2023 19:21:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:21:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:21:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAIJYi7yC9Dl2QGSXFw/ya/EUQm4fHVE1qSGRqqECuBe4u2L/2w78wKcw0hD+RdwVHYFvgEWT5di7/7GcAB84o7PvYUmXksHztcVbU50urpg/deyxX8K9wM+Ba4IYEVJoLOfhU0UxkgHz3sPFz0UvAiCWR+YynqdbBIFcj3Z3YOq8k6VM/SRsSLjVE1kam07DnlbAvGqjBYdjRM45GC/InJ6HN76E4z+tOX/DMCveqcmV54poflp8Cwyfv6CzQwu2UZ1n0xFlUvRifI2GQcBbkd30O2yQAUo/sPZiTUEOQb+Av0J06il4L4YAJxd6FPz4M870dlXS+HtC0Aao9Hgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alQsyAcgxMxydAdfquhQioZPpfGdKoQ8/u5AJlIuVuE=;
 b=Zr/KEQ0mtyG808m6HDBXbmKkVpNMTSIFNT6DHF4UkrEwdeF1532CzwZcXs3TPvWvDayWA44Xy3PnHLyugTnd3IflQPxGfAluXyKSbYwNWYGmWqRwbreZJaYrjG8NnjNMIkPBQjd2TzJh5rLsRouanDZ15XOxqEA8ieR3F5Q4mz/epldahenXlyGul3HUGWG86DgrYNuLURVaOz1tSyvpSxoYQMZ9hVlZkbCjbQIpTR7LFVpsWpBunkEqGKWQDuN/arIYydbCFgD3wMtQscoTTw/9mf/ibUngY1yOeM+JLESte+sJB6Rsg79F+v3dzViKs+W+o2lNGUs8tvzQHssx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:21:01 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:21:01 +0000
Message-ID: <8c01486f-3c1a-e50d-544e-502eadbddf05@intel.com>
Date:   Wed, 28 Jun 2023 10:20:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 04/10] mm: Implement folio_add_new_anon_rmap_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-s390@vger.kernel.org>
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-5-ryan.roberts@arm.com>
 <CAOUHufZ0ZzHoJXwbzNyZOv74L=XYdZzcxA8SXxLX0MXdykuWRA@mail.gmail.com>
 <b16636b3-b493-39c5-c605-c5701fcbed1f@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <b16636b3-b493-39c5-c605-c5701fcbed1f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f36b5a7-1cb2-4794-be8b-08db777e50f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8KfzFVDlboc3R9MSLYgxA2FJrBSSZU9p4gDWs2AzwwiYqcGN9HYaIWcGzSGVAWq4aGSNgSvnIU0A2nilWV6vCluy+wvuRPwQRJzcIuFWw/F/3erHgoLG24bCEuAonHaziqPbtrrigjL90shVnn8LjYyMfAFT6+JKWOgSDo1sKvQmkEW4GpDdpMoweUN52dMZjNy+1tUlmt1zVmBpgbkqD4wjJcSYCQrFj68OJS1bIx0WJeG8ugBj/Q/ybB4nfu0tNBwxa30IW6wxI1W2qNJxMzrnoZUDjZmm0/pWG01CWLnOeHBvLQlpZKwJS91l7OwMFHQf1h88++HUKYKf+UUFzSe5hpKfjmS2SAQfi0PXIV1naIzr3g7EsKcfCkV+5TbB9SDsESFKZdK/1hqZqiwM/vyvoHa4XyvUMZmpN6cZ61tY44YIrINgW3mq6pnDa7a9OwhMUyrQYTsbRjkTIPAOO5JngBzwRupL7sFBrtpHKTvZAn0to1j8WCaIJ0Th1M1pXFBSZKU8eOjzp0enBIITI7y2ey7NCioVxJ/wRzpX1QWCSpw1sGrxPVVm83nvWR5R2OYPVEQeRY7QcP9tAFMBG8NvETjyXJ9ihpEjj2dMWVCogzF2oVEqS8NAIIxKqjU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(86362001)(31696002)(36756003)(54906003)(110136005)(66556008)(66476007)(66946007)(26005)(6666004)(4326008)(478600001)(2616005)(2906002)(5660300002)(7416002)(966005)(82960400001)(6486002)(38100700002)(6506007)(8936002)(316002)(186003)(41300700001)(83380400001)(53546011)(6512007)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5zM25KSm5qRVVNalo5ellqbUJkYzdlSkxMRnRNelVMTEhKNnJYT3RvN2xV?=
 =?utf-8?B?OXR4NWkzdUVFNm9FVkhNa0R3V0FmeUpGbGxMQnFpckR4eVovdm1CVVRGZHpz?=
 =?utf-8?B?eXlTMk81OGxGeUsyMnhJSmI5eGlpcjBxTEtVbm9ENHFNdW0zOGpjVmpTUGFr?=
 =?utf-8?B?blNXclFNN3lpcVB3ZUFUKzdEUEYzMldDRU1LUWZyUm52K0RPU2hiRG9PaWkw?=
 =?utf-8?B?N0ZOVTJSdlpock5ydWwyVGNhZC9LdHUvOFZtTnIxMDBndmhlcFI2Y3N1SUZE?=
 =?utf-8?B?bGtsanRKUFBSbjBwSE5aZXhzelBBVCtCbi9vY2NIK0dHTW53eHN2eis3N1Iz?=
 =?utf-8?B?UXZ1TDJTbE8rMEF1b08wOW1NdEtQcXlzMGozc0RpeU02RE1RaWhWSzg2a1VJ?=
 =?utf-8?B?QVFUNm9lTGU1TGRIMXRxSEYrYWdqeVlBSmN3eDRJZmNpaDNEem1UcERhTm9Q?=
 =?utf-8?B?aFZjdysrRExjSGtFS2dFUTJ6UjVZczdsN0hlTUh3VnVCMi9EUFVEWmFYeGRW?=
 =?utf-8?B?aHVZNENpakVKODVBS0pMdmF5OURGMDFlb080YzVkRDFCZkJzMlRJRWl5eUN4?=
 =?utf-8?B?SGpoWDNHeFdtZjkydmhPNmdwMmN2dWVoOEUxQm1sQk9uSkVsdEdzaXEwS3Bx?=
 =?utf-8?B?blQ5T1FLYm5QaXVKNE1nRlZWaEtsMU5iZ1hzcTVIRDJ2Vm9iaktUeG5GOWZL?=
 =?utf-8?B?K0p4dnFPNnN1YnRCSlhLc3lCZFFKVVdsd1JaM1FnN21tVTZPSkhFalZJME1l?=
 =?utf-8?B?Q1FpTWNSRStlSE9mUFRxdnAzMHFKSWNMQTdqUUJwL05zdDd2YnpaR0VNYmtB?=
 =?utf-8?B?WUNXN0hmR3l3YmxRRnB0bUNRcWFiTWhlYjZzbVphT3dOV0NDVXRJRnJPejFH?=
 =?utf-8?B?MVNmN3I4Si83dCszUFpNanRqdTZCSVQvR25JK0M1SWYzWlhuWExFNVBCdHk3?=
 =?utf-8?B?b0svQXcza2ltMk02b2NqSDI0cUQyQVdDTlZuRkVQcFRUSUJ2SWpmNDhvdWh4?=
 =?utf-8?B?eGFoWVhwaWR1SmlqR0JWNVVNK3dDNjlYb2dxQld2ZFRYWGcvRlk0RU1BYnJ0?=
 =?utf-8?B?bEgvNnhQSHhlT1ZDVFhJWldUQ3JKS2VwbFUwb3FtUEt3dVlSRDBLbHM0M25Z?=
 =?utf-8?B?am4zUWZqZnZOR25hTHVrWVdzaG5IMlhCU1lLaHMzSkpwTi85eUxFOXFtdnV2?=
 =?utf-8?B?aGVXUXduK1MvT0V5ZXY3ZXFYL0UwR1l2Q0dDbENjOUZ0bmtZVDlST3R0bTVF?=
 =?utf-8?B?TldPUnc0QVkvbHlNWHpuTGVBaGtWYzhqZlJJM2M5cFZzaXBJa3ZWU1UxbXBL?=
 =?utf-8?B?ejNmRjc1TklQV1N5ckUxWDR5QVQ2OVJrQ0FSdVlKK1M3QW5ZTE42dWswWkhX?=
 =?utf-8?B?bXNPSlZjd25LVUtzRDNPRXMwUGV2dFpoOXY2cVBDc1NNR0J4dElHM0dMeUlL?=
 =?utf-8?B?Y0RBNHNSOU1jYU5iZHRhVlcwVEFZSDdQNTV0Z3FIeFZNSWlORjAvV28xcS9V?=
 =?utf-8?B?V0l2SU4veWxRUUZqMmZIdHN3REYvMVNFdzBlWjMvZkVTMkFrMlRBdlFpNFpj?=
 =?utf-8?B?OForS1NWYS9RYUp4d29zcWI5YlN2VE5sMDlwZklLK0tVTlNWcW9vUENZd1I4?=
 =?utf-8?B?OWd1SXhkdkxNTERYTkgzTmVNNnNGVlVTOEZ1bjh6TjZJL0RCQSsxd2hhVzF3?=
 =?utf-8?B?alJjTUQ4bUZBR2tIR0ZrenY2Zit0bFBTV2dGL3FGelhaNnBvQjMrRGdJZWRu?=
 =?utf-8?B?TkRVVktKNVJBWGJvR0ZEZWM4YXZkQ3R2SFJlMTl1VDlSaEtrUFBmakhCTVJx?=
 =?utf-8?B?Nks3ZXV6a3Q2cHNMcjlmSWU0cU9wZ1dWRld4YTVaZ0k2eWgrYXg2R2NYQWRr?=
 =?utf-8?B?Nnh5U2drQXUxLzBHTjR3WGRlbHQxbU8rc3lVYkhKTzM5eWhic0dRZmJLMFpi?=
 =?utf-8?B?WEJ3Qk80WW91UGUxT29kOUs1NU83OXd1QytQYk83MjlQWmFGQVQ2dUxZVmdS?=
 =?utf-8?B?Y0dDZTk1WjVjQUV4UW1EaDlvcHpIZnVweHJRUzA5YW9IV0x3SEwzOG9CMnNM?=
 =?utf-8?B?b1UxaTA0RHhlRkw4L2JpMWZ6WTJOU2Iwd2FVS01OM2NhL2ZudnRvQ0krTFNw?=
 =?utf-8?Q?tmaJhJi/ykwdJjlcWSaca2pLp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f36b5a7-1cb2-4794-be8b-08db777e50f6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:21:01.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWu6Y7oufiF1IkJNewl2mmDIfN6c/fwgaahFyGQ0yujO5ceeZJAXhuupGMwCeCbJ0mh1ZZbdIW0m02fYt/Yo1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
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



On 6/27/23 16:09, Ryan Roberts wrote:
> On 27/06/2023 08:08, Yu Zhao wrote:
>> On Mon, Jun 26, 2023 at 11:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> Like folio_add_new_anon_rmap() but batch-rmaps a range of pages
>>> belonging to a folio, for effciency savings. All pages are accounted as
>>> small pages.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/rmap.h |  2 ++
>>>  mm/rmap.c            | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 45 insertions(+)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index a3825ce81102..15433a3d0cbf 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -196,6 +196,8 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>>>                 unsigned long address);
>>>  void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>>                 unsigned long address);
>>> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *page,
>>> +               int nr, struct vm_area_struct *vma, unsigned long address);
>>
>> We should update folio_add_new_anon_rmap() to support large() &&
>> !folio_test_pmd_mappable() folios instead.
>>
>> I double checked all places currently using folio_add_new_anon_rmap(),
>> and as expected, none actually allocates large() &&
>> !folio_test_pmd_mappable() and maps it one by one, which makes the
>> cases simpler, i.e.,
>>   if (!large())
>>     // the existing basepage case
>>   else if (!folio_test_pmd_mappable())
>>     // our new case
>>   else
>>     // the existing THP case
> 
> I don't have a strong opinion either way. Happy to go with this suggestion. But
> the reason I did it as a new function was because I was following the pattern in
> [1] which adds a new folio_add_file_rmap_range() function.
> 
> [1] https://lore.kernel.org/linux-mm/20230315051444.3229621-35-willy@infradead.org/
Oh. There is different here:
For page cache, large folio could be created by previous file access. But later
file access by other process just need map partial large folio. In this case, we need
_range for filemap.

But for anonymous, I suppose we always map whole folio in. So I agree with Yu. We
don't need _range for folio_add_new_anon_rmap(). Thanks.


Regards
Yin, Fengwei

> 
> 
>>
>>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>>                 bool compound);
>>>  void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 1d8369549424..4050bcea7ae7 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1305,6 +1305,49 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>         __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>>  }
>>>
>>> +/**
>>> + * folio_add_new_anon_rmap_range - Add mapping to a set of pages within a new
>>> + * anonymous potentially large folio.
>>> + * @folio:      The folio containing the pages to be mapped
>>> + * @page:       First page in the folio to be mapped
>>> + * @nr:         Number of pages to be mapped
>>> + * @vma:        the vm area in which the mapping is added
>>> + * @address:    the user virtual address of the first page to be mapped
>>> + *
>>> + * Like folio_add_new_anon_rmap() but batch-maps a range of pages within a folio
>>> + * using non-THP accounting. Like folio_add_new_anon_rmap(), the inc-and-test is
>>> + * bypassed and the folio does not have to be locked. All pages in the folio are
>>> + * individually accounted.
>>> + *
>>> + * As the folio is new, it's assumed to be mapped exclusively by a single
>>> + * process.
>>> + */
>>> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *page,
>>> +               int nr, struct vm_area_struct *vma, unsigned long address)
>>> +{
>>> +       int i;
>>> +
>>> +       VM_BUG_ON_VMA(address < vma->vm_start ||
>>> +                     address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>
>> BTW, VM_BUG_ON* shouldn't be used in new code:
>> Documentation/process/coding-style.rst
> 
> Thanks, sorry about that. Was copy-pasting from folio_add_new_anon_rmap().
> 
