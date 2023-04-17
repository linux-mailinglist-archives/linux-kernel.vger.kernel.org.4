Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106BD6E429B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjDQIaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjDQIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:30:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC67420C;
        Mon, 17 Apr 2023 01:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU4+plG9V82D9DKgnS/N2VTTMLpgAR1d5Rt2xF6PTCon0hNKHWCeNS+iNyoAU2uBuo/SYJVx389LE8whpxnUZNr8mG831yJrlFJCg2YkZdYUyoiCUbA3yZW1Y7Za7qXe5vvu5/q8+DEulDHp0ccTTZ6AS77kNQk2a2wL+7Cg7mIO7cpd70FBwT/IpZqtoxKdRx1sDAbuRzg/KlvmxaYDGcFUIaijJ5HQfijZoiFHLZyOjRaJb7OBl7jr618/Q1Pn8ymEXyl5e0JxV2A8QsGIYZzbtfCSg1clykry9xRnS8iHx5JOKm6J8vJRLSCIAF7bn6J9V+vtaY/6cVksRhkydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsCWQht1eGUOk/0KyMsKVHpH6LvoJeGDeRLLZfirIiM=;
 b=Waq1Kud3xfoMiBg5LwlsX7cko9JOFpGwAxJ81G7lrCg6+PRgYDV7/DRJb7AkWDcDdvGOidLaKRtc9rLdOAYcPtzumRLnAlLy5z1IUBYTk7J5AT80NmyX6WmB5c1LmU3fLBdtkHikSw0tSDq3dvzrFicS18S5rU4P/wrQi2L83WGy/uplgZyNNdZrewSqWdVQx3AyU8zemaEPxlzjWT4V8aL1Iyj/pX4d9D9nlp2VAykJfWKS7L5C/VtnAiDb0GqnBE+GlnftS6g7H+Hb+olxCLccEWYDk0au9lu1zSrpWFpgO0Bw5L2+E8Vx6Jo7MhzTuKwWkb5m7E4SZmpeo9aPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsCWQht1eGUOk/0KyMsKVHpH6LvoJeGDeRLLZfirIiM=;
 b=sIHDD1Kr/kf3JfDas3BvdKpw6rYlcidJ9Ocj0j0CA33lhxQ66McRcZwD5VGSQNuEGdNXrmkc4W5RmXSWcnzivDbcRZy6mvDFzKN/85Ue8mZ1T2deqAH/G2AQK2kYRWkOQEwARwGS+XIU+xWXKxbqfFjTMHx+YVSemanh08eRSHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 08:29:53 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 08:29:53 +0000
