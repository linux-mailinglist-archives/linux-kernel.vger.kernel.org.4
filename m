Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4A72E287
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbjFMMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:09:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C2E55;
        Tue, 13 Jun 2023 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686658140; x=1718194140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77JdOeqaLtpWVDtMAb1kf7q0hb1+drYDYzJGG71SUZM=;
  b=KASaKrNXdILRf4TSg1/spcXSkOnEAATqkrQ8bjTlYb/VahwkJbuHRaG9
   0caMP69SAC8OGnWi+1Vq4qrF3DLVS3S2/yODFpYsB4L0S/tdGtB6FiDYd
   HUWECmjpdJvOHoFzGPit3y4/ue+DZyna9HrQLK2Vy0MfTzl4jJvE9hGGd
   TDQNXY/gPy6UZpghXmvfBeg/cNceL88e7vLxqbsq0u/wkITSi8PVHF9iE
   6J4NuZ/x4RObNBP0c43VlO1R2/DE4B7NrLmy+2TcqoQKjfRU2G5CqzEQm
   FKH3pczcTHwV6L98Ext5PFFSj5zJpSFqBuZ5DgKoNGSiqecr3S6n+ATyG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="424194077"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="424194077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885823097"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="885823097"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:08:39 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 93DF111F76F;
        Tue, 13 Jun 2023 15:00:34 +0300 (EEST)
Date:   Tue, 13 Jun 2023 12:00:34 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tommaso Merciai <tomm.merciai@gmail.com>,
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
Message-ID: <ZIhaYk1v69Sp+Xqd@kekkonen.localdomain>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <20230529074018.GD25984@pendragon.ideasonboard.com>
 <ZHcd09f5wOKjQdHX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531113331.GC27043@pendragon.ideasonboard.com>
 <ZHjPyxColttdARQm@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230602043126.GM22609@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602043126.GM22609@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent, Tommaso,

On Fri, Jun 02, 2023 at 07:31:26AM +0300, Laurent Pinchart wrote:
> > > > > > diff --git a/drivers/media/i2c/alvium.c b/drivers/media/i2c/alvium.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..e77fb6bda64b
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/media/i2c/alvium.c
> > > > > > @@ -0,0 +1,3547 @@
> 
> [snip]
> 
> > > > > > +static int alvium_probe(struct i2c_client *client)
> > > > > > +{
> > > > > > +	struct device *dev = &client->dev;
> > > > > > +	struct v4l2_subdev *sd;
> > > > > > +	struct alvium_dev *alvium;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
> > > > > > +	if (!alvium)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	alvium->i2c_client = client;
> > > > > > +	ret = alvium_get_dt_data(alvium);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	mutex_init(&alvium->lock);
> > > > > > +
> > > > > > +	sd = &alvium->sd;
> > > > > > +
> > > > > > +	/* init alvium sd */
> > > > > > +	v4l2_i2c_subdev_init(sd, client, &alvium_subdev_ops);
> > > > > > +
> > > > > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS | V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > > > > +	alvium->pad.flags = MEDIA_PAD_FL_SOURCE;
> > > > > > +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
> > > > > > +	sd->entity.ops = &alvium_sd_media_ops;
> > > > > > +
> > > > > > +	ret = media_entity_pads_init(&sd->entity, 1, &alvium->pad);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	sd->dev = dev;
> > > > > > +
> > > > > > +	ret = alvium_power_on(alvium);
> > > > > 
> > > > > The driver should use runtime PM (with autosuspend), and power on/off in
> > > > > the .s_stream() handler.
> > > > 
> > > > Can we delay the pm implementation as a future patchset?
> > > > Alvium pm would be tricky (cause is the boot time of the camera)
> > > > and if is possible I want work on pm later.
> > > > Let me know. Thanks! :)
> > > 
> > > With autosuspend the camera can remain powered up between stream stop
> > > and stream start, if they happen quickly enough. An autosuspend delay of
> > > a few seconds is usually a good value. It should be fairly easy to
> > > implement runtime PM support, you just need to
> > > 
> > > - Call alvium_power_on() from the runtime PM resume handler and
> > >   alvium_power_off() from the runtime PM suspend handler.
> > > 
> > > - Call pm_runtime_resume_and_get() and stream on time, and
> > >   pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() at stream
> > >   stop time.
> > > 
> > > - Initialize runtime PM at probe time (and clean up at remove time).
> > >   There's a bit of boilerplate code needed to get that right, but it's
> > >   not difficult. You can copy it from the imx290 driver.
> > 
> > Back to you to clarify this point.
> > 
> > Plan as you suggest is handling pm of camera using external
> > regulator. Problem is that the boot time of the camera is around 5s.
> 
> 5s ? Ouch !!
> 
> This has two consequences:
> 
> - Just probing the camera would take 5s, which is insanely long.
> - There will be a 5s delay when starting video capture.
> 
> There's no 5s delay in the current code, so I assume things work fine
> because the power regulator is always on, and turned on 5s or more
> before the driver is loaded. That's pretty fragile.
> 
> That camera is clearly not a good fit for an embedded system that cares
> about power consumption and performance, but we still have to support
> it. The probe time issue isn't something we can fix, a 5s delay is
> required.
> 
> The stream start issue can be alleviated by keeping the camera on, or
> offering a way for userspace to turn it on ahead of stream start.
> Runtime PM autosuspend will help with the former, and I would push the
> autosuspend delay up as a result of the huge camera boot time. We don't
> have a good solution of the latter at the moment, it used to be that
> opening video nodes would power up the whole pipeline, but that has been
> dropped some time ago in V4L2. Another API extension for this kind of

And that was never a good solution.

> use cases would be useful I think. Sakari, any opinion ?

I'd approach this with autosuspend, but going forward we could research
adding an API for V4L2 sub-devices to access PM QoS. This way the device
could be powered down while the user would have a way to ensure resuming
the device wouldn't take excessively long.

-- 
Kind regards,

Sakari Ailus
