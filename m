Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2713261303F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJaGUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJaGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:20:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D0B7651
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667197208; x=1698733208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OyvowzAZ1ojf3B5/A3Xl+FLhKdgYS3oUwYsJ/F3KJoE=;
  b=Fi2HWIBST+P9PlYy5wDytYD+LVxsi89JfKh2ViWLEEiDO23a8RKhEeHO
   A8yksZm9gVXRXyE4w91MzGkI+jncxbOtI8Hpk/TZnG1tp8chJVLycYJ2q
   FVDDwHMBgw1IsPuVDtK7MLcnTc8/ISKMADy51MlEcPmflYV2cedyiWDIe
   X/nz9uwoBuzFwcXhYIvD8NNDZ50M+AUmG0vvvWuuae+D7sUmAuLeo7wt5
   CQiQKbvnJxrbK8RUadXrSpRlr3eejR7npyn3vXUAhDeL0a3L6Hd61TiVo
   jgz3mIZl18yV2Dh0ejNvqiUUvU6B1M+/4nHP/UECdX3aIIjbztyA/We15
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="395142028"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="395142028"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 23:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="666719278"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="666719278"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 30 Oct 2022 23:20:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 30 Oct 2022 23:20:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 30 Oct 2022 23:20:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 30 Oct 2022 23:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7gKzsfoTxajohzvk4/kRzU/n5B54GSzeEQyqy4m7HSR5SL2GEK7D4S5G/HUvbrJLvJCmSA0I/AmejEz2UiehbYpDxofpfftyQfgEXidK41eb1KzuYjNSaNbyl6Bj7orUKaVrkmwU4hiowj8HBRwktvIaTI1HWAfvw7IiWe/uqQepHjiM4iIw98T1j6JfxBZpmp/lg8J7Jh2RckisEDpT6p3sTVslPVQhkzQXjo8SYBEL6rYc+oiEZkzTspjcy5HECtfFO3SPcFb7McjGC2AD7jGPwUtfvVtQFNArofpc1DNpE4NFU8pu6pVrklw3MSM801ZFXDcwOa1eyHrOe8ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rimqZdIVDCJYxyXO6LyiL1CkcdpbCI5VY3MzROhyyM=;
 b=JMthaGuaghcesH9EfprKzENXsWd89Uf2VWHaNqu2hmFFT01n66nxkAZZL5GBf85ccDnXc7hrxc5xdaNyl3gO73nH9wWEBcUt4CBjztGIo91Ig7UiBlYldXgcYhCj5G380ooX04O03VM7zXiaeeIDtWC7G6oMLum+rbMvMLF4STqP4VN61GGi9OGj6PbEC5sQrTSfktJdRsnemuoGwhbgwtUbT7LKJ1UvRg2OwkGHfsgCZ+J3/MyaOgnZ3mW3con4EMAEhejHZ647SDI2WMzXXSv7tUsxUgxFspWAwWmHntwy1wm6BiMpuKLSCxCHLQYGL9tvpDR/jjaN+emsZdyn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BN9PR11MB5386.namprd11.prod.outlook.com (2603:10b6:408:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 06:20:01 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%8]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 06:20:00 +0000
Date:   Mon, 31 Oct 2022 14:18:13 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <djwong@kernel.org>, <tglx@linutronix.de>, <jpoimboe@kernel.org>,
        <joao.moreira@intel.com>, <samitolvanen@google.com>,
        <lkp@intel.com>
