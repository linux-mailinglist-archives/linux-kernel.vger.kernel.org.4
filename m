Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDF7213D4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 01:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFCXx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 19:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFCXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 19:53:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584571A5;
        Sat,  3 Jun 2023 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685836405; x=1717372405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uPHc7aR5qV+MFLbs/qMeV+ZNXepaYX/sGLoDxYRBIYg=;
  b=NXVkM45yVkHl3HjrsLCH31/0ub7qe+FdKWs9ljfke+PxGahyCVQvNxTZ
   FN1I19Zcpadx613chjnIg/nGTPj7zrTbPHrkwcwgN5FH6qqEg95aOxVQ8
   adBKixLAaEAsiALYDqyblvEb04xpT5c0BkcADmojERKjEf1BXUBlnvbUr
   /LI5MXS9xo0BH30M6hJXg4ou2G6cW88Z7UgtYNx3xopHh1KwV7lWahXAM
   x3NtnJvsbrE20MBD9zQaUKv96I9ASdWJKlmk0GLfmzLIiSWgk+UwP8Gk+
   r4lY5BcJw85dqIN1xDjqDv9fn71NkRy/oDPHvctQBHFg1jEuCwADb5X+t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="442502283"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442502283"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 16:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702345323"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="702345323"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 16:53:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 16:53:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 3 Jun 2023 16:53:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 3 Jun 2023 16:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmmGBChQoqHQuVt5tW12nRHbqdcS/zsRPrC9vP72ChFnOjCrtRfzTGfzXRLm1Fhzo1GLk+TfexyKoZTq1y3TWqG6dQufQIqS+lp/byTNzXuyWnB9u7icyqwE/vrw/0/byeAy5Rt7jKrT2RbfG3akBX7qB3S+/1FfizjcuLlvNPJPQztWKVoht6BjcOOVlXyiZQ6jZ1EWE5Flq3wA2J/oo6E3+2/pSzhOnTUMyn6OhBhD3MurTj6YwUj2Mg0WOGEBNGE4WnINV3db3pcGDFiUN290NY2gvx/V7R74iT8XZ8QRpbwhnFLGBCContQvu7FhB/4QI4GMTtY5H2xOc8DA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TpvwjCpZY+1XhVXDQiMQWAYFV8/NIaet+zcPPJftBU=;
 b=Qg2mAx6UdteB8vQGHKFSWeQjJ28o16m+F0Q/7kci92CMhWPE9H2VmK4pGVXWed5Z6XEaMraCpjcvqC4hJTo0fqmb9rbgCA35aWBSromcfQ3b0Pgb1hUdIGzm1pnuOewM5txjwa06WK1oHW0pgBsIRz2GU2gMpdCztH1wPOBG6cbKDnTGUJEUvbA0ZJw+qtVElswZ+fEGeHaUXXBQrMiGK/2OGrIWgqlep2EAwIAWFQvE7pLilibiMBwo64fOjE65zK42Bd4VT3NLdrcD7rwWugC1Kk55qhr06CZnRhVrTcwwbNZNQvSMNPoo/2J2+T0YQzC6Pxj+ys+mlerK+qgPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 23:53:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.028; Sat, 3 Jun 2023
 23:53:18 +0000
