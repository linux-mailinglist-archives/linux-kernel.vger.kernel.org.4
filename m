Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2138273CE9F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 08:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFYGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 02:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:01:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E8B5;
        Sat, 24 Jun 2023 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687672906; x=1719208906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qRf/cahCINP7XuDANGsNz1NVifDRtKNO8iDVgJ6R9SA=;
  b=VSRO75nWAYF0wcOTwnaselGJCUZkBqDJ13Qi1R9XNr3hE9ipv8AJbie4
   XLepE1IVNHUwrsIbcSTV82UYS/kU9lAORRDQkpLaExRuLJt/CzxjnDAHL
   gQBvabEfPOoc4yGBDGl/myp4cOccpf42p0Ys0Dgi6f/Lolk+31Ry9ymUm
   m5nSSvJWSEw2tz6iydKn7HyY42Kua2duCKOTn1XEX/RW/EE68ilsMnM4w
   WdDhkUNYDMrXw61Bb0fxm5a0dl5i/bziwvsX1GRXVi8972GiqG8kSyyl5
   PbqFeQuHz6DVCwrLKQlQ4Wuwl93zl+QgyqyifY64YVJMIMvIrKHM8iLsV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="345782693"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="345782693"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 23:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="805637003"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="805637003"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2023 23:01:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 24 Jun 2023 23:01:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 24 Jun 2023 23:01:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 24 Jun 2023 23:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieRPXC8O6Nxs8YayWmFL1cvU436pGc/6GV0dapkmS3qkUZTC9SIP+5kzFQ15vlJ7g4JA7aof/up8iwTywXSV5ouwD4E5GAU6nzd72U0/U6FPknnnQU9EtV+ClsRAPa2OMWzPUUC5t8SoRRenIk3by7Gm4alUf+I7j211xueiRxUkCt+DM1ArvRDf0nUGt6c+SgtyfCgWNQd0AwE5f6UZtKTunPXCMhveWdW0npM3io4fQuoIqTd84lHLMfyqDprWa5Vn1bT1di0g7Iidh21DoKk/eN1RytyE17DVXjl0Uh6RUPLsrY/LPRkBxxBwkNuPSF0gT9Mxaj+s4mtQX+1b0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4uMpQCqUyLYjMGOTWax638fnRF7dCBLpohIDgHjo5I=;
 b=VQEACQIsA3u6qQqPiVE+puc41PwyT7ur1IXfWa6c6fRx8yriPtRvLE4ID6RUukYcJ65I5/gAVkbmKoKfl5ZcKJ6kFkxuIBTm9ojxBxXv9CsjnELWkbHcyojdbftZww+LGRhCValyCxgjwimucN/drwDMPv/RzfSVC/Qp5js7HeMrZmS+6JNmXKK6flBymjx2q2qiUQB64OcWePCWwMEvXWkZ0rYS78yQtKjz9KaTanlx8buk0NsjgZdmXn0T0DjMt5v7rR+jwemT98rGKJUB19fprbCr0u3SlAsOZCni/80w13Zlx6qBlqIGXsSzNm5+JdLtvzIhtcexlGZ2EMAVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6724.namprd11.prod.outlook.com (2603:10b6:510:1b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 06:01:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 06:01:41 +0000
Date:   Sat, 24 Jun 2023 23:01:38 -0700
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
Subject: RE: [PATCH v3 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <6497d8421945c_2ed72941@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1687645837.git.alison.schofield@intel.com>
 <2fd3778271d4fd3c4278c75c582daf6df4dcc503.1687645837.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2fd3778271d4fd3c4278c75c582daf6df4dcc503.1687645837.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 925a6187-57d7-4ef4-b308-08db7541a58f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhKSC6dseFh0TRc2jdXCijUG0O32jWTGqn1QzmV0I533CD8Ho+IYF4kJZ0hxQDVQPFcOirSIwpYSy+fPJ7FqOdRS7j/yc6mcKW9StJ0UqJi9EWcIVXdgqULwdlK1H0zZC4GgAgY1LGUD1F6ecrG3Bwxv0n3C2ajHcDnSTGr62mNekH5u4Ocg0C78PNxelMiPnjHOhD5b3EG9k+hyQPgSJkP2uozIRMEOw/NUzyWl/NkQbx4Ms0ZRcix2Vg2UecAOwOJCuXrcTMlJlQETWnaXInFeLSl1q87co2ulbHhQQcpiRMfRzujrRPTwKYUONNEp3oyPsyta0ft/slG3i8fxS3oyQlMFnAc0VP2eCfc/1T5Vr6JAYSDn+X4cH5DpyV/jJVL5TIj4PtlplsdLsjkvN+BRrYOEMtGXVD8o0gunlJ3PQV4tyqYgpl9k+SzvVOHMxo5OdxLggj81FKiPSzY9HVxysm0+yDTonwoyvLVgz5t33lPja/cvllvTbH8E9/knrE8OS83a2S6ASgX69wptG0cT3ew/4FPtE2u/PeAydA285KosJcatXRB/9J7HxFsuTzn6JBH4at66/8DkpB4ffQW0+P9tz4E79XNw6gXPiuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(8676002)(5660300002)(66476007)(316002)(478600001)(66946007)(66556008)(7416002)(4326008)(8936002)(2906002)(9686003)(6512007)(86362001)(54906003)(41300700001)(110136005)(6486002)(26005)(6506007)(186003)(6666004)(82960400001)(83380400001)(921005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gHNlAw9z3VMxxMnpo8/G8LIn+pMoSWs3XBxOa5dturlX7nqgd7NtoyIqQZ7?=
 =?us-ascii?Q?0TejteheIoQnmkRbHrbGE4rEks7HlZX4qymFWBflm+ulHUt63BCPMWY+Egdg?=
 =?us-ascii?Q?e6+LND5pzJp/YEhRhp2jwXzId9Ee6SA9KIc2RsK8nFgUVctYAVMI6Eyr6Qux?=
 =?us-ascii?Q?fAk/soQnCsXvr7YPeqvnEbtuZN7uAdPmSTetNMUFiXzURGOT4OzvLlFZC178?=
 =?us-ascii?Q?D6mKL6KLzPb7V/b/Ht6Y5SKnOiD3zzDB6J1Tg1FxVeuKX8+rTs15vXYw9WFH?=
 =?us-ascii?Q?qhWbfDCN8A3104vXyQQzwgPQ/tNeRNBP9s+n0Yk5iaUboYKXLgiVYb6o8+/w?=
 =?us-ascii?Q?1P4MHlPuXYZwUgIKeD4R07ovjOrhL7T3ekTHGVqXISLYQ04sdxNx4WXw5Npf?=
 =?us-ascii?Q?22z/LRd2kloX4z2JvUjX/Rvab6khw1np6snsB49M1KjXeMJoOzgM6cCjkHsP?=
 =?us-ascii?Q?fXAnOlu9TrY6DcGyAzjvn0gzYVH+YDhJEsO5OUEh+7E5bSRNdBaHx9dzHxdL?=
 =?us-ascii?Q?QpL3QvpxpnAtKUnJD7zh5OXjNRQ4FZqgOZqxPtHWQ9TQbRkrLY5OmTva+TVI?=
 =?us-ascii?Q?GUw1LuZjA2x03E8Lbzr8EOAhU6zmTSG27fCH3buyI69vLWW8dUdBifSvjS4D?=
 =?us-ascii?Q?ca1BVpRcA0uAjND3OurGJxU0Lym8WLMWtqc1hbMx3VYFdh5XusA3/PGKXzna?=
 =?us-ascii?Q?E5KOENxBF1+6HmmX5H9S6Q9UF9OaAkTu+t6SrmVFh8dcfEhW1YgPYzETo8fD?=
 =?us-ascii?Q?9LXO6rAi0LRzhgVA8fYzTgZSfU2rjscPxrWkB9yYPu9hrT8IJmtKo6/3nGC3?=
 =?us-ascii?Q?2Jz62ETYPWa+mQqkRdiSwC+m6pGsFw6BPRHMqCWptbLcHmIrLIpsgw0PdyLy?=
 =?us-ascii?Q?R4ebtlvM6Pc5mD72bd4NQCuWkUQNIs0RYk9pb9lDjCyqCqSguQ8Dkk4YWLY1?=
 =?us-ascii?Q?/BCKefATmyUz0VELPBMNogRAh1gtYz1VvCVqnz713xd6gNulXjhz/T/iOiST?=
 =?us-ascii?Q?PxvEnUNXVsJoNWF0dE9hdTZ0eyoSQIvyHekECn2EjG4qqUlycth3aIF0xuu/?=
 =?us-ascii?Q?z7+Wo8gtEUAAsZxQlEutQz+uoPp5Nf1mNRBIxbf0+d4ojwbajDW+8Ju9tRfL?=
 =?us-ascii?Q?Mhm0XNlFPm8DQXV0bu0ws3j53fzVjjhmDxlkDcI0Gt7YGaOrJ06yUhlQpJ/j?=
 =?us-ascii?Q?umE/Z8L5GAa8/0DMt0zVGrdnwD44HlfvFdN5x5oq8Gt/SRI4nqrrVwHqkwTd?=
 =?us-ascii?Q?LOZ6uGXrAYmIjujAe3HDM83bRHpRWYtJ6VP8REv1jl0J3aO7rxgtyzA+3QX2?=
 =?us-ascii?Q?m5XHOCg2BP06TBGHrPaYOmpHC0GltetQjUcGu5tT0aX5aY0KqMzPhs+DOpk3?=
 =?us-ascii?Q?Ei1r0xrii0oXYdCsQKDmhXCCyxIDj2ajo2xRTS9LCR1AGZ+0Gr0L2Wle8fEb?=
 =?us-ascii?Q?1pZA6gkv+3wFV+KglLd0x9fIvkxbVkGgmKOGtY4kirdE6/ttpW2edt/TT2dX?=
 =?us-ascii?Q?lRqZB9In8AA+Jv9fb9NKJ6OZS0Z9EHgJSqiQVmlFlYvZZPbzhdi8+2aLjLW3?=
 =?us-ascii?Q?PKqz+pvqXTD2jbrrkl5Mko/kK/gadfo+VhD2Ye50EtrhlDFDqAIds2lxjvqU?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 925a6187-57d7-4ef4-b308-08db7541a58f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 06:01:41.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZaXeQY5X3VUwuFZZZZAEgm2mTstULr1lqjkb1pzmLUXfkYWH2zjjEi/qT+bN3UxlUEws3XdHElhzjnBbcUitDGdiyWi/VWG2JdBSVsYK1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> over an physical address range.
[..]
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..152398bdecc4 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
[..]
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
> +	 * Fill any gaps by tracking the previous memblks
> +	 * end address and backfilling to it if needed.
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

After deleting this export you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
