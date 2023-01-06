Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D8660865
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjAFUlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFUlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:41:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934686144D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673037708; x=1704573708;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sk8KSnzcWBmWOYkY62YuLKxoWlfZhJIIFMMjXPzDHDg=;
  b=WbyU34zIdZgESPtx11njC/IEsqA4eoi+ojldm9g6fl1I1o3CTUk7EO2e
   000QeNmUsjWxQ5FqTcuDtb/osjD+YXkEVy3ywKn8Z5ERM306EfH/vvQZc
   hWnOSh6vojiVkhmSS1hSlUOOMcIQxOgE0aiURNZY5aQ4Dj8hPvBxKD6Cn
   Eh6ZB037jldutjDWts9+Q300DsGYugGhkySVygaWkoB5GcbCxS+yjTqhj
   fj5utmI3nmbNAJYlFRom3Zk18/Aiz/ihnKZJqO/xUSm3CWv7N8nEhit0i
   iV/yG8EKPtXNU8hOhSWNP60RKwz8dy1/gVowd4BDKjSTY/VqH2PwsqdsS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="349771301"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="349771301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 12:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="649415849"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="649415849"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2023 12:41:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 12:41:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 12:41:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 12:41:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfHFa5GaRri98jiQ3+J9NUAPEAseZrqIdVAdhVflrPGjSecAiqi9Mc47BannJ2/1Mjq75wX/BALHM36ucNi4TBZ9AhQQJuqH46SyzHAl6xu81t5n4W0lJajZ9VPmAe3oSXO/n2jDoGh/TpNKHBetbb3q66Z5UhpOvr8P9ycDrIrDsq06HZ3kFTbQbQ75Ea1oMXNEnu9N3UgPT2tlLOZndbxAmvMnH7zPbpfwuWIZCnJjUjfNDfR/vnIr7LGabbL6JBsokP9JocKKx6Vd+y+z6ei7Oha1Nnl5qK7F2b5BCC6PXUSee+v2+CwOCj0AK88h4seQLBeyTQV/EXwk3VkhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfu96ZWSIahVE6yp77oh30eGIKMIVpd6+pX1xvGqmcg=;
 b=CIEKp2Hksj1Gwhc8njM3/KNzdLbiwMHmgKQjURhV0IkOHFEA7nW42Rl8mngP0OUZzZfki5O3/ZIrOvU+amTpedox/JAvrY/t73EpA6qgS0xA37shS2J3lm28KHQHtfv9qnphls1SzFG6kl3Kl6OWKwArUZOBR83PHvdbGXabLq5uI6O/V3VpO0m1bZjKc6lwy/k7rP6CBDAvjDRSRccYUOPlt1yirq2t7tYV0NRD5mGLwRjde4xf0kfDs/KC71HtH4rnI4jWsLa/h7KxK1YrPCQDUmR5w7U4f7fE+jZYlPwXNalVO2r72wHKOFRtnCQrKEZimpOdCtNBKMsKXeRrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 20:41:39 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 20:41:39 +0000
