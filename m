Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835B26947B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBMOJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMOJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:09:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700BF742;
        Mon, 13 Feb 2023 06:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676297360; x=1707833360;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=De/ni8P0/bGzpe6fHZCmAkBqupFI5AQWrto54XnN2vc=;
  b=Y4UFRoJEcl4L5AueC96r7j4zS1Se6oxjVT5POBSqCs8AJcuVlvJ5Tiir
   7Yof4flYsCiY19vkW35vSkL8WZjcXTajwLNDSfkfdXnMWvU9n/dFVtIhA
   54zzpCBoy+R55zmde5oAvadWI17A5vWZgKRaH6dxN+SBCgXHRUuoA22op
   aBu2+9ZjsZUtJKkH+C8yDIZwobfiBvT3603NIRHK0UR1PqTC+kd6+C0fV
   9XtxnEkG58ljzEEBVHbsy0IXCGfJFlLQJuuBKpv8ULwjOhtRlRshif5zf
   vVbeWy8XPvdMJFNXDo9w5b0fKrSdm8FadT+qh68Tcw1KXIfN7+mMP1x0X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314539451"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="314539451"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 06:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701271761"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701271761"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2023 06:09:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 06:09:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 06:09:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 06:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDH8uyrfiWQxFYGQPSuUISw3XaOjK45wGKmjlfxbNcYi9t0z5LUtxn5AJSJwZk2uRoebiad7+kw/pP5IoU6EnqwI3ZKQSfUC/DMwz2bOqLVT2zy3l/9vvA5yHdyjfoGADun5chRWBHKwbQask/+a3Wb2QO+/Pv1WSWv2o2KFeOwgUDw3ATjSmkftV94+qmgyCNd0vQUzDNtQA2SP6yABeyCLdRAbWy05a2DVhrKKTW6+4Cwzi8V4V/s4pi2w+mGLwM8q594bts83zveFYnsYDu687+ZswjwxaFCmj/WwByOnWLx4jyf/wJWXwWHeDsZKXfcSdOOc/KMBPQoEP2ljCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgbomMwLnH8LXd/KZZM8dtMZvEG9jJ1iUoszxQISlkE=;
 b=V9aojqJE8+E/7gZn4VKzVHPJw7RwnIrQhGSqXzC4YXNDesOEeON7kOIlSOC8oBA+XqIR7WhgO6LDoQ7BX4QW48wPrrWfS7CjHdIVv7dqu/rI/mcKbMdb7G623cCwDrtatrjPNlGqn0kXyeE0G9o2KDy9a5lcKQzSRaOySMNariTC1q8pp1ocaCtaApJ9ozmaC6I5yO4+qE8toz+fAU8OwRHxxKrH04o42FLmdPuR34n8H+B/w/TqS2d3+49VkkeAGKKfk3b9vavkRwi47ET6jjASpe1IhC+QcluwYYX2yCoFE/Si3qPl95XuFCiR9F0skG1UsunKgKOsQFIVIh1ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 13 Feb
 2023 14:09:15 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%8]) with mapi id 15.20.6086.017; Mon, 13 Feb 2023
 14:09:15 +0000
Date:   Mon, 13 Feb 2023 22:04:35 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Joe Mario <jmario@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH] perf c2c: Add report option to show false sharing in
 adjacent cachelines
