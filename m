Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86EE60D6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYWWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJYWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:22:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4C26483;
        Tue, 25 Oct 2022 15:21:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud5so12946426ejc.4;
        Tue, 25 Oct 2022 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8y6RcNcqeipKdBc0KcpoWpoQGRSinTxo6WlCtAHVVFw=;
        b=lh0NRBFqQ37Pp2fRnoeAAM9cc7X8nP27UkZ1i/XKX98gMIpAuWUq5KWBlTtqlHiGeq
         x6ZUVZyTfxE60QHtbDFf1iaEJ1JKez+YvG7mQJOpKgOrDcKPZUhocxXh9mST2A1Sl9pS
         r0njkfhIIwycM7yO055a3feai4rOqXPvHneHE7E7dQQKKJ1EXFqRDXIC5mpU9vEwFK/a
         0efce3mBwTUymRzty/FhP9OhD8Jf5Q3vIhkjYFsNi805ptOa3ZGf/5+yqJTBinUPmsiP
         ZZeVmaWbMBtE5h9DRqCOxmlZWO9TEsB4eNGNeob4TWmijCb+PdiakLs0eQrr/FsCelZY
         19Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8y6RcNcqeipKdBc0KcpoWpoQGRSinTxo6WlCtAHVVFw=;
        b=k1aGY1d4tPbVyXpIK7YIip80WC2AjP/WDb3uuNcM2gn5Vgs3WZm4n818nKuUKVgh2O
         ERGDu5Mxke7Ug8WroYse0f52S4paLjeVUYjg6T4cN3trLnkGhUuohWLIU0W/WATdI+yt
         mzWjASFz7fNh5MEXbf1WEgPPcMKtNo4sMhO8XmPQzlz1tsDnenx/VZPPsra4yHad7bxn
         9ucQDZ0NJjD71BSkfOI6hnroiEYjDftIC6PUBaGJi4cWsTdPyB/UMx+Bubrpw68IuXa8
         2r32nucMp9DGGpRHges7eEdTZWC3DLCfwXIpAGKZ/WOhPeOx8TU58k206qUMlUbeszz6
         x4NQ==
X-Gm-Message-State: ACrzQf19sCNw4Yn1tmwpF94hDiuNk4Du12cREwIzQanmnkYB1lnTuXsy
        SkPTFvGTCMWQR3PSklKaB5Cm8AwKRgDVJsvd01A=
X-Google-Smtp-Source: AMsMyM6QITyQ7lHAa6lVQOgcVckdNVw20OEmjkUIHcwCzj/lp0O4BWOPYfKxzljxsA4kVmMiP28cLm/yW8CevROpj8k=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr29549937ejc.447.1666736518361; Tue, 25
 Oct 2022 15:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-14-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-14-arnd@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 25 Oct 2022 23:21:31 +0100
Message-ID: <CA+V-a8vH+rD2aJWc-5sVhnhe0-VYUCQ27KfQRS2BsimqJheWqw@mail.gmail.com>
Subject: Re: [PATCH 13/14] staging: media: remove davinci vpfe_capture driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev
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

On Wed, Oct 19, 2022 at 4:40 PM Arnd Bergmann <arnd@kernel.org> wrote:>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver was for the davinci dm644x and dm3xx platforms that are
> now removed from the kernel, so there are no more users.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                                   |    1 -
>  drivers/staging/media/Kconfig                 |    1 -
>  drivers/staging/media/Makefile                |    1 -
>  .../media/deprecated/vpfe_capture/Kconfig     |   58 -
>  .../media/deprecated/vpfe_capture/Makefile    |    4 -
>  .../media/deprecated/vpfe_capture/TODO        |    7 -
>  .../deprecated/vpfe_capture/ccdc_hw_device.h  |   80 -
>  .../deprecated/vpfe_capture/dm355_ccdc.c      |  934 --------
>  .../deprecated/vpfe_capture/dm355_ccdc.h      |  308 ---
>  .../deprecated/vpfe_capture/dm355_ccdc_regs.h |  297 ---
>  .../deprecated/vpfe_capture/dm644x_ccdc.c     |  879 --------
>  .../deprecated/vpfe_capture/dm644x_ccdc.h     |  171 --
>  .../vpfe_capture/dm644x_ccdc_regs.h           |  140 --
>  .../media/deprecated/vpfe_capture/isif.c      | 1127 ----------
>  .../media/deprecated/vpfe_capture/isif.h      |  518 -----
>  .../media/deprecated/vpfe_capture/isif_regs.h |  256 ---
>  .../deprecated/vpfe_capture/vpfe_capture.c    | 1902 -----------------
>  include/media/davinci/vpfe_capture.h          |  177 --
>  18 files changed, 6861 deletions(-)
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/Kconfig
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/Makefile
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/TODO
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/ccdc_hw_device.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.c
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc_regs.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.c
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc_regs.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif.c
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif_regs.h
>  delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/vpfe_capture.c
>  delete mode 100644 include/media/davinci/vpfe_capture.h
>
Acked-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar
