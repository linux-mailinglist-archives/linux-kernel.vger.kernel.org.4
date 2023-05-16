Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E57045AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEPHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:59:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0DDF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684220382; x=1715756382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ATdGPkfSEkTlQlqx8ZpZRTA1tZn3Vww6RhfY8FfRuMg=;
  b=b8Ar9rFOvv1yEuOS+6BKdQSHEHIoy9CRimNaUStS7x/NHFKMzmyqp232
   SSQ+p4IHxyqBtbSriznFjt2cFlrsyEe3BjCRwsFIFA0nJYe2dIC0RQwoV
   IvTel6TjKNogz8PJdLo/KH/DiQiAA3hrlCKYrIsxBTJlofk0mZgeu2gh0
   BS3YbgAw+c7dpnP3KTrYQ00L1pjEoaxS3AogRPVVLycypLrDQrZxpZ2aJ
   knrnMy69zxlG5KT4ye1MKL9xngMj1tuIwRm+KQfEiOtVcKRRYMPqw3U2G
   4wld04EvTixIRqVzd1bPMVaY81e8LxODHsBPx+VrByiBOHPvXltCgcoO+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="348900527"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="348900527"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 23:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="790960444"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="790960444"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2023 23:59:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 23:59:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 23:59:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 23:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhaf5D4CRbz2uBFJ9BKwK6aee+njgAx9WkNeuoD0VbAznS1AQ73gFh8yKCWdPKjWFnayusHV1+sy5PG8OP+BSc/49yiFsF3SBlmpdkmTJE5R/dsUUhptB2fC7It5kHC49K5Ar5sz2qF7uAFmbgHK3+Il2I3NFdN98g57reUxEkIGwL5QifSvUhOGkGgZ/ZerC/NZgAX0lggjREjs8nbtZIsmSNyv0/nCgem1+7TMaFG0DPWopCXfXfATcUWn/eJrEsMW7hDcX82BAjpygs2pCFeiimPjm/kbLRveAeb3NZ6O/LiHZTrvP5Wq3OJPK9/NLkngyuMkhfObX4NgUy06jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0joMdrazKsi8wBQKcaSwPKjoQ1aKUaI2OvVUD8uIiA=;
 b=NjLMsYQ5HySdZDaU/PDWuue/XFn9I0V3Qj8ESzROw+mv+GNHTMWV7RKZ8zL/AuwBR/WH9UZxVeO0LSbdePNab3KWjjbxpu1FYNRQ/9APItbUyCH61YReup9qYZgDdFrn4qfUy9gapQIpVj6MnxmvjMNCIKvKmZ1ut4WgcJlw+78FOCUzjQ7uQH1tsWi0HIWS8WhKaSbcRO1Z6waFZO7pb73lEXPQ0298fmPQhpX2WqBTahgqbE+8nH9/HDYN/5/FESTrz3CgdrP06OQI65DGtpdh76mNh4gkYm0+bL9ijyUPw1hvxrf0N6NWqEuzIkdACvVuZf1for+e4ABbizognQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 06:59:37 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 06:59:36 +0000
