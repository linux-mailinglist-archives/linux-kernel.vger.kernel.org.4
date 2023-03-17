Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0257A6BE9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCQMyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCQMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:54:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42729901B;
        Fri, 17 Mar 2023 05:54:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h19so5393969qtn.1;
        Fri, 17 Mar 2023 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679057659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yy1odbWsXcB3+d6xpK0RyeqAtvnnK3FOaGxkblyRCM=;
        b=ZkaqhdmqHvcbDaC4HFT15bz4oD8y5+iB6XdR1QhpfY67tf7MUNkuwjxQHvzmI8+D6o
         xQsSt+LLYQB9OIs9mHuB0vzS46t6Y94cQIZBWkfUwKFXzh1G4DithIWpqn7dsfnyM/nJ
         TCMcCTB08mXQNqwGBcxAoCSALf3B43/yLYy9cSMIkMTO6d2S+lWUgoj88B87AMOrB8+p
         XIAoRnS2gUnzGwPrDHihomU1FFutoCzgCKLNzwa+1zJLhRiXMRlQ5NR4+6iLMkVxUj/S
         WqOp4ZArrueZfbt8aFs1ZNfnZnOEM6iwK25AiDFqyOjNUxgl7gykhocv3wpMGiQi/7hc
         uqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679057659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yy1odbWsXcB3+d6xpK0RyeqAtvnnK3FOaGxkblyRCM=;
        b=m9yRunx4ZnRtYM8kiV6YizJ6GDjey6yw31DGHlq6akkALY8rSEV6DhnvuvtYuAuSyW
         lWR4ESRjOvu+73rowY6m6s+EuDe6TkgvFkJfXkLtRf1VizSudQNkPK3FJeCvVNdFw5OI
         UPhY5c5LqKWnFhhas39QoRR9C4TsJZGWQNg3KUFNRm7mceKJ9pi8I25f0sGaynwdZEyt
         fvdXJfWVcSqqiDanaKYxWg08w/ryQolvu7puZfEg8ptJI/gFF49IP18jD3H8DmY76Agq
         MJEbO5Uz/xcLEjBWso1iZaA86DfDUFFdrZT9CAjHZb12ay+XLIDYSc1PufY3UJxVaYRd
         zWmg==
X-Gm-Message-State: AO0yUKWjinb3+jbb6efnO9P6LwJn+n9Zvp9a57TfBto4ivjYkpatsZWE
        JhOvg/88U/6x+52vlNdRLXOMALJ9ApvSYesJfSY=
X-Google-Smtp-Source: AK7set8TQ1zjPsMRcmx95MZxkXEchuw8OEVbJF9E9g0BVWO3UdstkB4BMvTVeDaxat8f4pof91H9DcDAiLJMXwUtrAI=
X-Received: by 2002:ac8:4044:0:b0:3d3:a829:9715 with SMTP id
 j4-20020ac84044000000b003d3a8299715mr1687659qtl.0.1679057659262; Fri, 17 Mar
 2023 05:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-3-asmaa@nvidia.com>
