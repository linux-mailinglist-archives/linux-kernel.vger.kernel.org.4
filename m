Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4146A183D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBXIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBXIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:47:11 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703156531B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brHUyYZksJTriXQImEagUXQNCnOBB/4VOZ0tXv7OesD1TjYErwHnj9V8gdtj3pn2cOsP8D4D6L8dgQ/wGyttztDeElEypDuDmYmXgITJxvG6k7IxIMc/1YKEEtDTUe7eNXv+ad+03ywJexRWm+cU2A6tEXiRdA7iheU74BA4boYz9wDMP061XZ6m1l5sLZQOp7HGCHA+/LbeWxj6K1b11eomYMcaGEWbsgWPdDAntHIeeFmO0uGVftvYvl2DmuHT2wXJqWKQ4SGWQlhgk5Hgjlr7KCXLwn3quT2y7pTJ2wGAWKUy0EUznFS3gzGvMzSf1LxM6jUWPTjtqUUyAqPzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SrBd+TZpkaJ2Rc+1jCMCyTN0V+G5eOaZOuYzlNUA70=;
 b=LG0yH+L7SWdIM0D/b4QidFKSKlg6ed1vpM9fpaSpy1GuRRVTiFL2OKj0trE2JcRatkS7ga++zfvtjgd7r+739+EcUEOHWurZywOmbnj1HN49tj0oFNC0Gvt2NzHH6DCPSJK+1VMNWX3NliTMuJdvCGaiVUw9WFT5QfKJF0sGvmVHXuTnxEUFwjtRw1qGp4rk/gan/oQD/f7tMQFGuwjmLMtQNQuVgQynzpl4Ikk1HfqTa9ExrDYuVqJ4f/s5uNewLTBwXD6M+Ynz4+xzPKdZxR7LcdBS+petj7HVgvhv96PnOa/r94G/UUGQbgzB5Sfl2i+sPABz2dM7BUy0Nk66hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SrBd+TZpkaJ2Rc+1jCMCyTN0V+G5eOaZOuYzlNUA70=;
 b=GwZGn1dySZ/BOYdAa1AT746JLYJ1eE+JJql3Os+TmNpHOz+YfJj4Juzywg7ZkQ0thTpMJ5YDQ5xWpoAdVuX3aNa6r+k8fADg4O519iz2M1IGj5cinsESbirfK35/gkVPvHLOJT6rApqFc214o1dPwaljU4Y8MuXrI98ApyDNxW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by DB4PR03MB8658.eurprd03.prod.outlook.com (2603:10a6:10:386::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 08:46:53 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::6852:2e66:e605:86bc]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::6852:2e66:e605:86bc%6]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 08:46:53 +0000
