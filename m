Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963C5E6020
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiIVKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVKnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:43:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D9AA358
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:43:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w28so12963152edi.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=M77z27YzoHva29g50eo0MmW6ov3kpDSkgNX8RUaZz24=;
        b=LMF5ySSYa/Qj5IKr07ythRHHbr4z5pcF3vCGB0uPOuVqQa+HA37deRxW/au5v7TG3p
         QHkRu2RaRLhNn7ENhVJ7ZjOt60ObyRY8zosbnGCtrMIv1F5zAVe2fzNbsRb6c6lxPRs/
         VC0OHCEKlGUBRK86RmpjxWhFmQafWPtHkRw8dmluIoS8wYy7oRsoe/+ND40n3aKfszE3
         q+ADWYfGDY4LKg4ICZY9RqOmMKTtKbvJcvSF7UvcwxxjFZecpoy45dofNht838BFmdRu
         Xm03dF/NxNCFGJ1DFzrQQCD/fsyo6zfVbmAadO51zxgBwHVHp5zLgAedFBjYoXtNyd9b
         kibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M77z27YzoHva29g50eo0MmW6ov3kpDSkgNX8RUaZz24=;
        b=Xc++UZXQ5EQFzcpmoTYrKghJmFM9Jakw0WKWxlWtpOOjlYGUAxa21sDjwSPFYodBuo
         cssXhnjJKi5ufDVpxO3+VBOIQKfWeFbTbgzmrCHTR3wIBzDjsJRLwTNZZecaMPpiUGDH
         RW8wwLNRuK/5y3PUxoOjzd4VN4SpqfrGIGtNYihZJd3liwmiWqxMtmVWZ8XoEILrPZid
         P2R2H+D2SDHIBP3eq/WJoOaUR0iHsGtMApocpgHn/hsV4sgK3cycobPNgJu0oA6WEGNP
         uqvb+z/btWjV5QVkvu7ocyu3cu/bMK6aLa/MAgn/2bme/9wtz7uFHAIf0wUlWn3P6wVj
         Tdfg==
X-Gm-Message-State: ACrzQf3XrbfP9ZuOcsw6Te0HmQ4f0+/0kLaJbauX4SZkEjBZ86RUfDFS
        p7v4hGQfCnk52xXrnLa0lrmJWgYvi9vDIBqasKxzDg==
X-Google-Smtp-Source: AMsMyM5Gk59rUXAPqkCR3ymGPxm/zOnlAZM2u6xAwmJhSmjTYY+cItxeUecq5NeMhcnq1GISbRzoOL5jYhGrY9URSu0=
X-Received: by 2002:a05:6402:5210:b0:451:d4ff:ab02 with SMTP id
 s16-20020a056402521000b00451d4ffab02mr2601116edd.345.1663843408745; Thu, 22
 Sep 2022 03:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220911200147.375198-1-mike.rudenko@gmail.com> <YywwqFi+2Nah2RpY@paasikivi.fi.intel.com>
In-Reply-To: <YywwqFi+2Nah2RpY@paasikivi.fi.intel.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 22 Sep 2022 11:43:14 +0100
Message-ID: <CAPY8ntAvos4Et4c5mAiw=6Wb4b53p2PLRX_Jw03bHckpD+e-sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail & Sakari

On Thu, 22 Sept 2022 at 10:55, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Mikhail,
>
> On Sun, Sep 11, 2022 at 11:01:33PM +0300, Mikhail Rudenko wrote:
> > Hello,
> >
> > this series implements support for Omnivision OV4689 image
> > sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> > megapixel image sensor. Ihis chip supports high frame rate speeds up
> > to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> > interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> > connection.
> >
> > The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CS=
I-2
> > and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> > 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.
> >
> > While porting the driver, I stumbled upon two issues:
> >
> > (1) In the original driver, horizontal total size (HTS) was set to a
> > value (2584) lower then the frame width (2688), resulting in negative
> > hblank. In this driver, I increased HTS to 2688, but fps dropped from
> > 29.88 to 28.73. What is the preferred way to handle this?
>
> If horizontal total size is less than the frame width, something is
> certainly wrong there. You can't have negative horizontal blanking. Neith=
er
> it can be zero.

Something certainly seems odd.

To continue my thoughts from earlier in this patch set, Omnivision's
Product Brief [1] states:
The 1/3-inch OV4689 can capture full-resolution 4-megapixel high
definition (HD) video at 90 frames per second (fps), 1080p HD at 120
fps, and binned 720p HD at 180 fps

The datasheet section 2.1 states:
The OV4689 color image sensor is a high performance, 4 megapixel RAW
image sensor that delivers 2688x1520 at 90 fps using OmniBSI-2=E2=84=A2 pix=
el
technology.

So 4MP 90fps or 1080p120 should be achievable somehow.

2688x1520 @ 90fps is 367.7MPix/s, and that tallies quite nicely with
table 2-9 listing the DAC PLL speed limitation of 360-378MHz. Exactly
how that is then converted into PCLK or SCLK is unclear.
Ideally you'd be able to contact an Omnivision FAE to confirm, but
that means you need to be buying modules directly from them or
otherwise have a business relationship.
I do note that there is an NVidia Tegra driver for OV4689 at [2]. I
wonder if analysis of that would reveal anything.

I have just been looking at the ov9282 driver and the timings don't
tally there either - configure it for 60fps and you get 30fps. The
TIMING_HTS register appears to be in units of 2 pixels. The default is
0x2d8 (728 decimal) on a 1280x720 mode, but consider it as units of 2
pixels and HTS of 1456 (1280 active and hblank of 176) does match up.
It works in the general case too.

Looking at the OV4689 datasheet again, the default for TIMING_HTS
(0x380c/d) is 0x5f8 (1528 decimal) when HOUTPUT_SIZE (0x3808/9) is
0x1200 (4608 decimal). Whilst there are no guarantees that default
register settings will stream in any sensible form, it does imply
TIMING_HTS is not in units of 1 pixel, and potentially 4 pixels.
From the Rockchip BSP driver it plainly does stream at 30 (or 29.88)
fps with TIMING_HTS < HOUTPUT_SIZE, so a quick test of reducing it
further would be worthwhile. What does the default of 0x2d8 give you
as a frame rate, and are the images correct?

Just some thoughts.
  Dave

[1] https://www.ovt.com/wp-content/uploads/2022/01/OV4689-PB-v1.7-WEB.pdf
[2] https://github.com/bogsen/STLinux-Kernel/blob/master/drivers/media/plat=
form/tegra/ov4689.c


> >
> > (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> > gain is not linear across that range. Instead, it is piecewise linear
> > (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> > 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> > with more linear segments in between. Rockchip's camera engine code
> > chooses one of the above segments depenging on the desired gain
> > value. The question is, how should we proceed keeping in mind
> > libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> > libcamera will do the mapping, or the driver will do the mapping
> > itself and expose some logical gain units not tied to the actual gain
> > register value? Meanwhile, this driver conservatively exposes only
> > 0x0-0xf8 gain register range.
>
> --
> Sakari Ailus
