Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7563A4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiK1J1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiK1J07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:26:59 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7543C59;
        Mon, 28 Nov 2022 01:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R18hMwoJ8c/6TQhqK1K7A3T16S6lgM1Nq/JPI0qo/dl9qer9A2fLBjYPQZp23GL4GTLY1DKb9lPZ36lJ6B3XDzruG9Lrt7d9xBRjFnS69yZA9/sboXUJZAa4sEFVJXOawMrr1cJZe1xPnBwQRae5CRK/eZtO3VwgwwABsQjW4EukcAM+oGjgI2vduJlp+sk4823NU4YCCG5XGIaNQbo81LMyxq5kPr8C2WLceg8YtF3s0SQJANzo0h9GmTf9hHkKtBtc/3sm1N6uqquCMEhjyAIEnQM7x8V5cO3mNedpAZmK/YVNavl57kdLb6VUgKH/XN17dXy80gc0FH45v+6p6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NwK5xO7f/CqvfB03ZxG6gGE9d8+SgY5eIUqo5Pf1MQ=;
 b=KFkn/X6pfKhGkEKN87gdKxgDIjpVr40SV01XiFk1s0EHohS/62QEzLvdk+cIyxPpmCKHWgz/wev5CQpxkH73f9hx2Zd8HGUm06FE6Om9yi5WnXOQdohst2/CJHgwYXM4fKw6MbjdFc5HANJzS91G43HXjaKjofkSqET/7+ohhugDP4OSYbT0Un+0qpEAOX/oPqYRE99A6RdJX5Sd7yNC9DyR46bMYW8TyCCaDdgMVmB2AAizibjJrjLEbILB3Sm9DRf3oXVNyyYpEUYIDzXxErdv2uVVhvLAreEkSRoxQxuaYp0IEkjzQGxgNkZ6i5tq1US63iJZ+HNjzTd7DUrDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NwK5xO7f/CqvfB03ZxG6gGE9d8+SgY5eIUqo5Pf1MQ=;
 b=2/sSCCRPpIeTbhPyMDb7mESh8l9hAhauB/s/s5EtBXmQ9TVjBZvr7WMLB4wNfOvxCQ9+WKVCh2XwGyhZ3LKby77TPGBjvJN26dwsbIl99xHu7xgqT7dNJWorGWs1QnVe3NoPahqM/6mqlW5wDg3j2MuavWundzuttzTwqtKH2KO/MHbCg7avupYP1Nv4QQ/FpZ0p9YEqJsiO9mI5j9m/uyt5ScMJ6NXrWN8qKLhf3EzYBPhZkEp9rzCgh8bN0xBJyUhpbyxvg8oTlhwcc0on/hBv0TmanWnILIYKKzQ6wJ6yD5nG76d9K971OuR097qYkTr7nMyFzrg+51LwcT9YLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS8PR04MB8914.eurprd04.prod.outlook.com (2603:10a6:20b:42d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Mon, 28 Nov
 2022 09:26:54 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%7]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 09:26:53 +0000
