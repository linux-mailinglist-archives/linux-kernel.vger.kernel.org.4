Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4391770A70E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjETJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjETJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:59:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C91E4D;
        Sat, 20 May 2023 02:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgE7pTWewBtzVWt6CoVupfps3I5az8dxfb0ZDz2PzoJJ5q0E7vDqLyzNwWwp+NTvHHfn8dJgwsX7fTmwsYBYqLFRL29KYqW3N2+QXr9E6YHUhbU7nFjxxn55YUqz7xLMvoWxuIMZVOcijUoZuVjslAuNswYYNYD1BGnEUxNlnS5bv3Dm//LtUEE17t7+LX9STL9xYo5BTTUfVGSo4hWS3lh8RIysX1d0vBh9A6MMCL2s5n3BGvOlUkfC63mHDObLWor3B0872nhpyp4BlOz1gDQr4/R8nWvQY2QMBJMC0d296ztIr/AIzGSA13UgfyvuQj83EJU7MKhibJD9/WgpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKWRqtJabdhOM7Ow/EvoQPxZ4I+3pwP8zxIQJs9ib54=;
 b=P1bLwZ/XqpnZ4tCZ8k4cApQmCjnWBjJSklOK4o0IVDrYTGekRfmnhjBva0K9IwSZHLVUVwOHI2bKrMGIHydmJES35UlGWMdUHXu588xkMIuVqK7gz7dGIM3llhFXznEFfRYvrxt6QJRGMxmOHvhKZgI8N9TNqCMnEvIacjS63dVd2m9KlHEkjcYCwr8GhUyk900cRFe2udlDUuG4SSsKo/dPj0fgIb8MIZZjYSIRJoX26NRq1rZFZKJdQ2JZiQpnbooRZWo/GGtLtDIz4/Gz2hmaa0gEk9vuHGm0FrcinY6PGVp5qHU73dvV5F9Ld+K+5i3MDKbWZEfRISKL/48UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKWRqtJabdhOM7Ow/EvoQPxZ4I+3pwP8zxIQJs9ib54=;
 b=Dw+tgW8Hz32p981uZWramXsStTFc4t5Gw4NHq6YKLVI+a7lwmOU5ANPMBRwbmB5ctZUqI40dhkeanWAFfgQf0z+u2JJX2/XgBMJO5rfWwXGDoHv9hsSuQxoV911n5TEjhB7l6wcy5cOAZbJJeOgi8KIfu3p/PZLnGAl85kJpDoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AM7PR03MB6564.eurprd03.prod.outlook.com (2603:10a6:20b:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.23; Sat, 20 May
 2023 09:59:03 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%7]) with mapi id 15.20.6387.030; Sat, 20 May 2023
 09:59:03 +0000
