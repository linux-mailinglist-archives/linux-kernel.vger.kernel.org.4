Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08706803EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjA3Cz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjA3Cz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:55:56 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE831A95F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:55:53 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1631b928691so13441080fac.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=406ebqwrhhVJe5ezQ2JVn4C3uWECtQ/oeO07Gv31wp4=;
        b=VdvC6hscY6XOQ9dySJzjTwGbrRgd/u1vn6YH0i4gbC1/CmzoevN+65f+FEIOztlR08
         A6y/ppR3r+NJxVG8JmR+lb8IQ2DWuYhJxawXEHMsV2/8WTl3E4LWkgHADW8JGiu3DWYc
         U/WbjXfbHoHjEhQQpNnWDqpIwbDD2JibhRAXSZII/VYibYcQEVN7wokrtTZ3j46p/lIv
         Z41JI57DZFrJF1A0PlgZ7dl4cPStPPPLl2mNadmdCAhI41GX8eZebnpBj+ekBwQd2pTN
         oeFxgYve0Fgbdg9dzekKPeMOkQ/GjF35QueCB85aeZlkGWQYfgiLEMjuQNF4ok3Ta/OG
         ecZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=406ebqwrhhVJe5ezQ2JVn4C3uWECtQ/oeO07Gv31wp4=;
        b=LR0jG8Ofr9Pi87b2XGhbvGrooeHh1nZgbSnloBTQbkYA/jF0KjZpJ6Ksk7ArhFIPBx
         kJha+FGTXrrExMePLQiu1SANZubvJA+/JwZTOiQwqaLEdZcCpRFyV1I11bCVXjAllUs6
         VHrIaXiE+08GoCKCgKbmryNJ9c28Rs/+xE5WZxwpbZb1TpIiazenLxMg0EB6pcYgezZf
         1By4rDkpVaTK82owR1OlAux7Dzel73qcfW3DHmONezuYR/6Fwss/EGtCVlJhsekXSOwm
         OddEIRBvjHeWixHiWzjnGClpCXx0Rgplbz/4Y9635VYJK23HMhzI3Z9tWGj0e+MuWcRQ
         ipvw==
X-Gm-Message-State: AFqh2kr7U1Ut87/5bCQATCdGce+rCAuSLaanoKnDSWu8oVqzuOjNRTSe
        ZxF7nAc6akivQ5tWKV6EptEQqg==
X-Google-Smtp-Source: AMrXdXvsQBWIIN3KpCbiAcZAW1eUvU1z6WfL836yvDVS9zfHgijYii+uLEfBzVmchrL+VizHGEgY/Q==
X-Received: by 2002:a05:6871:4489:b0:13c:e933:2898 with SMTP id ne9-20020a056871448900b0013ce9332898mr23495791oab.49.1675047352273;
        Sun, 29 Jan 2023 18:55:52 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.239])
        by smtp.gmail.com with ESMTPSA id gn12-20020a056870d98c00b0013ae39d0575sm4642419oab.15.2023.01.29.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:55:50 -0800 (PST)
Date:   Sun, 29 Jan 2023 23:55:38 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v5 1/2] media: verisilicon: Do not change context bit
 depth before validating the format
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <QS2APR.JW5ZAKWFKLP63@vanguardiasur.com.ar>
In-Reply-To: <20230127092126.318268-2-benjamin.gaignard@collabora.com>
References: <20230127092126.318268-1-benjamin.gaignard@collabora.com>
        <20230127092126.318268-2-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks for taking care of this.

