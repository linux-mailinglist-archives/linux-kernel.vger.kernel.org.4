Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19FA636456
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiKWPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiKWPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:45:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B9DC4C3C;
        Wed, 23 Nov 2022 07:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669218328; x=1700754328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Yc+A/xXUFaEeWiiasDUR2svInBmCuGcvrT1oZX7wRbk=;
  b=lodIpIfEfBMCulZf8lH+Y5VsYw9CB0xM1RxT8TE4/4/BOdDRpqnhMT0M
   2q73LcJV16LOx/zguCI/9Dp82STJdBdifqwGJY7bCxacLdcLm/dvVqr1h
   VvkhVPicsefOiIH7A96BkHA3reARPhrfbJhrjmfmIlHNl9BF8+/4O/zI6
   s0BlkUlWP4rldoyt2eokeeuJOydhdE5ajhO79HpOBMUViPesdGIxAMWlM
   N4piABmhywOdwxlBj6wpFCAcJWoIv4E1lAYNhVXE4NyOGmpC58JJVjO1J
   wgPLsBIMpz2BlQwdGI8JDKBNhhuPNjBVUM2FQiNNjtiGSYTalw1sacOvl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="400386488"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="400386488"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 07:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="886994075"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="886994075"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2022 07:45:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 07:45:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 07:45:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 07:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXOOj33z0srjpyIdi/k5tDdTNYa3ZoQe2Q3CUzUKvsXdXhZm54CWxXxIppdALPGL1z4+Sut4e63rDY4TH5U62XsBqHJweoVO9Ms97aUvQ4cTeHF37xMXB7GVAGWlmFC7paY+rVKuKvmduf9bfuCGxAxbNTcXz3+v/dQUlR+9nyj7m2FxiROIVNrVk6lx84zOQbiDMdEKMYzA36rO2piPU1BXJMdJuSU8rb44h+L/9l8qJoMZO9eoL6z5XrlXj1OzFiH5JjcDI7omjbHrXQ0DDJsfRv3YSFqtfi9JUa6c/6jcU82Uhhmp21/QiTJTZ0NG+ejyGrGGTOZ35PVQS6GLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvimOYfOwf5MMRs3oQYoMM54UNYO+pARNdBy8K+eJpM=;
 b=C0e02Oh+kBvOHrbxEH5JyFr4AUgrReuVIqLptlXd0UUhThC0QlJzoCueUUc6OCuqjY8/HKoFSufEQHiyOtSXy2MESlqS62zPjMTTc2LBv1f4i4vaokaC+n8iiPQkTjFcwYUAMsw99cmOIE9tAtw9VwqNkiqO3k3yo32tiALu1bbm3AJI3AWhOw+7UPPJUYDRSZzU02uxRcpasZD+2LbQCH0LAheJmOOBG2nIfwn7tuA3N3bmNyxhEhOzih9IHo74v/q12DQQJ+fnfFWO80fCiIBXc1OiZhS5u++mqatFnvz7q+M6s22VTnpQg1THlgVRPsoakCEN5Jqy43n+CMEWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Wed, 23 Nov
 2022 15:45:23 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%6]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 15:45:22 +0000
Date:   Wed, 23 Nov 2022 23:45:50 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <rcu@vger.kernel.org>
Subject: Re: PID_NS unshare VS synchronize_rcu_tasks() (was: Re: [Syzkaller &
 bisect] There is task hung in "synchronize_rcu" in v6.1-rc5 kernel)
Message-ID: <Y35ALpl8borkSHjy@xpf.sh.intel.com>
References: <Y3sOgrOmMQqPMItu@xpf.sh.intel.com>
 <20221123143758.GA1387380@lothringen>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221123143758.GA1387380@lothringen>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: 340c54c7-1bbd-4e48-d52f-08dacd69bb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPE2NZFUnpplmYlktp12dQW0P5vn/hZmUesR4EUxWlpK8JETXBc6W/0okk9BKtovdPIcK9fj/eiGTOuE/mt6Gj15jExHbRB+4q1i0JoGpDiMkHkwD8vJlNC7xzK4tTRsvLTOmigwnrZCxVDI+gAStYsmSmQWPo3TdCby+MTWQgtm40R/3nISWsaqMi790FZVB5ad2YXOM3SDRnr5FCmMYsKGElaZDc2j3HunoQU7RL/TxHhH29T7Uf7ZMzQJHz5jSfTzUL8KgumIM1LebR3a5ex3l/xG52JLbvxXI16gUAbFidV/ECReH1wLMEU8m3vPZ7+8Xr7qGQ05qakePY8kkbyZ9zw4Bnn694p/yTUAVo8Qgnj+51u38sPCttn2+nAjqy+5PjKXNb8j16ciHKqqtOlocNPTnIYzYyM1cqIKoVLenZ2XKi/f+ztdK7xVW5GPyjb/SF3Bzh/i0Br0kwktPmuZpZG2F70nmuboYNadDax+eJ0QNRq+pqlSGqCSnqYH0+Xxb2Sfy9UelkVMLVb4vhADIOqA0yNjVNjYm6u+qmahxKX1bFfHBBJoQ0OosTnDNOGlJa+G5tEVb/r3Z85YM2UgrD2rledF8KPJTqJDJxsdJHcOn8EYkazkk6woQmO9IcHDTwk68MVNXKZ8PY1lBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(82960400001)(83380400001)(2906002)(86362001)(6512007)(4001150100001)(478600001)(5660300002)(8936002)(44832011)(38100700002)(26005)(186003)(6506007)(6666004)(4326008)(66946007)(8676002)(53546011)(66556008)(41300700001)(6916009)(316002)(54906003)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Y8x5WUYmW0nm5U3PoEtcyrhUlYPyW+6Ag0UjP2pYkicegmOBHsCdeZW9y/Q?=
 =?us-ascii?Q?q9oviMmBa4m91z0YgkU1smrNn2XCNiMFRA+ZRm0hZNbqe+Uup2cy1WM/4ujI?=
 =?us-ascii?Q?khtsfG6cT+0wA1kuBSwqDxSY9M2hLNgjC/Yd/YnyKJfzfRDiMvNTZVTqYrCL?=
 =?us-ascii?Q?fEG7MUQP58KjBGoK9NVrdsbKdaj688TJhf0gBAsQd+/JYwTB6G4Bcnl3mPz+?=
 =?us-ascii?Q?E7fKqs6m3hzIRRNq/nw9psLF3ccBhiAGialXM5+o6lk9cNswpKvL7uuuHLdf?=
 =?us-ascii?Q?voFxtnYJoxZa2i/vpsVH1mSUysNcYbp1PNNblIvk5dSTQr/nGjKoqZ7ZHN6C?=
 =?us-ascii?Q?EUaN0kV1l+TfOe7HZ/fZzJEL+oUyp6up0hNr9O/Hk7h/w3MHROxxSgD6xgG4?=
 =?us-ascii?Q?cdcrgq0Xp+ORp+LuzHIw4JKOgbIRzODqFlbUipeSBhHfJUBIJmrFVlK5SqFm?=
 =?us-ascii?Q?zr1Gj7nkdqfF8CCtdQoeMy+Wplgk073/TEwDxUZrtu5ZI9C1dykBQslpVbCA?=
 =?us-ascii?Q?LVw/ojZyMUhpJiT70Wvn3GriFg3Oi52tecn3wtoe7ilzC/Lh2bEYi1glMkMM?=
 =?us-ascii?Q?bSOybAhvKqDO4LEUjri+XrYbnhhrbs83c3K4s0Y53ua2t/XiGtdn/5olpha6?=
 =?us-ascii?Q?BoLUmkqFrbWaXUPJgRJ5kLvArQx2ZeyUFWztFoMXVzDONKUlYTDjbs+fq+Ee?=
 =?us-ascii?Q?D2OArpCvwc9SL8Qop9+28Jkmb361rZqM6hL7RXyRBrej0NxXMQTk9OO4JVxZ?=
 =?us-ascii?Q?8dkS0rNWoADECPi5jQEf2PokSf5Ho6fVXVCZkVB+UcJv+bdzAPD0uQcIW/MJ?=
 =?us-ascii?Q?AAvvsCJuyqDqJ6sgAkdn9wNmDLuwsUqudJjLvs9AoKPhrUJWGV/YI7xTzV4h?=
 =?us-ascii?Q?LgbKeFHH/R+UWNJPCFYysWGZfBddvX2IRau87Ew2q0JbBMvVrgio+50C6S42?=
 =?us-ascii?Q?9BQqliGzfx3XoGvSdmqz0ktpE28aVT1dzmRex2mceuJICsprJOxoD8wg1P4T?=
 =?us-ascii?Q?R9kUeiih9U3p3uXuexAn8DFd94SRpeWH4cd/Mpy69jPOpzettDQWXeC0pToM?=
 =?us-ascii?Q?JIN9MuCsNYpiz2WhtYTenXVyXwBQpw6bJUK3dbazekhxeigZ61eOsUx8pvuk?=
 =?us-ascii?Q?cCaanUN60J02xa9tuXHpm+vz8ElM41CmxDPbTuYICw3zY6QK0V7fKlEQIPlb?=
 =?us-ascii?Q?P4jtpAzNEc0Lxgg93dEMDTwOuvzt6KIrA1F2e0X9hEs7IEyX+d4G1y2u/lYk?=
 =?us-ascii?Q?XbyxvRnZmmyFg8Kv9zjiYdsloCuAeM1+L7jCgrS7+xUNl7olFKc3jpKgIWii?=
 =?us-ascii?Q?n+6TAk1JJ+u25evG1gZ2Z3So8jHbjoCRviQ/xaPdZ40s/2BRx9U6GgsoZ50K?=
 =?us-ascii?Q?PrbkH1R4VAy1Id9dvDbCK3yqZTE7uCBU6kzSsH3Ph++dO2knMgEFvYnGeWiY?=
 =?us-ascii?Q?kFRjf8v1fwkN8+CBNWAMfUTWfbNkxr+wtTGJtd7dvpqcDqLDhI2FtyaIQN9q?=
 =?us-ascii?Q?AjoDHQYGOV0B+27nyffZZsEb9c07Z9OZHVIYESlNpKkBBI/TF2qH2pamjsfD?=
 =?us-ascii?Q?I/tXTr5ZfFyq97m62hu5kz+0Cv0fyF7oDewBYtVgok4Ihsa2y+RbYvszrv/M?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 340c54c7-1bbd-4e48-d52f-08dacd69bb8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:45:22.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVogQ5LwQXdMzaNP9k0FublHfP2AmucNQZ4I0SlJrE0Kgkcah1895ftMeSXPe0NyN7aKS/a4qKzh1+z5kyydPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic Weisbecker,

On 2022-11-23 at 15:37:58 +0100, Frederic Weisbecker wrote:
> On Mon, Nov 21, 2022 at 01:37:06PM +0800, Pengfei Xu wrote:
> > Hi Frederic Weisbecker and kernel developers,
> > 
> > Greeting!
> > There is task hung in "synchronize_rcu" in v6.1-rc5 kernel.
> > 
> > Bisected the issue on Raptor and server(No atom small core, big core only),
> > both platforms bisected results show that:
> > first bad commit is c597bfddc9e9e8a63817252b67c3ca0e544ace26:
> > "sched: Provide Kconfig support for default dynamic preempt mode"
> > 
> > [  300.097166] INFO: task rcu_tasks_kthre:11 blocked for more than 147 seconds.
> > [  300.097455]       Not tainted 6.1.0-rc5-094226ad94f4 #1
> > [  300.097641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  300.097922] task:rcu_tasks_kthre state:D stack:0     pid:11    ppid:2      flags:0x00004000
> > [  300.098230] Call Trace:
> > [  300.098325]  <TASK>
> > [  300.098410]  __schedule+0x2de/0x8f0
> > [  300.098562]  schedule+0x5b/0xe0
> > [  300.098693]  schedule_timeout+0x3f1/0x4b0
> > [  300.098849]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [  300.099032]  ? queue_delayed_work_on+0x82/0xc0
> > [  300.099206]  wait_for_completion+0x81/0x140
> > [  300.099373]  __synchronize_srcu.part.23+0x83/0xb0
> > [  300.099558]  ? __bpf_trace_rcu_stall_warning+0x20/0x20
> > [  300.099757]  synchronize_srcu+0xd6/0x100
> > [  300.099913]  rcu_tasks_postscan+0x19/0x20
> > [  300.100070]  rcu_tasks_wait_gp+0x108/0x290
> > [  300.100230]  ? _raw_spin_unlock+0x1d/0x40
> > [  300.100389]  rcu_tasks_one_gp+0x27f/0x370
> > [  300.100546]  ? rcu_tasks_postscan+0x20/0x20
> > [  300.100709]  rcu_tasks_kthread+0x37/0x50
> > [  300.100863]  kthread+0x14d/0x190
> > [  300.100998]  ? kthread_complete_and_exit+0x40/0x40
> > [  300.101199]  ret_from_fork+0x1f/0x30
> > [  300.101347]  </TASK>
> 
> Thanks for reporting this. Fortunately I managed to reproduce and debug.
> It took me a few days to understand the complicated circular dependency
> involved.
> 
> So here is a summary:
> 
> 1) TASK A calls unshare(CLONE_NEWPID), this creates a new PID namespace
>    that every subsequent child of TASK A will belong to. But TASK A doesn't
>    itself belong to that new PID namespace.
> 
> 2) TASK A forks() and creates TASK B (it is a new threadgroup so it is a
>    thread group leader). TASK A stays attached to its PID namespace (let's say PID_NS1)
>    and TASK B is the first task belonging to the new PID namespace created by
>    unshare()  (let's call it PID_NS2).
> 
> 3) Since TASK B is the first task attached to PID_NS2, it becomes the PID_NS2
>    child reaper.
> 
> 4) TASK A forks() again and creates TASK C which get attached to PID_NS2.
>    Note how TASK C has TASK A as a parent (belonging to PID_NS1) but has
>    TASK B (belonging to PID_NS2) as a pid_namespace child_reaper.
> 
> 3) TASK B exits and since it is the child reaper for PID_NS2, it has to
>    kill all other tasks attached to PID_NS2, and wait for all of them to die
>    before reaping itself (zap_pid_ns_process()). Note it seems to make a
>    misleading assumption here, trusting that all tasks in PID_NS2 either
>    get reaped by a parent belonging to the same namespace or by TASK B.
>    And it is confident that since it deactivated SIGCHLD handler, all
>    the remaining tasks ultimately autoreap. And it waits for that to happen.
>    However TASK C escapes that rule because it will get reaped by its parent
>    TASK A belonging to PID_NS1.
> 
> 4) TASK A calls synchronize_rcu_tasks() which leads to
>    synchronize_srcu(&tasks_rcu_exit_srcu).
> 
> 5) TASK B is waiting for TASK C to get reaped (wrongly assuming it autoreaps)
>    But TASK B is under a tasks_rcu_exit_srcu SRCU critical section
>    (exit_notify() is between exit_tasks_rcu_start() and
>    exit_tasks_rcu_finish()), blocking TASK A
> 
> 6) TASK C exits and since TASK A is its parent, it waits for it to reap TASK C,
>    but it can't because TASK A waits for TASK B that waits for TASK C.
> 
> So there is a circular dependency:
> 
> _ TASK A waits for TASK B to get out of tasks_rcu_exit_srcu SRCU critical
> section
> _ TASK B waits for TASK C to get reaped
> _ TASK C waits for TASK A to reap it.
> 
> I have no idea how to solve the situation without violating the pid_namespace
> rules and unshare() semantics (although I wish unshare(CLONE_NEWPID) had a less
> error prone behaviour with allowing creating more than one task belonging to the
> same namespace).
> 
> So probably having an SRCU read side critical section within exit_notify() is
> not a good idea, is there a solution to work around that for rcu tasks?
> 
  Thanks for the analysis!
  Add one more information: I tried to revert this commit only on top of
  v6.1-rc5 mainline by script, but it caused kernel make to fail, it could not
  confirm the bisect information is 100% accurate if I could not pass the
  revert step verification. I just provide all the information I could.

  And this issue is too difficult to me.
  If I find more clue, I will update the eamil.

  Thanks!
  BR.

> Thanks.
