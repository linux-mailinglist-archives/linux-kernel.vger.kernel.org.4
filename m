Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3061EF9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiKGJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKGJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:52:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B925140D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667814749; x=1699350749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qcal6tRp/9EsOg2MewPydhz9ac9Cc7niG7OfaHOGBYM=;
  b=OYnJWc3wGqQ/ZZY+BrVtpaemW0/EUWgEZ2NKch7RUz6FbRnYHHL1S+nR
   5b7OYsDB6pDZXEx5H2cxh94ZvXkbld8crHVA90253ibsvXFD3F7iwGOKs
   TPc6Xh9EvzZPoXj+5HO3/tGgfyIReyRnsBzNMhxVI8vjOEXpjC+eaQA7q
   d++wnWs47qMjSPD/Ry1DYEN98DbDDJ2oBI8N7cPJnGqS80LM4MIc6LXPd
   +oretUXyMQiUXajdlOIgt9vKvbcxlhpmoeNZ0W9n4uq8TekpA9vReewBT
   PNjUTJqANrBYSPxgowhVVTawx0TmyZWm0VyW5cJlwfojQQ+kjztJZTSmM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="312137230"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="312137230"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 01:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="667115215"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="667115215"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 01:52:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 01:52:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 01:52:28 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 01:52:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXD/9tXwsovTr4KC6XejLGoZ7GbtyvJwL/j/6aBEVGlzv+XG9E6KFZkbzH5JluBIO5F+SoMIkjmG4hR4s3lT5wDa2OZbU9AvmHxor9xaV95EYs+4QgrZTQZZikKJweJ6dM0B9OvPs2uwa7f3YBhi5MA1/+fdkWHaH0aSO4rnMbbtDtHeo6T36KsyOlKRG8qKXysWsnq7SR8swujLAY5lqaj2UgaDWXFAP7bjmdP84enEygISIRqWvNRqBNdovvJGVpOxf+j9CTj6io9wzUVhWomKuNkEiaY7LWQRY3uytZrtzjKuFuLolJC8b8jEUyu5yq52eVKSejRojMEy4UgHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXxSZLLmxnqI9IS/qXklJHndPi0IRCr0RNBCKx+RItc=;
 b=ZGI3hbWqPHyn+M5C8p4Z26FasWHAfoT8AuuwKRMTp0LYIF10UsfsE787mypXkVU2Q7b/8VdIEnTDtR/EndNjNIszgtjsv8x3fUFfCxP70f4v0e5+2a2fZnRy/A6vdvcOP5ez7gcewCUda8KG6O3siIGVChqSpQ2q7iMe8zPEWOSapp3cmu6/mdSPthwA3hrpbci4CuC4GqIYVeV0Cl6tJKYioUve7jI91pgluScyaddX15fRePGILFEmN2nqYqo7RIMpojQyD7VP69ARPhSYvHFXpQpVnpakGvKwcH/Od5MLDTS++hfax4mOMQgwnEvT3ji7ZD77gTyyJify58mZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 09:52:27 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9%2]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 09:52:27 +0000
