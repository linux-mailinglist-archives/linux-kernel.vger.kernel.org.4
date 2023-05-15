Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159270269E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEOIHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjEOIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:06:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491001FC3;
        Mon, 15 May 2023 01:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1TIXMnLajm836rvRpR+4ihsjpg92U1IUB6ZFRIjbCrsBJ5GmUsC82fiD+TApebJ4QKj6bJAxoJoU7u89RIV2VXZxh1v5NsBm/2yYxLZQCG3xg9JCCSWaskZPX0nUBpYz/QK4EKBupuJtcbbFSO/dooWZfh67p4CK5569AQXuC1o6D7yXfeS3b8CFruZt5f8BEjazq7vsrjuxoOi4BXqO3HEirBHj9We5MzYu5EDnAfWYVAqZ7N1oyxXIL8uVKKT8c4S4Knp/k3b1rhaiSlFBlZ77YE1134jdtglIoMTulqctJD3+4zGAPB4eY5mBNXzNdU8cxCLJYnYGoHo42mv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN5+kUt8WdWHkTZN9RyVkvZdBg3yJniXOiKfGRG3SU4=;
 b=EVl0hHQXNmont6BtOY4qEDrSVwDVHVHLktaoUy3qM2FVtw6gugmkcvVkGGP7/Q1lm0Tz2Bs6DotjUC+UeHvltMFRPSp1C/7BYpJT99LTRfd6D3pVoDUBK7bUSqhMQf4fyEZsd6NQwAme1/4zNSMIkm29dFjdffuZC44c74r4QaodCJLxlc+RhXd0Whb9cNUUf0hCV1dx9oJJ37/DVDWdrGFGFZBWXhRUdKq3ECA4+Z9wtmCDCFggXU9nBkCy3p+WZpz2efCvvTFs15ozn37qSt6wDIbJ7gXg+gzckl/vPRXgip2wA7ZszE0Imf4B5f6BYyC4sxTBLpoK1cy/+UjqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN5+kUt8WdWHkTZN9RyVkvZdBg3yJniXOiKfGRG3SU4=;
 b=B61GlEZjK19oLjwuttagEkVOBiy04wFF7KtnXnkQx70uOydAnQEKOXt+6pP7/6fMjMPqswUD8yti6uL0M8WfwsUvQUB8RpDH/uFaA9tH8hzdqQE7rWZxh/cR79qvYPpf1L6pMPqwxgQTd7QE5OtKoYd6PMl6fHNWlYBx0DomrLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AM7PR03MB6328.eurprd03.prod.outlook.com (2603:10a6:20b:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 08:06:20 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:06:20 +0000
Date:   Mon, 15 May 2023 10:06:16 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Pillai <vineeth@bitbyteword.org>
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
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Message-ID: <20230515100616.33ba5dd9@luca64>
In-Reply-To: <20230515025716.316888-3-vineeth@bitbyteword.org>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::8) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AM7PR03MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: f22eb137-d604-40c8-2fd0-08db551b4413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpA4ZY3PtWzsoibriHD7QtWuTZwHyZAlu+dpLxTV+qGNHu9YhzXjYW/ms7+mDwRiCR5ih8+Dv9XLpdYxoOtMk2w5fmJZBh0eEJTzKZ7DDqvKDGq9P4qoP2pqZlkS4E8QuuqDEXEO30jJPY5QMN61HLucfnRB6gt0aODQmL0kvmjrO4f58z6fthUkf1BHU8JJ76x000mIScZ5t4nqQqRAmuEmRugVs97yHtdlFZbTOYBkJYicm2oNnERzo5GGNQrHndkBr3elkMxvQnO+xIlaan371pW16B61FMmN56z9IKHnutIDBeVAVWDmjTOA85IIT9zEb6+iyvncMLmxw23dH/YELwgRJBNJbTaQUOHO76TmT2FN5zxrgYd8WdeqoCcexdMDLFQTpuLRnuGxvj7yVA2E0mNzqWtlNy3yQb9S/S5E2ZriRdHiFV+zZ8zAVW3IlxHbaQCRYeWA8D7NwhaNhbQk8rJMRCE53/vLfJIivRBR4X6GfidAFkhqsbQME5796dwm61cSw9QXjaNx2oDtHHbMKRmK6rp9z8R8ku/F53vTiERV7rIe9D36/k4wmz6u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(366004)(346002)(136003)(39840400004)(396003)(451199021)(83380400001)(33716001)(4326008)(6916009)(41300700001)(38100700002)(786003)(9686003)(6512007)(26005)(6506007)(6486002)(1076003)(478600001)(66946007)(316002)(66476007)(66556008)(36916002)(8676002)(8936002)(7416002)(41320700001)(5660300002)(2906002)(54906003)(86362001)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avkb1NmBXW1R1/Ol5ivI2a/Gy2o2AcJprDfxR7F7IEsuLeB+EnS5OjHX3siM?=
 =?us-ascii?Q?+BUY2UwM2LJ63jAxfMwyOGkkTzKiz6xKN8yJpqYvGVZOz/fLdGpdZMzEqrcG?=
 =?us-ascii?Q?TRfv0YlMfvxjwB8HxF08N/wHpXbfBNmTmRIRPMBat4Ac6Bx5GMC7z36qXngO?=
 =?us-ascii?Q?xLWOt1ajX4nSwJSAK9sdEiAJx5bUa+fDwRKrOtsXexvNNL9izv1AEsz49O4B?=
 =?us-ascii?Q?5jx/guwsQ3Esmq3uL6ZqPYU2I5VTdrrsH8n4s62WzCsubLuSmDdVzW1AVYf9?=
 =?us-ascii?Q?M03VfqGv5KLFo2cF0S/POfrW9HuOrVwEE6sVIMP1uqjKpBSutXeURjlCuh5X?=
 =?us-ascii?Q?bWCpfuZYGwRFdR1EJSt4nnZFJNPy/mBwgP6RF+40gwZlt1dDfKzmyA6PyyJ/?=
 =?us-ascii?Q?2r4fgOzw1Hinwkv44uWPJBujIfVaTUE8d72q4pfqnD01qcXuE9P4s6E2rPNa?=
 =?us-ascii?Q?s/JmxSHW5XjKMVpWdRyUHGJW97oYPYAywPbAlof4Tn/ebxL7IJ+psuBgDDcq?=
 =?us-ascii?Q?FyzBS3QyHOhUNR1xkUGHVyHEKBM8+gDIQigwUxolNPlo8apkRAfmZHlFrRtp?=
 =?us-ascii?Q?8W8ZKmG4Au5AoNl4TwVgG9GO3a9abiXhJELVs2bQk7jcd2JQ991zv8dGNjUv?=
 =?us-ascii?Q?Tl4Z9kmTZGYbS4AWEM/rWfwfM/3o+eBmuVoOVG4FpPJOnU6zidsPUn0DJNMO?=
 =?us-ascii?Q?R1EtJp0BY3V0HH7Cet/9GKWQJ+7aCVLQPQN5qbZEdBNqiPJjF08Rt3//XQnB?=
 =?us-ascii?Q?B7fD+S3qT4UQ5Phoaho0/I6FTQZlV9HbIIAz6o5GDkAtwYD6eOQMdHv7ASk1?=
 =?us-ascii?Q?/psiUNUoDKz6ACrggwiQsgbHOOgvnIyVVfhpwmRaZNP07LmNh1hKkiGs6Fw4?=
 =?us-ascii?Q?ZMZmRDTmzMdOruNjAsK5xFP3TcGTebgXBYeCdB24kbjPv162T4SBT4FK93kN?=
 =?us-ascii?Q?z3C0Tg9m4Syk6xDy5/0TkYa8rBEa99gK+ctIyM9vVuHHGqZo45qhVXRWmZAE?=
 =?us-ascii?Q?S3T6v6iKemaXzN7s3+f9KlGVTXgvY3R67KargjezOC7BvCuPjLcNg93S/n1f?=
 =?us-ascii?Q?iphXW7p2FzQHnA+Cl49OIUQDeySILH3apA2ZyMhYxAM5O7TL4CSlT2zxElWq?=
 =?us-ascii?Q?MDO6r0GSDDP3lbsZezjSK3AG4VJL7vr1sjgqsBXUB0mLg5ssBFiyPVqjigSu?=
 =?us-ascii?Q?o6ZXWg3OSKXNZn+MTob3MTwLKGv5ySFUoCbBMGKUoH6EfO2V9NMpSqslbVB2?=
 =?us-ascii?Q?Tfwbwt/ROIUuP4lTBwaYgHs1dAVVQIMKqa8NoqCoUrGmMrOJLtsW53pgYmla?=
 =?us-ascii?Q?Uf20kblqVO8kgkQyMF9h/d6LyW4XeE1SUjjKUSktvGcYK7akvolzS8fjamvK?=
 =?us-ascii?Q?NRFZ+v74DHBSNYa6GbVuE0q+U3tnL1mgm05wbSwyaqczl51C1vtfqbM0Ttn7?=
 =?us-ascii?Q?flq6SMfpEWTxjyNptzgdlAz4jxPaIzqlahyJgAjl50TZplXdMcmPpH+VgxKn?=
 =?us-ascii?Q?mcj1Mg5AAwNC0/YKuhO5JkK1uQzHhKl6YAEBSqIvFOzPLr7HtT92El4BltW/?=
 =?us-ascii?Q?yu7CEMvLpLtktQ9Xlpk6I9L1I5Xek926VA/ZgSGZ0LlI7AKK7Toge28bFh0g?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: f22eb137-d604-40c8-2fd0-08db551b4413
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 08:06:19.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqeiVZnkK8Um7mc3jW2rLJLPDs0LWev/6YLnlULUFca3Sp+xZ8WTsMKdsZwTyrX1umwk7TMavhcpWM92qGlBdiuxtG6L2C0QiKydEFYTRMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch is giving me some headaches:

On Sun, 14 May 2023 22:57:13 -0400
Vineeth Pillai <vineeth@bitbyteword.org> wrote:
[...]
>   *	Uextra:		Extra bandwidth not reserved:
> - *			= Umax - \Sum(u_i / #cpus in the root domain)
> + *			= Umax - this_bw

While I agree that this setting should be OK, it ends up with
	dq = -Uact / Umax * dt
which I remember I originally tried, and gave some issues
(I do not remember the details, but I think if you try N
identical reclaiming tasks, with N > M, the reclaimed time
is not distributed equally among them?)

I need to think a little bit more about this...


		Luca

>   *	u_i:		Bandwidth of an admitted dl task in the
>   *			root domain.
>   *
> @@ -1286,22 +1286,14 @@ int dl_runtime_exceeded(struct
> sched_dl_entity *dl_se) */
>  static u64 grub_reclaim(u64 delta, struct rq *rq, struct
> sched_dl_entity *dl_se) {
> -	u64 u_act;
> -	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot -
> Uact */ -
>  	/*
> -	 * Instead of computing max{u, (rq->dl.max_bw - u_inact -
> u_extra)},
> -	 * we compare u_inact + rq->dl.extra_bw with
> -	 * rq->dl.max_bw - u, because u_inact + rq->dl.extra_bw can
> be larger
> -	 * than rq->dl.max_bw (so, rq->dl.max_bw - u_inact -
> rq->dl.extra_bw
> -	 * would be negative leading to wrong results)
> +	 * max{u, Umax - Uinact - Uextra}
> +	 * = max{u, max_bw - (this_bw - running_bw) + (this_bw -
> running_bw)}
> +	 * = max{u, running_bw} = running_bw
> +	 * So dq = -(max{u, Umax - Uinact - Uextra} / Umax) dt
> +	 *       = -(running_bw / max_bw) dt
>  	 */
> -	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> -		u_act = dl_se->dl_bw;
> -	else
> -		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
> -
> -	return div64_u64(delta * u_act, rq->dl.max_bw);
> +	return div64_u64(delta * rq->dl.running_bw, rq->dl.max_bw);
>  }
>  
>  /*

