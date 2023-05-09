Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07C6FCFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjEIUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEIUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:48:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FC5590;
        Tue,  9 May 2023 13:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8FngEewX8fMexqllVXSGmlqr+3IUwCJduHbvflwL06clAmjj9mggD/x4TKHZpy/t0B9IGETQGRodHE+KNM1okT59+H9NMZjKnT5pL/oeh159ZuqHZn85Yi4/mrQ1Kcfcs7L+2OEXWKNn06kk/pIqReeKMqdJdkdTGOEgE5PAQDJiZYCDzXbYvJPFtYXVxZkHLpTjRDcmLfd/8MIvE/QJPQJE2vf6qI5YgLf1O3L0LwBuzhB15c6araowM0GQOAEfHejEfyKsvlJc6Gu8x8iNS0DNGUA6WsgVBObZxfI5RWG1/IqOlRovGiwXmpjyF/hQTfas+s9VcaKpiHjfIPAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69MKZTDdjD0zWUaNtvtOhyLTOHIHn5u9Zpj9S/7D2W0=;
 b=FFW2mXxIPerFtDcSnV/Bry7mWDR1uzRTBsw1yBH1muesiGy+wfOxkmLGlWbhWlqL6QePiXn+VCAvahu7tFJt23Xr8/JYlnUp6EUqeyZ4HXgwQBi0Ito/nkO7dHU2SuYckN9MZVQ0g90wqZXQ3uU8fDHlLW3vUDch/8VrTOjRUBsGPQdW3CnXKY90BJaI3FJEuDv9ZVzQt2FsiUIIa7enHGNjmpB31WbeBPzUG2GsLHcdgz27Vi2pj5ohG2/X2c6JEnq+QvTbNHyjjN0jqxdqO6F20HHn/iqQslJhAwxCZH+aWYHfKJ3xplEsccHYwfFTO/rxL6zH7LGLZoGo1EzOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69MKZTDdjD0zWUaNtvtOhyLTOHIHn5u9Zpj9S/7D2W0=;
 b=JkNAeWi44BQaKRoSbxjOe0PY7CeB3AFmcTQdSaJA8wCmqQjwoDnQMlmNJHrotc4XaLafq5Cai7RoUV78/qflLaDaQv38Gr1f2HNWdQNgGg18xTT3AlyiMtTiDZkCihhprAR57eyJYNoKX6YTgoTmeKH7xI1UgyIGip/ABdQpXr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by PA4PR03MB7390.eurprd03.prod.outlook.com (2603:10a6:102:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 20:48:33 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8cd9:c5f1:f698:5600]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8cd9:c5f1:f698:5600%3]) with mapi id 15.20.6363.031; Tue, 9 May 2023
 20:48:32 +0000
