Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9817310C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbjFOHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbjFOHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:32:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEA2689
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686814341; x=1718350341;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WdW/pBPaRkrcHZ1EtIv00hxZxPQ0P8grnO2nJ5Su7gw=;
  b=b/c+ReSkRCIL5fMuQ/nvc2Ry/SuSKf0wd672QKzW/U9C6GNSw1ojspEh
   Z+1MMEm8ZnC3TZG+DbX4pns1VXuVtApx+ZmcPzr3X66rcqnI0gz0z9/dc
   tUlO0i8j/kwoZXQund3AV8YqHlrIIk2kP0k+IHw9C2rnDncLIpYZfZL2N
   hPRFJ7pqwxLSiw+64N39dV7PoYP0lpdtQJQCKtUSDp2KAzO5H5+7pr1SF
   0T3sfCA1Fvr/zSlCDv7CPnFCuTqquZfy9Uk/2GKfHmNY33FZAgKwui/E9
   DWFNntntu7JxIrpusQpxcSD9TpMXmBHGKME81PglrAPAMsrwG4uRWUmuk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="387269030"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="387269030"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 00:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802238214"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802238214"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 00:32:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 00:32:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 00:32:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 00:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byXvaMH9ZQNcvzorRx3aprJdJW82bwz43xNt5Wbvs79o4AF3CYYhvB0nOfjtBpUEXtx+kuHEPQ2qC8mdNq+QH6nWPL0FWKSvMOj3BlBLpl26855GKrCgwxqCcSQMfNNhpGH0zd4r2Oo9UmCrsDcPmzk6D8Oqj+H1aJ76Y9bvBif10WaMDNUQHZb5dfHjfMRYbaDWKs8znxM2hrMIWWa0TKyYTpdSAASe3bP61mBObW0dL04Gy+SPiGwP1pTLwaYr16yqES5lSJPFNwKKrUQQoV+O/EdbeZoWiTen3eeUwqos/FBOYZLgpFhx7Is83TUlT3Cp53St8to+VzQD4sQs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOdEUmhQMbwZvloW8rQBaE03dQoZqy62b3KReyCcFQU=;
 b=XVmz3JLWYpU49mAznPW9NjOfUtWRJWUruIux2Vom5XpTz2SGf1Nbzn77NldAiogmn2HOykABMYD1Zb1gj+HMjsw7UNxIL4c18yAZMEsB6gn7+ortkHmUMQqbfR2N0W1iVRzGOif3MzhtIA5wpEaU43Cv/6ySMfabGVpSbyM95nkCSP8ZX1/TOqFiXEE9omi9iphe1fIghrBMcuV08ixcd0zYLhEl31rP2MwunUHXU61M+ywKcqfh+mGqmmYQJCQv/l8wOiPwP7VcTO72xYb/Ya0xR6WD7WT5ce8N6BkwB6kV8OT0k48VtM5RWVC+XfDASoFijcm71JRAn6tR6ufLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 15 Jun
 2023 07:32:13 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 07:32:06 +0000
