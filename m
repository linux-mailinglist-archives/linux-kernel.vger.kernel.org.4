Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DBB6328C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKUP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:57:49 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90486AA45B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:57:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id h132so12967357oif.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik+O2yFhiDkDp3RkLBc5Rnv+Co0LOibULw9gEY7U8T0=;
        b=JN//ENGvlRn+Adk9i9dEqbgbYOd1F8XKs2vSvWxb4UvltkdIPUpjJi+gas/8glOu5j
         Opu4z7SYkrFCk4VBXajZ5KB5IwF+wHvPRwttDADAXbUF0Gxy2YAIqAPK2ROgVDdz13jU
         XAgGciFflBGnt/DrBshokkAa/IngSYsGTH0yOrDcrlahZps0PNQRcwEpDHHFLYwGdOBt
         ty9kKiyjibB/zgI7JjOvmR158NiOZBXVoaDTB/3/4qPrLSmSSBgqM4XGjmlU18ikyTcq
         eXer+0mr5qMZhxjmuKNWFj16lZyy7xCJSKiw1cNyar92H8iZjwuLV38RelhzJYGwTPrF
         t+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ik+O2yFhiDkDp3RkLBc5Rnv+Co0LOibULw9gEY7U8T0=;
        b=O60ERDJiabYciT1Y9dgNfCaUefPFFY1ZjU5kklOBq3k1DzVEKaJyYeuifojTVz6SpH
         rRDclrAfochvGyjf2DHQbLFQghlpP1uyqcOzRAMZMPZU7zI6O1v7YZJthmG0wKoA07a0
         WuE+atfxpoCquwbGf8xUigFtjYfOyrej9Y3vGFVW8duscOnSkaOf8EJCrXrHjA4aksEJ
         XToR2eTg3tdRcI+3CIe/xx4X8cFMA0TyloRivDM7VzJJlAzlLCcenyqtuyJROI1RjmzN
         tjQxAg36Gc4jd0LrwYElOohOrj66qduZ+vbWnSjYgjMSZ/6RQcUBko8j70qkwJpItwBE
         BJsQ==
X-Gm-Message-State: ANoB5pllxYULgiVaEMfpyd3pN+XRnISeV/CL5tpszRvKpYPxogB5zrzB
        vjrBcyMW7cB1mYYa1cKo1h1nlQ425tBS3DCgQP4=
X-Google-Smtp-Source: AA0mqf7B3UhZryQX9jOhaPL639OMvZw+mGDaYvFySZZA3OASotQiSxDe9JLWFat9fZ59veXeogwiQ6KhlqPmnfMRgbA=
X-Received: by 2002:a05:6808:9b8:b0:34f:97ea:14d with SMTP id
 e24-20020a05680809b800b0034f97ea014dmr9344853oig.96.1669046267882; Mon, 21
 Nov 2022 07:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org>
In-Reply-To: <20221119204435.97113-1-ogabbay@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Nov 2022 10:57:36 -0500
Message-ID: <CADnq5_MimkbzXXs+kwNTLSzLrcqpm+-7w3gZA8UiJVxQ8aapOg@mail.gmail.com>
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

On Sat, Nov 19, 2022 at 3:44 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> This is the fourth (and hopefully last) version of the patch-set to add the
> new subsystem for compute accelerators. I removed the RFC headline as
> I believe it is now ready for merging.
>
> Compare to v3, this patch-set contains one additional patch that adds
> documentation regarding the accel subsystem. I hope it's good enough for
> this stage. In addition, there were few very minor fixes according to
> comments received on v3.
>
> The patches are in the following repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4
>
> As in v3, The HEAD of that branch is a commit adding a dummy driver that
> registers an accel device using the new framework. This can be served
> as a simple reference.
>
> v1 cover letter:
> https://lkml.org/lkml/2022/10/22/544
>
> v2 cover letter:
> https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/
>
> v3 cover letter:
> https://lore.kernel.org/lkml/20221106210225.2065371-1-ogabbay@kernel.org/T/
>

With the understanding that individual drivers can choose to use
either classic drm or accel, whichever makes the most sense to them,
this series is:
Acked-by: Alex Deucher <alexander.deucer@amd.com>

> Thanks,
> Oded.
>
> Oded Gabbay (4):
>   drivers/accel: define kconfig and register a new major
>   accel: add dedicated minor for accelerator devices
>   drm: initialize accel framework
>   doc: add documentation for accel subsystem
>
>  Documentation/accel/index.rst         |  17 ++
>  Documentation/accel/introduction.rst  | 109 +++++++++
>  Documentation/admin-guide/devices.txt |   5 +
>  Documentation/subsystem-apis.rst      |   1 +
>  MAINTAINERS                           |   9 +
>  drivers/Kconfig                       |   2 +
>  drivers/accel/Kconfig                 |  24 ++
>  drivers/accel/drm_accel.c             | 323 ++++++++++++++++++++++++++
>  drivers/gpu/drm/Makefile              |   1 +
>  drivers/gpu/drm/drm_drv.c             | 102 +++++---
>  drivers/gpu/drm/drm_file.c            |   2 +-
>  drivers/gpu/drm/drm_sysfs.c           |  24 +-
>  include/drm/drm_accel.h               |  97 ++++++++
>  include/drm/drm_device.h              |   3 +
>  include/drm/drm_drv.h                 |   8 +
>  include/drm/drm_file.h                |  21 +-
>  16 files changed, 711 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/accel/index.rst
>  create mode 100644 Documentation/accel/introduction.rst
>  create mode 100644 drivers/accel/Kconfig
>  create mode 100644 drivers/accel/drm_accel.c
>  create mode 100644 include/drm/drm_accel.h
>
> --
> 2.25.1
>
