Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E253C72430F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjFFMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjFFMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932A10D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686055802; x=1717591802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5/CiWMwPLxiCBFfB9RhhWdUA+vRiyBwcCR1/XMARrYc=;
  b=CodOeBWm+3zlMqPrOrVKVE6z1qhyiy47Oe4oHx2qPc6i6V2geJUA883b
   jJ7VZ6CiGc1XbQayNzAUP42UeQc99T0uXsj+t4hc+CFR5diMMmhQuCxse
   68rGQWctlPvkqqBPZAFOZ6URG9zvPrrl/FD+8F+pJon/ttlMPzKCiNeV0
   xLqceifljuyw50al625jaPt4P831N68CmG8e+Gz2A9xSrzwGWdNLYeVl8
   cZRFfdRJUmuV9pLRUnmPy4BE/VkP9WT7/0McQnZ9s3PVuicmHmr/rbVgf
   Xku/JasrBgd/faVKh0CNvr4mHRjpCPqiEyic0taShRn6F9ShwzyffaEJP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384970913"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="384970913"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778986529"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="778986529"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2023 05:49:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 05:49:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 05:49:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 05:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAaKjcNdwiCIvh71JYos+C+VFwjhroSt/OChc3PqzOvhRMz9qePtcHoMkk++5PMbOE5ntqW5kLg6BMdACiIlvTHmBNjb9G49lXQ4EQLXH0VYbk/cv3rvNycFtpnPRImwSO+9gACUrHadDorbxe1tEGVVgZ8at32yzMjo7YjLD5B0aWL0qCPXXHpcsRw6uRfRWHrDB475jcmL5nFo7z6dpb8WHT0+IDKLemAZXu/gvLK7PxmD9AdPBGQdVaMfmBhy6Vh6O2HKiajZeEm8N10XY7nTlsnVWCLDSyIBCOq/ppoDnmOHukKvu+CxVyn8BDHzxR/5zVgLL2rjEwKF/ry6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QBnj3JDYbWm+vCVz4Req4p39XjyWcAa2WV2MGkaSFM=;
 b=gDKaNQoHeAHtck8uT9R7FtZZjPgpkMBMRODEiTzYUZjaAn4SXKNGa2oerC13MhdRQzGFsj7XRPtW3TZSBaKEC3DbHXGrUhBq/l8PKOyoA8Mm/PXKxKRFAp8h23JNvdqaDtHpsP1hKStWzPIM5MmQSSNAHfC1DNfevPMUUZ7E1/V5D7hxyzM1y5arwc6jm/Mp6/Bpss9t1sy8LrgLWvWCMWSw/d9mv9Ti90znEMNF4N8dlkEUPnYNkbhtdmqvYxsLpDbUDWgWGpx4MlOf2UCQAFOqOX39FRBYS+jNf3ifassF1Os39tbR41l8t3SfGMNzlEbChYdQz7Z4XSjsOOzLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 6 Jun
 2023 12:49:55 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 12:49:55 +0000