Date:   Tue, 16 May 2023 14:53:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Lu, Aaron" <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>,
        "michael.christie@oracle.com" <michael.christie@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <llong@redhat.com>
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Message-ID: <ZGMocw0rvtErnatJ@feng-clx>
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0371c9-7822-4a50-14fc-08db55db1bb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqETY7J8nlAq++kqM9UOsczdVIfzVDBzhtfxRLeIZ+jeEtCqyrNzSZfeZ047utJdQZwxnD2ZyWbwtjxKtspanSwTCvCsHdk76wXEIWUsN8KZfVbE7gCTF4ZyoUCN7P9WrFRiKs7UyXa7SHpLcnEhE3+tj2/8cOF1VNLzSDW4H8+6i+xzv8WQIrWRPYews+X8kihu8s18BLVU/TnEo8VKOWNWdOKQ1tLtE3nI4UW05ASKZC/Bvnul3gUzyF8dEK9xoqpvV3sE5cTZ7e0UCPuLZL1SOgUwzMT1ACeTgpuTp/MpqVzlj6Vs7YyjrczedZxRZo1fF8agQNYUwN6piSunaSZdorN/3M7LZhfEXBz8DHSy+XO7H3Cc6dlAZQXIobDBbZcPtpxSpmHXf7a5/eRfmYUR/R+Hi0vAsCMgYk0HeUM4zSWy4WrggGkgSFbiuJiGnXNcRcrOw9DXVFM+ub/za2jGEy7wfHTk1rXiNz2CaglH7JlhF0KjntEvdBLAUtmmpyC3Mgx0v/r3nlU0jixgHr2w+xDUKcBiz5MVwmuECqF/vmenWGEmvZOrQMLmkqKwMjHP/1f4r7lyC6ydcnHpsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(66556008)(54906003)(478600001)(6916009)(66476007)(4326008)(66946007)(316002)(7416002)(6486002)(966005)(8936002)(8676002)(2906002)(44832011)(41300700001)(82960400001)(5660300002)(26005)(33716001)(86362001)(38100700002)(83380400001)(6512007)(186003)(6506007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzRE5Urd8xvxUyfA7RScAyqnNZ1Lw7KYkSkX/Pmqvp8M6jvN7S3UZQpLENvh?=
 =?us-ascii?Q?Ae1Tlz7VRQbo2y6jo/3PQK8o/F7hBz19gZlI1xN/XIvlr3mc+N5/CB+R1zBY?=
 =?us-ascii?Q?umvh9Svsxj1EgycJvggiyq5yP/EpNpFsxHRcKBvo9N/cxV9CsgBu6rUX55/F?=
 =?us-ascii?Q?6bLfj2XzCnOVRSaR9F5yx75DPPDZYBdDnPrN8LbudXybSPud5zP5Z278aw4l?=
 =?us-ascii?Q?qIOh/i27Dc+aP1lZIZeqlOFltQGFoo8/pGXT5ToL+N6LFieLwQPNkLyflN+s?=
 =?us-ascii?Q?VK6bxL912omHkEds4EyG34EHz8Q6QjvhInT1ZsoXrYFCJbVPnLhTLAuGbxr0?=
 =?us-ascii?Q?7/osDZGH4brZs1JAenbDfuawjfsbYH6B9YpiGlwKOMrZiYV6xha+RA4mH/72?=
 =?us-ascii?Q?QFl9r/rq43p/vZiDrNu/zLeg1Gj7PJv8Xe4qxeeE1vQG+emxqMNv8VMD1mEJ?=
 =?us-ascii?Q?U+bQKxf1MzyGb9VDpmVB1CZC4erksrE/sokFfGimf4z2+Mp4KXV9FwC8/ALH?=
 =?us-ascii?Q?dgWUZBwQbdxoKxGENAeCZU4MDMqSvF5VKm/YYFYRM3bMIIgR65SeCFw5DpR8?=
 =?us-ascii?Q?yXVcoCbV9vgj+EvQIQv2f2dKr8RXGyGYyjMI/Mtsugehy+oeiP0ZqOTPu352?=
 =?us-ascii?Q?WIfHG0hMJOUbntj6XRNvJWgoTXlPpFbXNaFSx9kO1POgqVEWa+IrJSstMCJ/?=
 =?us-ascii?Q?yR2B0khcdO7vfKkl1vIXyU9o3lwt0355CE/KRWy9rzw0qVFmEKS+7/UxDD7D?=
 =?us-ascii?Q?zvudwxjo8n09pFLo3YOcjhU7uE/29AK9rJOxRZzeKCr8t9iEJBdImjiV5qu3?=
 =?us-ascii?Q?EquK167PLLxez48DL97xpfdlsLW5CMs+LjCUZ/lousQICAqB01DAuzE5Mte5?=
 =?us-ascii?Q?P8TPstcOfjWGznDMwldf23qPM6LiOZrfkunJHsVsP73dCcbGRC/dtI+kGaXv?=
 =?us-ascii?Q?j6cCLlOcl0cpAzYm22Y3nrCHzas7As8fpVa/hSbv5EZhC7izCn+S+eMQu2xR?=
 =?us-ascii?Q?h9DEmX4i3T3x+8XYdY7eUbWbmJQ98PaUnGYxkOawdxOzBQoFWZIf6D/oUFwk?=
 =?us-ascii?Q?J1olBqYsJ3smnkrEwo31CclgEgO8pL0QVmogIjtjd7aShqIFjquNR98jBQHs?=
 =?us-ascii?Q?HLaKYZ+luSSaOLgovQrErLvVZM4+oTerRDdad8TQomhfmY3JQE2+xW/H2zL9?=
 =?us-ascii?Q?aXaZrECTQ6K9b52QFKd6gsYzLOhtKXVKHiTYiq1xdDmLn8adqUcs+4AWgpiB?=
 =?us-ascii?Q?dwn7C4HSuRWpMZ3lcoEIGH2IWEagXLkI5yfhVFjxNa+ObePSC8Gwp9mCBGxf?=
 =?us-ascii?Q?Rjjj9bpmS846KM1s9hip6dHow80auDlV7jnanCbzypHsqQ/fN8jS1KQsO4is?=
 =?us-ascii?Q?Vqt5pImeBVfd6njKT0ao9GkG4Cp7ER1zADngxN1/HKVQU2wV6Zyr3X1b22DI?=
 =?us-ascii?Q?PEFZ3Kmv1IUifP4ewMgzUpC3CXZym4Gv+XSBF+A+7Kg+kK7Ipbd8cqS3rGRl?=
 =?us-ascii?Q?JwCfo62Hr3U8R93pJSZFkqk8AUuXjljPqA9nBU4aSegpC9yMDcIXV6wAzoxs?=
 =?us-ascii?Q?6z6wg7JEU+EykWF8Cb0sUVn+1zCE1+njYNrrF3tG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0371c9-7822-4a50-14fc-08db55db1bb7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 06:59:35.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+0eIeRZMrodWUPu+7oTl7x9hkZGaxa7Q58yjLupIpqxSFXrQZPiTEX5QRIbshW7Zr5ARoCkyM7eIlcsovsnUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
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

Hi Mathieu,

On Mon, May 15, 2023 at 10:35:36PM +0800, Mathieu Desnoyers wrote:
> The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
> performed by context switch. This causes false-sharing for surrounding
> mm_struct fields which are read-mostly.
> 
> This has been observed on a 2sockets/112core/224cpu Intel Sapphire
> Rapids server running hackbench, and by the kernel test robot
> will-it-scale testcase.
> 
> Move the mm_count field into its own cache line to prevent false-sharing
> with other mm_struct fields.
> 
> Move mm_count to the first field of mm_struct to minimize the amount of
> padding required: rather than adding padding before and after the
> mm_count field, padding is only added after mm_count.
> 
> Note that I noticed this odd comment in mm_struct:
> 
> commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
> 
>                 /*
>                  * With some kernel config, the current mmap_lock's offset
>                  * inside 'mm_struct' is at 0x120, which is very optimal, as
>                  * its two hot fields 'count' and 'owner' sit in 2 different
>                  * cachelines,  and when mmap_lock is highly contended, both
>                  * of the 2 fields will be accessed frequently, current layout
>                  * will help to reduce cache bouncing.
>                  *
>                  * So please be careful with adding new fields before
>                  * mmap_lock, which can easily push the 2 fields into one
>                  * cacheline.
>                  */
>                 struct rw_semaphore mmap_lock;
> 
> This comment is rather odd for a few reasons:
> 
> - It requires addition/removal of mm_struct fields to carefully consider
>   field alignment of _other_ fields,
> - It expresses the wish to keep an "optimal" alignment for a specific
>   kernel config.
> 
> I suspect that the author of this comment may want to revisit this topic
> and perhaps introduce a split-struct approach for struct rw_semaphore,
> if the need is to place various fields of this structure in different
> cache lines.

Thanks for bringing this up.


The full context of the commit 2e3025434a6b is here:
https://lore.kernel.org/lkml/20210525031636.GB7744@xsang-OptiPlex-9020/

Add Linus, Waiman who have analyzed this case.  

That a commit changed the cacheline layout of mmap_lock inside of
'mm_struct', which caused a will-it-scale regression. As false sharing
handling is tricky and we chosed to be defensive and just _restore_
its cacheline layout as before (even if it is kind of weired as
being related to kernel configs :)).

