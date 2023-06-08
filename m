Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA9727C88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjFHKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjFHKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:16:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A81FE9;
        Thu,  8 Jun 2023 03:16:17 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6261a8bbe5fso3874266d6.0;
        Thu, 08 Jun 2023 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686219376; x=1688811376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wer7TjrqaP3LFHGTKzkrthDtg8XZtueYOxQUZIMShj0=;
        b=DXrl+NRHgBi7GeS9cbDNxhQCJd/DtN5ZWd8H5QKkHFqNtmPZDhYW+oCWpz9Q1bfsTO
         +BptzesBIpdBGwtArVN6hivSr1DWF411sYYTpvsHS/WLfOvfCY3EPOjXYSPcba3gszxV
         R4m7LUZb9Pl3o3A9mgx0n4r5YaXdYBqixdHO7t/dFnp6q/vSUPHqsTvAkALF3Oh3GW3R
         /pr6DSE7F3fr3TTzJVtbXKmkgJGQmQ66d6kyIY/kGrdRpHuveu3Kdwo9osHuzD//nvx1
         ub5y9JLcDpmj08k2TrpsnUPKR2q03J9BkCIer8nNrg5fFudR9RwatjxY7ycXsL9/q6eB
         T0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219376; x=1688811376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wer7TjrqaP3LFHGTKzkrthDtg8XZtueYOxQUZIMShj0=;
        b=BfotHwilMmTj+AVMH9rJDrZVPNOfKBvP46JdEYnS4d9B0KriqtnYVcjWcTqULiF5Or
         rHhGTscbk2j7cVOeEVWeWNdQ/mgYJFkBg0LzwSW/vGh6732IAwskqIU3vnsb1kpGvP1A
         EHn1QUYDCb7qmCrLLNj7Si3PKnccO1I0PU9oyr6odmZ5LmAuLLnaaaT4SyJoxDsiP44k
         Tcd1s56Mv/0pfKdq3Np316CMe5Mfu533vCEOFkj2TV6FGK30CZdxtMMRpwLLut6+6yL2
         fpEskFNbpDuWotOL86ivPuc44DxBvH0ZRWKTJKIJu+amw43uDRCPiiv0sh30tOxXoDhB
         5f2g==
X-Gm-Message-State: AC+VfDzpzYLdDU7YnA7qVYWJdOi/6yUrG0UXxcqIN7LzMBaovnPQ14pZ
        eXXiDuur9fTHM+BeMOybbqfzvPvzI1Pivzzz4ss=
X-Google-Smtp-Source: ACHHUZ5bJqwsUiuYIuYyKtrxp0T4DQ2cWLIRkrjEFKTY+zMqOmjHn4eTPhPkGIovuK7yW1hFqI6ATJzAJalRd4GjRDg=
X-Received: by 2002:ad4:5c8d:0:b0:626:2b44:40c with SMTP id
 o13-20020ad45c8d000000b006262b44040cmr1097024qvh.59.1686219376038; Thu, 08
 Jun 2023 03:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230608072819.25930-1-zhuyinbo@loongson.cn> <20230608072819.25930-3-zhuyinbo@loongson.cn>
In-Reply-To: <20230608072819.25930-3-zhuyinbo@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Jun 2023 13:15:39 +0300
Message-ID: <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 10:28=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> This bus driver supports the Loongson SPI hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to

the use

> register SPI device resources.

