Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A6680A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjA3KHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjA3KHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:07:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8A16305;
        Mon, 30 Jan 2023 02:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4yGLjMHlno+N6HvQzCFsCjU8BPyM4rYEUI4Q5Rn9jN6fyVkxIPFsD6CfaHkrna51zJA9wR1aSbapdXhhome8/Ne33cJsWUc27iV5sSfKVpzBPotpA7ANER6FPNRGReW8OV6ereqPG7TaID2p8CwUFuVN3k1w5YgKAEcdL0fkWTq9TO9miSoFAnyf4T5zpfgyPDVn2MY5TMAHgt2M8xdkJq8doCJLEJ8Ay1z9wAcvnHAxiVkXIZQ0TeRgkWd2X2cuDXjgyk5u5qh1+109xmYlXM1QtMNAAtrTtm3u/ktPg5zcK7T/YDy307wsY/yzPDy53/olD5vJVH2p44aK/KM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j3Q70HNx+996ygc8e+a+7Xn6Y+US94YeXkzRlur7l4=;
 b=JSaqf71NoNyso5CGw3Ue5P7wY5OhmgkuwxrdO7vBnkdovoC67HXubXpNMpdQH55fdG1dV+OFoaIq4cRwE6JUgNJeKk0velzv8OSB4VcVidfPITqxNiVIsolctKfUIGDO23RSpa6B3YS4XA86H2LPZhrG4Bp4D76YfWff1zi5afIZ5lIOCg/TE04PQi6NY/HY02+0Dt6Wnc/q3Tv8AkHUdwNHArZ4vdR7KAaDmH4V+dYO46LhSF6O9IlsNaKsrImMZzdIhoHeNRrCmn8eBPVAdhFAy7j5W2/phRXlz3iKoXWBZU3EuPZJ2O9/6qU+ePKuM51FPg99+yzManf7ZvHiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j3Q70HNx+996ygc8e+a+7Xn6Y+US94YeXkzRlur7l4=;
 b=IsmD2lDypd1y6wtJnax8JnwqeQzZHFh2hYNBcw4IsGzqy6q+puvsUiJpxsooN7/98yRQTQM7AgNvLUscS1dlL2OshjLPBFlFAUwZFCYsBOoxV9se2So82M/wzPqo+krluMNd6vOpcUOsV02225V1OGQQG/fvRK2tLmyXiMcgCBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BY5PR03MB5141.namprd03.prod.outlook.com (2603:10b6:a03:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 10:07:23 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::10e9:e275:9f10:67cc]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::10e9:e275:9f10:67cc%9]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 10:07:23 +0000
Message-ID: <413ed194-2302-1161-c74f-768faeb999f2@synaptics.com>
Date:   Mon, 30 Jan 2023 18:07:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v6 03/11] media: v4l2: Add extended buffer (de)queue
 operations for video types
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Brian.Starkey@arm.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, helen.koike@collabora.com,
        hiroh@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, nicolas@ndufresne.ca,
        sakari.ailus@iki.fi, stanimir.varbanov@linaro.org,
        tfiga@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ayaka <ayaka@soulik.info>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-4-helen.koike@collabora.com>
 <20230125200026.16643-1-ayaka@soulik.info>
 <7609d523-667a-49a8-45f5-8186de20c24b@xs4all.nl>
 <Y9Jd12nYGk2xTYzx@pendragon.ideasonboard.com>
 <02142e8c-7479-1066-b5af-dad954136adc@soulik.info>
 <197c3574-2ffa-7c8a-2372-a373123087a3@xs4all.nl>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
