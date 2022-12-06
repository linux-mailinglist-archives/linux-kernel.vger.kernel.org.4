Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFC644A4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiLFRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiLFRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:31:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE6326CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:31:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so21267757edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+3e6H+rNc43BYKP5QkPBUPguk9yv8mtPl4Zi9TTV2M=;
        b=RHo82ZeUKPpZm++b23/Vi01vKGRZbpzPstVySQnDsmBFjqptsTHMkdlt5NDuUcCjLJ
         D+dQDJA16twpkFpjMRPfNUcCVLS7OBRiBBJ7UrlQ4Byu/mINP+boanGRQuqFFMr8IT7k
         yjQhN5ZGdSzRfLgxMiHNCrsRlRuGLg5GMlcE1fOC0aUQiTpGoVSqLl6eI/2HzUjcs4yr
         mTq9hJ+LvS2JPtHslPhw56nbUEklefcTDStYfKjvQdNdFw+lJ8i9PhjiPkyd9JCCeYM/
         VkCa1mTs10BWvMrFl/koSxmJQitrGybtGFVQPX+mf8AZ+mqS2zqgZAT3HxUdux+yQk01
         oW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+3e6H+rNc43BYKP5QkPBUPguk9yv8mtPl4Zi9TTV2M=;
        b=RKAyCLpqNQzsOcwyXwBvetlxdoNoWk4irk7J86uaeVngZEyH/dOptUwoSuPg6XQ9nD
         +pOG8kT1J7T1x5V8efn5VXo2kKGZARKy1owBJ6lDEJE4v4dHyRIvjMRP47gF4l4TH2VX
         LwXmdmONLWiHNmHXa0fKvlQzlXMJIcXPDK7M7wGrL4eQ9OXUrsM+TrrKM1tXYa0ZssQ+
         JxXAI9u6VLdlgT203mzMmeMFOfVtH0PX18iVNE2p5ERO7vAoUVcWdTcY/W4/TQwtGsSL
         7mHliiunlkTElIn01tuid9oSd2q89sibRvgztn6JYWof62bfEWJVlQ6ZHBHaEzcqRgva
         oKeQ==
X-Gm-Message-State: ANoB5pnzC2blpa4840S1OovbvxmMWmqw6JcsHdo9HlgUHjtKWfT1Hyan
        OuJ45C6NQV5axUuZhZDknoR0PVAj9mny7XXX8WA6C7i5CLCdWS5r
X-Google-Smtp-Source: AA0mqf5z3H2sENvjKeFsCcR7szkuQlYRa/2GaINCxycrZ2LS0FpYc8bKkNTO7AkvuYIqloOUkv/rK/xOygercDPdtGM=
X-Received: by 2002:a05:6402:538e:b0:468:ea55:ab40 with SMTP id
 ew14-20020a056402538e00b00468ea55ab40mr1832454edb.323.1670347862529; Tue, 06
 Dec 2022 09:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20221124110210.3905092-1-Naresh.Solanki@9elements.com> <20221124110210.3905092-3-Naresh.Solanki@9elements.com>
