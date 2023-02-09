Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C196902A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBII5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBII51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:57:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77B10268;
        Thu,  9 Feb 2023 00:57:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u21so1536957edv.3;
        Thu, 09 Feb 2023 00:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR+Zuj41V9OcnwxkujW0Dat+YRKGS6lOdavnOivT+n8=;
        b=OG0UMkcht3W1uLChw55NX4r8OMofbgx3cnsiQ9qFDhnznOtXOgYAH7jY69/bGtHfjB
         6hwGxQZZT2nFtWkhvV2cB806ESghC4undw+8MrUf/fHS+rjh41BIp6zpTdt4ypJHmlVx
         SysPdxIq/aHC+yv57qonEF7B690N/6Wg88l99mqtC+zkdgDqAPeRoLR/ZZNdm0O9fPC1
         6Vhz3l6eKj6vymTF4azg4Ljd7MKn4rY30H7KLfabCnt1fvD+qo2gs7UVvEFlYm9n41mZ
         D9rn5+pxxe8GfVjzsk7YC9FN+pMhzPWmtL4O/fJ+MBYggKLFTdy2a9Em31MJVLDsO6Us
         yuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR+Zuj41V9OcnwxkujW0Dat+YRKGS6lOdavnOivT+n8=;
        b=iaBcDV7RQdLKSoDxX+pBQDj9nLJy+9b1Juc5c1Mk51YGnOtdXP/1Y0ROqV4bRo0WuI
         L2IHLorbpTxLeb5Sng5n9ys0VT6SFgu+a7dPWxPsY9IYurAqm8oC+Ag762UInJSIVqdc
         slhjmhkN3bl7FrASFzREeJWQSUCGIBZ5n5A8M0HC6oh1MP38ojweydOhZEnESihafAQw
         V1BHgQSWpDHB36K6swuhuOlXEUFmULsClFEKw71E1gpz57K2gx4lMaMxQ45BMMR7Jo5e
         ljsQtGwBTPHCGvxNnhXMp24nh0lHBwm+/R4+OrhvUXlQFVb+eYa39OemFvRS4a/Whgap
         lenA==
X-Gm-Message-State: AO0yUKWcgESMdMX/iQfC4sWOzM/s8tqPpcFhmWXmPxp2MTqKrC+PJjhg
        bW9sLZVG/cNpOt6UCV0HLXM=
X-Google-Smtp-Source: AK7set/ljAZnzz7RXHpqE+yV4xbCb6FV0Lp47/Gn9bYBkkX3OE9cAh0INkNdrI29LcQwlKoVOWyrjQ==
X-Received: by 2002:a50:955b:0:b0:4aa:9ac7:403d with SMTP id v27-20020a50955b000000b004aa9ac7403dmr11306719eda.1.1675933043302;
        Thu, 09 Feb 2023 00:57:23 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-57-202.cust.vodafonedsl.it. [188.217.57.202])
        by smtp.gmail.com with ESMTPSA id u1-20020a50c2c1000000b004a21263bbaasm455224edf.49.2023.02.09.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:57:22 -0800 (PST)
Date:   Thu, 9 Feb 2023 09:57:20 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] media: mediatek: vcodec: Force capture queue format to
 MM21
Message-ID: <Y+S1cA4PXT1MVJm8@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230209074025.1816-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209074025.1816-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei Dong,

On Thu, Feb 09, 2023 at 03:40:25PM +0800, Yunfei Dong wrote:
> In order to conver the format of capture queue from mediatek MM21 to
> standard yuv420 with Libyuv, need to force capture queue format to
> MM21 for Libyuv can't covert mediatek MT21 format.

Sorry, just some clarifications on my side, just to understand :)
The problem is that libyuv can't convert mm21 format into yuv420
than you need to use mm21 (forcing this).
Did I understand correctly?

Thanks in advance,
Tommaso

> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.org>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 641f533c417f..4f5e9c20214f 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -41,7 +41,7 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
>  	const struct mtk_video_fmt *fmt;
>  	struct mtk_q_data *q_data;
>  	int num_frame_count = 0, i;
> -	bool ret = true;
> +	bool ret = false;
>  
>  	for (i = 0; i < *dec_pdata->num_formats; i++) {
>  		if (dec_pdata->vdec_formats[i].type != MTK_FMT_FRAME)
> @@ -63,7 +63,7 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
>  	case V4L2_PIX_FMT_H264_SLICE:
>  	case V4L2_PIX_FMT_VP9_FRAME:
>  		if (fmt->fourcc == V4L2_PIX_FMT_MM21)
> -			ret = false;
> +			ret = true;
>  		break;
>  	default:
>  		ret = true;
> -- 
> 2.18.0
> 
