Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C526697DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjAMNA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbjAMM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:59:51 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71987299
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:46:10 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k6so13195866vsk.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/DggaXflopvrsYX8VaMpFlZAfFkoKnsbvDWgILzC+Y=;
        b=n+mJNeF44RT6HI8EvOWF23646PPBlKd9ZG1M/RkuNzlPvcrpBvoqiHffAmHH5lPh+n
         W2B9cMk/Wym6ZA0hVIdZeICdACOcRXhZ7/XOX0AqL174V0zzfLTtbUFnXE2b7Bag8TOZ
         klzmz22nm+CJfqxfiXiMDBsVzfi+N8K8pDDPCnD4eNrcbqPp1/rkkhLElFp/VU/hBD2A
         44B0Sn/JPEIfD/Hp+eOF0doIj91+J8X3JI1DnDhep6AH1tvU9VSJiCXCqmmORipb70pL
         ODtZUtpHkFfLh3JzfesTqyO7u8nLZNMI/NiLd7WcyNuWQ/il0kll7dXyAcik4sBtgi0y
         1hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/DggaXflopvrsYX8VaMpFlZAfFkoKnsbvDWgILzC+Y=;
        b=iD9IhH3mT0WTyaGmSL8GElX02Yr54MSz/G/XQTHlcO1rfxwxKSdGLmEG02dGyiSy/O
         4l4Pc0DdQfFqxahrXcGCXj/310xTARCVFJcj4mqzRe5VEbQALWhVqzAzJMZQdEnAf3xN
         g/eI3rdRO+HKgW+X98ta5hVmMPu63iMSKLgZCc6G7gDCJacRUD6ZZAroGCTRxYSz1WJs
         AV7Rl+HIeitiVQ1tJjvwwW/0dp0v7+Uob6FbjDHhmrLgPxWlOSULqoMlqAljfDhoGzn4
         NRhhmRUhpEaw8l1rWmuXTkv56fpGDyI8eItzi/6qPRbJ+StmqmSG2P4nsroBFskO26r3
         HicA==
X-Gm-Message-State: AFqh2krgrSZA5ifLvrjAqjcVDOmG/PvzPdsigTpjKKhAOWAEdWzdJvPM
        Ocp4juhXr4uteYNNPjWPvfWzrUr2/YlX901dpLA3+Q==
X-Google-Smtp-Source: AMrXdXuaCS7+r3qYpM6lN+VGImjeK/gFJQi4eAD++wKZb5UHZLrengMFHehlDtnJ9em9FCcm/VaBNROa38Q3brcMmVQ=
X-Received: by 2002:a67:df09:0:b0:3ce:88b3:d7da with SMTP id
 s9-20020a67df09000000b003ce88b3d7damr6916448vsk.62.1673613969423; Fri, 13 Jan
 2023 04:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Jan 2023 13:45:58 +0100
Message-ID: <CAMRc=Me2BjZBwfCWZ=JYS6JAP7+3SWSNPNPt1ZkpqaaX_iiAJg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused of_mm_gpiochip_add()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 4:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_mm_gpiochip_add() is unused API, remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/TODO       | 4 ++--
>  include/linux/of_gpio.h | 5 -----
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
> index 76560744587a..68ada1066941 100644
> --- a/drivers/gpio/TODO
> +++ b/drivers/gpio/TODO
> @@ -61,8 +61,8 @@ Work items:
>
>  - Get rid of struct of_mm_gpio_chip altogether: use the generic  MMIO
>    GPIO for all current users (see below). Delete struct of_mm_gpio_chip,
> -  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_add()
> -  of_mm_gpiochip_remove() from the kernel.
> +  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_remove()
> +  from the kernel.
>
>  - Change all consumer drivers that #include <linux/of_gpio.h> to
>    #include <linux/gpio/consumer.h> and stop doing custom parsing of the
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index e27a9187c0c6..935225caf70d 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -56,11 +56,6 @@ extern int of_get_named_gpio(const struct device_node *np,
>  extern int of_mm_gpiochip_add_data(struct device_node *np,
>                                    struct of_mm_gpio_chip *mm_gc,
>                                    void *data);
> -static inline int of_mm_gpiochip_add(struct device_node *np,
> -                                    struct of_mm_gpio_chip *mm_gc)
> -{
> -       return of_mm_gpiochip_add_data(np, mm_gc, NULL);
> -}
>  extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
>
>  #else /* CONFIG_OF_GPIO */
> --
> 2.39.0
>

Applied, thanks!

Bart
