Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC173D74D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFZFs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:48:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012791A1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687758497; x=1719294497;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=v+P00Hop9f06jPfuaGmfCBKXKxXEMgt0JZjL3jfz4mY=;
  b=jVGrHmr3PEW8uyzKoh/0kOJFPTeTYoG8vgUdHl0z0aMXywkaZn1GQq1g
   CeQVlhFKuDR1BQixBCmxv5Fies2+ovxNZZSd5LmQzDUKOqIocfrCa2Nuj
   cf8F1EbKkufTp+mJn2UILBdcCEyJg/5UHecgTVmvYOc6VzTRd+j1D1huF
   wjRHbcrY+SClczHfG3X++oB7O0a8xaGlKHiZr3vX906DNXvFdmUTDvH2P
   puX8V5ousotxGr7hOlhiuE7mIBwwvTHxgBDUfTxmriwSPVHoKYMmNePAm
   QVZ4a8ofh02vMLrIoXcrX1UXLI4t57PHjZ9l/kRwtznke+VXSL96htUvu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="340767764"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="340767764"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 22:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="890170332"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="890170332"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2023 22:48:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 22:48:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 22:48:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 22:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/4X/9XbD1nbjNe3H8gwWfRW+y0hmTEoWq353GxSg5+bxzfjRk93K+6jUUe9ETnhbcgh03/OO7eYGFuPyh2eIPkWayPbQ9kgwKzWy8m5fM3fMuHvq0m4Zu+xkfsvWqYAmwOcQD107FIoE87ZASC6PzAyhMQL417gqiSvfhEtpjuewYuGnbMo/nnzKvI5eMQRZ22c8v05+pYxvIDmOm+ZQu+TCVmmhYvv5zCxGWtpJk4/+3HEYiuB6YesBSqb8bCYD3E+DhbZ0NSuSXnG4zXHIPgq4Va18YoVbxPFAFOXGPyzwnySG5hax9UL57kCKvo4BnNdGLWMQbOPEYrbATsoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjlh+duS34vkRgO7qM9NCQV4F+6XGrCyXdfYwsPOpTA=;
 b=MUHhfSrSMTNe9K/RCpGeCWUrRf76yZqdDv32O1QCo5BolBwaqBxs/js6H7NJFLhCh7ho+d5t19TSaL5t4YkoyFpujBHQTvGqxFOKMhSjFCdypkQxlyCXqSCI4IPufYdilRgrV4DbgoydbD4g6pgoVFoPy8SvSKi7q3ShHUS89u6dsTrqxWxBg+SMdHlxl8gDuMoJ5uTjp3Gr03a3Aezl2LpkH183m41THoX+sh69H6vWfWTMWnPpyvd7ipp2iB6KCBxCZ/V32fg/PVsru4wK3xfKf8+UjkQb/gCY6jGxUkjXoSUrf67QftpdODfKjsW06YU9VXhyB4Te+YNkspk1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 05:48:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 05:48:07 +0000
Date:   Mon, 26 Jun 2023 13:47:56 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Deng Pan <pan.deng@intel.com>
CC:     <tim.c.chen@intel.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <tianyou.li@intel.com>, <yu.ma@intel.com>, <lipeng.zhu@intel.com>,
        <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <20230626054756.GA435374@ziqianlu-dell>