Date:   Tue, 6 Jun 2023 20:42:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chris Bainbridge <chris.bainbridge@gmail.com>
CC:     <paulmck@kernel.org>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <ZH8pyG1SyfGxQKAm@feng-clx>
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
 <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: e41ad189-d021-49ad-a9ab-08db668c8762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UOoifzx1j8B/Ndf44UxaQ15c7FxKVcvY3HJpAbwRimfeHjUvWkgOg6O+amIYY+ZxO5CeTJXZ+eI8FTNkaYPWUb3EMnSjFHZi2GOd4f5u+5Q3F23d3EQcst8Nk9Qz7xt7sdNCeX3/DoM/xHS/0rBR1Csz5WfA0UDNaDtoTpudnscj+y7sqCR2S5KHKzI7PX8uSmfCl4B3rYHTXMDz+aqSEdFbVorj1KDYQpUdBkQo+W8gRP+/0pyURYsZRse3lwJ4SYype6ciwmY0Z+VPKlN/phvcAd9vxeXhFlWNG5Hi4M9C+0ce0hiMk+7RepKSG4AXFe6/qNpNB0EG8sXR8Q9pKeeAAN2kNdReUdSJXGx5nGISZPHkZFpieYZGyhn66Mw/PgsoiDNkZ27aYHu2HHCn67+VIAi8tuc0lKhX+UArX4GIE03pU3VgVV4BNXKxJYSrabIJeVIQbW8L/lvHZOLAvhP/BU+dnJXpo+r4hB6SwLGVbwROO1hpAb+Hi6+IQ4b9dq10yDzp/X5KX/pscaJxiPiWQdDI5LoRY1RcWsB95bU8KIACjxDFy12h9nScGp1ndzXtrna2GkVtbLbhjcGnTNdePRjTt4dmvCRo6+uXbReTwAweuNqVRHTvzyBw5MH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6666004)(66946007)(5660300002)(9686003)(83380400001)(2906002)(4326008)(33716001)(6506007)(26005)(66556008)(186003)(86362001)(6512007)(44832011)(478600001)(66476007)(8936002)(8676002)(6916009)(82960400001)(316002)(38100700002)(6486002)(41300700001)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FkwFcuM7sGDzGfTZsevYnY3qOatx3y68Qpf/5fKlKAyrkEcPnPFdWWFXOyVs?=
 =?us-ascii?Q?rszvQ8K5Amvt6i4OtYjI+SmwIGy+YTZhIRrMHqNYo6HNsUMbbzZcsXF1KOqD?=
 =?us-ascii?Q?g8yWF9kKe2zBXWhOYx/DJ/eMpsnTbcNZxpyIQElfapCTJdpzN4BSovdiiUVj?=
 =?us-ascii?Q?FXsx52QHeY7/2P/G8sL3aVYJle6nsnlt6qiCty0beGtizkWkhpPYlhXcLtfw?=
 =?us-ascii?Q?llq5Eze7JfiYJW7VO7lrInW81K/u2Pu1kE7sGYOLKjz/trcfxFpByyFR0LQc?=
 =?us-ascii?Q?mj1Hpw1geS3Nh/KwCW9krHS2qayGOOEsa7CE5JV/X/IbhDVS8J2kjYR58+GS?=
 =?us-ascii?Q?R3r37OAFF/naIRs6o0d3VNZQU1W3VDxFwftfnaOUTc+p5pyle7Luag/pjdlT?=
 =?us-ascii?Q?MJr6BUHA6xZiCFUbZDtnesj5HlcNLT2C7JzZDMPaLofHfu7pSU1LR6R/mbt3?=
 =?us-ascii?Q?yAb970p4TrEqtvcoNXIukX+xnYwCH3sl32de5sbQe0hGSE7AOgLJGItapvqp?=
 =?us-ascii?Q?uTyG++kpheeqFEEb399kx6EsYqbKYlrO1Aq1sPsgmPoA9aNHYLI8GcI8unUQ?=
 =?us-ascii?Q?aZVmNSzwlb7Q7M6cHRi9AoAKxV4KOrNqDBZ4wL9cm9YRd6hH4C7plYHmouMP?=
 =?us-ascii?Q?92xdpC0mYwHw7BKiweDl7ysfz+PHsn9aWXYryvvLTVv0M0CE6/lMiYkzWUK0?=
 =?us-ascii?Q?coDG2Z4A+xhHgMsbVZvYIvfFQ2yYjTWl87NQRHGSOlF7ZNv36unjryBg7r8o?=
 =?us-ascii?Q?cy6AnP5Wof3qO9sTtCYLklPup0QS+WKZ4V5PQlNE/hCOL5gVD3b3VoHuNH2A?=
 =?us-ascii?Q?CsknnCvKE6SBTXyWKu0wC3WVbESAQ8Ue7m7IqznJnk9umEIE0pHjfLy83P8r?=
 =?us-ascii?Q?Bt/eq5Y4syMDmEPocrDSJFcEG5N/HJeNN9+xud6MvR/t+W9Ky5tXShiEoa/5?=
 =?us-ascii?Q?oJGUpzRBc6mpBVATkOffWdsR9QQuICWUD69bxZi/bVGQOOyJIN0pDnbUlPma?=
 =?us-ascii?Q?oD4ZMwZibVaEmXCnAQfz/RgRTAtSZq/kfvtYG9SWK9W0ZM/tHj8PpUE4Sqso?=
 =?us-ascii?Q?shbReC370HXsARzHIhoFI/xz2ZmI6vwbs/TZ685k3oc+TOolyr2sohlaY6fn?=
 =?us-ascii?Q?+32UAo+cJPshd3hAv7csSx4RkRAXTnU7/95WbB5KeQhdAkGrH7uS2C2++w3t?=
 =?us-ascii?Q?PzHK+7akpEhaa0KquHWRXiJQjHol8pJx+oMx0pLovlf43p8RUPz1JZzsDdJR?=
 =?us-ascii?Q?DiteV/J9zMG3h2YK4gdnYadxYsplkstNPPDlmQunwYCuggg2XKZ7x5WcIcLP?=
 =?us-ascii?Q?0wlwxLEnQn88UHntct0Xc+JXuilRB+7Y1slKogO2NWHzeJE+eQbujI83YzDO?=
 =?us-ascii?Q?UZGjBj2MZKlK0WV2NMCRaKS/I5bZyMBHtKJKCc2Vygr/ZewozhifNY6FAmx7?=
 =?us-ascii?Q?yb7cStEFIYGn+MY3RUbP+IOMxMuEtnSbAdMg9wKYsrRDTbEPMoyPu2KsvbXq?=
 =?us-ascii?Q?Fuj96rszJ0pm1TjYVZXnwy6IdBp3qLW52S3wMczgt4Mg0jTWjbeiqKOq974U?=
 =?us-ascii?Q?shxot1nlsm5n4Cmjf7iXofeaeKFz9l27v4isN1qy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e41ad189-d021-49ad-a9ab-08db668c8762
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:49:55.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PA/QK7RkY7wZz5edyOJln4G5lV8gWTu09ROFBsPI4PXEWKOGRWFsZL5xe2XFM/hWOdvbY9wKkdLKFUGdaIg6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:28:50PM +0100, Chris Bainbridge wrote:
> On Tue, 6 Jun 2023 at 12:35, Feng Tang <feng.tang@intel.com> wrote:
> >
> > Hi,
> >
> > Could you share more info about the hardware, like which generation,
> > how many sockets or numa nodes (output of lscpu, 'numactl -h') ?
> >
> > Thanks,
> > Feng
> 
> The hardware is a HP Pavilion Aero 13 laptop.
> 
> $ lscpu
> Architecture:            x86_64
>   CPU op-mode(s):        32-bit, 64-bit
>   Address sizes:         48 bits physical, 48 bits virtual
>   Byte Order:            Little Endian
> CPU(s):                  16
>   On-line CPU(s) list:   0-15
> Vendor ID:               AuthenticAMD
>   Model name:            AMD Ryzen 7 5800U with Radeon Graphics
>     CPU family:          25
>     Model:               80
>     Thread(s) per core:  2
>     Core(s) per socket:  8
>     Socket(s):           1
>     Stepping:            0
>     Frequency boost:     enabled
>     CPU(s) scaling MHz:  35%
>     CPU max MHz:         4505.0781
>     CPU min MHz:         1600.0000
>     BogoMIPS:            3792.93
>     Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr pge mca cmov
>                          pat pse36 clflush mmx fxsr sse sse2 ht
> syscall nx mmxext fxsr_
>                          opt pdpe1gb rdtscp lm constant_tsc rep_good
> nopl nonstop_tsc c
>                          puid extd_apicid aperfmperf rapl pni
> pclmulqdq monitor ssse3 f
>                          ma cx16 sse4_1 sse4_2 movbe popcnt aes xsave
> avx f16c rdrand l
>                          ahf_lm cmp_legacy svm extapic cr8_legacy abm
> sse4a misalignsse
>                           3dnowprefetch osvw ibs skinit wdt tce
> topoext perfctr_core pe
>                          rfctr_nb bpext perfctr_llc mwaitx cpb cat_l3
> cdp_l3 hw_pstate
>                          ssbd mba ibrs ibpb stibp vmmcall fsgsbase
> bmi1 avx2 smep bmi2
>                          erms invpcid cqm rdt_a rdseed adx smap
> clflushopt clwb sha_ni
>                          xsaveopt xsavec xgetbv1 xsaves cqm_llc
> cqm_occup_llc cqm_mbm_t
>                          otal cqm_mbm_local clzero irperf xsaveerptr
> rdpru wbnoinvd cpp
>                          c arat npt lbrv svm_lock nrip_save tsc_scale
> vmcb_clean flushb
>                          yasid decodeassists pausefilter pfthreshold
> avic v_vmsave_vmlo
>                          ad vgif v_spec_ctrl umip pku ospke vaes
> vpclmulqdq rdpid overf
>                          low_recov succor smca fsrm


