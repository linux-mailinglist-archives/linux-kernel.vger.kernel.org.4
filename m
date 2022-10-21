Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A706607D32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJURJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJURIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51E58E8F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:08:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3552483pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BcKjJ/DvYciO22U+4C9FPgHR8gF43QoCQeInlu7o77U=;
        b=BKEWwEYSWhHnlAgMPL5eP9WwVf3jy/GmXCmDjYwxfZrmp3PJ3y9KZE1fifNjoSWhB5
         QCdaNDrLRb3V7Zm81gOAQWP8XKPBP08M57aMfpXQ//zEda/M0jLED/drOl3f/eTYs/Om
         dHR+mNPadrMkcl49SSVFZqrQsr5hE1DBqzi6wjMKCcNfocWhr61i5yZCRmy5W1Rt9t4Y
         5NtRqtsykWk1qpd3X2WEjB/PsIcWb2YyuVisrXbgE0HHWqXSqhY95p3Jy1H5rc+MV47d
         t/hYWZEuiNnDiJQ5Qxn4EOV3bZdiWN8S7A20/AHIGCETT8aRLQDqX6DGLZN0C5OAlP9t
         nbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcKjJ/DvYciO22U+4C9FPgHR8gF43QoCQeInlu7o77U=;
        b=ttF08SZb2UlQ9/IvAP50pzpfInXCLfCSNGVstmkpncU7TkSBuK6l+cwyvZeigP7MJu
         Jl95z97bxiPJKpL1d7gkdUTDcDhA118pVe6USZLOxYvga6aUWHgKeT87nJQTUQ7S+SiH
         2/cV3AJ9owfw+atp7GLMagFBD8WTQ+qjixNM3rvcwM4Fsh7WjYNfFqRnLfDsh1Y3AjE8
         /egmd5OzrlzfbUVCCK4K5ap7eqtuei8wZwhGSq6YucgpW9Dob78dx3bDZlvf9+V6E/ZS
         sNQdbU15lhl14UeRy6ZmbWV6Ha5yg8HPf7ehsZr+3Uavs7FGV+C6HgfrgXKCwS/wEHoA
         J9ag==
X-Gm-Message-State: ACrzQf0GZId2BM2afEwA7sN20ZP5lGuTPS7MIGMo4ZJQaDCCWpdBfEGf
        bhaoEAxes5JQEo9qBfEiaectsHMLYwezkJnS8bcfqg==
X-Google-Smtp-Source: AMsMyM7BW0377LCk6CQ5XZ0Vo9ObgaT/Wg9+y4LfXOhJBeGHzrWRSas/sCJXvN86SDgpNNVZC29CrJBhl72ukgaEzU8=
X-Received: by 2002:a17:90b:3c51:b0:20c:2630:5259 with SMTP id
 pm17-20020a17090b3c5100b0020c26305259mr58147003pjb.177.1666372123045; Fri, 21
 Oct 2022 10:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com> <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
In-Reply-To: <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
From:   Michael Sammler <sammler@google.com>
Date:   Fri, 21 Oct 2022 10:08:31 -0700
Message-ID: <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj,
Thank you for looking at the patch.

>
> > Compute the numa information for a virtio_pmem device from the memory
> > range of the device. Previously, the target_node was always 0 since
> > the ndr_desc.target_node field was never explicitly set. The code for
> > computing the numa node is taken from cxl_pmem_region_probe in
> > drivers/cxl/pmem.c.
> >
> > Signed-off-by: Michael Sammler <sammler@google.com>
> > ---
> >  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > index 20da455d2ef6..a92eb172f0e7 100644
> > --- a/drivers/nvdimm/virtio_pmem.c
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
> >  static int virtio_pmem_probe(struct virtio_device *vdev)
> >  {
> >         struct nd_region_desc ndr_desc = {};
> > -       int nid = dev_to_node(&vdev->dev);
> >         struct nd_region *nd_region;
> >         struct virtio_pmem *vpmem;
> >         struct resource res;
> > @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> >         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> >
> >         ndr_desc.res = &res;
> > -       ndr_desc.numa_node = nid;
> > +
> > +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> > +       ndr_desc.target_node = phys_to_target_node(res.start);
> > +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> > +               ndr_desc.target_node = ndr_desc.numa_node;
> > +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> > +                       NUMA_NO_NODE, ndr_desc.target_node);
> > +       }
>
> As this memory later gets hotplugged using "devm_memremap_pages". I don't
> see if 'target_node' is used for fsdax case?
>
> It seems to me "target_node" is used mainly for volatile range above
> persistent memory ( e.g kmem driver?).
>
I am not sure if 'target_node' is used in the fsdax case, but it is
indeed used by the devdax/kmem driver when hotplugging the memory (see
'dev_dax_kmem_probe' and '__dax_pmem_probe').

Best,
Michael
> Thanks,
> Pankaj
>
> > +
> >         ndr_desc.flush = async_pmem_flush;
> >         ndr_desc.provider_data = vdev;
> >         set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > --
