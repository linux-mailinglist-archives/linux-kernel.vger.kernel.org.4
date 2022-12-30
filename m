Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E871659444
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 03:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiL3Crw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 21:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiL3Cru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:47:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9FD15FD9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672368467; x=1703904467;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x3+COSQR00VZbJLCNxUrL8fbeSIOmcgxdLpwiCskXac=;
  b=fGr+i4LtvkrvrAuUIbprIuSK+GHVRojg/TBy07BZYt3cLJRFGKSFhBPf
   eXP6LcuvS5zJqo0V4vIGJu7HvnjZ3QAfRyRUN8d1CEYy8JPWM2wccK8Qx
   BikZkRcqmkL70nNk4u4C0thzbEuEFB/Etwntdgh1k6Mxz6pIncUmxyAZ1
   pvk++WGI5VtXC0hoYrgc5pfl7PsKQ2+ZwDB2IScu9pRvxD9jixtlIGJfk
   C9R9WkMcfXkTcFM4OP82SP2UmKhhHenBmpug19IDKFXBqZ0AhaEjzqnnv
   5hOWCSvaVN0MFodMULKtJp9B0xAqH/BCkIoiOVRrT2NpEHrrS9IGezGEC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="304650096"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="304650096"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 18:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="982544680"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="982544680"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 29 Dec 2022 18:47:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 18:47:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 18:47:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 18:47:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqdJfvop65CLwIOR04YJzmoEpOWeQ+5TrQLx/f8m6wuj7QfcJsT7rIpq/BkNiEiR1LLh5YaN7SWVmp+wQrq3c9a9305+nxwMBQDjYaCMOvN7HykWJo3LQTXZAshAKEfD2eBbzURMlFc7WPl7lNPcutmeN3j63z54LgPPXnmpaDkQLUQ1aoxk8s/UNaDrt6eC3iGrexFWruIG5V9LkknqRpKGd0+mLBK28z9DlTOOdvWLvYIwWIlRcXVdlfPMuENLgHteuDmnNIPHopkeiDdIwFP2EymM2tEPlCa634/29MolNMt6kD0i9a0MIMP0F9EPbaje6XzjcOmwaFLaPU4Kow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgk6FmAqI0ixHWZqfx25sANzU+cNcOnGIPhqJjZc7ko=;
 b=aZ/EePof9kKYV+fRqlMNxBJwHIuR9Jlj3eB14sohCXtuy7yI1icg1x0nR4m+agSCdkpLmPoYJj38aNM2CE3myWi8p585AgGMQmH52vna/+/7Nnvvg6gNa+35WhCcq5UaKDKvEmrfmogR6UxVWnQESM90pAlqE6x5vFJPIfifR/NER7sbL9xkSivWv5Xo2wfs2XfYIzxVdhtWfeZqn3Nbn39aNTM1pWL2bHpfrzDx57fBXW7Wzg4LQGfde4tMBQO97T0EKJPnsG56fJYUYTvDztPVCD3FyGAKVO5263c9DGl4k/xwfqLTdEApIkPbjvjWq/JlXL2oc6mAHpDoUr2TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7717.namprd11.prod.outlook.com (2603:10b6:510:2b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 02:47:43 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5944.015; Fri, 30 Dec 2022
 02:47:42 +0000
Date:   Fri, 30 Dec 2022 10:47:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
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
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task
 is running during wake up
Message-ID: <Y65RNzj522d7Q3OI@chenyu5-mobl1>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <105eede3-2125-5a1e-836c-954fc67f575b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <105eede3-2125-5a1e-836c-954fc67f575b@amd.com>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 79566aea-7392-4cca-30da-08daea10390c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ozfw16/qeUmLo0RanwIhdJJuSn1qbd5RvQS+4PQX8TJYvLpWpssdb82xhhKv+IKkQStbjvImamO576MrJXaKonXU+fTbvsTx78hHEyHHSMcqhYSezIHqGqe3e+fSipnfzd1nnsUn0172WcjrFBt0FDitXjoIwxjvyI7QgbffvOw8Qzk3WbAjqrSnGQncqE0Tb2O6pn4Hl1usZFn0dDhyQhJTn7d5XUlPmhXlyXNPTfip3ykL2yyNN11XRR5J5awbReXzOZqjcc+xZWKULfg0lpKNOTtjIIfVVxltkKkQP4CsfhDUE7MP0Qk9zS7472lEkO+X7E9ZIVRLHlzZ/wzNxk6xMQx2nOwsedSENvFD+sahblg9BYQmemq56C69Ln9AomZSCw7JHhrPnyfgQNN/k/zREbORUSfC8hIShLkTuElLbofDYiRwuH7BE7D+ZtxmpXZYiGNt6WcOTR3SRBZcCl8LCAemoyF4hIS4qW1STnX2aU2Kz7G7CLsKBgqV3se4FVy28YhvmunUgIx17/37QkOuJOLMIWJSbwgMEBV6tF/55J3tqDqtcW678rK0OYCAN5ESqEDMOY+pgP09jPXDZf845d/7NErYrcZepwyfv0jUX2uSw6jxoiCVYRIrRn5lj7h8XtHSfYXvf3rtAWj2fKjGH52saF5kmxR9tJbkhZ3jUiJ3z5QZwYcSGALjHBytZs4TlXR9HyOACqCqoXgyJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(41300700001)(6666004)(33716001)(6506007)(53546011)(26005)(6512007)(9686003)(186003)(4001150100001)(2906002)(6486002)(966005)(5660300002)(8936002)(316002)(478600001)(86362001)(66946007)(66476007)(66556008)(4326008)(8676002)(7416002)(6916009)(54906003)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsTXpXXEHCPg6cry/9OEUAkgKx9PqP5D68BQhI3pLVxPR5jryAMOo/eDgQrE?=
 =?us-ascii?Q?8ktIrLw1slVbEKO8NnfHvDJv/8r3ovekH3TQZiE2EMybjbGRiM4j2CYedM/4?=
 =?us-ascii?Q?12Hi2zpcAr2Vi6XmZW4/tO7bKGMqnDyVfPzgV7+pbK4MBtayz+A2XyzXuBTe?=
 =?us-ascii?Q?lV9IhriIsCp/XIh7jhR9O4HUu/vAqK5Wh7fMrYsiTZ9udD+h7QUmdVzQ6cOs?=
 =?us-ascii?Q?pLmnfqsD0J8P54hMnDcxTV/fNBr6AAsbru8wvJF1RcZ0zgct6cJzuzbH6WtB?=
 =?us-ascii?Q?2F18ibCLj/FAJun6+dYlErmCib61DwyLtYMgV1f71CL7LsYZYq7Ww87uVLKV?=
 =?us-ascii?Q?mwKkfpLnKPNUzTyVMN9ngRLunH+bRskHY9WAfUA/+cGS+ikKau/Ob6TpR7X1?=
 =?us-ascii?Q?pWmKokhK8o0Q1OtPtljL2irfyV+vg+QuCWsIV70FwliuR8yQM5abqrmYIKnB?=
 =?us-ascii?Q?Yxp48ueb8mZsWKRSV7+o4k16qPO6RF+Mfehy5TT4jFXm4WDcBrRDRqGviM00?=
 =?us-ascii?Q?ucJWDgFM1SkQz4iuH0tt5yj3Ps2vxIKLQGNFE39douKgaw/tLqpQdPN7EaxI?=
 =?us-ascii?Q?5acqVElE5tiZFgMQnyO43wW/Kj7rYxyQ6ZMuzm3gPdhZU8QFV3T0QIG9GAsf?=
 =?us-ascii?Q?CIg07lPNyHK0mB49veVBOWvC9n8YLYwUjp9AI12kdSWPVc/TWeVsYepsPLfe?=
 =?us-ascii?Q?KdDiCseoKzL6HnZuv5EKedX06NDQ9w2Hl2VkSMUcKnIJOhsf6GXjJsWPxuup?=
 =?us-ascii?Q?ctVMuhz2MwqpfVnz1HNaPOLJDwE0ZYo/BgV6E4nS6fGk0GPKN9qjZPr7IVRt?=
 =?us-ascii?Q?bI4GRAWX0v6BhkglVn4SW/gjp06tuw5isYLra4ivLqyQXGVxg116vnqZWCAn?=
 =?us-ascii?Q?NLT04wwDDLY/kssbiJNQJc2N6tfWuNTpzHjIWsET9zm5HvofPCoKilWEHyDC?=
 =?us-ascii?Q?6N+RsDzEsCCyJRLgsUV34wYijZKEibRVQE1F+el05LIzNMMS5zjUOgvNFw71?=
 =?us-ascii?Q?Et6r98CTVtnrGneLPnWcfmE5opan7vipD8FQCYotHz1utRmhqD7DFjgAH8+0?=
 =?us-ascii?Q?7R0lcK4+HXM8gBMvv8GBDrC6VbPoB2py3ZVAdwy5oBDXYRg6vgm1kYqv4Ih1?=
 =?us-ascii?Q?nwPfiFkaajItKAve24lwA9+Ccop7iF09dKrr9k1GYdVDVosBHIGkvCBT9njR?=
 =?us-ascii?Q?6wRNn+7eRyW8xWOzMe6QEaFdJfmiu/e52i0pjowEa7f3/RMq+agEumCV5b8e?=
 =?us-ascii?Q?uuCQS9qfDrMJ86PWryHiMMXTP8UvtqJfCnITgsx5MGxmbb3/hsn0NmwIXoTw?=
 =?us-ascii?Q?0rVjspZ39rNhG5dEB1K9odiIQiD8z2XU0efm5ayDssh90UF0N4qTEg9QeR0R?=
 =?us-ascii?Q?fCh2Ilkf7IUmDalebmrE7gVGkkIb73e4Fn55dUl6udRYhTC3UBNQ0KTGmnRO?=
 =?us-ascii?Q?gujnlkOdWKOb5C+ODavDDQTJFkopGqTNPoWMFuf2WBZawymNArFl0r9qQ987?=
 =?us-ascii?Q?lmL1+DyPZj+biE1/CKCoZfhByS44CbRsU6QxIjsKbv+6tXKTDYqLXKzBoc2r?=
 =?us-ascii?Q?r3rFnleJuHV02jcuIp5wgYsZ/nuk54mEXFX0p6s2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79566aea-7392-4cca-30da-08daea10390c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 02:47:42.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyd3CU8J91Sz6B/mloftyYYadTmAVkzqUCpFNF3ve1kb69p+G477yip18JIsm3Mz9ONpXkZOsLsUgD5FbzQDuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-29 at 12:46:59 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> Including the detailed results from testing below.
> 
> tl;dr
> 
> o There seems to be 3 noticeable regressions:
>   - tbench for lower number of clients. The schedstat data shows
>     an increase in wait time.
>   - SpecJBB MultiJVM performance drops as the workload prefers
>     an idle CPU over a busy one.
>   - Unixbench-pipe benchmark performance drops.
> 
> o Most benchmark numbers remain same.
> 
> o Small gains seen for ycsb-mongodb and unixbench-syscall.
>
Thanks Prateek for your test. 
> On 12/16/2022 11:38 AM, Chen Yu wrote:
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
> >    to select_idle_siblings(), because there is no CPU scan involved, per>    Yicong.
> 
> Following are the results from running standard benchmarks on a
> dual socket Zen3 (2 x 64C/128T) machine configured in different
> NPS modes.
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
>
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> Benchmark Results:
> 
> Kernel versions:
> - tip:          6.1.0-rc2 tip sched/core
> - sis_short: 	6.1.0-rc2 tip sched/core + this series
> 
> When the testing started, the tip was at:
> commit d6962c4fe8f9 "sched: Clear ttwu_pending after enqueue_task()"
>
OK, I'll rebase the code and to check if I could reproduce the regression
with SNC enabled. Previously I tested v3 with SNC enabled and did not see regress
so I did not enable SNC when testing v4, I'll do the test with SNC enabled.
[...]
> 
> o NPS1
> 
> Test			Metric	  Parallelism			tip		      	sis_short
> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48929419.48 (   0.00%)    48992339.28 (   0.13%)
> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6266355505.80 (   0.00%)  6251441423.60 (  -0.24%)
> unixbench-syscall       Amean     unixbench-syscall-1        2994319.73 (   0.00%)     2665595.13 *  10.98%*
> unixbench-syscall       Amean     unixbench-syscall-512      7349715.87 (   0.00%)     7645690.70 *  -4.03%*
> unixbench-pipe          Hmean     unixbench-pipe-1           2830206.03 (   0.00%)     2508957.89 * -11.35%*	*
> unixbench-pipe          Hmean     unixbench-pipe-512       326207828.01 (   0.00%)   306588592.66 *  -6.01%*	*
I'll also run unixbench-pipe in my environment. As will-it-scale context_switch1 also stress pipe and did
see improvement, I'll check why unixbench-pipe regress.
[...]
> total waittime by tasks on this processor (in jiffies)     :        176365,       258702  |  46.69|	* Wait time is much longer
This seems to be fall back to the result of v1, where we inhibit the idle CPU scan and caused problems.
> total timeslices run on this cpu                           :        116797,       106922  |  -8.45|
> -------------------------------------------------------------------------------------------------------------------------
> < -----------------------------------------------------------------  Wakeup info:  ------------------------------------ >
> Wakeups on same         SMT cpus = all_cpus (avg)       :             0,            0             
> Wakeups on same         MC cpus = all_cpus (avg)        :        116689,       106797  |  -8.48|
> Wakeups on same         DIE cpus = all_cpus (avg)       :             2,            4
> Wakeups on same         NUMA cpus = all_cpus (avg)      :             5,            7
> Affine wakeups on same  SMT cpus = all_cpus (avg)       :             0,            0
> Affine wakeups on same  MC cpus = all_cpus (avg)        :        116667,       106781  |  -8.47|
> Affine wakeups on same  DIE cpus = all_cpus (avg)       :             2,            4
> Affine wakeups on same  NUMA cpus = all_cpus (avg)      :             5,            6
> --------------------------------------------------------------------------------------------------------------------------
> 
> The rq->rq_sched_info.pcount and rq->sched_count seems to
> have reduced proportionally.
> 
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
> 
> All numbers are with turbo and C2 enabled. I wonder if the
> check "(5 * nr < 3 * sd->span_weight)" in v2 helped workloads
> like tbench and SpecJBB. I'll queue some runs with the condition
> added back and separate run with turbo and C2 disabled to see
> if they helps. I'll update the thread once the results are in.
Thanks for helping check if the nr part in v2 could bring the improvement
back. However Peter seems to have concern regarding the nr check, I'll
think about it more.

thanks,
Chenyu
> 
> --
> Thanks and Regards,
> Prateek
