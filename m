Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8D745A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGCKxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:53:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E60FB2;
        Mon,  3 Jul 2023 03:53:43 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:4563:92b0:7df7:68d2] (unknown [IPv6:2a01:e0a:120:3210:4563:92b0:7df7:68d2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BD3966015A0;
        Mon,  3 Jul 2023 11:53:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688381621;
        bh=nbKxX8264yKf/A19pKZCQVQRbFGD7v53KfDoUX7cgm8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bgG+8q0H+AWwxBmLYV0xDc5drfIeEBZHmYsEWY+O+A4uaRsuvGapFCz3qTvx7QJ7m
         bvtlnF1hCdLWtuBxMCjGb/Cs6jLbHyZeoi8Y0k3CTOxUJ4InFaQE/8aPEVEV78ATqn
         NjMKBumw7MnLTyM03yo8znRxjb0ge6dWcuKRLS7wF1+uhIlGX9HXYBZRON3oILVUeF
         G+L9Vi4GRzTZLKOGiD5tzQ9yCdn0DF0qHBwoFmTmLYXUS0y20bwCJcCATPX2Zkfb6D
         BE3wUdHz2pIOOLXxDYVPUHxY4xaKyPvLLjnSWbMvCRQ+VbNCrHI0yqa8OFqfUIAwgR
         33D+FXawfxPpA==
Message-ID: <a0d987e0-fcad-be76-a40d-2b5d43bd63b9@collabora.com>
Date:   Mon, 3 Jul 2023 12:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as
 global
Content-Language: en-US
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, linux-staging@lists.linux.dev,
        ming.qian@nxp.com, kernel@collabora.com,
        gregkh@linuxfoundation.org, tfiga@chromium.org,
        nicolas.dufresne@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com>
 <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com>
 <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 03/07/2023 à 10:35, Hsia-Jun Li a écrit :
>
> On 7/3/23 16:09, Benjamin Gaignard wrote:
>> CAUTION: Email originated externally, do not click links or open 
>> attachments unless you recognize the sender and know the content is 
>> safe.
>>
>>
>> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>>
>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>> CAUTION: Email originated externally, do not click links or open
>>>> attachments unless you recognize the sender and know the content is
>>>> safe.
>>>>
>>>>
>>>> After changing bufs arrays to a dynamic allocated array
>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>>
>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>>> more reasonable.
>>>
>>> It would be hard to iterate the whole array, it would go worse with a
>>> filter. Such iterate may need to go twice because you mix
>>> post-processing buffer and decoding buffer(with MV) in the same array.
>>
>> Here I don't want to change drivers behavior so I keep the same value.
>> If it happens that they need more buffers, like for dynamic 
>> resolution change
>> feature for Verisilicon VP9 decoder, case by case patches will be 
>> needed.
>>
> I just don't like the idea that using a variant length array here.

As far I have understand Hans and/or Laurent were happy to use that but I may have misunderstood them.

>
> And I could explain why you won't need so many buffers for the 
> performance of decoding.
>
> VP9 could support 10 reference frames in dpb.
>
> Even for those frequent resolution changing test set, it would only 
> happen to two resolutions,
>
> 32 would be enough for 20 buffers of two resolution plus golden 
> frames. It also leaves enough slots for re-order latency.
>
> If your case had more two resolutions, likes low->medium->high.

VP9 header doesn't tell you that video resolution will change and in which way.
It cloud be from factor x1/2 to x16 and multiple time so you can use lot of (too much) buffers.

>
> I would suggest just skip the medium resolutions, just allocate the 
> lower one first for fast playback then the highest for all the possible
>
> medium cases. Reallocation happens frequently would only cause memory 
> fragment, nothing benefits your performance.
>
>>
>>>
>>>> Remove it from the core definitions but keep it for drivers internal
>>>> needs.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>   drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>>   drivers/media/platform/amphion/vdec.c | 1 +
>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>>   drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>>   drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>>   drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>>   include/media/videobuf2-core.h | 1 -
>>>>   include/media/videobuf2-v4l2.h | 4 ----
>>>>   8 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> index 86e1e926fa45..899783f67580 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> @@ -31,6 +31,8 @@
>>>>
>>>>   #include <trace/events/vb2.h>
>>>>
>>>> +#define VB2_MAX_FRAME  32
>>>> +
>>>>   static int debug;
>>>>   module_param(debug, int, 0644);
>>>>
>>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>>> b/drivers/media/platform/amphion/vdec.c
>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>> @@ -28,6 +28,7 @@
>>>>
>>>>   #define VDEC_MIN_BUFFER_CAP            8
>>>>   #define VDEC_MIN_BUFFER_OUT            8
>>>> +#define VB2_MAX_FRAME                  32
>>>>
>>>>   struct vdec_fs_info {
>>>>          char name[8];
>>>> diff --git
>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>>> --- 
>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>> +++ 
>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>> @@ -16,6 +16,8 @@
>>>>   #include "../vdec_drv_if.h"
>>>>   #include "../vdec_vpu_if.h"
>>>>
>>>> +#define VB2_MAX_FRAME  32
>>>> +
>>>>   /* reset_frame_context defined in VP9 spec */
>>>>   #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>>   #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>>> b/drivers/media/platform/qcom/venus/hfi.h
>>>> index f25d412d6553..bd5ca5a8b945 100644
>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>>> @@ -10,6 +10,8 @@
>>>>
>>>>   #include "hfi_helper.h"
>>>>
>>>> +#define VB2_MAX_FRAME                          32
>>>> +
>>>>   #define VIDC_SESSION_TYPE_VPE                  0
>>>>   #define VIDC_SESSION_TYPE_ENC                  1
>>>>   #define VIDC_SESSION_TYPE_DEC                  2
>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>>> @@ -15,6 +15,8 @@
>>>>   #include <media/v4l2-vp9.h>
>>>>   #include <media/videobuf2-core.h>
>>>>
>>>> +#define VB2_MAX_FRAME  32
>>>> +
>>>>   #define DEC_8190_ALIGN_MASK    0x07U
>>>>
>>>>   #define MB_DIM                 16
>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>> index e530767e80a5..6627b5c2d4d6 100644
>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>> @@ -10,6 +10,8 @@
>>>>   #include "ipu3.h"
>>>>   #include "ipu3-dmamap.h"
>>>>
>>>> +#define VB2_MAX_FRAME  32
>>>> +
>>>>   /******************** v4l2_subdev_ops ********************/
>>>>
>>>>   #define IPU3_RUNNING_MODE_VIDEO                0
>>>> diff --git a/include/media/videobuf2-core.h
>>>> b/include/media/videobuf2-core.h
>>>> index 77921cf894ef..080b783d608d 100644
>>>> --- a/include/media/videobuf2-core.h
>>>> +++ b/include/media/videobuf2-core.h
>>>> @@ -20,7 +20,6 @@
>>>>   #include <media/media-request.h>
>>>>   #include <media/frame_vector.h>
>>>>
>>>> -#define VB2_MAX_FRAME  (32)
>>>>   #define VB2_MAX_PLANES (8)
>>>>
>>>>   /**
>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>> b/include/media/videobuf2-v4l2.h
>>>> index 5a845887850b..88a7a565170e 100644
>>>> --- a/include/media/videobuf2-v4l2.h
>>>> +++ b/include/media/videobuf2-v4l2.h
>>>> @@ -15,10 +15,6 @@
>>>>   #include <linux/videodev2.h>
>>>>   #include <media/videobuf2-core.h>
>>>>
>>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>> -#endif
>>>> -
>>>>   #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>   #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>   #endif
>>>> -- 
>>>> 2.39.2
>>>>
