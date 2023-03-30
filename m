Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2926D04BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjC3Mbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3Mbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295714C35;
        Thu, 30 Mar 2023 05:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6E26204E;
        Thu, 30 Mar 2023 12:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B505BC433EF;
        Thu, 30 Mar 2023 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680179502;
        bh=g96JjbevmpD1DolYg6cARgc+/oAyG6sjJB1Lf0Sfyf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJjuoQUda0FD4DE7HOrQPzv6HcUrOtthFJlM/Foo8q1Hd97rwFKTc89otQ1oBL+7b
         p6CCxLVjlOoN0gMDNIPHq5BIQNQxR6JCiBPi/w/zYKWFVIcQGWivnunHH5qIJYcPfh
         8+E7kH435Bll4mKvh/Adj1AUEUixylhjAfbo6v8H/aCtJhI+MhDZPQ1sqIAApDB5Zd
         cMZnSQkEAwvs56jMgXhBM1dCwRTK/vX6zdmahnHFOECCo1kWItKTvMOI0tGLP8FTs2
         3NHfADNslN0VYVFkgGHhYOm6+Re66I375tOy5XXMYlIk1rQwgjUv7ueJUbHCYkOv0u
         gDP5V/o2ZPsmg==
Date:   Thu, 30 Mar 2023 13:31:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Message-ID: <20230330123136.GF434339@google.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-9-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322055628.4441-9-Zeynep.Arslanbenzer@analog.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Zeynep Arslanbenzer wrote:

> MFD driver for MAX77643/MAX77654/MAX77658/MAX77659 to enable its sub

Please drop all references to 'MFD'.

What are these devices, really?  I suspect they are PMICs?

> devices.
>
> The MAX77643 is a multi-function devices. It includes
> regulator.
>
> The MAX77654 is a multi-function devices. It includes
> regulator and charger.
>
> The MAX77658 is a multi-function devices. It includes
> regulator, charger and battery.
>
> The MAX77659 is a multi-function devices. It includes
> regulator and charger.
>
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/mfd/Kconfig          |  15 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77658.c       | 448 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77658.h |  88 +++++++
>  4 files changed, 552 insertions(+)
>  create mode 100644 drivers/mfd/max77658.c
>  create mode 100644 include/linux/mfd/max77658.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b93856de432..7b4be7fb8662 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -821,6 +821,21 @@ config MFD_MAX77650
>  	  the following functionalities of the device: GPIO, regulator,
>  	  charger, LED, onkey.
>
> +config MFD_MAX77658
> +	tristate "Analog Devices MAX77643/MAX77654/MAX77658/MAX77659 PMIC Support"
> +	depends on I2C
> +	depends on OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Say Y here to add support for Analog Devices
> +	  MAX77643/MAX77654/MAX77658/MAX77659 Power Management IC.

"MAX776xx series"?

> +	  This is the core multifunction

Just "core driver" is fine.

Odd place to line wrap?

> +	  driver for interacting with the device. Additional drivers can be

"can be"?  It's probably pretty useless if you don't, no?

> +	  enabled in order to use the following functionalities of the device:
> +	  regulator, charger.

"... in order to use the regular and charger functionality of the device".

>  config MFD_MAX77686
>  	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7ed3ef4a698c..f52aff45878f 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -163,6 +163,7 @@ obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>  obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
>  obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
> +obj-$(CONFIG_MFD_MAX77658)	+= max77658.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
>  obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
> diff --git a/drivers/mfd/max77658.c b/drivers/mfd/max77658.c
> new file mode 100644
> index 000000000000..a1c6db48eb08
> --- /dev/null
> +++ b/drivers/mfd/max77658.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Analog Devices, Inc.
> + * ADI driver for the MAX77643/MAX77654/MAX77658/MAX77659
> + */

No need to list every device.

"MAX776xx series"?

> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77658.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#define I2C_ADDR_FUEL_GAUGE (0x6C >> 1)
> +
> +static const struct regmap_config max77658_regmap_config = {
> +	.reg_bits   = 8,
> +	.val_bits   = 8,
> +};
> +
> +static const struct regmap_config max77658_regmap_config_fg = {
> +	.reg_bits   = 8,
> +	.val_bits   = 16,
> +	.cache_type = REGCACHE_NONE,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static const struct regmap_irq max77643_glbl0_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_EN_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_EN_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL1_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL2_R, },
> +	{ .mask = MAX77643_BIT_INT_GLBL0_DOD0_R, },
> +};
> +
> +static const struct regmap_irq_chip max77643_glbl0_irq_chip = {
> +	.name           = "max77643_glbl0",
> +	.status_base    = MAX77658_REG_INT_GLBL0,
> +	.mask_base      = MAX77643_REG_INTM_GLBL0,
> +	.num_regs       = 1,
> +	.irqs           = max77643_glbl0_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77643_glbl0_irqs),
> +};
> +
> +static const struct regmap_irq max77658_glbl0_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_EN_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_EN_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL1_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL2_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_DOD1_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_DOD0_R, },
> +};
> +
> +static const struct regmap_irq_chip max77654_glbl0_irq_chip = {
> +	.name           = "max77654_glbl0",
> +	.status_base    = MAX77658_REG_INT_GLBL0,
> +	.mask_base      = MAX77654_REG_INTM_GLBL0,
> +	.num_regs       = 1,
> +	.irqs           = max77658_glbl0_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77658_glbl0_irqs),
> +};
> +
> +static const struct regmap_irq_chip max77658_glbl0_irq_chip = {
> +	.name           = "max77658_glbl0",
> +	.status_base    = MAX77658_REG_INT_GLBL0,
> +	.mask_base      = MAX77658_REG_INTM_GLBL0,
> +	.num_regs       = 1,
> +	.irqs           = max77658_glbl0_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77658_glbl0_irqs),
> +};
> +
> +static const struct regmap_irq max77659_glbl0_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_EN_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_EN_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL1_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL2_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL0_DOD0_R, },
> +};
> +
> +static const struct regmap_irq_chip max77659_glbl0_irq_chip = {
> +	.name           = "max77659_glbl0",
> +	.status_base    = MAX77658_REG_INT_GLBL0,
> +	.mask_base      = MAX77654_REG_INTM_GLBL0,
> +	.num_regs       = 1,
> +	.irqs           = max77659_glbl0_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77659_glbl0_irqs),
> +};
> +
> +static const struct regmap_irq max77643_glbl1_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_SBB0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_SBB1_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_SBB2_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
> +};
> +
> +static const struct regmap_irq_chip max77643_glbl1_irq_chip = {
> +	.name           = "max77643_glbl1",
> +	.status_base    = MAX77658_REG_INT_GLBL1,
> +	.mask_base      = MAX77643_REG_INTM_GLBL1,
> +	.num_regs       = 1,
> +	.irqs           = max77643_glbl1_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77643_glbl1_irqs),
> +};
> +
> +static const struct regmap_irq max77654_glbl1_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
> +	{ .mask = MAX77654_BIT_INT_GLBL1_GPI2_F, },
> +	{ .mask = MAX77654_BIT_INT_GLBL1_GPI2_R, },
> +	{ .mask = MAX77654_BIT_INT_GLBL1_SBB_TO, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_LDO1_F, },
> +};
> +
> +static const struct regmap_irq_chip max77654_glbl1_irq_chip = {
> +	.name           = "max77654_glbl1",
> +	.status_base    = MAX77658_REG_INT_GLBL1,
> +	.mask_base      = MAX77654_REG_INTM_GLBL1,
> +	.num_regs       = 1,
> +	.irqs           = max77654_glbl1_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77654_glbl1_irqs),
> +};
> +
> +static const struct regmap_irq max77658_glbl1_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_SBB0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_SBB1_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_SBB2_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_LDO1_F, },
> +};
> +
> +static const struct regmap_irq_chip max77658_glbl1_irq_chip = {
> +	.name           = "max77658_glbl1",
> +	.status_base    = MAX77658_REG_INT_GLBL1,
> +	.mask_base      = MAX77658_REG_INTM_GLBL1,
> +	.num_regs       = 1,
> +	.irqs           = max77658_glbl1_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77658_glbl1_irqs),
> +};
> +
> +static const struct regmap_irq max77659_glbl1_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
> +	{ .mask = MAX77659_BIT_INT_GLBL1_SBB_TO, },
> +	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
> +};
> +
> +static const struct regmap_irq_chip max77659_glbl1_irq_chip = {
> +	.name           = "max77659_glbl1",
> +	.status_base    = MAX77658_REG_INT_GLBL1,
> +	.mask_base      = MAX77658_REG_INTM_GLBL1,
> +	.num_regs       = 1,
> +	.irqs           = max77659_glbl1_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77659_glbl1_irqs),
> +};
> +
> +static const struct regmap_irq max77658_chg_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_THM, },
> +	{ .mask = MAX77658_BIT_INT_CHG, },
> +	{ .mask = MAX77658_BIT_INT_CHGIN, },
> +	{ .mask = MAX77658_BIT_INT_TJ_REG, },
> +	{ .mask = MAX77658_BIT_INT_CHGIN_CTRL, },
> +	{ .mask = MAX77658_BIT_INT_SYS_CTRL, },
> +	{ .mask = MAX77658_BIT_INT_SYS_CNFG, },
> +};
> +
> +static const struct regmap_irq_chip max77654_chg_irq_chip = {
> +	.name           = "max77654_chg",
> +	.status_base    = MAX77658_REG_INT_CHG,
> +	.mask_base      = MAX77658_REG_INTM_CHG,
> +	.num_regs       = 1,
> +	.irqs           = max77658_chg_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77658_chg_irqs),
> +};
> +
> +static const struct regmap_irq_chip max77658_chg_irq_chip = {
> +	.name           = "max77658_chg",
> +	.status_base    = MAX77658_REG_INT_CHG,
> +	.mask_base      = MAX77658_REG_INTM_CHG,
> +	.num_regs       = 1,
> +	.irqs           = max77658_chg_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77658_chg_irqs),
> +};
> +
> +static const struct regmap_irq max77659_chg_irqs[] = {
> +	{ .mask = MAX77658_BIT_INT_THM, },
> +	{ .mask = MAX77658_BIT_INT_CHG, },
> +	{ .mask = MAX77658_BIT_INT_CHGIN, },
> +	{ .mask = MAX77658_BIT_INT_TJ_REG, },
> +	{ .mask = MAX776569_BIT_INT_SYS_CTRL, },
> +};
> +
> +static const struct regmap_irq_chip max77659_chg_irq_chip = {
> +	.name           = "max77659_chg",
> +	.status_base    = MAX77658_REG_INT_CHG,
> +	.mask_base      = MAX77658_REG_INTM_CHG,
> +	.num_regs       = 1,
> +	.irqs           = max77659_chg_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77659_chg_irqs),
> +};
> +
> +static const struct mfd_cell max77643_devs[] = {
> +	MFD_CELL_OF("max77643-regulator", NULL, NULL, 0, 0,
> +		    "adi,max77643-regulator"),
> +};
> +
> +static const struct mfd_cell max77654_devs[] = {
> +	MFD_CELL_OF("max77654-regulator", NULL, NULL, 0, 0,
> +		    "adi,max77654-regulator"),
> +	MFD_CELL_OF("max77654-charger", NULL, NULL, 0, 0,
> +		    "adi,max77654-charger"),
> +};
> +
> +static const struct mfd_cell max77658_devs[] = {
> +	MFD_CELL_OF("max77658-regulator", NULL, NULL, 0, 0,
> +		    "adi,max77658-regulator"),
> +	MFD_CELL_OF("max77658-charger", NULL, NULL, 0, 0,
> +		    "adi,max77658-charger"),
> +	MFD_CELL_OF("max77658-battery", NULL, NULL, 0, 0,
> +		    "adi,max77658-battery"),
> +};
> +
> +static const struct mfd_cell max77659_devs[] = {
> +	MFD_CELL_OF("max77659-regulator", NULL, NULL, 0, 0,
> +		    "adi,max77659-regulator"),
> +	MFD_CELL_OF("max77659-charger", NULL, NULL, 0, 0,
> +		    "adi,max77659-charger"),
> +};