On Fri, Jan 27 2023 at 10:21:25 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> It is needed to check if the proposed pixels format is valid before
> updating context bit depth and other internal states.
> Stop using ctx->bit_depth to check format depth match and return
> result to the caller.
> 
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> version 5:
> - Add Review and Fixes tags
>  .../platform/verisilicon/hantro_postproc.c    |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  | 53 
> +++++++++----------
>  .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
>  3 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c 
> b/drivers/media/platform/verisilicon/hantro_postproc.c
> index 09d8cf942689..6437423ccf3a 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -197,7 +197,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	unsigned int i, buf_size;
> 
>  	/* this should always pick native format */
> -	fmt = hantro_get_default_fmt(ctx, false);
> +	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
>  	if (!fmt)
>  		return -EINVAL;
>  	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c 
> b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..2475bc05dee9 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -76,17 +76,16 @@ int hantro_get_format_depth(u32 fourcc)
>  }
> 
>  static bool
> -hantro_check_depth_match(const struct hantro_ctx *ctx,
> -			 const struct hantro_fmt *fmt)
> +hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
>  {
> -	int fmt_depth, ctx_depth = 8;
> +	int fmt_depth, depth = 8;
> 
>  	if (!fmt->match_depth && !fmt->postprocessed)
>  		return true;
> 
>  	/* 0 means default depth, which is 8 */
> -	if (ctx->bit_depth)
> -		ctx_depth = ctx->bit_depth;
> +	if (bit_depth)
> +		depth = bit_depth;
> 
>  	fmt_depth = hantro_get_format_depth(fmt->fourcc);
> 
> @@ -95,9 +94,9 @@ hantro_check_depth_match(const struct hantro_ctx 
> *ctx,
>  	 * It may be possible to relax that on some HW.
>  	 */
>  	if (!fmt->match_depth)
> -		return fmt_depth <= ctx_depth;
> +		return fmt_depth <= depth;
> 
> -	return fmt_depth == ctx_depth;
> +	return fmt_depth == depth;
>  }
> 
>  static const struct hantro_fmt *
> @@ -119,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, 
> u32 fourcc)
>  }
> 
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, 
> int bit_depth)
>  {
>  	const struct hantro_fmt *formats;
>  	unsigned int i, num_fmts;
> @@ -128,7 +127,7 @@ hantro_get_default_fmt(const struct hantro_ctx 
> *ctx, bool bitstream)
>  	for (i = 0; i < num_fmts; i++) {
>  		if (bitstream == (formats[i].codec_mode !=
>  				  HANTRO_MODE_NONE) &&
> -		    hantro_check_depth_match(ctx, &formats[i]))
> +		    hantro_check_depth_match(&formats[i], bit_depth))
>  			return &formats[i];
>  	}
>  	return NULL;
> @@ -203,7 +202,7 @@ static int vidioc_enum_fmt(struct file *file, 
> void *priv,
> 
>  		if (skip_mode_none == mode_none)
>  			continue;
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j == f->index) {
>  			f->pixelformat = fmt->fourcc;
> @@ -223,7 +222,7 @@ static int vidioc_enum_fmt(struct file *file, 
> void *priv,
>  	for (i = 0; i < num_fmts; i++) {
>  		fmt = &formats[i];
> 
> -		if (!hantro_check_depth_match(ctx, fmt))
> +		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
>  			continue;
>  		if (j == f->index) {
>  			f->pixelformat = fmt->fourcc;
> @@ -291,7 +290,7 @@ static int hantro_try_fmt(const struct hantro_ctx 
> *ctx,
> 
>  	fmt = hantro_find_format(ctx, pix_mp->pixelformat);
>  	if (!fmt) {
> -		fmt = hantro_get_default_fmt(ctx, coded);
> +		fmt = hantro_get_default_fmt(ctx, coded, 0);
>  		pix_mp->pixelformat = fmt->fourcc;
>  	}
> 
> @@ -379,15 +378,12 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  	const struct hantro_fmt *vpu_fmt;
>  	struct v4l2_pix_format_mplane *fmt;
> 
> -	vpu_fmt = hantro_get_default_fmt(ctx, true);
> +	vpu_fmt = hantro_get_default_fmt(ctx, true, 0);
> 
> -	if (ctx->is_encoder) {
> -		ctx->vpu_dst_fmt = vpu_fmt;
> +	if (ctx->is_encoder)
>  		fmt = &ctx->dst_fmt;
> -	} else {
> -		ctx->vpu_src_fmt = vpu_fmt;
> +	else
>  		fmt = &ctx->src_fmt;
> -	}
> 
>  	hantro_reset_fmt(fmt, vpu_fmt);
>  	fmt->width = vpu_fmt->frmsize.min_width;
> @@ -398,20 +394,21 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  		hantro_set_fmt_out(ctx, fmt);
>  }
> 
> -static void
> -hantro_reset_raw_fmt(struct hantro_ctx *ctx)
> +int
> +hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)

Seems the hantro_reset_raw_fmt and hantro_reset_encoded_fmt still need
some work.

>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
>  	struct v4l2_pix_format_mplane *raw_fmt, *encoded_fmt;
> 
> -	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
> +	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth);
> +
> +	if (!raw_vpu_fmt)
> +		return -EINVAL;
> 
>  	if (ctx->is_encoder) {
> -		ctx->vpu_src_fmt = raw_vpu_fmt;

Removing these unneeded ctx->vpu_src/dst_fmt assignments in 
hantro_reset_{}
is correct. The ctx->vpu_src/dst_fmt assignment needs to be done
only in hantro_set_fmt_out/cap.

Please split this change to a separate patch.

>  		raw_fmt = &ctx->src_fmt;
>  		encoded_fmt = &ctx->dst_fmt;
>  	} else {
> -		ctx->vpu_dst_fmt = raw_vpu_fmt;
>  		raw_fmt = &ctx->dst_fmt;

Now here's the evil: raw_fmt = &ctx->dst_fmt means
that raw_fmt is actually the current context dst_fmt.

But see below:

>  		encoded_fmt = &ctx->src_fmt;
>  	}
> @@ -420,15 +417,15 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  	raw_fmt->width = encoded_fmt->width;
>  	raw_fmt->height = encoded_fmt->height;
>  	if (ctx->is_encoder)
> -		hantro_set_fmt_out(ctx, raw_fmt);
> +		return hantro_set_fmt_out(ctx, raw_fmt);
>  	else
> -		hantro_set_fmt_cap(ctx, raw_fmt);
> +		return hantro_set_fmt_cap(ctx, raw_fmt);

raw_fmt (&ctx->dst_fmt) is passed to hantro_set_fmt_cap.

static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
                  struct v4l2_pix_format_mplane *pix_mp)
{
...
    ctx->dst_fmt = *pix_mp;

In other words:

ctx->dst_fmt = *(&ctx->dst_fmt) !!!

I'm thinking we could introduce another patch (after removing 
ctx->vpu_src/dst_fmt)
but before "media: verisilicon: Do not change context bit depth"), to 
fix the confusion
and have something like:

static void
hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
{
    const struct hantro_fmt *vpu_fmt;
    struct v4l2_pix_format_mplane fmt;

    vpu_fmt = hantro_get_default_fmt(ctx, true);

    hantro_reset_fmt(&fmt, vpu_fmt);
    fmt.width = vpu_fmt->frmsize.min_width;
    fmt.height = vpu_fmt->frmsize.min_height;
    if (ctx->is_encoder)
        hantro_set_fmt_cap(ctx, &fmt);
    else
        hantro_set_fmt_out(ctx, &fmt);
}

So it's clear the ctx format is actually reset to a new format
in each case; and it's similar to how hantro_set_fmt_cap/out are used 
by S_FMT.

Does it make any sense?

Thanks,
Ezequiel

>  }
> 
>  void hantro_reset_fmts(struct hantro_ctx *ctx)
>  {
>  	hantro_reset_encoded_fmt(ctx);
> -	hantro_reset_raw_fmt(ctx);
> +	hantro_reset_raw_fmt(ctx, 0);
>  }
> 
>  static void
> @@ -528,7 +525,7 @@ static int hantro_set_fmt_out(struct hantro_ctx 
> *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (!ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, 
> hantro_get_format_depth(pix_mp->pixelformat));
> 
>  	/* Colorimetry information are always propagated. */
>  	ctx->dst_fmt.colorspace = pix_mp->colorspace;
> @@ -591,7 +588,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx 
> *ctx,
>  	 * changes to the raw format.
>  	 */
>  	if (ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, 0);
> 
>  	/* Colorimetry information are always propagated. */
>  	ctx->src_fmt.colorspace = pix_mp->colorspace;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h 
> b/drivers/media/platform/verisilicon/hantro_v4l2.h
> index 64f6f57e9d7a..9ea2fef57dcd 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,9 +21,10 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
> 
> +int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
> -hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, 
> int bit_depth);
> 
>  #endif /* HANTRO_V4L2_H_ */
> --
> 2.34.1
> 


