Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E206FFB06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjEKUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbjEKUDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:03:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A8D074;
        Thu, 11 May 2023 13:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcNd9SnZH/q0AypXNCjL4OGnKZLjgFIpSrKGxXXBlza9vlINtLyL1oGir6WnvaDpJbVC/0yHrI6rn0+iGZX4ByB+HuTcRF2PasnLCur9k7yGNCQCIETWnePor4ZzTktRw4hoilrYsBa2XVf81y1oDFE2Gm7uVVQxxcMKYt3XFV0LMcMRTfQ9U8mH5xIxRtNDoGc6g/rzpxJkmR83N9E7pdVclFTsPseMgiGeAh62lBgs4fqLXlNYzERR05+aDeq0QdbSii7thXvWprlsYOD2OjHlJtyB5fvIkYsanb3C3CsOCNvrEFgPwK8r6svnwca0BPUzn8cYLTcEdkYXiflpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJl3LiZ+M8oPdJch/AhPZsGQnISWBuuClJ/SUWBOJIs=;
 b=GsTly3As6bEF9xqcGtLNC5HxbDIjTEaukhApG6EzvRITaI7EvunNzEDiz1mON8hfk0PMm8XK+hrQBEL8KKtojuhZxq76dL5zD1ZmWZ9u5Z5bn6iF3Bqeenrj7VTIXPxZAy3UkKFwAMpf7U3Ojnaeq3YsRV8U9wkKiMWyHZPs0fxmcsFmc2BP+pF5EqFhSRbmq89ugUg48/kXcP2LwkX91SZwmBQ1mrG14t12wYlV4eJ9uG5NWCflUiLHitv1GPudvbxuMhS1l9lJM3Ce4rQdlYt/x/bkmlPXLn5998ybf7LYeuu2mwup917k/RDFG5jSAPipSe0FKFaxmjGUj6vefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJl3LiZ+M8oPdJch/AhPZsGQnISWBuuClJ/SUWBOJIs=;
 b=kSVx49vhjES7GLN1rTHAa2hBFEfrUtwbROByVIzEgaSBw61ZhrqpPxTbm3bGtqmU3mWggtUavBo09SHnh8mvllgV2Y3osrA7CIUMtoOvFztc/k2gD93L25iFEr+vsNPOhrRGF6L4uC8FYo6qBML0C8o2MC6RaIWJP9B3bD+16pU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AM9PR03MB6850.eurprd03.prod.outlook.com (2603:10a6:20b:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Thu, 11 May
 2023 20:03:39 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 20:03:39 +0000
Date:   Thu, 11 May 2023 22:03:36 +0200
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
Message-ID: <20230511220336.05866e80@nowhere>
In-Reply-To: <CAO7JXPiKLFLVpqDKoRdu8c2Yd4AJ_2B2UyXJxD3kJAyiJ=n0_Q@mail.gmail.com>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
        <20230509132534.09098acc@luca64>
        <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
        <20230509224829.2fb547fd@nowhere>
        <20230509225417.61d36733@nowhere>
        <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
        <20230510090735.68f62cd4@nowhere>
        <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
        <20230511093711.2be82409@nowhere>
        <CAO7JXPiKLFLVpqDKoRdu8c2Yd4AJ_2B2UyXJxD3kJAyiJ=n0_Q@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::9) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AM9PR03MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5172f2e7-263c-4918-f043-08db525ad01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3ZKgrtiPPwdzsnYOtjDFgnhdEgWNgg0jWhAVctgoP6CKJ7X+Pt8vb3qJW0ACsN9q8YYpaah9ms0rIa3hMejANuQRay7V9FeqAyCxvuPXQK4Tp5Zon0Ew45zenSRyV9kXcMdtLYRows76u/m+EXV9OywtVwnkePK0OcdOPfnIJTb1Ff8Va4A/5WaJRRYNfebVDoJ9bHP28oG1VJSOjLE4mlYTmG2cBQwht+vQgcXD+bX/SbvUPOBrYE4l67yU5iNOQ/ATda9ffeNawFmxNx22i8a6lPB8thvz9oOocgz5NOvAVmbfpyv6Nt5nfwJeBy1/oryD/N24u3lK7ONn+tRk8+nIBYr7+jhgpFTdSNMQiDERXiErm+/GYQb/M/D/WkVirzMdFLXv5SRT4DJo6lmk2iA5sX4qj32HDratD5cKGYTMfdxrCLk0ein/kMp8IM1F2arQYA8k+PxquKEOWXWYAft/ZgfqMzAzcc+vLZZhnTH7P+GgWx1cFEUc1T0pHpZZMEB9at/L9Mkk401owZ/PXMKN7kPqQVv2lDwFk15x5au7vj5CXp+dDz9HzXPORDK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(5660300002)(33716001)(7416002)(8676002)(8936002)(41300700001)(316002)(786003)(4326008)(6916009)(66556008)(66476007)(41320700001)(66946007)(6506007)(186003)(26005)(478600001)(6512007)(9686003)(6666004)(6486002)(36916002)(1076003)(2906002)(38100700002)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQk/9WG80UwFAwwM2vRvD5GToM+zxTEFTcrCGdCvFEbOY+dvgL8fqCqco9dH?=
 =?us-ascii?Q?StQvOyp09pwGCo2jKlOXuPYuuaCCmKR3X2aeqvE5Fzyczg8PZEABdf7yeN54?=
 =?us-ascii?Q?G46NAiV/vQrfrK+JN10sp3OJt3YZRTafwB/ApTjTjQqMVd1/QuwjG73f/DIH?=
 =?us-ascii?Q?0eBSA5Gse2dcB2n/PzJiZqbTJkzzjNeTc7nFjH2T1bnAbFzZKrQt2xse3crc?=
 =?us-ascii?Q?2K9SQ8tqhPcaXArfjlChONLfzYA67Dt9MbBfZp/6Ba5nbPeelcFcryeE779w?=
 =?us-ascii?Q?0Qq3zyC2NsRSiKhjzx5ZiQY1//Ayk9ulXC0GmH4xeVGxCGi7X3kG4Iwjy5rs?=
 =?us-ascii?Q?c90l6wiyirta/VLqCf65pyDJbQHo7Abir27VcsWdtqS0vt/hq+fY8zyZanku?=
 =?us-ascii?Q?0Mj9JP/jzIuegsSzelcpAXFpKRtDKa1nZ6OY/b9PfQa1mPLs3mIOdcS+wZQA?=
 =?us-ascii?Q?sdypnNgpUNcg3yJA2wAG1CpVvFg536fOcdsPYwzhSMJ3I1GwrUfcwEJ3CgEM?=
 =?us-ascii?Q?gaQvb/MI5j0sVqIpIxTEjt6nMnsXjGWDga39BzUSYlPBLvPaOrxmJisOVehx?=
 =?us-ascii?Q?AXsPG6os4jwEf0IDn6l5PT6sV1/0H33dW0y3pnxcGLC/mWd4EjhNP6Xp9UNY?=
 =?us-ascii?Q?Qyuvb7ETFmvEtkHlm4XKXDRfojIRQ5Ag7dJEJbqkFiFDEmuwiV1mO3DB/+Kp?=
 =?us-ascii?Q?875XodsDqvl13TZkIIXrDwT2WCO1ruoefr1lImkAvT0QocmqhdN4tRvruAqW?=
 =?us-ascii?Q?fyqcVkHLAd7mJd2UCaJYpNbUMLwEfIVkf3CFEvd225ja+OM6H9Ujd5V2mwmZ?=
 =?us-ascii?Q?f6Tns8J5DhGc9OpiUfI70MTSjC0FWxJHEqZAxAvWsfLITyhyiEjHJEUqGqQn?=
 =?us-ascii?Q?p47yFmlcw1ww+Auiep+hgcT4d2810mzVBv+fktNTkw2rMHg7DF3p4qfhq70c?=
 =?us-ascii?Q?DuRb+vcl1KKW0S66vJYOLlH4qyJ/+havuUkdp8zNEAYB2Wr+OR1sazSljZw8?=
 =?us-ascii?Q?TM1UtZnqpB5aQCqqhcphlhwXfW+joUL2N1GKWxbSBzA6rSAEqR7wQtQEBnhA?=
 =?us-ascii?Q?ZFZq7mjgPRad2oD1A0JtVRIYkAfgPSfIM/mVdHs4e2Om1gV9FH64aMCsZW64?=
 =?us-ascii?Q?cpPiAGqvgLCIpWsEuhZayGtZNP/MzsosLuPH9PyqDbbBd7fGQb/XY2rfjkv4?=
 =?us-ascii?Q?rj9cQKoADqzklKKnTtdDFSGdMK++7HAqNLOIwn4hOx7CW9jwVSPoEZgR3GvE?=
 =?us-ascii?Q?ALyrWMGuT3Q4BNLzNNybvF4991rDXQHwigahbSqh63t7SWalsljEKVTvBQfB?=
 =?us-ascii?Q?K8ekNhEeGdfyZWM48RwtJzzVZO14khjNeiP0gy29Q6V75qEDq5QIu5j/v5aP?=
 =?us-ascii?Q?zFWnJm7ZbyrCWSEMSKnMoPSWrQUgKJI6DRLv/mzJpMGv+NlRqQ5xNltYrdXn?=
 =?us-ascii?Q?nZUXDN9KGkv5CrT9DLAJkw09XTjBAP4g9wyt5GoaCQBwSvA/7gyUREapggnn?=
 =?us-ascii?Q?1hSHhppO2VY8mhxQH8XNXDyPX4PpiH1cI/UrlMSWxOoAr4Mkfqx+WPdZ9tFM?=
 =?us-ascii?Q?9MpdHegJxR3hu2jRXXveUeJwjuH/zO3hXfyozJKR+Kau7EAUAUxvEMKetb3r?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 5172f2e7-263c-4918-f043-08db525ad01f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 20:03:39.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIn/a0J7E7h8jZE/EK7iddoL+1BvbMxabYj6trY3rVX7OrXhIsH6FTACUoeQffmx3B4pJlUiXCoYNRkocNRsCQGtF49ka1TH0ITXenmnziw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6850
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

