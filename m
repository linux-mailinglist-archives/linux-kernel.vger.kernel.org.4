Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9F682165
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjAaBbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:31:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33997244AC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675128669; x=1706664669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jr0kJYgxJBMFPdswqiJWCaWPzEWvRIcpkcFdntrYYuo=;
  b=NxHaqd40f+4wl0aNnzEkrDwkZB6rwEHuktSjakkFDj+r2BiN3hbg3Fxx
   LVOA+wUJUqviju7s7c63zK2gpEUZDcHjfCxSXwi5PnTTYmECZ0CRK96ZU
   h7vomgxxZKLBDQuZ5KKi0eGhkC2xvNZmtr0EWrwFbbQESHgFweLPFP76r
   vhbOq9htoNTf+z7a5IN1KFtRJ17hKIhu4qV7GtCZI5pXGptOcuZIoOaWR
   rWwlYo3zEGWQM37yS4Sh4COd/cOdnc50R183MiaiF2kUhnhyOXn4ff8WC
   eVuGc5LF6Vpr/HWAeWh3toCNvxv/5XlWcZgxGPQCvli7S8PKFlLyt7rxl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329833207"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="329833207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 17:31:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="838162708"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="838162708"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2023 17:31:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 17:31:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 17:31:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 17:31:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c73BAoRG6q+N85sZ4I2tj+0BWE4nrqs2PD1J93Z4uss2RTxwaYR/LAnsCcwg1CRR1t0IXvqMgVsLZ0Wm0BLg7mjJkwfgXBJVXvz313Qrlvh+BQEqMNjKmjBtJ/9rgzGYgJ8wLCWPP4FJ23icJo1Maea2jF6sIGiPCeqQzi7D3g1oTTRRPu9PTBtdbWo671A7j3gcq042kss94BcRAttSUZg6herzF1GFo9mzDqXM/Y0IgElFy1W/adEMLmLUtrnA4iXKeZGolJdYKcOiVvJZJf194rstd0+MU5eD9mdMHDn4kTNHGlG0F0T3ZDfCEOSePWsjFXqxdQ0YSy4azcBdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j6pKu4OHxDi1YnmF2m8v0g6wrV5K1dM5ff4SaMDruI=;
 b=jKMW/dYuJsPxusePDHS2tlE6a3gJP+RfOSltZBXVDTln+JjdWr2ud4Ze55ZrwpX2BnkbRprQmDmf/zvHoteJ4Zjldtj4GAm3GhcKwgHVseHpynCgswD9jDl+I9Qv6y/mgMMqtl8fE57PdFfTleLub7LLsMlW7Iy/abIAx1owZxIFkWsH5L2QO/nxQMFO7RGCvoXszIspfICO+8mv9L8/92rpdrvBFaHaEOlPZkz3h36Ns6VVtgXH313TjiyAVZg1UrPMFKeXs31Y/SCitBEfUPltjsa1raiLslHyFx9VekRB2SyeI/t5u443Xpe85jd9yIHMOn9dXp+Hgb2nAcfL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 01:31:04 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 01:31:04 +0000
