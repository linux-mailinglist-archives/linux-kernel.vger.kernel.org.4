Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE061673E53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjASQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjASQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:13:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8386B1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674144796; x=1705680796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LRoph+okx94TfO1UykVTBHNf35V4uEC+DhxIu5aFqkI=;
  b=Po+ajxRH9uajqeyRFAUIFYPyeX6KPRJBLu6VgM2HXtTs/UlgTO1ODpQe
   KkAwn6W9IvgKQXwT0f5DY+dvQNYoJnyTAGi8iZGQnX0QBZq6C4blZUwjS
   zBpFhJ9OLqL3j5d2eDCivh2yP6i2/wLxlCFflylrJ3mKT39TVjSIUVq1v
   WA7Az2P/dJ+p+pnGvty+hupXAfFWHtnp7r2Q5jVi8nshbjuD9mi0zhH+a
   txSFlvBnaUu9cAX5UpiXq6iIFRcF3uj1xsCh1Bsy8zUF7yQUQkiDIQya0
   6hdIEpO2Ui3Qkect0sAFD20LcVnlQqqlE/ouzuSuYYT+dnglgp+Nc+5q0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305696656"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305696656"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637752460"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="637752460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 08:11:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 08:11:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 08:11:35 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 08:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSAf8pKDpDWCnR/hvLe1MeP3nbFnF35CCmOYt2L7PqKZvFUqMSkPPCDPfR2QWGu7R/lLYuzFpL9C8hBwq2AHl46ono/M8OH9gLX1bAywp+PexPvRAlv700WGQEtmAV1YV6ukpywxxhCfmfqN1P13i3OytbPG9z+MxJL2lvH6IoxwH4wMYD34Rew7MjkrYvGwA1MRgSIdoP5eidGNt4hRGEgXLhEUsXfnC+D4pc8EVaBfIznsrS8iFnrXxgFBGxuDxJPwqJFjELpBtFeApT3Yp6Z0SMiPKmwv+mlrSWw6s3w05Dp3aymQznAI+LnYZS2cAvLoK2M2Z5go36LuxmyGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX8PcEy1oN582wS/Ov3twUrvVoV3c1QGEWZ6Rw766J0=;
 b=UMf9aPXa0rx3fTRt42S1s0ISEl96x7sq9QK+BiiPRSN4zZj05S04dkXigvBZvrMau7eoReoiystd4vZIEHmXlTXji7he910YbR85rPaLfJHPg9ooFIeH4xaN9dNv2e8bvoxXPMhLTfgY/rdjNUo0kVlexCTH4fkEO0pBpIw1vGyKEYh5ukvcXFdP14qfjfZJnQgkjJCZFfrqYXXAereIGL+QG88fghHZZspkby+wPg7sGYPrXjZk5Tggi80arI0vdUMgXjQK7KUPATxk57y4KBYiiJVryxRfGWYmssAYddNpTUtIfjy+f5LCMJKLKxXo0GEMXMwCNj9no0+sHw2vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 16:11:32 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%6]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 16:11:32 +0000
Date:   Fri, 20 Jan 2023 00:11:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <yangyicong@hisilicon.com>, Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y8lrnvLzGGJmlPor@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <5910589f-fe3e-5999-5821-7b2b8021e74b@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5910589f-fe3e-5999-5821-7b2b8021e74b@huawei.com>
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b41d8f3-b3e0-4ba4-ccec-08dafa37d488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NULnUs02fUuM0uU3EIJPFZ8W6sXmfYVKGKtpEwutiq7bN1YwAkhssGc4xFAw3fbgPdHFA44jPsZGvBTz2Nxkky6cFsZhq1S5Snu5wKkvwVJfo11Fd9XyzIAx18aboAcyYp9HvdbebrzmlmzQkMzPNJmAWRnvdiNz/ip6SRWOTlIYrlJw+BTcD0hWPT00pOIE2pgm4U8cqPdqv6tInOstoZtwebfvGc4Tbr+2pA5eNLsV6zjdjlsczsG/Si2Mgk0KCGh/k2XWQeEY0xYEF2cvoqRwJqMNXP9KgNJQGWV2PUf6kD9ffzlGKF/12+hrIeprLOOQ8whiLNYwP4FeWe/TBjI9DZMVZL6yGs+q8c/xdaiN3m7R8+QiF1Cl0oKUWwB8OlpCtWxJ21MVSP0D7QPeZ32+B4N5kOHhpu0NHFZLHLjHO2rq3xKQhE9U1l1H2goS3SXO7NqZgVQe/JGWG5HUojNyb1M7yvyi/BzvnjCf93rc1oYnOpW2gUWPoI285P9yUC9LKXWf/nO+a4HFlb+MeA3ZwevhFYLKzOYwJM1C+KnES6PAn1PzjvuaZmrO4r+vG5W40cwyETafFuRTSPbHLYEB23MkcC+ffMBMOFgzLNw3ayt0WsJUuK1og53PJYyJgfRw3Wvq3jG2dgNGYCJ/xyaOys74jSXdeTeOiUQCxDv9sUrTodWOwI2wjDN26r6YSp7tKGyyWsBGCMOCLLoUaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(86362001)(2906002)(66946007)(7416002)(5660300002)(8936002)(66556008)(66476007)(82960400001)(38100700002)(316002)(54906003)(53546011)(6666004)(478600001)(6506007)(6486002)(966005)(26005)(8676002)(4326008)(41300700001)(33716001)(6916009)(186003)(6512007)(83380400001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZXaHfwqOCc4+ioFQ0kJYHJc+GGPYCMcdt1gNzDNcFzVrwcb/za27R1cr5qy?=
 =?us-ascii?Q?gg2kSgZSmB8Apxx8mpYCsim3laFQ37yRh0QdK3V6tJBDrReetjh28LgA17iZ?=
 =?us-ascii?Q?eHN1jZeGvwXgsKpnCSF0bllo4f0Tyq/OZWSmDczfGZYwB/xfEJF/rnQmnIWt?=
 =?us-ascii?Q?0Pt3Ke2EIdBgHQNeXb2i8DPsPd6ucCUPWyViakRjQHJsYwUeGsJN4DGHq7Ht?=
 =?us-ascii?Q?e7C5n9iEp+om6LJomZJSk5ERjpTLjQh/LNhrJjbVBmv9L7OQx7gK5jj95dVS?=
 =?us-ascii?Q?I0DiEa+fZdehBvnNFkzHE9MZFBayk6+9eXJzgS7hpRIhDH8JSkcpg6j6Aklp?=
 =?us-ascii?Q?vew/xCxs46xGQPijS3HFkLSu/pD7veyaRWVhH/bGPB5FpIiET/J5uMfISXKe?=
 =?us-ascii?Q?pqoE53L5GyMFD7p6PlzrxUaidQHdLfidKhxNKSmw7vXaHegoT4QkmFQgU4V/?=
 =?us-ascii?Q?LX7rC7Kwz0KjHaOL+7byrYkcoHaqiSh7zKZeNwaUg8V0xnGrLDGeDFI+ymYr?=
 =?us-ascii?Q?hePfIpU1PwKkcp5oY7eF0ZEe8vwr1Nn+4Sj5vOKv/TG23ZdLuWCjMwurNat9?=
 =?us-ascii?Q?GhhFxUUp2to7XX0V3YVBKfUjZlJ5c2wATWMFdmisfW9sh8tjGCQKeB4DDJf0?=
 =?us-ascii?Q?IT7IFmp9OPeF9sg0EcNXxOLWSVVfvqMlWyVqJhyNtAtFy0jFqQLzGACtJxTX?=
 =?us-ascii?Q?A/PLEh+HCJSx66VzLxoiLOj5TTID1vKSln/NoXciao8LhBo8VbPNn6wlsKKH?=
 =?us-ascii?Q?BKFDXwFVSxQQUCAjXabjP0gV+rYJvzoLeFYn2BuG+AXijCTzIdualbPquSoE?=
 =?us-ascii?Q?yUW0d0YZLr733pV4N9COeuZEphKmC0QZh0W+8j3S5IwSnD1occJyVy0PDH5n?=
 =?us-ascii?Q?SkNfISYI8yUY3E/oQqYYzDhQNYmSKLZN58IeU1XFDXWp9Fjez/0fYyYfQi2N?=
 =?us-ascii?Q?cfpNNvleZPqoFeePLFunOKC1AM8xX2lPaoQ/iWShSmdQt++bcTA+r/+HpOoj?=
 =?us-ascii?Q?gRp9tiDinEYIWl/8GPEZYsTkXDFN1vwIRrIQ1EShcMZ7QNmo93HMsoXJtQ3n?=
 =?us-ascii?Q?FD/nQvZgVCY6yiOZ44j/5uAwb07u6MMcNTmojxUZdwr3QQDqkXA4pvm4pRZm?=
 =?us-ascii?Q?zjIooEIb8SgJMeRK9fQnJTc0u4K39Yt6al8QPDFDGpSHA/FVsHz5F4NPoNFU?=
 =?us-ascii?Q?3dPu3eEHfVsKhRume1ovq+LA83EiqbElkwA9sUUHKfYtcaFtzuDfUCfn9vgA?=
 =?us-ascii?Q?6RdVKuFyytX36O+PCLWJYzyy5aAQaWbjKvesDhN/ZVzOCXGJl/ykf7QkMpl3?=
 =?us-ascii?Q?daBhbM8Pfbi9Uk58lHiQMu8H14BLb323a6CAcQPOK99VARbs4r1Ped533ipU?=
 =?us-ascii?Q?2FzDavJwcHdfViLoqj8wIClf5Bl47baC/yZZZxL/NB/OknueT/NMl/r4zh/B?=
 =?us-ascii?Q?pshNGzBqZbzRnoJLUqczkV8Hp8pzEwKudYGoEHEyLmH5qbkXRAAYJnwVP9o1?=
 =?us-ascii?Q?dJyDcpQYqO1ja3wm2ih/qMnWBMogYqvSRnHycuuwYZomssWxK4/rl0XDSPB+?=
 =?us-ascii?Q?jywMVbLNp4xjWlNVAvD8bhEDx/vCZOXJWeKyZYHB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b41d8f3-b3e0-4ba4-ccec-08dafa37d488
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:11:32.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlh/8XMAjSnjkZ3F83Xi7abrAfll5lFM8miFS5S6enPyArhwAH8qBhgZLkSN42UH1XPis41sVKaKK5p+e9ru6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,
On 2023-01-17 at 10:53:25 +0800, Yicong Yang wrote:
> Hi Chen Yu,
> 
> On 2022/12/16 14:08, Chen Yu wrote:
> > The main purpose of this change is to avoid too many cross CPU
> > wake up when it is unnecessary. The frequent cross CPU wake up
> > brings significant damage to some workloads, especially on high
> > core count systems.
> > 
> > This patch set inhibits the cross CPU wake-up by placing the wakee
> > on waking CPU or previous CPU, if both the waker and wakee are
> > short-duration tasks.
> > 
> > The first patch is to introduce the definition of a short-duration
> > task. The second patch leverages the first patch to choose a local
> > or previous CPU for wakee.
> > 
> 
> Tested with tbench and netperf locally and MySQL remotely. Unluckily
> cannot reproduce the improvement and see some regression.
Thank you for the test.
> Detailed information below. The tests are done based on 6.2-rc1 on a 2x64 CPUs
> Kunpeng 920 server with 4 nodes and no SMT, CONFIG_SCHED_CLUSTER
> enabled.
> 
> For tbench and netperf tested on single node and two nodes on one socket.
> 
Does this platform have 2 sockets, each socket has 2 Numa nodes, each node
is attached to 32 CPUs, and the benchmarks are bound to the first sockets?
And may I know how many CPUs there are in one LLC? Is it also 32?
> Further looked into 64 threads since it regress most and mainly looked on the
> server(mysqld) side. In this case most loads will be on node 0 and partly
> on node 1. With SIS_SHORT the utilization on node 0 keeps almost the same
> but utilization on node 1 remains nearly half comparing to baseline. That
> may partly answers why the performance decreases.
> 
OK, I see. So it seems that the Numa sched domain load balance does not spread
tasks fast enough while SIS_SHORT is waking task on the same node frequently.
But I thought select_idle_sibling() would wake up the tasks
on the same node(LLC) anyway, why SIS_SHORT inhibits the load balance more?
> mpstat 60s, non-idle%
> 	vanilla	sis_short	
> node 0	94.25	91.67	-2.73%
> node 1	46.41	30.03	-35.29%
> 
> Previously there's argument that sync wakeup from interrupts maybe incorrectly
I see. Do you mean, wakeup from interrupt might cause tasks stacking on the same
CPU, because the interrupt is delivered to the same CPU? I thought userspace
irq load balance would spread the interrupt? Or do you mean others?
> and SIS_SHORT seems to consolidate that and tie more tasks on the interrupt node.
>
> SIS_SHORT will likely to make short tasks wakeup locally but seems to increase the
> wait time in this case. schedstat for CPUs on node 0 shows:
> 
Agree. 
>                         vanilla               sis_short
> time elapsed            60.201085s            60.200395s
> [cpu Average, counts/sec]
> #0 cpu zeros            0.0                   0.0
> #1 sched_yied()         0.03                  0.12
> #2 zeros                0.0                   0.0
> #3 schedule()           409415.36             340304.86
> #4 sched->idle()        125616.92             91078.52
> #5 try_to_wake_up()     317404.25             280896.88
> #6 try_to_wakeup(local) 115451.87             140567.68
> #7 run time             26071494674.87        26164834556.84
> #8 wait time            3861592891.75         7361228637.54 (+ 90.63%)
> #9 timeslices,          283747.1              249182.34
> 
> Since it's a 128 CPU machine the min_granularity is 3000000ns which means a short
> task running within 375000ns. Most mysql worker threads' se.dur_avg is around
> 110000ns and will be regarded as short tasks.
> 
> To exclude the influence of Patch 1 (which we'll always record the dur_avg and related
> informations), tested 64 threads case with SIS_SHORT enabled or not through debugfs
> control and seems Patch 2 mainly dominate the results.
> 
> 		NO_SIS_SHORT	SIS_SHORT	
> TPS		17446.54	16464.83	-5.63%
> QPS		279144.61	263437.21	-5.63%
> avg lat		3.67		3.89		-5.99%
> 95th lat	5.09		5.37		-5.50%
> 
> Please let me know if you need more information.
> 
Very useful information, I'm thinking of taking nr_llc into consideration to
adjust the threshold of short task, so on system with smaller llc we do
not inhibit the idle CPU scan too much.

thanks,
Chenyu
> Thanks.
> 
> > Changes since v3:
> > 1. Honglei and Josh have concern that the threshold of short
> >    task duration could be too long. Decreased the threshold from
> >    sysctl_sched_min_granularity to (sysctl_sched_min_granularity / 8),
> >    and the '8' comes from get_update_sysctl_factor().
> > 2. Export p->se.dur_avg to /proc/{pid}/sched per Yicong's suggestion.
> > 3. Move the calculation of average duration from put_prev_task_fair()
> >    to dequeue_task_fair(). Because there is an issue in v3 that,
> >    put_prev_task_fair() will not be invoked by pick_next_task_fair()
> >    in fast path, thus the dur_avg could not be updated timely.
> > 4. Fix the comment in PATCH 2/2, that "WRITE_ONCE(CPU1->ttwu_pending, 1);"
> >    on CPU0 is earlier than CPU1 getting "ttwu_list->p0", per Tianchen.
> > 5. Move the scan for CPU with short duration task from select_idle_cpu()
> >    to select_idle_siblings(), because there is no CPU scan involved, per
> >    Yicong.
> > 
> > Changes since v2:
> > 
> > 1. Peter suggested comparing the duration of waker and the cost to
> >    scan for an idle CPU: If the cost is higher than the task duration,
> >    do not waste time finding an idle CPU, choose the local or previous
> >    CPU directly. A prototype was created based on this suggestion.
> >    However, according to the test result, this prototype does not inhibit
> >    the cross CPU wakeup and did not bring improvement. Because the cost
> >    to find an idle CPU is small in the problematic scenario. The root
> >    cause of the problem is a race condition between scanning for an idle
> >    CPU and task enqueue(please refer to the commit log in PATCH 2/2).
> >    So v3 does not change the core logic of v2, with some refinement based
> >    on Peter's suggestion.
> > 
> > 2. Simplify the logic to record the task duration per Peter and Abel's suggestion.
> > 
> > This change brings overall improvement on some microbenchmarks, both on
> > Intel and AMD platforms.
> > 
> > v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
> > v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> > v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> > 
> > Chen Yu (2):
> >   sched/fair: Introduce short duration task check
> >   sched/fair: Choose the CPU where short task is running during wake up
> > 
> >  include/linux/sched.h   |  3 +++
> >  kernel/sched/core.c     |  2 ++
> >  kernel/sched/debug.c    |  1 +
> >  kernel/sched/fair.c     | 32 ++++++++++++++++++++++++++++++++
> >  kernel/sched/features.h |  1 +
> >  5 files changed, 39 insertions(+)
> > 
