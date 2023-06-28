Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5C740881
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjF1Cni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjF1Cne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:43:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429882947;
        Tue, 27 Jun 2023 19:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687920211; x=1719456211;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PV4swNzFCtA2mZ08xknEXIY2+fX13/DpmAzwFLdGrFI=;
  b=bTjFsc0qeiJ4cU5PeRoEvOoNsPdfx+ljIHPQfOIKYvPK8fr36F2Flj94
   ygLXNcjxNtJWmwEKzYj2qNDsg56Av5gN4Yn05gfjZeGdqYJNM43FIzndN
   KWWXueIK0t/mb6wc2ZRA7MxTzKeVcH1QpIK9Ve9LO6Jv45btA9HE9Phrv
   prVnWJsRWId71vOmXPTDxyPKqJ/ZZYIhQIpBm6ZvtlnKQ6QIn1WzGEWZd
   Du+iB5rtsid90B/4DjC9gHn+n/fvZsYaGvL68CGKgtFxghfJNWrwtmuPU
   dotEy5jzB2WfVPAog2NLIpCNk9NaqGgasJ2w9CplET9s+9tolqOf3ChJ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425404157"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="425404157"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752042806"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="752042806"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 19:43:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:43:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:43:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8FT560DaNvquaX7muBLrrdmDuFEQ/3kibNS0OXFxVU6EEXsafSHXScNHtrlGhIOsFRCt2np0OUzB2b6gPyitNDS5uJz0Fscb30NmHPcV0U77y/yBsvOPm0wjeQnEB32UbnK15xo/jEz08Vovo+uAWMGEx9N9LtbYNPWFQP/r4f+LD7QwezAY3Y3UHS+PxC0Gj5J5CKSfwmwhk8g023g0qfOWI7TuFrfVCIJZFOm/Dix8X4vodZHqPaOihSRu+gi28+YGxNh+E4+M0+eQAEfqjX7ohC6JBw36/P2dHJ9Qyx6trb1hti1wVzSm9qbahtC8WbRUcsaZjqVN3F4NjZ5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGsic+KcL0gqfz7BSzgJm5elWH80iVh7dRhSTVu15BY=;
 b=HPnq2Aw0TsrK+QoT7BfTZXdGELMqnKHVaFaSS8xJLd75eMQFNQ6p1xqbsuZXD/Pn7/EOXQZlRZBRjVdE0M+xk8QcP6Bsx+fZ3vSK/gJoY1ir9M+st/Z8VbKXElZ/HEJZ4h/Olsmtc6NZzeEkFJqTe8zmsY+Qk/8CxsYqVY7cAm2Dks0K7jhuaRzuxRjJ8CaVlDWThUe3gE7Jxxyg6NgPxMMCUDBMKpkNdBkpSd7b2TnhBJNKoJnKnqpEUOpsj4Nb+rQv8zMuo1pcUGD/XbGVKt2laZGCyrb+xWegHg8rxUfF1fA857dFFyHkM779ezAxlZirq2qIEiRJSFXAW7s7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 28 Jun
 2023 02:43:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:43:22 +0000
