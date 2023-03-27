Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF86C9AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjC0Fk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0FkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:40:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD74C02
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679895622; x=1711431622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LNhX2UiIOT5m1btUaSFZRukoE4WO/hqSTlwQABFEvn8=;
  b=iAmKChfse70rhFMQhDquKqw5ibc/emyl9bLE1QDAmXNdHyiFDQmiHMtJ
   7mzaDLshOMDg6Gm0LP+j/cKAr4S1gObf/pJWkRzDhw+oI0cwdJR1EcBB3
   nOE99wtn0SGVoDjrt6WhZZGgvQY9v8HFwtp2dVkuODKnyXh2uExDRte8F
   JOcN7m0cOybX61ZFmjf4Hp9T6456FTobA9lBIDLvOQ5pbhKQgMb2sGj9d
   lnOMQhNW94yQZhf6St5fANVWdfN2T9yCW6+FZUrIyBm9qRXwoAQ61INly
   CKQG+yp+SafzjpZEzxZ/6Pael80+K+6EzU66zSjZcr6rC0pFUlELoqs5V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="319838633"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="319838633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747861213"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="747861213"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2023 22:40:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 26 Mar 2023 22:40:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 26 Mar 2023 22:40:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 26 Mar 2023 22:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFEvKem4NKAjJh8E3CBbMZ9SWJYmigpMW3wnDsA0g0wopPc/ZCGz9PoQOAp/zcOmdYCaVhE/Obf/FnxoX78F0HFXFSKiqEp1FeXT4VM/Jqtw/gFkpF2FWY8LbJ3ulp0vlsCTaSlhXRhjZSjsatjwm2jErmwGiu8EloBitz7bXdx+8xgRsaEGPRUg7ELA1aNnSMDd/tfeqa6OLX/hGXqEW/UbjR7NSwyLD6Dsqq45oDfDQfKNTUmmMPgT6Av5wLjJoXUFJjKvKC0H3CkmhHRzJ/b6mZ+TnbGlZooRswfB93GuNg4H3ubmlKFgkAKl4zgkKh4jsxWco5En9E4qnizbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LARHPizkdtO9n6+RqMw1SFsLD3GElFokjpC58y7b2DA=;
 b=nJ4VrkgOLlWkUdp+M8+kGepEvTZV+KsaPpZqjhgSBVNMVc9eTE92TFxofEa6qIgICf5ezyQZyTt2UMve8BakuCj+nd9H/D53RGkTJVIA9apmOqUmgo+tzzVs73G8Cxo3Mw3nY3UvTHKHRmPH2M8puhrYZRAb1/hte3R/tubHvbV+2hclCVMnw7LyOcuqUIhh/IU8IDM864dQbYsz9IzUvneXXzUBAPSRTGuQo9rXRovomMctl9bLT6ANA1vc+LVlEDsTTKsK+jFAfR/WRs8Sf5xVJzt57x5hUkLqRnPTFue1LZW7V4XaGFudwNOImeJJFRblHOI8ADZfaxSm0XY5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 05:40:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 05:40:08 +0000
