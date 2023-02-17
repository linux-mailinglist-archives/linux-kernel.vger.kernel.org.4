Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459C69A3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjBQClL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:41:09 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D79EEE;
        Thu, 16 Feb 2023 18:41:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfhwHwFNdbdIqgoT5nAPzSCeW7j3KIJZKUlm/xL84G4uHehiD0l/nZXJVxrYd8O2bRsFmJdnG1XpqjVZdQ8dFs4q9x85ET7HWeTM5YWfnYYE+Qh4f6usSDbu3HH0I9u6C1aQhPB4dYh++t+NxEwn+MUf1Q4OkTeECYzMJ0dMXOV1++ZCRuMHf+3fNMJc4jiI7TfNavFNtWhO+coJqxuTvzBgqZhV04/P4rcZDi4oDy0rNoH5daPqMwTJdL4gVvwlMMHhu+ARxGNxqoWLpKGR2hn7ehe+KlX5vE+yNZZSXzStisEwZpycrl+8Bcj7YTFuvLL4y8uh7YisYxHHR2EWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkyBAV0CYzPCfGOH8y7SDB948lMxXbDaLEExlESXGEA=;
 b=f7mjqV5j5dEOxQW+gT1hOZ64LmXOVOp8v+nkE+0MfSWUrAC5eX7MAGcrGal1WZtHIq76A+DAYqlYGKfVzkxf7tc9FZ00zVX30G/hUFPZ+IRSKGApZNTfgZ+nbOd9r70R8ICIFaJRgCvlk6oWfsKGqOnvojhAXGsuMipQG9dupG4EwDbMJ/f9JenN7RW/Cl1hIPdXw8hINtzgzqZ/m0UItaTjKlhMxJithP89TFHbIjgGHZK0hxFHFpN37kfjV/kByvl6TgrZQbO3Rd+SuHRSBCXrzbIBjpemW/H8qLxgAi2dKchNn/XDwiRFmPmnuV8U2AS+7JEXpOt5NmveqsaRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkyBAV0CYzPCfGOH8y7SDB948lMxXbDaLEExlESXGEA=;
 b=O2CbORRHsN4IQ2qvbIJ7UdeQ0Q6BrPvPRIuHEEqWnQNQSp/FIgsZaO+hx0ujhXu0mdx0SkXa1aN6bfU6GYA5EjjEkpeUnnG1dWoVkkdeiuaqNILOyH0kRrjMz3nyUk40jZgsza5cfIqK8RoPVGoTUl+MGdwis/jc8kvUrYgKAiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BY5PR03MB4936.namprd03.prod.outlook.com (2603:10b6:a03:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 02:41:02 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::10e9:e275:9f10:67cc]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::10e9:e275:9f10:67cc%8]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 02:41:02 +0000