Thank you for an update. I have a few nit-picks below, but in general
this version is good (esp. if you address them)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  MAINTAINERS                     |   4 +
>  drivers/spi/Kconfig             |  26 +++
>  drivers/spi/Makefile            |   3 +
>  drivers/spi/spi-loongson-core.c | 275 ++++++++++++++++++++++++++++++++
>  drivers/spi/spi-loongson-pci.c  |  55 +++++++
>  drivers/spi/spi-loongson-plat.c |  47 ++++++
>  drivers/spi/spi-loongson.h      |  49 ++++++
>  7 files changed, 459 insertions(+)
>  create mode 100644 drivers/spi/spi-loongson-core.c
>  create mode 100644 drivers/spi/spi-loongson-pci.c
>  create mode 100644 drivers/spi/spi-loongson-plat.c
>  create mode 100644 drivers/spi/spi-loongson.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e604dddd87b..69cb8fb2a0e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12191,6 +12191,10 @@ M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>  L:     linux-spi@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> +F:     drivers/spi/spi-loongson-core.c
> +F:     drivers/spi/spi-loongson-pci.c
> +F:     drivers/spi/spi-loongson-plat.c
> +F:     drivers/spi/spi-loongson.h
>
>  LOONGSON-2 SOC SERIES GUTS DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3de2ebe8294a..6b953904792e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -516,6 +516,32 @@ config SPI_LM70_LLP
>           which interfaces to an LM70 temperature sensor using
>           a parallel port.
>
> +config SPI_LOONGSON_CORE
> +       tristate
> +       depends on LOONGARCH || COMPILE_TEST
> +
> +config SPI_LOONGSON_PCI
> +       tristate "Loongson SPI Controller PCI Driver Support"
> +       select SPI_LOONGSON_CORE
> +       depends on PCI && (LOONGARCH || COMPILE_TEST)
> +       help
> +         This bus driver supports the Loongson SPI hardware controller i=
n
> +         the Loongson platforms and supports to use PCI framework to
> +         register SPI device resources.
> +         Say Y or M here if you want to use the SPI controller on
> +         Loongson platform.
> +
> +config SPI_LOONGSON_PLATFORM
> +       tristate "Loongson SPI Controller Platform Driver Support"
> +       select SPI_LOONGSON_CORE
> +       depends on OF && (LOONGARCH || COMPILE_TEST)
> +       help
> +         This bus driver supports the Loongson SPI hardware controller i=
n
> +         the Loongson platforms and supports to use DTS framework to
> +         register SPI device resources.
> +         Say Y or M here if you want to use the SPI controller on
> +         Loongson platform.
> +
>  config SPI_LP8841_RTC
>         tristate "ICP DAS LP-8841 SPI Controller for RTC"
>         depends on MACH_PXA27X_DT || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 28c4817a8a74..3e933064d237 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -71,6 +71,9 @@ obj-$(CONFIG_SPI_INTEL_PLATFORM)      +=3D spi-intel-pl=
atform.o
>  obj-$(CONFIG_SPI_LANTIQ_SSC)           +=3D spi-lantiq-ssc.o
>  obj-$(CONFIG_SPI_JCORE)                        +=3D spi-jcore.o
>  obj-$(CONFIG_SPI_LM70_LLP)             +=3D spi-lm70llp.o
> +obj-$(CONFIG_SPI_LOONGSON_CORE)                +=3D spi-loongson-core.o
> +obj-$(CONFIG_SPI_LOONGSON_PCI)         +=3D spi-loongson-pci.o
> +obj-$(CONFIG_SPI_LOONGSON_PLATFORM)    +=3D spi-loongson-plat.o
>  obj-$(CONFIG_SPI_LP8841_RTC)           +=3D spi-lp8841-rtc.o
>  obj-$(CONFIG_SPI_MESON_SPICC)          +=3D spi-meson-spicc.o
>  obj-$(CONFIG_SPI_MESON_SPIFC)          +=3D spi-meson-spifc.o
> diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-c=
ore.c
> new file mode 100644
> index 000000000000..403b735bd0cf
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-core.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "spi-loongson.h"
> +
> +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsi=
gned char reg,
> +                                         unsigned char data)
> +{
> +       writeb(data, spi->base + reg);
> +}
> +
> +static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsig=
ned char reg)
> +{
> +       return readb(spi->base + reg);
> +}
> +
> +static void loongson_spi_set_cs(struct spi_device *spi, bool val)
> +{
> +       int cs;
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +
> +       cs =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
> +                                          & ~(0x11 << spi_get_chipselect=
(spi, 0));
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG,
> +                                      (val ? (0x11 << spi_get_chipselect=
(spi, 0)) :
> +                                      (0x1 << spi_get_chipselect(spi, 0)=
)) | cs);

Can be done as

static void loongson_spi_set_cs(struct spi_device *spi, bool en)

    unsigned char mask =3D (BIT(4) | BIT(0)) << spi_get_chipselect(spi, 0);
    unsigned char val =3D en ? mask :  (BIT(0) << spi_get_chipselect(spi, 0=
));

    cs =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG) & ~ma=
sk;
    loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val | cs);

(Renamed variables to be consistent with the other uses in the driver below=
)

> +}
> +
> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsi=
gned int hz)
> +{
> +       unsigned char val;
> +       unsigned int div, div_tmp;
> +       static const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10,=
 11};
