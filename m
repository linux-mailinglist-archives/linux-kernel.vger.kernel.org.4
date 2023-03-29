Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E496CD386
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjC2HqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjC2HqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:46:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2226AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680075968; x=1711611968;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qlUxHg11UgNyGEnRZFwl/dQwr+pYfNAXjiRemS2SNnM=;
  b=D3ka3WLt/yKalTbR5I6si1W4Ve3q1TZtf9Iq7PmPrg5vXN3zQtxBDNBo
   5qV8E1mbWRNy+shmSlLZBb+uxGGy4kjF9noKUsjRz61NuuFrEhYBsSpiQ
   ladG9v4FQ1nJJbxj/C64smOYVETz0HpTxfeIpfz9qw+3h/nOiGKhtK6xf
   Nzn0nCsbiSTvdDlfIStyn8AGH2lPmAUC7PFANTOr/jMWRyEG9TzkNGGi4
   3gTivW5nn8V5+LoNG0Lj57wYedO9wg/4Ob/tdyTsWbWJSuDQnmjYYst6l
   De0s0qClrVYHMmxwd7v1o2ix/wSo2STtAmOfwdn0yXFyxUeMW5Qupj0nH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324709671"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="324709671"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634383089"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="634383089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 00:46:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 00:46:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 00:46:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 00:46:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT/e+LCuHvDktv4+q5tiYlz0Z+9FoQ1CxoGm6ZAuN8+UR+/ts3rvWwqJADGhjQQslvn6oOGpZc6gQjqTE2DqyRACkV6ooh3ktOrVna0MjQ7/YdS/+Es1Qlw1NWRxjpl9EHfuMmQx0iXe5LhN2eZzviDaoVfawmHLszbHhHjvi6XwsYyppZ6R3B/RCu/omb4cpVxxi5bGrVcTutGVBaHOHuQWfqNFH/uweDqwrsbR5DXB7A01aDZwQSJfZH9nRuyvslf+DwFlSDvUqb56PeghkgsUwUWw38vE4ovcfYNsrMK/0ggVAignnf3311N7FKfqsuHYJYtjIML6wB6KpFs2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV7aZo7HjWp1Sv30gRLFwCaZpkdJjVIszyNrFS5WcPI=;
 b=B+PXuV5dIW3uRbidDThapDOi2LTxWSY/pHFLhUhVs9VPKo8P9Ov87Qta1D3C40WVfV17dWP0BRaqbPJWvAc7Q0KfSUynVdXQ30bx6vk6sFtXnUlgmkdY6zuHaUj0Qr+oydpgmS15tJb8AB+AD44YTopAuNcKAdr0uV+r+qDo8oRAU2fCIA4Nfj6DM5taMQMYo8e0T60fCisqMVSccd+NxFsaPNqWVHpDp6ERjmBGA+Q9a2PNKnM6covB3Jim8ASGDMqi4mzneost7Bh6p/Pis16MrxyJtwzE75KR06jDJuLPvaccjHhQ8PCajC2nbYNhdhDnV/0hQPimtvL+/pooyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 07:45:58 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 07:45:58 +0000
Date:   Wed, 29 Mar 2023 15:45:49 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230329074549.GA65916@ziqianlu-desk2>
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
 <20230327140425.GA1090@ziqianlu-desk2>
 <fc66a0a9-aeb3-cc80-83fb-a5c02ee898ca@efficios.com>
 <20230328065809.GB4899@ziqianlu-desk2>
 <c481529e-43d4-a5ce-58ca-12e8ea36aa38@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c481529e-43d4-a5ce-58ca-12e8ea36aa38@efficios.com>
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA3PR11MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: cd86f76d-b44e-430f-8403-08db3029a286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaluPrNcdqN3qHWK470TQlu7T9Bo7XGh4FlutxZxQegoohM3ZM93VJ3ENP7inqOxJzrrGYxfCFFEBP/0HrZosnwsF9/crIMSzTDJfuc9GXnDPRJDkhQz1wtfxhhzroigLePe45TRSCJ9mIegn0yh87AT2c1B0OJhTxS70mhxCC1ru/tG5IMO3f85lpGKgpTftBMFxELxXoTwGPQ3pubtNQX5ZD0rY/Ca7bo5/6wdfV/7d22l0cNn6Y/0YTXql5v4L1y9fbaecRNg9dUMp2yHhyD4gjLPf1FXAbyIIU/zvz7ZVjwSkUxCZ5wyRxJHzRlm8JAJ3jvthH1yhTykCUeGXRAKBb2Zjb3I1JPVLElG+ld4DSKQNBo/lnkGXgSCxe1lH3BA43sEj1wXwZ6pcZmiNcbUz35gOqUlDsAsiph1mukdqz/ebU4q/EzmvSwYKHwVg21CFGlVZWy8r5ezwLlgylhf03ovTs09FbSskv+7UGThsaIQoh45RxWvAEIRJeX/jUKOhxaolqRjAmDREWjejEtuHy+0dqwEufG3kDEXfQ2kBDcvu++T2+UtECGVTebnj66tMi1/zJ9Z8TRaGjLwWkqhXbViGZ2kfEJs9acyVNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(82960400001)(66556008)(66476007)(66946007)(8676002)(41300700001)(6916009)(4326008)(2906002)(5660300002)(38100700002)(8936002)(44832011)(26005)(9686003)(6506007)(1076003)(6512007)(53546011)(966005)(6486002)(6666004)(33716001)(33656002)(83380400001)(186003)(316002)(86362001)(478600001)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpitJ+Uc1n9xTHCeqrlNlT9RvoR/AVjb7dq0/y0biwz0ZSepbgx3EHSJhXI/?=
 =?us-ascii?Q?36j6imGdz/9p14NPILKUd+6wwS1D/twVssiJ5SuysQqo8D0VusczqVQOFvLj?=
 =?us-ascii?Q?9ABUXtj77eit7DkJT+dQK3gaWNk0xigcf/loLAP6ti4HlXX1ullIodUAI6hv?=
 =?us-ascii?Q?jYP26qlPaqkaGgU6yrGZvrhy/yBeCwbDVPn+cTXE/l28Q4V3KRcUY+gkREJO?=
 =?us-ascii?Q?PU10qSDWWjWyGI2+97HShlj2Mv6vhO+TWIr7HUMFT8gAJXYq1Lpn0/Wrd16l?=
 =?us-ascii?Q?i6K2LUgUbBKUGfP4nXHVxjqoWJglmNcjgsMyOIMXtP7PmHP4JZrS/vHMkxBt?=
 =?us-ascii?Q?lPt8mYX81Z8alcHjRGftaxU5v32DSVZ6gP6VcoPVmrbqSZ/JICRG266RFKQf?=
 =?us-ascii?Q?y4eq9Oj1eP8NoLscimYVBNWQqYpfW6Xq83R1Ldz+RgNPWxTB5Wh2ChvA4RLT?=
 =?us-ascii?Q?Te9P3epG5XP3K8Ysw0OwL/YG++1JSkGwLAAwLa9k3UCpjNf4sPb9s+SF2CmT?=
 =?us-ascii?Q?Q2eIsyI7XcTwuRZzQDrfA04KQKCltBqWDEn/NRRg1C4tvFToWgmEdIHzy97e?=
 =?us-ascii?Q?sGTCgMi35pyYRPg4K5eZ8g18DJmK1LFscwEv8CMtgi7640TaZHetF92dZEHs?=
 =?us-ascii?Q?pLQoY85vEXO2SCKFRPg5xJDWhX998eYXrx83+8q9cjBPZGPtC/ow0FMSEbgA?=
 =?us-ascii?Q?i9K0PTd8Xeqf1cqYMLdNF0/CYX7Tg1pCDFgNEH+KxZBfVh4Yni3GlyQkqy0b?=
 =?us-ascii?Q?L+LBS4QMZFut6x4quX8kKAMqsTo8BK1Ufv25WVVtDqxiHXCE2YmZWU5jnyOk?=
 =?us-ascii?Q?yuEFJQxFbk/VokjxtrNgxXWiuvjy4Gj+P/NmG8sH/zCVwblsrlID/y/PFTFW?=
 =?us-ascii?Q?TnOfHsKd1D3lOEsZJ8i6P4E8Qn7cqxBOOvGA4xw4xRLdVPZcaV8019BmgmAU?=
 =?us-ascii?Q?3njdy73sf4VMXddX7ROhIX6borkYFhNqcwfy2dTkPKGv/AulLuvtbpPA++wj?=
 =?us-ascii?Q?xMaO24k21ilc6vul16ltBdGSvo9wXnqvroVDWTpIN263C7km7Sf337bHYXOm?=
 =?us-ascii?Q?bu0ZYz1PcHCgmKUZ5iZjqBZ4xTMt6qfyVeyPOTgA9DKI2zUSTylBtCfxc+Gg?=
 =?us-ascii?Q?AnuWIh9vOPS+Y+zkJN9CAd7rlPnnKdsy2wq+ET4HFGb9eG0sWuSc6KHcYB5K?=
 =?us-ascii?Q?gih6taqdBf3lJIE5VncYQJWsGPl3OZ/8G5epWGeCbA/hR1lfwnLZGqCxTU3B?=
 =?us-ascii?Q?Fcucg03NyWqfSS5pWYGZGF9o+yv7EnTtmFwUAOabjEtxvyxoPVmROUBL0hh8?=
 =?us-ascii?Q?LZFbblOhdvu8XDPetg2r+629+Q9ht4jJXY4Uy7hsAU7V81wVGiBQg9deZ9Hf?=
 =?us-ascii?Q?SgZJy5mMot0isV+dPGWUUNmy4BsO1yWnMgZ6HfF7w7hcmFZICRdOqqiUGGiU?=
 =?us-ascii?Q?xvjtxyptwm6flA8puLuRxM4bJZa3MlzAy+40SrgFhF50IJ8suILamEassNRo?=
 =?us-ascii?Q?aM2nCa5Zf8L0wUZx8d0MmdKEoAaX55QzOn5MfEQAxYN94IUvITlShju3mJFl?=
 =?us-ascii?Q?ddXgFBMJ6JJXxSdkvcrw3ChK0BmFvGP0Ir7j7Vj4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd86f76d-b44e-430f-8403-08db3029a286
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 07:45:58.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGy3G6A+cTIptj2xv3eCJHnU49EGNMat4UP4hwrRH8EqWNvT9QZJaZ2OkBNScl/dp/xFZKt0B7vILZHwO9fBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:39:41AM -0400, Mathieu Desnoyers wrote:
> On 2023-03-28 02:58, Aaron Lu wrote:
> > On Mon, Mar 27, 2023 at 03:57:43PM -0400, Mathieu Desnoyers wrote:
> > > I've just resuscitated my per-runqueue concurrency ID cache patch from an older
> > > patchset, and posted it as RFC. So far it passed one round of rseq selftests. Can
> > > you test it in your environment to see if I'm on the right track ?
> > > 
> > > https://lore.kernel.org/lkml/20230327195318.137094-1-mathieu.desnoyers@efficios.com/
> > 
> > There are improvements with this patch.
> > 
> > When running the client side sysbench with nr_thread=56, the lock contention
> > is gone%; with nr_thread=224(=nr_cpu of this machine), the lock contention
> > dropped from 75% to 27%.
> 
> This is a good start!
> 
> Can you compare this with Peter's approach to modify init/Kconfig, make
> SCHED_MM_CID a bool, and set it =n in the kernel config ?
> 
> I just want to see what baseline we should compare against.
> 
> Another test we would want to try here: there is an arbitrary choice for the
> runqueue cache array size in my own patch:
> 
> kernel/sched/sched.h:
> # define RQ_CID_CACHE_SIZE    8
> 
> Can you try changing this value for 16 or 32 instead and see if it helps?