Date:   Mon, 27 Mar 2023 13:39:55 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230327053955.GA570404@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 667531c9-a5dc-4cfc-b01a-08db2e85b99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ua1oxPMdBgFQa2jm5EAgeZHaOq2tcrgGJGg2Ttlc/3G7pAfMkIJTbotSAcy9EyFsQhNYfQ0FoTrbaSGQyht/MoOcU+5Ig8ul1v9MyzLbJHD51kRl5IOgM0//ahF6XbuxHB90Q79/GuZFyM1RaiO6j7ugUIjHpSMKaPgUnxYVy0a98X++frL4j5F5FVTWQ4rbMYxYBGXkdOqDXSraZVhsWnn9CP9uoj2TlDXaQwRfmNEp5C2dzJubiMed0lj5C0iX6P/adEAoFoC0tLbNOw12JsVAolznO9spw3iVsMWcfvqGdmLZynf7uYtnMLHEJHaefLpZUlT6mk0wHyGTbEUVszP2PZGpsZgvoL7VCKRgsc8qzqzXfFMDSvKs+iPV5R/8/PcoO7IqzU8Erw46tByZZj0QLpwj6TmcAMyeM65885pag9fICtlN0jFC1bVuMqlM4Twh/6fcBGH09jF0EXxqXnnVAaBFkaFUIVyyxNJx2x/FwT6h1Vl9IzjTxP4zOxuJz1hCc2KBnOdyXdSTbfoTSTr7IBV1Nv5mO1DAqr1LS1EMUIyra0hHU4JZNFgtIVQa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(33716001)(86362001)(6512007)(6506007)(1076003)(26005)(9686003)(83380400001)(33656002)(44832011)(186003)(7416002)(5660300002)(6666004)(8936002)(82960400001)(41300700001)(6486002)(4326008)(54906003)(38100700002)(2906002)(66946007)(8676002)(110136005)(316002)(66556008)(66476007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/jZJvLNnGsoKKvqJzwqhuze5xW8knJSHX1nbV5hILD3fLVfF/p0d7ixAMXf?=
 =?us-ascii?Q?Q/WaRApP1lfJzFA8VSBex08GCQc4o6gXMuIJz+pALPrKR7NlWAqcgl6BNGgH?=
 =?us-ascii?Q?/gRXRhFS15N0ayQ5ZoTbWjg7Sj9rLa8ym8N07lh8tJVpT3PZBXkppQ146bIb?=
 =?us-ascii?Q?BQGudDHixnse8uWvX74IPlkBt4wsNxNdvWeY6SGreX0uzu5UnSGQuICVmGxT?=
 =?us-ascii?Q?RHHd9JdbJQxj3wvpx/HXgC4g4ggGDqiTQ0UsvmQn+SU6YMcoSReAI21gDslE?=
 =?us-ascii?Q?gZanCF5X51Tn9FJjSkpir8en5ifd5c97zCqLSlYCXjOXrZj//tMqoXW6WyMp?=
 =?us-ascii?Q?9yvIv9OKnSMws/gXbQH6vVn67ghN5IY994W2345/NIHnlGOy2iwWxhI4a2zu?=
 =?us-ascii?Q?SWUhxk7nTRV9dRiB3o4kn3pT59t9GrSTFWbUSdledJdYE3ePBM5cA9qgx2w6?=
 =?us-ascii?Q?+phC4ozUoNvpSqwhpIwAxRxS1QWdW7iaaGFGhejY8P7K7yxRhrvwymPzat/Z?=
 =?us-ascii?Q?H3VPYDwsJarjwlqPKpKEhRs/28xMODvquatMZfUpP0A34xXGWtay+eTFzwtu?=
 =?us-ascii?Q?VJacfDzA83c9niYhI5DkJcvNKM8IgzkXYVus/SxvJWfV5zjheMmd48idoSKP?=
 =?us-ascii?Q?huQ81P6HjAuC3+ExEPwNYWTd34afdWHSvg0R7IIbb5XUZDWpxPZ43FCXnOwu?=
 =?us-ascii?Q?RCRGxLzAfRmGxaugEDxDKQ2AI1ypATyL3aA2pbC25Z1fu9V2jbPVacTbCEjC?=
 =?us-ascii?Q?M57YZidSmwG6VaCPAW2Xokr624DDu0Vospc5TTDQZW/oFZahPKem3hp9u+Ax?=
 =?us-ascii?Q?5n34G2KA6N/4PNmqQhvhAe/zh4bYASYrUD6PYTCF+mYXq1g59Ds/h/te65yd?=
 =?us-ascii?Q?1ZKJGxmcttQVieVGjcKHPE9rtv3K/TCJrEB9NDNuTi2Dm58ex5le4+vTKvH0?=
 =?us-ascii?Q?Nd+Ty/a0Dam4ibfxs3BzeSr3RVXqQSJzcjCDkGXOgjVbWEc1yQnhngtwe6ne?=
 =?us-ascii?Q?T7s7mZUcnZIUn97dyYvgYr+f9y+k8P+WO0WQa+eMvscTnXbfDBnBzyzW8+sQ?=
 =?us-ascii?Q?TUienSR0GU2GqKqAfJ86mLIg+j0hQYLJWcGMn5kstiCT342fPVg1rtLBJNn9?=
 =?us-ascii?Q?Q73366S8xniUG7M39Yaa1h5mC++7ln7eewDk6o3gAEvOsxz1gOZ3Nqm6nsfP?=
 =?us-ascii?Q?d/2BhK9Kl0pkPKFHoGuYcgZ8hx5kbyWVeI36g9+zTcZbzsNIjXoJZ3veJ0Ri?=
 =?us-ascii?Q?fhZJHY51Om6sG2jQxk2RvNztjEB8RfguiVicNBhc25swP3p2xNuIpA9bM+BV?=
 =?us-ascii?Q?V/o9hhJs9UYdc+ZnMv7k9wJeeCxdpJQpbZZr+A8MqqG5kSURuTtJBDWZH2r+?=
 =?us-ascii?Q?yGw5Napc9PeAnSJHF82PwoovJI/4xdPvijvCEoG3U8MwrCG6Xm/9IwYVNYW3?=
 =?us-ascii?Q?w9OI+PBut/JwCN8Js4EtwfgqkHOx7u12sSOmjykr5qjZwX/rcRwb/bf7Utr6?=
 =?us-ascii?Q?PLnTy7l+/BWm4ONacSqczUGF64sdMfByw115KyRz86JfprfTuPm2bqZdY08e?=
 =?us-ascii?Q?zDzWRU/kG/yBaR7s8afbX733n6fJlu2nnOGyHFfj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 667531c9-a5dc-4cfc-b01a-08db2e85b99c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:40:08.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRT+o6wlM/5XFSIbbqgmvEPdpDubEIAyq0jdj13igLf1DIEoF5YnVXSp927WN405UOc77qPW87M3i7v9bLQ9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using sysbench to benchmark Postgres in a single docker instance
