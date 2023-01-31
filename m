Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FD68216B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAaBco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjAaBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:32:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09E303FF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675128753; x=1706664753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FC6UYu8DzaKUPQk43QcuahUlPLJGO0ly8SI/PUCYio4=;
  b=SAX9rk/sg0COPkgOm58Ghw4GnTfWaXoktgOjuh+dbSOUFokj3f1CHhEY
   aBS+gtzLNjqKMF/d0/YSbaj0nQ50mMYPkBt7bYImnyZRi4J1z0IMd6ur9
   e0uHJb8/64tdGPsUdK2UOGPCkRy0mZT7AuW4NTfagj1V8GmQPuFHQa34m
   zCD5GhH+TFDGjql5h9TPT5bTGza0rZxNfaJaHSdAfTvMpc2+ZBEIbsD1t
   5NImHjVC+AGqtdk+MYPOmiNcsV9XbPib6pmrC3QvXufYoVRxMMNztVEZC
   dKF0cJ/jyjp/9SEgnzFQU1C87mcM1nVvWja4Y9P53imYfeuKp60Xbx84s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328996571"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328996571"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 17:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="993091608"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="993091608"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2023 17:32:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 17:32:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 17:32:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 17:32:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSucWHKag4hQbty1KVuMNal3DYuvoPuFVZqXDQiU2FFCHTAKbiBOIEvhE/308yyZE73ThfiBC/wHz53UuYO4gXFCD0tTKKBz4p7/JnD6E6N+Lk3KLOk+VSnX7jOR5jbyNXST2DIW8DmeOOfG5jLoRJjKs+udE/I4sTsW71W6dPPgt9U8c0pOFbjN3VnqaVtMjEzNjKdbSyTVp933+0sjTdrZV/YfmuBP5q8VQ4DRUB6IAxcM/2EmbGWBSeszG8FGuQX+l5fndfAUu/BpqTCsK7eY/eEQIorXzm+8amh66SzfVi2UIdbdu4og1KYqe4pDyDcDwhfyOZkdRU9CSv3fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrtfqUO97h5YUXBQoLEfSjnDSOkuGywUDjhbJeXV2Gw=;
 b=jH4NdiL2QB3tOYZMhTFhcqmUFsnlCymmNBudqip9HohSPBKK/LX7B+1Zyb95SARTzKXwznRP7MsVrTbCTHP7UqNN/kXNCQ7wZ89s3fqv79G2LvEehKSX6bvEe9AesmYxYQEfyQEe+rvzB2eRS4cfGlDRgf5SKXmcNJn25oMi1hLYH+AxFpxm6DLzWRjS0hIeyEbD5QNajEk/UhB0X/smE3lwaEC6mkC+O889Hs/knVQMjDL/Er9nHpkOXoOh5HtwEL/UQ9Ke7g1yVq+Iq3uIHWz/eHP9E3yrjNUlMcuevi3SjibPGDd7QHzYNNrdpTKoC2yWCdv6KxGGVeBrrIFjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 01:32:29 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 01:32:29 +0000