Date:   Thu, 15 Jun 2023 15:31:53 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joshdon@google.com>,
        <roman.gushchin@linux.dev>, <tj@kernel.org>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230615073153.GA110814@ziqianlu-dell>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230615044917.GA109334@ziqianlu-dell>
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MN6PR11MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d738f29-0f2e-4989-695c-08db6d729e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6irNQlZ6ETLptRkd4s1fzLfTD3u3KmFgXPBp0CMxq6p60XXvrBWx6hyOZFS/ca6sC1n8SWHVoelK72upkrOT8f5Z5Nu4YX8QXxHSw1lqRwVJw9AJxyzh8ZAUVtFJhV9u8j8dKQHGdibwrimuJb56+LpHMoxpyFrVUmkbF3YlwVQ4VOFLyyrybmZdTcVUBVmRzYqVpragyqBtB9DAmd5ShWP7F2n4EIoVBXfAHHZ11Dl11FnX5FqXHFI8V2dImh0DstO2z41TqcazWnpPU4wpV38Drmr4f3mEsl6uCwyY4/WRZNr4smcHB6mR85a1ZxHcVgQ4kUMgQRfwoiSAIZzjll7ZAAjjncQgebM3vOa43UO16YPOjVY1k8Yc9RfsPvhfLq7RQPtNG0Df2+rjK0hEa4FH1c2m3V9Dsrb5LzEEnrynCfnNQXKGOryV/JwarqJKLfx/ce9yQmiSuZDSwoqcnyx2MOO9EzJ8zFe2scwrSzXPmlH312hgZHNBiGsQLfO4WKPVX+NuwcFhfeSZw3urWIMlPGYzSyqs3A7A9h0dbJAgTNmxn++/3kLkvJK48iT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(33716001)(26005)(186003)(6512007)(5660300002)(9686003)(6506007)(41300700001)(33656002)(1076003)(478600001)(7416002)(44832011)(86362001)(83380400001)(6666004)(4326008)(8936002)(66946007)(2906002)(66476007)(66556008)(8676002)(316002)(6486002)(82960400001)(6916009)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nX5DIv5ZM+fieyq6OM8/7T/uvln75RGxH1qY4/eGG2+qeaQ6o8ytx38Zkq2o?=
 =?us-ascii?Q?qUV/mZhQsyuvR4ERHjjBIhCuGcm/IrZOuqnlyjoAbieiFJxmD7ch8mjMmorE?=
 =?us-ascii?Q?Nu7+lzjIlr7ao60T3EjHVe4W8eS9hQsTC3nf+CKIIfd4J8YbQF0gUrC5NHtM?=
 =?us-ascii?Q?ShEGJvJ3XREr9hX1e9y3xQo0XxnmH8RrCK9A1XKGyzdwe3mjwUwEU7wsnMLR?=
 =?us-ascii?Q?eETdqlc9mCsa6s8wHaH3BdJym3dPRfEscPN1MZ6GP9teButbTUYwDnaDTVEB?=
 =?us-ascii?Q?E02fpPGtmvJerdA0DWR2oRmHO954Up1wp0wVvrfqWI2b2BHmiDncsN/NHHib?=
 =?us-ascii?Q?OgNXgcXZaGI/+dW5tcKDLLxQhtEznIjE3G6D1izk4j1hkTF4CxBi4wtv/7+x?=
 =?us-ascii?Q?JCcQdegByzyBZJyVOVjmdMlD4tvASa0GlrgOZiPEZM/KS2afyxtaBEMXptT/?=
 =?us-ascii?Q?JHyd92Rr1sMDLmezbwP0BtWNPM5PV4o98NYEot8Imuq5FOVKK5NzKNH2Salj?=
 =?us-ascii?Q?27bWqv/WzdHxFQYsdv1dBU35nCUDYUjEMm6+YvAxCOYTyge4feeTEAe07WDO?=
 =?us-ascii?Q?MBmhV5xCyRtanGoe/bBcQ8YbiljooFBb3MKcAlWG1rPyVdJBsUe98kHeAD/4?=
 =?us-ascii?Q?+dTRXEYUO7+7M45DNOqnPbFnLpnaGmf0fLKMBiSSTprgh9VfTMgbneaeOQoP?=
 =?us-ascii?Q?/6DDjeAnWNncEy2P0coewK9VlsyztxRvdWJUTp32BHGOBi8wTozLXUVOk52G?=
 =?us-ascii?Q?CXeHNKth38nYbdYNQbKTktnSAB/2mnHflumhQaBeoVhrNN5yXU2YFClt/O0R?=
 =?us-ascii?Q?0eSJKQ1OV9fsbiI7yXc1VfkJz5tg0qv2d3GGfqwB6N20vPKnziK7wCN7wEvh?=
 =?us-ascii?Q?XVGOX9y//f+6rGfbVt8cNF97zXSns3INqePFAFT3Wb+Db2D9xGvl5ccHnm78?=
 =?us-ascii?Q?wSSl0KO0Sl2099Ia0vGBufed3sLOvZ75cpqxwTsjjJhRH1TKzrr0BFTSqnBe?=
 =?us-ascii?Q?Ued5SymmzZepxPqeKB5BAAFvLyZ/9I4AoZD3NtkWZG/vABSxX8yvG+asuO/j?=
 =?us-ascii?Q?oD69r7AGKnwQm3hlF5WkBRawr3boNl4w+zHLEpWuk+WpnHziWe8S3Jrvc4mM?=
 =?us-ascii?Q?tzGL48uARumDStk6rix6N5toqxQLfRXE1RoTzSIpz0mlU/LYG1PhXBH7HmUe?=
 =?us-ascii?Q?KY4SYABfR/VwwftOrjxGnnfKKUXzk1G7BuDWefUES0aq/rgTXDtw95HLRv9P?=
 =?us-ascii?Q?p/lg4KOJwvm1XnGJeqoSrNYktFiw/vk+QG//W7VgyH8T0W0vrKcJaqGJIMnW?=
 =?us-ascii?Q?4rKFL9D1SbWPeg/frUNu1s+un0SCxap1ByjWBNx+P1ML1HxOeUqv/gLNqfE9?=
 =?us-ascii?Q?BJ9ie0eTtPPw21pYy5o2f4DCRq/scmg/26jlj1s67xyZUpBwO76lkbMPte0B?=
 =?us-ascii?Q?PFOOR2aIuuNKvbz6EiUvNnUXN3pbACrdv96z7yUcP0bpZyW0Z4NIw/fPWJwy?=
 =?us-ascii?Q?nSft9q2M9BRgF0u5VRHMlvzeoppgnC0GqWAM5DOo5PcNM5fMKbz1hQBoBcie?=
 =?us-ascii?Q?MOf+ZNv0te/Ys5YEPak2/ycH84x1U4lJOHGdAJv/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d738f29-0f2e-4989-695c-08db6d729e91
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 07:32:05.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIXbTPtXlzOsFUurEttCGcwAw7SpEtIEM3XvyKSQyCKfx1mw58/vchWP/nzqNYDJYgwq+O6hAMTi+Trb1tO/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:49:17PM +0800, Aaron Lu wrote:
> I'll see if I can find a smaller machine and give it a run there too.

