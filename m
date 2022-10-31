Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302576138A2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiJaOE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJaOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:04:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9310573;
        Mon, 31 Oct 2022 07:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F864B817C2;
        Mon, 31 Oct 2022 14:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB9C433D6;
        Mon, 31 Oct 2022 14:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667225058;
        bh=WT/oM6yMv3E1f0+FE6QN2kC+ntZ+v8NTJw+qVfDbUnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcychxhkkcHBfy/LJKCP01W9g4E9lDNEwrWVJGUidFeVCNDxpqTv97LyHMQq3w5V0
         liq8R8Nvk1s1xeHjo+Eya/579axzTGJLk3EeHWg80wZUVbm0p6RcpOYmnRIS3ZH2HT
         nkNhTIosP+VKEDSOgJtG+tZEMUoPwYHebt3Z2ipF+jhyBkr0phzhLUqFJ5VXSUvH/y
         AtmvcsEpxmL9esO7sv5rAhwSXxtt3Ihg4ghmUpdjaqw2b0sHjm/8VQBaS+gD47w5dq
         yU59Xm9/uxrJZTp7vtxEhW62JXXYNy3HL5tF4KlpAbIlU8hCND33sw59He7M3DMtPG
         FXqNdcfEqnUOQ==
Date:   Mon, 31 Oct 2022 14:04:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
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
Subject: Re: [PATCHv4 09/13] mfd: rk8xx: add rk806 support
Message-ID: <Y1/V3GOIPoqMgBUO@google.com>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
 <20221020204251.108565-10-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221020204251.108565-10-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022, Sebastian Reichel wrote:

> Add support for SPI connected rk806, which is used by the RK3588
> evaluation boards. The PMIC is advertised to support I2C and SPI,
> but the evaluation boards all use SPI. Thus only SPI support is
> added here.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Change log?  What happened over the previous 4 iterations?

>  drivers/mfd/Kconfig       |  14 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rk8xx-core.c  |  67 ++++++-
>  drivers/mfd/rk8xx-spi.c   | 115 +++++++++++
>  include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 604 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mfd/rk8xx-spi.c

[...]

> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip RK806 Core (SPI) driver
> + *
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + *
> + * Author: Xu Shengfei <xsf@rock-chips.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rk808.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +static const struct regmap_range rk806_volatile_ranges[] = {
> +	regmap_reg_range(RK806_POWER_EN0, RK806_POWER_EN5),
> +	regmap_reg_range(RK806_DVS_START_CTRL, RK806_INT_MSK1),
> +};
> +
> +static const struct regmap_access_table rk806_volatile_table = {
> +	.yes_ranges = rk806_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rk806_volatile_ranges),
> +};
> +
> +static const struct regmap_config rk806_regmap_config_spi = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_table = &rk806_volatile_table,
> +};
> +
> +static int rk806_spi_bus_write(void *context, const void *vdata, size_t count)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	const char *data = vdata;
> +	char buffer[4] = { 0 };
> +
> +	/* implementation currently only supports single write */
> +	if (count != 2)
> +		return -EINVAL;

Is this a H/W limitation?

> +	buffer[0] = RK806_CMD_WRITE | (count - 2);
> +	buffer[1] = data[0]; /* register address */

You can make these clearer by defining the indexes.

> +	buffer[2] = RK806_REG_H;
> +	buffer[3] = data[1]; /* register value */
> +
> +	return spi_write(spi, &buffer, sizeof(buffer));
> +}
> +
> +static int rk806_spi_bus_read(void *context, const void *vreg, size_t reg_size,
> +			      void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	const char *reg = vreg;
> +	char txbuf[3] = { 0 };
> +
> +	if (reg_size != sizeof(char) || val_size < 1)
> +		return -EINVAL;
> +
> +	txbuf[0] = RK806_CMD_READ | (val_size - 1);
> +	txbuf[1] = *reg;
> +	txbuf[2] = RK806_REG_H;
> +
> +	return spi_write_then_read(spi, txbuf, sizeof(txbuf), val, val_size);
> +}
> +
> +static const struct regmap_bus rk806_regmap_bus_spi = {
> +	.write = rk806_spi_bus_write,
> +	.read = rk806_spi_bus_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +};
> +
> +static int rk8xx_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(&spi->dev, &rk806_regmap_bus_spi,
> +				  &spi->dev, &rk806_regmap_config_spi);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initialize register map\n");
> +
> +	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
> +}
> +
> +static const struct of_device_id rk8xx_spi_of_match[] = {
> +	{ .compatible = "rockchip,rk806", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rk8xx_spi_of_match);
> +
> +static const struct spi_device_id rk8xx_spi_id_table[] = {
> +	{ "rk806", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, rk8xx_spi_id_table);

Are these simple tables required for SPI?

Is there anything akin to I2C's probe_new that you could use?

> +static struct spi_driver rk8xx_spi_driver = {
> +	.driver		= {
> +		.name	= "rk8xx-spi",
> +		.of_match_table = rk8xx_spi_of_match,
> +	},
> +	.probe		= rk8xx_spi_probe,
> +	.id_table	= rk8xx_spi_id_table,
> +};
> +module_spi_driver(rk8xx_spi_driver);
> +
> +MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
> +MODULE_DESCRIPTION("RK8xx SPI PMIC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index 4183427a80fe..78e167a92483 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h

[...]

-- 
Lee Jones [李琼斯]
