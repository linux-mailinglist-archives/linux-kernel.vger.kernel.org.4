Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73C6EB7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDVGFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 02:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDVGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 02:05:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4E1994
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682143512; x=1713679512;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rE50OPnFSXkMcRJMISPUxw7QYqcXszrKsD/Oz5t2WZM=;
  b=Yripuw62doJcLDj5Kg1yVitWY/t3ge+jdE3nVNGWnyKCCxC6BLbh6mIA
   3KVVcJ1soeW/oHdEWA8J8FWSteMdx9wPcBqqEX6CAHuZv2lEinolspONi
   N14/ebLU5HJKuvXLxBn8KnSR4v0ne0EtEH96ssYDmTQCzt2UfXX1KkqK8
   AeqgXAtPAF2aSVTnHh1bvUxmAXxOHkQ5ty21MtJNtSijBoSZoxoWCNG6h
   Bk1PQ73F2MPLTyRV3ML6wI8s7WolVjkPTHnNfeKhF3NDfiavAVbEtymaH
   D7CarLJknC7tGu5yaZI1Iorrdt064iNnceRpII+XUgJZeM1d16HGQLx5z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="374069706"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="374069706"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 23:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="685968580"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="685968580"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 21 Apr 2023 23:05:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 23:05:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 23:05:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 23:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmbbQ3fq1cQX1aixClrFZKswuR8YeimeJ/WTnkclXkhpKBYr3FHXB23GYwF3LfsS3HvuYtpjyGhs+4aLD3OM6iDp4Vnbkw8hz9nRpp+wlEMoEQPvNVc4HAzhRNiIA2RegJzThKBXrXAXIyHUl5/S7hVTmXKT4ztpSC7e92/rsyrniLDIQfb0A7o+WPi9+N1SpTB48dbYgmB3mu/GMisIl1KtsIiC/v3pSizxCl7lcceWyNLXaB5ddlHfvnzdI4qVNKgOK7eIlLR68jySmAdL/NWyfymPvrsHBgHmjc4vspFc5RSbfz1hKKp2FTGerXnbxiP2FWkPgQWku4QjJBxtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAeib06+P279hTXrTvtEqsA1SDzWW2pr0dSNZA0Gt6M=;
 b=MDAF8jRbF+QS/NxQqML/P0c8+RTp8Dsnm1A/6icyGOfXI0w0P4Ey1ttaXQGqKPyzu94HMkvxbyYYcdnXlLzyye6RiHReJfZQ3g9jb8riO5Yrc/Qupn4JkUti6FG0RwF/yzNAgjqXAioTSWJxWI9OPeieMyM5i0qlzSvtPzOkmz80XN5cIpFhjiDN1D++IfRdl1TGxchTjnskn/OHLjiPzs28bI3WoMauWzJE1lUDDl0O3YG9lbey03ultBAEinUUGO9Na/iVPj1nZo9Iu0QVCSRxf13QODCOlhB3CsNAfmrs4HaDK0agiKTVy+lv8eccwWV65a41Xj5OUNpGJzLpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 06:05:09 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 06:05:09 +0000