Message-ID: <Y+pDc9pgydL09jSj@feng-clx>
References: <20230213031733.236485-1-feng.tang@intel.com>
 <649f813d-2500-3015-57dc-b2e1fe290388@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <649f813d-2500-3015-57dc-b2e1fe290388@redhat.com>
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c35da68-f176-4b31-9a6e-08db0dcbe3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw/V1PfDKiAVwBoC3npsCZOKxbFd0PFKO8dlWYzreCj+GvkMgi/inn4z+hWnCa6PdY/itU99/KuZ4rpbkJabEW7WGBtTOOev1F/X2Jl7K4NcgLgeFe2mfUmznmTBCRf3EnJ4itSZjV08HR2nNktHYN2EgEfYdzED6f5Mj/ZDkhw6SLI9n034f6ccL5qPMcZqlmENFjs2Beqep2TaFWjBI7tFI5+VeGEsv0lWS/MEzt3LGDaURrTtbluN32mFQtdzOZLPhsjQc0/ru9TPyiImcSjxFj93jXR6jXU85Ohtd9gtZ6zC3FCfUkvQ9P/dSrYqtWiVrJU+GQehGO8154B0yiRYfNue1hIbYKnrmE391bJN2aHREGdooVxj+fHBXTNaA/M1ZbOcBWwelIerAKgt65MzJO5++cF4SSbDBN1BvJbvHpbMgeXWcdjjpztn8+h/kICTnjSybRNEjasYi8/sZ8IfDUu2CFNLMVxJMiSsGlMsWIY+60kAqSiMdH1aZ/DCBHaHnZVmQsU1ISfCSIuJhaoV/SoaXZLz3Ou9jW10F5xDFKiKNzy1uxBOYOwQKK9FZ2rB1tBd5qAEIX9k+qxZ1iObk/MBGUnFk5gFol/WBYyG2QMdNQBuiDJ8TxhLONz8SrSi1bBaWIxChSdYNYPvXRG22teMavPPIL6K0QBYeIk2nRoR1pgL4TSUVgzRUF7y8zyfsK8ZHwbZgJo+OqtN8YzUKQTqSPMZMYR2uQ5fTss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(66556008)(8676002)(66946007)(66574015)(6916009)(4326008)(83380400001)(66476007)(41300700001)(33716001)(38100700002)(82960400001)(5660300002)(86362001)(186003)(26005)(9686003)(54906003)(316002)(6512007)(6506007)(966005)(7416002)(2906002)(6486002)(53546011)(44832011)(478600001)(6666004)(30864003)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+BfNq2lSEOxRfmvpEY5LtHm9ZXLDYvrAcWsCKVUjqWh7bhKELqLdBGJp49s?=
 =?us-ascii?Q?NKUrMvAFxOMvdLe88hDc45bmhVinXfOQ5nh1lF7WjYpFpimw4u8HWTyh8rIs?=
 =?us-ascii?Q?cMwrmbgaWDu1ND3OLAu4lRmKe2EaQYrc3zTJGc5lkYCvybV70BYZyio+xDjo?=
 =?us-ascii?Q?PMRx7kk9hX0L3jsaYGdq79AlJWzRAF1RmNCiKlN+Q33W8kuf6PZuXC0M6uuC?=
 =?us-ascii?Q?a5d6ZB3qiRLVci0mb0sb8Kb8jdNealPFIamq9AISl9xtbNOkRzNyMX5NBD0F?=
 =?us-ascii?Q?Nfw0mqg/fOudqC3A1DV1nNP0OaCT/H44c9vzUP0un2b7/ndgkCfQRrLBLM+0?=
 =?us-ascii?Q?OSZvlj9bjxu/290ApZBNOH1e3r9xtF3+hueBN9xAtRzZTM4hSb9sgIWlN/SA?=
 =?us-ascii?Q?ecZOflfQ9x6dcdZ6U5RNnhmQLJV9U6qAl2aKHPUkJ1ivIwgmSyAw1m9aW/iQ?=
 =?us-ascii?Q?482TCnF2RCnDDNIO7odItv1Jg89N62syN26uW0HAThe/pDqLlkUnFNlsfokH?=
 =?us-ascii?Q?uN+IrvKln6JLoakV6glLTFkukcj8ir2YeezLexmrb03UCWXMD3SWkapgHfy/?=
 =?us-ascii?Q?CvnLdFFwHXx6om90/SUGlRx79EC8Utnvm0pP5kI5QTXRpvcBDUjL4loGt4fV?=
 =?us-ascii?Q?LF8GbEMefAq2SOkAExQFdSdFhPF+t7iNMXhYsWkgsimFuHfG4FWOcDlFp2Al?=
 =?us-ascii?Q?CiV8x5iqE1rAv7IDbdy5CIdvZGEUFEHWzOkQ+b9NOjFHvT4rEuLhGLxNOiDs?=
 =?us-ascii?Q?z9Uy3ohQs6Jwb/utzl6sQzFKfF1i5EdEpdA47t5k9lJwxB9So8HYO38o6JEH?=
 =?us-ascii?Q?rdF9VO+CQ5AgLeG7lFvNzNZHiw42FgPqVZT6mg8cTP68TD0DzjSGvgOMkeYm?=
 =?us-ascii?Q?xCFBSWGjBrkfSd3Wwb/nR5SIMBePPdU744iT73fKvMmd2NfyvZy6WuRWvq6L?=
 =?us-ascii?Q?tTaITcc46itu6RmogR6ZkcnV+6IfpEzYbviZcXFOpJUtXWWqETI9OEXvKy9D?=
 =?us-ascii?Q?LEQSxmeZ8xuT2ULkH1nx69MBMSVP01JHqecA+1heKJAO2JFQ/fS7omg7l205?=
 =?us-ascii?Q?LPA/2CdYLZ9dqfwOcHG+YP6pMRxYyt/1/L8zaBKlrw8rE5oAbbX5frqACODg?=
 =?us-ascii?Q?uSGUOJ6Wsu+5Xz7SO5Vwd1YGMgf6delYG7M42f2jUeX0e7vorJMTBgl2nceV?=
 =?us-ascii?Q?3LJcKyLWKI4e/HA2TVpkg9zSCFcQq+KkKeo0Ucde9lZc/3ik+xvRSU1kKR2U?=
 =?us-ascii?Q?7pnG8GmeffLX3Zv2YePx6A24xQ5HRjqoSqhXP4FwkFE804+PS/b60voAGplZ?=
 =?us-ascii?Q?4V4p8x87nkfLXIYTmrJglOF0p4N8HmEM6eyoNuEPOtdImVWRwGJBs2b5912f?=
 =?us-ascii?Q?zyO899DnLoHn6OHiyMPKMNICJqXOSNZvIerJte2g9+seBIKcbq95VmDpDwUY?=
 =?us-ascii?Q?wahjgZ/lB/1BItJ97nal/W4BVgGPiAzy7vyVSR9YCQEj+eQkHgaz6aqhYbOs?=
 =?us-ascii?Q?Q88m49MhZr9n80OXDTrRi9l2irfmBC3kBhkhikuXbV4wHNkCUiduL4Nx/IKz?=
 =?us-ascii?Q?3JMuUKidUhHGyESVOF4GckHzUkDzAfa+dqhkcs8Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c35da68-f176-4b31-9a6e-08db0dcbe3b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:09:15.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFUy++pFQPg0lL+imfK39xUCU9mFZJ9Kwhuxw669NVUumnW+BTOzmtenYIWTQ+b1g0ZTFwKu5Pg2mKDTMQHzAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Feb 13, 2023 at 08:39:15AM -0500, Joe Mario wrote:
> 
> 
> On 2/12/23 10:17 PM, Feng Tang wrote:
> > Many platforms have feature of adjacent cachelines prefetch, when it
> > is enabled, for data in RAM of 2 cachelines (2N and 2N+1) granularity,
> > if one is fetched to cache, the other one could likely be fetched too,
> > which sort of extends the cacheline size to double, thus the false
> > sharing could happens in adjacent cachelines.
> > 
> > 0Day has captured performance changed related with this [1], and some
> > commercial software explicitly makes its hot global variables 128 bytes
> > aligned (2 cache lines) to avoid this kind of extended false sharing.
> > 
> > So add an option "-a" or "--double-cl" for c2c report to show false
> > sharing in double cache line granularity, which acts just like the
> > cacheline size is doubled. There is no change to c2c record. The
> > hardware HITM events are still per cacheline. The option just changes
> > the granularity of how events are grouped and displayed.
> > 
> > In the c2c report below (will-it-scale's pagefault2 case on old kernel):
> > 
> >   ----------------------------------------------------------------------
> >      26       31        2        0        0        0  0xffff888103ec6000
> >   ----------------------------------------------------------------------
> >    35.48%   50.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff8133148b      1153        66       971     3748        74  [k] get_mem_cgroup_from_mm
> >     6.45%    0.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff813396e4       570         0      1531      879        75  [k] mem_cgroup_charge
> >    25.81%   50.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81331472       949        70       593     3359        74  [k] get_mem_cgroup_from_mm
> >    19.35%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81339686      1352         0      1073     1022        74  [k] mem_cgroup_charge
> >     9.68%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff813396d6      1401         0       863      768        74  [k] mem_cgroup_charge
> >     3.23%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81333106       618         0       804       11         9  [k] uncharge_batch
> > 
> > The offset 0x10 and 0x54 used to displayed in 2 groups, and now they
> > are listed together to give users a hint.
> > 
> > [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/Documentation/perf-c2c.txt |  6 ++++++
> >  tools/perf/builtin-c2c.c              | 22 +++++++++++++---------
> >  tools/perf/util/cacheline.h           | 25 ++++++++++++++++++++-----
> >  tools/perf/util/sort.c                | 13 ++++++++++---
> >  tools/perf/util/sort.h                |  1 +
> >  5 files changed, 50 insertions(+), 17 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> > index 5c5eb2def83e..a8e1e40d270e 100644
> > --- a/tools/perf/Documentation/perf-c2c.txt
> > +++ b/tools/perf/Documentation/perf-c2c.txt
> > @@ -126,6 +126,12 @@ REPORT OPTIONS
> >  	The known limitations include exception handing such as
> >  	setjmp/longjmp will have calls/returns not match.
> >  
> > +-a::
> > +--double-cl::
> > +	Group HITM events in double cacheline granularity. Some architecture
> > +	has Adjacent Cacheline Prefetch feature, which behaves like the
> > +	cachline size is doubled.
> > +
> 
> Hi Feng:
> One or two of the recent C2C patches changed the Intel-specifc "HITM" wording to something more generic, mostly because other arches do not have HITM events.
> 
> How about changing the above description to something like:
> +-a::
> +--double-cl::
> +       Group the detection of shared cacheline events into double cacheline granularity.
> +       Some architectures have an Adjacent Cacheline Prefetch feature, which causes
> +       cacheline sharing to behave like the cachline size is doubled.

Yes, HITM should not be in this architecture independent description.
Thanks for helping to improve it, which is much better now!

> By the way, this patch is awesome.  
> It's not often that Adjacent Cacheline Prefetching causes performance problems, but when it does, it's a pain to track down.
> This will really help.  Thank you for doing it.
 
Thanks for your work on perf-c2c and the great blog (I forwarded the
link to tens of colleagues :))

Thanks,
Feng

> Joe
> 
> >  C2C RECORD
> >  ----------
> >  The perf c2c record command setup options related to HITM cacheline analysis
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 52d94c7dd836..7d495db7e5a2 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -524,7 +524,7 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  	char buf[20];
> >  
> >  	if (he->mem_info)
> > -		addr = cl_address(he->mem_info->daddr.addr);
> > +		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
> >  
> >  	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
> >  }
> > @@ -562,7 +562,7 @@ static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  	char buf[20];
> >  
> >  	if (he->mem_info)
> > -		addr = cl_offset(he->mem_info->daddr.al_addr);
> > +		addr = cl_offset(he->mem_info->daddr.al_addr, chk_double_cl);
> >  
> >  	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
> >  }
> > @@ -574,9 +574,10 @@ offset_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> >  	uint64_t l = 0, r = 0;
> >  
> >  	if (left->mem_info)
> > -		l = cl_offset(left->mem_info->daddr.addr);
> > +		l = cl_offset(left->mem_info->daddr.addr, chk_double_cl);
> > +
> >  	if (right->mem_info)
> > -		r = cl_offset(right->mem_info->daddr.addr);
> > +		r = cl_offset(right->mem_info->daddr.addr, chk_double_cl);
> >  
> >  	return (int64_t)(r - l);
> >  }
> > @@ -2590,7 +2591,7 @@ perf_c2c_cacheline_browser__title(struct hist_browser *browser,
> >  	he = cl_browser->he;
> >  
> >  	if (he->mem_info)
> > -		addr = cl_address(he->mem_info->daddr.addr);
> > +		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
> >  
> >  	scnprintf(bf, size, "Cacheline 0x%lx", addr);
> >  	return 0;
> > @@ -2788,15 +2789,16 @@ static int ui_quirks(void)
> >  	if (!c2c.use_stdio) {
> >  		dim_offset.width  = 5;
> >  		dim_offset.header = header_offset_tui;
> > -		nodestr = "CL";
> > +		nodestr = chk_double_cl ? "Double-CL" : "CL";
> >  	}
> >  
> >  	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
> >  
> >  	/* Fix the zero line for dcacheline column. */
> > -	buf = fill_line("Cacheline", dim_dcacheline.width +
> > -				     dim_dcacheline_node.width +
> > -				     dim_dcacheline_count.width + 4);
> > +	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
> > +				dim_dcacheline.width +
> > +				dim_dcacheline_node.width +
> > +				dim_dcacheline_count.width + 4);
> >  	if (!buf)
> >  		return -ENOMEM;
> >  
> > @@ -3037,6 +3039,8 @@ static int perf_c2c__report(int argc, const char **argv)
> >  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
> >  	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
> >  		    "Enable LBR callgraph stitching approach"),
> > +	OPT_BOOLEAN('a', "double-cl", &chk_double_cl,
> > +		    "Check adjacent cachline false sharing"),
> >  	OPT_PARENT(c2c_options),
> >  	OPT_END()
> >  	};
> > diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
> > index dec8c0fb1f4a..630d16731b4f 100644
> > --- a/tools/perf/util/cacheline.h
> > +++ b/tools/perf/util/cacheline.h
> > @@ -6,16 +6,31 @@
> >  
> >  int __pure cacheline_size(void);
> >  
> > -static inline u64 cl_address(u64 address)
> > +
> > +/*
> > + * Some architecture has 'Adjacent Cacheline Prefetch' feature,
> > + * which performs like the cacheline size being doubled.
> > + */
> > +static inline u64 cl_address(u64 address, bool double_cl)
> >  {
> > +	u64 size = cacheline_size();
> > +
> > +	if (double_cl)
> > +		size *= 2;
> > +
> >  	/* return the cacheline of the address */
> > -	return (address & ~(cacheline_size() - 1));
> > +	return (address & ~(size - 1));
> >  }
> >  
> > -static inline u64 cl_offset(u64 address)
> > +static inline u64 cl_offset(u64 address, bool double_cl)
> >  {
> > -	/* return the cacheline of the address */
> > -	return (address & (cacheline_size() - 1));
> > +	u64 size = cacheline_size();
> > +
> > +	if (double_cl)
> > +		size *= 2;
> > +
> > +	/* return the offset inside cachline */
> > +	return (address & (size - 1));
> >  }
> >  
> >  #endif // PERF_CACHELINE_H
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index e188f74698dd..148b28f0a7e2 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -52,6 +52,13 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
> >  static const char *const dynamic_headers[] = {"local_ins_lat", "ins_lat", "local_p_stage_cyc", "p_stage_cyc"};
> >  static const char *const arch_specific_sort_keys[] = {"local_p_stage_cyc", "p_stage_cyc"};
> >  
> > +/*
> > + * Some architecture has Adjacent Cacheline Prefetch feature, which behaves
> > + * like the cachline size is doubled. Enable this flag to check things in
> > + * double cacheline granularity.
> > + */
> > +bool chk_double_cl;
> > +
> >  /*
> >   * Replaces all occurrences of a char used with the:
> >   *
> > @@ -1499,8 +1506,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
> >  
> >  addr:
> >  	/* al_addr does all the right addr - start + offset calculations */
> > -	l = cl_address(left->mem_info->daddr.al_addr);
> > -	r = cl_address(right->mem_info->daddr.al_addr);
> > +	l = cl_address(left->mem_info->daddr.al_addr, chk_double_cl);
> > +	r = cl_address(right->mem_info->daddr.al_addr, chk_double_cl);
> >  
> >  	if (l > r) return -1;
> >  	if (l < r) return 1;
> > @@ -1519,7 +1526,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
> >  	if (he->mem_info) {
> >  		struct map *map = he->mem_info->daddr.ms.map;
> >  
> > -		addr = cl_address(he->mem_info->daddr.al_addr);
> > +		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
> >  		ms = &he->mem_info->daddr.ms;
> >  
> >  		/* print [s] for shared data mmaps */
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index 921715e6aec4..04f0a6dc7381 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -35,6 +35,7 @@ extern struct sort_entry sort_sym_from;
> >  extern struct sort_entry sort_sym_to;
> >  extern struct sort_entry sort_srcline;
> >  extern const char default_mem_sort_order[];
> > +extern bool chk_double_cl;
> >  
> >  struct res_sample {
> >  	u64 time;
> 
