Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3E70E705
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEWU6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjEWU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:58:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC88F;
        Tue, 23 May 2023 13:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMUxdT24bjPSuQTDfbZUzUteto43Mm3d7wQAlyNjo3Mqvlrrs4uP6SKcSwGctaNjeZzfF3KjuhNR+hWG8h/S+mdO8NBBNLfs2moThH8QND38EtaB3zM1WxMnc+o4ZU7dIT4PDxCjSDD/NqW16ytsexxjN1wcMh6oC5cg6F6ds9NBynu9P7qLkGWkVT1gQUMz46SX/agOBFU2UqxafwWVioF/M4yTCsfaZS6vuq7wefh2tEU6u6wgX/SaZMve+YENyhIGrs2hXNSdMIhKHnzxHlFi645oXCT57jEWQloLSsykWOn56jP+zbXrSoDFyv4Hx/gJE4wq6hNY5YTxuvXLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzSBRWv3MbVwdsymxRewKv1eegjP3T4XN7RlThuZP1c=;
 b=bByMKbCVlnfz1X8YJNWMJW7Zd8VhjeVW2EKfR5JDIUCJVfhHLjpxwWxi/164TJIrfyBZh7SNxmUMQc/B0KIr4g0NCJUSOrSsqDA2ZV2uBbHzBPLIbize2NNOBoKcnS6XziIkRrMuad5KFVTMA78YOtLHxNMb1dG9I75Cl7R0FLjB8ZnlD8wo/Ac3YTnZmc2R3KnV8Yn+Bm0wyA6arbQw/FfQ6lEFi/XO+baMDP2wA445JzkhigH2o+Qyd1zs967mS/yahJbzxCWXXAZGJa8JAgzBFyYfSg3UmtT5ouVIOUg6eQiQw/h0+QR3nP/wtpMrXBnKxPAoSV7qjXhGzaBsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzSBRWv3MbVwdsymxRewKv1eegjP3T4XN7RlThuZP1c=;
 b=h6p/iKq7gSOEfccqbzBbfLYKM2tl9lc+3QoHtcLrjejYFZtZLyruMhOnZRHHOEd53YdLF0KPXO5d9SQA0kweterDefMW085elunGcogw0wgnuH9yiRbjNVun0WJJQt5lnT1/3cbsQDnCkDk9cgg0W7qUS/IMSPY1QRMl2UUDQ+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AM7PR03MB6562.eurprd03.prod.outlook.com (2603:10a6:20b:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 20:58:34 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934%6]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 20:58:34 +0000
