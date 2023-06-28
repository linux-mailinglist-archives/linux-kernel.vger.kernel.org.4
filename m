Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8367D740826
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjF1CRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjF1CRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:17:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61130C0;
        Tue, 27 Jun 2023 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687918647; x=1719454647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DthWWfPuvN+v9B+o3ObGz2bPWR/9Lmugg+uiaVSfsTA=;
  b=CyXXXdTorKdIukMYsVB4J6/tU2bKRf2WCLoLRrXkk3po8iNUgr7FIyZi
   I5GO/vmcZ4OcDQ6RItd+qMwfvnGam5kcvnb0bxmfyZkkcbbY2Lyg6/gzM
   kW/Vwo+bnUj6M0wV1CSUqovqasbyakThd8nvOrHCroWXJlArYn1DGyLOJ
   R1+8XuCA7M8CGK0J2+tLXsKZUcwakbYOdCNHUnxWkPIWSMs9u9x2uTBr/
   vlulGOeUpJFgOLkYtO+p3YVUyaRvNr40sF6JpRdZ0hDoS7Af8oBkOLbXy
   cT6KWzbTZRjznqojqPYv9ne4za880JYr1baoZSu3UCLTSqUfpW+S2r1DO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425400884"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="425400884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861324364"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="861324364"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 19:17:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:17:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:17:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 19:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5wX3UAT6L+14K5qfaoE0ekek+14ISD0yXF45PFxUp9dnBMg/MhVtnAM/OoOzCFu4g0a7CaoczNL7xij2cRCbKchXVPhSmqr5cciCaygulTxTON/tK6OhfyRsXc/c53hGgHaRAe57kjTWpIhrXje5YyntaPpHhavPWF/Ro/wKoT7LQN+vTcyIS+3E6MFzvfGlHsmt6SXYggKqTDSEFwjpK6szvurApjvm3NTR0OZzA73qyZgeyGEA526OJh+Ib1LtAn8pQ8S+9qzqv8KLfEIaRzfqgQs9Y5Y10l59qcTLHqa9acsoEkSa6FE1FeGMTvBdHw1EfFzC/tLmgSbSa3BPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm7Lc5P+nsrHxk0cEc3cWWkzVAwjeF2JpVxyV7x7CFI=;
 b=GbMMqCQGCVY+Bv13oBEWWZ3T15Fwx0pdEakh8k2MH4ZdxcbF+6g6c8APS+qAVS4O/s71G+4Us0GGwHzSbT8ogRbJZwbYUxAdNIYDjsN5H1yRkFZ0maUkYw8nkZWe1rdWvHoH2e3Z38Rxe+O8z7nHLNICnQHNQ9a14Ff/bflxWemzF5Y6VAKJkDto3YrdT417xERB5oHLBggPRPLvi9UNcjKcojL8vVM4l0nNn/Fo3O0Yp96aX/XP/Gl2AIvERcI049qBmy02Zs6EpP0hIxx/02373i2fsIoeq3aQ9CtTpRQU9h0A4mQ+TCNRQXAj3BQfClsvXAGYYUtsTP9bIQClDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:17:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:17:22 +0000
Message-ID: <16ea687c-0f10-59ce-885b-811721e4ba50@intel.com>
Date:   Wed, 28 Jun 2023 10:17:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 04/10] mm: Implement folio_add_new_anon_rmap_range()
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
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
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufZ0ZzHoJXwbzNyZOv74L=XYdZzcxA8SXxLX0MXdykuWRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 520c7998-e11e-4b1c-0e74-08db777dce6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPnUASEI1/VnvCLl2AHrqr191wxNAOdD4hRTHt0J+QSOmefXAZOYMezNvglGF1kGVMQGwhJogff/uiy2/3wszcocnE2ea/AeW+ifSReF5eXAjW1Vv7ijSOmbU86PmA4DH2YWOncv6bXR615JzEOOqSJYOWUUUoZn3MjRA7GnTr/QEIZSEe77feXAPHhOdLY6i+3AV6F2anogNfsKmn7mLBEcSgrpfug3+Xj2f0HoYkACxN6uh8tGsjo+aajvax2t7cCq+hKfGoIhAe5BLTet660iZPNSLFs/pp1UT8RmsIVZJ2V/kG1ao2CCRsnf71xGka9Rs4qdneG/gVQrniazwv9RLin1fLXDcBVP21Ugo0ONUyMpMYc2JgxQgR8BVEyASiLEBASwUewT8kryuWLUjsVyBziH0c/sO1VOpIjPcHhkcGEEsdLiQiV5JJRPpTaEStPxLiILOJOoWN4ga1L2PZ3j1H3S8xwL/I1Pb5lfX987f7MD9IJ+PNtVshbgk8rOUOjO4thm3/jQTRV9aaUPo6IRu2C8XqAKuRXz92ifZJvr6YRoM+sxs5kv1HctHTb2faxmgNhshNxwBnlWGTpfpgCK6LBm4xc6tWWmmazANDJElxes9mZFO+hWBcB5JA1GH7fhbEZ45gAcmA6YVAIPgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(6666004)(186003)(31686004)(6512007)(6486002)(5660300002)(7416002)(53546011)(6506007)(26005)(478600001)(82960400001)(8936002)(8676002)(316002)(38100700002)(41300700001)(2906002)(110136005)(83380400001)(36756003)(66946007)(66556008)(66476007)(2616005)(86362001)(4326008)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3k1SysvZlhxRXR1eG5ZeDBMNEdGTmZDd3MxS0d4WUxNUHJEV0hIdldmUXI4?=
 =?utf-8?B?SytuKzlmVUdiZmpCVlFNL1ZNaXEwcUxneUZDOTZ6SWhBQkkxbnY3dEQyWVJR?=
 =?utf-8?B?cWxsU3BMN24wSFYwRlJrM2RNS1ZSUXU0QVRWYkRtZjlNS0hISzlaQ3F3OTNE?=
 =?utf-8?B?QnRiNnlTa0hZNFhLZzcxbDM4YnhmaTFZcFlYc3VRYWV6TGxvNW1QYXl2V05h?=
 =?utf-8?B?QURZbWZ1MkZhdGhHOW1SMFpCZFRyWjNYL3lBbkJwM29vb3pyQWVQcStmdlMr?=
 =?utf-8?B?bzFHdERnYTVIaUFjSmdncHI0aTg2VlU1ZWVZMVBRUzdXa0tPZDMvM3VVbXVq?=
 =?utf-8?B?UGVwSGN5dTBxaWhXdFpjMjVSYkpER1JGTDBoaGdqNmJkRXJhNEVxRjBYSHRw?=
 =?utf-8?B?aEFYVWpsMk9FU3NmeG9kYU9CcHZySDJQbFEwWC9pYVBTdE9GU01yaEZHU21F?=
 =?utf-8?B?c3lvRlRRekpFa3R2OXBFb0tlMGxqUTVQaVZKek53bytZWkUzdVBxOVdFSm40?=
 =?utf-8?B?VVIzZ1l6T21YeEJzcFJWbWk3R1lOVkNZa0wxdThqK3RuQXFzbW83QmZsTVFJ?=
 =?utf-8?B?UmlsSlpFaTlGUjZSOWoxUFpCd2xzOVI4Q0lscS9qaUM2dDgwSmorRVdxZTNv?=
 =?utf-8?B?VXBKSGZoWXRFZlhDZ0hjc3BRUnc2SXlSMGQ3UjBCLzYzTjFPMmxsaFRQeGNC?=
 =?utf-8?B?RFY5QmQ2MkNZMDkxc1ZyVk5Iamt0cytlUGlPWkNCNkx3VFlkeGVMTUxPQlh1?=
 =?utf-8?B?Z1JjaDRFT1RDN0JMUW1hWG1FUEkzSXZCeitTOXdkRjBocnFxNlVncERZYU5N?=
 =?utf-8?B?dkIxYTl1UTlHb2w3T3Z5Z3BkQ21uZUJ3Sm14bmIyN3lhMlFneFo2WnE4elRS?=
 =?utf-8?B?U0lreGxZOUQva2xvdHBBS2M5TU02MXo3U1I5MGVMV3BIMmtLdFd5ODZoU1R1?=
 =?utf-8?B?TUNxUXJOZXZmdDc0WWhhNXRxa2xpVXVsVU5UQ1lZeC9pclB1dkVVYlFkTU9i?=
 =?utf-8?B?c2tFQTVMaUtEZHRuSS85UjhzVTFpa255MS9Yb3B4T0J4SDdpVU9aK3RGK3BP?=
 =?utf-8?B?TVRFVC93UmxRVXh1ZjhNL3orUjhmVnIxM0xIQi9SOEx5WElzd1Zpam84cnU1?=
 =?utf-8?B?d3VCUlBrQU9RaUdrS3U5d2dySmRtV1o5aGR0NUtlQUpSUndHSzI5ZDdXcWpz?=
 =?utf-8?B?RW9zY1JrczFiRGRRRHU0bU1HOWVaeEwwZis3bW9YOEVEZUdzZ1FQaTNGZXY0?=
 =?utf-8?B?Q1h6b1lCQVJtZjhiYkZYcytiQ3FwVjA2ajdTZjg4SlhEQjU2cVV0SHhTZTdM?=
 =?utf-8?B?L3BRVG9hbUhkeE1Gc1JVVUJXbWZ2aGpiMVpjdlFnVWlLRmlkNVdRVENWNGJ4?=
 =?utf-8?B?dlpzdjlaUWdGMFBEb3FnZE9WbDhUNW5nK3c5SVNqNVRieVRlRzRYYS82NFlL?=
 =?utf-8?B?SCtrVzBNRi9WZ21tL210QUpaSCtMSUM2VnBqOFFlM0kra0ZIK2x5RkZyRm1s?=
 =?utf-8?B?V3JFZHhOeEJibGtna1o0SGtRcVVSYzlLNTRWVTZuMjF6di92WW1xSXduZCtB?=
 =?utf-8?B?L1NDK2I0TUFET3AxemJpUElQLzFRWnkrdC9iVFhGa29kZkFHRW9iN1dBT0xX?=
 =?utf-8?B?eDRuZFVzMnFmak9iMEhaMlNkKzdNUVlIOFJCNGh5T1pHMDltVFFpaUJwVmor?=
 =?utf-8?B?d3pjRnRvbGhrdmdwUCtnRXJBVTB2TUVpZXloVlBqKzVwWW44UFkxeWNKdFdV?=
 =?utf-8?B?VnpzK212WUdBUTBTVko4blo1RC9DSTZlQ01QZWczZlhrMVZ6K3YyM0xUL2JT?=
 =?utf-8?B?Q3l4anh1VS9HYmV4T3lZSmZkM3Z6ZkZORFlSaWU4YjZOTmZaaXp3alBiaURO?=
 =?utf-8?B?MXFrRlZmdllHVVFxWGdCd29hdjd6YkloemtTa0ZJRzNHSVpmRUpCRFdabnUx?=
 =?utf-8?B?OGNhQjlieXg1TU40VTM5VXozV0MyUGZrK3BKaVo2NFhSK3ZXbkRON3BNcnJE?=
 =?utf-8?B?NGZDdEdISmFLMXBYcE54OEh6NXBqRERtWlJWS1BKcWZiRXdOT1h2REYraDYv?=
 =?utf-8?B?eE1FU0MzaC9zaDllazY0ZUg3S2ZjdFFQMWF5amdBbGYrZFpOWEVaZHFkTnJQ?=
 =?utf-8?Q?QVdB+m2ls0G6j+qA35gY8KeU0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 520c7998-e11e-4b1c-0e74-08db777dce6d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:17:22.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQIvab/OAnQXwdaIavzQbGzg4WmNLhMRwxFAJiV7g3C3y2d5yI0U96XB+BcGwOn+pfOlE4VVVdC8oShTFAYHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
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



