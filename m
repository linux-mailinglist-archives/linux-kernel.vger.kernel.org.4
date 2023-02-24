Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4CE6A1D34
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBXOGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:06:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5311640;
        Fri, 24 Feb 2023 06:06:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t11so7083566lfr.1;
        Fri, 24 Feb 2023 06:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WugV16wwdpThpxOytIyvHhs9GcS6RbAKcp+XYF6w6GI=;
        b=JWA3VmqVlQ4KDIgOAfORbcpySGHCTJS/N2B513rhokXkkS/x9bzOnvP33J1kL2o8Nl
         K/n8gE7sbUoZn6HL8xeedr5c+Jui+/8C7E9VH6wvJ2ZTw8LQWMZxgsAwIIC1rddicqDl
         XRb5olm7CAs2UQuPNYPHJvJ6vXRrqM33M5jA23WP3a674dKKGsMB3weJuQ8Oarl4KQPX
         6700LIyH71s2eoi3vaDEaFfXjCbo4uonuCOlQbhfdGE3oilyU7wPSRuKkDMpPYtHgJp8
         WWWKZtGnivEX0tDelimp0beY/AwRxOethpXwzSebTxxr9tx/AZJiwijkgb9dKC1SN/nd
         gqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WugV16wwdpThpxOytIyvHhs9GcS6RbAKcp+XYF6w6GI=;
        b=Z7Us6T860aLpohWR2TokoLWQ0TeGIJx43iOHXHCIkgQcL/zirIWhK88rBiYHYXYxS5
         wtHMWJ6zkqUHv8eQmqautNhOjoOQw6IWABbAcC9IztnjYRkGsIbWE/mufB7LDe/b8LNO
         GNdJSL0W9oVFbyLjnqPwbrsV7iR34mkdXE8JReA7L4CJ491girQafv2s0IpZTjCV0Dqx
         oGB/OMz75ES/hv+bIFZnD7fBSb5f/MJsE4zkzDjIyZefS572Nlk1ExnpMfTqThEleUPY
         Jzaoa8W9yg4lkn6934whisnVXRWSESbxmX9NTWAy+FdOs/KOj/H/7hStyIaZtwL8GJSY
         La4A==
X-Gm-Message-State: AO0yUKVkih+FRts4SeJX+IAbWRNW6vYN7q5zlxIKPoKHXZbtqPN6R3im
        dXxCzJlUANv2TP7nqNEuVA0=
X-Google-Smtp-Source: AK7set84jLYOULkMNgO3SGfFxBj1UO9q7VzNkwrJVUEnyL70RzuKTPdj4vSrFJ5Qr1CX3wqSUnT5rA==
X-Received: by 2002:a19:7614:0:b0:4db:2021:a3e1 with SMTP id c20-20020a197614000000b004db2021a3e1mr4803080lff.43.1677247560083;
        Fri, 24 Feb 2023 06:06:00 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o16-20020a05651238b000b004db1d3bf9b4sm891492lft.26.2023.02.24.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 06:05:59 -0800 (PST)
Message-ID: <ceb76b77-1361-5605-db18-3b6918c029aa@gmail.com>
Date:   Fri, 24 Feb 2023 16:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
In-Reply-To: <20230224133129.887203-4-eblanc@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