Message-ID: <3d7b078e-0777-f850-6b95-9dfbff236653@wolfvision.net>
Date:   Mon, 17 Apr 2023 10:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Content-Language: en-US
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0124.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::21) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAXPR08MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b92f9b-23c9-44db-ab48-08db3f1deaeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpNMXzkIoUSAUyEynidn+oKYFIqWk6P6pGrWTd3ODixQ214HXsp5/k/odFHN+vsjBYW5oXZKDlqglo+3u1Eq/1zlyqoweMTqNbY+ieDPXrjtyfQWWkzq7SXv9Ng2KXiTyU3GIndGO41pdVqv//SRLy6xt7Zw+zdjnc5/dfhA7uU4iMfQY71V9N8ZBszUh3Tl5z5cT+nGhc8+HbfmrZMflQlDO7nEIt37nVBq9fwqIRYC1blSfK1cQEgB0r8bSD1fjZnCkLCij/LgDDMHvl7dZWeajXSG8RDjKNkeh93qIHZPhazgB7Ta65cA5OwWgl1jMmzbh3NOVzQQUGPH4WQBmhREuFGQQXNXGApef9D0q2cmQ5A4wf6zzwCS91XNDq07e4O0BHEVDYEIcz9hZ4XamnGuy/Pt3GzwvH0hC7sjEG+AJKLwyJRa5CslsVWGPWy3r+mH1/QjZLC9TeVyWYjHQFUk7uN7DwjHe81BiSlEMGkMHg6qFYRp7mwEARgmtSvTSYoNIaG56AiMDZHr32EAI4tgHqJ573bCNS63L6vdDTFgSLAboMO1ynimtq9QuRwPQmNXNhfxFui5lt4J/UUGi4/+rZvKepaSKVKeYnKFfM3LDqOIKYXG7UikI11k5uE++yrfV1qYuDhc38e+4JK9kbheLacRJUCLo638ST23Dab0jdgLHtvXiAIfP+2BeTWV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39840400004)(396003)(366004)(376002)(451199021)(38100700002)(8676002)(8936002)(44832011)(5660300002)(2906002)(30864003)(36756003)(86362001)(31696002)(478600001)(6486002)(54906003)(31686004)(186003)(2616005)(966005)(6506007)(6512007)(53546011)(66946007)(66476007)(83380400001)(316002)(41300700001)(4326008)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnZNbzJ1USs3ZWk3b1FWMnBuODlURCtzZE04WE1BdFVyTHFhSitMaDVUYUFC?=
 =?utf-8?B?L3cxK0R3TXZTcVNIam9FUDVSSlNYMk5lZXNHNndlejZhZHF1NDJtMWR3M2NI?=
 =?utf-8?B?cWltTXVDZnN0SVgzaFlCbEtTbW04OVVWUlU4T0c0SGVTTFp0OTBrNzRLejhQ?=
 =?utf-8?B?OGI2NHhUZVlsWmMyVUpzMG1kRW5aaDJ2ZmZqbEFjZ2xESE00ZVh3ZmdMNFpp?=
 =?utf-8?B?QjUwUUpqZExIaXVHOGxkL1FyS0haVTZYL0ZsdUVGdForOGthb1VQcVErcmFl?=
 =?utf-8?B?QzBMS0hYUFA2QmRKOCt0Vk1vU0M5UU9EdVFWcDVzUWNGT2NNU1F0a0VYREVj?=
 =?utf-8?B?c20zcXFaRFhyUi90SEw4RmN3eDJKUWRhL2hNYkJ1c2hzcUtDQzFqUnQwRFFs?=
 =?utf-8?B?M2NEcWZpVmxjaGhNUTRXZHY2YkMrcVh6d1l4UTN6VWZUMmtGbjJDMTlnbDZB?=
 =?utf-8?B?STJ5OHV5WGR3MWVTU2N3dy9GV3VWNm9sdDU3MWZNZldlbGVBT3E2eW9YVFRv?=
 =?utf-8?B?U3dKNjIxb1kvenBpQUVJNDgzK0dwUk5xTHZXeEZ3Q3pSeWFlR2ErVWdrdk56?=
 =?utf-8?B?QnFEazl3TktrNUlxTkcwVHpvQ05McmJVMEtrbmVIY2o2R0RoQzRoTFR0bThx?=
 =?utf-8?B?ZExWZXQ5eitUcEVGK2dCQnU3ZTRaY01qclpldEhubE13N2hIbGF3T2dKc0RC?=
 =?utf-8?B?OGsrbC9tY0xUZHd0NC91SmoyVVZKbnV3VnJxeVJOTlZiMjJ5RTZacG9MU0pL?=
 =?utf-8?B?TkV2aDVVVlYveU9zdkNKYlR4alRjTUhwV2VwU0g1ckdWU1RzK3BHTjlYMDBv?=
 =?utf-8?B?bWpwWThPcTJIR28rN0pmOUJzOGlpLzZLZUdWV3l3TDFuVmUxcjRYMFJ4cVpX?=
 =?utf-8?B?Y2s4dDhjUVBCR2pla0txZmRDNmRxa0NYUkQ1Z2JWMUNROW5vVTlKK0drTzFX?=
 =?utf-8?B?d2hKckZzbmFCM1pzcHZPUjc4Y3VGTXQyTGRRakxFMTVZVnRqYmVIc3YzZFRa?=
 =?utf-8?B?cUJFRk1aQlg5SHkvNG5vUXJxMFhMQ3dFYW1GMzIwL3pjUFF2OFg3aXJvZDNX?=
 =?utf-8?B?aURGWVN6aE1GTkN0Q0MzVXk3ZzYzd0ZpR3lxNXRFNkJrbHJEeG5DczFGT0Mz?=
 =?utf-8?B?aFgvNzdER0lrZThRR3ZaYTBzQmNieFFmS1Y3dVF5ZWtsSEFHMyt3WnhXZUZz?=
 =?utf-8?B?Z1B5bDZJU0VHZW9EMjdxVjZvUUkwNUZNNElrb0tVS08xZWJIb2R6NmdvdzBS?=
 =?utf-8?B?KzBONG5uZ2pFNkRtelJMc251T3RBVXZRcEZJTDFaYVMvMnBVaG1JeGtDeGh5?=
 =?utf-8?B?b3ZxL24yczkvNGZDdjZSMzljazMrcDA4TThNeFdvTlh1MHVLTjlPalZWWUxk?=
 =?utf-8?B?QzJFOHNvcUR1UzRmaTJUUE1vRllXOUkwaGhtVWhtV1pnZDRERXFVWGpiQTYy?=
 =?utf-8?B?WHR4TEtXaDlkemVMTm1rZXlMeDB3WGZ3eWxsN1VOd093V0xFM1NlQU1xVmdw?=
 =?utf-8?B?YnZtV3ExaSt5OUdDRzducU54VGovOWRvZWk0SjhRb08xOUpuYU5ad3YyTytW?=
 =?utf-8?B?TnhFRmxaSFpISityWVZXbXFSWmZzTW12bXZZcjBGTzhZdGVNSEJKclh5emhX?=
 =?utf-8?B?ciszZmNqc0hMb1J5MVVzN09sU1N4QUxLVDQrOUMyRWFhSXVXbjFyUGhqdVlz?=
 =?utf-8?B?Y2x2RnlVVkRYUndtYzZ6MFpZekJrSVh0dklsaTBjSFllUVZkdCtxS0V1Y0li?=
 =?utf-8?B?Y0VEOHlEbGEva3lxelJoTFl0MHJaVkRjTW4zRmZFdUsvMmhIbG5FeXZDRHJL?=
 =?utf-8?B?WGtjajdmU3V6d2tTbGtHc213L0VzcTFPN0VoRkJLQ05iSmpyck9IQXN4MnhW?=
 =?utf-8?B?VUFIbjhhY2thWkNMUXdKSW9uRmtkUTRRTE1pNTNxODdIKzRFZ2Y3SEljdElt?=
 =?utf-8?B?NWdidkFuaXAxOGhabU5NV2M2dDlyS2lHdXBKMjJkTXNFKzI3V29ad0VtSktE?=
 =?utf-8?B?SFFkOTM4WDVGZFZHbDNjWUhuM3c1UzNyWFkzeTh6d2lzalN1V1QzUzZiU1JB?=
 =?utf-8?B?a0ZsS2RjR3NnTlZYNUg3a2I2dHI0ZTNsbVZWQU9iZGdFcDhmM2Joak12amdD?=
 =?utf-8?B?QzRYZk5wK0xlZHEvUEhaaHl3U2NDWUtMVE1oVzNjemxnUG9ZcmJkbThsV0lp?=
 =?utf-8?B?Z3dNbmMyQkZFMmhzcjJCRFdST1E5T3BDc2tGL0VZU2kvR3BLeGE0ODl0b0Z6?=
 =?utf-8?B?Ti92TnA0WFQ0NFlCRjRjK29INXVnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b92f9b-23c9-44db-ab48-08db3f1deaeb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 08:29:53.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHbMNfTpgoZ84YOJAiz3qlvEjuTG3HDpikZBbVfGSqI5LV3zgsqq+rH9ajno85DcEZAfuI7n1C0AMHzf09vrd3KKn18o64uZ7uF7SqkalB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/12/23 15:55, Dave Stevenson wrote:
