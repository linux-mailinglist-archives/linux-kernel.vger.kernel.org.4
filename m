Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EC69FD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBVVMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:12:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69045149B8;
        Wed, 22 Feb 2023 13:12:02 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9723366021D8;
        Wed, 22 Feb 2023 21:11:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677100321;
        bh=XbP0sDtxNAm8IjAuyCN+WUe9AnaCJFk0QivDms/MLjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1TrERe84hp5Xh4cdSkuPi9RArEPR4vwFIsdCEi4eoh3RC74Qm/9Y9Q0rrx6he6MF
         2iPbBOgXAoxANRrkIVPITIcY5WvvOcrf+iNUeSGe2aw838v42JwuLRj/F2eG/pX7XW
         KHWswBtuV/cZcbdJyt4Iml8w9WmqrbsHF/GGT+WAxL0OxZwQdJwy8C2K3DICs3uc5U
         yyBu3o4Kk2ubBrSJ2d3uWzi7oD1gAzcnmPSnGNmFtVzoPxoQa3gwr5aJGGPq90SyyP
         +uJw3vWsqq31TIpE1nIZ2S0nf5yXuyOk6C4P5wQyDI+LH4totlwaGhiEHd/Bid9Tvs
         YxIOnCzJnUE3g==
Date:   Wed, 22 Feb 2023 16:11:54 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong =?utf-8?B?KOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
Cc:     "wenst@chromium.org" <wenst@chromium.org>,
        Tiffany Lin =?utf-8?B?KOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Force capture queue format
 to MM21
Message-ID: <20230222211154.mhl7mihycl7eq5v6@notapiano>
References: <20230210055518.6017-1-yunfei.dong@mediatek.com>
 <e972c2ac1a7a6f0ce258c8056b82bdc87e4d8ceb.camel@ndufresne.ca>
 <f6148f4c4864d324b52a52cc87b8785d958ceeb5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6148f4c4864d324b52a52cc87b8785d958ceeb5.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 14, 2023 at 02:28:04AM +0000, Yunfei Dong (董云飞) wrote:
> Hi Nicolas,
> 
> Thanks for your suggestion.
> On Fri, 2023-02-10 at 10:36 -0500, Nicolas Dufresne wrote:
> > Le vendredi 10 février 2023 à 13:55 +0800, Yunfei Dong a écrit :
> > > In order to conver the format of capture queue from mediatek MM21
> > > to
> > > standard yuv420 with Libyuv, need to force capture queue format to
> > > MM21 for Libyuv can't covert mediatek MT21 format at current
> > > period.
> > 
> > Please rework this text, it is hard to understand.
> > 
> 
> Will re-write the commit message in next version as below, could you
> please help to review whether it's well to be used ?
> 
> Libyuv is one software library used to covert format. Only covert
> mediatek MM21 to standard yuv420 for MT21 is compressed mode and MM21
> is uncompressed mode at current period. Need to set capture queue
> format to MM21 in order to use Libyuv.
> 
> > > 
> > > Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec
> > > using different capture format")
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.org>
> > > ---
> > > changed with v1:
> > > - add Fixes tag.
> > > ---
> > >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > index 641f533c417f..4f5e9c20214f 100644
> > > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > > @@ -41,7 +41,7 @@ static bool mtk_vdec_get_cap_fmt(struct
> > > mtk_vcodec_ctx *ctx, int format_index)
> > >  	const struct mtk_video_fmt *fmt;
> > >  	struct mtk_q_data *q_data;
> > >  	int num_frame_count = 0, i;
> > > -	bool ret = true;
> > > +	bool ret = false;

This change doesn't do anything, so I'd drop it.

> > >  
> > >  	for (i = 0; i < *dec_pdata->num_formats; i++) {
> > >  		if (dec_pdata->vdec_formats[i].type != MTK_FMT_FRAME)
> > > @@ -63,7 +63,7 @@ static bool mtk_vdec_get_cap_fmt(struct
> > > mtk_vcodec_ctx *ctx, int format_index)
> > >  	case V4L2_PIX_FMT_H264_SLICE:
> > >  	case V4L2_PIX_FMT_VP9_FRAME:
> > >  		if (fmt->fourcc == V4L2_PIX_FMT_MM21)
> > > -			ret = false;
> > > +			ret = true;
> > 
> > This makes the VP8 and the other cases identical, leaving anything
> > that touches
> > MT21 as dead code. I'm not sure, cause I cannot test it, but it
> > should in theory
> > render MT8192 unusable, unless a new firmware has been submitted to
> > linux-
> > firmware with MM21 support ?
> > 
> 
> If the firmware only support MT21 => won't exist for vp8 need to use
> MM21.

And that's the issue, the scp.img for MT8192 on linux-firmware only supports
MT21 [1]. Can you please update it to support both MM21 and MT21?

For MT8195, only MM21 is supported in scp.img [2], but since the hardware
supports both MM21 and MT21, the firmware should also support both. So please
also update it on linux-firmware.

[1] https://lore.kernel.org/all/20230112204626.ciaff4amseoidybw@notapiano/
[2] https://lore.kernel.org/all/20230112205825.wb5qcqhh5kwvyi3y@notapiano/

Thanks,
Nícolas

> 
> If the firmware only support MM21, will using MM21.
> If the firmware support MT21 & MM21, will force VP8 to use MM21,
> H264/VP9/AV1 will use MT21 before this change. 
> 
> Will force all driver to use MM21 after adding this change. 
> 
> Best Regards,
> Yunfei Dong
> > >  		break;
> > >  	default:
> > >  		ret = true;
> > 
> > 
