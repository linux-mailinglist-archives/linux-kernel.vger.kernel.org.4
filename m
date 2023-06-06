Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB6724E4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbjFFUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjFFUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:45:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D91712;
        Tue,  6 Jun 2023 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686084357; x=1717620357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NP4X3G2dcPJm4KsWynD5Khn1ktN6ZJJRrZ3JbQhAMT4=;
  b=cI88bZOJE6fAOc+1sKA/dTcu1LGWkU5vv8LL7wyMFpUdtWiTE5+nOl2S
   v33EeK4/TnHKzMxppXAnNRvSZ8M8xAfN4821hMXukcAkieaom/+uECwYr
   gRfAUdMH8vR1Xc4NeSRwg3+sPYZjshVJS8SNt2Gv59w0yTHGRV15mhsuY
   QH8TMNteSnh4QFbxAyk8znat2BaHfY9OT7eXpXbvXMS4ARJXl7gJi6RjB
   UPVZ1LJBBAiAtUlS97irFZRjFpXWtCEMN2wppaSQbrHEiHYdUcQwbh6AJ
   WH7zm0dKig1pScXAzaGnMkEtuZK/hdv6AAR+5PkpzIzCrNJBmUtcdyHh3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346399938"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="346399938"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 13:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703344168"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="703344168"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 13:45:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 13:45:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 13:45:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 13:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxZWgyyNhxQMGZHGSxnKiR1Lxg9HFUOH/amhxBzjs4G5iWV2zOownoDxUEbQVW+ARNsWUdzMJIs+6pKXVeIdL9CoxRuXk1oJ9vClNSWl+MZynZIudhSj1Q4rrOqTmqO/9xiHXyIiS9CosH6Get1bJNydD+3BTtiArCPqcLOD52iuGYvjcIjppdlZt5QUu+JuQyTDLyq5ZmIcjZyOOj4PertgVArmvUelJhfBjyhIbGmqjDdVUsX83zjoDS1JDBw3eKezdj/EXpi54TMsQkUM+ZyYq4oKUgTzOY0YN9EK7QgFMBwL8CDoVeSekTEWGjfDcShSniTe+xqDySMCLLXNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilP34sN2c1ohWvBaRB6zsS2PDIYMxli0JnXkbwa7BKE=;
 b=W+1daoBkZRY/frLHY87x7t3kHzUrrfQQZzzygJbnZP9Koe3nGTS5shAvatmgfN7z8e7S7o4Ce+r0+YsKtUNDG5kS2rLt5t2gJ03WosgNFyJhuG9wEx3asd251A1lPZ8vCCqqD1aWrDchxFSthNpqlPt7321iStxLMI+VIU+ZH4NOHpxyY2qeW0zMUvarHRtDLfsopAe3xfX0GQlDibXQA9D4abAyBkFbRHGvuM+yOQhRlNDdxXqtCvyknai2FJvr9IkaKGi14InHBa2H7GEEcgMUZumoqAmWlBT/3oXOkV6nSYtJmYVmnZmxaPwT1BDW3inQ6zUdRISY12UMPnYeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 20:45:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:45:39 +0000
Date:   Tue, 6 Jun 2023 13:45:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <647f9aef8928d_1433ac294ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <647bd26937a11_142af829499@dwillia2-xfh.jf.intel.com.notmuch>
 <ZH+RFGZqAoSEIHqT@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZH+RFGZqAoSEIHqT@aschofie-mobl2>