You can unwrap all of these, you have 100-chars to play with.

> +static const struct chip_info chip[] = {
> +	[ID_MAX77643] = {
> +		.id = ID_MAX77643,
> +		.n_devs = ARRAY_SIZE(max77643_devs),
> +		.devs = max77643_devs,
> +	},
> +	[ID_MAX77654] = {
> +		.id = ID_MAX77654,
> +		.n_devs = ARRAY_SIZE(max77654_devs),
> +		.devs = max77654_devs,
> +	},
> +	[ID_MAX77658] = {
> +		.id = ID_MAX77658,
> +		.n_devs = ARRAY_SIZE(max77658_devs),
> +		.devs = max77658_devs,
> +	},
> +	[ID_MAX77659] = {
> +		.id = ID_MAX77659,
> +		.n_devs = ARRAY_SIZE(max77659_devs),
> +		.devs = max77659_devs,
> +	},
> +};
> +
> +static int max77658_pmic_irq_init(struct device *dev)
> +{
> +	const struct regmap_irq_chip *glbl0_chip, *glbl1_chip, *chg_chip;
> +	struct max77658_dev *max77658 = dev_get_drvdata(dev);
> +	int ret, i;
> +
> +	switch (max77658->chip->id) {
> +	case ID_MAX77643:
> +		glbl0_chip = &max77643_glbl0_irq_chip;
> +		glbl1_chip = &max77643_glbl1_irq_chip;
> +		break;
> +	case ID_MAX77654:
> +		glbl0_chip = &max77654_glbl0_irq_chip;
> +		glbl1_chip = &max77654_glbl1_irq_chip;
> +		chg_chip = &max77654_chg_irq_chip;
> +		break;
> +	case ID_MAX77658:
> +		glbl0_chip = &max77658_glbl0_irq_chip;
> +		glbl1_chip = &max77658_glbl1_irq_chip;
> +		chg_chip = &max77658_chg_irq_chip;
> +		break;
> +	case ID_MAX77659:
> +		glbl0_chip = &max77659_glbl0_irq_chip;
> +		glbl1_chip = &max77659_glbl1_irq_chip;
> +		chg_chip = &max77659_chg_irq_chip;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	for (i = 0; i < glbl0_chip->num_regs; i++) {
> +		ret = regmap_update_bits(max77658->regmap,
> +					 glbl0_chip->mask_base,
> +					 (1 << glbl0_chip->irqs[i].reg_offset),
> +					 1);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Unable to write Global0 Interrupt Masking register\n");
> +	}
> +
> +	for (i = 0; i < glbl1_chip->num_regs; i++) {
> +		ret = regmap_update_bits(max77658->regmap,
> +					 glbl1_chip->mask_base,
> +					 (1 << glbl1_chip->irqs[i].reg_offset),
> +					 1);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Unable to write Global1 Interrupt Masking register\n");
> +	}
> +
> +	if (max77658->chip->id != ID_MAX77643) {
> +		for (i = 0; i < chg_chip->num_regs; i++) {
> +			ret = regmap_update_bits(max77658->regmap,
> +						 chg_chip->mask_base,
> +						 (1 <<
> +						 chg_chip->irqs[i].reg_offset),
> +						 1);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Unable to write Charger Interrupt Masking register\n");
> +		}
> +
> +		ret = devm_regmap_add_irq_chip(dev, max77658->regmap,
> +					       max77658->irq,
> +					       IRQF_ONESHOT | IRQF_SHARED, 0,
> +					       chg_chip, &max77658->irqc_chg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to add charger IRQ chip\n");
> +	}
> +
> +	ret = devm_regmap_add_irq_chip(dev, max77658->regmap, max77658->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED, 0,
> +				       glbl0_chip, &max77658->irqc_glbl0);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add global0 IRQ chip\n");
> +
> +	return devm_regmap_add_irq_chip(dev, max77658->regmap, max77658->irq,
> +					IRQF_ONESHOT | IRQF_SHARED, 0,
> +					glbl1_chip, &max77658->irqc_glbl1);

This function is hectic.

What exactly are you doing here?

> +}
> +
> +static int max77658_pmic_setup(struct device *dev)
> +{
> +	struct max77658_dev *max77658 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = max77658_pmic_irq_init(max77658->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   max77658->chip->devs, max77658->chip->n_devs,
> +				   NULL, 0, NULL);
> +

These are usually placed in probe.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add sub-devices\n");
> +
> +	ret = device_init_wakeup(dev, true);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max77658_i2c_id[];

What on earth is this?  A struct forward declaration?

If you need this, just move the original code block to here.

> +static int max77658_i2c_probe(struct i2c_client *client)
> +{
> +	struct max77658_dev *max77658;
> +	struct i2c_client *fuel;
> +
> +	max77658 = devm_kzalloc(&client->dev, sizeof(*max77658), GFP_KERNEL);
> +	if (!max77658)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, max77658);
> +	max77658->dev = &client->dev;

How do you fetch back max77658?

Don't you need access to the device structs?

If so, you already have a reference, no?

> +	max77658->irq = client->irq;
> +
> +	if (max77658->dev->of_node)
> +		max77658->chip  = of_device_get_match_data(max77658->dev);
> +	else
> +		max77658->chip  = (struct chip_info *)

Cast from void * shouldn't be required.

> +					i2c_match_id(max77658_i2c_id,
> +						     client)->driver_data;

100-chars everywhere.

> +	if (!max77658->chip)
> +		return -EINVAL;
> +
> +	max77658->regmap = devm_regmap_init_i2c(client,
> +						&max77658_regmap_config);
> +	if (IS_ERR(max77658->regmap))
> +		return dev_err_probe(max77658->dev, PTR_ERR(max77658->regmap),
> +				     "Failed to allocate register map\n");

s/allocate/initialise/

"regmap" is fine.

> +	fuel = i2c_new_dummy_device(client->adapter, I2C_ADDR_FUEL_GAUGE);
> +	if (IS_ERR(fuel))
> +		return dev_err_probe(max77658->dev, PTR_ERR(fuel),
> +				     "failed add i2c device[0x%Xh]\n",

"Failed to create I2C device"

> +				      I2C_ADDR_FUEL_GAUGE);
> +
> +	i2c_set_clientdata(fuel, max77658);
> +
> +	max77658->regmap_fg = devm_regmap_init_i2c(fuel,
> +						   &max77658_regmap_config_fg);
> +	if (IS_ERR(max77658->regmap_fg))
> +		return dev_err_probe(max77658->dev,
> +				     PTR_ERR(max77658->regmap_fg),
> +				     "failed to initialize i2c device[0x%Xh]\n",

"Failed"

"I2C"

> +				     I2C_ADDR_FUEL_GAUGE);
> +
> +	return max77658_pmic_setup(max77658->dev);
> +}
> +
> +static const struct of_device_id max77658_of_id[] = {
> +	{ .compatible = "adi,max77643", .data = &chip[ID_MAX77643] },
> +	{ .compatible = "adi,max77654", .data = &chip[ID_MAX77654] },
> +	{ .compatible = "adi,max77658", .data = &chip[ID_MAX77658] },
> +	{ .compatible = "adi,max77659", .data = &chip[ID_MAX77659] },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max77658_of_id);
> +
> +static const struct i2c_device_id max77658_i2c_id[] = {
> +	{ "max77643", (kernel_ulong_t)&chip[ID_MAX77643] },
> +	{ "max77654", (kernel_ulong_t)&chip[ID_MAX77654] },
> +	{ "max77658", (kernel_ulong_t)&chip[ID_MAX77658] },
> +	{ "max77659", (kernel_ulong_t)&chip[ID_MAX77659] },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max77658_i2c_id);

Please don't pass MFD data through the DT platform initialisation API.

Pass the Chip ID and match in C-code.

> +static struct i2c_driver max77658_driver = {
> +	.driver = {
> +		.name = "max77658",
> +		.of_match_table = max77658_of_id,
> +	},
> +	.probe_new = max77658_i2c_probe,
> +	.id_table = max77658_i2c_id,
> +};
> +module_i2c_driver(max77658_driver);
> +
> +MODULE_DESCRIPTION("MAX77658 MFD Driver");
> +MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max77658.h b/include/linux/mfd/max77658.h
> new file mode 100644
> index 000000000000..471a8474513e
> --- /dev/null
> +++ b/include/linux/mfd/max77658.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __MAX77658_MFD_H__
> +#define __MAX77658_MFD_H__
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +
> +#define MAX77658_REG_INT_GLBL0	0x00
> +#define MAX77658_REG_INT_CHG	0x01
> +#define MAX77658_REG_INT_GLBL1	0x04
> +#define MAX77658_REG_INTM_CHG	0x07
> +#define MAX77658_REG_INTM_GLBL0	0x08
> +#define MAX77658_REG_INTM_GLBL1	0x09
> +
> +#define MAX77654_REG_INTM_GLBL1	0x08
> +#define MAX77654_REG_INTM_GLBL0	0x09
> +
> +#define MAX77643_REG_INT_GLBL1	0x01
> +#define MAX77643_REG_INTM_GLBL0	0x04
> +#define MAX77643_REG_INTM_GLBL1	0x05
> +
> +#define MAX77658_BIT_INT_GLBL0_GPIO0_F	BIT(0)
> +#define MAX77658_BIT_INT_GLBL0_GPIO0_R	BIT(1)
> +#define MAX77658_BIT_INT_GLBL0_EN_F	BIT(2)
> +#define MAX77658_BIT_INT_GLBL0_EN_R	BIT(3)
> +#define MAX77658_BIT_INT_GLBL0_TJAL1_R	BIT(4)
> +#define MAX77658_BIT_INT_GLBL0_TJAL2_R	BIT(5)
> +#define MAX77658_BIT_INT_GLBL0_DOD1_R	BIT(6)
> +#define MAX77658_BIT_INT_GLBL0_DOD0_R	BIT(7)
> +
> +#define MAX77643_BIT_INT_GLBL0_DOD0_R	BIT(6)
> +
> +#define MAX77658_BIT_INT_GLBL1_GPI1_F	BIT(0)
> +#define MAX77658_BIT_INT_GLBL1_GPI1_R	BIT(1)
> +#define MAX77658_BIT_INT_GLBL1_SBB0_F	BIT(2)
> +#define MAX77658_BIT_INT_GLBL1_SBB1_F	BIT(3)
> +#define MAX77658_BIT_INT_GLBL1_SBB2_F	BIT(4)
> +#define MAX77658_BIT_INT_GLBL1_LDO0_F	BIT(5)
> +#define MAX77658_BIT_INT_GLBL1_LDO1_F	BIT(6)
> +
> +#define MAX77659_BIT_INT_GLBL1_SBB_TO	BIT(4)
> +
> +#define MAX77654_BIT_INT_GLBL1_GPI2_F	BIT(2)
> +#define MAX77654_BIT_INT_GLBL1_GPI2_R	BIT(3)
> +#define MAX77654_BIT_INT_GLBL1_SBB_TO	BIT(4)
> +
> +#define MAX77658_BIT_INT_THM		BIT(0)
> +#define MAX77658_BIT_INT_CHG		BIT(1)
> +#define MAX77658_BIT_INT_CHGIN		BIT(2)
> +#define MAX77658_BIT_INT_TJ_REG		BIT(3)
> +#define MAX77658_BIT_INT_CHGIN_CTRL	BIT(4)
> +#define MAX77658_BIT_INT_SYS_CTRL	BIT(5)
> +#define MAX77658_BIT_INT_SYS_CNFG	BIT(6)
> +
> +#define MAX776569_BIT_INT_SYS_CTRL	BIT(4)
> +
> +enum max77658_ids {
> +	ID_MAX77643,
> +	ID_MAX77654,
> +	ID_MAX77658,
> +	ID_MAX77659
> +};
> +
> +struct chip_info {
> +	enum max77658_ids id;
> +	int n_devs;
> +	const struct mfd_cell *devs;
> +};
> +
> +struct device;
> +struct regmap;
> +struct regmap_irq_chip_data;
> +
> +struct max77658_dev {
> +	struct device *dev;
> +	const struct chip_info *chip;
> +
> +	int irq;
> +	struct regmap_irq_chip_data *irqc_glbl0;
> +	struct regmap_irq_chip_data *irqc_glbl1;
> +	struct regmap_irq_chip_data *irqc_chg;
> +
> +	struct regmap *regmap;
> +	struct regmap *regmap_fg;
> +};
> +
> +#endif /* __MAX77658_MFD_H__ */
> --
> 2.25.1
>

--
Lee Jones [李琼斯]
