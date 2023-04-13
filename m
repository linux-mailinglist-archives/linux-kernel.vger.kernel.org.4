Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BF6E0FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjDMOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjDMOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:09:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D09E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681394996; x=1712930996;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ou826BIIvIMr8BBj+foYNk+ve6Y/4fDOWbbkT056JkI=;
  b=TWxR+AGb0gsSKbKBdHTuhPLcpLboDmZMSsQF4YIAMGrM/cgxvUK0D54i
   /FB/KfQOWMMU33c7eJbVxIG7s2Irn8fTmYboEp/msL8tDBzumb/6pyq22
   DA9DU7r7Uk6pMZh6UEHeSPujUQhQ7EzWpNMIrnL/Q0FYTaTMWJYRTbT5E
   H4d2+Me0NB9pVyIJjlgOtBwnxaPmYIGhaDi1hUMDJe84dXrLSkh/EUpbn
   Z8xJe+hFZ5/ezfYByWDUxhdWLNcS+zzyN+wyIR/qsFFyMSGlFWh/BZKd7
   E+PvgVZNlxIZHIZTDgfdsZzz8AwFfPCb+BSCD16u/6uILLgn6KzIiG2tO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346000256"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="346000256"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935597100"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="935597100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2023 06:49:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 06:49:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 06:49:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 06:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDnjZASxMMDy1XMrpe/TVwVI/pu8XKNzAQvVTWflvK7J7xvUDspBiHqvWWwQSuvDFXzk8ABhA6b1Rx6D77VzBH7d5mKESb31NvRyZkqArqqY6Xqs2aj2a39d5qB4P0GjGLr5osbFascKXXDrjXLSdEm8TjgG1h77YXcLxBPGPQIAZNc/agFI3VlAFYZ2JRL+KLloCccokrVck+wv601Bmv3YsD0v2pqOC7DByWQaqorESyurVEi12MQvzqdG1m+BLmWVILHeAzMt52a0V/CEBxFTWrRQzWZ4qrYwXzmLyaSA9lLBKJgZAXTp8FkSDT+ukJaKJmIklYdvVYrjmCVmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a7KJKtv2wlzZvAGEXykZpfgcZSM8x9KnMNTGVBFNM0=;
 b=MJ0sWMeEqz2TzqjOfCBBDXl1NW8lb25UiTINeyzRdbWKF0nTIQmgpS/uxf3/Rh/wdg2GFBka4b+VEjQITvwkMxjJGAzUpjL+9V24ruKHffEKIuv6UP7qefeVPSVfMUmBvmbVdWMRxlhViBQxf2zjLaqnjY7IvuXqN/cMEKnpfi6ontOp5dDhQjHxzokvKHd8mQ9CtCkDlSM3ZN/9US1cJWor6Sor0lgFWh1xy0nZ1FyrzQnZEKyOlDOeTrREGdSC4OkjZNwoYkgFcMvl/LVTBuFqkHbJDMSEeT0Ez0SsW4nhbnGszkQY0YEaOGnO8nwMOTOgVQ8UFFiJr1zPHMSReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 13:49:23 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 13:49:22 +0000
