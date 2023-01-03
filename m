Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946E365C79E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjACTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjACTiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:38:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE8959C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672774684; x=1704310684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L+Jv62oll9vaDlqgzIn96xp1HHlFeiigdZqmLcQLodM=;
  b=RIib5jGwSfKgwFY22bXUYQP6Ofok45z8Ya61TkI4G5Vz5kPnAY/vY2KC
   ASPaFqZ/ASPtqBBnXviQ8B9qvdy8KTjwZV29flPzmn6xRawJnYfbdiMYr
   OML0DTvQXFOEk6CGWnJ3ru8vUaVe6qhV+7eh+iWGzw3t+tBcmdmolgrHi
   4G0Ko7PN/z2DVBxT8r5U6IBL4MH7SJSbgfy0B3leZ7rHhK4MCKakuOt7e
   dXLiLlvBqBYk0Tp/Mv6kncqawoTWf1g1qUfl5miTLZItBIq6x3Z5u6h3k
   O/GJFW54xHOc9eiqCi0EHCYqhpePW+1G3a81MU3IuLvahxttbDrK3WSfe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302115786"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302115786"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:38:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="718209549"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="718209549"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2023 11:38:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 11:38:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 11:38:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 11:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1wUx33qPSZ3EsE9M/vqWVslP2MidS94DX+sMXWn04iDt0EnQWygy8e0XJckdUGmqtXvC+eC4FmUjIqEuRs7LPwrU7mj5bcMNCwwaIU5a66veEEqaGyiVCF2Z0bh6Tc90muMPkql+I1BLg0kK3i0qCd2PPBJOWLWHOeBcoMSlK+fEI51PDehKS/qv/DMujm9ikwL07RtVw43MbJ2uKZRsnd5ZQ6cvqGRzVtgrz0W4bxrO7PB/kmfQPt4RrDA3W6/8SzXvRZJILmtUexLEnxNUnR7MK3sc/NS9HzFlUqgvjZ/yIz3KGnTHlt+7405+M2zn174SHwjKnCV9OtKw2j1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1RrX+P9Sczo+f9Aot6BhikUuiLoM5L7KsnWgTmUNyo=;
 b=HRaC0Xdn3HfnKAXWBS4Q1JbMB+bfhmF8cJgHdxi0itB8qKNnTyIAwEtdLkh6thcGUGN+us+JBWqmOVAk9WoMA8P0aOz9sedRpX48hSHf/Qm//3ZZROEHYadVg10Uq9yW8RWdL+/Fjq/nLyvCs9cf6B6ZJvFxfdt1zx9NRJCwKv3O2tOsEBydkyGXLsRX7/OGdB6RPLAHK5+DnIG7gG8r/oVTfyR42232seJpWt/8WzMyxJCfGVmIVCbBnnN4FIpxHOapOxlv2QQwg7cjzgOF95mWusqsBqBjPjxWyWUAKOux8b1XpxUnDtK6vtQuP9LHO7cEqsn2XuCDsA4PgGndQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB6042.namprd11.prod.outlook.com (2603:10b6:8:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:38:00 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:38:00 +0000
