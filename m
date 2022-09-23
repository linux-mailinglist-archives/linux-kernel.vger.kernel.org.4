Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50035E8246
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIWTCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:02:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85978121E5F;
        Fri, 23 Sep 2022 12:02:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z13so1382098edb.13;
        Fri, 23 Sep 2022 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tvTaWw9lajKyLbxeogGrLSkWapSQo87IgViP98Qc0Vw=;
        b=owV+Wm5c21cs0/lLvIw0BNA5lWc9X/4H79eI73Lz954+sduKUO2iP3GGTSw8akXrFw
         b2W/Gw0KFe76F3qy7BbeMtQVdkd1Fzjm6VTOamVogb+eW3hlQk1vqKHCbbz2eUD0D05o
         owS569lzlnDTAJBEqjpMbCNzSeRiq8kMwlbBUqDCLNO4EYZifganI/vnyFQt8mdGuEpY
         EC1EVqwZx0wWh+NNGvXxCEZu9ymflgiB1lGqpGIAAfNcWSHCSJwMG/hJm3wF0pD2KKU4
         TgsekSWP+huvnwbX1lFi/ZmH7y9nuSP+ceX2Lx2wGtR0cF34Jf6x/30TD/dwACyPduQy
         u+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tvTaWw9lajKyLbxeogGrLSkWapSQo87IgViP98Qc0Vw=;
        b=IMKMKywaGo7hxYwbcS9z+o9dwNdcuWUAq/+QwAdvaOc/mHIBXqau7Y10e1+E58eXB1
         /1cI5HGLdELfZ3m61fwoeMqjucCW+6GkvS/AEcNJSkBaWiqk4lV+a2Vyr7SMSsUQKYVM
         KNQfUSY2BOvpGIe/td8kZ5J6LUUH/ucZ42OjMSxYCZ4aPPXKzBS9ooiuekrHLryX3yyU
         2NAd63vvyGv2NwrCLOsdHxpD/x5sBRjdVd7jbN8otqVfPwUOObtUhl0WLuMlGinKfU60
         00lOwFOdiokn7kYAgKO4xcWc3tadP2NvwtGXtf/t76Duz1BlMJ4/1BsrbqPcMbl160x6
         Gadw==
X-Gm-Message-State: ACrzQf2qItRe5G/DsSHSr8Tvto435mRg4LWKSzHuYNltNngTg+WJ3661
        WTkz+I3ALyWBrV0Z8cAGr97G9eSF5aH8agZktCU=
X-Google-Smtp-Source: AMsMyM5dFz86Lgfd36h7YgKrzv1FAVKxOy6w8SyQIcOjVxghiBuw8PJviDew89KamiWpPwVA6/GnRGBcuR5svXHu3DM=
X-Received: by 2002:a05:6402:40c2:b0:44f:963d:1ab4 with SMTP id
 z2-20020a05640240c200b0044f963d1ab4mr9988349edb.319.1663959759647; Fri, 23
 Sep 2022 12:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yyx/NI8sew4hpFAc@pendragon.ideasonboard.com>
In-Reply-To: <Yyx/NI8sew4hpFAc@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 23 Sep 2022 20:02:12 +0100
Message-ID: <CA+V-a8u9DqzN_dDxU74F1wCZpJeODQet-aF7sd6j2=jk545x7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the review.

On Thu, Sep 22, 2022 at 4:29 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Tue, Sep 06, 2022 at 12:04:06AM +0100, Lad Prabhakar wrote:
> > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> >
> > Based on a patch in the BSP by Hien Huynh
> > <hien.huynh.px@renesas.com>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1 -> v2
> > * No change
> >
> > RFC v2 -> v1
> > * Moved the driver to renesas folder
> > * Fixed review comments pointed by Jacopo
> >
> > RFC v1 -> RFC v2
> > * Dropped group
> > * Dropped CSI subdev and implemented as new driver
> > * Dropped "mc_" from function names
> > * Moved the driver to renesas folder
> > ---
> >  .../media/platform/renesas/rzg2l-cru/Kconfig  |  17 +
> >  .../media/platform/renesas/rzg2l-cru/Makefile |   3 +
> >  .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 395 ++++++++++
> >  .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 152 ++++
> >  .../platform/renesas/rzg2l-cru/rzg2l-dma.c    | 734 ++++++++++++++++++
> >  .../platform/renesas/rzg2l-cru/rzg2l-v4l2.c   | 368 +++++++++
>
> I'd merge those two files together, they both handle the video node.
> There's a comment below that recommends adding a subdev, that should
> then go to a separate file.
>
OK, I'll merge these files into rzg2l-video.c.

> >  6 files changed, 1669 insertions(+)
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
> >
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > index 57c40bb499df..08ff0e96b3f5 100644
> > --- a/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > @@ -15,3 +15,20 @@ config VIDEO_RZG2L_CSI2
> >
> >         To compile this driver as a module, choose M here: the
> >         module will be called rzg2l-csi2.
> > +
> > +config VIDEO_RZG2L_CRU
> > +     tristate "RZ/G2L Camera Receiving Unit (CRU) Driver"
> > +     depends on ARCH_RENESAS || COMPILE_TEST
> > +     depends on V4L_PLATFORM_DRIVERS
> > +     depends on VIDEO_DEV && OF
> > +     select MEDIA_CONTROLLER
> > +     select V4L2_FWNODE
> > +     select VIDEOBUF2_DMA_CONTIG
> > +     select VIDEO_RZG2L_CSI2
>
> Is this required, can't the CRU be used with a parallel sensor without
> the CSI-2 receiver ?
>
Yes the CRU can be used with parallel sensors, I'll drop the above select.

> > +     select VIDEO_V4L2_SUBDEV_API
> > +     help
> > +       Support for Renesas RZ/G2L (and alike SoC's) Camera Receiving
> > +       Unit (CRU) driver.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called rzg2l-cru.
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > index 91ea97a944e6..7628809e953f 100644
> > --- a/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > @@ -1,3 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_VIDEO_RZG2L_CSI2) += rzg2l-csi2.o
> > +
> > +rzg2l-cru-objs = rzg2l-core.o rzg2l-dma.o rzg2l-v4l2.o
> > +obj-$(CONFIG_VIDEO_RZG2L_CRU) += rzg2l-cru.o
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > new file mode 100644
> > index 000000000000..b5d4110b1913
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > @@ -0,0 +1,395 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for Renesas RZ/G2L CRU
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + *
> > + * Based on Renesas R-Car VIN
> > + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> > + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> > + * Copyright (C) 2008 Magnus Damm
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include <media/v4l2-fwnode.h>
> > +#include <media/v4l2-mc.h>
> > +
> > +#include "rzg2l-cru.h"
> > +
> > +#define v4l2_dev_to_cru(d)   container_of(d, struct rzg2l_cru_dev, v4l2_dev)
>
> As this macro is only used to get the rzg2l_cru_dev pointer from the
> v4l2_async_notifier pointer, you can replace it with
>
> #define notifier_to_cru(n)      container_of(n, struct rzg2l_cru_dev, notifier)
>
> I would also turn it into a static inline function for additional
> compile-time type safety.
>
OK, I will do it as mentioned above.

