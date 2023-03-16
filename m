Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911C76BD171
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCPNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCPNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:53:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF12B291
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:53:27 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso2183946fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678974806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT2+ny4p/vVYNzr7+EK2Lb0ixcwCh6elsP4Qy0BaT6o=;
        b=epd5FV2Fr1C10Z/wxi9lYv0/neUD0acFnvSabLSTeExSFzq6FBR61NtOkPotXxqduE
         brCR6NrGy0nAd/ZuhyIKajahPVWlyqLKTMcu3j3/sqDJ0y7fODXdqghObHQRhZ0sAl7/
         ZnhPjY9r35Rq38NPvoRNjbxQWb3S+hxnmRL879TrtuNbeUNfmGvOwOY/0+Iotuys2qWe
         1LzrE9z6D3OK6j0RYoTO+2S49ip5lo7CjgK/iSYsB+95/j6YZUTv1irUX4KELtY418GT
         /BmDr2RP90VZB8Smm2fWftkXURgg+guml2VypqebETidlIzT3EMc6J33Jn9ApovvksTI
         uHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT2+ny4p/vVYNzr7+EK2Lb0ixcwCh6elsP4Qy0BaT6o=;
        b=Aa1z0EimFBUByTg03iDvhd/RIJgvXwIe18ZsKUdgkJVu23ukeaSbH/JmAQ+mNMf874
         BPi/LsC7vWF+GIof6/6e62Rjm7ldoLd093nEv7LL0WIkYWtkbRYqNG179eO5zirqOFWl
         qPXtYsQH8dH8OVfiiSr5PndtsfnLq9mlb8ElbeE1nBFEFmP6YdbjoQoNvqOUDmKn1Lsv
         eu4xHB1x12eho7wMA3XDimwZU8QzshLzITizg4GqGdh395swmIdZEI38egKSrq+TJsT5
         wCnur+qjEKs59LEjb7ZZSiIIEtg9C2TREqn72mQtRkhsY40/DBfPR2KgrIGjR4wuXwlW
         YI5g==
X-Gm-Message-State: AO0yUKUuurfeKCYKihkKF8bBbZYYRcyquM9pLdjZtuK/E4yvAS/rbfJm
        h0wFPW/MR1MrLCGPK7H8ZHGug1PH3WD8ZP2uwYQ=
X-Google-Smtp-Source: AK7set/x0uSpr4lrBp0ShQSg5kgvHD9bjWFd3R0T4/YE3AtaigBfKP2+ZizIOyaqzSaC6IVNg0nCI15OW1QygajqbX8=
X-Received: by 2002:a05:6870:886:b0:177:aa31:79d6 with SMTP id
 fx6-20020a056870088600b00177aa3179d6mr7154168oab.4.1678974806677; Thu, 16 Mar
 2023 06:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230312120157.452859-1-ray.huang@amd.com> <20230312120157.452859-2-ray.huang@amd.com>
 <ea0e3852-87ba-984b-4010-5eeac3d6c507@suse.com> <alpine.DEB.2.22.394.2303141747350.863724@ubuntu-linux-20-04-desktop>
 <f5e03f2a-8176-528f-e885-9a97940367c0@suse.com> <alpine.DEB.2.22.394.2303151616200.3462@ubuntu-linux-20-04-desktop>
 <5e22a45d-6f12-da9b-94f6-3112a30e8574@suse.com> <CADnq5_PH9ZqDqpPES74V3fB3NVpaexDoGTyu_+-zoux5vgagyg@mail.gmail.com>
 <dcb54275-b21f-a837-76bb-e19e331a0666@suse.com>
In-Reply-To: <dcb54275-b21f-a837-76bb-e19e331a0666@suse.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Mar 2023 09:53:14 -0400
Message-ID: <CADnq5_PpCWrZzQdE_X6ZnuNU3ktVeC6TbmE5vq3K6rCAdB8GTg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] x86/xen: disable swiotlb for xen pvh
To:     Juergen Gross <jgross@suse.com>
Cc:     Jan Beulich <jbeulich@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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

On Thu, Mar 16, 2023 at 9:48=E2=80=AFAM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 16.03.23 14:45, Alex Deucher wrote:
> > On Thu, Mar 16, 2023 at 3:50=E2=80=AFAM Jan Beulich <jbeulich@suse.com>=
 wrote:
> >>
> >> On 16.03.2023 00:25, Stefano Stabellini wrote:
> >>> On Wed, 15 Mar 2023, Jan Beulich wrote:
> >>>> On 15.03.2023 01:52, Stefano Stabellini wrote:
> >>>>> On Mon, 13 Mar 2023, Jan Beulich wrote:
> >>>>>> On 12.03.2023 13:01, Huang Rui wrote:
> >>>>>>> Xen PVH is the paravirtualized mode and takes advantage of hardwa=
re
> >>>>>>> virtualization support when possible. It will using the hardware =
IOMMU
> >>>>>>> support instead of xen-swiotlb, so disable swiotlb if current dom=
ain is
> >>>>>>> Xen PVH.
> >>>>>>
> >>>>>> But the kernel has no way (yet) to drive the IOMMU, so how can it =
get
> >>>>>> away without resorting to swiotlb in certain cases (like I/O to an
> >>>>>> address-restricted device)?
> >>>>>
> >>>>> I think Ray meant that, thanks to the IOMMU setup by Xen, there is =
no
> >>>>> need for swiotlb-xen in Dom0. Address translations are done by the =
IOMMU
> >>>>> so we can use guest physical addresses instead of machine addresses=
 for
> >>>>> DMA. This is a similar case to Dom0 on ARM when the IOMMU is availa=
ble
> >>>>> (see include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect, the correspo=
nding
> >>>>> case is XENFEAT_not_direct_mapped).
> >>>>
> >>>> But how does Xen using an IOMMU help with, as said, address-restrict=
ed
> >>>> devices? They may still need e.g. a 32-bit address to be programmed =
in,
> >>>> and if the kernel has memory beyond the 4G boundary not all I/O buff=
ers
> >>>> may fulfill this requirement.
> >>>
> >>> In short, it is going to work as long as Linux has guest physical
> >>> addresses (not machine addresses, those could be anything) lower than
> >>> 4GB.
> >>>
> >>> If the address-restricted device does DMA via an IOMMU, then the devi=
ce
> >>> gets programmed by Linux using its guest physical addresses (not mach=
ine
> >>> addresses).
> >>>
> >>> The 32-bit restriction would be applied by Linux to its choice of gue=
st
> >>> physical address to use to program the device, the same way it does o=
n
> >>> native. The device would be fine as it always uses Linux-provided <4G=
B
> >>> addresses. After the IOMMU translation (pagetable setup by Xen), we
> >>> could get any address, including >4GB addresses, and that is expected=
 to
> >>> work.
> >>
> >> I understand that's the "normal" way of working. But whatever the swio=
tlb
> >> is used for in baremetal Linux, that would similarly require its use i=
n
> >> PVH (or HVM) aiui. So unconditionally disabling it in PVH would look t=
o
> >> me like an incomplete attempt to disable its use altogether on x86. Wh=
at
> >> difference of PVH vs baremetal am I missing here?
> >
> > swiotlb is not usable for GPUs even on bare metal.  They often have
> > hundreds or megs or even gigs of memory mapped on the device at any
> > given time.  Also, AMD GPUs support 44-48 bit DMA masks (depending on
> > the chip family).
>
> But the swiotlb isn't per device, but system global.

Sure, but if the swiotlb is in use, then you can't really use the GPU.
So you get to pick one.

Alex