Message-ID: <3811dce6-ce81-2a2b-1891-a6ecaddfecdb@intel.com>
Date:   Tue, 31 Jan 2023 09:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable v4 1/6] mm: add folio_estimated_sharers()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20230130201833.27042-1-vishal.moola@gmail.com>
 <20230130201833.27042-2-vishal.moola@gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230130201833.27042-2-vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbf84af-3ae3-4be4-dec8-08db032ac37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDQyLAmu54uRuH/FdGwF6gK0gbUDwifroRhyCzky8oJkw99i0EIKRY6RDhE5ROF7GUYFfjzoHBSEX3PLSRgvYKFpMDaBhykD+nRMgf7L9GLZweHKmL+2aAgiS/0MyvpVL4+nwBZvy/Hb5EwqUft6fHGfDV1W1AGtLNqMmyxh5fmlu5XsVsQ/4IrpdeEAM1JFXUo/swHp/umSuQw2AyYtDDZxE6YMtP5LbJOPbtkyaFMEQqmBKfkl7rCsGLfh3OTOZYlP/sl5nyOkwage0Q53hNRgWyEbYKNEVsp74pRfzbIO3Nu1AL7prkBgDpVxNIfNvyhqv1ZPo0EF7z8ph7bJ72+ncdBjJXjZt5lNnMNv1bPUBuarLZZdbCXAC9A3kS9a+VTvWA5yPUJ8SCCqfRhLEsb7kGB0g1k5lRO41BQGVtXDnexjVmbs5EdLQf+GTUadGS5AW6kPgrxtD8FiiayIgCQHcvaNkXEwYd1NSYmbdUGNXL1jajNCBOl7SCRI03p1CV35dgWBrW++0knxA4U8TNbLbQDfNS31r5IfaNMDxQJy1B4TNG31XajhTd+FoXXqBCT+sJAvTVIgI9ejnD87wvZtyFnVHDMXSEVgwrSFygR4Eo5IYYjv3PCmd7l6mHrbUF6C8dwWTy4uCUobBkcKL+BxtyaEMl4vkMyx3tJZy3u5I2DXToYPx1gmzlOUjX8/bqFAgZVH6H5JKbdSCeNJuFy1xf5sHiPoH16mZVu7TaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199018)(82960400001)(31696002)(38100700002)(86362001)(41300700001)(2906002)(36756003)(478600001)(6666004)(6486002)(26005)(5660300002)(316002)(4326008)(66946007)(2616005)(8676002)(8936002)(186003)(83380400001)(6512007)(66556008)(6506007)(53546011)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRsUFJudGorSkFiSWtMd1NFR3hFN2hCdG1rQ3UxQmYrRHpRZTdRbFBpZ1R4?=
 =?utf-8?B?eVl6NFhrMlBkdmo3UHljeHQ1RGtYaVRhVElBbUVJc0NyVkliaG9Wa0EwMEJv?=
 =?utf-8?B?MGdEMHRMOEpZL2g3bGtjc3RrbDZaaG91N3REVGh0QjE2L0NEb2NRTytGZkl1?=
 =?utf-8?B?a1ZwcHl6bmZBeWd2bGJ5WHJidUF1V1BzZ2plRmZmU2YxbzNhb0VodSsvL3k0?=
 =?utf-8?B?cHBSRFVVT3hvV3NLQ1lHSkY1UVpMZ1J4NEgycHZmSXk2bEIvbDZwUUl0ei9T?=
 =?utf-8?B?Qm04TC9XZURMNTJOeEFjYTFvK2pJMkkranNmMDhYWi9rL1ZqdUNWbWdFUXdT?=
 =?utf-8?B?Ykd1dFZ2eW52c2hyR2FvSTlhcmllVUVyWEdDVjdwaTlzSnVnZTN2VGtvd2hL?=
 =?utf-8?B?a2VKcVV2K2FnYUNwS20yWlovODVLZFo3cUVWRVJBN3daUW5teGRnYTNsSTY3?=
 =?utf-8?B?OTFWWmtrSHhFb2hxNmNYdnZSbVJCUFo5dlVQN3ZsNWVyY0NNZlpuNmNXUlVo?=
 =?utf-8?B?WUFrenJLa1kzVlhzSUZWeDlxNlM5K0dadkZHTHlhS25QbjF6V1JHeVltL0E1?=
 =?utf-8?B?QnhsVCt4aUF5SDlhSXR5S1ljN2VMQVhBNk5wSlFnQ1lHMzArejB6Nm9KZnZG?=
 =?utf-8?B?aHdoM2JheGVIZXJiNlNabFhQMFRkTlMrYVltTEIyWGhiSSs4YXYvaVVNc3Rt?=
 =?utf-8?B?cjMyUjh0eWt3c3hrbmw2Wk90VnZWcGZCSTNhZklrN1R0bkgvMFF6Z2JldlI1?=
 =?utf-8?B?VXlsb3hja0ROQVhaRjIrMXNOandVMjcxNmlKNzV0VFJUT2NoVnBZRmxyTGJT?=
 =?utf-8?B?TldlbkpNRXBjUjRuN2hyWWllRlNrZFo0VnNRc1IyMUpqVHcxaUdvS3BBRVZK?=
 =?utf-8?B?ZEczNGNEUFM4WmREWUdtckdGZ3ZoRUl0dTB3dWUwUXFPMU04M2R6OXZiY2Zp?=
 =?utf-8?B?eUZhZTFBczVSOWl6cUxrRXJsbS9NYW5Pekt4MGVwaFNIZTdZZnp1b0FVc3RI?=
 =?utf-8?B?alBCYXBIVnl6MkhWRmwxNjVlN3RQTDJ6d0ZpK292ZG9WL0d2c2NPM1B6YXpp?=
 =?utf-8?B?VmRJSGdpaEVQM2RneitFa2J2RTNheU10VGFXblEvUnp3ek5ia2ZDNVNmQkNo?=
 =?utf-8?B?NnFBSzNNVjFQYWVhNmt0elBDcnUwUkg3NmtpQUNreGtWYXpyT1M4NGoyYjlO?=
 =?utf-8?B?S3NySEYyNVVkaTZSanpyODBOY081WDl6MXdYZUYrOHliUWlnalArOXJkV01K?=
 =?utf-8?B?WWN1WlppR3R5NndqU2hWdnBabzk1emhPaGJWcmE0NGkzMitLS0laVGRNODZh?=
 =?utf-8?B?N0pTbmM5b2F1REtrTFpNallLQkg2YXVOZUF2T3RqRHZqakx6c2hteW95cjVl?=
 =?utf-8?B?VWUvZW1sdW1mQnBZQlFqdlQ5RVVNNjdNKytKWjF5RmxCU2VPbjMzbG1JeWJk?=
 =?utf-8?B?MXJkcE1XTUgxQ1V3Y2dxZnQ0Z1R1OFZCTmRnLzhaVDBseWljaEF2eGJpQnhj?=
 =?utf-8?B?amNqZkNzcEVZWExyMzFTN2dJVTB5L0xvWEpsY2liVzB3eFFqem1rSjd0Rzlt?=
 =?utf-8?B?aGpGOGlCUVNkSGxFMmwxZWJzc2dYaW5QTFFCaTNnNDAxcXNYaVJhcHl1Y2NF?=
 =?utf-8?B?SStUdUs1K3VzaVhENkM5Y2xmYWxIVjExdHg1ZFIzbGRDUHBLYnB2a1c2L2J2?=
 =?utf-8?B?NHlWVDRZdmVYV1QyQyt5VVlEaTZpaFB5WkZtQjN6c1orbnQvSHlRaktibVJh?=
 =?utf-8?B?cDF1dGZqSzZqUVdnTmF4UnR0aXlQS3lXblZJbGV6cFd6TkJGVGlKWUFYQmMz?=
 =?utf-8?B?Z2FnWUtMUTdxUXVPMUVReit0VUxXVXR4WWdybnBscTQ2Wk5sYk1uNUhJUGlt?=
 =?utf-8?B?K0k1MW93TjRNTjAzK08zbndoMHRQN29uZXdMb0FVOEg0cG9rR2lSakhmcTlP?=
 =?utf-8?B?U214N3JUUTJCYzE2c281UVhFRER2dGI4NDQxdmZ1bThyMSs5aWx1VFhYcUNn?=
 =?utf-8?B?M3hYTFFkbFdyYzBFSlNWVk5saXl4N1pzVkFNc1pUL21icDZDSFZQVW1yVy91?=
 =?utf-8?B?Zjg2VHdRelV2ZlhCK3BGTjI1M3lpZ0F5OFp6TkNMMzlqMGFCZWVraVFwUFlH?=
 =?utf-8?B?UXRXbTFob0xvRVBTOGpBaWdxQ3d4Q0JtNGdCa3RSczU5eE40QXFMYzZ3dWhS?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbf84af-3ae3-4be4-dec8-08db032ac37d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 01:31:04.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UDLvuYOIGGnCI9YfK3+OEmGuzonCpRFIWCkGHOKHC1WjHuJClLH67lvEmDkJGx8zu/pCBXAMAfPh1AIQriLaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 4:18 AM, Vishal Moola (Oracle) wrote:
> folio_estimated_sharers() takes in a folio and returns the precise
> number of times the first subpage of the folio is mapped.
> 
> This function aims to provide an estimate for the number of sharers of a
> folio. This is necessary for folio conversions where we care
> about the number of processes that share a folio, but don't necessarily
> want to check every single page within that folio.
> 
> This is in contrast to folio_mapcount() which calculates the total
> number of the times a folio and all its subpages are mapped.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei

> ---
>  include/linux/mm.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27b34f7730e7..c91bf9cdb3d0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1905,6 +1905,24 @@ static inline size_t folio_size(struct folio *folio)
>  	return PAGE_SIZE << folio_order(folio);
>  }
>  
> +/**
> + * folio_estimated_sharers - Estimate the number of sharers of a folio.
> + * @folio: The folio.
> + *
> + * folio_estimated_sharers() aims to serve as a function to efficiently
> + * estimate the number of processes sharing a folio. This is done by
> + * looking at the precise mapcount of the first subpage in the folio, and
> + * assuming the other subpages are the same. This may not be true for large
> + * folios. If you want exact mapcounts for exact calculations, look at
> + * page_mapcount() or folio_total_mapcount().
> + *
> + * Return: The estimated number of processes sharing a folio.
> + */
> +static inline int folio_estimated_sharers(struct folio *folio)
> +{
> +	return page_mapcount(folio_page(folio, 0));
> +}
> +
>  #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
>  static inline int arch_make_page_accessible(struct page *page)
>  {