References: <20230621081425.420607-1-pan.deng@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621081425.420607-1-pan.deng@intel.com>
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: c750453b-adec-44b4-2df1-08db7608eaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewwJuLeVTntv7YdyAbyPcHPiK3sqcP+7cIPZKK2Cdajr8S8W/wxGfvsm+RwZ/1lwt5c8afrpjVN1OXvGGzBIijh26KJpt0yTq4hmLi8MDHYbIyHYi4B1JrH3xThYCvNTwtCKQ2fjHX413fJmVpQ8Tytf5LASVsTep715Rg3lqUL3P6YuG3nlmfjgZx3di9M9O84f3awzEHrocMcFGMsf/0+sb6NiZqw6xMsPVk4mzpPqxMQKS2cuAggpw6xs/OV0OyiX0Q03RKjzw8TAaulHhjawt8hp2pGq6kTtSwwn0tFwDY5j9RW6Z9g2Wg0jLllYFLm8FG3/mVAXhVVbr5I2W2v5nXvr7UzFWBi48XvBHDwj79iL15jUH3QoZ8c5euoCdpcTG3qShQBBxnb1HCj36Ahax8bOtK1uyEgAVnmTUOWTTZogaYa2xm/xTNZZr5KXRRnQJNQiDxxyUVwA38lcdHg/IxuP2vb8sXsWVSfg/qbLwy5F9X/KYjfQPLf0KorSzGZFR11dCGW9+gusxXFiqAL0bT2Rbe3bR9Bj6xQvYF0Bm5mDpEvUJEfW0zJ9bt8p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(33716001)(6486002)(6666004)(82960400001)(38100700002)(83380400001)(6512007)(6506007)(1076003)(26005)(9686003)(186003)(41300700001)(86362001)(478600001)(316002)(66946007)(4326008)(6636002)(66556008)(33656002)(66476007)(44832011)(5660300002)(8676002)(8936002)(6862004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENJSGZRblplUTgzWmhMbm1mTzJDbFZmMThpOE45N1ZFVGNlY0J6UW9mMjBj?=
 =?utf-8?B?ZTdOd1dUSkR0UzI4UHhNVTUyeEFwWVY0ZEhuZlc0clhVaEZpTVBHWHR2OGIy?=
 =?utf-8?B?UGIwZmFjMG8wVytTODZBNndoRklPbG43ZW5VQjMrU0pqWXZvQzNKYUUwMnBC?=
 =?utf-8?B?NjVXaXRwcVNHZy9HMTQ2WUFYemo4VlhaYUxoT3V5SUJ0cXRDbEs1TGZ1RWpJ?=
 =?utf-8?B?QnU0NkZnYTY4cEFSbXB5bzFvUWdJaWdkSy8xVDlQWkp4NTBHQmsycFcyV0ZD?=
 =?utf-8?B?dDg0bWxOUkZmeW1RZkYrL3QxWHA4RG5DRzZSOFFIeklLd0lPSThrQ0E5U0gv?=
 =?utf-8?B?QVdqNkhWUmZ1RkJFYXh5YmcyQTJMUDRYQ1N6YjhjajV5MjJ5SDdidlNnYzZa?=
 =?utf-8?B?WW9EQm9uOTcwLzRVRnlmRXUwM2RCdHdEZHVXOGJhN2ZlTVB4Uk1UTG9kSXZR?=
 =?utf-8?B?eFI1elllOUpyUTg5QlpxNFVqRjhuVHJ5aGR6ZVRnc3h5VHYyMTdOSlcwOHRB?=
 =?utf-8?B?L1dYQ2hGVG42aXAzNFJzMTZuNDAvSzFHS3JuYThlT0pFQ3N6NW1jSDhSNDVw?=
 =?utf-8?B?dkk3b0J6MEp6dnRGVkJKcGV5NkZ6Qmt1ODNaQTFnd0RpY0E5ZTNmWFpJWTNH?=
 =?utf-8?B?clplZlJKcHlWbnZNTStxZUNMbEhMQzhzbU02cmV0MU5LeDNUNFpMWG1RUGVH?=
 =?utf-8?B?M1N2ZkpEVnkrQ0NFSmxIUXN3Q25BYWw1cnM2ZjBZWG53QUFheXNYV0gyY1ZS?=
 =?utf-8?B?Rm5GcUNpdGJvZ0FDblJadEQ5UGY3SXBBcktyK0ZyTGxNOUcwN1paeEQ0MTNK?=
 =?utf-8?B?WDlpTzdFUXZQNDRJb1FYV2tjTU1LcUFrWk8zMEgxNWlDOW9yTytVQXBPSmRY?=
 =?utf-8?B?U1FTbkswayt2R01mM1UxUmNRZmY0Qis0M2xXQ0xHUjVjVWdaM3l5aTY2OUNh?=
 =?utf-8?B?T251bEliQUN0M0d0elE2ZEhyNUE0djlRcUQxV0xVYmdEbkZzcGRJbUljKytk?=
 =?utf-8?B?b2ZjbnZQNktqMVBUbzdhdTRsaklRMTEzS1F5WWxiZlZuaEpPWFpIakNCODFt?=
 =?utf-8?B?UitDVEd3QjlkcXB3TkRBWFViamVXYWUyakFxa09ZRndRd3NQSG9NbzJLa0lO?=
 =?utf-8?B?djNKbDFsYXhtODEwU0JtbVFNQWFVcDVkeVVncWRnd0ZXdXJVVGFoS2Z3aXlY?=
 =?utf-8?B?c0VqOFlGcFgvVUgzbkFCWUhNYVFObmJzdmtxaXUyVlpSemZQeUxJZGtqY3pI?=
 =?utf-8?B?MWdNUWgvaTF0bVNoazBMMjlscDFYd20ydW5ETUdpMXJIbWdHTjJPcnBUREJ4?=
 =?utf-8?B?OXh0SU55ZHRjd2NBdjJTTHJIR3BWUU84Q2kxR3RVQnVxNXBaaHo3bGhTMkUy?=
 =?utf-8?B?VWdvd01kbDNmMVU0OGVTcEVwaXBJTW1pNWl2WlFVdEpjM2w1cEtER3lCS3VJ?=
 =?utf-8?B?LysxRW1RcUk2M0VaMDRxWVoxZWlwd2liSjNuQVIyNGdxaFAxQjNndVFvd0Za?=
 =?utf-8?B?UVhacnNJT3pSRGVJQmMvQnJrZmNjd2lkN2RDSHVPTUpMT2h2TW5rdzFMVzBS?=
 =?utf-8?B?SjBFTnk5YVZJeFk4d2ZVNDZnYjFKbUtFK056UDFEVC9ma2o1QnhjRlZsNy9w?=
 =?utf-8?B?bi9qSDBkOU9IVlUzME1HWW9MeXg5bTJKdUdkVm9jb0FKNlNJOWtJOWY4VjZL?=
 =?utf-8?B?aGFJRW43UXBUNmxjNldjMmNUUlEwK2ZmamhRa2p3cldHUzljV1J1QW9EWk1J?=
 =?utf-8?B?MDhlcmFvdmszaWhjZ3g1SGF3N3lCb1QxRGdjZUhhQ3NjTGYxOERZUXl1SzMr?=
 =?utf-8?B?eDN5Sjl6bjdsRTFlK01YWjRNNmpFMTgyd3pPNGs5bUFUYTlEQ3R2K1lzQXky?=
 =?utf-8?B?bVBVNzRyQW5yN29CbGIwb1d3M3VNMUlXRlRqMDBPZEpmZUlZV2JKSUhucUFv?=
 =?utf-8?B?RHAwU1JJM1RPczRrdzlFZ3FqcVB0bnRFTVZFNndKNzQ1YWdsN2RCUHdHMURz?=
 =?utf-8?B?KzJKdnpaY3I5M1Zuc3lic1dqNEs3QW1qZ3pqdmZXekI0ZGJId2JIVWpyZ2dC?=
 =?utf-8?B?RXkrd3RiWXJHaktjZHFjRTEwanBEakQzdjdoSUdKQnNKR2NNejkzWks3eit0?=
 =?utf-8?Q?Sk1GmoNaQhk7+3PH9KAqPxJuZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c750453b-adec-44b4-2df1-08db7608eaca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 05:48:07.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Mr+wg+6Px0GO7o3r4ya2OJRte/TTPDgJxgDkxa3cjRVI9NciFKYpQCEMR1rKHjsMBWvwbkiK8MsTjiuUCNI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 04:14:25PM +0800, Deng Pan wrote:
> When running UnixBench/Pipe-based Context Switching case, we observed
> high false sharing for accessing ‘load_avg’ against rt_se and rt_rq
> when config CONFIG_RT_GROUP_SCHED is turned on.
> 
> Pipe-based Context Switching case is a typical sleep/wakeup scenario,
> in which load_avg is frequenly loaded and stored, at the meantime, rt_se
> and rt_rq are frequently loaded. Unfortunately, they are in the same
> cacheline.
> 
> This change re-layouts the structure:
> 1. Move rt_se and rt_rq to a 2nd cacheline.
> 2. Keep ‘parent’ field in the 2nd cacheline since it's also accessed
> very often when cgroups are nested, thanks Tim Chen for providing the
> insight.
> 
> Tested on Intel Icelake 2 sockets 80C/160T platform, based on v6.4-rc5.
> 
> With this change, Pipe-based Context Switching 160 parallel score is
> improved ~9.6%, perf record tool reports rt_se and rt_rq access cycles
> are reduced from ~14.5% to ~0.3%, perf c2c tool shows the false-sharing
> is resolved as expected:

I also give it a run on an Icelake and saw similar things when
CONFIG_RT_GROUP_SCHED is on.

For hackbench/pipe/thread, set_task_cpu() dropped from 1.67% to 0.51%
according to perf cycle; for netperf/nr_client=nr_cpu/UDP_RR,
set_task_cpu() dropped from 5.06% to 1.08%.

The patch looks good to me, just a nit below.

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..4fbd4b3a4bdd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -389,6 +389,19 @@ struct task_group {
>  #endif
>  #endif
>  
> +	struct rcu_head		rcu;
> +	struct list_head	list;
> +
> +	struct list_head	siblings;
> +	struct list_head	children;
> +
> +	/*
> +	 * To reduce false sharing, current layout is optimized to make
> +	 * sure load_avg is in a different cacheline from parent, rt_se
> +	 * and rt_rq.
> +	 */
> +	struct task_group	*parent;
> +

I wonder if we can simply do:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..31b73e8d9568 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -385,7 +385,9 @@ struct task_group {
 	 * it in its own cacheline separated from the fields above which
 	 * will also be accessed at each tick.
 	 */
-	atomic_long_t		load_avg ____cacheline_aligned;
+	struct {
+		atomic_long_t		load_avg;
+	} ____cacheline_aligned_in_smp;
 #endif
 #endif

This way it can make sure there is no false sharing with load_avg no
matter how the layout of this structure changes in the future.

Your patch has the advantage of not adding any more padding, thus saves
some space; the example code above has the advantage of no need to worry
about future changes that might break the expected alignment, but it
does make the structure size a little larger(704 -> 768).

Thanks,
Aaron

>  #ifdef CONFIG_RT_GROUP_SCHED
>  	struct sched_rt_entity	**rt_se;
>  	struct rt_rq		**rt_rq;
> @@ -396,13 +409,6 @@ struct task_group {
>  	struct rt_bandwidth	rt_bandwidth;
>  #endif
>  
> -	struct rcu_head		rcu;
> -	struct list_head	list;
> -
> -	struct task_group	*parent;
> -	struct list_head	siblings;
> -	struct list_head	children;
> -
>  #ifdef CONFIG_SCHED_AUTOGROUP
>  	struct autogroup	*autogroup;
>  #endif
> -- 
> 2.39.3
> 