In-Reply-To: <20221124110210.3905092-3-Naresh.Solanki@9elements.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 6 Dec 2022 23:00:52 +0530
Message-ID: <CABqG17hCoY86w3usA6RNLQbGjHo_JRFioznuvdCZLo4_KNaMWg@mail.gmail.com>
Subject: Re: [RESEND PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

Regards,
Naresh Solanki



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email:  naresh.solanki@9elements.com
Mobile:  +91 9538631477

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO


On Thu, 24 Nov 2022 at 16:32, Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> Implement a regulator driver with IRQ support for fault management.
> Written against documentation [1] and [2] and tested on real hardware.
>
> Every channel has its own regulator supplies nammed 'vss1-supply' and
> 'vss2-supply'. The regulator supply is used to determine the output
> voltage, as the smart switch provides no output regulation.
> The driver requires the 'shunt-resistor-micro-ohms' property to be
> present in Device Tree to properly calculate current related
> values.
>
> Datasheet links:
> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/mfd/Kconfig         |  12 +++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 207 insertions(+)
>  create mode 100644 drivers/mfd/max597x.c
>  create mode 100644 include/linux/mfd/max597x.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b93856de432..416fe7986b7b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -253,6 +253,18 @@ config MFD_MADERA_SPI
>           Support for the Cirrus Logic Madera platform audio SoC
>           core functionality controlled via SPI.
>
> +config MFD_MAX597X
> +       tristate "Maxim 597x Power Switch and Monitor"
> +       depends on I2C
> +       depends on OF
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       help
> +         This driver controls a Maxim 5970/5978 switch via I2C bus.
> +         The MAX5970/5978 is a smart switch with no output regulation, b=
ut
> +         fault protection and voltage and current monitoring capabilitie=
s.
> +         Also it supports upto 4 indication LEDs.
> +
>  config MFD_CS47L15
>         bool "Cirrus Logic CS47L15"
>         select PINCTRL_CS47L15
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7ed3ef4a698c..819d711fa748 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -161,6 +161,7 @@ obj-$(CONFIG_MFD_DA9063)    +=3D da9063.o
>  obj-$(CONFIG_MFD_DA9150)       +=3D da9150-core.o
>
>  obj-$(CONFIG_MFD_MAX14577)     +=3D max14577.o
> +obj-$(CONFIG_MFD_MAX597X)      +=3D max597x.o
>  obj-$(CONFIG_MFD_MAX77620)     +=3D max77620.o
>  obj-$(CONFIG_MFD_MAX77650)     +=3D max77650.o
>  obj-$(CONFIG_MFD_MAX77686)     +=3D max77686.o
> diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
> new file mode 100644
> index 000000000000..45838413f24a
> --- /dev/null
> +++ b/drivers/mfd/max597x.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Maxim MAX5970/MAX5978 Power Switch & Monitor
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max597x.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config max597x_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .max_register =3D MAX_REGISTERS,
> +};
> +
> +static const struct mfd_cell max597x_cells[] =3D {
> +       { .name =3D "max597x-regulator", },
> +       { .name =3D "max597x-iio", },
> +       { .name =3D "max597x-led", },
> +};
> +
> +static int max597x_probe(struct i2c_client *i2c, const struct i2c_device=
_id *id)
> +{
> +       struct max597x_data *ddata;
> +       enum max597x_chip_type chip =3D id->driver_data;
> +
> +       ddata =3D devm_kzalloc(&i2c->dev, sizeof(*ddata), GFP_KERNEL);
> +       if (!ddata)
> +               return -ENOMEM;
> +
> +       /*
> +        * Based on chip type, Initialize the number of switch. This is n=
eeded by
> +        * regulator & iio cells.
> +        */
> +       switch (chip) {
> +       case MAX597x_TYPE_MAX5970:
> +               ddata->num_switches =3D MAX5970_NUM_SWITCHES;
> +               break;
> +       case MAX597x_TYPE_MAX5978:
> +               ddata->num_switches =3D MAX5978_NUM_SWITCHES;
> +               break;
> +       }
> +
> +       ddata->regmap =3D devm_regmap_init_i2c(i2c, &max597x_regmap_confi=
g);
> +       if (IS_ERR(ddata->regmap)) {
> +               dev_err(&i2c->dev, "Failed to initialize regmap");
> +               return PTR_ERR(ddata->regmap);
> +       }
> +
> +       /* IRQ used by regulator cell */
> +       ddata->irq =3D i2c->irq;
> +       ddata->dev =3D &i2c->dev;
> +       i2c_set_clientdata(i2c, ddata);
> +
> +       return devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO,
> +                                   max597x_cells, ARRAY_SIZE(max597x_cel=
ls),
> +                                   NULL, 0, NULL);
> +}
> +
> +static const struct i2c_device_id max597x_table[] =3D {
> +       { .name =3D "max5970", MAX597x_TYPE_MAX5970 },
> +       { .name =3D "max5978", MAX597x_TYPE_MAX5978 },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max597x_table);
> +
> +static const struct of_device_id max597x_of_match[] =3D {
> +       { .compatible =3D "maxim,max5970" },
> +       { .compatible =3D "maxim,max5978" },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, max597x_of_match);
> +
> +static struct i2c_driver max597x_driver =3D {
> +       .id_table =3D max597x_table,
> +       .driver =3D {
> +                 .name =3D "max597x",
> +                 .of_match_table =3D of_match_ptr(max597x_of_match),
> +                 },
> +       .probe =3D max597x_probe,
> +};
> +module_i2c_driver(max597x_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX597X Power Switch and Monitor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
> new file mode 100644
> index 000000000000..706eff9c50a4
> --- /dev/null
> +++ b/include/linux/mfd/max597x.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Maxim MAX5970/MAX5978 Power Switch & Monitor
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#ifndef MFD_MAX597X_H
> +#define MFD_MAX597X_H
> +
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX5970_NUM_SWITCHES 2
> +#define MAX5978_NUM_SWITCHES 1
> +#define MAX597X_NUM_LEDS     4
> +
> +enum max597x_chip_type {
> +       MAX597x_TYPE_MAX5978 =3D 1,
> +       MAX597x_TYPE_MAX5970,
> +};
> +
> +#define MAX5970_REG_CURRENT_L(ch)              (0x01 + (ch) * 4)
> +#define MAX5970_REG_CURRENT_H(ch)              (0x00 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_L(ch)              (0x03 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_H(ch)              (0x02 + (ch) * 4)
> +#define MAX5970_REG_MON_RANGE                  0x18
> +#define  MAX5970_MON_MASK                              0x3
> +#define  MAX5970_MON(reg, ch)          (((reg) >> ((ch) * 2)) & MAX5970_=
MON_MASK)
> +#define  MAX5970_MON_MAX_RANGE_UV              16000000
> +
> +#define MAX5970_REG_CH_UV_WARN_H(ch)   (0x1A + (ch) * 10)
> +#define MAX5970_REG_CH_UV_WARN_L(ch)   (0x1B + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_H(ch)   (0x1C + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_L(ch)   (0x1D + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_H(ch)   (0x1E + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_L(ch)   (0x1F + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_H(ch)   (0x20 + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_L(ch)   (0x21 + (ch) * 10)
> +
> +#define  MAX5970_VAL2REG_H(x)                  (((x) >> 2) & 0xFF)
> +#define  MAX5970_VAL2REG_L(x)                  ((x) & 0x3)
> +
> +#define MAX5970_REG_DAC_FAST(ch)               (0x2E + (ch))
> +
> +#define MAX5970_FAST2SLOW_RATIO                        200
> +
> +#define MAX5970_REG_STATUS0                            0x31
> +#define  MAX5970_CB_IFAULTF(ch)                        (1 << (ch))
> +#define  MAX5970_CB_IFAULTS(ch)                        (1 << ((ch) + 4))
> +
> +#define MAX5970_REG_STATUS1                            0x32
> +#define  STATUS1_PROT_MASK                             0x3
> +#define  STATUS1_PROT(reg) \
> +       (((reg) >> 6) & STATUS1_PROT_MASK)
> +#define  STATUS1_PROT_SHUTDOWN                 0
> +#define  STATUS1_PROT_CLEAR_PG                 1
> +#define  STATUS1_PROT_ALERT_ONLY               2
> +
> +#define MAX5970_REG_STATUS2                            0x33
> +#define  MAX5970_IRNG_MASK                             0x3
> +#define  MAX5970_IRNG(reg, ch) \
> +                                               (((reg) >> ((ch) * 2)) & =
MAX5970_IRNG_MASK)
> +
> +#define MAX5970_REG_STATUS3                            0x34
> +#define  MAX5970_STATUS3_ALERT                 BIT(4)
> +#define  MAX5970_STATUS3_PG(ch)                        BIT(ch)
> +
> +#define MAX5970_REG_FAULT0                             0x35
> +#define  UV_STATUS_WARN(ch)                            BIT(ch)
> +#define  UV_STATUS_CRIT(ch)                            BIT(ch + 4)
> +
> +#define MAX5970_REG_FAULT1                             0x36
> +#define  OV_STATUS_WARN(ch)                            BIT(ch)
> +#define  OV_STATUS_CRIT(ch)                            BIT(ch + 4)
> +
> +#define MAX5970_REG_FAULT2                             0x37
> +#define  OC_STATUS_WARN(ch)                            BIT(ch)
> +
> +#define MAX5970_REG_CHXEN                              0x3b
> +#define  CHXEN(ch)                                             (3 << (ch=
 * 2))
> +
> +#define MAX5970_REG_LED_FLASH                  0x43
> +
> +#define MAX_REGISTERS                                  0x49
> +#define ADC_MASK                                               0x3FF
> +
> +struct max597x_data {
> +       struct device *dev;
> +       int irq;
> +       int num_switches;
> +       struct regmap *regmap;
> +       /* Chip specific parameters needed by regulator & iio cells */
> +       u32 irng[MAX5970_NUM_SWITCHES];
> +       u32 mon_rng[MAX5970_NUM_SWITCHES];
> +       u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
> +};
> +
> +#endif
> --
> 2.37.3
>
