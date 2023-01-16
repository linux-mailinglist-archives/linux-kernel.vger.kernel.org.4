Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663466B9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjAPJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjAPJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:04:42 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F164A1449A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:00:57 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i188so28353376vsi.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S0ueNcf2NBJBYhPqy5V0hnT6DT1EdchN5SecUp3AsN8=;
        b=1GzO/BdmGYVbuKJmelPPs+TdGrO6cdfoJXeFDMMdqo7+c9sYoFsUky92k69WsqHR23
         Xbu45GKB2BAMyPnDiH55UmLbeaMoH8jvW6ZxHb4MJEwDvSmGgl7YswSxDA+FkyvNhWU2
         dpaYZESL//iBf9/exDo+/3E9ePxgsSg8P+ErmR1QjWRnDXLl1fKLsBYVQveW4LHPNk6E
         FMfUXzy7Wg/b+KM6CiKua5vEc3SDceNykXD4ieEx2Ptqy0/cGt4Pdjf9ejFYvX/+HvmS
         9RndiH8jNcmRgjBA1y51cXGbYbJXLvJA1not+3iBqkg5ubF8mQ3jGTgMC0GAhp/GjH+l
         j/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0ueNcf2NBJBYhPqy5V0hnT6DT1EdchN5SecUp3AsN8=;
        b=AMHtK4p5Lvj/F+VWxj5loYqXfvGKNCOwuFzTkgfvnSazZdi1WK4vDeBusJKORuIUFE
         G7BZlBZjFS8C2QlC0BA+/4YE0XuTUWzVytNrrWdL9ZMlpV8emK63tVn3lM03BPAlloWb
         mu8M93f/0A2gspy5ecuMjaRvxZq2y2Xk2Fem1fJ/vxnngRACwQyLAB3I4m0TccU6rrmt
         7kFdgzLdk9S29Hs05FWdWCajmMwj9lKo6heFYJvX65mnCMimR84ysGsMlgiVdSZowGA8
         ONfDJNanBdubPYwcU1j698CFgEnxKh03rKNnW1NgeMk1V+RGL4I8d4geb9ivb+4sXy5R
         IBrA==
X-Gm-Message-State: AFqh2koJtk6aK0HbeI/fIcG3zaEk/xzAhH9Zklmk1f5LfSeukYDvv65F
        oCUrZ9OOtYC3KBBGhuM7C4W7rF2EtovhhtEPV6oCvIGUUwfQ734R
X-Google-Smtp-Source: AMrXdXvhy1FeVWHBVvw4fEyYr/T+PDw8YubE4c1pnN86davLdLEr/gcemBVgZ1PNs2BthQo2Gqs+/S/dKPIrkMhhODo=
X-Received: by 2002:a05:6102:1141:b0:3d2:3577:2d05 with SMTP id
 j1-20020a056102114100b003d235772d05mr818208vsg.9.1673859656695; Mon, 16 Jan
 2023 01:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20230112163941.73143-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112163941.73143-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 10:00:45 +0100
Message-ID: <CAMRc=Mc-k9bkeowhv74g=m=3qj2OzpmXM4c0cgsaMG_peceNhA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpio: zevio: Remove duplicate assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Moses Christopher Bollavarapu <mosescb.dev@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 5:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-zevio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
> index ce9d1282165c..c9f4c26cae3d 100644
> --- a/drivers/gpio/gpio-zevio.c
> +++ b/drivers/gpio/gpio-zevio.c
> @@ -162,7 +162,6 @@ static const struct gpio_chip zevio_gpio_chip = {
>         .base                   = 0,
>         .owner                  = THIS_MODULE,
>         .ngpio                  = 32,
> -       .of_gpio_n_cells        = 2,
>  };
>
>  /* Initialization */
> --
> 2.39.0
>

Applied, thanks!

Bart
