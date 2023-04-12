Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630FA6DED21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDLIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDLIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:00:36 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C15BB5;
        Wed, 12 Apr 2023 01:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWS0eSmhWTe9lQjkf0YF6j/Nd2qaju1aCfyRxxjQaR/56bAPCdwxfFDYYyQiJ768HN66sl80ZdOk3u+yZs2bEiDrTHZ8PhRBQMTFRVGL1VzqzFMofgmRDD8i5jJBHBls4qe0j5kzAfsTU4mgSR1LSYVZZXxd/Dk2oHKzoAMXsdN2BfqPydO77J4HHKnFgdkDUePif67UlqcKVkjGrLcirYC5vmNm43HIFb+Et0rVojp6tnDLHKVYx1ky8xSkczcJDsOEBpb+R7oi1iJBTBD/LfAzPFvmSf3mUecLq8X/4nGIkw5h/14+VuAxFj6yFRHAsDnNqBs7jg88nlPjJ9yvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8747tjrli3rlMy4OFgJp8BNdJCnB0LO5HKIL7tZx13c=;
 b=mdmriRSBrSiQiC9W0YrJzC7x2duuh8V3W0jixulVx2xsTybqrLUnroDGhWpJXHRXJZlR7WKstlAenaD7LeMvUV9IxEZPJEKDccp2d5KHnRTEvrFXcLMJfKQcwuucSvV1GtRDOXLo7Bz/IFOlqbljBJtohiDpbQJsEbHC0/fwyOhFetgTaHC9K9e9f9c8z9uGo8xMmuB4JoG1lqrJiqia36BYZkTOaXC7Hy+6+ZqDpBTNQAKMxSoDkm/WbiTQBl+OWXNbW6ClSVQnXaLSYdhMUpSt+w9G0bE5LqqZvb3ReYUGX3Tmoz4yBSCQDyCnaJukIfkgO8OjMfTyyc++7+Ofdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8747tjrli3rlMy4OFgJp8BNdJCnB0LO5HKIL7tZx13c=;
 b=ErrTzRsQqfHmucVtTG9WfI90NO0fG+Cy8JictieKf1HEqWbfKR1XMn91USAUAhkG5/Mjh7EpI3Tz/MFkD+mDPKz+DsZsx8gsbKhMYzoVINDLTkMjrhYOFiJLoLndRldCv6GdjiGMTyAQmqdotI1Zt8rb7AQO5HZqcP1eTZsGn8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB10315.eurprd08.prod.outlook.com (2603:10a6:20b:5c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 08:00:29 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 08:00:28 +0000
Message-ID: <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
Date:   Wed, 12 Apr 2023 10:00:26 +0200
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
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0219.eurprd08.prod.outlook.com
 (2603:10a6:802:15::28) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB10315:EE_
X-MS-Office365-Filtering-Correlation-Id: 868cc8f4-6302-48aa-38d9-08db3b2bfb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64NJgCXZKbAlhEHeGBuGUJP9Xt50yffIMQ6J4OBinNxG/lcQghag1cfD8t9aXUSFfBRGR/Gqzu6eGVeEJ19zgYe7W0rgryHmpWZEg/C7CPzjNbK+hLPjTnnXEkOCMHEnhr3uvHc3q3vvrDxNaoZrYJQJeTf+w/a4arutAY2PO8hTQkjw3kUOtJ/47C8NH00Dn/of8FzTdqAsxwuct8+dovYKqaT/fux0D1Uatign1EzjFcPTo2b1dMSlwV/QTyKCO+UFR6WC7PXKqofIHnP5d1DMbrUqdQi0zMD66iCjPoyhwtQc4Au//JdDilv58bwTweTb0a4c1qiOnVEZ2ELu3wrMv24lN2FtluZ36AOdQwixijdmC/OTFBZc7P6nRWGkLQNZxFrkL1dWkWkVcFAqt5CfRnMTW3UiRQqWIypYQr/khbEpQwrpSNrsUuS55Iwziw8gEHEayOja7PejmV7simm0iWZA/qn/ihKAcbMtXOmi8wbYvXrdgFBSmuG6M76ZWphCxHMmCjGJXitzoAREX/lDESiX4+0MaesYTPNJFffDwrs8AknW/k6CrsAI+2kKSvfu+R+rAeXvYnn5Uv/T2eaUJIx239Aznh5teN+V4vs/EWYF6Db5RJo+yhJePPd/KnaUvVt0+JqiRzJYedTlYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(451199021)(5660300002)(44832011)(30864003)(6486002)(966005)(8936002)(53546011)(26005)(6506007)(6512007)(2906002)(83380400001)(186003)(36756003)(2616005)(38100700002)(86362001)(31696002)(478600001)(41300700001)(6916009)(66556008)(4326008)(66946007)(8676002)(66476007)(36916002)(316002)(31686004)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVUvc0ZrR29TV1J5SkN0RDByQitSN013a1grZmxDY2c3K0UvTXpLd0plb0No?=
 =?utf-8?B?RW9SL01kdTVyV2J5M2VPdmJkOGd3ZG5Ua3RtdG9GTmxKUWlFbWNUQm1yZ3l6?=
 =?utf-8?B?RXhKd2lSbVBkaGh6aDh6V3BsTnhLZDRxRkJVeVYzYU1lLzBnTmlSWUFjTTVu?=
 =?utf-8?B?bVhMS2hhRnJwSUYwQVJXRTFHdXlwYWRxdGF4MG45b05SWmRHZ0FNTElPVytE?=
 =?utf-8?B?dlNsUDk0b21MQVNJelZDTGlKSkpUZ1B3cWxwd2FiNEFlRnVmdUlVNVZMaEZy?=
 =?utf-8?B?YytUZWdGekM5NW9sa1VYSmlQQTFscTEzQUJuUzBnalpqTVpCanlueEhqUGE5?=
 =?utf-8?B?NHhBVWtZZ2s3SlBUNDJIMzBXeGZLMnZPckQ1RmpCdzVIcTV3ejRmTTlOeXlZ?=
 =?utf-8?B?T1kyZjFFSFllNDJNaVJUajBlc0srWVVXZzFXbGIwOWpuVjRMSXZScVdWSEJH?=
 =?utf-8?B?Vmg2Y1RuY0lKV3NQVnlZSkVYbi9hYzJXUThXUjljMWZDRFlwYjBxdWdCb1Zo?=
 =?utf-8?B?WmtmdE94WnVpOGV5SU5rRUxIWUplcERiOXROVVRSNHBQQXBJbzNDWHIrSk5Y?=
 =?utf-8?B?NExtS1BTc2dTbmNrcnpQYW1QTVVmUE9mUjBjUFZGcDVzaHJ2bUMyRnN1SVNa?=
 =?utf-8?B?NlUzbWxveCtzME1HQS9mUTVueXNjWHhJQXpaaEdTV0I1bmVBbEdQUnN1Qjd3?=
 =?utf-8?B?UXRWdFVMK1k5QkhraE5HWUNhTjFwOFdYTDlacUdkQ3BoeGszS3dtNDhhNFpM?=
 =?utf-8?B?SkxRT1VYT25mRmpWZFlBc0t2MEtkR011Y25NVDhZUWNGQVJUa3A2YnE1UGlt?=
 =?utf-8?B?TnZvSGpBK2REUVE3U0xoUXdKb3FuaUxvYmVpQm1XTE9ER1BJVzJZQmRkbkhE?=
 =?utf-8?B?NzJoZFhPcFduNHlNMy9DRlAwQmIxSkl4cGNHTS9xeWIrQytJSlVCeFN5UkVD?=
 =?utf-8?B?Y1lmN3orWXRtWXR4Sm1xOXR4VGVMNkQvcVVnZ3hoNU9nRWlQQ2xDaHdHUkNR?=
 =?utf-8?B?djBNV25nRGs5NXBubTZVOHNwWDFWMWpCWjVsK1oxcmlDWWRaNnZ2aXFSejZK?=
 =?utf-8?B?NnF4YklDNlhBaU5mUzZaaE5tVTBja2RzbjVjQlNqNUJSTjFrNTFXWVFNVkhz?=
 =?utf-8?B?QmxTVlhjZERIOGUzQlRmbmxHT1Y0eEFqZWE3MnNJQytzSE1kV250WDJnbmN1?=
 =?utf-8?B?a210Y2JBT0RwSVZvdWcrWGtJdGptdCtQZnlDdDE1T0lNSDNqdExQRThKQVpw?=
 =?utf-8?B?N2pqenhnbW1WRm4xY1J1Vndmb1l4M0ZvdDJPVk0vcWxDelk1Zk1uUVdqV1JM?=
 =?utf-8?B?QkwyRTgvRTJXUXhCeXNsR0ZNVGtDcDdyWkplQWwxTW14bFhzUHdlS09xM1NV?=
 =?utf-8?B?aE1GVlBUa0M3UmxkWnFNVDZocUYzSDBqNzlLb2J6Z2lLU0FsanI5bWxtSWFU?=
 =?utf-8?B?WEVNSnhxR3F2TEFXQnFEZVV2Yko0RzkzSTA1anU5bmdtMWpPUkdBazcrbjRL?=
 =?utf-8?B?TUdBVkVwa2lPazh5NHg3RUpUeFM5MDNORW5TQnowa1JDbWdiWTQvNkRTNWw3?=
 =?utf-8?B?cWxYNGNRM1RJMXVuOWlVSjYyYUFOVmJDZmwzVWx4aWRvNmlNOGtLMjRkd1k5?=
 =?utf-8?B?a1NiTEQxbmtnUmNUTzZkWFNiSEs0MC9zdlJ5SVExcG93ZFcvK2Z1a094My8w?=
 =?utf-8?B?elpnWEhncnBtbXd4SzgwaGRpcmRDTGl2WTV0aCtWMmRvMDE5RlNWR05PTjA0?=
 =?utf-8?B?TnpqZkJkeTIybVpUNTh6TitTdDN5U1FvS3pqbVdCcWFVTGtVVytxTFdxYXYx?=
 =?utf-8?B?QnpiSlJmWEpoV2YwM0kzUkd1VU1QNnEwVlBkTGpiTzFxNitFWXJ3ZU5KcEdY?=
 =?utf-8?B?Y0ViTHNaNXpRNkR2Q0FhNWswRkkzdkhMZjhRQ3lHZm11Wjc2Y1owQXhHbkh6?=
 =?utf-8?B?TUp4OEx1Z3JnS05RUS94anFpTHBQc0tUWG1ta3FpeG1odmNNNm1UQjB3Q1pp?=
 =?utf-8?B?dGIweVYxVnRxS3lmY0xmTHp0V1daSVh3RmJyQmhicGNENnpDdUxycnR5NW5v?=
 =?utf-8?B?cG1yRi9NREQ2d1lsVVFjR0FpeEZHd1JnakRzVUpNY0xwTFNwNGYrN21wNUJj?=
 =?utf-8?B?TkU2Wmx3UXo5cCtoUW9pSU9QSkdpczV1bVZvK1dBUUNJbkUraTZiNnNEOUli?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 868cc8f4-6302-48aa-38d9-08db3b2bfb04
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 08:00:28.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04/f0qji6MOcKRZKu/idnLJKc9xfO6pjUIcPwNy+LOiAzETVWb6h1k9eV00w/brJ8J6ng5g8dtYdGOhaYXnrsPyM7g4TWaWn6qhUMKYrnA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10315
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/11/23 20:15, Dave Stevenson wrote:
> Hi Michael
> 
> On Tue, 11 Apr 2023 at 18:33, Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> Hi Dave,
>>
>> On 4/6/23 17:16, Dave Stevenson wrote:
>>> Hi Michael
>>>
>>> Thanks for the patch.
>>>
>>> I've got a personal interest here as I'd love to be able to control a
>>> couple of CCTV lenses that I have. Those have standard motors with
>>> potentiometers for position feedback, not stepper motors, but
>>> otherwise have the same limitations of slow movement.
>>
>> That's great to hear :-) Thank you for your feedback!
>>
>>> On Thu, 6 Apr 2023 at 15:31, Michael Riesch via B4 Relay via
>>> libcamera-devel <libcamera-devel@lists.libcamera.org> wrote:
>>>>
>>>> From: Michael Riesch <michael.riesch@wolfvision.net>
>>>>
>>>> Add the controls V4L2_CID_FOCUS_STATUS and V4L2_CID_ZOOM_STATUS that report
>>>> the status of the zoom lens group and the focus lens group, respectively.
>>>> The returned data structure contains the current position of the lens group
>>>> as well as movement indication flags.
>>>>
>>>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>>>> ---
>>>>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 48 ++++++++++++++++++++++
>>>>  drivers/media/v4l2-core/v4l2-ctrls-core.c          |  9 ++++
>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  7 ++++
>>>>  include/media/v4l2-ctrls.h                         |  2 +
>>>>  include/uapi/linux/v4l2-controls.h                 | 13 ++++++
>>>>  include/uapi/linux/videodev2.h                     |  2 +
>>>>  6 files changed, 81 insertions(+)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>>>> index daa4f40869f8..3a270bc63f1a 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>>>> @@ -149,6 +149,30 @@ enum v4l2_exposure_metering -
>>>>      to the camera, negative values towards infinity. This is a
>>>>      write-only control.
>>>>
>>>> +``V4L2_CID_FOCUS_STATUS (struct)``
>>>> +    The current status of the focus lens group. This is a read-only control.
>>>> +    The returned data structure contains the current position and movement
>>>> +    indication flags. The unit of the current position is undefined. Positive
>>>> +    values move the focus closer to the camera, negative values towards
>>>> +    infinity. The possible flags are described in the table below.
>>>
>>> The units are undefined, but positive and negative mean something with
>>> respect to some unspecified focal distance represented by 0. That
>>> seems a little odd.
>>>
>>> I was going to suggest that it seems to make sense to follow the same
>>> units as V4L2_CID_FOCUS_ABSOLUTE, but on reading that description in
>>> [1] it's the same text.
>>> I suspect there was a little too much copy/paste from
>>> V4L2_CID_FOCUS_RELATIVE, or the intent was that increasing the value
>>> brings the focus closer, and decreasing moves it towards infinity.
>>>
>>> If we did specify that it was the same units as
>>> V4L2_CID_FOCUS_ABSOLUTE, then what would that mean for use with
>>> V4L2_CID_FOCUS_RELATIVE? Then again the only user of _RELATIVE appears
>>> to be ov5693 with atomisp and that just maps it onto _ABSOLUTE, so
>>> potentially it's redundant and could be deprecated.
>>>
>>> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-camera.html
>>
>> I think we agree that the _STATUS controls should use the same unit as
>> the corresponding _ABSOLUTE control, whatever that may be.
>>
>> Then, the question is whether the description of FOCUS_ABSOLUTE needs to
>> be revised. I would agree that the intention probably was: "Larger
>> values move the focus closer to the camera, smaller values move the
>> focus to infinity." (cf. the phrasing in the description of IRIS_ABSOLUTE).
>>
>> It would be interesting to know whether zero and negative values are
>> (intentionally?) included. Since they are not explicitly excluded, my
>> driver exposes the position of the lens in motor steps to the user
>> space. If the values were (supposed to be) restricted to positive values
>> like ZOOM_ABSOLUTE, this would not be allowed of course.
>>
>> As to the relation to _RELATIVE, I think it should be clear that all
>> controls should act on the same scale and I don't see any problems here.
>> However, feel free to point out what I am missing :-)
>>
>>>> +
>>>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>>>> +
>>>> +.. flat-table::
>>>> +    :header-rows:  0
>>>> +    :stub-columns: 0
>>>> +
>>>> +    * - ``V4L2_LENS_STATUS_IDLE``
>>>> +      - Focus lens group is at rest.
>>>> +    * - ``V4L2_LENS_STATUS_BUSY``
>>>> +      - Focus lens group is moving.
>>>> +    * - ``V4L2_LENS_STATUS_REACHED``
>>>> +      - Focus lens group has reached its target position.
>>>> +    * - ``V4L2_LENS_STATUS_FAILED``
>>>> +      - Focus lens group has failed to reach its target position. The driver
>>>> +       will not transition from this state until another action is performed
>>>> +       by an application.
>>>
>>> When would the lens state transition from V4L2_LENS_STATUS_REACHED to
>>> V4L2_LENS_STATUS_IDLE?
>>> If it's reached the position then it is at rest, and being at rest is
>>> the definition of V4L2_LENS_STATUS_IDLE.
>>> Likewise the lens always has a target position based on the control
>>> value, so it's always at V4L2_LENS_STATUS_REACHED when it's not
>>> moving.
>>> Is there a need to have 2 states?
>>
>> Good point, I need to reconsider that (and possibly remove one of those
>> states).
>>
>>> If the position is the same units as V4L2_CID_FOCUS_ABSOLUTE, then do
>>> you leave the determination of state to the application?
>>
>> I am afraid I don't quite follow.
> 
> If the application sets V4L2_CID_FOCUS_ABSOLUTE to 42, and
> V4L2_CID_FOCUS_STATUS returns that the position is now 42, then the
> application knows that the lens has reached the requested position. If
> the two controls return different values then the lens is still
> moving.
> What new information does adding an additional status flag give you?

