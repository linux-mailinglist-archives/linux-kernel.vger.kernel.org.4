Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5156B60E060
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiJZMKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiJZMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:09:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06438D9975;
        Wed, 26 Oct 2022 05:08:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a67so41041031edf.12;
        Wed, 26 Oct 2022 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+sFgXU272HAzKHMb/kYeJV2N/Mo4JiF4D4k4UprARA=;
        b=fzEn+CmvIJyhIRGwFqLt44V5e6YtCKWJe6uFUNDfViuWX7SatpNXsPijOQz3UeF4dE
         vaapxdyEpr7dibMIA4MdZ2IzgbZktcyLHiskJfisGXRS05X8CWMo1iPoRF2PVrSI4xLe
         Th3wPzgpPosZ2bbL0njaUjSOwXlrSD8bVwqDB/eBxj9UbKGuhC5mZ321jZVGMgzn5ucM
         CXJMbNVnWW8kaj7+G4MRNmOSy/9qv7UHK9uajffee1LRvEaHERZIp6oquVSpLyhxspqi
         7k3gs4InSSGac+46G8+KzpLf96c5Ug0ThOlCQlii4dH97hFglrpfJKMppcU14lFo4UZa
         zWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+sFgXU272HAzKHMb/kYeJV2N/Mo4JiF4D4k4UprARA=;
        b=SxAhJthpRwuOfjwd4lW+vjo41Q4mp6MXJfOpK9ulCRgAkpVxVWSHUhbQiqHxEtRTgr
         RXf7hLfcSlTn76gWhpPCd9QuSmLNSwK0cqPT5R1T9wCiwc3Iz7LyO2OUlq/nRPrqbAIc
         +v3/NgHxAi0yFeffGVYvNhyxEz2HFuwpXv76zCMW7d3r0ZxU+904QkCLpTJmEF1N8zON
         1jkc7CtxRzCvtVKvNjYvLSlSDql7OT+ySL7L8dd27Gjn9zZvWu07bA4yklFL7lK9slP6
         TMtzwS7oBqHeTCYIXAOuBUjyQJjkNBVpG2boTzsAY6yysgSfAEfHuiMhESUaL7oEr1ub
         EiKA==
X-Gm-Message-State: ACrzQf1X+bDj8zDgCd4gGfFFZNHam+KBx6V3p6jYWmq+Mb89m7+PDzG6
        rHe/2+KxOmAv6fRzRW3OdSu6VmArQmrh5zry5iM=
X-Google-Smtp-Source: AMsMyM4uQcHACnDYbCpSVLGK6r2/1lQQH7yJt8RKJJJ3m09SvKWD63tUH5pVnggP0JMYooCH4Zy0CdKo4gAHJyYU6fA=
X-Received: by 2002:a05:6402:2552:b0:45d:ecf:b23 with SMTP id
 l18-20020a056402255200b0045d0ecf0b23mr40976114edb.255.1666786098436; Wed, 26
 Oct 2022 05:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0m180wwV9CiNNTf@paasikivi.fi.intel.com> <Y0pNkiK2IZP4Ipey@pendragon.ideasonboard.com>
 <Y0pSP3fwM8pEeD1e@pendragon.ideasonboard.com>
In-Reply-To: <Y0pSP3fwM8pEeD1e@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 13:07:51 +0100
Message-ID: <CA+V-a8s6JmM+DYYdzCoQt9h_OXCLt5iuEGi-RvtJkY-5QQhjgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] media: i2c: ov5645: Use runtime PM
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Laurent,

Thank you for the review.