Message-ID: <4a48ffda-ab14-9b4b-ddc0-504f9f9f3b27@intel.com>
Date:   Tue, 31 Jan 2023 09:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable v4 6/6] mm/mempolicy: convert
 migrate_page_add() to migrate_folio_add()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20230130201833.27042-1-vishal.moola@gmail.com>
 <20230130201833.27042-7-vishal.moola@gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230130201833.27042-7-vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cfbccf-1a0d-41db-d4d3-08db032b03e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEB79/ZlJxVTXzXMRj7Oo/v9H1Th0JiiiEk63TpKnQ9Cb5w8SFalSMhF0KfNYHgPGLGbgzUiklrMrFaOjcRZa9SSOKGHyYKTK9H8uQwrbjfYOMr7NAWL8bsd4Z/qeCAlNAN2nZJ1ShnPXgva3AfHywSwOFYv4vgI0kZVVL08eX4UxIYiP0NtrcZdTgLPDSfQSuZ3b72euBP6yjp+hj+HSwt7N/rkjCnIPsM5S2VBp7WE0imgtVE/p6wTnXwJx+O3gh+gFkWaff7BYnjanX/zNXbk/mYPf7mvfN4C1Yu2AjiOlXdWAF6WY2Yon2sAsQXzAs70WaPg5ZUuHXOUze+D9jC01m//+2Mr4jnv8fHC9MVkYzNYa1KecweHbMh87x/mWx/vqhC5jA6DPFZ2mqF4LrOaQyzNbWpxwVR8EraYL3oF0zjNkY61bZPFOw1nQpO71Psqh1qUf8JpzFpCqVlKOlteOacTMYT6c/qwcjxvsXwYP27KRHRmuYyh2QcDGwJONBjycObyErVCoJGqXT/ttZGRVk3eMnvbD2D0DUr69LKeeBP8uNMbwp8gHunEvUcQDXMJfJthNn9jLRvZH0rIkRWItWt/WjBBMC+Z3IhyeUJc5M+7vknwyl5qEC+iP1rORe0WWnpC1zOa8EN2Czvb5wz7GY3RRF416XYCrVIg6OABFR9mmw6ly8aqcvutTwybkS/t18SakTmI77H3SaKxQJyfWPGEUpLwLzqO02Mx7KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199018)(82960400001)(31696002)(38100700002)(86362001)(41300700001)(2906002)(36756003)(478600001)(6666004)(6486002)(26005)(5660300002)(316002)(4326008)(66946007)(2616005)(8676002)(8936002)(186003)(83380400001)(6512007)(66556008)(6506007)(53546011)(66476007)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJZOWs1bjV6QlliYVJrRDN1a292enhhZkE3RTlOZndMYVB3N0JUQkJwam1j?=
 =?utf-8?B?WjRxTVptRmVlVE9JY2dxdzNiNk9KaGhjUFRQZWJWL05oa3ZqTE83SWV0OEpz?=
 =?utf-8?B?UlcyU0RSLzYyTThNSXZ5dFJVcHRybFZmdXZsZzgwOXRIZTNUd1VBbXBUQjE2?=
 =?utf-8?B?SHdsY3ExOEI0eUdKcEhzaUJwNkxWckYxNW1uSkdnem0zSlNlV3JTK1NhaGFm?=
 =?utf-8?B?ZVB3VTJrNTZFa2t0VE5iQ29mMkdtYS9oeXptUHpsZ0tnY2t1aE9ySkhtanhC?=
 =?utf-8?B?YVVWTlZWSTREWVQ0dmtoM2dqWHNySEhsRzBLKyt2SFBxdXZtdUUwcWxmaWVy?=
 =?utf-8?B?TjRNVHNEMmpLanlBRFcwcjBmN1NoMlEyb1cwd2o5RWY4TVNLTThiem5kcEh3?=
 =?utf-8?B?ZTVrV1psenhCMDdzaCs5bVZGZUY1a254eEpSL1M0S0NSUG8zOHNrNTFxd1pl?=
 =?utf-8?B?V3hxU3I4cVpITlBDM3FxWkpZcU9hR2VBYUFPaVd5eFU1OEk4Mll3RXEvYjNR?=
 =?utf-8?B?TG5qUUNsMGJoZUhHdGRIMGQzVkhzRkJVYk9QSjI1Wk9aMVR3OWY3THc2OTVo?=
 =?utf-8?B?OTl2TVdVVmxhQ2JNQVdjbFAvWDJrLzFkcW1idW5IbXQySnk5MjNSMTBJYzVm?=
 =?utf-8?B?dEczNHNrN2NGM0ZUaVdocUVZUnpnTHByU3BvV2VQVzh3ZEJiU0RVdjg0a0VN?=
 =?utf-8?B?SjdwZ2crWmprSWZENkRYMUV6QWZjZzNUT01xck5XakJ5NFJIc2VEUklyOGcw?=
 =?utf-8?B?UjNWMUZ1NHlpUW9ycUNieUxSeisvcTZpWDh6bm1BZXNnd29qTlRDSWJLV3hF?=
 =?utf-8?B?ekJXSk45TmRxWFliVzN3dEdwbUtPYU5VK25ibmZrcW1kQnlUTHRxYjBJeWlT?=
 =?utf-8?B?a0ZLY3RKTzJkMHJudlJmcFUwU2JlanVpUE85bURHRDFBL2tWTFNOelY3amxi?=
 =?utf-8?B?MW9jaXJ6RW9qWlFiUUZGcXliZEcrOGVMc2VpczFJeVJIWExSUlhCQXR0Yys3?=
 =?utf-8?B?aUxNWmFXK1JxandZQ0I1dUdBQjUrYnd5UHYveEN1eW5CeWVHNTI4eFcxMjly?=
 =?utf-8?B?bDY5U1pvdmxCTmJOK0ZJQzAxYU1JSUo0SUE1Z0s5Mkp6Q1Z4TTdDWFAvMkxn?=
 =?utf-8?B?czc4WGFTUkRYU3dvMFdiWTJWQmxnQ0RZcEhPeWNXVW1aTnRLSDE3S0c4eXdH?=
 =?utf-8?B?R2RGelFOOURKZ2Jlb09qclhoTWRxUSthYUx3T1dweVZVekVtTlNmQS94RUFh?=
 =?utf-8?B?eENuWUdYR0ZUeWM2K0JjVzBTdlRBb3FaazdoTW9LRENVcUR0WGlOOVlVeXlF?=
 =?utf-8?B?c0FESmJTaGlIZUJnUlpaYVl3Q3BOK0MvdDIwcmZ1ZUhIekE5SEI5eE9idWtn?=
 =?utf-8?B?N2l0TVlFa1NBMUFEU0xWdFhqNWhTbVdUYWJ5bE5Pem9zcjh4Q0U4Zzl0Zjhr?=
 =?utf-8?B?NVJuWUhWSzJtT1lVUk80bWJCKzBBcEp4WGViUFFPamp0ZFZuNXV5K0VwYVhq?=
 =?utf-8?B?UkNvSk12V1g3dFlYMDBTcTN1NjZxT1hlNEFRK3JpS2RTSXJPL2d3aVZ6Qjh1?=
 =?utf-8?B?MllkSlIxeERaRis0SzdKQkJnaDRVS3h2OUVkMkV3RHN6YlgxSkEvdFhQZEJv?=
 =?utf-8?B?dXBFRDBsb2dvYmVxd3RJN0hRR2xjRXNQWjVhZ3cySmFOSVBtZnJqOTdGN3oy?=
 =?utf-8?B?ciswSDJwUjMyMk96WEs5and3ZGc1WisyNXhmWWFYRytQanhLZnB4TU5XT3h0?=
 =?utf-8?B?c3FTdFlJWFBKQ1A1TTRHS0ZCOU9sTm5GTU4yTlQrTng3dXZ2UGlxWGxteC9E?=
 =?utf-8?B?RUdoY2pzbjM0WURUejlCQmg5N2VJcEI2bDVmTnFZMHo5WHphYktCdUgxdTNR?=
 =?utf-8?B?RDFDa1JEeWNZUjVGSks3MUMzNXlOeGFHbDJ1ck51OWhDeUwrSXk1czVOU203?=
 =?utf-8?B?YzZJbW1mbnJSRzRqY29HYWRoc3RXTHd0ditRYzhvNjlaQWh5YUJVVXVjb0R5?=
 =?utf-8?B?RWltZ2NZeUxvMS9OVVNoMmlBN1RwTHZVdG01UHJnNEtOd25lZTZ4M0xYNmt6?=
 =?utf-8?B?cnZZNjZ3b015T0JFUERMVVJwQlJwYlhiMVd5R0svZHRYUUlUUHVjS0lOYTE5?=
 =?utf-8?B?OGUwbmpPc1RzTldtdkJUNVBGYXV6ZkdFaEErZTFib2U5SHFqT1pCMWJSZENY?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cfbccf-1a0d-41db-d4d3-08db032b03e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 01:32:29.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNm9tg9gaAVr5qTHKXrI7vzHdsbHhdsl7V1tSrPG9d5VHAtcoycSq06pCakN8AQY9F9B9BxNvbaWKkUnNULMKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 4:18 AM, Vishal Moola (Oracle) wrote:
