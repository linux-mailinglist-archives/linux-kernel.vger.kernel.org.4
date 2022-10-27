Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9319060FFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiJ0SIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiJ0SIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:08:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7E2124E;
        Thu, 27 Oct 2022 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666894089; x=1698430089;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GwNVRxTiCYFzojdPwmngirWE3nXMoSVqjyOK4NFJUVk=;
  b=CnnKBHu1+MX+i4VpAN1yNEPUeTusTsaSz53Q/yK1a6XTb71127uvQvGP
   fnZikV0uakdrg8a72L/rOAZVQPYrDwWfo55Aj4nfJ4O64V7uR0sajL373
   Jm0SUK15TE1g94zsM8Y8rOYZ4UCdyWiyB2ZHR9pM+8FqYTJp3rmEtCJJS
   TzsjD5erufuedPby6rdcrE/gA+QpM2JPqg3NhnuPpDjKAeW63La7+321F
   3MJcl6DUKJcZfVCNRKTqJWQfN0Wj3MSJaLURsmPvRjvfV94Rc1FYLSgZP
   O1RJTXAwtmXpm/4qEcvTbyEwkhIoTH7IwSeZ6kv350YxkM68Q9fxhjOp2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="372513804"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="372513804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 11:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="663715197"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="663715197"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2022 11:08:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:08:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 11:08:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 11:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMyl0BmOwrswctK6vkWOpiB+6Rd14NaQPPa/JjW95fzmn24XavAaT8K0eZdWuEfd8Fczno6qSLTet5/EOQGT9NNbqZ67f2xOHTmsYni32v2UHXjoWhvHJBhMb81aiEdkpSaJWf2CI20eHsP7pG43K59NJdRhtlhMCqKPkIoytXI4kcPIAZKNQkBrfI1SFtGwN1N9Fao1W5ZbOxi6mNXOwRiTCEP/cIAc47efWn/Xc2zoqypkxrma7b3vjWW5AEWkIR4tAumvb+gzYGNfQX7nnP3YKHvxJK2uGsdC15A84TyFD8vOLVjAKpw9tSIzD4ctCLy0d4lRC6/aTDxX15JAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diki5L5E3e9R/bCDwCEu7w65ozBI4PfymPB8UE4EazY=;
 b=HeKPADvQEONPQeZ71RML6EoC2mW3e/qUwKIdH2Eh8TKvMF0cKYjX8pSoHYG6JIuKcotT2hZH6rqFy2KHgWbc5prQu32cIlUhGXBmxAEgukMTtbkApGz3wa3SteRv0XztDRA80o1celDWpaeXeYGKyrw7Z8F9+6965QpvF0tF1Og8NUks2xxgv8BPbA4SO2ACB3ZNSeRGlLHkO15+LEPhmopD0zF9S0DoA+kX/UkQoUbXJfjNZBVJRPWp3Eewq3XdyMevvMxG6rBawdoG3ZX2WAvUbhRFq2Wu5DdVmyzkDo9Y4w5mrZRhMAFMyjGZ0eCgXj4VtY0Bre2sfzCPJpGx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW5PR11MB5931.namprd11.prod.outlook.com
 (2603:10b6:303:198::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 27 Oct
 2022 18:08:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Thu, 27 Oct
 2022 18:08:02 +0000
Date:   Thu, 27 Oct 2022 11:07:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] memregion: Add cpu_cache_invalidate_memregion()
 interface
