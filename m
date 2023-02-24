Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617126A2166
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBXSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBXSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:25:03 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8762E0E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:24:51 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z6so422996qtv.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Fnp0ba5VhlafZVccT2w5j+DOMmZOJytBGzATXCfRD8=;
        b=gsy94FmB/yD5akZbWO1RHmsYnY7jOABYlgOtGW+dqfUo/RJ/YocCQi3PyiDgw406OM
         8e5J52NEppx0L0S8P0f27OoShbCoRqvnxPSn/kw10Z8xHHzcOo8j8P2vn5OQl2O0KIkN
         241S97+5XB5fzrWsuBQ1o6mMXWmLhmC/HvafwEjrzMgg8IMBoNgxCg37s3kuKriuZBsO
         FI4v+9INha/6ABRTN8iSBytExs9NpvTFcu/zP4YT/7o2JAazVcZ34wSG0mF8l/gWiNhi
         9uzZw1hLZ7R+uTmuhWg0+FGk7fCWctkGz0vBw6mKs7BvCMp3ke3eg66DI0aLgO6JyS+7
         2epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Fnp0ba5VhlafZVccT2w5j+DOMmZOJytBGzATXCfRD8=;
        b=X2V4vY0a4SS9Ju9JrcBMAmQGMbOZx6PH1sfpkZu2JpWKdKr6e1wTfPDiPgFSnnSKpO
         cb7tQ6cn3+xJNwLmqTcz869vxBmgz8gMAjSRNSjNcXON3cP4FpYYas6J7Toh8Lr1psEB
         QolfyJMa/mi8sBIqXhZRgylQ+9JL04bNFKra7JUNsnZs+d7S/TgQGS51CXYlcJt0fChI
         82x4A3CkGwop06dyc/QBWJ9kNB255AHHigwoamgdhvn+z4O5PB06VFHjzbVzdOMOUaWG
         vXOmRdbfRgLSkpqCpf3UlLybrJpk9TlE/5kwnsDIc7D5TtjCksGjRK7UkmtQXYqGBHYT
         juAQ==
X-Gm-Message-State: AO0yUKUCZFu+U27T+Kx8SZzjI/AO2TymqJ4cTicIOMcl7c88jSIaICF1
        V4ekyIggqzBFkZUVbZQzz+07Dw==
X-Google-Smtp-Source: AK7set/BeRHe9RXAinrBHWyLkkp50J5q+OBYt4CtP9mCl04Us2eZ1g2ISTz8oiIeu+G+p4iRan5NbQ==
X-Received: by 2002:ac8:5f86:0:b0:3bf:a461:e6df with SMTP id j6-20020ac85f86000000b003bfa461e6dfmr23199359qta.25.1677263090595;
        Fri, 24 Feb 2023 10:24:50 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id x14-20020ac8018e000000b003bfaae103f6sm5340400qtf.89.2023.02.24.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:24:49 -0800 (PST)
Message-ID: <12dfd1f511d83bb1a3d9924cb0d09dbba626a699.camel@ndufresne.ca>
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Feb 2023 13:24:48 -0500
In-Reply-To: <CAHCN7xLXz4iSKcTQgyW=E0c4eLZSAYAiuoTKpQBWz8GsfZ2GCA@mail.gmail.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
         <CAHCN7xKbL+g5ZaPe3a50fUEe4AU3a6asCqWFSE8d7DCzWZO=qg@mail.gmail.com>
         <Y/d3m78NgmuuXOH8@pendragon.ideasonboard.com>
         <CAHCN7xLXz4iSKcTQgyW=E0c4eLZSAYAiuoTKpQBWz8GsfZ2GCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Le jeudi 23 f=C3=A9vrier 2023 =C3=A0 10:10 -0600, Adam Ford a =C3=A9crit=C2=
=A0:
> On Thu, Feb 23, 2023 at 8:26 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >=20
> > Hi Adam,
> >=20
> > On Wed, Feb 22, 2023 at 05:39:30PM -0600, Adam Ford wrote:
> > > On Fri, Nov 18, 2022 at 3:44 AM Paul Elder wrote:
> > > >=20
> > > > This series depends on v3 of "dt-bindings: media: Add macros for vi=
deo
> > > > interface bus types" [1].
> > > >=20
> > > > This series extends the rkisp1 driver to support the ISP found in t=
he
> > > > NXP i.MX8MP SoC.
> > > >=20
> > > > The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP=
1")
> > > > and in the NXP i.MX8MP have the same origin, and have slightly dive=
rged
> > > > over time as they are now independently developed (afaik) by Rockch=
ip
> > > > and VeriSilicon. The latter is marketed under the name "ISP8000Nano=
",
> > > > and is close enough to the RK3399 ISP that it can easily be support=
ed by
> > > > the same driver.
> > > >=20
> > > > The last two patches add support for UYVY output format, which can =
be
> > > > implemented on the ISP version in the i.MX8MP but not in the one in=
 the
> > > > RK3399.
> > > >=20
> > > > This version of the series specifically has been tested on a Polyhe=
x
> > > > Debix model A with an imx219 (Raspberry Pi cam v2).
> > > >=20
> > > > [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laur=
ent.pinchart@ideasonboard.com/
> > > >=20
> > > > Laurent Pinchart (3):
> > > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
> > > >   media: rkisp1: Add and use rkisp1_has_feature() macro
> > > >   media: rkisp1: Configure gasket on i.MX8MP
> > > >=20
> > > > Paul Elder (11):
> > > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
> > > >   media: rkisp1: Add match data for i.MX8MP ISP
> > > >   media: rkisp1: Add and set registers for crop for i.MX8MP
> > > >   media: rkisp1: Add and set registers for output size config on i.=
MX8MP
> > > >   media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
> > > >   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
> > > >   media: rkisp1: Add register definitions for the test pattern gene=
rator
> > > >   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
> > > >   media: rkisp1: Support devices without self path
> > > >   media: rkisp1: Add YC swap capability
> > > >   media: rkisp1: Add UYVY as an output format
> > >=20
> > > Paul / Laurent,
> > >=20
> > > I noticed an unexpected behaviour on the imx8mp.
> > >=20
> > > If I setup my pipeline for 640x480, it works just fine using an imx21=
9
> > > camera configured for SRGGB10_1X10.
> > >=20
> > > However, when I try to configure the pipeline to use the same camera
> > > at 1920x1080 (no resizing), the ISP source keeps defaulting to 640x48=
0
> > >=20
> > > Media device information
> > > ------------------------
> > > driver          rkisp1
> > > model           rkisp1
> > > serial
> > > bus info        platform:rkisp1
> > > hw revision     0xe
> > > driver version  6.2.0
> > >=20
> > > Device topology
> > > - entity 1: rkisp1_isp (4 pads, 4 links)
> > >             type V4L2 subdev subtype Unknown flags 0
> > >             device node name /dev/v4l-subdev0
> > > pad0: Sink [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xfer=
:none ycbcr:601 quantization:full-range crop.bounds:(0,0)/1920x1080 crop:(0=
,0)/640x480]
> >=20
> > You're cropping the image to 640x480 here. You need to set the crop
> > rectangle to 1920x1080.
> >=20
> > As Jacopo mentioned, I wouldn't recommend exercising the ISP directly.
> > Not only do you need to setup the pipeline, but you would also need to
> > implement all the imaging algorithms in userspace. libcamera will do al=
l
> > this for you.
>=20
> I'll give that a try.  My current employer has a v4l2src requirement,
> but I can likely make an argument to switch to libcamera.  I didn't
> catch the cropping part. Thanks for that.

I'd hope you can transparently replace v4l2src with libcamerasrc, the plugi=
ns
currently lives inside the libcamera project. If not, I'd really like to kn=
ow
why. We can work together on adding missing controls (this is something I'm
starting on soon).

regards,
Nicolas

>=20
> adam
> >=20
> > > <- "csis-32e40000.csi":1 [ENABLED]
> > > pad1: Sink [fmt:unknown/0x0 field:none]
> > > <- "rkisp1_params":0 [ENABLED,IMMUTABLE]
> > > pad2: Source [fmt:YUYV8_2X8/640x480 field:none colorspace:raw xfer:no=
ne ycbcr:601 quantization:lim-range crop.bounds:(0,0)/640x480 crop:(0,0)/64=
0x480]
> > > -> "rkisp1_resizer_mainpath":0 [ENABLED]
> > > pad3: Source [fmt:unknown/0x0 field:none]
> > > -> "rkisp1_stats":0 [ENABLED,IMMUTABLE]
> > >=20
> > > - entity 6: rkisp1_resizer_mainpath (2 pads, 2 links)
> > >             type V4L2 subdev subtype Unknown flags 0
> > >             device node name /dev/v4l-subdev1
> > > pad0: Sink [fmt:YUYV8_2X8/1920x1080 field:none colorspace:srgb xfer:s=
rgb ycbcr:601 quantization:lim-range crop.bounds:(0,0)/1920x1080 crop:(0,0)=
/640x480]
> > > <- "rkisp1_isp":2 [ENABLED]
> > > pad1: Source [fmt:YUYV8_2X8/1920x1080 field:none colorspace:srgb xfer=
:srgb ycbcr:601 quantization:lim-range]
> > > -> "rkisp1_mainpath":0 [ENABLED,IMMUTABLE]
> > >=20
> > > - entity 9: rkisp1_mainpath (1 pad, 1 link)
> > >             type Node subtype V4L flags 0
> > >             device node name /dev/video0
> > > pad0: Sink
> > > <- "rkisp1_resizer_mainpath":1 [ENABLED,IMMUTABLE]
> > >=20
> > > - entity 13: rkisp1_stats (1 pad, 1 link)
> > >              type Node subtype V4L flags 0
> > >              device node name /dev/video1
> > > pad0: Sink
> > > <- "rkisp1_isp":3 [ENABLED,IMMUTABLE]
> > >=20
> > > - entity 17: rkisp1_params (1 pad, 1 link)
> > >              type Node subtype V4L flags 0
> > >              device node name /dev/video2
> > > pad0: Source
> > > -> "rkisp1_isp":1 [ENABLED,IMMUTABLE]
> > >=20
> > > - entity 29: csis-32e40000.csi (2 pads, 2 links)
> > >              type V4L2 subdev subtype Unknown flags 0
> > >              device node name /dev/v4l-subdev2
> > > pad0: Sink [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb xfe=
r:srgb ycbcr:601 quantization:full-range]
> > > <- "imx219 1-0010":0 [ENABLED]
> > > pad1: Source [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb x=
fer:srgb ycbcr:601 quantization:full-range]
> > > -> "rkisp1_isp":0 [ENABLED]
> > >=20
> > > - entity 34: imx219 1-0010 (1 pad, 1 link)
> > >              type V4L2 subdev subtype Sensor flags 0
> > >              device node name /dev/v4l-subdev3
> > > pad0: Source [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb x=
fer:srgb ycbcr:601 quantization:full-range crop.bounds:(8,8)/3280x2464 crop=
:(688,700)/1920x1080]
> > > -> "csis-32e40000.csi":0 [ENABLED]
> > >=20
> > > It's at this point that everything except the ISP source is 1920x1080=
.
> > >=20
> > > When I try to set the ISP sink to 1080, it ends up being 640x480 and
> > > the resizer sink is also changed to 640x480
> > >=20
> > > root@beacon-imx8mp-kit:~# media-ctl -v -V "'rkisp1_isp':2
> > > [fmt:YUYV8_2X8/1920x1080 field:none]"
> > > Opening media device /dev/media0
> > > Enumerating entities
> > > looking up device: 81:3
> > > looking up device: 81:4
> > > looking up device: 81:0
> > > looking up device: 81:1
> > > looking up device: 81:2
> > > looking up device: 81:5
> > > looking up device: 81:6
> > > Found 7 entities
> > > Enumerating pads and links
> > > Setting up format YUYV8_2X8 1920x1080 on pad rkisp1_isp/2
> > > Format set: YUYV8_2X8 640x480
> > > Setting up format YUYV8_2X8 640x480 on pad rkisp1_resizer_mainpath/0
> > > Format set: YUYV8_2X8 640x480
> > >=20
> > >=20
> > > It's my understanding that the ISP should be able to handle 1920x1080=
,
> > > and the resizer sink should match the ISP source.
> > >=20
> > > With the pipeline improperly setup, the capture fails.
> > >=20
> > > >  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
> > > >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
> > > >  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
> > > >  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
> > > >  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
> > > >  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 ++++++++++++++=
+++-
> > > >  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
> > > >  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
> > > >  include/uapi/linux/rkisp1-config.h            |   2 +
> > > >  9 files changed, 509 insertions(+), 40 deletions(-)
> >=20
> > --
> > Regards,
> >=20
> > Laurent Pinchart