In-Reply-To: <20230315215027.30685-3-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Mar 2023 14:53:43 +0200
Message-ID: <CAHp75VeOsh4yi3mst9xpgBviwh0jnqMRQYEoTtzhZZHbneOt7w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: mlxbf3: Add pinctrl driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        niyas.sait@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 11:50=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> NVIDIA BlueField-3 SoC has a few pins that can be used as GPIOs
> or take the default hardware functionality. Add a driver for
> the pin muxing.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  drivers/pinctrl/Kconfig          |  13 ++
>  drivers/pinctrl/Makefile         |   1 +
>  drivers/pinctrl/pinctrl-mlxbf3.c | 320 +++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-mlxbf3.c
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 7d5f5458c72e..9009bc6adbea 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -523,6 +523,19 @@ config PINCTRL_ZYNQMP
>           This driver can also be built as a module. If so, the module
>           will be called pinctrl-zynqmp.
>
> +config PINCTRL_MLXBF3
> +       tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> +       depends on (MELLANOX_PLATFORM && ARM64) || COMPILE_TEST
> +       select PINMUX
> +       select GPIOLIB
> +       select GPIOLIB_IRQCHIP
> +       select GPIO_MLXBF3
> +       help
> +         Say Y to select the pinctrl driver for BlueField-3 SoCs.
> +         This pin controller allows selecting the mux function for
> +         each pin. This driver can also be built as a module called
> +         pinctrl-mlxbf3.
> +
>  source "drivers/pinctrl/actions/Kconfig"
>  source "drivers/pinctrl/aspeed/Kconfig"
>  source "drivers/pinctrl/bcm/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index d5939840bb2a..10dd072e8423 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PINCTRL_MCP23S08_I2C)    +=3D pinctrl-mcp2=
3s08_i2c.o
>  obj-$(CONFIG_PINCTRL_MCP23S08_SPI)     +=3D pinctrl-mcp23s08_spi.o
>  obj-$(CONFIG_PINCTRL_MCP23S08) +=3D pinctrl-mcp23s08.o
>  obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)  +=3D pinctrl-microchip-sgpio.o
> +obj-$(CONFIG_PINCTRL_MLXBF3)   +=3D pinctrl-mlxbf3.o
>  obj-$(CONFIG_PINCTRL_OCELOT)   +=3D pinctrl-ocelot.o
>  obj-$(CONFIG_PINCTRL_OXNAS)    +=3D pinctrl-oxnas.o
>  obj-$(CONFIG_PINCTRL_PALMAS)   +=3D pinctrl-palmas.o
> diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-m=
lxbf3.c
> new file mode 100644
> index 000000000000..3698f7bbd88d
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-mlxbf3.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
> +/* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#define MLXBF3_NGPIOS_GPIO0    32
> +#define MLXBF3_MAX_GPIO_PINS   56
> +
> +enum {
> +       MLXBF3_GPIO_HW_MODE,
> +       MLXBF3_GPIO_SW_MODE,
> +};
> +
> +struct mlxbf3_pinctrl {
> +       void __iomem *fw_ctrl_set0;
> +       void __iomem *fw_ctrl_clr0;
> +       void __iomem *fw_ctrl_set1;
> +       void __iomem *fw_ctrl_clr1;
> +       struct device *dev;
> +       struct pinctrl_dev *pctl;
> +       struct pinctrl_gpio_range gpio_range;
> +};
> +
> +#define MLXBF3_GPIO_RANGE(_id, _pinbase, _gpiobase, _npins)    \
> +       {                                                       \
> +               .name =3D "mlxbf3_gpio_range",                    \
> +               .id =3D _id,                                      \
> +               .base =3D _gpiobase,                              \
> +               .pin_base =3D _pinbase,                           \
> +               .npins =3D _npins,                                \
> +       }
> +
> +static struct pinctrl_gpio_range mlxbf3_pinctrl_gpio_ranges[] =3D {
> +       MLXBF3_GPIO_RANGE(0, 0,  480, 32),
> +       MLXBF3_GPIO_RANGE(1,  32, 456, 24),
> +};
> +
> +static const struct pinctrl_pin_desc mlxbf3_pins[] =3D {
> +       PINCTRL_PIN(0, "gpio0"),
> +       PINCTRL_PIN(1, "gpio1"),
> +       PINCTRL_PIN(2, "gpio2"),
> +       PINCTRL_PIN(3, "gpio3"),
> +       PINCTRL_PIN(4, "gpio4"),
> +       PINCTRL_PIN(5, "gpio5"),
> +       PINCTRL_PIN(6, "gpio6"),
> +       PINCTRL_PIN(7, "gpio7"),
> +       PINCTRL_PIN(8, "gpio8"),
> +       PINCTRL_PIN(9, "gpio9"),
> +       PINCTRL_PIN(10, "gpio10"),
> +       PINCTRL_PIN(11, "gpio11"),
> +       PINCTRL_PIN(12, "gpio12"),
> +       PINCTRL_PIN(13, "gpio13"),
> +       PINCTRL_PIN(14, "gpio14"),
> +       PINCTRL_PIN(15, "gpio15"),
> +       PINCTRL_PIN(16, "gpio16"),
> +       PINCTRL_PIN(17, "gpio17"),
> +       PINCTRL_PIN(18, "gpio18"),
> +       PINCTRL_PIN(19, "gpio19"),
> +       PINCTRL_PIN(20, "gpio20"),
> +       PINCTRL_PIN(21, "gpio21"),
> +       PINCTRL_PIN(22, "gpio22"),
> +       PINCTRL_PIN(23, "gpio23"),
> +       PINCTRL_PIN(24, "gpio24"),
> +       PINCTRL_PIN(25, "gpio25"),
> +       PINCTRL_PIN(26, "gpio26"),
> +       PINCTRL_PIN(27, "gpio27"),
> +       PINCTRL_PIN(28, "gpio28"),
> +       PINCTRL_PIN(29, "gpio29"),
> +       PINCTRL_PIN(30, "gpio30"),
> +       PINCTRL_PIN(31, "gpio31"),
> +       PINCTRL_PIN(32, "gpio32"),
> +       PINCTRL_PIN(33, "gpio33"),
> +       PINCTRL_PIN(34, "gpio34"),
> +       PINCTRL_PIN(35, "gpio35"),
> +       PINCTRL_PIN(36, "gpio36"),
> +       PINCTRL_PIN(37, "gpio37"),
> +       PINCTRL_PIN(38, "gpio38"),
> +       PINCTRL_PIN(39, "gpio39"),
> +       PINCTRL_PIN(40, "gpio40"),
> +       PINCTRL_PIN(41, "gpio41"),
> +       PINCTRL_PIN(42, "gpio42"),
> +       PINCTRL_PIN(43, "gpio43"),
> +       PINCTRL_PIN(44, "gpio44"),
> +       PINCTRL_PIN(45, "gpio45"),
> +       PINCTRL_PIN(46, "gpio46"),
> +       PINCTRL_PIN(47, "gpio47"),
> +       PINCTRL_PIN(48, "gpio48"),
> +       PINCTRL_PIN(49, "gpio49"),
> +       PINCTRL_PIN(50, "gpio50"),
> +       PINCTRL_PIN(51, "gpio51"),
> +       PINCTRL_PIN(52, "gpio52"),
> +       PINCTRL_PIN(53, "gpio53"),
> +       PINCTRL_PIN(54, "gpio54"),
> +       PINCTRL_PIN(55, "gpio55"),
> +};
> +
> +/*
> + * All single-pin functions can be mapped to any GPIO, however pinmux ap=
plies
> + * functions to pin groups and only those groups declared as supporting =
that
> + * function. To make this work we must put each pin in its own dummy gro=
up so
> + * that the functions can be described as applying to all pins.
> + * We use the same name as in the datasheet.
> + */
> +static const char * const mlxbf3_pinctrl_single_group_names[] =3D {
> +       "gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6=
", "gpio7",
> +       "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio=
14", "gpio15",
> +       "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21", "gpio=
22", "gpio23",
> +       "gpio24", "gpio25", "gpio26", "gpio27", "gpio28", "gpio29", "gpio=
30", "gpio31",
> +       "gpio32", "gpio33", "gpio34", "gpio35", "gpio36", "gpio37", "gpio=
38", "gpio39",
> +       "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45", "gpio=
46", "gpio47",
> +       "gpio48", "gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio=
54", "gpio55",
> +};
> +
> +static int mlxbf3_get_groups_count(struct pinctrl_dev *pctldev)
> +{
> +       /* Number single-pin groups */
> +       return MLXBF3_MAX_GPIO_PINS;
> +}
> +
> +static const char *mlxbf3_get_group_name(struct pinctrl_dev *pctldev,
> +                                        unsigned int selector)
> +{
> +       return mlxbf3_pinctrl_single_group_names[selector];
> +}
> +
> +static int mlxbf3_get_group_pins(struct pinctrl_dev *pctldev,
> +                                unsigned int selector,
> +                                const unsigned int **pins,
> +                                unsigned int *num_pins)
> +{
> +       /* return the dummy group for a single pin */
> +       *pins =3D &selector;
> +       *num_pins =3D 1;
> +
> +       return 0;
> +}
> +
> +static const struct pinctrl_ops mlxbf3_pinctrl_group_ops =3D {
> +       .get_groups_count =3D mlxbf3_get_groups_count,
> +       .get_group_name =3D mlxbf3_get_group_name,
> +       .get_group_pins =3D mlxbf3_get_group_pins,
> +};
> +
> +/*
> + * Only 2 functions are supported and they apply to all pins:
> + * 1) Default hardware functionality
> + * 2) Software controlled GPIO
> + */
> +static const char * const mlxbf3_gpiofunc_group_names[] =3D { "swctrl" }=
;
> +static const char * const mlxbf3_hwfunc_group_names[]   =3D { "hwctrl" }=
;
> +
> +struct pinfunction mlxbf3_pmx_funcs[] =3D {
> +       PINCTRL_PINFUNCTION("hwfunc", mlxbf3_hwfunc_group_names, 1),
> +       PINCTRL_PINFUNCTION("gpiofunc", mlxbf3_gpiofunc_group_names, 1),
> +};
> +
> +static int mlxbf3_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
> +{
> +       return ARRAY_SIZE(mlxbf3_pmx_funcs);
> +}
> +
> +static const char *mlxbf3_pmx_get_func_name(struct pinctrl_dev *pctldev,
> +                                          unsigned int selector)
> +{
> +       return mlxbf3_pmx_funcs[selector].name;
> +}
> +
> +static int mlxbf3_pmx_get_groups(struct pinctrl_dev *pctldev,
> +                                unsigned int selector,
> +                                const char * const **groups,
> +                                unsigned int * const num_groups)
> +{
> +       *groups =3D mlxbf3_pmx_funcs[selector].groups;
> +       *num_groups =3D MLXBF3_MAX_GPIO_PINS;
> +
> +       return 0;
> +}
> +
> +static int mlxbf3_pmx_set(struct pinctrl_dev *pctldev,
> +                             unsigned int selector,
> +                             unsigned int group)
> +{
> +       struct mlxbf3_pinctrl *priv =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +       if (selector =3D=3D MLXBF3_GPIO_HW_MODE) {
> +               if (group < MLXBF3_NGPIOS_GPIO0)
> +                       writel(BIT(group), priv->fw_ctrl_clr0);
> +               else
> +                       writel(BIT(group % MLXBF3_NGPIOS_GPIO0), priv->fw=
_ctrl_clr1);
> +       }
> +
> +       if (selector =3D=3D MLXBF3_GPIO_SW_MODE) {
> +               if (group < MLXBF3_NGPIOS_GPIO0)
> +                       writel(BIT(group), priv->fw_ctrl_set0);
> +               else
> +                       writel(BIT(group % MLXBF3_NGPIOS_GPIO0), priv->fw=
_ctrl_set1);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mlxbf3_gpio_request_enable(struct pinctrl_dev *pctldev,
> +                                    struct pinctrl_gpio_range *range,
> +                                    unsigned int offset)
> +{
> +       struct mlxbf3_pinctrl *priv =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +       if (offset < MLXBF3_NGPIOS_GPIO0)
> +               writel(BIT(offset), priv->fw_ctrl_set0);
> +       else
> +               writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_s=
et1);
> +
> +       return 0;
> +}
> +
> +static void mlxbf3_gpio_disable_free(struct pinctrl_dev *pctldev,
> +                                   struct pinctrl_gpio_range *range,
> +                                   unsigned int offset)
> +{
> +       struct mlxbf3_pinctrl *priv =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +       /* disable GPIO functionality by giving control back to hardware =
*/
> +       if (offset < MLXBF3_NGPIOS_GPIO0)
> +               writel(BIT(offset), priv->fw_ctrl_clr0);
> +       else
> +               writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_c=
lr1);
> +}
> +
> +static const struct pinmux_ops mlxbf3_pmx_ops =3D {
> +       .get_functions_count =3D mlxbf3_pmx_get_funcs_count,
> +       .get_function_name =3D mlxbf3_pmx_get_func_name,
> +       .get_function_groups =3D mlxbf3_pmx_get_groups,
> +       .set_mux =3D mlxbf3_pmx_set,
> +       .gpio_request_enable =3D mlxbf3_gpio_request_enable,
> +       .gpio_disable_free =3D mlxbf3_gpio_disable_free,
> +};
> +
> +static struct pinctrl_desc mlxbf3_pin_desc =3D {
> +       .name =3D "pinctrl-mlxbf3",
> +       .pins =3D mlxbf3_pins,
> +       .npins =3D ARRAY_SIZE(mlxbf3_pins),
> +       .pctlops =3D &mlxbf3_pinctrl_group_ops,
> +       .pmxops =3D &mlxbf3_pmx_ops,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static_assert(ARRAY_SIZE(mlxbf3_pinctrl_single_group_names) =3D=3D MLXBF=
3_MAX_GPIO_PINS);
> +
> +static int mlxbf3_pinctrl_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mlxbf3_pinctrl *priv;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D &pdev->dev;
> +
> +       priv->fw_ctrl_set0 =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->fw_ctrl_set0))
> +               return PTR_ERR(priv->fw_ctrl_set0);
> +
> +       priv->fw_ctrl_clr0 =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(priv->fw_ctrl_set0))
> +               return PTR_ERR(priv->fw_ctrl_set0);
> +
> +       priv->fw_ctrl_set1 =3D devm_platform_ioremap_resource(pdev, 2);
> +       if (IS_ERR(priv->fw_ctrl_set0))
> +               return PTR_ERR(priv->fw_ctrl_set0);
> +
> +       priv->fw_ctrl_clr1 =3D devm_platform_ioremap_resource(pdev, 3);
> +       if (IS_ERR(priv->fw_ctrl_set0))
> +               return PTR_ERR(priv->fw_ctrl_set0);
> +
> +       ret =3D devm_pinctrl_register_and_init(dev,
> +                                            &mlxbf3_pin_desc,
> +                                            priv,
> +                                            &priv->pctl);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register pinctr=
l\n");
> +
> +       ret =3D pinctrl_enable(priv->pctl);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable pinctrl\=
n");
> +
> +       pinctrl_add_gpio_ranges(priv->pctl, mlxbf3_pinctrl_gpio_ranges, 2=
);
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id mlxbf3_pinctrl_acpi_ids[] =3D {
> +       { "MLNXBF34", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, mlxbf3_pinctrl_acpi_ids);
> +
> +static struct platform_driver mlxbf3_pinctrl_driver =3D {
> +       .driver =3D {
> +               .name =3D "pinctrl-mlxbf3",
> +               .acpi_match_table =3D mlxbf3_pinctrl_acpi_ids,
> +       },
> +       .probe =3D mlxbf3_pinctrl_probe,
> +};
> +module_platform_driver(mlxbf3_pinctrl_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA pinctrl driver");
> +MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.30.1
>


--=20
With Best Regards,
Andy Shevchenko
