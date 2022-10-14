Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D915FE7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJNDtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNDs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:48:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB516251D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665719337; x=1697255337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xqt6gSc3sjmhJCKICjVYOpR9FVleqdez+054yf09Tas=;
  b=dANbuX9iiXT1Akv1ALHLuDmHi39sB6PUeEHObQISJjaIqsDNstDdC7Yy
   ilokArRJhtqJovSC4zjnmWM9UFqphBCadwOnBqT7lBUk3y6uvxGUUkzUF
   yC02l/yElH48zYAff2R4jiI0boKySiH1/+jt4iqr4H4/UGRj82bm8r4/h
   9EEEnONgZEpSZNnziMqLDSPoTd8naTnoh0gHuEh/V7JDZvJFG9xbxOTRU
   rw//NQrmynX60bzlak2c/ZwnZMQgVleOlWC2rbaO8J6MgcWblyol6hS6U
   pwwDIhGYPqnUns8zWiaqZLlLbMJUHbiOOzFMIh65bio2XC7/Tp6pv8VhJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="367288669"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="367288669"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 20:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="716595888"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="716595888"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2022 20:48:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 20:48:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 20:48:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 20:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDzEIhttN40z9OfdDMV7OUuH8+5zuYRlGdrZGoZ1UW6aDR0S3Tpo3igBb+z3gvzlxObIjLFtKV3iMNbhrD9yheuSYGv6VxxkiICZSRi9J//vZgpa6nr4MRa4vSn+p7k7y8nQGf7QHIuB31TKSFWiQybKw8ZhMtfgd15tKiD1DNL+DW8V1Iikb+L1myZPCIjvhL1E2gjXG7tFEBEnLj3QiBiGuhJhWlxf1nYsEelu9VPE9y3rNXprwQoybQPzGr04m1uUiGG80OjgUueqcIqskbKZ3HigEur8yaZwwonNTfaA02FWlj0hIXu4aabZyKXc1eaEdxyjHcNR1DB/dTGzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g20l0u9DxVW/3yMCDWNKIta1P/8cTP3PCtx3xVScx6k=;
 b=KXZddZy38xqTNxufZaUpk0UsEituuLfOpUHXfUT6Rcm/1Ayg8MqTEQkQdSYQ9G2EhLXGrHv6J5Cw8v4z0776VItG3lsh0aQG/Uwrq8raSxH2IRdzFMu050s5LDP8X7FENiS4TfAJ/hnDi0BjLBoKWIEGOFnUaL0jshZT540F/6ZFnWXJMmWjiefvqY358sEvgtNr9ZfKNOGJ7MbVwtvlL4qVt9gyWrwRn7Qoumv3ob1n6Vqlw2hrQYxopLfBvXAR16E4KePh5Ul0+sjWBGEt93xYqrFI4DxaA0DIyPkHnrvOlIwv292Y8fD3BEJ7etGmU9WyzDRPzYLE4D/EFnwtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:48:53 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::42a2:71ba:f567:a5be]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::42a2:71ba:f567:a5be%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:48:54 +0000
Date:   Fri, 14 Oct 2022 11:48:42 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Song Liu <song@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <kernel-team@fb.com>,
        <rick.p.edgecombe@intel.com>, <dave.hansen@intel.com>,
        <urezki@gmail.com>
Subject: Re: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Message-ID: <Y0jcGjzjIYeFzNhv@ziqianlu-desk>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-4-song@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221007234315.2877365-4-song@kernel.org>
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: e76edd62-f13d-44d4-53bc-08daad97035b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aqs6hUGR7yb01T07CIrbHSzhzUMo1E0UW598HD70PhZT+zFqRPT2pyKXaRU3xgfaZlbdpxKQDtRa3xILx1PtzOFC5kPXoMMncBQQd0aHtOIlEJaBJHIJZlRQvtHhzsbn0uOHidl0BoQvzbT/Jm7Ikljwa9hEOdJG2oSsY7xYi8nWGLJ35gX63pLgQ2CMTDP379gnPiNh52SmB8jjv+WU0Nc4BcQdQd1Xe+Z54BM6eZdHrjalouEnirrYnDyI19hyT4AfcNO1K7/ya4V1EEprEsiAGmKvRTOLVpZIRqoBPF0Aja9CgueqABJsLHO4l+k2e58jlKWFkLrG6MOqWV/vGgFEBWDJ5Gt/UJseXe6aGUnPyGMrYwtAK72qPK+mgaANDCq1BJqo4scNpF/H3L94PDrijMipAKHglR8M1U/qyA5A9MOW0gpgKqEs9CA8GAPMBpJ8mLw+GxL6N1n55R3bYJ2Y1GHrqmn6Ir8gVe94Reww3/Zjv0Alk74N/JG3kq2uuNiWIA3oJ++GseHY9/BkyY1do3KGGoFJu0tYKtaUxO615MQ3hAl+gq/fp4ttb24JuuP8i8Dj3XjaY4f/Jb0bmIhg0QSUjCAXeryzrV0jE8DAQVedvdjz64Cl6SrEDV3qMmhHRMut2hinaLR1TyeeECKOKtA7JCoWxtlAWC9OzbRYIKmPKNLKtZ4nVUnRGBU5nDaFrozL+ZSUSoeGIcFm5unLZsmjfd+VM4ehnNFuczRdL6rBkjjxo64D6/5UzBvDH4JEoPepca62ysH/7j6uug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(45080400002)(478600001)(6486002)(33716001)(6666004)(41300700001)(316002)(6916009)(4326008)(66946007)(66556008)(8676002)(82960400001)(83380400001)(186003)(38100700002)(6506007)(86362001)(26005)(6512007)(9686003)(66476007)(44832011)(2906002)(5660300002)(8936002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ny6niRAhkdRqy4Ry8QXXNTkYGH1wOZjB9dY2g44DKfZoKVMLXfSJdkst/4to?=
 =?us-ascii?Q?9hw+VoMztBRoGkCjhcJ/9JeJlc78qw/cJd56jpXMzsGGYOFd73MboiB1TJp0?=
 =?us-ascii?Q?kauq1n/aa40Vm7/ub8EKnM5zSeFqknJU+XbC8PHNlMTR6HvjLiKIEuXtDqtW?=
 =?us-ascii?Q?b8VXH+3qadaHydtlgz/wbW7Vk7WTC9vzjgtEG865HIC+NuqkGibhxMr5+fYm?=
 =?us-ascii?Q?faqdWq7G2VkWsQ9BO1uNDcI5JlAz91Gqr6xNyo+YsQ6AxL60yVWXLFPsMcgR?=
 =?us-ascii?Q?zzB7ZD4d/zGKRRjp+UAbdPzxYA7idRyO889NwCheJfLsMWGpvnTOaNaDrTCv?=
 =?us-ascii?Q?xBpv47wU0BTNEuFSlXgBOZwBXlJIgEpIhN/q93f+UmO1AAxNVyP8yIjC9URj?=
 =?us-ascii?Q?tujSfQKD6V8yuZ3Touy41CBt0jOF7vjxYShBsyCz30MdmrH6pfi1OOSu2l36?=
 =?us-ascii?Q?noOImaiK9v+HjrUEjLP5dywFzZAM7kbiAdXx9Jb/c0GAhpg5FtDu+icvWCsa?=
 =?us-ascii?Q?g8qFtTOlByK2i335FSMSLLxvx+5CpV5VZUDS+QyGzik3rEssC6VUOKd2nRSV?=
 =?us-ascii?Q?2WHpMSfotTSadf3IZk9dRocxMIOawBx4CsP6fbiM4omHE0j73qr6bjk3qYyV?=
 =?us-ascii?Q?BmxUfdfeLB7lJmUih9qlyD4uzpByEG9a/JLQkbvdSHVxqZpS6bNrzBOMeQpn?=
 =?us-ascii?Q?qH+mB6Gb/mxqyRYSSIptMHky/pnkWvy0vJFzPaojft9iKWN86pOTWMUcitwz?=
 =?us-ascii?Q?/LgfYSubZFdKLwDWw4+3hXRa471BULLNhTKdgrjW7REP66l+H6Y2Z3ZMWknE?=
 =?us-ascii?Q?uKkQH8RczNnDgnz0PgUm9CBXWlq/IYYS15oTcn1a9OAdDUE2NQ2Pfd82xT93?=
 =?us-ascii?Q?9HkLj+G/HbmpS2WIo/JkYKigupSyEm02sAnyW6HQ0Q+gsla0kqU74RQR2zcr?=
 =?us-ascii?Q?ltmgfPDBi63t28NUbWjHMPhaS6zHCrNWsCxnytTONf9NUW8WSy6dbShoa+ix?=
 =?us-ascii?Q?Z4JEEhJXU/uYYpRJDQvpQonYirV/mgiDZxbU3sSf1P0ksrfM1H96iIkSw/m6?=
 =?us-ascii?Q?aFNR/armQ/WpA0wSfhramkGg+9JXBP2kXRwEVBCBcBue0Bt/mzd1NOZCQg2X?=
 =?us-ascii?Q?MGFIyIQvaNOTQPgoO6xCqlvB541Vz80gg7vdVuFFOp4Gwc2Z4SHFpre4tMYB?=
 =?us-ascii?Q?qbGuToy7DW0JGmzOjHCo4lNnw0Qqxz+wxOIts0a1z3MaRe1Z3RKZfnDW6Pio?=
 =?us-ascii?Q?kYJYK0HervfGhI6KFAmILYJZFQ4+3ayw0N+7T4ypUI9K9s+xtnaxZ7E/N/ct?=
 =?us-ascii?Q?nKiHjH0Xi/t/2L2irylecxG0BCCs7iLXuB24BMJxK97c1+27hMh98n9gXcf0?=
 =?us-ascii?Q?WuJqdaiZ1M2ZMe2rFoXHTqo7M8YIRurLx/RMpx9gWSavF2ZeKaXEa62E+NR/?=
 =?us-ascii?Q?QAkBzlNU96iU7BVcRn0liFHQet8fXiALZtzjgji3/0CJPuyzeIOxBXg/j8zg?=
 =?us-ascii?Q?82OnqvCTk9/ct3yyRvh+uMGg2/JGkFf/VRY2ACz2Apry8OzUqFY9m3eoKC5t?=
 =?us-ascii?Q?b18uULIrpveC9jmtDftCFnR2Z/q/ve2CvMmg6aNp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e76edd62-f13d-44d4-53bc-08daad97035b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:48:54.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXhpgJoGaNkA5Y0e17AdJ8GuTn06DCZ1aoymGrcjzd0o108svRHIavUWFtdStLNwm7CSbmc2vnbJqJBPSJUSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 04:43:14PM -0700, Song Liu wrote:
> This is a prototype that allows modules to share 2MB text pages with other
> modules and BPF programs.
> 
> Current version only covers core_layout.
> ---
>  arch/x86/Kconfig              |  1 +
>  arch/x86/kernel/alternative.c | 30 ++++++++++++++++++++++++------
>  arch/x86/kernel/module.c      |  1 +
>  kernel/module/main.c          | 23 +++++++++++++----------
>  kernel/module/strict_rwx.c    |  3 ---
>  kernel/trace/ftrace.c         |  3 ++-
>  6 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..0b1ea05a1da6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -91,6 +91,7 @@ config X86
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_HAS_STRICT_MODULE_RWX
> +	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if X86_64
>  	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  	select ARCH_HAS_SYSCALL_WRAPPER
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 4f3204364caa..0e47a558c5bc 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -332,7 +332,13 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  
>  		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
>  
> -		text_poke_early(instr, insn_buff, insn_buff_sz);
> +		if (system_state < SYSTEM_RUNNING) {
> +			text_poke_early(instr, insn_buff, insn_buff_sz);
> +		} else {
> +			mutex_lock(&text_mutex);
> +			text_poke(instr, insn_buff, insn_buff_sz);
> +			mutex_unlock(&text_mutex);
> +		}
>  
>  next:
>  		optimize_nops(instr, a->instrlen);
> @@ -503,7 +509,13 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
>  			optimize_nops(bytes, len);
>  			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
>  			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
> -			text_poke_early(addr, bytes, len);
> +			if (system_state == SYSTEM_BOOTING) {
> +				text_poke_early(addr, bytes, len);
> +			} else {
> +				mutex_lock(&text_mutex);
> +				text_poke(addr, bytes, len);
> +				mutex_unlock(&text_mutex);
> +			}
>  		}
>  	}
>  }
> @@ -568,7 +580,13 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
>  		if (len == insn.length) {
>  			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
>  			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
> -			text_poke_early(addr, bytes, len);
> +			if (unlikely(system_state == SYSTEM_BOOTING)) {
> +				text_poke_early(addr, bytes, len);
> +			} else {
> +				mutex_lock(&text_mutex);
> +				text_poke(addr, bytes, len);
> +				mutex_unlock(&text_mutex);
> +			}
>  		}
>  	}
>  }
> @@ -609,7 +627,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
>  		 */
>  		DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
>  		DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
> -		text_poke_early(addr, &poison, 4);
> +		text_poke(addr, &poison, 4);
>  	}
>  }
>  
> @@ -791,7 +809,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
>  
>  		/* Pad the rest with nops */
>  		add_nops(insn_buff + used, p->len - used);
> -		text_poke_early(p->instr, insn_buff, p->len);
> +		text_poke(p->instr, insn_buff, p->len);