> Hi Michael
> 
> On Wed, 12 Apr 2023 at 09:00, Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> Hi Dave,
>>
>> On 4/11/23 20:15, Dave Stevenson wrote:
>>> Hi Michael
>>>
>>> On Tue, 11 Apr 2023 at 18:33, Michael Riesch
>>> <michael.riesch@wolfvision.net> wrote:
>>>>
>>>> Hi Dave,
>>>>
>>>> On 4/6/23 17:16, Dave Stevenson wrote:
>>>>> Hi Michael
>>>>>
>>>>> Thanks for the patch.
>>>>>
>>>>> I've got a personal interest here as I'd love to be able to control a
>>>>> couple of CCTV lenses that I have. Those have standard motors with
>>>>> potentiometers for position feedback, not stepper motors, but
>>>>> otherwise have the same limitations of slow movement.
>>>>
>>>> That's great to hear :-) Thank you for your feedback!
>>>>
>>>>> On Thu, 6 Apr 2023 at 15:31, Michael Riesch via B4 Relay via
>>>>> libcamera-devel <libcamera-devel@lists.libcamera.org> wrote:
>>>>>>
>>>>>> From: Michael Riesch <michael.riesch@wolfvision.net>
>>>>>>
>>>>>> Add the controls V4L2_CID_FOCUS_STATUS and V4L2_CID_ZOOM_STATUS that report
>>>>>> the status of the zoom lens group and the focus lens group, respectively.
>>>>>> The returned data structure contains the current position of the lens group
>>>>>> as well as movement indication flags.
>>>>>>
>>>>>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>>>>>> ---
>>>>>>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 48 ++++++++++++++++++++++
>>>>>>  drivers/media/v4l2-core/v4l2-ctrls-core.c          |  9 ++++
>>>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  7 ++++
>>>>>>  include/media/v4l2-ctrls.h                         |  2 +
>>>>>>  include/uapi/linux/v4l2-controls.h                 | 13 ++++++
>>>>>>  include/uapi/linux/videodev2.h                     |  2 +
>>>>>>  6 files changed, 81 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>>>>>> index daa4f40869f8..3a270bc63f1a 100644
>>>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>>>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>>>>>> @@ -149,6 +149,30 @@ enum v4l2_exposure_metering -
>>>>>>      to the camera, negative values towards infinity. This is a
>>>>>>      write-only control.
>>>>>>
>>>>>> +``V4L2_CID_FOCUS_STATUS (struct)``
>>>>>> +    The current status of the focus lens group. This is a read-only control.
>>>>>> +    The returned data structure contains the current position and movement
>>>>>> +    indication flags. The unit of the current position is undefined. Positive
>>>>>> +    values move the focus closer to the camera, negative values towards
>>>>>> +    infinity. The possible flags are described in the table below.
>>>>>
>>>>> The units are undefined, but positive and negative mean something with
>>>>> respect to some unspecified focal distance represented by 0. That
>>>>> seems a little odd.
>>>>>
>>>>> I was going to suggest that it seems to make sense to follow the same
>>>>> units as V4L2_CID_FOCUS_ABSOLUTE, but on reading that description in
>>>>> [1] it's the same text.
>>>>> I suspect there was a little too much copy/paste from
>>>>> V4L2_CID_FOCUS_RELATIVE, or the intent was that increasing the value
>>>>> brings the focus closer, and decreasing moves it towards infinity.
>>>>>
>>>>> If we did specify that it was the same units as
>>>>> V4L2_CID_FOCUS_ABSOLUTE, then what would that mean for use with
>>>>> V4L2_CID_FOCUS_RELATIVE? Then again the only user of _RELATIVE appears
>>>>> to be ov5693 with atomisp and that just maps it onto _ABSOLUTE, so
>>>>> potentially it's redundant and could be deprecated.
>>>>>
>>>>> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-camera.html
>>>>
>>>> I think we agree that the _STATUS controls should use the same unit as
>>>> the corresponding _ABSOLUTE control, whatever that may be.
>>>>
>>>> Then, the question is whether the description of FOCUS_ABSOLUTE needs to
>>>> be revised. I would agree that the intention probably was: "Larger
>>>> values move the focus closer to the camera, smaller values move the
>>>> focus to infinity." (cf. the phrasing in the description of IRIS_ABSOLUTE).
>>>>
>>>> It would be interesting to know whether zero and negative values are
>>>> (intentionally?) included. Since they are not explicitly excluded, my
>>>> driver exposes the position of the lens in motor steps to the user
>>>> space. If the values were (supposed to be) restricted to positive values
>>>> like ZOOM_ABSOLUTE, this would not be allowed of course.
>>>>
>>>> As to the relation to _RELATIVE, I think it should be clear that all
>>>> controls should act on the same scale and I don't see any problems here.
>>>> However, feel free to point out what I am missing :-)
>>>>
>>>>>> +
>>>>>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>>>>>> +
>>>>>> +.. flat-table::
>>>>>> +    :header-rows:  0
>>>>>> +    :stub-columns: 0
>>>>>> +
>>>>>> +    * - ``V4L2_LENS_STATUS_IDLE``
>>>>>> +      - Focus lens group is at rest.
>>>>>> +    * - ``V4L2_LENS_STATUS_BUSY``
>>>>>> +      - Focus lens group is moving.
>>>>>> +    * - ``V4L2_LENS_STATUS_REACHED``
>>>>>> +      - Focus lens group has reached its target position.
>>>>>> +    * - ``V4L2_LENS_STATUS_FAILED``
>>>>>> +      - Focus lens group has failed to reach its target position. The driver
>>>>>> +       will not transition from this state until another action is performed
>>>>>> +       by an application.
>>>>>
>>>>> When would the lens state transition from V4L2_LENS_STATUS_REACHED to
>>>>> V4L2_LENS_STATUS_IDLE?
>>>>> If it's reached the position then it is at rest, and being at rest is
>>>>> the definition of V4L2_LENS_STATUS_IDLE.
>>>>> Likewise the lens always has a target position based on the control
>>>>> value, so it's always at V4L2_LENS_STATUS_REACHED when it's not
>>>>> moving.
>>>>> Is there a need to have 2 states?
>>>>
>>>> Good point, I need to reconsider that (and possibly remove one of those
>>>> states).
>>>>
>>>>> If the position is the same units as V4L2_CID_FOCUS_ABSOLUTE, then do
>>>>> you leave the determination of state to the application?
>>>>
>>>> I am afraid I don't quite follow.
>>>
>>> If the application sets V4L2_CID_FOCUS_ABSOLUTE to 42, and
>>> V4L2_CID_FOCUS_STATUS returns that the position is now 42, then the
>>> application knows that the lens has reached the requested position. If
>>> the two controls return different values then the lens is still
>>> moving.
>>> What new information does adding an additional status flag give you?
>>
>> I can think of two situations:
>>
>>  - Hardware error: the lens stops at 40 (for whatever reason). Since 40
>>    != 42 the lens is still moving, although a hardware error has occured
>>    that may need recovery or at least reporting.
> 
> Are you thinking of the lens drive having totally failed, or just that
> the requested position is out of the achievable range?