Message-ID: <0d9bf4c1-2b7f-3214-df4c-d02d080fe2e9@synaptics.com>
Date:   Fri, 17 Feb 2023 10:40:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 01/12] media: v4l2: Add NV15 pixel format
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
 <20230101-patch-series-v2-6-2-rc1-v2-1-fa1897efac14@collabora.com>
 <aa85c526-da32-d108-f85e-5dcd2cc8c846@synaptics.com>
 <c30fad90fcc48802b6f8be632789a5f034711797.camel@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <c30fad90fcc48802b6f8be632789a5f034711797.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BY5PR03MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed5393a-052b-4010-15cf-08db109068c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocXC3Y0mN9nmC8xshq6d+f8VO/olelV9OL/TAR9nBcipBWc+cY5+9Lcwsf1UdghXE25+fyeqUw+brvB+ZhUgz/76v35uOHAqcT/lp6qi3iLc5309hECUTrb8eeOpGa15lYZkCoYUcoGl5+u6OfV6XWAfSmJGPpT+qIsS5pYobZYlCfA0rpart04JNdqrgh9IiZ/NRb19rcdxfKSN/ZedJfs7XXZYnSyQomi4ngfrfnooIQAbvEbIGldhpvVB+dHU2nThdpFVzKXO0QaC+sJKT+g1zK//I9hNijzZdPUeph04h9zqNFcLiZ2xUgWfk38WZhGS2WWRdPiLuatnV61sjo/50W0Rd4d09o0GGaYXECaU6YLM6l0n5STaxoBz6pgRVcuNhlfOXMkPjk7VK479iU7XBYTHRzSm0VVNA8WbJhcux8dHafeD9DuvUFObSqPkTy74ShW1ZELtjSLyk0gAmMsPJ3UbYYnSdp7AcBiOi9C35PL8aQjRDp4BnD4HQwbUZKn4hl165GgYM/Kg1Cm06sVKOS44FvbyamRF/lKd4PcOFyV7qzRMFmj2y79O/ADI9ltKm2hdnbzI67l7rMuamAqvS8/wS6QJ5VsB1l3RgKwhqtpVcmOQn/vTYdgv8mYK8s1s5O2ZnuNfqSPlxI1wEOkk0IS11+9QMVhiztipNkS5J2Xvl99wPk9hE9mJu4Og/c0aV1UCaTTeHMdC8t/X9ckv6gZsnekgAmm9U1W+dhEzDpaJyEOkkrr9MkAr5oc+qm3QLlK4CUgtAz0GddhCsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(39850400004)(136003)(451199018)(31686004)(2906002)(31696002)(8936002)(36756003)(86362001)(5660300002)(7416002)(38100700002)(83380400001)(38350700002)(52116002)(4326008)(6486002)(6916009)(66476007)(66556008)(66946007)(8676002)(54906003)(41300700001)(6512007)(26005)(53546011)(186003)(6506007)(478600001)(316002)(2616005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGFvYzRYSzEwOXZGYUhpSk9EQXAxMFhjL1psTnFqdnVjVlVnV0JHSUhHWm1X?=
 =?utf-8?B?TFlLNGoyallrclE1MjBVMEZBRUxUZjUzRjI2anc2RStwc0hnT3ZWWTNwWlNZ?=
 =?utf-8?B?UlFjeVVjdXF0T0lrT2g4ckRjaXlhLzkxYUpmZGlsSVJ5ckxMTnVrNWNSNzVW?=
 =?utf-8?B?aUtzUGE3UzZSYUlYT1FrU1hySGI2U2JUZFVHaU1rR1pCZ3dXQmsyTmllNjlp?=
 =?utf-8?B?TVJ6ZWZNTjNWclZXOGpmWHQ0Sm9JTEduRnhFb0did0lnRFh6SURzbys3Zmh4?=
 =?utf-8?B?VXpsV2RHZkFVSFNpUkpTaUNLZlJXdVlHWnRvYTdkUDNlbGZ3bm5oZThwV3JL?=
 =?utf-8?B?Y0ZSZ0pRNnNsbURQa1EwQS8vTkFIZjhzWmpnRW1HRTFKM0dzeUJYQ3VCRStk?=
 =?utf-8?B?aFdJY2FzMzExakM3bTZzWnBXYWhCcFgzNGZxUWRLSDJDZmVVR2pLUVdCalpG?=
 =?utf-8?B?Q2pzVWFpMWU1YkhldzFaMFdPZEVEN1h6dUx6RlI5M1Byams5VEV4eVJxaUt0?=
 =?utf-8?B?b0pYUnN3c3VSUjdGZllxa0FaalNva3FxV1BsZ0dLdC91c0VhbnVwc3hROVZZ?=
 =?utf-8?B?QnF2UVlXWmgydmdMZ0xGZ1JVZXJBV0UybnJubE9PZEpDTGpQUlBIZGVZWkI0?=
 =?utf-8?B?YVh5Um91TDBNK1ZTcHYwRHJRekE0VmRHTTMwd1ZhNTI4NE1WRXdxYzRoeHU2?=
 =?utf-8?B?RXJrcW5mNjJPWnRPMFBaNTJSSTFvdVFJZ1JOT2V1UWdST3dacTk4WGRpUEhi?=
 =?utf-8?B?dkppNGxaTDV6RDdmUld0TncvUEJWQkFERWNraDMyZWF1TWJGQmdIN2dwZExa?=
 =?utf-8?B?N2pvNGtaL2lwVzgzcEFhNWhVbWV1YmZ0RjRTK05ZQ2hvcHVZN0tkVCtQd0hC?=
 =?utf-8?B?OGk2TlBXNTZRWXZ2WUpKVjhIdWtZcGdaVlpGc2JyRWhjbkQ5bHhnL21Cejcr?=
 =?utf-8?B?OGZaYmNkQkhIYVg3WkxmWlIyY1MrTjRWanBEbmRCSFRNWmljYWwwLzZYUkhR?=
 =?utf-8?B?MStRWEV3Si9hVVVYQSs3RGpkakhvOVRmRjNMV2NXc2RPWDJ5V1NkM05Oa1Ax?=
 =?utf-8?B?djB2RW5rbU11UEN3K0xQWW9VckM4azdqZXFSeDdnbU9nRzZsNGx6cXBrNjJj?=
 =?utf-8?B?ZDdiUmNpOFA0NzVnSHE2Rnk3cnM5QTEvMlB0YjVTeU1MMURMN1NUenVaQVQz?=
 =?utf-8?B?N1R3dyswQWxtOEl6TDJKL2g4cFRHNDFRT0ZFbU5vc0V5b0hieVRZWnFYd0JM?=
 =?utf-8?B?RU05NVVxZjhrNlJWM0xUOVZkcWpKUXRjOTJJeUdha1hOZ2dIemdWeDRoK2Ri?=
 =?utf-8?B?TlNyZnFqSjNkb0hyRFNPSlByMTIwZXlMUlJFQ0NPVEJadjE4T3lRZ3FydjdO?=
 =?utf-8?B?TFNvOHFhN0tFL3dBVE1mN1NBQlVFK0VhYzBTazhTT3BlWUVwcGlqQ1BWTVU0?=
 =?utf-8?B?LzRFcVo3K3BTTnJ6WUx4dFZuZkJ3TEl3clZHTE0xZWVGYVhvWkZGMTVQenNl?=
 =?utf-8?B?cDRvazR0WVVtcWpJTjE4RVVnbnFlMGpVTmwyaWtQZFZqdHZybXJNOXA4ZmVJ?=
 =?utf-8?B?WnRiWFIzQnF5S0s0K3lIL05YSzl2aFloUlhIT29vb1VxVmhmSWpPdWgxVVNW?=
 =?utf-8?B?cHowdVdOTmE1d0MzZE9VL2tJQmFVM09yazdQMGFFVVFweVhCYkk3MUorc2Vh?=
 =?utf-8?B?VFZsWEd3RXY3RURYcE00Y3FQVFNtZWtUakxDQ3VXL1dHNHJpUmlwenpPOCs4?=
 =?utf-8?B?ZjlhaDhnS1UvMUttSUJJRzFOM1FYN3ZPWnZmV1VGR3UzeGlDVzNNSktrTi9J?=
 =?utf-8?B?a1FpSTlqbURXQXI3OU9rMzJFcmdTRHg2Q2syS3U5Q1hPcmpoR2w4eFNrUGNL?=
 =?utf-8?B?Z2wyaHNqRUt1ZmpNWTcwMG5uTnRRd1NNNG0zR1p4ZWFoMGJxSWNIYmdJbEFF?=
 =?utf-8?B?bm5QR29UQWlFMVRHT2xmTE1DSE1paFExUlZTYU5XVkkvaXFiSjdRSHZTK1dO?=
 =?utf-8?B?cDFTV1JwY3BmekxTTGhmOXNQbUg2b292OXNHYlVjN01LWC8xNDBNbXRlOVBv?=
 =?utf-8?B?Vkl4cVF2UXU1VmVRalpTdHVqRENtcXVLUjBLcDdQSDlHcDhFQmczQmxFYUNS?=
 =?utf-8?Q?G8LmQNjaiaIcSDyRt2HYRvqF6?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed5393a-052b-4010-15cf-08db109068c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 02:41:02.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmiGYGjVzgqQX1yNseqI19RrPwsvUcOheCNEx/S5BUCt6+av9u9nksIWrhz3G0b9ItDew1gtA9IgnSCF4NdoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4936
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/23 01:00, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le jeudi 16 février 2023 à 16:57 +0800, Hsia-Jun Li a écrit :
>>
>> On 1/12/23 20:56, Sebastian Fricke wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> Add the NV15 pixel format used by the Rockchip Video Decoder for 10-bit buffers.
>>>
>> I think this pixel format in the Rockchip platform supports multiple
>> planes buffers. It is all right not to add more variant until the ext
>> pixel format and buffer APIs are merged.
>>
>> I just want to mention the need of this.
> 
> Can you extend, I don't see that support in rkvdec driver (nor in mpp).
> 
>          /* config output base address */
>          dst_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
>          writel_relaxed(dst_addr, rkvdec->regs + RKVDEC_REG_DECOUT_BASE);
> 
>          reg = RKVDEC_Y_VIRSTRIDE(y_virstride / 16);
>          writel_relaxed(reg, rkvdec->regs + RKVDEC_REG_Y_VIRSTRIDE);
> 
>          reg = RKVDEC_YUV_VIRSTRIDE(yuv_virstride / 16);
>          writel_relaxed(reg, rkvdec->regs + RKVDEC_REG_YUV_VIRSTRIDE);
> 
> That looks like a base address and 2 strides only. For NV15M (multiple
I think the rockchip drm does
VOP_WIN_SET(vop, win, uv_vir, DIV_ROUND_UP(fb->pitches[1], 4));
VOP_WIN_SET(vop, win, uv_mst, dma_addr);

vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
vop2_win_write(win, VOP2_WIN_UV_MST, uv_mst);

> allocation) you'd need 2 addresses. It could be that RGA or newer chip have that
> support, but as you know, we add formats only when actually using them.
 From the public info, it is not just rockchip but also NXP and xilinx 
