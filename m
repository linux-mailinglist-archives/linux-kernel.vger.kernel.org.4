Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2465601A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 06:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLZF0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 00:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZF0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 00:26:00 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E803B2AF4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 21:25:58 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id z23so2189618uae.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 21:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sT3SK0Ig9Fw55mcy0k8TpGrOXIEw8Q66Z7qmqIKL+Xo=;
        b=bkAvYw3P4z43Jck4xYrm2EDIVwSyjXsMPw6Ej62zjflu7zLVYcEbvHL7oATljZ36ak
         fEPJS5eoYNJmawUGEHrYBS9UlPwzyaIbYoIp2uXlKvN+7vjNfyED7Qob/NRLQjnHJgnV
         +ISzyN0cFXj/e4w2qVh2D1IRwDEgxbLbFEI+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT3SK0Ig9Fw55mcy0k8TpGrOXIEw8Q66Z7qmqIKL+Xo=;
        b=AZ3y3Q7temnxqTDQWdyl+P9wVWuJURmiOX2V+515Wf2xHwLs4sGsk4jOeLYmS1Vx4R
         ++NjvH/hGTqvDg7Js0FI5lHLJyep3KY9Gj5miFFMPXx8FtayFJbR0mC6DdXGVRvkP1Yb
         6+O+t7K9Z7qe6pdWiT/p7+42yeOjZq8lTfhPGJg0RuGt03GCkkyaFT9rwGWu+YCJYXat
         KI3h4opOv541MlumO4VgQ4Kk4EZckG8TkNX9kH7MXnUfNOmRVFASZBU94DT0Gf77bXmV
         IBlGxQ9kgl760G5V/cK1AV/lWksH839Icwf1bUvI2MLL5GgDhxqKAS17RlF8A+JTBPjP
         ZL9g==
X-Gm-Message-State: AFqh2kpuPMuxJTjs0gkY7JWy/m3tmizVJRQ4aeSupkz8TuyDtZH0r9IX
        JvT1cCLaSMgaip6AsdBB3pXXrjKYShDr+F85vHanrUS4gqGo4w==
X-Google-Smtp-Source: AMrXdXt286Gi9fevINpB6FGCfsF2UPV+IdB1Ns9Pzhi4ZEqxN6DTSIvhZ9z1KSicg/rcTBORWExcDade1GnmooUdTn8=
X-Received: by 2002:ab0:7411:0:b0:418:b849:8187 with SMTP id
 r17-20020ab07411000000b00418b8498187mr1568480uap.43.1672032358009; Sun, 25
 Dec 2022 21:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20221216132404.1173254-1-wenst@chromium.org> <CAHCN7xJfR34WxigZSYcntWOsry4sc8ZJ9_T1comd0R5Z5Na7vA@mail.gmail.com>
In-Reply-To: <CAHCN7xJfR34WxigZSYcntWOsry4sc8ZJ9_T1comd0R5Z5Na7vA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Dec 2022 13:25:47 +0800
Message-ID: <CAGXv+5Hyth3WGw9rtKpgSAyNKxaH7Wkjpp5NpVDGru8Fj7dY+A@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Use core-generated bus_info value
To:     Adam Ford <aford173@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 3:39 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Dec 16, 2022 at 7:46 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > The Hantro driver uses a hardcoded value for the bus_info field in the
> > media device and |struct v4l2_capability|. This worked well when there
> > was just one device. However with the iMX.8 series we are now seeing
> > two Hantro blocks on the same chip. The static bus_info is no longer
> > sufficient for differentiating devices.
> >
> > Since commit f2d8b6917f3b ("media: v4l: ioctl: Set bus_info in
> > v4l_querycap()"), the V4L2 core provides a default value for the
> > bus_info field for platform and PCI devices. This value will match
> > the default value for media devices added by commit cef699749f37
> > ("media: mc: Set bus_info in media_device_init()"). These defaults
> > are stable and device-specific.
> >
> > Drop the static bus_info values from the hantro driver and use the
> > defaults.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile           | 1 +
> >  drivers/media/platform/verisilicon/hantro_drv.c  | 2 --
> >  drivers/media/platform/verisilicon/hantro_v4l2.c | 2 --
> >  3 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index ef6f364eaa18..ef815442c78b 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -55,6 +55,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-hummingboard-pulse.dtb
>
> I think the makefile was edited by mistake.

It was. I'll send a v2.

On this topic though, has anyone else tried the i.MX8 Mini variant of
the Hummingboard Pulse?

I forward-ported the DT from SolidRun's 5.4 kernel and got it running
and correct to a certain degree, but if the PMIC regulator driver is
enabled, the board cuts out as soon as it is probed.


ChenYu