Date:   Fri, 24 Feb 2023 09:46:48 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
Message-ID: <20230224094648.69cfa411@luca64>
In-Reply-To: <20230222220034.02c38eb3@nowhere>
References: <20230120150246.20797-1-wander@redhat.com>
        <20230120150246.20797-2-wander@redhat.com>
        <20230123163002.GB6268@redhat.com>
        <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
        <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
        <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
        <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
        <20230217200437.551ad7c2@nowhere>
        <20230222184237.hkfznxm3ts3gye2i@fedora>
        <20230222220034.02c38eb3@nowhere>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::25) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|DB4PR03MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 670df9ad-1887-4e0a-493a-08db1643ad3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb8PiGiJopy3a6I9Itu4y2WkE+1D/s9waPhH6Z4OA3w7kpgcm5D0F8+hPy8pW1CeLUf4mV4WsW/GJbHUMs/+XQ+i8eeJXt4RVg0Mwu0XOHz2CemW7x6UDHhAOLPAyVeJO7HLvF1YBZjch9O0fZzUTMSlCSQVIli5ElVYNMDU1EhgBFzEsYlJKwGDDymt0wc3yccvEgTJXXry7uf0gXRl3cicdpSt+AyV4mPTrWLTGXn38V0nfHq3mUrkLO0sP4+sPHijEb/CvNzOQkPXUcwQDMgkOn/ipqHL8l6jgi4vQp3U+Mie8nabCbLGB7EHlC6KAgQukRi8/3AnzxnFFCdU1yyWsvHH4/9YrNy00RZDHEnYaI895ADRmMimATTUmFukPYtaYRKUUGXl5G7N603Cotub05ZksUXakLhMPB12yzo2TANZ2iO5qRnbOqiRtjfGYjA8zFude5M2YZTDtYSRBOjlvwdfERMcFgHL3800F3mxWtQCgZKb8KpStS/8w2/zthTMK3Rit34xyeOpFToblAaiDXc/O/dwFKfaUAD9WxlGFX375l119M/ehdaWcyEVNjIanWzDuj3eDJItzf96H/vSIvxOdiREapxZIISjUAQSzvMT6LSogro8hg6fEUfIK9rXLzrEh5/YJUjTtiZyrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(376002)(366004)(346002)(136003)(39850400004)(451199018)(33716001)(86362001)(2906002)(7416002)(38100700002)(6486002)(36916002)(9686003)(26005)(186003)(41320700001)(66476007)(66556008)(66946007)(54906003)(83380400001)(41300700001)(4326008)(786003)(6666004)(6916009)(6506007)(6512007)(1076003)(8936002)(316002)(478600001)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xj5L/0x2z5yU1absSU7KU44nfuMdf9BLuPHZOf8pAs2PlG3tyvEMrTXqYGDG?=
 =?us-ascii?Q?/rR1aAT2sMSsE5pgG5dxgRv6g/gn/uWtrm4fAu8YyHUx0Vti3DrQv8/Bvxii?=
 =?us-ascii?Q?nuynBxM2Q0Ii5a4YEoD+bJ5Y6ryiD86jTbS6aCaQoNDgsSFIs3zDP46z5nhk?=
 =?us-ascii?Q?FHQMtta5v7VNThvh5lZeb4+oQvUjLNDwDj1pk86P2y6chLydG1B5lFypMW1P?=
 =?us-ascii?Q?wBQi6w8EWm1m3xApJ1KVT4R1Ucaqq3gz99bR4Rr2yYMkZ7vKyjsPDJm0bnqp?=
 =?us-ascii?Q?8eH6qAkpQyNJj5hU8CKMP9dWw/LKmBKf+ZvP64LlrE+QCeKInCUz1imAW6Vj?=
 =?us-ascii?Q?nVwg20eyMYPdvPrNrJBVDFyzHFLPRXQhcRdfCtzy2n0lcbFE5b668KhGhxQI?=
 =?us-ascii?Q?fXUUzE3HEFGx/OZqGdpwPeZmW5wl/MBFhe01ME/ZRi3ilTBwleGYB4wg+iY9?=
 =?us-ascii?Q?F0c0emmUBJ3OYD9p5sjolYsQ2tl92HJ/HIW125S3eZlO9ulOC78YL68xrL9W?=
 =?us-ascii?Q?kFSe507VhlW/eArJG0KVfv9PRHXDPnCErzG+9cCfBbMfOBjTej3rCOHZLnJE?=
 =?us-ascii?Q?ibeu3saKiG38iobfHwHt5ycjcVUPcgWZVkN+QpYYePtb4Rw3toGQc3wTBvUB?=
 =?us-ascii?Q?hcjPdHIz+l7f7vox/fZNbHRlArE+fyur/26ajF7KqdzNv90aDP33mUotgelM?=
 =?us-ascii?Q?aACA/anmL/Eb5YF9038z30E2GYkuf71rc/e2TLqd8J/hg9zp5HPy9COXvU0V?=
 =?us-ascii?Q?b87TY0fjxerxHP8LT9pGK6qlXG6p3F4wih6HmC1k4xo41VRugspoMplAk1WC?=
 =?us-ascii?Q?0fM7Q6Kbcyvxv/HryrUnGLgUlt4tbWkPliLQe1PmCpN3mREbunvke8p0DPQQ?=
 =?us-ascii?Q?KQYZ8HxclJvkJD9gzdy6ZY5V8uXA3hJsTTbt8pZq/GpwVkwBBzkIAYhNxRjB?=
 =?us-ascii?Q?2IbSheCX9kYtaigidsBziR7CIEgZ5CCW6buNyMMkE7qbbMpQvjhVAhG++KkB?=
 =?us-ascii?Q?Mp63xK8iQagxPoPtKXaZpSQPy3b7SboNaSASeKI1LNHUR2VWOqMRoUl9Slzo?=
 =?us-ascii?Q?BgyggN9atcxLgfoqxIaDJ6XyHAw2KWoqD810wYutIGKLryIO3QfrXI18+DMN?=
 =?us-ascii?Q?IFF7+P7NDoM2kHHViy4Fse6lBwC1D+vRLGo6G815JQvPm4xV1p1jqnWN1xIS?=
 =?us-ascii?Q?8swptfapKRNmdhcd2g9072+xA7d7vrrPDZIuuK1of2baxB+iESfE9C1g3XE9?=
 =?us-ascii?Q?p+krjbso1LSYAivZceHG9fyj9+LdeSwFnqVHqFfCQRWGhXfYWbWf7iRA7IHv?=
 =?us-ascii?Q?QKS0F6oEa8klg9TKZA8Cy1kbp7RIlBNJV7OPLkPdU3++oy3rp3d+ygOqEJ+X?=
 =?us-ascii?Q?6qcJQ5Vj7uuhwZi9+ro3TC7kOQ6dTUby/8ttb2fxF/jFZ9VC/QhhCpWqnKbB?=
 =?us-ascii?Q?az01MpF+iUahip+H4q2gCla7epegBscNjHIVBd78UE08RkpDl8WOAf5uQwFO?=
 =?us-ascii?Q?uYte/YwlezYht8g6XiOxTrlnF8eFlfcf78HN4qDmhxI1j4u3o/kaz3iIBHL1?=
 =?us-ascii?Q?VX/UWq90+8EtUO5S+oUkXo3h9tJaP43lnpRt0+XjAIUkSAe593L6ZO3Ign6K?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 670df9ad-1887-4e0a-493a-08db1643ad3c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:46:53.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LUy+9y3nTJZ3v1eMMagzuUPkvy1Vs3OLJb4pOgjhbm1SO0vPWbOqZTdHDLV0bA5XQx5+iybLi5qAmV7ZL15p84jawLZcg/rKsLK/4rdQ3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 22:00:34 +0100
