Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F775EAF83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiIZSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIZSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:18:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC9FD76;
        Mon, 26 Sep 2022 11:11:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E8EB415;
        Mon, 26 Sep 2022 20:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664215897;
        bh=HqN82ot/YsUR78RuI/U5/GaeTx6YXvwQ++AEduJCNGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1CsNodU80Fm9sBrGhZDTZGFWJA3r/4C6eWyTXHN7nsgmhHpxDwwWpnhqhY6PBY90
         Mkh6Sp7cNRCI/ng3+sxsrExpfcnWDIqQcuUuSrckhckC+S/U3ubUTUMygXYlyZv+K2
         K7TL+RBKX5AlqzwvItqwLpzMvlVgF1vd0IRo/5MI=
Date:   Mon, 26 Sep 2022 21:11:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <YzHrSU4RK/QFx9Xs@pendragon.ideasonboard.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yyx/NI8sew4hpFAc@pendragon.ideasonboard.com>
 <CA+V-a8u9DqzN_dDxU74F1wCZpJeODQet-aF7sd6j2=jk545x7Q@mail.gmail.com>
 <YzFp8x78/HJ/Yf2Y@pendragon.ideasonboard.com>
 <CA+V-a8tcj1iun1-9qcCP5649S___JfD_rL46v0_1HCcnEXnNVg@mail.gmail.com>
 <YzHTcuThQgNTo/HS@pendragon.ideasonboard.com>
 <CA+V-a8sGzAC1M8hxgbizKFnCbAGXzr0FXFzmsfnfEgMz_H_hxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8sGzAC1M8hxgbizKFnCbAGXzr0FXFzmsfnfEgMz_H_hxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Sep 26, 2022 at 06:27:40PM +0100, Lad, Prabhakar wrote:
> On Mon, Sep 26, 2022 at 5:29 PM Laurent Pinchart wrote:
> > On Mon, Sep 26, 2022 at 05:24:47PM +0100, Lad, Prabhakar wrote:
> > > On Mon, Sep 26, 2022 at 9:59 AM Laurent Pinchart wrote:
> > > > On Fri, Sep 23, 2022 at 08:02:12PM +0100, Lad, Prabhakar wrote:
> > > > > On Thu, Sep 22, 2022 at 4:29 PM Laurent Pinchart wrote:
> > > > > > On Tue, Sep 06, 2022 at 12:04:06AM +0100, Lad Prabhakar wrote:
> > > > > > > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> > > > > > >
> > > > > > > Based on a patch in the BSP by Hien Huynh
> > > > > > > <hien.huynh.px@renesas.com>
> > > > > > >
> > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > ---
> > > > > > > v1 -> v2
> > > > > > > * No change
> > > > > > >
> > > > > > > RFC v2 -> v1
> > > > > > > * Moved the driver to renesas folder
> > > > > > > * Fixed review comments pointed by Jacopo
> > > > > > >
> > > > > > > RFC v1 -> RFC v2
> > > > > > > * Dropped group
> > > > > > > * Dropped CSI subdev and implemented as new driver
> > > > > > > * Dropped "mc_" from function names
> > > > > > > * Moved the driver to renesas folder
> > > > > > > ---
> > > > > > >  .../media/platform/renesas/rzg2l-cru/Kconfig  |  17 +
> > > > > > >  .../media/platform/renesas/rzg2l-cru/Makefile |   3 +
> > > > > > >  .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 395 ++++++++++
> > > > > > >  .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 152 ++++
> > > > > > >  .../platform/renesas/rzg2l-cru/rzg2l-dma.c    | 734 ++++++++++++++++++
> > > > > > >  .../platform/renesas/rzg2l-cru/rzg2l-v4l2.c   | 368 +++++++++
> > > > > >
> > > > > > I'd merge those two files together, they both handle the video node.
> > > > > > There's a comment below that recommends adding a subdev, that should
> > > > > > then go to a separate file.
> > > > >
> > > > > OK, I'll merge these files into rzg2l-video.c.
> > > > >
> > > > > > >  6 files changed, 1669 insertions(+)
> > > > > > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > > > > > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> > > > > > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
> > > > > > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
> > > > > > >
> > > > > > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > > > > > > index 57c40bb499df..08ff0e96b3f5 100644
> > > > > > > --- a/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > > > > > > +++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > > > > > > @@ -15,3 +15,20 @@ config VIDEO_RZG2L_CSI2
> > > > > > >
> > > > > > >         To compile this driver as a module, choose M here: the
> > > > > > >         module will be called rzg2l-csi2.
> > > > > > > +
> > > > > > > +config VIDEO_RZG2L_CRU
> > > > > > > +     tristate "RZ/G2L Camera Receiving Unit (CRU) Driver"
> > > > > > > +     depends on ARCH_RENESAS || COMPILE_TEST
> > > > > > > +     depends on V4L_PLATFORM_DRIVERS
> > > > > > > +     depends on VIDEO_DEV && OF
> > > > > > > +     select MEDIA_CONTROLLER
> > > > > > > +     select V4L2_FWNODE
> > > > > > > +     select VIDEOBUF2_DMA_CONTIG
> > > > > > > +     select VIDEO_RZG2L_CSI2
> > > > > >
> > > > > > Is this required, can't the CRU be used with a parallel sensor without
> > > > > > the CSI-2 receiver ?
> > > > >
> > > > > Yes the CRU can be used with parallel sensors, I'll drop the above select.
> > > > >
> > > > > > > +     select VIDEO_V4L2_SUBDEV_API
> > > > > > > +     help
> > > > > > > +       Support for Renesas RZ/G2L (and alike SoC's) Camera Receiving
> > > > > > > +       Unit (CRU) driver.
> > > > > > > +
> > > > > > > +       To compile this driver as a module, choose M here: the
> > > > > > > +       module will be called rzg2l-cru.
> > > > > > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > > > > > > index 91ea97a944e6..7628809e953f 100644
> > > > > > > --- a/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > > > > > > +++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > > > > > > @@ -1,3 +1,6 @@
> > > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > > >
> > > > > > >  obj-$(CONFIG_VIDEO_RZG2L_CSI2) += rzg2l-csi2.o
> > > > > > > +
> > > > > > > +rzg2l-cru-objs = rzg2l-core.o rzg2l-dma.o rzg2l-v4l2.o
> > > > > > > +obj-$(CONFIG_VIDEO_RZG2L_CRU) += rzg2l-cru.o
> > > > > > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..b5d4110b1913
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > > > > > > @@ -0,0 +1,395 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +/*
> > > > > > > + * Driver for Renesas RZ/G2L CRU
> > > > > > > + *
> > > > > > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > > > > > + *
> > > > > > > + * Based on Renesas R-Car VIN
> > > > > > > + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> > > > > > > + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> > > > > > > + * Copyright (C) 2008 Magnus Damm
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/clk.h>
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/mod_devicetable.h>
> > > > > > > +#include <linux/of.h>
> > > > > > > +#include <linux/of_device.h>
> > > > > > > +#include <linux/of_graph.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > +
> > > > > > > +#include <media/v4l2-fwnode.h>
> > > > > > > +#include <media/v4l2-mc.h>
> > > > > > > +
> > > > > > > +#include "rzg2l-cru.h"
> > > > > > > +
> > > > > > > +#define v4l2_dev_to_cru(d)   container_of(d, struct rzg2l_cru_dev, v4l2_dev)
> > > > > >
> > > > > > As this macro is only used to get the rzg2l_cru_dev pointer from the
> > > > > > v4l2_async_notifier pointer, you can replace it with
> > > > > >
> > > > > > #define notifier_to_cru(n)      container_of(n, struct rzg2l_cru_dev, notifier)
> > > > > >
> > > > > > I would also turn it into a static inline function for additional
> > > > > > compile-time type safety.
> > > > >
> > > > > OK, I will do it as mentioned above.
> > > > >
> > > > > > > +
> > > > > > > +static int rzg2l_cru_csi2_link_notify(struct media_link *link, u32 flags,
> > > > > > > +                                   unsigned int notification)
> > > > > > > +{
> > > > > > > +     struct media_entity *entity;
> > > > > > > +     struct rzg2l_cru_dev *cru;
> > > > > > > +     struct media_pad *csi_pad;
> > > > > > > +     struct v4l2_subdev *sd;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     ret = v4l2_pipeline_link_notify(link, flags, notification);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > > > +
> > > > > > > +     /* Only care about link enablement for CRU nodes. */
> > > > > > > +     if (!(flags & MEDIA_LNK_FL_ENABLED))
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     cru = container_of(link->graph_obj.mdev, struct rzg2l_cru_dev, mdev);
> > > > > > > +     /*
> > > > > > > +      * Don't allow link changes if any entity in the graph is
> > > > > > > +      * streaming, modifying the CHSEL register fields can disrupt
> > > > > > > +      * running streams.
> > > > > > > +      */
> > > > > > > +     media_device_for_each_entity(entity, &cru->mdev)
> > > > > > > +             if (media_entity_is_streaming(entity))
> > > > > > > +                     return -EBUSY;
> > > > > > > +
> > > > > > > +     mutex_lock(&cru->mdev_lock);
> > > > > > > +
> > > > > > > +     csi_pad = media_pad_remote_pad_first(&cru->vdev.entity.pads[0]);
> > > > > > > +     if (csi_pad) {
> > > > > > > +             ret = -EMLINK;
> > > > > > > +             goto out;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     sd = media_entity_to_v4l2_subdev(link->source->entity);
> > > > > > > +     if (cru->csi.subdev == sd) {
> > > > > > > +             cru->csi.channel = link->source->index - 1;
> > > > > > > +             cru->is_csi = true;
> > > > > > > +     } else {
> > > > > > > +             ret = -ENODEV;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +out:
> > > > > > > +     mutex_unlock(&cru->mdev_lock);
> > > > > > > +
> > > > > > > +     return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static const struct media_device_ops rzg2l_cru_media_ops = {
> > > > > > > +     .link_notify = rzg2l_cru_csi2_link_notify,
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* -----------------------------------------------------------------------------
> > > > > > > + * Group async notifier
> > > > > > > + */
> > > > > > > +
> > > > > > > +static int rzg2l_cru_group_notify_complete(struct v4l2_async_notifier *notifier)
> > > > > > > +{
> > > > > > > +     struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
> > > > > > > +     unsigned int i;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     ret = media_device_register(&cru->mdev);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > >
> > > > > > I'd move the v4l2_device_register() call here, as it's the V4L2
> > > > > > counterpart of the media device, and handling them together would be
> > > > > > best.
> > > > >
> > > > > OK.
> > > > >
> > > > > > > +
> > > > > > > +     ret = v4l2_device_register_subdev_nodes(&cru->v4l2_dev);
> > > > > > > +     if (ret) {
> > > > > > > +             dev_err(cru->dev, "Failed to register subdev nodes\n");
> > > > > > > +             return ret;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     if (!video_is_registered(&cru->vdev)) {
> > > > > >
> > > > > > Can this happen ?
> > > > >
> > > > > No, I'll drop this check.
> > > > >
> > > > > > > +             ret = rzg2l_cru_v4l2_register(cru);
> > > > > > > +             if (ret)
> > > > > > > +                     return ret;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     /* Create all media device links between CRU and CSI-2's. */
> > > > > > > +     /*
> > > > > > > +      * TODO: RZ/G2L supports 4 VC0, as support for virtual channels
> > > > > > > +      * should be implemented by streams API which is under development
> > > > > > > +      * so for now just link it to VC0
> > > > > > > +      */
> > > > > >
> > > > > > The streams API won't require more links, so I'd drop the comment and
> > > > > > the loop and create a single link.
> > > > >
> > > > > OK.
> > > > >
> > > > > > > +     for (i = 1; i <= 1; i++) {
> > > > > > > +             struct media_entity *source, *sink;
> > > > > > > +
> > > > > > > +             source = &cru->csi.subdev->entity;
> > > > > > > +             sink = &cru->vdev.entity;
> > > > > >
> > > > > > Hmmm... I'd recommend adding a subdev to model the image processing
> > > > > > pipeline of the CRU, between the CSI-2 receiver and the video node. That
> > > > > > will help when you'll add support for parallel sensors, and it will also
> > > > > > be needed by the streams API to select which virtual channel to capture.
> > > > >/
> > > > > just model as a dummy subdev for now (MEDIA_ENT_F_VID_MUX)?
> > > >
> > > > I think MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER would be more
> > > > appropriate.
> > >
> > > OK I will use MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER. As this will be
> > > just like a switch should I be implementing the get_fmt/set_fmt
> > > callbacks?
> >
> > Yes, subdev operations need to be implemented, especially given that the
> > CRU implements color space conversion, so the input and output formats
> > of the subdev can be different.
> 
> OK, the reason I asked as, for the sink pad the format of IP subdev
> will be the same as remote source pad (i.e. either from CSI/parallel
> subdev) and for the source pad this will be the same as format on the
> video node (ie CRU output).
> 
> get_fmt -> we get the subdev pad fmt of the remote source and return it.
> set_fmt -> we just pass through, as the fmt is set on the video dev node.
> 
> Does the above sound good?

No, subdevs must not query each other to implement those operations.
Subdevs are configured by userspace separately from each other, so a
subdev set_fmt handler must accept any format that is valid for the
subdev, regardless of how the connected subdevs or video nodes are
configured. get_fmt just returns the format that has been set on the
subdev. Validation of the pipeline, to check that connected pads have a
compatible format, is done when starting the stream.

-- 
Regards,

Laurent Pinchart
