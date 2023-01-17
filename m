Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31C670B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjAQWJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAQWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:08:10 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C5B448;
        Tue, 17 Jan 2023 12:30:57 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id q15so4355142qtn.0;
        Tue, 17 Jan 2023 12:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZfuHp/Lb3thRInaaLDpig3glVMpImoS79RTofhvspM=;
        b=zS/0IXMQhrWGp4Hwy8Fr/lYDMKRffnkvdgaUBYzc8n5aRSy4Uyy6Ox6dsbobE1dYnU
         JLyl2tWyYNHRL+GQzTbeqFH2S68r89Xrf+vfER/G+mYu1sMNu4SiWg3xeYXBRHhjsEIT
         WFbs5DCF8vrEuZey1B7XDDwMIlFD4S7yGRAF0JTDi/j5IC+RRIFOJIRONW9buBHh9VZ+
         gpXimnpHzdnW1O7QJjp27Qcv0sZEYCR2VY94NM3Ct27gwhiUgk14+846hwDv/CycT/AL
         zrJ1RKOGQZgc9WaGCLd902V5Lniyed4va4R7SSvd0YMIouWQqXJ+wk24kkfu/W14iisO
         oMiw==
X-Gm-Message-State: AFqh2krvfpSNLO9qh80w6eycN9K+dy9WW+zAe4H4r88ppdY4nOKMFwgg
        XDphPXphotcK3d8iZwrFZCbx8GnIZx9xdw==
X-Google-Smtp-Source: AMrXdXudbXI+KxsWVquYsuYpnexniQjgsLrcQRP5I81E1/UtjpB0RYi1NQUAWW1lXSupBy2Omn6l8w==
X-Received: by 2002:ac8:4d8d:0:b0:3af:f7f5:2b38 with SMTP id a13-20020ac84d8d000000b003aff7f52b38mr5064876qtw.59.1673987456474;
        Tue, 17 Jan 2023 12:30:56 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id e26-20020ac845da000000b003a527d29a41sm3353344qto.75.2023.01.17.12.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:30:55 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-4a263c4ddbaso440053397b3.0;
        Tue, 17 Jan 2023 12:30:55 -0800 (PST)
X-Received: by 2002:a81:bd6:0:b0:48d:1334:6e38 with SMTP id
 205-20020a810bd6000000b0048d13346e38mr535340ywl.316.1673987455061; Tue, 17
 Jan 2023 12:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20230117165851.2300111-1-arnd@kernel.org>
In-Reply-To: <20230117165851.2300111-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jan 2023 21:30:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4b4huZR=CMpgW3NzDS2x3O6DJ3mvSqfa68Q3QGmsrfA@mail.gmail.com>
Message-ID: <CAMuHMdU4b4huZR=CMpgW3NzDS2x3O6DJ3mvSqfa68Q3QGmsrfA@mail.gmail.com>
Subject: Re: [PATCH] staging: media: stkwebcam: add USB dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:58 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Before the move, this driver had implicit dependencies on both
> CONFIG_USB and MEDIA_SUPPORT, which can be =m even in combination
> with CONFIG_MEDIA_USB_SUPPORT=y, so without the dependency we
> get a link failure when USB is a loadable module but stkwebcam
> is built-in:
>
> arm-linux-gnueabi-ld: drivers/staging/media/deprecated/stkwebcam/stk-webcam.o: in function `stk_camera_probe':
> stk-webcam.c:(.text+0xcbc): undefined reference to `usb_get_dev'
> arm-linux-gnueabi-ld: stk-webcam.c:(.text+0xccc): undefined reference to `usb_get_intf'
> arm-linux-gnueabi-ld: stk-webcam.c:(.text+0xd68): undefined reference to `usb_put_intf'
> arm-linux-gnueabi-ld: stk-webcam.c:(.text+0xd70): undefined reference to `usb_put_dev'
> arm-linux-gnueabi-ld: drivers/staging/media/deprecated/stkwebcam/stk-webcam.o: in function `stk_prepare_iso':
> stk-webcam.c:(.text+0xfcc): undefined reference to `usb_free_urb'
> arm-linux-gnueabi-ld: stk-webcam.c:(.text+0x1010): undefined reference to `usb_alloc_urb'
> arm-linux-gnueabi-ld: stk-webcam.c:(.text+0x10d8): undefined reference to `usb_kill_urb'
>
> Add back the original dependency.
>
> Fixes: 1943fb1e50d1 ("media: staging/media: add a STAGING_MEDIA_DEPRECATED option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah, those pesky tristate->bool->tristate dependency chains...

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/staging/media/deprecated/stkwebcam/Kconfig
> +++ b/drivers/staging/media/deprecated/stkwebcam/Kconfig
> @@ -3,6 +3,7 @@ config VIDEO_STKWEBCAM
>         tristate "USB Syntek DC1125 Camera support (DEPRECATED)"
>         depends on VIDEO_DEV
>         depends on MEDIA_USB_SUPPORT && MEDIA_CAMERA_SUPPORT
> +       depends on USB && MEDIA_SUPPORT
>         help
>           Say Y here if you want to use this type of camera.
>           Supported devices are typically found in some Asus laptops,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
