Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1467637C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjAUDmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjAUDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:42:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494DC40E9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674272529; x=1705808529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZjqyQH6lHs1mxmtYJVadBxfc0mrxAiTmFL4Pi0Hgq70=;
  b=U7DzQb1ejrfbCpfsmfZpOk133TzZFM+RS61rtFhLYgo4ZUAkC+TemOu0
   JNUgaclXZw1het0eUQ++HcmvjCB+17XLE9TiMXKG+pQNkYCo9ENGdz+Nr
   r/MwYDc+I8wcaBOg7mOl5iLFov+z80+NawdviLwWq0acjoniTUzXRu3xI
   5GOChbafaZq8R8kHvJ/vD0jm6P5TufC09s9Hxfu6BpysIh4J4LBKXEdA2
   ykXXWZvaVYjRCkB53uGmMwi0N+JxZrZ9yfLuSEcBrJAVVP/faG5E6+BO8
   ai8iMtlSY+CErGjULrxnjSEJAuliH8ddnlJDFMpGV5ubS9FWrQKs/+WJR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323442904"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="323442904"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 19:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="834634936"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="834634936"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2023 19:42:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 19:42:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 19:42:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 19:42:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlwGdk4bhsAI3kWJ8kg6bIfQBLX9/O1I9TRCzFd1ocCIQ4hXUp9sX4qbQnk/D2uKfByuqmYgWPH4R3waU9djSDRJTIdCVbCiALSy+j5f5/6InvBPXgJFi6FpHmhy1mgBlGjOYqJxkTxF69N6hVrzc3S9gGLG8LPLVQPEWwaFN8130iXogEAKjbRJTOfgVutFaSxWztziqp9jDUZEMROzVewg5OPBX/4QbwiAfUUHLzfvsOMsppnU+9cbYAoAyqhemtZEIz3UUUqIKyU7ZNuhfnCXYAhuxS5Wb3reJ65TIMRglHlRYOBPBY5CsoVit64w4tdRODZIsu1ylAD6iP1sSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIF7OEi+yak/LA03GGtUu/HM3livjMHR+fH2LObEneo=;
 b=jeNvM7ELjc4Qq9i8/+aR8Aj+Kccu9dNCeQQzk21tir96RClTh0yiAnhOa4zTqbkQhiFe3jdPKHsXbk0UT578fq3fnVGm0yrNSrjFMYzpSpa+4flVGtHGPoqMNESJDMOF2zBPWirlY7/RAYzwBVNK0/qdx2+9hg1lcomXuLAlbSPccoB7EI6zuc+IQlt1K+DgdrRK6pYu5Lczmqsit6Gnb6hnAlu09b2iEwGXqbyJXhXuGrZdjfRi72K4YKoPieWi3/cz3NvrnPQX9+xlEs604sMesGlPB2aTLhPQpJ/QCa9TtefhDvy9prDDEQczIrdq3wPG/3O+J6V6xfRZpD55fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB5422.namprd11.prod.outlook.com (2603:10b6:5:399::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Sat, 21 Jan
 2023 03:42:05 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 03:42:05 +0000
Message-ID: <2bcf36c4-54a1-37e4-7a0a-3d3e34ef4e56@intel.com>
Date:   Sat, 21 Jan 2023 11:41:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable 5/5] mm/mempolicy: Convert migrate_page_add()
 to migrate_folio_add()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20230118232219.27038-1-vishal.moola@gmail.com>
 <20230118232219.27038-6-vishal.moola@gmail.com>
 <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
 <Y8rv3/GfW8XDDXj7@casper.infradead.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <Y8rv3/GfW8XDDXj7@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7486e670-353e-4d96-6297-08dafb6176c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5Kh3FSKGWK1UEXb9N8P14ky8fMlMgm1DZY1gJ9Gv1tU3GA7IkNGGCk4HXGsc97mclFRM82Cod70X5trYOdnq3TgQDC9+gFw5F1QCL/4zu4DdN6QGgAWUiJfvOypgePbLJ9ow8dPXJQqnfj25SNChGoFALdC6tM32VBOLZXKR/hzjpzY8qEIDx/EIMnPoNFuMR0P1VdUeThsyvnZbKrkAwzySO2xpAkYCd2cbnhmZkBbDYGnVIzV3f0481HGnusZ7+Zjd9Hho8Gj3PjEnoCsS/5Lh4wE5sVU6h2pz+Eh47Y9u4OUmhWxity20PjY0HpZV05Fnn8rhFmGULk1wkD8SQdKb1VvVCfKTXBTApchvLNTEqCcxj2XNxfTyscdrRiCqG569K2t+HtXlg+/O82PaQstt4HVE8x5nT6qsmBMxG+sR7O3yq6rHOl2PunwwbyYN9U7cMF1fUDha5jJ2j+JRxkCQ4Ujj/hlT9MEnpp0qxD5pW4IA+2lxzhyyaoKxNhnISjSywy4lSo6a/BMO0V95PVHaapherC+4aFFgKfYQma+33x4UOvZ3SyP019fFzV/IolbDTjqtT9+y8d6DUVPxYT24oDn5aMOjfcP5uNArW/nwXnZd/uSHIdo8Xluv8ApAbj978622hiB3m0KVSAb6HUUn1/PNg9WdODuS7OGL1HKw8LOFfYPnh3i2AOdZxAEoqtotRpkupyxDcSVZuOfGxTLBNnkGQluZr727kgIY2OtOycTruzKw7fynYrC20dZ4m/+XVdarAnKpsXrRmJFdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(86362001)(82960400001)(31696002)(53546011)(966005)(6666004)(6506007)(6486002)(36756003)(5660300002)(478600001)(8936002)(316002)(66476007)(4326008)(6916009)(38100700002)(6512007)(41300700001)(26005)(66946007)(186003)(8676002)(66556008)(2616005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtXTVF1QmE2eGd6UDZrUXRlSTRYTStkbzF2TlBFVDhyeU1IaXl3dm92Z1c3?=
 =?utf-8?B?RjM4TXovWndjL25qbi8raEhud3lvT3hnL0FwYzd4WTY3QkpSTFluSm1RMnFM?=
 =?utf-8?B?QS9iYWFNSk54eHFmTk4rTWkxWmJWVTFzOXpEVHVZRW1YK0tLMldkaEg5KzVx?=
 =?utf-8?B?SkE5bEZjeU83RjFJeGlKYmFVdWpXcnR6NjQ3YVREak5COTNVQXJjbXgxL0cw?=
 =?utf-8?B?aGxJTnhvZmcrYkd1SW1BUWxITG5oWCtPb0U1UFIyMXhRQWlqS083MWdtY2dB?=
 =?utf-8?B?Y1VydEU1RndWVlhiSmV1Y2tkd0JqZSt5SVZpNnJ1YXFnd1Z6TTMyK3FkWm1G?=
 =?utf-8?B?a3pFTE04NFRDQndSV3l6SEM3M3k4M3F1Zkd6RXFldmJRRDRHNXBnSDZuS3E0?=
 =?utf-8?B?NUpzRnJSWHQyT3F1UFBBU2RyU2w4MWtHaTRzS1NXOXJRT1lEUzU1bXluUzNn?=
 =?utf-8?B?TTdhYlhmVWZRdGFNZlpqSEI0WGcvL3FsdnFweml0KzZVbzU0UmpaYkhxcXcx?=
 =?utf-8?B?VkY2RDkyQ3puMXk1N2xreDBKaHBCWHBZOVE2UkVvRTBET2E3OEs2UXFjY1cr?=
 =?utf-8?B?WnN1MkFpV2hmdEswRXloZFE1RzBpZGZMSlArL1B2OFQ3ZmcrcWw4N210ZDBB?=
 =?utf-8?B?QWJrRC96Yy9DWnlwS0wxb3RKbEhJUXNZeTVsdm5KcndEU3FvSnFPZXhpNE4v?=
 =?utf-8?B?cjN3ZGZNUnQ4MUJXNmhUZUpaci9ZanV2VXI2bG5xNjFtNWRCMFp3S3BjRi9D?=
 =?utf-8?B?c1RqZFVDMGFOaWc1L3NaazZaYSs4cXJKYkROOGdwdEQwNlBqSmdzL3laajJJ?=
 =?utf-8?B?YzUrSkFGWkxJbTdnY3FXQkVHclhPdTc4U3p3TDc2OTRQU2xCS2Zod0ZnVkNH?=
 =?utf-8?B?UFgwWFE2WDlmNHpaU3lBd1VtSThDbzJ6dFozR1QvSlRoaHA2V0dwYS9LT3Nt?=
 =?utf-8?B?V05OTzYrTmJmSmU0RFZYeWxiY2FES000ZGpGV1c1UkMrMWkxd3J1eHRWSzAx?=
 =?utf-8?B?WFFxTmVDbnUwVk1yb1VJMmQ2R2t4aHdUbWZSVSthSHRJbGpoYmlMc1BpR014?=
 =?utf-8?B?ZnlnSlJ0YkdQNXVaOXR4RGNTZzZ6eDFqcnQwQkFQYmNodnl3T0kxSHdxUkV4?=
 =?utf-8?B?SVBlYWpERG1xMWtoVEdEQ1lUQmh3aDdwd3daZXBoZjNYNnBpMkxKZkNwd2po?=
 =?utf-8?B?SE9laVZqZ0tUL3M1cWFyb3pBQW1NS2pYNVVLcU8rVk9XSExXMDRHbHV1SU5r?=
 =?utf-8?B?d2JqWWlaYXd0b05uMnB1M0pIelJpeUJtTG84QUJZVGczTVBQaEFlZ3BoNVV3?=
 =?utf-8?B?VWdCSGRGVVBnOWxhOHUxbnJzbExBU243Yjg4dW5ZUHcxV0hqcUF2c0xEaUp2?=
 =?utf-8?B?UUR3YjRPbmw3Yy80L3o5VGRVMjZGRS9xS1gyWlZYQXk3Skw2cEFWb2wrREVN?=
 =?utf-8?B?ZVBMdkRlcmRXWGxYaWdiSGN6QW82SXBUWlIrT1pZSVQzdVg5VGJPaUhNdUZO?=
 =?utf-8?B?MlNRNlNRVWNmR1NNRlF6Mm41TnVxVGorQWx2b3d6U1kvYUVOMlFmTzBUTGl2?=
 =?utf-8?B?R2lsWjQ0SW56N3puTVVUS1dpS1lpcmRuY21KZS9nZ2Z2L1FRd25kT1JuOEo0?=
 =?utf-8?B?RkhTTU8wZVdjMFQ4ZUZNeTl2bjFXQlE3SEYwNUxySkNaZHg4Q2hWeUpEQVJC?=
 =?utf-8?B?Z3JPTUVXeWt3WEdZVTNuK1JRYmwvVGNuKy80MEpDS3dCZWFzTkVpaEE5SERP?=
 =?utf-8?B?eEFEcTZrM0ZvclF4VTVpT2pzdk4rbjUzUHdkb2tDMENqZmpDSXczNHBhWVB6?=
 =?utf-8?B?ZzZZaTNrcHpRTmt3UStPU0lBM2JKdmRoY0VXVFZ5TW9uS0MzUzhFVTRITG9V?=
 =?utf-8?B?U1FvNWlFcFFmT3RCeDRFWUpsbTZGTG9RRDkyaHFCRm5DZGpxZkdUL055SXcy?=
 =?utf-8?B?Zzhic1JVcUY1YlJZTXFPRDFLWWNGaysxdWcvM283ZU96WWhKa0dST2hLakw5?=
 =?utf-8?B?QWlBaEpXQ3R0YXF0b0ptd0E3Skp6Y1JZVXdTTWp1NnVZdDNwZ3B5K2xZME83?=
 =?utf-8?B?Nkg0OUNqNFZmUnk4ZEcvZytGNVpmcDgxZXRIOElvMDlOR01RUDFGOHhWeU1k?=
 =?utf-8?Q?+TrTfC7kJJbyzxwP9K20gcFzy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7486e670-353e-4d96-6297-08dafb6176c7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 03:42:05.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS1o/KmQWCEAUMt3ZGSS2XNeG0p1zi1hnwWgyXYIdc39zqV/VT1LQ6Jvv+IhqdkK6sITD9On54z6m6oo/cegKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5422
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2023 3:47 AM, Matthew Wilcox wrote:
> On Thu, Jan 19, 2023 at 09:24:16AM +0800, Yin, Fengwei wrote:
>> On 1/19/2023 7:22 AM, Vishal Moola (Oracle) wrote:
>>> @@ -1022,27 +1022,23 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>>>  }
>>>  
>>>  #ifdef CONFIG_MIGRATION
>>> -/*
>>> - * page migration, thp tail pages can be passed.
>>> - */
>>> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
>>> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>>>  				unsigned long flags)
>>>  {
>>> -	struct page *head = compound_head(page);
>>>  	/*
>>> -	 * Avoid migrating a page that is shared with others.
>>> +	 * Avoid migrating a folio that is shared with others.
>>>  	 */
>>> -	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
>>> -		if (!isolate_lru_page(head)) {
>>> -			list_add_tail(&head->lru, pagelist);
>>> -			mod_node_page_state(page_pgdat(head),
>>> -				NR_ISOLATED_ANON + page_is_file_lru(head),
>>> -				thp_nr_pages(head));
>>> +	if ((flags & MPOL_MF_MOVE_ALL) || folio_mapcount(folio) == 1) {
>> One question to the page_mapcount -> folio_mapcount here.
>>
>> For a large folio with 0 entire mapcount, if the first sub-page and any
>> other sub-page are mapped, page_mapcount(head) == 1 is true while
>> folio_mapcount(folio) == 1 is not.
> 
> We had a good discussion about this in today's THP Cabal meeting [1].  I
> didn't quite check everything that I said was true, so let me summarise
> & correct it now ...
> 
>  - This is a heuristic.  We're trying to see whether this folio is
>    mapped by multiple processes (because if it is, it's probably not
>    worth migrating).  If the heuristic is wrong, it probably doesn't
>    matter _too_ much?
Agree.

>  - A proper heuristic for this would be
> 		folio_total_mapcount(folio) == folio_nr_pages(folio)
I am not sure. File folio can be partially mapped. Maybe following check?
  for each sub-pages:
     (folio_entire_mapcount(folio) + sub-pages->_mapcount) <= 1

But it's also expensive to check all sub-pages. Maybe a bit in folio
if filio mapped to only one process is really important?

>    but this would be expensive to calculate as it requires examining
>    512 cachelines for a 2MB page.
>  - For a large folio which is smaller than PMD size, we're guaranteed
>    that folio_mapcount() is 0 today.
My understanding is: for large folio, if any sub-page is mapped,
folio_mapcount() can not be 0.

>  - In the meeting I said that page_mapcount() of the head of a THP
>    page was zero; that's not true; I had forgotten that we added in
>    entire_mapcount to the individual page mapcount.
> 
> so I now think this should be:
> 
> 	page_mapcount(folio_page(folio, 0))
For file large folio, it's possible folio_page(folio, 0) mapped only
once, other sub-pages mapped multiple times.

But I think this maybe the best choice here.

> 
> with an explanation that checking every page is too heavy-weight.
> Maybe it should be its own function:
> 
> static inline int folio_estimated_mapcount(folio)
> {
> 	return page_mapcount(folio_page(folio, 0));
> }
> 
> with a nice comment explaining what's going on.
> 
> [1] https://www.youtube.com/watch?v=A3PoGQQQD3Q is the recording of
> today's meeting.
This is nice. Thanks a lot for sharing.


Regards
Yin, Fengwei