Message-ID: <a5504a76-d59f-7b5d-769b-8dd0539681c8@suse.com>
Date:   Mon, 28 Nov 2022 10:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 0/2] ALSA: core: Fix deadlock when shutdown a frozen
 userspace
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, Len Brown <len.brown@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS8PR04MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc849b5-03e2-49d4-d275-08dad122afbb
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwDub4225NYjF8XHGqwGUN3MIfAzBOjSIvYV5myRVbT28t3TQr3cj0xz9GvmMOKanRXHgnMAyHWlaiXm5+HqEQZNt6e9cwIV+UtaoKB979c4iz1kvfZhuKniyOuxKWaJaPjctScuxbcxm0RIDMr7dQjXyLAWXsFeh63PYJTj3NDfJG5FJM5gWp266EA5xpAx01qu0CCzZY8J7oft/q2L31jsJpQtAdWhaNff1NJt15bfqQhB+QtGATV97BhnbX2C2qGovtERKOkcoHsuzrd9bBpFmisL96D3EDWyO+U7nQz0VU3q/WN4U3aNPj597BmBFJhqnN1vY+lewH3eaV/OyDkP2IGGppo1JI/+StSir4ULEz6ZtjHdsmScGBcBRJJs4bFDy51oxlv4SPAghI+/0RUnVFo7vISY3yLYoz52Ib5zG/hl4jsxhXAsjT55J9xnSm2316DTu556ucEjH3uDGBOWzxrDJRb1OdmuBNsJLVpkc4OXJJhKEGIpPY0AWxdxtncLrAy4mYsSH/PhRAz4X+8ZbAa3j/fdzv1MNkCvelnRfRc80P1s1Ggc6nAwl12MOkCSjwKg5JM9q2aLgiO3nptOJ+cRLdjzzZw8oi3+TV223aIrq2946L00+EcZ1vzWPSYK4/yMfVDp6v4fafZBUnsxZ5PunaZd4SZXdg6Y3PN7c0RVHoB80/3j4IisUhF+4jr1S/IfnmE2oWXTeKjfBVEGdOMZJDhescm5uy2B/HP+anUaX5Ynt+q0Y+InI3Wj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(36756003)(53546011)(921005)(6486002)(6512007)(6506007)(478600001)(38100700002)(66556008)(41300700001)(66476007)(8676002)(66946007)(86362001)(31696002)(4326008)(4744005)(7416002)(316002)(110136005)(5660300002)(8936002)(186003)(2616005)(31686004)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9nUWhMQ05XVmp4cXZkRUs3MXZLNWFhRUZjeUUvbUlnVDNLRFZaMGtyUjhG?=
 =?utf-8?B?Zkg0S3d2UWFzRk0rMnlEZ25SdFpaNHhTaHhqekwzdU5RVFh0NTZPbGl6QmFz?=
 =?utf-8?B?dFJwU1dqUHUwZjBQWnUwYndLSkNQOUdCTU50KzdZbGZQa3pDbXBDREduRExj?=
 =?utf-8?B?dHlEUHVVL3hRM0dSejZyZHlDbTZSS2lBRVZkYktyYVpJcXNwUkdZOXNJTG5H?=
 =?utf-8?B?THlDQ2JzUlNZV3laazZtcUJZS2N2REhoOUdSQ1NzbVJLeFhqZmxlUmNGdnVN?=
 =?utf-8?B?MzNCOHhwazA1cWMvcVYxZms3Q0tycjNyOGdWTXA3eitleEpaZkpkeTdVVFBS?=
 =?utf-8?B?dzB6UzJyeGx6T1U5Q2IweVJuV2Y5YW4zODJNa0d5ZHVBbU9xamI4eDZDVFhU?=
 =?utf-8?B?SnZkMDArTjdsQzRab2RaNFhQUStwRTVubmJDc0NVdzFicXVzMVlEK2F1L1hQ?=
 =?utf-8?B?YVFaVC9FSkpVRHY3aENSQXRjcnlMa2k3ci9aYTM5cEUvdEJSRDI1c1ZsV20r?=
 =?utf-8?B?U3lHL1haQUFrMGJGOWltTDhKS3A5YUZMS2NVYVpodU5JcUxiakhOUUk4TGJL?=
 =?utf-8?B?UHBMTkJIbzdIdk0zWEg1MSsyZXpCdTczdmpEQTQ5bDRwMjlOK2s2TlI2NjVj?=
 =?utf-8?B?enl3Wjh3R2wwckliRnJObUJXNlJXdWlQY3RrclFvVXlENmFnRWdQTnBRQ1RK?=
 =?utf-8?B?b3VlVDFURDN0b1JIakdIMXpYUEZEOHN3WjJCS3R2aHVTY2dKRU1UbmI2cFFw?=
 =?utf-8?B?UlArZldNdXR2Z0g5S2RTcXJFRlF1UW5xeW1BSUVIWVdHcGJpa3pYMEI5WFZp?=
 =?utf-8?B?ekdEZTFpVWc1MVlaS2ZQZEpySzF2Q2RKRU16R3NlQzh1K2Y3SWlRamJnY3NI?=
 =?utf-8?B?T21zaW1YNnJHdWtUOGN3andNNUp5UCtENzFPUzVqamwyblZnVllJQUtEbzda?=
 =?utf-8?B?bjZGa3F1NUFPcHFGNkovYzhOUkw2ZEVpYVFOK0dGN3VwQ1JXUkMvM2J6TENZ?=
 =?utf-8?B?Z1MvaENsVlkwc2Mwcy9sV3V0WjdvSStZd0U3UGVoUnY5b2FRM1NmZ3F4dGcr?=
 =?utf-8?B?K3VBNC9udkhPeHVxbWQzYWN4UGw2VDlEV0dmZWVIRU9JdVBqQ04rLzNXQW0v?=
 =?utf-8?B?YnlUakRUdUZ5WklWM0cxNENieTlONVVpZmZVZjI5OTJIYy9udStra1FZaTJZ?=
 =?utf-8?B?My9EUTlqUHRVTkdMdmN4bWFYT1BwdG53YjBQYlljYk9wUmtTd1liRVE3RDda?=
 =?utf-8?B?SDEwRDdlemxWcXMzc2tEUUJrM2JHYzU2Tklkc1NSZ2RhbUcrb3dwUCtZUk42?=
 =?utf-8?B?T0ZsY3RLOS9XT0dVVTEwTE1DaHljK0R2T04xVUp4WlpzRVJUU0RrYklMWS83?=
 =?utf-8?B?Um5ib3dFWkxwRzA0UGNreUZrU1JXb1NyZG1nZ0M1citmU09nUkR0NzByTFd6?=
 =?utf-8?B?M1MzRDVjT05BdEVBamRCcjZBaGMxOHlnNytnWUFFU2Yvc3k1NERZK2E3QUVj?=
 =?utf-8?B?NXNFbXVhckhRcmh0UmdBZC8wbTJCV3ZLSC83bHNTdzk4V3llV1lPdUxjOVJw?=
 =?utf-8?B?cDIzVUNxLzc3UkFXWXBTY1RFdzJGZkJEMUluZTlEb2ZaMy9FOFk3SEpnYkZl?=
 =?utf-8?B?bHBOeHltSkFBcnFTOVdya3hhbXhMTUJRTE10Ky9aMzdhNE1hYVVNQXVYQm0v?=
 =?utf-8?B?Zi93RUI3WDBRQXFHUnQxVDZXUjZ2ZHZWK2Q3b3RaN3RVeWw5b2VVWkdFQ0FH?=
 =?utf-8?B?ZWhxQ0ZqckJrK2swbUZnWklmRm44ZEpaQXIxcVRIa21WcEdiT29OODZveHoz?=
 =?utf-8?B?S2dIRk1UclBlZ2QrNXVRSXJ0eDdNOU5MVUtXUmF1Rm1HLzZoQWRtKzlnMFgy?=
 =?utf-8?B?OFlvb3FVL0hLVEhkNFBtZ0JWNFcrcldXVWFvYUtjdXRLdHc4R05LM0l6cnVp?=
 =?utf-8?B?c0ZwbHJ1dzdYODE4OUxsMllsK1B2ZnNUTHZKc2srbXBzSlpLV1Y2YVVwTlQ3?=
 =?utf-8?B?MWdUUnB2cHJVK1JXdk83ZzVLUGNUY1BvZzh3MnpqRVJMSzQ4UXpVSXdKZFhD?=
 =?utf-8?B?UjNoQzE5Qjg0dUhPT3J2SkU0YWtwRDErSEl0bUZmTDYxbjJOUzlIczhhU3Zu?=
 =?utf-8?B?SmhrZlk1YmpuRTQzZldrNFNRWEwrVXE4VVRldFhHb2VmKzAwZU9oUjhFa2U4?=
 =?utf-8?Q?9dqcMk7qK5EufEmeeDq+G9x1e+b9vVa27Or5ucV0BFEQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc849b5-03e2-49d4-d275-08dad122afbb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 09:26:53.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp/jsWixJ0ovAYIlqWllAks0jZsiCI1s+7iAfKmcLMPaRcWVbcLih72HhRU8Dys4XYx9ltklp86f4KSoMII+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8914
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.11.22 10:10, Ricardo Ribalda wrote:
> Since 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
> we wait for userspace to close its fds.
> 
> But that will never occur with a frozen userspace (like during kexec()).


Hi,

that means that user space can delay an unplugging process for an
indefinite time. And that is a problem. I am afraid there is a problem
with the basic approach, even outside of times user space is frozen.

	Regards
		Oliver
