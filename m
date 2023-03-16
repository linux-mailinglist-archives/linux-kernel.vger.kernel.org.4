Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E506BD12B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjCPNpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCPNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:45:27 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5A97FDA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:45:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so1009649otv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678974326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWCKbtplZJ+ZPgiQ+llRwn6vMzQlR6RfveV/kyzoYt0=;
        b=Fa5TBJOICTZGaAxV8ye5x/ZGojNIPknDBs5bvwl/jjueeLJVcAM9u1WFzuXQI7xZCR
         n7Kg/cy4BRgB25po6d/b/l6zWT4zDdvL2TmjSvcTB6aaPSDjYx0DTg7J/Ef3bJ1vHrfP
         oc3iTg8aJ+duikjB3ZL0qXYVMXCAAwGrg+YD3g82Cdkt6m3gdjfq+00C3MOagRFgOfPO
         8gPjTi+3DqW8ZvZ1o+KlDr+O1RGQYuO6L99FTGyc/GY1iALewM4OETUp5E3miX4XFIFp
         eYrGZtgMHqU4iH1Yk3QGWbiUWd99Q6qZxWmwmN3GvrpCWRJrOrbOR4SzR863ePdEPcBC
         C/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWCKbtplZJ+ZPgiQ+llRwn6vMzQlR6RfveV/kyzoYt0=;
        b=APmumV5bJQf0XyJ1pRKZ9CVWMpfNHWV+FTcn0HHdWZH1hA6xC3lvRFvESGgIFun7Gu
         nXLBaQykUDOdWyk/o+rb8mbHtrxVKktrKhdiBmgR+HGRvCaGwWAOAYW8YYHhYGl89d5K
         SmSFjW8qolH8BkaNaTsfozbk1RoVMo0nu93gs/zm3ua6BJTtCUIlhJtADTnyy3L19Fcy
         1Cuwc4gjvWgvLLSB1nvhgDptSuyDbXJil1QSrxToFVWnt4UxjAQVqeKAlbFyQr3w7iKv
         XeFWxcMtAb52z12F7Hw5aNOuyBwGwQeRzPiRkzCgONEwFSNZSPXtIA9l7CQbioZ4avk9
         ER1w==
X-Gm-Message-State: AO0yUKXSfTbR2FaWaTwNshZhEGUKKuqqqVkJq7wdrnAiCNtWTJ+EMsZG
        Tv9ZrxmyLPV9MPxwjLlOD8FaQ7up5hXJ2HK4Gzw=
X-Google-Smtp-Source: AK7set+3qR+KxTZtbczZDS3CGBW6F0/GCDOIJw7w85TfFDZI7hjqtUvXWb4ZF1iNyyygRY1zoh1WOtxULP5svQP6l+0=
X-Received: by 2002:a05:6830:3345:b0:698:d198:fe9a with SMTP id
 l5-20020a056830334500b00698d198fe9amr2702720ott.3.1678974325749; Thu, 16 Mar
 2023 06:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230312120157.452859-1-ray.huang@amd.com> <20230312120157.452859-2-ray.huang@amd.com>
 <ea0e3852-87ba-984b-4010-5eeac3d6c507@suse.com> <alpine.DEB.2.22.394.2303141747350.863724@ubuntu-linux-20-04-desktop>
 <f5e03f2a-8176-528f-e885-9a97940367c0@suse.com> <alpine.DEB.2.22.394.2303151616200.3462@ubuntu-linux-20-04-desktop>
 <5e22a45d-6f12-da9b-94f6-3112a30e8574@suse.com>
In-Reply-To: <5e22a45d-6f12-da9b-94f6-3112a30e8574@suse.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Mar 2023 09:45:14 -0400
Message-ID: <CADnq5_PH9ZqDqpPES74V3fB3NVpaexDoGTyu_+-zoux5vgagyg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] x86/xen: disable swiotlb for xen pvh
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Huang Rui <ray.huang@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julia Zhang <julia.zhang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 3:50=E2=80=AFAM Jan Beulich <jbeulich@suse.com> wro=
te:
>
> On 16.03.2023 00:25, Stefano Stabellini wrote:
> > On Wed, 15 Mar 2023, Jan Beulich wrote:
> >> On 15.03.2023 01:52, Stefano Stabellini wrote:
> >>> On Mon, 13 Mar 2023, Jan Beulich wrote:
> >>>> On 12.03.2023 13:01, Huang Rui wrote:
> >>>>> Xen PVH is the paravirtualized mode and takes advantage of hardware
> >>>>> virtualization support when possible. It will using the hardware IO=
MMU
> >>>>> support instead of xen-swiotlb, so disable swiotlb if current domai=
n is
> >>>>> Xen PVH.
> >>>>
> >>>> But the kernel has no way (yet) to drive the IOMMU, so how can it ge=
t
> >>>> away without resorting to swiotlb in certain cases (like I/O to an
> >>>> address-restricted device)?
> >>>
> >>> I think Ray meant that, thanks to the IOMMU setup by Xen, there is no
> >>> need for swiotlb-xen in Dom0. Address translations are done by the IO=
MMU
> >>> so we can use guest physical addresses instead of machine addresses f=
or
> >>> DMA. This is a similar case to Dom0 on ARM when the IOMMU is availabl=
e
> >>> (see include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect, the correspond=
ing
> >>> case is XENFEAT_not_direct_mapped).
> >>
> >> But how does Xen using an IOMMU help with, as said, address-restricted
> >> devices? They may still need e.g. a 32-bit address to be programmed in=
,
> >> and if the kernel has memory beyond the 4G boundary not all I/O buffer=
s
> >> may fulfill this requirement.
> >
> > In short, it is going to work as long as Linux has guest physical
> > addresses (not machine addresses, those could be anything) lower than
> > 4GB.
> >
> > If the address-restricted device does DMA via an IOMMU, then the device
> > gets programmed by Linux using its guest physical addresses (not machin=
e
> > addresses).
> >
> > The 32-bit restriction would be applied by Linux to its choice of guest
> > physical address to use to program the device, the same way it does on
> > native. The device would be fine as it always uses Linux-provided <4GB
> > addresses. After the IOMMU translation (pagetable setup by Xen), we
> > could get any address, including >4GB addresses, and that is expected t=
o
> > work.
>
> I understand that's the "normal" way of working. But whatever the swiotlb
> is used for in baremetal Linux, that would similarly require its use in
> PVH (or HVM) aiui. So unconditionally disabling it in PVH would look to
> me like an incomplete attempt to disable its use altogether on x86. What
> difference of PVH vs baremetal am I missing here?

swiotlb is not usable for GPUs even on bare metal.  They often have
hundreds or megs or even gigs of memory mapped on the device at any
given time.  Also, AMD GPUs support 44-48 bit DMA masks (depending on
the chip family).

Alex
