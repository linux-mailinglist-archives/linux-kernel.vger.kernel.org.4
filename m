Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7E6328D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiKUP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiKUP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:58:40 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A42C9A98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:58:39 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l127so12946562oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Q+0MfaVGvddTD+8xtgNvdChtHP9WL1IrfM4mIdp8U=;
        b=eskIWZFK5N+Qzhoa5iX5oKoPLHzl9CG4du3z7W8zDsQjUFBgsOUXcaP0To7YMUy59z
         Pkj6PGk5z1bWu8Izb2p0b/L57NDJmJBVCvf7nCtc6fDgW/Jl2e+q4WZJx51flkH056sB
         n0j8SgTngmuljV9XEQsoldmpHYGrPm0yorH9j7NL1cm+K2NOWEyNmWaxHeltFf8EdmVQ
         3xcsLsGC9guCb1FXMomdTkp+0v9j8NxcnWin+Cd8ohRcsZneBfFyUNoSnLw/1IRP6399
         6DbdcuLrSIqXoqAdrHcTgMX+OxJQKvFzJlVqa0sjXpQtH6TOJiPrNV1Lc55IfNJszjF0
         lJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4Q+0MfaVGvddTD+8xtgNvdChtHP9WL1IrfM4mIdp8U=;
        b=1B8VuwewTGkHb/qc+RZK/on0Y9sbTfjcePe/MoUDdRhZSjKnhBT9R1IYTVJPHuIXE6
         kddqnQ9dbSjn8UVHeK5oS8IoqFZ+rABxBEPHfWMsQsGpNJssCcSMKPOlHV1INNC2KvFa
         fdGlKNv+7kGmuDSg5YqhH5tsDutKNsKIPVNzEaUSB/DaPBu+R00HOEEYvKaoINHkvqWz
         Q60BG1mCzPiiYw4EE6qmzNYw99rA3VqjrCsrl9wf4f0JwWiwMTp8gp8LZxe4wMVtEHp/
         OIebv8ImFcijIMJL1Su6jDmK5P4QKZEiA11sHr7k5JDI71gaBYwFRgiM2e00X8I155qW
         eQug==
X-Gm-Message-State: ANoB5pknyEsU9bbJ3C20jp4LEEqOPXe/qjoyWB293vUjvhN0yOVgCi/3
        atCOTK57wARgzxzqyABbAvYJVd2ecbAVCMMYxTU=
X-Google-Smtp-Source: AA0mqf6I4jr6wT+uWfZSCYLVdC4qM8crbZNH3OaqBsBu/hYhf35OlR2tPJqrzPCmaDoivSfOY1IqIpAKwXiBEGfS0vc=
X-Received: by 2002:a05:6808:295:b0:357:670f:9e4e with SMTP id
 z21-20020a056808029500b00357670f9e4emr12430765oic.46.1669046318747; Mon, 21
 Nov 2022 07:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org> <CADnq5_MimkbzXXs+kwNTLSzLrcqpm+-7w3gZA8UiJVxQ8aapOg@mail.gmail.com>
In-Reply-To: <CADnq5_MimkbzXXs+kwNTLSzLrcqpm+-7w3gZA8UiJVxQ8aapOg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Nov 2022 10:58:27 -0500
Message-ID: <CADnq5_MS_SGqTfA7v31TVBb6Fv_TZM=+jnJoAMJzJWjEL=4_2g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiho Chu <jiho.chu@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Friedt <chrisfriedt@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Mon, Nov 21, 2022 at 10:57 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sat, Nov 19, 2022 at 3:44 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > This is the fourth (and hopefully last) version of the patch-set to add the
> > new subsystem for compute accelerators. I removed the RFC headline as
> > I believe it is now ready for merging.
> >
> > Compare to v3, this patch-set contains one additional patch that adds
> > documentation regarding the accel subsystem. I hope it's good enough for
> > this stage. In addition, there were few very minor fixes according to
> > comments received on v3.
> >
> > The patches are in the following repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4
> >
> > As in v3, The HEAD of that branch is a commit adding a dummy driver that
> > registers an accel device using the new framework. This can be served
> > as a simple reference.
> >
> > v1 cover letter:
> > https://lkml.org/lkml/2022/10/22/544
> >
> > v2 cover letter:
> > https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/
> >
> > v3 cover letter:
> > https://lore.kernel.org/lkml/20221106210225.2065371-1-ogabbay@kernel.org/T/
> >
>
> With the understanding that individual drivers can choose to use
> either classic drm or accel, whichever makes the most sense to them,
> this series is:
> Acked-by: Alex Deucher <alexander.deucer@amd.com>

and not typo my email:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> > Thanks,
> > Oded.
> >
> > Oded Gabbay (4):
> >   drivers/accel: define kconfig and register a new major
> >   accel: add dedicated minor for accelerator devices
> >   drm: initialize accel framework
> >   doc: add documentation for accel subsystem
> >
> >  Documentation/accel/index.rst         |  17 ++
> >  Documentation/accel/introduction.rst  | 109 +++++++++
> >  Documentation/admin-guide/devices.txt |   5 +
> >  Documentation/subsystem-apis.rst      |   1 +
> >  MAINTAINERS                           |   9 +
> >  drivers/Kconfig                       |   2 +
> >  drivers/accel/Kconfig                 |  24 ++
> >  drivers/accel/drm_accel.c             | 323 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/Makefile              |   1 +
> >  drivers/gpu/drm/drm_drv.c             | 102 +++++---
> >  drivers/gpu/drm/drm_file.c            |   2 +-
> >  drivers/gpu/drm/drm_sysfs.c           |  24 +-
> >  include/drm/drm_accel.h               |  97 ++++++++
> >  include/drm/drm_device.h              |   3 +
> >  include/drm/drm_drv.h                 |   8 +
> >  include/drm/drm_file.h                |  21 +-
> >  16 files changed, 711 insertions(+), 37 deletions(-)
> >  create mode 100644 Documentation/accel/index.rst
> >  create mode 100644 Documentation/accel/introduction.rst
> >  create mode 100644 drivers/accel/Kconfig
> >  create mode 100644 drivers/accel/drm_accel.c
> >  create mode 100644 include/drm/drm_accel.h
> >
> > --
> > 2.25.1
> >
