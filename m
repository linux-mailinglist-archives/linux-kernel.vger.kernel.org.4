Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B95FCB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJLS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJLS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:56:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15803FA3D;
        Wed, 12 Oct 2022 11:55:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r14so11368084edc.7;
        Wed, 12 Oct 2022 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVB6ZYTXUvLg/D/PHLwOskXsHA8JVr/HQ+MinTA/oK8=;
        b=fZlrmklj1VesxLv2gq0SAZzmWe0r6DaFZOmox6WujoQAbtR8IpxJ1O2dSL2wrywfdT
         umudUW7shlTPgER348TqX9Kewhbblv+mgt45kOpdRD+gjZ4DUWJNF5tXIaBaleZjX8/5
         Kuxz1OxfBep3CsmtKFWRe7eHi6ojd4f6utfCQIhxGs48J/1hPrS8Wyqf+mk25x+KL1ye
         65rkoL+6p44nRxs4XZnqPk818HSh3TUMsYzuedgahANH0EoqgNOuR0X2Lq/mLcPrB9uR
         1aHJpDf/Lryf34XPYr4bqSmfJBuY223CMNyqmZ+YeVzVULf0SP8nxXMXUzxKR9tzZmSc
         lEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVB6ZYTXUvLg/D/PHLwOskXsHA8JVr/HQ+MinTA/oK8=;
        b=38u4Gt1/VQHtl9Va9NDzjm88NE23QGQF5HTHreNQL7U6Yz9mei2vUZzoBgReRkfIay
         vmCnLF8aBMWVr+FAwxEqwLU8S1NMUJRe6fiUaAVw4MTW8iR/r+3lkOgAWUU8QEr0z0xR
         O3P4THninM6z0nmyoTHOj8ae93HVuMHQJxO+qF0U4VLpvKcJjSE7xiZOOklf4FfD+YUM
         BnpMhMuGuIQLnKVVdRmk5rik5qPtCUnMe80c0X0ySSjUPe3ww/4cEw5mv9vZ4Z7dyMzP
         n8yk36DnrNxbMelx5IDDXT47ViB7eyfTq+LGVeSImRdIOcMJh/9270SHg/8UzNXJhou2
         XsKg==
X-Gm-Message-State: ACrzQf2rWWGRnA5gwFG//D8FhsTZoiGV85YvBYXTrjzAa0neohKwmwLW
        xTC/6B58SsWuSDAHlMBCGoOojUj8EBMmz3d5URA=
X-Google-Smtp-Source: AMsMyM7bh/aV4pHRcV6NpRU8yjGQWB83+0rDVN2nWli5zW92pfuvmVWDajmG36eY9rwedsYEY6W7BAiknzjS70XsZ2k=
X-Received: by 2002:a05:6402:5485:b0:459:147a:d902 with SMTP id
 fg5-20020a056402548500b00459147ad902mr29644202edb.263.1665600952970; Wed, 12
 Oct 2022 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0Ulvmyg8rBOPbRF@paasikivi.fi.intel.com> <CA+V-a8v6ZGC7Ea6zdWGcLVyyq2Q=pUb0C_OwHWjFqSmuo5f-ZA@mail.gmail.com>