I can think of two situations:

 - Hardware error: the lens stops at 40 (for whatever reason). Since 40
   != 42 the lens is still moving, although a hardware error has occured
   that may need recovery or at least reporting.

 - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
   then what happens if the application performs a
   V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
   V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
   the application's point of view.

Don't get me wrong, a simple control that reports the current position
would be way easier. But I feel that we may regret this in the future.
Also, I would not use two separate controls "current" and "flags/status"
in order to avoid non-atomic access patterns.

> (Thinking aloud) I guess you have got my case where your readback is
> via an ADC so that the position may fluctuate slightly due to
> conversion noise. The control loop for applying power to the motors
> will presumably stop at some point and stop trying to adjust the
> position, so potentially it could be the state returned from that
> control loop. However the noisy ADC position could also be solved by
> the position being returned by the control loop instead of giving the
> raw value.

With stepper motors the readback is not that noisy, but in any case the
flags field allows an underlying controller to signal certain conditions
without relying on the exact value of the current position. I think that
is a plus, especially for noisy readback.

>> But FWIW the application should read out the flags to find out whether
>> the lens is moving and, if this is not the case, whether the last move
>> command (FOCUS_ABSOLUTE or FOCUS_RELATIVE) has succeeded or failed. The
>> failed state is important as there might be the possibility that
>> depending on the zoom lens position certain focus positions are not
>> available (and vice versa).
> 
> How would you configure those kinds of restrictions in the kernel
> driver? Is the kernel driver the best place to do it (so many things
> are being kicked back to userspace these days)?