Subject: Re: [PATCH 0/5] x86/kallsyms: Fix the call-thunk kallsyms fail
Message-ID: <Y19opTRPIZfmHXtV@yujie-X299>
References: <20221028194022.388521751@infradead.org>
 <Y15AqvPo/JqjVjTx@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y15AqvPo/JqjVjTx@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BN9PR11MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: f97ca924-8736-4c4b-e1f5-08dabb07f053
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+X1o1Gq+QSrdtcJYIHraX/GNy2Y3ryZPFF9lIzEsWzGIaO1V/Hm1sBj4wjtNEyef+Let/DSumnxAD/tjsgbdjk2d8P6StKJf4NSSs5uFtxUFT0fR1WfO5IxSsbxxbxgy5fVqcS4Ibr7r6UdkPly99JKzbVczxrwED9UXC1LEOOdQDYFS/bNi9HBty0HiB7ntS75UsWamTqbNZN9w3Xub8i9w+h5B7eFjuesVSdoKyRpGJXXU6c+jfOFjskviMKTPObs/PODHb2trorUS5RLKdFJxNG3wtiEY5fITiQUjfogRXlGA42d8Cebk+0L/ujaUVgtifxUX4h8CplAFaEnAGtYXRaUrRW0V0VQSUGEonkLLD3K7sOwT/eCZxdm1EEufz34H538mdmU5ElhUZyInZbYYbZfgNFlf0vTKN/vpuc4KoRmzAgiUiMEcGmfHiCLh2RgR1odm29fAhgg6w9h8xDIwzuPEaHTG6hcK+4JIcX6YHljYeo4R8cgLdmWJ06Vxz441/6kSziMjxou42sLP/ZUkP6wtSD0A0iwTbwML6J4plpet+Ml7KC+Nsy7vntkgM6M52UIOisyEb7oAkkfIODiJ977KoD9cXcZrSxUFbWcz08cgJlA2SrokaqMvbxL/0OqvR9XKjrckFG5DsafGccvOXqUQ33vS9689ZcBJZpz3lKIiXqIxswqawceTecDYfG69TEKNqJlblP/I9yS1Ul0Pkh8iRE9oJ9vo8IATL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(4326008)(8676002)(316002)(66556008)(66946007)(6916009)(66476007)(41300700001)(5660300002)(44832011)(9686003)(2906002)(6506007)(478600001)(107886003)(6666004)(6486002)(966005)(186003)(6512007)(83380400001)(8936002)(33716001)(26005)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LK0U1EYhMij/O7OpAXwHiKBWNx5GLjghkXyAup3g0HaSpwu2RT6whxyygVdp?=
 =?us-ascii?Q?1gwfJfddfnzvxsiCE5YJSvIjZArRriWspzZB6dQmzl6PWyLLM/nfWUBbefgh?=
 =?us-ascii?Q?B6a9XOklN1V9/1Nw98XUFK6bk5werslABT7iOyf5CkFC0VEJ7ngoTgzjvIen?=
 =?us-ascii?Q?s/sSpmN0/AWBengnRrn7Ol+8+npT7Ln8MKt0F9N+B6N0HjEt3cxBrPsNY83v?=
 =?us-ascii?Q?4c2H1vw6XgzTVmoLW6NLUuuKPlP6Y8I/ULzw78yLxkxn+esfB7tAClaxjoEg?=
 =?us-ascii?Q?Mh1vcmrZzHo81ez0V43OevBNxdIo4s00b7gaCZ4tDPloNZuIsOe5yjzzMF3Q?=
 =?us-ascii?Q?4JTrNwN3K7YMaY3wQKl4TfIFf1SZ0zoDQd5wFktOL2n+4H+u8dQNHDQbYoHV?=
 =?us-ascii?Q?8LGLMW5XuJbzHoEUINwkwwg0DkHufHdZC/G1JPt4w279kyWS2hKqRZ4NoHEx?=
 =?us-ascii?Q?U35qfeTPETMg6YZfZ35rFOBIBbVhp/HviL5ldokBO3pYAbB0xnCI4WlGh+1n?=
 =?us-ascii?Q?1xtmRDiW9TFuV2uUmLYPTvgI7moBm6uNujQyPblYU7zWzz9MwKHaYk/XUywN?=
 =?us-ascii?Q?o6/C8Gqe4o0jgzc/Hd8tsdP6OUBacoFDuDHwJDkU2JuHDuWKuChILGQk+gwU?=
 =?us-ascii?Q?PiMAK/3omnwFPNrHpq8nWKyS//sjQcjiQ/8S1Z5SPC2rl19hkY64xyz3slFs?=
 =?us-ascii?Q?w/BhN8cnrLyNNqVdxEaAM4f6WWG6IlBS5GtmRv52h8kdaCxhGIFVue1FRVTN?=
 =?us-ascii?Q?kThVl4lS2Zy1TrzquuV9FnbU2roSLkGI5FGNAUjdMlhKUen0fdLV65nTxolf?=
 =?us-ascii?Q?vCrLwiULtV8C2Z7mLEXBwmlU6CJtBkIvNB6gisbFac/C7MtLYbxOgrEPM6Y6?=
 =?us-ascii?Q?PXR48IeOCVfEEM/VJpuwWY4t9plfygMvkGzdrNvBarUGTkdC4qbjz7eitfYf?=
 =?us-ascii?Q?eoesHJX8kYByQ5Gh9CF3+mcb4G0wp8sTxRFTZjuSwq7V++BKsy5LMb+ZUaoW?=
 =?us-ascii?Q?PREr8VyjA1DbLA2SsSRAFt1OnO4e2Ln8lNQR4Gizc4PgQEWxaSDwV2QwHqnz?=
 =?us-ascii?Q?gp2soJzDxx88pxscN6hibqc2OVSwU1K4F715er132mi1N63B/ij4UrGK5Iyh?=
 =?us-ascii?Q?HnoIVMNbZHUCx0rSXMwvWtni1rbWgBRr7BxNFplvSGTAqjza92KBpFKLAFBl?=
 =?us-ascii?Q?P+Ivt4rvs/xr+bvaC72eLMQbkUSVsQsBCx+JyH5qokntrbqPPzSuAXCgEdEU?=
 =?us-ascii?Q?DdzKV3Mt60B8Bx02cZbcGvlexwsCSco9/kAaKIx073pRyQkqhGcprsTMQlRE?=
 =?us-ascii?Q?BYlvRrTiyhWm6jcwGK4Acp247eHYM5oNygJdWP1CC1vqDT639BG58RSSl/oX?=
 =?us-ascii?Q?IaH7uW1Bla5COTmxaqYad15+J9m1m8z0BHkMbUdArKagpJUCCDNp5DIgGzSk?=
 =?us-ascii?Q?6RdgQhDxgHpoof6ygtZP0dIsHlWXb8dpCy27wiMI0n55QqR7GfzCe2VyerXo?=
 =?us-ascii?Q?jI8RF6jUDdffe8b0ZGCMNbupfd/hRM7REclqXjwEH/Vgu58Dqezh/K4yN/FM?=
 =?us-ascii?Q?fA+frwTgKQdzKy6vSmGGL4hYJZLv5jBGL+vpPjVm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f97ca924-8736-4c4b-e1f5-08dabb07f053
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 06:20:00.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRNfO+RJZzeIBWU/j1r1tpOhZsVPjpFBqHKBvc9bj+yAG/g+eteraKkhCvqHYMp9VsEwavo0Yk7Fzph/zErlqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5386
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 10:15:22AM +0100, Peter Zijlstra wrote:
> On Fri, Oct 28, 2022 at 09:40:22PM +0200, Peter Zijlstra wrote:
> > Hi all,
> > 
> > As reported here:
> > 
> >   https://lkml.kernel.org/r/202210241614.2ae4c1f5-yujie.liu@intel.com
> > 
> > The kallsyms change for call-thunks doesn't really work out as expected. These
> > patches revert that change and propose an alternative.
> 
> Robot found it needed the below; have folded back and pushed out again.

