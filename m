Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E159D62B535
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiKPI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiKPI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:28:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7C21804
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668587172; x=1700123172;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jgiY9LdDB2qXEHwNdlA5rhC0KYKVKUqxtpt73TYQSAc=;
  b=LsLNTvzhAicGYQqmWWew/UkEwChZJddX/FweLvlBy3JQhcMhFEi4cCd0
   TS1AbM9kk7hgTifkfBMAjCnryFwUpCWr4eZOTI0Os3iqxY2z5K3aTrteL
   +EnlBjIAtd+lgseDsHA+efM2I8uOxtKG0Pr0DhPJdPCp+WSD7MSyEVUje
   HEAef/VYr2Q3C4wHfst7BPaOFV/BJ2DQeS6cBBttzkYIE9MC1ndPgwfPy
   K9Lfse0Hs3V6MTOs4o3c9yQMyeC7TjUuUb4ZCzsm9KZVypeICD55ncvZe
   vmu3O5mPP/Af3eUwRbWxY45ShC/I/I5cETQiokrPTQdrBNB0dmb/JqD6i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311192259"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311192259"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781670507"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781670507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 00:25:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 00:25:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 00:25:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 00:25:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxHJ0QmrgJMrKFIjMZ00erI/oVZXOse7VpnJ+FIOixShtS5SHOSBf+HlA/r/HEYOCwHe5Z2c7YvwWcLDf3pJZ5aAaakkm6+TgrguO9xTYXxEsYfr33Y+D8JdTtPyvx+FoLgFe8RuveBL1G04ejppVLE+MjhaIUn+AG4T5zXktdX4g4uShn4hhOuVI5kGPskoEGFgvPbxEcwMkUX7VAW0urcQNn3u2MI4xNfxKt06l/4i2cuwEr3DFgRuXzndrPej7J2Qn2qYdYKc7LcNQ+BQrAMqg2lNzp8pf3a5c8I1vvQFXI1pyKEz4oyuTIwuxk9dZ5xGtbiI+Pa/SsMu0djrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+V0vUPTQ/zgqDiyiCFyvDEP6TuU7mUiLE+QykWFYQc=;
 b=mtKrGFfob280cnaLxU15V4YrS2QY/iXPUSrHFBDHTGSLSxq1mUh5pYJJwLQqgH5Wu3laF7hLYHW4o7Eb7kKfgp/Ja/qxnr5NQP5T+Q2GZlDZso7AKScEfInBIG+sBTj6EXvQIgP67u8/7ILBdY6F7GZJcK4AlU98BsO0MdBG0XAtsXfD2gfabc5sdh2a2HGpMuGy52vwIlzlqPxSLFH2Lgq3UaxZpIk7UqeI++mhUJA89uP+T69RE5WkRqieBImoOTMsfHnoX7bv389LODU5pxqf5gKXM8LlWi94ij2w456FILKT7rnRXsX/CfakG4R+P9NmziKhwjQMp7tWRNIkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by IA1PR11MB7245.namprd11.prod.outlook.com (2603:10b6:208:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 08:25:53 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::9784:1dbd:35fb:93fa]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::9784:1dbd:35fb:93fa%4]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 08:25:53 +0000
