Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A642D60E071
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiJZMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiJZMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:12:33 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922C2D747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:12:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id g10so18166466oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ5aSZWWIhIFIjTByURiHqOWXy1GxsKS3NVs264EAr8=;
        b=oXfPzt0JJzEiYPmp6/UVl3QESY5eYmPMyk1PUXcPsx5TkKA1luR3mwvzMiHsFdGkuw
         lFH6H1yHTH3ixTKPoCmMNQ4zmAp75XjW8TEArvQQcC9hfXaPtgUUlj1DryJcJiA3nJ+W
         cgnd9b+7zJ5sW07GpsYxTQ9nhqXaUOiY7d1M26nHfsv7Cr8ofV5LDZayI7aSrq/ruofN
         D9sxcxBlcJsoCSj/b9SDSbyoFg2D1P3keAyRtLQMECLOm6SnKgknqsy0ty6kzKJ1ys76
         UuRzGDlMsZauVIIEb8m9Do0erpzGPXdpUdcsyaPfqdbcpnUagMxNHH8ihhphMM3USBN5
         c7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ5aSZWWIhIFIjTByURiHqOWXy1GxsKS3NVs264EAr8=;
        b=ExlsU40ItqdvP/Ntxf0UZFyhWvY9NRPPngN/2yGPqMXPUCFrxjF3lt4xBEjNY76Mhc
         UaUtM52GTZLEfKZi/n4nC7zNOBxdCQ5xHjTIH/dpp/U+5wWhHA5W4VsvnpbUHEnw2eIE
         04qrIcIj1+rI3nMcWuujGqF6Z0AtPn+dSYTh9n6R3c7kMp19rPcTTvw4aKH1seXX6UEl
         MHNbycEDLgh+3ejkzupHxCuMX+khzHOk8eKhO4eOiw5q1xmuW6/jRMS7tfGEBHQM1azr
         WCG6oam/GFGd6j/PEMKg0Rk8sSpOLREA4qpm/O/PLsqf6e+dYHbehiPrcdAMc6wxzmEK
         Ix1g==
X-Gm-Message-State: ACrzQf3eAajIWfaYaoNHUxtDcSdQWpgGJyaYVbrD1uaBWHbAoDzmyeq5
        aoVz8R8GbXA5jIwFSgMHHr/6+QrZ6q1ZJpvCmcLJzL+/dE0=
X-Google-Smtp-Source: AMsMyM6M69yoWy/DsnOkqIuIhedU2TaFkjjGn29Zgv+lzU9ZTLfGzsVjJyPfg+CacBfyK3QLJhVTKAWS0qGoNA4silI=
X-Received: by 2002:a05:6808:f93:b0:355:29b1:c2a1 with SMTP id
 o19-20020a0568080f9300b0035529b1c2a1mr1666878oiw.297.1666786351235; Wed, 26
 Oct 2022 05:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com> <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
 <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
In-Reply-To: <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 26 Oct 2022 14:12:20 +0200
Message-ID: <CAM9Jb+hk0ZRtXnF+WVj0LiRiO7uH-jDydJrnUQ_57yTEcs--Dw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Michael Sammler <sammler@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
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

> > > Compute the numa information for a virtio_pmem device from the memory
> > > range of the device. Previously, the target_node was always 0 since
> > > the ndr_desc.target_node field was never explicitly set. The code for
> > > computing the numa node is taken from cxl_pmem_region_probe in
> > > drivers/cxl/pmem.c.
> > >
> > > Signed-off-by: Michael Sammler <sammler@google.com>
> > > ---
> > >  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > > index 20da455d2ef6..a92eb172f0e7 100644
> > > --- a/drivers/nvdimm/virtio_pmem.c
> > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
> > >  static int virtio_pmem_probe(struct virtio_device *vdev)
> > >  {
> > >         struct nd_region_desc ndr_desc = {};
> > > -       int nid = dev_to_node(&vdev->dev);
> > >         struct nd_region *nd_region;
> > >         struct virtio_pmem *vpmem;
> > >         struct resource res;
> > > @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> > >         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > >
> > >         ndr_desc.res = &res;
> > > -       ndr_desc.numa_node = nid;
> > > +
> > > +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> > > +       ndr_desc.target_node = phys_to_target_node(res.start);
> > > +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> > > +               ndr_desc.target_node = ndr_desc.numa_node;
> > > +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> > > +                       NUMA_NO_NODE, ndr_desc.target_node);
> > > +       }
> >
> > As this memory later gets hotplugged using "devm_memremap_pages". I don't
> > see if 'target_node' is used for fsdax case?
> >
> > It seems to me "target_node" is used mainly for volatile range above
> > persistent memory ( e.g kmem driver?).
> >
> I am not sure if 'target_node' is used in the fsdax case, but it is
> indeed used by the devdax/kmem driver when hotplugging the memory (see
> 'dev_dax_kmem_probe' and '__dax_pmem_probe').

Yes, but not currently for FS_DAX iiuc.

Thanks,
Pankaj
