Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451496DF7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDLOCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDLOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:02:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF877EDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681308143; x=1712844143;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yrzarY5BBUCPH2QYtRefVemBmw9xO387nEF3b81FX9k=;
  b=MEQOuGshxj0FZN9RD0cJKsjuGZh11MddUb19GYzgo/3b7XMCL6bAUuse
   6husKCX5tbt06XBj3wv8Xq/0AD6e59rWKAsRIbv0O/0mjTdYcLkNMcqve
   Dp6oseluvKJ3lSBab4Q/E+IzGzwU46DGKn/ATC4UR3S1azxbGzFJKpFYB
   X5cmbfpA9MJRHWgqUVjwKz8TvgrM+P/Q5OzbfZE8vpeYbM+tHZr2vmTqz
   dQrL2msbKTcbcOdIgBituvhthV2pdLKfWTfp6IKnxWpu9ga+8kPPyn+P1
   xiy9kLH07AUz+M+yMg+A9xEVzvtuKDoTuO2jZGqPVW9HLpKUiPTvhTeR1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328014117"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328014117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753536989"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753536989"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2023 07:02:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:02:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 07:02:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 07:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBq5XUTYMmLmXuV9dvhV7NIy6WEFOXfJHB6V7Tv2JfgvimNxV+HecMwjgyiAx/D1sOrC3Ql0eX+7WF/jVJhZmNSn9lU6rj3Y2tRQ4w9bqwcO/80GDF6MoxP48SSdtfsnKZfaay1GzDhfwI7hDxQpCUvn0Ger9NGQ/TC+kMH0ouWINEQLrMd2+mwv4Q173v7skC3aIB1miMreZdpz+/nCYKpegTQtckPVHCcBPC57+JpGryf1iN9SaAoVXzhM4E20g7tBCrPMqVV78jR3/WRsfMD7YNnLkRBlm5j3rKf9SsxtzStQ6eOcoRtLk5bnox+LpasY338IIWZTr1vpUrmBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V++gYLh3NlvMXankaAXEY2lajCehvbmM1UBrK4sQFTw=;
 b=FcnjEN24kdvzinqmRlhyU1wnhqbqWJbqIo25q07PHFbJDQi8rnab7yZcBoNdTnKZUvaO3RN135jkK4nnTOlLesNRs1XGgyF0aj+IoScnCNmirZqC3AL3L0yIEz0hFQ/BDee0axssi21Vg4s7QEqsTl6tWy1ZFTypdBsq5KZsP/QkDel6Kb7wT0ohPhVDDhFOHbx0ifvrpckzhcS/pSl+DmQ7ffn+DB9Vi8EEFnnRmf+jBIEmVx+3ZDbd5/FfdX3+AlzAluwCxvU4At6DfBkgYKUdEaKXUPL7dv8lbWU0Z4r3F1oN0i3zKxVRvu1lwK0WHWjz8Ki0NVFVPTmmLX4E3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB6954.namprd11.prod.outlook.com (2603:10b6:510:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 14:02:13 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Wed, 12 Apr 2023
 14:02:13 +0000
Date:   Wed, 12 Apr 2023 22:01:27 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230412140127.GA155769@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <20230412115936.GC628377@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230412115936.GC628377@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 82be46d1-4a83-4042-08d0-08db3b5e83a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew3XjGOcNnveNn64PJxlFv05mpoSeSxwkoD6h/XmFXeDPYeJPvYkDAxUN1a1uECp6VXqYgsXI3f44BV84aQN5wz9YF0lpyW3h59/JXpgvfK/LHAVG4Oru9q6Jp73dCODzsDQN5yvM+zvtdxGEOTb3ENh5esHgVCep8LZOkZ6SuNEGbrhlbkpp6/TwcpLe57RdMvq2JEdIT7E/R9G6srQp18kfU7NE0xBYONdBqYgHFM5aJIZxwZ7+36JlLUVekUxmR12SAKE4mGQ2GvUxIzg5LhI5MzCweFATSBHzKstvwaUSfRkbxPdq0gJlgy7W78u/ORLmoBDm8faQhLKK2AP9t76mVSO2d3yJN+JR5SgeGzyRcGqiXl+g9i6U9V/YegRYZimSdY9KdWubNt7Z742txUw2o8/1CCFTGk3n1UasR1C8SPQgpmydpK/qKh5xvvvtC4SWhxrokd/W3ZqmuNWjegDnV66PHb7pNQbKZf1pvTMvYSJiS0Onena0cfIi4Xuwn7XYw/F7e0KSEUcw4hP6B9PW5zUerMU6kSRLi4rN09SrLJSA6tN/l/FQbMKar/O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(66946007)(6486002)(8676002)(6916009)(66476007)(4326008)(478600001)(316002)(66556008)(54906003)(41300700001)(33656002)(86362001)(6666004)(6506007)(1076003)(26005)(6512007)(83380400001)(9686003)(33716001)(8936002)(44832011)(5660300002)(7416002)(2906002)(186003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMM8STa9Ri3O++/r+QVwOUJKnyX9CAWbibpC6oSzc6Q3Zg+mPSiI2TclxcVk?=
 =?us-ascii?Q?VXLG+j2PGRs0+7LOiGPcdxu8bs9VkKCscmPju+PFTxk3bvGRkAtcSu7GKCQi?=
 =?us-ascii?Q?YhOmXvpJL2w60/HOGYfXL838MjB+9NO/aTuf2qgwyhVXNw9pt1TCwodqdgl0?=
 =?us-ascii?Q?+AfYsyGZCv/zco3ooTpPWGsPQWzDh1SVFhTeMq9BvYVccWr6aiBWid90C9kv?=
 =?us-ascii?Q?KOadAMI02q7jZzNxHDEtK87rLFBd4UNGbgDlFZ0W+VUz460RVhsjEMOjg5z+?=
 =?us-ascii?Q?RfATEVb34YREvyLt77spaUNCYgu7pGN3z+MmTfMnCzT7PQZ2N1LnVuViJ1j0?=
 =?us-ascii?Q?zvzCdOGJchk6CCV0OIlPgmlZmxnTfNmEVqnDcJmttAmeVn/udHKk5oDrGKdG?=
 =?us-ascii?Q?st9WW+v0sYFgquQ1lqphETRMdwfFiZ49UOV6aN96+aq1GjKflwZXGf4eH8mL?=
 =?us-ascii?Q?Ig56/AmVMZz9XBi9F+MiuMEQwRZggNecj9IFZW+HgmxHDYXSlNwI5XrAEGdB?=
 =?us-ascii?Q?uxb/xHnArGyVyvvUvqMnJfUODbKV/UWNgKsxBcKfPWTsWHnfWKpL9e5XoxQK?=
 =?us-ascii?Q?fYbi0s9VrLGLruMXsp6NQ9R5t+5qeHAxXvUhDm8gKcDoKDzX+x2bzS3f1L4J?=
 =?us-ascii?Q?9EpFAvzPGqUTSDFXNlW6Kg0nJNnCliFklDGn3ENfaZoKUPGGdNGdbh3cwuhD?=
 =?us-ascii?Q?QroyX0s9c7F0/khbqWTql2FIq6R4z7FakdITeAdSLGHcGiFu4Bd6qbJla3j6?=
 =?us-ascii?Q?RudRzHVNdLSf8YNfIoUF4tnGIPNmSNA4kKq6W9AGZyfkkNhP8aj02CfkbzaM?=
 =?us-ascii?Q?Oec950vjOUwgUxXuZRuf9+eL6BrsqeVadfWY2fM81I1hGvNS5YvmEffFH9VK?=
 =?us-ascii?Q?+Gs9IzvHQr7L9bpWEkOi4KAgptKYWBc54prcbTczGToxdMw8ILq1iBqRqmXi?=
 =?us-ascii?Q?7FIKlHHiNjrxGtQBRCE/kH5eLPjEhjg9aqFlDX+u62ne019M/XsMiX/yr/KY?=
 =?us-ascii?Q?By5DXIisWwur297B16KyBZ8y3ux9O7WH3etN/myVwVtKTphOToNO7ZxfV/b8?=
 =?us-ascii?Q?10ZhLm+LkPVRCnTnRJFN/X13rM+NHlOv+lzGaM6DbegG7MwG8OuqhOOn9MPv?=
 =?us-ascii?Q?SqYr6rzYe/9AlnRFptW3awm35dYOf8jkYxJErxQFy55XSZ/8UPn+xVECudgD?=
 =?us-ascii?Q?DsBaoy993h7A4cBHs5BYNW/Kmwun5pm83wke/UKWsdvgcscYvrtxySb86h1J?=
 =?us-ascii?Q?Mu1GKihPMJSPMlf+nBExt2vwD3rEqRjxI7tRUvXKK6iAJXMl8V65YO562dD9?=
 =?us-ascii?Q?wZ2L2nIAl5BC1Kj6yVZYpaAxPfMMHE9NYgh7XEBYxU47m8Od1aNYm8CZWBKI?=
 =?us-ascii?Q?y62cqrtjSDpPIR4CowUkSxVHfE4aa3A6bDSmKVz03c7zKcW08gqu6I99PFL4?=
 =?us-ascii?Q?LBXHR+TcV1ISnk8SzyNjTF9/8Ici3ezvcSJtmypBEtZKKalERRi8VDmkYmPa?=
 =?us-ascii?Q?7Xs2vUv6xEpSrdWoO27C2gpwDsHwc5qDU8JIhUJrMlKLJkEr5/eica1AR7P6?=
 =?us-ascii?Q?w5XKuNkozef+gSvfQo/E6RCAKxZGp+y3+3Xm2DIN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82be46d1-4a83-4042-08d0-08db3b5e83a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:02:12.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1UEfX5A/C0aV5Ujr3EkZ2sWoH439Byp5zKE/hJWH8dgcUdvv/EnuKRICwK37sv5vzVG02ej73b2GIT1IYsG/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6954
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:59:36PM +0200, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 01:39:55PM +0800, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> > 
> >     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
> >      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > While cpus of the other node normally sees a lower cycle percent:
> > 
> >      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
> >      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side.
> > 
> > The reason why only cpus of one node has bigger overhead is: task_group
> > is allocated on demand from a slab and whichever cpu happens to do the
> > allocation, the allocated tg will be located on that node and accessing
> > to tg->load_avg will have a lower cost for cpus on the same node and
> > a higer cost for cpus of the remote node.
> > 
> > Tim Chen told me that PeterZ once mentioned a way to solve a similar
> > problem by making a counter per node so do the same for tg->load_avg.
> 
> Yeah, I send him a very similar patch (except horrible) some 5 years ago
> for testing.
> 
> > After this change, the worst number I saw during a 5 minutes run from
> > both nodes are:
> > 
> >      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
> >      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> 
> Nice!

:-)

> > Another observation of this workload is: it has a lot of wakeup time
> > task migrations and that is the reason why update_load_avg() and
> > update_cfs_group() shows noticeable cost. Running this workload in N
> > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > task migrations on wake up time are greatly reduced and the overhead from
> > the two above mentioned functions also dropped a lot. It's not clear to
> > me why running in multiple instances can reduce task migrations on
> > wakeup path yet.
> 
> If there is *any* idle time, we're rather agressive at moving tasks to
> idle CPUs in an attempt to avoid said idle time. If you're running at
> about the number of CPUs there will be a fair amount of idle time and
> hence significant migrations.

Yes indeed.

> When you overload, there will no longer be idle time and hence no more
> migrations.

True. My later profile showed the multi-instance case has much lower
idle time compared to 1 instance setup, 0.4%-2% vs ~20%, and thus much
fewer migrations on wakeup, thousands vs millions in a 5s window.

> > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> If you want to make things more complicated you can check
> num_possible_nodes()==1 on boot and then avoid the indirection, but

Ah right, will think about how to achieve this.

Thanks for your comments.
