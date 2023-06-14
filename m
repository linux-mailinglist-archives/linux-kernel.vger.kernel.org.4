Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8F72FD61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbjFNLu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjFNLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:50:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E999BA2;
        Wed, 14 Jun 2023 04:50:23 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7D1E6606ED1;
        Wed, 14 Jun 2023 12:50:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686743422;
        bh=9DNBrynI+HiRfRvrWhvvvBpQCTBoLpIz0X4Xq8IQ6sI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ICb+jwxKt+INPGpAuktKxr8rwW5NNORpaVS8MosEyn3MqXNglbRHCSSdVhUv87RL7
         MSFu/OGJDqR+8DTBIKWhm2p8j/bCOQMXKriA3lC5OBBTQUdWbv3LRv6fqLUwJT/njd
         cXoXzSqPk+ts5b3eebntXZpJRnrAsTFD5T4KHhs32zj4NOAkOuBJ6PPFfK+aFQCJ7s
         nJg46uNkDlzTijh4uMj3uOHuUCIflkpYxebVIUZ2zzQzHDszV4Kdb2vGKGQkVbcRU/
         JTwE46qD677bIJ1tnf4WT57Qv+9WC1/DjZcz+lCFmvyMgCEaccIDh8gNp80B4Rg7Ye
         V7uYccUG9IlAg==
Message-ID: <b89035bf-cbdd-e99a-1332-a11885ae8f8b@collabora.com>
Date:   Wed, 14 Jun 2023 13:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2,04/10] media: mediatek: vcodec: remove the dependency
 of debug log
Content-Language: en-US
To:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
 <20230607084901.28021-5-yunfei.dong@mediatek.com>
 <ad28c125d9efca1f7e422fffe42dd56cef66b349.camel@collabora.com>
 <6bb7e4b283332f1b76c1550347cb245a57eee90b.camel@mediatek.com>
 <ac3f4becf89d909503caeb8a05883fc38afccd41.camel@collabora.com>
 <925956db-9001-7a4f-700e-c84220103201@collabora.com>
 <e1e00e3207784f48b6adc9c3b6ec48f57795228d.camel@collabora.com>
 <1ea03faee8da26e17690c707464ab1cda405a313.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1ea03faee8da26e17690c707464ab1cda405a313.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/06/23 11:17, Yunfei Dong (董云飞) ha scritto:
> Hi AngeloGioacchino,
> 
> How do you think about Nicolas's suggestion?
> 

Please don't top-post!

Nicolas' suggestion looks good. Please go on.

P.S.: Sorry for the late reply.

Cheers,
Angelo


