Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61A6424DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiLEIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiLEIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:40:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857417056
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229640; x=1701765640;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DsiM8pDUO5+6swnKqQF15FFc4Ssz/hw/3JjCGmjY8Go=;
  b=ltaJkm/Rpjb9L9Sj97Jfm3AOEwNi//pbXvpKEGvGdIgKWWk1Gp55mCO5
   fdag9ipVo20K2Mvo9GoYnHxBv4psnh2xeiZaSCNxbN586Wnw80CJGbKqK
   hjQwxxJdpoJ0AUNqFODW9bhKiQgYiRRTOS/wAlHl5UkEuRfsuGSD1RhDL
   5W/4uNTLxr0oUOQ40QPWGDiYo7NmZmMHa5/WNq/PPvWMaOhL5FUsQMZla
   JstMMUoL7N3hWVI3TEiUBnuaPlXCuKnNytX3z4cWcMEtjIQ3g2YxGxX/u
   /N1YhbcG648f5quttk6gysCE830nzmRkuhgC9Vg/ve/IFTpyGdVQe524D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="343289226"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="343289226"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="647867413"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="647867413"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 00:40:36 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 00:40:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 00:40:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 00:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHfPsTgEI6OEg81thx6jDrzfc9soCP7WsErCIaDK2XmudJaxOZ8Ma7M3Lhi9Ropl7TuIXO1fyZutlSkv0uVmsY0dTw8uXkrtGYoNJryc8c6Vf2BR63CzEa9DDavwSnCdGZLCHq696HiQQB0JT5pAM7Tm8K17e/+Ht2C40ovnV0NSkj206r4U2Iz+34JESxzBshLaSVpwjEz6GH68LMNblJjJHrgOSX7fOPm+YYgW0v9ayxp826JIAm9BXrFN4sP2d8uQnE3MnOBWYjgPMaRuM5bmf2sqcIz5I7/ju0/Yn7cBBsbA1Hy7VbnDevgWi0kMOhh41tgS/EJ97zWvkLhpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMg2tYVZpv1GmpNHrnf4+1xKKGeLdhcc15kFczVweZI=;
 b=L127APKAHskeJhzPwTZbxP+iKDkszC2LEAMj4/AV7g4xzj6XsZR18YO3yyU0EoLmsbYNQ+xjiwBIpf687MVrY4CqzAEbu4YkZid9H0c0XmP97QUgeWlrAteAvwiCmSsCtP1in1NNfnvYi2eeBK5iwdLM4ED+l3nDg/jqdG49rHycuW/0QjGi1uSc2ZXB2sPu+X8RdC0wQsJTLcmNOsnjpWpqaRaNQsdkUMBws7UKFxxzEQCf+bKlCTx68/jHTM99xiMOS0Nh6InLTEFSEZdpT94KCHYEBDltss9I3TiPW3ExeozNo6WkpBXUrN3A6I9SiHoWCFzL8AjUJDT4QG7Shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 08:40:33 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 08:40:33 +0000