In-Reply-To: <CA+V-a8v6ZGC7Ea6zdWGcLVyyq2Q=pUb0C_OwHWjFqSmuo5f-ZA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 12 Oct 2022 19:55:25 +0100
Message-ID: <CA+V-a8vkB=Fok5S-L_zLT+unxuuSJJk+pkeS52N_kcugCoeT6w@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Oct 11, 2022 at 9:36 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Sakari,
>
> Thanks for the review. That was quick.
>
> On Tue, Oct 11, 2022 at 9:14 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > Thanks for the patch. It's great to see drivers moving to runtime PM!
> >
> > On Tue, Sep 27, 2022 at 09:16:34PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Switch to using runtime PM for power management.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/media/i2c/Kconfig  |   2 +-
> > >  drivers/media/i2c/ov5645.c | 135 +++++++++++++++++++------------------
> > >  2 files changed, 69 insertions(+), 68 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > index 7806d4b81716..c0edd1017fe8 100644
> > > --- a/drivers/media/i2c/Kconfig
> > > +++ b/drivers/media/i2c/Kconfig
> > > @@ -459,7 +459,7 @@ config VIDEO_OV5640
> > >  config VIDEO_OV5645
> > >       tristate "OmniVision OV5645 sensor support"
> > >       depends on OF
> > > -     depends on I2C && VIDEO_DEV
> > > +     depends on I2C && PM && VIDEO_DEV
> > >       select MEDIA_CONTROLLER
> > >       select VIDEO_V4L2_SUBDEV_API
> > >       select V4L2_FWNODE
> > > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > > index 81e4e87e1821..3c3b30338328 100644
> > > --- a/drivers/media/i2c/ov5645.c
> > > +++ b/drivers/media/i2c/ov5645.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_graph.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/types.h>
> > > @@ -108,7 +109,6 @@ struct ov5645 {
> > >       u8 timing_tc_reg21;
> > >
> > >       struct mutex power_lock; /* lock to protect power state */
> > > -     int power_count;
> > >
> > >       struct gpio_desc *enable_gpio;
> > >       struct gpio_desc *rst_gpio;
> > > @@ -635,8 +635,24 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
> > >       return 0;
> > >  }
> > >
> > > -static int ov5645_set_power_on(struct ov5645 *ov5645)
> > > +static int ov5645_set_power_off(struct device *dev)
> > >  {
> > > +     struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > > +     struct ov5645 *ov5645 = to_ov5645(sd);
> > > +
> > > +     ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> > > +     gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > > +     gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > > +     clk_disable_unprepare(ov5645->xclk);
> > > +     regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ov5645_set_power_on(struct device *dev)
> > > +{
> > > +     struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > > +     struct ov5645 *ov5645 = to_ov5645(sd);
> > >       int ret;
> > >
> > >       ret = regulator_bulk_enable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > > @@ -658,57 +674,19 @@ static int ov5645_set_power_on(struct ov5645 *ov5645)
> > >
> > >       msleep(20);
> > >
> > > -     return 0;
> > > -}
> > > -
> > > -static void ov5645_set_power_off(struct ov5645 *ov5645)
> > > -{
> > > -     gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > > -     gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > > -     clk_disable_unprepare(ov5645->xclk);
> > > -     regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > > -}
> > > -
> > > -static int ov5645_s_power(struct v4l2_subdev *sd, int on)
> > > -{
> > > -     struct ov5645 *ov5645 = to_ov5645(sd);
> > > -     int ret = 0;
> > > -
> > > -     mutex_lock(&ov5645->power_lock);
> > > -
> > > -     /* If the power count is modified from 0 to != 0 or from != 0 to 0,
> > > -      * update the power state.
> > > -      */
> > > -     if (ov5645->power_count == !on) {
> > > -             if (on) {
> > > -                     ret = ov5645_set_power_on(ov5645);
> > > -                     if (ret < 0)
> > > -                             goto exit;
> > > -
> > > -                     ret = ov5645_set_register_array(ov5645,
> > > -                                     ov5645_global_init_setting,
> > > +     ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
> > >                                       ARRAY_SIZE(ov5645_global_init_setting));
> > > -                     if (ret < 0) {
> > > -                             dev_err(ov5645->dev,
> > > -                                     "could not set init registers\n");
> > > -                             ov5645_set_power_off(ov5645);
> > > -                             goto exit;
> > > -                     }
> > > -
> > > -                     usleep_range(500, 1000);
> > > -             } else {
> > > -                     ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> > > -                     ov5645_set_power_off(ov5645);
> > > -             }
> > > +     if (ret < 0) {
> > > +             dev_err(ov5645->dev, "could not set init registers\n");
> > > +             goto exit;
> > >       }
> > >
> > > -     /* Update the power count. */
> > > -     ov5645->power_count += on ? 1 : -1;
> > > -     WARN_ON(ov5645->power_count < 0);
> > > +     usleep_range(500, 1000);
> > >
> > > -exit:
> > > -     mutex_unlock(&ov5645->power_lock);
> > > +     return 0;
> > >
> > > +exit:
> > > +     ov5645_set_power_off(dev);
> > >       return ret;
> > >  }
> > >
> > > @@ -795,7 +773,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> > >       int ret;
> > >
> > >       mutex_lock(&ov5645->power_lock);
> > > -     if (!ov5645->power_count) {
> > > +     if (!pm_runtime_get_if_in_use(ov5645->dev)) {
> > >               mutex_unlock(&ov5645->power_lock);
> > >               return 0;
> > >       }
> > > @@ -827,6 +805,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> > >               break;
> > >       }
> > >
> > > +     pm_runtime_put_autosuspend(ov5645->dev);
> > >       mutex_unlock(&ov5645->power_lock);
> > >
> > >       return ret;
> > > @@ -991,6 +970,10 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > >       int ret;
> > >
> > >       if (enable) {
> > > +             ret = pm_runtime_resume_and_get(ov5645->dev);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > >               ret = ov5645_set_register_array(ov5645,
> > >                                       ov5645->current_mode->data,
> > >                                       ov5645->current_mode->data_size);
> > > @@ -998,22 +981,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > >                       dev_err(ov5645->dev, "could not set mode %dx%d\n",
> > >                               ov5645->current_mode->width,
> > >                               ov5645->current_mode->height);
> > > -                     return ret;
> > > +                     goto err_rpm_put;
> > >               }
> > >               ret = v4l2_ctrl_handler_setup(&ov5645->ctrls);
> > >               if (ret < 0) {
> > >                       dev_err(ov5645->dev, "could not sync v4l2 controls\n");
> > > -                     return ret;
> > > +                     goto err_rpm_put;
> > >               }
> > >
> > >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x45);
> > >               if (ret < 0)
> > > -                     return ret;
> > > +                     goto err_rpm_put;
> > >
> > >               ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> > >                                      OV5645_SYSTEM_CTRL0_START);
> > >               if (ret < 0)
> > > -                     return ret;
> > > +                     goto err_rpm_put;
> > >       } else {
> > >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> > >               if (ret < 0)
> > > @@ -1023,14 +1006,15 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > >                                      OV5645_SYSTEM_CTRL0_STOP);
> > >               if (ret < 0)
> > >                       return ret;
> >
> > Not a problem with this patch and should be addressed separately, but the
> > caller will just call s_stream(0) and will ignore the return value. You
> > could complain about the error but still should return 0 when disabling
> > streaming.
> >
> OK, I will create a separate patch on top of this.
>
> > > +             pm_runtime_put(ov5645->dev);
> > >       }
> > >
> > >       return 0;
> > > -}
> > >
> > > -static const struct v4l2_subdev_core_ops ov5645_core_ops = {
> > > -     .s_power = ov5645_s_power,
> > > -};
> > > +err_rpm_put:
> > > +     pm_runtime_put(ov5645->dev);
> > > +     return ret;
> > > +}
> > >
> > >  static const struct v4l2_subdev_video_ops ov5645_video_ops = {
> > >       .s_stream = ov5645_s_stream,
> > > @@ -1046,7 +1030,6 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
> > >  };
> > >
> > >  static const struct v4l2_subdev_ops ov5645_subdev_ops = {
> > > -     .core = &ov5645_core_ops,
> > >       .video = &ov5645_video_ops,
> > >       .pad = &ov5645_subdev_pad_ops,
> > >  };
> > > @@ -1188,11 +1171,9 @@ static int ov5645_probe(struct i2c_client *client)
> > >               goto free_ctrl;
> > >       }
> > >
> > > -     ret = ov5645_s_power(&ov5645->sd, true);
> > > -     if (ret < 0) {
> > > -             dev_err(dev, "could not power up OV5645\n");
> > > +     ret = ov5645_set_power_on(dev);
> > > +     if (ret)
> > >               goto free_entity;
> > > -     }
> > >
> > >       ret = ov5645_read_reg(ov5645, OV5645_CHIP_ID_HIGH, &chip_id_high);
> > >       if (ret < 0 || chip_id_high != OV5645_CHIP_ID_HIGH_BYTE) {
> > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > >
> > >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > >
> > > +     pm_runtime_set_active(dev);
> > > +     pm_runtime_get_noresume(dev);
> > > +     pm_runtime_enable(dev);
> > > +
> > >       ret = ov5645_read_reg(ov5645, OV5645_AEC_PK_MANUAL,
> > >                             &ov5645->aec_pk_manual);
> > >       if (ret < 0) {
> > >               dev_err(dev, "could not read AEC/AGC mode\n");
> > >               ret = -ENODEV;
> > > -             goto power_down;
> > > +             goto err_pm_runtime;
> > >       }
> > >
> > >       ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG20,
> > > @@ -1222,7 +1207,7 @@ static int ov5645_probe(struct i2c_client *client)
> > >       if (ret < 0) {
> > >               dev_err(dev, "could not read vflip value\n");
> > >               ret = -ENODEV;
> > > -             goto power_down;
> > > +             goto err_pm_runtime;
> > >       }
> > >
> > >       ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG21,
> > > @@ -1230,14 +1215,18 @@ static int ov5645_probe(struct i2c_client *client)
> > >       if (ret < 0) {
> > >               dev_err(dev, "could not read hflip value\n");
> > >               ret = -ENODEV;
> > > -             goto power_down;
> > > +             goto err_pm_runtime;
> > >       }
> > >
> > > -     ov5645_s_power(&ov5645->sd, false);
> > > +     pm_runtime_set_autosuspend_delay(dev, 1000);
> > > +     pm_runtime_use_autosuspend(dev);
> > > +     pm_runtime_put_autosuspend(dev);
> >
> > You can also do this after registering async subdev. That allows removing
> > err_pm_runtime label and the two lines below it.
> >
> Agreed, I'll move this after registering the subdev.
>
On a closer look, I can move the above after registering the subdev,
but I can get rid of err_pm_runtime label as PM is enabled further up
the code path to detect the senosr.

If you are OK with this i'll post a v2 along with the below two
patches + the suggestions you mentioned earlier on this patch.

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.linuxtv.org/project/linux-media/patch/20220919153540.178732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