In our case we have a hardware controller that needs to handle the
restrictions anyway in order to avoid mechanical damage. The kernel
driver is only responsible for reading out the controller status and
transforming it into the V4L2 control.

I am not sure how any restrictions can be reliably handled in software,
hence I don't have a strong opinion on whether this is done in kernel or
user space.

> If it is to be done in the kernel, then shouldn't eg changing the zoom
> position alter the ranges advertised for the relevant focus controls?

While it should be possible to update the minimum and maximum of e.g.,
FOCUS_ABSOLUTE, I am not sure whether the interface is designed for
frequent re-reading of the range.

> If the ranges aren't updated, where should that out-of-range lens
> movement leave the lens?

This is up to the hardware controller, but I would guess it typically
stops one step before disaster. Wherever that may be, the error
condition and the current position can be read out via this new STATUS
control.

Does this sound good so far?

Best regards,
Michael

> 
>   Dave
> 
>>>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>>>>      Enables continuous automatic focus adjustments. The effect of manual
>>>>      focus adjustments while this feature is enabled is undefined,
>>>> @@ -239,6 +263,30 @@ enum v4l2_auto_focus_range -
>>>>      movement. A negative value moves the zoom lens group towards the
>>>>      wide-angle direction. The zoom speed unit is driver-specific.
>>>>
>>>> +``V4L2_CID_ZOOM_STATUS (struct)``
>>>> +    The current status of the zoom lens group. This is a read-only control.
>>>> +    The returned data structure contains the current position and movement
>>>> +    indication flags. The unit of the current position is driver-specific and
>>>> +    its value should be a positive integer. The possible flags are described
>>>> +    in the table below.
>>>> +
>>>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>>>> +
>>>> +.. flat-table::
>>>> +    :header-rows:  0
>>>> +    :stub-columns: 0
>>>> +
>>>> +    * - ``V4L2_LENS_STATUS_IDLE``
>>>> +      - Zoom lens group is at rest.
>>>> +    * - ``V4L2_LENS_STATUS_BUSY``
>>>> +      - Zoom lens group is moving.
>>>> +    * - ``V4L2_LENS_STATUS_REACHED``
>>>> +      - Zoom lens group has reached its target position.
>>>> +    * - ``V4L2_LENS_STATUS_FAILED``
>>>> +      - Zoom lens group has failed to reach its target position. The driver will
>>>> +       not transition from this state until another action is performed by an
>>>> +       application.
>>>> +
>>>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>>>>      This control sets the camera's aperture to the specified value. The
>>>>      unit is undefined. Larger values open the iris wider, smaller values
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>> index 29169170880a..f6ad30f311c5 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>> @@ -350,6 +350,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
>>>>         case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
>>>>                 pr_cont("HEVC_DECODE_PARAMS");
>>>>                 break;
>>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>>>> +               pr_cont("LENS_STATUS");
>>>> +               break;
>>>>         default:
>>>>                 pr_cont("unknown type %d", ctrl->type);
>>>>                 break;
>>>> @@ -918,6 +921,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>>>>                         return -EINVAL;
>>>>                 break;
>>>>
>>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>>>> +               break;
>>>> +
>>>>         default:
>>>>                 return -EINVAL;
>>>>         }
>>>> @@ -1605,6 +1611,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
>>>>         case V4L2_CTRL_TYPE_AREA:
>>>>                 elem_size = sizeof(struct v4l2_area);
>>>>                 break;
>>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>>>> +               elem_size = sizeof(struct v4l2_ctrl_lens_status);
>>>> +               break;
>>>>         default:
>>>>                 if (type < V4L2_CTRL_COMPOUND_TYPES)
>>>>                         elem_size = sizeof(s32);
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> index 564fedee2c88..9b26a3aa9e9c 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> @@ -1044,6 +1044,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>         case V4L2_CID_CAMERA_ORIENTATION:       return "Camera Orientation";
>>>>         case V4L2_CID_CAMERA_SENSOR_ROTATION:   return "Camera Sensor Rotation";
>>>>         case V4L2_CID_HDR_SENSOR_MODE:          return "HDR Sensor Mode";
>>>> +       case V4L2_CID_FOCUS_STATUS:             return "Focus, Status";
>>>> +       case V4L2_CID_ZOOM_STATUS:              return "Zoom, Status";
>>>
>>> Is there a need for the comma in the text strings?
>>
>> Not sure, actually. Some other strings used commas. Monkey see, monkey do.
>>
>> Best regards,
>> Michael
>>
>>>
>>> Cheers
>>>   Dave
>>>
>>>>
>>>>         /* FM Radio Modulator controls */
>>>>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
>>>> @@ -1593,6 +1595,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>>>                 *flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>>>>                           V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>>>>                 break;
>>>> +       case V4L2_CID_FOCUS_STATUS:
>>>> +       case V4L2_CID_ZOOM_STATUS:
>>>> +               *type = V4L2_CTRL_TYPE_LENS_STATUS;
>>>> +               *flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
>>>> +               break;
>>>>         case V4L2_CID_FLASH_STROBE_STATUS:
>>>>         case V4L2_CID_AUTO_FOCUS_STATUS:
>>>>         case V4L2_CID_FLASH_READY:
>>>> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
>>>> index e59d9a234631..f7273ffc20c9 100644
>>>> --- a/include/media/v4l2-ctrls.h
>>>> +++ b/include/media/v4l2-ctrls.h
>>>> @@ -52,6 +52,7 @@ struct video_device;
>>>>   * @p_hdr10_cll:               Pointer to an HDR10 Content Light Level structure.
>>>>   * @p_hdr10_mastering:         Pointer to an HDR10 Mastering Display structure.
>>>>   * @p_area:                    Pointer to an area.
>>>> + * @p_lens_status:             Pointer to a lens status structure.
>>>>   * @p:                         Pointer to a compound value.
>>>>   * @p_const:                   Pointer to a constant compound value.
>>>>   */
>>>> @@ -81,6 +82,7 @@ union v4l2_ctrl_ptr {
>>>>         struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
>>>>         struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
>>>>         struct v4l2_area *p_area;
>>>> +       struct v4l2_ctrl_lens_status *p_lens_status;
>>>>         void *p;
>>>>         const void *p_const;
>>>>  };
>>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>>>> index 5e80daa4ffe0..8b037467ba9a 100644
>>>> --- a/include/uapi/linux/v4l2-controls.h
>>>> +++ b/include/uapi/linux/v4l2-controls.h
>>>> @@ -993,6 +993,19 @@ enum v4l2_auto_focus_range {
>>>>
>>>>  #define V4L2_CID_HDR_SENSOR_MODE               (V4L2_CID_CAMERA_CLASS_BASE+36)
>>>>
>>>> +struct v4l2_ctrl_lens_status {
>>>> +       __u32 flags;
>>>> +       __s32 current_position;
>>>> +};
>>>> +
>>>> +#define V4L2_LENS_STATUS_IDLE                  (0 << 0)
>>>> +#define V4L2_LENS_STATUS_BUSY                  (1 << 0)
>>>> +#define V4L2_LENS_STATUS_REACHED               (1 << 1)
>>>> +#define V4L2_LENS_STATUS_FAILED                        (1 << 2)
>>>> +
>>>> +#define V4L2_CID_FOCUS_STATUS                  (V4L2_CID_CAMERA_CLASS_BASE + 37)
>>>> +#define V4L2_CID_ZOOM_STATUS                   (V4L2_CID_CAMERA_CLASS_BASE + 38)
>>>> +
>>>>  /* FM Modulator class control IDs */
>>>>
>>>>  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX | 0x900)
>>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>> index 17a9b975177a..256c21c68720 100644
>>>> --- a/include/uapi/linux/videodev2.h
>>>> +++ b/include/uapi/linux/videodev2.h
>>>> @@ -1888,6 +1888,8 @@ enum v4l2_ctrl_type {
>>>>         V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS        = 0x0272,
>>>>         V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX      = 0x0273,
>>>>         V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS       = 0x0274,
>>>> +
>>>> +       V4L2_CTRL_TYPE_LENS_STATUS              = 0x0300,
>>>>  };
>>>>
>>>>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
>>>>
>>>> --
>>>> 2.30.2
>>>>