Content-Language: en-GB
In-Reply-To: <197c3574-2ffa-7c8a-2372-a373123087a3@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BY5PR03MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e1ea14-8fdb-410d-96a0-08db02a9c805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxdzC4D+EAGgWxg47PB/uL0qN0EeWVvwIBzT1sbEu5Xgrc42WvQFGgXZEijiDZ7j/J44JQF7vW3mpkECPeZbKWM9sRRa4vDWe50LB8DODmtCWU5Kg+ubBt8mO47JZxmDWOkHMCu6QxPdFyfHal2dZXSyFnbromdV8J6Upo4qi8bX2uttXm5v5oVlWDf3ZvnVi7PQg/z7UgZtaNNi/VtiDuC07fTUh+d5jCdOBoTqJxc9fMags4yYQEFTC8vsokouULj9ZxCwv7sWD+ZBQAhdOA4bSZ6j6/BAckqJ6Vv6sy96eBSaJoCfsAhMWLHtxbpreNkNqk2WfGx4EknEz0irlzOahWqEN/Ih3hNOxFkj2qJ8C5N526a6/ZiEYMoB9bbuzwr/L+VXupYls5HaFiuw1TVpdBaqr1dySEhr/WEdetrT2LpbvJyHVmP2cdSn9p4kbg8HbBx3XNz123VnH4KT7aTs6a3i7y2ILVdO1k5McaMnn1bFhfeOb+2c92d/Ev8Favz2dHHTl8hbgGSePcmeCOTp2MxM36lBEVzHB0tZJYyvGK8ys1Blgw7IRGcD+WF+3sAR32E6bpzfags0Amm/qO8pUoj3pPQhZPDu9otahYj/A7d7XBopOHgqzJCo3+2DoXTn9Y7gCsxsGUwh5XXkBx2tOlvI0YMiw+soeP7PeZ9mmKre8UyLkPamgtbCGc3LOJU0dmxQFxZK8Dh5449sr5XBM88LG8pPPWWH4op6UQJ5jD6d3zwmO8N2HSPj5AHCb4AUDyPD58Fv5BRoT5V//A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39850400004)(396003)(136003)(451199018)(52116002)(31696002)(31686004)(8676002)(66476007)(66556008)(6916009)(4326008)(41300700001)(66946007)(8936002)(83380400001)(478600001)(86362001)(316002)(2906002)(38350700002)(38100700002)(6666004)(6486002)(26005)(6506007)(53546011)(5660300002)(186003)(6512007)(54906003)(7416002)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlHTzlONHdadHdUR3dyQUl0M0hhMzNjZzBrMHlPTHpTcFMxKzYyS1BVekR1?=
 =?utf-8?B?OHRWenpnWWw0bjFLd0xnR0VyblBEMGxMZ0dKRGkvOFNvMyt3a3kyV2J2UDVU?=
 =?utf-8?B?ejh4OG1talNpZG5mV1RhOVU5SXB6V0xwNlZGVlc5MjZ5Mmx1a3lYaDJzemgx?=
 =?utf-8?B?ZHJwQ3JCdjFXcjJHTlVRNHF1OGtBQ2hmSDJhWjk3THFvN0krUXZIanp3L2Jw?=
 =?utf-8?B?Mk5OVTRpR3FFaVpQU2kwZ0NmV1RFTlZWL3JNbk1Fa2tLQUtXcDYzVzM2Ym4z?=
 =?utf-8?B?ZWYzQ0JrSXpqMUFKUXp4OEI2cXo2UU03dTJjdXIyd3RxUm55Wjd6dG9uUmJO?=
 =?utf-8?B?UkRpWEplalFoWW5XWmJhRHZHQVNuTDdBQ2d3WDRMY25oWXEzK1N0WDVjdVFD?=
 =?utf-8?B?WXg4NGExazB2U2VlYm05eUpsNnhZOHlTcGhaWjBHaW9Yd3hPeDdvNk50d0JG?=
 =?utf-8?B?Kzl2YUloY0tXU2xlczNsWnpIVENnNHhGdTdkbmcwSDJlazhITkFZZDV3cGNP?=
 =?utf-8?B?QnJwYkNsb2pjMUs4V0FQa2VpSGMyQ0ZPcUhTejRDeStaSWcwS1QxVVBJT1RX?=
 =?utf-8?B?UG5MY0dCZFBUTFVOZlV6MDdCd0UveU5RVWZ6NlZFelZQOWZKbTFXU1lrSUxP?=
 =?utf-8?B?Y3kzRzJLME5tVkdMU0p2aXc4YkhTdlcwMUN0RTVqdmpHTDlzdGRRdE8wejl3?=
 =?utf-8?B?SG0rSkxiaGg3YlBST0tNaUNYSVVndVlEL2U0MzZVbzkxWGRMS0pSZjczaXo2?=
 =?utf-8?B?QzFydHF6L05oNm5mNmkwQUdNUEZldWJnRERRRndDRE1PSVlrbjl0N2RNTE1r?=
 =?utf-8?B?TXRmUHUrb1hHandxV215WE9kUmovVWNvVjhmY2ZNVDJ0Z1YyWlRtQ3I1REpH?=
 =?utf-8?B?SHYrYVhsU1FWRzdaSVkzWFNQeFgvVUJIYWxQRUJPdXJudWpiemczZU5tL0pr?=
 =?utf-8?B?LzZxR2NFRHFGMlFuQzhwQUpDSnBGS2c1eGpDYlFRQk43SDhtei9WOEUwWFdo?=
 =?utf-8?B?UE1Wbk41STIxWXlEa0FnMzlOZ2xESS9Sd2pLMUE0VFJzL3l6bVRaZmZOdE8x?=
 =?utf-8?B?K1JyWmNzQkNFZW5WVmp2M1J6dituYlVwZlNEbUx2VmZnYWkrRWVoVTRKNWVm?=
 =?utf-8?B?ei8zcGdjV2djUjR4UXFOYXdCOUM3R1lDTEZJMHcxY1lhVkFkdFJYWlI3WWF5?=
 =?utf-8?B?T3h2Q0pBWDRDMkprSnZPcm9IRVJFeDFodjBnL0Y4dUlaWmV2MThOTVc3dXZO?=
 =?utf-8?B?TUtmcjF5SUxVU21uWXFSRFhia2xGNXVkVHBYdUd2aVZhRjdSVjhBVVB4emZy?=
 =?utf-8?B?eTNIZW4rM29IL01TTnM4YUlwWmpxRHhNR3lYK0hKdFlqd3g4SnBzY3Q3VEdT?=
 =?utf-8?B?SDgxaUVwZGhTSTJYTTFPWVpLT3RjL3Z5Vm1FUnVhbnNZOEk1VkRmTkJzZ1Fr?=
 =?utf-8?B?Zkl5dXBTSDg2UitUblYydHQwVVlmUHFRMDdtelpJVUczejI5RmhQcjh4SUxS?=
 =?utf-8?B?bU5ycWk2MGFHK0VWRjA4Y3RWRWtMQXk1UkZNdHlSSm0yaitwbFMwZDQ5Szha?=
 =?utf-8?B?YnduUi9tSzRTeFF6ZC9rOEdKNXVaUHR2cEE2ajlrdWJIOUxKa3V4T3BMeXhN?=
 =?utf-8?B?Y1B6VmcxTWdINWlBVmR3RTB4VTR4blJIdXZ5aWpVRWFPcW03aVZuUkVXK25E?=
 =?utf-8?B?NnF4QXpmNFIxSWNuSkF6T1drbW8wZGRWTlRzcGl3MkRQTW1qYU5BY2swK01B?=
 =?utf-8?B?T1BESnZxTEpxU1lDRVpaMHFrQlltRUFQQmE1eWV1aEt1YkY3cnQreEZwK3lC?=
 =?utf-8?B?ZEtkTDJHeExvVEdpaThaVldyKzN6ZXRncDc0M2xrRU9yZVpvRU5LZ3NVYnc5?=
 =?utf-8?B?V2JzSUJ3Si9iNXhCSHNYVnp1MnhOTjhaSG9zN21ZMzhGbFdtS0JLZ1RxVHJ6?=
 =?utf-8?B?dndib3FXeEI1ZWJNdTdDeHdZYlFCOG5jMTBadmZ2eitqS1VIeGpReGU2WXcw?=
 =?utf-8?B?dFhNOE9NOGN1ZWN5bGlWbC9wc0hVOWgwOFYzcmVUdzBRSGFwWVAvVFBxVmNq?=
 =?utf-8?B?eFUrSDh4S3lRRUx2Z3dDTHZTTEtMa3grM0c4NnQ2REMzREFjNTRGTGRQRE1C?=
 =?utf-8?Q?qFq1ZPYpBWlWcCGfwHzB2SYOd?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e1ea14-8fdb-410d-96a0-08db02a9c805
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 10:07:23.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3osg3QHQGB/BgXpBoRgRM7m7r7zsa3t7fsHGZZrSqkUaa/BSFnPnsXSVs2/8Y6G7fJnj+VYlmxR/9YzuXlgnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 16:11, Hans Verkuil wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On 26/01/2023 19:36, ayaka wrote:
>>
>> On 1/26/23 19:02, Laurent Pinchart wrote:
>>> On Thu, Jan 26, 2023 at 09:57:51AM +0100, Hans Verkuil wrote:
>>>> On 25/01/2023 21:00, ayaka wrote:
>>>>> I am currently refresh this patchset, but I didn't see the need beyond v4l2_ext_pix_fmt, which I had done.
>>>>> On 2/23/21 20:58, Hans Verkuil wrote:
>>>>>> On 14/01/2021 19:07, Helen Koike wrote:
>>>>>>> Those extended buffer ops have several purpose:
>>>>>>> 1/ Fix y2038 issues by converting the timestamp into an u64 counting
>>>>>>>       the number of ns elapsed since 1970
>>>>> I think application just use the timestamp field for tracking the
>>>>> buffer. It would be just a sequence buffer.
>>>>> At least for the most widely cases, the video encoder and decoder
>>>>> and ISP, this field is not a wall time.
>>>> For video capture and video output this is typically the monotonic
>>>> clock value.
>>>>
>>>> For memory-to-memory devices it is something that is just copied from
>>>> output to capture.
>>>>
>>>> So ISPs definitely use this as a proper timestamp.
>>> There are both inline (live-to-memory) and offline (memory-to-memory)
>>> ISPs. The former certainly need a proper timestamp.
>>>
>> I really have not seen a device that has timer starting with the epoch.
>>
>> I rarely know the ISP has a wall clock timer.
>>
>> Timestamp is not my first concern here. Offset is.
> 
> You are working in the V4L2 core framework here, something that is used
> by all V4L2 drivers. So everything is important. You can't just focus on
> your own use-case.
> 
I was trying to say we could focus on a more important item: offset.
>>
>>>>>>> 2/ Unify single/multiplanar handling
>>>>>>> 3/ Add a new start offset field to each v4l2 plane buffer info struct
>>>>>>>       to support the case where a single buffer object is storing all
>>>>>>>       planes data, each one being placed at a different offset
>>>>> I really care about this. But I think the data_offset field in
>>>>> struct v4l2_plane is enough. The rest is the problem of the kernel
>>>>> internal API and allocator.
>>>> data_offset has proven to be very confusing and is rarely used because
>>>> of that.
>> Yes, I didn't know any stateful codec driver support this.
>>>> We do need some sort of an offset field as proposed here, but it
>>>> shouldn't be named data_offset.
>> Maybe we could just rename it or make a union in the existing struct.
>>> The existing data_offset field was indeed added for other purposes, to
>>> let drivers report where the actual image data starts for devices that
>>> prepend some sort of header.
>>
>> For the compressed image, it makes sense. But the most of usage I knew is the upstream would just allocate a large buffer for compression video bitstream,
>>
>> Then it could tell where the decoder should start.
> 
> It's not codec specific, it's meant to be used with raw video frames.
> 
> The key problem in today's API is that if the buffer for the video frame
> contains multiple planes, typically Y and UV (2 planes) or Y, U and V (3 planes).
> 
> The offset at which each plane begins is currently a property of the
> pixelformat. That doesn't scale since there are often HW requirements
> that influence this.
> 
> One of the main confusing issues is that data_offset is included in
> the bytesused value, which was a design mistake in hindsight.
> 
I didn't see any problem here.
And v6 does NOT have the length property. There are many reasons that we 
want to limit the hardware access region for a plane.
> For the new APIs just ignore the existing data_offset and design
> this from scratch.
> 
All I am worrying is the effort we spent didn't have much change to the 
previous. Beyond breaking the userspace compatibility, it needs huge 
work on updating existing drivers included those could be replaced with 
the new framework.

