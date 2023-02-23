Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B436A06D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjBWK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjBWK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:58:51 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C49740;
        Thu, 23 Feb 2023 02:58:49 -0800 (PST)
Received: from ideasonboard.com (host-87-16-53-160.retail.telecomitalia.it [87.16.53.160])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84A7C4DE;
        Thu, 23 Feb 2023 11:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1677149926;
        bh=ykZ6O0AnbceQWgdSWq/0czBCFAMEGPVFDYg0sfPzC3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgRFMMmDgBZA68w4BeUm4PB3UMouz8nrE4xJZ95Zhmp080fiW+ysN9PHonUqWUjzI
         31ZB0f+7At4L2miOxZcc98q9rt2ayPUJ0UBgO6Tx2M6x2vKRVITuXjZuKfBI4jLe2T
         giztLAVOND5z5sRRPBiK45Y/uTrjPrZqbUoFeLF0=
Date:   Thu, 23 Feb 2023 11:58:44 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
Message-ID: <20230223105844.cqhkxoypkl5v24h2@uno.localdomain>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <CAHCN7x+9E8qcBVOQZKTKagDkvkKVnqDtjvpNX-iNFYwCLRoYug@mail.gmail.com>
 <Y+1xCtdxIoPtnOws@pendragon.ideasonboard.com>
 <CAHCN7xLQ2+EuwByr_S9LJjPOtNJncDEHJmBkiLqfEdG4P7gTkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xLQ2+EuwByr_S9LJjPOtNJncDEHJmBkiLqfEdG4P7gTkw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam
   sorry to jump up without being involved in the conversation