Date:   Tue, 23 May 2023 22:58:31 +0200
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
Message-ID: <20230523225831.60d75b38@nowhere>
In-Reply-To: <CAO7JXPgXi8q02HBeBR_RLWmODd9uQBH_UMCYgVQwbf+FX=Qxkg@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
        <20230519115621.2b3f75e2@luca64>
        <20230519121804.6c85a3ed@luca64>
        <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
        <20230520115857.3838a7ea@nowhere>
        <CAO7JXPgXi8q02HBeBR_RLWmODd9uQBH_UMCYgVQwbf+FX=Qxkg@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AM7PR03MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae20bbe-c52c-45ce-afd1-08db5bd07926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+tAhky0T9+jwVL7/A/f7r4Oy50lx5pqpeZZFIbq9kcqDidgtAI6xWWyfr7x6sTyyw876ihYi9IqyVbdkRDtx372A3JifVX30C5Jg0lpNOjH7imMM85VJzgePg/Ddv7BdMyI+bQdpw1xtWu06csLVcOqscTnkWm/XgVmE0yq0QbnEymrqDzPf1np63mVzYvXtvwbw3w1P4mkjGZw7TxC00QbfcKz3N+HYzHiW9Xlz30jmziOTCjJ3nBb7aUR+m6uJVRMh+aDsdyUCMDjXTvB9vS8r9/HF7myuyajgRuwPzdbhMzazJLeI4FTzX5grDa6bmtihd+0lh4TOYrpY+XS+I1XOyd/dtyUMrXnYhV6eKU/4cgJTDM9C6gNUx9kXuKAcRcKi7Mq6GTB+dNNcHU08QlZojlBOj1Jc7uAnlHg9IXuVfEk5Uov/a3zXtnCWNIfhiJrk1+Gzp1/vl5+9wEfxEwfUWslbJvEnSeRPy9jq42Hayd6ZS4REQ3L2Ar+szLIGYScsGAM2E9ratd5xVVhpxd7pNVTANg+pdB+Lv/lieAXANvDhUK2/BFNIqQ72PxC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39850400004)(346002)(366004)(376002)(136003)(396003)(451199021)(9686003)(6512007)(8676002)(7416002)(8936002)(83380400001)(38100700002)(33716001)(86362001)(41320700001)(6506007)(2906002)(41300700001)(66556008)(66946007)(66476007)(6916009)(36916002)(786003)(4326008)(6666004)(6486002)(316002)(26005)(54906003)(5660300002)(1076003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zyy3bcy35sxZFg8aCkaLfjtCJMv3fS9CarmrcDgp477pH6smz9ABng872qMz?=
 =?us-ascii?Q?vKEENCmEUZtIUQmf1IdcpYGtX3jcarZBNEkupJD5uepBMUO5YevoOGR2njrR?=
 =?us-ascii?Q?dAbIwFUu4sQk/TBCWq6aih5CAiJjXfe9AjqqHUC23RZlzX2hhAOhR4Bft/tk?=
 =?us-ascii?Q?dT4UO3AkR7fTwfXJrWrE30ASM9/DpPdtWDmoLsFk8gQszAZsv96hBtU1TLwq?=
 =?us-ascii?Q?WRU8VCGyNBn9eTl/RFS1ztM9kCO0AG7TfGWGR4LfB1sjbGzuROEP6mb8XY4T?=
 =?us-ascii?Q?42mzF6IlIp3I/xLkynvsUUY2uwOjw1QgypxSfW0bp8A53zrJbWzb1H3Hn1HZ?=
 =?us-ascii?Q?pIEZXr6tSFUWXvlGnFCE4UtRPOdRBERTf1a/lhkcpDiYkRm6o8w9zHDAqw9n?=
 =?us-ascii?Q?FCfbHSJe5EvEnHuoi0TwBkpUjhjXJ/tby8UiTXPPggxHbnCRhrWVfzjKkci6?=
 =?us-ascii?Q?R1cbe42ECI7XO9tC7b4D8DFNBQmiXhj2aJbw8HEEprXgRSs+kjuhlHDg1jBa?=
 =?us-ascii?Q?WGvV1fpOrgQilyCKbdhU84UPpxk6RTnTMF1GOw12MMjON6wz6j+BeIqtjIsH?=
 =?us-ascii?Q?MqDs4+IFSpguB9xnYMH3j41EzuHnJHuL5lXQa3SQ7P9fDAUj2Xgx7ttIGRwG?=
 =?us-ascii?Q?30emXeM/QgUj3wmqkktRuPnd7kbjhCS3HZBxDouE7JmloyhoJJrjNXw+BShp?=
 =?us-ascii?Q?zjnq3fGc9ex7QQZeMFeFKegQUGrbALjLan1bnLWzbdDdELUH14L++l4p5N59?=
 =?us-ascii?Q?UnaLcdSq0nZrPdkBd1C604QVQ47vHJMVKqMnkyp9O8gnbi1wkcJ4fWay45wt?=
 =?us-ascii?Q?J5LeTXHYrzafcBt07qE8azHdEBXHpPaJh3d7qstSF2Ra16SJN1OPDyYsysJ+?=
 =?us-ascii?Q?lLRqF4Q/v/Vk7PrKzXUWZJfESlo3McTWcN8Esgz/Naau2MOrSzpxGGJqS0Iz?=
 =?us-ascii?Q?Y0uyuu1qTEIpq6GgdXu+E2Bc8ET35vhD0DiyvK4lXRtPNCjfQUuNqqDm/5Gx?=
 =?us-ascii?Q?+5MyuDa7ZNSKX/MDjGe3sjAIOxlfKWtXUVk8DJ6uUeW+8Qg4SrtUrCXpYO8H?=
 =?us-ascii?Q?zai4odxI0DAhgvh1+jVnevTzhNZ6vL80+L4S1ZTJyeBFVR3qyHZOSdosjXTV?=
 =?us-ascii?Q?3+W8BLBgzNHPREDR2DM/cUa3vro8AYFcm/Rbhx4cpAWTnOaln/Y5p/q6++/3?=
 =?us-ascii?Q?2zjS9kzff4lFzLvjg/aEd0jSd396Ge37l1GZKOKJmF7hIaxjDWa4/wMmlIio?=
 =?us-ascii?Q?txBjqPQkrJ73RnLqwiBh9fpPi4+LipKQQWyI5lCOHtWyNgAsiRoY4TmbOkDv?=
 =?us-ascii?Q?aEjSeYXAjXIcSf8zteJhuQ57zYGbXhPPHw89mv7JWOygVkLetfCusu6jdgQR?=
 =?us-ascii?Q?MHH55a5MVrYk+byVuiOMkipL8zaLY4QZay4lNsafrk8MIJ0fF+ayEwCOR2vq?=
 =?us-ascii?Q?KM4uLL2cMGioJbDjQil8pOIOYuEx/kg3huiUB2DYVpsEh40egic6j5m2FrHe?=
 =?us-ascii?Q?KTSMAYfU8nS3o8PM3HO3ADfyfZd4jWqggqb6f8lYdAtE6n8qbAfl79bxYXO2?=
 =?us-ascii?Q?Kqxs3GoDcjfVelfAYRxTRkKwc3jsbUdoynY3nTEBupb8fsNBxOF9U+27uvuZ?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae20bbe-c52c-45ce-afd1-08db5bd07926
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:58:34.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+z/Oy2SI2DoLaW4/wa7xA6niXK/lAlZ84fYQCOnJS/pg1Q+bMw28oS27pSfkxRy+cmabIKQ2rf5JyRjLyS6b+NDsENYy2ytjLLUmZJAZxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6562
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

sorry for the late reply.

On Mon, 22 May 2023 15:22:52 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> > But when I use
> >         dq = -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt
> > everything works as expected, the 4 tasks reclaim 95% of the CPU
> > time and my shell is still active...
> > (so, I cannot reproduce the starvation issue with this equation)
> >  
> Sorry about this confusion, yes you are right, there is no stall with
> this equation. The only issue is the lesser reclaim when the load is
> less and tasks have different bandwidth requirements.
> 
> > So, I now think the second one is the correct equation to be used.
> >  
> Thanks for confirming.
> 
> I think it probably makes sense to get the fix for the equation to go
> in as a first step and then we can investigate more about the second
> issue (less reclaiming with less load and different bandwidth) and
> fix it separately. What do you think?

I fully agree. If you split this change in a first patch, IMHO it
can be applied.

BTW, I tried changing the equation without introducing div64, and it
seems to me that it works well... So, if removing the bw_ratio
approximation is needed, I think you can do it in a second patch (so,
the first patch changes the reclaiming equation, and the second one
introduces div64)


			Thanks,
				Luca

> I shall send the next iteration
> with the fix for the equation alone if its okay with you.
> 
> Thanks,
> Vineeth