Date:   Sat, 3 Jun 2023 16:53:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <647bd26937a11_142af829499@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a2766f-b703-41a9-4e86-08db648db3c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlP4XWN1OOFu+99y5uY0/jurehy48G8dJGt2mY85OU+KlCK+ovuWg7I4iQGtJT/Eicrxavdx5fdGyV1+hBP+RjP2034rgUqHUpT9FCqcgeRtBOOdRYk9i56VwRGHn8Hm/dVIVfjmB5DpI5iF2R3AP0+Jt7EzMH6oDdG1mZRvt2qoXf7cl45r6kokhyIx5faSV1RTkfpsy8PZ9XYi7V8kMvAsuTlvcMWdES5PYXQp1ZCY9zOVE4b6XL9SWda8Oeh3RijkH25kqrB8+xX5sc19eb/MG/isuqfmoFIKc73K1BP1Dh1X2OG3UlHUPPfsqlG/QB+O4TrD+zIn8R7AKbOy8+zITSZhS1X6h5xovFnlDPlFRZLsafJrUIc1AN+QcYyVH7Y+iHSR8+XFg3uk+EdQ6kwGdWdAfST+bHlmuJhf8A/fQkVhr7UiRHBNwgKWr+e1PSpjdGtjgkSAvOzxZo9bw9xKliS4Q04tcfka+RALEmBbCjFJ9uKIg5Hyz8mW/aIkfkcCmGio92xIYe5qr8WWXX9o3Q0YH0EgKICVi2jxsLFQNhPvI6y24iVnwBVfRyUV0vhQRTdcAn9w4nShToFdpHaK44fpfw56wt6JErPih7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(83380400001)(38100700002)(86362001)(82960400001)(921005)(478600001)(6666004)(6486002)(110136005)(8676002)(8936002)(5660300002)(7416002)(66476007)(66946007)(66556008)(4326008)(6636002)(41300700001)(2906002)(316002)(66899021)(26005)(6512007)(6506007)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gg4j2PRVIZXc5jQ2VrXiXGENHuqKa2shdvLQI7fdSG0HtbhvlVf9C/ZuKu6N?=
 =?us-ascii?Q?ARkFVHwkAlGP3ouXUFJnou4dlL78otu32/PLUL2IwB/SurxB8lM9n+2QeNRS?=
 =?us-ascii?Q?7LqYoTaYn3GjvV7hXGF9cu2aQqu3YhxKFyrJSX6bTSO1EVXbt3IhFCmlrtOO?=
 =?us-ascii?Q?P8DfXUWr5/PSdehYAwjiptniMaQ9OhNQbV2TUp2qoNqycKrgekz0KxPz+NQS?=
 =?us-ascii?Q?VmR9ets2lQ0lHOw6zh9tDQA8Rn6fHnd0YwRxcHWOslMYqixcyWzI/q1WNhFg?=
 =?us-ascii?Q?XQtW8IepPWHCY/TAXc3f/DgFu8nNAMYETKvL6DnK18FI4j2oD9bBTXwy3tZc?=
 =?us-ascii?Q?bkjirZmftB52JyJ717on2VlJdHUCbxhKl00rxAHjIZOSXau/7HO28rZ7lxVT?=
 =?us-ascii?Q?aI320RRlWbx38hQRHxrxC81GO+6cCBBTKaD7u+KqWxlQLYtdbvxbj8OJoJmV?=
 =?us-ascii?Q?gz5tT/DbLjNc9Qs9rhhzQ8QVVYPwm3QMzpFgFYbIsMCRFslzbQCj3UbE3bo5?=
 =?us-ascii?Q?KyoMs6UPy74Ilcnc09yHeoZB6uLSFF840GetdtlY/Jq2vye/Z+6IPjKhzb6A?=
 =?us-ascii?Q?T5gZ4RWO2g7u+1k2udkUJD2+r/Qqgy6Dv4I7TH/XadvbZYpWyTAJUEGOzj7f?=
 =?us-ascii?Q?wVmACEVYyOD2/0RHVs2L2+9zG9bPMT7xyZ23Eg0N4EAuBtjFqog0bHK0TQB2?=
 =?us-ascii?Q?0PJTeEWxOK7aL9lFN1sICHU9CiGUwduRymz8bYMVc1+mT+2kJuOsdl/icj4V?=
 =?us-ascii?Q?RAQXutl6/QHJvpSbb8O/vB2VqAawFsWLXZ/J6Z0YSITcc1n+4LVxrIOAtw8A?=
 =?us-ascii?Q?v5yn1EcyCyKmmh+yYZJkHYvPXuRI3SBIR+alTb2suZ3Y/14dKbLgoObkz2gS?=
 =?us-ascii?Q?GzoP6z7lH/MOc/Q47oXEOO/SEgpa9AlF5oraVS1zgFX2zy9EBBuKdm5F/EZb?=
 =?us-ascii?Q?2tVfWvCfyfVr9XcaK+mXuItY8F5RkFhdPMD7itz3XumzqebMNO8NR+6RPS5S?=
 =?us-ascii?Q?LpwucfJySODKfL4ZbphFrEl+x532lUMoMAEV2T44+rl1Tv90npXR2WgmvpMO?=
 =?us-ascii?Q?Gpz8Sy36PfNwHzK7jI//ET4HKCz0vT04TylaLtuVOjgQjxFOE5g01Q7ZvLFY?=
 =?us-ascii?Q?TClTw6maiKiWa7I423UNaWGYPKTzfQMKqXa6tdBb1uZlrpo8Qmxua6TvPFYw?=
 =?us-ascii?Q?GTUgPbRDlW+SU64BqXbup3iOSTz86UBOMgnWIE8Djjmnr2oJtVCDvcQWkSSO?=
 =?us-ascii?Q?CbBNBMWeLsH1SkMxoWZ+Fibp7QMdwEdtgAQSAv+h55Ic0bYd6f1r3ZB0tjvA?=
 =?us-ascii?Q?bT+2WPqoBc4VUPebR7qcpo519FwOu1pF3kbxBCnoZ1MXcMsjETwBzuyfF0VM?=
 =?us-ascii?Q?2aootclPkEMxrv2qTiCMNZ7wGQKb0S8tuu2nUIwxyJHOMkf2G9yT3zQPr/Ds?=
 =?us-ascii?Q?YOC1r7hFmP9xowR5AMYgf+m/HhAd8faK/v3JHL6BZNEbZzJRaQRHSEpufpJ2?=
 =?us-ascii?Q?0cdyW0L8iAN3igHqp0wHKrdHc+npKvsyvrFSKu3uK4GxfTkxGQ/W/975s1A7?=
 =?us-ascii?Q?MXDdloshHs4CITPtHYcpgXc5UKu97bGCQwExxKwd3yrgJVF4RSJpG+kNZiX7?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a2766f-b703-41a9-4e86-08db648db3c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 23:53:17.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iiNs+hA9QDWX+2dsrwUAjTQ/DJlIbkKy98PbCsdichMdBjIKkkOG2Hian6ivCTXjRgDYXGc42oPRdv4DG620trRqbab6bomYvReFObXzUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> over an HPA address range.
