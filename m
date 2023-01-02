Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A065B3D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjABPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjABPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:07:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44B9585
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:07:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y19so10735430plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Py+mEqQrMGrkTWxmxdenUzEXoKA3++r71/dyBxZERsw=;
        b=XqAPGNKYWKsdaCjTLnL19DjUzyvHU1zDCW+L9YztruS26V5NLRL+50aGaQ0+n4MPfH
         qipaSASdXYBD80SNIVtmnM6eaTylCiYgyg1aO0KBSXzpYp3biaY32Ij0wynLb/ypdHyJ
         C74mNjYFAJFiBEfm2rINUile4beFOFRNp0EB7FD9ZU64HIKoYuTJQhYMG1B7c5To2MLv
         qENvQUSxOT2OZXLmPA6b6B4Xy6NptV0rLcYLIArt47DQJBTZP9rNvbMUHhQWyzW3LJrn
         /lcGBkXao5Xr8s0NSyz6XskOSD1PR+WNN0EU+oWzz+6xjX8yGgBv/s7Fp6imMzA/7GDJ
         l1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Py+mEqQrMGrkTWxmxdenUzEXoKA3++r71/dyBxZERsw=;
        b=tLm/avK9RBtSkp3DtcMjTrWEafSGuXivhgzR5o0WDeDEsn0AMS6arFBeRGzY3upcLy
         5BNsX5YDlOSXirLKEE/JbZRW1b4g76BWGqQaqBz5EwpygTa9PpoOVXXn+fDvSkfswR56
         4Qj8DSmd4V9kqwRkuZ5nmV5PSGhgeheNgkYeK7EFXl/TlrTBM8Wt5WvCtYXYkxbeDXh5
         XXYvNu5ATW49c67iMSFC/JJ5knA7/QtlYRigW1OeBCOu0u5Gk18ZxFVcTIeS7f6naddq
         G3pkUTGWdPQrs9obt2+kwUvKTs9jEX5PguXg6QGtD/fmCRpRSj5nx5f6pxuZEtq2A4sb
         xi+A==
X-Gm-Message-State: AFqh2kpcylUhUqcol61KTqr2Ivg22zfFsa+WD6pCh2z70kH0vrkuCG5j
        2dsa7GzeeVYDoQzQnO2Ck3inu0KIUJuBFgK7tARQag==
X-Google-Smtp-Source: AMrXdXsb/89JOjMTTfy2Q3dneSOnFo/ez0oRGNhv5+8eBCdxAb2lUwf/bIShv7DuOj+vHcfQTv5jcLFKZG+LBoqY5GM=
X-Received: by 2002:a17:902:b902:b0:190:e27b:b554 with SMTP id
 bf2-20020a170902b90200b00190e27bb554mr2443908plb.148.1672672062362; Mon, 02
 Jan 2023 07:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
 <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com> <CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com>
In-Reply-To: <CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:07:06 +0100
Message-ID: <CAPDyKFqRF=X755_H9418i1WZ4W-PxMwkzFnkcRco9mmycYHiPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hari.prasathge@microchip.com, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 at 01:23, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Balamanikandan,
>
> thanks for your patch!
>
> On Mon, Dec 26, 2022 at 8:39 AM Balamanikandan Gunasundar
> <balamanikandan.gunasundar@microchip.com> wrote:
>
> > Replace the legacy GPIO APIs with gpio descriptor consumer interface.
> >
> > To maintain backward compatibility, we rely on the "cd-inverted"
> > property to manage the invertion flag instead of GPIO property.
> >
> > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
>
> Overall this looks really nice! I thought about converting this driver
> but was a bit afraid of doing mistakes since it was a bit elaborate.
> Nice that you use fwnode accessors!
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Linus, thanks for helping out by reviewing this!

>
> Improvement to consider (can also be a separate patch):

I tried to apply the $subject patch as is, but it failed. It needs to
be rebased on top of my latest next branch. Please re-spin and if
possible, consider incorporating Linus's suggestions too as part of
the series.

Kind regards
Uffe



>
> > +       if (slot->detect_pin) {
> > +               present = !(gpiod_get_raw_value(slot->detect_pin) ^
> >                             slot->detect_is_active_high);
>
> Normally we contain all this active low/high mess in mmc_of_parse(),
> but I guess this doesn't work here because the of node is different
> from the device :P
>
> Since the code says *explicitly* "active high" not "inverted" as the
> core code parses it, could you try just push this to gpiolib like
> we usually do, by deleting the detect_is_active_high stuff and
> just apply a patch like this?
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4fff7258ee41..5979c9a75cf9 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -199,7 +199,9 @@ static void of_gpio_set_polarity_by_property(const
> struct device_node *np,
>                 { "fsl,imx8mm-pcie", "reset-gpio", "reset-gpio-active-high" },
>                 { "fsl,imx8mp-pcie", "reset-gpio", "reset-gpio-active-high" },
>  #endif
> -
> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> +               { "atmel,hsmci", "cd-gpios", "cd-inverted" },
> +#endif
>                 /*
>                  * The regulator GPIO handles are specified such that the
>                  * presence or absence of "enable-active-high" solely controls
>
> (It's fine to include in your MMC patch if some GPIO maintainer like
> me ACK it.)
>
> Yours,
> Linus Walleij
