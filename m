Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A969B2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBQTEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:04:50 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C262429
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:04:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlP3yHg4oI72MZZd14R9vjlfElVpZGYQMvqYSPl1Jhklml+ZlLY66rKPCP7w56ZM/6F9U6v8YLHdNGlYm8bYMgx5q7oRyRdRKknnzHhA8Rl/AfDDVZE0Mmc7p1mucWvMRVYicg5C//YecRqfPttYkAgU1GBLPSC6gpEoMBE6NQZELejplFganSp0DO0FvnKr4jLt31v4KiCIi77vfAqeMZ62u1lKzqh1NHPprzw5ARK2SgKmlGfPJpFPf1BoztF+o4aCkmNoeHf411DSdcYiYrYqR9azxk+p2G5QwPkXHlJZ0+/JbN49iNUCYpY0e8xXI//Brck+jaUBRtmDNyG4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewzoDRoXrhR53tI3aii96RKFuUA570j/lk8YN7WktZU=;
 b=de4xJlMz8r4KKG3Yqk7FfA+D0Lcn7r4ZRv9dsAaJvLxA+9JZ9yK/jBq2l4/y2e+Ld3sT8jSo23EykrhYC9iS6ktMv6oDm6lIIFaY0qTrSjsMRgt4SmamyOUm7GCLFVIchimNCA8ztmdNqgyNAmwCywV4v7NR97sWpFzFhVNprMeqo7utYa1mSDOkFJ3ygaLj+NgEIv5ml1GMs5AlF1NVUm8OExJcegfW6oT1dFaXT0xy6wXML7EHvUX/nxpYFHhDYxtnP/FqdgdC3nHGfZV8ISLtLxpgwgI8wrj/lQPGylbt3s1mdLYAtRHRBP9z748zF0Fy7QEXeg0pNZrBRB2LdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewzoDRoXrhR53tI3aii96RKFuUA570j/lk8YN7WktZU=;
 b=gKD9SrdiAYtxlcyDDGO4XAjYVv6iRq6xncRFo8QAiLRxR7dmWFFhKktifSIb2Gm0zvLB40lLlz/xFP299megKosdh/kePrAuJ5jqVkA1oWCk0bhGWh7Cu07zaci534NJeUqTMfb17PVBOR+ngsleCJXAnQfEh0ZGDTv7M4rA9vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from AM5PR03MB2867.eurprd03.prod.outlook.com (2603:10a6:206:1a::31)
 by PR3PR03MB6633.eurprd03.prod.outlook.com (2603:10a6:102:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 19:04:43 +0000
Received: from AM5PR03MB2867.eurprd03.prod.outlook.com
 ([fe80::d865:4460:940:2ca5]) by AM5PR03MB2867.eurprd03.prod.outlook.com
 ([fe80::d865:4460:940:2ca5%3]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 19:04:43 +0000
Date:   Fri, 17 Feb 2023 20:04:37 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
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
Message-ID: <20230217200437.551ad7c2@nowhere>
In-Reply-To: <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
        <20230120150246.20797-2-wander@redhat.com>
        <20230123163002.GB6268@redhat.com>
        <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
        <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
        <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
        <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::16) To AM5PR03MB2867.eurprd03.prod.outlook.com
 (2603:10a6:206:1a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR03MB2867:EE_|PR3PR03MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 0313ba81-10bb-4458-03c5-08db1119d42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gzxuBpflFrdUhpI6955RGgyOcUu809ol+OeAwCzPR52QHIWUP8J23PLcun7SGo+zG+nbydsMCHBuMNTCNM7dBJJtnXZYzbH6ZSRi3F0oqih01aovN7C2I3LtQqOPlpTqfASV4KpnFZBQaYlhbeoNS4rmignUje2P0z6gR+ctXrBc2uPhWsJbmPcq8n7L1b3JgGUUl8RDiJvb3Qx+GELN3srbKXebR5Dg1/yzqe1Dq/06h24qW+qwq74r+20IUqUIdyZEv95CQ+fJ2BLseZ1SGE/tmFWS4WV7hClVIw/XMjhFSiBPZD4Iux9Df5CfLzKGJVvW+rwbQdookjMRL8aYNZjY0LftmF3ivZYY/UhL4lXxqsImHu3sAXIELjmU2lp/eipj/OskR2V61vkoIfD/io1aByJXYZE0ixjL7xVtdB2Ts69Qfx7nwBo2mQuJfDT7CZHHoMguaD9uEscYu9KOGtj1YuN2kCTEqzdGnuWPt1zfOJA8YScZ3ekx8dIEWS9vufi5YIjf/YLjLszyx3g5mGQtSuv02MohT8tfWQgiOcziYs7vSrRS79TC76wyyFi3k7UF5WEsG2KZNkgQqOEv95ysPlfGnPowXaTJ/WNkVDWDAl3djA4qd56uCs+ah7ZmUZgzpyCOzlVU0skEGJNUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR03MB2867.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(136003)(346002)(366004)(39850400004)(376002)(451199018)(5660300002)(54906003)(316002)(786003)(6512007)(6506007)(7416002)(4744005)(8936002)(86362001)(33716001)(41300700001)(6666004)(66476007)(41320700001)(66556008)(478600001)(66946007)(36916002)(8676002)(4326008)(6916009)(6486002)(38100700002)(53546011)(9686003)(1076003)(26005)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kpj0u41yQ5eY+210C3lWk+6+G+GY5cfQiQbV+0lBdP/qXiL38q5ogGaRXEvS?=
 =?us-ascii?Q?q7ARDw84q8J16WSD5mUG5IhIuoctpqLGhokt5oSsPRWlruhhdob9YJZOkAjy?=
 =?us-ascii?Q?A0UxcVBwHpmdKbqse1pGyeJYgt+LWVi6Xyoq/AkzBs/ni3p7htoiflp2kc5l?=
 =?us-ascii?Q?eS6TVCg+0BCo1x8uBM40T5Q+r+bCyL7YTRXMLb60sc2M6M1Dn46c2Tntl6yU?=
 =?us-ascii?Q?1vEPW97xADv41nz1mfX6zTW9qOvxwivJAm4Dsl3JbSwJP7s7enqiFMT3c0IS?=
 =?us-ascii?Q?c3wwfYFQYpiCFOmuQwVlk9ReUVmVtKRFbgH8NlaStTuAf/vNjVha0oAdWy4G?=
 =?us-ascii?Q?e/51pvBqhvc2dhf3OJNS7KIml4wPIKbW0SiqMTzrtH89MHaONaRPDw7bZ/Ib?=
 =?us-ascii?Q?5VvfZegGsnRO+3Uh/DS474RXAO+D78gNRvUJqpDWHo2rxSw0VWCSVB6tZRED?=
 =?us-ascii?Q?qiZFULPBbPnxwWY9zlwki808+Sb6P2/xkQatraHLxNOQ4/oOG0E35vOiyAXv?=
 =?us-ascii?Q?c4w+WzuM/URdLmgzCfSNzkJUP88fZqz2ZADVG1YXUT0Sr7lZRl84lGj74ZHi?=
 =?us-ascii?Q?KVCdrrF3h05zKqcmLrD/MzgP6rrXejdNxLBziqcbO8EI5zO3DGw8ILzTIVCb?=
 =?us-ascii?Q?90Z9PUM5i1o7DBGDgCe++GlRnXyT+kdrnU70VGjPmgOgGEV4CxFynQDmybbU?=
 =?us-ascii?Q?m/weEoBSVH7SJFmH/gwXkmQ3X96BPJHw6/YKz+wZoWs8wxyT4jk1WWrjFPPY?=
 =?us-ascii?Q?PWuyOrR+NeIp59OsyVSTY5Q6LaKX+xtlkLYpXdBfIdGDyRn6pY/ItDQ3Cs1U?=
 =?us-ascii?Q?w/8x0ahB8V3jlXL3PqyUlyV0LutjZBzAfXZHMxLylSZWCyx4O1PnVW2E3qOE?=
 =?us-ascii?Q?NA/RVjj1ewNgmJG9DchCIeh+x8UhIVeQ4GUOatzi0/03r3TuQ/dJFiAqNitO?=
 =?us-ascii?Q?FcZjZW3pwNLKF4BgrMvLD4jIIL1rmM14Au00CnaG0yXv/tTg2rfQWuBdv4y8?=
 =?us-ascii?Q?J/W0Lbbb1nE1I1LAj6+8JnGL38ZjU+2Mnk9iyBbaJ9x+GrmyQKvV4f+xc+qV?=
 =?us-ascii?Q?+3UxfCHiZOFYecUzb6VW7ofi//pend4Dpcy57BcQj2IwFLaW+SSlFsXIPMRk?=
 =?us-ascii?Q?DqRn68HMhri0/hskfmt4R1o+9ijalI4ZxNqOX4oSX2DOOcoRjRq8EEqiMMBp?=
 =?us-ascii?Q?FsR+Ta8X2lnz3EkkbQlLedsf8FoX8cYNwzYqC0joQj2OD7vpoJ7AXJqj2C/v?=
 =?us-ascii?Q?dveDWRLyzSGsLUCoL8su8tEJfGN3OWuXqpCfEo5/J5kEcM7KYda5U0UY4cdV?=
 =?us-ascii?Q?ntD9Gevx7YEzbhTj9tRhP6C5TSra/m9o/RC6E6S2t2mk3Uyo4pd0VGe9yy7J?=
 =?us-ascii?Q?EHYScenq89F6e/CQiC6kURvdfFfrRe92MhZQ0297auUM9e5bEHWsDvNwhtTf?=
 =?us-ascii?Q?kUxNE4zUH47ZO4LRRzwtIW1xH+5ct/9gjyLy5dZTcnPawzpUyVf8nRp/h5L5?=
 =?us-ascii?Q?mqxIgvOBVomzzcr2B8l5qZrKpA/XWTCxVVwNftBCathwUFIR+OxS4k0RZXHK?=
 =?us-ascii?Q?Ci4e7qwTzsrb4z0iUv2Sx259e+JE2t7nrtgipTFrIZwyJGfN/Y9kRxOsr32H?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 0313ba81-10bb-4458-03c5-08db1119d42b
X-MS-Exchange-CrossTenant-AuthSource: AM5PR03MB2867.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 19:04:43.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P9Bb0fbfkevTVotojzwU5rXIl7QNWf/jZnzJ5dAsNBqHGggeims/D0cOnzXvPD1QJpMfx9Yd6h26a2HgQwbc4FTihC+uo+RP2Z9SW9hq2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, 17 Feb 2023 14:35:22 -0300
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 1/30/23 08:49, Wander Lairson Costa wrote:
> >> Another thing, if you look at release_task_stack(), it either
> >> caches the outgoing stack for later use, or frees it via RCU
> >> (regardless of PREEMPT_RT). Perhaps we could follow that and just
> >> always punt the freeing of the task struct to RCU?
> >>  
> > That's a point. Do you mean doing that even for !PREEMPT_RT?
> >   
> 
> It seems that Luca Abeni (in Cc) is hitting the bug in the non-rt
> kernel with SCHED_DEADLINE...
> 
> adding him to the thread.

Thanks Daniel for adding me.

I triggered this "BUG: Invalid wait context" with a 5.15.76 kernel,
without PREEMPT_RT. I can reproduce it easily on a KVM-based VM; if
more information or tests are needed, let me know.


			Luca
