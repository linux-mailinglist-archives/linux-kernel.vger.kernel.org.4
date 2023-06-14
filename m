Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3C72FEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjFNMof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbjFNMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:44:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC67AE79;
        Wed, 14 Jun 2023 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686746666; x=1718282666;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=frFu13+tnOBPXhIXd+Jm98anQQ/LZ3FhxOdDmHlpvu4=;
  b=gTC3jzhfUcYqmkFRLGZjLo9zs65p1SfMpM7pREzQOiTkmsJ6W4J8VUQM
   NItrC7oYpDTlolH3RDrQLuQNaUeOjPY7AQO1n+MtfyIvsluvfHpqOf44d
   gA86x9sp54g3N/aUdFFDgsVY9rChCarr6SM3MEFW+xXKByLrK4uTJrHlh
   rbLRJejizdcCcjmQAno1Mm3EIcTEfV96b//gcGArib/vjUDCoOdMxvRqB
   LOuWGvHjpMhW+HqFcQgF+4MMApjQZo3uzd10KXz0ShrKsH9vtZoOvnGtQ
   EX9m371wvF1xvoN0CCQZQZU1pHix6fsP96ieUflEBbIQuZZT+fBZl/Lfo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338950742"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="338950742"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="824803077"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="824803077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 05:44:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 05:44:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 05:44:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 05:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jykGasiYrQgUuKYW/TuJtAJxrpXKeWywc7VQb50CQv0Q/aU4nzzNy9zenlsQUh/sMzy/MxpYYlb8GC1RmJDA+Gws3EkxpZ5P4eLXroj/UWRZcbbALWlhApxxJzkcQd+ujZCjYMPKrDGijlcUOvNa4EFZYCWPFwuTMX7NstvFbDqiSlDEThjqYguMYNDJrqoXnifbfTwcA1zakIeN5sxCwzWO6A04KGJa7G6VvazJuNEWIK3dVIl6OZFfivyd6640jDRN5+e1sZGI+7vmGdNi7FfWHtjoB8L4acSTZMEaCkKSmoeUG+VI4TyAl5SfM7H/6Di0zjfZGJk8QnJNgqZKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVwaQzubPL7gKD2ioPHqeneIrGyKu2Gt//nZUbiX7eg=;
 b=oVti+GrOKuWiDgFf01quAiv6CW8J/G67gxJoevx6MqVTkuKAvKljsxK704BpkgRjDTpxuCIjQd1deP7zZHHG+iGiJ3tK/t2MryX0LnFqnEII+BuZm07+mOieVaMNuCSlMHCWwmnu2SNayCaUFPdDqtB3HAIQE5nJicoI34tr7vO+daYSaHPPL/a1Gf493B5haO/r0OhgsozmJoi8S1aZ0OToKGlbNE2D/s7AKLtfHqFdEYTxUX/OgueHpHozEAUAkyNjJ/hsKwXHVaEg0Y6gQL+oJaNlL6ziAJTgUXaN6q2UQ6MHZ5ooc/PnMoT6k9ErjcpmCsXc9hb7x58sTJU2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 12:44:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 12:44:22 +0000
Date:   Wed, 14 Jun 2023 05:44:19 -0700
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
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Derick Marks <derick.w.marks@intel.com>
Subject: RE: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <6489b6234a03e_142af829454@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 70388179-afa4-415a-e8eb-08db6cd513da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: re9EgBc6MlIDmkKm9JGB9T5+lL3yE+nDDVoVdpw3e0FcFGxBQhFWEoSV+FBVmmwMVre7retxbBmziikzu231KasFmp/+S9UKRkzGk+OjpvMwvgDMkId21fOe+WGbnw7FrVVSbrCmHu4ef7lvvCZseIesCgXb+QLKkywaKWMk71AUKnJCi1Hf37UYNn0J0sAKQJV7HIhUutU+U/Z0pjLWOn7fhyoBqboGeNt5Issq3c4ruWQ+BAtHGTHFfPhBFIuP45bd8s0nLGNkZIH7UvVl/gnl8H0JANdZNo7EEBsVqdQVRaM3tv1pe96PDobnNuyMyMvEVoQIMG5wQ4CJ2brgO9LDZsXrlg8mQOM2HPHKZDojO9LPMZ61pTiGpzT8U7DfpAv5A4PgYI0NYlVdutiJuChVgUuUb3eZTUk7D+N38EOb61P1M9hSFPcjbcWdrKmcqaO/lEVP0OpBaufxHufWe233d7sYBdd/JXuGtOdfcJ1iBlgEi/jmt78Twy3ujcA0sFMTBH0/v1lvgB+PttJQg1Mu2g+VR1QW+7e2rLE1M1XJMIM43et31gTUi9L0RL+UO6hNZyHNZ3fUUhhXXRnv5ZLEkMBHXECL2duH9Y0M4Gk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(82960400001)(921005)(38100700002)(478600001)(6666004)(110136005)(54906003)(6486002)(7416002)(316002)(41300700001)(5660300002)(8676002)(8936002)(66556008)(66476007)(66946007)(4326008)(2906002)(83380400001)(66899021)(6512007)(26005)(9686003)(186003)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E9ab+npXfOlkkpmdbnQ/51CiVSKW1BSIcG658jr+PvUtgura9vURLgRFQgZ/?=
 =?us-ascii?Q?pdGA9Mobkr89OVr9cfmqxb95w5m5X7ZD1e6cbm2n5S8ZDvk6ZSRV7lk0Loxq?=
 =?us-ascii?Q?HtyM4AzfjKjowFXVddyvocXHpr6oVXsPQ9uzgNi2D7s0wq+B/kW+FWRmKe0E?=
 =?us-ascii?Q?AZKppiCudqPfopEoa8UjhEC0FN49wSUPCedTMrkQYnK+pnc1la4yNt5gamYD?=
 =?us-ascii?Q?JSdw1qJJygbp1e4Qvqaj8YQEa2oYx41Gwyn1pGmnH+jEnERFzSTJ8Pfagy6N?=
 =?us-ascii?Q?E15QYCBpxIUAGwASg/+L9CIJVBo1XZs21wa6+H+fVmwJ6Me59jg2aOqIW4nv?=
 =?us-ascii?Q?bbDZ/3lvqwlvQveNJiNdCtW2cFWr5X53MR6J+RFwEKmbIKG6HAWZlBAeDLis?=
 =?us-ascii?Q?ib5gifpoTJSwN0Wv98tjqhSSJImSh9VGjayddgX27bRdWoKwgSctlxcOnRnR?=
 =?us-ascii?Q?LqGkNMvXqhZkAsKo/mPfFg1Sc3U7LlI30hWA3rr2sZha/+6rKJbx0PYIdeDh?=
 =?us-ascii?Q?WaVP/6/i2P9G368gRYZBCNc7CXwWflbRVyg09C8tO2zpvBSJopbjMDc1WDjR?=
 =?us-ascii?Q?1liVJGQDTRwg7CKChHiwv1i5W6AF2af/ea3rosmDvPN5U3G3AcTorxIIS0bk?=
 =?us-ascii?Q?4YPLijVFXDMEAl0ai9LSdT7/2Pyq5xlt+yHxll2AYXu872ICXsVYUL3zMUPX?=
 =?us-ascii?Q?/Zfkmd7S2bfX70B84TCoJ3AkHDGwpCtzMb4VwguyM8S+L+mRRoTf/uMhsjVb?=
 =?us-ascii?Q?Gh5x/gtIAU2ndj6VTV1rmpectDbbbA4VnQhDwvrJ4s0FDWLZDOzo296Lu2fC?=
 =?us-ascii?Q?TJsfmw87GOqf05Z40izsjDsYNT55bWgcUOteVtJ50wdHRFahyHQ6yuHWJ3M3?=
 =?us-ascii?Q?vJ+cdY6t64NkiNjFK7EcYaGoniAMi7o2euiT1dH1fKSW6KvKHNUISU1/fE0I?=
 =?us-ascii?Q?llRBcePdYma45SnjuwsJwpAz5jtuHp18Q1hT1mJHBJNtRFzZn+Gp3wRuWyDt?=
 =?us-ascii?Q?s0JPnRvIxp3RaBk38cy6WUKlsoA1zhFvVVVSPxnypu4qButh6VF3AOXMEOnQ?=
 =?us-ascii?Q?lH4/grYxF+iJroBXGdEEsyP6qTTUCcL+b7opbHkYaxVOaPLVgM+3vhS7xYwP?=
 =?us-ascii?Q?VvxFE21GV3DbyuVp0qtpwHRkVS5yrtPNd5IzKPi7c6QyBxwqEpIV6CIXAquv?=
 =?us-ascii?Q?CpJExASSGSMxEmhmVL4TKbq+2rUssxCVZ2O5JDcUt3ZHA29C+V9KOnC93WSt?=
 =?us-ascii?Q?iT+04glKQ7+gi6JBsXuvgxs3kb8plV8ao/EJygim5oeAKPu8xohOyUQETOYU?=
 =?us-ascii?Q?iY3SBh/NbFSHtlH9/2Y1TtWDIPxTLDlJOnAtoQAOBwoRLMF/j3KM9+AkS4OA?=
 =?us-ascii?Q?jtrqeoiIAlR3DnYiqisjoYpkmn69tCVVW3CjCssLIarYDTAnNMq881POjCkP?=
 =?us-ascii?Q?gZlypI2tiklbRs12chxlYfSuIpwx2UJQ9UKSobBa8JUWWP6jZEKngnH5ELA1?=
 =?us-ascii?Q?v1R+E4uGew2X7bZUm+hhRKPM9/d8qRAfA3/MgmpDeMS9oIjSo4/xl3WckNLN?=
 =?us-ascii?Q?Ma2nt9+tWK8uekLFc5gVm0DfQ4KkDaj1/SjXkJx2q5K2EXZWTbohMJZoBd7Q?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70388179-afa4-415a-e8eb-08db6cd513da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 12:44:22.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9yGhtiKxKRSv6u2pTmOmfe9SLp06g64C7Yp3IOEJ81X3LOQSKAOMmpNeRWg0ZF8nqnCKD48ofth3J9hRu6ru+2RjL27LzViO8H+xmyG+s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> The ACPI driver will use numa_fill_memblks() to implement a new Linux
