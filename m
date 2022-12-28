Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EC658522
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiL1RMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiL1RMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:12:16 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B26168;
        Wed, 28 Dec 2022 09:12:15 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r130so15309141oih.2;
        Wed, 28 Dec 2022 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/+Nth0Nu8gmjfacEJmdzYlP/TTCuiYpUSrTOOkqTNM=;
        b=QB3Kamik55n+qNzvp0RqlGrP8edwJ2oTipYAV0uLjJO1LAxvyikfePe2Km2CgJldgG
         iiWu5RYzHMdHe4ZNNJBEluDQ5TIoYLJlPe1BuHuiUHckGhaHf6xYYLclmBhlEMX8Mj++
         WhY+4Xqb+4ip4BVUwOuPSXYdq7ejR/Nh1QOsDzjYaWHgOpLyMxquVGnAHi0teSIRbAk6
         Na3CZwWJQzAZpQNJybBXOQl1Cy2CjOE/zgWtvtaQDx8lapXIS+/ApmwETSMx0xqGhLqv
         f0C364Ve7uR+pTEOzIzf7PFj0LIkYnUXZ/wFKOn1/vN+/4VTeFw2z5cxx2/Fr7/WcN8s
         ecXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/+Nth0Nu8gmjfacEJmdzYlP/TTCuiYpUSrTOOkqTNM=;
        b=xd0v0/BzLEY5UOIwGgq58OobfFyJlqpRz8X6SUGkMiMFdcH6lf/T+8f8fmG9RN/FTp
         jAr2YKKjykdhXxCdwBnd2CIkPkdyFCCmVcdJTq27lKh3wjs2rwSMZDdWvP6NAYg4GXIZ
         8QyfQDTN3Vn1JurLse1vPHKg0QkterSEEZ29St6S5bxyNs6Vy9rZhG5xh15V3CGj2XRL
         Qi5GuD57c6Ri4J6rUGzRaM94DwYyet3SPRRX8HzkuZIrwLHTHGKgVCpf9M+H1gGvDJYM
         wA7BYIo87v9Slum+ZBKeRFKlU0ytTFDDR9iHq0IOgZwSDFn8JXRI5aEvKZUpcdqZtjX3
         m4/A==
X-Gm-Message-State: AFqh2kpqcKV4+RK9oeLGnJY+CVqMoLD8pseklav6o17aQAbslHxtVqzB
        sHGMpxS6ojN6fiMq1x0NFH4cCTWF1J0=
X-Google-Smtp-Source: AMrXdXu4HuqbLIfl49jbFyVzumy46KXlwHsTII0C1oiJm3o50ISJD54AfMx0kuQbxDDMxKO8g0I2gg==
X-Received: by 2002:aca:1b0d:0:b0:35e:1e0d:8432 with SMTP id b13-20020aca1b0d000000b0035e1e0d8432mr11300428oib.27.1672247534261;
        Wed, 28 Dec 2022 09:12:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7-20020a9d5387000000b00666a5b5d20fsm7946890otg.32.2022.12.28.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:12:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 09:12:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Message-ID: <20221228171212.GA2575313@roeck-us.net>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
 <20221130200846.4226-2-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130200846.4226-2-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:08:41PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC can support up to 16 fans through the interface provided by
> the CPLD. The current support is limited to 8 fans. The fans speeds are
> controlled via 8 different PWMs which can vary in value from  0-255. The
> fans are also capable of reporting if they have failed to the CPLD which
> in turn reports the status to the GXP SoC.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  Documentation/hwmon/gxp-fan-ctrl.rst |  28 +++
>  Documentation/hwmon/index.rst        |   1 +
>  drivers/hwmon/Kconfig                |   9 +
>  drivers/hwmon/Makefile               |   1 +
>  drivers/hwmon/gxp-fan-ctrl.c         | 254 +++++++++++++++++++++++++++
>  5 files changed, 293 insertions(+)
>  create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
>  create mode 100644 drivers/hwmon/gxp-fan-ctrl.c
> 
> diff --git a/Documentation/hwmon/gxp-fan-ctrl.rst b/Documentation/hwmon/gxp-fan-ctrl.rst
> new file mode 100644
> index 000000000000..ae3397e81c04
> --- /dev/null
> +++ b/Documentation/hwmon/gxp-fan-ctrl.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver gxp-fan-ctrl
> +==========================
> +
> +Supported chips:
> +
> +  * HPE GXP SOC
> +
> +Author: Nick Hawkins <nick.hawkins@hpe.com>
> +
> +
> +Description
> +-----------
> +
> +gxp-fan-ctrl is a driver which provides fan control for the hpe gxp soc.
> +The driver allows the gathering of fan status and the use of fan
> +PWM control.
> +
> +
> +Sysfs attributes
> +----------------
> +
> +======================= ===========================================================
> +pwm[0-7]		Fan 0 to 7 respective PWM value (0-255)
> +fan[0-7]_fault		Fan 0 to 7 respective fault status: 1 fail, 0 ok
> +fan[0-7]_enable         Fan 0 to 7 respective enabled status: 1 enabled, 0 disabled
> +======================= ===========================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c1d11cf13eef..97819cf5c97f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
>     g762
>     gsc-hwmon
>     gl518sm
> +   gxp-fan-ctrl
>     hih6130
>     ibmaem
>     ibm-cffps
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7ac3daaf59ce..45febd5d5cf7 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -706,6 +706,15 @@ config SENSORS_GPIO_FAN
>  	  This driver can also be built as a module. If so, the module
>  	  will be called gpio-fan.
>  
> +config SENSORS_GXP_FAN_CTRL
> +	tristate "HPE GXP fan controller"
> +	depends on ARCH_HPE_GXP || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for GXP fan control functionality.
> +
> +	  The GXP controls fan function via the CPLD through the use of PWM
> +	  registers. This driver reports status and pwm setting of the fans.
> +
>  config SENSORS_HIH6130
>  	tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 11d076cad8a2..b5782dc4dc6e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> +obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
>  obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
> diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
> new file mode 100644
> index 000000000000..5d137ee3de9a
> --- /dev/null
> +++ b/drivers/hwmon/gxp-fan-ctrl.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define OFS_FAN_INST 0 /* Is 0 because plreg base will be set at INST */
> +#define OFS_FAN_FAIL 2 /* Is 2 bytes after base */
> +#define OFS_SEVSTAT 0 /* Is 0 because fn2 base will be set at SEVSTAT */
> +#define POWER_BIT 24
> +
> +struct gxp_fan_ctrl_drvdata {
> +	void __iomem	*base;
> +	void __iomem	*plreg;
> +	void __iomem	*fn2;
> +};
> +
> +static bool fan_installed(struct device *dev, int fan)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	u8 val;
> +
> +	val = readb(drvdata->plreg + OFS_FAN_INST);
> +
> +	return !!(val & BIT(fan));
> +}
> +
> +static long fan_failed(struct device *dev, int fan)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	u8 val;
> +
> +	val = readb(drvdata->plreg + OFS_FAN_FAIL);
> +
> +	return !!(val & BIT(fan));
> +}
> +
> +static long fan_enabled(struct device *dev, int fan)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	/*
> +	 * Check the power status as if the platform is off the value
> +	 * reported for the PWM will be incorrect. Report fan as
> +	 * disabled.
> +	 */
> +	val = readl(drvdata->fn2 + OFS_SEVSTAT);
> +
> +	return !!((val & BIT(POWER_BIT)) && fan_installed(dev, fan));
> +}
> +
> +static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		if (val > 255 || val < 0)
> +			return -EINVAL;
> +		writeb(val, drvdata->base + channel);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int gxp_fan_ctrl_write(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		return gxp_pwm_write(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	switch (attr) {
> +	case hwmon_fan_enable:
> +		*val = fan_enabled(dev, channel);
> +		return 0;
> +	case hwmon_fan_fault:
> +		*val = fan_failed(dev, channel);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	/*
> +	 * Check the power status of the platform. If the platform is off
> +	 * the value reported for the PWM will be incorrect. In this case
> +	 * report a PWM of zero.
> +	 */
> +
> +	reg = readl(drvdata->fn2 + OFS_SEVSTAT);
> +
> +	if (reg & BIT(POWER_BIT))
> +		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}
> +
> +static int gxp_fan_ctrl_read(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return gxp_fan_read(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return gxp_pwm_read(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t gxp_fan_ctrl_is_visible(const void *_data,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel)
> +{
> +	umode_t mode = 0;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_enable:
> +		case hwmon_fan_fault:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			mode = 0644;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +static const struct hwmon_ops gxp_fan_ctrl_ops = {
> +	.is_visible = gxp_fan_ctrl_is_visible,
> +	.read = gxp_fan_ctrl_read,
> +	.write = gxp_fan_ctrl_write,
> +};
> +
> +static const struct hwmon_channel_info *gxp_fan_ctrl_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),

Why HWMON_PWM_ENABLE ? It is not actually supported, or am I missing
something ? If it is supposed to be aligned with hwmon_fan_enable,
the necessary code is missing.

Guenter

> +	NULL
> +};
> +
> +static const struct hwmon_chip_info gxp_fan_ctrl_chip_info = {
> +	.ops = &gxp_fan_ctrl_ops,
> +	.info = gxp_fan_ctrl_info,
> +
> +};
> +
> +static int gxp_fan_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct device *hwmon_dev;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(struct gxp_fan_ctrl_drvdata),
> +			       GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drvdata->base))
> +		return dev_err_probe(dev, PTR_ERR(drvdata->base),
> +				     "failed to map base\n");
> +
> +	drvdata->plreg = devm_platform_ioremap_resource_byname(pdev,
> +							       "pl");
> +	if (IS_ERR(drvdata->plreg))
> +		return dev_err_probe(dev, PTR_ERR(drvdata->plreg),
> +				     "failed to map plreg\n");
> +
> +	drvdata->fn2 = devm_platform_ioremap_resource_byname(pdev,
> +							     "fn2");
> +	if (IS_ERR(drvdata->fn2))
> +		return dev_err_probe(dev, PTR_ERR(drvdata->fn2),
> +				     "failed to map fn2\n");
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +							 "hpe_gxp_fan_ctrl",
> +							 drvdata,
> +							 &gxp_fan_ctrl_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id gxp_fan_ctrl_of_match[] = {
> +	{ .compatible = "hpe,gxp-fan-ctrl", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_fan_ctrl_of_match);
> +
> +static struct platform_driver gxp_fan_ctrl_driver = {
> +	.probe		= gxp_fan_ctrl_probe,
> +	.driver = {
> +		.name	= "gxp-fan-ctrl",
> +		.of_match_table = gxp_fan_ctrl_of_match,
> +	},
> +};
> +module_platform_driver(gxp_fan_ctrl_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP fan controller");
> +MODULE_LICENSE("GPL");
