Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF466444E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiLFNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiLFNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:48:54 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3B62BB02
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:48:41 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i186so6466495ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmup+yZE24MciFW4DY8WzQr4D9UdPQvkxaXBWwbCYGE=;
        b=xe3w3Tx0jataJsf2+EB4Q0j3OYn9qQHKxRUt6vgl2x/bpUU5hKmzKUbra8fDpwCSz3
         Jw2n+bTh0lJOjqpmmydmGj2mH/Dme+W5GL9XfKOBgiEKyfosxU0ESPt7rAMCxGl2b3wA
         KwieWxvYIcNJQYyq2cD5t+soasSIXY5v7Ys5GjjTt6JsJBH5nSfiTptO/q/yDxCpwZqV
         kyt1ekwbPGDGPnYxGBPV0hb2g6PFpC4hQEGKRmqeKZ49z1FoEaScecfP8r+/BKkJo0Qb
         ojzY/Kpp8CcXLupFQFQ2uB77/Zse2n4QRZdGawIHgDDAakSjalANBxypUkAhzrlCmLk5
         9qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmup+yZE24MciFW4DY8WzQr4D9UdPQvkxaXBWwbCYGE=;
        b=UJmEoejoaF40UJHPCREgJ+paiU5Im9zwYN3oSx17k5cDdvZt9f/i9dCQqGpwyPneDN
         4M+gtyQ+btwBCXp820C07/LXrSvNsm46IR7MSAH6W6WUd+3nGRCUEHh1iZMjANOddNrk
         m3PC27v4X9d+UrbFzezzCCASkJVBWoVbQlngrJcb7zwryE5FECOOpNuS4GgTewwbjLHr
         dHY8Kq4aAo4WHiBMkur2ZyBV+8DZrQ/adFUSeuUt6FXUrae8oPJNHaT0pbTsJBmMIiER
         bFqPNoS9pX1pyWhZqrfet7iCHpqxAnBASkAPkb7TEZDoEYNqokq8G3yBPdItzl6JaGg6
         1wng==
X-Gm-Message-State: ANoB5plyr+QqoBa/SDvl4zf0iyaYgi0C1rV670knZQf4mjZehL7+v750
        OdHLAoduf/qUKD4OpJ0NQnqYk9ug8qYu1h116LuObw==
X-Google-Smtp-Source: AA0mqf5tl3eg8mA3q4GuLrw5pMrRj9hK8s8duIDp/yaZGXXS5z2P056c9hRjGtvEEBktcn6Lc1Fn5hE3Z7WDlN/xa8A=
X-Received: by 2002:a25:3dc3:0:b0:6f0:d54a:8f2d with SMTP id
 k186-20020a253dc3000000b006f0d54a8f2dmr54940542yba.66.1670334520828; Tue, 06
 Dec 2022 05:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20221206124530.5431-1-edmund.berenson@emlix.com>
In-Reply-To: <20221206124530.5431-1-edmund.berenson@emlix.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Dec 2022 14:48:29 +0100
Message-ID: <CACRpkdYnbQfbAhFCeNh6dD_4zfPPxcEREX9QOMEqKu5tVDVK1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: max7317: Add gpio expander driver
To:     Edmund Berenson <edmund.berenson@emlix.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

Hi Edmund & Lukasz,

thanks for your patch!

On Tue, Dec 6, 2022 at 1:45 PM Edmund Berenson
<edmund.berenson@emlix.com> wrote:
>
> Add driver for maxim MAX7317 SPI-Interfaced 10 Port
> GPIO Expander.
>
> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>

(...)

> +config GPIO_MAX7317
> +       tristate "Maxim MAX7317 GPIO expander"
> +       depends on SPI

Skip this. Just put it inside the section:

menu "SPI GPIO expanders"
        depends on SPI_MASTER

But consider this:

select REGMAP_SPI

> +/* A write to the MAX7317 means one message with one transfer */
> +static int max7317_spi_write(struct device *dev, unsigned int reg,
> +                               unsigned int val)
> +{
> +       struct spi_device *spi = to_spi_device(dev);
> +       u16 word = ((reg & 0x7F) << 8) | (val & 0xFF);
> +
> +       return spi_write_then_read(spi, &word, sizeof(word), NULL, 0);
> +}
> +
> +/* A read from the MAX7317 means two transfers, with chip select going high between them. */
> +static int max7317_spi_read(struct device *dev, unsigned int reg)
> +{
> +       int ret;
> +       u16 word;
> +       struct spi_device *spi = to_spi_device(dev);
> +
> +       word = 0x8000 | (reg << 8);
> +
> +       /* First transfer: ask to read register */
> +       ret = spi_write(spi, &word, sizeof(word));
> +       if (ret)
> +               return ret;
> +
> +       /* Second transfer: read register value */
> +       ret = spi_read(spi, &word, sizeof(word));
> +       if (ret)
> +               return ret;
> +
> +       return word & 0xff;
> +}

I bet this is standard SPI addressing of some kind, if in doubt Mark Brown
will know. Look into REGMAP_SPI and use regmap accessors in the driver.
Look at: drivers/gpio/gpio-xra1403.c for an example.

> +static int max7317_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct max7317 *ts = gpiochip_get_data(chip);
> +       unsigned int reg, val, mask, shift;

Switch to unsigned long when using regmap.

> +       int inputs;
> +
> +       if (offset < 8) {
> +               reg = REG_CODE_READ_PORTS_7_TO_0;
> +               mask = 1u << offset;

mask = BIT(offset);

> +               shift = offset;
> +       } else {
> +               reg = REG_CODE_READ_PORTS_9_TO_8;
> +               mask = 1u << (offset - 8);

mask = BIT(offset - 8);

> +               shift = offset - 8;
> +       }
> +
> +       mutex_lock(&ts->lock);
> +       inputs = max7317_spi_read(ts->dev, reg);
> +       mutex_unlock(&ts->lock);

Regmap also contains a mutex already so you will just need a oneliner
for things like this.

> +       val = ((unsigned int)inputs & mask) >> shift;
> +       return (int)val;

Ugh get rid of this shifting and casting.

I tend to do:

return !!(inputs & mask);

That will clamp whatever value to a bool.

Once you have converted the driver to use REGMAP_SPI, take a
look at GPIO_REGMAP in drivers/gpio/gpio-regmap.c and see if
you can also use that helper to slim this down even more. (Uncertain
about that, but check it!)

Yours,
Linus Walleij