support this 10bits format. I am not sure whether they would support that.

Besides, I think the rockchip decoder needs some spare space between its 
Y plane and UV plane. It would be hard to present such thing with the 
single plane format unless you want to get the wrong start address of 
the chroma plane.
> 
> regards,
> Nicolas
> 
>>> NV15 is a packed 10-bit 4:2:0 Y/CbCr format similar to P010 and P210 but has no
>>> padding between components. Instead, luminance and chrominance samples are grouped
>>> into 4s so that each group is packed into an integer number of bytes:
>>>
>>> YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes
>>>
>>> The '15' suffix refers to the optimum effective bits per pixel
>>> which is achieved when the total number of luminance samples is a multiple
>>> of 8 for NV15.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>> ---
>>>    .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  | 75 ++++++++++++++++++++++
>>>    drivers/media/v4l2-core/v4l2-common.c              |  2 +
>>>    drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
>>>    include/uapi/linux/videodev2.h                     |  1 +
>>>    4 files changed, 79 insertions(+)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
>>> index f1d5bb7b806d..7d8d228f8063 100644
>>> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
>>> @@ -79,6 +79,13 @@ All components are stored with the same number of bits per component.
>>>          - Cr, Cb
>>>          - Yes
>>>          - Linear
>>> +    * - V4L2_PIX_FMT_NV15
>>> +      - 'NV15'
>>> +      - 15
>>> +      - 4:2:0
>>> +      - Cb, Cr
>>> +      - Yes
>>> +      - Linear
>>>        * - V4L2_PIX_FMT_NV12M
>>>          - 'NM12'
>>>          - 8
>>> @@ -183,6 +190,7 @@ horizontally.
>>>
>>>    .. _V4L2-PIX-FMT-NV12:
>>>    .. _V4L2-PIX-FMT-NV21:
>>> +.. _V4L2-PIX-FMT-NV15:
>>>    .. _V4L2-PIX-FMT-NV12M:
>>>    .. _V4L2-PIX-FMT-NV21M:
>>>    .. _V4L2-PIX-FMT-P010:
>>> @@ -586,6 +594,73 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
>>>          - Cb\ :sub:`11`
>>>          - Cr\ :sub:`11`
>>>
>>> +.. _V4L2_PIX_FMT_NV15:
>>> +
>>> +NV15
>>> +----
>>> +
>>> +Similar to P010, a semi-planar 10-bit Y/CbCr format, but all components are
>>> +packed without any padding between each other. As a side-effect, each group of
>>> +4 components are stored over 5 bytes (YYYY or UVUV = 4 * 10 bits = 40 bits = 5
>>> +bytes).
>>> +
>>> +.. flat-table:: Sample 4x4 NV15 Image
>>> +    :header-rows:  0
>>> +    :stub-columns: 0
>>> +
>>> +    * - start + 0:
>>> +      - Y'\ :sub:`00`
>>> +      - Y'\ :sub:`01`
>>> +      - Y'\ :sub:`02`
>>> +      - Y'\ :sub:`03`
>>> +    * - start + 8:
>>> +      - Y'\ :sub:`04`
>>> +      - Y'\ :sub:`10`
>>> +      - Y'\ :sub:`11`
>>> +      - Y'\ :sub:`12`
>>> +    * - start + 16:
>>> +      - Y'\ :sub:`13`
>>> +      - Y'\ :sub:`14`
>>> +      - Y'\ :sub:`20`
>>> +      - Y'\ :sub:`21`
>>> +    * - start + 24:
>>> +      - Y'\ :sub:`22`
>>> +      - Y'\ :sub:`23`
>>> +      - Y'\ :sub:`24`
>>> +      - Y'\ :sub:`30`
>>> +    * - start + 32:
>>> +      - Y'\ :sub:`31`
>>> +      - Y'\ :sub:`32`
>>> +      - Y'\ :sub:`33`
>>> +      - Y'\ :sub:`34`
>>> +
>>> +    * - start + 0:
>>> +      - Cb\ :sub:`00`
>>> +      - Cr\ :sub:`00`
>>> +      - Cb\ :sub:`01`
>>> +      - Cr\ :sub:`01`
>>> +    * - start + 8:
>>> +      - Cb\ :sub:`02`
>>> +      - Cr\ :sub:`02`
>>> +      - Cb\ :sub:`03`
>>> +      - Cr\ :sub:`03`
>>> +    * - start + 16:
>>> +      - Cb\ :sub:`04`
>>> +      - Cr\ :sub:`04`
>>> +      - Cb\ :sub:`10`
>>> +      - Cr\ :sub:`10`
>>> +    * - start + 24:
>>> +      - Cb\ :sub:`11`
>>> +      - Cr\ :sub:`11`
>>> +      - Cb\ :sub:`12`
>>> +      - Cr\ :sub:`12`
>>> +    * - start + 32:
>>> +      - Cb\ :sub:`13`
>>> +      - Cr\ :sub:`13`
>>> +      - Cb\ :sub:`14`
>>> +      - Cr\ :sub:`14`
>>> +
>>> +.. raw:: latex
>>>
>>>    Fully Planar YUV Formats
>>>    ========================
>>> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
>>> index 40f56e044640..be23e319fb3a 100644
>>> --- a/drivers/media/v4l2-core/v4l2-common.c
>>> +++ b/drivers/media/v4l2-core/v4l2-common.c
>>> @@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>>>                   /* YUV planar formats */
>>>                   { .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>>>                   { .format = V4L2_PIX_FMT_NV21,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>>> +               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
>>> +                 .block_w = { 4, 2, 0, 0 }, .block_h = { 1, 1, 0, 0 } },
>>>                   { .format = V4L2_PIX_FMT_NV16,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>>>                   { .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>>>                   { .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> index 8e0a0ff62a70..1c80ad78ef00 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> @@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>>           case V4L2_PIX_FMT_M420:         descr = "YUV 4:2:0 (M420)"; break;
>>>           case V4L2_PIX_FMT_NV12:         descr = "Y/UV 4:2:0"; break;
>>>           case V4L2_PIX_FMT_NV21:         descr = "Y/VU 4:2:0"; break;
>>> +       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/UV 4:2:0 (Packed)"; break;
>>>           case V4L2_PIX_FMT_NV16:         descr = "Y/UV 4:2:2"; break;
>>>           case V4L2_PIX_FMT_NV61:         descr = "Y/VU 4:2:2"; break;
>>>           case V4L2_PIX_FMT_NV24:         descr = "Y/UV 4:4:4"; break;
>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>> index 1befd181a4cc..e9731286dc77 100644
>>> --- a/include/uapi/linux/videodev2.h
>>> +++ b/include/uapi/linux/videodev2.h
>>> @@ -621,6 +621,7 @@ struct v4l2_pix_format {
>>>    /* two planes -- one Y, one Cr + Cb interleaved  */
>>>    #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
>>>    #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 4:2:0  */
>>> +#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/CbCr 4:2:0 10-bit packed */
>>>    #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 4:2:2  */
>>>    #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>>>    #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
>>>
>>> --
>>> 2.25.1
>>
> 

-- 
Hsia-Jun(Randy) Li