Date:   Sat, 22 Apr 2023 14:04:50 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230422060450.GA264770@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <ZENcN3suKMCaHm1w@chenyu5-mobl1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZENcN3suKMCaHm1w@chenyu5-mobl1>
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MN2PR11MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 66952aa3-2d45-4184-c5f5-08db42f78683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iy7TdcTlW50637iu4/nJEK4FCZghc7sWEOjPcZEnCNkGKUjsI2SQccsIsbFjEsIey32QznoHGR2sGHlSwGciqH/5lUS2PUNWnwGUKTm1SJmawIG1EswNaUu55tJgxb5GzTxfe6ip+l1YZ2OwXBtpREhBE8Ou6laEmXgGwLPpL3GBx62I7W6gKyBU9J8q7k20ZUxspMH+81NtsMssgmuSUHCRBSY+DJblNt6Y/SXZMWvE48AzjxV0cDS5GnFv/255Cury06t9/mWaDtj4JuG347VJj0qE5gD5v3CeuWnoG0jkQ28FH3TcKh6ZvSCY/KjT702kRKlyi4qwzz8LnLqQRz6ublVZYEoO6TM7q7yBPhdN1kyW1UU0Kbu9f/K+/c5UAJmNfdU0msiTy906cumyai6+13UA5XriBYcU166YZr9MoPYtDG0e+G8V0HtXm4eaOITZG0cmMJawUFcgYoE74Be65u41w3wk9KyEDFck4t4R0qUObAfRi5Q+S0xBUJ4MWK7YmPf2ABZj879H+Im2zo+EX7Zn//GT6cj/fJK92BJhMan8Fu5mzvEE8as7VrY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(2906002)(8936002)(6862004)(8676002)(7416002)(44832011)(5660300002)(33716001)(33656002)(86362001)(6486002)(6512007)(6666004)(6506007)(26005)(9686003)(1076003)(6636002)(54906003)(478600001)(83380400001)(186003)(316002)(53546011)(66946007)(66556008)(82960400001)(66476007)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CL47207t4YpIlZN7jVzfJqHX+SF94GAJOMb6z0RVaPNwyHOLxEZE3bpg6lj/?=
 =?us-ascii?Q?wSuVKFSG1F5cJ1dV2hha70drKayk9f9/Axw4YHOvqFmoXlr1NlCQh3cp0ylD?=
 =?us-ascii?Q?51W48Hsfiy0r1Ll58La0dmOWOBDJOy11mxSxxE0+9/gQKyNbtHi5ntxTDbSr?=
 =?us-ascii?Q?B7P2IJb3J3euxBQmIHDFNXo2OkIv5EtalDcYVSvBYZXEdYoHVYsmSDwQEZ6R?=
 =?us-ascii?Q?tG4lo8Q3JJzoUlpAPT3gB+TfHBFhpMhifZRtN1W1WM3xxGsR7KXecYYN3xg6?=
 =?us-ascii?Q?clE3nYCEtpWEq5KXlnKW1s5wJfWPX38f8cpV88+kOSq+ctBGUfALmsQotZFA?=
 =?us-ascii?Q?RaAH6N6TECucoQ/tq49elOa7lYcBPcM5No68GeW18HswxLS+lh6HzN9gmCGW?=
 =?us-ascii?Q?+1+4+BBy6KofS3O8e2enZ0BOlDj/YACrjLVFmfYcpIYu0XZERqpa1i8WpJMI?=
 =?us-ascii?Q?Fu1++crpgDegWa9Ad2PenUup2kIGsPx5Urf/YPS/kLQacgskYGi1iwWfw+56?=
 =?us-ascii?Q?Or38NiXcTore5DRUk/otc9mzlYyc2bdA60LIZQfnK1f4P6X/yPntQxXITnFn?=
 =?us-ascii?Q?Zw5VG/9ndCsOSBnd7BlTd8sLZAnjCRJzMvJgXTPP5T+ieL56NKXLBV4OGd5K?=
 =?us-ascii?Q?GZYZGyNjtTCYdkZD0hJ0WBlrbDXdhIMt4Wa1qtN8OB5QHL4bewgVZ4NoZH5u?=
 =?us-ascii?Q?8Bag0HtuPgYGLC4ldxZviPkW63GMnOyVMhO6lLgO8Dsbm1zCKaKX8JX/QGcA?=
 =?us-ascii?Q?0MXeki/ss4AkDh7M07Asfeq/04g7ulK/FhuDJVnim81V/BpsclItT1cd2gGE?=
 =?us-ascii?Q?Hxfu2jC7BwNeX37w086l9AceT9dAy+aaR9JBtU0WSYsp2tGCOPTKDkc9A6RO?=
 =?us-ascii?Q?6PSksryNkEHibEc1I/R7/gXYJ7DLdLuRcmlVxyPvjCPO0d17G/7LTn8p5Fnr?=
 =?us-ascii?Q?bqqz33lp93WrwrvtzEQBYzufv/YhJIHfde4o22PMVlWhdT7a5HaYFh5F5HZu?=
 =?us-ascii?Q?wlKHB7vJ3uR7kehJMTixD3k2dYe9SVTe8PdPuzo5HYroXt02r9b4O4Pbdr+n?=
 =?us-ascii?Q?W1qV1ef/9xYlTA0UxnorFZ4/Sk9YKV3OjCVYa16Yh3NYZqST8TWNFodOLq3h?=
 =?us-ascii?Q?Dez8hAO4J/IJXhjVGo2LQZR5L0/fFzqF5znNIE5rhEJax2MLbVZDLQPXfhFN?=
 =?us-ascii?Q?n6Q3odOsR3B1TsmZB1EB+U54PR+Ms5hRSbFQuXvJeCv6vJ742j+8Sf6kHbbs?=
 =?us-ascii?Q?qs7ezkzIPNBRvYpqdD+AaDjYg+cfcWTsLToGA+Q8sk0p0UXE30rtsL/iIFD2?=
 =?us-ascii?Q?9HKDyHsP/icstguAXzQnWzq7tdYhOEkWli/Psi6DrsFJ4wJVKC7OLvY7GL2k?=
 =?us-ascii?Q?5oJGnf1XXJH56r9BxwuPz4NooZ+iItsZ5B9tI+fwVCkkoRITxNlEmmd9Mq4o?=
 =?us-ascii?Q?qGRmwol5ivPjoKWz0ZGCK25dgmPk4/9rQ56jddc/1ywv99kkPnC07Ermk5y/?=
 =?us-ascii?Q?9t83TZyY5ORUVroA83zjW/ZHmv+7+25y4BxCWp3Kw2qi7h0Q/WLMavH1gmbK?=
 =?us-ascii?Q?T9UMlpvYK57FzlHqBF/LuN95ze97WTKbR6wcxAuh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66952aa3-2d45-4184-c5f5-08db42f78683
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 06:05:08.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKSDm04OLCzH3bYqTTf8Y7tXTj57G8gEOV2SziDFHxANUpI9sBbKfJ0WF9gKtTC+zDHP0NpIAgE2nkr94g6G7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:01:59PM +0800, Chen Yu wrote:
> On 2023-03-27 at 13:39:55 +0800, Aaron Lu wrote:
> > 
> > The reason why only cpus of one node has bigger overhead is: task_group
> > is allocated on demand from a slab and whichever cpu happens to do the
> > allocation, the allocated tg will be located on that node and accessing
> > to tg->load_avg will have a lower cost for cpus on the same node and
> > a higer cost for cpus of the remote node.
> [...]
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  {
> >  	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +	int node = cpu_to_node(cfs_rq->rq->cpu);
> >  
> >  	/*
> >  	 * No need to update load_avg for root_task_group as it is not used.
> > @@ -3616,7 +3617,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  		return;
> >  
> >  	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> > -		atomic_long_add(delta, &cfs_rq->tg->load_avg);
> > +		atomic_long_add(delta, &cfs_rq->tg->node_info[node]->load_avg);
> When entered enqueue_entity(cfs_rq, se) -> update_tg_load_avg(cfs_rq)
> the cfs_rq->rq->cpu is not necessary the current cpu, so the node returned by
> cpu_to_node(cfs_rq->rq->cpu) is not necessary the current node as the current
> CPU, would atomic_add still introduce cross-node overhead due to remote access
> to cfs_rq->tg->node_info[node]->load_avg in this case, or do I miss something?

That's good point.

The chance cpu being different is high, but the node being different is
pretty low though. The wakeup path will not do cross LLC activation with
TTWU_QUEUE, but the load balance path does make it possible to dequeue
a task that is on a remote node and I think that's the only path where
the two cpus(current vs cfs_rq->rq->cpu) can be on different nodes.

A quick test shows during a 5s window of running hackbench on a VM, the
number of times when the two nodes derived from current and cfs_rq->rq->cpu
being different are less than 100 while being equal are 992548.

I'll switch to using smp_processor_id() in next posting since it's the
right thing to do, thanks for spotting this!
