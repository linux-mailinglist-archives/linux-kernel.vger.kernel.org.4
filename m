Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35486FECF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjEKHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEKHhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:37:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401D10DD;
        Thu, 11 May 2023 00:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYXqO8ZqpG+phseYkgNVE5TGa0UoEAUmCEYASTk7mVkD9q5Qzdl5dFvcnca3o8cNFIsV0ThjDVDzrUWQRhw7GSTAA8ja7t4q6/iKcoSqWypI5rDdHWW6HtNty9gIA8To4B8kkeE9AFBzOC6gRf2p2ivH1oal9omWu7KdiTua1kwCnL/Z5isTM+K8H/07SQZtcNPSOdYiJHbDU0pBOuVaq8g+Sd/Kg0cexX5BQDwsF8iduRnWZc083eZCgYbfvq78hzPiaZjIZiNApyOFA2UIc9KkeEgvsQMrTsnWJ1turlV7FuyQrHQlLq04GIKO2UFY8NlHD/LBFJV3ldJmVgPuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g92VZvV0Gp81FZ3EVT7g0PeFqiVEhQCcZiQRkg+SO2o=;
 b=OZ4lPD5WfdgM16JEZkrjD8aCJWgDSYiNFt3je6mK9rbdgSLV5R8WpSlv9qYEXGxaFm3zuoGoz8FZ9UDK8+Z3Q/YDOQgyBib07fSXxRDkEKEJBZC2aoKprjZFXS9SdCgjscsjYEPp2c8sIfk/nU17Nd7VWbresRqakQmP6XDlvRLwd83//rHg6uDm+q4T5b/6oVZOJDSp76nlJAa6QeWMxzKCpe/d0urtkNARmn3TRbIDl+VCPnMNCuRfIHS969snDdK2OQQS//7wZl9urEPFLHTyzXpJMnZoCXahqvXS0daCp5liB7xSaFAl8n6LcETvTHiYT7yxChIeK4v596tBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g92VZvV0Gp81FZ3EVT7g0PeFqiVEhQCcZiQRkg+SO2o=;
 b=mi2zVljXwQ+Hgjz2x9DIV5mQTmi06CzDu8QCqBNBWLpW53AJjdMfXQh5bTOC7ldoYAX2E8xNsKmjJKlM1Y4P8Jb0wvYqrpu2bbrLnPS40zkLSBtJfh1pT6cXmDBJoZsK+ZX8A7QQyWREmYkfKNLUTkfmJIThRQFEi8Ol5tFXnTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AS8PR03MB9700.eurprd03.prod.outlook.com (2603:10a6:20b:61c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 07:37:14 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 07:37:14 +0000
Date:   Thu, 11 May 2023 09:37:11 +0200
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
Message-ID: <20230511093711.2be82409@nowhere>
In-Reply-To: <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
        <20230509132534.09098acc@luca64>
        <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
        <20230509224829.2fb547fd@nowhere>
        <20230509225417.61d36733@nowhere>
        <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
        <20230510090735.68f62cd4@nowhere>
        <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AS8PR03MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: aa205e87-b9cf-4df7-6725-08db51f289fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKWGd7TGiJ0SfijkU2b9VrkfoBK9eSBEpf3aZOz7nLfdNi9n/WCKrI5zEfG+f3qqxi2zFIWudmDt9U3TBSLMLtzSuSRUAqsP9wyEXb2xr4cF64oO274c4IyTV2i/DWFisSNqT/5bnVKUXE4y0ChhgRK//kkJIonjCSGaExShYaaXjf5zd3l3hojBEI3xK1+GYurhGL47fDP+DY9tRZkzzMtDS6vmCqKnhicj0ekNzIrnl3DPCwy7VofMzxsoWU5z8PNEuAI3qu741O/DHRK9w8q0/2MsnOpo3Pl2M+T2K7PEpLzWd9Kri+Wbx6hpzDa8x5AFXhntwOcBTdNSwtpuOlFMZGsDVasTdXAC7dcnEziV+gXYwXr2wMEpMwOkIAo4KKDGv6sN++V2kvOvl03nFnBgoYWcUFDSJrP0e6by//Mo3MdZDvgurcb/LTDJFChiY/Ivgxkz+v5IoSJdwa7JXpO9Bs+AZkRhHfZkD4tJS4fVz8J7Q3GU4+rItclPPJuVoP0wg26DXgSjkSQNMKVWEeA50mekP2tKBskVCySX0SPXWDHSpXAIO+Vp5bA7MlzR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39850400004)(376002)(396003)(366004)(346002)(136003)(451199021)(86362001)(41320700001)(33716001)(38100700002)(9686003)(6512007)(1076003)(6506007)(26005)(5660300002)(4326008)(186003)(6916009)(8676002)(8936002)(66476007)(66946007)(66556008)(7416002)(316002)(41300700001)(786003)(36916002)(6666004)(478600001)(54906003)(6486002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tx27lgD35W99TPRVdGYOWhr2g8p1TvdjYVNF/UQQSMQRigMlpsmiBiZPIylx?=
 =?us-ascii?Q?3pCM4URMqvuyt7zfFvRLiLg/gabSr1639D8/YgLhQI6mHWE+JsRnpp92vMIn?=
 =?us-ascii?Q?r9R7KNNJL4gDx+c265vx/GajvCffVo2Q/nNZZDF8qX3kjcN6Yh+ay6LQYifq?=
 =?us-ascii?Q?hhlXNRbGjL7jo7gNTKQ27+HwxK5g6vghBFxJGBufjQzWfiZjVLNCE8qqc2CZ?=
 =?us-ascii?Q?wWDQ4RRcZInqsovGA9A5OIG+kK0TYM4pBlo7Npj69L7zWT4rw0/GyV6SqC9B?=
 =?us-ascii?Q?pQTZ7nOIP27FhPGAHCxOBmjIw3FJOa7cLAQIUCK4L46kU3iHlWEwFs5NwOOU?=
 =?us-ascii?Q?ZB4TvQX4PXKaKlk2rUuyiizlvEDbG652sIZOkp+JVmJWodB4uE2pjFkUcX64?=
 =?us-ascii?Q?LiupWJleIXKuecwM2tBn2FwQ1FlrRb29tZ02zI6sdH5F3d2MHbQfTe55WRtN?=
 =?us-ascii?Q?sjhDSQnyO9yw30X3iV/wTV3hnJ/N1c6SnhQAsIAugT6mcFuHRU8u7i8OYQFW?=
 =?us-ascii?Q?OPpihJ/v5eLD7JP2fsxE2B4UpOJFjvCW0gYq+wxkDWL+fIsNL0bN6bdMg1qM?=
 =?us-ascii?Q?jsgTav5n7YvRxZK8DWZeUbRwc1Hlx0sVsDhijSWhq5oL4liaMwSHUsVR+HMz?=
 =?us-ascii?Q?4BOGAX0C73TimrFMZzRniAN715LQXdMqpDiuwd8KY8+zQhTRNeAqYbNXOEwR?=
 =?us-ascii?Q?w1gV1zoh0g4V+mhiXAQxBnTgHx4m4tT33wPUw4OAOaMaOEzSXfPPiIfOhDdU?=
 =?us-ascii?Q?PKGXxTZrrf6cvy/tj1V8GLPsOB4Q+XvtazhkW8swFeMerlFyKDMIpOjchkHu?=
 =?us-ascii?Q?BojxoVgghfM9TPxRXzcD64au2DGtzs3EmgfipvJU98nLlMfNmK+ErEMeUsZo?=
 =?us-ascii?Q?nkDkNhdh3JcfQu28aXlaq2YyZ9s+zHOoIWFAhGlWDYO/+/WENC9Gy9V4n4fK?=
 =?us-ascii?Q?pr9EDBHpiFKjN5F//AVK/AAyvwepPKTFUObanA6AkQCpBgrZxcP0AC0+eKCb?=
 =?us-ascii?Q?7VEIlQF46ESQX9Mcdj4ni0IvkxTxerYKIgTl3XIf3LSntnuGl72mHdd8uzQ4?=
 =?us-ascii?Q?6fUvLHWQAjlaEGcFffeMePdECKtAklzX5ZO3vVWAcEHv6D18NGt6KDr2pe7D?=
 =?us-ascii?Q?hDUFx7XV8LE+eLvl1f1megjR2dtZbsp8xgBxKSkHpAWtjnhOtjtJ6KeyZ4L4?=
 =?us-ascii?Q?FF5F9OfMbxVdD1olnQfaBaY+N1xoqD7f8XaimEJ3tiLAkMgswV/NsGPgfLPX?=
 =?us-ascii?Q?qsdW31u0dl/PtxzzMct4ROYktemXCN9+CaM+V2k0onf2VhWf0+HXbFBXhehW?=
 =?us-ascii?Q?SPktzbk0PAN2pqYPYXV9jhYsmflaZTzayJvwFWt07jJG6JPIQRV8ic0q+YeD?=
 =?us-ascii?Q?4aeDhSycwGFH9aNeMiuIKbswFa8UIOoVR7Ja5cjhyIysOJsUMmvVhJ9r3J6V?=
 =?us-ascii?Q?pdkUNwIVumnCuMNtbVk1yg4BKhmXpZlqpvclpLIs4mRo87+GPNEUiTXKC7CO?=
 =?us-ascii?Q?eb6YpD7/Bz9+bvuckhF9gYTcdEHZ+OTNdvA1sQXpjPoQfVFddstnF16dsKkw?=
 =?us-ascii?Q?tfAv2m8ZD67VjJ+RYgDZ87ZOwIqJurjMYPEIeCHNw4KXoN7X9QThq+Z59fiN?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: aa205e87-b9cf-4df7-6725-08db51f289fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:37:14.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aMj7thLxRbQbLq/JucFWLWxiw5L+0BoEcjJr1LDlvHuu9sCONdtayIGaeox8vKLBC5Iw27E7LJGut4ulDbAwGR0oCy8tnOD86cUhRW3+mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9700
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

On Wed, 10 May 2023 11:50:00 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]
> > the "1 - u_inact - u_extra" part is needed to make sure that the
> > real-time guarantees are not broken by the reclaiming mechanism...
> > But it can end up with a task trying to consume too much time on a
> > single CPU, hence the "u/Umax" term in the "max{}" is needed to
> > make sure that a task will not consume more than Umax of a CPU.
> >
> > Now, if we have one single task on a CPU u/Umax will always be
> > larger than the other term... But when we have multiple tasks the
> > other term is needed too.
> >  
> Understood, thanks for explaining.
> 
> > (BTW, when considering multiple tasks on multiple CPUs, another
> > potential problem is given by u_extra... Now that I remember all the
> > details, u_extra is not "Umax - this_bw" - this is true when we
> > consider only one CPU, but is is "Umax - sum(u_i)/m" (where
> > "sum(u_i)" is the sum of the bandwidths of all the SCHED_DEADLINE
> > tasks in the root domain, and "m" is the number of CPUs in the root
> > domain)... So, the reclaimable CPU time is distributed uniformly on
> > all the CPUs and this could create some issues. But let's see what
> > happens after the div64 fix and the SCHED_FLAG_RECLAIM fix)
> >  
> This makes sense. This also means that we wouldn't be able to replace
> "Uextra + Uinact" with "Umax - running_bw"

Right. When I suggested it, I was mistaken (I probably mis-read some
comments, and I did not remember how u_extra is exactly computed)


> and I was seeing problems
> with SMP testing. So I shall revert to "Uextra + Uinact" in v2. And I
> think the potential issue with Uextra would be avoided by the check
> for Uextra + Uinact > Umax to make sure that we don't reclaim more
> than Umax for a single cpu.
> 
> I have tested the patch with SMP using the stressor mentioned in the
> commit message and running cyclicdeadline in parallel. The results
> are similar to upstream and GRUB able to reclaim upto Umax now.
> 
> I shall send the v2 soon after a bit more testing..

I've just seen v2, and (unless I misunderstand something) I see you
removed the max{u_i/u_max, 1 - (u_inact + u_extra}} thing?

I fear this might break the real-time guarantees provided by the
algorithm...


> Thanks a lot for all the valuable inputs and detailed explanation :-)

And thank you for addressing this issue and listening to me :)



			Thanks,
				Luca
