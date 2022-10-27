Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A09610114
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiJ0TFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiJ0TFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:05:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0646D94;
        Thu, 27 Oct 2022 12:05:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t25so7372242ejb.8;
        Thu, 27 Oct 2022 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgWWVYiYg4DsJHKbNx1DTZxWa/M/7TWzafl01hWoYrI=;
        b=pZPiYBHYaVunFDCio+fsHSfpVEwU+UMuk0fO8o/z+KNl+DMrYQZIWDX/lssj403o1g
         E2fFn2XxGkzJlRtF03H+AeWQMsvuw+VRcRlAqD7Yv3xntLN1G9LaUtHPY3Vpx7glnGOk
         DYsLK2w8GZ0jdFR5Wpem4/KTm2A3k+Zna8Er9tR75fM6D9Z7LGJ5F/HKafw8sc0Adb3R
         zwGJYv5Ql9PSXuhLR1k8ySlRlBqqaJVMGnyzbkoTT4u4AvpiQ6/yrv1rIGF5ykYMObMS
         Tjvy0dSpV+UtDKnK+Ey6ROwSeij0mBn80d0kLolGSkSCt79r8IMj8hVNwyW2dxsLgjhy
         57OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgWWVYiYg4DsJHKbNx1DTZxWa/M/7TWzafl01hWoYrI=;
        b=JofzC2uxnbIpQs911FqKMpJHxtAuqjelZiCMvHKDrIicHdgYUwsCy/FWcA2R1MRhVV
         VZ6O9sgk48Qb5hpMmdM8ba72unnYBoYcjDdonPvoDWW6xxM9xVe2lKNUqyj+LRVrWV/5
         esJMsN4a9HDncQyLXaRqKhy1qCeKuSV4E5C78Z+avq/FeVQnHmD1naoLWaxWz41VXfxY
         5RBZVkYMd/XipMgGGGubZxyAfIan94hxo4DKSRifNu1yOW6YrNUH0ENitAmYGEE33S/z
         n5QPOxVgA29nE/5I6eK8Ic0dEyz4UuQhUytYqj5p/w8NmjgUOne5RWs3xso4TY7ezSo/
         tIZQ==
X-Gm-Message-State: ACrzQf16EEEi23uYk5Rp45A+lU+djMxAVg11edf6PGH85JkD02WRb7px
        4YhCIi5NfkUFNG1iqszNw4nzjVMSViyDgd6t088=
X-Google-Smtp-Source: AMsMyM7ROzLZDEVXQwvfx8kk42u85P9NWUQJXvHGwT3noqEANhha79AIG0oolaTgAycy+mNpiSDb8TKpDxuPGIkTJ6E=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr43091480ejb.80.1666897507562; Thu, 27
 Oct 2022 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221027103104.74576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221027103104.74576-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y1qCbUoLrR6qlQwa@paasikivi.fi.intel.com>
In-Reply-To: <Y1qCbUoLrR6qlQwa@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Oct 2022 20:04:40 +0100
Message-ID: <CA+V-a8seroka4YkyCnSYa2KMPDWMG1Zk8tyiqRntdPUQnc+nrA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thank you for the quick review.