> +
> +       div =3D clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2=
, 4096);
> +       div_tmp =3D rdiv[fls(div - 1)];
> +       loongson_spi->spcr =3D (div_tmp & GENMASK(1, 0)) >> 0;
> +       loongson_spi->sper =3D (div_tmp & GENMASK(3, 2)) >> 2;
> +       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);

    val &=3D GENMASK(1, 0);

> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val =
& ~3) |
> +                              loongson_spi->spcr);

       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val
| loongson_spi->spcr);

> +       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG=
);

    val &=3D GENMASK(1, 0);

> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val =
& ~3) |
> +                              loongson_spi->sper);

       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val
| loongson_spi->sper);

> +       loongson_spi->hz =3D hz;
> +}
> +
> +static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
> +                                 struct spi_device *spi)
> +{
> +       unsigned char val;
> +
> +       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);
> +       val &=3D ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
> +       if (spi->mode & SPI_CPOL)
> +               val |=3D LOONGSON_SPI_SPCR_CPOL;
> +       if (spi->mode & SPI_CPHA)
> +               val |=3D LOONGSON_SPI_SPCR_CPHA;
> +
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
> +       loongson_spi->mode |=3D spi->mode;
> +}
> +
> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> +                               struct spi_device *spi, struct spi_transf=
er *t)
> +{
> +       if (t && loongson_spi->hz !=3D t->speed_hz)
> +               loongson_spi_set_clk(loongson_spi, t->speed_hz);
> +
> +       if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> +               loongson_spi_set_mode(loongson_spi, spi);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_setup(struct spi_device *spi)
> +{
> +       struct loongson_spi *loongson_spi;
> +
> +       loongson_spi =3D spi_controller_get_devdata(spi->controller);
> +       if (spi->bits_per_word % 8)
> +               return -EINVAL;
> +
> +       if (spi_get_chipselect(spi, 0) >=3D spi->controller->num_chipsele=
ct)
> +               return -EINVAL;
> +
> +       loongson_spi->hz =3D 0;
> +       loongson_spi_set_cs(spi, 1);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8=
 **tx_buf,
> +                                       u8 **rx_buf, unsigned int num)
> +{
> +       int ret;
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +
> +       if (tx_buf && *tx_buf)
> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G, *((*tx_buf)++));
> +       else
> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G, 0);

+ Blank line

> +       ret =3D readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR=
_REG, loongson_spi->spsr,
> +                       (loongson_spi->spsr & 0x1) !=3D LOONGSON_SPI_SPSR=
_RFEMPTY, 1, MSEC_PER_SEC);

                       (loongson_spi->spsr &
LOONGSON_SPI_SPSR_RFEMPTY) !=3D LOONGSON_SPI_SPSR_RFEMPTY,
                       1, MSEC_PER_SEC);

> +       if (rx_buf && *rx_buf)
> +               *(*rx_buf)++ =3D loongson_spi_read_reg(loongson_spi, LOON=
GSON_SPI_FIFO_REG);
> +       else
> +               loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG=
);
> +
> +       return ret;
> +}
> +
> +static int loongson_spi_write_read(struct spi_device *spi, struct spi_tr=
ansfer *xfer)
> +{
> +       int ret;
> +       unsigned int count;
> +       const u8 *tx =3D xfer->tx_buf;
> +       u8 *rx =3D xfer->rx_buf;
> +
> +       count =3D xfer->len;

> +

Unneeded blank line.

> +       do {
> +               ret =3D loongson_spi_write_read_8bit(spi, &tx, &rx, count=
);
> +               if (ret)
> +                       break;
> +       } while (--count);
> +
> +       return ret;
> +}
> +
> +static int loongson_spi_prepare_message(struct spi_controller *ctlr, str=
uct spi_message *m)
> +{
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
ctlr);

> +       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_PARA_REG);

> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->para & ~1);

BIT(0) ?
LOONGSON_SPI_PARA_MEM_EN ?

> +       return 0;
> +}
> +
> +static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct=
 spi_device *spi,
