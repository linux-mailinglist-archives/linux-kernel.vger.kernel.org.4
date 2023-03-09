Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB36B2704
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCIOg0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjCIOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:36:13 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E42E7EFC;
        Thu,  9 Mar 2023 06:35:49 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id jo29so1554594qvb.0;
        Thu, 09 Mar 2023 06:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri9sSxFPujb6hfgdxYFHOdQXavWyvWPB4UY0+uT79Nw=;
        b=eTnguzaluUJXlztCk2iX3NWCpxDgqQ2alLA8p7d2qZUJq2Bnr3O4xwH4dTnJtYAtol
         yGnaAKQHQl+P0fOr9ZrI4IPwe5EqVGwGceMZCN1WKajed9/9jVkWx1MRY7+Hn6ONOM1b
         ZlkK4bIGKtquTXKr7bY7arhJeEPH4NnWtvrS6u5eipgFfZXNueNRev/uT+L2EIky/hNU
         ph1MTqXzTyyC3CfKOUkhCSJ9MNLBfme89grtJOa857bFZiLjZCKszbZwfKdQ10o/4eX2
         Rd0TnxMgRSsX0YeTPuJtCo+b6K+aKcM5HTJbLBQQk/KFCk13sSw3ftaSELLoTkch5E3o
         /psg==
X-Gm-Message-State: AO0yUKW5yo4dufnVktQw/3whRKxyvnTS408N4/nSV9syKCRH7e7N5Qqp
        NAs9K+bmIQhTOs84O+oRrgOWwHAOM19yLA==
X-Google-Smtp-Source: AK7set8+SAgzvyJlMh11ayPR9bJfGF9zVYlqWAx9nGmFRdDfApJr4J0bSoNWrJvNXerJ8Pn5gctiyw==
X-Received: by 2002:a05:6214:238e:b0:56e:bb43:a07c with SMTP id fw14-20020a056214238e00b0056ebb43a07cmr2340663qvb.20.1678372548438;
        Thu, 09 Mar 2023 06:35:48 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id r125-20020a374483000000b006fcb77f3bd6sm13658332qka.98.2023.03.09.06.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 06:35:48 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-536bf92b55cso38174207b3.12;
        Thu, 09 Mar 2023 06:35:47 -0800 (PST)
X-Received: by 2002:a81:ae1d:0:b0:524:5bc5:a3d5 with SMTP id
 m29-20020a81ae1d000000b005245bc5a3d5mr13737816ywh.4.1678372547668; Thu, 09
 Mar 2023 06:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20230309135255.3861308-1-geert+renesas@glider.be> <ZAnna6xIhBZPG/nD@smile.fi.intel.com>
In-Reply-To: <ZAnna6xIhBZPG/nD@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Mar 2023 15:35:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUn0rbhiDLyTKuBvYTw3c9JGOs2ZZq=7aaOFnQ4_6PZAg@mail.gmail.com>
Message-ID: <CAMuHMdUn0rbhiDLyTKuBvYTw3c9JGOs2ZZq=7aaOFnQ4_6PZAg@mail.gmail.com>
Subject: Re: [PATCH] sh: mach-x3proto: Add missing #include <linux/gpio/driver.h>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Hi Andy,

On Thu, Mar 9, 2023 at 3:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Mar 09, 2023 at 02:52:55PM +0100, Geert Uytterhoeven wrote:
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
>
> Thank you!
>
> ...
>
> >  #include <linux/gpio.h>
> > +#include <linux/gpio/driver.h>
>
> Do we still need the legacy header?

Apparently not.  And "make arch/sh/boards/mach-x3proto/setup.i"
confirms it's not included indirectly.

Will send a v2...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
