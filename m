Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5A66BA74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjAPJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjAPJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:34:11 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A521715F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:34:10 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id k4so28426954vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZOuVys9mIzGnHTVfzNN5gjowcf0f3FatVf154JV6kI=;
        b=CAgnq0I7BlFfkCghCCqc3RKNz/Q7K2CoNwOb30lf57/hbdxKULjkM/TM+wdhkP6w9R
         1giTcgyCxnZsErQxTyJ1UzD3mKoA0jlupISi36EvixNBTjRDQlrml7FYcrMyLzjZn9UL
         oYmZLmTCrV3kKVdadxU6/cJaq93U+EDgR3I9OQwGgc+OmnprWH+PiQMDM0Q4ZKIv/XK5
         WTY8PirgFG9M+Dsj3mnxHtwVD5o3ElndxTNWnIZrJtFvkE+A+GhehBIKX4g1W38SOWTg
         AhFHCUzpL9QR4g8h1A7XjWmwA5Yk2vH9TVcKwy71QvLvBdWHu0XrwsNWMIh8NhRFG3nV
         pdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZOuVys9mIzGnHTVfzNN5gjowcf0f3FatVf154JV6kI=;
        b=exSuhiWfdsSeDzBvGfocNOwq1Wg3vTOEbRnSRHliRe5ZMZKZEJ4Gnx2UXlj+vvuCjX
         gTH52RvZhAdIWoyls+wfKQbUVjmNgg/fq8b3Mo12ogsK5ZV0BtHIzmxzgTmCOFZBYXAJ
         XDV7ihWin6myj9UvlhJrZmBSFWS6YuR0OI9wBmHyv07SeeL3MyeDqGemc8YixQgl/L8v
         zfc/3VJ1HVkviiMFwwL8xv+oPDDQJ1C1oEpW0hz3OmmHIvd2DIw3/elwgayz7AfbKw6f
         5mmbeXtE1O0x1OaUqgq5kXDSCZ50OxkT6hmdSKqZNQ9c6Cq+VdknEuxFuGO75l82AiTp
         EQdg==
X-Gm-Message-State: AFqh2ko1HbbD3AT0+owZVTqjrLy/ErUM2/IABU38TSR024M76fHa1a+v
        0dRujObGJEXG0IFeKlM6ZRn6CKXNrM9AXXKR+oohsg==
X-Google-Smtp-Source: AMrXdXupP3qQ3MR8Xhcjf19nZo0r5SdZGW1Fyn0PeSZXrUauTJQF3PKLBZ56aau/2xm/B0FrvP5coVOd488pke6eeic=
X-Received: by 2002:a67:f899:0:b0:3d3:d90c:5ef2 with SMTP id
 h25-20020a67f899000000b003d3d90c5ef2mr414465vso.17.1673861649780; Mon, 16 Jan
 2023 01:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112134653.59268-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112134653.59268-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 10:33:59 +0100
Message-ID: <CAMRc=MeFmZWnCKxT7QJv2dmSO-OKLCp60NwP-11MhvKRw1whgQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: rockchip: Do not mention legacy API in the code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 2:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace mentioning of legacy API by the latest one.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 200e43a6f4b4..e5de15a2ab9a 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -299,7 +299,7 @@ static int rockchip_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
>  }
>
>  /*
> - * gpiolib gpio_to_irq callback function. Creates a mapping between a GPIO pin
> + * gpiod_to_irq() callback function. Creates a mapping between a GPIO pin
>   * and a virtual IRQ, if not already present.
>   */
>  static int rockchip_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
> --
> 2.39.0
>

Applied, thanks!

Bart
