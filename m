Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC87B6D6798
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjDDPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjDDPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:39:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4B5583
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680622725; x=1712158725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yBxi/DotJgunlwvtJItJHUVJLQUGdHBm2tJjORBGkvc=;
  b=b+e+FT+b8AIrU8NkFT0df1fmM1nwMh6lxoqwk39v416JrQEv2Lfzr6Lq
   9Whvfoiv89ehvsxpmT9PP2OeU8YGWrz1xjJRyl5h+9mSKSsVgj8bn/k6M
   BKEqHz86yGAJY982ZBffkwWXbrbtAU3JzKHn6ffKnnwYTnzhlXdwp6fMf
   7Iw1VPvXKx4i8R/nDSWhP8/65P9P+Iqyzx5xKsGIF8RRndL4M31IGGdIh
   ZJFycMdTUD4lTbVZb6R/ZFUGdxTSxCBUNN80m+mDApv9ZNxBTILjXvPhF
   7V3Lgi+6Ntx6nb7U0mUtZI2duzfES74DCpxAX3bAG0nhhNOVlm+FcE7/0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370039141"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="370039141"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 08:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755688043"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="755688043"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2023 08:37:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 08:37:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 08:37:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 08:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmNIpE6ZM2ZWWzFpib/EoCI4oAm41YoZg1p0UbrFG9rotWlasx0CPL6gJnTtkCmU0vv+891G0NBThdq6IqHSz2n9TK0HH18bm5O9HHy6H3pWUtEs9OoGZrsg+VkoSQiWeRVvhv9krqsFnPdHOdqsp04LOBhX0Hc5E2Wm2mdpHuozrfFahb9CAgwUyUadNbKYYxcO+MgIrDBLps8BhyTulVBCHKyt4YDn1TqMB1s/c92A/VxfHrsTqvytsqMuerO1H3EEFju8fLBf+eqARf5LSfF5bqVRI2sXN/IbVSM9cRA7OuUi0HaMlmaTsU+ih7Se0ttjXhRduZOV3YepC2WCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i58VzweYh4O8OycQkKlAhBp8/jgNAKNF8VNokoAnqpg=;
 b=Ab4iiRSMAvhgEpdg0tvzjT34bE+e1AuI3Oq80savIRHzu7DKXOK5fKVEfo87JCkwyZpgxQuCxqpbfXdrQv2dEDDAXHLSAfbbu0bG57lKbXwgRN4FqlYMOk8BXkx5exYYxiHTYUE6jJcErrzvJhQXQBzKrptaiA2oIzV9SOoDn7fcJZhBT/8ZJDeD/6twwLKym70VXDuOu62H+S95KrrAgPLZZXQJmAc754F7CcveE4YL8iEqNhIFVOvpJCStAcGA8kjOB99n1947XZsKhVdguMsAwC4EN03xfryYA9QZmeUdbde2WbtsTUtTBKtD+EOBeg0zusZJV9cVFpJBvwu4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 4 Apr
 2023 15:37:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 15:37:47 +0000
