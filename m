Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4A72E3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbjFMNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjFMNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:24:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C31AA;
        Tue, 13 Jun 2023 06:24:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec3bso4409405e9.2;
        Tue, 13 Jun 2023 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686662678; x=1689254678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XW9rh4jUldX1UD/nk0BgegxHJcL2wRG/tuF1MFv9Nc=;
        b=qmt3yPAItBp5Leswgr+iV8olSEMC29DPV49p+1DpTPn4HI+QdqTomAGa7LTX97VRfD
         U79hAQNmJAQipoFY3i2ZNhAk9J1LyPNcDlV1Q4rvzFMFrYIUy/p3W7OImFrgKE1FKS3b
         lQFbZwYxlRGSytAewkTIMHYqV5aIx7tJyXyI+uuXgI0d+zP36/yI+luh4bSu0bnnRSBE
         c4J6Kd3aBrRs4/wsuRkvnpDBwUIprjS7wAn3NrflPgyIAWWXw0lEbbg5v+ilL28P2Com
         jFzzy/thS7b0qfsn6NqnmIWjltvuecvfCowa8Ul6AC1kDTKG+6Beg9mgST0HjHYMiDTJ
         1VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662678; x=1689254678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XW9rh4jUldX1UD/nk0BgegxHJcL2wRG/tuF1MFv9Nc=;
        b=QQ20F7zMakV3/FUch9BYqIRaZu+dYWleEvTKv7o1EGaKJl8wBvyYFUn4vmWOQrH1Sz
         iTyGuv8acZSjdcuvdqXVgIPnUYJuqFhNSBetn3XVrCB7dRKoussYd5XETxgjDUhxZw62
         lp8448+xfvlNMCB3Y2MsQgYM6yANY0mgZbXR/0JD0pYzmHi+kjGtwcbPoB839hozOznS
         7No60pvqrseqMjWgpEiYlWTzZ0rQFjhoR9P01iu2TDKkuF7rw20kIY3gs3DgTkLYB0Zx
         T2vevGk/L84kwOfR/3tt20Nt6V7IQ3/TmGfXFNKiHG9I2Rit04ZacTCWeh1XfFjxsp1M
         eIOw==
X-Gm-Message-State: AC+VfDw9PN78H9NWWTweBC4aRJE77WmeXweMbXoN+89xCb1dGRAD1biq
        iH/aJk4TB9zsfe+fYdMLZAQ=
X-Google-Smtp-Source: ACHHUZ4ZArX1XRPgz5kr7OpNljmKS21m1ctlMDTCGRb52v2HpifiBaaxnMNFu9qpPCrRm7/KNUx/4A==
X-Received: by 2002:a1c:7906:0:b0:3f7:f2d0:b904 with SMTP id l6-20020a1c7906000000b003f7f2d0b904mr10595351wme.8.1686662678012;
        Tue, 13 Jun 2023 06:24:38 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (mob-5-90-65-61.net.vodafone.it. [5.90.65.61])
        by smtp.gmail.com with ESMTPSA id t11-20020a7bc3cb000000b003f60eb72cf5sm14542378wmj.2.2023.06.13.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:24:37 -0700 (PDT)
Date:   Tue, 13 Jun 2023 15:24:33 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Message-ID: <ZIhuEcUGdK4spvoy@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <20230529074018.GD25984@pendragon.ideasonboard.com>
 <ZHcd09f5wOKjQdHX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531113331.GC27043@pendragon.ideasonboard.com>
 <ZHjPyxColttdARQm@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230602043126.GM22609@pendragon.ideasonboard.com>
 <ZIhaYk1v69Sp+Xqd@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIhaYk1v69Sp+Xqd@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari, Laurent,


