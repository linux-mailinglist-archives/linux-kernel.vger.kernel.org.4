Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005C47031B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbjEOPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbjEOPhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:37:04 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915721FC8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:36:58 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-435fff402d0so6536207137.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684165017; x=1686757017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDwExbJjZiuUEmbISOKD+F+fLk3AocW2ljrFDFs8fro=;
        b=nJWSKeJLxXCV+eTC7FJsJvh+GrgqH9XyCo9+rXPiAz69yUvW54TIkZWNqE7IuEmXM6
         Fb8L915shprDP03v9haDVr03x9nE4KTYy4w00/FERy3lWtS0VTL0fQteupmS/xPsvqNc
         PHHUegHiHfsEliUrRBzK3qnA3I3StYmdVALJcWl5yamer8bYWTHgMVhXnbLMI9xAemHf
         u2XU1y2fof9XkkEW+ukRLBAg+esyE86DNYOhw4GNZrRLAxYLPlZ0H7UQuXh2ZTAngt2x
         m02B16sCxh+OZFZYptssm+0QDKzSWfIj6KtOSWeNx/3R7OYEfrqnNzvRqUAvitxeW1xc
         G+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684165017; x=1686757017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDwExbJjZiuUEmbISOKD+F+fLk3AocW2ljrFDFs8fro=;
        b=MWquRXwVEHk2exbqZroKOMlYvAlcoOksooL+jVnefu/oHsPm9qQ5htJexYl5zUoHQ8
         EIh/qvVSVce8LDsc6MV1EOgzoVJHGd2rGUHSZUZAzER3waqIaEXO627LMBaNLdH8azw7
         giB6bv4Mj0cbzEd9gWzkHOS8Jg8PQ/Bphep4b2DcUuoZNKmVMeVTmxPgseYPdHBD9ZcK
         mr5n19Ob4JevseFTq6/TnQmFyxmsQuKoazQHtQdZzpsrRYP2rdKmxD5M/7nZk1zQpXU8
         T6H5dMszqg7LwLmRIyei9VZ/ga2ZRIt4HBkOgLul2iw1sre/ou4sjioZErcj0ubECFPG
         lKeQ==
X-Gm-Message-State: AC+VfDxlgf5ZXN5ekvElgqNlSasaPaQOMPkR+mFrZgLcldNSWkt57EG+
        P9ggFV6sJJBxdzPUDj+KceyareUuEa2eQcOLk8tGKg==
X-Google-Smtp-Source: ACHHUZ5yNKfzYLGZFR2x8B3eZtCJiXZx0tIH74uI1njx8D+WU80tfHstv0o5D0NqwVZM7mSZWXnBILqiOKKoqWEqVvI=
X-Received: by 2002:a05:6102:3cd:b0:42e:63a5:b711 with SMTP id
 n13-20020a05610203cd00b0042e63a5b711mr14345264vsq.10.1684165017337; Mon, 15
 May 2023 08:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 May 2023 17:36:46 +0200