X-ClientProxiedBy: BYAPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 03533882-df02-4939-4aeb-08db66cefc8c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5oaywApcK27EkYTR5CsZE2Lr5JbA5+cEKTdwtTUbyOukYUNRVYwDWOqm2/OqPC0fO4TGLrIssYK2brjbgO5mtUr23kq/3LTWeMFYKljgVdNvRe8/0BURKafwJfuybWMhYokssptvDhhRt9q/zu23HZrxwgSiozJf9BnJcdC9IQsvo3+WysHIVtOyQybE4qI3NLUk5LIMk3hzuM8Lja3vFaJMedR/CPrcHLoEKyM9s0zf20Ynxac0MFoYQopgGomv10wpd8RtdbbUlINfHnU09X8PwuUCW/U7hiTN1oq8u4Q97U/cftR/bHEuqFvRiafFhQkGDYJY4KBsDlmVV/G5UJHJfv1GOR2Go5Vg4mmelvvmBe8xe8LPNfZhN50ehuEXcJwR8Eicq1ZLu0zbJVIU1BTYKsuD6NAh7C7Kp+nbFwszvi2e+Oc6IA65Box703cZfQi+UkkeYAAyuzyG8QJPF8rQLNuEBkzj9ukk7lRzN+2WHBc/vr3HBschn9RJJMyIbKLA+yYCrzEXle9Bld4UjVPo8GfOO5LQjgdfDEk//A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(186003)(6512007)(9686003)(26005)(6506007)(83380400001)(8936002)(8676002)(5660300002)(316002)(7416002)(41300700001)(66556008)(4326008)(66476007)(66946007)(6666004)(110136005)(966005)(478600001)(2906002)(54906003)(6486002)(38100700002)(82960400001)(86362001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aN4sCHg2f9GsTK51G2F3wxjIIWVnQ9VGCWrJ24S47vMGTVIacNFqoTafzooG?=
 =?us-ascii?Q?8f3L6wg6HAAaQYE37NEvYD3gHjyQc53HX/+hMb3gk0RLsZxAHZ+imePjYhrS?=
 =?us-ascii?Q?Kt408ZgcyI1RWVT2nbnS+JBa+YdC7AH2fB1FaPBb+PzN+ZcwMnX4B9LYc2om?=
 =?us-ascii?Q?FcHj2fWtqQPjfF8BfqWIgwoc9ySV/Jw6aeOOoolykx1Kil0Y1U61pDx3yDeh?=
 =?us-ascii?Q?MG4H6Xyup9asyrd1wC1EX/W9vCN1+AZI3AWRpqIB7XBQxiRz0+oaGSV1MXyA?=
 =?us-ascii?Q?loYz/wHgctnEvhNE/MECIlmQMGs8OgRrAOh7B0Ozx0fphMcCMmRNVuJtFAAK?=
 =?us-ascii?Q?jCaPBtPKv1x5pdtRosqTC7zd09Wq/1s+sHKmdFpF7N2Bh18ZRabFHk0ib9Gd?=
 =?us-ascii?Q?bJo0oAMKjLaUf+5C6W2fZnQxP02el1rRprLQjeUR6KE418Vyrl3S5J/9mzVt?=
 =?us-ascii?Q?3+kWUC+9ZEk1jKHfnzjz31c3Al1ivtWGrH3Wy/NN/jkjjejtOwrhhSPMAjlq?=
 =?us-ascii?Q?cYvOwp8V/mzgU6jrJObWebXe13UUjh6ct/yJpj6LKhXHf0bKlw9uVRX3i4El?=
 =?us-ascii?Q?v02tWmgXLl33REqVxi4Gp30p6Uz/ZYWWrSA4MnGNguR8YW22dHHDDhfyAnDc?=
 =?us-ascii?Q?vl8hIrJQGzNNOaYCz4mw7KcvsTNJ0nWsuclqhb8XYVUy6r47fcuXmqV2pna8?=
 =?us-ascii?Q?ZB13rjHb2dscmnHZPCPM//MHOcMTPhEMJ/fkk5i+7qLRadaYKxcF36CJGHHP?=
 =?us-ascii?Q?FSuz0iAW7FfWhdKkiOcdBEBCWmNDcEGnKanX9BIPxexJisYGb5zGLL3WSTj/?=
 =?us-ascii?Q?Hxda2Z3H5f0OWYafAOAcjuRyxL80A1tenjaHIbyL0o1xaFrSugLJNLFZtgaq?=
 =?us-ascii?Q?Uyxc109IfEn2w+PBcqcwskv/jIHlhJjsKHEQHsRN3wkYJqWxWJ6yfjzHDbzO?=
 =?us-ascii?Q?g/Fo+ZcAqHYFjaNVqVjIj9KvZ3w96lU/SggvqqPj9MzWBsMDxJsRLwuorFt/?=
 =?us-ascii?Q?jfrBgkR84mU1RsjYTT/1++5A0CJvNqbmt2RV2iFVD0op0LE4MTID/BELE/f0?=
 =?us-ascii?Q?QFL0t/fhyiH7sUu+Er0Ndf3z0l18uDwurSkcHEevD+mJF+NFH5Ahpbv2++HZ?=
 =?us-ascii?Q?ZMwRPdguBJL0pmM+7uWBE5f3wEs8ZWdQGVI1KAM3JWXnX5ToVgsbvDDGUwsH?=
 =?us-ascii?Q?Sd3iLqXNfEcxuMS+iD+lcq7eFuCWLhue3wEtKLIihm11c/p3mQgsuhnJG9VR?=
 =?us-ascii?Q?+WXa9K8bVXHJeEpDbuOYw9C8YGW7JTgpcgiDv3B/EkOiUL/aDf4CB+P+lzyJ?=
 =?us-ascii?Q?UQFqPI4ujVk+jPJpTppb3wdmLwLmXqMEKRT/E7fIRVVEFdiOuedst4xZ7fbH?=
 =?us-ascii?Q?cgw1UCXBCfg1gJIM0w9BAFjmMl577fQ5MiBXVS6ngTBRzc+TLQNaAJtYKMbu?=
 =?us-ascii?Q?2/ecq6ZKtCGJugvdfmQkqLGKf1e2mJeEheXbqJIfbrCDe68Yl+wpQhwyOkJy?=
 =?us-ascii?Q?Xrc/OfO/F9jCogf7NxS6mWpHvsda/hBp3Z0MUla6lWLc0k74klS24TEu7YLC?=
 =?us-ascii?Q?F94xUEyvQ/5siUhpSF6keAoILDa+9qy6rbOYNU1SqJ1ycIB547obm1hREr3j?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03533882-df02-4939-4aeb-08db66cefc8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:45:39.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 520wCEFcxJaufuj6oO5EDiVlQczFd1mLeHDNZVk7S0t78izqHRQSz2sW2TzAuBkSVY2d2pE++Fhd1aKJHFTMiDj5D4kAjvFuMoCuhMcQPck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
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

