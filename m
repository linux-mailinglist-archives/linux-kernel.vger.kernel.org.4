Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3D6699E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbjAMOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242112AbjAMOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:14:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9576DBB2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:13:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bu8so33282631lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLMxgYnqS/4/TB7UwvI/vIGP7m316E2G7fHeJE1jpg8=;
        b=AgTJXz4WlI46LfMJr07WPO9BhmaVxpE2iOif1zm+Oqp2iZVRniRVH567A90yVL5zdT
         q1XZFC3xt7nD6cJNMVIvsOZecK0s9anCwlI3UWXh2ZdrPj0tZocJmc/VU9ZcuJg6dyTK
         APxb7T3i87E3Xsmq+DLDOIjYhftZV8wQrUz9GGXYm1vlT2HYb8Q8EXQCe5dVC28w94XB
         5f7UeCZX30k7tILF7DrEO0D4HJzPbpfVs418KVMVGS9QCsqtum44qhS7GAzZ0+irSILU
         ipDxlxLSFw7DLoQehGVG7EYWuzAgSdyGCk1kY45FvWcJvcItZFLeF+D4HXs+ejyIVgO+
         HwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLMxgYnqS/4/TB7UwvI/vIGP7m316E2G7fHeJE1jpg8=;
        b=fzVsZZNIxTVDwHvKq3jCqLw7CjLFNr3VD0TpPm06mxT5OxuFBWUVUFt9/tgpFqfnqX
         E2CBSez0g/C+uA1ayMct03hJe+cWNHsN+7bfN7c7WLH7lq//iVixH1KTYEV5X/+cnIWy
         ZvZtLwa+UT85SdNytnXVL3vJAnorv+UW4H+1gj6q4eQk/X9iWVJrXjaA4IxGxjVbX5TR
         9xokmvy4lGYeGG59NXo//I7fTphOngbQgjmmU8A4qNPXOV754n2T+DAsgN82yPWlH7eL
         fYYa8t5iWjdFtsYqubxKJR4wHFRc19hBp1SAmxV53SKhgKO0ccxJtQq2jeOVAMhJYZ0r
         5sTg==
X-Gm-Message-State: AFqh2kofazAEZg7VNs/5xuqrAbQL8d/x44Co1CWCgRmx0AbVp75E+Zs0
        htjCQAlXC/FzxTNFjxOAFq0traCksOSIFKnlTgGqvw==
X-Google-Smtp-Source: AMrXdXutSMAOZy9HzarrHShlHiOo8HAv9jYGW08xHIKS5auBxnj5lfCkvop1Nhs4GtEDmbJ2Th7fITLFBqZcAAXkUY0=
X-Received: by 2002:a05:6512:708:b0:4ca:fab6:91db with SMTP id
 b8-20020a056512070800b004cafab691dbmr3403772lfs.202.1673619186692; Fri, 13
 Jan 2023 06:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20230113131257.661079-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20230113131257.661079-1-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 13 Jan 2023 11:12:53 -0300
Message-ID: <CAAEAJfAnoe+rL=9yFV1crhoaFa9uWaaJq3nCeS+QZPLi_xnsOw@mail.gmail.com>
Subject: Re: [PATCH v2] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, Jan 13, 2023 at 10:13 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> When decoding a 10bits bitstreams HEVC driver should only expose
> 10bits pixel formats.
> To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
> when bit depth change and to correctly set match_depth in pixel formats
> enumeration.
>
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
> - Also remove struct hantro_ctx *ctx variable in hantro_try_ctrl()
>
>  .../media/platform/verisilicon/hantro_drv.c   | 40 +++++++++++++++----
>  .../media/platform/verisilicon/hantro_v4l2.c  |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.h  |  1 +
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>  4 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..e824e87618db 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>
>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -       struct hantro_ctx *ctx;
> -
> -       ctx = container_of(ctrl->handler,
> -                          struct hantro_ctx, ctrl_handler);
> -

This change is unrelated to this commit.

>         if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>                 const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>
> @@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>                 if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
>                         /* Only 8-bit and 10-bit are supported */
>                         return -EINVAL;
> -
> -               ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;
>         } else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>                 const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
>
> @@ -286,6 +279,32 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +       struct hantro_ctx *ctx;
> +
> +       ctx = container_of(ctrl->handler,
> +                          struct hantro_ctx, ctrl_handler);
> +
> +       vpu_debug(1, "s_ctrl: id = %d, val = %d\n", ctrl->id, ctrl->val);
> +
> +       switch (ctrl->id) {
> +       case V4L2_CID_STATELESS_HEVC_SPS:
> +               const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
> +               int bit_depth = sps->bit_depth_luma_minus8 + 8;
> +
> +               if (ctx->bit_depth != bit_depth) {
> +                       ctx->bit_depth = bit_depth;
> +                       hantro_reset_raw_fmt(ctx);

We need to propagate the EBUSY error from hantro_set_fmt_cap,
to hantro_reset_raw_fmt, so this operation can fail if the capture
queue has buffers allocated.

Keep in mind, we have to make sure the hantro_ctx state
remains unchanged when the operation fails.

The entire hantro_v4l2.c format negotiation is done without this
case in mind (controls can change the format enumeration),
so this new case needs some refactoring.

I also think we need v4l2-compliance tests for it.

Thanks!
Ezequiel


> +               }
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct hantro_ctx *ctx;
> @@ -328,6 +347,11 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>         .try_ctrl = hantro_try_ctrl,
>  };
>
> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
> +       .s_ctrl = hantro_hevc_s_ctrl,
> +       .try_ctrl = hantro_try_ctrl,
> +};
> +
>  static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
>         .s_ctrl = hantro_jpeg_s_ctrl,
>  };
> @@ -470,7 +494,7 @@ static const struct hantro_ctrl controls[] = {
>                 .codec = HANTRO_HEVC_DECODER,
>                 .cfg = {
>                         .id = V4L2_CID_STATELESS_HEVC_SPS,
> -                       .ops = &hantro_ctrl_ops,
> +                       .ops = &hantro_hevc_ctrl_ops,
>                 },
>         }, {
>                 .codec = HANTRO_HEVC_DECODER,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..0025e049dd26 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -398,7 +398,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>                 hantro_set_fmt_out(ctx, fmt);
>  }
>
> -static void
> +void
>  hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  {
>         const struct hantro_fmt *raw_vpu_fmt;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/media/platform/verisilicon/hantro_v4l2.h
> index 64f6f57e9d7a..f642560aed93 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
> @@ -21,6 +21,7 @@
>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
>
> +void hantro_reset_raw_fmt(struct hantro_ctx *ctx);
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
>  const struct hantro_fmt *
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index b390228fd3b4..f850d8bddef6 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -152,6 +152,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
>         {
>                 .fourcc = V4L2_PIX_FMT_NV12,
>                 .codec_mode = HANTRO_MODE_NONE,
> +               .match_depth = true,
>                 .postprocessed = true,
>                 .frmsize = {
>                         .min_width = FMT_MIN_WIDTH,
> @@ -165,6 +166,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
>         {
>                 .fourcc = V4L2_PIX_FMT_P010,
>                 .codec_mode = HANTRO_MODE_NONE,
> +               .match_depth = true,
>                 .postprocessed = true,
>                 .frmsize = {
>                         .min_width = FMT_MIN_WIDTH,
> --
> 2.34.1
>