Message-ID: <635ac8f52615_11722294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <166672803035.2801111.9244172033971411169.stgit@dwillia2-xfh.jf.intel.com>
 <3ce6ef93-2f47-eda3-f974-0cfea7f43766@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ce6ef93-2f47-eda3-f974-0cfea7f43766@intel.com>
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: dddd5942-cc24-486a-b12e-08dab8462ff2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9YwZozm1i9rhPSkrgDCUboQ5Tmd2ZykiIGOSO/EyJjnaeR+LFVzk5esWqK55bT6gL8ZHuWVa0DwkSkxK6h1DI2vD6jKmZpMmXXqu1QlPXNAbDGcPqYYy96oW2BDBm4+R4LJRE4oielw7/sQ6WAS2wkkqPBwPgwu72w8tVfcQAQWIIxqokYH5lCaWXUkWaJapyXxLJXmT1St6PcX2pR8F4j1b1nNYOh3Dj9VPYvApBbHnyayI1PFfhXaoZUUOq0g0ozmPBDHp2WstI3N6PWMql1YHvtxYXOsJxDsNVyZkuRHG1jGS21AqJaXtRZ4RBoMazHrkDGLkA7gq8C3+MSf+oDOAHwC5FOBsShMR0Q/Mj+HKMR9D2+xQKDPOO2Gsjye4WA0DF8zS0uRKd9OBR0kI7bG60FmzU9Tmzy8rt2D1VFtw8dHljTB8Sy35uWvDvzs8jBuaMoEujUHWza0xAqmM3YgrPysyW1C/u2kqSOqGfQaCt7/PHdNR9Q52LunxOqyIjpYH/XbNThGBCNBjJq3CJ+RiwPPiuyUgKRXS8AziHGTcaK6oJpMiSX9La7MypIO5lvpSaNepfHcL68g/G+sC75wrjkaKoM4SNbQz16ViGytshygfwEnsBHzR8J4nDVtTzAHb2zZl4peumL94AT0k2/NWyLGsRQk1H0RstbUkknry/B/iERw37wJMftnhViuU3CDWLUrPAoXzjDeGfoibA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(66899015)(82960400001)(86362001)(8936002)(7416002)(38100700002)(5660300002)(83380400001)(26005)(6512007)(9686003)(478600001)(8676002)(6666004)(6486002)(66476007)(110136005)(54906003)(316002)(186003)(66946007)(53546011)(4326008)(66556008)(2906002)(41300700001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grlDp0+gMTktEL5CTumz5WPgolYCgf7W+WiKgFyNb0oIHkm+3evaTpkH8bs5?=
 =?us-ascii?Q?ResZRRlTXH6nvULh6FfqCarn4QvNd/3L7KRRthZ0PqRvHGKCKQCW+HLiSd9q?=
 =?us-ascii?Q?WLbmm7RsFwSuH7Xa360fTRXN+RltzOZbYQd/dk9LrIpenjteUDuPboKUUlbl?=
 =?us-ascii?Q?ePRXyxgk3RRc1KsXjisIVNwqNpr+LaNvPuHnUId4aLIA4ir+8h2a2H2cl+Tz?=
 =?us-ascii?Q?nSzKXrEDxWid5T5xGzJqsJqrd4nUJzvxT0oa10Ztmjwh7hrdl3K/n7n+j4VM?=
 =?us-ascii?Q?M3WoWJLmIdvpO5yZNW+eEfFZUc1NPkpJQz3D3bP0bmgO2uLYjDiBTEQ0oTeP?=
 =?us-ascii?Q?L7U0FFSf9OpnZn/t9mCKiInKphQvgCle5tJy6eTz1DAuAq2b3tSAsT7n8vij?=
 =?us-ascii?Q?f358a3n6Es1j1SLouZimMpFMjowzXAsLsZaY+RbPLXEbSuBW4oa0uSKjmgTS?=
 =?us-ascii?Q?R8F/y5nFP3kgQFvh3BwFIhvjt9OyrE/0fclX31gifgJL8Kqp77gXa/q7wuJY?=
 =?us-ascii?Q?rvkdl0K74pl+7VDCMzDVXikpQerGDUTZC1Xf2J/+f9K7xNhgAp5E2y9diTv+?=
 =?us-ascii?Q?VxaWisHaP18Eq3Jwc4EkEAf0VAhR80MvcIJHdjhthvwf6l8tavBGcxWDGeDC?=
 =?us-ascii?Q?pjT56LVlB1ksVBbzJZptksk/sLuDtAOZqz61+IVRCZj/fW30GFOQV4wWBlkz?=
 =?us-ascii?Q?rwmd44IARCvwUSEaTxLTUnv4TCYxNhllWoVh+SsQSacmfbC79i5saoK36w9g?=
 =?us-ascii?Q?IKFsrXDLbSJDOU+B9+r+hugN0UHJiSLIyHCfbvKuEikAq8sPVKRYU11NjYtl?=
 =?us-ascii?Q?W0y6FmUWoqbOlHY3wQF0LlT6uZaBYkP80CItPaNHlm3nDKoTAiygRUsg70FL?=
 =?us-ascii?Q?nwa6qk5e0KOQG6L7Vw4B2U8zHp3P547vZdP8fQemhrxtM935yZx4HaxNGSPj?=
 =?us-ascii?Q?vF/QxxqanRZP5qLVtXWKrSXYCNOYVQKP2wy0eZcQoXUS0xPzELro8dlNXCXi?=
 =?us-ascii?Q?YUEdiOEYA1k5YX5+r93IqB/qoe6/qVPgS3aMEUwuoN3Fyi0+wx/lttu5Nwp7?=
 =?us-ascii?Q?Gg20XNqq41qo88INhK418ysAmaDHCJgLUZZ9h1GsIY+nYKbcJr/jzZdR8ZRR?=
 =?us-ascii?Q?OD0tDecCMuF6MI4GHw9Oy9WdhOwfD9M76Ahu+oZjfVUVxxUletfi7AYn6o5X?=
 =?us-ascii?Q?XFNB8PQ5d0MWPWbFjSHTRokrv8ngJmIjMUWNxgi1aRLlvy5TVrg2sRHrIHUc?=
 =?us-ascii?Q?t63jPUI2cmsB1lMPEfzinpGSTRQtU0oiBks0u4Au00O7RuWvPiGxjNf+1Y6n?=
 =?us-ascii?Q?y2eP2ZcRIJNohxOrIbbuRdl/W9mOrZIlxPjRcJ7Tf6V0DyqgEn51+5Xuiau9?=
 =?us-ascii?Q?B7P3HyKZpp/LM0hxVmLaw3hvSHFRSViYQbUQCfBXrg/s7Tgo9H+KfGqeVDCy?=
 =?us-ascii?Q?uHIoSzZwJtYjGSNFNvjflO6UzKFhUz9W8cIz2GSey3aNkSQ6/alMPsbUsPAi?=
 =?us-ascii?Q?Qqz/cmu5Dj7PByYQzXZIoMb07bx1QKH5/mtRhKZOfUCp+RB9XvUfCxjBNulp?=
 =?us-ascii?Q?xsJFsgfsZj/vfPCEB8wj1CjlJzY/77G4rqNASQAF0zWQjhN1xvujvRdMvW7Z?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dddd5942-cc24-486a-b12e-08dab8462ff2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:08:02.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edmj+LC92Yb7lvwPQJjzPEmID3bnIgJY3HqhRB0IX0QxsaY0g14cvkzFzrwVuBjWy1ckW7FANb233py8PwVfcSU5BGw+ocy14sqwt27OlHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On 10/25/22 13:05, Dan Williams wrote:
> > Users must first call cpu_cache_has_invalidate_memregion() to know whether
> > this functionality is available on the architecture. Only enable it on
> > x86-64 via the wbinvd() hammer. Hypervisors are not supported as TDX
> > guests may trigger a virtualization exception and may need proper handling
> > to recover. See:
> That sentence doesn't quite parse correctly.  Does it need to be "and
> may trigger..."?

Yes, but I think this can be said more generally, and with more detail:

"Only enable on bare metal x86-64 vai the wbinvd() hammer. It is already
the case that wbinvd() is problematic to allow in VMs due its global
performance impact and KVM, for example, has been known to just trap and
ignore the call. With confidential computing guest execution of wbinvd
may even trigger an exception. As guests should not be messing with the
bare metal address map cpu_cache_has_invalidate_memregion() returns
false in those environments."

> > This global cache invalidation facility,
> > cpu_cache_invalidate_memregion(), is exported to modules since NVDIMM
> > and CXL support can be built as a module. However, the intent is that
> > this facility is not available outside of specific "device-memory" use
> > cases. To that end the API is scoped to a new "DEVMEM" module namespace
> > that only applies to the NVDIMM and CXL subsystems.
> 
> Oh, thank $DEITY you're trying to limit the amount of code that has
> access to this thing.
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 67745ceab0db..b68661d0633b 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -69,6 +69,7 @@ config X86
> >  	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
> >  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
> >  	select ARCH_HAS_CACHE_LINE_SIZE
> > +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION  if X86_64
> 
> What is 64-bit only about this?
> 
> I don't expect to have a lot of NVDIMMs or CXL devices on 32-bit
> kernels, but it would be nice to remove this if it's not strictly
> needed.  Or, to add a changelog nugget that says:
> 
> 	Restrict this to X86_64 kernels.  It would probably work on 32-
> 	bit, but there is no practical reason to use 32-bit kernels and
> 	no one is testing them.

I had to go recall this myself, but it looks like this is unnecessarily
cargo culting the stance of ARCH_HAS_PMEM_API that arose from this
change:

96601adb7451 x86, pmem: clarify that ARCH_HAS_PMEM_API implies PMEM mapped WB

...that observed that on pure 32-bit x86 CPUs that non-temporal stores
had weaker guarantees about whether writes would bypass the CPU cache.
However, that commit is so old that it even talks about the interactions
with the pcommit instruction. Suffice to say there is no X86_64
dependency for wbinvd, I'll drop the dependency.

> 
> >  	select ARCH_HAS_CURRENT_STACK_POINTER
> >  	select ARCH_HAS_DEBUG_VIRTUAL
> >  	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 97342c42dda8..8650bb6481a8 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -330,6 +330,21 @@ void arch_invalidate_pmem(void *addr, size_t size)
> >  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> >  #endif
> >  
> > +#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > +bool cpu_cache_has_invalidate_memregion(void)
> > +{
> > +	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, DEVMEM);
> > +
> > +int cpu_cache_invalidate_memregion(int res_desc)
> > +{
> > +	wbinvd_on_all_cpus();
> > +	return 0;
> > +}
> 
> Does this maybe also deserve a:
> 
> 	WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion());
> 
> in case one of the cpu_cache_invalidate_memregion() paths missed a
> cpu_cache_has_invalidate_memregion() check?

Yeah, good idea.

> 
> > +/**
> > + * cpu_cache_invalidate_memregion - drop any CPU cached data for
> > + *     memregions described by @res_desc
> > + * @res_desc: one of the IORES_DESC_* types
> > + *
> > + * Perform cache maintenance after a memory event / operation that
> > + * changes the contents of physical memory in a cache-incoherent manner.
> > + * For example, device memory technologies like NVDIMM and CXL have
> > + * device secure erase, or dynamic region provision features where such
> > + * semantics.
> 
> s/where/with/ ?

Yes.

> 
> > + * Limit the functionality to architectures that have an efficient way
> > + * to writeback and invalidate potentially terabytes of memory at once.
> > + * Note that this routine may or may not write back any dirty contents
> > + * while performing the invalidation. It is only exported for the
> > + * explicit usage of the NVDIMM and CXL modules in the 'DEVMEM' symbol
> > + * namespace.
> > + *
> > + * Returns 0 on success or negative error code on a failure to perform
> > + * the cache maintenance.
> > + */
> 
> WBINVD is a scary beast.  But, there's also no better alternative in the
> architecture.  I don't think any of my comments above are deal breakers,
> so from the x86 side:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks Dave, this unblocks a significant amount of CXL work.
