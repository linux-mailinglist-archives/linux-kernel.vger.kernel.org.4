Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648FB667900
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjALPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjALPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:22:12 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B82D2DB;
        Thu, 12 Jan 2023 07:14:54 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id e76so18981793ybh.11;
        Thu, 12 Jan 2023 07:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y6qY7Xi7w4nejlKSxi1fYejKBcc6r8h/6CzmR1L1Uk=;
        b=cfetF7YgvWZzeA6YsIlEdpbTlNWGHzLPtMw//oNCDwfLtzh6FtXTIP6k66gocUMj2S
         5J0x4g0XM7m6GWwuIJqzK7nUOUnJbQkXkuSlb4SaKfB/BMJY66/5uCJ+45a1dtpo2+aQ
         GEV9bpbA8029gGqw1TouUnDLiKSx5/avqDQFPl15ln/MWva2mqVm7MXmSWLl1XkD7Bq8
         B0zS0aOSG1yo/e860McBKbVa9jP9Ez0CuRNdgmmeOBYIj7OPPJXwfOLSoF8Em7Fy6ImO
         bsxV8aN/zpLjDwH04YSfv1BPjPhw/H7VHWhQ7HhdLZifjJJmbgKrfYIietCl/iPny3Sd
         dQbA==
X-Gm-Message-State: AFqh2kpanpBn8YaF8hA6bKD9F+mWzterFr66FhWwWZS5BcYTDbV5nVeq
        +2va56hV3AQGMYHCJlLH5oLfa/HOqo9uzA==
X-Google-Smtp-Source: AMrXdXsWa0RSqrqbDnzDudymKVXjSLCYLCOdQSyE3q0oSko+1ZA/oq04ZzvN+XUHAix3cI40mmoKZg==
X-Received: by 2002:a25:ce82:0:b0:6fa:392c:78a2 with SMTP id x124-20020a25ce82000000b006fa392c78a2mr69026790ybe.5.1673536493315;
        Thu, 12 Jan 2023 07:14:53 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a269700b006fb11eee465sm11121485qkp.64.2023.01.12.07.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:14:52 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-4bf16baa865so242942587b3.13;
        Thu, 12 Jan 2023 07:14:51 -0800 (PST)
X-Received: by 2002:a81:1a16:0:b0:46f:bd6:957d with SMTP id
 a22-20020a811a16000000b0046f0bd6957dmr1837351ywa.383.1673536491636; Thu, 12
 Jan 2023 07:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Jan 2023 16:14:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSc-H5TKBGisthv3DH3sZmF3fV_15FuMEt=typwTWUtA@mail.gmail.com>
Message-ID: <CAMuHMdXSc-H5TKBGisthv3DH3sZmF3fV_15FuMEt=typwTWUtA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted irq_to_gpio()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC greg

On Thu, Jan 12, 2023 at 2:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> irq_to_gpio() is legacy and unused API, remove it for good.
>
> This leaves gpio_to_irq() as it's used yet in many places.
> Nevertheless, removal of its counterpart is a good signal
> to whoever even trying to consider using them that do not.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/driver-api/gpio/legacy.rst             |  8 --------
>  .../translations/zh_CN/driver-api/gpio/legacy.rst    |  7 -------
>  Documentation/translations/zh_TW/gpio.txt            |  7 -------
>  arch/m68k/include/asm/gpio.h                         |  7 -------
>  arch/sh/include/asm/gpio.h                           |  5 -----
>  include/linux/gpio.h                                 | 12 ------------
>  6 files changed, 46 deletions(-)

[...]

> --- a/arch/m68k/include/asm/gpio.h
> +++ b/arch/m68k/include/asm/gpio.h
> @@ -66,13 +66,6 @@ static inline int gpio_to_irq(unsigned gpio)
>                 return __gpio_to_irq(gpio);
>  }
>
> -static inline int irq_to_gpio(unsigned irq)
> -{
> -       return (irq >= MCFGPIO_IRQ_VECBASE &&
> -               irq < (MCFGPIO_IRQ_VECBASE + MCFGPIO_IRQ_MAX)) ?
> -               irq - MCFGPIO_IRQ_VECBASE : -ENXIO;
> -}
> -
>  static inline int gpio_cansleep(unsigned gpio)
>  {
>         return gpio < MCFGPIO_PIN_MAX ? 0 : __gpio_cansleep(gpio);

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