Found a Skylake with 18cores/36threads on each socket/LLC and with
netperf, the contention is still serious.

"
$ netserver
$ sudo sh -c "echo SWQUEUE > /sys/kernel/debug/sched/features"
$ for i in `seq 72`; do netperf -l 60 -n 72 -6 -t UDP_RR & done
"

        53.61%    53.61%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath            -      -            
            |          
            |--27.93%--sendto
            |          entry_SYSCALL_64
            |          do_syscall_64
            |          |          
            |           --27.93%--__x64_sys_sendto
            |                     __sys_sendto
            |                     sock_sendmsg
            |                     inet6_sendmsg
            |                     udpv6_sendmsg
            |                     udp_v6_send_skb
            |                     ip6_send_skb
            |                     ip6_local_out
            |                     ip6_output
            |                     ip6_finish_output
            |                     ip6_finish_output2
            |                     __dev_queue_xmit
            |                     __local_bh_enable_ip
            |                     do_softirq.part.0
            |                     __do_softirq
            |                     net_rx_action
            |                     __napi_poll
            |                     process_backlog
            |                     __netif_receive_skb
            |                     __netif_receive_skb_one_core
            |                     ipv6_rcv
            |                     ip6_input
            |                     ip6_input_finish
            |                     ip6_protocol_deliver_rcu
            |                     udpv6_rcv
            |                     __udp6_lib_rcv
            |                     udp6_unicast_rcv_skb
            |                     udpv6_queue_rcv_skb
            |                     udpv6_queue_rcv_one_skb
            |                     __udp_enqueue_schedule_skb
            |                     sock_def_readable
            |                     __wake_up_sync_key
            |                     __wake_up_common_lock
            |                     |          
            |                      --27.85%--__wake_up_common
            |                                receiver_wake_function
            |                                autoremove_wake_function
            |                                default_wake_function
            |                                try_to_wake_up
            |                                |          
            |                                 --27.85%--ttwu_do_activate
            |                                           enqueue_task
            |                                           enqueue_task_fair
            |                                           |          
            |                                            --27.85%--_raw_spin_lock_irqsave
            |                                                      |          
            |                                                       --27.85%--native_queued_spin_lock_slowpath
            |          
             --25.67%--recvfrom
                       entry_SYSCALL_64
                       do_syscall_64
                       __x64_sys_recvfrom
                       __sys_recvfrom
                       sock_recvmsg
                       inet6_recvmsg
                       udpv6_recvmsg
                       __skb_recv_udp
                       |          
                        --25.67%--__skb_wait_for_more_packets
                                  schedule_timeout
                                  schedule
                                  __schedule
                                  |          
                                   --25.66%--pick_next_task_fair
                                             |          
                                              --25.65%--swqueue_remove_task
                                                        |          
                                                         --25.65%--_raw_spin_lock_irqsave
                                                                   |          
                                                                    --25.65%--native_queued_spin_lock_slowpath

I didn't aggregate the throughput(Trans. Rate per sec) from all these
clients, but a glimpse from the result showed that the throughput of
each client dropped from 4xxxx(NO_SWQUEUE) to 2xxxx(SWQUEUE).

Thanks,
Aaron
