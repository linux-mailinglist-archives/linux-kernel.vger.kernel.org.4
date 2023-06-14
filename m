Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE672F39E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbjFNEhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjFNEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:36:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA111FEB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686717371; x=1718253371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TdE4iOR9f5IDhJW7tXn8LxHtcP2/rmheUSop+2QnNrE=;
  b=Utz8R6iG/iraznk4Lgt9nbFQyRMGrlgKIkkEvoJMewKmAenjmTdZvsvG
   CP0EvIOiHxWFwiNEuKO3TBOb2erlV+tOqOqZBz4q3Dtccxaor+mmrh6JY
   XNGYE8coWcjqSc3BuO1VcAT5kFho2T5jZFfMd7cCaKnPuu3JJC5DXrPwI
   +uQPoXN/yBcXn4rGkVo/dGYimHAv8jeq7vkFoQaiwL8yCgxOjGPPrmMER
   QhPHnOt/chGdF/O4iyJYSDaumspfRfsF9EMcgunsmMakiKDwt1OOvRuuu
   0nmeaB360fBg4MXzn+51qqXC+7xvWV4Jq4u8zkDJerRP1aK3EbwGFgm2k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361889535"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="361889535"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="836135056"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="836135056"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2023 21:35:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 21:35:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 21:35:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 21:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO3CmqeZ8jrHOku+BpN7+GGD3hJviKHQu0RGr8se2MyzmHcM+Wt0djz92o/aj5k+LcdCBkE1YJvosOD1FxCJ+rlLk0gyNJpfbLvGRBhJvCpYvv/jtYzuOnU+j4CM8+F+oS2IaERwx6WmsdubatozYEEVvNk04bErV9aBKIu46SYYunbGrwxTZIcV2UxnLaJfhtfiIKyq50NXzGoyr8zmdH1lmGKM7lVYWDHkK9CqiJgGQyGvwncyEkLrdetMuyzHMQxxKWhIY44OSi6ewJrjGYed8eF03WV44GYoCyAo5VNwNLszrN+Tu4Su9XUvtRbhrzSxTB8eYhJ7qs03KQRiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=907M5yAvx0JyF4rvjKDJHeIj7kK+RQmTFpg2GlhCTQc=;
 b=mcYW8POQrm4mGX1p2kdkMh/fTRP9GveSy/HwBIiG4Uvx2Ehwmq0y0Y00d2UiZzbQwIJ67fI4lwvRTp5bYCtF3L915k4wRrVKdARGcORlk/t9oNWP5zDCm1qfxOb9Nu/iNWirtSlQdctznLNRtErRfvpwdQsvtMaLsaXv+4oNFEer/breRj9KGbCsmB0S0lYkb1wmLAyM2jB8jlFbjnnVcOU/mpJpwma5VpYA/Invz/40IJJOBwDCZypWNx1Ye6EMiydodWjY62EvI/X4+WY7h7J1mU68bVwTjfJUneI07QXFf4yyfAZXKnxeZlzDvR6abOls2jVU3lGm/+lH6hQyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB7320.namprd11.prod.outlook.com (2603:10b6:208:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 14 Jun
 2023 04:35:45 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 04:35:44 +0000
Date:   Wed, 14 Jun 2023 12:35:29 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joshdon@google.com>,
        <roman.gushchin@linux.dev>, <tj@kernel.org>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230614043529.GA1942@ziqianlu-dell>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230613083203.GR4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0f8ee9-3828-4139-5887-08db6c90d0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgyT0qL30E4dR1JRdDbVfS737x4zD3jeMoOrV3GPp+Euj2cLs3JPFlgAqVNnDXPWz7Hgzu7Sf8XatPdKUVe5D34SXmrjEp3BEoPNNq/Wzvtjjb+JPIQpK8JQkZzdkcjqOIEI15lrTT79iAUYJMq76A5s5ti5vXf8geIlEP3O8/WXVa7FKmzp/PqSgBVQkb9AyezvJk2ZMo2wNMXkJiyzrZdV7N6Z5E/qrTSSzU+0R61uQqEsqvjpvqPKd6y5bQbn8DlX3TZvDwiJMxG9C7CTpdZ3fmHjIHxcLqhRafSpGtGv8M6GetpEp4789s8IB6qG5sM2hpki57OwuNvrfX9fW5e9co1tIAd78OCLYdFUK89NcEm5N/GseEDEJpXXGKxD1hqhjZMdmvvhbgfURzY7LOQWfX2tHaidWyoCVPYsTPPtDrPNyyRXFuWnOFygYtVcZluwlbFp9MKTBOCYKtQFPuKRIQcaDlUA6VWdVjD9Zub9nrPQbeiQvoA3dFUJ6aFd4GYeSXcYnCEfKYC7rNV5FJOb+mZXr8iRk+doyDvq181DMQ3Y2j6nC5xRTBDuknd4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(478600001)(66946007)(4326008)(2906002)(8936002)(8676002)(316002)(110136005)(41300700001)(44832011)(66556008)(5660300002)(66476007)(6666004)(7416002)(6486002)(1076003)(6506007)(26005)(9686003)(6512007)(33656002)(82960400001)(38100700002)(186003)(83380400001)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ksDuVEWIW4Gs3ClQARjapgpDbkJQYewT5ps1nbJuBIWSOelvZ2U2v2v4cwS?=
 =?us-ascii?Q?OGgPFkwK7WdlZKsRyn+zJBlBlr4YEgQCxJZZJDaXRN5NDXyhpLYqA8PR7Dwk?=
 =?us-ascii?Q?MfKzhgbfsk93PEHqlOR/kneMs/MXjUXt6f7AI3NGYhAxpu9CjteGbV9PLEi6?=
 =?us-ascii?Q?Cd8lJYSTEXnl4lMVWVHuBrC5rfz97UVVr5sqh8MEqGXnLoYrJVwsSenSmR29?=
 =?us-ascii?Q?DoVfVrP0D9Pw2zKSlizq0+Ba070XNsQyr4v5DhU9oCf9IOjDQqp/v8Gl0r6p?=
 =?us-ascii?Q?fe1Vl4baIUBHHzDCXSEBQr7Wh8RJrEe59k5eb409EROEKJow4bdYaiyM9PI/?=
 =?us-ascii?Q?cfNhD8Ml8FUx2wLe9qoW6NekMF4QY1z+DFOm70ryI2VSeeToO42ec5XbAhnn?=
 =?us-ascii?Q?PZPKHkO1AhImRmhLmng4uaMk+eYHR05gcrHxBKQmBGhW53G9tsVVx3TkH+up?=
 =?us-ascii?Q?WIfesruvuuxoD70YloaTc/0i1kCAVhCPMkcQnRIzr2gz5ceKqKSKHl4HbK6X?=
 =?us-ascii?Q?y1Dcx4UdzuzbKW4968n54Qa2Zsil6EUXzq+Rdi3XCOk989LK5WHvW3nkxUP0?=
 =?us-ascii?Q?vTUKyMweg1ye1HUMutO6DH51dw7H6PPg1vfJwU/b40AQ8jhBoVwbxukf7/99?=
 =?us-ascii?Q?HWYPEHdI5j80CyZ3LCn7i13oiNTdj4h/GN0MkEsfEbnctMBrudklF/ql1BYM?=
 =?us-ascii?Q?sG6EE2Of4FYn/NwoGC8OFg7MWbqVSwhnzQPcrD9qOuLaE3ow1q+tyc7xEzn/?=
 =?us-ascii?Q?eGy0MWRdIyeLdDaK5lgZVp6toxit+TzaO4hgbYFcEUzDxmSWAKQ6WNKgfe0E?=
 =?us-ascii?Q?cZQefnD+99lg3BExMTZdAo99Iy+PO2u1uPwvKiLRgsdooAQ8JRzz5hXS/XcC?=
 =?us-ascii?Q?D2+3sa717haiLtt8MQ70sQAzqkZsuKpVj5fD+1v9LB4SHkOgmFoO+T5NxwLA?=
 =?us-ascii?Q?j+A6HXOVIyO/2M3u2/ipv0/6j4OZOVdIvi3Xibs7GcVamajrmwHNi9IDXNwT?=
 =?us-ascii?Q?89oYMSRetOKt4n09hPxZOSWJt84k4epeyL5FirMM3kL75VO4+5kSPY7ACOW8?=
 =?us-ascii?Q?n0GzvZGicrQvMtaoDrO5mOId8TG54UY3Di03BklvYg9krjlqazisfAe+8I/y?=
 =?us-ascii?Q?FUsoHso6Abj9ONYGQ3qMEZJ3B7/MCxaCceQik01LRjR/V9/pYgFV/dm0YiOy?=
 =?us-ascii?Q?dgNNGMS2pMKYtmct+TtTYzGZSishonSnGuMO1D2m/+/iht6JHh6M82M+SlO/?=
 =?us-ascii?Q?Oz6FQV/2pnjhHsM4nsr9dV4EcAspzCkye9yumCDPgiSg1/DKhJa6xM9FD8wA?=
 =?us-ascii?Q?o7iVwc/277MNIgHM3km/NegG7qE/wgEUYcjp0E5Bcqgh+UhUvSXoMSE8FXMs?=
 =?us-ascii?Q?dlmplTB0PaBZbu/AXQRRhCk4BMcoORjcPyUad6F/ATHvdUewkiWrFHgsEIN+?=
 =?us-ascii?Q?ey6xngv7wf6RtmS9ywPSyLJIixi75WBjl7BbKTKO1c5IL4Q7iaavXhyE/gWq?=
 =?us-ascii?Q?+srYZIwKsxpcyZ7QsZPtTj8d0AgXfd63kV2J9MQ7Z36ygXzj6f0slHSGCxI6?=
 =?us-ascii?Q?gDaP/R5ChKIVTAO/Z+aZj7sKbFVIGzFSEQqiK/kz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0f8ee9-3828-4139-5887-08db6c90d0d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 04:35:44.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb1XihqGBJQ+wkF43x9u9//9b7yYGKlI+0UuFB5t6F2XsVw5BFJCS2YnutsQtr9IjUxCvscEP0GMxeCytGJzGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:32:03AM +0200, Peter Zijlstra wrote:
> 
> Still gotta read it properly, however:
> 
> On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
> > Single-socket | 72-core | 6-CCX | AMD Milan Zen3
> > Single-socket | 176-core | 11-CCX | 2-CCX per CCD | AMD Bergamo Zen4c
> 
> Could you please also benchmark on something Intel that has these stupid
> large LLCs ?
> 
> Because the last time I tried something like this, it came apart real
> quick. And AMD has these relatively small 8-core LLCs.

I tested on Intel(R) Xeon(R) Platinum 8358, which has 2 sockets and each
socket has a single LLC with 32 cores/64threads.

When running netperf with nr_thread=128, runtime=60:

"
netserver -4

for i in `seq $nr_threads`; do
	netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l $runtime &
done

wait
"

The lock contention due to the per-LLC swqueue->lock is quite serious:

    83.39%    83.33%  [kernel.vmlinux]  [k] native_queued_spin_lock_slowpath                                  -      -            
            |          
            |--42.86%--__libc_sendto
            |          entry_SYSCALL_64
            |          do_syscall_64
            |          |          
            |           --42.81%--__x64_sys_sendto
            |                     __sys_sendto
            |                     sock_sendmsg
            |                     inet_sendmsg
            |                     udp_sendmsg
            |                     udp_send_skb
            |                     ip_send_skb
            |                     ip_output
            |                     ip_finish_output
            |                     __ip_finish_output
            |                     ip_finish_output2
            |                     __dev_queue_xmit
            |                     __local_bh_enable_ip
            |                     do_softirq.part.0
            |                     __do_softirq
            |                     |          
            |                      --42.81%--net_rx_action
            |                                __napi_poll
            |                                process_backlog
            |                                __netif_receive_skb
            |                                __netif_receive_skb_one_core
            |                                ip_rcv
            |                                ip_local_deliver
            |                                ip_local_deliver_finish
            |                                ip_protocol_deliver_rcu
            |                                udp_rcv
            |                                __udp4_lib_rcv
            |                                udp_unicast_rcv_skb
            |                                udp_queue_rcv_skb
            |                                udp_queue_rcv_one_skb
            |                                __udp_enqueue_schedule_skb
            |                                sock_def_readable
            |                                __wake_up_sync_key
            |                                __wake_up_common_lock
            |                                |          
            |                                 --42.81%--__wake_up_common
            |                                           receiver_wake_function
            |                                           autoremove_wake_function
            |                                           default_wake_function
            |                                           try_to_wake_up
            |                                           ttwu_do_activate
            |                                           enqueue_task
            |                                           enqueue_task_fair
            |                                           _raw_spin_lock_irqsave
            |                                           |          
            |                                            --42.81%--native_queued_spin_lock_slowpath
            |          
            |--20.39%--0
            |          __libc_recvfrom
            |          entry_SYSCALL_64
            |          do_syscall_64
            |          __x64_sys_recvfrom
            |          __sys_recvfrom
            |          sock_recvmsg
            |          inet_recvmsg
            |          udp_recvmsg
            |          __skb_recv_udp
            |          __skb_wait_for_more_packets
            |          schedule_timeout
            |          schedule
            |          __schedule
            |          pick_next_task_fair
            |          |          
            |           --20.39%--swqueue_remove_task
            |                     _raw_spin_lock_irqsave
            |                     |          
            |                      --20.39%--native_queued_spin_lock_slowpath
            |          
             --20.07%--__libc_recvfrom
                       entry_SYSCALL_64
                       do_syscall_64
                       __x64_sys_recvfrom
                       __sys_recvfrom
                       sock_recvmsg
                       inet_recvmsg
                       udp_recvmsg
                       __skb_recv_udp
                       __skb_wait_for_more_packets
                       schedule_timeout
                       schedule
                       __schedule
                       |          
                        --20.06%--pick_next_task_fair
                                  swqueue_remove_task
                                  _raw_spin_lock_irqsave
                                  |          
                                   --20.06%--native_queued_spin_lock_slowpath

I suppose that is because there are too many CPUs in a single LLC on
this machine and when all these CPUs try to queue/pull tasks in this
per-LLC shared wakequeue, it just doesn't scale well.