> Replace migrate_page_add() with migrate_folio_add().  migrate_folio_add()
> does the same a migrate_page_add() but takes in a folio instead of a page.
> This removes a couple of calls to compound_head().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

Regards
Yin, Fengwei

> ---
>  mm/mempolicy.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6a68dbce3b70..0919c7a719d4 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -414,7 +414,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  	},
>  };
>  
> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags);
>  
>  struct queue_pages {
> @@ -476,7 +476,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  	/* go to folio migration */
>  	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>  		if (!vma_migratable(walk->vma) ||
> -		    migrate_page_add(&folio->page, qp->pagelist, flags)) {
> +		    migrate_folio_add(folio, qp->pagelist, flags)) {
>  			ret = 1;
>  			goto unlock;
>  		}
> @@ -544,7 +544,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>  			 * temporary off LRU pages in the range.  Still
>  			 * need migrate other LRU pages.
>  			 */
> -			if (migrate_page_add(&folio->page, qp->pagelist, flags))
> +			if (migrate_folio_add(folio, qp->pagelist, flags))
>  				has_unmovable = true;
>  		} else
>  			break;
> @@ -1021,27 +1021,28 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  }
>  
>  #ifdef CONFIG_MIGRATION
> -/*
> - * page migration, thp tail pages can be passed.
> - */
> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags)
>  {
> -	struct page *head = compound_head(page);
>  	/*
> -	 * Avoid migrating a page that is shared with others.
> +	 * We try to migrate only unshared folios. If it is shared it
> +	 * is likely not worth migrating.
> +	 *
> +	 * To check if the folio is shared, ideally we want to make sure
> +	 * every page is mapped to the same process. Doing that is very
> +	 * expensive, so check the estimated mapcount of the folio instead.
>  	 */
> -	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
> -		if (!isolate_lru_page(head)) {
> -			list_add_tail(&head->lru, pagelist);
> -			mod_node_page_state(page_pgdat(head),
> -				NR_ISOLATED_ANON + page_is_file_lru(head),
> -				thp_nr_pages(head));
> +	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
> +		if (!folio_isolate_lru(folio)) {
> +			list_add_tail(&folio->lru, foliolist);
> +			node_stat_mod_folio(folio,
> +				NR_ISOLATED_ANON + folio_is_file_lru(folio),
> +				folio_nr_pages(folio));
>  		} else if (flags & MPOL_MF_STRICT) {
>  			/*
> -			 * Non-movable page may reach here.  And, there may be
> -			 * temporary off LRU pages or non-LRU movable pages.
> -			 * Treat them as unmovable pages since they can't be
> +			 * Non-movable folio may reach here.  And, there may be
> +			 * temporary off LRU folios or non-LRU movable folios.
> +			 * Treat them as unmovable folios since they can't be
>  			 * isolated, so they can't be moved at the moment.  It
>  			 * should return -EIO for this case too.
>  			 */
> @@ -1235,7 +1236,7 @@ static struct page *new_page(struct page *page, unsigned long start)
>  }
>  #else
>  
> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags)
>  {
>  	return -EIO;
