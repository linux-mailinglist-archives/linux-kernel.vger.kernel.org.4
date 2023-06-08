Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3372C72823D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjFHOHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjFHOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5C2D6B;
        Thu,  8 Jun 2023 07:06:54 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7C866606EC6;
        Thu,  8 Jun 2023 15:06:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686233212;
        bh=kjaR2FllOAiVWb1avCR9mHDwOW3pyNO/oWSCjV78BAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TVvR7iryuWlbkSiuF6gLKPyzY0lkWiW0S4sfQbmL9Ot735qZKnwu7q8Y4m9dy+qNz
         /A8VY9pXimTXQxsP6gmHHAuoIqhBrgdajJGJIPEs149yISjp5O5f9+f4IC+yseut3T
         YX/ciQyFzQN8oeSctF4/or4Gb4OUBCsxyZ9DMgAfinyqCd08/5N08AzL9cOxwiU6Xz
         KPLR3O5cjKx79z2kkuTi3cRsnqpkkPYPACWVqIdSfMzfGwZbT5OvRTy3yktyKzYLvT
         NaPnF8L4ojB0uORsCxJfEACWlKL3mx50QJ6IsMsb/kARqWD7i+L+lDn+ON+7HC9h5I
         9fz8uWy3BERlg==
Message-ID: <925956db-9001-7a4f-700e-c84220103201@collabora.com>
Date:   Thu, 8 Jun 2023 16:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2,04/10] media: mediatek: vcodec: remove the dependency
 of debug log
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ac3f4becf89d909503caeb8a05883fc38afccd41.camel@collabora.com>
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

Il 08/06/23 15:11, Nicolas Dufresne ha scritto:
> Le jeudi 08 juin 2023 à 07:27 +0000, Yunfei Dong (董云飞) a écrit :
>> Hi Nicolas,
>>
>> Thanks for your review.
>> On Wed, 2023-06-07 at 21:41 -0400, Nicolas Dufresne wrote:
>>>   	
>>> External email : Please do not click links or open attachments until
>>> you have verified the sender or the content.
>>>   Hi Yunfei,
>>>
>>> Le mercredi 07 juin 2023 à 16:48 +0800, Yunfei Dong a écrit :
>>>> 'mtk_vcodec_debug' and 'mtk_vcodec_err' depends on 'mtk_vcodec_ctx'
>>>> to get the index of each instance, using the index directly instead
>>>> of with 'mtk_vcodec_ctx'.
>>>>
>>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>>> ---
>>>>   .../mediatek/vcodec/mtk_vcodec_util.h         |  26 ++-
>>>>   .../vcodec/vdec/vdec_av1_req_lat_if.c         | 105 +++++++-----
>>>>   .../mediatek/vcodec/vdec/vdec_h264_if.c       |  62 ++++---
>>>>   .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  39 +++--
>>>>   .../vcodec/vdec/vdec_h264_req_multi_if.c      |  80 +++++----
>>>>   .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  67 ++++----
>>>>   .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  54 ++++---
>>>>   .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  46 +++---
>>>>   .../mediatek/vcodec/vdec/vdec_vp9_if.c        | 152 ++++++++++--
>>> ------
>>>>   .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  84 ++++++----
>>>>   .../platform/mediatek/vcodec/vdec_vpu_if.c    |  59 ++++---
>>>>   .../mediatek/vcodec/venc/venc_h264_if.c       |  86 +++++-----
>>>>   .../mediatek/vcodec/venc/venc_vp8_if.c        |  48 +++---
>>>>   .../platform/mediatek/vcodec/venc_vpu_if.c    |  64 ++++----
>>>>   14 files changed, 565 insertions(+), 407 deletions(-)
>>>>
>>>> diff --git
>>> a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>> b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>> index ecb0bdf3a4f4..ddc12c3e2983 100644
>>>> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
>>>> @@ -31,9 +31,8 @@ struct mtk_vcodec_dev;
>>>>   #define mtk_v4l2_err(fmt, args...)                \
>>>>   pr_err("[MTK_V4L2][ERROR] " fmt "\n", ##args)
>>>>   
>>>> -#define mtk_vcodec_err(h, fmt, args...)\
>>>> -pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n",\
>>>> -       ((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
>>>> +#define mtk_vcodec_err(plat_dev, inst_id, fmt,
>>> args...)                                 \
>>>> +dev_err(&(plat_dev)->dev, "[MTK_VCODEC][ERROR][%d]: " fmt "\n",
>>> inst_id, ##args)
>>>>   
>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>   extern int mtk_v4l2_dbg_level;
>>>> @@ -46,27 +45,24 @@ extern int mtk_vcodec_dbg;
>>>>    __func__, __LINE__, ##args);        \
>>>>   } while (0)
>>>>   
>>>> -#define mtk_vcodec_debug(h, fmt, args...)                      \
>>>> -do {                      \
>>>> -if (mtk_vcodec_dbg)                      \
>>>> -dev_dbg(&(((struct mtk_vcodec_ctx *)(h)->ctx)->dev->plat_dev-
>>>> dev),   \
>>>> -"[MTK_VCODEC][%d]: %s, %d " fmt "\n",                         \
>>>> -((struct mtk_vcodec_ctx *)(h)->ctx)->id,                      \
>>>> -__func__, __LINE__, ##args);                                  \
>>>> +#define mtk_vcodec_debug(plat_dev, inst_id, fmt,
>>> args...)                               \
>>>> +do
>>> {
>>>          \
>>>> +if
>>> (mtk_vcodec_dbg)
>>> \
>>>> +dev_dbg(&(plat_dev)->dev, "[MTK_VCODEC][%d]: %s, %d " fmt "\n", \
>>>
>>> At least in this patch, you systematically pass plat_dev as
>>> <something>->ctx->dev->plat_dev, which is quite long and verbose, any
>>> reason we
>>> can't just pass that <something> here ? We can follow the same
>>> structure path
>>> for both encoder/decoder ?
>>>
>>
>> In order to separate encode and decoder, need to define two different
>> struct mtk_vcodec_dec_ctx and struct mtk_vcodec_enc_ctx.
>>
>> struct mtk_vcodec_ctx won't be used again, need to use platform device
>> to print dev_dbg and dev_err.
>>
>> encoder and decoder using the same interface to print log message.
> 
> Just a reminder, I'm just making suggestions, there is no strict action required
> here other then a discussion to try and make the logging a bit more light.
> 
> My points was that C macros don't care about types, so if you keep the path to
> the platform device the same (ctx->dev->plat_dev), you could just pass the ctx
> as argument. What I don't know though myself, is if this is actually feasible in
> all code path, but considering you had access to the instance previously, I
> thought it should.
> 

One macro used to access two different structures?

Please, no.

Regards,
Angelo

> regards,
> Nicolas
> 
>>
>> Best Regards,
>> Yunfei Dong
>>>> +inst_id, __func__, __LINE__, ##args);                   \
>>>>   } while (0)
>>>>   #else
>>>>   #define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt, ##args)
>>>>   
>>>> -#define mtk_vcodec_debug(h, fmt, args...)\
>>>> -pr_debug("[MTK_VCODEC][%d]: " fmt "\n",\
>>>
>> ...snip...
> 

