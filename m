Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A073D198
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjFYO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:59:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08AB1A4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687705157; x=1719241157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8D7Nifqb2KeLvtDkW4nqmVtrks5c8pYCRyWH4oPXmW0=;
  b=AIkgX+UclHiOeOMQaknPmwfMHsUsu7zs8zdVTzxd1YWWdLK2PFUJary1
   WdWlGU+AmhIuP1eAulQrROdgl9sX85tLfZhAHNxdaS9qKVC20tKuMjQSm
   CnQNoZfOjIOqxqenfqXsbfFVxlBRd6VF6M9kTMhNKS+T+JyEeqIzinsNE
   AUTZGzjaNLom3qIc5nFdIdpIYnB/cMKH0hLFIQ1h+5HR3IJUTVdcBr7th
   6r3YBJSi0XmoECeqUdBgm6hVv41stm1rFb27v4y/Y+F4367GyS63CDce6
   JxBPl1K5V0K51bdFdzH3gvnSk7vI1zBDc4f55TxhOXjSrPfANBtjFnFVe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364522064"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="364522064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 07:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="666026950"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="666026950"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2023 07:59:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 07:59:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 07:59:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 07:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMTIcsfZy6+1gJGcP1SzNMv6KS7JXezjduJmTuXPmNxnC4i6gSRNhpvKlXUC7otOCE5p4SSB8qsZNielb4Ye7UKsA2nqWm4lz/eYYKeCimzL94p/GV9t2k1aWxMaDfbFV2MB/Q1HKP0ZbaDy4iCXB+Jri4S8yxQLuRto21IlN6703Io3rEYWz1p1SApJTvjT5kknHYTMzW9esURNz903E186+kQzh4YEhEabe33jQJiOBDa9KNJdvJtiL5pykzy4M8f159vjqAS0TBYhY9kX2GOzb7OIFAvE4WWEyV8S7SH0+er9gvr0+f562vzs64dadQWHByjmF2MmuBiIdm2JJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNm4cMbP3iISmwFUsUXPEamToj/ri4iOqX58Gq1v8rY=;
 b=Rvj1WQL/OXJxY47tiopmPMYxnTBJHtNuIaYwflwjr1gRQbmRr3Qac8RKKZhN0gKWr+8mnL6sVaYsA3vln5XFYc2WyBI40xpN/JdMVVB5C6z6xmLat0GigRa4h5UbBnNjDbQlOabjJ5hfSIe8up92uqh8LRzwZXqo0DxRHSJdlnJc0svTgP8/dPoNXIqSiAPffkROz+yG7EcYwsaIXuLPwsyfwJzjht24EXAM+n0FrUeKyf4pAq10sp5M9B7+0RXb6KC7XNXyD2reRph+z1Y4b1mht8G2Ny79+Rp+uoDlVtZVjNq/dKudX9Tnatyw0EzHubHVKEpNVNowK5WmBj+FXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Sun, 25 Jun
 2023 14:59:13 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7%4]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 14:59:13 +0000
