Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011BC634B96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiKWAPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKWAPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:15:33 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9741D338C;
        Tue, 22 Nov 2022 16:15:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n21so39274045ejb.9;
        Tue, 22 Nov 2022 16:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tkjtew5fZOq+Ws9ayZhgVOfpvVrtfI4z/wzsiQHDiI=;
        b=mH15BSXZOpjG3WWRV8O2a+T241/yUz8Cu3/DJQnt/fo3GJEy3/9E+nKJqyisHeiYgk
         1epU8/6O4xpwCAzd9jYkJuiCMvniuWGb7xoTP9swMp/TPNGzouEeUBN5lG3lY8rx8umb
         rg2DKVRfNCO5Sl4IgXg84PNrPNOZ3HxczcE5CqYHzI9gU76LKtGrqQaT8iCfUNu4lD6N
         QzBqjVVD6jmh0dzg+wlWIFBByEW3xqreneRu35tHLVSPuHivVotLOcy8p4XCRj/4vQ1o
         es2sXoCV12q3VU6aHPaW7NXBDKll2jZaQl4xGfyc8NRurj/hWYwmF45TO/w4uLESSOtK
         bQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tkjtew5fZOq+Ws9ayZhgVOfpvVrtfI4z/wzsiQHDiI=;
        b=KNreCS+SGSOlXDeGAeP9fOsW9Vso/KCRJCjsGqI8WTKfQdy+rC5tkyba46CKF1YIyV
         LU8ekzwCZ59TnJkIJ0ntT9soXlTE/br5RhQtJoe3y918XWIPr/UUz+465lqXdwuotbZA
         llLWta/uioBTYjPYYDD47LOBICFUKFLd2VAbjllOlOwL0IM6SwF8GDOBBBToJyOIf8ne
         WRQf2igx5sEwiFjCEOzdYU115GIKC1uTuXD/vx93eki2fncCKseMoGDeQ+80i6oYOxuF
         lpHWmNls+SU9JF79bLEFoHxMvz+jpmB9FVBfARNC6lbo8z3aE5XfcJ0hN9lLiG7pyKkZ
         2hwg==
X-Gm-Message-State: ANoB5pnZAMHTeqIGlnvlXXhjIdf3DCnKfJdnEPO+qm2YjSHqgGOawymV
        QiEm6SZp4fmoZbBDDXcah56LG+H5nXFlpJnYw+A=
X-Google-Smtp-Source: AA0mqf4ws0v/d7LS3Gyj/1miRkPgFwm33/Amjv9DiDBcbh8rS/cnELMEPQISI+yHFNukwetcIC9/gAAGqtMomhMgnzU=
X-Received: by 2002:a17:906:ccd0:b0:7ad:db82:d073 with SMTP id
 ot16-20020a170906ccd000b007addb82d073mr10146636ejb.480.1669162530251; Tue, 22
 Nov 2022 16:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221102004329.5410-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3wtKZK8Xafts71R@pendragon.ideasonboard.com> <CA+V-a8sPuF6TUHj6wfe6kBUetFA2vt2wEr6sPBhF4hGQmOW6gA@mail.gmail.com>