Message-ID: <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 4:09=E2=80=AFPM Jerome Neanne <jneanne@baylibre.com=
> wrote:
>
> Add support for TPS65219 PMICs GPIO interface.
>
> 3 GPIO pins:
> - GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
> - GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec
>
> GPIO0 is statically configured as input or output prior to Linux boot.
> it is used for MULTI_DEVICE_ENABLE function.
> This setting is statically configured by NVM.
> GPIO0 can't be used as a generic GPIO (specification Table 8-34).
> It's either a GPO when MULTI_DEVICE_EN=3D0,
> or a GPI when MULTI_DEVICE_EN=3D1.
>
> Datasheet describes specific usage for non standard GPIO.
> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
>
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/gpio/Kconfig         |  17 +++++
>  drivers/gpio/Makefile        |   1 +
>  drivers/gpio/gpio-tps65219.c | 173 +++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 192 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0cde28c62c6..d912b7465e84 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15398,6 +15398,7 @@ T:      git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/tmlind/linux-omap.git
>  F:     arch/arm/configs/omap2plus_defconfig
>  F:     arch/arm/mach-omap2/
>  F:     drivers/bus/ti-sysc.c
> +F:     drivers/gpio/gpio-tps65219.c
>  F:     drivers/i2c/busses/i2c-omap.c
>  F:     drivers/irqchip/irq-omap-intc.c
>  F:     drivers/mfd/*omap*.c
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5521f060d58e..f4e37881d01a 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1440,6 +1440,23 @@ config GPIO_TPS65218
>           Select this option to enable GPIO driver for the TPS65218
>           chip family.
>
> +config GPIO_TPS65219
> +       tristate "TPS65219 GPIO"
> +       depends on MFD_TPS65219
> +       default MFD_TPS65219
> +       help
> +         Select this option to enable GPIO driver for the TPS65219
> +         chip family.
> +         GPIO0 is statically configured as input or output prior to Linu=
x boot.
> +         it is used for MULTI_DEVICE_ENABLE function.
> +         This setting is statically configured by NVM.
> +         GPIO0 can't be used as a generic GPIO.
> +         It's either a GPO when MULTI_DEVICE_EN=3D0,
> +         or a GPI when MULTI_DEVICE_EN=3D1.
> +
> +         This driver can also be built as a module. If so, the
> +         module will be called gpio_tps65219.
> +
>  config GPIO_TPS6586X
>         bool "TPS6586X GPIO"
>         depends on MFD_TPS6586X
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 20036af3acb1..7843b16f5d59 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -160,6 +160,7 @@ obj-$(CONFIG_GPIO_TN48M_CPLD)               +=3D gpio=
-tn48m.o
>  obj-$(CONFIG_GPIO_TPIC2810)            +=3D gpio-tpic2810.o
>  obj-$(CONFIG_GPIO_TPS65086)            +=3D gpio-tps65086.o
>  obj-$(CONFIG_GPIO_TPS65218)            +=3D gpio-tps65218.o
> +obj-$(CONFIG_GPIO_TPS65219)            +=3D gpio-tps65219.o
>  obj-$(CONFIG_GPIO_TPS6586X)            +=3D gpio-tps6586x.o
>  obj-$(CONFIG_GPIO_TPS65910)            +=3D gpio-tps65910.o
>  obj-$(CONFIG_GPIO_TPS65912)            +=3D gpio-tps65912.o
> diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
> new file mode 100644
> index 000000000000..42bbd142e4b6
> --- /dev/null
> +++ b/drivers/gpio/gpio-tps65219.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPIO driver for TI TPS65219 PMICs
> + *
> + * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com=
/
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/tps65219.h>
> +

Please keep all includes together and ordered alphabetically. I see
you probably wanted to split them thematically but we don't really do
this.

> +#define TPS65219_GPIO0_DIR_MASK                BIT(3)
> +#define TPS65219_GPIO0_OFFSET          2
> +#define TPS65219_GPIO0_IDX             0
> +#define TPS65219_GPIO_DIR_IN           1
> +#define TPS65219_GPIO_DIR_OUT          0
> +
> +struct tps65219_gpio {
> +       struct gpio_chip gpio_chip;
> +       struct tps65219 *tps;
> +};
> +
> +static int tps65219_gpio_get_direction(struct gpio_chip *gc, unsigned in=
t offset)
> +{
> +       struct tps65219_gpio *gpio =3D gpiochip_get_data(gc);
> +       int ret, val;
> +
> +       if (offset !=3D TPS65219_GPIO0_IDX)
> +               return GPIO_LINE_DIRECTION_OUT;
> +
> +       ret =3D regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,=
 &val);
> +       if (ret)
> +               return ret;
> +
> +       return !!(val & TPS65219_GPIO0_DIR_MASK);
> +}
> +
> +static int tps65219_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct tps65219_gpio *gpio =3D gpiochip_get_data(gc);
> +       int ret, val;
> +
> +       if (offset !=3D TPS65219_GPIO0_IDX) {
> +               dev_err(gpio->tps->dev,
> +                       "GPIO%d is output only, cannot get\n",
> +                       offset);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       ret =3D regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_CTRL, &va=
l);
> +       if (ret)
> +               return ret;

Add newline here.

> +       dev_warn(gpio->tps->dev,
> +                "GPIO%d =3D %d, used for MULTI_DEVICE_ENABLE, not as sta=
ndard GPIO\n",
> +                offset, !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK)));
> +
> +       /* depends on NVM config return error if dir output else the GPIO=
0 status bit */
> +       if (tps65219_gpio_get_direction(gc, offset) =3D=3D TPS65219_GPIO_=
DIR_OUT)
> +               return -EOPNOTSUPP;

Add newline here.

