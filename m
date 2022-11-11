Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94E06263E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKVzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:11 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F68419C31
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:55:10 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id g4so2391113vkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBLvh8HDrSTVyJY825uCLCQg+DtN/s4Hedrzyz0sKsQ=;
        b=qRUpMGjO41oswo0eWuEJnL4lA6NTT3EottV/MKOhv1tfm/fvdBrbl39qD6To/pMojR
         IwOBWiSNm7tAIA4WarulF7NmnuUTnSQlYsVRd+fJJuwyIVVv09kapCofm75y04VBq8mk
         NcITIDrEsTVstEUdOc6P1N9ujcKvGH7WtxppnDUYH8jfs0HonyGc9freox75/pgD0Yjd
         c3aYqH6tbuXg5y7bssFWlZnSPDGYJk3pVMDsNJN0fbqJXKjcPrnt3iHCEtjqMaUU/PFz
         rT3+NWDi9DWgY2SP04fOx8pSp9qR3pi1fhEuNKxivQdoLtdmNmTjlbeMsrXPhDKgJ1rR
         30ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBLvh8HDrSTVyJY825uCLCQg+DtN/s4Hedrzyz0sKsQ=;
        b=aOko2C+G9bDDWn04/82ByWRrYoKCNbtQXGhsEXAMtONO4K8LYkc85mMa54l9S8Wp9E
         b5PGjclpAklaVpOVETM5q/w1P3iVBYxGH3mib+rYN8vR6s8RjshkoJjUw3+DYZZpmRl/
         vFQ1f0CNCwyMnTp4kg0FIdIs0qxM7Ulta5ItVaUCFnZo0yMX9S76MWdyrT/3lTBFskNM
         N7U5ASnVEv1/2HKfk8yfcaYmJ3pikfN3c+MLdYgh6h1z+fODrIHRi59f1WyLWrX4wnVX
         V+vRg0Uy1Bm+JRMid5RiEz8j4vMI2t+Wc2saUXpmWvx6IEU01l7bZgKufZ/BrWIYNBZT
         2yFQ==
X-Gm-Message-State: ANoB5pmAC4J+Nw4lMftetlzw7GLume2M5O+N70Va52Xn9YsVdJkRfr8B
        QBHG4ysm5jKTFUwvoCZ9PWHrPbg0krDA9a+M6Mto5w==
X-Google-Smtp-Source: AA0mqf6064Vn0CTjnLKRKzlBqbKkwGHDuSg2sxSCL5xzBsXvlzlPBQOwhe/EC0YWvSGl/TWX4sMwuQqebjxjD085XVs=
X-Received: by 2002:a05:6122:852:b0:3b8:68cc:1d1d with SMTP id
 18-20020a056122085200b003b868cc1d1dmr2098111vkk.14.1668203709387; Fri, 11 Nov
 2022 13:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com> <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
 <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
 <CAM9Jb+hk0ZRtXnF+WVj0LiRiO7uH-jDydJrnUQ_57yTEcs--Dw@mail.gmail.com> <6359ab83d6e4d_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6359ab83d6e4d_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 11 Nov 2022 13:54:58 -0800
Message-ID: <CAHS8izOYYV+dz3vPdbkipt1i1XAU-mvJOn6c_z-NJJwzUtWzDg@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michael Sammler <sammler@google.com>,
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

On Wed, Oct 26, 2022 at 2:50 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Pankaj Gupta wrote:
> > > > > Compute the numa information for a virtio_pmem device from the memory
> > > > > range of the device. Previously, the target_node was always 0 since
> > > > > the ndr_desc.target_node field was never explicitly set. The code for
> > > > > computing the numa node is taken from cxl_pmem_region_probe in
> > > > > drivers/cxl/pmem.c.
> > > > >
> > > > > Signed-off-by: Michael Sammler <sammler@google.com>

Tested-by: Mina Almasry <almasrymina@google.com>

I don't have much expertise on this driver, but with the help of this
patch I was able to get memory tiering [1] emulation going on qemu. As
far as I know there is no alternative to this emulation, and so I
would love to see this or equivalent merged, if possible.

This is what I have going to get memory tiering emulation:

In qemu, added these configs:
      -object memory-backend-file,id=m4,share=on,mem-path="$path_to_virtio_pmem_file",size=2G
\
      -smp 2,sockets=2,maxcpus=2  \
      -numa node,nodeid=0,memdev=m0 \
      -numa node,nodeid=1,memdev=m1 \
      -numa node,nodeid=2,memdev=m2,initiator=0 \
      -numa node,nodeid=3,initiator=0 \
      -device virtio-pmem-pci,memdev=m4,id=nvdimm1 \

On boot, ran these commands:
    ndctl_static create-namespace -e namespace0.0 -m devdax -f 1&> /dev/null
    echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
    echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
    for i in `ls /sys/devices/system/memory/`; do
      state=$(cat "/sys/devices/system/memory/$i/state" 2&>/dev/null)
      if [ "$state" == "offline" ]; then
        echo online_movable > "/sys/devices/system/memory/$i/state"
      fi
    done

Without this CL, I see the memory onlined in node 0 always, and is not
a separate memory tier. With this CL and qemu configs, the memory is
onlined in node 3 and is set as a separate memory tier, which enables
qemu-based development:

==> /sys/devices/virtual/memory_tiering/memory_tier22/nodelist <==
3
==> /sys/devices/virtual/memory_tiering/memory_tier4/nodelist <==
0-2

AFAIK there is no alternative to enabling memory tiering emulation in
qemu, and would love to see this or equivalent merged, if possible.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers

> > > > > ---
> > > > >  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
> > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > > > > index 20da455d2ef6..a92eb172f0e7 100644
> > > > > --- a/drivers/nvdimm/virtio_pmem.c
> > > > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > > > @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
> > > > >  static int virtio_pmem_probe(struct virtio_device *vdev)
> > > > >  {
> > > > >         struct nd_region_desc ndr_desc = {};
> > > > > -       int nid = dev_to_node(&vdev->dev);
> > > > >         struct nd_region *nd_region;
> > > > >         struct virtio_pmem *vpmem;
> > > > >         struct resource res;
> > > > > @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> > > > >         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > > > >
> > > > >         ndr_desc.res = &res;
> > > > > -       ndr_desc.numa_node = nid;
> > > > > +
> > > > > +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> > > > > +       ndr_desc.target_node = phys_to_target_node(res.start);
> > > > > +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> > > > > +               ndr_desc.target_node = ndr_desc.numa_node;
> > > > > +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> > > > > +                       NUMA_NO_NODE, ndr_desc.target_node);
> > > > > +       }
> > > >
> > > > As this memory later gets hotplugged using "devm_memremap_pages". I don't
> > > > see if 'target_node' is used for fsdax case?
> > > >
> > > > It seems to me "target_node" is used mainly for volatile range above
> > > > persistent memory ( e.g kmem driver?).
> > > >
> > > I am not sure if 'target_node' is used in the fsdax case, but it is
> > > indeed used by the devdax/kmem driver when hotplugging the memory (see
> > > 'dev_dax_kmem_probe' and '__dax_pmem_probe').
> >
> > Yes, but not currently for FS_DAX iiuc.
>
> The target_node is only used by the dax_kmem driver. In the FSDAX case
> the memory (persistent or otherwise) is mapped behind a block-device.
> That block-device has affinity to a CPU initiator, but that memory does
> not itself have any NUMA affinity or identity as a target.
>
> So:
>
> block-device NUMA node == closest CPU initiator node to the device
>
> dax-device target node == memory only NUMA node target, after onlining
