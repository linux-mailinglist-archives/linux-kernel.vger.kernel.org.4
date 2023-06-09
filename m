Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6C729CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbjFIOWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbjFIOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:21:58 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E53598
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:21:56 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43c1e5978e4so566771137.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1686320515; x=1688912515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYw72ONYPV2xVcy+vVwHAaNMN0MkSZEs9+n8OoLyugo=;
        b=POYiFmJra8BduMkX0l3ba/dSMCXVTW8i911gg3upy23CuajNUfYedpm0T2dnwt2xHR
         P6AHQ/iWF8EQy6GrWk/XXFKvzzTyfuZdOHegksSoYKNMbii0XZrm/M7LVz89VygUlNFh
         hLjpXlObpO+UzFy1jFKe5XgVEI2lqRc4Y+n9PjBtLnDJ8YHCFZz0meZUeOngbNtprB6h
         ppEh4B4hr5zKTpnxiKkXB9wdJjK1pCYcEttMdhl2rDMLJkl4weBVXHbjEwiUE1ck17bU
         jxkPl79I2HWejtjnBFZlowZU0Wc/8h/+eF+cxHuaXYbkyei99FB7UL+ruQqtzLHORAbS
         jOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686320515; x=1688912515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYw72ONYPV2xVcy+vVwHAaNMN0MkSZEs9+n8OoLyugo=;
        b=UkUmFjs5SSmBmOzPLByaD+yfkSQ0HmbQGGxd08ONZJgjsxIhn8V2zUwAlWze3yOsIL
         ZbHIYm7jNQd83pKgnMshc/3q5Ya/0acnSmf14haJOvno9Lf7RpQSZOx+4pjkKr6XV/kn
         SvMNedHq2Zw2r4AzReQk3j37cz0nTZynzt5dmHfgx2mSWLpGMARUpaIaNvLTDQqbXST8
         V10hpxvdRRpQouUvKVdjmV4gTErRim+ZW0p5exY3IcObsJ1cBtDPE61rJWYZKa9v9Hm+
         bZI/TWCDqOVjLPwwYL7DMB9co9HdObuQfnTQdecJkAhEqJoO+XzkAKv61OE1Y0DSJ8xI
         IKxQ==
X-Gm-Message-State: AC+VfDw2etS4KTkGyt0BVBJXnsK13JvgEXXY1N95ZqTqMKaV1xbIbi6f
        5a8g3sxF/Nv++EcSEh0jHAZGMwBB6XlJW4oGVvrGqg==
X-Google-Smtp-Source: ACHHUZ6Y+NIkPQikkI8aKPtMgD3/TPOkqVy6U1xEezSWkfp7GsXZ53//b6kXeGHGqtyyyQT7adNmfgwXmm/U35rVdss=
X-Received: by 2002:a67:d017:0:b0:43b:56af:df85 with SMTP id
 r23-20020a67d017000000b0043b56afdf85mr991427vsi.15.1686320515618; Fri, 09 Jun
 2023 07:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230609-v4l2-vtotal-v1-0-4b7dee7e073e@skidata.com> <20230609-v4l2-vtotal-v1-2-4b7dee7e073e@skidata.com>
In-Reply-To: <20230609-v4l2-vtotal-v1-2-4b7dee7e073e@skidata.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 9 Jun 2023 15:21:39 +0100
Message-ID: <CAPY8ntCx8QLX_jqtJeWzCQkApSR_+RY7jMM5pDNA7zewJa+eiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: i2c: imx290: Add support for V4L2_CID_VTOTAL
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

Thanks for the patch

On Fri, 9 Jun 2023 at 14:16, Benjamin Bara <bbara93@gmail.com> wrote:
>
> From: Benjamin Bara <benjamin.bara@skidata.com>
>
> The new V4L2_CID_VTOTAL control represents the VMAX register.
> Implementing it simplifies calculations in user space, as it is
> independent of the current mode (format height), meaning its value does
> not change with format changes.

I know Laurent suggested this change[1] so that (AIUI) exposure max
limits are easier to compute around mode changes.

I'm currently seeing this as a fair amount of boilerplate to be added
to all drivers so that two controls provide effectively the same
information, and I'm not convinced it saves any significant effort in
userspace. Can you (or Laurent) detail exactly what the issue is that
the new control solves?

Do we need to do the same for HBLANK as well, or do we live with an
asymmetrical set of controls.

Thanks
  Dave

[1] https://lists.libcamera.org/pipermail/libcamera-devel/2023-June/038170.html

> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/media/i2c/imx290.c | 47 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 5ea25b7acc55..42938400efb0 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -255,6 +255,7 @@ struct imx290 {
>         struct v4l2_ctrl *link_freq;
>         struct v4l2_ctrl *hblank;
>         struct v4l2_ctrl *vblank;
> +       struct v4l2_ctrl *vtotal;
>         struct v4l2_ctrl *exposure;
>         struct {
>                 struct v4l2_ctrl *hflip;
> @@ -782,8 +783,7 @@ static void imx290_exposure_update(struct imx290 *imx290,
>  {
>         unsigned int exposure_max;
>
> -       exposure_max = imx290->vblank->val + mode->height -
> -                      IMX290_EXPOSURE_OFFSET;
> +       exposure_max = imx290->vtotal->val - IMX290_EXPOSURE_OFFSET;
>         __v4l2_ctrl_modify_range(imx290->exposure, 1, exposure_max, 1,
>                                  exposure_max);
>  }
> @@ -794,7 +794,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
>                                              struct imx290, ctrls);
>         const struct v4l2_mbus_framefmt *format;
>         struct v4l2_subdev_state *state;
> -       int ret = 0, vmax;
> +       int ret = 0;
>
>         /*
>          * Return immediately for controls that don't need to be applied to the
> @@ -803,10 +803,22 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
>         if (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY)
>                 return 0;
>
> -       if (ctrl->id == V4L2_CID_VBLANK) {
> -               /* Changing vblank changes the allowed range for exposure. */
> +       /* Changing vtotal changes the allowed range for exposure. */
> +       if (ctrl->id == V4L2_CID_VTOTAL)
>                 imx290_exposure_update(imx290, imx290->current_mode);
> -       }
> +
> +       /*
> +        * vblank and vtotal depend on each other, therefore also update the
> +        * other one.
> +        */
> +       if (ctrl->id == V4L2_CID_VBLANK &&
> +           imx290->vtotal->val != ctrl->val + imx290->current_mode->height)
> +               __v4l2_ctrl_s_ctrl(imx290->vtotal,
> +                                  ctrl->val + imx290->current_mode->height);
> +       if (ctrl->id == V4L2_CID_VTOTAL &&
> +           imx290->vblank->val != ctrl->val - imx290->current_mode->height)
> +               __v4l2_ctrl_s_ctrl(imx290->vblank,
> +                                  ctrl->val - imx290->current_mode->height);
>
>         /* V4L2 controls values will be applied only when power is already up */
>         if (!pm_runtime_get_if_in_use(imx290->dev))
> @@ -821,9 +833,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
>                 break;
>
>         case V4L2_CID_VBLANK:
> -               ret = imx290_write(imx290, IMX290_VMAX,
> -                                  ctrl->val + imx290->current_mode->height,
> -                                  NULL);
> +               /* vblank is updated by vtotal. */
> +               break;
> +
> +       case V4L2_CID_VTOTAL:
> +               ret = imx290_write(imx290, IMX290_VMAX, ctrl->val, NULL);
> +               if (ret)
> +                       goto err;
> +
>                 /*
>                  * Due to the way that exposure is programmed in this sensor in
>                  * relation to VMAX, we have to reprogramme it whenever VMAX is
> @@ -834,9 +851,8 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
>                 ctrl = imx290->exposure;
>                 fallthrough;
>         case V4L2_CID_EXPOSURE:
> -               vmax = imx290->vblank->val + imx290->current_mode->height;
>                 ret = imx290_write(imx290, IMX290_SHS1,
> -                                  vmax - ctrl->val - 1, NULL);
> +                                  imx290->vtotal->val - ctrl->val - 1, NULL);
>                 break;
>
>         case V4L2_CID_TEST_PATTERN:
> @@ -880,6 +896,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
>                 break;
>         }
>
> +err:
>         pm_runtime_mark_last_busy(imx290->dev);
>         pm_runtime_put_autosuspend(imx290->dev);
>
> @@ -911,11 +928,14 @@ static void imx290_ctrl_update(struct imx290 *imx290,
>         unsigned int vblank_max = IMX290_VMAX_MAX - mode->height;
>
>         __v4l2_ctrl_s_ctrl(imx290->link_freq, mode->link_freq_index);
> +       __v4l2_ctrl_s_ctrl(imx290->vblank, imx290->vtotal->val - mode->height);
>
>         __v4l2_ctrl_modify_range(imx290->hblank, hblank_min, hblank_max, 1,
>                                  hblank_min);
>         __v4l2_ctrl_modify_range(imx290->vblank, vblank_min, vblank_max, 1,
>                                  vblank_min);
> +       __v4l2_ctrl_modify_range(imx290->vtotal, mode->vmax_min,
> +                                IMX290_VMAX_MAX, 1, mode->vmax_min);
>  }
>
>  static int imx290_ctrl_init(struct imx290 *imx290)
> @@ -947,7 +967,7 @@ static int imx290_ctrl_init(struct imx290 *imx290)
>
>         /*
>          * Correct range will be determined through imx290_ctrl_update setting
> -        * V4L2_CID_VBLANK.
> +        * V4L2_CID_VTOTAL.
>          */
>         imx290->exposure = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
>                                              V4L2_CID_EXPOSURE, 1, 65535, 1,
> @@ -983,6 +1003,9 @@ static int imx290_ctrl_init(struct imx290 *imx290)
>
>         imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
>                                            V4L2_CID_VBLANK, 1, 1, 1, 1);
> +       imx290->vtotal = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> +                                          V4L2_CID_VTOTAL, 1, IMX290_VMAX_MAX,
> +                                          1, 1);
>
>         imx290->hflip = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
>                                           V4L2_CID_HFLIP, 0, 1, 1, 0);
>
> --
> 2.34.1
>