Message-ID: <ddcc31b5-0518-e2e3-2887-62a4ccc9e582@intel.com>
Date:   Wed, 28 Jun 2023 10:43:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 06/10] mm: Allow deferred splitting of arbitrary large
 anon folios
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-s390@vger.kernel.org>
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-7-ryan.roberts@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230626171430.3167004-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 22651b35-81f4-49cf-eceb-08db77817085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXzuC11LgE82erJhN9S3YtgmBNRtC8Ry76xc0bE6nlmjb2kyZ5cL/Em1NMXbyYh0jxWPM4a/vSd6cIRaRhx1OzGpa7ZuovKApWbmyDDQGkVtNV3zHKWD3LJRibzy2f+QozftDB2I9fWqK9tQn+bDkO9t2tZYz95KySHnLl+oVW4NZOgr8vYVIm740cwDH3wbfPcpSJ/VkZ0c7WivTrExTOpVX/hHa0S5HTubEsBSlD2sf10hv5D2u7Uaxv19lfs5MPPt90bsPDOOKha9erRJPxs3LqN3ZdPh+0ezaxHNiEwCq50pXKjEMvJh6aXoTxd06hXTyQU2AiVrTo4wCj1hBJ73Sr1Gs5OaSGOuHsgl4YN0QEs2uv2MHyH6WSQe7G/8B40sanR+8eOgG0STtOcAeurknfvulltvpiuU9eebf3c33M3YsQIGjUDmSeIz0lJ5+L4+BDVSKsqbpfWq5/xnk9i0zZ6ElarBjD7pKW8KaFzZQLUaPTMzSBt+45FClCq/XmiXg3RtaKuwHmjEt2J+rQaorXsGzkCSHIdKJ/uJwJMg8Ah29+u89bjnuqe7yN1/YlHKrE3nyKYTeOurwEKs3X92aimmm9mhLKKgdtE3UQp0LSbu4us9Xk84IrwCYhH4ygdXreKJMwrrJAw3aglBsYgm/B0koM48keymSmLY+zI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(7416002)(5660300002)(31686004)(66946007)(4326008)(66556008)(66476007)(478600001)(36756003)(316002)(8936002)(8676002)(2906002)(110136005)(31696002)(41300700001)(6486002)(186003)(86362001)(26005)(6506007)(6512007)(53546011)(6666004)(38100700002)(921005)(2616005)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xSbFFuSFV6RVVjZ1lVMWVnVkN0bXFLL1ZlQnc3ME1xdU4vZHRRMXhaSzVT?=
 =?utf-8?B?bDlQQXRlY1VFTnlsZXN1UFBYN2U3cmlCUlJaVVlUQWZXQjhiWmdNSGVQNC9s?=
 =?utf-8?B?UkczSkNodXhXOHF3UlN1eWVGNEVDU09IUndKOEl6a3ZTcExFQW1Relg0YWJa?=
 =?utf-8?B?Nm9JZzBCNWJmRlhqaG1xNGZwV3p5eFE2MnhMVUIxSUJrdjBoZjRMbTdtaFBa?=
 =?utf-8?B?WmdkcEh3UUNZZzBmcFdCU2pPM3ZnaVB0TFAxUGQyQjRhcjQ4USs4U2k4ZTdl?=
 =?utf-8?B?R2g0M0J5Wk0xL3d2VkZaMVAvM0VwK0ZDVXI5aWZsREh0THpzeWlNQmVySXJi?=
 =?utf-8?B?ajFDWGZUM2ozTjV1WjQ1cXM5TENGem9URHZwVWR0ZTVoeHRpYnNya3B0dUJo?=
 =?utf-8?B?MlFpc2RqenY5TGNOei9EUm1kZXVqR2xxM3BMOUpxRWZ0VkpWWWlVK3ZvN2Ja?=
 =?utf-8?B?OE9MRUkrTmR1RnMyMCtDTzBvamRPVkNMdE9ZeDZEaWFkUnh5Z1ZtVkpnRHR0?=
 =?utf-8?B?QXVsdGhlZGpPWnUwZFlBNkhMVmNIbEZjUXlEcTNSSWpuN2wrRU5UWmpSRzN5?=
 =?utf-8?B?eGZxQURJbXhnV0swLytrcXZOeUFkcjNTcFF3cnVwdnBTTG5QdjNGODNQOWxn?=
 =?utf-8?B?TkJDSkJYSkk0ZnZYbUdIZEZGYmJhSWxFZTdoSEhtNmNaTlJZaG0wNzcyMlky?=
 =?utf-8?B?NE84dXVNaTdnL25BclU1SG5maTFydW5hMFJxYTFwUUJpSXMwZE9CNXB1dExD?=
 =?utf-8?B?aUx0dEZyVVZxNTJtNnhqbzI1cWI3UGJGRlFwR2l0R2NOQ1k1ckYwemR3Yk4r?=
 =?utf-8?B?SlQ1TTRtYVdwZXVSRUZjV0E3cWZ5S2lrUFFLMmx1ZHEwRHUvNzdHUWJ0Q0dt?=
 =?utf-8?B?dGRVM3AwaE1OSjJYYk80QWtCVmlVY2lCZXNRT2ZzMmJlUmxPdXNRUFZJUnVa?=
 =?utf-8?B?YzhLUXdXRVcxK3k4ZmNsek1FbHRiMkM5UXdXTlhETTdrMVgrZzBTOVN4UnJC?=
 =?utf-8?B?eFBLOGlwS0UvTlVsWjFzV3p1emNlNzlOb25VKzZmWTNWQ0FjRVF2NklwMUEz?=
 =?utf-8?B?cVRVZ3pkOE41eDV4UzZ6ckhFLy81WGl6ejRhYVN5SmdET0tvQUR6cXp3UHFZ?=
 =?utf-8?B?cnFTZEwzaEh1OGVBQS8vSnhHc1N3SkZhMjFnZ3NWZ0VCNXBsOTIvRzA3Vm4w?=
 =?utf-8?B?dnpyTUJ5RlRTU3kvajdBUEtPMFdFVDhaVTNTVzBjTHliQmxhRWZIdGRBUDNi?=
 =?utf-8?B?ZjM2MkpFRVJIc1hFeUFldnc3aVJBY0Z4TWhibllNQkx2VkNLb0JDUW56NWFi?=
 =?utf-8?B?OWRTMVoyZjB3NjlpSVR4TTYwbVFrOVdhTVBpMjQvbkdSTVhnUlN3R2ZSZjBv?=
 =?utf-8?B?R1ZZOFVNOVdpTUdUVksyQWlIWEhvWElpTVN4SGJEYlRZdHEyL0FlWEoxNkhV?=
 =?utf-8?B?aTFRWTBxQ1ZaQlM1K3NKaThnRTlSdkNOQnBoWmJ5aHNSM200NXJ1WVZhSmFN?=
 =?utf-8?B?TDVGSjBOWUpzdlN6YklXMlRCb0o5ZGwrUXg4NThVSmlsVXkvWVRyam1mOStH?=
 =?utf-8?B?bzhIazFleGFoRnZYT1NyRDRmb05hVDB1Rzd6cTN5VWtxMWJvemdsd3V0Y1Ex?=
 =?utf-8?B?Q1o5Si8zWmVzTU5TQ29nbyt3ZXdZVWxYbDNhakxtRXJtK2pINVNTKytPSzQ3?=
 =?utf-8?B?UWZCd3B4WGZjMHMrdmhNMFU1T2xhUVVPZjkyeEppb3V5eUhSVHMvdWFxbXRv?=
 =?utf-8?B?anJyZFJqUXFiMzl6YjNRbHI3MW9aN05uUThjWlJBOTRrZ3NncmsxRDEwdWhP?=
 =?utf-8?B?c2tsSlFQcENlQndkMVVnSXVaeDJhbFY0UGpvQVcvY2lpN2o5Rm9rSmVSQm9l?=
 =?utf-8?B?N2pJUm1EdEZZS2NyaDc0NTI2Z0lzUVZhZnZWaGxjNy81dTNoaWRiTkI0RXdO?=
 =?utf-8?B?VytSNFZuRTBmMnFHc29CT2FnZ0FLRGdRaGZDenV1TWFFRnZkN0lSWFJXa1RI?=
 =?utf-8?B?WUt3RjJVcnk3NnFBeGxlRzZhbkxWSEIwZytoZU14Y2FqWThicXgxNXAzcmU1?=
 =?utf-8?B?M2V4N1dFcXhnRjZXZU03ZTI1V2RpSzZJMmFXUGlqclpHVUdldkxLMVdmeURr?=
 =?utf-8?Q?51uRhZRsxBtS9+3WB0R7IXNdS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22651b35-81f4-49cf-eceb-08db77817085
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:43:22.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XtWioyfUH7ElG2sw4eeX+1SduxhQWUWVOmf+rAbrXVfaqQnPPyxSg1CfPtDloBIIwBTBm+BzYLQcGcvSnekXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/23 01:14, Ryan Roberts wrote:
> With the introduction of large folios for anonymous memory, we would
> like to be able to split them when they have unmapped subpages, in order
> to free those unused pages under memory pressure. So remove the
> artificial requirement that the large folio needed to be at least
> PMD-sized.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei

> ---
>  mm/rmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index ac1d93d43f2b..3d11c5fb6090 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1567,7 +1567,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  		 * page of the folio is unmapped and at least one page
>  		 * is still mapped.
>  		 */
> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> +		if (folio_test_large(folio) && folio_test_anon(folio))
>  			if (!compound || nr < nr_pmdmapped)
>  				deferred_split_folio(folio);
>  	}