I would say the latter. At least one of our optics (with one focus lens
and two zoom lenses) exhibits nontrivial constraints for the range of
the individual lenses.

> Looking at the flash controls[1], hardware failures are handled by
> V4L2_CID_FLASH_FAULT as a separate control.
> 
> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-flash.html
> 
>>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
>>    then what happens if the application performs a
>>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
>>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
>>    the application's point of view.
> 
> V4L2_CID_FOCUS_RELATIVE really ought to die IMHO, or at least work in
> co-operation with V4L2_CID_FOCUS_ABSOLUTE such that the absolute
> current position can always be retrieved.
> 
> Using _RELATIVE to set a position that is outside of the range defined
> by _ABSOLUTE is meaningless. Any call to S_CTRL on _RELATIVE almost
> has to be followed by a call to G_CTRL _ABSOLUTE to know the final
> result, so why not just make a S_CTRL _ABSOLUTE call in the first
> place.
> 
> I guess _RELATIVE may have uses in the case where there is no
> read-back of the position at all, but in that case I don't see a way
> that your new controls could be implemented.

I am quite neutral to this. We don't plan to use the _RELATIVE controls
and if you want to get rid of them there won't be any objections from
our side.

If the drivers should only implement either ABSOLUTE or RELATIVE then
situation I described above is not an issue, of course.

>> Don't get me wrong, a simple control that reports the current position
>> would be way easier. But I feel that we may regret this in the future.
>> Also, I would not use two separate controls "current" and "flags/status"
>> in order to avoid non-atomic access patterns.
> 
> I have no fixed views, but overcomplicating things is generally bad news.
> 
>>> (Thinking aloud) I guess you have got my case where your readback is
>>> via an ADC so that the position may fluctuate slightly due to
>>> conversion noise. The control loop for applying power to the motors
>>> will presumably stop at some point and stop trying to adjust the
>>> position, so potentially it could be the state returned from that
>>> control loop. However the noisy ADC position could also be solved by
>>> the position being returned by the control loop instead of giving the
>>> raw value.
>>
>> With stepper motors the readback is not that noisy, but in any case the
>> flags field allows an underlying controller to signal certain conditions
>> without relying on the exact value of the current position. I think that
>> is a plus, especially for noisy readback.
>>
>>>> But FWIW the application should read out the flags to find out whether
>>>> the lens is moving and, if this is not the case, whether the last move
>>>> command (FOCUS_ABSOLUTE or FOCUS_RELATIVE) has succeeded or failed. The
>>>> failed state is important as there might be the possibility that
>>>> depending on the zoom lens position certain focus positions are not
>>>> available (and vice versa).
>>>
>>> How would you configure those kinds of restrictions in the kernel
>>> driver? Is the kernel driver the best place to do it (so many things
>>> are being kicked back to userspace these days)?
>>
>> In our case we have a hardware controller that needs to handle the
>> restrictions anyway in order to avoid mechanical damage. The kernel
>> driver is only responsible for reading out the controller status and
>> transforming it into the V4L2 control.
> 
> How does userspace know what the valid ranges are? Do you end up with
> the same restrictions having to be coded in both your controller and
> userspace, or are you relying on the driver reporting back this error
> status with userspace not knowing by how much it got it wrong by?