Date:   Tue, 9 May 2023 22:48:29 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/deadline: accurate reclaim bandwidth for GRUB
Message-ID: <20230509224829.2fb547fd@nowhere>
In-Reply-To: <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
        <20230509132534.09098acc@luca64>
        <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0197.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::8) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|PA4PR03MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b9f44a-503f-4bfd-94d7-08db50cec052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ8PDvU8jtS9YmEudgJ6s1EdKjIkaxM87xuXZK0R/dwufyQ6OOULJV2G74ZPYpYD3QdYcZhDti/W3MHL9204lV0Hiu/1eGclxt8uHXwBbO0cNUslv+bBWnXqUdRpHb6xDngD42FY7sAYN9ycaRVnt9lHkvFPy1w+QpfkjbMkSMe9W3Vx3RSq6KMCUiUxsRM6yc+ghTDR2KtJI/svwhrxUgyj0kcGaIDdmrmdME+tQsP1eqj9FBPPCDZ7KHOgEkR7mQpNIpkE1RsA63VNA42CxDsb651dPYP/sXLhXi6BR+Y57uGnqI7FhVe1vCeWZ/vQ4uOavv/DPLH6PoTYyDPiwbIVaHpHi7qXExF3a8sh2FgAhlkiskwrz9YGQ8B+55x55w9U2hbGx58WEZT8vk9YEr/7TcX0a6lEvwi+QPvAgibhnn9FEAQKm3Ntns5K/9MSO/1UizdeCkUUY2MGYmjOBE3i+WBmajPHJfzc0ahvMP/9i46WSlUd9AJfwSkyvvfoXXF+iE9O6ZwyvvEZccjUTV4MPU0DT3zGeZo4k1mbbsg+QYD4hxui3mFiBzBOnKpa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(86362001)(316002)(786003)(54906003)(66946007)(66476007)(4326008)(36916002)(6916009)(6486002)(6666004)(478600001)(66556008)(41320700001)(33716001)(8676002)(8936002)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(186003)(9686003)(1076003)(6506007)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?om0LSM6q007C9q0F+XKl0fQzWgiD2mh5nhPghWifrIUOkyn5BSHYoevEhUKT?=
 =?us-ascii?Q?EHy5lrZ7x5LxONHnKnFXHpoLEXdM3nx/vx+x+Nll4NhcMlKX6rMLr8UrsMNl?=
 =?us-ascii?Q?XEnaX1MNP5Fx6entpJjAMQzww0SP5Vpx2svmKxz9S6AqdPrBXXKStfaw+2TF?=
 =?us-ascii?Q?ga8Jmz6vX4bKCWYxaV6kAkk8hliQ/OFb7dulRa2w82ppV1B9XjAiWgG0M7iU?=
 =?us-ascii?Q?DP91CeOyok3AveiuLrq5o776AswM6E0g7hExBz4I4yBJ+NpZfgYBNsgF2QkK?=
 =?us-ascii?Q?NZ3FjgKIc9pFhLQqtUuFPvPJOaPgho7ahwgJYjq/wOxnygAEU8wd4Z+hvJhK?=
 =?us-ascii?Q?YpksLkbbZsxtaNMe9Oti8DNGhmXe3+VSzAHa8o6g/19XFfYNebaLh44khoZf?=
 =?us-ascii?Q?RDU/YfrNCR6P+OMc1CTzwwfC7kJV6DnFlcE5aGQtbKIAeulUUYgBCHD81UX9?=
 =?us-ascii?Q?gJQ1DAhXVL/HiEXrwrZhxp0xk5psBVFpesySIk9lGDW7cLmR2NLvfw4oZrD6?=
 =?us-ascii?Q?4FBHjWrB9/H83NHf3QEJ/VamuVQLEN4QjrwmFeqjwXJtUSjhfE2PEpqbHqdv?=
 =?us-ascii?Q?ILJbM5NbXeMBoClyE3ThJia313CcAGc1GQ0u1dhpMJGf1JXWtd7g7lvewhkh?=
 =?us-ascii?Q?5Jakd5BxRwvmAMSy3YOM5j5dDl+zTmf9lpcLpXMUVX7GDwXdz/6SrHAjdpAV?=
 =?us-ascii?Q?GDoBGjeuhGgbCW1BPjLfglYQSQE+NJl2wOJ+dIb1KLihN8VBJ8U00zMxrYVL?=
 =?us-ascii?Q?6xlwS3Po9flRpLpscJllIhS/Wgm51ShgK+7eQYbo+KxnlZq/sX7WB4+IvpEU?=
 =?us-ascii?Q?aBvQK3DeexE1CCSEVeQRV0EZWnOMq9jzuCd8mKAPPf82cRuawqnt6z5CS081?=
 =?us-ascii?Q?RC2X/zVdDjJ5reNc5DQg2APN6vPKnWBIvFoLDE2/C/hcVrsDT0w5OuZC45lO?=
 =?us-ascii?Q?ckVMmYEeB8MPnfMiUd1hegH+A6wdtPuCDlncobZFIdNUlyppV8W2kd9QrUfF?=
 =?us-ascii?Q?IipmWyb/NpwqOFcGoJFoFP7msMnb/z1Ov1lO/YUQXf/neXCapnB0gQ1Ehrpp?=
 =?us-ascii?Q?xbu+66LNppNv8dBEJ0tlDQspmQH877wN9gXtM8aiZyUvrzGBGwmtM+Gr64jo?=
 =?us-ascii?Q?MByvMFO4suuLNWWFR0Yj/QxLK8eBR26g7ZP+JIRw7RBBvDkzCrlrnMzNHlRh?=
 =?us-ascii?Q?vUK69tzpYbdcjfbeJZEwNky0fN6f+HxCaNFq6jRZsGokchdWYDAuyjZ2nJdU?=
 =?us-ascii?Q?4h2mfgA1mrgllRIcqS9wnUUpLzqQow68AuCr7ebILtniTtSPqZmtwA6y6lAN?=
 =?us-ascii?Q?CYZnJBtP/y+12LxXXsK35rafuFQ3JiLFBG4pfy7kOSLYOjy2pwE6XYyx78ej?=
 =?us-ascii?Q?iJsXRX2u2u8AFg5krosir0qdY0akebWabgnXg+WymIuxbTkWflQ/7rgPlnW2?=
 =?us-ascii?Q?bFZHNFdGTNl5/Zmf25qMFxFRBjc6/gfYFSyCvCN0K1Q5sOAYPY5T52nQ66pB?=
 =?us-ascii?Q?pzwoGXN/GrTQzWv2Uzjv9eshRoxNrp7RbHxfbJXD2Y42j6Ol+bSdwXfIdVPt?=
 =?us-ascii?Q?+aGnK7CYqCiBFXd8TADAhQyoqTu2WdvDu6hqdrKExA3RWLuJKcsM8kfMs0le?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b9f44a-503f-4bfd-94d7-08db50cec052
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 20:48:32.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2989zjkGsmkW/nj5d1M4MGdt+Dt+uizNmqNAs4ggqgSRssEKAqNgaDhsNNOj57rU6isG4PW48kGq9eGmDbCcJL3R1/E04LRoLcrKB5wykA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 May 2023 15:29:21 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> > Is this understanding correct?  
> Yes, the above two details are correct. In addition to that, I think
> the existing equation had a small bug:
> GRUB paper says, running time is depreciated as
>    "dq = -U dt" where U is running_bw.
> This is assuming that the whole cpu bandwidth could be reclaimed. But
> in our case, we cap at Umax. So the equation should be
>    "dq = -(U/Umax) dt"