> +       return !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
> +}
> +
> +static void tps65219_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +                             int value)
> +{
> +       struct tps65219_gpio *gpio =3D gpiochip_get_data(gc);
> +       int v, mask, bit;
> +
> +       bit =3D (offset =3D=3D TPS65219_GPIO0_IDX) ? TPS65219_GPIO0_OFFSE=
T : offset - 1;
> +
> +       mask =3D BIT(bit);
> +       v =3D value ? mask : 0;
> +
> +       regmap_update_bits(gpio->tps->regmap,
> +                          TPS65219_REG_GENERAL_CONFIG,
> +                          mask, v);

This can fail - I suggest emitting an error message as regmap won't do it.

> +}
> +
> +static int tps65219_gpio_change_direction(struct gpio_chip *gc, unsigned=
 int offset,
> +                                         unsigned int direction)
> +{
> +       struct tps65219_gpio *gpio =3D gpiochip_get_data(gc);
> +
> +       /* Documentation is stating that GPIO0 direction must not be chan=
ged in Linux:
> +        * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
> +        * Should only be changed in INITIALIZE state (prior to ON Reques=
t).
> +        * Set statically by NVM, changing direction in application can c=
ause a hang.
> +        * Below can be used for test purpose only:
> +        */
> +
> +#if 0
> +       int ret =3D regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MF=
P_1_CONFIG,
> +                                TPS65219_GPIO0_DIR_MASK, direction);
> +       if (ret)
> +               return ret;
> +#endif

Agree with Linus here on enabling it for DEBUG.

And a newline here.

> +       dev_err(gpio->tps->dev,
> +               "GPIO%d direction set by NVM, change to %u failed, not al=
lowed by specification\n",
> +                offset, direction);

And before return.

> +       return -EOPNOTSUPP;
> +}
> +
> +static int tps65219_gpio_direction_input(struct gpio_chip *gc, unsigned =
int offset)
> +{
> +       struct tps65219_gpio *gpio =3D gpiochip_get_data(gc);
> +
> +       if (offset !=3D TPS65219_GPIO0_IDX) {
> +               dev_err(gpio->tps->dev,
> +                       "GPIO%d is output only, cannot change to input\n"=
,
> +                       offset);
> +               return -EOPNOTSUPP;
> +       }

Newline here.

> +       if (tps65219_gpio_get_direction(gc, offset) =3D=3D TPS65219_GPIO_=
DIR_IN)
> +               return 0;

and here.

> +       return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_D=
IR_IN);
> +}
> +
> +static int tps65219_gpio_direction_output(struct gpio_chip *gc, unsigned=
 int offset,
> +                                         int value)
> +{
> +       tps65219_gpio_set(gc, offset, value);
> +       if (offset !=3D TPS65219_GPIO0_IDX)
> +               return 0;
> +
> +       if (tps65219_gpio_get_direction(gc, offset) =3D=3D TPS65219_GPIO_=
DIR_OUT)
> +               return 0;

and here.

> +       return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_D=
IR_OUT);
> +}
> +
> +static const struct gpio_chip tps65219_gpio_chip =3D {
> +       .label                  =3D "tps65219-gpio",
> +       .owner                  =3D THIS_MODULE,
> +       .get_direction          =3D tps65219_gpio_get_direction,
> +       .direction_input        =3D tps65219_gpio_direction_input,
> +       .direction_output       =3D tps65219_gpio_direction_output,
> +       .get                    =3D tps65219_gpio_get,
> +       .set                    =3D tps65219_gpio_set,
> +       .base                   =3D -1,
> +       .ngpio                  =3D 3,
> +       .can_sleep              =3D true,
> +};
> +
> +static int tps65219_gpio_probe(struct platform_device *pdev)
> +{
> +       struct tps65219 *tps =3D dev_get_drvdata(pdev->dev.parent);
> +       struct tps65219_gpio *gpio;
> +
> +       gpio =3D devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +
> +       gpio->tps =3D tps;
> +       gpio->gpio_chip =3D tps65219_gpio_chip;

Aren't you getting any warnings here about dropping the 'const' from
the global structure?

> +       gpio->gpio_chip.parent =3D tps->dev;
> +
> +       return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio_chip, gpio)=
;
> +}
> +
> +static struct platform_driver tps65219_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "tps65219-gpio",
> +       },
> +       .probe =3D tps65219_gpio_probe,
> +};
> +module_platform_driver(tps65219_gpio_driver);
> +
> +MODULE_ALIAS("platform:tps65219-gpio");
> +MODULE_AUTHOR("Jonathan Cormier <jcormier@criticallink.com>");
> +MODULE_DESCRIPTION("TPS65219 GPIO driver");
> +MODULE_LICENSE("GPL");
>

Otherwise looks good, just a couple nits.

Bart

> --
> 2.34.1
>
