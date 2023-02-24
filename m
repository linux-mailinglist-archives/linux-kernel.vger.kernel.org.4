Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE626A21B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjBXSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:46:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6CE6C8C4;
        Fri, 24 Feb 2023 10:46:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h14so400233plf.10;
        Fri, 24 Feb 2023 10:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to5vJVxEp0UU32rm0NGYCVyewKbZkeSc8N7b2X1iLhs=;
        b=nfYgA9jRzJx/597NvPlFV9Pog9qINZw558UyOkf4awrgHVJl/Ggavt0HjvMRQGjAbj
         zkNYDoff/FGVR7gyw2rwbBIMw6O5hMaS/7X9AC47yEerv9RfgWuHeCXFX3W595R6V+dB
         i8tkOPah2yDQnu4Xxioz9NqAkE/MjInES6Mq9sdGdfK5MK/pnHxvzNV5i1DoEf2Pkdri
         IuVL4wATAKMF6ZnGzQVdD4PkJol+Gno4O4plWRE54KcbBzwZjDEHksGkuz6iAZY9Ipqk
         iDl+SpVX7Zo2693368Z+m9Qrdyxf7aBt6/k0FuBPPNlTEgKL7PqUwCkBs4uaylwxuNH3
         fvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to5vJVxEp0UU32rm0NGYCVyewKbZkeSc8N7b2X1iLhs=;
        b=BgAlwzf0znJigOyUIY4SJ5gbVNTr2awF+oDo4ZVcelh/iIhYuHKsFBHQROco0NEwjZ
         DxpInzR71AmDzG2iWgrtO9aS/0LfpS6W+LEk+0xpQKVNdTSpkdCYWxkhbKD2f8WHlXid
         CCdv5Lbi/BfXcAg2wb657eMFzDJufdJVfjwDaqf8JcOFHAaPhOEU2BRlVLBpZywG8O6w
         TZFe2ITjOY47EXuuTA69q73UVtPraulElMa8yhn/94a1EESrTvMffJcjVwgt7GuBpjqk
         68OmN8Klo6LjIn9sJEk41icn73wDZEf4COax2c/RwMikA5pDO4ohx0Z9Z9NgQxotViB2
         c4EA==
X-Gm-Message-State: AO0yUKXlC4Y250jQw/BPUYJ/YFIrt815Ajmn46hL4tJHpnXdwSFvqlpW
        HgKcmZUDfta8D+smvll5ojS7kBvZ+Mhr2NlgjrI=
X-Google-Smtp-Source: AK7set9iHR8Vdy2GATvmM/SKxy2TO8YELkPlohM9CVMoNTmh121KKUWOGl/AjQPID8gP029RMY99o9gCLY6sGw4tXPU=
X-Received: by 2002:a17:90a:db86:b0:234:13f7:b6b0 with SMTP id
 h6-20020a17090adb8600b0023413f7b6b0mr2096550pjv.6.1677264411323; Fri, 24 Feb
 2023 10:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <CAHCN7xKbL+g5ZaPe3a50fUEe4AU3a6asCqWFSE8d7DCzWZO=qg@mail.gmail.com>
 <Y/d3m78NgmuuXOH8@pendragon.ideasonboard.com> <CAHCN7xLXz4iSKcTQgyW=E0c4eLZSAYAiuoTKpQBWz8GsfZ2GCA@mail.gmail.com>
 <12dfd1f511d83bb1a3d9924cb0d09dbba626a699.camel@ndufresne.ca>
In-Reply-To: <12dfd1f511d83bb1a3d9924cb0d09dbba626a699.camel@ndufresne.ca>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 24 Feb 2023 12:46:39 -0600
Message-ID: <CAHCN7xJZjhvjejuMhtewVMvFVijzi8VdyFiGKCvpx3C0MGLjqA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:24 PM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Hi Adam,
>
> Le jeudi 23 f=C3=A9vrier 2023 =C3=A0 10:10 -0600, Adam Ford a =C3=A9crit =
:
> > On Thu, Feb 23, 2023 at 8:26 AM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Wed, Feb 22, 2023 at 05:39:30PM -0600, Adam Ford wrote:
> > > > On Fri, Nov 18, 2022 at 3:44 AM Paul Elder wrote:
> > > > >
> > > > > This series depends on v3 of "dt-bindings: media: Add macros for =
video
> > > > > interface bus types" [1].
> > > > >
> > > > > This series extends the rkisp1 driver to support the ISP found in=
 the
