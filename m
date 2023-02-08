Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB168F31B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBHQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBHQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:23:16 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC7DBF8;
        Wed,  8 Feb 2023 08:23:15 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso5336820otp.1;
        Wed, 08 Feb 2023 08:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8a7ia7hlKY1WwWjsg9wr/+VRH6pE01RhHoyC7vXYB0=;
        b=Oj9mf56dSpIhY1P0SX6qZQtxRCkUjHFiR8gxzT9jeWirHQQXmxKLL5HrGkrH4G6hVE
         tlp62NC4Mbt8pmqn0ez58JDRw7g4Nu14de3hVhfBsvTXBd4Sae8F767QWyRncxFzR3pJ
         4SHclgHPquyCcg1FYj9DN49v4eKi7Z9fWahrjCF3UaNVseRzU1GqByF7kUQZU6Pin/sB
         dJMC6ddouFW9vL8bMAiPX6UAgWdFQyjQUcj0+NuN3ohbCMQNl2pl7QA1esfZrdr1JGE0
         vbBQSKPTU1nXQjeTWezbpVfD6H4sCJF1ziDv/w5gV/MGli3g6BCXTNeHFUvoF7hoGxQR
         F7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8a7ia7hlKY1WwWjsg9wr/+VRH6pE01RhHoyC7vXYB0=;
        b=vZNHxyC4/eBvsSjo3ONDQs9JW+dhNpSCtO8Ep1ezRSzC3NC1SiNvTb6UURbeYJMj5k
         pd/3PTgGngJz7kWIMYcJipLl/183A2Xec2upNKh9Fqfkbf8hFLDB+rBX8qvYhvo7ZBzv
         2cRPdkNqPxX6hNpZZOWXN5Es+6wbSsdIhAoi/SJiqsuvWfBkhSr1cun40LvqPUjO88mg
         uoQ7KtEze8tZVvta6M6tUYtE7Ui8+xBnYs/Hqc1ajmJ1zrDkLzu/wJukURYM6DLfwSHq
         M1Mu4mScd9c96ddIoN4fyVQ/Xcoy2zuYQ17sjhvlz5q8FVePbxxIkNip/Vmyi0l4DcZO
         LW+Q==
X-Gm-Message-State: AO0yUKWZNvfsGIY2bFx0tOZCv6dQ9rPSKlRJBSpCmLvO5428U+dUtoyC
        Vu7DmGG84h5HbXHyMNw6gXg=
X-Google-Smtp-Source: AK7set+ROni7EFW8LlhMuZRUxVgKYbNqh5T2FP1vVmxlY2srAoopQ/tJBoTJ49tqWqBjGoOVkpM+JQ==
X-Received: by 2002:a9d:4913:0:b0:68b:bbe2:fa4d with SMTP id e19-20020a9d4913000000b0068bbbe2fa4dmr4257931otf.18.1675873394370;
        Wed, 08 Feb 2023 08:23:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d2c07000000b0068d4649bedasm8180317otb.67.2023.02.08.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:23:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Feb 2023 08:23:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (sfctemp) Add StarFive JH71x0 temperature
 sensor
Message-ID: <20230208162312.GA3062856@roeck-us.net>
References: <20230207072314.62040-1-hal.feng@starfivetech.com>
 <20230207072314.62040-3-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207072314.62040-3-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:23:14PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Register definitions and conversion constants based on sfctemp driver by
> Samin in the StarFive 5.10 kernel.

"based on ..." does not belong here. Describe what the driver does,
not what it is based on. If you want to add a note about the origin
of the driver, add it in the comments on the top of the driver.

Please add the missing default: statements in the driver,
and explain (for example in the comments at the top of the
driver) why you don't use continuous mode. The description
needs to be detailed and compelling enough that no one comes
back and implements a continuous mode version of the driver.

Thanks,
Guenter

> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Samin Guo <samin.guo@starfivetech.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/sfctemp.rst |  33 +++
>  MAINTAINERS                     |   8 +
>  drivers/hwmon/Kconfig           |  10 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/sfctemp.c         | 352 ++++++++++++++++++++++++++++++++
>  6 files changed, 405 insertions(+)
>  create mode 100644 Documentation/hwmon/sfctemp.rst
>  create mode 100644 drivers/hwmon/sfctemp.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index fe2cc6b73634..a666e3706ea2 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -180,6 +180,7 @@ Hardware Monitoring Kernel Drivers
>     sch5627
>     sch5636
>     scpi-hwmon
> +   sfctemp
>     sht15
>     sht21
>     sht3x
> diff --git a/Documentation/hwmon/sfctemp.rst b/Documentation/hwmon/sfctemp.rst
> new file mode 100644
> index 000000000000..9fbd5bb1f356
> --- /dev/null
> +++ b/Documentation/hwmon/sfctemp.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver sfctemp
> +=====================
> +
> +Supported chips:
> + - StarFive JH7100
> + - StarFive JH7110
> +
> +Authors:
> + - Emil Renner Berthing <kernel@esmil.dk>
> +
> +Description
> +-----------
> +
> +This driver adds support for reading the built-in temperature sensor on the
> +JH7100 and JH7110 RISC-V SoCs by StarFive Technology Co. Ltd.
> +
> +``sysfs`` interface
> +-------------------
> +
> +The temperature sensor can be enabled, disabled and queried via the standard
> +hwmon interface in sysfs under ``/sys/class/hwmon/hwmonX`` for some value of
> +``X``:
> +
> +================ ==== =============================================
> +Name             Perm Description
> +================ ==== =============================================
> +temp1_enable     RW   Enable or disable temperature sensor.
> +                      Automatically enabled by the driver,
> +                      but may be disabled to save power.
> +temp1_input      RO   Temperature reading in milli-degrees Celsius.
> +================ ==== =============================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb1471cb5ed3..6f5de1438f65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18917,6 +18917,14 @@ L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	drivers/net/ethernet/sfc/
>  
> +SFCTEMP HWMON DRIVER
> +M:	Emil Renner Berthing <kernel@esmil.dk>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> +F:	Documentation/hwmon/sfctemp.rst
> +F:	drivers/hwmon/sfctemp.c
> +
>  SFF/SFP/SFP+ MODULE SUPPORT
>  M:	Russell King <linux@armlinux.org.uk>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 3176c33af6c6..572e1b2541bb 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1930,6 +1930,16 @@ config SENSORS_STTS751
>  	  This driver can also be built as a module. If so, the module
>  	  will be called stts751.
>  
> +config SENSORS_SFCTEMP
> +	tristate "Starfive JH71x0 temperature sensor"
> +	depends on SOC_STARFIVE || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for temperature sensor
> +	  on the Starfive JH71x0 SoCs.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sfctemp.
> +
>  config SENSORS_SMM665
>  	tristate "Summit Microelectronics SMM665"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e2e4e87b282f..337e1b19678a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -180,6 +180,7 @@ obj-$(CONFIG_SENSORS_SBRMI)	+= sbrmi.o
>  obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>  obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> +obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
>  obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> diff --git a/drivers/hwmon/sfctemp.c b/drivers/hwmon/sfctemp.c
> new file mode 100644
> index 000000000000..79749b5195be
> --- /dev/null
> +++ b/drivers/hwmon/sfctemp.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2021 Samin Guo <samin.guo@starfivetech.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +/*
> + * TempSensor reset. The RSTN can be de-asserted once the analog core has
> + * powered up. Trst(min 100ns)
> + * 0:reset  1:de-assert
> + */
> +#define SFCTEMP_RSTN	BIT(0)
> +
> +/*
> + * TempSensor analog core power down. The analog core will be powered up
> + * Tpu(min 50us) after PD is de-asserted. RSTN should be held low until the
> + * analog core is powered up.
> + * 0:power up  1:power down
> + */
> +#define SFCTEMP_PD	BIT(1)
> +
> +/*
> + * TempSensor start conversion enable.
> + * 0:disable  1:enable
> + */
> +#define SFCTEMP_RUN	BIT(2)
> +
> +/*
> + * TempSensor conversion value output.
> + * Temp(C)=DOUT*Y/4094 - K
> + */
> +#define SFCTEMP_DOUT_POS	16
> +#define SFCTEMP_DOUT_MSK	GENMASK(27, 16)
> +
> +/* DOUT to Celcius conversion constants */
> +#define SFCTEMP_Y1000	237500L
> +#define SFCTEMP_Z	4094L
> +#define SFCTEMP_K1000	81100L
> +
> +struct sfctemp {
> +	/* serialize access to hardware register and enabled below */
> +	struct mutex lock;
> +	struct completion conversion_done;
> +	void __iomem *regs;
> +	struct clk *clk_sense;
> +	struct clk *clk_bus;
> +	struct reset_control *rst_sense;
> +	struct reset_control *rst_bus;
> +	bool enabled;
> +};
> +
> +static irqreturn_t sfctemp_isr(int irq, void *data)
> +{
> +	struct sfctemp *sfctemp = data;
> +
> +	complete(&sfctemp->conversion_done);
> +	return IRQ_HANDLED;
> +}
> +
> +static void sfctemp_power_up(struct sfctemp *sfctemp)
> +{
> +	/* make sure we're powered down first */
> +	writel(SFCTEMP_PD, sfctemp->regs);
> +	udelay(1);
> +
> +	writel(0, sfctemp->regs);
> +	/* wait t_pu(50us) + t_rst(100ns) */
> +	usleep_range(60, 200);
> +
> +	/* de-assert reset */
> +	writel(SFCTEMP_RSTN, sfctemp->regs);
> +	udelay(1); /* wait t_su(500ps) */
> +}
> +
> +static void sfctemp_power_down(struct sfctemp *sfctemp)
> +{
> +	writel(SFCTEMP_PD, sfctemp->regs);
> +}
> +
> +static void sfctemp_run_single(struct sfctemp *sfctemp)
> +{
> +	writel(SFCTEMP_RSTN | SFCTEMP_RUN, sfctemp->regs);
> +	udelay(1);
> +	writel(SFCTEMP_RSTN, sfctemp->regs);
> +}
> +
> +static int sfctemp_enable(struct sfctemp *sfctemp)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&sfctemp->lock);
> +	if (sfctemp->enabled)
> +		goto done;
> +
> +	ret = clk_prepare_enable(sfctemp->clk_bus);
> +	if (ret)
> +		goto err;
> +	ret = reset_control_deassert(sfctemp->rst_bus);
> +	if (ret)
> +		goto err_disable_bus;
> +
> +	ret = clk_prepare_enable(sfctemp->clk_sense);
> +	if (ret)
> +		goto err_assert_bus;
> +	ret = reset_control_deassert(sfctemp->rst_sense);
> +	if (ret)
> +		goto err_disable_sense;
> +
> +	sfctemp_power_up(sfctemp);
> +	sfctemp->enabled = true;
> +done:
> +	mutex_unlock(&sfctemp->lock);
> +	return ret;
> +
> +err_disable_sense:
> +	clk_disable_unprepare(sfctemp->clk_sense);
> +err_assert_bus:
> +	reset_control_assert(sfctemp->rst_bus);
> +err_disable_bus:
> +	clk_disable_unprepare(sfctemp->clk_bus);
> +err:
> +	mutex_unlock(&sfctemp->lock);
> +	return ret;
> +}
> +
> +static int sfctemp_disable(struct sfctemp *sfctemp)
> +{
> +	mutex_lock(&sfctemp->lock);
> +	if (!sfctemp->enabled)
> +		goto done;
> +
> +	sfctemp_power_down(sfctemp);
> +	reset_control_assert(sfctemp->rst_sense);
> +	clk_disable_unprepare(sfctemp->clk_sense);
> +	reset_control_assert(sfctemp->rst_bus);
> +	clk_disable_unprepare(sfctemp->clk_bus);
> +	sfctemp->enabled = false;
> +done:
> +	mutex_unlock(&sfctemp->lock);
> +	return 0;
> +}
> +
> +static void sfctemp_disable_action(void *data)
> +{
> +	sfctemp_disable(data);
> +}
> +
> +static int sfctemp_convert(struct sfctemp *sfctemp, long *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&sfctemp->lock);
> +	if (!sfctemp->enabled) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
> +
> +	sfctemp_run_single(sfctemp);
> +
> +	ret = wait_for_completion_interruptible_timeout(&sfctemp->conversion_done,
> +							msecs_to_jiffies(10));
> +	if (ret <= 0) {
> +		if (ret == 0)
> +			ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	/* calculate temperature in milli Celcius */
> +	*val = (long)((readl(sfctemp->regs) & SFCTEMP_DOUT_MSK) >> SFCTEMP_DOUT_POS)
> +		* SFCTEMP_Y1000 / SFCTEMP_Z - SFCTEMP_K1000;
> +
> +	ret = 0;
> +out:
> +	mutex_unlock(&sfctemp->lock);
> +	return ret;
> +}
> +
> +static umode_t sfctemp_is_visible(const void *data, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +			return 0644;
> +		case hwmon_temp_input:
> +			return 0444;
default: missing

> +		}
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int sfctemp_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct sfctemp *sfctemp = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +			*val = sfctemp->enabled;
> +			return 0;
> +		case hwmon_temp_input:
> +			return sfctemp_convert(sfctemp, val);

default: missing

> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sfctemp_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	struct sfctemp *sfctemp = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +			if (val == 0)
> +				return sfctemp_disable(sfctemp);
> +			if (val == 1)
> +				return sfctemp_enable(sfctemp);
> +			break;

default: missing

> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct hwmon_channel_info *sfctemp_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops sfctemp_hwmon_ops = {
> +	.is_visible = sfctemp_is_visible,
> +	.read = sfctemp_read,
> +	.write = sfctemp_write,
> +};
> +
> +static const struct hwmon_chip_info sfctemp_chip_info = {
> +	.ops = &sfctemp_hwmon_ops,
> +	.info = sfctemp_info,
> +};
> +
> +static int sfctemp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *hwmon_dev;
> +	struct sfctemp *sfctemp;
> +	int ret;
> +
> +	sfctemp = devm_kzalloc(dev, sizeof(*sfctemp), GFP_KERNEL);
> +	if (!sfctemp)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, sfctemp);
> +	mutex_init(&sfctemp->lock);
> +	init_completion(&sfctemp->conversion_done);
> +
> +	sfctemp->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sfctemp->regs))
> +		return PTR_ERR(sfctemp->regs);
> +
> +	sfctemp->clk_sense = devm_clk_get(dev, "sense");
> +	if (IS_ERR(sfctemp->clk_sense))
> +		return dev_err_probe(dev, PTR_ERR(sfctemp->clk_sense),
> +				     "error getting sense clock\n");
> +
> +	sfctemp->clk_bus = devm_clk_get(dev, "bus");
> +	if (IS_ERR(sfctemp->clk_bus))
> +		return dev_err_probe(dev, PTR_ERR(sfctemp->clk_bus),
> +				     "error getting bus clock\n");
> +
> +	sfctemp->rst_sense = devm_reset_control_get_exclusive(dev, "sense");
> +	if (IS_ERR(sfctemp->rst_sense))
> +		return dev_err_probe(dev, PTR_ERR(sfctemp->rst_sense),
> +				     "error getting sense reset\n");
> +
> +	sfctemp->rst_bus = devm_reset_control_get_exclusive(dev, "bus");
> +	if (IS_ERR(sfctemp->rst_bus))
> +		return dev_err_probe(dev, PTR_ERR(sfctemp->rst_bus),
> +				     "error getting busreset\n");
> +
> +	ret = reset_control_assert(sfctemp->rst_sense);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error asserting sense reset\n");
> +
> +	ret = reset_control_assert(sfctemp->rst_bus);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error asserting bus reset\n");
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, ret, sfctemp_isr, 0, pdev->name, sfctemp);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error requesting irq\n");
> +
> +	ret = devm_add_action(dev, sfctemp_disable_action, sfctemp);
> +	if (ret)
> +		return ret;
> +
> +	ret = sfctemp_enable(sfctemp);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error enabling temperature sensor: %d\n", ret);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, pdev->name, sfctemp,
> +							 &sfctemp_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id sfctemp_of_match[] = {
> +	{ .compatible = "starfive,jh7100-temp" },
> +	{ .compatible = "starfive,jh7110-temp" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sfctemp_of_match);
> +
> +static struct platform_driver sfctemp_driver = {
> +	.probe  = sfctemp_probe,
> +	.driver = {
> +		.name = "sfctemp",
> +		.of_match_table = sfctemp_of_match,
> +	},
> +};
> +module_platform_driver(sfctemp_driver);
> +
> +MODULE_AUTHOR("Emil Renner Berthing");
> +MODULE_DESCRIPTION("StarFive JH71x0 temperature sensor driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.38.1
> 