Date:   Tue, 3 Jan 2023 11:37:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v3 2/6] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y7SEEtHdeKmPchJ0@a4bf019067fa.jf.intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-3-ashok.raj@intel.com>
 <efafb54e-5447-fd5e-8f8b-1fc150087d35@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <efafb54e-5447-fd5e-8f8b-1fc150087d35@intel.com>
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e379308-1d6a-4b28-220e-08daedc2058b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Qffo97d0jJ+Z4D2z/g4NYHW3JRt0ssqnsDhVAOASJpoeL+dk8wi7yKBEb/5XRiEm4fC7zuilyGVKAI81HSUkwFxV51VmI4Uxiu7Gl5D9nmdDRxkz6DbVfl2iUTzjraiCgwFiPXQOvwynpPLfzWBjZ7ZrviB6XrioEZ7EMevk0kYvy06+Jg2r0UWPMMvrJ/DZoTJWnjlnP0up0+/S0yGmDJXxN0IrY25MC1+JC6AqZxCqWgS8zP6S0xI5dndrfhwi+NMgHzdN6lv/yzHbouiqR1VwAGL79QMWOwlpjymT7TkfLSi9MpG/bJNk4O9jxahzE5EzyUnjSL9ZQ/yvUIywtwU7cGsZj97t9DjuXTzfiLBup3Vzm9wef/AWv/hG1YuDmsMCB8KOeQ2JkUJHUbbUyu4uHJYNJfPoq0r/1ptUbXjVinJ9G2NGqDjD/PhnHb/q7CGGzzYATYV0+UpfH5hfvjnNOJ53diBJ6I8+af+lXWXGj0mLpGe1ntmsCgaRm/kvIau3GHW/916OnA/IebfqkxHAwywn3LBMB74dcu5Q9vvyi21Mbd87mG8Nf1XEa6J3Mp5BkPbXoNHmPjlnx6+7iY8sR8s5Hd2UbFnkCCk7fTtudjSwJXDdsVC4gi2mQNwdEfDOrLMCjhb8nJ9BlmdroeWJgrR+6Sxz0cGuwqh1UefTnJMHA+cxyx3rCz/gzhn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(6862004)(5660300002)(2906002)(44832011)(8936002)(41300700001)(4326008)(8676002)(66476007)(316002)(54906003)(66946007)(6636002)(6486002)(478600001)(66556008)(186003)(26005)(6512007)(107886003)(6666004)(6506007)(83380400001)(53546011)(82960400001)(38100700002)(86362001)(22166006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55qqs0uOMHCLw+GNCSEswKure1qc86Tci9IauA28g0xODKFIhJrHA1EU1F4L?=
 =?us-ascii?Q?z4yhb2lYsbvlTkOyDLZJBfL5qtVFp2EtdMiLomy/HpeRWzq0Nm3njifjNk+w?=
 =?us-ascii?Q?JHf12BgA47oibGYOY32iCbi7OAWX89I+25d2pQaoYyX+g1092+2/v6yqThUG?=
 =?us-ascii?Q?d/M3mr3E1EnsTLgwYT4D79qMmJHzVcE1f8+ND+frI7+hTrNnSQ+Wwvw6C4UK?=
 =?us-ascii?Q?bkizLBi+++P09BnseVKJBn3yywE+4MIGRm1PrkN5O4s8Wv1wcjhHsTJB1/ma?=
 =?us-ascii?Q?ML4R/udTXwnyV55U5A/xtIjhXheKX9JgcQ4n1mECBQTKGN1uq3TFVuu+0PTW?=
 =?us-ascii?Q?2HI3xxS2nSyqAMYEZ7cvUUvwuS1dazrjzuW48NKOwzZoOYOQpg7z/pqGK8Kt?=
 =?us-ascii?Q?ZWImO3xg1voWgb9ANmCNXEpVN1cu1B1PYpJBGEmZ2bSMcX1Oq0fVdNBW5cIV?=
 =?us-ascii?Q?max34cF9Pou7I280WiqrQ0JhYbpF8GrvS0wq9Vgl8lIGb2Uggzj7hYwWsr8x?=
 =?us-ascii?Q?r4VtcZVp0E469Hjkso3dk2rPfSJxorhJqMo4OzlSnTk3+C11IRY8EUGxE70l?=
 =?us-ascii?Q?hGWcCzdKi47nZXI5ksZt1O1tF61bgIPiM18CFYRLJfRqggaHAzaBY/GWTY41?=
 =?us-ascii?Q?remZ8qLmbfNDaxKoUf42yO+K4PJjRUtIlJp9fIr9Tsn7noZj0bBT3hqKPHoh?=
 =?us-ascii?Q?4MH/ithgEzziH+OSd1nxxqXiJLbTMZ/0QVddT5nRtZxR+Pe9LlB6GSrACkAI?=
 =?us-ascii?Q?VX5nlJnxuYDxgPIEakpsmjQgfv9/acCgqP18nKLjAk76R6ZA48pOFWcq9cZU?=
 =?us-ascii?Q?PmoLIHYWhtrF/hKOXnDrtlCSoTbGrJodnrjNHwhOLAXyMj00q8z9zWNjj1ma?=
 =?us-ascii?Q?+uZGFZ785NfFotFFv49e9en6y4en39E0gQ5QIMur3Xb+OoS+W4Twg3CXBgit?=
 =?us-ascii?Q?DoUAVBoQ+KTzvNmXsCjxD4tzLZuDl7XsoT0PtYe2gfhaqMKFpcFg4cSwnlct?=
 =?us-ascii?Q?jwNRcNdlNVM1UCEsSoteQUDMEUfR1FziQMfl+dG7YHXEQFzn980bQbIEg2hZ?=
 =?us-ascii?Q?drvTB3u33gudbEuRlxZsZyD1/EML7e0lGV1HxV6gLq1PoLqQL9eHxMyZppsF?=
 =?us-ascii?Q?YeSsCekv0jwdbiTHnAIiOpcDslzdWygusMBRLmTRVBJ7kDaf8CXjwJQ3cOGI?=
 =?us-ascii?Q?HBFE43S5APcGplEsz/wmQS3oD5hQwL2shZh1RY4lVAlNL7/MuJS97EgY9AB6?=
 =?us-ascii?Q?bdyvLPh8niRqPYQAlwXY61HJ8lZGysda1edgpe/3/aoSqfaETATJEAIWAOFs?=
 =?us-ascii?Q?8BWFu9mr8gOErG7mLnZmHTNoxdHphg6T5MV2O+XyYBh78kU2MV4w+JCm7+bY?=
 =?us-ascii?Q?k9OYEh12uJXi8oGW3/UTp/zjLYePgB7UxCLx5G7+WOWshfx7P+DA+qk22JDs?=
 =?us-ascii?Q?/3tXMM3d+B+TNoai3vowGBHfbvm6WPQ7bYMbmsTmrO+4ca5ZMKUpMXO/6O9z?=
 =?us-ascii?Q?NrXPGfWgDvRTXrM9AC9rYgGUzlz2ia8VN/L4dUpT3SJttRpovEEmunUmzluv?=
 =?us-ascii?Q?vZPaF09Mu9VuQox/xh8iub1QeCaUK34LT9iUcQTr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e379308-1d6a-4b28-220e-08daedc2058b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:38:00.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLLHARpuN+p8roOvLlPlRhAJ88QEK/fHWHqusBt1i2okwSBZ8heTxqalp54qdyoaPCOhjLeCFE/bLtgmX66KyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:46:56AM -0800, Dave Hansen wrote:
> On 1/3/23 10:02, Ashok Raj wrote:
> > The kernel caches features about each CPU's features at boot in an
> > x86_capability[] structure. The microcode update takes one snapshot and
> > compares it with the saved copy at boot.
> > 
> > However, the capabilities in the boot copy can be turned off as a result of
> > certain command line parameters or configuration restrictions. This can
> > cause a mismatch when comparing the values before and after the microcode
> > update.
> > 
> > microcode_check() is called after an update to report any previously
> > cached CPUID bits might have changed due to the update.
> > 
> > microcode_store_cpu_caps() basically stores the original CPU reported
> > values and not the OS modified values. This will avoid giving a false
> > warning even if no capabilities have changed.
> > 
> > Ignore the capabilities recorded at boot. Take a new snapshot before the
> > update and compare with a snapshot after the update to eliminate the false
> > warning.
> ...
> 
> It took me a moment to square this "Ignore the capabilities recorded at
> boot." statement with the continued existence of:
> 
> 	memcpy(info->x86_capability, &boot_cpu_data.x86_capability, ...
> 
> I think just adding "hardware" might help:
> 
> 	Ignore all hardware capabilities recorded at boot.
> 
> Or even adding one more sentence:
> 
> 	Only consult the synthetic capabilities recorded at boot so that
> 	a simple memcmp() can be used for comparisons.

Rewritten this multiple times, but it still seems confusing, however hard I
try :-(

Its not consulting just the synthetic capabilties, but all real
capabilities reported by hardware including synthetic ones. For e.g. 
if we turn off SGX, but HW still exposes it, the new snapshot will 
have SGX but previous copy doesn't as it has gone through some more
filtering during enabling. That is what resulted in the miscompare. 

Does this replacement sound better?

Ignore any changes to capabilities applied by the kernel during any
feature enabling and check against raw capabilities exposed by the
hardware


> 
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 387578049de0..ac2e67156b9b 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -697,6 +697,7 @@ bool xen_set_default_idle(void);
> >  #endif
> >  
> >  void __noreturn stop_this_cpu(void *dummy);
> > +void microcode_store_cpu_caps(struct cpuinfo_x86 *info);
> >  void microcode_check(struct cpuinfo_x86 *info);
> >  
> >  enum l1tf_mitigations {
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index b9c7529c920e..7c86c6fd07ae 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -2297,28 +2297,43 @@ void cpu_init_secondary(void)
> >  #endif
> >  
> >  #ifdef CONFIG_MICROCODE_LATE_LOADING
> > +
> > +void microcode_store_cpu_caps(struct cpuinfo_x86 *info)
> > +{
> > +	/* Reload CPUID max function as it might've changed. */
> > +	info->cpuid_level = cpuid_eax(0);
> > +
> > +	/*
> > +	 * Copy all capability leafs to pick up the synthetic ones so that
> > +	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
> > +	 * get overwritten in get_cpu_cap().
> > +	 */
> > +	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
> > +	       sizeof(info->x86_capability));
> > +
> > +	get_cpu_cap(info);
> > +}
> > +
> >  /*
> >   * The microcode loader calls this upon late microcode load to recheck features,
> >   * only when microcode has been updated. Caller holds microcode_mutex and CPU
> >   * hotplug lock.
> >   */
> > -void microcode_check(struct cpuinfo_x86 *info)
> > +void microcode_check(struct cpuinfo_x86 *orig)
> >  {
> > -	perf_check_microcode();
> > +	struct cpuinfo_x86 info;
> 
> 'info' is kinda a throwaway name.  would this be better as:
> 
> 	prev_info / new_info
> 
> instead of:
> 
> 	orig / info
> 
> ?

Yes, that sounds better.

> 
> > -	/* Reload CPUID max function as it might've changed. */
> > -	info->cpuid_level = cpuid_eax(0);
> > +	perf_check_microcode();
> >  
> >  	/*
> >  	 * Copy all capability leafs to pick up the synthetic ones so that
> >  	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
> >  	 * get overwritten in get_cpu_cap().
> >  	 */
> 
> This comment got copied to microcode_store_cpu_caps().  Does this
> instance still need to be here?

I think it still applies.. get_cpu_cap() copies all reported capabilities
and adds the synthetic ones too.

> 
> > -	memcpy(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability));
> > -
> > -	get_cpu_cap(info);
> > +	microcode_store_cpu_caps(&info);
> >  
> > -	if (!memcmp(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability)))
> > +	if (!memcmp(&info.x86_capability, &orig->x86_capability,
> > +		    sizeof(info.x86_capability)))
> >  		return;
> >  
> >  	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
> > diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> > index d86a4f910a6b..14d9031ed68a 100644
> > --- a/arch/x86/kernel/cpu/microcode/core.c
> > +++ b/arch/x86/kernel/cpu/microcode/core.c
> > @@ -447,6 +447,13 @@ static int microcode_reload_late(void)
> >  	atomic_set(&late_cpus_in,  0);
> >  	atomic_set(&late_cpus_out, 0);
> >  
> > +	/*
> > +	 * Take a snapshot before the microcode update, so we can compare
> > +	 * them after the update is successful to check for any bits
> > +	 * changed.
> > +	 */
> > +	microcode_store_cpu_caps(&info);
> 
> A "we" snuck in there.  How about this?
> 
> 	/*
> 	 * Take a snapshot before the microcode update.  This enables
> 	 * a later comparison to see any bits changed after an update.
> 	 */
> 
> I do think some better naming of 'info' here would be nice too.
> 'old_info' or 'prev_info' seem like good alternatives.

Sounds good. 

Cheers,
Ashok