Date:   Mon, 7 Nov 2022 18:01:44 +0800
From:   Fei Li <fei1.li@intel.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <peterz@infradead.org>
CC:     <dave.hansen@intel.com>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <Yu1.Wang@intel.com>, <conghui.chen@intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Message-ID: <Y2jXiHMtR+4jDB1n@louislifei-OptiPlex-7090>
References: <20221101053019.174948-1-fei1.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221101053019.174948-1-fei1.li@intel.com>
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|CY8PR11MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d86da0-8ab3-458d-3074-08dac0a5c741
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L20rZWH6jzi5qc51Ou61EUgdV4spcv1pzxaIxxTV5K4DALFt6YKbCX41cAOp4+VBVaQ23aUYY+RcB9GSi65PEQFlI6nr3YOC4Ul3A9eyv1OygLI0PYcG0Nk1qe1fDP5Xa6/pWkJ5P6NVL+O+RvOnQgRNV+sF3EwylwdRHjEsoZ/lWnOqUzKgm5EmHTju9iRmu2dn5bkdAyMYSWnTRhiwpsASdDGPo7jQV6LQKYDZQU7HjN2j3ACFREI5pQtpzK5Uaj8H5X6Tewg5CQ8E05eR8ExloWDdj0myCcPCsWQHKNYYaoQexPkbp1FNPAi0oXQmBbX0ihnEHIYGXinshQ7xp7p+mKDMQyJA2CY/+mIgKOS8pEAuIKNhooHGjD3JRi+IJTyafWwcvW1p1Swshq3/ALbYddKMezIbiNTIuk4cDmqSYNPo+huOyn4grXr/IDKDPATOQvRROut0pYVpdqdSXqKgrdG9SSJS+03UDWhUy0HqQJ9Y+0gYin8nviHzdTUQX/3eXf2uozIOLPXjUYFt8337ZiZpCkr3KrkXN9zqbFG6MW3XCHCT1YGNEYz33Ewm5VVd0t14dfs9XNZ9P1h+nXasWpP1QtL7ExQFddeH3irAiwyiTZvANuCi7hAnoFjFdPcwSbIFNl3KQQPPdHMDH65pbcAEG461a6t8wkqBftCNbCEpaxgh5CkYc1j/H8ZyEMg5bzhoUFtpHVsYANEgUYb0iriId3gjMHOhZdQ2l3TgdP90Q5GFTCX3/5wc4sdH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(86362001)(82960400001)(2906002)(5660300002)(6512007)(9686003)(26005)(83380400001)(186003)(38100700002)(53546011)(6506007)(8676002)(4326008)(66556008)(8936002)(41300700001)(66476007)(66946007)(316002)(33716001)(478600001)(6486002)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Fa+24RHERvUa9cTfF/HQqokswVOdmsLDiIkULh+QVhT0+ak4aTL5D7jzw/D?=
 =?us-ascii?Q?+fLHeNisWrBa/DBuFMz0/NzR1edPOk1gvu8Bwh7yBBaQQKC66exAqmNHc42t?=
 =?us-ascii?Q?MOKZCQBq2RTIwI797c6WGjPtOl0JjZunPslQOowfnLRBjs4EPCjmptDaxNK+?=
 =?us-ascii?Q?um0Fjx6ktA0a0RO3rjeUa6fasIXFJuS/5mJVAledCjNU5WI6o97g/b5OKFDu?=
 =?us-ascii?Q?QSAqoyUX3fFgYV/sGtnnraHkKfHaEPLaGPLD8770+O/f5NeqT3mE1EBZzXTk?=
 =?us-ascii?Q?nCP1b2gffBLabVrxXgQop+Gu0odNviKvi83E+06l0/AkCVuCiq6qIqxK2GHB?=
 =?us-ascii?Q?kyVZoLpJscbbQfU6hNSAuPWDrASGnars7x1yEER4JL+FxMXQYYAgzmhaNeAC?=
 =?us-ascii?Q?wMgXEaGYei/PMXwKzT0VTIb1CWxQmgtx7nh6ko87LxuXD+M8Oby93mMOg9Tw?=
 =?us-ascii?Q?x7EGMo6b0yrc0VQ06AWliis5WDc9OiPh6TdXRGSwpCu2x84dX+Cm5RybPToj?=
 =?us-ascii?Q?ibxGky4Q6+LLMRYmY+bx8Wqh/RcTJk1H2ThjWN1pBJpeh9wRsJzrEDdBtMb+?=
 =?us-ascii?Q?etAjkl2X4raX7po6cpD6Rady+XMue79E3hjHVT/weWp5Z6NxzjDSBkpp3YPc?=
 =?us-ascii?Q?IpbnYa/UrAs71sE7bQXGRzZ8PxDF3SYCEVd5nNKPpc7OXgq+V0b+J8GBeSrp?=
 =?us-ascii?Q?0xkG+yQ4elJB5ZJ5svvaUtQ+7a9MnxmY9Moc23O61Om8hIQCG0Fw/30jyx5j?=
 =?us-ascii?Q?xFFvdFij8OZykkWHfMy1kxfn2cfY7mAg73zQr1HC7zw1avk/Q1foOsym6lu6?=
 =?us-ascii?Q?jaW6aE0UTKpHO6mhqW1MOxCvsIF9YHdHx+21arUJboclAj9OYRu91OMlqKhy?=
 =?us-ascii?Q?t98UTMkc4aN1f+yRMcEhxTaQR5A9jR14w7yHj9ydumzUaROgd+zYTk3ue2g6?=
 =?us-ascii?Q?wBeYU9YIawmL4n9gre6GZg1bbp/5caTj33TFBfA75i0FKai8tjPEUDegPmfZ?=
 =?us-ascii?Q?EbKdFv5gEwy+Gov3xLmqOzfi9iEtXWWAmn/AXGaBoEGuMft6DX+Q/9vfNNaV?=
 =?us-ascii?Q?boZITGbO+d65izIkg7n4zZAq4CXP7IIh+umnmDEDPTxtrKwDN4zCylWWLHMN?=
 =?us-ascii?Q?gIaA6CcmMDnJ4ScjXrCwQzWSnyvIxb7MyvgeOY46yRKjsStGReKMOnglRsoF?=
 =?us-ascii?Q?8gbMBaM2iL6q3lW9ASEewB44PhhxOzaqChbG1b4XZEQ6UPPiRDukMYGw/LHW?=
 =?us-ascii?Q?6SsawcVThqxAXTpL/Hmtq/inru9J+jzVBg/Es3ODJNKOFiPhu/DRcnL3fF3+?=
 =?us-ascii?Q?3e8TS628vGGYOibjgjnpG1LS7d9iWpP8Y+4Lm+r4MhPVEI4/pDLk40DtqzWS?=
 =?us-ascii?Q?spx32G1K4itMSNm+2RTZh6Ugj+kCN1dpfn9Mcwz9yCYMgJJI/UcOoY6KlaxN?=
 =?us-ascii?Q?VgaaJFor5Yay0ybjOgPeC6COPDj7BuP+p5QhmDPQDNV5yPQH9EjDXD214b5R?=
 =?us-ascii?Q?q2F/waP8lgAw+iCPNgL3SIOtzGFcXxxJMdF3iy2KGU8CuXmJ98AQ5BC0Ahn5?=
 =?us-ascii?Q?v1nqZdnqpu7BLSL/qZ9XcDezlklyYoXSrSX6cR6T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d86da0-8ab3-458d-3074-08dac0a5c741
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 09:52:27.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj10mNgYinGDDRRJ+B9ySF6bILpPzk1Cde2uRPMH4G0GtPJKeS23j2tKyZmSJlfBqphNUc2XwLmdBJLxgG9QAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-01 at 13:30:19 +0800, Fei Li wrote:
> If the TSC frequency is known from the acrn_get_tsc_khz(),
> the TSC frequency does not need to be recalibrated.
> 
> Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
> This patch also removes `inline` for acrn_get_tsc_khz() since
> it doesn't make sense.
> 
> Signed-off-by: Fei Li <fei1.li@intel.com>
> Reviewed-by: Yin, Fengwei <fengwei.yin@intel.com>
> 
> ---
> v2:
> - Detail the commit message

Ping ...

> ---
>  arch/x86/include/asm/acrn.h | 5 -----
>  arch/x86/kernel/cpu/acrn.c  | 6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
> index 1dd14381bcb6..aa12c74ea959 100644
> --- a/arch/x86/include/asm/acrn.h
> +++ b/arch/x86/include/asm/acrn.h
> @@ -30,11 +30,6 @@ static inline u32 acrn_cpuid_base(void)
>  	return 0;
>  }
>  
> -static inline unsigned long acrn_get_tsc_khz(void)
> -{
> -	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> -}
> -
>  /*
>   * Hypercalls for ACRN
>   *
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 485441b7f030..c5ff75b6a949 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -24,6 +24,12 @@ static u32 __init acrn_detect(void)
>  	return acrn_cpuid_base();
>  }
>  
> +static unsigned long acrn_get_tsc_khz(void)
> +{
> +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> +}
> +
>  static void __init acrn_init_platform(void)
>  {
>  	/* Setup the IDT for ACRN hypervisor callback */
> 
> base-commit: 5aaef24b5c6d4246b2cac1be949869fa36577737
> -- 
> 2.34.1
> 