On Sat, Feb 18, 2023 at 10:14:08AM -0600, Adam Ford wrote:
> On Wed, Feb 15, 2023 at 5:55 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Adam,
> >
> > On Wed, Feb 15, 2023 at 07:57:53AM -0600, Adam Ford wrote:
> > > On Fri, Nov 18, 2022 at 3:44 AM Paul Elder wrote:
> > >
> > > > This series depends on v3 of "dt-bindings: media: Add macros for video
> > > > interface bus types" [1].
> > > >
> > > > This series extends the rkisp1 driver to support the ISP found in the
> > > > NXP i.MX8MP SoC.
> > >
> > > I'm going to spend some time testing this over the weekend.  Is there a V4
> > > pending, or should I just test whatever is in Laurent's repo?
> >
> > I've updated all the v6.2-based branches on
> > https://gitlab.com/ideasonboard/nxp/linux.git (and renamed them to
> > v6.2/*). Beside a rebase, the v6.2/isp branch contains (at the bottom) 6
> > additional patches that I've previously posted to the linux-media
> > mailing list (feel free to review them ;-)).
>
> I grabbed your v6.2 series, and applied some updates to enable an
> imx219 camera and routed it through the ISP and configured the camera
> to SRGGB10_1X10/640x480 and had the ISP convert to YUYV8_2X8/640x480
> and it captured just fine.
>
> With that, I think you can add
>
> Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon
>
> I haven't experimented with the resizer yet,but  I did have some
> questions on the AWB.  The AWB appears to be available on the 8MP per
> the TRM, and  I see reference to AWB in the driver, but when I query
> the subdev via yavta, I didn't see anything obvious on how to enable
> it.  My pipeline (attached) shows klisp1_params as video2 and
> rkisp1_stats as video1.  I attempted to query both without much
> success.

As you might be aware there's no magic button to "turn AWB on". The
ISP enables the implementation of AWB algorithms that consumes the
statistics the ISP produces on the raw images it is fed with and
allows to program the color gains to realize colors balancing.

The implementation of such algorithms doesn't live in the driver but
rather in a separate component usually running in user space. With
libcamera we're creating a userspace camera stack where it is possible
to implement such algorithms, and the i.MX8MP is fairly well supported
by the "rkisp1" component.
https://git.libcamera.org/libcamera/libcamera.git/tree/src/libcamera/pipeline/rkisp1
https://git.libcamera.org/libcamera/libcamera.git/tree/src/ipa/rkisp1/algorithms

There's probably one single patch still out of tree in libcamera to flip
the switch and enable i.MX8MP support through the RkISP1 component.

If you're willing to give it a spin let me know and I can try
support you in testing it.


>
> root@beacon-imx8mp-kit:~# yavta -l /dev/video2
> Device /dev/video2 opened.
> Device `rkisp1_params' on `platform:rkisp1' (driver 'rkisp1') supports
> meta-data, output, without mplanes.
> unable to query control 0xc0000000: Inappropriate ioctl for device (25).
> Meta-data format: RK1P (50314b52) buffer size 3048
> root@beacon-imx8mp-kit:~# yavta -l /dev/video1
> Device /dev/video1 opened.
> Device `rkisp1_stats' on `platform:rkisp1' (driver 'rkisp1') supports
> meta-data, capture, without mplanes.
> unable to query control 0xc0000000: Inappropriate ioctl for device (25).
> Meta-data format: RK1S (53314b52) buffer size 260
> root@beacon-imx8mp-kit:~#
>
> Is there documentation somewhere on where to test the AWB?  This is of
> particular interest to me, because the RGGB format of the camera comes
> across with a green tint.  I am able to remove this green-ness on a
> different platform using some AWB on the ARM, but I'd rather do it in
> hardware if possible.
>
> Thanks
>
> adam
>
>
> >
> > My only concern with this series is with patch "media: rkisp1: Add match
> > data for i.MX8MP ISP", and in particular with the following hunk:
> >
> >  enum rkisp1_cif_isp_version {
> >         RKISP1_V10 = 10,
> >         RKISP1_V11,
> >         RKISP1_V12,
> >         RKISP1_V13,
> > +       IMX8MP_V10,
> >  };
> >
> > It's not a very nice versioning scheme :-S I'll see if I can find
> > something better, but regardless of that, I'll post v4 with the goal of
> > merging it in v6.4.
> >
> > > I have an IMX219 camera with 4-lane support and an i.MX8M Plus kit from
> > > Beacon, and I want to test the RGGB bayer conversion to see how well it
> > > works.
> > >
> > > > The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP1")
> > > > and in the NXP i.MX8MP have the same origin, and have slightly diverged
> > > > over time as they are now independently developed (afaik) by Rockchip
> > > > and VeriSilicon. The latter is marketed under the name "ISP8000Nano",
> > > > and is close enough to the RK3399 ISP that it can easily be supported by
> > > > the same driver.
> > >
> > > Is there a reason the driver cannot be renamed to a more generic name than
> > > rkisp1 if the Rockchip and VeriSilicon had similar origins?  Having the
> > > name Rockchip referenced from an NXP i.MX8M Plus seems odd to me.
> >
> > The common roots of the IP core predate both Rockchip and VeriSilicon.
> > Those two implementations have now diverged (as with all forks), so
> > either name would be wrong in some cases :-S
> >
> > > > The last two patches add support for UYVY output format, which can be
> > > > implemented on the ISP version in the i.MX8MP but not in the one in the
> > > > RK3399.
> > > >
> > > > This version of the series specifically has been tested on a Polyhex
> > > > Debix model A with an imx219 (Raspberry Pi cam v2).
> > > >
> > > > [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/
> > > >
> > > > Laurent Pinchart (3):
> > > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
> > > >   media: rkisp1: Add and use rkisp1_has_feature() macro
> > > >   media: rkisp1: Configure gasket on i.MX8MP
> > > >
> > > > Paul Elder (11):
> > > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
> > > >   media: rkisp1: Add match data for i.MX8MP ISP
> > > >   media: rkisp1: Add and set registers for crop for i.MX8MP
> > > >   media: rkisp1: Add and set registers for output size config on i.MX8MP
> > > >   media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
> > > >   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
> > > >   media: rkisp1: Add register definitions for the test pattern generator
> > > >   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
> > > >   media: rkisp1: Support devices without self path
> > > >   media: rkisp1: Add YC swap capability
> > > >   media: rkisp1: Add UYVY as an output format
> > > >
> > > >  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
> > > >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
> > > >  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
> > > >  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
> > > >  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
> > > >  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
> > > >  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
> > > >  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
> > > >  include/uapi/linux/rkisp1-config.h            |   2 +
> > > >  9 files changed, 509 insertions(+), 40 deletions(-)
> >
> > --
> > Regards,
> >
> > Laurent Pinchart