Got below warning when booting a VM:

[    0.190098] ------------[ cut here ]------------
[    0.190377] WARNING: CPU: 0 PID: 0 at /home/aaron/linux/src/arch/x86/kernel/alternative.c:1224 text_poke+0x53/0x60
[    0.191083] Modules linked in:
[    0.191269] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-00004-gc49d19177d78 #5
[    0.191721] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.192083] RIP: 0010:text_poke+0x53/0x60
[    0.192326] Code: c7 c7 20 e7 02 81 5b 5d e9 2a f8 ff ff be ff ff ff ff 48 c7 c7 b0 6d 06 83 48 89 14 24 e8 75 fd bf 00 85 c0 48 8b 14 24 75 c8 <0f> 0b eb c4 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56
[    0.193083] RSP: 0000:ffffffff83003d60 EFLAGS: 00010246
[    0.194083] RAX: 0000000000000000 RBX: ffffffff810295b7 RCX: 0000000000000001
[    0.194506] RDX: 0000000000000006 RSI: ffffffff828b01c5 RDI: ffffffff8293898e
[    0.195083] RBP: ffffffff83003d82 R08: ffffffff82206520 R09: 0000000000000001
[    0.195506] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a9949c0
[    0.195929] R13: ffffffff8a95f400 R14: 00000000ffffffff R15: 00000000ffffffff
[    0.196083] FS:  0000000000000000(0000) GS:ffff88842de00000(0000) knlGS:0000000000000000
[    0.196562] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.197083] CR2: ffff88843ffff000 CR3: 0000000003012001 CR4: 0000000000770ef0
[    0.197508] PKRU: 55555554
[    0.197673] Call Trace:
[    0.197822]  <TASK>
[    0.198084]  apply_paravirt+0xaf/0x150
[    0.198313]  ? __might_resched+0x3f/0x280
[    0.198557]  ? synchronize_rcu+0xe0/0x1c0
[    0.198799]  ? lock_release+0x230/0x450
[    0.199030]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[    0.199083]  ? lockdep_hardirqs_on+0x79/0x100
[    0.199345]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
[    0.199643]  ? atomic_notifier_chain_unregister+0x51/0x80
[    0.200084]  alternative_instructions+0x27/0xfa
[    0.200357]  check_bugs+0xe08/0xe82
[    0.200570]  start_kernel+0x692/0x6cc
[    0.200797]  secondary_startup_64_no_verify+0xe0/0xeb
[    0.201088]  </TASK>
[    0.201223] irq event stamp: 13575
[    0.201428] hardirqs last  enabled at (13583): [<ffffffff811193c2>] __up_console_sem+0x52/0x60
[    0.202083] hardirqs last disabled at (13592): [<ffffffff811193a7>] __up_console_sem+0x37/0x60
[    0.202594] softirqs last  enabled at (12762): [<ffffffff8117e169>] cgroup_idr_alloc.constprop.60+0x59/0x100
[    0.203083] softirqs last disabled at (12750): [<ffffffff8117e13d>] cgroup_idr_alloc.constprop.60+0x2d/0x100
[    0.203665] ---[ end trace 0000000000000000 ]---

Looks like it is also necessary to differentiate system_state in
apply_paravirt() like you did in the other apply_XXX() functions.