Date:   Sat, 20 May 2023 11:58:57 +0200
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
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Message-ID: <20230520115857.3838a7ea@nowhere>
In-Reply-To: <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
        <20230519115621.2b3f75e2@luca64>
        <20230519121804.6c85a3ed@luca64>
        <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::19) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AM7PR03MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 6251c8a9-e0c1-4124-d131-08db5918d74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4129zr26UImrE6jMiYy0NM55IWMja/p7aXzMuvtbKAHkwzdIeD1iu5LlCT4yfdEocSUy9Z78okPzDkY3kHwYbeTXIYIpCerJA0whx6grAwmxwyOOyN3JGbGaOOCLD45V8OMa6II3jbCAMtuxLsAeQM6tgZb4rKGXS+lgpyUly4A+LO2iWZjLn+oh/SpH2iUphFyEht1bMrjWz6pv1IzSUVACUdQEyplUagfdgOh5/RA7+tqQW6fpY92HvswFZWsyXAl/TMWQq5FlQUVCVc6oySiiwD+kFHqm90xPzwJ3FUq3hEEEo7WrU/BC94RbmJJC4tiwtv2TEDHy9QHnJG9Wz/6QMhEmV7Y0bRquoT4S25Hjx5JqlwXcSEK3QQQbRQ1NyuXyDmbCAnhAcxN5sP5hK0lG1zm9WWQKtHQ0qoGqU4BYxZtH+iTn6PEOKbhRpuOtQenNY0lmSc7pn+t7Q2/IAUhP9aFWLq67xX0RZ4R9IpkRO/1jct6jGSc/x/E6VTxYPWAZh1SzPfhqekgCOaFZyMgMYbrLNKy+37pl3aS4ketqFm0rUGyGrTxMRxsx7+j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(366004)(376002)(39850400004)(396003)(451199021)(36916002)(6486002)(6666004)(478600001)(33716001)(186003)(9686003)(6506007)(26005)(83380400001)(38100700002)(41320700001)(86362001)(1076003)(6512007)(786003)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(7416002)(5660300002)(2906002)(8936002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yD7vf2geb30Khkb/i3Qmo8UjVOVsQyh1oQEwf4cqw0N3sJucuoXhNhoqF/Tb?=
 =?us-ascii?Q?WkyEUHZ4SIHOxPIMM9cfS032sXy0UGhnPAXy14dXDEwJh4SmoQYxYtLb+N+j?=
 =?us-ascii?Q?0QggUHK1FC51UPz5V1T4H3ZXA651rat71l5KtuVcmy80itpsCMdqmAVpoOTe?=
 =?us-ascii?Q?xX4+C7VBBtCgfMErhkx0/stbp/2jVbts6jEXWpGhpGDZ/RMFmJS4LIcl54un?=
 =?us-ascii?Q?du2HPW8B1uj0ZB9Tp7BVG/YoU4PNwofkkIVWtS0hU6UqVESPPm/rmnDkzRxf?=
 =?us-ascii?Q?x16SVFhZ7AxO75LaAlHB3/HAce9GYPie5WxL/NbRAtGJ/2XJFoMeMJdldzm6?=
 =?us-ascii?Q?REt37pdg+HQdzBPfwx5pEOpUCTk/lH9rhkh1V3l9mblBL0nnbHKoYSl4EXNy?=
 =?us-ascii?Q?ZK5xhJMAciTVj1TGa4Ap6QJbVMy0F5zDTwDDuDV/VHkuBjRkjuIHGSEd2u75?=
 =?us-ascii?Q?9nl8I/oj1vearhaidFDh4zF8NWPiugO0Nm2h4kDe+/2rG7XrgVIIF1baWuIO?=
 =?us-ascii?Q?NY1AArF/SeD8+8BGTX7povvWr/e0YpmuC4FXCAOl472L3lJUYo9pb3jSlzqN?=
 =?us-ascii?Q?CKwqOCOQjUdiu0XPk5iH9iX8Vl77NMQ4TCZrSOyZAVgMjW7CIhKxtqIxemwT?=
 =?us-ascii?Q?IGZBPv82v6XFfjZpETt4u95emKUJANVH2Eztbw1leydAcXQJemiYtGuGd1EN?=
 =?us-ascii?Q?KBnzfGDYzV11H7LudcQqUcWHMGK8tE9l6Zq4dV/IwP+0psCNMYcqVoh1l0GK?=
 =?us-ascii?Q?hrio0Olu0tf93SWiKMX/I1BFePIRXjF+xuHWz1VQTeWq6C+PzXuVtcLA4fCF?=
 =?us-ascii?Q?HmJg6udxT0y3YvxUKXehqahYuiox/d7kiE+f5ma8B2nFZhFDMWw+L3cPauvp?=
 =?us-ascii?Q?WuYChAeh9OkYsnh+ThiLLD0AyafOVjCZ0metz8EgXCFkwmD2aMte2yjFAgvY?=
 =?us-ascii?Q?/Fmf7gDtvXZ84VVnXVPPUWu9pAWe89fnVjYJ0anrjkeLNVX/UjvBss4u38Mw?=
 =?us-ascii?Q?74MRysZXhuvDZwfOz6lfRaF6EOb64Qm/clkHhP2PS4267Y33LC7EdMbXaIob?=
 =?us-ascii?Q?ZViLRM+77/I24Nf8DsyXGk5rD2nGETnWBtAkpWgu2vMq3EBGwwUUujN12cEW?=
 =?us-ascii?Q?SW5+VlBOLXlVuYxQi5WxxdAhXNItbqBS5qfg+Sc0YOm6qt155hP4B0WvOdw7?=
 =?us-ascii?Q?kqrQGflWsvCo1Ti+JgTHaYU3UN7xHsJKBJEszSKFBv8Ww2DenkLmz2eEHBSd?=
 =?us-ascii?Q?Kh5wWusAH5EiO2Kmfg0KBQFVpoXO26jW/4ZMPk1fZ18gZ0vE5Pmq2GIkZV5i?=
 =?us-ascii?Q?0twvtUTdYv693YnIXJMnkcOF4crxXFLvg//glr2jIKz2gr4C/aM0DtLhcCGr?=
 =?us-ascii?Q?1k7r5lbXURBHMnJZTiP9L68Dv/2UShrxYNwnrt3/6+iRCSOvro/rccBe3PQG?=
 =?us-ascii?Q?vv9+3QAGF5wtyOOQucvNUYHpy7e8gAme58CXbfGFQTg/zcyXHjaAST6o6t+F?=
 =?us-ascii?Q?QiTzaxvED6LlDFAeZIBwqkIsspwQWkTGfYoJdj3ai0Vqz07w80Wp9AUoNKS/?=
 =?us-ascii?Q?Nvbn3/nSU6WQi0mEPcLDuoUhON2mZoEHLOYYCskhvOLNMkb/zFLfd0llLKxg?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 6251c8a9-e0c1-4124-d131-08db5918d74e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 09:59:03.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0EIKBiS4bw1qK9vsnfKMOhbAinK/HvGlEJ8F+Z6NN9n/7MjmxR8rwIUDITsv8wXWOCSGqpqMYVeYiVdKj3Ycz1Ny7NcZ9muVZTJFaB5Ytg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Fri, 19 May 2023 12:12:50 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> - cpu util may go to 100% when we have tasks with large bandwidth
> close to Umax
> 
> As an eg. for issue 1, three tasks - (7,10) (3,10) and (1,10):
> TID[590]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.20
> TID[591]: RECLAIM=1, (r=3ms, d=10ms, p=10ms), Util: 81.94
> TID[592]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 27.19
> 
> re. issue 2, four tasks with same reservation (7,10), tasks tries
> to reclaim leading to 100% cpu usage on all three cpus and leads to
> system hang.

I just tried to repeat this test on a VM with 3 CPUs, and I can
reproduce the stall (100% of CPU time reclaimed by SCHED_DEADLINE
tasks, with no possibility for the other tasks to execute) when I use
	dq = -(max{u_i / Umax, (Umax - Uinact - Uextra)}) * dt

But when I use
	dq = -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt
everything works as expected, the 4 tasks reclaim 95% of the CPU
time and my shell is still active...
(so, I cannot reproduce the starvation issue with this equation)

So, I now think the second one is the correct equation to be used.



				Luca