> On Thu, 2023-06-08 at 11:17 -0400, Nicolas Dufresne wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Le jeudi 08 juin 2023 à 16:06 +0200, AngeloGioacchino Del Regno a
>> écrit :
>>> Il 08/06/23 15:11, Nicolas Dufresne ha scritto:
>>>> Le jeudi 08 juin 2023 à 07:27 +0000, Yunfei Dong (董云飞) a écrit :
>>>>> Hi Nicolas,
>>>>>
>>>>> Thanks for your review.
>>>>> On Wed, 2023-06-07 at 21:41 -0400, Nicolas Dufresne wrote:
>>>>>>    
>>>>>> External email : Please do not click links or open
>> attachments until
>>>>>> you have verified the sender or the content.
>>>>>>    Hi Yunfei,
>>>>>>
>>>>>> Le mercredi 07 juin 2023 à 16:48 +0800, Yunfei Dong a écrit :
>>>>>>> 'mtk_vcodec_debug' and 'mtk_vcodec_err' depends on
>> 'mtk_vcodec_ctx'
>>>>>>> to get the index of each instance, using the index directly
>> instead
>>>>>>> of with 'mtk_vcodec_ctx'.
>>>>>>>
>>>>>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>>>>>> ---
>>>>>>>    .../mediatek/vcodec/mtk_vcodec_util.h         |  26 ++-
>>>>>>>    .../vcodec/vdec/vdec_av1_req_lat_if.c         | 105
>> +++++++-----
>>>>>>>    .../mediatek/vcodec/vdec/vdec_h264_if.c       |  62 ++++-
>> --
>>>>>>>    .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  39 +++--
>>>>>>>    .../vcodec/vdec/vdec_h264_req_multi_if.c      |  80
>> +++++----
>>>>>>>    .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  67 ++++-
>> ---
>>>>>>>    .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  54 ++++-
>> --
>>>>>>>    .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  46 +++
>> ---
>>>>>>>    .../mediatek/vcodec/vdec/vdec_vp9_if.c        | 152
>> ++++++++++--
>>>>>> ------
>>>>>>>    .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  84
>> ++++++----
>>>>>>>    .../platform/mediatek/vcodec/vdec_vpu_if.c    |  59 ++++-
>> --
>>>>>>>    .../mediatek/vcodec/venc/venc_h264_if.c       |  86
>> +++++-----
>>>>>>>    .../mediatek/vcodec/venc/venc_vp8_if.c        |  48 +++
>> ---
>>>>>>>    .../platform/mediatek/vcodec/venc_vpu_if.c    |  64 ++++-
>> ---
>>>>>>>    14 files changed, 565 insertions(+), 407 deletions(-)
>>>>>>>
>>>>>>> diff --git
>>>>>> a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>>>> b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>>>>> index ecb0bdf3a4f4..ddc12c3e2983 100644
>>>>>>> ---
>> a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>>>>> +++
>> b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>>>>> @@ -31,9 +31,8 @@ struct mtk_vcodec_dev;
>>>>>>>    #define mtk_v4l2_err(fmt, args...)                \
>>>>>>>    pr_err("[MTK_V4L2][ERROR] " fmt "\n", ##args)
>>>>>>>    
>>>>>>> -#define mtk_vcodec_err(h, fmt, args...)\
>>>>>>> -pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n",\
>>>>>>> -       ((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
>>>>>>> +#define mtk_vcodec_err(plat_dev, inst_id, fmt,
>>>>>> args...)                                 \
>>>>>>> +dev_err(&(plat_dev)->dev, "[MTK_VCODEC][ERROR][%d]: " fmt
>> "\n",
>>>>>> inst_id, ##args)
>>>>>>>    
>>>>>>>    #if defined(CONFIG_DEBUG_FS)
>>>>>>>    extern int mtk_v4l2_dbg_level;
>>>>>>> @@ -46,27 +45,24 @@ extern int mtk_vcodec_dbg;
>>>>>>>     __func__, __LINE__, ##args);        \
>>>>>>>    } while (0)
>>>>>>>    
>>>>>>> -#define mtk_vcodec_debug(h, fmt,
>> args...)                      \
>>>>>>> -do {                      \
>>>>>>> -if (mtk_vcodec_dbg)                      \
>>>>>>> -dev_dbg(&(((struct mtk_vcodec_ctx *)(h)->ctx)->dev-
>>> plat_dev-
>>>>>>> dev),   \
>>>>>>> -"[MTK_VCODEC][%d]: %s, %d " fmt
>> "\n",                         \
>>>>>>> -((struct mtk_vcodec_ctx *)(h)->ctx)-
>>> id,                      \
>>>>>>> -__func__, __LINE__,
>> ##args);                                  \
>>>>>>> +#define mtk_vcodec_debug(plat_dev, inst_id, fmt,
>>>>>> args...)                               \
>>>>>>> +do
>>>>>> {
>>>>>>           \
>>>>>>> +if
>>>>>> (mtk_vcodec_dbg)
>>>>>> \
>>>>>>> +dev_dbg(&(plat_dev)->dev, "[MTK_VCODEC][%d]: %s, %d " fmt
>> "\n", \
>>>>>>
>>>>>> At least in this patch, you systematically pass plat_dev as
>>>>>> <something>->ctx->dev->plat_dev, which is quite long and
>> verbose, any
>>>>>> reason we
>>>>>> can't just pass that <something> here ? We can follow the
>> same
>>>>>> structure path
>>>>>> for both encoder/decoder ?
>>>>>>
>>>>>
>>>>> In order to separate encode and decoder, need to define two
>> different
>>>>> struct mtk_vcodec_dec_ctx and struct mtk_vcodec_enc_ctx.
>>>>>
>>>>> struct mtk_vcodec_ctx won't be used again, need to use platform
>> device
>>>>> to print dev_dbg and dev_err.
>>>>>
>>>>> encoder and decoder using the same interface to print log
>> message.
>>>>
>>>> Just a reminder, I'm just making suggestions, there is no strict
>> action required
>>>> here other then a discussion to try and make the logging a bit
>> more light.
>>>>
>>>> My points was that C macros don't care about types, so if you
>> keep the path to
>>>> the platform device the same (ctx->dev->plat_dev), you could just
>> pass the ctx
>>>> as argument. What I don't know though myself, is if this is
>> actually feasible in
>>>> all code path, but considering you had access to the instance
>> previously, I
>>>> thought it should.
>>>>
>>>
>>> One macro used to access two different structures?
>>>
>>> Please, no.
>>
>> Its up to you. I do think this is an empty statement. Still believe
>> we avoid
>> this code "deterioration". One can always be creative to workaround
>> your
>> concerns.
>>
>> struct base_ctx {
>> struct dev dev;
>> }
>>
>> struct enc_ctx {
>> struct base_ctx;
>> ...
>> }
>>
>> struct src_ctx {
>> ...
>> }
>>
>> But this is in no way more safe then a naming convention, this is
>> macro calls,
>> its not typed.
>>
>> Nicolas
>>
> 
> In order to speed up the upstream progress, maybe we can discuss it in
> chat.
> 
> Best Reagrds,
> Yunfei Dong
>>>
>>> Regards,
>>> Angelo
>>>
>>>> regards,
>>>> Nicolas
>>>>
>>>>>
>>>>> Best Regards,
>>>>> Yunfei Dong
>>>>>>> +inst_id, __func__, __LINE__, ##args);                   \
>>>>>>>    } while (0)
>>>>>>>    #else
>>>>>>>    #define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt,
>> ##args)
>>>>>>>    
>>>>>>> -#define mtk_vcodec_debug(h, fmt, args...)\
>>>>>>> -pr_debug("[MTK_VCODEC][%d]: " fmt "\n",\
>>>>>>
>>>>> ...snip...
>>>>
>>>
>>