[ add Mike, see "[Mike]" note below... ]

Alison Schofield wrote:
> On Sat, Jun 03, 2023 at 04:53:13PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > > over an HPA address range.
> > > 
> > > The initial use case is the ACPI driver that needs to extend
> > > SRAT defined proximity domains to an entire CXL CFMWS Window[1].
> > 
> > I feel like this demands more explanation because the "need" is not
> > apparent. In fact its a Linux policy choice not a requirement. The next
> > patch has some of this, but this story is needed earlier for someone
> > that reads this patch first. Something like:
> > 
> 
> Hi Dan,
> 
> Thanks for the review :)
> 
> Sure, I can add the story below to make the 'need' for this function
> more apparent, as well as s/needs/want so as not to conflate need with
> requirement.
> 
> > ---
> > 
> > The CFWMS is an ACPI data structure that indicates *potential* locations
> > where CXL memory can be placed. It is the playground where the CXL
> > driver has free reign to establish regions.  That space can be populated
> > by BIOS created regions, or driver created regions, after hotplug or
> > other reconfiguration.
> > 
> > When the BIOS creates a region in a CXL Window it additionally describes
> > that subset of the Window range in the other typical ACPI tables SRAT,
> > SLIT, and HMAT. The rationale for the BIOS not pre-describing the entire
> > CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> > future. I.e. there is nothing stopping higher or lower performance
> > devices being placed in the same Window. Compare that to ACPI memory
> > hotplug that just onlines additional capacity in the proximity domain
> > with little freedom for dynamic performance differentiation.
> > 
> > That leaves the OS with a choice, should unpopulated window capacity
> > match the proximity domain of an existing region, or should it allocate
> > a new one? This patch takes the simple position of minimizing proximity
> > domain proliferation and reuse any proximity domain intersection for the
> > entire Window. If the Window has no intersections then allocate a new
> > proximity domain. Note that SRAT, SLIT and HMAT information can be
> > enumerated dynamically in a standard way from device provided data.
> > Think of CXL as the end of ACPI needing to describe memory attributes,
> > CXL offers a standard discovery model for performance attributes, but
> > Linux still needs to interoperate with the old regime.
> > 
> > ---
> > 
> > > 
> > > The APCI driver expects to use numa_fill_memblks() while parsing
> > 
> > s/APCI/ACPI/
> > 
> > Again, the ACPI code does not have any expectation, this is pure OS
> > policy decision about how to handle undescribed memory.
> > 
> 
> The intent was to show the pending use case, perhaps 'wants to' use
> this function to enact a purely OS policy decision!

