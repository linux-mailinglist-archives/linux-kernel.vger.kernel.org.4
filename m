Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFF69733A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBOBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjBOBKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:10:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691CE32CF4;
        Tue, 14 Feb 2023 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676423383; x=1707959383;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TltVZA0aZouIMj7YnjpUu1C0c/9A7uc2zpTOpn8e0f4=;
  b=Uy1wzFTTvtzXshn+y7VXaOkAUiZPiGJMCPRO7hNx26DZ1FOwbp+uIla6
   9ZlaNIbBCj46zWb1Xd4HVgjfEuE3tGQGxIuEyQp4fbAbTvCZulT06Gsms
   IwMvwM2RgDD1GVlXZwTGjVm2eynes7Nceea1jJ47SIdVo2gmJbyNXqZyr
   q4u7RuuKDbTIbWKJ/1rkXMqBN8k0C8j5reSeokC1ESiAz3czT4b+V9djW
   04Uu+jrowuC6MTQQR7km02Mg7R+SfT8XOWorN/Wz9bkn4B7eTU14T+tLX
   S5zlK4utG1eKgJn54XSxCTSi4yEKUw06AqSJ0cyQ7vczW1Eop8Whpihjg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358731965"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="358731965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701840097"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="701840097"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2023 17:08:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:08:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:08:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:07:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU/pC9xeTAkxIcy1JHYQV7UUM61xaOlAASeVB6wYreX2AdePVKiZ9OymX7y3nr6Hj/8EgHXpl7VUYV0K8NjBnH7KOWHkXACku4z9ch+uMbmq/Z6/bVV0EvyNrRr8+wEhquyfedeXrRhXJbFFu4rSiyaTXigB0vXl3Lc/CQXBhxJJYiQUzOdtR58iHYNZfY+/Ju9BJEhhBlf05b1yURBUW8scb952OozXUEoqMEm7fo3qiUVToDAggH5I83mKAdTbywUS7+8ChOJZ9uggMfBJs4hpxppsq9uVVRCMmc5H04SjXP7HQXgPG+9+j5u1ZFqnvJXlcMqjhz9Pka1SaMh2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBCy+BO+TaKghw8RIXs/YYGnMA9/9iaTLodwswZnIWM=;
 b=jqG2gRQIvc4S6JYbZWmyLY/DBa/HsYw5KkqApiACaYl4O1D8zNzKjYG6JTo88onxbQy8F4p7AJ0929kEhHvDd1X2AXgTBVH3Eh3B1yae/AIKu1ofG7aoqeQ9OSHh7JOl6d4ZFHmrqIOZCZgkvvXmNk/wFnp4/riXR4RdFT/smOXu12TJWF4rHF4IAlf7qR4CYq2AwrIM/ZunNpqnwZ5TJGgmgJcVMCeo0sagqIzZwN5zbN9zK+ZcOVHZ+hLUSck0yuK8Pq8BQAXOKVFQ7zSp0pxXccKRIvcxrfXq2dGOlDP7pwh14p+Qwu4JyzO1XmXWqMpaYmt/Juk+kxL0YRRp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5088.namprd11.prod.outlook.com (2603:10b6:a03:2df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:07:57 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%8]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 01:07:57 +0000
Date:   Wed, 15 Feb 2023 09:03:16 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [PATCH v2] perf c2c: Add report option to show false sharing in
 adjacent cachelines