Maybe I should clarify a bit the use cases here. Most of the time the
ZOOM_ABSOLUTE and FOCUS_ABSOLUTE controls will be used to operate the
optics. Here, AFAIK there should not be any constraints (or at least,
they are handled by the lens controller hardware) and user space can
pick any value between the minimum and maximum of the respective control.

The situation is more complicated for the calibration. Here, individual
lenses can be moved and may be subject to certain constraints. Before
the calibration, the limits may be unknown or estimated. Then, one
approach could be to set the target position of a lens to INT_MAX and
read back the status. The error status plus the current position could
then yield the actual limit.

Note that such calibration techniques are very specialized use cases,
but with the proposed API it should be possible to cover several
different approaches.

>> I am not sure how any restrictions can be reliably handled in software,
>> hence I don't have a strong opinion on whether this is done in kernel or
>> user space.
>>
>>> If it is to be done in the kernel, then shouldn't eg changing the zoom
>>> position alter the ranges advertised for the relevant focus controls?
>>
>> While it should be possible to update the minimum and maximum of e.g.,
>> FOCUS_ABSOLUTE, I am not sure whether the interface is designed for
>> frequent re-reading of the range.
> 
> There's nothing in there that stops you, and several hooks to help you.
> Updating V4L2_CID_VBLANK on most raw sensors will update the range on
> V4L2_CID_EXPOSURE, as the exposure period can't be longer than the
> frame period. It would be similar that each change to ZOOM_ABSOLUTE
> would result in a range adjustment to FOCUS_ABSOLUTE.
> Userspace can also use VIDIOC_SUBSCRIBE_EVENT to subscribe to any
> updates in controls, so it gets told automatically of any updates.

OK, maybe we'll give this some more thought!

Thanks a lot for your comments!

Best regards,
Michael

