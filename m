Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA5677E25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjAWOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjAWOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:33:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF31026C;
        Mon, 23 Jan 2023 06:33:26 -0800 (PST)
Received: from mercury (dyndsl-091-096-062-081.ewe-ip-backbone.de [91.96.62.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F4FF6602C0F;
        Mon, 23 Jan 2023 14:33:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674484404;
        bh=meM8S77AOAQO4olML6dCCPK+Kb/Ze1pRXnZNkhagrAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vcj64ubTogcFaJtD72Itqv9MmLc0+aIDQ6gVK35Utxl7hQjoqVw0dAYCsTUAeaOmK
         UnnPCk1lIvvKIra9sS1JCBCfmh9nkzDteP4AYiz3Z22DSca0K4s4pfe5mBi2k5nqXm
         I438JOpF1EYTdL7I6PDS9xvkFumnBtlfNcT/XWAIQmkdeMHRhgjJzND2nDUcMsYxSJ
         Kw5c9PrDPaIl1oQSPqS2zJ8148EPyBR5LM00AJUCIelIS+f4PCvR5LlKOHx72Xfk3I
         uwHewBhCGkWL/sSq1BZAyoT3pWYfHYWcYYzhh4IQn+XPp0Rcq00RmbZ6EDJVc7MNVT
         qIWzAnZv6rr7A==
Received: by mercury (Postfix, from userid 1000)
        id F009F10607D5; Mon, 23 Jan 2023 15:33:21 +0100 (CET)
Date:   Mon, 23 Jan 2023 15:33:21 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 07/10] mfd: rk8xx: add rk806 support
Message-ID: <20230123143321.lsddiol6bo2agfbk@mercury.elektranox.org>
References: <20230109172723.60304-1-sebastian.reichel@collabora.com>
 <20230109172723.60304-8-sebastian.reichel@collabora.com>
 <Y8rIadiDIEdXuM0Y@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5k5qizeblejwinc"
Content-Disposition: inline
In-Reply-To: <Y8rIadiDIEdXuM0Y@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5k5qizeblejwinc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 20, 2023 at 04:59:21PM +0000, Lee Jones wrote:
> On Mon, 09 Jan 2023, Sebastian Reichel wrote:
>=20
> > Add support for SPI connected rk806, which is used by the RK3588
> > evaluation boards. The PMIC is advertised to support I2C and SPI,
> > but the evaluation boards all use SPI. Thus only SPI support is
> > added here.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/mfd/Kconfig       |  14 ++
> >  drivers/mfd/Makefile      |   1 +
> >  drivers/mfd/rk8xx-core.c  |  67 ++++++-
> >  drivers/mfd/rk8xx-spi.c   | 122 ++++++++++++
> >  include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 611 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/mfd/rk8xx-spi.c
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 692e38283bda..13582ea5cb44 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1222,6 +1222,20 @@ config MFD_RK8XX_I2C
> >  	  through I2C interface. The device supports multiple sub-devices
> >  	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
> > =20
> > +config MFD_RK8XX_SPI
> > +	tristate "Rockchip RK806 Power Management Chip"
> > +	depends on SPI && OF
> > +	select MFD_CORE
> > +	select REGMAP_SPI
> > +	select REGMAP_IRQ
> > +	select MFD_RK8XX
> > +	help
> > +	  If you say yes here you get support for the RK806 Power Management
> > +	  chip.
> > +	  This driver provides common support for accessing the device
> > +	  through an SPI interface. The device supports multiple sub-devices
> > +	  including interrupts, LDO & DCDC regulators, and power on-key.
> > +
> >  config MFD_RN5T618
> >  	tristate "Ricoh RN5T567/618 PMIC"
> >  	depends on I2C
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index f65ef1bd0810..a88f27cd837b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -222,6 +222,7 @@ obj-$(CONFIG_MFD_NTXEC)		+=3D ntxec.o
> >  obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
> >  obj-$(CONFIG_MFD_RK8XX)		+=3D rk8xx-core.o
> >  obj-$(CONFIG_MFD_RK8XX_I2C)	+=3D rk8xx-i2c.o
> > +obj-$(CONFIG_MFD_RK8XX_SPI)	+=3D rk8xx-spi.o
> >  obj-$(CONFIG_MFD_RN5T618)	+=3D rn5t618.o
> >  obj-$(CONFIG_MFD_SEC_CORE)	+=3D sec-core.o sec-irq.o
> >  obj-$(CONFIG_MFD_SYSCON)	+=3D syscon.o
> > diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> > index c52f5fa1a4da..289f4c1f30c2 100644
> > --- a/drivers/mfd/rk8xx-core.c
> > +++ b/drivers/mfd/rk8xx-core.c
> > @@ -37,6 +37,11 @@ static const struct resource rk805_key_resources[] =
=3D {
> >  	DEFINE_RES_IRQ(RK805_IRQ_PWRON_FALL),
> >  };
> > =20
> > +static struct resource rk806_pwrkey_resources[] =3D {
> > +	DEFINE_RES_IRQ(RK806_IRQ_PWRON_FALL),
> > +	DEFINE_RES_IRQ(RK806_IRQ_PWRON_RISE),
> > +};
> > +
> >  static const struct resource rk817_pwrkey_resources[] =3D {
> >  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
> >  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
> > @@ -64,6 +69,16 @@ static const struct mfd_cell rk805s[] =3D {
> >  	},
> >  };
> > =20
> > +static const struct mfd_cell rk806s[] =3D {
> > +	{ .name =3D "rk805-pinctrl", },
> > +	{ .name =3D "rk808-regulator", },
> > +	{
> > +		.name =3D "rk805-pwrkey",
> > +		.num_resources =3D ARRAY_SIZE(rk806_pwrkey_resources),
> > +		.resources =3D &rk806_pwrkey_resources[0],
>=20
> My OCD-sense is tingling.
>=20
> Could you please add the resources *before* the num_resources please?
>=20
> Also: '.resources =3D rk806_pwrkey_resources' is fine

Ack.

>=20
> > +	},
> > +};
> > +
> >  static const struct mfd_cell rk808s[] =3D {
> >  	{ .name =3D "rk808-clkout", .id =3D PLATFORM_DEVID_NONE, },
> >  	{ .name =3D "rk808-regulator", .id =3D PLATFORM_DEVID_NONE, },
> > @@ -122,6 +137,12 @@ static const struct rk808_reg_data rk805_pre_init_=
reg[] =3D {
> >  	{RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
> >  };
> > =20
> > +static const struct rk808_reg_data rk806_pre_init_reg[] =3D {
> > +	{ RK806_GPIO_INT_CONFIG, RK806_INT_POL_MSK, RK806_INT_POL_L },
> > +	{ RK806_SYS_CFG3, RK806_SLAVE_RESTART_FUN_MSK, RK806_SLAVE_RESTART_FU=
N_EN },
> > +	{ RK806_SYS_OPTION, RK806_SYS_ENB2_2M_MSK, RK806_SYS_ENB2_2M_EN },
> > +};
> > +
> >  static const struct rk808_reg_data rk808_pre_init_reg[] =3D {
> >  	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
> >  	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
> > @@ -272,6 +293,27 @@ static const struct regmap_irq rk805_irqs[] =3D {
> >  	},
> >  };
> > =20
> > +static const struct regmap_irq rk806_irqs[] =3D {
> > +	/* INT_STS0 IRQs */
> > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_FALL, 0, RK806_INT_STS_PWRON_FALL),
> > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_RISE, 0, RK806_INT_STS_PWRON_RISE),
> > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON, 0, RK806_INT_STS_PWRON),
> > +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_LP, 0, RK806_INT_STS_PWRON_LP),
> > +	REGMAP_IRQ_REG(RK806_IRQ_HOTDIE, 0, RK806_INT_STS_HOTDIE),
> > +	REGMAP_IRQ_REG(RK806_IRQ_VDC_RISE, 0, RK806_INT_STS_VDC_RISE),
> > +	REGMAP_IRQ_REG(RK806_IRQ_VDC_FALL, 0, RK806_INT_STS_VDC_FALL),
> > +	REGMAP_IRQ_REG(RK806_IRQ_VB_LO, 0, RK806_INT_STS_VB_LO),
> > +	/* INT_STS1 IRQs */
> > +	REGMAP_IRQ_REG(RK806_IRQ_REV0, 1, RK806_INT_STS_REV0),
> > +	REGMAP_IRQ_REG(RK806_IRQ_REV1, 1, RK806_INT_STS_REV1),
> > +	REGMAP_IRQ_REG(RK806_IRQ_REV2, 1, RK806_INT_STS_REV2),
> > +	REGMAP_IRQ_REG(RK806_IRQ_CRC_ERROR, 1, RK806_INT_STS_CRC_ERROR),
> > +	REGMAP_IRQ_REG(RK806_IRQ_SLP3_GPIO, 1, RK806_INT_STS_SLP3_GPIO),
> > +	REGMAP_IRQ_REG(RK806_IRQ_SLP2_GPIO, 1, RK806_INT_STS_SLP2_GPIO),
> > +	REGMAP_IRQ_REG(RK806_IRQ_SLP1_GPIO, 1, RK806_INT_STS_SLP1_GPIO),
> > +	REGMAP_IRQ_REG(RK806_IRQ_WDT, 1, RK806_INT_STS_WDT),
> > +};
> > +
> >  static const struct regmap_irq rk808_irqs[] =3D {
> >  	/* INT_STS */
> >  	[RK808_IRQ_VOUT_LO] =3D {
> > @@ -422,6 +464,18 @@ static struct regmap_irq_chip rk805_irq_chip =3D {
> >  	.init_ack_masked =3D true,
> >  };
> > =20
> > +static struct regmap_irq_chip rk806_irq_chip =3D {
> > +	.name =3D "rk806",
> > +	.irqs =3D rk806_irqs,
> > +	.num_irqs =3D ARRAY_SIZE(rk806_irqs),
> > +	.num_regs =3D 2,
> > +	.irq_reg_stride =3D 2,
> > +	.mask_base =3D RK806_INT_MSK0,
> > +	.status_base =3D RK806_INT_STS0,
> > +	.ack_base =3D RK806_INT_STS0,
> > +	.init_ack_masked =3D true,
> > +};
> > +
> >  static const struct regmap_irq_chip rk808_irq_chip =3D {
> >  	.name =3D "rk808",
> >  	.irqs =3D rk808_irqs,
> > @@ -548,6 +602,7 @@ int rk8xx_probe(struct device *dev, int variant, un=
signed int irq, struct regmap
> >  	struct rk808 *rk808;
> >  	const struct rk808_reg_data *pre_init_reg;
> >  	const struct mfd_cell *cells;
> > +	bool dual_support =3D false;
> >  	int nr_pre_init_regs;
> >  	int nr_cells;
> >  	int ret;
> > @@ -569,6 +624,14 @@ int rk8xx_probe(struct device *dev, int variant, u=
nsigned int irq, struct regmap
> >  		cells =3D rk805s;
> >  		nr_cells =3D ARRAY_SIZE(rk805s);
> >  		break;
> > +	case RK806_ID:
> > +		rk808->regmap_irq_chip =3D &rk806_irq_chip;
> > +		pre_init_reg =3D rk806_pre_init_reg;
> > +		nr_pre_init_regs =3D ARRAY_SIZE(rk806_pre_init_reg);
> > +		cells =3D rk806s;
> > +		nr_cells =3D ARRAY_SIZE(rk806s);
> > +		dual_support =3D true;
> > +		break;
> >  	case RK808_ID:
> >  		rk808->regmap_irq_chip =3D &rk808_irq_chip;
> >  		pre_init_reg =3D rk808_pre_init_reg;
> > @@ -602,7 +665,7 @@ int rk8xx_probe(struct device *dev, int variant, un=
signed int irq, struct regmap
> >  		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IR=
Q\n");
> > =20
> >  	ret =3D devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
> > -				       IRQF_ONESHOT, -1,
> > +				       IRQF_ONESHOT | (dual_support ? IRQF_SHARED : 0), -1,
>=20
> Why not 'dual_support =3D IRQF_SHARED', then | it regardless?

Ack

>=20
> >  				       rk808->regmap_irq_chip, &rk808->irq_data);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
> > @@ -617,7 +680,7 @@ int rk8xx_probe(struct device *dev, int variant, un=
signed int irq, struct regmap
> >  					     pre_init_reg[i].addr);
> >  	}
> > =20
> > -	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > +	ret =3D devm_mfd_add_devices(dev, dual_support ? PLATFORM_DEVID_AUTO =
: PLATFORM_DEVID_NONE,
>=20
> Any reason why you can't use AUTO all the time?

That would change device names (and thus sysfs paths) for already
supported devices. DEVID_AUTO appends a ".<number>" suffix compared
to DEVID_NONE.

> >  			      cells, nr_cells, NULL, 0,
> >  			      regmap_irq_get_domain(rk808->irq_data));
> >  	if (ret)
> > diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
> > new file mode 100644
> > index 000000000000..3fbcaaaa453a
> > --- /dev/null
> > +++ b/drivers/mfd/rk8xx-spi.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Rockchip RK806 Core (SPI) driver
> > + *
> > + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> > + * Copyright (c) 2023 Collabora Ltd.
> > + *
> > + * Author: Xu Shengfei <xsf@rock-chips.com>
> > + * Author: Sebastian Reichel <sebastian.reichel@collabora.com>
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/rk808.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define RK806_CMD		0
> > +#define RK806_REG_ADDR_L	1
> > +#define RK806_REG_ADDR_H	2
> > +
> > +static const struct regmap_range rk806_volatile_ranges[] =3D {
> > +	regmap_reg_range(RK806_POWER_EN0, RK806_POWER_EN5),
> > +	regmap_reg_range(RK806_DVS_START_CTRL, RK806_INT_MSK1),
> > +};
> > +
> > +static const struct regmap_access_table rk806_volatile_table =3D {
> > +	.yes_ranges =3D rk806_volatile_ranges,
> > +	.n_yes_ranges =3D ARRAY_SIZE(rk806_volatile_ranges),
> > +};
> > +
> > +static const struct regmap_config rk806_regmap_config_spi =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.cache_type =3D REGCACHE_RBTREE,
> > +	.volatile_table =3D &rk806_volatile_table,
> > +};
> > +
> > +static int rk806_spi_bus_write(void *context, const void *vdata, size_=
t count)
> > +{
> > +	struct device *dev =3D context;
> > +	struct spi_device *spi =3D to_spi_device(dev);
> > +	const char *data =3D vdata;
> > +	char buffer[3] =3D { 0 };
> > +	struct spi_transfer xfer[2] =3D { 0 };
> > +
> > +	buffer[RK806_CMD]	 =3D RK806_CMD_WRITE | (count - 2);
>=20
> Comment or define please.
>=20
> > +	buffer[RK806_REG_ADDR_L] =3D data[0];
>=20
> As above.
>=20
> > +	buffer[RK806_REG_ADDR_H] =3D RK806_REG_H;
> > +
> > +	xfer[0].tx_buf =3D buffer;
> > +	xfer[0].len =3D sizeof(buffer);
> > +	xfer[1].tx_buf =3D data+1;
>=20
> And here.
>=20
> > +	xfer[1].len =3D count-1;
>=20
> Here too.

I don't follow. What part do you need comments/defines for? I did
add the RK806_CMD/RK806_REG_ADDR_L/RK806_REG_ADDR_H when you asked
for defines last times, so obviously you meant something else :)

> Nit: spaces around the '+' and '-' please.

Ack.

> > +	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
> > +}
> > +
> > +static int rk806_spi_bus_read(void *context, const void *vreg, size_t =
reg_size,
> > +			      void *val, size_t val_size)
> > +{
> > +	struct device *dev =3D context;
> > +	struct spi_device *spi =3D to_spi_device(dev);
> > +	const char *reg =3D vreg;
> > +	char txbuf[3] =3D { 0 };
> > +
> > +	if (reg_size !=3D sizeof(char) || val_size < 1)
> > +		return -EINVAL;
> > +
> > +	txbuf[RK806_CMD]	=3D RK806_CMD_READ | (val_size - 1);
> > +	txbuf[RK806_REG_ADDR_L]	=3D *reg;
> > +	txbuf[RK806_REG_ADDR_H]	=3D RK806_REG_H;
>=20
> What's this for?  Isn't it already 0?

Yes. I guess I could remove the '=3D { 0 }' init considering I
explicitly do a full init of the buffer. OTOH the compiler will
optimize this anyways.

-- Sebastian

> > +	return spi_write_then_read(spi, txbuf, sizeof(txbuf), val, val_size);
> > +}
> > +
> > +static const struct regmap_bus rk806_regmap_bus_spi =3D {
> > +	.write =3D rk806_spi_bus_write,
> > +	.read =3D rk806_spi_bus_read,
> > +	.reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> > +	.val_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> > +};
> > +
> > +static int rk8xx_spi_probe(struct spi_device *spi)
> > +{
> > +	struct regmap *regmap;
> > +
> > +	regmap =3D devm_regmap_init(&spi->dev, &rk806_regmap_bus_spi,
> > +				  &spi->dev, &rk806_regmap_config_spi);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> > +				     "Failed to initialize register map\n");
> > +
> > +	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
> > +}
> > +
> > +static const struct of_device_id rk8xx_spi_of_match[] =3D {
> > +	{ .compatible =3D "rockchip,rk806", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rk8xx_spi_of_match);
> > +
> > +static const struct spi_device_id rk8xx_spi_id_table[] =3D {
> > +	{ "rk806", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, rk8xx_spi_id_table);
> > +
> > +static struct spi_driver rk8xx_spi_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "rk8xx-spi",
> > +		.of_match_table =3D rk8xx_spi_of_match,
> > +	},
> > +	.probe		=3D rk8xx_spi_probe,
> > +	.id_table	=3D rk8xx_spi_id_table,
> > +};
> > +module_spi_driver(rk8xx_spi_driver);
> > +
> > +MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
> > +MODULE_DESCRIPTION("RK8xx SPI PMIC driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--l5k5qizeblejwinc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPOmqIACgkQ2O7X88g7
+pqoKRAAgkEKxQ+fuKg6nbOc8qnznSvON/bjQ4+KPXlN/9cDMTnuaIDRyPLohaTw
kd6XyMs5qzEam2mCMDErowPgLYwBnrlDnqzY3T5a0DlkDguMInKQsfoB5mI25x6D
j1M/3JANI8ax2XEFPznTbsRRHNeIXxot8+WOUDwf1fG51BQ7a03TpkVhLSzCUcKj
V6jD3ndAu5nsFJuwwj3P5EMbFzySPW7AkD5DozZSvdFYPtyRqFEgo3A5n+ysQuO7
N7lqKwvxmNVvNErOaV20RwKjDozuR7R4bXmsv8b5OreiydDZVQ0/VC32o0ogBQ+8
cAKhC1ejUOevFpHDIryFFxT6Gj5JFFyNENZmbsj8B6j/hrCZt8pr1winhRqID+J7
V2PZfa5Yx8eDTpcS6M1ZWRSk4AS+Hzk93wqRK9Nlk/N75yIazDqMlJI9cS4UHYxU
DNzY2U9HQPx8PfTp4bNAqpSJuORRS8Lke8UgQY0J2KPAzBWTb6SsDZbtsBAdwJiB
/RYOY+DadWEU5QuRYMu5HltD43sz4hHRi4BC5YWqVmkAazhrUsWIEZoVBpK+XFxb
eKfKT5xRxqjPiafjNK47A8oAj05PnQab3/DIVxu4QZmu1CkkCeq/46ahM+VrXRJy
oyQt2Ic3+XvllZ7M3gMDbv1fWs7pXhhmGvufEO7WxYTvTMdh4aA=
=Ry4l
-----END PGP SIGNATURE-----

--l5k5qizeblejwinc--
