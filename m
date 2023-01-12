Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F496678E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjALPS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjALPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:18:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E23C3AE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:10:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so28888918lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nxfZ2qN8MzXsqeAe0vT9OR0MbsMemwdZIPX0mBB8DSs=;
        b=aP2ZK3l2HbkQFQr3BjiHH89amPOjBFazr7tsjyfmVPnp3EuwcI1w5dKg35poT2/j2e
         5KGHWSAkboMaRD0K9HCa1KOyfi9aLceGPVdrU69sQIg94vBGGxd0f0mgsm0SGnTuAEit
         G+nhnG2TU75OEQ05lhzLL63EnNc7gzv6aPSWQ2AOKUjoRsR9lv5ut0yUr8pHRpU4F7n1
         13uUrblhJhz4Z/QKboemQNQOQfHWddsk62QSC4vk+iF2QArK152Df639fRa4F7+d3rM5
         MoLs6SiBr27jbLWZVJq7X07m5nuGWYTaccUa9IgZ81TuWO/d75R0uMFd7DxxUFi5fSGn
         TpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxfZ2qN8MzXsqeAe0vT9OR0MbsMemwdZIPX0mBB8DSs=;
        b=xO7iTE2GTyCvb7aem82t5utr+EdyFh1JkTbY2bpyKX2Ga/l37BBkYSk2db3L2jXTPi
         34koyJyXxApZGk458Gl8JpR136b/A91Zn9ksbHb6UyzuqQ5WrCQH2izV1CxgaUVq+grL
         dVt8oJh7IH7Im27ggzyXCtzRewV8kvENX7nGGo4YkzOy77uIeVrRFMiBQRxP34B+IJLF
         0txLNlmq22RT9e4uH7HYxsLmQym/ohCTupy6BzDOIFqGlyXJejcPlKoIFfSOQiGRujQO
         /5g1OHClxXv1KeqsfVDID/BoyFV6i7d5XkpzkM7vK7w5TN3qwtDo/0nY4xKHyYUKm7pc
         g3cA==
X-Gm-Message-State: AFqh2kqTlm4raK1aW7kPB11PnnwuOqpxIYODICHYgqxhKaPkMnuEQrCh
        Eh+HxDYl15xnXIPIM+oRutMuygTnxt5ltXBCi9y9cQ==
X-Google-Smtp-Source: AMrXdXsxoC5K+Ve6ec7xC0jIZ2GvpTnrNpHpf02BPZZMLipCmdniLgyDnNJuHW4vvexbORlcNwMZsmOUegUt7iyDcaE=
X-Received: by 2002:ac2:5632:0:b0:4cb:33b:6264 with SMTP id
 b18-20020ac25632000000b004cb033b6264mr6975049lff.161.1673536206178; Thu, 12
 Jan 2023 07:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com> <20230101-patch-series-v2-6-2-rc1-v2-11-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-11-fa1897efac14@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 12 Jan 2023 12:09:54 -0300
Message-ID: <CAAEAJfDm3FBUkacR+tRVYnEbO8g43RT_L89WQuZjRi-Kwn7CYA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] staging: media: rkvdec: Enable S_CTRL IOCTL
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Jan 12, 2023 at 9:57 AM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
>
> Enable user-space to set the SPS of the current byte-stream on the
> decoder. This action will enable the decoder to pick the optimal
> pixel-format for the capture queue, whenever it is required.
>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 81 +++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index b303c6e0286d..3d413c5ad1d2 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -93,6 +93,79 @@ static int rkvdec_get_sps_attributes(struct rkvdec_ctx *ctx, void *sps,
>         return 0;
>  }
>
> +static int rkvdec_set_sps(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp;
> +       struct sps_attributes attributes = {0};
> +       void *new_sps = NULL;
> +
> +       /*
> +        * SPS structures are not filled until the control handler is set up
> +        */
> +       if (!ctx->fh.ctrl_handler)
> +               return 0;

The control handler is embedded in the context, and the fh.ctrl_handler
is initialized when the context is returned.

You cannot have a context without a control handler (see hantro_open).

> +
> +       switch (ctrl->id) {
> +       case V4L2_CID_STATELESS_H264_SPS:
> +               new_sps = (void *)ctrl->p_new.p_h264_sps;
> +               break;
> +       case V4L2_CID_STATELESS_HEVC_SPS:
> +               new_sps = (void *)ctrl->p_new.p_hevc_sps;
> +               break;
> +       default:
> +               dev_err(ctx->dev->dev, "Unsupported stateless control ID: %x\n", ctrl->id);
> +               return -EINVAL;
> +       };
> +       rkvdec_get_sps_attributes(ctx, new_sps, &attributes);
> +
> +       /*
> +        * Providing an empty SPS is valid but we do not store it.
> +        */
> +       if (attributes.width == 0 && attributes.height == 0)
> +               return 0;
> +
> +       pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
> +
> +       /*
> +        * SPS must match the provided format dimension, if it doesn't userspace has to
> +        * first reset the output format

This comment says it's a mismatch check, but the check is checking for
"larger than".

Other than that, the general idea looks good, can you rework the series to avoid
the extra storage of the SPS control in the context?

Thanks,
Ezequiel

> +        */
> +       if ((attributes.width > pix_mp->width) || (attributes.height > pix_mp->height)) {
> +               dev_err(ctx->dev->dev,
> +                       "Dimension mismatch. [%s SPS] W: %d, H: %d, [Format] W: %d, H: %d)\n",
> +                       ctrl->id == V4L2_CID_STATELESS_HEVC_SPS ? "HEVC" : "H264",
> +                       attributes.width, attributes.height, pix_mp->width, pix_mp->height);
> +               return -EINVAL;
> +       }
> +
> +       if (ctx->sps && pix_mp->pixelformat == rkvdec_get_valid_fmt(ctx)) {
> +               /*
> +                * Userspace is allowed to change the SPS at any point, if the
> +                * pixel format doesn't differ from the format in the context,
> +                * just accept the change even if buffers are queued
> +                */
> +               ctx->sps = new_sps;
> +       } else {
> +               /*
> +                * Do not accept changing the SPS, while buffers are queued,
> +                * when the new SPS would cause switching the CAPTURE pixel format
> +                */
> +               if (pix_mp->pixelformat != rkvdec_get_valid_fmt(ctx)) {
> +                       if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE))
> +                               return -EBUSY;
> +               }
> +               ctx->sps = new_sps;
> +               /*
> +                * For the initial SPS setting and when the pixel format is
> +                * changed adjust the pixel format stored in the context
> +                */
> +               pix_mp->pixelformat = rkvdec_get_valid_fmt(ctx);
> +               rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
> +       }
> +
> +       return 0;
> +}
> +
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> @@ -104,8 +177,16 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +       struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> +
> +       return rkvdec_set_sps(ctx, ctrl);
> +}
> +
>  static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
>         .try_ctrl = rkvdec_try_ctrl,
> +       .s_ctrl = rkvdec_s_ctrl,
>  };
>
>  static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
>
> --
> 2.25.1