>>> If the ranges aren't updated, where should that out-of-range lens
>>> movement leave the lens?
>>
>> This is up to the hardware controller, but I would guess it typically
>> stops one step before disaster. Wherever that may be, the error
>> condition and the current position can be read out via this new STATUS
>> control.
>>
>> Does this sound good so far?
> 
> Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
> Laurent), and I'm just expressing my views based on the lenses I've
> encountered.
> All of my lenses have a single drive for focus, a single drive for
> zoom, and where there are multiple elements they are all connected
> mechanically. Your setup sounds far more complex and is likely to need
> a more extensive driver, but it'd be nice to not unnecessarily
> overcomplicate the interface.
> 
>   Dave
> 
>> Best regards,
>> Michael
>>
>>>
>>>   Dave
>>>
>>>>>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>>>>>>      Enables continuous automatic focus adjustments. The effect of manual
>>>>>>      focus adjustments while this feature is enabled is undefined,
>>>>>> @@ -239,6 +263,30 @@ enum v4l2_auto_focus_range -
>>>>>>      movement. A negative value moves the zoom lens group towards the
>>>>>>      wide-angle direction. The zoom speed unit is driver-specific.
>>>>>>
>>>>>> +``V4L2_CID_ZOOM_STATUS (struct)``
>>>>>> +    The current status of the zoom lens group. This is a read-only control.
>>>>>> +    The returned data structure contains the current position and movement
>>>>>> +    indication flags. The unit of the current position is driver-specific and
>>>>>> +    its value should be a positive integer. The possible flags are described
>>>>>> +    in the table below.
>>>>>> +
>>>>>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>>>>>> +
>>>>>> +.. flat-table::
>>>>>> +    :header-rows:  0
>>>>>> +    :stub-columns: 0
>>>>>> +
>>>>>> +    * - ``V4L2_LENS_STATUS_IDLE``
>>>>>> +      - Zoom lens group is at rest.
>>>>>> +    * - ``V4L2_LENS_STATUS_BUSY``
>>>>>> +      - Zoom lens group is moving.
>>>>>> +    * - ``V4L2_LENS_STATUS_REACHED``
>>>>>> +      - Zoom lens group has reached its target position.
>>>>>> +    * - ``V4L2_LENS_STATUS_FAILED``
>>>>>> +      - Zoom lens group has failed to reach its target position. The driver will
>>>>>> +       not transition from this state until another action is performed by an
>>>>>> +       application.
>>>>>> +
>>>>>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>>>>>>      This control sets the camera's aperture to the specified value. The
>>>>>>      unit is undefined. Larger values open the iris wider, smaller values
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>>> index 29169170880a..f6ad30f311c5 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>>> @@ -350,6 +350,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
>>>>>>         case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
>>>>>>                 pr_cont("HEVC_DECODE_PARAMS");
>>>>>>                 break;
>>>>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>>>>>> +               pr_cont("LENS_STATUS");
>>>>>> +               break;
>>>>>>         default:
>>>>>>                 pr_cont("unknown type %d", ctrl->type);
>>>>>>                 break;
>>>>>> @@ -918,6 +921,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>>>>>>                         return -EINVAL;
>>>>>>                 break;
>>>>>>
>>>>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>>>>>> +               break;
>>>>>> +
>>>>>>         default:
>>>>>>                 return -EINVAL;
>>>>>>         }
>>>>>> @@ -1605,6 +1611,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
>>>>>>         case V4L2_CTRL_TYPE_AREA:
>>>>>>                 elem_size = sizeof(struct v4l2_area);
>>>>>>                 break;
>>>>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>>>>>> +               elem_size = sizeof(struct v4l2_ctrl_lens_status);
>>>>>> +               break;
>>>>>>         default:
>>>>>>                 if (type < V4L2_CTRL_COMPOUND_TYPES)
>>>>>>                         elem_size = sizeof(s32);
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>> index 564fedee2c88..9b26a3aa9e9c 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>> @@ -1044,6 +1044,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>>>         case V4L2_CID_CAMERA_ORIENTATION:       return "Camera Orientation";
>>>>>>         case V4L2_CID_CAMERA_SENSOR_ROTATION:   return "Camera Sensor Rotation";
>>>>>>         case V4L2_CID_HDR_SENSOR_MODE:          return "HDR Sensor Mode";
>>>>>> +       case V4L2_CID_FOCUS_STATUS:             return "Focus, Status";
>>>>>> +       case V4L2_CID_ZOOM_STATUS:              return "Zoom, Status";
>>>>>
>>>>> Is there a need for the comma in the text strings?
>>>>
>>>> Not sure, actually. Some other strings used commas. Monkey see, monkey do.
>>>>
>>>> Best regards,
>>>> Michael
>>>>
>>>>>
>>>>> Cheers
>>>>>   Dave
>>>>>
>>>>>>
>>>>>>         /* FM Radio Modulator controls */
>>>>>>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
>>>>>> @@ -1593,6 +1595,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>>>>>                 *flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>>>>>>                           V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>>>>>>                 break;
>>>>>> +       case V4L2_CID_FOCUS_STATUS:
>>>>>> +       case V4L2_CID_ZOOM_STATUS:
>>>>>> +               *type = V4L2_CTRL_TYPE_LENS_STATUS;
>>>>>> +               *flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
>>>>>> +               break;
>>>>>>         case V4L2_CID_FLASH_STROBE_STATUS:
>>>>>>         case V4L2_CID_AUTO_FOCUS_STATUS:
>>>>>>         case V4L2_CID_FLASH_READY:
>>>>>> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
>>>>>> index e59d9a234631..f7273ffc20c9 100644
>>>>>> --- a/include/media/v4l2-ctrls.h
>>>>>> +++ b/include/media/v4l2-ctrls.h
>>>>>> @@ -52,6 +52,7 @@ struct video_device;
>>>>>>   * @p_hdr10_cll:               Pointer to an HDR10 Content Light Level structure.
>>>>>>   * @p_hdr10_mastering:         Pointer to an HDR10 Mastering Display structure.
>>>>>>   * @p_area:                    Pointer to an area.
>>>>>> + * @p_lens_status:             Pointer to a lens status structure.
>>>>>>   * @p:                         Pointer to a compound value.
>>>>>>   * @p_const:                   Pointer to a constant compound value.
>>>>>>   */
>>>>>> @@ -81,6 +82,7 @@ union v4l2_ctrl_ptr {
>>>>>>         struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
>>>>>>         struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
>>>>>>         struct v4l2_area *p_area;
>>>>>> +       struct v4l2_ctrl_lens_status *p_lens_status;
>>>>>>         void *p;
>>>>>>         const void *p_const;
>>>>>>  };
>>>>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>>>>>> index 5e80daa4ffe0..8b037467ba9a 100644
>>>>>> --- a/include/uapi/linux/v4l2-controls.h
>>>>>> +++ b/include/uapi/linux/v4l2-controls.h
>>>>>> @@ -993,6 +993,19 @@ enum v4l2_auto_focus_range {
>>>>>>
>>>>>>  #define V4L2_CID_HDR_SENSOR_MODE               (V4L2_CID_CAMERA_CLASS_BASE+36)
>>>>>>
>>>>>> +struct v4l2_ctrl_lens_status {
>>>>>> +       __u32 flags;
>>>>>> +       __s32 current_position;
>>>>>> +};
>>>>>> +
>>>>>> +#define V4L2_LENS_STATUS_IDLE                  (0 << 0)
>>>>>> +#define V4L2_LENS_STATUS_BUSY                  (1 << 0)
>>>>>> +#define V4L2_LENS_STATUS_REACHED               (1 << 1)
>>>>>> +#define V4L2_LENS_STATUS_FAILED                        (1 << 2)
>>>>>> +
>>>>>> +#define V4L2_CID_FOCUS_STATUS                  (V4L2_CID_CAMERA_CLASS_BASE + 37)
>>>>>> +#define V4L2_CID_ZOOM_STATUS                   (V4L2_CID_CAMERA_CLASS_BASE + 38)
>>>>>> +
>>>>>>  /* FM Modulator class control IDs */
>>>>>>
>>>>>>  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX | 0x900)
>>>>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>>>> index 17a9b975177a..256c21c68720 100644
>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>> @@ -1888,6 +1888,8 @@ enum v4l2_ctrl_type {
>>>>>>         V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS        = 0x0272,
>>>>>>         V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX      = 0x0273,
>>>>>>         V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS       = 0x0274,
>>>>>> +
>>>>>> +       V4L2_CTRL_TYPE_LENS_STATUS              = 0x0300,
>>>>>>  };
>>>>>>
>>>>>>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
>>>>>>
>>>>>> --
>>>>>> 2.30.2
>>>>>>