first of all, thanks for your patience with my comments :)

On Thu, 11 May 2023 14:34:38 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> SMP GRUB paper has the equation for depreciating runtime as:
>   dq_i = -max{u_i, 1 - (extra_bw + Uinact)} dt
> 
> Since we are caping at Umax, the equation would be
>   dq_i = -(max{u_i, Umax - (extra_bw + Uinact)} / Umax) dt (1)
> 
> But existing implementation is:
>   dq_i = -max{u_i/Umax, 1 - (extra_bw + Uinact)} dt (2)
> 
> Here in (2), we factored Umax only to the first term "u_i" and the
> second term in max{} was as left as it is. What do you think?

I agree with you, (1) looks more correct. I do not know why I
implemented (2), but I agree with (1) now.


> Now with normal DL and SCHED_FLAG_RECLAIM tasks, equation (1) can be
> re-written as:
>   dq_i =
>    -(max{u_i, Ureclaim_max - (extra_bw + Uinact)}/Ureclaim_max)dt (3)
> 
> I tested this equation (3) and it works as expected. What do you think
> about the correctness of equation (3)?

I agree with this too.

> 
> I felt that, since we are using sequential reclaim mentioned in the
> paper and we isolate all parameters per-cpu(except for extra_bw) we
> could use the "-dq = -(U/Umax) dt" equation as it was simpler than
> equation (3).

This is the part I am not sure about...

Maybe the best way to go is to split the patch: first you implement (1)
(and use div64 to remove the approximation I used), then you implement
(3) in a second patch.

Finally, if removing the max{} is really needed you can do it in a
third patch (but I would try to go with Equation 3 before removing the
max{})


			Thanks,
				Luca