> > +
> > +static int rzg2l_cru_csi2_link_notify(struct media_link *link, u32 flags,
> > +                                   unsigned int notification)
> > +{
> > +     struct media_entity *entity;
> > +     struct rzg2l_cru_dev *cru;
> > +     struct media_pad *csi_pad;
> > +     struct v4l2_subdev *sd;
> > +     int ret;
> > +
> > +     ret = v4l2_pipeline_link_notify(link, flags, notification);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Only care about link enablement for CRU nodes. */
> > +     if (!(flags & MEDIA_LNK_FL_ENABLED))
> > +             return 0;
> > +
> > +     cru = container_of(link->graph_obj.mdev, struct rzg2l_cru_dev, mdev);
> > +     /*
> > +      * Don't allow link changes if any entity in the graph is
> > +      * streaming, modifying the CHSEL register fields can disrupt
> > +      * running streams.
> > +      */
> > +     media_device_for_each_entity(entity, &cru->mdev)
> > +             if (media_entity_is_streaming(entity))
> > +                     return -EBUSY;
> > +
> > +     mutex_lock(&cru->mdev_lock);
> > +
> > +     csi_pad = media_pad_remote_pad_first(&cru->vdev.entity.pads[0]);
> > +     if (csi_pad) {
> > +             ret = -EMLINK;
> > +             goto out;
> > +     }
> > +
> > +     sd = media_entity_to_v4l2_subdev(link->source->entity);
> > +     if (cru->csi.subdev == sd) {
> > +             cru->csi.channel = link->source->index - 1;
> > +             cru->is_csi = true;
> > +     } else {
> > +             ret = -ENODEV;
> > +     }
> > +
> > +out:
> > +     mutex_unlock(&cru->mdev_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct media_device_ops rzg2l_cru_media_ops = {
> > +     .link_notify = rzg2l_cru_csi2_link_notify,
> > +};
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Group async notifier
> > + */
> > +
> > +static int rzg2l_cru_group_notify_complete(struct v4l2_async_notifier *notifier)
> > +{
> > +     struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ret = media_device_register(&cru->mdev);
> > +     if (ret)
> > +             return ret;
>
> I'd move the v4l2_device_register() call here, as it's the V4L2
> counterpart of the media device, and handling them together would be
> best.
>
OK.

> > +
> > +     ret = v4l2_device_register_subdev_nodes(&cru->v4l2_dev);
> > +     if (ret) {
> > +             dev_err(cru->dev, "Failed to register subdev nodes\n");
> > +             return ret;
> > +     }
> > +
> > +     if (!video_is_registered(&cru->vdev)) {
>
> Can this happen ?
>
No, I'll drop this check.

> > +             ret = rzg2l_cru_v4l2_register(cru);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     /* Create all media device links between CRU and CSI-2's. */
> > +     /*
> > +      * TODO: RZ/G2L supports 4 VC0, as support for virtual channels
> > +      * should be implemented by streams API which is under development
> > +      * so for now just link it to VC0
> > +      */
>
> The streams API won't require more links, so I'd drop the comment and
> the loop and create a single link.
>
OK.

> > +     for (i = 1; i <= 1; i++) {
> > +             struct media_entity *source, *sink;
> > +
> > +             source = &cru->csi.subdev->entity;
> > +             sink = &cru->vdev.entity;
>
> Hmmm... I'd recommend adding a subdev to model the image processing
> pipeline of the CRU, between the CSI-2 receiver and the video node. That
> will help when you'll add support for parallel sensors, and it will also
> be needed by the streams API to select which virtual channel to capture.
>
just model as a dummy subdev for now (MEDIA_ENT_F_VID_MUX)?

> > +
> > +             ret = media_create_pad_link(source, i, sink, 0, 0);
> > +             if (ret) {
> > +                     dev_err(cru->dev, "Error adding link from %s to %s\n",
> > +                             source->name, sink->name);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_cru_group_notify_unbind(struct v4l2_async_notifier *notifier,
> > +                                       struct v4l2_subdev *subdev,
> > +                                       struct v4l2_async_subdev *asd)
> > +{
> > +     struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
> > +
> > +     rzg2l_cru_v4l2_unregister(cru);
> > +
> > +     mutex_lock(&cru->mdev_lock);
> > +
> > +     if (cru->csi.asd == asd) {
> > +             cru->csi.subdev = NULL;
> > +             dev_dbg(cru->dev, "Unbind CSI-2 %s\n", subdev->name);
> > +     }
> > +
> > +     mutex_unlock(&cru->mdev_lock);
> > +
> > +     media_device_unregister(&cru->mdev);
> > +}
> > +
> > +static int rzg2l_cru_group_notify_bound(struct v4l2_async_notifier *notifier,
> > +                                     struct v4l2_subdev *subdev,
> > +                                     struct v4l2_async_subdev *asd)
> > +{
> > +     struct rzg2l_cru_dev *cru = v4l2_dev_to_cru(notifier->v4l2_dev);
> > +
> > +     mutex_lock(&cru->mdev_lock);
> > +
> > +     if (cru->csi.asd == asd) {
> > +             cru->csi.subdev = subdev;
> > +             dev_dbg(cru->dev, "Bound CSI-2 %s\n", subdev->name);
> > +     }
> > +
> > +     mutex_unlock(&cru->mdev_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct v4l2_async_notifier_operations rzg2l_cru_async_ops = {
> > +     .bound = rzg2l_cru_group_notify_bound,
> > +     .unbind = rzg2l_cru_group_notify_unbind,
> > +     .complete = rzg2l_cru_group_notify_complete,
> > +};
> > +
> > +static int rvin_mc_parse_of(struct rzg2l_cru_dev *cru, unsigned int id)
>
> The id parameter is always 0, I'd drop it.
>
Agreed, I will drop it.

> > +{
> > +     struct v4l2_fwnode_endpoint vep = {
> > +             .bus_type = V4L2_MBUS_CSI2_DPHY,
> > +     };
> > +     struct fwnode_handle *ep, *fwnode;
> > +     struct v4l2_async_subdev *asd;
> > +     int ret;
> > +
> > +     ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(cru->dev), 1, id, 0);
> > +     if (!ep)
> > +             return 0;
> > +
> > +     fwnode = fwnode_graph_get_remote_endpoint(ep);
> > +     ret = v4l2_fwnode_endpoint_parse(ep, &vep);
> > +     fwnode_handle_put(ep);
> > +     if (ret) {
> > +             dev_err(cru->dev, "Failed to parse %pOF\n", to_of_node(fwnode));
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     if (!of_device_is_available(to_of_node(fwnode))) {
> > +             dev_dbg(cru->dev, "OF device %pOF disabled, ignoring\n",
> > +                     to_of_node(fwnode));
> > +             ret = -ENOTCONN;
> > +             goto out;
> > +     }
> > +
> > +     asd = v4l2_async_nf_add_fwnode(&cru->notifier, fwnode,
> > +                                    struct v4l2_async_subdev);
> > +     if (IS_ERR(asd)) {
> > +             ret = PTR_ERR(asd);
> > +             goto out;
> > +     }
> > +
> > +     cru->csi.asd = asd;
> > +
> > +     dev_dbg(cru->dev, "Added OF device %pOF to slot %u\n",
> > +             to_of_node(fwnode), vep.base.id);
> > +out:
> > +     fwnode_handle_put(fwnode);
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_cru_mc_parse_of_graph(struct rzg2l_cru_dev *cru)
> > +{
> > +     int ret;
> > +
> > +     v4l2_async_nf_init(&cru->notifier);
> > +
> > +     ret = rvin_mc_parse_of(cru, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     cru->notifier.ops = &rzg2l_cru_async_ops;
> > +
> > +     if (list_empty(&cru->notifier.asd_list))
> > +             return 0;
> > +
> > +     ret = v4l2_async_nf_register(&cru->v4l2_dev, &cru->notifier);
> > +     if (ret < 0) {
> > +             dev_err(cru->dev, "Notifier registration failed\n");
> > +             v4l2_async_nf_cleanup(&cru->notifier);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_csi2_init(struct rzg2l_cru_dev *cru)
>
> The naming is a bit weird, as this isn't related to CSI-2. I would name
> the function rzg2l_cru_media_init().
>
Agreed, I will rename it.

> > +{
> > +     struct media_device *mdev = NULL;
> > +     const struct of_device_id *match;
> > +     int ret;
> > +
> > +     cru->pad.flags = MEDIA_PAD_FL_SINK;
> > +     ret = media_entity_pads_init(&cru->vdev.entity, 1, &cru->pad);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_init(&cru->mdev_lock);
> > +     mdev = &cru->mdev;
> > +     mdev->dev = cru->dev;
> > +     mdev->ops = &rzg2l_cru_media_ops;
> > +
> > +     match = of_match_node(cru->dev->driver->of_match_table,
> > +                           cru->dev->of_node);
> > +
> > +     strscpy(mdev->driver_name, KBUILD_MODNAME, sizeof(mdev->driver_name));
> > +     strscpy(mdev->model, match->compatible, sizeof(mdev->model));
> > +     snprintf(mdev->bus_info, sizeof(mdev->bus_info), "platform:%s",
> > +              dev_name(mdev->dev));
> > +
> > +     cru->v4l2_dev.mdev = &cru->mdev;
> > +
> > +     media_device_init(mdev);
> > +
> > +     ret = rzg2l_cru_mc_parse_of_graph(cru);
> > +     if (ret) {
> > +             mutex_lock(&cru->mdev_lock);
> > +             cru->v4l2_dev.mdev = NULL;
> > +             mutex_unlock(&cru->mdev_lock);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_probe(struct platform_device *pdev)
> > +{
> > +     struct rzg2l_cru_dev *cru;
> > +     int irq, ret;
> > +
> > +     cru = devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
> > +     if (!cru)
> > +             return -ENOMEM;
> > +
> > +     cru->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(cru->base))
> > +             return PTR_ERR(cru->base);
> > +
> > +     cru->presetn = devm_reset_control_get(&pdev->dev, "presetn");
> > +     if (IS_ERR(cru->presetn))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(cru->presetn),
> > +                                  "failed to get cpg presetn\n");
> > +
> > +     cru->aresetn = devm_reset_control_get(&pdev->dev, "aresetn");
> > +     if (IS_ERR(cru->aresetn))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(cru->aresetn),
> > +                                  "failed to get cpg aresetn\n");
> > +
> > +     cru->vclk = devm_clk_get(&pdev->dev, "vclk");
> > +     if (IS_ERR(cru->vclk)) {
> > +             dev_err(&pdev->dev, "Failed to get vclk");
> > +             return PTR_ERR(cru->vclk);
>
> You could use dev_err_probe() here too (as well as below).
>
OK.

> > +     }
> > +
> > +     cru->pclk = devm_clk_get(&pdev->dev, "pclk");
> > +     if (IS_ERR(cru->pclk)) {
> > +             dev_err(&pdev->dev, "Failed to get pclk");
> > +             return PTR_ERR(cru->pclk);
> > +     }
> > +
> > +     cru->aclk = devm_clk_get(&pdev->dev, "aclk");
> > +     if (IS_ERR(cru->aclk)) {
> > +             dev_err(&pdev->dev, "Failed to get aclk");
> > +             return PTR_ERR(cru->aclk);
> > +     }
> > +
> > +     cru->dev = &pdev->dev;
> > +     cru->info = of_device_get_match_data(&pdev->dev);
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     ret = rzg2l_cru_dma_register(cru, irq);
> > +     if (ret)
> > +             return ret;
> > +
> > +     platform_set_drvdata(pdev, cru);
> > +
> > +     ret = rzg2l_cru_csi2_init(cru);
> > +     if (ret)
> > +             goto error_dma_unregister;
> > +
> > +     cru->num_buf = HW_BUFFER_DEFAULT;
> > +     pm_suspend_ignore_children(&pdev->dev, true);
> > +     pm_runtime_enable(&pdev->dev);
> > +
> > +     return 0;
> > +
> > +error_dma_unregister:
> > +     rzg2l_cru_dma_unregister(cru);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id rzg2l_cru_of_id_table[] = {
> > +     {
> > +             .compatible = "renesas,rzg2l-cru",
> > +     },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_cru_of_id_table);
> > +
> > +static int rzg2l_cru_remove(struct platform_device *pdev)
> > +{
> > +     struct rzg2l_cru_dev *cru = platform_get_drvdata(pdev);
> > +
> > +     pm_runtime_disable(&pdev->dev);
> > +
> > +     rzg2l_cru_v4l2_unregister(cru);
> > +
> > +     v4l2_async_nf_unregister(&cru->notifier);
> > +     v4l2_async_nf_cleanup(&cru->notifier);
> > +
> > +     media_device_cleanup(&cru->mdev);
> > +     mutex_destroy(&cru->mdev_lock);
> > +     cru->v4l2_dev.mdev = NULL;
>
> Is this needed ?
>
Not required.

> > +
> > +     rzg2l_cru_dma_unregister(cru);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver rzg2l_cru_driver = {
> > +     .driver = {
> > +             .name = "rzg2l-cru",
> > +             .of_match_table = rzg2l_cru_of_id_table,
> > +     },
> > +     .probe = rzg2l_cru_probe,
> > +     .remove = rzg2l_cru_remove,
>
> No PM ?
>
I plan to gradually add at a later point.

> > +};
> > +
> > +module_platform_driver(rzg2l_cru_driver);
> > +
> > +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L CRU driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> > new file mode 100644
> > index 000000000000..a834680a3200
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> > @@ -0,0 +1,152 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Driver for Renesas RZ/G2L CRU
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + *
>
> Extra blank line.
>
Oops, I will drop it.

> > + */
> > +
> > +#ifndef __RZG2L_CRU__
> > +#define __RZG2L_CRU__
> > +
> > +#include <linux/reset.h>
> > +
> > +#include <media/v4l2-async.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-dev.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/videobuf2-v4l2.h>
> > +
> > +/* Number of HW buffers */
> > +#define HW_BUFFER_MAX                8
> > +#define HW_BUFFER_DEFAULT    3
>
> Could you prefix macro names with CRU_ (or RZG2L_CRU_, up to you) ?
> These names are a bit generic and could lead to clashes.
>
Agreed, I will rename it.

> > +
> > +/* Address alignment mask for HW buffers */
> > +#define HW_BUFFER_MASK               0x1ff
> > +
> > +/* Maximum number of CSI2 virtual channels */
> > +#define CSI2_VCHANNEL                4
> > +
> > +#define CRU_MAX_INPUT_WIDTH  2800
> > +#define CRU_MAX_INPUT_HEIGHT 4095
> > +
> > +/**
> > + * enum rzg2l_cru_dma_state - DMA states
> > + * @RZG2L_CRU_DMA_STOPPED:   No operation in progress
> > + * @RZG2L_CRU_DMA_STARTING:  Capture starting up
> > + * @RZG2L_CRU_DMA_RUNNING:   Operation in progress have buffers
> > + * @RZG2L_CRU_DMA_STOPPING:  Stopping operation
> > + */
> > +enum rzg2l_cru_dma_state {
> > +     RZG2L_CRU_DMA_STOPPED = 0,
> > +     RZG2L_CRU_DMA_STARTING,
> > +     RZG2L_CRU_DMA_RUNNING,
> > +     RZG2L_CRU_DMA_STOPPING,
> > +};
> > +
> > +struct rzg2l_cru_csi {
> > +     struct v4l2_async_subdev *asd;
> > +     struct v4l2_subdev *subdev;
> > +     u32 channel;
> > +};
> > +
> > +/**
> > + * struct rzg2l_cru_dev - Renesas CRU device structure
> > + * @dev:             (OF) device
> > + * @base:            device I/O register space remapped to virtual memory
> > + * @info:            info about CRU instance
> > + *
> > + * @presetn:         CRU_PRESETN reset line
> > + * @aresetn:         CRU_ARESETN reset line
> > + *
> > + * @vclk:            CRU Main clock
> > + * @pclk:            CPU Register access clock
> > + * @aclk:            CRU image transfer clock
> > + *
> > + * @vdev:            V4L2 video device associated with CRU
> > + * @v4l2_dev:                V4L2 device
> > + * @ctrl_handler:    V4L2 control handler
> > + * @num_buf:         Holds the current number of buffers enabled
> > + * @notifier:                V4L2 asynchronous subdevs notifier
> > + *
> > + * @csi:             CSI info
> > + * @mdev:            media device
> > + * @mdev_lock:               protects the count, notifier and csi members
> > + * @pad:             media pad for the video device entity
> > + *
> > + * @lock:            protects @queue
> > + * @queue:           vb2 buffers queue
> > + * @scratch:         cpu address for scratch buffer
> > + * @scratch_phys:    physical address of the scratch buffer
> > + *
> > + * @qlock:           protects @queue_buf, @buf_list, @sequence
> > + *                   @state
> > + * @queue_buf:               Keeps track of buffers given to HW slot
> > + * @buf_list:                list of queued buffers
> > + * @sequence:                V4L2 buffers sequence number
> > + * @state:           keeps track of operation state
> > + *
> > + * @is_csi:          flag to mark the CRU as using a CSI-2 subdevice
> > + *
> > + * @input_is_yuv:    flag to mark the input format of CRU
> > + * @output_is_yuv:   flag to mark the output format of CRU
> > + *
> > + * @mbus_code:               media bus format code
> > + * @format:          active V4L2 pixel format
> > + *
> > + * @compose:         active composing
> > + */
> > +struct rzg2l_cru_dev {
> > +     struct device *dev;
> > +     void __iomem *base;
> > +     const struct rzg2l_cru_info *info;
> > +
> > +     struct reset_control *presetn;
> > +     struct reset_control *aresetn;
> > +
> > +     struct clk *vclk;
> > +     struct clk *pclk;
> > +     struct clk *aclk;
> > +
> > +     struct video_device vdev;
> > +     struct v4l2_device v4l2_dev;
> > +     u8 num_buf;
> > +
> > +     struct v4l2_async_notifier notifier;
> > +
> > +     struct rzg2l_cru_csi csi;
> > +     struct media_device mdev;
> > +     struct mutex mdev_lock;
> > +     struct media_pad pad;
> > +
> > +     struct mutex lock;
> > +     struct vb2_queue queue;
> > +     void *scratch;
> > +     dma_addr_t scratch_phys;
> > +
> > +     spinlock_t qlock;
> > +     struct vb2_v4l2_buffer *queue_buf[HW_BUFFER_MAX];
> > +     struct list_head buf_list;
> > +     unsigned int sequence;
> > +     enum rzg2l_cru_dma_state state;
> > +
> > +     bool is_csi;
> > +
> > +     bool input_is_yuv;
> > +     bool output_is_yuv;
> > +
> > +     u32 mbus_code;
> > +     struct v4l2_pix_format format;
> > +
> > +     struct v4l2_rect compose;
> > +};
> > +
> > +int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru, int irq);
> > +void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru);
> > +
> > +int rzg2l_cru_v4l2_register(struct rzg2l_cru_dev *cru);
> > +void rzg2l_cru_v4l2_unregister(struct rzg2l_cru_dev *cru);
> > +
> > +const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format);
> > +
> > +#endif
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
> > new file mode 100644
> > index 000000000000..44efd071f562
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
> > @@ -0,0 +1,734 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for Renesas RZ/G2L CRU
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + *
> > + * Based on Renesas R-Car VIN
> > + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> > + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> > + * Copyright (C) 2008 Magnus Damm
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <media/videobuf2-dma-contig.h>
> > +
> > +#include "rzg2l-cru.h"
> > +#include "rzg2l-csi2.h"
> > +
> > +/* HW CRU Registers Definition */
> > +/* CRU Control Register */
> > +#define CRUnCTRL                     0x0
> > +#define CRUnCTRL_VINSEL(x)           ((x) << 0)
> > +
> > +/* CRU Interrupt Enable Register */
> > +#define CRUnIE                               0x4
> > +#define CRUnIE_SFE                   BIT(16)
> > +#define CRUnIE_EFE                   BIT(17)
> > +
> > +/* CRU Interrupt Status Register */
> > +#define CRUnINTS                     0x8
> > +#define CRUnINTS_SFS                 BIT(16)
> > +
> > +/* CRU Reset Register */
> > +#define CRUnRST                              0xc
> > +#define CRUnRST_VRESETN                      BIT(0)
> > +
> > +/* Memory Bank Base Address (Lower) Register for CRU Image Data */
> > +#define AMnMBxADDRL(x)                       (0x100 + ((x) * 8))
> > +
> > +/* Memory Bank Base Address (Higher) Register for CRU Image Data */
> > +#define AMnMBxADDRH(x)                       (0x104 + ((x) * 8))
> > +
> > +/* Memory Bank Enable Register for CRU Image Data */
> > +#define AMnMBVALID                   0x148
> > +#define AMnMBVALID_MBVALID(x)                GENMASK(x, 0)
> > +
> > +/* Memory Bank Status Register for CRU Image Data */
> > +#define AMnMBS                               0x14c
> > +#define AMnMBS_MBSTS                 0x7
> > +
> > +/* AXI Master FIFO Pointer Register for CRU Image Data */
> > +#define AMnFIFOPNTR                  0x168
> > +#define AMnFIFOPNTR_FIFOWPNTR                GENMASK(7, 0)
> > +#define AMnFIFOPNTR_FIFORPNTR_Y              GENMASK(23, 16)
> > +
> > +/* AXI Master Transfer Stop Register for CRU Image Data */
> > +#define AMnAXISTP                    0x174
> > +#define AMnAXISTP_AXI_STOP           BIT(0)
> > +
> > +/* AXI Master Transfer Stop Status Register for CRU Image Data */
> > +#define AMnAXISTPACK                 0x178
> > +#define AMnAXISTPACK_AXI_STOP_ACK    BIT(0)
> > +
> > +/* CRU Image Processing Enable Register */
> > +#define ICnEN                                0x200
> > +#define ICnEN_ICEN                   BIT(0)
> > +
> > +/* CRU Image Processing Main Control Register */
> > +#define ICnMC                                0x208
> > +#define ICnMC_CSCTHR                 BIT(5)
> > +#define ICnMC_INF_YUV8_422           (0x1e << 16)
> > +#define ICnMC_INF_USER                       (0x30 << 16)
> > +#define ICnMC_VCSEL(x)                       ((x) << 22)
> > +#define ICnMC_INF_MASK                       GENMASK(21, 16)
> > +
> > +/* CRU Module Status Register */
> > +#define ICnMS                                0x254
> > +#define ICnMS_IA                     BIT(2)
> > +
> > +/* CRU Data Output Mode Register */
> > +#define ICnDMR                               0x26c
> > +#define ICnDMR_YCMODE_UYVY           (1 << 4)
> > +
> > +#define RZG2L_TIMEOUT_MS             100
> > +#define RZG2L_RETRIES                        10
> > +
> > +struct rzg2l_cru_buffer {
> > +     struct vb2_v4l2_buffer vb;
> > +     struct list_head list;
> > +};
> > +
> > +#define to_buf_list(vb2_buffer) (&container_of(vb2_buffer, \
> > +                                             struct rzg2l_cru_buffer, \
> > +                                             vb)->list)
> > +
> > +static void rzg2l_cru_write(struct rzg2l_cru_dev *cru, u32 offset, u32 value)
> > +{
> > +     iowrite32(value, cru->base + offset);
> > +}
> > +
> > +static u32 rzg2l_cru_read(struct rzg2l_cru_dev *cru, u32 offset)
> > +{
> > +     return ioread32(cru->base + offset);
> > +}
> > +
> > +/* Need to hold qlock before calling */
> > +static void return_unused_buffers(struct rzg2l_cru_dev *cru,
> > +                               enum vb2_buffer_state state)
> > +{
> > +     struct rzg2l_cru_buffer *buf, *node;
> > +     unsigned long flags;
> > +     unsigned int i;
> > +
> > +     spin_lock_irqsave(&cru->qlock, flags);
> > +     for (i = 0; i < cru->num_buf; i++) {
> > +             if (cru->queue_buf[i]) {
> > +                     vb2_buffer_done(&cru->queue_buf[i]->vb2_buf,
> > +                                     state);
> > +                     cru->queue_buf[i] = NULL;
> > +             }
> > +     }
> > +
> > +     list_for_each_entry_safe(buf, node, &cru->buf_list, list) {
> > +             vb2_buffer_done(&buf->vb.vb2_buf, state);
> > +             list_del(&buf->list);
> > +     }
> > +     spin_unlock_irqrestore(&cru->qlock, flags);
> > +}
> > +
> > +static int rzg2l_cru_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
> > +                              unsigned int *nplanes, unsigned int sizes[],
> > +                              struct device *alloc_devs[])
> > +{
> > +     struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
> > +
> > +     /* Make sure the image size is large enough. */
> > +     if (*nplanes)
> > +             return sizes[0] < cru->format.sizeimage ? -EINVAL : 0;
> > +
> > +     *nplanes = 1;
> > +     sizes[0] = cru->format.sizeimage;
> > +
> > +     return 0;
> > +};
> > +
> > +static int rzg2l_cru_buffer_prepare(struct vb2_buffer *vb)
> > +{
> > +     struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vb->vb2_queue);
> > +     unsigned long size = cru->format.sizeimage;
> > +
> > +     if (vb2_plane_size(vb, 0) < size) {
> > +             dev_err(cru->dev, "buffer too small (%lu < %lu)\n",
> > +                     vb2_plane_size(vb, 0), size);
> > +             return -EINVAL;
> > +     }
> > +
> > +     vb2_set_plane_payload(vb, 0, size);
> > +
> > +     return 0;
> > +}
> > +
> > +static void rzg2l_cru_buffer_queue(struct vb2_buffer *vb)
> > +{
> > +     struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> > +     struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vb->vb2_queue);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&cru->qlock, flags);
> > +
> > +     list_add_tail(to_buf_list(vbuf), &cru->buf_list);
> > +
> > +     spin_unlock_irqrestore(&cru->qlock, flags);
> > +}
> > +
> > +static int rzg2l_cru_mc_validate_format(struct rzg2l_cru_dev *cru,
> > +                                     struct v4l2_subdev *sd,
> > +                                     struct media_pad *pad)
> > +{
> > +     struct v4l2_subdev_format fmt = {
> > +             .which = V4L2_SUBDEV_FORMAT_ACTIVE,
> > +     };
> > +
> > +     fmt.pad = pad->index;
> > +     if (v4l2_subdev_call_state_active(sd, pad, get_fmt, &fmt))
> > +             return -EPIPE;
> > +
> > +     if (cru->is_csi) {
> > +             switch (fmt.format.code) {
> > +             case MEDIA_BUS_FMT_UYVY8_1X16:
> > +                     break;
> > +             default:
> > +                     return -EPIPE;
> > +             }
> > +     }
> > +     cru->mbus_code = fmt.format.code;
> > +
> > +     switch (fmt.format.field) {
> > +     case V4L2_FIELD_TOP:
> > +     case V4L2_FIELD_BOTTOM:
> > +     case V4L2_FIELD_NONE:
> > +     case V4L2_FIELD_INTERLACED_TB:
> > +     case V4L2_FIELD_INTERLACED_BT:
> > +     case V4L2_FIELD_INTERLACED:
> > +     case V4L2_FIELD_SEQ_TB:
> > +     case V4L2_FIELD_SEQ_BT:
> > +             break;
> > +     default:
> > +             return -EPIPE;
> > +     }
> > +
> > +     if (fmt.format.width != cru->format.width ||
> > +         fmt.format.height != cru->format.height ||
> > +         fmt.format.code != cru->mbus_code)
> > +             return -EPIPE;
> > +
> > +     return 0;
> > +}
> > +
> > +static void rzg2l_cru_set_slot_addr(struct rzg2l_cru_dev *cru,
> > +                                 int slot, dma_addr_t addr)
> > +{
> > +     const struct v4l2_format_info *fmt;
> > +     int offsetx, offsety;
> > +     dma_addr_t offset;
> > +
> > +     fmt = rzg2l_cru_format_from_pixel(cru->format.pixelformat);
> > +
> > +     /*
> > +      * There is no HW support for composition do the best we can
> > +      * by modifying the buffer offset
> > +      */
> > +     offsetx = cru->compose.left * fmt->bpp[0];
> > +     offsety = cru->compose.top * cru->format.bytesperline;
> > +     offset = addr + offsetx + offsety;
> > +
> > +     /*
> > +      * The address needs to be 512 bytes aligned. Driver should never accept
> > +      * settings that do not satisfy this in the first place...
> > +      */
> > +     if (WARN_ON((offsetx | offsety | offset) & HW_BUFFER_MASK))
> > +             return;
> > +
> > +     /* Currently, we just use the buffer in 32 bits address */
> > +     rzg2l_cru_write(cru, AMnMBxADDRL(slot), offset);
> > +     rzg2l_cru_write(cru, AMnMBxADDRH(slot), 0);
> > +}
> > +
> > +/*
> > + * Moves a buffer from the queue to the HW slot. If no buffer is
> > + * available use the scratch buffer. The scratch buffer is never
> > + * returned to userspace, its only function is to enable the capture
> > + * loop to keep running.
> > + */
> > +static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev *cru, int slot)
> > +{
> > +     struct vb2_v4l2_buffer *vbuf;
> > +     struct rzg2l_cru_buffer *buf;
> > +     dma_addr_t phys_addr;
> > +
> > +     /* A already populated slot shall never be overwritten. */
> > +     if (WARN_ON(cru->queue_buf[slot]))
> > +             return;
> > +
> > +     dev_dbg(cru->dev, "Filling HW slot: %d\n", slot);
> > +
> > +     if (list_empty(&cru->buf_list)) {
> > +             cru->queue_buf[slot] = NULL;
> > +             phys_addr = cru->scratch_phys;
> > +     } else {
> > +             /* Keep track of buffer we give to HW */
> > +             buf = list_entry(cru->buf_list.next,
> > +                              struct rzg2l_cru_buffer, list);
> > +             vbuf = &buf->vb;
> > +             list_del_init(to_buf_list(vbuf));
> > +             cru->queue_buf[slot] = vbuf;
> > +
> > +             /* Setup DMA */
> > +             phys_addr = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> > +     }
> > +
> > +     rzg2l_cru_set_slot_addr(cru, slot, phys_addr);
> > +}
> > +
> > +static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
> > +{
> > +     unsigned int slot;
> > +
> > +     /*
> > +      * Set image data memory banks.
> > +      * Currently, we will use maximum address.
> > +      */
> > +     rzg2l_cru_write(cru, AMnMBVALID, AMnMBVALID_MBVALID(cru->num_buf - 1));
> > +
> > +     for (slot = 0; slot < cru->num_buf; slot++)
> > +             rzg2l_cru_fill_hw_slot(cru, slot);
> > +}
> > +
> > +static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru)
> > +{
> > +     u32 icnmc;
> > +
> > +     switch (cru->mbus_code) {
> > +     case MEDIA_BUS_FMT_UYVY8_1X16:
> > +             icnmc = ICnMC_INF_YUV8_422;
> > +             cru->input_is_yuv = true;
> > +             break;
> > +     default:
> > +             cru->input_is_yuv = false;
> > +             icnmc = ICnMC_INF_USER;
> > +             break;
> > +     }
> > +
> > +     icnmc |= (rzg2l_cru_read(cru, ICnMC) & ~ICnMC_INF_MASK);
> > +
> > +     /* Set virtual channel CSI2 */
> > +     icnmc |= ICnMC_VCSEL(cru->csi.channel);
> > +
> > +     rzg2l_cru_write(cru, ICnMC, icnmc);
> > +}
> > +
> > +static int rzg2l_cru_initialize_image_conv(struct rzg2l_cru_dev *cru)
> > +{
> > +     u32 icndmr;
> > +
> > +     if (cru->is_csi)
> > +             rzg2l_cru_csi2_setup(cru);
> > +
> > +     /* Output format */
> > +     switch (cru->format.pixelformat) {
> > +     case V4L2_PIX_FMT_UYVY:
> > +             icndmr = ICnDMR_YCMODE_UYVY;
> > +             cru->output_is_yuv = true;
> > +             break;
> > +     default:
> > +             dev_err(cru->dev, "Invalid pixelformat (0x%x)\n",
> > +                     cru->format.pixelformat);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* If input and output use same colorspace, do bypass mode */
> > +     if (cru->output_is_yuv == cru->input_is_yuv)
> > +             rzg2l_cru_write(cru, ICnMC,
> > +                             rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
> > +     else
> > +             rzg2l_cru_write(cru, ICnMC,
> > +                             rzg2l_cru_read(cru, ICnMC) & (~ICnMC_CSCTHR));
> > +
> > +     /* Set output data format */
> > +     rzg2l_cru_write(cru, ICnDMR, icndmr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
> > +{
> > +     struct rzg2l_csi2 *csi2 = sd_to_csi2(cru->csi.subdev);
> > +     struct media_pipeline *pipe;
> > +     struct v4l2_subdev *sd;
> > +     struct media_pad *pad;
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     pad = media_pad_remote_pad_first(&cru->pad);
> > +     if (!pad)
> > +             return -EPIPE;
> > +
> > +     sd = media_entity_to_v4l2_subdev(pad->entity);
> > +
> > +     if (!on) {
> > +             media_pipeline_stop(&cru->vdev.entity);
> > +             return v4l2_subdev_call(sd, video, s_stream, 0);
> > +     }
> > +
> > +     ret = rzg2l_cru_mc_validate_format(cru, sd, pad);
> > +     if (ret)
> > +             return ret;
> > +
> > +     rzg2l_csi2_dphy_setting(csi2, 1);
> > +
> > +     spin_lock_irqsave(&cru->qlock, flags);
> > +
> > +     /* Select a video input */
> > +     if (cru->is_csi)
> > +             rzg2l_cru_write(cru, CRUnCTRL, CRUnCTRL_VINSEL(0));
> > +
> > +     /* Cancel the software reset for image processing block */
> > +     rzg2l_cru_write(cru, CRUnRST, CRUnRST_VRESETN);
> > +
> > +     /* Disable and clear the interrupt before using */
> > +     rzg2l_cru_write(cru, CRUnIE, 0);
> > +     rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
> > +
> > +     /* Initialize the AXI master */
> > +     rzg2l_cru_initialize_axi(cru);
> > +
> > +     /* Initialize image convert */
> > +     ret = rzg2l_cru_initialize_image_conv(cru);
> > +     if (ret) {
> > +             spin_unlock_irqrestore(&cru->qlock, flags);
> > +             return ret;
> > +     }
> > +
> > +     /* Enable interrupt */
> > +     rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
> > +
> > +     /* Enable image processing reception */
> > +     rzg2l_cru_write(cru, ICnEN, ICnEN_ICEN);
> > +
> > +     spin_unlock_irqrestore(&cru->qlock, flags);
> > +
> > +     pipe = sd->entity.pipe ? sd->entity.pipe : &cru->vdev.pipe;
> > +     ret = media_pipeline_start(&cru->vdev.entity, pipe);
> > +     if (ret)
> > +             return ret;
> > +
> > +     clk_disable_unprepare(cru->vclk);
> > +
> > +     rzg2l_csi2_mipi_link_setting(csi2, 1);
> > +
> > +     ret = clk_prepare_enable(cru->vclk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     rzg2l_csi2_cmn_rstb_deassert(csi2);
> > +
> > +     ret = v4l2_subdev_call(sd, video, s_stream, 1);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +     if (ret)
> > +             media_pipeline_stop(&cru->vdev.entity);
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_cru_stop_streaming(struct rzg2l_cru_dev *cru)
> > +{
> > +     struct rzg2l_csi2 *csi2 = sd_to_csi2(cru->csi.subdev);
> > +     u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
> > +     unsigned int retries = 0;
> > +     unsigned long flags;
> > +     u32 icnms;
> > +
> > +     cru->state = RZG2L_CRU_DMA_STOPPING;
> > +
> > +     rzg2l_cru_set_stream(cru, 0);
> > +
> > +     rzg2l_csi2_dphy_setting(csi2, 0);
> > +
> > +     rzg2l_csi2_mipi_link_setting(csi2, 0);
> > +
> > +     spin_lock_irqsave(&cru->qlock, flags);
> > +
> > +     /* Disable and clear the interrupt */
> > +     rzg2l_cru_write(cru, CRUnIE, 0);
> > +     rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
> > +
> > +     /* Stop the operation of image conversion */
> > +     rzg2l_cru_write(cru, ICnEN, 0);
> > +
> > +     /* Wait for streaming to stop */
> > +     while ((rzg2l_cru_read(cru, ICnMS) & ICnMS_IA) && retries++ < RZG2L_RETRIES) {
> > +             spin_unlock_irqrestore(&cru->qlock, flags);
> > +             msleep(RZG2L_TIMEOUT_MS);
> > +             spin_lock_irqsave(&cru->qlock, flags);
> > +     }
> > +
> > +     icnms = rzg2l_cru_read(cru, ICnMS) & ICnMS_IA;
> > +     if (icnms)
> > +             dev_err(cru->dev, "Failed stop HW, something is seriously broken\n");
> > +
> > +     cru->state = RZG2L_CRU_DMA_STOPPED;
> > +
> > +     /* Wait until the FIFO becomes empty */
> > +     for (retries = 5; retries > 0; retries--) {
> > +             amnfifopntr = rzg2l_cru_read(cru, AMnFIFOPNTR);
> > +
> > +             amnfifopntr_w = amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
> > +             amnfifopntr_r_y =
> > +                     (amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
> > +             if (amnfifopntr_w == amnfifopntr_r_y)
> > +                     break;
> > +
> > +             usleep_range(10, 20);
> > +     }
> > +
> > +     /* Notify that FIFO is not empty here */
> > +     if (!retries)
> > +             dev_err(cru->dev, "Failed to empty FIFO\n");
> > +
> > +     /* Stop AXI bus */
> > +     rzg2l_cru_write(cru, AMnAXISTP, AMnAXISTP_AXI_STOP);
> > +
> > +     /* Wait until the AXI bus stop */
> > +     for (retries = 5; retries > 0; retries--) {
> > +             if (rzg2l_cru_read(cru, AMnAXISTPACK) &
> > +                     AMnAXISTPACK_AXI_STOP_ACK)
> > +                     break;
> > +
> > +             usleep_range(10, 20);
> > +     };
> > +
> > +     /* Notify that AXI bus can not stop here */
> > +     if (!retries)
> > +             dev_err(cru->dev, "Failed to stop AXI bus\n");
> > +
> > +     /* Cancel the AXI bus stop request */
> > +     rzg2l_cru_write(cru, AMnAXISTP, 0);
> > +
> > +     /* Resets the image processing module */
> > +     rzg2l_cru_write(cru, CRUnRST, 0);
> > +
> > +     spin_unlock_irqrestore(&cru->qlock, flags);
> > +
> > +     /* Set reset state */
> > +     reset_control_assert(cru->aresetn);
> > +}
> > +
> > +static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int count)
> > +{
> > +     struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
> > +     int ret;
> > +
> > +     /* Release reset state */
> > +     ret = reset_control_deassert(cru->aresetn);
> > +     if (ret) {
> > +             dev_err(cru->dev, "failed to deassert aresetn\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Allocate scratch buffer. */
> > +     cru->scratch = dma_alloc_coherent(cru->dev, cru->format.sizeimage,
> > +                                       &cru->scratch_phys, GFP_KERNEL);
> > +     if (!cru->scratch) {
> > +             return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
> > +             dev_err(cru->dev, "Failed to allocate scratch buffer\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     cru->sequence = 0;
> > +
> > +     ret = rzg2l_cru_set_stream(cru, 1);
> > +     if (ret) {
> > +             return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
> > +             goto out;
> > +     }
> > +
> > +     cru->state = RZG2L_CRU_DMA_STARTING;
> > +
> > +     dev_dbg(cru->dev, "Starting to capture\n");
> > +
> > +out:
> > +     if (ret)
> > +             dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
> > +                               cru->scratch_phys);
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq)
> > +{
> > +     struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
> > +
> > +     rzg2l_cru_stop_streaming(cru);
> > +
> > +     /* Free scratch buffer */
> > +     dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
> > +                       cru->scratch_phys);
> > +
> > +     return_unused_buffers(cru, VB2_BUF_STATE_ERROR);
> > +}
> > +
> > +static const struct vb2_ops rzg2l_cru_qops = {
> > +     .queue_setup            = rzg2l_cru_queue_setup,
> > +     .buf_prepare            = rzg2l_cru_buffer_prepare,
> > +     .buf_queue              = rzg2l_cru_buffer_queue,
> > +     .start_streaming        = rzg2l_cru_start_streaming_vq,
> > +     .stop_streaming         = rzg2l_cru_stop_streaming_vq,
> > +     .wait_prepare           = vb2_ops_wait_prepare,
> > +     .wait_finish            = vb2_ops_wait_finish,
> > +};
> > +
> > +static irqreturn_t rzg2l_cru_irq(int irq, void *data)
> > +{
> > +     struct rzg2l_cru_dev *cru = data;
> > +     unsigned int handled = 0;
> > +     unsigned long flags;
> > +     u32 irq_status;
> > +     u32 amnmbs;
> > +     int slot;
> > +
> > +     spin_lock_irqsave(&cru->qlock, flags);
> > +
> > +     irq_status = rzg2l_cru_read(cru, CRUnINTS);
> > +     if (!irq_status)
> > +             goto done;
> > +
> > +     handled = 1;
> > +
> > +     rzg2l_cru_write(cru, CRUnINTS, rzg2l_cru_read(cru, CRUnINTS));
> > +
> > +     /* Nothing to do if capture status is 'RZG2L_CRU_DMA_STOPPED' */
> > +     if (cru->state == RZG2L_CRU_DMA_STOPPED) {
> > +             dev_dbg(cru->dev, "IRQ while state stopped\n");
> > +             goto done;
> > +     }
> > +
> > +     /* Increase stop retries if capture status is 'RZG2L_CRU_DMA_STOPPING' */
> > +     if (cru->state == RZG2L_CRU_DMA_STOPPING) {
> > +             if (irq_status & CRUnINTS_SFS)
> > +                     dev_dbg(cru->dev, "IRQ while state stopping\n");
> > +             goto done;
> > +     }
> > +
> > +     /* Prepare for capture and update state */
> > +     amnmbs = rzg2l_cru_read(cru, AMnMBS);
> > +     slot = amnmbs & AMnMBS_MBSTS;
> > +
> > +     /*
> > +      * AMnMBS.MBSTS indicates the destination of Memory Bank (MB).
> > +      * Recalculate to get the current transfer complete MB.
> > +      */
> > +     if (slot == 0)
> > +             slot = cru->num_buf - 1;
> > +     else
> > +             slot--;
> > +
> > +     /*
> > +      * To hand buffers back in a known order to userspace start
> > +      * to capture first from slot 0.
> > +      */
> > +     if (cru->state == RZG2L_CRU_DMA_STARTING) {
> > +             if (slot != 0) {
> > +                     dev_dbg(cru->dev, "Starting sync slot: %d\n", slot);
> > +                     goto done;
> > +             }
> > +
> > +             dev_dbg(cru->dev, "Capture start synced!\n");
> > +             cru->state = RZG2L_CRU_DMA_RUNNING;
> > +     }
> > +
> > +     /* Capture frame */
> > +     if (cru->queue_buf[slot]) {
> > +             cru->queue_buf[slot]->field = cru->format.field;
> > +             cru->queue_buf[slot]->sequence = cru->sequence;
> > +             cru->queue_buf[slot]->vb2_buf.timestamp = ktime_get_ns();
> > +             vb2_buffer_done(&cru->queue_buf[slot]->vb2_buf,
> > +                             VB2_BUF_STATE_DONE);
> > +             cru->queue_buf[slot] = NULL;
> > +     } else {
> > +             /* Scratch buffer was used, dropping frame. */
> > +             dev_dbg(cru->dev, "Dropping frame %u\n", cru->sequence);
> > +     }
> > +
> > +     cru->sequence++;
> > +
> > +     /* Prepare for next frame */
> > +     rzg2l_cru_fill_hw_slot(cru, slot);
> > +
> > +done:
> > +     spin_unlock_irqrestore(&cru->qlock, flags);
> > +
> > +     return IRQ_RETVAL(handled);
> > +}
> > +
> > +void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru)
> > +{
> > +     mutex_destroy(&cru->lock);
> > +
> > +     v4l2_device_unregister(&cru->v4l2_dev);
> > +     reset_control_assert(cru->presetn);
> > +}
> > +
> > +int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru, int irq)
> > +{
> > +     struct vb2_queue *q = &cru->queue;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ret = reset_control_deassert(cru->presetn);
> > +     if (ret) {
> > +             dev_err(cru->dev, "failed to deassert presetn\n");
> > +             return ret;
> > +     }
>
> Shouldn't this be done when starting streaming instead ?
>
Agreed, Ill move it there.

> > +
> > +     /* Initialize the top-level structure */
> > +     ret = v4l2_device_register(cru->dev, &cru->v4l2_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_init(&cru->lock);
> > +     INIT_LIST_HEAD(&cru->buf_list);
> > +
> > +     spin_lock_init(&cru->qlock);
> > +
> > +     cru->state = RZG2L_CRU_DMA_STOPPED;
> > +
> > +     for (i = 0; i < HW_BUFFER_MAX; i++)
> > +             cru->queue_buf[i] = NULL;
> > +
> > +     /* buffer queue */
> > +     q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > +     q->io_modes = VB2_MMAP | VB2_READ | VB2_DMABUF;
>
> No VB2_READ please, that's very inefficient.
>
OK, I'll drop it.

> > +     q->lock = &cru->lock;
> > +     q->drv_priv = cru;
> > +     q->buf_struct_size = sizeof(struct rzg2l_cru_buffer);
> > +     q->ops = &rzg2l_cru_qops;
> > +     q->mem_ops = &vb2_dma_contig_memops;
> > +     q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> > +     q->min_buffers_needed = 4;
>
> Does the hardware really require 4 buffers to operate ?
>
v4l2-compliance complains about sequnce mismatch when set to 3.

> > +     q->dev = cru->dev;
> > +
> > +     ret = vb2_queue_init(q);
> > +     if (ret < 0) {
> > +             dev_err(cru->dev, "failed to initialize VB2 queue\n");
> > +             goto error;
> > +     }
> > +
> > +     /* IRQ */
> > +     ret = devm_request_irq(cru->dev, irq, rzg2l_cru_irq, IRQF_SHARED,
> > +                            KBUILD_MODNAME, cru);
> > +     if (ret) {
> > +             dev_err(cru->dev, "failed to request irq\n");
> > +             goto error;
> > +     }
> > +
> > +     return 0;
> > +
> > +error:
> > +     rzg2l_cru_dma_unregister(cru);
> > +     return ret;
> > +}
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
> > new file mode 100644
> > index 000000000000..c565597f5769
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
> > @@ -0,0 +1,368 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for Renesas RZ/G2L CRU
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + *
> > + * Based on Renesas R-Car VIN
> > + * Copyright (C) 2016 Renesas Electronics Corp.
> > + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> > + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> > + * Copyright (C) 2008 Magnus Damm
> > + */
> > +
> > +#include <linux/clk.h>
> > +
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-mc.h>
> > +#include <media/v4l2-rect.h>
> > +
> > +#include "rzg2l-cru.h"
> > +
> > +#define RZG2L_CRU_DEFAULT_FORMAT     V4L2_PIX_FMT_UYVY
> > +#define RZG2L_CRU_DEFAULT_WIDTH              800
> > +#define RZG2L_CRU_DEFAULT_HEIGHT     600
> > +#define RZG2L_CRU_DEFAULT_FIELD              V4L2_FIELD_NONE
> > +#define RZG2L_CRU_DEFAULT_COLORSPACE V4L2_COLORSPACE_SRGB
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Format Conversions
> > + */
> > +
> > +static const struct v4l2_format_info rzg2l_cru_formats[] = {
> > +     {
> > +             .format = V4L2_PIX_FMT_UYVY,
> > +             .bpp[0] = 2,
> > +     },
> > +};
> > +
> > +const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(rzg2l_cru_formats); i++)
> > +             if (rzg2l_cru_formats[i].format == format)
> > +                     return rzg2l_cru_formats + i;
> > +
> > +     return NULL;
> > +}
> > +
> > +static u32 rzg2l_cru_format_bytesperline(struct v4l2_pix_format *pix)
> > +{
> > +     const struct v4l2_format_info *fmt;
> > +
> > +     fmt = rzg2l_cru_format_from_pixel(pix->pixelformat);
> > +
> > +     if (WARN_ON(!fmt))
> > +             return -EINVAL;
> > +
> > +     return pix->width * fmt->bpp[0];
> > +}
> > +
> > +static u32 rzg2l_cru_format_sizeimage(struct v4l2_pix_format *pix)
> > +{
> > +     return pix->bytesperline * pix->height;
> > +}
> > +
> > +static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
> > +                                struct v4l2_pix_format *pix)
> > +{
> > +     if (!rzg2l_cru_format_from_pixel(pix->pixelformat))
> > +             pix->pixelformat = RZG2L_CRU_DEFAULT_FORMAT;
> > +
> > +     switch (pix->field) {
> > +     case V4L2_FIELD_TOP:
> > +     case V4L2_FIELD_BOTTOM:
> > +     case V4L2_FIELD_NONE:
> > +     case V4L2_FIELD_INTERLACED_TB:
> > +     case V4L2_FIELD_INTERLACED_BT:
> > +     case V4L2_FIELD_INTERLACED:
> > +             break;
> > +     default:
> > +             pix->field = RZG2L_CRU_DEFAULT_FIELD;
> > +             break;
> > +     }
> > +
> > +     /* Limit to CRU capabilities */
> > +     v4l_bound_align_image(&pix->width, 320, CRU_MAX_INPUT_WIDTH, 1,
> > +                           &pix->height, 240, CRU_MAX_INPUT_HEIGHT, 2, 0);
> > +
> > +     pix->bytesperline = rzg2l_cru_format_bytesperline(pix);
> > +     pix->sizeimage = rzg2l_cru_format_sizeimage(pix);
> > +
> > +     dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
> > +             pix->width, pix->height, pix->bytesperline, pix->sizeimage);
> > +}
> > +
> > +static void rzg2l_cru_try_format(struct rzg2l_cru_dev *cru,
> > +                              struct v4l2_pix_format *pix)
> > +{
> > +     /*
> > +      * The V4L2 specification clearly documents the colorspace fields
> > +      * as being set by drivers for capture devices. Using the values
> > +      * supplied by userspace thus wouldn't comply with the API. Until
> > +      * the API is updated force fixed values.
> > +      */
> > +     pix->colorspace = RZG2L_CRU_DEFAULT_COLORSPACE;
> > +     pix->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix->colorspace);
> > +     pix->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colorspace);
> > +     pix->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true, pix->colorspace,
> > +                                                       pix->ycbcr_enc);
> > +
> > +     rzg2l_cru_format_align(cru, pix);
> > +}
> > +
> > +static int rzg2l_cru_querycap(struct file *file, void *priv,
> > +                           struct v4l2_capability *cap)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +
> > +     strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
> > +     strscpy(cap->card, "RZG2L_CRU", sizeof(cap->card));
> > +     snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
> > +              dev_name(cru->dev));
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_try_fmt_vid_cap(struct file *file, void *priv,
> > +                                  struct v4l2_format *f)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +
> > +     rzg2l_cru_try_format(cru, &f->fmt.pix);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_s_fmt_vid_cap(struct file *file, void *priv,
> > +                                struct v4l2_format *f)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +
> > +     if (vb2_is_busy(&cru->queue))
> > +             return -EBUSY;
> > +
> > +     rzg2l_cru_try_format(cru, &f->fmt.pix);
> > +
> > +     cru->format = f->fmt.pix;
> > +
> > +     cru->compose.top = 0;
> > +     cru->compose.left = 0;
> > +     cru->compose.width = cru->format.width;
> > +     cru->compose.height = cru->format.height;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_g_fmt_vid_cap(struct file *file, void *priv,
> > +                                struct v4l2_format *f)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +
> > +     f->fmt.pix = cru->format;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_enum_fmt_vid_cap(struct file *file, void *priv,
> > +                                   struct v4l2_fmtdesc *f)
> > +{
> > +     if (f->index >= ARRAY_SIZE(rzg2l_cru_formats))
> > +             return -EINVAL;
> > +
> > +     f->pixelformat = rzg2l_cru_formats[f->index].format;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_subscribe_event(struct v4l2_fh *fh,
> > +                                  const struct v4l2_event_subscription *sub)
> > +{
> > +     switch (sub->type) {
> > +     case V4L2_EVENT_SOURCE_CHANGE:
> > +             return v4l2_event_subscribe(fh, sub, 4, NULL);
> > +     }
> > +     return v4l2_ctrl_subscribe_event(fh, sub);
> > +}
> > +
> > +static const struct v4l2_ioctl_ops rzg2l_cru_ioctl_ops = {
> > +     .vidioc_querycap                = rzg2l_cru_querycap,
> > +     .vidioc_try_fmt_vid_cap         = rzg2l_cru_try_fmt_vid_cap,
> > +     .vidioc_g_fmt_vid_cap           = rzg2l_cru_g_fmt_vid_cap,
> > +     .vidioc_s_fmt_vid_cap           = rzg2l_cru_s_fmt_vid_cap,
> > +     .vidioc_enum_fmt_vid_cap        = rzg2l_cru_enum_fmt_vid_cap,
> > +
> > +     .vidioc_reqbufs                 = vb2_ioctl_reqbufs,
> > +     .vidioc_create_bufs             = vb2_ioctl_create_bufs,
> > +     .vidioc_querybuf                = vb2_ioctl_querybuf,
> > +     .vidioc_qbuf                    = vb2_ioctl_qbuf,
> > +     .vidioc_dqbuf                   = vb2_ioctl_dqbuf,
> > +     .vidioc_expbuf                  = vb2_ioctl_expbuf,
> > +     .vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
> > +     .vidioc_streamon                = vb2_ioctl_streamon,
> > +     .vidioc_streamoff               = vb2_ioctl_streamoff,
> > +
> > +     .vidioc_log_status              = v4l2_ctrl_log_status,
> > +     .vidioc_subscribe_event         = rzg2l_cru_subscribe_event,
> > +     .vidioc_unsubscribe_event       = v4l2_event_unsubscribe,
> > +};
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Media controller file operations
> > + */
> > +
> > +static int rzg2l_cru_open(struct file *file)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +     int ret;
> > +
> > +     ret = clk_prepare_enable(cru->pclk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = clk_prepare_enable(cru->vclk);
> > +     if (ret)
> > +             goto disable_pclk;
> > +
> > +     ret = clk_prepare_enable(cru->aclk);
> > +     if (ret)
> > +             goto disable_vclk;
> > +
> > +     ret = mutex_lock_interruptible(&cru->lock);
> > +     if (ret)
> > +             goto disable_aclk;
> > +
> > +     file->private_data = cru;
> > +     ret = v4l2_fh_open(file);
> > +     if (ret)
> > +             goto err_unlock;
> > +
> > +     ret = v4l2_pipeline_pm_get(&cru->vdev.entity);
> > +     if (ret < 0)
> > +             goto err_open;
> > +
> > +     mutex_unlock(&cru->lock);
> > +
> > +     return 0;
> > +err_open:
> > +     v4l2_fh_release(file);
> > +err_unlock:
> > +     mutex_unlock(&cru->lock);
> > +disable_aclk:
> > +     clk_disable_unprepare(cru->aclk);
> > +disable_vclk:
> > +     clk_disable_unprepare(cru->vclk);
> > +disable_pclk:
> > +     clk_disable_unprepare(cru->pclk);
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_cru_release(struct file *file)
> > +{
> > +     struct rzg2l_cru_dev *cru = video_drvdata(file);
> > +     int ret;
> > +
> > +     mutex_lock(&cru->lock);
> > +
> > +     /* the release helper will cleanup any on-going streaming. */
> > +     ret = _vb2_fop_release(file, NULL);
> > +
> > +     v4l2_pipeline_pm_put(&cru->vdev.entity);
> > +     clk_disable_unprepare(cru->aclk);
> > +     clk_disable_unprepare(cru->vclk);
> > +     clk_disable_unprepare(cru->pclk);
> > +
> > +     mutex_unlock(&cru->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct v4l2_file_operations rzg2l_cru_fops = {
> > +     .owner          = THIS_MODULE,
> > +     .unlocked_ioctl = video_ioctl2,
> > +     .open           = rzg2l_cru_open,
> > +     .release        = rzg2l_cru_release,
> > +     .poll           = vb2_fop_poll,
> > +     .mmap           = vb2_fop_mmap,
> > +     .read           = vb2_fop_read,
> > +};
> > +
> > +void rzg2l_cru_v4l2_unregister(struct rzg2l_cru_dev *cru)
> > +{
> > +     if (!video_is_registered(&cru->vdev))
> > +             return;
> > +
> > +     v4l2_info(&cru->v4l2_dev, "Removed %s\n",
> > +               video_device_node_name(&cru->vdev));
>
> You can use dev_info(), but I'd actually use dev_dbg(). Same below.
>
OK, I will switch to dev_dbg().

> > +
> > +     /* Checks internally if vdev have been init or not */
> > +     video_unregister_device(&cru->vdev);
> > +}
> > +
> > +static void rzg2l_cru_notify(struct v4l2_subdev *sd,
> > +                          unsigned int notification, void *arg)
> > +{
> > +     struct rzg2l_cru_dev *cru =
> > +             container_of(sd->v4l2_dev, struct rzg2l_cru_dev, v4l2_dev);
> > +     struct v4l2_subdev *remote;
> > +     struct media_pad *pad;
> > +
> > +     pad = media_pad_remote_pad_first(&cru->pad);
> > +     if (!pad)
> > +             return;
> > +
> > +     remote = media_entity_to_v4l2_subdev(pad->entity);
> > +     if (remote != sd)
> > +             return;
> > +
> > +     switch (notification) {
> > +     case V4L2_DEVICE_NOTIFY_EVENT:
> > +             v4l2_event_queue(&cru->vdev, arg);
> > +             break;
> > +     }
> > +}
>
> Drop this, userspace should listen for events on the subdevices that
> generate them.
>
OK so in that case I can completely get rid of rzg2l_cru_notify().

> > +
> > +int rzg2l_cru_v4l2_register(struct rzg2l_cru_dev *cru)
> > +{
> > +     struct video_device *vdev = &cru->vdev;
> > +     int ret;
> > +
> > +     cru->v4l2_dev.notify = rzg2l_cru_notify;
> > +
> > +     /* video node */
> > +     vdev->v4l2_dev = &cru->v4l2_dev;
> > +     vdev->queue = &cru->queue;
> > +     snprintf(vdev->name, sizeof(vdev->name), "CRU output");
> > +     vdev->release = video_device_release_empty;
> > +     vdev->lock = &cru->lock;
> > +     vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
> > +                         V4L2_CAP_READWRITE;
>
> No read/write please.
>
OK, I will drop it.

> > +
> > +     /* Set a default format */
> > +     cru->format.pixelformat = RZG2L_CRU_DEFAULT_FORMAT;
> > +     cru->format.width = RZG2L_CRU_DEFAULT_WIDTH;
> > +     cru->format.height = RZG2L_CRU_DEFAULT_HEIGHT;
> > +     cru->format.field = RZG2L_CRU_DEFAULT_FIELD;
> > +     cru->format.colorspace = RZG2L_CRU_DEFAULT_COLORSPACE;
> > +
> > +     vdev->device_caps |= V4L2_CAP_IO_MC;
> > +     vdev->fops = &rzg2l_cru_fops;
> > +     vdev->ioctl_ops = &rzg2l_cru_ioctl_ops;
> > +
> > +     rzg2l_cru_format_align(cru, &cru->format);
>
> I'd perform all this initialization in an init function called at probe
> time, with only the actual registration left here, to be done at bound
> time.
>
Agrreed, Ill create a rzg2l_cru_v4l2_init() for it.


Cheers,
Prabhakar