Date:   Sun, 25 Jun 2023 22:51:52 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZJhUiO+bdBoLU5WF@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx>
 <87h6qz7et0.ffs@tglx>
 <87edm36qqb.ffs@tglx>
 <ZJW0gi5oQQbxf8Df@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJW0gi5oQQbxf8Df@feng-clx>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BN9PR11MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a45719-b014-4ab4-c184-08db758cbcd9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nN+GfSWT7UthdGSrKVtvvDNTArlriAW4oOAmQzGn5ltud4LvD9waZ5slGwp1R9nXWtM6NZsHZhWA992cG9s2AoAgqY5Rhwz8XKGSuGMfhmlwmGSgRpcchfAEdK/xAWr+QzbYDUVrWQd1lFvyztt20V2UzbGjt62PIFR6IvcRD0wj/gGlpdXUtJHmf4qqmpawyONz/HeOtCyh2Mj8hYL5Dz5PMJNs7PX0ABRzUDNi5g9l0nxoFTKcD1Et02sjEQvKchCvwtaTOBYIHFsaIFOwFQrrVz8t4SzxDZwmUyW/LmJRzEztFsJ2zeD5dRQ3odIb54Ba44MwDLkqWPL8WclRpJLoUcH5ChG8uGPoWd7g5Le38qmNMoQOB+kwrwrSBXUDcrIpYLHeTjmh6cipH/27tv6LnKp7VOLmVxEc8lvGp6SQJH7V2qRQhFTi1ZINF1JdlZp/yNOgHEBwPN2Z05ttd2DIYBr0Rd+c/YfOv7rWKtO/plxXeajqpExtOZVUzfP/Jls7iY/FcFdQP45RJZ8cbyF9hhmj3YoG9Jn+DvDU0UVOUb87OlH9cup6dqRJn8xD6KuGrUKOgN+exyogrIS1tZ6Nf50ZWw6LQ6hi2BXUl4JyohXHa0EX3Bi/tueSEl/1CANXZ5hBvxfMB6D1eLuc7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(26005)(2906002)(8676002)(7416002)(83380400001)(478600001)(66556008)(44832011)(6506007)(9686003)(6486002)(8936002)(316002)(54906003)(6512007)(6916009)(4326008)(66476007)(5660300002)(6666004)(66946007)(186003)(41300700001)(82960400001)(38100700002)(86362001)(33716001)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNeSizur6QfxvEJewYAw+ts4ypujx38ERRjpuEJ4sQhAyLAtZqu1s05YsvG8?=
 =?us-ascii?Q?Nhllgaap/WN2MAMm8mpoDNaBlRWgSLYz89uo6k4Gj+BJhcJ49pHa4siGSfKU?=
 =?us-ascii?Q?rT63A/d5nknLz/UEhCxQlfB6+UGb/g1SqNa0wlUfXUY9sfnZMDuJ1WM+cb7e?=
 =?us-ascii?Q?xb7rUb5Oc3rUG+BEvNmWCZng13veGKkwb40yMki1MZpYhT9PxtDqEcH7VOTU?=
 =?us-ascii?Q?kaw/Cq6yBysuZHmov0VqGF7cWm6Oy70IDm+WRKfuUzjCR22Kt/3W9uOTE5BG?=
 =?us-ascii?Q?eDKrKAYxYrqHcnO2wBOTnXgw3LQAli4f7YexQJ0dophp46pvNkkrKEE2LQA4?=
 =?us-ascii?Q?aZCoTISOS+ZMqj+eGaZsmEqCnR4gCQlkGdccU6ff1Ul0xUaDsxsQerG38+4X?=
 =?us-ascii?Q?kxP5hyNW/TL50U9njKU3D670WplHVPniydxBWmT7LyRYBLqPcgryOEosHkVt?=
 =?us-ascii?Q?ByulvzzmMx15Xl7A2DWkFSx1dGSA8d8Z2bJRdqn1IZG/AB1xeb76Jkz4hmFV?=
 =?us-ascii?Q?WrPPSwBktU3wpmErVZ/eefI7p4A0pfLAGJ7PlG+hI4nK21yIvWnsu+/uI981?=
 =?us-ascii?Q?LEYghqtz00/iyuX1ByqGsMN7tA6tdGLHI9ob41SrmlCklDNOwTkv7i5DB2oY?=
 =?us-ascii?Q?7ZQQD7wXq5VOOb7mwuLnDP/HicwSxAMd7bpHSxSlqjLLlkdtg+xlL1rb0wMw?=
 =?us-ascii?Q?2cjhSsF35b/n0MRCnWZkfypdKc02tBE4QG1mUK5UWIF3v7wCJU18Q9Y68heF?=
 =?us-ascii?Q?m52aQ34MnzdJoU1WtciNHBjo2tjSPfUxtx15V2Qs+iKPxeiH2mjyCG57kulE?=
 =?us-ascii?Q?byLAJ9pi7Y/jXxm69b1Q/2xyMYWyOMdzGACVwp05tci9GNiZioC/yRNJuace?=
 =?us-ascii?Q?KqVz4AHWopHam8qEsr0PXcVkj4M2zej+b1o0PaSRsIE79JxFw93Y4pf9D6XZ?=
 =?us-ascii?Q?Mq6FQmFBXrM8gNhqyvj4TKEQ065+SD1aBiQuO1mIHBlU+YBmJBGPCx+hopmf?=
 =?us-ascii?Q?AV7T/HFRirgm4ULU0PzR9kN+3yq37cNwnKrLUovSbQqXEaWpFRl2LQsMYd0L?=
 =?us-ascii?Q?L6PmOG/GPq7tOcgBy6/wk1VKZ0EuCzclp5I50z96TMbcb8kxBzajGQQj0QII?=
 =?us-ascii?Q?4DeNWL69dDoBUNYVxp83+0HqJVZUBCUU0PQW1qVaFuzA6X4NkJVcWAkJpsFL?=
 =?us-ascii?Q?EFxK8VmbE+uK+qeRSdISyvWAXvHeDj03nrfZeshTxpui6fU0ZaqeZo/VL5nF?=
 =?us-ascii?Q?E1+gZnCdLlBVd2P3jQFHqsQPhhoyQFBbSIqC/7sMdJHZ14wrl+xWJjNMPHse?=
 =?us-ascii?Q?eq10N4g0GFJiCmQKD53PU5H7dASSK2tCHx7NryJ5yBpXYnJ+c2m4WtYeyztv?=
 =?us-ascii?Q?ifaUHMxS+ntL0ZT6ZllMIERZ6RvdprwuD3KIeEXOG5XW58wpFVLGwv0a+9lp?=
 =?us-ascii?Q?pUJCfH8ECO0gDOrIN1IjpMEccuwFWxzvK/1TKZhAVWjIaxx9f3wrvBRcyYOZ?=
 =?us-ascii?Q?4mS9JmKeGELK/bvsZEfyWcKvNDiUlEtynFQ+6lpV6z5defoVugab6OwDKy7K?=
 =?us-ascii?Q?BGWHW7WOoow3AOuzwYIkOZf+y8g/dVOLUsOIYnJa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a45719-b014-4ab4-c184-08db758cbcd9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 14:59:12.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXHKorAZtIUgFRpNCGiY0p+qxFxMYw7L9oqcyslpzUuWlgu5/C7IxAggesbCHB3GjdQ72q6UvuFJoznyizj5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:04:34PM +0800, Feng Tang wrote:
> Hi Thomas,
> 
> On Fri, Jun 23, 2023 at 01:07:24AM +0200, Thomas Gleixner wrote:
> > On Thu, Jun 22 2023 at 16:27, Thomas Gleixner wrote:
> > > On Fri, Jun 16 2023 at 15:18, Feng Tang wrote:
> > > So something like the below should just work.
> > 
> > Well it works in principle, but does not take any of the command line
> > parameters which limit nr_possible CPUs or the actual kernel
> > configuration into account. But the principle itself works correctly.
> > 
> > Below is an updated version, which takes them into account.
> > 
> > The data here is from a two socket system with 32 CPUs per socket.
> > 
> > No command line parameters (NR_CPUS=64):
> > 
> >  smpboot: Allowing 64 CPUs, 32 hotplug CPUs
> >  clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
> >  smp: Brought up 1 node, 32 CPUs
> >  smpboot: Max logical packages ACPI enumeration: 2
> > 
> > "possible_cpus=32" (NR_CPUS=64) or
> > No command line parameter (NR_CPUS=32):
> > 
> >  smpboot: Allowing 32 CPUs, 0 hotplug CPUs
> >  clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
> >  smp: Brought up 1 node, 32 CPUs
> >  smpboot: Max logical packages ACPI enumeration: 1
> > 
> > maxcpus=32
> >  smpboot: Allowing 64 CPUs, 0 hotplug CPUs
> >  clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
> >  smp: Brought up 1 node, 32 CPUs
> >  smpboot: Max logical packages ACPI enumeration: 2
> > 
> > But that's really all we should do. If the ACPI table enumerates CPUs as
> > hotpluggable which can never arrive, then so be it.
> > 
> > We have enough parameters to override the BIOS nonsense. Trying to do
> > more magic MAD table parsing with heuristics is just wrong.
> > 
> > We already have way too many heuristics and workarounds for broken
> > firmware, but for the problem at hand, we really don't need more.
> > 
> > The only systems I observed so far which have a non-sensical amount of
> > "hotpluggable" CPUs are high-end server machines. It's a resonable
> > expectation that machines with high-end price tags come with correct
> > firmware. Trying to work around that (except with the existing command
> > line options) is just proliferating this mess. This has to stop.
> > 
> > Thanks,
> > 
> >         tglx
> 
> Thanks for helping on this.
> 
> I run some tests with your patch againt latest kernel, and found with
> some "maxcpus=" setup, the kernel will soft hung, that it will print
> some hung/stall message from time to time.
> 
> My test machine is Cascacade Lake AP, 2 packages (4 NUMA nodes), 96C
> and 192T. The cmdline is "maxcpus=24", and 24 is the number of core
> per NUMA node. Don't know if you can reproduce it with "maxcpus=16"
> on your test box.
> 
> The box is in remote lab and I don't have serial console, but a remote
> console, and I took 2 pictures of the error message (attched).
> 
> Also I will check more on how to debug on this remote machine.
 
[ Above mail was auto-rejected by many mail servers  due to the big size
 of the pictures ]

From debug, the reason of the hung/stall is detect_extended_topology_early()
is called by cpu hotplug after boot, where there is "maxcpus=XXX" setting,
(#echo 1 > /sys/devices/system/cpu/cpuX/online).

It could be fixed with below patch:
----------------------------------------------------------------
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 828c1f7edac1..1ff73c8c4972 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -29,7 +29,7 @@ unsigned int __max_die_per_package __read_mostly = 1;
 EXPORT_SYMBOL(__max_die_per_package);
 
 #ifdef CONFIG_SMP
-unsigned int apic_to_pkg_shift __ro_after_init;
+unsigned int apic_to_pkg_shift;
 
 /*
  * Check if given CPUID extended topology "leaf" is implemented

----------------------------------------------------------------

I also tested 'numa=off' and 'numa=fake=8' cmdline parameter on one
2 package Cascad Lake SP and one 2 package (4 NUMA nodes) Cascade
Lake AP, and the code works fine by giving the _correct_ estimation:
  
  "smpboot: Max logical packages ACPI enumeration: 2"

Thanks,
Feng

> Thanks,
> Feng