> 
> The initial use case is the ACPI driver that needs to extend
> SRAT defined proximity domains to an entire CXL CFMWS Window[1].

I feel like this demands more explanation because the "need" is not
apparent. In fact its a Linux policy choice not a requirement. The next
patch has some of this, but this story is needed earlier for someone
that reads this patch first. Something like:

---

The CFWMS is an ACPI data structure that indicates *potential* locations
where CXL memory can be placed. It is the playground where the CXL
driver has free reign to establish regions.  That space can be populated
by BIOS created regions, or driver created regions, after hotplug or
other reconfiguration.

When the BIOS creates a region in a CXL Window it additionally describes
that subset of the Window range in the other typical ACPI tables SRAT,
SLIT, and HMAT. The rationale for the BIOS not pre-describing the entire
CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
future. I.e. there is nothing stopping higher or lower performance
devices being placed in the same Window. Compare that to ACPI memory
hotplug that just onlines additional capacity in the proximity domain
with little freedom for dynamic performance differentiation.

That leaves the OS with a choice, should unpopulated window capacity
match the proximity domain of an existing region, or should it allocate
a new one? This patch takes the simple position of minimizing proximity
domain proliferation and reuse any proximity domain intersection for the
entire Window. If the Window has no intersections then allocate a new
proximity domain. Note that SRAT, SLIT and HMAT information can be
enumerated dynamically in a standard way from device provided data.
Think of CXL as the end of ACPI needing to describe memory attributes,
CXL offers a standard discovery model for performance attributes, but
Linux still needs to interoperate with the old regime.

---

> 
> The APCI driver expects to use numa_fill_memblks() while parsing

s/APCI/ACPI/

Again, the ACPI code does not have any expectation, this is pure OS
policy decision about how to handle undescribed memory.

> the CFMWS. Extending the memblks created during SRAT parsing, to
> cover the entire CFMWS Window, is desirable because everything in
> a CFMWS Window is expected to be of a similar performance class.
> 
> Requires CONFIG_NUMA_KEEP_MEMINFO.

Not sure this adds anything to the description.

> 
> [1] A CXL CFMWS Window represents a contiguous CXL memory resource,
> aka an HPA range. The CFMWS (CXL Fixed Memory Window Structure) is
> part of the ACPI CEDT (CXL Early Discovery Table).
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  arch/x86/include/asm/sparsemem.h |  2 +
>  arch/x86/mm/numa.c               | 82 ++++++++++++++++++++++++++++++++
>  include/linux/numa.h             |  7 +++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 64df897c0ee3..1be13b2dfe8b 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +extern int numa_fill_memblks(u64 start, u64 end);
> +#define numa_fill_memblks numa_fill_memblks