luca abeni <luca.abeni@santannapisa.it> wrote:

> On Wed, 22 Feb 2023 15:42:37 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
> [...]
> > > I triggered this "BUG: Invalid wait context" with a 5.15.76
> > > kernel, without PREEMPT_RT. I can reproduce it easily on a
> > > KVM-based VM; if more information or tests are needed, let me
> > > know. 
> > 
> > Does it happen in linux-6.1 or linux-6.2?  
> 
> I only tried with 5.15.76... I am going to test 6.2 and I'll let you
> know ASAP.

For various reasons it took more time than expected, but I managed to
reproduce the bug with 6.2... Here are the relevant kernel messages:

[ 1246.556100] =============================
[ 1246.559104] [ BUG: Invalid wait context ]
[ 1246.562270] 6.2.0 #4 Not tainted
[ 1246.564854] -----------------------------
[ 1246.567260] swapper/3/0 is trying to lock:
[ 1246.568665] ffff8c2c7ebb2c10 (&c->lock){..-.}-{3:3}, at: put_cpu_partial+0x24/0x1c0
[ 1246.571325] other info that might help us debug this:
[ 1246.573045] context-{2:2}
[ 1246.574166] no locks held by swapper/3/0.
[ 1246.575434] stack backtrace:
[ 1246.576207] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.2.0 #4
[ 1246.578184] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 1246.580815] Call Trace:
[ 1246.581723]  <IRQ>
[ 1246.582570]  dump_stack_lvl+0x49/0x61
[ 1246.583860]  __lock_acquire.cold+0xc8/0x31c
[ 1246.584923]  ? __lock_acquire+0x3be/0x1df0
[ 1246.585915]  lock_acquire+0xce/0x2f0
[ 1246.586819]  ? put_cpu_partial+0x24/0x1c0
[ 1246.588177]  ? lock_is_held_type+0xdb/0x130
[ 1246.589519]  put_cpu_partial+0x5b/0x1c0
[ 1246.590996]  ? put_cpu_partial+0x24/0x1c0
[ 1246.592212]  inactive_task_timer+0x263/0x4c0
[ 1246.593509]  ? __pfx_inactive_task_timer+0x10/0x10
[ 1246.594953]  __hrtimer_run_queues+0x1bf/0x470
[ 1246.596297]  hrtimer_interrupt+0x117/0x250
[ 1246.597528]  __sysvec_apic_timer_interrupt+0x99/0x270
[ 1246.599015]  sysvec_apic_timer_interrupt+0x8d/0xc0
[ 1246.600416]  </IRQ>
[ 1246.601170]  <TASK>
[ 1246.601918]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1246.603377] RIP: 0010:default_idle+0xf/0x20
[ 1246.604640] Code: f6 5d 41 5c e9 72 4a 6e ff cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 03 52 2a 00 fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[ 1246.609718] RSP: 0018:ffffa1a2c009bed0 EFLAGS: 00000202
[ 1246.611259] RAX: ffffffffa4961a60 RBX: ffff8c2c4126b000 RCX: 0000000000000000
[ 1246.613230] RDX: 0000000000000000 RSI: ffffffffa510271b RDI: ffffffffa50d5b15
[ 1246.615266] RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000001
[ 1246.617275] R10: 0000000000000000 R11: ffff8c2c4126b000 R12: ffff8c2c4126b000
[ 1246.619318] R13: ffff8c2c4126b000 R14: 0000000000000000 R15: 0000000000000000
[ 1246.621293]  ? __pfx_default_idle+0x10/0x10
[ 1246.622581]  default_idle_call+0x71/0x220
[ 1246.623790]  do_idle+0x210/0x290
[ 1246.624827]  cpu_startup_entry+0x18/0x20
[ 1246.626016]  start_secondary+0xf1/0x100
[ 1246.627200]  secondary_startup_64_no_verify+0xe0/0xeb
[ 1246.628707]  </TASK>


Let me know if you need more information, or
I should run other tests/experiments.


				Luca
