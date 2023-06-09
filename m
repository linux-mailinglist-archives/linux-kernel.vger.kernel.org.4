Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D53729842
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbjFILgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFILgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:36:52 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CE2D68
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:36:50 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-789d36c830cso659610241.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1686310610; x=1688902610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JB4CTunLjDtuj3/U1NJvDXOU9FbzRT6Z5F6MuzG7PXE=;
        b=TlDx+q+/FFWVeNtExocYfHS+0B9wcTMdQ2jN5aJavlczQdazku17vR8yQ3el94ib6n
         pkVjeR3BLRqH825/LQBHc8xmbq3AiFwFCMC3talrIgBB/jUh7vIJchNO6SUEa6jgCqwB
         Iu9VoaFbWI4Bn4yG9u7t6kqctjxgRzOboi+jU9daMmMT416RcUcUmadXwqcL24w4Fxr1
         PriaxXLvkSNX8n1VGTAU70bnPVFijLBbHSZmdR/dPErxZQd8HC67dwVpa96udobFpTk9
         F6Ly2aSnwnQ3YDvXq8u/sw9DUtxAIyWh9iU5uSWId71T09A+Ov8Rn6Co8clptxViBuSx
         Vkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310610; x=1688902610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JB4CTunLjDtuj3/U1NJvDXOU9FbzRT6Z5F6MuzG7PXE=;
        b=NLsoTT23+rFvk+etsqUURnazH7wu3SOM2NxEZv8RC7DpW4II8w+je4VPRkuRW3rR2k
         WsCpObWNw9U4jZ1OOLeyW/L5unQN0BCg9nXKE/l3uD0+g/RpJ1R/E+QlNIxpq6ZxAXSB
         SQTpzGPZ0kf0hOi0qHCbEIeY5gyXzJrxYMPGopd8XZoWU0cJa8tzbm6kMukrd6AzPO90
         cktJ7bGtDPMgrLk55328C6v9x/osrbfhCWm8BkMYdWLR5/inWb9OOvBewaxTt/LfIC4W
         dn+7KLjs71YGh77mON0wvJKrHj9cFCWAR7b+M3Ny8DJKDsqH1f9TFt7/vM7JbzMoMaY9
         LN8w==
X-Gm-Message-State: AC+VfDwelZQt9ghpItug8chZpp6vclAH19Qw5IhXUReYSL0gfflNFL3H
        AQblEL+DhKZpTz0beSv9wQ0dDCql6UN6/R6gJXuF6w==
X-Google-Smtp-Source: ACHHUZ7ehYIQTXfBt5Th7NxzuAq+LE45UrOBNJX+f5UIMHneMwdaLrC6UFuwzEpBYiXgYMD+wFgiN2Bm536HVbTndqc=
X-Received: by 2002:a05:6102:34f9:b0:43b:458f:b078 with SMTP id
 bi25-20020a05610234f900b0043b458fb078mr760771vsb.30.1686310610005; Fri, 09
 Jun 2023 04:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230608222810.574628-1-tomm.merciai@gmail.com>
In-Reply-To: <20230608222810.574628-1-tomm.merciai@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 9 Jun 2023 12:36:33 +0100
Message-ID: <CAPY8ntA2YLc-yTngBzL2-yrs8_25kKNcfTB+t4LE8n8sovKpJw@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: imx290: drop format param from imx290_ctrl_update
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, linuxfancy@googlegroups.com,
        jacopo.mondi@ideasonboard.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Tommaso

Thanks for the patch.

On Thu, 8 Jun 2023 at 23:28, Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> The format param actually is not used in imx290_ctrl_update
> function, let's drop this
>
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

You (or a maintainer in applying it) could add:

Fixes: bc35f9a21a55 ("media: i2c: imx290: Fix the pixel rate at 148.5Mpix/s")

> ---
>  drivers/media/i2c/imx290.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 5ea25b7acc55..a84b581682a2 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -902,7 +902,6 @@ static const char * const imx290_test_pattern_menu[] = {
>  };
>
>  static void imx290_ctrl_update(struct imx290 *imx290,
> -                              const struct v4l2_mbus_framefmt *format,
>                                const struct imx290_mode *mode)
>  {
>         unsigned int hblank_min = mode->hmax_min - mode->width;
> @@ -1195,7 +1194,7 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
>         if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
>                 imx290->current_mode = mode;
>
> -               imx290_ctrl_update(imx290, &fmt->format, mode);
> +               imx290_ctrl_update(imx290, mode);
>                 imx290_exposure_update(imx290, mode);
>         }
>
> @@ -1300,7 +1299,6 @@ static const struct media_entity_operations imx290_subdev_entity_ops = {
>  static int imx290_subdev_init(struct imx290 *imx290)
>  {
>         struct i2c_client *client = to_i2c_client(imx290->dev);
> -       const struct v4l2_mbus_framefmt *format;
>         struct v4l2_subdev_state *state;
>         int ret;
>
> @@ -1335,8 +1333,7 @@ static int imx290_subdev_init(struct imx290 *imx290)
>         }
>
>         state = v4l2_subdev_lock_and_get_active_state(&imx290->sd);
> -       format = v4l2_subdev_get_pad_format(&imx290->sd, state, 0);
> -       imx290_ctrl_update(imx290, format, imx290->current_mode);
> +       imx290_ctrl_update(imx290, imx290->current_mode);
>         v4l2_subdev_unlock_state(state);
>
>         return 0;
> --
> 2.34.1
>
