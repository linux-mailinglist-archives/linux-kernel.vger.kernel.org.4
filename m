Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE7645470
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLGHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLGHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:18:33 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2A2183C;
        Tue,  6 Dec 2022 23:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCHhkAYe7K/3+m4w2wEOPbcB/0dEidNpFzGiIrLynGUJMJk4nDc8lwaVBWmhiUvWz7U/CJkHtwHK3j0RJqk3s251UtL+XYV9ck94SZX7xCxvWFqQBX3AKg5itSelTiBdSwPvYcgLiuYyl+e7cUgYwz+EsoyEbevrFvRhyJLVygJ6NjfMu5Y9/ormGJuy/Mf9uGplxRHbDmoQM9gq8DrpxAvRR8d/tbWFULYgJzlh0IyrIxOgRv6mqaj9kzVfUtuYrgqiBeH1Z77dWGd0MOs/6JfW0lz0eYdbFozxFFs/JFux/+kKgdXGSsJ436PXsKrbpfvY7HOFLOCnYr5QkKTLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/QklCoikcUASk/W4P6RMoEJzUWhTTyotAhAS4Z65ow=;
 b=fbYj1OmpDsoOcqqDxQX7szqKwLM6C72/2ABXlKRtiGzr695Lyo41Ab7khWCcx650aTTMOHyJPw7ig3iwnmisYWxqBCpL2u9+w6htSVB+kzV2Pp6HmDU3/dTh9UOlJSZWShId8wmaq6dnH//qo2pJitLuCH0+Us81oHZJfIfuUUS2PqHXJ4VkS8wWivsgFDADJwBEGkE3WY9DMnVwPk4QzXOhBAxmw8mCIfxh3/0fPdJ2OlR05c1QzO5LELEV4BomBiu2TE3OUXLsFXTpN8hzGfpW2DEpWpB7MyqVd1HUtNYAKavx2qCFaonw59jExLbEIVDEd725WN2IpzAyCyng5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/QklCoikcUASk/W4P6RMoEJzUWhTTyotAhAS4Z65ow=;
 b=TwzQFDxZ9D/ZR1fkP7HyC9gHeDGxhiIAcnKW4vj75ea9TrIEtupvLWiIkELTOH9/PA8R9YjmoXfPqdVUabGvcobzm2odFs/0CI9TjbaWEyowx83MjlsstcgfVaS4trOkHUqXDhBeuDwcugp6x6TaLa+cm1xSzhT2PS/b5Ql0+d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CO6PR03MB6241.namprd03.prod.outlook.com (2603:10b6:303:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 07:18:30 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 07:18:30 +0000
Message-ID: <07385baa-9e82-9fc8-5cc1-cc1089e87fdb@synaptics.com>
Date:   Wed, 7 Dec 2022 15:18:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V2] [media] v4l2: Add AV1 pixel format
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, hui.zhang@amlogic.com,
        lele.xiang@amlogic.com, Shi Hao <hao.shi@amlogic.com>,
        laurent.pinchart@ideasonboard.com, nanxin.qin@amlogic.com
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
 <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
 <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
 <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45)
 To DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CO6PR03MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a473e1-d9f4-4816-b7ee-08dad8233dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSNgYZIHQ1A30j1vGIlxi9TDBz3qCCSwLqYrOV34Jd0eNI0C2RuPnqbEkNIeU0lFH3c/YUGk6aE7zl/0nO62AwnLmZQVRjuYMgKRZjBm6eRxaEx7tfo736aHG7YoZbB+sy53heaPROn/4mY/Mf97TYndA8k8FZK3qZJyaU7wWKKPaosceG5c/Ot7HBgrlrMS3Ogq4EkLHN8CQqPJKBIBT6Nf4aMi+f8IXL3CzTBFXHLoRydWeXoB0dKdES+mAwSXP36aXwZqO57y2ChmttRlGs1RfOMLJWKStbf72ynyVRxf1O5dgDQANlgmURhtSXEwyn9d3R9DVTUiUkoiOce8LEyiq9+95ZbLFvt1q8bg9OBu+Qr86Q6X1xvVD3saskA6uwYhOHEM8u6XWvV6ZY2F+YeQNbb90r4tCW+K+OvMavfYUnzyT2GIUWY5WeCfT6ZkWciCXD2Jk2uWEPbBr98yTl9OZ8D4nPYi/fEjnEibToChmTHPpDqs7BXJv8bJDFeRoHEsUz0jSIBHfp1LJZcs2UTEe5iWgWOuGWEYtGqeZGPsT1ikEyptZxEovaw3Ux5Q7P4jlwo4hNY9jTt6gvNvJUcIfavj78aIsqDmicIRFN49uStOpWgWlYRQoeSVSYgvJiDdB93/UsF/YKb3+bl2T0flH3hoBk1O1Hzx6BDK2dwzKFXa04wxvFDUV0D/fiYvs5i00LdINMZOlxihEyng7raA2TttVCzFro5iHdfgpCxTCBY3fAz6r9gCfp2eKGADuCU2YkDohNghnQaM9pjEqANnqlNZZWOmrRqdeZZ/j6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39850400004)(376002)(366004)(451199015)(83380400001)(86362001)(8936002)(31696002)(5660300002)(38350700002)(2906002)(66574015)(7416002)(4326008)(41300700001)(478600001)(186003)(26005)(53546011)(6506007)(6512007)(52116002)(6666004)(66946007)(2616005)(66556008)(6916009)(66476007)(966005)(31686004)(6486002)(316002)(8676002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHp6QUtEd21xb1BRNXhmamZYY3F5WDhQWEIvTktsRHNSSXRFMmpmVktNbUti?=
 =?utf-8?B?Si80UnF2MWZEL3owMWVNWXpNVGhzQXZYTkZWQnpFSnlIWjRneGJlanpsQk5D?=
 =?utf-8?B?OWJrZlhYbkp6RmF6Z3Q0MjNlNy8rMzIybVZUeXZ2ZS9kdVMzQW1HS09scVlO?=
 =?utf-8?B?VTNUemxWdjM1WmhOT0ZkblU4T3dwcXZJY1RXUkk1elhFZDZaTTBDMElFczY3?=
 =?utf-8?B?VmlseHlWVi9oZkhaOEJUdk1XdXJjV3dDTituc1c2NnpXTkVmR2FyeWxsaGRa?=
 =?utf-8?B?UXVlL0h5d1MwUWE4UzhDRVdGdlZLT2ovZ3I2UWdsd3Z1b2FzKy9jMzdYTmtF?=
 =?utf-8?B?dnVuanVqNXI3eHBSQy9ZSEZUOXMyaWlObGFsdkhMMllzTkkxb01XWU5VRitQ?=
 =?utf-8?B?Zmd4SUR0a2R0Q3hoM0tvUmU3SWR3cGNocWxMUGhMZ2hlZGF6aEtJQ0NVaUxx?=
 =?utf-8?B?elJFcHRaenlTK2VIckJsYTkxSU1aUEFrWGxqRy9zN0Q2WGFVM3BBRC9JRWZl?=
 =?utf-8?B?dHVTemYzYmJCcitlaWdpR3VsUHBqaXpGalVENzZ4cEM4REpHb0R1YTQ3UkNR?=
 =?utf-8?B?UkRvY0RRRGlhNWhhNkpIZUxBU3Fhb3lnemlyMkx5MkJPU0IzQXV6bE02OEJP?=
 =?utf-8?B?aDl0amE0UmlqbkJTWmhET3JPWlF5MUxyTHh3cTI5WDNkdkhkRVpnODhqV0NF?=
 =?utf-8?B?cUtITUpSYS9FOUw3SUxzVXdYMnY4bm1ielZyVkJ0REJ0SFV3eU9MRDllUlk4?=
 =?utf-8?B?Qzg5MTJrbFc4Wi9telExNVFaRGM5SVZzQnpSMTZIeThha095LzNWcGUyRUdS?=
 =?utf-8?B?UFdUSlp0V1MzYVlHRjFnQWtwakhKZGlxRld1b0FJTDlldDBFdk4xNnhTdFVI?=
 =?utf-8?B?ZjVaSGhJMXlwYkUxZDVMQzVWaFlLZFp5Zlg0ZEtDK2VYRFEvbW9qZEpJakE2?=
 =?utf-8?B?S0YrUFhDQkdUZlFNVEJreFQ1RjBOUDlwUDRXcG85SnNtNzNDWUdPZ2Q0R1Vn?=
 =?utf-8?B?QzhJVW5mT2l0elh4NjM4dU4rRkpIS25XNmRhQlVYMVpvZVR5Q2RXdU8rU0g2?=
 =?utf-8?B?bHo0QWdKZXA0R015UHJqZDZOYS90c1FQWENTclgzZHREVUlSZm42MXNSWG05?=
 =?utf-8?B?UFRQUENHMHJYbjFYNG42TWJNYUdieVhzamM2NkhINDV3VGtSS25wMG5nYVZ5?=
 =?utf-8?B?TnlaRGtSdWRaWnpwaXQ2ZUc0d21GdzA3UHZVSzBrV0kzNzIzcTY3NzgyQUN4?=
 =?utf-8?B?QUY3a0lGRmwzOU9kRmNVQlZlUGFhUmhHOFpSaUV5Y01WNWxxYXRiZ0lVOFJS?=
 =?utf-8?B?d21ZQTcxd1owNklHQ1luTWZZRC9LUW5yZWV6ZEQ3Mk5MTnNVc2VqaHRldXZw?=
 =?utf-8?B?MmhMVzdOU0p6TThQU1FDWXR5eVdmZkNwQ2hUOEFIYldoRzcxNlhPUXE3b0Fo?=
 =?utf-8?B?WFBmbjVPQVZLakY5SDFISk9HSldiL0NLT1NRZkNQZHk5QUZ1WkYzUUZQMmlY?=
 =?utf-8?B?VlVnemxTS3p0N09wK3QwSGs2bEZMeG1RaExHcDdLbDQyTG9Jc2ZLOWVDby9a?=
 =?utf-8?B?ZVB0QUh5ZEFhOHJJcCtReG9QWE9vVERQaVJPZzlpQVE2WElwNkcvUlJJSyth?=
 =?utf-8?B?b3VTTWU3YmZQQncycXJ2emdZYkVGaEkwZWNwZUU1aStMZk1KV2NSQlZteVdN?=
 =?utf-8?B?YS9qbklUcGttdU9yYnc0OHNiUW9pemJOakNnRVI5c0Y4c1JobldSY0FUbzVG?=
 =?utf-8?B?YTUrRFNsbEU5MGx3eG5YdEdnUDQxem9OUHpYWk9DNkVUcjhiRjAxMlJNZklF?=
 =?utf-8?B?NzlPcmIvTHFKaXpuUi96aXNSVFBxejl1Y0M4Njl2dkdHTXBMK1diUjZNcXB2?=
 =?utf-8?B?c01sUjFMQ3M5Q0VhdG84WUczMXBESEhNdDJma0I0RkhNT21ZYXJPZW1jUU4y?=
 =?utf-8?B?VVFOd0NlOG93SStWZEZjd1FwZll1a1dUaHZKT294WEFiUG1Ybzl4U3V2QSs3?=
 =?utf-8?B?KzR6d2tuM3pPZ1lyaGxFOEdTUTZpQkFQUFZEYXpsRlVkNEVKODFHZDJlTzZE?=
 =?utf-8?B?OVdCU0J2Z0NNVnBpTVBCTE1BWkV4QXVEd2FWV2FUVHhIMmtYVFhCYkNQeVIy?=
 =?utf-8?Q?t/SWzcNaBKxmN+jsH1KW3EBiD?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a473e1-d9f4-4816-b7ee-08dad8233dba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 07:18:29.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T7hFzlQHqqeqn955H/clewZB83nt9pf0h1uowEgtF3AAV8m994bX2KnHeu2v0jlnCQp623GjJQA6ea646rYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/22 02:03, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le mardi 29 novembre 2022 à 18:32 +0800, Hsia-Jun Li a écrit :
>> Hello
>>
>> I think we need to add an extra event for VP9 and AV1 which support
>> frame scaling, which means its frame width and height could be different
>> to the previous frame or reference frame.
>>
>> That would be more possible for the VP9 as there is not a sequence
>> header for VP9.
> 
> The solution is unlikely in the form of an event, but yes, to complete VP9
> support (and improve AV1 support) a mechanism need to be designed and specified
> to handle inter-frame resolution changes.
> 
> Why I say improve AV1, this is because VP9 bitstream does not signal SVC spatial
> streams (the most common use of inter-frame resolution changes). With SVC
> streams, the smaller images are alway decode-only (never displayed). This can be
> at least partially supported as long as the maximum image dimension is signalled
> by the bitstream. This is the case for AV1, but not VP9.
> 
> Stateless decoders are not affected, because userspace is aware of frames being
> decoded, but not displayed. It is also aware that these frames are reference
> frames. While on stateless decoder, userspace usually does not have this
> knowledge. I think one way to solve this, would be for drivers to be able to
> mark a buffer done, with a flag telling userspace that its not to be displayed.
> For the SVC case, the dimensions and stride are irrelevant.
> 
> For true inter-resolution changes, like VP9 supports (though rarely used), this
> needs more APIs. It was suggested to extend CREATE_BUFS, which allow allocation
> with different FMT, with a DELETE_BUFS ioctl, so that userspace can smoothly
> handle the allocation transition. 
This could only solve the problem of never display graphics buffers 
likes golden frame or alternative reference frame.

About the topic timestamp tracking problem in v4l2, maybe we could start 
a new thread or move them to Gstreamer.
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1619

My idea here is event attached to buffer or just using the new request 
supported in CAPTURE side. I know you worry about the v4l2 event, it is 
out of band, more event could lead to the problem we suffer from 
OpenMAX. If we could have an order between event and buffer, it won't be 
a problem.
For VP9 also, it might be required to support
> super-frame, VP9 supper frames are the ancestor of AV1 TU, and only the last
> frame of a super-frame is every to be displayed. A newly introduced AV1 format
> might also requires complete TU, rather then frames, this needs strict
> documentation.
I don't think the temporal unit is a good idea here.
Most of hardware could only decode a frame once or less likes a 
tile(likes slice in ITU codecs).

Considering the MPEG-TS case,
https://aomediacodec.github.io/av1-mpeg2-ts/
Decodable Frame Group could be more a better idea.
Temporal Unit would lead to larger delay.

  Decoding frames would mean that un-display and frame of different
> sizes get delivered, and we don't have a method to communicate these frame
> dimension and strides at the moment.
> 
> Nicolas
> 
> 
> 
>>
>> On 9/12/22 23:45, Nicolas Dufresne wrote:
>>> Hi Shi,
>>>
>>> thanks for the patches, check inline for some comments. Generally speaking, we
>>> don't usually add formats ahead of time unless we have a good rationale to do
>>> so. Should be expect a companion series against the amlogic decoder driver that
>>> enables this ?
>>>
>>> Le mardi 30 août 2022 à 09:40 +0800, Shi Hao a écrit :
>>>> From: "hao.shi" <hao.shi@amlogic.com>
>>>>
>>>> Add AV1 compressed pixel format. It is the more common format.
>>>>
>>>> Signed-off-by: Hao Shi <hao.shi@amlogic.com>
>>>> ---
>>>>    .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 +++++++++
>>>>    drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
>>>>    include/uapi/linux/videodev2.h                           | 1 +
>>>>    3 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>> index 506dd3c98884..5bdeeebdf9f5 100644
>>>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>> @@ -232,6 +232,15 @@ Compressed Formats
>>>>            Metadata associated with the frame to decode is required to be passed
>>>>            through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>>>>            See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
>>>> +    * .. _V4L2-PIX-FMT-AV1:
>>>> +
>>>> +      - ``V4L2_PIX_FMT_AV1``
>>>> +      - 'AV1'
>>>> +      - AV1 Access Unit. The decoder expects one Access Unit per buffer.
>>>
>>> I believe this is using a MPEG LA terminology. Did you mean a Temporal Unit (TU)
>>> ? In AV1 a TU represent 1 displayable picture, just like AU in H.264 (if you
>>> ignore interlaced video).
>> I think it should be a complete tile group obu. From the spec, we have
>> the term 'frame'.
>>
>> Currently, AV1 doesn't support interlace.
>>>
>>>> +        The encoder generates one Access Unit per buffer. This format is
>>>> +        adapted for stateful video decoders. AV1 (AOMedia Video 1) is an
>>>> +        open video coding format. It was developed as a successor to VP9
>>>> +        by the Alliance for Open Media (AOMedia).
>>>>
>>>>    .. raw:: latex
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> index c314025d977e..fc0f43228546 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>>>                    case V4L2_PIX_FMT_MT21C:        descr = "Mediatek Compressed Format"; break;
>>>>                    case V4L2_PIX_FMT_QC08C:        descr = "QCOM Compressed 8-bit Format"; break;
>>>>                    case V4L2_PIX_FMT_QC10C:        descr = "QCOM Compressed 10-bit Format"; break;
>>>> +         case V4L2_PIX_FMT_AV1:          descr = "AV1"; break;
>>>>                    default:
>>>>                            if (fmt->description[0])
>>>>                                    return;
>>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>> index 01e630f2ec78..c5ea9f38d807 100644
>>>> --- a/include/uapi/linux/videodev2.h
>>>> +++ b/include/uapi/linux/videodev2.h
>>>> @@ -738,6 +738,7 @@ struct v4l2_pix_format {
>>>>    #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
>>>>    #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>>>    #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
>>>>
>>>>    /*  Vendor-specific formats   */
>>>>    #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
>>>>
>>>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>
>>>
>>
> 

-- 
Hsia-Jun(Randy) Li
Spelling

Possible spelling mistake found.

OpenVASPentaxOpenStaxOpenAIPenman

Add "OpenMAX" to personal dictionary

Ignore in this text

LanguageTool

basic

