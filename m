Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A370536D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEPQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEPQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:19:42 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2058.outbound.protection.outlook.com [40.107.247.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E6F5BB4;
        Tue, 16 May 2023 09:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln2C1jg/sxCTzkmS2PaORZIQ2opbBeKSV5DBZfKrfM1ZeBDcVzoAaiH7hcnfGLgHc46HNfmLUUwEj6lFzKpoC+0GQoYn9rBcmeRvLw3PGlJyuaWT/2qO9EFTZz82DZ95frCFf1mt6IuUOw5SbwABn25y0S9vLSFFTkIlXNr/VzlzfxMvlrM/lAy8n+YoYjEsjHk6ONCh0SHA9DsAqTi0kSEI8QACadrv/jJkehCgWHXUj3PPXp5QJYm65Ce0oLbaI/+atqafWjkiqMCGJL8yLRTMVEW7mtafYKdgh5158SBa7Ezcw7p2/BADTwhPf4SrWajq4zuQMUPTmA3bXfzLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuE24viKMmBJe787zVoqogLjQqdp5I1eGg2Ah/qcFrY=;
 b=lJZCaKEhHtMEvoA0F9ElO1p6tinSsKGf5+LkWP0ltoVrM+YNA8UQCIqNbq1IVR8baFp7LlyxMmBhuQ/WLLXbZWPXadtBohAkmknm/D5ai8zcifC48OCR9ojjS1gUAd7LkgoCSG3Y5TAIR/LyjxN7Tt2SlVPOfSswwD0DFz1C6dQbv51sjvJqViRMa7fK/mvCK+U/UVZ8QVQZwCIyQDFSztejYkDI5M7vCbh8h5KBEVYkcdmTPOv1vMBvbRltmkR89kp3nDAfRbn++G0NW5dR00qFhTMujTCZejA/EEJL4b3QGOcYAIPMm63QoWHlth5Ax045/jvoBvj+MOXQilO+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuE24viKMmBJe787zVoqogLjQqdp5I1eGg2Ah/qcFrY=;
 b=INYpd4u/dfUQegUx/2SbEpHM+PozIWpQqkuaNCgFnTwt3tOo/aZIvmi0XGTIVoSXoPia5cuvKnx558uXUNzy7abt4UUtkP8SfSGuJLXRjNQuOJnfjsBXyEPOTt6A7oL92oiS6NRMJqk71fRfI+WJaMRvWPzdDbxOh2HA9XvR5hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by PAVPR03MB9382.eurprd03.prod.outlook.com (2603:10a6:102:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 16:19:35 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:19:34 +0000
Date:   Tue, 16 May 2023 18:19:28 +0200
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
Message-ID: <20230516181928.1991acbd@nowhere>
In-Reply-To: <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::19) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|PAVPR03MB9382:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cc7c23-2a50-4ed7-0bdf-08db56295613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Co3MrYK39+qgDYcTohjbViFGhpJWAcM25g+w/eX2tbbGOPnKoFieDtmPI7572Rl9ZzKsI33lLrdSOPOzIosbgtiy01J+5bUCVjwAutSJokYagVYNIZVNbQigQrN/9La6w4drrS2fCFBZgBcjQ84Qzk7NiYPYtrDmHqZet2rGGFt32rArF9VXEhKC5JSlXqDx44cBd1tXsBCwMJ+qdHM3TLLEhzvWurjxlxYFm8MvzfQUL0OJSJUyFtS/JsV0J67fW07FTShUO9V10tC+7wgFJXz+vV7330mStxO9vuFzN9IrQuTXZY2OnYcsg8J9ahsu211l6zfNzRJTsOqW1Sv4k0ERtRDeCaAwJ0CXdPHB83YEjJYDZuYyKD0pGRXfhwGc6W8qWCg6b94mEpb9MhjXsLskO7yskIQXYb3eHy/2KM/m45CdY6fu/FRdn8ToaZnTWaXVpvwry0/EtjnZ01DMyyRPEr7TI/lpoU1poRv0WW2l5/+DvFNz5gCsTE0ymsy/yyxhFNDbjy0C69mtCNbIE2PIjU7pITI051DP2IFhVRCtQvrbJGkcIMi1uz5XiVY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(54906003)(38100700002)(2906002)(478600001)(8676002)(86362001)(41300700001)(8936002)(33716001)(41320700001)(7416002)(6916009)(4326008)(786003)(5660300002)(66476007)(66556008)(6506007)(66946007)(316002)(6512007)(26005)(53546011)(9686003)(83380400001)(1076003)(186003)(6666004)(6486002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JnUGNiVnpxdjRZWU05SFVrRTNaZnZaSXVpN24xUFNTS0swMEorUmVncjB0?=
 =?utf-8?B?aGV2bnArQUwzSVRoVWNDU0x4WVVwVDdsdVRXRHNLVHlPeHJ5bHM5cUdBN1R4?=
 =?utf-8?B?V2VEZHdkMTQwU1JSQS9rQk9LakdvVUNLdlJtb0pva1lKTWFjaXI5R09LVDRO?=
 =?utf-8?B?cjl5T2ErNGpiaHp6NWtPdy9nRUhNQXNHeXZSdi9Vd25BQ3N5MGh0YnJVTkZ3?=
 =?utf-8?B?Vy9KM25UcTAvUkJxT2Z6K0hSVXY0VFlSTlpkeWFZSEtMLzFnbGtPSExHZWlR?=
 =?utf-8?B?NlhOeDZENm9wLytOZUREM01ZdnhoK0VqNlA0Y3M0aGJ5dGFsL0xUSnJDNzJM?=
 =?utf-8?B?RGVabXRCV3dmZFZHK1k0NTJZUUlDSzdTdkMzWjVtaENvbkRzYWdFNWVOb1R2?=
 =?utf-8?B?a3oybHd1ZlRIb0hPTkwxSlB4QnIvNE5NR25TalFwWGsrVTJrTHRsTVlQRUxI?=
 =?utf-8?B?Zk4ySUxZZkZFSE1LVVE4dUNnMTZEeGNkUlZSY2l2eW83RXhCeWVRSlBjR29o?=
 =?utf-8?B?eGIvR2h2RVRwTlhWdTNpNzhrRUdMNXM4aFp6VjNtT1ltQk1sVG9GRHNraWhS?=
 =?utf-8?B?SWFVc0RsWGE1RmVCMjE3amJiMHJkQkZuTUE3bUtWYXNMNzRCRmJnNDRTMnBO?=
 =?utf-8?B?MmF0OE9OeVUzMnFtaG9CdWhCaGhwYzlrR2hPWGFuL1RPTHNJUDNxV0tTd3R4?=
 =?utf-8?B?VEp3TUxJUlNWbGxCLzlZa0pJR0M5VFlBdU05R1VQWENEVGNKUFFWT2xzeFBC?=
 =?utf-8?B?K2xqTnAvWHhJdS9HOS83ZFBWWDcwYVFWNTljd01GdWNMMHFVOFVMVytoaUxv?=
 =?utf-8?B?a2Q4VkFFN0NXUnZ1NUZqSHgvd1Y2NFpOODF0Ny9vRndwMGJpSFcxTWRvK1Aw?=
 =?utf-8?B?NXdlOTN5VktSdEVJUmJVOGpiWEx4a3BTci92cHk5dDBueC9HL2N6WG0wZGo5?=
 =?utf-8?B?R1BhYVdWeXJSTHNlV29tYTNyUTNhSWpSUFA2K1lIMlNvTkdhc1VtTU1RNUdi?=
 =?utf-8?B?cFQybDB0T1Fyb21sMUF6TWhyeTFKTlhCR1lnUmFCbHpKVWdhc2VqWWg5Znk0?=
 =?utf-8?B?VldZMFhHbWhVc2hwRVpiTG1WM0xFQnptWHlxd2xKTU1lS3VGVXgvWGVZbG8z?=
 =?utf-8?B?YjRrWFV3aTNkNnpaa3ljckNuVUxsYkhFOHNBRGZiU3k4bVgyTkZZb1doaGoy?=
 =?utf-8?B?RzUvZmczdm5GUnJ1Vmt0UU5kNUs5djhVdDI2TVhiT25LWDh4STVpNHozQXcw?=
 =?utf-8?B?MDJhbWYrbnYycFN3NjFxNDQwT1lud3NZSFRRU2dGMDRtMXl5ZEhPekptWGFH?=
 =?utf-8?B?M0NBcHZRemxySFNCa3UvemIyeFdhVVEwZjh1Y3BVRWZOeDdXdmpaYnlibjg4?=
 =?utf-8?B?d2dnUTUzM1VwK3hxSHNiYXlVYVEya0x6SVZTdUZIRjVhU1dBcUFhcmxjdTZH?=
 =?utf-8?B?aDZFVFZIRHpxNld5clJQT2dPN3kzd1N3L0tjcG81c3B5c25kcktGUzF0NEk5?=
 =?utf-8?B?S2FjMklqZGpIRy9YSDM5NEVvM2xlMkM0aTlyVks1V0s3eWhiN2ltbHNDVmJO?=
 =?utf-8?B?dmlPQTgvWXhjRkM5N0cwQVRKSjZ6bUtjYmpzV1ltOVJ4SzVaTnhCdWphUHIx?=
 =?utf-8?B?TUY4TnlqdnNhY0Nla2hyV0lHUm1qczNuaW1YOGxyNERNLzk3Z2tyTXRhc0VG?=
 =?utf-8?B?M3d1NWxmUlVoMUNFaFZ0bzJXMkpmc3ZlMFl1TXVTalJtMUdBZURHTUFBT3RM?=
 =?utf-8?B?YXA3QW1TQ2NTUjJaaFh0M0hVWldTRmZSMkFWc2MzQTRHRHJsRXJVNHhYcUxz?=
 =?utf-8?B?aEQzZytCVForNFozVHpHamtJdTlONGNIUlVCTytucEdkY2tYRVlkS1BXV0ZB?=
 =?utf-8?B?WnJFRVExRTJSZXlZb1hkdXpyMVFBaVNmdmsvMnQ3bzQ4WVdLUlREbGplV2V4?=
 =?utf-8?B?Zy9Yd0xMdDBiaUpDejhCZnpiYVFTcldTT3ZiZmd5bTN3NlVDNndFSmlleXRm?=
 =?utf-8?B?RWZQMlgwaFN1b1dZdmFZMzl5SG40cHF2TURTeGxOQVE0U25LUmNVV1pFcUU2?=
 =?utf-8?B?Y0pmdFN3S0EwRXBPUlJHS2NnWVZ2dzhia0xZdmQwbXNCTjBnYWo5bm9WS3ls?=
 =?utf-8?B?UklhR3BZU3FMNDVHQzVzaHZodW9aZ2dVemtmR0JucjRvNDczZGFBSHpnYk80?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc7c23-2a50-4ed7-0bdf-08db56295613
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:19:34.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYsnHgRfpo8ZEidhxx65O+WwoIEVvORmelX99sJ0sUoO5FGKyKHnaqpRXaPWUGK/By0Ph4uuV2ROlgV6W5GYCywKRIODx9ZJO69l87amQj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9382
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

On Tue, 16 May 2023 11:08:18 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:

> Hi Luca,
>=20
> On Tue, May 16, 2023 at 3:37=E2=80=AFAM luca abeni
> <luca.abeni@santannapisa.it> wrote:
> > > I have noticed this behaviour where the reclaimed time is not
> > > equally distributed when we have more tasks than available
> > > processors. But it depended on where the task was scheduled.
> > > Within the same cpu, the distribution seemed to be proportional. =20
> >
> > Yes, as far as I remember it is due to migrations. IIRC, the
> > problem is related to the fact that using "dq =3D -Uact / Umax * dt"
> > a task running on a core might end up trying to reclaim some idle
> > time from other cores (which is obviously not possible).
> > This is why m-GRUB used "1 - Uinact" instead of "Uact"
> > =20
> This is what I was a little confused about. In "-Uact / Umax", all
> the variables are per-cpu and it should only be reclaiming what is
> free on the cpu right? And when migration happens, Uact changes
> and the reclaiming adapts itself.

Sorry, I do not remember the details... But I think the problem is in
the transient when a task migrates from a core to a different one.
I am trying to search from my old notes to see if I find some more
details.


> I was thinking it should probably
> be okay for tasks to reclaim differently based on what free bw is
> left on the cpu it is running. For eg: if cpu 1 has two tasks of bw
> .3 each, each task can reclaim "(.95 - .6) / 2" and another cpu with
> only one task(.3 bandwidth) reclaims (.95 - .3). So both cpus
> utilization is .95 and tasks reclaim what is available on the cpu.

I suspect (but I am not sure) this only works if tasks do not migrate.


> With "1 - Uinact", where Uinact accounts for a portion of global free
> bandwidth, tasks reclaim proportionately to the global free bandwidth
> and this causes tasks with lesser bandwidth to reclaim lesser when
> compared to higher bandwidth tasks even if they don't share the cpu.
> This is what I was seeing in practice.

Just to be sure: is this with the "original" Uextra setting, or with
your new "Uextra =3D Umax - this_bw" setting?
(I am not sure, but I suspect that "1 - Uinact - Uextra" with your new
definition of Uextra should work well...)


[...]
> > I think I can now understand at least part of the problem. In my
> > understanding, the problem is due to using
> >         dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt
> >
> > It should really be
> >         dq =3D -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt
> >
> > (since we divide by Umax, using "Umax - ..." will lead to
> > reclaiming up to "Umax / Umax" =3D 1)
> >
> > Did you try this equation?
> > =20
> I had tested this and it was reclaiming much less compared to the
> first one. I had 3 tasks with reservation (3,100) and 3 cpus.
>=20
> With dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt (1)
> TID[636]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 95.08
> TID[635]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 95.07
> TID[637]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 95.06
>=20
> With dq =3D -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt (2)
> TID[601]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 35.65
> TID[600]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 35.65
> TID[602]: RECLAIM=3D1, (r=3D3ms, d=3D100ms, p=3D100ms), Util: 35.65

Maybe I am missing something and I am misunderstanding the situation,
but my impression was that this is the effect of setting
	Umax - \Sum(u_i / #cpus in the root domain)
I was hoping that with your new Umax setting this problem could be
fixed... I am going to double-check my reasoning.


			Thanks,
				Luca