Hi Peter,

We applied the five patches in this patchset plus below extra fixup
patch on top of x86/core branch of tip. The xfstests failure and the
issue of changed dmesg WARNING are gone. Thanks.

  Tested-by: Yujie Liu <yujie.liu@intel.com>

=========================================================================================
compiler/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/4HDD/xfs/x86_64-rhel-8.3-func/debian-11.1-x86_64-20220510.cgz/lkp-ivb-d04/xfs-no-bug-assert/xfstests

commit:
  f1389181622a0 ("kallsyms: Take callthunks into account")
  9b10b976b8e2f ("x86/kallsyms: Fix the call-thunk kallsyms fail")

f1389181622a08d6 9b10b976b8e2f61d861befc114f
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         12:12        -100%            :12    xfstests.xfs.098.fail
         12:12        -100%            :12    xfstests.xfs.439.fail
           :12          92%          11:12    dmesg.RIP:assfail[xfs]
         12:12        -100%            :12    dmesg.WARNING:CPU:#PID:#at_fs/xfs/xfs_message.c:#xfs_buf_alert_ratelimited.cold-#[xfs]
           :12          92%          11:12    dmesg.WARNING:at_fs/xfs/xfs_message.c:#assfail[xfs]


Best Regards,
Yujie

> 
> ---
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index cf743520a786..55066c493570 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3479,7 +3479,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  
>  		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
>  			/* Ignore KCFI type preambles, which always fall through */
> -			if (!strncmp(func->name, "__cfi_", 6))
> +			if (!strncmp(func->name, "__cfi_", 6) ||
> +			    !strncmp(func->name, "__pfx_", 6))
>  				return 0;
>  
>  			WARN("%s() falls through to next function %s()",
> @@ -4042,6 +4043,7 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
>  
>  	for (;;) {
>  		struct instruction *prev = list_prev_entry(insn, list);
> +		u64 offset;
>  
>  		if (&prev->list == &file->insn_list)
>  			break;
> @@ -4049,11 +4051,13 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
>  		if (prev->type != INSN_NOP)
>  			break;
>  
> -		insn = prev;
> -		if (func->offset - prev->offset == opts.prefix) {
> -			elf_create_prefix_symbol(file->elf, func, -opts.prefix);
> +		offset = func->offset - prev->offset;
> +		if (offset >= opts.prefix) {
> +			if (offset == opts.prefix)
> +				elf_create_prefix_symbol(file->elf, func, opts.prefix);
>  			break;
>  		}
> +		insn = prev;
>  	}
>  
>  	return 0;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 9fbdad7a565d..3d636d12d679 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -822,7 +822,7 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
>  static int elf_add_string(struct elf *elf, struct section *strtab, char *str);
>  
>  struct symbol *
> -elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend)
> +elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
>  {
>  	struct symbol *sym = calloc(1, sizeof(*sym));
>  	size_t namelen = strlen(orig->name) + sizeof("__pfx_");
> @@ -840,7 +840,8 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend)
>  
>  	sym->sym.st_name = elf_add_string(elf, NULL, name);
>  	sym->sym.st_info = orig->sym.st_info;
> -	sym->sym.st_value = orig->sym.st_value + addend;
> +	sym->sym.st_value = orig->sym.st_value - size;
> +	sym->sym.st_size = size;
>  
>  	sym = __elf_create_symbol(elf, sym);
>  	if (sym)
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index 9e3bd4717a11..b6974e3173aa 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -146,7 +146,7 @@ static inline bool has_multiple_files(struct elf *elf)
>  struct elf *elf_open_read(const char *name, int flags);
>  struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
>  
> -struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend);
> +struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
>  
>  int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
>  		  unsigned int type, struct symbol *sym, s64 addend);
