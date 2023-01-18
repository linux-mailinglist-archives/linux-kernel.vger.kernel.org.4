Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7322672535
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjARRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjARRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:39:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E959744
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:39:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z5so33668771wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGboknKGt/v97Q9vnlsbZzlLwS3DVaa01pAelrahrg=;
        b=fCoG1ap/QVvYXCsNdIJluv3W2A/WmR2a0VJLmKy6TYRbn0Wh0vCO5PRr/UhRpRAQx2
         Nz2R218W5mKK4Q3olpYDNqfALaiELbmLCPUK/D+68N6iR0y+MHIP7BEmIgI4UP1CwIyD
         lOvvj1+yI7bpeZis/Rmmb622M0lhj5K1bu7aIlWPkq+xAyg5bP6Pc8aUlAPBeP/r0zXx
         u75hkC5EsnkWCOAikmAbFm51Td2OIOf8KwLiL09zuOP7eTXww9qkHdNoEWgRTXj63b70
         xL8zm5Eo2XEOy/D+t1fG1vujs1kxhzWbkZXPW/PXeVMhnMiZBcuhIBydUKuL/T5seFk7
         Tt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSGboknKGt/v97Q9vnlsbZzlLwS3DVaa01pAelrahrg=;
        b=n6Vy5Yc7b6VLs9qo3BgYbpHbIKby9oiS3hY7qzbT4XgoogW11fTlXUQS4aezFUaB89
         pgtix4eay0yQlaymeTrm1Vp5MvFAbSZWPAZOQNO1ObNX25isFhMVMmfgR0F1UIuGZJpw
         cdu14IYOWl9wjF/NkZIOS2otAYF14vZz7edip+T4qSj13O43jvHPK+CVwLeC1JreTCSt
         QLzf+hdGRPXgqdOTFMVMdruKRaQfI++NXR5caPoPFkagvUv7/U3pdgTzt2wp5o1dN7Jw
         e5HdbynSOHcyLaGCsgndG8mz5EcX41lpD4Tj8IR2AkFNYAb0wEYDa9/m6cvjrS8iCtGV
         9i3w==
X-Gm-Message-State: AFqh2kpIXfpPlADjrZA0TPI22z6/NFcMfBAh31dnlSR/j8Tsn9T4GCkt
        +tDHJ6mCXe+3Fuec8ROqwGxwCTr3GsafsLFmR2plvAPA94Gzvw==
X-Google-Smtp-Source: AMrXdXtFjML2kMeAcVvj1MtxenYnvk4kkEcOiam/ZVVFpKAA2cBZAoWXiLMQIKspZtAXBpxXCHqfqukGXuzn19ybzHM=
X-Received: by 2002:a5d:4144:0:b0:2ba:8d6c:11d0 with SMTP id
 c4-20020a5d4144000000b002ba8d6c11d0mr283005wrq.477.1674063549930; Wed, 18 Jan
 2023 09:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
 <20221227151131.hkezt4j2om5volnu@builder.lan> <CANLsYkwrCoX=Mw5YDJq-1hvmB3tH2admCC5GodwU0=jggmZg0w@mail.gmail.com>
 <20230104155613.xclae5hup2ybypdo@builder.lan> <20230104214541.GA2112402@p14s>
In-Reply-To: <20230104214541.GA2112402@p14s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 18 Jan 2023 10:38:59 -0700
Message-ID: <CANLsYkz1qq7xLd1PHLwNu79TvH8+2+X0-ZrnNNSTOZiDUgcSuQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.levinsky@xilinx.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Did you have more comments on this?  Given that we are at rc4, it
would be nice to get this to simmer in linux-next for a while.

Thanks,
Mathieu