> > > > > NXP i.MX8MP SoC.
> > > > >
> > > > > The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip I=
SP1")
> > > > > and in the NXP i.MX8MP have the same origin, and have slightly di=
verged
> > > > > over time as they are now independently developed (afaik) by Rock=
chip
> > > > > and VeriSilicon. The latter is marketed under the name "ISP8000Na=
no",
> > > > > and is close enough to the RK3399 ISP that it can easily be suppo=
rted by
> > > > > the same driver.
> > > > >
> > > > > The last two patches add support for UYVY output format, which ca=
n be
> > > > > implemented on the ISP version in the i.MX8MP but not in the one =
in the
> > > > > RK3399.
> > > > >
> > > > > This version of the series specifically has been tested on a Poly=
hex
> > > > > Debix model A with an imx219 (Raspberry Pi cam v2).
> > > > >
> > > > > [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-la=
urent.pinchart@ideasonboard.com/
> > > > >
> > > > > Laurent Pinchart (3):
> > > > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
> > > > >   media: rkisp1: Add and use rkisp1_has_feature() macro
> > > > >   media: rkisp1: Configure gasket on i.MX8MP
> > > > >
> > > > > Paul Elder (11):
> > > > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
> > > > >   media: rkisp1: Add match data for i.MX8MP ISP
> > > > >   media: rkisp1: Add and set registers for crop for i.MX8MP
> > > > >   media: rkisp1: Add and set registers for output size config on =
i.MX8MP
> > > > >   media: rkisp1: Add i.MX8MP-specific registers for MI and resize=
r
> > > > >   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
> > > > >   media: rkisp1: Add register definitions for the test pattern ge=
nerator
> > > > >   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
> > > > >   media: rkisp1: Support devices without self path
> > > > >   media: rkisp1: Add YC swap capability
> > > > >   media: rkisp1: Add UYVY as an output format
> > > >
> > > > Paul / Laurent,
> > > >
> > > > I noticed an unexpected behaviour on the imx8mp.
> > > >
> > > > If I setup my pipeline for 640x480, it works just fine using an imx=
219
> > > > camera configured for SRGGB10_1X10.
> > > >
> > > > However, when I try to configure the pipeline to use the same camer=
a
> > > > at 1920x1080 (no resizing), the ISP source keeps defaulting to 640x=
480
> > > >
> > > > Media device information
> > > > ------------------------
> > > > driver          rkisp1
> > > > model           rkisp1
> > > > serial
> > > > bus info        platform:rkisp1
> > > > hw revision     0xe
> > > > driver version  6.2.0
> > > >
> > > > Device topology
> > > > - entity 1: rkisp1_isp (4 pads, 4 links)
> > > >             type V4L2 subdev subtype Unknown flags 0
> > > >             device node name /dev/v4l-subdev0
> > > > pad0: Sink [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xf=
er:none ycbcr:601 quantization:full-range crop.bounds:(0,0)/1920x1080 crop:=
(0,0)/640x480]
> > >
> > > You're cropping the image to 640x480 here. You need to set the crop
> > > rectangle to 1920x1080.
> > >
> > > As Jacopo mentioned, I wouldn't recommend exercising the ISP directly=
.
> > > Not only do you need to setup the pipeline, but you would also need t=
o
> > > implement all the imaging algorithms in userspace. libcamera will do =
all
> > > this for you.
> >
> > I'll give that a try.  My current employer has a v4l2src requirement,
> > but I can likely make an argument to switch to libcamera.  I didn't
> > catch the cropping part. Thanks for that.
>
> I'd hope you can transparently replace v4l2src with libcamerasrc, the plu=
gins
> currently lives inside the libcamera project. If not, I'd really like to =
know
> why. We can work together on adding missing controls (this is something I=
'm
> starting on soon).

I plan to give it a try.  From what I've read it appears to be the
right thing to do.  I just need to carve out some time to get it
installed.  I mostly wanted to check out a camera adapter board my
company made, test some updates I pushed for the imx219 on a second
platform, and get more familiar with the ISP on the 8MP.

I'll open a separate thread if I have questions on the cameralib.
Thanks for all the feedback.  I look forward to seeing this driver
merged.

adam
>
> regards,
> Nicolas
>
> >
> > adam
> > >
> > > > <- "csis-32e40000.csi":1 [ENABLED]
> > > > pad1: Sink [fmt:unknown/0x0 field:none]
> > > > <- "rkisp1_params":0 [ENABLED,IMMUTABLE]
> > > > pad2: Source [fmt:YUYV8_2X8/640x480 field:none colorspace:raw xfer:=
none ycbcr:601 quantization:lim-range crop.bounds:(0,0)/640x480 crop:(0,0)/=
640x480]
> > > > -> "rkisp1_resizer_mainpath":0 [ENABLED]
> > > > pad3: Source [fmt:unknown/0x0 field:none]
> > > > -> "rkisp1_stats":0 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 6: rkisp1_resizer_mainpath (2 pads, 2 links)
> > > >             type V4L2 subdev subtype Unknown flags 0
> > > >             device node name /dev/v4l-subdev1
> > > > pad0: Sink [fmt:YUYV8_2X8/1920x1080 field:none colorspace:srgb xfer=
:srgb ycbcr:601 quantization:lim-range crop.bounds:(0,0)/1920x1080 crop:(0,=
0)/640x480]
> > > > <- "rkisp1_isp":2 [ENABLED]
> > > > pad1: Source [fmt:YUYV8_2X8/1920x1080 field:none colorspace:srgb xf=
er:srgb ycbcr:601 quantization:lim-range]
> > > > -> "rkisp1_mainpath":0 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 9: rkisp1_mainpath (1 pad, 1 link)
> > > >             type Node subtype V4L flags 0
> > > >             device node name /dev/video0
> > > > pad0: Sink
> > > > <- "rkisp1_resizer_mainpath":1 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 13: rkisp1_stats (1 pad, 1 link)
> > > >              type Node subtype V4L flags 0
> > > >              device node name /dev/video1
> > > > pad0: Sink
> > > > <- "rkisp1_isp":3 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 17: rkisp1_params (1 pad, 1 link)
> > > >              type Node subtype V4L flags 0
> > > >              device node name /dev/video2
> > > > pad0: Source
> > > > -> "rkisp1_isp":1 [ENABLED,IMMUTABLE]
> > > >
> > > > - entity 29: csis-32e40000.csi (2 pads, 2 links)
> > > >              type V4L2 subdev subtype Unknown flags 0
> > > >              device node name /dev/v4l-subdev2
> > > > pad0: Sink [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb x=
fer:srgb ycbcr:601 quantization:full-range]
> > > > <- "imx219 1-0010":0 [ENABLED]
> > > > pad1: Source [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb=
 xfer:srgb ycbcr:601 quantization:full-range]
> > > > -> "rkisp1_isp":0 [ENABLED]
> > > >
> > > > - entity 34: imx219 1-0010 (1 pad, 1 link)
> > > >              type V4L2 subdev subtype Sensor flags 0
> > > >              device node name /dev/v4l-subdev3
> > > > pad0: Source [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb=
 xfer:srgb ycbcr:601 quantization:full-range crop.bounds:(8,8)/3280x2464 cr=
op:(688,700)/1920x1080]
> > > > -> "csis-32e40000.csi":0 [ENABLED]
> > > >
> > > > It's at this point that everything except the ISP source is 1920x10=
80.
> > > >
> > > > When I try to set the ISP sink to 1080, it ends up being 640x480 an=
d
> > > > the resizer sink is also changed to 640x480
> > > >
> > > > root@beacon-imx8mp-kit:~# media-ctl -v -V "'rkisp1_isp':2
> > > > [fmt:YUYV8_2X8/1920x1080 field:none]"
> > > > Opening media device /dev/media0
> > > > Enumerating entities
> > > > looking up device: 81:3
> > > > looking up device: 81:4
> > > > looking up device: 81:0
> > > > looking up device: 81:1
> > > > looking up device: 81:2
> > > > looking up device: 81:5
> > > > looking up device: 81:6
> > > > Found 7 entities
> > > > Enumerating pads and links
> > > > Setting up format YUYV8_2X8 1920x1080 on pad rkisp1_isp/2
> > > > Format set: YUYV8_2X8 640x480
> > > > Setting up format YUYV8_2X8 640x480 on pad rkisp1_resizer_mainpath/=
0
> > > > Format set: YUYV8_2X8 640x480
> > > >
> > > >
> > > > It's my understanding that the ISP should be able to handle 1920x10=
80,
> > > > and the resizer sink should match the ISP source.
> > > >
> > > > With the pipeline improperly setup, the capture fails.
> > > >
> > > > >  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
> > > > >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++-=
--
> > > > >  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
> > > > >  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
> > > > >  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
> > > > >  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 ++++++++++++=
+++++-
> > > > >  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
> > > > >  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
> > > > >  include/uapi/linux/rkisp1-config.h            |   2 +
> > > > >  9 files changed, 509 insertions(+), 40 deletions(-)
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
>
