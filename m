Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE068781B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjBBJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjBBJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:01:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177A2D46;
        Thu,  2 Feb 2023 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675328485; x=1706864485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=za/ubQr/+93gCMuJJ1xC8ZQWhY/KbUwbbbwQt6HxEIc=;
  b=EOZnOQZ4fDhfVPi3dYTMZNjGYDR2Q7cSnKEayRSAl5g91SFY6LCnaIp9
   rTmgsV/P3UFQfjRe78fUsoo0ZPPx07lHuRsjuEpCvJOw9r7dnb83FhgNK
   TJdo6LZ6ene5/YkplBHUO1mtSIB8SPVfdTHDTi4cSiTM5kswH49eM0eHw
   iMtuDF5eeytekgYnaEhL7EB6gaDL/SrJYgEJhGyS4Kyz3u4Z63ob+Wcp7
   oFB+lW+D1sCHpV1zvITrRD3MFRRUMZ+IWrIGVncTWYsJ9Y6zPrTr7eHya
   gWMp/bs8Fntmw9yULbrSsUxsogW/mWyHIHFa226p89WgzeJ45C2fVdc69
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="330530292"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="330530292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:01:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="728775050"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="728775050"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:01:19 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E68591218DC;
        Thu,  2 Feb 2023 11:01:13 +0200 (EET)
Date:   Thu, 2 Feb 2023 11:01:13 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 2/2] media: i2c: add imx415 cmos image sensor driver
Message-ID: <Y9t72at49U97brb/@kekkonen.localdomain>
References: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
 <20230124060107.3922237-3-michael.riesch@wolfvision.net>
 <Y9EKqwfDSsF31dLZ@kekkonen.localdomain>
 <395807d3-e242-5779-5c6d-06d750357b8c@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395807d3-e242-5779-5c6d-06d750357b8c@wolfvision.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Jan 27, 2023 at 11:43:33AM +0100, Michael Riesch wrote:
> Hi Sakari,
> 
> Thanks for your review. The majority of your comments are clear, I'll
> spin a v3 next week. Just a few things:
> 
> On 1/25/23 11:55, Sakari Ailus wrote:
> > [...]
> >> +++ b/drivers/media/i2c/imx415.c
> >> @@ -0,0 +1,1296 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Driver for the Sony IMX415 CMOS Image Sensor.
> >> + *
> >> + * Copyright (C) 2022 WolfVision GmbH.
> > 
> > You can use 2023 now.
> 
> Time flies, doesn't it... :-)
> 
> > [...]
> >> +static int imx415_stream_on(struct imx415 *sensor)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = imx415_write(sensor, IMX415_MODE, IMX415_MODE_OPERATING);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* wait at least 24 ms for internal regulator stabilization */
> >> +	msleep(30);
> > 
> > This is a very, very long time to wait for a regulator. Most probably
> > either the time is too long or we're waiting for something else.
> 
> I just realized that both msleep calls are after setting the mode to
> operating, i.e., after getting the sensor out of standby. The other
> instance of this code (see below) documents that clearly, but this
> "regulator stabilization" comment here is seems wrong indeed.
> 
> >> +
> >> +	return imx415_write(sensor, IMX415_XMSTA, IMX415_XMSTA_START);
> >> +}
> >> [...]>> +static int imx415_subdev_init(struct imx415 *sensor)
> >> +{
> >> +	struct i2c_client *client = to_i2c_client(sensor->dev);
> >> +	int ret;
> >> +
> >> +	v4l2_i2c_subdev_init(&sensor->subdev, client, &imx415_subdev_ops);
> >> +
> >> +	ret = imx415_ctrls_init(sensor);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	sensor->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> > 
> > Add V4L2_SUBDEV_FL_HAS_EVENTS.
> 
> Just for my understanding: why is this required/a good idea?
> 
> >> [...]
> >> +static int imx415_identify_model(struct imx415 *sensor)
> >> +{
> >> +	int model, ret;
> >> +
> >> +	/*
> >> +	 * While most registers can be read when the sensor is in standby, this
> >> +	 * is not the case of the sensor info register :-(
> >> +	 */
> >> +	ret = imx415_write(sensor, IMX415_MODE, IMX415_MODE_OPERATING);
> >> +	if (ret < 0)
> >> +		return dev_err_probe(sensor->dev, ret,
> >> +				     "failed to get sensor out of standby\n");
> >> +
> >> +	/*
> >> +	 * According to the datasheet we have to wait at least 63 us after
> >> +	 * leaving standby mode. But this doesn't work even after 30 ms.
> >> +	 * So probably this should be 63 ms and therefore we wait for 80 ms.
> >> +	 */
> >> +	msleep(80);
> > 
> > Wow.
> 
> This is the other occurrence of this long sleep. We could refactor this
> code into a imx415_wakeup() method if desired. Otherwise, we need to
> align the sleep period and the explanation at least.

I'm ok with the code, it's just a very, very long delay.

-- 
Sakari Ailus