> +                                    struct spi_transfer *xfer)
> +{
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
spi->controller);
> +
> +       loongson_spi_update_state(loongson_spi, spi, xfer);
> +       if (xfer->len)
> +               return loongson_spi_write_read(spi, xfer);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_unprepare_message(struct spi_controller *ctrl, s=
truct spi_message *m)
> +{
> +       struct loongson_spi *loongson_spi =3D spi_controller_get_devdata(=
ctrl);
> +
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->para);
> +
> +       return 0;
> +}
> +
> +static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
> +{
> +       unsigned char val;
> +
> +       val =3D loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR=
_REG);
> +       val &=3D ~LOONGSON_SPI_SPCR_SPE;
> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, v=
al);
> +
> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
> +                              (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPS=
R_WCOL));
> +
> +       val =3D loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR=
_REG);
> +       val |=3D LOONGSON_SPI_SPCR_SPE;
> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, v=
al);
> +}
> +
> +int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
> +{
> +       struct spi_controller *controller;
> +       struct loongson_spi *spi;
> +       struct clk *clk;
> +
> +       controller =3D devm_spi_alloc_host(dev, sizeof(struct loongson_sp=
i));
> +       if (controller =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;

   ... =3D SPI_MODE_X_MASK | SPI_CS_HIGH;

> +       controller->setup =3D loongson_spi_setup;
> +       controller->prepare_message =3D loongson_spi_prepare_message;
> +       controller->transfer_one =3D loongson_spi_transfer_one;
> +       controller->unprepare_message =3D loongson_spi_unprepare_message;
> +       controller->set_cs =3D loongson_spi_set_cs;
> +       controller->num_chipselect =3D 4;
> +       device_set_node(&controller->dev, dev_fwnode(dev));
> +       dev_set_drvdata(dev, controller);
> +
> +       spi =3D spi_controller_get_devdata(controller);
> +       spi->base =3D regs;
> +       spi->controller =3D controller;
> +
> +       clk =3D devm_clk_get_optional(dev, NULL);
> +       if (IS_ERR(clk))
> +               return dev_err_probe(dev, PTR_ERR(clk), "unable to get cl=
ock\n");
> +
> +       spi->clk_rate =3D clk_get_rate(clk);
> +       loongson_spi_reginit(spi);
> +
> +       spi->mode =3D 0;
> +
> +       return devm_spi_register_controller(dev, controller);
> +}
> +EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, SPI_LOONGSON_CORE);
> +
> +static int __maybe_unused loongson_spi_suspend(struct device *dev)
> +{
> +       struct loongson_spi *loongson_spi;
> +       struct spi_controller *controller;
> +
> +       controller =3D dev_get_drvdata(dev);
> +       spi_controller_suspend(controller);
> +
> +       loongson_spi =3D spi_controller_get_devdata(controller);
> +
> +       loongson_spi->spcr =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SPCR_REG);
> +       loongson_spi->sper =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SPER_REG);
> +       loongson_spi->spsr =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SPSR_REG);
> +       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_PARA_REG);
> +       loongson_spi->sfcs =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_SFCS_REG);
> +       loongson_spi->timi =3D loongson_spi_read_reg(loongson_spi, LOONGS=
ON_SPI_TIMI_REG);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused loongson_spi_resume(struct device *dev)
> +{
> +       struct loongson_spi *loongson_spi;
> +       struct spi_controller *controller;
> +
> +       controller =3D dev_get_drvdata(dev);
> +       loongson_spi =3D spi_controller_get_devdata(controller);
> +
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loong=
son_spi->spcr);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loong=
son_spi->sper);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG, loong=
son_spi->spsr);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loong=
son_spi->para);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loong=
son_spi->sfcs);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loong=
son_spi->timi);
> +
> +       spi_controller_resume(controller);
> +
> +       return 0;
> +}
> +
> +const struct dev_pm_ops loongson_spi_dev_pm_ops =3D {
> +       .suspend =3D loongson_spi_suspend,
> +       .resume =3D loongson_spi_resume,
> +};
> +EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, SPI_LOONGSON_CORE);
> +
> +MODULE_DESCRIPTION("Loongson SPI core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pc=
i.c
> new file mode 100644
> index 000000000000..134cda0c13a5
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-pci.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// PCI interface driver for Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/pci.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_pci_register(struct pci_dev *pdev,
> +                       const struct pci_device_id *ent)
> +{
> +       int ret;
> +       void __iomem *reg_base;
> +       struct device *dev =3D &pdev->dev;
> +       int pci_bar =3D 0;
> +
> +       ret =3D pcim_enable_device(pdev);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "cannot enable pci device\=
n");
> +
> +       ret =3D pcim_iomap_regions(pdev, BIT(pci_bar), pci_name(pdev));
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to request and rem=
ap memory\n");
> +
> +       reg_base =3D pcim_iomap_table(pdev)[pci_bar];
> +
> +       ret =3D loongson_spi_init_controller(dev, reg_base);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to initialize cont=
roller\n");
> +
> +       return 0;
> +}
> +
> +static struct pci_device_id loongson_spi_devices[] =3D {
> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a1b) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(pci, loongson_spi_devices);
> +
> +static struct pci_driver loongson_spi_pci_driver =3D {
> +       .name       =3D "loongson-spi-pci",
> +       .id_table   =3D loongson_spi_devices,
> +       .probe      =3D loongson_spi_pci_register,
> +       .driver =3D {
> +               .bus =3D &pci_bus_type,
> +               .pm =3D &loongson_spi_dev_pm_ops,
> +       },
> +};
> +module_pci_driver(loongson_spi_pci_driver);
> +
> +MODULE_DESCRIPTION("Loongson spi pci driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-p=
lat.c
> new file mode 100644
> index 000000000000..c066e5f5891e
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-plat.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Platform driver for Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_platform_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       void __iomem *reg_base;
> +       struct device *dev =3D &pdev->dev;
> +
> +       reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       ret =3D loongson_spi_init_controller(dev, reg_base);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to initialize cont=
roller\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id loongson_spi_id_table[] =3D {
> +       { .compatible =3D "loongson,ls2k1000-spi" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
> +
> +static struct platform_driver loongson_spi_plat_driver =3D {
> +       .probe =3D loongson_spi_platform_probe,
> +       .driver =3D {
> +               .name   =3D "loongson-spi",
> +               .bus =3D &platform_bus_type,
> +               .pm =3D &loongson_spi_dev_pm_ops,
> +               .of_match_table =3D loongson_spi_id_table,
> +       },
> +};
> +module_platform_driver(loongson_spi_plat_driver);
> +
> +MODULE_DESCRIPTION("Loongson spi platform driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> new file mode 100644
> index 000000000000..35f95b161842
> --- /dev/null
> +++ b/drivers/spi/spi-loongson.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Header File for Loongson SPI Driver. */
> +/* Copyright (C) 2023 Loongson Technology Corporation Limited */
> +
> +#ifndef __LINUX_SPI_LOONGSON_H
> +#define __LINUX_SPI_LOONGSON_H
> +
> +#include <linux/bits.h>
> +#include <linux/pm.h>
> +#include <linux/types.h>
> +
> +#define        LOONGSON_SPI_SPCR_REG   0x00
> +#define        LOONGSON_SPI_SPSR_REG   0x01
> +#define        LOONGSON_SPI_FIFO_REG   0x02
> +#define        LOONGSON_SPI_SPER_REG   0x03
> +#define        LOONGSON_SPI_PARA_REG   0x04
> +#define        LOONGSON_SPI_SFCS_REG   0x05
> +#define        LOONGSON_SPI_TIMI_REG   0x06
> +
> +/* Bits definition for Loongson SPI register */
> +#define        LOONGSON_SPI_PARA_MEM_EN        BIT(0)
> +#define        LOONGSON_SPI_SPCR_CPHA  BIT(2)
> +#define        LOONGSON_SPI_SPCR_CPOL  BIT(3)
> +#define        LOONGSON_SPI_SPCR_SPE   BIT(6)
> +#define        LOONGSON_SPI_SPSR_RFEMPTY       BIT(0)
> +#define        LOONGSON_SPI_SPSR_WCOL  BIT(6)
> +#define        LOONGSON_SPI_SPSR_SPIF  BIT(7)
> +
> +struct device;
> +struct spi_controller;
> +
> +struct loongson_spi {
> +       struct  spi_controller  *controller;
> +       void __iomem            *base;
> +       int                     cs_active;
> +       unsigned int            hz;
> +       unsigned char           spcr;
> +       unsigned char           sper;
> +       unsigned char           spsr;
> +       unsigned char           para;
> +       unsigned char           sfcs;
> +       unsigned char           timi;
> +       unsigned int            mode;
> +       u64                     clk_rate;
> +};
> +
> +int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
> +#endif /* __LINUX_SPI_LOONGSON_H */
> --
> 2.20.1
>


--=20
With Best Regards,
Andy Shevchenko