On 2/24/23 15:31, Esteban Blanc wrote:
> From: Jerome Neanne <jneanne@baylibre.com>
> 
> This patch adds support for TPS6594 regulators (bucks and LDOs).
> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
> Bucks can be used in single or multiphase mode, depending on PMIC
> part number.
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>   drivers/regulator/Kconfig             |  12 +
>   drivers/regulator/Makefile            |   1 +
>   drivers/regulator/tps6594-regulator.c | 559 ++++++++++++++++++++++++++
>   3 files changed, 572 insertions(+)
>   create mode 100644 drivers/regulator/tps6594-regulator.c
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 820c9a0788e5..921540af6958 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1432,6 +1432,18 @@ config REGULATOR_TPS65219
>   	  voltage regulators. It supports software based voltage control
>   	  for different voltage domains.
>   
> +config REGULATOR_TPS6594
> +	tristate "TI TPS6594 Power regulators"
> +	depends on MFD_TPS6594 && OF
> +	help
> +	  This driver supports TPS6594 voltage regulator chips.
> +	  TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
> +	  voltage regulators.
> +	  BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
> +	  Part number defines which single or multiphase mode is i used.
> +	  It supports software based voltage control
> +	  for different voltage domains.
> +
>   config REGULATOR_TPS6524X
>   	tristate "TI TPS6524X Power regulators"
>   	depends on SPI
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index b9f5eb35bf5f..948b53f6156b 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -171,6 +171,7 @@ obj-$(CONFIG_REGULATOR_TPS6524X) += tps6524x-regulator.o
>   obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
>   obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
>   obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
> +obj-$(CONFIG_REGULATOR_TPS6594) += tps6594-regulator.o
>   obj-$(CONFIG_REGULATOR_TPS65132) += tps65132-regulator.o
>   obj-$(CONFIG_REGULATOR_TPS68470) += tps68470-regulator.o
>   obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
> diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
> new file mode 100644
> index 000000000000..c099711fd460
> --- /dev/null
> +++ b/drivers/regulator/tps6594-regulator.c
> @@ -0,0 +1,559 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regulator driver for tps6594 PMIC
> + *
> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> + *
> + * This implementation derived from tps65218 authored by "J Keerthy <j-keerthy@ti.com>"
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#include <linux/mfd/tps6594.h>
> +
> +#define BUCK_NB		5
> +#define LDO_NB		4
> +#define MULTI_PHASE_NB	4
> +
> +enum tps6594_regulator_id {
> +	/* DCDC's */
> +	TPS6594_BUCK_1,
> +	TPS6594_BUCK_2,
> +	TPS6594_BUCK_3,
> +	TPS6594_BUCK_4,
> +	TPS6594_BUCK_5,
> +
> +	/* LDOs */
> +	TPS6594_LDO_1,
> +	TPS6594_LDO_2,
> +	TPS6594_LDO_3,
> +	TPS6594_LDO_4,
> +};
> +
> +enum tps6594_multi_regulator_id {
> +	/* Multi-phase DCDC's */
> +	TPS6594_BUCK_12,
> +	TPS6594_BUCK_34,
> +	TPS6594_BUCK_123,
> +	TPS6594_BUCK_1234,
> +};
> +
> +struct tps6594_regulator_irq_type {
> +	const char *irq_name;
> +	const char *regulator_name;
> +	const char *event_name;
> +	unsigned long event;
> +};
> +
> +static struct tps6594_regulator_irq_type tps6594_regulator_irq_types[] = {
> +	{ TPS6594_IRQ_NAME_BUCK1_OV, "BUCK1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_BUCK1_UV, "BUCK1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },

You have warning level IRQs - which is cool :)

As warning level IRQs are used for non fatal errors, you probably would 
like to also implement a mechanism for consumers to know when the 
"warning is over" (assuming the HW provides the status information). 
Maybe regulator_get_error_flags() would serve you?

I'd be _really_ interested in hearing if you already have a use-case for 
the warnings.

