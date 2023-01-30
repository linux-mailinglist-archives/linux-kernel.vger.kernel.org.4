Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF5680439
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjA3DNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA3DNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:13:20 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D55FD5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:13:19 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id k15-20020a4adfaf000000b00517450f9bd7so438294ook.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTu6F24MqMbAJlXYaKwd3yi8Qfnk8wpGkhBK8iYWWDQ=;
        b=jnt9DQSwQ/Ur8IJ9UrZwPrtybbNaC1r+KuxS4nvGYz7ojACw4Jh5DECkp6Fbpdl4cR
         fQIIURSL8Ieih2Ou80GtwdK1uqJG5ktVWS2tInYacHsYEtL6u5G589utkM/5rgKfupOo
         gIz7WkXR1PSU1n1D7UcoU2ygPpIiQNSTU8IPF8AFdveOmUWvvoq7FUxpWpITPS01s1X5
         a8ONNSISFfXaSGIdxGWRqkWYYjd5487REhepdry5ms6L/NogcXE2TnOivz5Ksite++vj
         ROhmByC9ZSQZwfPOmJl2j0/TrQIxJCYxDW3ZVN95Ifo2v77xR4/h3274JIgU5fvs5Q2V
         Lr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTu6F24MqMbAJlXYaKwd3yi8Qfnk8wpGkhBK8iYWWDQ=;
        b=OYo9wEjH64Pr4hlm2phcaZpJG0HQC+HdA6JLH9s0YS6vA39kq3UszXbaO7xrqo4/mg
         4rBt2SzGolSoXv3P2WMMHjcrkLVSIbqvhLvX9rEax4Zl0BN6ElT7BtuuHkFzvKTFgPBZ
         WEc1bPqsneUTU0Ja6QTey5iu0w6BNfaT88sCj3YLJ0B3uzQnQOjxtJXMVGlYDsempZGJ
         5vp4kqafLpeJ3ZjlnPIpMGq6uH7B/Enwjbfie3VW+qQuN+Hr5iopx0KMKmO6mR6H1zzN
         BAHnG2IJiWiXpqwY4XlhA04y27vAlnh7MPg5jLounYnLp4f+REdZ5FOEyrr7KUMwhX9H
         ibdA==
X-Gm-Message-State: AO0yUKU/k4kS2s2rySMKX5DDG3lYqi/XxdTv0AvQZJJ+7MubpdgCxC50
        KRpdZ/9OM7j1ean/hJtz4W4qEA==
X-Google-Smtp-Source: AK7set/CiwEkUdJjQvtgDYsbBuJvmT6nW80SlOcWcwweRlx8EJHuWUbXBGRLG9XBdLXzbn7/PEgGMA==
X-Received: by 2002:a4a:3791:0:b0:517:67ba:586 with SMTP id r139-20020a4a3791000000b0051767ba0586mr1605298oor.3.1675048398516;
        Sun, 29 Jan 2023 19:13:18 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.239])
        by smtp.gmail.com with ESMTPSA id j26-20020a4ad2da000000b00517425df590sm2524174oos.14.2023.01.29.19.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:13:17 -0800 (PST)
Date:   Mon, 30 Jan 2023 00:13:05 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v5 2/2] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <TL3APR.DGMI81ZTIDLJ1@vanguardiasur.com.ar>
In-Reply-To: <20230127092126.318268-3-benjamin.gaignard@collabora.com>
References: <20230127092126.318268-1-benjamin.gaignard@collabora.com>
        <20230127092126.318268-3-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jan 27 2023 at 10:21:26 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> When decoding a 10bits bitstreams HEVC driver should only expose
> 10bits pixel formats.
> To fulfill this requirement it is needed to call 
> hantro_reset_raw_fmt()
> when bit depth change and to correctly set match_depth in pixel 
> formats
> enumeration.
> 
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> version 5:
> - Add Review and Fixes tags
> 
>  .../media/platform/verisilicon/hantro_drv.c   | 44 
> +++++++++++++++----
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>  2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c 
> b/drivers/media/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..a736050fef5a 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, 
> struct vb2_queue *dst_vq)
> 
>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct hantro_ctx *ctx;
> -
> -	ctx = container_of(ctrl->handler,
> -			   struct hantro_ctx, ctrl_handler);
> -
>  	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>  		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
> 
> @@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 
> != 2)
>  			/* Only 8-bit and 10-bit are supported */
>  			return -EINVAL;
> -
> -		ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;

I think we need to make this change in a separate patch, so we can
clarify the reason using s_ctrl instead of try_ctrl.

Thanks!
Ezequiel

>  	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>  		const struct v4l2_ctrl_vp9_frame *dec_params = 
> ctrl->p_new.p_vp9_frame;
> 
> @@ -286,6 +279,36 @@ static int hantro_try_ctrl(struct v4l2_ctrl 
> *ctrl)
>  	return 0;
>  }
> 
> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx = container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_HEVC_SPS:
> +	{
> +		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
> +		int bit_depth = sps->bit_depth_luma_minus8 + 8;
> +		int ret;
> +
> +		if (ctx->bit_depth == bit_depth)
> +			return 0;
> +
> +		ret = hantro_reset_raw_fmt(ctx, bit_depth);
> +		if (!ret)
> +			ctx->bit_depth = bit_depth;
> +
> +		return ret;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct hantro_ctx *ctx;
> @@ -328,6 +351,11 @@ static const struct v4l2_ctrl_ops 
> hantro_ctrl_ops = {
>  	.try_ctrl = hantro_try_ctrl,
>  };
> 
> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
> +	.s_ctrl = hantro_hevc_s_ctrl,
> +	.try_ctrl = hantro_try_ctrl,
> +};
> +
>  static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
>  	.s_ctrl = hantro_jpeg_s_ctrl,
>  };
> @@ -470,7 +498,7 @@ static const struct hantro_ctrl controls[] = {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
>  			.id = V4L2_CID_STATELESS_HEVC_SPS,
> -			.ops = &hantro_ctrl_ops,
> +			.ops = &hantro_hevc_ctrl_ops,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c 
> b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index b390228fd3b4..f850d8bddef6 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -152,6 +152,7 @@ static const struct hantro_fmt 
> imx8m_vpu_g2_postproc_fmts[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_NV12,
>  		.codec_mode = HANTRO_MODE_NONE,
> +		.match_depth = true,
>  		.postprocessed = true,
>  		.frmsize = {
>  			.min_width = FMT_MIN_WIDTH,
> @@ -165,6 +166,7 @@ static const struct hantro_fmt 
> imx8m_vpu_g2_postproc_fmts[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_P010,
>  		.codec_mode = HANTRO_MODE_NONE,
> +		.match_depth = true,
>  		.postprocessed = true,
>  		.frmsize = {
>  			.min_width = FMT_MIN_WIDTH,
> --
> 2.34.1
> 


