Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8648868398F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjAaWsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAaWsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:48:00 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1130A5C7;
        Tue, 31 Jan 2023 14:47:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id r8so9776467pls.2;
        Tue, 31 Jan 2023 14:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HU/MdybbG/glk0CegVgWICyWlU+BfqYTCamUenzajo=;
        b=qo+t07w2SMKuFdeA/18mz9N591rBihXFKkfOBr3SleMSXkiMz9LTAL6muokf+1CHSr
         kogi6FyE/OsujRkl0aciiZ6EMciYx0dySRXYizzNqspzHnQ5KkjUN1b+1jGQWwTMmYZS
         VctmcFVpy1irNmFVFYu2k61rJRnd2Umwp7BkUnEgnYSvdmK5cycxuhPeuY0MFJdKkLha
         HZZ/rMSX9u2wbS+rVvYrwfaPyHZx4xO/cdF86s7gQPto1C+cwUIQKvy1AvW/RcjQgBbp
         ZLa+hIVFpocaZ90uqgG6cOMysZBwQcLT06RTyh5eq14h0EIGI+atXTp4Mnr6+OHSH7E5
         /u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HU/MdybbG/glk0CegVgWICyWlU+BfqYTCamUenzajo=;
        b=11TRv19iFEJXyOMTLh3L/UzVEGTHGzdj29VBtyX44Gv2wRa7iEB0GQOw4KtAc8ptQl
         OaXQcWZp/cNIGEXTkSqgG3IkurPy6qgowT/YSXUgQAPSWN7svQeSI7Be0NYT1uIWutZL
         vQBfVM/ukk886YjRSz9h3MXcEKjztKA7GZmdGD6PgioKxIHJswpJZk+drizY+mgIKVuj
         2aI9R5DNyET6ye5AtgpwpeN/GGgBZF2uBfhwcWw673KvxS29CVthM4X3S8XXSVZIs0hO
         y3/G7ChAtSM4d5GMSMIYytg/9I0DmqC8OJX19r7k1s0PCczVxHXcEI3T/qR9D/QyT5Av
         ZgJg==
X-Gm-Message-State: AO0yUKW7ovd8WJLzlOEPaZjz+VDH3uvk7lHZ3ilE+wwPyk8KN0mrCKaC
        8lghCDE4r4HlRLoohPA2wbc8OaOQ68QoQJmzwjJ5aLpG
X-Google-Smtp-Source: AK7set/BCQNTIscNeVzBVBz8UHT9bXG3AL0aqJ0f/LokhadS2hAx5Qm/AGyxj8RNZuyPgsIOMdjJUw+nDazoigiwdGo=
X-Received: by 2002:a17:90a:c914:b0:230:2da0:5cf with SMTP id
 v20-20020a17090ac91400b002302da005cfmr212192pjt.42.1675205276943; Tue, 31 Jan
 2023 14:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20221220120754.2040428-1-aford173@gmail.com> <20221220120754.2040428-2-aford173@gmail.com>
 <CAHCN7xLsm32SufnHb3pozmjKbT6KTETTRR4msdiYBxDn_LKHRw@mail.gmail.com>
 <CAPY8ntAv7WC5mVz6F2Jd5iMDbYdP7KN=yFXFE+AtDrUc93qLwQ@mail.gmail.com>
 <CAHCN7xLrVfN+CbGhUEB-iy54hu2tSHk7Ge0eEb-h41r44R3DEg@mail.gmail.com>
 <CAPY8ntBZ9rw=Uki13rEDuCu9T9O5W5z-ZCw7bHRC-PudjzRUpA@mail.gmail.com>
 <CAHCN7xJcP0WWJitGgLvfS=UuWkHEF7-09TUizaON06BBPc4QfQ@mail.gmail.com> <CAPY8ntCrJdvqg+UTKTSXZLeXVu9=Rr0JK09RizA+Wgw3=uDD3Q@mail.gmail.com>
In-Reply-To: <CAPY8ntCrJdvqg+UTKTSXZLeXVu9=Rr0JK09RizA+Wgw3=uDD3Q@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 31 Jan 2023 16:47:44 -0600
Message-ID: <CAHCN7xJOR084tYnENcfZ74jOw-ub6yAQpy+B4wkfrVh3YQ-5Ew@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] media: i2c: imx219: Support four-lane operation
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     linux-media@vger.kernel.org, aford@beaconembedded.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 4:09 PM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Adam
>
> On Tue, 31 Jan 2023 at 20:52, Adam Ford <aford173@gmail.com> wrote:
> >
> > On Mon, Jan 16, 2023 at 11:05 AM Dave Stevenson
> > <dave.stevenson@raspberrypi.com> wrote:
> > >
> > > On Mon, 16 Jan 2023 at 16:36, Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 16, 2023 at 8:42 AM Dave Stevenson
> > > > <dave.stevenson@raspberrypi.com> wrote:
> > > > >
> > > > > Hi Adam
> > > > >
> > > > > Sorry, for the delay.
> > > > >
> > > > > On Fri, 13 Jan 2023 at 18:41, Adam Ford <aford173@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Dec 20, 2022 at 6:08 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > >
> > > > > > > The imx219 camera is capable of either two-lane or four-lane
> > > > > > > operation.  When operating in four-lane, both the pixel rate and
> > > > > > > link frequency change. Regardless of the mode, however, both
> > > > > > > frequencies remain fixed.
> > > > > > >
> > > > > > > Helper functions are needed to read and set pixel and link frequencies
> > > > > > > which also reduces the number of fixed registers in the table of modes.
> > > > > > >
> > > > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > >
> > > > > I can't test on 4 lanes, but 2 lane modes still work, and the code
> > > > > looks reasonable for 4 lanes.
> > > >
> > > > Thanks!  For what it's worth, I tested this on an Renesas RZ/G2M SoC
> > > > which has both a 2-lane and 4-lane interface, and I didn't see any
> > > > difference in performance or image quality between the 2-lane and
> > > > 4-lane modes.
> > >
> > > It's more that I don't have an IMX219 module that breaks out all 4 lanes.
> > > It still works correctly on 2 lanes, so as long as it works for you on
> > > 4 lanes, then I'm happy.
> > >
> > >   Dave
> > >
> > > > adam
> > > > >
> > > > > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > > >
> >
> > Is there anything that I need to do to get this into the media
> > staging?  I wasn't sure if I missed someone in the CC list.
>
> Your patches are in Sakari's tree, and he issued a pull request to
> Mauro for that about a week back. Those patches should be in 6.3.

Awesome.  Thank you.  I must not have looked in the right place.