Yes, this is the approximation I was mentioning... Instead of using a
division, I approximated it with a different equation using a sum.


> And then we have an upper limit of (1 - Uextra - Uinact). I feel we
> should be taking the minimum of these values to make sure that we
> don't cross the upper bound. I think the equation should be:
>    "dq = -min{U/Umax, (1 - Uextra - Uinact)} dt"
> 
> But the current implementation is
>    "dq = -max{u/Umax, (1 - Uextra - Uinact)} dt"
>    Where u = dl_se->dl_bw.

Well, here I think we should really use a "max{}", not a "min{}",
otherwise we risk to subtract an amount of time which is too small (the
"min{}" should be on the reclaimed bandwidth - so that we do not
reclaim too much - but this expression is computing the runtime
decrement - so I think this should be a "max{}").

Or am I misunderstanding something?

Did you try using u/Umax, but without changing the "max{}" into "min{}"?


> After fixing the above equation, reclaim logic works well but when
> only SCHED_FLAG_RECLAIM tasks are running. When we have a mix of both
> normal deadline and SCHED_FLAG_RECLAIM, it breaks the reclaim logic.
> As you pointed out, the second part of the fix is for that.

OK


> > If using div64_u64() does not introduce too much overhead, then I
> > agree with the first change.  
> In my testing, I did not see a change in the performance of the
> grub_reclaim function. Both old and new implementations take 10 to
> 20 nanoseconds on average. But my observation might not be accurate.

Or maybe my assumption that div64 is bad was wrong :)
Let's see what other people think about this.


			Thanks,
				Luca




> With this change, it is difficult to avoid division as the denominator
> is a variable and we would not be able to pre-calculate an inverse. We
> could probably calculate inverse during {__add/__sub}_running_bw so as
> to reduce the frequency of div64_u64. I shall try this for v2.
> 
> > The second change also looks good to me.
> >
> > I have no comments on the code, but there is one thing in the
> > comments that looks misleading to me (or I am misunderstanding the
> > code or the comments):
> >  
> 
> > > + * We can calculate Umax_reclaim as:
> > > + *   Umax_reclaim:   this_bw + Uinact + Ureclaim  
> >
> > I think this looks like a typo (summing this_bw to Uinact
> > looks wrong). Should "this_bw" be Uextra?
> >  
> Thanks a lot for pointing it out. Yes you are right, I messed up in
> the comments. It should be Uextra and I shall fix it in v2.
> 
> > > + *   dq = -(Ureclaim / Umax_reclaim) * dt
> > > + *      = -(Ureclaim / (Ureclaim + Uextra + Uinact)) * dt  
> >
> > I think this should be the correct equation. BTW, since you are
> > summing Uextra and Uinact, mabe you could just use "Umax -
> > running_bw"? 
> Makes sense, it will avoid an extra variable Uinact. I shall modify
> this in v2.
> 
> Thanks,
> Vineeth