Date:   Mon, 5 Dec 2022 16:40:12 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
CC:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        "Aaron Lu" <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v3 2/2] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <Y42ubFckJTOgiYyG@chenyu5-mobl1>
References: <cover.1669862147.git.yu.c.chen@intel.com>
 <0fefba11f59c083256eabff0fbb6c82b9d3bfdf9.1669862147.git.yu.c.chen@intel.com>
 <a71a227a-5f1b-8ebc-bfde-0babf267b7d9@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a71a227a-5f1b-8ebc-bfde-0babf267b7d9@linux.alibaba.com>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afd590c-0c9c-485f-46ea-08dad69c5f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gMqL8adfoPEIQ05Iw7K+tTGNDFaFhPUBtWLc6laPsTlDRWpF/p+CrkNbUyQvqqlKXx2eYvETywXOkdLcJMgFPhCqeTslT9rRu5Y2LLO5Sndx93JAYzTtFNJdPFy2raS3/ETzB5YWegEUK3Ls3P7pPHHTEZG6xpOj89taxqSat6QKbPucH3qzr/0nlxf+4wZxEb+P7Ryeud6cG4qIKYg8bUz5+RPq+8zIQ4XGXCtJjapIZiTG4xD6OJKllSL4h9jA7VH62d1DIMDGfwW6o+TFonCYcexBqgaSrPEytNN3z2+rGXVR1llROjjNHQXlmGskzEN4SpUK+i1oI/WAo3inTedcCaqknkEfuAiuB/+KsGGK+z1qcUN0nLo3W+SCp/1kAGiJAf9a3qqgyx/XFYrThywruFAmXK/0E+1hMYUdn4un0KXbfZKSxxV0Bkn7T1DGTnfYMPDaZrlSIPErNKTtSV5HR4xrXl8BIaJXx8369exutJyM55uztechwRqOb7aavLcmKlpXMbuw6EQXbIOHTM3q6VMKwOEJ4hjvBW6sQ3Nz1xHZh4dclD8RGwM09qw1pCIoZkLMR1nlEQuDi/l9Pb6ipHkl3scZYzZnY/BQKHgBQZgE3EJ3o661oCvZnse
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(186003)(82960400001)(5660300002)(41300700001)(8676002)(4326008)(66476007)(66556008)(66946007)(83380400001)(86362001)(478600001)(6486002)(33716001)(6666004)(6512007)(6506007)(9686003)(54906003)(26005)(6916009)(316002)(53546011)(2906002)(38100700002)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8oRs5DklYr+p0U5KR5/7Cy/G6kaQP/l0xmK7TeZ/JlXqfTp/gPYXcQpMdMAy?=
 =?us-ascii?Q?e5yveEGHoSXUj2DdmgAMGXbIW6AqJdYbmGmuveACMe+b/cwJm7uLxmntDfxO?=
 =?us-ascii?Q?n7PjgGLl0ySKwv6X0580uCqgInWF8uvfmBw9HCk+jGWqqCwj83708Q5vTzC8?=
 =?us-ascii?Q?JDvxV5jf4bXgHafiyEX3O19wD31JceikJkmIwDNM7qzjNbB3jSg09hyPhaVQ?=
 =?us-ascii?Q?PZLOcF79lXOV4QQcdqVykH8UJBU2utvkLA7FQuqGCVwYzDdARe13Dvx5JX9U?=
 =?us-ascii?Q?ie4Ai1pPmG0C4AQKWXaj/f9hJwN8uVGMGrdA7X8/NI+ek5KQ1BvRb1PABnPx?=
 =?us-ascii?Q?kfbrrKZuEGBqYh607kwD5y0wfq/1UjQ9CGnZoi//e8Xj4VLicD8edc9Vi5II?=
 =?us-ascii?Q?bfQbvvfcHKEysUQ6Zig1C6H0NWYpbJd68wS3xrNTN4tMUorL0yl78QGgPrsN?=
 =?us-ascii?Q?Lnmyhz08mlsx77RddX8rhVR3x5dMncLcvvjCOjodP7Lc9SJHjAurOoOpglpV?=
 =?us-ascii?Q?8bB6O4ROl2wU+J/ic+p2iK3grE9wgiJfvbREBJwaeITVXImrIRB1JadlHhoR?=
 =?us-ascii?Q?841Ep4tYYB0ICUNnqf8KtzkxsvoxZy7hnQWLeRV4E4pYSM1BEGqwKqeWyXRw?=
 =?us-ascii?Q?tguMfRYbhih9Dt7+FPziGW8AX4vRnKnCBrtusuza7H9VAt7PM5ZxvkOgpW7y?=
 =?us-ascii?Q?uekGhkidR1bEiJCRqrYCQ3EdBk39KQbPhERkoVSf47IAKQEY4xRwf4eIsJpE?=
 =?us-ascii?Q?UC1ejFA9I+6sn0JMsQS1PjY3xN1P5mMIzZ7a20vjDwi1Ut2fCtvfL2/1/7L1?=
 =?us-ascii?Q?BUMKPXY36CPo6iULktCoMKiWEQYPPZ3qAN6NGdTVtmy1btwniMHGC9JgMNq6?=
 =?us-ascii?Q?jt0yIqjjFnU0RhP88bida9CX2noYGr4DN3eFyjazwoCrO6AYd6ZPtS6youu7?=
 =?us-ascii?Q?DjRsRGBiTZqMA9SiEOai2PoJOteC6opvfELiid2UJGSrgiHWr4fT6y2DTBIn?=
 =?us-ascii?Q?lxkniEz08oQjfKPGvITT/Z+z/3bsNfGapgH1aPOPq1Jc4NiUD9XwGzhActH1?=
 =?us-ascii?Q?qw7AXXWnrfb+IDz1p0C50P/uYpRTeGuBifAkrkIYKAjtYcctuSV7iwkPhOGj?=
 =?us-ascii?Q?C3iRjW+sJZdAX17lMPKlIRWD3Gw6wOrnn6/mJoutR9Ojm7Es7F3dGuzfLQGw?=
 =?us-ascii?Q?FKLLWXYSXbHCKUTFYFu0NrCUpdUIYEy1Df8ZkAUbp+FODq+nETUW3bpv1DMf?=
 =?us-ascii?Q?IIdHGEyQUXGz3nQvC2KBHHKlb4VqxXslIx22WGhD08LIpE0CuohwQsZNNhA4?=
 =?us-ascii?Q?QkouBY79+VFsiIh8QQK520youqTvei3U09DQbMgmoLwDx+9SFOq/GY3y/50t?=
 =?us-ascii?Q?R4p6egjGRwDKBfAOjYnggeSTLyiOPL/uXDd2sB1oj3b0TxtpwusxmEItxt74?=
 =?us-ascii?Q?kbVBPHjHldPUN6za5mkCEFQP1KuBQQbd1nIUtqKUnCN4lmq3IzihnfVGl7v4?=
 =?us-ascii?Q?r9T68Kn7glVtkHTD6QSj9+vPeYmZvS9o4OatMYchKaDArmS/MUZM2/99diVb?=
 =?us-ascii?Q?DkV3MFBSIPw4SwlkXNlPdK4AM67VwQc0W4cHHrUn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afd590c-0c9c-485f-46ea-08dad69c5f43
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 08:40:33.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlG/G/G6oymjWlSmLvdOdByEjBKpHyyTv/Ng0nWVDzOrc9hlHEpROr1PLmJM8SysqQ2nW8GOla9Nl0iXmXI76Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-05 at 10:36:25 +0800, Tianchen Ding wrote:
> Hi Chen.
> 
> On 2022/12/1 16:44, Chen Yu wrote:
> > [Problem Statement]
> > For a workload that is doing frequent context switches, the throughput
> > scales well until the number of instances reaches a peak point. After
> > that peak point, the throughput drops significantly if the number of
> > instances continues to increase.
> > 
> > The will-it-scale context_switch1 test case exposes the issue. The
> > test platform has 112 CPUs per LLC domain. The will-it-scale launches
> > 1, 8, 16 ... 112 instances respectively. Each instance is composed
> > of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> > pipe_read() and pipe_write(). No task is bound to any CPU.
> > It is found that, once the number of instances is higher than
> > 56(112 tasks in total, every CPU has 1 task), the throughput
> > drops accordingly if the instance number continues to increase:
> > 
> >            ^
> > throughput|
> >            |                 X
> >            |               X   X X
> >            |             X         X X
> >            |           X               X
> >            |         X                   X
> >            |       X
> >            |     X
> >            |   X
> >            | X
> >            |
> >            +-----------------.------------------->
> >                              56
> >                                   number of instances
> > 
> > [Symptom analysis]
> > 
> > The performance downgrading was caused by a high system idle
> > percentage(around 20% ~ 30%). The CPUs waste a lot of time in
> > idle and do nothing. As a comparison, if set CPU affinity to
> > these workloads and stops them from migrating among CPUs,
> > the idle percentage drops to nearly 0%, and the throughput
> > increases by about 300%. This indicates room for optimization.
> > 
> > The reason for the high idle percentage is different before/after
> > commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU
> > on wakelist if wakee cpu is idle").
> > 
> > [Before the commit]
> > The bottleneck is the runqueue spinlock.
> > 
> > nr_instance          rq lock percentage
> > 1                    1.22%
> > 8                    1.17%
> > 16                   1.20%
> > 24                   1.22%
> > 32                   1.46%
> > 40                   1.61%
> > 48                   1.63%
> > 56                   1.65%
> > --------------------------
> > 64                   3.77%      |
> > 72                   5.90%      | increase
> > 80                   7.95%      |
> > 88                   9.98%      v
> > 96                   11.81%
> > 104                  13.54%
> > 112                  15.13%
> > 
> > And top 2 rq lock hot paths:
> > 
> > (path1):
> > raw_spin_rq_lock_nested.constprop.0;
> > try_to_wake_up;
> > default_wake_function;
> > autoremove_wake_function;
> > __wake_up_common;
> > __wake_up_common_lock;
> > __wake_up_sync_key;
> > pipe_write;
> > new_sync_write;
> > vfs_write;
> > ksys_write;
> > __x64_sys_write;
> > do_syscall_64;
> > entry_SYSCALL_64_after_hwframe;write
> > 
> > (path2):
> > raw_spin_rq_lock_nested.constprop.0;
> > __sched_text_start;
> > schedule_idle;
> > do_idle;
> > cpu_startup_entry;
> > start_secondary;
> > secondary_startup_64_no_verify
> > 
> > task A tries to wake up task B on CPU1, then task A grabs the
> > runqueue lock of CPU1. If CPU1 is about to quit idle, it needs
> > to grab its lock which has been taken by someone else. Then
> > CPU1 takes more time to quit which hurts the performance.
> > 
> > [After the commit]
> > The cause is the race condition between select_task_rq() and
> > the task enqueue.
> > 
> > Suppose there are nr_cpus pairs of ping-pong scheduling
> > tasks. For example, p0' and p0 are ping-pong scheduling,
> > so do p1' <=> p1, and p2'<=> p2. None of these tasks are
> > bound to any CPUs. The problem can be summarized as:
> > more than 1 wakers are stacked on 1 CPU, which slows down
> > waking up their wakees:
> > 
> > CPU0					CPU1				CPU2
> > 
> > p0'					p1' => idle			p2'
> > 
> > try_to_wake_up(p0)							try_to_wake_up(p2);
> > CPU1 = select_task_rq(p0);						CPU1 = select_task_rq(p2);
> > ttwu_queue(p0, CPU1);							ttwu_queue(p2, CPU1);
> >    __ttwu_queue_wakelist(p0, CPU1); =>	ttwu_list->p0
> > 					quiting cpuidle_idle_call()
> > 
> > 					ttwu_list->p2->p0	<=	  __ttwu_queue_wakelist(p2, CPU1);
> > 
> >      WRITE_ONCE(CPU1->ttwu_pending, 1);					    WRITE_ONCE(CPU1->ttwu_pending, 1);
> > 
> > p0' => idle
> > 					sched_ttwu_pending()
> > 					  enqueue_task(p2 and p0)
> > 
> > 					idle => p2
> > 
> > 					...
> > 					p2 time slice expires
> > 					...
> > 									!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > 								<===	!!! p2 delays the wake up of p0' !!!
> > 									!!! causes long idle on CPU0     !!!
> > 					p2 => p0			!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > 					p0 wakes up p0'
> > 
> > idle => p0'
> > 
> > 
> > 
> > Since there are many waker/wakee pairs in the system, the chain reaction
> > causes many CPUs to be victims. These idle CPUs wait for their waker to
> > be scheduled.
> > 
> > Actually Tiancheng has mentioned above issue here[2].
> > 
> 
> First I want to say that this issue (race condition between selecting idle
> cpu and enqueuing task) always exists before or after the commit
> f3dd3f674555. And I know this is a big issue so in [2] I only try to fix a
> small part of it. Of course I'm glad to see you trying solving this issue
> too :-)
> 
> There may be a bit wrong in your comment about the order.
> "WRITE_ONCE(CPU1->ttwu_pending, 1);" on CPU0 is earlier than CPU1 getting
> "ttwu_list->p0", right?
>
Yes, you are right, I'll refine the comment.

thanks,
Chenyu 