In-Reply-To: <CA+V-a8sPuF6TUHj6wfe6kBUetFA2vt2wEr6sPBhF4hGQmOW6gA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 23 Nov 2022 00:15:03 +0000
Message-ID: <CA+V-a8us7u8MrC3rS5N513icMAVBdmY_ZopkvymURJze8vCq3w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Nov 22, 2022 at 8:28 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Laurent,
>
> Thank you for the review.
>
> On Tue, Nov 22, 2022 at 2:00 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Prabhakar,
> >
> > Thank you for the patch.
> >
> > On Wed, Nov 02, 2022 at 12:43:29AM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> > >
> > > Based on a patch in the BSP by Hien Huynh
> > > <hien.huynh.px@renesas.com>
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > -v4 -> v5
> > > * Made sure we call pre_streamon/post_streamoff around s_stream
> > > * Made sure to cleanup on error path in s_stream
> > > * Dropped pre_streamon/post_streamoff callbacks from IP subdev
> > > * Moved the CRU start/stop configuration to IP subdev to avoid
> > >   recursively calling pre_streamon/post_streamoff callbacks.
> > >
> > > -v3 -> v4
> > > * Undoing the configuration in case s_stream(1) fails
> > > * Made sure we call post_streamoff in the error path of s_stream(1)
> > >
> > > v2 -> v3
> > > * Switched to PM runtime
> > > * Modeled CRU IP block as a subdev
> > > * Dropped explicitly selecting VIDEO_RZG2L_CSI2 for VIDEO_RZG2L_CRU config
> > > * Replaced v4l2_dev_to_cru macro with inline function notifier_to_cru()
> > > * Dropped id parameter from rvin_mc_parse_of()
> > > * Renamed rzg2l_cru_csi2_init() -> rzg2l_cru_media_init()
> > > * Used dev_err_probe() in rzg2l_cru_probe()
> > > * Replaced devm_reset_control_get() -> devm_reset_control_get_exclusive()
> > > * Prefixed HW_BUFFER_MAX and HW_BUFFER_DEFAULT macros with RZG2L_CRU_
> > > * Moved asserting presetn signal from rzg2l_cru_dma_register() to rzg2l_cru_start_streaming_vq()
> > > * Dropped VB2_READ from VB2 io_modes
> > > * Used dev_dbg() in rzg2l_cru_video_register() and rzg2l_cru_video_unregister()
> > > * Got rid of rzg2l_cru_notify()
> > > * Dropped V4L2_CAP_READWRITE from device caps
> > > * Introduced rzg2l_cru_v4l2_init() for initialization.
> > > * Got rid v4l2_pipeline_pm_get() and used PM in ov5645 sensor driver. Patch posted
> > >   https://patchwork.linuxtv.org/project/linux-media/patch/20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > >
> > > v1 -> v2
> > > * No change
> > >
> > > RFC v2 -> v1
> > > * Moved the driver to renesas folder
> > > * Fixed review comments pointed by Jacopo
> > >
> > > RFC v1 -> RFC v2
> > > * Dropped group
> > > * Dropped CSI subdev and implemented as new driver
> > > * Dropped "mc_" from function names
> > > * Moved the driver to renesas folder
> > > ---
> > >  .../media/platform/renesas/rzg2l-cru/Kconfig  |   16 +
> > >  .../media/platform/renesas/rzg2l-cru/Makefile |    3 +
> > >  .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  370 ++++++
> > >  .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  169 +++
> > >  .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  283 +++++
> > >  .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 1086 +++++++++++++++++
> > >  6 files changed, 1927 insertions(+)
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
> > >  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > >
> > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > > index 57c40bb499df..b39818c1f053 100644
> > > --- a/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > > +++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> > > @@ -15,3 +15,19 @@ config VIDEO_RZG2L_CSI2
> > >
> > >         To compile this driver as a module, choose M here: the
> > >         module will be called rzg2l-csi2.
> > > +
> > > +config VIDEO_RZG2L_CRU
> > > +     tristate "RZ/G2L Camera Receiving Unit (CRU) Driver"
> > > +     depends on ARCH_RENESAS || COMPILE_TEST
> > > +     depends on V4L_PLATFORM_DRIVERS
> > > +     depends on VIDEO_DEV && OF
> > > +     select MEDIA_CONTROLLER
> > > +     select V4L2_FWNODE
> > > +     select VIDEOBUF2_DMA_CONTIG
> > > +     select VIDEO_V4L2_SUBDEV_API
> > > +     help
> > > +       Support for Renesas RZ/G2L (and alike SoC's) Camera Receiving
> > > +       Unit (CRU) driver.
> > > +
> > > +       To compile this driver as a module, choose M here: the
> > > +       module will be called rzg2l-cru.
> > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > > index 91ea97a944e6..c4db2632874f 100644
> > > --- a/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > > +++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> > > @@ -1,3 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >
> > >  obj-$(CONFIG_VIDEO_RZG2L_CSI2) += rzg2l-csi2.o
> > > +
> > > +rzg2l-cru-objs = rzg2l-core.o rzg2l-ip.o rzg2l-video.o
> > > +obj-$(CONFIG_VIDEO_RZG2L_CRU) += rzg2l-cru.o
> > > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > > new file mode 100644
> > > index 000000000000..7a92fcfee84c
> > > --- /dev/null
> > > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
> > > @@ -0,0 +1,370 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Driver for Renesas RZ/G2L CRU
> > > + *
> > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > + *
> > > + * Based on Renesas R-Car VIN
> > > + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> > > + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> > > + * Copyright (C) 2008 Magnus Damm
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_graph.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +
> > > +#include <media/v4l2-fwnode.h>
> > > +#include <media/v4l2-mc.h>
> > > +
> > > +#include "rzg2l-cru.h"
> > > +
> > > +static inline struct rzg2l_cru_dev *notifier_to_cru(struct v4l2_async_notifier *n)
> > > +{
> > > +     return container_of(n, struct rzg2l_cru_dev, notifier);
> > > +}
> > > +
> > > +static int rzg2l_cru_csi2_link_notify(struct media_link *link, u32 flags,
> > > +                                   unsigned int notification)
> > > +{
> > > +     struct media_entity *entity;
> > > +     struct rzg2l_cru_dev *cru;
> > > +     int ret;
> > > +
> > > +     ret = v4l2_pipeline_link_notify(link, flags, notification);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Only care about link enablement for CRU nodes. */
> > > +     if (!(flags & MEDIA_LNK_FL_ENABLED))
> > > +             return 0;
> > > +
> > > +     cru = container_of(link->graph_obj.mdev, struct rzg2l_cru_dev, mdev);
> > > +     /*
> > > +      * Don't allow link changes if any entity in the graph is
> > > +      * streaming, modifying the CHSEL register fields can disrupt
> > > +      * running streams.
> > > +      */
> > > +     media_device_for_each_entity(entity, &cru->mdev)
> > > +             if (media_entity_is_streaming(entity))
> > > +                     return -EBUSY;
> > > +
> > > +     mutex_lock(&cru->mdev_lock);
> > > +     if (media_pad_remote_pad_first(&cru->vdev.entity.pads[0]))
> > > +             ret = -EMLINK;
> > > +     mutex_unlock(&cru->mdev_lock);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static const struct media_device_ops rzg2l_cru_media_ops = {
> > > +     .link_notify = rzg2l_cru_csi2_link_notify,
> > > +};
> > > +
> > > +/* -----------------------------------------------------------------------------
> > > + * Group async notifier
> > > + */
> > > +
> > > +static int rzg2l_cru_group_notify_complete(struct v4l2_async_notifier *notifier)
> > > +{
> > > +     struct rzg2l_cru_dev *cru = notifier_to_cru(notifier);
> > > +     struct media_entity *source, *sink;
> > > +     int ret;
> > > +
> > > +     ret = media_device_register(&cru->mdev);
> > > +     if (ret)
> > > +             return ret;
> >
> > I'd move the v4l2_device_register() call here, as it's the V4L2
> > counterpart of the media device, and handling them together would be
> > best.
> >
> OK, but now that we plan to get rid of rzg2l_cru_csi2_link_notify()
> I'll move this call into rzg2l_cru_dma_register().
>
I misread the comment earlier, I will get rid of
rzg2l_cru_csi2_link_notify() and use v4l2_pipeline_link_notify()
instead. And I will also move the media_device_register() into
rzg2l_cru_dma_register().

Cheers,
Prabhakar
