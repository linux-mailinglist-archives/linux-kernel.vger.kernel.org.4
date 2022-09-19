Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF635BC2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiISGkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiISGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:40:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3FFDFF5;
        Sun, 18 Sep 2022 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663569620; x=1695105620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGdzPuF+v42yf4zDqtPQbfbq7myqGLMKpQb0RUChj4o=;
  b=fL2DfV8ar0StJiGUsHCNINxpXR/7C7Dpa3Z1gzTFdDrWaUK9WSfAs4fG
   AReeJutHFRl8YYYidbjEHQQlPOpdWhFexSx/M6CC/+R1x8pvRQ2FsmZQw
   NmM7QlfwdxfoA98O/WHifsmDLXD37O1ITMfPB+juNd4yrQX4c5XUbH6b4
   2axtIYXw1NjrPirntFJEh3/0vXFnqliFGpaY+RfacCTwLjucE29xVxaXC
   kGD4fyH0y48qF+ZicFGu/yiLWOtnkD2Lr0QZ01vHnYd06eDf6lV6iXvg5
   f48ux/Wm8Nuie2dNStVeu73mXMNA03lz5ocxHjnk66VsS4uH3xN/e5fhg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="296911154"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="296911154"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:40:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="620739375"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:40:15 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 0791020078;
        Mon, 19 Sep 2022 09:40:13 +0300 (EEST)
Date:   Mon, 19 Sep 2022 06:40:13 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Message-ID: <YygOzWAHyoP+KwTv@paasikivi.fi.intel.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <CAPY8ntCA3jbpBOiNfoft58sHPeTFSLoLop0VUmkOCWP3cX_rdw@mail.gmail.com>
 <87czbwp9xx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czbwp9xx.fsf@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Fri, Sep 16, 2022 at 12:27:42AM +0300, Mikhail Rudenko wrote:
> 
> Hi Dave,
> 
> On 2022-09-14 at 10:58 +01, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:
> > Hi Mikhail
> >
> > On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> this series implements support for Omnivision OV4689 image
> >> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> >> megapixel image sensor. Ihis chip supports high frame rate speeds up
> >> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> >> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> >> connection.
> >>
> >> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
> >> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> >> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.
> >>
> >> While porting the driver, I stumbled upon two issues:
> >>
> >> (1) In the original driver, horizontal total size (HTS) was set to a
> >> value (2584) lower then the frame width (2688), resulting in negative
> >> hblank. In this driver, I increased HTS to 2688, but fps dropped from
> >> 29.88 to 28.73. What is the preferred way to handle this?
> >
> > This is one of the joys of sensors - they don't all work in the same way.
> >
> > I don't have an official datasheet for OV4689 from Omnivision, but
> > found one on the internet [1]. That should allow you to reverse the
> > PLL configuration to confirm that the pixel rate is the value you've
> > computed based on link frequency (they aren't necessarily related). Do
> > the frame rate calculations work using width + HBLANK, height +
> > VBLANK, and pixel rate?
> > The datasheet claims the sensor supports 2688x1520 @ 90 fps, so
> > something doesn't hold true between 4 data lanes at 500MHz/1Gbit/s per
> > lane when your default hts/vts is 2688x1554 and it only gives
> > 28.73fps.
> 
> Seems like those 90 fps is about CSI throughput, not actual sensor
> performance. I've checked the datasheet and the register values, and it
> seems like the pixel clock is 126 Mhz in this configuration (the maximum
> is 150 MHz according to the datasheet). This corresponds to a
> theoretical fps of 30.16 at hts=2688 and vts=1554. At the same time the
> observed fps is 28.73. I'm not sure where those 1.43 frames are lost,
> hope to do more experimentation with VTS and HTS over the weekend.
> 
> > I have seen modes in sensors where the HTS register is in units of 2
> > pixels, so what range of HTS (and VTS) values actually works on this
> > sensor? (I don't see it documented, but I'm not surprised).
> >
> > [1] https://cdn.hackaday.io/files/19354828041536/OV4689-OmniVision.pdf
> >
> >> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> >> gain is not linear across that range. Instead, it is piecewise linear
> >> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> >> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> >> with more linear segments in between. Rockchip's camera engine code
> >> chooses one of the above segments depenging on the desired gain
> >> value. The question is, how should we proceed keeping in mind
> >> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> >> libcamera will do the mapping, or the driver will do the mapping
> >> itself and expose some logical gain units not tied to the actual gain
> >> register value? Meanwhile, this driver conservatively exposes only
> >> 0x0-0xf8 gain register range.
> >
> > The datasheet linked above says "for the gain formula, please contact
> > your local OmniVision FAE" :-(
> > I would assume that the range is from 1x rather than 0x - people
> > rarely want a totally black image that 0x would give. Or is it ranges
> > of 1x - 2x, 2x - 4x, 4x - 8x, and 8x - 16x?
> 
> A picture is worth a thousand words, so I've attached the results of my
> experimentation with the gain register. They were obtained with Rockchip
> 3399, with AEC, AGC and black level subtraction disabled. The image was
> converted from 10-bit RGGB to 8-bit YUV 4:2:0 by the Rockchip ISP.

Based on that it looks like their medication may have been a little too
strong.

Could this be implemented so that the control value would be linear linear
but its range would correspond 1x--16x values?

libcamera will be able to cope with that.

> 
> > Other sensors expose the full range of the register via
> > V4L2_CID_ANALOGUE_GAIN, and require userspace (mainly libcamera now)
> > to know how to convert a gain into the register value. If the gain
> > range goes up to x16, then exposing that would be useful. I'd advocate
> > just exposing the full range of 0x000 - 0x7ff, as then you can have
> > the accuracy of 256 values between x1 to x2, but also the full range.
> 
> I also like this approach, although libcamera's CameraSensorHelper
> doesn't support piecewise-linear gain code mapping yet. Nevertheless,
> I believe exposing the full range is a good idea and will do so in v3.
> 
> > I might see if I can pick up one of these sensors and see if I can get
> > it running on a Raspberry Pi. Thanks for trying to upstream this -
> > it's nice to have such a range of sensor drivers to choose from.
> >
> >   Dave
> >
> 
> Thanks for your elucidating tips!
> 
> --
> Best regards,
> Mikhail Rudenko
> 



-- 
Sakari Ailus
