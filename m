Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36116B260A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCIOAI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 09:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjCIN7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:59:41 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69264F184C;
        Thu,  9 Mar 2023 05:56:45 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id h19so1960436qtk.7;
        Thu, 09 Mar 2023 05:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLNeuP6UyITHef9gvZx7n863rnHNAiqi/ViL295oG8w=;
        b=Q5/UZ4WcFYbF/dk8hUaRDS9r2b8+mJnWR+T/CSxGXvwYk90bD0nz/5yKv7H/h3aanw
         80Bw8xORUnFWkYz2USHreLwgpTmvu+4IGufl/Vd1R4gf0lKThhbIFL+8jPWM4XluoC6R
         hc2Vf08E+hA0ef/k0KFdpPbF2dopEqonQXkEH/3JLXhbOcootrHbz1njg/dZKYZIHqKq
         CT8H5PclAyM+HHA9tZ5B76U0SNJU9IsVzhOJv7M53DTRvJCp1q54cQJXGpk4Xi2wTrlZ
         7skt5oVBAXTibbgVJUF7RnQr7iwxj6jEFlSDYCmCRxsvy6pNZ8vW6lmlTOCB38u6GgSl
         e9/A==
X-Gm-Message-State: AO0yUKX8Kv32sOmOVMjP9j5T4ci+66+PLO3O9ib2fQtiEB6z8dfuO4h0
        nG5TsJygnTWqm0T9vl5R3JakZcgJmU/LVQ==
X-Google-Smtp-Source: AK7set/H9deSQh6GsXSGe/eAZZjUB9Z6xSso/wONZ1fhsOLEPB+Go2F+Ws7JATNsl0XfNF2BuJIwmw==
X-Received: by 2002:a05:622a:1042:b0:3b8:6b74:8ac3 with SMTP id f2-20020a05622a104200b003b86b748ac3mr1612830qte.28.1678370204189;
        Thu, 09 Mar 2023 05:56:44 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id j11-20020a05622a038b00b003bd0f0b26b0sm14119377qtx.77.2023.03.09.05.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 05:56:43 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id v101so1981069ybi.2;
        Thu, 09 Mar 2023 05:56:43 -0800 (PST)
X-Received: by 2002:a5b:b91:0:b0:a6f:b653:9f21 with SMTP id
 l17-20020a5b0b91000000b00a6fb6539f21mr13549994ybq.12.1678370203203; Thu, 09
 Mar 2023 05:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20230309135255.3861308-1-geert+renesas@glider.be> <a1f72b2bb25f8a06a10a436138e1032cc12b6506.camel@physik.fu-berlin.de>
In-Reply-To: <a1f72b2bb25f8a06a10a436138e1032cc12b6506.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Mar 2023 14:56:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUbZ69hcUBUBHpH1P1ZJ59ejTF=9vOdUMO-cgOHtBgGCA@mail.gmail.com>
Message-ID: <CAMuHMdUbZ69hcUBUBHpH1P1ZJ59ejTF=9vOdUMO-cgOHtBgGCA@mail.gmail.com>
Subject: Re: [PATCH] sh: mach-x3proto: Add missing #include <linux/gpio/driver.h>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-gpio@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> On Thu, 2023-03-09 at 14:52 +0100, Geert Uytterhoeven wrote:
> > shx3_defconfig:
> >
> >     arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
> >     arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
> >       246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
> >         |                                                              ^
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Link: https://lore.kernel.org/r/CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com
> > Fixes: 21d9526d13b5467b ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/arch/sh/boards/mach-x3proto/setup.c
> > +++ b/arch/sh/boards/mach-x3proto/setup.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/usb/r8a66597.h>
> >  #include <linux/usb/m66592.h>
> >  #include <linux/gpio.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/gpio_keys.h>
> >  #include <mach/ilsel.h>
> >  #include <mach/hardware.h>
>
> Thanks. You were much faster than me. I didn't even have the time to have a look
> at the problem yet ;-). Is it sufficient to pick this up for 6.4?

As the problem is introduced in and only found in gpio/for-next,
I expect Linus or Andy to pick it up.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