On Sat, Oct 15, 2022 at 7:25 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> One more comment.
>
> On Sat, Oct 15, 2022 at 09:05:08AM +0300, Laurent Pinchart wrote:
> > On Fri, Oct 14, 2022 at 07:18:11PM +0000, Sakari Ailus wrote:
> > > On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Switch to using runtime PM for power management.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v1->v2
> > > > * Moved pm_runtime_*_autosuspend() calls after registering the subdev.
> > > > ---
> > > >  drivers/media/i2c/Kconfig  |   2 +-
> > > >  drivers/media/i2c/ov5645.c | 137 +++++++++++++++++++------------------
> > > >  2 files changed, 70 insertions(+), 69 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > > index 7806d4b81716..c0edd1017fe8 100644
> > > > --- a/drivers/media/i2c/Kconfig
> > > > +++ b/drivers/media/i2c/Kconfig
> > > > @@ -459,7 +459,7 @@ config VIDEO_OV5640
> > > >  config VIDEO_OV5645
> > > >   tristate "OmniVision OV5645 sensor support"
> > > >   depends on OF
> > > > - depends on I2C && VIDEO_DEV
> > > > + depends on I2C && PM && VIDEO_DEV
> > > >   select MEDIA_CONTROLLER
> > > >   select VIDEO_V4L2_SUBDEV_API
> > > >   select V4L2_FWNODE
> > > > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > > > index 81e4e87e1821..1551690a94e0 100644
> > > > --- a/drivers/media/i2c/ov5645.c
> > > > +++ b/drivers/media/i2c/ov5645.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_graph.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/regulator/consumer.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/types.h>
> > > > @@ -108,7 +109,6 @@ struct ov5645 {
> > > >   u8 timing_tc_reg21;
> > > >
> > > >   struct mutex power_lock; /* lock to protect power state */
> > > > - int power_count;
> > > >
> > > >   struct gpio_desc *enable_gpio;
> > > >   struct gpio_desc *rst_gpio;
> > > > @@ -635,8 +635,24 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
> > > >   return 0;
> > > >  }
> > > >
> > > > -static int ov5645_set_power_on(struct ov5645 *ov5645)
> > > > +static int ov5645_set_power_off(struct device *dev)
> > > >  {
> > > > + struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > > > + struct ov5645 *ov5645 = to_ov5645(sd);
> > > > +
> > > > + ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> >
> > I'm not sure this belongs here, but it can be addressed later.
> >
> > > > + gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > > > + gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > > > + clk_disable_unprepare(ov5645->xclk);
> > > > + regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > > > +
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static int ov5645_set_power_on(struct device *dev)
> > > > +{
> > > > + struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > > > + struct ov5645 *ov5645 = to_ov5645(sd);
> > > >   int ret;
> > > >
> > > >   ret = regulator_bulk_enable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > > > @@ -658,57 +674,19 @@ static int ov5645_set_power_on(struct ov5645 *ov5645)
> > > >
> > > >   msleep(20);
> > > >
> > > > - return 0;
> > > > -}
> > > > -
> > > > -static void ov5645_set_power_off(struct ov5645 *ov5645)
> > > > -{
> > > > - gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > > > - gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > > > - clk_disable_unprepare(ov5645->xclk);
> > > > - regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > > > -}
> > > > -
> > > > -static int ov5645_s_power(struct v4l2_subdev *sd, int on)
> > > > -{
> > > > - struct ov5645 *ov5645 = to_ov5645(sd);
> > > > - int ret = 0;
> > > > -
> > > > - mutex_lock(&ov5645->power_lock);
> > > > -
> > > > - /* If the power count is modified from 0 to != 0 or from != 0 to 0,
> > > > -  * update the power state.
> > > > -  */
> > > > - if (ov5645->power_count == !on) {
> > > > -         if (on) {
> > > > -                 ret = ov5645_set_power_on(ov5645);
> > > > -                 if (ret < 0)
> > > > -                         goto exit;
> > > > -
> > > > -                 ret = ov5645_set_register_array(ov5645,
> > > > -                                 ov5645_global_init_setting,
> > > > + ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
> > > >                                   ARRAY_SIZE(ov5645_global_init_setting));
> > > > -                 if (ret < 0) {
> > > > -                         dev_err(ov5645->dev,
> > > > -                                 "could not set init registers\n");
> > > > -                         ov5645_set_power_off(ov5645);
> > > > -                         goto exit;
> > > > -                 }
> > > > -
> > > > -                 usleep_range(500, 1000);
> > > > -         } else {
> > > > -                 ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> > > > -                 ov5645_set_power_off(ov5645);
> > > > -         }
> > > > + if (ret < 0) {
> > > > +         dev_err(ov5645->dev, "could not set init registers\n");
> > > > +         goto exit;
> > > >   }
> > > >
> > > > - /* Update the power count. */
> > > > - ov5645->power_count += on ? 1 : -1;
> > > > - WARN_ON(ov5645->power_count < 0);
> > > > + usleep_range(500, 1000);
> > > >
> > > > -exit:
> > > > - mutex_unlock(&ov5645->power_lock);
> > > > + return 0;
> > > >
> > > > +exit:
> > > > + ov5645_set_power_off(dev);
> > > >   return ret;
> > > >  }
> > > >
> > > > @@ -795,7 +773,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> > > >   int ret;
> > > >
> > > >   mutex_lock(&ov5645->power_lock);
> > > > - if (!ov5645->power_count) {
> > > > + if (!pm_runtime_get_if_in_use(ov5645->dev)) {
> > > >           mutex_unlock(&ov5645->power_lock);
> > > >           return 0;
> > > >   }
> > > > @@ -827,6 +805,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> > > >           break;
> > > >   }
> > > >
> > > > + pm_runtime_put_autosuspend(ov5645->dev);
> > >
> > > I think you'll need pm_runtime_mark_last_busy() before this. I missed this
> > > on the last round. Maybe in probe() too. Feel free to resend just this
> > > patch.
> > >
> > > >   mutex_unlock(&ov5645->power_lock);
> > > >
> > > >   return ret;
> > > > @@ -991,6 +970,10 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > > >   int ret;
> > > >
> > > >   if (enable) {
> > > > +         ret = pm_runtime_resume_and_get(ov5645->dev);
> > > > +         if (ret < 0)
> > > > +                 return ret;
> > > > +
> > > >           ret = ov5645_set_register_array(ov5645,
> > > >                                   ov5645->current_mode->data,
> > > >                                   ov5645->current_mode->data_size);
> > > > @@ -998,22 +981,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > > >                   dev_err(ov5645->dev, "could not set mode %dx%d\n",
> > > >                           ov5645->current_mode->width,
> > > >                           ov5645->current_mode->height);
> > > > -                 return ret;
> > > > +                 goto err_rpm_put;
> > > >           }
> > > >           ret = v4l2_ctrl_handler_setup(&ov5645->ctrls);
> > > >           if (ret < 0) {
> > > >                   dev_err(ov5645->dev, "could not sync v4l2 controls\n");
> > > > -                 return ret;
> > > > +                 goto err_rpm_put;
> > > >           }
> > > >
> > > >           ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x45);
> > > >           if (ret < 0)
> > > > -                 return ret;
> > > > +                 goto err_rpm_put;
> > > >
> > > >           ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> > > >                                  OV5645_SYSTEM_CTRL0_START);
> > > >           if (ret < 0)
> > > > -                 return ret;
> > > > +                 goto err_rpm_put;
> > > >   } else {
> > > >           ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> > > >           if (ret < 0)
> > > > @@ -1023,14 +1006,15 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > > >                                  OV5645_SYSTEM_CTRL0_STOP);
> > > >           if (ret < 0)
> > > >                   return ret;
> > > > +         pm_runtime_put(ov5645->dev);
>
> This should be pm_runtime_put_autosuspend(), with a
> pm_runtime_mark_last_busy() call too.
>
OK.