As for rw_semaphore, it is a fundermental thing while that regerssion
is just one single workload of micro-benchmark. IMHO, any change to
its layout should consider more workloads, and deserve a wide range
of benchmark tests.

I just checked latest kernel, seems the cache layout is already
different from what 2e3025434a6b try to restore, that the 'count' and
'owner' fields sit in 2 different cachelines. So this patch won't
'hurt' in this regard.

Thanks,
Feng

> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> Link: https://lore.kernel.org/lkml/7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Olivier Dion <odion@efficios.com>
> Cc: michael.christie@oracle.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/mm_types.h | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..de10fc797c8e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -583,6 +583,21 @@ struct mm_cid {
>  struct kioctx_table;
>  struct mm_struct {
>  	struct {
> +		/*
> +		 * Fields which are often written to are placed in a separate
> +		 * cache line.
> +		 */
> +		struct {
> +			/**
> +			 * @mm_count: The number of references to &struct
> +			 * mm_struct (@mm_users count as 1).
> +			 *
> +			 * Use mmgrab()/mmdrop() to modify. When this drops to
> +			 * 0, the &struct mm_struct is freed.
> +			 */
> +			atomic_t mm_count;
> +		} ____cacheline_aligned_in_smp;
> +
>  		struct maple_tree mm_mt;
>  #ifdef CONFIG_MMU
>  		unsigned long (*get_unmapped_area) (struct file *filp,
> @@ -620,14 +635,6 @@ struct mm_struct {
>  		 */
>  		atomic_t mm_users;
>  
> -		/**
> -		 * @mm_count: The number of references to &struct mm_struct
> -		 * (@mm_users count as 1).
> -		 *
> -		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
> -		 * &struct mm_struct is freed.
> -		 */
> -		atomic_t mm_count;
>  #ifdef CONFIG_SCHED_MM_CID
>  		/**
>  		 * @pcpu_cid: Per-cpu current cid.
> -- 
> 2.25.1
> 
