Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4D6452BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLGDyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiLGDyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:54:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470BE52160
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670385285; x=1701921285;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zn4P+NXj4L5lrAXAtSgel5I4qZQ41XbwSEJL1yI0FKI=;
  b=cBhqt+bjJepunj3LE/tEuCi3fD5Xi/srso3I6TaXNwKWWvWpcWHdV52h
   VZ8XMW9PNQSU6GEv60gDZ7vEuHpdKVvt8S6G9v2k0cGXXCD1kp21YPp3T
   Ltj3JUPFCeeNnitN+ORZB8ezmdLAjjKqXu6iVlHs2CPzAbmRwfKcxiiJW
   O5PsKpS+wZWI51Y4nxIBC9VqjFR3pQIFpZomHCBi3KIo+e2cDyuUN2upV
   VkuCaNnNVbnGUXb9ZQYqPw5y0l9Rb4RVUhXm1v2HwwbL3g0t8L322B+Rp
   OiVAoVjVTYYLhEhQlUcq8N5jLIKFhTO7bukSFfuNALLN+aFLiEl87VEOV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381090751"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="381090751"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 19:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="788738844"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="788738844"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2022 19:54:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 19:54:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 19:54:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 19:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS9SFMR3+7GFsptjW/jYMFgBsr+bcazZhbmQJPGy5Cwybj5z14zqU7VhAM8NtuIrf6Vq3ZdG3mtgfDb6M1dNBC61GbVQOUlKT5BWT6md5U3kpY7/wVjfujtpDdetE8aksjmmchQxXitqduUMuGFS9resdx1JaGpwQ+V6xJ7Z93QeC9wJeO+TE59libCsDimlF5C/vQ7OUBprLiiZZcHn+nIDpDW4A3A4JR0vTiyCZrbrBx1wvroeQAaHcymzb9hTo4qeoOCYu8q9ITBBmO17RcbhkZrwgIkIILTZ0/74o64PCo67gscBJaxcZpx1xiURKYmF9Iop6sy1FcJR5QxhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlYS+2FdDopKSGNXihM/0TSYlFJqejNIIQ8i26dJh5Y=;
 b=l0BV6jPw4viiKYMWdb2czbOuUUSGrQ6HAEp9IP2wx1o375mSQkv7rEC41bkL0L1n0bnkoouklU85pw9ZYGxWJtSOauo9OCM1qLzdhthA7WcTFvwnGAYduEvXIoi4umV8cLNDSji9+rZ0RfLzBrYssMhI5JhASNLGEpL6PfzrvNyxCVswwTyzEVpMqZCO8HwucYDK09Zf1egYRoFnZWdb26qbD6mOBHAd4B3s6AP8jRxAQ9iNH0oPq4bh9UgPqmEGp2Kt4nOYXduAZwKft0SCL6ID9wQTCCGzEgUNgzCD1zUNCXJGufJ6jCxglbdoDyEFr3L/Ry11pfm4vrgmiW+QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 03:54:31 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5880.013; Wed, 7 Dec 2022
 03:54:31 +0000
Date:   Wed, 7 Dec 2022 11:54:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Tim Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 2/2] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <Y5AOYq+wHKJFph0l@chenyu5-mobl1>
References: <cover.1669862147.git.yu.c.chen@intel.com>
 <0fefba11f59c083256eabff0fbb6c82b9d3bfdf9.1669862147.git.yu.c.chen@intel.com>
 <c504bc78-364b-e608-d539-c763b6ca84e3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c504bc78-364b-e608-d539-c763b6ca84e3@huawei.com>
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CO1PR11MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f8345a-d75e-4ca4-7cac-08dad806bf13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjfdFsImcm/NzGHhSsVS3RwUOagFaTowZUdJlOc5VJkMIh2B+Ikhg4nLGWH93cx4maAzzBSr7GWMNxv1dqwpE6lxbIdVYR1AU95OFykIOJY3gM3DPv+CzU805x+exjtyR09uoPpM0WtoHBCcDuvpIH4iiU6i1SgiDYlpsgpQs1n9OtvjOxNtPztdjaSlFNNJxcSmqya5fanihF0VwEyK7Ia/MBpU3G2QAczY4ldyzY9yRUiYo1m6itgpgfveV84D2O0QCn5WbsML6ocWQA7z3vks8HvT4Am929slBjjyJ3KRNjumyIZPFLBoBYmxg8OhI7Q9F3vPvzC0SjvVCsU9KvyXYuUcnl1SbkYj950/RKz+00TMbubqDZDUnj2TgNTd0Ml6YXCnoNRftGiPm1Q/pphC4PFXxVT8LcdEZeIWYGVP0k9ndLEv9kG1pLY01qHf0A8IJOeSNqUkff0WBP1+9DimsUBHy00vxi382NZtx3v3v1mJE/iRSds7UgJcjVyuijtvkXID8FLnxE5q/NANw2OCSeTrk4l/IoDSk4FtUgErs2gvJ3K9xxUbtsITDtSsQlNePZvz1jiJmatQ9nMwL9uxPefKY/xgTzQXiItQWEZnu1njaIo5SfsR8zE/JXZh6jm5P2taoKK3Di0bU2m08nJaahqGixg/AB76x8rL9E18tm4x75kULdT2LUqA9Yg5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(6486002)(478600001)(186003)(6666004)(107886003)(38100700002)(7416002)(5660300002)(83380400001)(33716001)(53546011)(2906002)(6506007)(9686003)(82960400001)(316002)(8936002)(66476007)(86362001)(6512007)(26005)(6916009)(66556008)(66946007)(54906003)(8676002)(41300700001)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLV5znT0tNKYmZnSUJMhKVSn/xWbMDjmbdXkOLV2E+mIbJqPr6AHc9PS8xWR?=
 =?us-ascii?Q?0lmQLrhRMrISa7jUtvHeiLkeUYqN9XbBBUdfQW+1cy2+Ez1u97ChaQ3BWSGF?=
 =?us-ascii?Q?afH9H1Ova3ZtbxZdc9rc3LkwXmCEQdWr3p5vckqZ2ctYWiUzCTl8Mibt7eJv?=
 =?us-ascii?Q?2cm61ewpYx9ACE5CkIFzTsB+3g1MAvS0pKlFKJ1Q1CHAblHoafLy1H/Wqic4?=
 =?us-ascii?Q?GjCu13hCzE6JcLHDI38ql3R51nytLIWFPgthi+1DFo81yHRzk/salo5NJa43?=
 =?us-ascii?Q?cqES29RCqk3RpyMavSYG2o8Zcllkq6QkypDyfsEcc4gvDgit+5ci0KwuN3eu?=
 =?us-ascii?Q?EwSsABu6F1LQhHdzlU2Op/F3z//8hcvyBtKZeMLzRUCaNAyBTvqUEKL2SfXi?=
 =?us-ascii?Q?lxvqrMzKm6twDQ9Mxt55Blj9Y5KnbOlb5NaUvgNDRP3YCvjuOupl3xNHOwsv?=
 =?us-ascii?Q?QpbK4NnDa+MfKiXM4r3Gt19PGU5EiiPQp3Cw1Tch4z/69bCpKSZPiGMVXdQ8?=
 =?us-ascii?Q?RfDna0uD7GTEgXvin5oaBxLmDx2n5wej1bRVqLR6cdDXWoa0MOx20Y0h31Xz?=
 =?us-ascii?Q?u5AYelomP1CqFtyHm7kTZ2c2Wkg2mDZmcjViHj8EmAfCRFktDeivQoU3x8ht?=
 =?us-ascii?Q?hko7zI7lMHNViV+YKcKb6aY1cKhWIKQCM8tmTu8FO1z3Fb2kpxZ3RfVU63L9?=
 =?us-ascii?Q?O5kd9qasRIdmkViZktLQ38ybmImubtn/QO1aui0vBQX/GNpltwFXOvGrzW2s?=
 =?us-ascii?Q?clg1VhAhLCjLTTyld3EVtRKLgYdQb0BudL6dhKvWff4JEA5GQM983+WZKnZI?=
 =?us-ascii?Q?FdwbzYi4ML/bQMRnSM91WHpTkCAcrIdu990wFDAkwSEpncG809G9gnTpleqM?=
 =?us-ascii?Q?N9ehL5BPYhX85n10wcOPN4uT8oNUfqX77AcK04er0i/GsybJzPaUeWgTV5uL?=
 =?us-ascii?Q?DtJdKwkhRzDF/UXSB8nmU3DTzqZ7OLil0ifpuoEAbvNvB/LHmXlVrq8Gc9Kx?=
 =?us-ascii?Q?EhUef89zs2d3oPkeNGdXXuX8oGjb1O3/no4afJljFcCtJ4nZz4bDZQx6mr5h?=
 =?us-ascii?Q?1QwvHn9RtqzWqVBibtewx3S2UzLDm6b7AIXo7n63ox7dIDcolYrUtHobi3vP?=
 =?us-ascii?Q?pbXRJ6nNJ8Gcaa5aOLRJWraB9Z+tGmcdBuRkTE7pVAbEY/kyrH9Zu9hP60O5?=
 =?us-ascii?Q?G2+OnfVHXchMTf46pg3/g2U4UQKPYBBGoKj+041rg2ySOtUitALwD7XcMHr8?=
 =?us-ascii?Q?llLyr2Z+ItQNkLDC9sU3swJqJDdPbPceFqF49m80bjZ3iGuqGLd+xVcAdz80?=
 =?us-ascii?Q?8SBf9aw4wJ27MkR9+nEyE8popqOo0tnhfjh4fUTPcR76zAWcd9FJKuLtmPn8?=
 =?us-ascii?Q?Lqj1uUiRGu5KOrjqQXvJI4v8oosp0TbnAEZvi+w8e4LOBRZNW+pltuH5Srnf?=
 =?us-ascii?Q?ZQehvuc144dG56sbJmU7KQ380MOi+av3lxmh3NpIUUgfqxi8S6LPMcRRK40D?=
 =?us-ascii?Q?HYFKpueSdLQCt4QxCu5yc/sO0jOzi5Tho3ykwSTL4LPvLb9WZ2z5JjM3uL5F?=
 =?us-ascii?Q?EdMamzPQiHV/QeuzbiXY7X2F3gLAosrR2X2jTzSC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8345a-d75e-4ca4-7cac-08dad806bf13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 03:54:31.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bl3bAAqaBY1zrnoS8lRWsxBETGNP83iluJx76+UpZrnxKL9l10+34H/gl6eaeNbYHUf/8cNGIPLGjFcvCXJ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
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
On 2022-12-06 at 21:02:11 +0800, Yicong Yang wrote:
[...]
> > +++ b/kernel/sched/fair.c
> > @@ -6246,6 +6246,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  	if (available_idle_cpu(prev_cpu))
> >  		return prev_cpu;
> >  
> > +	/* The only running task is a short duration one. */
> > +	if (cpu_rq(this_cpu)->nr_running == 1 &&
> > +	    is_short_task((struct task_struct *)cpu_curr(this_cpu)))
> > +		return this_cpu;
> > +
> 
> Is it necessary to check the ttwu pending state here and below?
>
My understanding is that, ttwu_pending will be set on this_cpu if
1) this_cpu is idle, or
2) waker on another LLC domain wants to wake up the wakee on this_cpu,
see ttwu_queue_cond().
For 1), the nr_running is 1, so it is not idle. For 2) the
chance to do a cross LLC wake up is relatively low with current patch
applied. Besides, I was trying to make this proposal a dynamic version
of WF_SYNC, since the latter does not check ttwu_pending, I did
not add this check as well.(for now)+
> >  	return nr_cpumask_bits;
> >  }
> >  
> > @@ -6612,6 +6617,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  		time = cpu_clock(this);
> >  	}
> >  
> > +	if (!has_idle_core && cpu_rq(target)->nr_running == 1 &&
> > +	    is_short_task((struct task_struct *)cpu_curr(target)) &&
> > +	    is_short_task(p))
> > +		return target;
> > +
> 
> A short running task doesn't means a low utilization (you also mentioned in Patch 1/2).
> So should we concern that we may overload the target?
> 
The overloaded target might be expected in this case IMO. Because for a ping-pong scheduling
pair, we want to saturate the target CPU to eliminate the idle time. And this strategy
only takes effect when !has_idle_core.
> btw, we're doing no scanning here so I may think it'll be more consistent to put this part
> in select_idle_siblings(), considering we've already have some similiar judgement for the
> prev_cpu, recent_used_cpu, etc. there.
> 
Got it, I can change it in next version.
> Still doing some test, will reply the results once I get them.
Thanks for the test, we can tune this patch when we have the data.

thanks,
Chenyu
> 
> Thanks,
> Yicong
> 
> >  	if (sched_feat(SIS_UTIL)) {
> >  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> >  		if (sd_share) {
> > 