Date:   Thu, 13 Apr 2023 21:49:12 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230413134912.GB214119@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
 <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
 <20230412114240.GA155547@ziqianlu-desk2>
 <20230412142616.GI628377@hirez.programming.kicks-ass.net>
 <20230412143934.GB162902@ziqianlu-desk2>
 <20230413111047.GB83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413111047.GB83892@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM6PR11MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 33de9afa-ea95-45d4-6a46-08db3c25e31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOXK4JlJR46CzveIgC7i0XxNpdE4uEsdPaJ7vX5xKDXiI2CT943KcGlpCLp9J9kdPvyyDXQdLa8yUXOMSj/Gt4gJrDPfFiVEc5U5YamCs/dWk273fwlvm42iI4lg9f4rlQqBLJEdeY6R/S2N8/CYc9divAwMtt92UREXYhO1DmB2do58A7hThuhM2PQ374k3XPUCeOhp+XTJebpyok+Ji+jKqn+8TVmrZnkY8O3XXOn/LNBvTZNse4Tfq9CK4QmDm+Kd+TstQZhD5SXfrPHRsmFunkhPbgnnwuAXQxCPvU6C74Mv7/zo9vcoMcmo3o1KNZzQMYm/pBm2cBGLE6dcJQu6S09MySL+qpZI+EAqS4PMmkOMpXode/YXiE3hpC+YWGOhPAIgR6xyhruoZG0fph35yEwbQuxL3V3qO7b7632BHMlq4lRyl2wuv+hQoGsyAYWX5ElnIE0+1MfC29MUKWOk96MEagjv/EmzzYgqBvWNlotrHaK8+vEwVyv5l4zcmEgfNjbDlLy2ppOoK+FpXmygGlhRYQD4LFjRUNWv2ehi+F0XKbIReR6muMOXlUfP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(2906002)(8676002)(8936002)(5660300002)(44832011)(478600001)(41300700001)(33656002)(316002)(66946007)(66476007)(83380400001)(82960400001)(66556008)(54906003)(6916009)(4326008)(186003)(86362001)(38100700002)(6486002)(6506007)(6666004)(26005)(9686003)(1076003)(6512007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyXSsVnXT/yIMJ9ZL0WwNplYADFbE5VcF5/wi1M9BmQLxDzRmXFlfEe9bti1?=
 =?us-ascii?Q?ZMCukqFjws78g2p13sCvUin4I6O9RJTs4Ebv+L5lRbR6Z8RNnXlELESPUJpE?=
 =?us-ascii?Q?wVg6jWrJWIjezBSLiPTmPo6v6Rb3FG1LZ/v1GbogbAEZYnBVkCGB2MrImuH1?=
 =?us-ascii?Q?fjpsrblyTsUBV9Ut9HF8WGSqH9oZqitiyhVE/k20AbvEn7YvAnhIYgTaGNmj?=
 =?us-ascii?Q?Fls4E3lzIMD4/fyX2eMLZiXYp/vylGMx3LrGQUHcfRMdnGD3iwRibWy8ftqk?=
 =?us-ascii?Q?s9PB+ZQRnW5qL9b//BqXUrrEjD8kgT8QK1u4IA57OjSNOiRxV2y3Mblz/la0?=
 =?us-ascii?Q?mzksHz7yHJkl0G072M92JW/XxVWKC4265xAu3rbOa8t7ZozJko07vIjM1vSA?=
 =?us-ascii?Q?SuvFRGuUY3TlHFG7o1U3wli93ZHwE0tuyUJcFzmTOvevcRnpbzjNhF2a5Kk5?=
 =?us-ascii?Q?dw1Yl/XYen5fTBU2fGrJaAoEBRqrF8XD4uMe55cyFJGEcj61S+PC3rHuZUgE?=
 =?us-ascii?Q?oY5JVSY0SGB5NX4H8UQfuLjpz7UImYO+d6SizU7twnLmSPUOZ812m/bfU4lC?=
 =?us-ascii?Q?Ak9x5VJ8PaAJN8cU0y9k+vwq22z/p/A0VG5dG9giHDHaBl1f4Bxnccw9kS7M?=
 =?us-ascii?Q?lAhaqilVHXgcxsdrSY5V49IM3uhVSFXclQEucHIU968AsVIdGbxSDNU44asr?=
 =?us-ascii?Q?P5Vhk44JJWCCUS8BcU6c6yfJxj8FimenfKJElP8vQrz3Qu5VYy4AWUHnEm4s?=
 =?us-ascii?Q?c2KWQjoQx04UzxDr8Ou2Pd4hQ9D+kh3HZ0RNBq28bbAYaljbcaJt7b1j4EIz?=
 =?us-ascii?Q?PxIr4GOFIgRH5edmm8N7mbFs91fcoOHAcr+Di3MtHpYOyOkK/uINPNXEvyod?=
 =?us-ascii?Q?X2xe1azopYBbhQfs0QvyKlRMeZocbxp4zEvEjq2H4NOEGi5LxeGx68nx0H0Q?=
 =?us-ascii?Q?6e2srGEJX6Pev1fKaROqCXS2s88+VSdFjwLtiArfLPpe6CMlQLCX1cD0TH5n?=
 =?us-ascii?Q?WFC3Sva+dDo0VDCWcHmfizUF4XEkoaZ1lfXYom+XTEIJLY4TE4ptU/UtWb71?=
 =?us-ascii?Q?WQ8/iA+IYaPkDdnM92WdHeQB7/BkwYo2Gze6Ags8wbXWJbEosY6P1gzLYIz9?=
 =?us-ascii?Q?OoxkjLaMFHryfmrnloKsDmvyD3T3iFzvYDLoxw8TMRgbGHLIVViWnIQZB4N3?=
 =?us-ascii?Q?iPW3hFRoDURGV2HsN10SGiYGpXX82DdroyTO2tJ0KhdaG4FWKNRhZrqOsyzf?=
 =?us-ascii?Q?/i8Bn62F5cbfClaPbdy/KIlF0aQ4SOUJk2+Wz0EPFQ/2VHGzpfLvHdT01Jg1?=
 =?us-ascii?Q?tDgfZjgGKMeaCrfVjkzuU3ftsNPPiWxe2LtmykLO6U0OVMFlGV8FAnpSxZyd?=
 =?us-ascii?Q?JMj4tJqUE5YJJlY/qTqlMxQAFWShpOUCuQ+zQtHwHx2gpOgV1RJ5UZ7KAf96?=
 =?us-ascii?Q?FJWAn1NgAixvQ5HAbezrOr1MZDi6jjalM7ZeE46urifMegH2GOlZKLHIOZdb?=
 =?us-ascii?Q?dPzryHyPXkt/cRCIHw9qo1chLfhcih2wdedHiCZ9VLI5Tangu4ddHlEpeoaG?=
 =?us-ascii?Q?LziqdLevq1J8SkxqryI/VQQFmS+20Rlx5sHmzPzT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33de9afa-ea95-45d4-6a46-08db3c25e31a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 13:49:22.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuXRX5Wj/WaNiEIrNoqv5AeDei1n/eB3L/NnQSksKD0mcIMlAyKRRi/BpWX52+H/BvZPVGXJ9MkBCtotQX6apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 01:10:47PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 10:39:34PM +0800, Aaron Lu wrote:
> > On Wed, Apr 12, 2023 at 04:26:16PM +0200, Peter Zijlstra wrote:
> > > On Wed, Apr 12, 2023 at 07:42:40PM +0800, Aaron Lu wrote:
> > > 
> > > > I *guess* you might be able to see some contention with hackbench on
> > > > that HSW-EX system with v4.
> > > 
> > > Indeed! Notably it seems to be the wakeup from idle that trips it
> > > hardest:
> > 
> > Could it because for idle cpus, the per-cpu/mm cid is no longer valid for
> > the sake of compacting and when task wakes there, it will have to
> > re-allocate a new cid through mm_get_cid() which needs to acquire
> > mm->cid_lock?
> 
> Yup. And I'm thinking it is futile (and counter productive) to strive
> for compactness in this (nr_threads >= nr_cpus) case.
> 
> The below on v4 solves the contention I see with hackbench (which runs
> 400 threads which is well above the 144 cpu count on that machine).

I also tested on Icelake and SPR using hackbench and the contention is
also gone :-)