Sounds good, yeah I tend to read "need" as a requirement and assume that
Linux is out of spec or something breaks if it does not do the needed
thing.

> 
> 
> > > the CFMWS. Extending the memblks created during SRAT parsing, to
> > > cover the entire CFMWS Window, is desirable because everything in
> > > a CFMWS Window is expected to be of a similar performance class.
> > > 
> > > Requires CONFIG_NUMA_KEEP_MEMINFO.
> > 
> > Not sure this adds anything to the description.
> > 
> > > 
> > > [1] A CXL CFMWS Window represents a contiguous CXL memory resource,
> > > aka an HPA range. The CFMWS (CXL Fixed Memory Window Structure) is
> > > part of the ACPI CEDT (CXL Early Discovery Table).
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  arch/x86/include/asm/sparsemem.h |  2 +
> > >  arch/x86/mm/numa.c               | 82 ++++++++++++++++++++++++++++++++
> > >  include/linux/numa.h             |  7 +++
> > >  3 files changed, 91 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> > > index 64df897c0ee3..1be13b2dfe8b 100644
> > > --- a/arch/x86/include/asm/sparsemem.h
> > > +++ b/arch/x86/include/asm/sparsemem.h
> > > @@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
> > >  #define phys_to_target_node phys_to_target_node
> > >  extern int memory_add_physaddr_to_nid(u64 start);
> > >  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> > > +extern int numa_fill_memblks(u64 start, u64 end);
> > > +#define numa_fill_memblks numa_fill_memblks
> > 
> > What is this for? The other defines are due to being an arch-specific
> > API and the #define is how the arch declares that it has a local version
> > to replace the generic one.
> 
> That define, along with the numa.h change below, are to support builds of
> CONFIG_ARM64 and CONFIG_LOONGARCH, both include the caller acpi_parse_cfmws(),
> of numa_fill_memblks().

[Mike]

Hmm, ok, but this is piling onto the maintenance burden of x86 not
getting onboard with memblock for numa info yet. At a minimum that
avoidance of touching the ARM64 and LOONGARCH cases needs to be called
out, but it would be useful to have a discussion about the options here
with questions like:

- What's blocking x86 from switching to memblock?

- Or, does the memblock API support what numa_fill_memblks() wants to
  do? I.e. add a real numa_fill_memblks() implementation to
  drivers/base/arch_numa.c rather than skip SRAT based fixups for the
  generic case.

Last I remember it was the conceptual disconnect of x86 not marking Reserved
ranges as memory like other architectures:

https://lore.kernel.org/all/20200708091520.GE128651@kernel.org/

...but its been a while since this last came up and I have not been
following memblock developments. Maybe the anwser is the same in the
end, add x86-specific numa_fill_memblks, but this is as good a time as
any to revisit carrying that burden.

[..]
snipped the rest, looks like we are aligned there.