adam
>
>   Dave
>
> > adam
> > > > >
> > > > > > Gentle nudge on this.
> > > > > >
> > > > > > > ---
> > > > > > > V4:  Restore check for nr_of_link_frequencies and update commit message
> > > > > > > V3:  Keep the helper function doing the link and lane parsing to
> > > > > > >      keep th probe function small.
> > > > > > >
> > > > > > > V2:  Replace if-else statements with ternary operator
> > > > > > >      Fix 4-lane Link Rate.
> > > > > > >      Fix checking the link rate so only the link rate for
> > > > > > >      the given number of lanes is permitted.
> > > > > > >
> > > > > > > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > > > > > > index 7f44d62047b6..b5fa4986470a 100644
> > > > > > > --- a/drivers/media/i2c/imx219.c
> > > > > > > +++ b/drivers/media/i2c/imx219.c
> > > > > > > @@ -42,10 +42,16 @@
> > > > > > >  /* External clock frequency is 24.0M */
> > > > > > >  #define IMX219_XCLK_FREQ               24000000
> > > > > > >
> > > > > > > -/* Pixel rate is fixed at 182.4M for all the modes */
> > > > > > > +/* Pixel rate is fixed for all the modes */
> > > > > > >  #define IMX219_PIXEL_RATE              182400000
> > > > > > > +#define IMX219_PIXEL_RATE_4LANE                280800000
> > > > > > >
> > > > > > >  #define IMX219_DEFAULT_LINK_FREQ       456000000
> > > > > > > +#define IMX219_DEFAULT_LINK_FREQ_4LANE 363000000
> > > > > > > +
> > > > > > > +#define IMX219_REG_CSI_LANE_MODE       0x0114
> > > > > > > +#define IMX219_CSI_2_LANE_MODE         0x01
> > > > > > > +#define IMX219_CSI_4_LANE_MODE         0x03
> > > > > > >
> > > > > > >  /* V_TIMING internal */
> > > > > > >  #define IMX219_REG_VTS                 0x0160
> > > > > > > @@ -299,6 +305,10 @@ static const s64 imx219_link_freq_menu[] = {
> > > > > > >         IMX219_DEFAULT_LINK_FREQ,
> > > > > > >  };
> > > > > > >
> > > > > > > +static const s64 imx219_link_freq_4lane_menu[] = {
> > > > > > > +       IMX219_DEFAULT_LINK_FREQ_4LANE,
> > > > > > > +};
> > > > > > > +
> > > > > > >  static const char * const imx219_test_pattern_menu[] = {
> > > > > > >         "Disabled",
> > > > > > >         "Color Bars",
> > > > > > > @@ -474,6 +484,9 @@ struct imx219 {
> > > > > > >
> > > > > > >         /* Streaming on/off */
> > > > > > >         bool streaming;
> > > > > > > +
> > > > > > > +       /* Two or Four lanes */
> > > > > > > +       u8 lanes;
> > > > > > >  };
> > > > > > >
> > > > > > >  static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
> > > > > > > @@ -936,6 +949,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
> > > > > > >         return -EINVAL;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int imx219_configure_lanes(struct imx219 *imx219)
> > > > > > > +{
> > > > > > > +       return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
> > > > > > > +                               IMX219_REG_VALUE_08BIT, (imx219->lanes == 2) ?
> > > > > > > +                               IMX219_CSI_2_LANE_MODE : IMX219_CSI_4_LANE_MODE);
> > > > > > > +};
> > > > > > > +
> > > > > > >  static int imx219_start_streaming(struct imx219 *imx219)
> > > > > > >  {
> > > > > > >         struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> > > > > > > @@ -953,6 +973,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> > > > > > >                 goto err_rpm_put;
> > > > > > >         }
> > > > > > >
> > > > > > > +       /* Configure two or four Lane mode */
> > > > > > > +       ret = imx219_configure_lanes(imx219);
> > > > > > > +       if (ret) {
> > > > > > > +               dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
> > > > > > > +               goto err_rpm_put;
> > > > > > > +       }
> > > > > > > +
> > > > > > >         /* Apply default values of current mode */
> > > > > > >         reg_list = &imx219->mode->reg_list;
> > > > > > >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > > > > > > @@ -1184,6 +1211,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
> > > > > > >         .open = imx219_open,
> > > > > > >  };
> > > > > > >
> > > > > > > +static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
> > > > > > > +{
> > > > > > > +       return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /* Initialize control handlers */
> > > > > > >  static int imx219_init_controls(struct imx219 *imx219)
> > > > > > >  {
> > > > > > > @@ -1205,15 +1237,16 @@ static int imx219_init_controls(struct imx219 *imx219)
> > > > > > >         /* By default, PIXEL_RATE is read only */
> > > > > > >         imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
> > > > > > >                                                V4L2_CID_PIXEL_RATE,
> > > > > > > -                                              IMX219_PIXEL_RATE,
> > > > > > > -                                              IMX219_PIXEL_RATE, 1,
> > > > > > > -                                              IMX219_PIXEL_RATE);
> > > > > > > +                                              imx219_get_pixel_rate(imx219),
> > > > > > > +                                              imx219_get_pixel_rate(imx219), 1,
> > > > > > > +                                              imx219_get_pixel_rate(imx219));
> > > > > > >
> > > > > > >         imx219->link_freq =
> > > > > > >                 v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
> > > > > > >                                        V4L2_CID_LINK_FREQ,
> > > > > > >                                        ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
> > > > > > > -                                      imx219_link_freq_menu);
> > > > > > > +                                      (imx219->lanes == 2) ? imx219_link_freq_menu :
> > > > > > > +                                      imx219_link_freq_4lane_menu);
> > > > > > >         if (imx219->link_freq)
> > > > > > >                 imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > > > > > >
> > > > > > > @@ -1308,7 +1341,7 @@ static void imx219_free_controls(struct imx219 *imx219)
> > > > > > >         mutex_destroy(&imx219->mutex);
> > > > > > >  }
> > > > > > >
> > > > > > > -static int imx219_check_hwcfg(struct device *dev)
> > > > > > > +static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
> > > > > > >  {
> > > > > > >         struct fwnode_handle *endpoint;
> > > > > > >         struct v4l2_fwnode_endpoint ep_cfg = {
> > > > > > > @@ -1328,10 +1361,12 @@ static int imx219_check_hwcfg(struct device *dev)
> > > > > > >         }
> > > > > > >
> > > > > > >         /* Check the number of MIPI CSI2 data lanes */
> > > > > > > -       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> > > > > > > -               dev_err(dev, "only 2 data lanes are currently supported\n");
> > > > > > > +       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2 &&
> > > > > > > +           ep_cfg.bus.mipi_csi2.num_data_lanes != 4) {
> > > > > > > +               dev_err(dev, "only 2 or 4 data lanes are currently supported\n");
> > > > > > >                 goto error_out;
> > > > > > >         }
> > > > > > > +       imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
> > > > > > >
> > > > > > >         /* Check the link frequency set in device tree */
> > > > > > >         if (!ep_cfg.nr_of_link_frequencies) {
> > > > > > > @@ -1340,7 +1375,8 @@ static int imx219_check_hwcfg(struct device *dev)
> > > > > > >         }
> > > > > > >
> > > > > > >         if (ep_cfg.nr_of_link_frequencies != 1 ||
> > > > > > > -           ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
> > > > > > > +          (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
> > > > > > > +           IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE))) {
> > > > > > >                 dev_err(dev, "Link frequency not supported: %lld\n",
> > > > > > >                         ep_cfg.link_frequencies[0]);
> > > > > > >                 goto error_out;
> > > > > > > @@ -1368,7 +1404,7 @@ static int imx219_probe(struct i2c_client *client)
> > > > > > >         v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> > > > > > >
> > > > > > >         /* Check the hardware configuration in device tree */
> > > > > > > -       if (imx219_check_hwcfg(dev))
> > > > > > > +       if (imx219_check_hwcfg(dev, imx219))
> > > > > > >                 return -EINVAL;
> > > > > > >
> > > > > > >         /* Get system clock (xclk) */
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
