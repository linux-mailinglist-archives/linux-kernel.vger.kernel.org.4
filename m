Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A660AED9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiJXPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJXPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:18:07 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9382DF46
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:59:28 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13b103a3e5dso11941466fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SLy1rvfHOR6fvZX4wUC0MNcz5p/zlg2NigI8l8/yRGs=;
        b=CqIasuSZ5uIB8stglnpfvRgHPEbtPHy4hdOHecTc7Ln8YdB+iByVHXCFS9O2jfv8PS
         wU3QKz7U4/dHwBkvlQPvjTn1W4rbR3OQc8uqQg/iaRau7l/WE8jbC8gL800Vqutztqmv
         HTDTDtx6225EYgaNUh4EYdNwjXq9ogpoAVym2U2JDkBmcURzY1R/t+sjRk8LX+1CvCa3
         QnVX3pCx0r7jePe6fBuwR9qmwLRL4fs0iNSYh8ss534bjb4SkiBCWp9jN62nGtG6koa1
         a5Vhv1SQt0cCmuIBDKUsoD871gE8ZmPtDyAyIfEVdcAuYG9tej/ZJM103Xl1yLqmuWlG
         k70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLy1rvfHOR6fvZX4wUC0MNcz5p/zlg2NigI8l8/yRGs=;
        b=M+3Oc9AGdcgAkikNz01IcQRX52fftBlflHBeCRfAsJr66fd0Sl+lZQDtGtzRdQXBpS
         cLzIAKS3E11zVtT1q2V5KN73LnqUoovuGRQWWvBhj6hDd+CaCI8WI1pVgq6M3s5OTfdS
         Zts1QBsNBIIR1bVrSp3OJhj54c+RH2fCdYX22oU0yEET5km6kcVdvcDqYAfejuQfLKpJ
         2QDKYXvvMhqX9wMhoc5M/4hqXHLPcke9JgA1RlkFAzbJGVo6Odtl2E0pC771+nmBBym+
         G6K1P2zSjirZuD4eIXEhAeT+xIawyBge5U6ZdgqQT4KqSTwQ580Edk+AtJUMl3Rf0jFT
         k2aw==
X-Gm-Message-State: ACrzQf33jvDFAciK+rxJXqQiMbk5ZOSs+Ju1M+AW7Rq63TjxIdvPq2+H
        Ckrwc9IEdMaDgMz3dI2nIBBFS1xlXJfNjFxdBQE=
X-Google-Smtp-Source: AMsMyM48BEV6gAD+fDU7fEZlSOoxZrxa19LvRseYRI0OoiztkA6ySW4NEyHuhDukEgkIZ/ClEr209+UfXCrwSUhHQqY=
X-Received: by 2002:a05:6870:a116:b0:13a:f9de:6fd0 with SMTP id
 m22-20020a056870a11600b0013af9de6fd0mr13348716oae.46.1666619717251; Mon, 24
 Oct 2022 06:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org>
In-Reply-To: <20221022214622.18042-1-ogabbay@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Oct 2022 09:55:05 -0400
Message-ID: <CADnq5_PwNwsSUeyhXDkoy-y1JXFrTj99AgVV02oHX0a29QUXpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jiho Chu <jiho.chu@samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 5:46 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> In the last couple of months we had a discussion [1] about creating a new
> subsystem for compute accelerator devices in the kernel.
>
> After an analysis that was done by DRM maintainers and myself, and following
> a BOF session at the Linux Plumbers conference a few weeks ago [2], we
> decided to create a new subsystem that will use the DRM subsystem's code and
> functionality. i.e. the accel core code will be part of the DRM subsystem.
>
> This will allow us to leverage the extensive DRM code-base and
> collaborate with DRM developers that have experience with this type of
> devices. In addition, new features that will be added for the accelerator
> drivers can be of use to GPU drivers as well (e.g. RAS).
>
> As agreed in the BOF session, the accelerator devices will be exposed to
> user-space with a new, dedicated device char files and a dedicated major
> number (261), to clearly separate them from graphic cards and the graphic
> user-space s/w stack. Furthermore, the drivers will be located in a separate
> place in the kernel tree (drivers/accel/).
>
> This series of patches is the first step in this direction as it adds the
> necessary infrastructure for accelerator devices to DRM. The new devices will
> be exposed with the following convention:
>
> device char files - /dev/accel/accel*
> sysfs             - /sys/class/accel/accel*/
> debugfs           - /sys/kernel/debug/accel/accel*/
>
> I tried to reuse the existing DRM code as much as possible, while keeping it
> readable and maintainable.

Wouldn't something like this:
https://patchwork.freedesktop.org/series/109575/
Be simpler and provide better backwards compatibility for existing
non-gfx devices in the drm subsystem as well as newer devices?

Alex

>
> One thing that is missing from this series is defining a namespace for the
> new accel subsystem, while I'll add in the next iteration of this patch-set,
> after I will receive feedback from the community.
>
> As for drivers, once this series will be accepted (after adding the namespace),
> I will start working on migrating the habanalabs driver to the new accel
> subsystem. I have talked about it with Dave and we agreed that it will be
> a good start to simply move the driver as-is with minimal changes, and then
> start working on the driver's individual features that will be either added
> to the accel core code (with or without changes), or will be removed and
> instead the driver will use existing DRM code.
>
> In addition, I know of at least 3 or 4 drivers that were submitted for review
> and are good candidates to be included in this new subsystem, instead of being
> a drm render node driver or a misc driver.
>
> [1] https://lkml.org/lkml/2022/7/31/83
> [2] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html
>
> Thanks,
> Oded
>
> Oded Gabbay (3):
>   drivers/accel: add new kconfig and update MAINTAINERS
>   drm: define new accel major and register it
>   drm: add dedicated minor for accelerator devices
>
>  Documentation/admin-guide/devices.txt |   5 +
>  MAINTAINERS                           |   8 +
>  drivers/Kconfig                       |   2 +
>  drivers/accel/Kconfig                 |  24 +++
>  drivers/gpu/drm/drm_drv.c             | 214 +++++++++++++++++++++-----
>  drivers/gpu/drm/drm_file.c            |  69 ++++++---
>  drivers/gpu/drm/drm_internal.h        |   5 +-
>  drivers/gpu/drm/drm_sysfs.c           |  81 +++++++++-
>  include/drm/drm_device.h              |   3 +
>  include/drm/drm_drv.h                 |   8 +
>  include/drm/drm_file.h                |  21 ++-
>  include/drm/drm_ioctl.h               |   1 +
>  12 files changed, 374 insertions(+), 67 deletions(-)
>  create mode 100644 drivers/accel/Kconfig
>
> --
> 2.34.1
>