On Thu, Oct 27, 2022 at 2:07 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the quick update. A few more pre_streamon/post_streamoff
> comments plus more I missed earlier.
>
> On Thu, Oct 27, 2022 at 11:31:04AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> >
> > Based on a patch in the BSP by Hien Huynh
> > <hien.huynh.px@renesas.com>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3 -> v4
> > * Undoing the configuration in case s_stream(1) fails
> > * Made sure we call post_streamoff in the error path of s_stream(1)
> >
> > v2 -> v3
> > * Switched to PM runtime
> > * Modeled CRU IP block as a subdev
> > * Dropped explicitly selecting VIDEO_RZG2L_CSI2 for VIDEO_RZG2L_CRU config
> > * Replaced v4l2_dev_to_cru macro with inline function notifier_to_cru()
> > * Dropped id parameter from rvin_mc_parse_of()
> > * Renamed rzg2l_cru_csi2_init() -> rzg2l_cru_media_init()
> > * Used dev_err_probe() in rzg2l_cru_probe()
> > * Replaced devm_reset_control_get() -> devm_reset_control_get_exclusive()
> > * Prefixed HW_BUFFER_MAX and HW_BUFFER_DEFAULT macros with RZG2L_CRU_
> > * Moved asserting presetn signal from rzg2l_cru_dma_register() to rzg2l_cru_start_streaming_vq()
> > * Dropped VB2_READ from VB2 io_modes
> > * Used dev_dbg() in rzg2l_cru_video_register() and rzg2l_cru_video_unregister()
> > * Got rid of rzg2l_cru_notify()
> > * Dropped V4L2_CAP_READWRITE from device caps
> > * Introduced rzg2l_cru_v4l2_init() for initialization.
> > * Got rid v4l2_pipeline_pm_get() and used PM in ov5645 sensor driver. Patch posted
> >   https://patchwork.linuxtv.org/project/linux-media/patch/20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
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
> >  .../media/platform/renesas/rzg2l-cru/Kconfig  |   16 +
> >  .../media/platform/renesas/rzg2l-cru/Makefile |    3 +
> >  .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  372 ++++++
> >  .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  163 +++
> >  .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  277 +++++
> >  .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 1087 +++++++++++++++++
> >  6 files changed, 1918 insertions(+)
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
> >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> >
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > index 57c40bb499df..b39818c1f053 100644
> > --- a/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > @@ -15,3 +15,19 @@ config VIDEO_RZG2L_CSI2
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
> > +     select VIDEO_V4L2_SUBDEV_API
> > +     help
> > +       Support for Renesas RZ/G2L (and alike SoC's) Camera Receiving
> > +       Unit (CRU) driver.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called rzg2l-cru.
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > index 91ea97a944e6..c4db2632874f 100644
> > --- a/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > @@ -1,3 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_VIDEO_RZG2L_CSI2) += rzg2l-csi2.o
> > +
> > +rzg2l-cru-objs = rzg2l-core.o rzg2l-ip.o rzg2l-video.o
> > +obj-$(CONFIG_VIDEO_RZG2L_CRU) += rzg2l-cru.o
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > new file mode 100644
> > index 000000000000..bd78f84428ff
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > @@ -0,0 +1,372 @@
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
> > +static inline struct rzg2l_cru_dev *notifier_to_cru(struct v4l2_async_notifier *n)
> > +{
> > +     return container_of(n, struct rzg2l_cru_dev, notifier);
> > +}
> > +
> > +static int rzg2l_cru_csi2_link_notify(struct media_link *link, u32 flags,
> > +                                   unsigned int notification)
> > +{
> > +     struct media_entity *entity;
> > +     struct rzg2l_cru_dev *cru;
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
> > +     if (media_pad_remote_pad_first(&cru->vdev.entity.pads[0]))
> > +             ret = -EMLINK;
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
> > +     struct rzg2l_cru_dev *cru = notifier_to_cru(notifier);
> > +     struct media_entity *source, *sink;
> > +     int ret;
> > +
> > +     ret = media_device_register(&cru->mdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = rzg2l_cru_ip_subdev_register(cru);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = v4l2_device_register_subdev_nodes(&cru->v4l2_dev);
> > +     if (ret) {
> > +             dev_err(cru->dev, "Failed to register subdev nodes\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = rzg2l_cru_video_register(cru);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * CRU can be connected either to CSI2 or PARALLEL device
> > +      * For now we are only supporting CSI2
> > +      *
> > +      * Create media device link between CSI-2 <-> CRU IP
> > +      */
> > +     source = &cru->csi.subdev->entity;
> > +     sink = &cru->ip.subdev.entity;
> > +     ret = media_create_pad_link(source, 1, sink, 0, 0);
> > +     if (ret) {
> > +             dev_err(cru->dev, "Error creating link from %s to %s\n",
> > +                     source->name, sink->name);
> > +             return ret;
> > +     }
> > +
> > +     /* Create media device link between CRU IP <-> CRU OUTPUT */
> > +     source = &cru->ip.subdev.entity;
> > +     sink = &cru->vdev.entity;
> > +     ret = media_create_pad_link(source, 1, sink, 0, 0);
> > +     if (ret) {
> > +             dev_err(cru->dev, "Error creating link from %s to %s\n",
> > +                     source->name, sink->name);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void rzg2l_cru_group_notify_unbind(struct v4l2_async_notifier *notifier,
> > +                                       struct v4l2_subdev *subdev,
> > +                                       struct v4l2_async_subdev *asd)
> > +{
> > +     struct rzg2l_cru_dev *cru = notifier_to_cru(notifier);
> > +
> > +     rzg2l_cru_ip_subdev_unregister(cru);
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
> > +     struct rzg2l_cru_dev *cru = notifier_to_cru(notifier);
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
> > +static int rzg2l_cru_mc_parse_of(struct rzg2l_cru_dev *cru)
> > +{
> > +     struct v4l2_fwnode_endpoint vep = {
> > +             .bus_type = V4L2_MBUS_CSI2_DPHY,
> > +     };
> > +     struct fwnode_handle *ep, *fwnode;
> > +     struct v4l2_async_subdev *asd;
> > +     int ret;
> > +
> > +     ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(cru->dev), 1, 0, 0);
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
> > +     ret = rzg2l_cru_mc_parse_of(cru);
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
> > +static int rzg2l_cru_media_init(struct rzg2l_cru_dev *cru)
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
>
> You can drop this line, media_device_init() does this for you.
>
OK.

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
> > +     int ret;
> > +
> > +     cru = devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
> > +     if (!cru)
> > +             return -ENOMEM;
> > +
> > +     cru->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(cru->base))
> > +             return PTR_ERR(cru->base);
> > +
> > +     cru->presetn = devm_reset_control_get_shared(&pdev->dev, "presetn");
> > +     if (IS_ERR(cru->presetn))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(cru->presetn),
> > +                                  "Failed to get cpg presetn\n");
> > +
> > +     cru->aresetn = devm_reset_control_get_exclusive(&pdev->dev, "aresetn");
> > +     if (IS_ERR(cru->aresetn))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(cru->aresetn),
> > +                                  "Failed to get cpg aresetn\n");
> > +
> > +     cru->vclk = devm_clk_get(&pdev->dev, "video");
> > +     if (IS_ERR(cru->vclk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(cru->vclk),
> > +                                  "Failed to get video clock\n");
> > +
> > +     cru->dev = &pdev->dev;
> > +     cru->info = of_device_get_match_data(&pdev->dev);
> > +
> > +     cru->image_conv_irq = platform_get_irq(pdev, 0);
> > +     if (cru->image_conv_irq < 0)
> > +             return cru->image_conv_irq;
> > +
> > +     platform_set_drvdata(pdev, cru);
> > +
> > +     ret = rzg2l_cru_dma_register(cru);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = rzg2l_cru_media_init(cru);
> > +     if (ret)
> > +             goto error_dma_unregister;
> > +
> > +     cru->num_buf = RZG2L_CRU_HW_BUFFER_DEFAULT;
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
> > +static int rzg2l_cru_remove(struct platform_device *pdev)
> > +{
> > +     struct rzg2l_cru_dev *cru = platform_get_drvdata(pdev);
> > +
> > +     pm_runtime_disable(&pdev->dev);
> > +
> > +     v4l2_async_nf_unregister(&cru->notifier);
> > +     v4l2_async_nf_cleanup(&cru->notifier);
> > +
> > +     rzg2l_cru_video_unregister(cru);
> > +     media_device_cleanup(&cru->mdev);
> > +     mutex_destroy(&cru->mdev_lock);
> > +
> > +     rzg2l_cru_dma_unregister(cru);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id rzg2l_cru_of_id_table[] = {
> > +     { .compatible = "renesas,rzg2l-cru", },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_cru_of_id_table);
> > +
> > +static struct platform_driver rzg2l_cru_driver = {
> > +     .driver = {
> > +             .name = "rzg2l-cru",
> > +             .of_match_table = rzg2l_cru_of_id_table,
> > +     },
> > +     .probe = rzg2l_cru_probe,
> > +     .remove = rzg2l_cru_remove,
> > +};
> > +
> > +module_platform_driver(rzg2l_cru_driver);
> > +
> > +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L CRU driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> > new file mode 100644
> > index 000000000000..bd76f9d07221
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> > @@ -0,0 +1,163 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Driver for Renesas RZ/G2L CRU
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
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
> > +#define RZG2L_CRU_HW_BUFFER_MAX              8
> > +#define RZG2L_CRU_HW_BUFFER_DEFAULT  3
> > +
> > +/* Address alignment mask for HW buffers */
> > +#define RZG2L_CRU_HW_BUFFER_MASK     0x1ff
> > +
> > +/* Maximum number of CSI2 virtual channels */
> > +#define RZG2L_CRU_CSI2_VCHANNEL              4
> > +
> > +#define RZG2L_CRU_MIN_INPUT_WIDTH    320
> > +#define RZG2L_CRU_MAX_INPUT_WIDTH    2800
> > +#define RZG2L_CRU_MIN_INPUT_HEIGHT   240
> > +#define RZG2L_CRU_MAX_INPUT_HEIGHT   4095
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
> > +struct rzg2l_cru_ip {
> > +     struct v4l2_subdev subdev;
> > +     struct media_pad pads[2];
> > +     struct v4l2_async_notifier notifier;
> > +     struct v4l2_subdev *remote;
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
> > + *
> > + * @vdev:            V4L2 video device associated with CRU
> > + * @v4l2_dev:                V4L2 device
> > + * @ctrl_handler:    V4L2 control handler
> > + * @num_buf:         Holds the current number of buffers enabled
> > + * @notifier:                V4L2 asynchronous subdevs notifier
> > + *
> > + * @ip:                      Image processing subdev info
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
> > +
> > +     int image_conv_irq;
> > +
> > +     struct video_device vdev;
> > +     struct v4l2_device v4l2_dev;
> > +     u8 num_buf;
> > +
> > +     struct v4l2_async_notifier notifier;
> > +
> > +     struct rzg2l_cru_ip ip;
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
> > +     struct vb2_v4l2_buffer *queue_buf[RZG2L_CRU_HW_BUFFER_MAX];
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
> > +int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru);
> > +void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru);
> > +
> > +int rzg2l_cru_video_register(struct rzg2l_cru_dev *cru);
> > +void rzg2l_cru_video_unregister(struct rzg2l_cru_dev *cru);
> > +
> > +const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format);
> > +
> > +int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev *cru);
> > +void rzg2l_cru_ip_subdev_unregister(struct rzg2l_cru_dev *cru);
> > +
> > +#endif
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
> > new file mode 100644
> > index 000000000000..fee1d459436a
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
> > @@ -0,0 +1,277 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Renesas RZ/G2L CRU
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include "rzg2l-cru.h"
> > +
> > +struct rzg2l_cru_ip_format {
> > +     u32 code;
> > +     unsigned int datatype;
> > +     unsigned int bpp;
> > +};
> > +
> > +static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] = {
> > +     { .code = MEDIA_BUS_FMT_UYVY8_1X16,     .datatype = 0x1e, .bpp = 16 },
> > +};
> > +
> > +enum rzg2l_csi2_pads {
> > +     RZG2L_CRU_IP_SINK = 0,
> > +     RZG2L_CRU_IP_SOURCE,
> > +};
> > +
> > +static const struct rzg2l_cru_ip_format
> > +*rzg2l_cru_ip_code_to_fmt(unsigned int code)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(rzg2l_cru_ip_formats); i++)
> > +             if (rzg2l_cru_ip_formats[i].code == code)
> > +                     return &rzg2l_cru_ip_formats[i];
> > +
> > +     return NULL;
> > +}
> > +
> > +static int rzg2l_cru_ip_s_stream(struct v4l2_subdev *sd, int enable)
> > +{
> > +     struct rzg2l_cru_dev *cru;
> > +     int ret;
> > +
> > +     cru = v4l2_get_subdevdata(sd);
> > +
> > +     if (!cru->is_csi)
> > +             return -EINVAL;
> > +
> > +     ret = v4l2_subdev_call(cru->ip.remote, video, s_stream, enable);
>
> It's up to the driver how call pre_streamon() and post_streamoff(), as long
> as it takes place on both sides of s_stream().
>
> In other words, as it seems your device doesn't need anything special, you
> could waive implemeting the callbacks yourself and call pre_streamon() and
> post_streamoff() here.
>
Here the cru->ip.remote = CSI, in the rzg2l_cru_set_stream(1) where we
are calling pre_streamon()/post_streamoff() callbacks the subdev is
CRU-IP. So the calls from rzg2l_cru_set_stream() land into
rzg2l_cru_ip_pre_streamon() and rzg2l_cru_ip_post_streamoff() which
are calling pre_streamon/post_streamoff for the CSI subdev.

If we implement the pre_streamon/post_streamoff here that would be a
repetitive call to the CSI subdev.

Or is it that I am missing something?

> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_cru_ip_pre_streamon(struct v4l2_subdev *sd, u32 flags)
> > +{
> > +     struct rzg2l_cru_dev *cru;
> > +     int ret;
> > +
> > +     cru = v4l2_get_subdevdata(sd);
> > +
> > +     if (!cru->is_csi)
> > +             return -EINVAL;
> > +
> > +     ret = v4l2_subdev_call(cru->ip.remote, video, pre_streamon, 0);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_cru_ip_post_streamoff(struct v4l2_subdev *sd)
> > +{
> > +     struct rzg2l_cru_dev *cru;
> > +     int ret;
> > +
> > +     cru = v4l2_get_subdevdata(sd);
> > +
> > +     if (!cru->is_csi)
> > +             return -EINVAL;
> > +
> > +     ret = v4l2_subdev_call(cru->ip.remote, video, post_streamoff);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_cru_ip_set_format(struct v4l2_subdev *sd,
> > +                                struct v4l2_subdev_state *state,
> > +                                struct v4l2_subdev_format *fmt)
> > +{
> > +     struct v4l2_mbus_framefmt *format;
> > +
> > +     if (fmt->pad != RZG2L_CRU_IP_SINK && fmt->pad != RZG2L_CRU_IP_SOURCE)
> > +             return -EINVAL;
> > +
> > +     format = v4l2_subdev_get_pad_format(sd, state, fmt->pad);
> > +
> > +     if (!rzg2l_cru_ip_code_to_fmt(fmt->format.code))
> > +             format->code = rzg2l_cru_ip_formats[0].code;
> > +     else
> > +             format->code = fmt->format.code;
> > +
> > +     format->field = V4L2_FIELD_NONE;
> > +     format->colorspace = fmt->format.colorspace;
> > +     format->xfer_func = fmt->format.xfer_func;
> > +     format->ycbcr_enc = fmt->format.ycbcr_enc;
> > +     format->quantization = fmt->format.quantization;
> > +     format->width = clamp_t(u32, fmt->format.width,
> > +                             RZG2L_CRU_MIN_INPUT_WIDTH, RZG2L_CRU_MAX_INPUT_WIDTH);
> > +     format->height = clamp_t(u32, fmt->format.height,
> > +                              RZG2L_CRU_MIN_INPUT_HEIGHT, RZG2L_CRU_MAX_INPUT_HEIGHT);
> > +
> > +     fmt->format = *format;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_ip_enum_mbus_code(struct v4l2_subdev *sd,
> > +                                    struct v4l2_subdev_state *state,
> > +                                    struct v4l2_subdev_mbus_code_enum *code)
> > +{
> > +     if (code->index >= ARRAY_SIZE(rzg2l_cru_ip_formats))
> > +             return -EINVAL;
> > +
> > +     code->code = rzg2l_cru_ip_formats[code->index].code;
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_ip_enum_frame_size(struct v4l2_subdev *sd,
> > +                                     struct v4l2_subdev_state *state,
> > +                                     struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +     if (fse->index != 0)
> > +             return -EINVAL;
> > +
> > +     fse->min_width = RZG2L_CRU_MIN_INPUT_WIDTH;
> > +     fse->min_height = RZG2L_CRU_MIN_INPUT_HEIGHT;
> > +     fse->max_width = RZG2L_CRU_MAX_INPUT_WIDTH;
> > +     fse->max_height = RZG2L_CRU_MAX_INPUT_HEIGHT;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_cru_ip_init_config(struct v4l2_subdev *sd,
> > +                                 struct v4l2_subdev_state *sd_state)
> > +{
> > +     struct v4l2_subdev_format fmt = { .pad = RZG2L_CRU_IP_SINK, };
> > +     int ret;
> > +
> > +     fmt.format.width = RZG2L_CRU_MIN_INPUT_WIDTH;
> > +     fmt.format.height = RZG2L_CRU_MIN_INPUT_HEIGHT;
> > +     fmt.format.field = V4L2_FIELD_NONE;
> > +     fmt.format.code = MEDIA_BUS_FMT_UYVY8_1X16;
> > +     fmt.format.colorspace = V4L2_COLORSPACE_SRGB;
> > +     fmt.format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> > +     fmt.format.quantization = V4L2_QUANTIZATION_DEFAULT;
> > +     fmt.format.xfer_func = V4L2_XFER_FUNC_DEFAULT;
> > +
> > +     ret = rzg2l_cru_ip_set_format(sd, sd_state, &fmt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     fmt.pad = RZG2L_CRU_IP_SOURCE;
> > +     return rzg2l_cru_ip_set_format(sd, sd_state, &fmt);
> > +}
> > +
> > +static int rzg2l_cru_ip_link_setup(struct media_entity *entity,
> > +                                const struct media_pad *local,
> > +                                const struct media_pad *remote, u32 flags)
> > +{
> > +     struct v4l2_subdev *remote_source;
> > +     struct v4l2_subdev *ip_sd;
> > +     struct rzg2l_cru_dev *cru;
> > +
> > +     ip_sd = media_entity_to_v4l2_subdev(entity);
> > +     cru = v4l2_get_subdevdata(ip_sd);
> > +     /* We are only interested in remote link */
> > +     if ((flags & MEDIA_LNK_FL_ENABLED) && remote) {
> > +             if (media_pad_remote_pad_first(remote))
> > +                     return -EMLINK;
> > +
> > +             remote_source = media_entity_to_v4l2_subdev(remote->entity);
> > +
> > +             if (cru->csi.subdev && cru->csi.subdev == remote_source) {
> > +                     /* Default to VC0 for now */
> > +                     cru->csi.channel = 0;
> > +                     cru->is_csi = true;
> > +                     cru->ip.remote = remote_source;
> > +             }
> > +     } else if (!flags) {
> > +             remote_source = media_entity_to_v4l2_subdev(remote->entity);
> > +             if (cru->csi.subdev == remote_source) {
> > +                     cru->is_csi = false;
> > +                     cru->ip.remote = NULL;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct v4l2_subdev_video_ops rzg2l_cru_ip_video_ops = {
> > +     .s_stream = rzg2l_cru_ip_s_stream,
> > +     .pre_streamon = rzg2l_cru_ip_pre_streamon,
> > +     .post_streamoff = rzg2l_cru_ip_post_streamoff,
> > +};
> > +
> > +static const struct v4l2_subdev_core_ops rzg2l_cru_ip_core_ops = {
> > +     .log_status = v4l2_ctrl_subdev_log_status,
> > +};
> > +
> > +static const struct v4l2_subdev_pad_ops rzg2l_cru_ip_pad_ops = {
> > +     .enum_mbus_code = rzg2l_cru_ip_enum_mbus_code,
> > +     .enum_frame_size = rzg2l_cru_ip_enum_frame_size,
> > +     .init_cfg = rzg2l_cru_ip_init_config,
> > +     .get_fmt = v4l2_subdev_get_fmt,
> > +     .set_fmt = rzg2l_cru_ip_set_format,
> > +};
> > +
> > +static const struct v4l2_subdev_ops rzg2l_cru_ip_subdev_ops = {
> > +     .core = &rzg2l_cru_ip_core_ops,
> > +     .video = &rzg2l_cru_ip_video_ops,
> > +     .pad = &rzg2l_cru_ip_pad_ops,
> > +};
> > +
> > +static const struct media_entity_operations rzg2l_cru_ip_entity_ops = {
> > +     .link_setup = rzg2l_cru_ip_link_setup,
> > +     .link_validate = v4l2_subdev_link_validate,
> > +};
> > +
> > +int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev *cru)
> > +{
> > +     struct rzg2l_cru_ip *ip = &cru->ip;
> > +     int ret;
> > +
> > +     ip->subdev.dev = cru->dev;
> > +     v4l2_subdev_init(&ip->subdev, &rzg2l_cru_ip_subdev_ops);
> > +     v4l2_set_subdevdata(&ip->subdev, cru);
> > +     snprintf(ip->subdev.name, sizeof(ip->subdev.name),
> > +              "cru-ip-%s", dev_name(cru->dev));
> > +     ip->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
> > +
> > +     ip->subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
> > +     ip->subdev.entity.ops = &rzg2l_cru_ip_entity_ops;
> > +
> > +     ip->pads[0].flags = MEDIA_PAD_FL_SINK;
> > +     ip->pads[1].flags = MEDIA_PAD_FL_SOURCE;
> > +
> > +     ret = media_entity_pads_init(&ip->subdev.entity, 2, ip->pads);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = v4l2_subdev_init_finalize(&ip->subdev);
> > +     if (ret < 0)
> > +             goto entity_cleanup;
> > +
> > +     ret = v4l2_device_register_subdev(&cru->v4l2_dev, &ip->subdev);
> > +     if (ret < 0)
> > +             goto error_subdev;
> > +
> > +     return 0;
> > +error_subdev:
> > +     v4l2_subdev_cleanup(&ip->subdev);
> > +entity_cleanup:
> > +     media_entity_cleanup(&ip->subdev.entity);
> > +
> > +     return ret;
> > +}
> > +
> > +void rzg2l_cru_ip_subdev_unregister(struct rzg2l_cru_dev *cru)
> > +{
> > +     struct rzg2l_cru_ip *ip = &cru->ip;
> > +
> > +     media_entity_cleanup(&ip->subdev.entity);
> > +     v4l2_subdev_cleanup(&ip->subdev);
> > +     v4l2_device_unregister_subdev(&ip->subdev);
> > +}
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > new file mode 100644
> > index 000000000000..77af036cf496
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > @@ -0,0 +1,1087 @@
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
> > +#include <linux/delay.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/videobuf2-dma-contig.h>
> > +
> > +#include "rzg2l-cru.h"
> > +
> > +/* HW CRU Registers Definition */
> > +
> > +/* CRU Control Register */
> > +#define CRUnCTRL                     0x0
> > +#define CRUnCTRL_VINSEL(x)           ((x) << 0)
> > +
> > +/* CRU Interrupt Enable Register */
> > +#define CRUnIE                               0x4
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
> > +#define RZG2L_CRU_DEFAULT_FORMAT     V4L2_PIX_FMT_UYVY
> > +#define RZG2L_CRU_DEFAULT_WIDTH              RZG2L_CRU_MIN_INPUT_WIDTH
> > +#define RZG2L_CRU_DEFAULT_HEIGHT     RZG2L_CRU_MIN_INPUT_HEIGHT
> > +#define RZG2L_CRU_DEFAULT_FIELD              V4L2_FIELD_NONE
> > +#define RZG2L_CRU_DEFAULT_COLORSPACE V4L2_COLORSPACE_SRGB
> > +
> > +struct rzg2l_cru_buffer {
> > +     struct vb2_v4l2_buffer vb;
> > +     struct list_head list;
> > +};
> > +
> > +#define to_buf_list(vb2_buffer) \
> > +     (&container_of(vb2_buffer, struct rzg2l_cru_buffer, vb)->list)
> > +
> > +/* -----------------------------------------------------------------------------
> > + * DMA operations
> > + */
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
> > +     if (WARN_ON((offsetx | offsety | offset) & RZG2L_CRU_HW_BUFFER_MASK))
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
> > +static int rzg2l_cru_stream_off(struct rzg2l_cru_dev *cru)
> > +{
> > +     int stream_off_ret = 0;
> > +     struct v4l2_subdev *sd;
> > +     struct media_pad *pad;
> > +     int ret;
> > +
> > +     media_pipeline_stop(&cru->vdev.entity);
>
> This operation should take place ast last, after post_streamoff.
>
OK, I'll move this at the end of func.

> > +
> > +     pad = media_pad_remote_pad_first(&cru->pad);
> > +     sd = media_entity_to_v4l2_subdev(pad->entity);
> > +     ret = v4l2_subdev_call(sd, video, s_stream, 0);
> > +     if (ret)
> > +             stream_off_ret = ret;
> > +
> > +     ret = v4l2_subdev_call(sd, video, post_streamoff);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +     if (ret && !stream_off_ret)
> > +             stream_off_ret = ret;
> > +
> > +     return stream_off_ret;
> > +}
> > +
> > +static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
> > +{
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
> > +     if (!on)
> > +             return rzg2l_cru_stream_off(cru);
> > +
> > +     sd = media_entity_to_v4l2_subdev(pad->entity);
> > +
> > +     ret = rzg2l_cru_mc_validate_format(cru, sd, pad);
> > +     if (ret)
> > +             goto err_post_streamoff;
> > +
> > +     ret = v4l2_subdev_call(sd, video, pre_streamon, 0);
> > +     if (ret == -ENOIOCTLCMD)
> > +             ret = 0;
> > +     if (ret)
> > +             goto err_post_streamoff;
>
> You should return here and above instead. You can only call
> post_streamoff() once pre_streamon() has successfully returned.
>
Agreed.

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
> > +             goto err_post_streamoff;
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
>
> media_pipeline_start() needs to take place before pre_streamon() call.
>
Ok, I will move this up.

Cheers,
Prabhakar