I then tested with sysbench_postgres, the contention is still there on
SPR:

    11.63%    11.62%  [kernel.vmlinux]        [k]     native_queued_spin_lock_slowpath
    7.91%     native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
    3.17%     native_queued_spin_lock_slowpath;_raw_spin_lock;mm_cid_get;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;epoll_wait

> 
> This obviously leaves a problem with the nr_threads = nr_cpus - 1 case,
> but I'm thinking we can add some fuzz (nr_cpu_ids - ilog2(nr_cpus_ids+1)
> perhaps). Also, I would be thinking that's not something that typically
> happens.

Let me see if adding some fuzz helps here.

For sysbench_postgres, the server uses process model while the client
uses thread model and the client(sysbench) started nr_cpus threads so
it's likely didn't trigger the (nr_cpus-1) bar here. I doubt the bar
may have to be as low as 1/2 nr_cpus considering that some of the
cpus are running the server processes.

> 
> Mathieu, WDYT? -- other than that the patch is an obvious hack :-)
> 
> ---
>  include/linux/mm_types.h | 8 ++++++++
>  kernel/fork.c            | 4 +++-
>  kernel/sched/core.c      | 9 +++++++++
>  kernel/sched/sched.h     | 2 ++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4160ff5c6ebd..598d1b657afa 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -609,6 +609,7 @@ struct mm_struct {
>  		 * were being concurrently updated by the updaters.
>  		 */
>  		raw_spinlock_t cid_lock;
> +		int cid_saturated;
>  		/**
>  		 * @pcpu_cid: Per-cpu current cid.
>  		 *
> @@ -912,6 +913,12 @@ static inline int mm_cid_clear_lazy_put(int cid)
>  	return cid & ~MM_CID_LAZY_PUT;
>  }
>  
> +static inline void mm_cid_desaturate(struct mm_struct *mm)
> +{
> +	if (mm->cid_saturated && atomic_read(&mm->mm_users) < nr_cpu_ids)
> +		mm->cid_saturated = 0;
> +}
> +
>  /* Accessor for struct mm_struct's cidmask. */
>  static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
>  {
> @@ -928,6 +935,7 @@ static inline void mm_init_cid(struct mm_struct *mm)
>  	int i;
>  
>  	raw_spin_lock_init(&mm->cid_lock);
> +	mm->cid_saturated = 0;
>  	for_each_possible_cpu(i)
>  		*per_cpu_ptr(mm->pcpu_cid, i) = MM_CID_UNSET;
>  	cpumask_clear(mm_cidmask(mm));
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3832bea713c4..a5233e450435 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1233,7 +1233,9 @@ void mmput(struct mm_struct *mm)
>  	might_sleep();
>  
>  	if (atomic_dec_and_test(&mm->mm_users))
> -		__mmput(mm);
> +		return __mmput(mm);
> +
> +	mm_cid_desaturate(mm);
>  }
>  EXPORT_SYMBOL_GPL(mmput);
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 425766cc1300..d5004d179531 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11550,6 +11550,15 @@ void sched_mm_cid_migrate_from(struct task_struct *t)
>  	if (last_mm_cid == -1)
>  		return;
>  
> +	/*
> +	 * When nr_threads > nr_cpus, there is no point in moving anything
> +	 * around to keep it compact.
> +	 */
> +	if (mm->cid_saturated) {
> +		t->last_mm_cid = -1;
> +		return;
> +	}
> +
>  	src_rq = task_rq(t);
>  	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(src_rq));
>  	src_cid = READ_ONCE(*src_pcpu_cid);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f3e7dc2cd1cc..6c4af2992e79 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3347,6 +3347,8 @@ static inline int mm_cid_get(struct mm_struct *mm)
>  	}
>  	raw_spin_lock(&mm->cid_lock);
>  	cid = __mm_cid_get_locked(mm);
> +	if (cid == nr_cpu_ids - 1)
> +		mm->cid_saturated = 1;
>  	raw_spin_unlock(&mm->cid_lock);
>  	WRITE_ONCE(*pcpu_cid, cid);
>  	return cid;