Date:   Fri, 6 Jan 2023 12:41:33 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 2/6] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y7iHfaOD67UO+lbV@a4bf019067fa.jf.intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-3-ashok.raj@intel.com>
 <Y7XL9Pr9DiW0wdaM@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7XL9Pr9DiW0wdaM@zn.tnic>
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: ededf2fa-e160-4461-3f0f-08daf02668f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQJFrELyLqtPHW3GLbVacY37jCdJQG197L0G0mjmvqbMwrOcFlra5PrXzDPAlfLwVcfgu8Cy6ShQVzGu3d0ZynJHA6o3QOom6/AbO/AF6s76Kh3EHoL0YQYXBAVrTiUnAQPzjS1L+9oUp7Qf4TyzFTzydpLTxIBv3vSCLoijK3tNkoFO1ozll7FgBZBbuaUEHK0Q2e4fdPyfuxnGm3hACdTX1UNgltt74PqiqSLEukfFTD9yd1wkl35KydetpU5Mke84yJRlBJS00rtr8nZZIaTdd4/E+qiQaekJAlqw1q+HdyOsdj8yCaJETqoHDRYBOdpca1eCJZa5E2hmWePhmXnatqFbfK3gj3tdEUw6lLYCFPs63oSbJI5xEPYkWX1e1DXg7vSXi9hY04Fz2hmk3qXwGmRtCOEHL2pLnuX6kfw/I29rtNzfHQHhXB6qHdeRpXlk2popMjC/HfxYZ0136hsDC6IY8QoLJCgX0ESjsl1vpF14t2iel6rDu3kdTLSNtzix2jTqO6K6eOOqvs8G+w5BzgSp6wsH5T9HY7J3hpuWkC/8tCHRLI9AxIcn+vmoq14RTqy4hTUmyFN1KEhdeqW1b92/GMXeIqk/ROwaW3faZ0MSGNUzS3ZF3zp7MpZzjhnsKgLMjSZJWVRlebIBYul4NlJ1XpaDVdVa6gkyUvtHKvaHWuL+i+tQjAk5oVId
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(82960400001)(6916009)(41300700001)(8676002)(66946007)(86362001)(66476007)(4326008)(66556008)(54906003)(38100700002)(316002)(5660300002)(2906002)(44832011)(83380400001)(8936002)(478600001)(6512007)(26005)(6506007)(107886003)(6666004)(6486002)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2J0QbmhYonvhAl0rhSCxucnzijbnVUTBDoGjQUYzu225jhiM/RX1SBhwh3F?=
 =?us-ascii?Q?6RMwtyja+b/i/V9g0YNdm8vIrNP/fG7xidExxP00kiNA5cv2yxGExPtr96m+?=
 =?us-ascii?Q?L6YtiyakCbC2r3Xt64g67tviaVDNBJiYhjbyFMXuQNhaoCPT0qEsTP88tQdi?=
 =?us-ascii?Q?Vfq9o3Lo6K8fB3p5pa2/4vV/eMvFojsG5qDrBOiy/+coJJBGXZ8ZPlVIwghG?=
 =?us-ascii?Q?bbXAwRR92kX1znHePGbzUjrNuo/SNLFyGHNgcHNPQbGU817kQ42YYqsShiQu?=
 =?us-ascii?Q?/duAsE16W2MOaMObC0EUYK3+sIrrLCM1c/6B5YiUhI0UNgMgIX0zHnqfdC/d?=
 =?us-ascii?Q?YzLNsj3gXwSfr/04bUcOqjnvSobG+aN5nxwEQY+xXRT3RASk+4/3oY4RUiAS?=
 =?us-ascii?Q?a+WGnPD0PH46nQyNCf4mTSeVZZPcbhmvAJqt1jptuMAvlOrm5/BCZbqvSlSb?=
 =?us-ascii?Q?wd0tgMJT3g2qIBrCmyzrrcu63NJNyIZ3Vs5Pm1AnyOYVlqZVaw+2CLqUayDh?=
 =?us-ascii?Q?tI0NN+JmgbAmU22Ssz0/dOis3KOBi0MGMgFJd/94dYod7dmf4WU8YrdXf4mC?=
 =?us-ascii?Q?dMQbsx3WftXdUfYhntteMYy6vquiLwYcSh24AEF4vEmqmCoIBnzriL87mzI7?=
 =?us-ascii?Q?qbU9y3WlJctZ2hcflRcYb8j9pLKm7WVe8KlrBSldWZo/dUwInJiq3C4OUe5p?=
 =?us-ascii?Q?B/v4R7koTAfLaH8tJEFfnvmp3U0EHIsx3KYaIawPIVSur8nb0chRW7SJXEyM?=
 =?us-ascii?Q?ybP+4UOYfeCs8j6XqmfAUwhV4inWSIbdc1tKj0ZnHMHxC0jG2bI3OKOHqkCv?=
 =?us-ascii?Q?G/py0lx1lNadf9NNZuhks3yyQm21ZsgSvFbk/j15FAqUJrQJ7Oa4YS2F4x3L?=
 =?us-ascii?Q?HbAEo/+moH6vwqwisXv3fMzBRfPV0Tdriep61egsw7qrDnfKTYFl3dcVZrdW?=
 =?us-ascii?Q?OyVR/OF1RHPO0lgYKd1yLlmvIqfCcn81yOnMXPyaEKIDaK6X56UgmYMiQhEJ?=
 =?us-ascii?Q?08Exxa1DXGsBVmr39R7FDgMDX6+AVi83CG3JF1kJA1bJHU6zrn51uoa9OkhB?=
 =?us-ascii?Q?WJCItgBJnbB9Px1kiYQFrSjesTJtOa4K1JzQN5rasFRPLdLiLRPkGO/RhRm5?=
 =?us-ascii?Q?ea7s4uJKnamF6kRuNg9vHjS7yyyvHmvAYe4ZxgMGRoqKY9pbmiU0RdOS1ZZ0?=
 =?us-ascii?Q?amCC1NfFaduef6XQ51+wgst4sc7C3oIgzduLVa531crxmFAjIGwnFcXUlMPc?=
 =?us-ascii?Q?L2pigBE4oGlGF2JDackZOJu/VwIw4kQQGNvJAdnZP56QzqMSXe1eUw/kXBLw?=
 =?us-ascii?Q?5TLh/V0IomNQ1mnFK9fyXYC6a0ZPtKpsJv4hyEIwlR+p/vjYNcsR9RyXFIND?=
 =?us-ascii?Q?wEuDpVfTZFLEjXlpQxYcx/ot46UecuOIaHS8cCsLLaSxtSEdnhPVBGQhT8GQ?=
 =?us-ascii?Q?sfGi03kbt0j3P5x7t9nYcbx8QcJnp63gNEoxiPtkaj5GCYzkvqxAEwiPOwY6?=
 =?us-ascii?Q?IJ7ST+tu3MD6d12QKZwdRuuPYAydIvHq+oYOh/kqD60om4jdCfUJJbNwf+i+?=
 =?us-ascii?Q?nkSdBYqHuafa/txxrf2s8eOTemqHUyPGrOxtcv8j2n+F1oBVHNFDx0HwpygK?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ededf2fa-e160-4461-3f0f-08daf02668f8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 20:41:39.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIpiY5CEWm0qGyrSK8QAkkxViFYEXOKznO8UWPFkuiSIxTAUZwOLjzfqc4C3aOTE/6kx60WTYwqWRwvCG7mxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:56:52PM +0100, Borislav Petkov wrote:
> On Tue, Jan 03, 2023 at 10:02:08AM -0800, Ashok Raj wrote:
> > Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
> 
> Why a Fixes tag? Do you have a failure scenario for current kernels?

When we reload the same microcode there is no change in CPUID bits, but if
the kernel has turned off a feature, in my case it was SGX. So bsp copy has
SGX off, but new get_cpu_cap() seems to think SGX is there since this is
unfiltered by the kernel. 

This results in a miscompare. I have noticed even when i load a brand new
patch but has no change in CPUID, report there might have been a change in
CPUID.

> 
> If so, then it would need stable backporting.
> 
> If so, it would need the previous patch too.

I think so, but your call.


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
> 
> s/microcode_store_cpu_caps/store_cpu_caps/g

Yes, i'll change.

> 
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
> 
> Might've changed how?

This comment existed in the previous microcode_check(). I just moved it
around during the refactor.

I suppose new microcode can bring new features and this max function
enumeration can also change?

> 
> > +	info->cpuid_level = cpuid_eax(0);
> > +
> > +	/*
> > +	 * Copy all capability leafs to pick up the synthetic ones so that
> > +	 * memcmp() below doesn't fail on that...
> 
> split that comment and put the second part...
> 
> > +	 */
> > +	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
> > +	       sizeof(info->x86_capability));
> > +
> 
> ... here:

Will do.

> 
> 	/*
> 	 * ... the ones coming from CPUID will get overwritten here:
> 	 */
> 
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
> 					   ^^^^^
> 
> Yeah, what dhansen said.

Yes, I'm changing that as well.