> policy that prescribes extending proximity domains in a portion of a
> CFMWS window to the entire window.
> 
> Dan Williams offered this explanation of the policy:
> A CFWMS is an ACPI data structure that indicates *potential* locations
> where CXL memory can be placed. It is the playground where the CXL
> driver has free reign to establish regions. That space can be populated
> by BIOS created regions, or driver created regions, after hotplug or
> other reconfiguration.
> 
> When BIOS creates a region in a CXL Window it additionally describes
> that subset of the Window range in the other typical ACPI tables SRAT,
> SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
> CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> future. I.e. there is nothing stopping higher or lower performance
> devices being placed in the same Window. Compare that to ACPI memory
> hotplug that just onlines additional capacity in the proximity domain
> with little freedom for dynamic performance differentiation.
> 
> That leaves the OS with a choice, should unpopulated window capacity
> match the proximity domain of an existing region, or should it allocate
> a new one? This patch takes the simple position of minimizing proximity
> domain proliferation by reusing any proximity domain intersection for
> the entire Window. If the Window has no intersections then allocate a
> new proximity domain. Note that SRAT, SLIT and HMAT information can be
> enumerated dynamically in a standard way from device provided data.
> Think of CXL as the end of ACPI needing to describe memory attributes,
> CXL offers a standard discovery model for performance attributes, but
> Linux still needs to interoperate with the old regime.
> 
> Reported-by: Derick Marks <derick.w.marks@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Derick Marks <derick.w.marks@intel.com>
[..]
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..fa82141d1a04 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
[..]
> @@ -961,4 +962,90 @@ int memory_add_physaddr_to_nid(u64 start)
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
> +	/* Caller handles duplicate start addresses */
> +	return 0;

This can be simplified to:

static int __init cmp_memblk(const void *a, const void *b)
{
	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
	const struct numa_memblk *mb = *(const struct numa_memblk **)b;

	return ma->start - mb->start;
}

> +}
> +
> +static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
> +
> +/**
> + * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> + * @start: address to begin fill
> + * @end: address to end fill
> + *
> + * Find and extend numa_meminfo memblks to cover the @start-@end
> + * HPA address range, such that the first memblk includes @start,
> + * the last memblk includes @end, and any gaps in between are
> + * filled.
> + *
> + * RETURNS:
> + * 0		  : Success
> + * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
> + */
> +
> +int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	struct numa_memblk **blk = &numa_memblk_list[0];
> +	struct numa_meminfo *mi = &numa_meminfo;
> +	int count = 0;
> +	u64 prev_end;
> +
> +	/*
> +	 * Create a list of pointers to numa_meminfo memblks that
> +	 * overlap start, end. Exclude (start == bi->end) since
> +	 * end addresses in both a CFMWS range and a memblk range
> +	 * are exclusive.
> +	 *
> +	 * This list of pointers is used to make in-place changes
> +	 * that fill out the numa_meminfo memblks.
> +	 */

Thanks for this comment, looks good.

> +	for (int i = 0; i < mi->nr_blks; i++) {
> +		struct numa_memblk *bi = &mi->blk[i];
> +
> +		if (start < bi->end && end >= bi->start) {
> +			blk[count] = &mi->blk[i];
> +			count++;
> +		}
> +	}
> +	if (!count)
> +		return NUMA_NO_MEMBLK;
> +
> +	/* Sort the list of pointers in memblk->start order */
> +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> +
> +	/* Make sure the first/last memblks include start/end */
> +	blk[0]->start = min(blk[0]->start, start);
> +	blk[count - 1]->end = max(blk[count - 1]->end, end);
> +
> +	/*
> +	 * Fill any gaps by tracking the previous memblks end address,
> +	 * prev_end, and backfilling to it if needed. Avoid filling
> +	 * overlapping memblks by making prev_end monotonically non-
> +	 * decreasing.

I am not immediately understanding the use of the term monotonically
non-decreasing here? I think the first sentence of this comment is
enough, or am I missing a nuance?

> +	 */
> +	prev_end = blk[0]->end;
> +	for (int i = 1; i < count; i++) {
> +		struct numa_memblk *curr = blk[i];
> +
> +		if (prev_end >= curr->start) {
> +			if (prev_end < curr->end)
> +				prev_end = curr->end;
> +		} else {
> +			curr->start = prev_end;
> +			prev_end = curr->end;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(numa_fill_memblks);

This export is not needed. The only caller of this is
drivers/acpi/numa/srat.c which is only ever built-in, not a module.