On Tue, Jun 13, 2023 at 12:00:34PM +0000, Sakari Ailus wrote:
> Hi Laurent, Tommaso,
> 
> On Fri, Jun 02, 2023 at 07:31:26AM +0300, Laurent Pinchart wrote:
> > > > > > > diff --git a/drivers/media/i2c/alvium.c b/drivers/media/i2c/alvium.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..e77fb6bda64b
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/media/i2c/alvium.c
> > > > > > > @@ -0,0 +1,3547 @@
> > 
> > [snip]
> > 
> > > > > > > +static int alvium_probe(struct i2c_client *client)
> > > > > > > +{
> > > > > > > +	struct device *dev = &client->dev;
> > > > > > > +	struct v4l2_subdev *sd;
> > > > > > > +	struct alvium_dev *alvium;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
> > > > > > > +	if (!alvium)
> > > > > > > +		return -ENOMEM;
> > > > > > > +
> > > > > > > +	alvium->i2c_client = client;
> > > > > > > +	ret = alvium_get_dt_data(alvium);
> > > > > > > +	if (ret)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	mutex_init(&alvium->lock);
> > > > > > > +
> > > > > > > +	sd = &alvium->sd;
> > > > > > > +
> > > > > > > +	/* init alvium sd */
> > > > > > > +	v4l2_i2c_subdev_init(sd, client, &alvium_subdev_ops);
> > > > > > > +
> > > > > > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS | V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > > > > > +	alvium->pad.flags = MEDIA_PAD_FL_SOURCE;
> > > > > > > +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
> > > > > > > +	sd->entity.ops = &alvium_sd_media_ops;
> > > > > > > +
> > > > > > > +	ret = media_entity_pads_init(&sd->entity, 1, &alvium->pad);
> > > > > > > +	if (ret)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	sd->dev = dev;
> > > > > > > +
> > > > > > > +	ret = alvium_power_on(alvium);
> > > > > > 
> > > > > > The driver should use runtime PM (with autosuspend), and power on/off in
> > > > > > the .s_stream() handler.
> > > > > 
> > > > > Can we delay the pm implementation as a future patchset?
> > > > > Alvium pm would be tricky (cause is the boot time of the camera)
> > > > > and if is possible I want work on pm later.
> > > > > Let me know. Thanks! :)
> > > > 
> > > > With autosuspend the camera can remain powered up between stream stop
> > > > and stream start, if they happen quickly enough. An autosuspend delay of
> > > > a few seconds is usually a good value. It should be fairly easy to
> > > > implement runtime PM support, you just need to
> > > > 
> > > > - Call alvium_power_on() from the runtime PM resume handler and
> > > >   alvium_power_off() from the runtime PM suspend handler.
> > > > 
> > > > - Call pm_runtime_resume_and_get() and stream on time, and
> > > >   pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() at stream
> > > >   stop time.
> > > > 
> > > > - Initialize runtime PM at probe time (and clean up at remove time).
> > > >   There's a bit of boilerplate code needed to get that right, but it's
> > > >   not difficult. You can copy it from the imx290 driver.
> > > 
> > > Back to you to clarify this point.
> > > 
> > > Plan as you suggest is handling pm of camera using external
> > > regulator. Problem is that the boot time of the camera is around 5s.
> > 
> > 5s ? Ouch !!
> > 
> > This has two consequences:
> > 
> > - Just probing the camera would take 5s, which is insanely long.
> > - There will be a 5s delay when starting video capture.
> > 
> > There's no 5s delay in the current code, so I assume things work fine
> > because the power regulator is always on, and turned on 5s or more
> > before the driver is loaded. That's pretty fragile.
> > 
> > That camera is clearly not a good fit for an embedded system that cares
> > about power consumption and performance, but we still have to support
> > it. The probe time issue isn't something we can fix, a 5s delay is
> > required.
> > 
> > The stream start issue can be alleviated by keeping the camera on, or
> > offering a way for userspace to turn it on ahead of stream start.
> > Runtime PM autosuspend will help with the former, and I would push the
> > autosuspend delay up as a result of the huge camera boot time. We don't
> > have a good solution of the latter at the moment, it used to be that
> > opening video nodes would power up the whole pipeline, but that has been
> > dropped some time ago in V4L2. Another API extension for this kind of
> 
> And that was never a good solution.
> 
> > use cases would be useful I think. Sakari, any opinion ?

:'(

> 
> I'd approach this with autosuspend, but going forward we could research
> adding an API for V4L2 sub-devices to access PM QoS. This way the device
> could be powered down while the user would have a way to ensure resuming
> the device wouldn't take excessively long.

What's the plan? :)

I test regulator/pm implementation in v5
Take your time to check that.

(I'm waiting for your feedback on some questions on
first review of v5) :)

If you have better ideas to handle this
very long boot time please don't esitate to share
with me. I can test on my side.

In my opinion using regulator and skipping power up
if regulator is already enabled as suggested by Laurent,
is not a so bad idea :)

Tests on the real hw are giving good results.

Let me know. Many thanks!

Regards,
Tommaso

> 
> -- 
> Kind regards,
> 
> Sakari Ailus