Message-ID: <Y+wvVNWqXb70l4uy@feng-clx>
References: <20230214075823.246414-1-feng.tang@intel.com>
 <Y+vhcAYQrX6Lv7cL@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+vhcAYQrX6Lv7cL@kernel.org>
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb4f296-7a9e-4a60-5b3d-08db0ef1126a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eq89OMUXC8yWaPyTeHHnudy3Fr3ab0bm7uY65zBX5Jjr870Bl1X5kAtef2WVWD2xj1Y3mBI3Ib+vKNueVP3yiros4CBFgfdCcVkwvDE6dkNnOca8VuWDFENQRIAqjNkdq2QTL8fme8+UHYvq9J9ndSKTRMrW/XTlkZ/FvjBsLZpKpBk1mT1wEHWXZRYb1kupfpDCKGo6ADCV7YSlbAu/vtsKT0/CIk7ce22e7IBYl/w65YdTCE/YPjw8+wxVJrnJa+2BEgvW4RUeR+EhbV+/9A3Gox77rFpccifJulabEfvPfNmGo3rOwr6CFUayyq/mzHxSb1V81WHKGG0ZfaCY1XFrwd+bMCR1vtrhPqQBLXmyNH9VT1fpI5aZ7fuL1/G82bSFLfjmMX6qSIWDklrd3cItY8KS+c+kgFMlPkTXevdmAXUgUbDUR1DzDQzxe5sxW5ht2FVSAdgQE3q4Cc8pMYhd0Hkx0Jsb1L6n4nzabyDHAPhESqEiweTAIz6pwAAdPgRCCtBQCEfzSvU2HvgIODiTPuAgvxlrcylng0R6AklpSCumxvQsWgtREbRTPFcVikrK3GC5v49hojL02Y1ibjngY6GXd1bqFiVjt8LNXFaQuG3sBJWL36gsdGyqU3t1YXAfOHaBOHyV58BqGLluPHZLlLr+1QY4gocF6Jwou4OQcbHg9IgPgJFp/ZTqfA8E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(82960400001)(8936002)(41300700001)(478600001)(7416002)(6486002)(5660300002)(966005)(54906003)(316002)(8676002)(66476007)(4326008)(66556008)(33716001)(66946007)(6916009)(83380400001)(26005)(6512007)(186003)(6666004)(6506007)(2906002)(9686003)(44832011)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v344VkT0ekI8WgJTd0Cep8XoInOlyLTit78DYtqdJbW2luCb7TbNkY+79aT/?=
 =?us-ascii?Q?xzail1UXdB7zBocRQg8ExsCD+Dgb+sr2TVHmLmrhy5kIOvVvcdAH7oyGfJ4y?=
 =?us-ascii?Q?Qbal8EyzumQBf/DlR+DfECh+SO16tPNrdeZar5Autg5fI3N2TV9r+gmArnee?=
 =?us-ascii?Q?Zi9EgtJU/NEORbavG3a/Z1l+1w/1Bymqwdy/LO4yo/mPH60Fux/SjXFSeEpq?=
 =?us-ascii?Q?JqrytaeciPMpMoJTVpY/DbuMXM93cI0W+kp34B5S6J4qZQJK2H1ys+vskWXr?=
 =?us-ascii?Q?H/BVtc2aw3faP94zjw/sTY9obxKaUj8fSSzB/fYbt9T3LdREZleBdGIs0Jvg?=
 =?us-ascii?Q?iYHv2ZYuIWiYW8N7ekV8dM4K53qld/iO0NfXytCWCFvqSFYEukraLmJVI1m0?=
 =?us-ascii?Q?XOJtnhh6IjcY9fUvcEliZKlPvQYXtDvWp9eC18/wS2KHrI5JRocXimt3rHA9?=
 =?us-ascii?Q?6MOzptAETO/2VAL6OPax+NlBSqtOfc6U8IW0nnkG7kBLGGkFV2xKfDiJZepR?=
 =?us-ascii?Q?3Lyw4B+4vUOBYHWPQXHaMjlFK1NwQFF45u4XPAqJbNss9ud3Y18zBLiPVVJo?=
 =?us-ascii?Q?GohJ+8KMASeqi/MfjthTuGOQlRmuwmfO+/+1DC19d/dlvZeDyE75IszDKSXx?=
 =?us-ascii?Q?gJXkOChfDF3GiVPEh8f2YAhx9mNBIpS1YqpfzFTWjD1PBZA/FE6spjtPYXAR?=
 =?us-ascii?Q?4qwQuzOpcbs6Mchc1928/7kdyiOJOa146EEQsCHEoZWhujLBIIjYCLjhDIRD?=
 =?us-ascii?Q?j4QBYBTAbS/XRav6dm8zNRiIloCQB9r8UPOzyYryawsiGwj211sH0azxA10V?=
 =?us-ascii?Q?CztbD7X6GHink81gnia3zZsXYcaaJM3j7K7ph12LFcB5BeyS6vnNqcAu9hOm?=
 =?us-ascii?Q?KsMGbZpqKmmcPBUJ/Wlgzze3I52XsI1H0YvOdxXZWYrgNz7D+pfyU+Pf6WQ7?=
 =?us-ascii?Q?n/hN90AJehAwQaJ38dMXQ/YUNleDVGbHW0r9CvLRiGlKK3H748vecmj0bPsH?=
 =?us-ascii?Q?gP+QKotg0iNL7vAtkpBnvGD1UDb22fGYUKTiK5YicukLnPOswhGQJXo1d9sQ?=
 =?us-ascii?Q?Qaig2I6gXbkrs4WVSMEpkTTxMInZV7piJi6k2PGXuvbCbBTzkRqiYyWim1PG?=
 =?us-ascii?Q?5ToI70Cbh28359gFf3Ut1QAvNcOjWu1A08xvGJspJw/3sGMqYwbuu2tiy3aw?=
 =?us-ascii?Q?YPQkAVlYpLJEzYvWmAVFjSU6aCk7Z3uqxbC2ze5JfPPzUeodKuZQMqShrXG9?=
 =?us-ascii?Q?HAWkth1+PxBusVxYzoSk3UgcmqxW63R53j9Ue1n9zftG6r8j0YSQ0jqASkHB?=
 =?us-ascii?Q?cETgNRZew/PDKpdSlKQcqq5pPb9E/Wu5dOnPqmwjYaqu55c02rl7q55s7yz5?=
 =?us-ascii?Q?mC1HyDJZy+q+TGmeJq/+zb+EkfAru4z6BX0wiZCGUOlInJP+GNesvKQLQZua?=
 =?us-ascii?Q?u7d5pbuTVbtCWVvk/1yqmo5c2w0siIL2AxSfPMtn3Icon7WGhWGpD3Ul3uBn?=
 =?us-ascii?Q?STfpaeo1orWrjHSzyNLXs3NSdKnj7sxaVhV1NWQ7rBtn1Du4SwDmxITCpMgt?=
 =?us-ascii?Q?xwcObO26soCqTd0CWoIBaFxTZ/+l2Q9MoK+IsbC8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb4f296-7a9e-4a60-5b3d-08db0ef1126a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:07:56.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBfEcs47Vjb4yNjNAF0ApENHDlxLccfMfoZwLEgKmaoe+nj4blyxBiQ5qqEtCJsEtDWr9XFGQB+PA2slU4d1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5088
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

Hi Arnaldo,

On Tue, Feb 14, 2023 at 04:30:56PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 14, 2023 at 03:58:23PM +0800, Feng Tang escreveu:
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
> > hardware events of shared cacheline are still per cacheline, and
> > this option just changes the granularity of how events are grouped
> > and displayed.
> > 
> > In the c2c report below (will-it-scale's 'pagefault2' case on old kernel):
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
> > are listed together to give users a hint of extended false sharing.
> > 
> > [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> > ---
> > Changelog:
> > 
> >   v1 -> v2:
> >   * Refine comments and fix typos (Leo Yan)
> >   * Add reviewd-by and tested-by(for Arm64) tag from Leo Yan
> >   * Refine cmd description and commit log to avoid using
> >     architecture specific name (Joe Mario)
> > 
> >  tools/perf/Documentation/perf-c2c.txt |  7 +++++++
> >  tools/perf/builtin-c2c.c              | 22 +++++++++++++---------
> >  tools/perf/util/cacheline.h           | 25 ++++++++++++++++++++-----
> >  tools/perf/util/sort.c                | 13 ++++++++++---
> >  tools/perf/util/sort.h                |  1 +
> >  5 files changed, 51 insertions(+), 17 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> > index 4e8c263e1721..cc18d61ec5d5 100644
> > --- a/tools/perf/Documentation/perf-c2c.txt
> > +++ b/tools/perf/Documentation/perf-c2c.txt
> > @@ -130,6 +130,13 @@ REPORT OPTIONS
> >  	The known limitations include exception handing such as
> >  	setjmp/longjmp will have calls/returns not match.
> >  
> > +-a::
> > +--double-cl::
> > +	Group the detection of shared cacheline events into double cacheline
> > +	granularity. Some architectures have an Adjacent Cacheline Prefetch
> > +	feature, which causes cacheline sharing to behave like the cacheline
> > +	size is doubled.
> > +
> 
> Humm, this is something not that usual, so I think we should have it
> just as --double-cl, ok?
> 
> I can do the adjustment here if you agree.

Sure. Many thanks for the review and suggestion!

- Feng

> Thanks,
> 
> - Arnaldo
 