There is a commit to lift the watchdog check for morden qualified
platforms: b50db7095fe0 ("Disable clocksource watchdog for TSC on
qualified platorms"). But the patforms need to have 'tsc_adjust'
feature (has a TSC_ADJUST MSR), which can't be found in the above
lscpu info.

And I'm have no idea if there is a real hardware/firmware issue
or just a false alarm.

Thanks,
Feng

> Virtualization features:
>   Virtualization:        AMD-V
> Caches (sum of all):
>   L1d:                   256 KiB (8 instances)
>   L1i:                   256 KiB (8 instances)
>   L2:                    4 MiB (8 instances)
>   L3:                    16 MiB (1 instance)
> NUMA:
>   NUMA node(s):          1
>   NUMA node0 CPU(s):     0-15
> Vulnerabilities:
>   Itlb multihit:         Not affected
>   L1tf:                  Not affected
>   Mds:                   Not affected
>   Meltdown:              Not affected
>   Mmio stale data:       Not affected
>   Retbleed:              Not affected
>   Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
>   Spectre v1:            Mitigation; usercopy/swapgs barriers and
> __user pointer saniti
>                          zation
>   Spectre v2:            Mitigation; Retpolines, IBPB conditional,
> IBRS_FW, STIBP alway
>                          s-on, RSB filling, PBRSB-eIBRS Not affected
>   Srbds:                 Not affected
>   Tsx async abort:       Not affected
> 
> $ numactl -H
> available: 1 nodes (0)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> node 0 size: 15331 MB
> node 0 free: 789 MB
> node distances:
> node   0
>   0:  10