On Wed, 4 Jan 2023 at 14:45, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Wed, Jan 04, 2023 at 09:56:13AM -0600, Bjorn Andersson wrote:
> > On Tue, Jan 03, 2023 at 11:48:56AM -0700, Mathieu Poirier wrote:
> > > On Tue, 27 Dec 2022 at 08:11, Bjorn Andersson <andersson@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 14, 2022 at 03:16:43PM -0700, Mathieu Poirier wrote:
> > > > > Multi-cluster remoteproc designs typically have the following DT
> > > > > declaration:
> > > > >
> > > > >       remoteproc_cluster {
> > > > >               compatible = "soc,remoteproc-cluster";
> > > > >
> > > > >                 core0: core0 {
> > > > >                       compatible = "soc,remoteproc-core"
> > > > >                         memory-region;
> > > > >                         sram;
> > > > >                 };
> > > > >
> > > > >                 core1: core1 {
> > > > >                       compatible = "soc,remoteproc-core"
> > > > >                         memory-region;
> > > > >                         sram;
> > > > >                 }
> > > > >         };
> > > > >
> > > > > A driver exists for the cluster rather than the individual cores
> > > > > themselves so that operation mode and HW specific configurations
> > > > > applicable to the cluster can be made.
> > > > >
> > > > > Because the driver exists at the cluster level and not the individual
> > > > > core level, function rproc_get_by_phandle() fails to return the
> > > > > remoteproc associated with the phandled it is called for.
> > > > >
> > > > > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > > > > driver when the driver for the immediate remoteproc's parent is not
> > > > > found.
> > > > >
> > > >
> > > > Can you please help me understand why zynqmp_r5_remoteproc_probe()
> > > > invokes devm_of_platform_populate() to create platform_device instances
> > > > for the clusters?
> > > >
> > >
> > > Platform device instances are created for the individual cores found
> > > in the cluster, following the work done on TI's K3-R5[1].
> > >
> >
> > Right, and this is a design pattern that I've been bitten by several
> > times by now. There's no real purpose of spinning up platform_devices
> > for those nodes.
> >
>
> Calling of_platform_populate() happened before my time in this subsystem.  I
> thought you were favourable to it.  Can you give one or two examples where it caused
> you grief?
>
> > > > Why can't the platform_device for the cluster be used as parent for both
> > > > remoteprocs and then the driver deal with the subnodes within the
> > > > driver?
> > > >
> > >
> > > That is exactly how things work for both K3-R5 and R5F architectures.
> > > That said, if we use the cluster's platform device as parent of the
> > > remote processors inside the cluster, function rproc_get_by_phandle()
> > > will return the first remote processor it finds with a matching parent
> > > rather than the remote processor referenced by the phandle parameter.
> > >
> >
> > I missed the fact that we don't associate either the rproc or the rproc
> > device with the of_node, but rather just rely on the fact that
> > rproc->dev->parent->of_node is typically is the handle we're looking
> > for.
> >
> > And I don't think we'll return the first instance, because
> > rproc->dev->parent->of_node will never match the instance's of_node.
> >
>
> My first suggestion was also to use the cluster's device as parent to the remote
> processors inside the cluster but it didn't work, though the exact details are
> lost in the holiday's fairy dust.  Looking more closely at the code I think you
> are correct.
>
> >
> > I think it would be cleaner to add a of_node to struct rproc and use
> > this for matching.
> >
>
> I also considered that option but decided to proceed differently because it
> duplicates of_node information that is already available and requires
> modifications to the drivers already using rproc_get_by_phandle().   Unless
> I'm missing something we would still have to call of_platform_populate() to get
> the of_node information...  And modify the parameters to rproc_alloc(), which
> cascades exponentially.
>
> > And I do suggest that we don't of_platform_populate() in the TI driver.
> > If nothing else, doing so saves ~2kb of wasted RAM...
> >
>
> And that would require a serious refactoring exercise that, in my opinion, far
> outweigh the benefits.
>
> Thanks,
> Mathieu
>
>
> > > [1]. https://elixir.bootlin.com/linux/v6.2-rc2/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1728
> > >
> > > > Regards,
> > > > Bjorn
> > > >
> > > > > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > ---
> > > > >  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
> > > > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > > index 1cd4815a6dd1..91f82886add9 100644
> > > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > @@ -33,6 +33,7 @@
> > > > >  #include <linux/idr.h>
> > > > >  #include <linux/elf.h>
> > > > >  #include <linux/crc32.h>
> > > > > +#include <linux/of_platform.h>
> > > > >  #include <linux/of_reserved_mem.h>
> > > > >  #include <linux/virtio_ids.h>
> > > > >  #include <linux/virtio_ring.h>
> > > > > @@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
> > > > >  #ifdef CONFIG_OF
> > > > >  struct rproc *rproc_get_by_phandle(phandle phandle)
> > > > >  {
> > > > > +     struct platform_device *cluster_pdev;
> > > > >       struct rproc *rproc = NULL, *r;
> > > > > +     struct device_driver *driver;
> > > > >       struct device_node *np;
> > > > >
> > > > >       np = of_find_node_by_phandle(phandle);
> > > > > @@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> > > > >       list_for_each_entry_rcu(r, &rproc_list, node) {
> > > > >               if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> > > > >                       /* prevent underlying implementation from being removed */
> > > > > -                     if (!try_module_get(r->dev.parent->driver->owner)) {
> > > > > +
> > > > > +                     /*
> > > > > +                      * If the remoteproc's parent has a driver, the
> > > > > +                      * remoteproc is not part of a cluster and we can use
> > > > > +                      * that driver.
> > > > > +                      */
> > > > > +                     driver = r->dev.parent->driver;
> > > > > +
> > > > > +                     /*
> > > > > +                      * If the remoteproc's parent does not have a driver,
> > > > > +                      * look for the driver associated with the cluster.
> > > > > +                      */
> > > > > +                     if (!driver) {
> > > > > +                             cluster_pdev = of_find_device_by_node(np->parent);
> >
> > Doing so also has the added benefit that we don't add an implicitly
> > requirement on the rproc-device's parent being a platform_driver.
> >
> > Regards,
> > Bjorn
> >
> > > > > +                             if (!cluster_pdev) {
> > > > > +                                     dev_err(&r->dev, "can't get parent\n");
> > > > > +                                     break;
> > > > > +                             }
> > > > > +
> > > > > +                             driver = cluster_pdev->dev.driver;
> > > > > +                             put_device(&cluster_pdev->dev);
> > > > > +                     }
> > > > > +
> > > > > +                     if (!try_module_get(driver->owner)) {
> > > > >                               dev_err(&r->dev, "can't get owner\n");
> > > > >                               break;
> > > > >                       }
> > > > > --
> > > > > 2.25.1
> > > > >
