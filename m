Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33A709447
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjESJ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjESJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:57:20 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7209199D;
        Fri, 19 May 2023 02:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvBjWlIy1Hwoi5Q7NrcasvSmmV+IUKYOyQkRYZZB/WXL/+eplZL2FvgLoPvm5Z9wj/LyqsTnh9iBuyia9PgQcmB4LHvWpy3CuVANF4mI6u+1K2VITytMyISZ6H4JmzL33R3OZxPoW/KsaTLAzUVRg+Aa555qJ/F91IQP2vxawnGCkL4fmyCVDTMy8XrNmHCduxmouSenZpXsHkKYh8IPZeuwmE0XwINCzqaKBc0xl8J4aSVGGZ7NmlF0KxDTgZ/kQ8lyjbEJU0lOtK0jDEAmTYKszR3Qgk4UnhCveZzTFtNsWCmD+zUVEjVWWHVQikWBGWzo28eayzEeSgNZzBQ8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIXidAwpSnMm0/qxr+8/a3b6tuNvvuEtBLTFoKwInCA=;
 b=B27dtp6OVlN3jXMNlQNaAv/kksm+dyv/s7Jk52qK3KBaVZfY0B32vNzxKoK3OQU6gfmRgLa6q441lTXdEzgVCuzms1BK+he5RBMrf3OzIxsBnWOsrKQsehYpIZpoI7vwbKQeqIRtZ7O1za5KEO0LoXXPKY4JC4l69UtBnbYZb5vKiGEFWn9MYb8CmYiWwvdr5fzHgY25trVQO0gqABPsso5EjKbwxJxiouR5RfUycOYpmqgTYYIienV4FJ0mhSPcy8JHTsSQB0mdfrHw9sgfRcM+0fw7ZpYoxJ1z54Ta9OkSSryKXeoX+yLPXB2gYSnncdQ2QSWSPEjbkZ1v6tDyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIXidAwpSnMm0/qxr+8/a3b6tuNvvuEtBLTFoKwInCA=;
 b=LGVOLfi4TwhQ8auWhmARPEf4s1PwcQntqJ2mmrcTuWhnA7Op97o1e/weSKZV5echJcZ2jOkwsRXepZlO0aWrTR7ZQXBurp8llLjBSHGd/QTDdzphyLYzGt2jGkavZgM1uJebc7WB5ngZZbeYzw5kXEF+W+2+Y52qkeKB23tx+8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by GV2PR03MB9355.eurprd03.prod.outlook.com (2603:10a6:150:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 09:56:26 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.030; Fri, 19 May 2023
 09:56:25 +0000
Date:   Fri, 19 May 2023 11:56:21 +0200
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
Message-ID: <20230519115621.2b3f75e2@luca64>
In-Reply-To: <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::12) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|GV2PR03MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d80db58-c8d7-4584-6f4a-08db584f4f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDZxBNnuvFplZEXDfmbSznBSuJFx5aNLURCIwfyJliOrfmvqhDj+RlJcZt6PvWtPYpsZaadSlViiqOazkm3bIrOXA/MT6V/7qvOo2XCJo6q9KBZah30kXdclUTDpOpQ4j0xkcrwrGP3GlJJ3mNMz3o909jjS3zTSs/pvFEREcB5TDbBD+AXFXjwIgyWERNvgeRf/zBqyy4qdIWbZBfLckCeWV8bWIS1EXVcLVdWwnYPI0ldkW2yb6OKbdYbZpNIsld/D6upa7UgXT0a9QfGb/PmWZ5mlFaeJFHhZCSVoCTiz8oL4q9ecjEJWqIdWvTI3mJLIgbA87utJx2gHKt+YdfKROp2z4KSGauktvepm7bRFH+5WZMsoGVxnF/2HjaB9aR7lQL40eQbvrxV1ZYChqn2FYSaGGuHPnjN8L8Fhg8Emab1qk70aljYgpiZGQ2DoGway4J8Q+4VSxzr34abj9i0xmpke+F1eHuFJJdDHvJkLHznhP3N/UMSd25Lj41k9CcJEJwEPvIKhggQvcrmCxzLZckCznRiEqHALoy4/rdn1ROh0tAEBQ3LebJoW1i3E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(86362001)(5660300002)(41300700001)(2906002)(33716001)(83380400001)(41320700001)(38100700002)(9686003)(186003)(1076003)(26005)(6512007)(8936002)(7416002)(8676002)(6506007)(66556008)(66476007)(66946007)(6486002)(478600001)(6666004)(36916002)(54906003)(316002)(6916009)(786003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JRrHjlVz5V/dpVjuIsMQHvK/Fc6awPdkjIzsWMbBn283UH4snnSgVePcrb7X?=
 =?us-ascii?Q?J3m4obW45lGfQgk7UdV8k/jVdVHsA9RoKGiIXOkMltD/iC1w1iSnaJz7BzUn?=
 =?us-ascii?Q?nkMrLgjxXEliEIs/3DRso6SbU/Ev+l5xdrS5GQrRtR4W4oRuj3wyscDyum2N?=
 =?us-ascii?Q?/gwm4ne33UBr82QlOAi4BVFqyzPQoQsK4Ge/8v2W3Kjhy2L3lY36isXscnsk?=
 =?us-ascii?Q?RY1NtaAm3mL6ZEQHCl/XgQATSdM6Yvv+4nOC9sy2rbfD0wm5OH9WFcL0BncH?=
 =?us-ascii?Q?79v5yq9EMhNnxoli7QXSQYy/eg+aMpyIWAdwtIiBhPlV+TOgT1UIfHvoGL/S?=
 =?us-ascii?Q?RV0h9mETkTNIC2opNQdvzm+t3KVWkF8ZFCVIp3+hJw3rOe9rewTHIDAVQ7WV?=
 =?us-ascii?Q?DahtCeph+zMA0P6GaXPogbKYyUc6Z2lSl0DsQt6IRBpRZqLwJ9A0Y97t7+/2?=
 =?us-ascii?Q?ui3iLcfQtk/W28urRH8KJM9eAPLACkPDF87RdKhVd7UwJNR+9C0GcLHFucoo?=
 =?us-ascii?Q?wPRVzhJ9VZU7CRFKg7DvFPBCMQHWimeiTPfyM93aflh4WoJf7WLC9lBDosSP?=
 =?us-ascii?Q?6gxzpgLyx1JGx2iwER5VHPPAnGveASYQPCsqCZb7oyb1jVr8JXKy8n7J2VMM?=
 =?us-ascii?Q?P8+XFwMPuJUrtA06eygagpwQuMO2kGp7bWCPXWFVnVlXd8UBfHyq/ZmJ1TtK?=
 =?us-ascii?Q?kJvMH7io25Kz54AtT6qihhn+a5cw2x1wbwNWRGjAqqke2t0eVXbeAXEpTdvF?=
 =?us-ascii?Q?n1klkYV5KBq/MT9BpypgUacuP4TUng1GXKKIy1xc8T740Lk54IpYS9+bvngT?=
 =?us-ascii?Q?Os51I+3MrdeN4v2Sj517t5z1uFX7FjwmUAjgDYhNTteh8HYj2u3bHh0wc29f?=
 =?us-ascii?Q?z0pow4++rCvwGF7qC90WMnltmg7ieBeIfT23g486vMTjgCAPfkmEGGbA9jCo?=
 =?us-ascii?Q?BKPDuiDW5wIDYSckVd1wAKUb7zccEeJzBkZRgIizYCn2iHQ9are5iAZuWZt/?=
 =?us-ascii?Q?7ka31c0OuZ15n7FXQPsgihQ+EY9zNo6f9/+wZ5e8HCyX0X2tMGKWJJqGOoX7?=
 =?us-ascii?Q?CfLUOQcjjLQRhuTqWZ/gRLlPEHpgSapbSYJKdgI+MFx60CJ5alWOqxuXpMAw?=
 =?us-ascii?Q?/azNtuOGtgOe4f2PEyB4l8dpW7e6qoBGSafME8cZ0ZGR+12rDMHSkKgq6/Di?=
 =?us-ascii?Q?hUMjgvNDe3/GRSCNIzLbqVF3joLBjI7pjaARRp8MfHXE9NtqqrKrcL++f6+N?=
 =?us-ascii?Q?VPKz/80TWVvmIOycQFXU6qfa0IuKBHelzRC5ox3bcHb4jHaSHEDZ7h492eT7?=
 =?us-ascii?Q?8zJfZl1uqGBAbGFlABepP/UZrh0vIMl5NBzQkxKvxnNaeqWxpw8QjkxzBiOt?=
 =?us-ascii?Q?M3URDn0++lMEmJute70a4HTfNpqzSwEb0FZZZtvISuL5zqXaFwf/1EmUoN+R?=
 =?us-ascii?Q?Y8aZHv7Rlx8RhriCrKZebAGI5nYJQ/1U7LG4mBJQEgtPFttvD1A5j77rUA4f?=
 =?us-ascii?Q?gme/HDxe99ijzwtQjBxfYbjxtfQNNIiyIbbMX8Kp0tlRcemLAowDfRJu2Li5?=
 =?us-ascii?Q?8Kc7RXZLzQwOOq1uRP+iQ0t3lvVXkefLIGMfRFwNksbzRel8/FdTudAphdly?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d80db58-c8d7-4584-6f4a-08db584f4f27
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:56:25.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvV+HC2GOZJhXgB2SttPO0BjWhvTNf7unoDYlvyeg/ETphdZVf+2ZCORfd722ePT6kjQLcZ8f+oC8+ykZnTz8i+U1h37FZK0G8xWxUHIW5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9355
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

sorry for returning on this discussion, but there is something I still
do not understand:

On Tue, 16 May 2023 11:08:18 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
[...]  
> I had tested this and it was reclaiming much less compared to the
> first one. I had 3 tasks with reservation (3,100) and 3 cpus.

So, just to confirm: here you have only 3 SCHED_DEADLINE tasks,
scheduled on a root domain containing only 3 CPUs (dl_bw_cpus() return
3)... Right?
So, the utilization of each task is 3/100 = 0.03 and Uextra is
1 - (0.03 * 3) / 3 = 0.97.
And since all the tasks are always active, Uinact = 0...
Is this understanding right?

If so:
> With dq = -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt (1)
> TID[636]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 95.08
> TID[635]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 95.07
> TID[637]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 95.06
> 
> With dq = -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt (2)
> TID[601]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 35.65
> TID[600]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 35.65
> TID[602]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 35.65

Here, we should have
	dq = -(max{0.03, (1 - 0 - 0.97)} / Umax) * dt
	   = -(0.03 / Umax) * dt
which reclaims up to Umax... So, the utilization should be 95%
Since you measured 35.65%, it means that (1-Uextra) is much larger
than 0.97... So, maybe you found some bug in the Uextra computation?

Can you try printing the extra_bw value, to check what happened?



			Thanks,
				Luca

> 
> As the task bandwidth goes higher, equation (2) reclaims more, but
> equation (2) is a constant of 95% as long as number of tasks less
> than cpus. If the number of tasks is more than cpus, eq (2) fares
> better in reclaiming than eq (1)
> 
> eq (1) with 5 tasks (3,100)
> TID[627]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.64
> TID[626]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.64
> TID[629]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.62
> TID[628]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 29.00
> TID[630]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.99
> 
> Here top shows 3 cpus in the range ~45 to 50% util
> 
> eq (2) with 5 tasks (3,100)
> TID[667]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 57.20
> TID[670]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 57.79
> TID[668]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 57.11
> TID[666]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 56.34
> TID[669]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 55.82
> 
> And here top shows all 3 cpus with 95% util
> 
> > I'll write more about this later... And thanks for coping with all
> > my comments!
> >  
> Thanks :-)
> 
> Vineeth