Date:   Tue, 4 Apr 2023 23:37:29 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <ZCxEOVBO3kPGF4FU@chenyu5-mobl1>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <20230404151540.GA51499@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230404151540.GA51499@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 63253316-a625-45df-6cb4-08db35228a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icb/a9cRCiCRX5PcUEK3CNzn+eWzw9RdKrFsaWT4TX36NgmfE+3EZodqSQpuOTSUDnvmK/SpVHvfHdhykgo1z2IhIYvndbE6cQFtUmOnMoHSNLIfLfFaGXh6BHu9yGunU5cWMa19H+LZrHt/ZP/sr5/yGCoVP9YQ/GNoiVSqZ1ZlPCXBKqJBGFP9MfWTjwwrODkX6UjHWqvYeoeEWd5f1pi1z6VQKrj+aJaJl66Ozg/32V/dJflxxq43mqVidA/fmUm+52YLrL1DHRxEs1vOjY/EUrPtHeCnohxsndKAwcL0yyugwoG5inQ0uD6DJuWXm89jbYD2w68YFv2EJcLtG/oBRVOIt4izAx2um97/Khbij3RfinQbgk7GvG0iZ/05MuvKBGoQQtxI8KouCjWlsrUG84o/756iQlhmXUiGQPbwonIBkt0j/EFcoDpYJyNqY/YSC633X0NJTRUHajxcOJK6fasCRjxIni0QbgC1sizqhMidFRzH4ddkvMrIVUpHzObNfmXQmE2ym25ogfrwl/iXcligeOvlBSx2YhTmIlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(83380400001)(2906002)(41300700001)(5660300002)(7416002)(9686003)(53546011)(6512007)(6506007)(26005)(38100700002)(66476007)(66556008)(54906003)(966005)(316002)(8676002)(66946007)(4326008)(6486002)(6636002)(33716001)(86362001)(6666004)(82960400001)(186003)(8936002)(6862004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dEuHBaZYtC8DogUVwenynvrX6zloQIoGZ22Qg980y8G7vgswd+q4vaIoqx4X?=
 =?us-ascii?Q?DoJO6YzWOogszebMnIjymSeFz+/sehZ8Q3JYdZWw3cW91I2DcXcHsIVZqZeb?=
 =?us-ascii?Q?FNCC8yUFBpk06n6dOAV9oxCRtdED8HgABtWDPhKBzBj9lmyV6LJpRbDndY1b?=
 =?us-ascii?Q?2p9nMCS1j0h6WMDZh4lBMkPYT4JhY4feHLGkHwaDEkNuNTDisR3nvBVCynPU?=
 =?us-ascii?Q?nnfGSgIlCZ9NNCz1Mc/ZORPJTy+8R0Dq9jMhnc7HPKuOnGlPy7a0DY2fCsmn?=
 =?us-ascii?Q?eBdjz0tY77koxXsR/TsZISeyWsV6qb3BMZCLnbZSSb/+pglwT7t27hUzQI8I?=
 =?us-ascii?Q?kqEJf1/XKLVI6NtAoy8NDdTwvkiB22MB14SgMtaRPA+h/tuUkzEiXQDyNpp8?=
 =?us-ascii?Q?3IrkbthBogZVfLZxn5IZNt3T2fsKQ1otRa2aRomgGTCdv7o0Pd8XWQO+gD0Y?=
 =?us-ascii?Q?g6/rYjHWoy4yEUjjHlvp9HvCcm32wvAl99W1mZ6kjXPGR3IK8c07j2kMjAun?=
 =?us-ascii?Q?EThQ3MR28hBR2exRbhBao98kaxld6Ohj+esrdibWxemJHyeUC9AYzcVsegHf?=
 =?us-ascii?Q?Nh1vrNxL8K+sz+MX4isTbw95lXk7+tLjAjDwMI+9oepLn1NI3vQGJ0VAbcr6?=
 =?us-ascii?Q?fFVsC0FvkM6gTIh8jaKegXsrnF41BaJIjMifAmsWEdIPrsPriJZHH6Y0F+tu?=
 =?us-ascii?Q?Q5Cw2kBZnJyMNn69oWdK3FXj9E8DXUbLxs2a6fvA3NKEvp+BpYxckjz1b3MA?=
 =?us-ascii?Q?rHaiRQSNNZFXS8HpOVKveoOwj844t2IM9n4i34WUC2lYE3BnkGnAp9haXH0t?=
 =?us-ascii?Q?wfOJAsAMFec8Mh5Z5/IKZwVVlPfA5aBKZQ3yzbv4pUYW8DunVamJT1yUzSUL?=
 =?us-ascii?Q?sRDLDvwvAFs2p3Yqm8lpw1Bf62pRvGXZIBCA8AoqIv4dSTFWXUdYA+OrYij1?=
 =?us-ascii?Q?HbGAAYTI6KY0iDE+Xu0JGQ9PEgj9jaytyA1Ly791IyNEgxqMfrLKDUcS23Ef?=
 =?us-ascii?Q?mLqBsQV6Bif26nR0DVrwPw9qSspkHtCVpIfQyFgaD1Sqs7nFOmqExGQ8LV6B?=
 =?us-ascii?Q?Vr3g47Sl8TeAYbDl+gOGOQ7j4ZVJwVXW67mYbMAjOHgGp7VL4590a9oQwoQe?=
 =?us-ascii?Q?oObcKWGvYyptlgwE/9PMv5TiIK00+M2O1Mk7tdZO6x4/RnUx2+02PWzHlCsE?=
 =?us-ascii?Q?zstwVyNBYZclPlhVojCCO97C6MxvXv1k0xcH4PBK3ae4wjddO+cw/l2JTCLD?=
 =?us-ascii?Q?f3RUs0vemz0gz7fQR3w0p6BulDhds6KsngXzxpf4l5n2RCpcOCOa5Wc9uEHF?=
 =?us-ascii?Q?3UXte6xnEAfq5F2n3P6hT6wyMPc7Gv2iz5qxttYcNbSvnZQkklcw6Li3i6PE?=
 =?us-ascii?Q?A8o/CTIExXD1SijWNO6eB/+XED8jhopnT2ik1Ackn/lmEObXWUJDPPueqnSv?=
 =?us-ascii?Q?/isiKhYyQhnqKEwEmx72QUZaFnX+1xzaOP/G1As2vfFtpz1l+KKkSELyd+Qm?=
 =?us-ascii?Q?Xbg6dq206rAQQ2r8udj2c3FYVJVlQWTNvigHUKeIHQLtBBq1s66aNCh9uIN6?=
 =?us-ascii?Q?ipk70gCH5TDRUViZhWGNs2SsckDaUEk3daZ/wnq/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63253316-a625-45df-6cb4-08db35228a4b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 15:37:47.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhW9ZbHCwgRbZQ9EClMBaf2KMHhnyptcL6DcJ8A9eeFlfmdjni7DnMGxJKDKRDOLgwWoXfjEt4Cvd85iPAyugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-04 at 23:15:40 +0800, Aaron Lu wrote:
> On Mon, Mar 27, 2023 at 01:39:55PM +0800, Aaron Lu wrote:
> [...]
> > Another observation of this workload is: it has a lot of wakeup time
> > task migrations and that is the reason why update_load_avg() and
> > update_cfs_group() shows noticeable cost. Running this workload in N
> > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > task migrations on wake up time are greatly reduced and the overhead from
> > the two above mentioned functions also dropped a lot. It's not clear to
> > me why running in multiple instances can reduce task migrations on
> > wakeup path yet.
> 
> Regarding this observation, I've some finding. The TLDR is: 1 instance
> setup's overall CPU util is lower than N >= 2 instances setup and as a
> result, under 1 instance setup, sis() is more likely to find idle cpus
> than N >= 2 instances setup and that is the reason why 1 instance setup
> has more migrations.
> 
> More details:
> 
> For 1 instance with nr_thread=nr_cpu=224 setup, during a 5s window,
> there are 10 million calls of select_idle_sibling() and 6.1 million
> migrations. Of these migrations, 4.6 million comes from select_idle_cpu(),
> 1.3 million comes from recent_cpu.
> mpstat of this time window:
> Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
> Average:     all   45.15    0.00   18.59    0.00    0.00   17.29    0.00 0.00    0.00   18.98
> Average:       0   38.14    0.00   17.29    0.00    0.00   14.77    0.00 0.00    0.00   29.80
> Average:       1   52.07    0.00   19.88    0.00    0.00   19.78    0.00 0.00    0.00    8.28
> 
> 
> For 4 instance with nr_thread=56 setup, during a 5s window, there are 15
> million calls of select_idle_sibling() and only 30k migrations.
> select_idle_cpu() is called 15 million times but only 23k of them passed
> the sd_share->nr_idle_scan != 0 test.
> mpstat of this time window:
> Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
> Average:     all   68.54    0.00   21.54    0.00    0.00    8.35    0.00 0.00    0.00    1.58
> Average:       0   70.05    0.00   20.92    0.00    0.00    8.17    0.00 0.00    0.00    0.87
> Average:       1   67.03    0.00   22.16    0.00    0.00    8.53    0.00 0.00    0.00    2.29
> 
> For 8 instance with nr_thread=28 setup, during a 5s window, there are
> 16 million calls of select_idle_sibling() and 9.6k migrations.
> select_idle_cpu() is called 16 million times but none of them passed the
> sd_share->nr_idle_scan != 0 test.
> mpstat of this time window:
> Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
> Average:     all   70.29    0.00   20.99    0.00    0.00    8.28    0.00 0.00    0.00    0.43
> Average:       0   71.58    0.00   19.98    0.00    0.00    8.04    0.00 0.00    0.00    0.40
> Average:       1   69.00    0.00   22.01    0.00    0.00    8.52    0.00 0.00    0.00    0.47
> 
> On a side note: when sd_share->nr_idle_scan > 0 and has_idle_core is true,
> then sd_share->nr_idle_scan is not actually respected. Is this intended?
> It seems to say: if there is idle core, then let's try hard and ignore
> SIS_UTIL to find that idle core, right?
Yes, SIS_UTIL inherits the logic of SIS_PROP, which honors has_idle_core and
scans at any cost. Abel previously proposed a patch to make this more aggressive
by not allowing SIS_UTIL to take effect even when the system is overloaded.
https://lore.kernel.org/lkml/20221019122859.18399-3-wuyun.abel@bytedance.com/

thanks,
Chenyu
