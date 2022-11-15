Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112AB6297BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKOLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiKOLuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:50:14 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 03:50:13 PST
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B06DFF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:50:13 -0800 (PST)
X-KPN-MessageId: 03a5e7f5-64db-11ed-888a-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 03a5e7f5-64db-11ed-888a-005056992ed3;
        Tue, 15 Nov 2022 12:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=9HmQSNgbeAnuAmyJ//N8rl1O/DoZ4K7/mSpROb1E7nw=;
        b=GLaLkVCMvQlGJyTNqq6NAK+FYyoFKGLZqKVH+FDShyNmcfe6YYkS9SCbTjpp3oHP4wgObBiLg5Gui
         Gu0wKUQeFGJF2l4ZClJ4dHEG6zebb6Zrv14nZLmIWexvDhK0BurjnRqLtSX+kbjo7yRUS2iTVJXrEm
         csTXyHjeLjhOTrooqULTIo+psEqb8KFgWsualRR/Cngoo2rrR0nR0zilUsReXuiuagfNp5KR55BVlU
         FF8YBlU76sNqbFDdc3aUSEurFI01UvrRRXeS045Xbz+CQsgy16RR6sqYN5olXPFJbyMC7jpmdkd4yj
         jaYg2edVH84QPIQ8mySHHvoDaJM5+PQ==
X-KPN-MID: 33|rXukB6Fhm70IJI8my3JcBZxo1C9PC67ixhmJDZgGMsK4jKmNSrbBuYK7BxT/x50
 HQ9pHZI0HdqQqGLYrJweUeP01C+M5cywlmmo6Lc8GE5I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qFgCJVZLrOjSmXDsOsPFe36X9/J5Zvn6k8bgzvFgKeyRPVF+JMMX7ZI+fEfchp1
 kLO5r0eeC3yUJ3R0nZsuceQ==
X-Originating-IP: 173.38.220.59
Received: from [10.47.77.219] (unknown [173.38.220.59])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 83bee959-64db-11ed-ad2a-00505699772e;
        Tue, 15 Nov 2022 12:49:10 +0100 (CET)
Message-ID: <ac1f56bc-2d38-8d0c-83ea-f5e36eb15e25@xs4all.nl>
Date:   Tue, 15 Nov 2022 12:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
Content-Language: en-US
To:     =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "acourbot@chromium.org" <acourbot@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TG9uZ2ZlaSBXYW5nICjnjovpvpnpo54p?= 
        <Longfei.Wang@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220926093501.26466-1-irui.wang@mediatek.com>
 <a386f704b43b117d8857a7d7f51b1652ddb40663.camel@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <a386f704b43b117d8857a7d7f51b1652ddb40663.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

On 11/15/22 12:40, Irui Wang (王瑞) wrote:
> Dear Hans,
> 
> Gently ping for this patch.
> May I know this patch current status? It seems is under your reviewing
> state?

Mauro was on vacation last week, but he said that he hopes to merge
the pending PRs tomorrow. Fingers crossed...

Regards,

	Hans

> 
> Thanks
> Best Regards
> 
> On Mon, 2022-09-26 at 17:35 +0800, Irui Wang wrote:
>> The encoder driver support h264 baseline, main, high encoder
>> profile, set mask for V4L2_CID_MPEG_VIDEO_H264_PROFILE to skip
>> the unsupported profile.
>> 
>> get supported h264_profile by command: v4l2-ctl -d /dev/videoX -L
>> h264_profile 0x00990a6b (menu) : min=0 max=4 default=4 value=4
>>         0: Baseline
>>         2: Main
>>         4: High
>> 
>> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
>> ---
>>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> index d810a78dde51..d65800a3b89d 100644
>> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> @@ -1397,7 +1397,10 @@ int mtk_vcodec_enc_ctrls_setup(struct
>> mtk_vcodec_ctx *ctx)
>>  0, V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE);
>>  v4l2_ctrl_new_std_menu(handler, ops,
>> V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>>  V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
>> -0, V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
>> +~((1 << V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE)
>> |
>> +  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
>> +  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_HIGH)),
>> +V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
>>  v4l2_ctrl_new_std_menu(handler, ops,
>> V4L2_CID_MPEG_VIDEO_H264_LEVEL,
>>         h264_max_level,
>>         0, V4L2_MPEG_VIDEO_H264_LEVEL_4_0);
> 
> ************* MEDIATEK Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