I tried 32. The short answer is: for nr_thread=224 case, using a larger
value doesn't show obvious difference.

Here is more detailed info.

During a 5 minutes run, I captued 5s perf every 30 seconds. To avoid
getting too huge data recorded by perf since this machine has 224 cpus,
I picked 4 cpus of each node when doing perf record and here are the results:

Your RFC patch that did mm_cid rq cache:
node0_1.profile:    26.07%    26.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_2.profile:    28.38%    28.37%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_3.profile:    25.44%    25.44%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_4.profile:    16.14%    16.13%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_5.profile:    15.17%    15.16%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_6.profile:     5.23%     5.23%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_7.profile:     2.64%     2.64%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_8.profile:     2.87%     2.87%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_9.profile:     2.73%     2.73%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_1.profile:    23.78%    23.77%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_2.profile:    25.11%    25.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_3.profile:    21.97%    21.95%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_4.profile:    19.37%    19.35%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_5.profile:    18.85%    18.84%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_6.profile:    11.22%    11.20%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_7.profile:     1.65%     1.64%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath 
node1_8.profile:     1.68%     1.67%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_9.profile:     1.57%     1.56%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath

Changing RQ_CID_CACHE_SIZE to 32:
node0_1.profile:    29.25%    29.24%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_2.profile:    26.87%    26.87%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_3.profile:    24.23%    24.23%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_4.profile:    17.31%    17.30%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_5.profile:     3.61%     3.60%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_6.profile:     2.60%     2.59%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_7.profile:     1.77%     1.77%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_8.profile:     2.14%     2.13%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_9.profile:     2.20%     2.20%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_1.profile:    27.25%    27.24%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_2.profile:    25.12%    25.11%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_3.profile:    25.27%    25.26%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_4.profile:    19.48%    19.47%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_5.profile:    10.21%    10.20%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_6.profile:     3.01%     3.00%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_7.profile:     1.47%     1.47%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_8.profile:     1.52%     1.51%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_9.profile:     1.58%     1.56%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath

This workload has a characteristic that in the initial ~2 minutes, it has
more wakeups and task migrations and that probably can explain why lock
contention dropped in later profiles.

As comparison, the vanilla v6.3-rc4:
node0_1.profile:    71.27%    71.26%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_2.profile:    72.14%    72.13%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_3.profile:    72.68%    72.67%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_4.profile:    73.30%    73.29%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_5.profile:    77.54%    77.53%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_6.profile:    76.05%    76.04%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_7.profile:    75.08%    75.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_8.profile:    75.78%    75.77%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_9.profile:    75.30%    75.30%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_1.profile:    68.40%    68.40%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_2.profile:    69.19%    69.18%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_3.profile:    68.74%    68.74%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_4.profile:    59.99%    59.98%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_5.profile:    56.81%    56.80%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_6.profile:    53.46%    53.45%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_7.profile:    28.90%    28.88%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_8.profile:    27.70%    27.67%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_9.profile:    27.17%    27.14%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath

And when CONFIG_SCHED_MM_CID is off on top of v6.3-rc4:
node0_1.profile:     0.09%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_2.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_3.profile:     0.09%     0.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_4.profile:     0.10%     0.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_5.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_6.profile:     0.09%     0.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_7.profile:     0.15%     0.15%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_8.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_9.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_1.profile:     0.23%     0.22%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_2.profile:     0.28%     0.28%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_3.profile:     2.80%     2.80%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_4.profile:     4.29%     4.29%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_5.profile:     4.05%     4.05%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_6.profile:     2.93%     2.92%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_7.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_8.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_9.profile:     0.07%     0.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
As for the few profiles on node1 where lock contention is more than
0.3%, I've checked those are from pkg_thermal_notify() which should
be a separate issue.

Thanks,
Aaron
