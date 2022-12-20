Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5EC652726
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiLTTjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLTTjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:39:02 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F110BC;
        Tue, 20 Dec 2022 11:39:01 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i83so6909064ioa.11;
        Tue, 20 Dec 2022 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYaA/z9swc++YH1wobMl6bW+b+fBO50nDrSwqdy0I7E=;
        b=aGUxp6XWxBv8E8WQbtt82XBc9GS0fUYdPiKCQFh4EmyXeKrwmzTdS7vwIhZK8U7Rz7
         2OHLHXeXLr6h3+0XgZZ112VOYFO9ubc3WavVeJJW+Hc7xVZv1PWE6KMBwGmS2Ktf8oSV
         vsmsIJcE5rhJagrlJdYjc5bCy5mVLRmaaYoTmmuYHrUpvJM4LJXiWxSXVx4bbKxMKH7x
         UZPwqvFyRafXtiKJcLZSOG0xROtTYlP7oKI1nNivkXn4Pb+rrRnmkxhFgSN2R26fVTSR
         Ys8kIaIIrirRKFnKk3SVAfb1X8vAdrqBaHmtDxtbmb5Oxu/J+TkyySLkDE9nPtgh7Kfj
         V2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYaA/z9swc++YH1wobMl6bW+b+fBO50nDrSwqdy0I7E=;
        b=GqesuMsQ5onN/ABuiiIrOhUqu+dz8tY0aqmyMB+4nRIMo9V6znc70es+2jviHs+Ky1
         EuDYv6Naajo4jC/iiU9fDH3UUrin8bIWe3xP09Wkvvh2nOFWchr5xzHRqV6YT4/nb3Pi
         IFy5KXum5/OclHppQJM+8tN53noaaPWgEgnt+Q2gjoU7MiF/YR0uwVLuc3OSQQjpAmKi
         e62AeMYIk58FNtzMY8+f/aYE2kqjDD0QqweDbJHi853/BkFZJ5uIb8/yV08HSk/tGFN1
         CvH/CzUpS0A0fCbdyhBTo2Be2zG/gtYg7tOfwbTosy8/9l81hQLg+JhTZcjDh36s5NfF
         5NoQ==
X-Gm-Message-State: ANoB5pmfHILfXFWLsWQzsflTjd0wXz0gFbp2+njY8F5DSdmWGqXQt4a/
        Magh97MsHCu27HBrWkxNCN+oalx1/pd8S//iY5Q=
X-Google-Smtp-Source: AA0mqf6kOU4KSWIg4U3q900GDMNzZiF6FHB28sxddMACnN7EnmMJ8RpCYVPbVvEQMU82GwcTvMt84Y9obrESxAemX6Y=
X-Received: by 2002:a05:6638:36e5:b0:38a:53d5:1488 with SMTP id
 t37-20020a05663836e500b0038a53d51488mr11480218jau.146.1671565139680; Tue, 20
 Dec 2022 11:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20221216132404.1173254-1-wenst@chromium.org>
In-Reply-To: <20221216132404.1173254-1-wenst@chromium.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 20 Dec 2022 13:38:47 -0600
Message-ID: <CAHCN7xJfR34WxigZSYcntWOsry4sc8ZJ9_T1comd0R5Z5Na7vA@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Use core-generated bus_info value
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 7:46 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> The Hantro driver uses a hardcoded value for the bus_info field in the
> media device and |struct v4l2_capability|. This worked well when there
> was just one device. However with the iMX.8 series we are now seeing
> two Hantro blocks on the same chip. The static bus_info is no longer
> sufficient for differentiating devices.
>
> Since commit f2d8b6917f3b ("media: v4l: ioctl: Set bus_info in
> v4l_querycap()"), the V4L2 core provides a default value for the
> bus_info field for platform and PCI devices. This value will match
> the default value for media devices added by commit cef699749f37
> ("media: mc: Set bus_info in media_device_init()"). These defaults
> are stable and device-specific.
>
> Drop the static bus_info values from the hantro driver and use the
> defaults.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile           | 1 +
>  drivers/media/platform/verisilicon/hantro_drv.c  | 2 --
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index ef6f364eaa18..ef815442c78b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -55,6 +55,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-hummingboard-pulse.dtb

I think the makefile was edited by mistake.

>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-innocomm-wb15-evk.dtb
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 8cb4a68c9119..b0aeedae7b65 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -1050,8 +1050,6 @@ static int hantro_probe(struct platform_device *pdev)
>
>         vpu->mdev.dev = vpu->dev;
>         strscpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
> -       strscpy(vpu->mdev.bus_info, "platform: " DRIVER_NAME,
> -               sizeof(vpu->mdev.bus_info));
>         media_device_init(&vpu->mdev);
>         vpu->mdev.ops = &hantro_m2m_media_ops;
>         vpu->v4l2_dev.mdev = &vpu->mdev;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..c1a116031013 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -142,8 +142,6 @@ static int vidioc_querycap(struct file *file, void *priv,
>
>         strscpy(cap->driver, vpu->dev->driver->name, sizeof(cap->driver));
>         strscpy(cap->card, vdev->name, sizeof(cap->card));
> -       snprintf(cap->bus_info, sizeof(cap->bus_info), "platform: %s",
> -                vpu->dev->driver->name);
>         return 0;
>  }
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