> +	{ TPS6594_IRQ_NAME_BUCK1_SC, "BUCK1", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_BUCK1_ILIM, "BUCK1", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_BUCK2_OV, "BUCK2", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_BUCK2_UV, "BUCK2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_BUCK2_SC, "BUCK2", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_BUCK2_ILIM, "BUCK2", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_BUCK3_OV, "BUCK3", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_BUCK3_UV, "BUCK3", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_BUCK3_SC, "BUCK3", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_BUCK3_ILIM, "BUCK3", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_BUCK4_OV, "BUCK4", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_BUCK4_UV, "BUCK4", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_BUCK4_SC, "BUCK4", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_BUCK4_ILIM, "BUCK4", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_BUCK5_OV, "BUCK5", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_BUCK5_UV, "BUCK5", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_BUCK5_SC, "BUCK5", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_BUCK5_ILIM, "BUCK5", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_LDO1_OV, "LDO1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_LDO1_UV, "LDO1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_LDO1_SC, "LDO1", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_LDO1_ILIM, "LDO1", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_LDO2_OV, "LDO2", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_LDO2_UV, "LDO2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_LDO2_SC, "LDO2", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_LDO2_ILIM, "LDO2", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_LDO3_OV, "LDO3", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_LDO3_UV, "LDO3", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_LDO3_SC, "LDO3", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_LDO3_ILIM, "LDO3", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +	{ TPS6594_IRQ_NAME_LDO4_OV, "LDO4", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_LDO4_UV, "LDO4", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_LDO4_SC, "LDO4", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS6594_IRQ_NAME_LDO4_ILIM, "LDO4", "reach ilim, overcurrent",
> +	  REGULATOR_EVENT_OVER_CURRENT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps6594_ext_regulator_irq_types[] = {
> +	{ TPS6594_IRQ_NAME_VCCA_OV, "VCCA", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_VCCA_UV, "VCCA", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_VMON1_OV, "VMON1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_VMON1_UV, "VMON1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_VMON1_RV, "VMON1", "residual voltage",
> +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_VMON2_OV, "VMON2", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS6594_IRQ_NAME_VMON2_UV, "VMON2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> +	{ TPS6594_IRQ_NAME_VMON2_RV, "VMON2", "residual voltage",
> +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +};
> +
> +struct tps6594_regulator_irq_data {
> +	struct device *dev;
> +	struct tps6594_regulator_irq_type *type;
> +	struct regulator_dev *rdev;
> +};
> +
> +struct tps6594_ext_regulator_irq_data {
> +	struct device *dev;
> +	struct tps6594_regulator_irq_type *type;
> +};
> +
> +	for (i = 0; i < ARRAY_SIZE(tps6594_regulator_irq_types); ++i) {
> +		irq_type = &tps6594_regulator_irq_types[i];
> +
> +		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
> +		if (irq < 0)
> +			return -EINVAL;
> +
> +		irq_data[i].dev = tps->dev;
> +		irq_data[i].type = irq_type;
> +
> +		tps6594_get_rdev_by_name(irq_type->regulator_name, rdevbucktbl,
> +					 rdevldotbl, rdev);
> +
> +		if (rdev < 0) {
> +			dev_err(tps->dev, "Failed to get rdev for %s\n",
> +				irq_type->regulator_name);
> +			return -EINVAL;
> +		}
> +		irq_data[i].rdev = rdev;
> +
> +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
> +						  tps6594_regulator_irq_handler,
> +						  IRQF_ONESHOT,
> +						  irq_type->irq_name,
> +						  &irq_data[i]);
> +		if (error) {
> +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
> +				irq_type->irq_name, irq, error);
> +			return error;
> +		}
> +	}

If I read this correctly, you have exact, 1 to 1 mapping from an IRQ to 
regulator and event? Maybe you could slightly simplify the driver by 
using the devm_regulator_irq_helper() and 
regulator_irq_map_event_simple() with it's map-event? And if the 
devm_regulator_irq_helper() does not work for you I'll be interested in 
hearing if it could be improved.

> +
> +	if (tps->chip_id == LP8764X)
> +		ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
> +
> +	irq_ext_reg_data = devm_kmalloc(tps->dev,
> +					ext_reg_irq_nb *
> +					sizeof(struct tps6594_ext_regulator_irq_data),
> +					GFP_KERNEL);
> +	if (!irq_ext_reg_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ext_reg_irq_nb; ++i) {
> +		irq_type = &tps6594_ext_regulator_irq_types[i];
> +
> +		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
> +		if (irq < 0)
> +			return -EINVAL;
> +
> +		irq_ext_reg_data[i].dev = tps->dev;
> +		irq_ext_reg_data[i].type = irq_type;
> +
> +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
> +						  tps6594_regulator_irq_handler,
> +						  IRQF_ONESHOT,
> +						  irq_type->irq_name,
> +						  &irq_ext_reg_data[i]);
> +		if (error) {
> +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
> +				irq_type->irq_name, irq, error);
> +			return error;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tps6594_regulator_driver = {
> +	.driver = {
> +		.name = "tps6594-regulator",
> +	},
> +	.probe = tps6594_regulator_probe,
> +};
> +
> +module_platform_driver(tps6594_regulator_driver);
> +
> +MODULE_ALIAS("platform:tps6594-regulator");
> +MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
> +MODULE_DESCRIPTION("TPS6594 voltage regulator driver");
> +MODULE_LICENSE("GPL");

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