What is this for? The other defines are due to being an arch-specific
API and the #define is how the arch declares that it has a local version
to replace the generic one.

>  #endif
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..6c8f9cff71da 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -11,6 +11,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/sched.h>
>  #include <linux/topology.h>
> +#include <linux/sort.h>
>  
>  #include <asm/e820/api.h>
>  #include <asm/proto.h>
> @@ -961,4 +962,85 @@ int memory_add_physaddr_to_nid(u64 start)
>  	return nid;
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> +
> +static int __init cmp_memblk(const void *a, const void *b)
> +{
> +	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> +	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> +
> +	if (ma->start != mb->start)
> +		return (ma->start < mb->start) ? -1 : 1;
> +
> +	if (ma->end != mb->end)
> +		return (ma->end < mb->end) ? -1 : 1;

Why is this sorting by start and end? I can maybe guess, but a comment
would help a future intrepid reader.

> +
> +	return 0;
> +}
> +
> +static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
> +
> +/**
> + * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> + * @start: address to begin fill
> + * @end: address to end fill
> + *
> + * Find and extend numa_meminfo memblks to cover the @start/@end
> + * HPA address range, following these rules:
> + * 1. The first memblk must start at @start
> + * 2. The last memblk must end at @end

Why these requirements? I worry this is too strict because of the
existence of numa_cleanup_meminfo() which indicates that Linux has seen
quite messy firmware tables, or otherwise needs to cleanup after the
"numa=fake=" command line option. Is it not enough to just check for any
intersection?

> + * 3. Fill the gaps between memblks by extending numa_memblk.end
> + * Result: All addresses in start/end range are included in
> + *	   numa_meminfo.
> + *
> + * RETURNS:
> + * 0		  : Success. numa_meminfo fully describes start/end
> + * NUMA_NO_MEMBLK : No memblk exists in start/end range

This probably wants to clarify whether @end is inclusive or exclusive.

> + */
> +
> +int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	struct numa_meminfo *mi = &numa_meminfo;
> +	struct numa_memblk **blk = &numa_memblk_list[0];
> +	int count = 0;
> +
> +	for (int i = 0; i < mi->nr_blks; i++) {
> +		struct numa_memblk *bi = &mi->blk[i];
> +
> +		if (start <= bi->start && end >= bi->end) {

Maybe a comment about what this is doing? This is looking for to see if
any CXL window completely overlaps any SRAT entry?
   
> +			blk[count] = &mi->blk[i];
> +			count++;
> +		}
> +	}
> +	if (!count)
> +		return NUMA_NO_MEMBLK;
> +
> +	if (count == 1) {
> +		blk[0]->start = start;
> +		blk[0]->end = end;
> +		return 0;

So this is updating numa_meminfo in place?

> +	}
> +
> +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> +	blk[0]->start = start;
> +	blk[count - 1]->end = end;
> +
> +	for (int i = 0, j = 1; j < count; i++, j++) {
> +		/* Overlaps OK. sort() put the lesser end first */
> +		if (blk[i]->start == blk[j]->start)
> +			continue;
> +
> +		/* No gap */
> +		if (blk[i]->end == blk[j]->start)
> +			continue;
> +
> +		/* Fill the gap */
> +		if (blk[i]->end < blk[j]->start) {
> +			blk[i]->end = blk[j]->start;
> +			continue;
> +		}

This looks clever to sort an array of pointers into the existing
numa_meminfo, I think it needs some comments to explain the cleverness,
but I am not seeing anything glaringly wrong about the approach.

> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(numa_fill_memblks);
> +
>  #endif
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 59df211d051f..0f512c0aba54 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -12,6 +12,7 @@
>  #define MAX_NUMNODES    (1 << NODES_SHIFT)
>  
>  #define	NUMA_NO_NODE	(-1)
> +#define	NUMA_NO_MEMBLK	(-1)
>  
>  /* optionally keep NUMA memory info available post init */
>  #ifdef CONFIG_NUMA_KEEP_MEMINFO
> @@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
>  	return 0;
>  }
>  #endif
> +#ifndef numa_fill_memblks
> +static inline int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	return NUMA_NO_MEMBLK;
> +}
> +#endif

Why does linux/numa.h need to care about this x86-specific init routine?

>  #else /* !CONFIG_NUMA */
>  static inline int numa_map_to_online_node(int node)
>  {
> -- 
> 2.37.3
> 


