Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85D62CD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiKPWDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:03:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3548A5F86F;
        Wed, 16 Nov 2022 14:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668636191; x=1700172191;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iOYaIhnQqEyR2w4WUcBU6dYYcXSBhzu7YgBYbO+UrSg=;
  b=hjI3EE+fu4xaN1GyvagD+WXHWjybWCj6xlgMayKZSqZwj+RzXzsE/W0M
   cyP42S0kg6bdKqTMkND8SJNbpu9nCVCdoBZEBla8JFdeZRdIuivByMEDz
   Sz10sqWgkPi3H9BzTFURBEi+3NX1cXpNwFUiZmrO4HUafr6CnDHtE+fJ4
   6RHLveBcfYZIZolVc+xTTmVbnqjNnPEaQr1AHedm460VVh90CY04vsrpI
   JMeiO4wEP9QFPKAbYZ+qYCbd5yO12e7h7FYTt0xBOtH4QNLQrBSjTJdXO
   XLwtrO5ulHYIsBSiojxjKoji5sOPx00OrTxIP8jl26cMXpPX5UGgU68GF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="398966386"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="398966386"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884582875"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="884582875"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 14:03:10 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:03:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 14:03:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 14:03:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COnjFqPAAJIDa//2crbUwNAEmLr3ivcjD0xXSXV8W14iqrlkGCAd4MPUtByck5p49GGNk4W1B20JM2+QpmDHr+2RY2cRRsHcw7Kx/chQuKtHzaHBFltc4ZM1OHBGM4YonEzoBMMXqT2+RiL1fgwy7gg92OUIWtgwavN3KS9NjSdeXXLlRtNzxVK3sPy2tXfBt8D6OjXT9LtmlpPw5BKKuqIIpfeYc4zuJUC1dYIrrAfPfaBWF7luKbuHymqELOUGKq/N/TYhfZ1eOURcxMaFG0j9g0Fb9SkzmwLWu2k6zPQ+Qwe0yMUO+AYPzsxqGk43wB2SgUibumErWy/B/aNy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjqRKEiiKoBHuGwzd17w1n+qkjgYnVAHP2SgsikwYts=;
 b=IqMh2auRYTsYPHLC2TAWi8II7qgyhOm4T5AbwMChr4NATE/tlzncQdXxB055Oeu3mXAjKCQkPx8+pnqHSUTVAYFFXw2owtbz1V1yWs9TitaXdA7t+dkVyb1BDOw+GW9N/2XSwJs6G6uqnxvG6wUDuKvoY9+eatl0Dnvn7goFv0NDayspq8MmxiMuznxfMKd6HE1J6rDwUwv1M582z1qD6b/GymoAH4cckd+n7J1py3QZeFgU4JIXDHgFa8l38e8POT5HOcn1SYNfl6s1W9/KI4DR8yR4IPdX9Q07R4qSBtwKu7VATFnFFbydSuQ9FNGsouhg0cVRcfRavfuQEqeJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5551.namprd11.prod.outlook.com (2603:10b6:5:392::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 22:03:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 22:03:05 +0000
Date:   Wed, 16 Nov 2022 14:03:00 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
CC:     <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-sgx@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y3VeFLAYdIDZCRxO@iweiny-mobl>
References: <20221115161627.4169428-1-kristen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115161627.4169428-1-kristen@linux.intel.com>
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 6548f79e-b6c8-4402-e84e-08dac81e5682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osagzLN/cJnhGsy8RGsyxyskHyLAGvScETMxo9KZsxWFfeHz48h/lrPtKcr9yByBR5cLirrepzNLWlCXkPz6u7XZLvd931cUU5wZ47x42MrkH76yYSI/RRUrfCWytEFeC42lF9AFDm3RSGxx8tg2Lx1pkJtUv388TWAFDKRhoXbzHekeHhiotGC15aZDEe34s49KkRv/Ce4QvKDiMkb1UGbkdts344rpq2d6CKRJpqV7sxGBDN3cOS+ku+EmC8T/k5kTjjRy8ygF9nKp3RfgLMkV4+Q3Owf4v9H8FN6PMbzLUEGNbxeVDB41L2yWNxCSpITo+CxOfSDKJJnZZQIkp2ZuiooNs9yDICbZZZJzQK99LX+7FM0p1YKNIfRPxRKbCr3OrLGHRRwd+x1bgHIfpFYc3mas60WB8mCVRGdIJ5hNIJV530hZyhIJD/OmjE9LBLHW8w0zMGCm3gZqgYfR/bRhT2rLp/1zoSGsqaV9CFeLQCupfa+pnl3OidlOZlvC/2OKimM6Ky+07bGuTbCBnLBxt7CButWaylPTeq8UZHye0FcH0C3ew+Rjz/6xGbEh3JB226mNBJuQWejKhFqQk1/1ZZn0IMQE4jBoD66LjRo7R13sq3tMLiaNtDfPERccx+lEUPdKksjn7+YByfAHy6jvRvBN+GaR7O1euC5B3dFi9w+UtmeVIaqV321g4SY3sOpOwJ+3p2TUKOFS+1Cf5+hWoOPd15R7j35HZcLlgV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(38100700002)(2906002)(7416002)(8936002)(5660300002)(44832011)(8676002)(66556008)(66476007)(41300700001)(66946007)(83380400001)(6512007)(186003)(6666004)(966005)(6506007)(9686003)(33716001)(86362001)(54906003)(4326008)(6916009)(478600001)(316002)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9o8vMmCuEoa2dHYh5L6dxJYCB0AlqxKRWZxZvyNstDMgbKl5+lIN4+wk51aS?=
 =?us-ascii?Q?X9y06aREfim2tvFXJBI1aOGBrNk14BgOhU4tInHDKVbQOY+6CXVfaj8jktpZ?=
 =?us-ascii?Q?ZQmrk9bS1hdsygeXKZPbpRe6WQv3HyRACynN8xRTHU3OPiMs4GYnXEnMkfGk?=
 =?us-ascii?Q?nK37+uG8FPpIrZm3EuOUbY/cp08sEG1oTbWf6hzNTsKAYwowCI83vWZ69wUC?=
 =?us-ascii?Q?cntTxLKVeoxy9uY3FzmqdcnFviDD2uBSGjQygH+K0TCqEkLV6ldqFKiLcYgj?=
 =?us-ascii?Q?IiCinGNIlevqyJ1HSHXlKrSue0verF8NAzt0MKZZYvn36xM0+RMkLxu/3n5/?=
 =?us-ascii?Q?mTIRjuIaq7fKaQm4cD6bzDr3c26yUHcZ2i9HZn5yLVW7i4AQr9BUsVphPlM/?=
 =?us-ascii?Q?eQnMz38go+7DWhO4KZAvkyM7lV6gId+NfdYpa+TLk7B8/d2dD9wURIUP76Ll?=
 =?us-ascii?Q?E7yhT+njmKjkHFuJquuozqspAuC4CzjfBEjYp8jZ41wqR6s5Pccs4MO65MsR?=
 =?us-ascii?Q?TXpjZOL68h8NRrVent3OZtXQNYjZF6vk6rSsr2x+IEWOOg6N5dFscXZnytWi?=
 =?us-ascii?Q?YqjQ3+VAMJvCwaYfjUj7mHxMKRQOzJSxslNL+gQXLRMKMwoylKQi7nRQfckJ?=
 =?us-ascii?Q?kf95ixds0Ie2LEOrXcJFhdlak25mGjfbV7ojEK3jtbZqE7T5KxyW7YlBZlU9?=
 =?us-ascii?Q?yt1T8DimzI5Gm7SxjixKIfneAJXFp10CUDTKeU2sW6T7gPQUcQvySSChYb+9?=
 =?us-ascii?Q?KV/mBa1j7UbExidGt5wDg5JuiELmqBt/nvTeuXvnSPyFBnot843N2qsZ36+k?=
 =?us-ascii?Q?8bjPPnCmBUifG4uoD2gbVAvGOzPqHnMDU4E26TbpDcilYJHwlodBCi/SuTox?=
 =?us-ascii?Q?grwAtKMqsl8Yx1kxGW34mbN62fZSTWARzOGxd8wwah8FsqQUZTHE+vqhIU69?=
 =?us-ascii?Q?Fes5ZA9InT6hgt3pPCQDjpCO6t2OuEeNPuF03rGx4N0wfUsRCAadZjm85frF?=
 =?us-ascii?Q?SUmLaMOQVDQe7DjNMuFcmyGmXCC1+wXkXiBvPlG/e619FYkphaqVRZ3aqWYJ?=
 =?us-ascii?Q?bADhm9QTlogi8WUtQQ+26DFtokvu6ehbU9CRgxnwS/6uMuOuQH+0HaaPzE3/?=
 =?us-ascii?Q?qnsazsYic55tKe1lRbRt3dXUJrO8N8MHdf+IdKB4Bp2EgKQpN1tq3B00RCNd?=
 =?us-ascii?Q?EuzlV8JAA40VbehJSIjAENiGurG0EUrHmwM7SeaEddbaY4qomnM6EJXHkJwF?=
 =?us-ascii?Q?wSEm6ciQEl0er9sXs8/PR0Ux9HNZVJDJefPWKaTdsbEIKWUhSXZOZZMBWFYJ?=
 =?us-ascii?Q?q3Pmg8QeOV184ZiY95oNVimhiz/mowLoXJad6wTbb0Oj9XfDMbXi7k32Nkv2?=
 =?us-ascii?Q?gzFxWFLx0JVkdWQ84xBuWH9BLab2o9Y1+8d5FUoZg5PDNZfyGif6+UPKAEl+?=
 =?us-ascii?Q?XLNyl0JUsRQsbVztRSrxKN2IOmlPlH3hbRc3TbgxRfylrxaITfjeIGPM1JRW?=
 =?us-ascii?Q?JO8CDNQQpwOfMcqTmMNLBw9lViBR8vFCXqd43xf0/HmlZPmfB1yNP/kFxBc7?=
 =?us-ascii?Q?NIdxOkcBNoZBIXrFxri6vBu1sIK7v1pldLhLIewtiLJ0EcjeB7HSzhEk+rXf?=
 =?us-ascii?Q?5VpzESPvrrYszLD+YRXOnaOiToShXdzYdrvnk81PmijM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6548f79e-b6c8-4402-e84e-08dac81e5682
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 22:03:05.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3I0FqpkL+TLP3CDRTktcqL11nvxbLcW5AdRUiHbMBIXS/LPH7er/npPbaE5YD+Q0DdJmAZK4fkDQPRQWTslZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:16:26AM -0800, Kristen Carlson Accardi wrote:
> kmap_local_page() is the preferred way to create temporary mappings
> when it is feasible, because the mappings are thread-local and
> CPU-local. kmap_local_page() uses per-task maps rather than per-CPU
> maps. This in effect removes the need to preemption in the
> local CPU while kmap is active, and thus vastly reduces overall
> system latency. It is also valid to take pagefaults.
> 
> The use of kmap_atomic() in the SGX code was not an explicit design
> choice to disable page faults or preemption, and there is no compelling
> design reason to using kmap_atomic() vs. kmap_local_page().
> 
> Link: https://lore.kernel.org/linux-sgx/Y0biN3%2FJsZMa0yUr@kernel.org/
> 
> For more information on the use of kmap_local_page() vs.
> kmap_atomic(), please see Documentation/mm/highmem.rst
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
> Changes since V1:
> 
> - Reword commit message to make it more clear why it is preferred
>   to use kmap_local_page() vs. kmap_atomic().
> 
>  arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
>  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
>  arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 2c258255a629..68f8b18d2278 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  		return ret;
>  
>  	pginfo.addr = encl_page->desc & PAGE_MASK;
> -	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
> -	pcmd_page = kmap_atomic(b.pcmd);
> +	pginfo.contents = (unsigned long)kmap_local_page(b.contents);
> +	pcmd_page = kmap_local_page(b.pcmd);
>  	pginfo.metadata = (unsigned long)pcmd_page + b.pcmd_offset;
>  
>  	if (secs_page)
> @@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	 */
>  	pcmd_page_empty = !memchr_inv(pcmd_page, 0, PAGE_SIZE);
>  
> -	kunmap_atomic(pcmd_page);
> -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +	kunmap_local(pcmd_page);
> +	kunmap_local((void *)(unsigned long)pginfo.contents);
>  
>  	get_page(b.pcmd);
>  	sgx_encl_put_backing(&b);
> @@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  
>  	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
>  		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
> -		pcmd_page = kmap_atomic(b.pcmd);
> +		pcmd_page = kmap_local_page(b.pcmd);
>  		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
>  			pr_warn("PCMD page not empty after truncate.\n");
> -		kunmap_atomic(pcmd_page);
> +		kunmap_local(pcmd_page);
>  	}
>  
>  	put_page(b.pcmd);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index ef874828fa6b..03c50f11ad75 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
>  	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
>  	pginfo.addr = encl_page->desc & PAGE_MASK;
>  	pginfo.metadata = (unsigned long)secinfo;
> -	pginfo.contents = (unsigned long)kmap_atomic(src_page);
> +	pginfo.contents = (unsigned long)kmap_local_page(src_page);
>  
>  	ret = __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
>  
> -	kunmap_atomic((void *)pginfo.contents);
> +	kunmap_local((void *)pginfo.contents);
>  	put_page(src_page);
>  
>  	return ret ? -EIO : 0;
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 0aad028f04d4..e5a37b6e9aa5 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -165,17 +165,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
>  	pginfo.addr = 0;
>  	pginfo.secs = 0;
>  
> -	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
> -	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
> +	pginfo.contents = (unsigned long)kmap_local_page(backing->contents);
> +	pginfo.metadata = (unsigned long)kmap_local_page(backing->pcmd) +
>  			  backing->pcmd_offset;
>  
>  	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
>  	set_page_dirty(backing->pcmd);
>  	set_page_dirty(backing->contents);
>  
> -	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
> +	kunmap_local((void *)(unsigned long)(pginfo.metadata -
>  					      backing->pcmd_offset));

NIT: Technically you don't have to pass the pointer to the beginning of the
page here but this works fine.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +	kunmap_local((void *)(unsigned long)pginfo.contents);
>  
>  	return ret;
>  }
> -- 
> 2.38.1
> 