On 6/27/23 15:08, Yu Zhao wrote:
> On Mon, Jun 26, 2023 at 11:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Like folio_add_new_anon_rmap() but batch-rmaps a range of pages
>> belonging to a folio, for effciency savings. All pages are accounted as
>> small pages.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/rmap.h |  2 ++
>>  mm/rmap.c            | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index a3825ce81102..15433a3d0cbf 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -196,6 +196,8 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>>                 unsigned long address);
>>  void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>                 unsigned long address);
>> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *page,
>> +               int nr, struct vm_area_struct *vma, unsigned long address);
> 
> We should update folio_add_new_anon_rmap() to support large() &&
> !folio_test_pmd_mappable() folios instead.
> 
> I double checked all places currently using folio_add_new_anon_rmap(),
> and as expected, none actually allocates large() &&
> !folio_test_pmd_mappable() and maps it one by one, which makes the
> cases simpler, i.e.,
>   if (!large())
>     // the existing basepage case
>   else if (!folio_test_pmd_mappable())
>     // our new case
>   else
>     // the existing THP case
I suppose we can merge the new case and existing THP case.


Regards
Yin, Fengwei

> 
>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>                 bool compound);
>>  void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1d8369549424..4050bcea7ae7 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1305,6 +1305,49 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>         __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>  }
>>
>> +/**
>> + * folio_add_new_anon_rmap_range - Add mapping to a set of pages within a new
>> + * anonymous potentially large folio.
>> + * @folio:      The folio containing the pages to be mapped
>> + * @page:       First page in the folio to be mapped
>> + * @nr:         Number of pages to be mapped
>> + * @vma:        the vm area in which the mapping is added
>> + * @address:    the user virtual address of the first page to be mapped
>> + *
>> + * Like folio_add_new_anon_rmap() but batch-maps a range of pages within a folio
>> + * using non-THP accounting. Like folio_add_new_anon_rmap(), the inc-and-test is
>> + * bypassed and the folio does not have to be locked. All pages in the folio are
>> + * individually accounted.
>> + *
>> + * As the folio is new, it's assumed to be mapped exclusively by a single
>> + * process.
>> + */
>> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *page,
>> +               int nr, struct vm_area_struct *vma, unsigned long address)
>> +{
>> +       int i;
>> +
>> +       VM_BUG_ON_VMA(address < vma->vm_start ||
>> +                     address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> 
> BTW, VM_BUG_ON* shouldn't be used in new code:
> Documentation/process/coding-style.rst