I highly recommend just rename a property which was not used by any 
drivers in the upstream and make a new description for it.

>>
>>>    That's indeed not what we want here, we
>>> instead need something similar to the offsets field of struct
>>> drm_mode_fb_cmd2.
>>
>> That leads to another question. Should the offset be fixed from the first enqueued?
> 
> It's always been fixed in the hardware I have seen, but I'm sure someone will
> make it dynamic at some point in the future :-(
> 
There have been two cases the offset won't be fixed.
1. video codec bitstream input in a circular buffer as mentioned in the 
previous mail
2. decoder resolution change(down) while reusing the existing 
buffer(re-allocation costs lots of time)
> So I would say that the public API has to support this as a future enhancement,
> but it is OK to write the initial code with the assumption that it will remain
> fixed.
> 
>>
>> For the dmabuf, the v4l2 core framework would detatch then attach the buffer when it found the private of a plane is not same. Although it sounds unnecessary, some devices would a different cache line
>> for the chroma channel, it should be updated.
>>
>> For the drm_mode_fb_cmd2, unless you remove that fb_id, there is no way to modify the offset. But this would break the existing usage I mentioned before.
>>
>> We need to consider whether we need to keep the previous offset and a hook for update it.
>>
>>>>> I am thinking just add a field recording the offset input from the user.
>>>>> When we return the buffer back to the user, the value of the offset
>>>>> should be same as the it is queued.
>>>>>
>>>>> Meanwhile, the API compatible that I want to keep is user using the
>>>>> ext_pix API could access those drivers support old API.
>>>>> But I don't want the user would expect they could get correct pixel
>>>>> format using the old ioctl(). It could create many duplicated pixel
>>>>> formats. If we want to keep the compatible here, that is the job of
>>>>> libv4l.
>>>>>
>>>>> Besides, I think make the driver using the new API be compatible
>>>>> with the old ioctl() would lead a huge problem. User won't like to
>>>>> update its code if it could work even in a less performance mode
>>>>> because this code are for all the other hardware vendors/models.
>>>>> Unless we make this a feature, they could make a new branch in their
>>>>> code(don't count them would upate the kernel of the other products).
>>>> New drivers that require the additional information that these new ioctls give can
>>>> decide to just support these new ioctls only. But for existing drivers you want
>>>> to automatically support the new ioctls.
>>
>> What I said didn't break that. Application would use the new ioctl() to contact with the existing driver.
>>
>> What I want to remove is that Application use the old ioctl() to contact with the driver support new ioctl().
> 
> No, you can't do that. Not unless the driver uses features that only work with the new API.
> 
> I.e. if I make a new driver whose properties are completely compatible with the existing
> APIs (so no weird offsets etc.), then I want to write the driver using the new ioctls,
> and leave it to the V4L2 framework to provide support for the old ioctls.
> 
> There is absolutely no reason to block old ioctls in that case. Applications will not
> just be able to support a new API overnight, that takes years.
> 
>>
>> I would omit this related patches in the refresh set. We could always add it back. But what I want is a way  to enqueue and dequeue different formats(or usage) of buffers in both OUTPUT and CAPTURE. I
>> may add a more complex API later.
> 
> For discussion it is OK to drop the old ioctl support, but once you go beyond the RFC stage
> it has to be put back.
> 
> Regards,
> 
>          Hans

-- 
Hsia-Jun(Randy) Li