Date:   Wed, 16 Nov 2022 16:25:33 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Joel Fernandes <joel@joelfernandes.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <parth@linux.ibm.com>, <qyousef@layalina.io>,
        <chris.hyser@oracle.com>, <patrick.bellasi@matbug.net>,
        <David.Laight@aculab.com>, <pjt@google.com>, <pavel@ucw.cz>,
        <tj@kernel.org>, <qperret@google.com>,
        <tim.c.chen@linux.intel.com>, <joshdon@google.com>, <timj@gnu.org>,
        <kprateek.nayak@amd.com>, <yu.c.chen@intel.com>,
        <youssefesmat@chromium.org>, <riel@redhat.com>
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
Message-ID: <Y3SefaraLvX2hPYj@ziqianlu-desk2>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org>
 <Y3Gwr2p5BcofuZ8e@google.com>
 <CAKfTPtD2A3QaMON_jkhaobY0Wy+LpnAnfhtuaozK_OkmSvuf8Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtD2A3QaMON_jkhaobY0Wy+LpnAnfhtuaozK_OkmSvuf8Q@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|IA1PR11MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 343e5341-1706-4139-6df2-08dac7ac2cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sngtuNNpI+Ky6hmtkZn3YWYtL+/Egrkst9JX9ML0w2ljy37AqX4fPdy2GhS5AVUL8H7R0BMKDxrKRYvHfttaXgmcwoN0ETOoSvdV7JRWF+sviz+DSvMkHe+Y72FywIVjB+xzBT6ZW4a0qRZXB9fdJn4IRVb/txv0S4dCERIL1I96pBxiX/CNFDKE+drNp+1VC+RvCbqVfMz659C8TDfzZucrDKfSWoEA9qvk9RwrOAuPpNXTE5qlmbVskNrhViBzFBN1yc7F4ehTVTxQObLHpS59Mhm/oZD5Le0diKAoObZ51fyhGfsvryJaVPWFsi3BNy3qPNMUfYsKeaebPuX86kkZiks1UDfvxhSRQq51oXYau3I2SKiiA4CXYWtOeOWH70Tqdu1+Orpd2QkIDeWY0PMffx1XryzMAvpKWyYzqslypBuF2CXg12xDXraBzh3rU9YdqygmfJIBJvYo59vI8sl3r34xorOKLbUCEl8BBfq7hoGnlrB66kXLuoJZLXDyAG4qJWyVp75lg0GcZv4D7n+j/VY8V6/TEEpxDGuiFPHs5FTC/4KfNGdSpX7agoGWP40I7mRnN67dZ7MECS2cCTBQ38yOCOZ+TG5cxqvFTSyVhUfygScDrPrMqaskM+4w0W1nXRNH/dbyDUyOP9G9F7PORal4isiNUf/rVfoTu05bY6zn0TjO6sHZWZtwDdRffZ5UncLEWVrD9onIdr2iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(38100700002)(186003)(82960400001)(6512007)(5660300002)(7416002)(86362001)(26005)(6916009)(9686003)(6506007)(316002)(33716001)(4326008)(8936002)(6666004)(8676002)(66556008)(66946007)(66476007)(41300700001)(2906002)(6486002)(66899015)(478600001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bimFnC8BjtrTkkjXCpzfUvttEu/IT/CNJxx2W8HDs5bkhv1AsozujqFSAJX8?=
 =?us-ascii?Q?DWDHuhK6LV6EyNyZ6VTE3fNTp0TyJ7Jj9CFQFj4gqaLEwK5+avLTbcYJpbyc?=
 =?us-ascii?Q?9OBHmmIUDGDz76CLiklh6Seokufdj0+jqmFHLxKIuPnGuS0FJikMnsGJ8v1p?=
 =?us-ascii?Q?in2FQ51bOsUM6j1/RsQn7RTHgAZWifGdb3Kz68wO+c7uNin5UyWKcBK1U+31?=
 =?us-ascii?Q?wSx9bzIFg7tiW83fCw8rM/wlMVsIHpBlih/49yXtGKC5R02u2gGSG4eVH/t7?=
 =?us-ascii?Q?I6VJqRcYeyPtm2Oedjm1wYhGUgulx3XwdKfTsN8g5foHeU6V7qwtN5+cppY/?=
 =?us-ascii?Q?6EU2mFk9kon6bBxNG49KzGmrcO6NMImIEuAAPTamA0N5mcbBTTdIvFY/D23q?=
 =?us-ascii?Q?BBlSUgtR6RhQMCzdsJRXxdzSA99k6PKpN8xwfA1BOA+phKewr7QUFXLoyQHh?=
 =?us-ascii?Q?eTQ87QKhzxDsY+7E1HB+z0pMRg/vjXpDO5E1s2ulAPvM4es/bNg24U7WrOCZ?=
 =?us-ascii?Q?2qfEl7Q9Ze1hmMEpqajv0Veby1LJ9fFQ6YjGICxbWn9J8AVElSrVfTuD/HUr?=
 =?us-ascii?Q?aY+vJBrpHorgaNxReWTMxcCRuvAYecekCnIPo14tIA3w5hz0aLfpWCQ6lidr?=
 =?us-ascii?Q?NfybuuBTZ5oC0wX8bQ67tLr8qsfKdK2ob/+YSlz0/8xVzUD6odblaHfjIBNC?=
 =?us-ascii?Q?Lx9OyXF4xssNrZLYBS90Qm8fW2tIwAMuoxwC8qQw+OhT5IU3D3MLI8wpaqgI?=
 =?us-ascii?Q?8db+R/B/NJ9Z68Q2Lj9NxvPnSjWqye3mAwF/MlO4PPP9VBQcnZskdkMAEYEe?=
 =?us-ascii?Q?EnGUY4pnqVQubtG/+js45CUJLHCGmOO2kSFn6gmMUHRoDTP05xzqR4aPOtVN?=
 =?us-ascii?Q?rS61Cy+XnAeWAHNvVDP3t4VZri4iOOAI91YiQcixWQA/YoXNcR24kKOsgegi?=
 =?us-ascii?Q?iXM86U2NC+d472vAvg2U9TI/ZsxCODVGPE3FVQcWNCL3nX7FzXpyY09QTSwp?=
 =?us-ascii?Q?unfRJSv2BzlsuB2CdZPql6Pi5Q0RJBRIaY4JHAAymy0+zb1n5xQNgNyZY+/s?=
 =?us-ascii?Q?gqzNUGbgkKroiX54MM/9EohbEXTZvd0FQuBcV8AOg3RJFANNpD/SVaSEAhHh?=
 =?us-ascii?Q?xFrsqARZ0AJWCHF4w6lTSgKrV/9RQOITaTBcDQAC+bKR3pr/bC+HVYHXCR5X?=
 =?us-ascii?Q?g3K55jpDJDCT5M083A+TQIlWQOkSSA8I163B7I0jnmKyP6bmejQ0BY0A9nDN?=
 =?us-ascii?Q?X2IPjh3H3IRTqUJX+t8RHkSRKGC/nLrtnNa/rSD1JATd9hx5zWP/37LMBC+a?=
 =?us-ascii?Q?yItCLUv8LI8VmEX1IIbfyYeCOYCtxZrUFpncJ4mAJ+wPv680xechZSlM5brO?=
 =?us-ascii?Q?OLlK99XHSu3qQIl7/2Kl2Y8a/i/QLwwZ1QkyvDZdzA8aQYdjpkiW1y000R/l?=
 =?us-ascii?Q?AJrxU5LS4xxXIqZ+PrSigUz1H+Lw2K0sx6b3C9P2gjCnv4Pl13Nhmxlx4fQy?=
 =?us-ascii?Q?YsRIE6IP9ATjTiOVgPUji/rmT2kZfXgjuT8uSUR4UOatx44ZE2OhYhBlRjQ8?=
 =?us-ascii?Q?DszKES3ipl8BYfJ4BYJ2SNIW3XyAZIzf6sHayuET?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 343e5341-1706-4139-6df2-08dac7ac2cb6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 08:25:53.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ageGMT7U5QLtYdLeU1gwSb9Jv3F9MlXQxBMj87235Kp0o1thpSzNBfqGvjRHdimLsh3ySQ5hDuiFwQV7+Ot3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:05:18PM +0100, Vincent Guittot wrote:
> On Mon, 14 Nov 2022 at 04:06, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi Vincent,
> >
> > On Thu, Nov 10, 2022 at 06:50:01PM +0100, Vincent Guittot wrote:

... ...

> > > +static inline unsigned long  get_latency_max(void)
> > > +{
> > > +     unsigned long thresh = get_sched_latency(false);
> > > +
> > > +     thresh -= sysctl_sched_min_granularity;
> >
> > Could you clarify, why are you subtracting sched_min_granularity here? Could
> > you add some comments here to make it clear?
> 
> If the waking task failed to preempt current it could to wait up to
> sysctl_sched_min_granularity before preempting it during next tick.

check_preempt_tick() compares vdiff/delta between the leftmost se and
curr against curr's ideal_runtime, it doesn't use thresh here or the
adjusted wakeup_gran, so I don't see why reducing thresh here can help
se to preempt curr during next tick if it failed to preempt curr in its
wakeup path.

I can see reducing thresh here with whatever value can help the waking
se to preempt curr in wakeup_preempt_entity() though, because most
likely the waking se's vruntime is cfs_rq->min_vruntime -
sysctl_sched_latency/2 and curr->vruntime is near cfs_rq->min_vruntime
so vdiff is about sysctl_sched_latency/2, which is the same value as
get_sched_latency(false) and when thresh is reduced some bit, then vdiff
in wakeup_preempt_entity() will be larger than gran and make it possible
to preempt.

So I'm confused by your comment or I might misread the code.