with sysbench's nr_threads set to nr_cpu, it is observed there are times
update_cfs_group() and update_load_avg() shows noticeable overhead on
cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:

    10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
     7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg

While cpus of the other node normally sees a lower cycle percent:

     4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
     4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg

Annotate shows the cycles are mostly spent on accessing tg->load_avg
with update_load_avg() being the write side and update_cfs_group() being
the read side.

The reason why only cpus of one node has bigger overhead is: task_group
is allocated on demand from a slab and whichever cpu happens to do the
allocation, the allocated tg will be located on that node and accessing
to tg->load_avg will have a lower cost for cpus on the same node and
a higer cost for cpus of the remote node.

Tim Chen told me that PeterZ once mentioned a way to solve a similar
problem by making a counter per node so do the same for tg->load_avg.
After this change, the worst number I saw during a 5 minutes run from
both nodes are:

     2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
     2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group

Another observation of this workload is: it has a lot of wakeup time
task migrations and that is the reason why update_load_avg() and
update_cfs_group() shows noticeable cost. Running this workload in N
instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
task migrations on wake up time are greatly reduced and the overhead from
the two above mentioned functions also dropped a lot. It's not clear to
me why running in multiple instances can reduce task migrations on
wakeup path yet.

Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/sched/core.c  | 24 +++++++++++++++++-------
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  |  5 +++--
 kernel/sched/sched.h | 32 ++++++++++++++++++++++++--------
 4 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a4918a1faa9..531d465038d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9759,9 +9759,6 @@ int in_sched_functions(unsigned long addr)
  */
 struct task_group root_task_group;
 LIST_HEAD(task_groups);
-
-/* Cacheline aligned slab cache for task_group */
-static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
 void __init sched_init(void)
@@ -9820,8 +9817,6 @@ void __init sched_init(void)
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 #ifdef CONFIG_CGROUP_SCHED
-	task_group_cache = KMEM_CACHE(task_group, 0);
-
 	list_add(&root_task_group.list, &task_groups);
 	INIT_LIST_HEAD(&root_task_group.children);
 	INIT_LIST_HEAD(&root_task_group.siblings);
@@ -10219,7 +10214,6 @@ static void sched_free_group(struct task_group *tg)
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
-	kmem_cache_free(task_group_cache, tg);
 }
 
 static void sched_free_group_rcu(struct rcu_head *rcu)
@@ -10241,11 +10235,27 @@ static void sched_unregister_group(struct task_group *tg)
 /* allocate runqueue etc for a new task group */
 struct task_group *sched_create_group(struct task_group *parent)
 {
+	size_t size = sizeof(struct task_group);
+	int __maybe_unused i, nodes;
 	struct task_group *tg;
 
-	tg = kmem_cache_alloc(task_group_cache, GFP_KERNEL | __GFP_ZERO);
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
+	nodes = num_possible_nodes();
+	size += nodes * sizeof(void *);
+	tg = kzalloc(size, GFP_KERNEL);
+	if (!tg)
+		return ERR_PTR(-ENOMEM);
+
+	for_each_node(i) {
+		tg->node_info[i] = kzalloc_node(sizeof(struct tg_node_info), GFP_KERNEL, i);
+		if (!tg->node_info[i])
+			return ERR_PTR(-ENOMEM);
+	}
+#else
+	tg = kzalloc(size, GFP_KERNEL);
 	if (!tg)
 		return ERR_PTR(-ENOMEM);
+#endif
 
 	if (!alloc_fair_sched_group(tg, parent))
 		goto err;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..2f20728aa093 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -645,7 +645,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
-			atomic_long_read(&cfs_rq->tg->load_avg));
+			tg_load_avg(cfs_rq->tg));
 #endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..68ac015fab6a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3439,7 +3439,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 
 	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
 
-	tg_weight = atomic_long_read(&tg->load_avg);
+	tg_weight = tg_load_avg(tg);
 
 	/* Ensure tg_weight >= load */
 	tg_weight -= cfs_rq->tg_load_avg_contrib;
@@ -3608,6 +3608,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	int node = cpu_to_node(cfs_rq->rq->cpu);
 
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
@@ -3616,7 +3617,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 		return;
 
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
-		atomic_long_add(delta, &cfs_rq->tg->load_avg);
+		atomic_long_add(delta, &cfs_rq->tg->node_info[node]->load_avg);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..11a1aed4e8f0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -365,6 +365,14 @@ struct cfs_bandwidth {
 #endif
 };
 
+struct tg_node_info {
+	/*
+	 * load_avg can be heavily contended at clock tick and task
+	 * enqueue/dequeue time, so put it in its own cacheline.
+	 */
+	atomic_long_t		load_avg ____cacheline_aligned;
+};
+
 /* Task group related information */
 struct task_group {
 	struct cgroup_subsys_state css;
@@ -379,14 +387,6 @@ struct task_group {
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
 
-#ifdef	CONFIG_SMP
-	/*
-	 * load_avg can be heavily contended at clock tick time, so put
-	 * it in its own cacheline separated from the fields above which
-	 * will also be accessed at each tick.
-	 */
-	atomic_long_t		load_avg ____cacheline_aligned;
-#endif
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -418,8 +418,24 @@ struct task_group {
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
+	struct tg_node_info	*node_info[];
+#endif
 };
 
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
+static inline long tg_load_avg(struct task_group *tg)
+{
+	long load_avg = 0;
+	int i;
+
+	for_each_node(i)
+		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
+
+	return load_avg;
+}
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.39.2