> > > >   }
> > > >
> > > >   return 0;
> > > > -}
> > > >
> > > > -static const struct v4l2_subdev_core_ops ov5645_core_ops = {
> > > > - .s_power = ov5645_s_power,
> > > > -};
> > > > +err_rpm_put:
> > > > + pm_runtime_put(ov5645->dev);
>
> Here I would go for pm_runtime_put_sync(), as a failure to start the
> stream would benefit from forcing power being cut off before the user
> tries again.
>
Agreed.

> > > > + return ret;
> > > > +}
> > > >
> > > >  static const struct v4l2_subdev_video_ops ov5645_video_ops = {
> > > >   .s_stream = ov5645_s_stream,
> > > > @@ -1046,7 +1030,6 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
> > > >  };
> > > >
> > > >  static const struct v4l2_subdev_ops ov5645_subdev_ops = {
> > > > - .core = &ov5645_core_ops,
> > > >   .video = &ov5645_video_ops,
> > > >   .pad = &ov5645_subdev_pad_ops,
> > > >  };
> > > > @@ -1188,11 +1171,9 @@ static int ov5645_probe(struct i2c_client *client)
> > > >           goto free_ctrl;
> > > >   }
> > > >
> > > > - ret = ov5645_s_power(&ov5645->sd, true);
> > > > - if (ret < 0) {
> > > > -         dev_err(dev, "could not power up OV5645\n");
> > > > + ret = ov5645_set_power_on(dev);
> > > > + if (ret)
> > > >           goto free_entity;
> > > > - }
> > > >
> > > >   ret = ov5645_read_reg(ov5645, OV5645_CHIP_ID_HIGH, &chip_id_high);
> > > >   if (ret < 0 || chip_id_high != OV5645_CHIP_ID_HIGH_BYTE) {
> > > > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> > > >
> > > >   dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> > > >
> > > > + pm_runtime_set_active(dev);
> > > > + pm_runtime_get_noresume(dev);
> > > > + pm_runtime_enable(dev);
> > > > +
> > > >   ret = ov5645_read_reg(ov5645, OV5645_AEC_PK_MANUAL,
> > > >                         &ov5645->aec_pk_manual);
> >
> > Totally unrelated to this patch, can we drop all these register reads ?
> > The registers are written through he ov5645_global_init_setting array,
> > we know what the values are.
> >
Indeed, I'll have a closer look while working on the subdev state for
this driver.

> > > >   if (ret < 0) {
> > > >           dev_err(dev, "could not read AEC/AGC mode\n");
> > > >           ret = -ENODEV;
> > > > -         goto power_down;
> > > > +         goto err_pm_runtime;
> > > >   }
> > > >
> > > >   ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG20,
> > > > @@ -1222,7 +1207,7 @@ static int ov5645_probe(struct i2c_client *client)
> > > >   if (ret < 0) {
> > > >           dev_err(dev, "could not read vflip value\n");
> > > >           ret = -ENODEV;
> > > > -         goto power_down;
> > > > +         goto err_pm_runtime;
> > > >   }
> > > >
> > > >   ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG21,
> > > > @@ -1230,23 +1215,30 @@ static int ov5645_probe(struct i2c_client *client)
> > > >   if (ret < 0) {
> > > >           dev_err(dev, "could not read hflip value\n");
> > > >           ret = -ENODEV;
> > > > -         goto power_down;
> > > > +         goto err_pm_runtime;
> > > >   }
> > > >
> > > > - ov5645_s_power(&ov5645->sd, false);
> > > > -
> > > >   ret = v4l2_async_register_subdev(&ov5645->sd);
> > > >   if (ret < 0) {
> > > >           dev_err(dev, "could not register v4l2 device\n");
> > > > +         pm_runtime_disable(dev);
> > > > +         pm_runtime_set_suspended(dev);
> > > >           goto free_entity;
> >
> > This looks weird, why do we need special handling of runtime PM here,
> > instead of just jumping to err_pm_runtime ?
> >
Agreed, I have fixed that now.

> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
Cheers,
Prabhakar
