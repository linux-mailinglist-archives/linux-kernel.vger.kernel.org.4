Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0266C621F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKHW7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKHW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:59:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5A222AC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667948358; x=1699484358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Zf2pe2okogzE+iBiXB0rX+VG7MottN1gAKee+8FZK8=;
  b=istzhszIqu7sVqnRbcV73BT9beNqOR20lVG+dlUvqYzler0hNRSPQNQK
   RymDMrY98IxsUZWPkDqIFdzGrNJ9ZzIFLJWXraxFmvXoZA19LGmXqCV8B
   MdLM7rNyuYyuE+iYNg9KvoSQvel9VNf9zicAfrb7u6pBBc+8Ljsp4r8cK
   MZGvbK5HlD6qsPLNhxDEW8WgA+wOp9BeyzeTnL1j3FnBVV6uOFcEbwN78
   JbEeiaw4o0ajDZcftikZCEiYNqCsnwbMsoItvc8sU7lHj4vJXPz8q2T+k
   N4en4LXHgL5wzuQCV4vsLf2T2NIYfqX2k22A6DG/TujD6X+2FBXUO0YMc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="308450774"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="308450774"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700109525"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="700109525"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 14:59:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 14:59:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 14:59:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 14:59:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCozsFgprT5qJX1izCfs5Rw+n1fyDt6zPBqw2IVzMFeBOLB/9Ph5E3gHMciRpWACYAT65pgrW+Utup9rHne8pdi5p0AYIWo4q2xJ2rHLSfrnPESxAdWJyzsG3DEVnwK5AZt+BgYX46u2zPXMNQZznzive5qPhtT2ekJVAIqYMtu21Tufg/jdcaPDbU5cvjSOhwLbmTM6u+fyS8YERuOrY7CBt0vItkC1Qq1xbVzqNsL8uPuq+LoH5gk7YmzvSEtaPA3Dj/bJsN43ubdjJx6OrdTsC6VtUTCX3cG1P+QsV1CEIT8GeREkFju+o4S0+lUk/zD+mzLmvfQfC0f9+gb65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OK/YJHN/QkvDCjTR243AlTvYMhvYzcdvyEf6tOp0VQ=;
 b=E1gboKvWBroFeEtmvGQf4RVuo3si93kuWUp5qJ8k4jIh2DasvKSL0zbhNe9lfY67XuxCE56zO8GFplUDP0GQs5aRU8hO117bUXUUWUfp3kKi9c3Sch/xij86QLHrpS1pbKK8ONwiPvJ1f4O8VVGWhRmm1WTjnJygnyCwyIA1mXadMbdc0nZ6CvyQnnirIMgFMn0WOZOKz87q6JsVqLAZEnnwxrDORgOW6JNMbt4Y4QdbVjqc7sQPw421W9aqH41AkvydLnThWLbzNJ/etvAoqYfcjR0CpUkCodeP07Fk3uTpHLbACJCqd71Aw3Y4YS64RXo8a7dXFa7oDd05OWVo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CO1PR11MB4803.namprd11.prod.outlook.com (2603:10b6:303:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 22:59:15 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 22:59:15 +0000
Message-ID: <542c4313-3833-bcae-10ae-005084d96ea1@intel.com>
Date:   Tue, 8 Nov 2022 14:59:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] x86/resctrl: Move MSR defines into msr-index.h
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Fenghua Yu <fenghua.yu@intel.com>,
        "Babu Moger" <Babu.Moger@amd.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20221106212923.20699-1-bp@alien8.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221106212923.20699-1-bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CO1PR11MB4803:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d6b76b-7e7e-400d-394f-08dac1dcdc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cO6f85QlxMt4mW1UXc/HJ1xfMmtKxvx5njcXMNQIlPPkifatXjMhxLHuH/qMTrP/66ffgIGacYLzhV/dh14sFYNTloCbjKch/OdiR/w6kLQaG1ySmHuhjYzjd3ha+M2jPlvYde8WsMFRzhimyXs1nrviv28zAZAf2ghIHmwjq8FwgpH8z+lddFZfeRL8/nZk710StVPPUU+Vcm3swdgvG7wIJIZQ1Nw4k5PvKrDngUnSZrjKAcZgMJZpGp9G6CG6YVsO3/Ru5E+3yy4Fu7cuq9GzQ7XEUWyz64Gue75VoaW0+URqNDUX+TYAx6cj3QrHNyetb8O4FAtw0CyzkN1T9eIj7uL0R8uBIpbhLeiHq5u6v98n5K3uve3VlxVVf/CBqARVQehqzuCJGWBp+FQtCD7WgiGdQhs72KK1xtY4srC1YKf7UAMk06GpuLRIoCGXuoZEVDK7XsLRBwKxvRzYG3tq25JZEHaes4qylmiGgjUJMhT4eQ/FMewEKDDwe9rcoEF16QcQLGQ1d7mfL5Ulf1SicQfxKGfHrwiqT4McBiCKLjcTDdj6N72TZ9APepRmipzCWLfvoRPSpEoNsRvZmzqCe3Ji8YsVGDGMdojUvVzDWAJBrokJmJloHYfx3vWW6ZpdOD/mvb6+fvy74wd0sNclQWDYmbwiDUKinIACORIgazslXk6xfseg4rQjlh6sB24rg7QF44QIFdTaEO8Euc4HEFvTW6/DQv2rnI6H5Eec00K4uLRV4DEdxyOvcLNe8TjJMq1g67DT0IBMpHIkscE9+o1Clbq/+XIHZvknFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(31696002)(86362001)(66476007)(66899015)(316002)(66946007)(66556008)(54906003)(110136005)(8936002)(41300700001)(5660300002)(2616005)(186003)(2906002)(6486002)(478600001)(44832011)(6512007)(38100700002)(6506007)(26005)(36756003)(31686004)(4326008)(8676002)(53546011)(83380400001)(6666004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andTTysxSVNsM1lJeXFZVDJUOEJTTU9mMnI0NXdaQWZONjRtV29FSWo2NlFy?=
 =?utf-8?B?Vk5uN0toTXV1SllqbFRzSzQ3bzVxcUlWajdzc21PY1AyUWh4akpSamRlOE14?=
 =?utf-8?B?bXU3MVJmVW1QcndtMUJFSjBiQ2hGcThjSEZGakRJdXA0U1pxdXRHTDJvMXRB?=
 =?utf-8?B?NGc4Q3BqWFhIZFJHQmNhUFJhS3E1TjVSekJkMUJ4S1A2RHBmUXRpcEZzbnZH?=
 =?utf-8?B?U000ZEpZZFoyMmlxQjhwTEVpNGhOeFdKWGtDcXY0SEtNZm1ROHlQaGxKcFgv?=
 =?utf-8?B?QmNrL3dPSnd3ejZiSXE3dVBCYklsampYWGZJdkNUa2o2am5TeVNmMkl0aWJn?=
 =?utf-8?B?dGduT3FRZEtXM3dZYUZUL25Wa0d6MTNUM0lpTXJOTzhrSjJEaVp1VTc4K2Jq?=
 =?utf-8?B?cTkvVkVmcUFjcS9tVjdudXdIckN4VnUzZ3NrTk9VS2t0eGpka3BaV21VV3c2?=
 =?utf-8?B?NklaQkJZcm9aS1BmNkxKOFhZTXhVYmhOdkJzZThaekp5U2xndzc4TEl5VU9p?=
 =?utf-8?B?K0NGdkI1M21QU0VqdE1GYlpLQlpCZFVPYjdpNkZGalFHL3VEOG40U1Fxc2p6?=
 =?utf-8?B?WGtBR3lFTWNlaFRmRDVkZ2lCOVc2NzBON3IydGdHc3JzQmY2ck9rSXgrNnc5?=
 =?utf-8?B?TWxyT1F5ZmlHUkt4ZnBLT0VEblVQeWQ2MHpsd2NaNGJKTlE4UEtPem8vS3N4?=
 =?utf-8?B?NW5iTGVlaWdNZGFGc1hxU2tEL1NWbjF4cEoyWDRDQkJ3Q0VkcTdkWlhzbm44?=
 =?utf-8?B?Q1lqUXl5RGF5QzFqa2xZNXc1R3BITlJwc2RLc3M0S21YaXNOQWZXRkN1VDNp?=
 =?utf-8?B?dXp2aDh3dEtPeE9PMDNqOXhVaWxMaE5CZTUyYlo2cjJGaThuMDBYamdadmJE?=
 =?utf-8?B?aURlalZNTUdHYlBwblRuRkMvWS9ZUWlIV0NPdVhOSTE4NHpvRjlFcVZQb0ZB?=
 =?utf-8?B?QjZ6MkdCRnJoZ3plM2tvWmJOSUtYRWFBek1zbGZZWkhNN2Z0TVludXpKUGJ2?=
 =?utf-8?B?b3NXQW52cVlRZm1rVzhBUFJVOEc2L3RZZGZCQWNyeVhEc1E5UUE3NkNNVGVK?=
 =?utf-8?B?NDA2RzVZdjIrV01NVjFIMXVrN2RFd0tlTTc2N2JHQVpUV1FiR3plSXZFYWll?=
 =?utf-8?B?N3NDMW1lT2xucTZCSjBOUlVhV0JadEJqUU1yYmhsNkFseVF0dEJMNS9aa0kz?=
 =?utf-8?B?cnhLWGk5d0NLYmdIN0Z3eXpqdWlsUGM0Qjhrbjl6Rm1tWWltVDJ0aDM1MG5M?=
 =?utf-8?B?VGs4WVBRdUd5MnYrMncreWxXQzVQSStmSVdTYjNJbTVYdXhqWGlLZTBpa1Vm?=
 =?utf-8?B?SVJpblM0RTcvZXp5WG5LS2l4K0ZqaUllamVOUnBJQzBzMkIrOEVYM0FVUEMy?=
 =?utf-8?B?WHYwUkloNUNLY3M5K0JoL0lXTVJSdDM4MldLWFZJNlhUd2tQaDZHSGpWK2hO?=
 =?utf-8?B?c2s0ZGVZRU1ueFc4SVZWZS9CYTZGUUl2VGs3elVKWVNnZlByK0FFLyt3dWdR?=
 =?utf-8?B?OEcweW5UMU9TZW5pWm1SazN3cU9jdFZ3d2VHTk1sSml6dFlqY3Bqd2VIeHZu?=
 =?utf-8?B?T0diT0hWV05uVEJEL2JEdlVKUWhWV2RFaVJUNmxqY3FPK0pDSDhNeGdycnVo?=
 =?utf-8?B?NzNENnltOUMrN2VSV1dEZHRJY3l2TWlYd0hSckZMMmtzM1FyUS9BS2kvbDZa?=
 =?utf-8?B?bXpsd05sYk5TN0lTQzFGT3h3NWpOOWFuaUdLanNmOXphMUxNeHg0aUxDUWNW?=
 =?utf-8?B?c0FJMTJ5bmNhOUEvdkpRbDlvdkcwbllsemV4QlJqcHpDUm8vOW5PWm1yOUYx?=
 =?utf-8?B?aVZoUitjb210dis1eUNPTkxIalp3S29NYkRpWE5lRVM3bndzSkM4dHg0akRC?=
 =?utf-8?B?UUlGaVZJZUZqQ25tendNQi84WFdiaXdwNFU3QXpnYS9TclRDY2RlQmFiUVV2?=
 =?utf-8?B?YTg1eG9TU3lLS0hjSGc2T2pPYmF3Q21uNVdyQ2Z6aFdpaFdNYWE2QVcrTllO?=
 =?utf-8?B?Mmx5bTIvR1o0cm16NGY3WGNGU3AycDFHdEo3S3RUUWJZWjNSU2xtQzViWG9n?=
 =?utf-8?B?OWg1Qlh0RFYzUTJzWWROaFdRaGtmYVorcFU5RGxNbUgyY3dta2JSREpFNWZJ?=
 =?utf-8?B?SlhuWGJRaFJkTmYxZmZCaFlxNTliMWlIdjFDdHJNZ3U2NUdWL0JRMDEycDJi?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d6b76b-7e7e-400d-394f-08dac1dcdc10
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 22:59:15.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zaqSuIyBIuEVXztTGlR3iMeOKxxwYjm70UES264apejWkIPkC7iokO3RJcaH88R0tloHbh5RL6ajORO6O5AJWg6LaO6HlnU8HxbfhuKGaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 11/6/2022 1:29 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> msr-index.h should contain all MSRs for easier grepping for MSR numbers
> when dealing with unchecked MSR access warnings, for example.
> 
> Move the resctrl ones. Prefix IA32_PQR_ASSOC with "MSR_" while at it.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/msr-index.h          | 22 ++++++++++++++++------
>  arch/x86/include/asm/resctrl.h            |  8 +++-----
>  arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 10 +---------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
>  5 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index a3eb4d3e70b8..c29cf6d1935b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -4,12 +4,7 @@
>  
>  #include <linux/bits.h>
>  
> -/*
> - * CPU model specific register (MSR) numbers.
> - *
> - * Do not add new entries to this file unless the definitions are shared
> - * between multiple compilation units.
> - */
> +/* CPU model specific register (MSR) numbers. */
>  

Not an objection, just an observation: the above is a significant
change for a patch with the x86/resctrl prefix.

>  /* x86-64 specific MSRs */
>  #define MSR_EFER		0xc0000080 /* extended feature register */
> @@ -1051,6 +1046,21 @@
>  #define VMX_BASIC_MEM_TYPE_WB	6LLU
>  #define VMX_BASIC_INOUT		0x0040000000000000LLU
>  
> +/* Resctrl MSRs: */
> +/* - Intel: */
> +#define MSR_IA32_L3_QOS_CFG		0xc81
> +#define MSR_IA32_L2_QOS_CFG		0xc82
> +#define MSR_IA32_QM_EVTSEL		0xc8d
> +#define MSR_IA32_QM_CTR			0xc8e
> +#define MSR_IA32_PQR_ASSOC		0xc8f
> +#define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_IA32_L2_CBM_BASE		0xd10
> +#define MSR_IA32_MBA_THRTL_BASE		0xd50
> +
> +
> +/* - AMD: */
> +#define MSR_IA32_MBA_BW_BASE		0xc0000200
> +

Is it important to distinguish between Intel and AMD?
All but one (MSR_IA32_MBA_THRTL_BASE) of the register values
under the "Intel" heading are also used by AMD.

(sidenote: multiple blank lines above)

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5f7128686cfd..4f43da46243d 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -8,15 +8,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
>  
> -#define MSR_IA32_L3_QOS_CFG		0xc81
> -#define MSR_IA32_L2_QOS_CFG		0xc82
> -#define MSR_IA32_L3_CBM_BASE		0xc90
> -#define MSR_IA32_L2_CBM_BASE		0xd10
> -#define MSR_IA32_MBA_THRTL_BASE		0xd50
> -#define MSR_IA32_MBA_BW_BASE		0xc0000200
> -
> -#define MSR_IA32_QM_CTR			0x0c8e
> -#define MSR_IA32_QM_EVTSEL		0x0c8d
> +
>  
>  #define L3_QOS_CDP_ENABLE		0x01ULL

This new empty line results in a multiple blank lines
warning in this area.
  
Reinette
