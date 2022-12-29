Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABC658E64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiL2Pim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiL2Pik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:38:40 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0483E5FEF;
        Thu, 29 Dec 2022 07:38:38 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-15027746720so6985235fac.13;
        Thu, 29 Dec 2022 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXey9CaoziRSvP/D+NhT3CvzhzYELSn354hSB6TkYOE=;
        b=kydO5L+c3pF1ydBPEgMq2M8iP90bAvPt0pLDWw9qmVcC+K4Hh/JXWIztnqtWk5WV/d
         4E/tguiIFJwVO+Sgo0tCeOYBb3678qrPgwXePqOkwdElkzt1DbJWxJAdkj3yQuRP33f8
         J15Z7vov/FGCT5D/uiGDZOpGNQ1cg4FFuAuZ7aFnY60ClOqa6ycMKZO8xe5f0vsORNfu
         p1VDqxiDL5bka5t6fIaZo7l1i81cqqJOosNJVy+4SgHpdolOj59UxqIoghdk8xmLH+oQ
         nCFl8TTDgl5sTLUXaYGGMER5zlm6S6TE/ZRNdoLC6bPYPjA//jcpi1l+CD0IQffXLhR4
         EqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXey9CaoziRSvP/D+NhT3CvzhzYELSn354hSB6TkYOE=;
        b=2v7ZTOsLg+Upar+b6wesES2Ir8nVPPt5zQtKye+trv7byybJ+htdKpd08UVLL3cwsf
         0I+svm0VPa8+56GeRcKGJlfrcmzwVtPwWWpfUvHBNaIS7K4vPFx9zFz5mOOrV8Iqlwja
         wOx7Bl50AaUMjdm+BnoRle8RG+mF+NYSml7LX3831jgqWJXfdhOAiRg4novJUVHCpV3S
         KgkbhYxNsy81d6D5QIDYP4cKHkmnMz9GRhggcWxs4HM/9Q6b2TrwkYgg88DWPuLvtfeY
         M0/f03V3jnN6huElg6cD7/QkayFwHqUWOussJmg4hTemHUBc2er6OJMst+6dvCPeuXEC
         BjRg==
X-Gm-Message-State: AFqh2koV9CNqMflj+mIpUceZRsOavZKAC82lW35DlkhxT4mE/ZHyROLl
        uGcHeTYHyZj77pqTS2cMRar+o/KRmyU=
X-Google-Smtp-Source: AMrXdXtUA35a4utXkavX3nAhRzIwepZKab6zgaN8+tbRR+P6zifgNRUPnnUPM2NGuqYe5qzLhUrVHQ==
X-Received: by 2002:a05:6871:890:b0:144:840e:76be with SMTP id r16-20020a056871089000b00144840e76bemr18865686oaq.24.1672328317099;
        Thu, 29 Dec 2022 07:38:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z12-20020a056870738c00b00143065d3e99sm8839079oam.5.2022.12.29.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:38:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 07:38:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sinan Divarci <Sinan.Divarci@analog.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drivers: hwmon: Add max31732 quad remote
 temperature sensor driver
Message-ID: <20221229153835.GA22357@roeck-us.net>
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-2-Sinan.Divarci@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214142206.13288-2-Sinan.Divarci@analog.com>
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

On Wed, Dec 14, 2022 at 05:22:04PM +0300, Sinan Divarci wrote:
> The MAX31732 is a multi-channel temperature sensor that monitors its own
> temperature and the temperatures of up to four external diodeconnected
> transistors.
> 
> The MAX31732 offers two open-drain, active-low alarm outputs, ALARM1
> and ALARM2. When the measured temperature of a channel crosses the
> respective primary over/under temperature threshold levels ALARM1
> asserts low and a status bit is set in the corresponding thermal status
> registers. When the measured temperature of a channel crosses the
> secondary over/under temperature threshold levels, ALARM2 asserts low
> and a status bit is set in the corresponding thermal status registers.
> 
> Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>

There is no public documentation about a MAX31732 chip. Google search
only points to this driver submission. I'll need it to determine if the
chip even exists and to evaluate some implementation details such as
interupt handling.

> ---
>  drivers/hwmon/Kconfig    |  11 +
>  drivers/hwmon/Makefile   |   1 +
>  drivers/hwmon/max31732.c | 620 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 632 insertions(+)
>  create mode 100644 drivers/hwmon/max31732.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 3176c33af..f498f3867 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1076,6 +1076,17 @@ config SENSORS_MAX31730
>  	  This driver can also be built as a module. If so, the module
>  	  will be called max31730.
>  
> +config SENSORS_MAX31732
> +	tristate "MAX31732 temperature sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Support for the Analog Devices MAX31732 4-Channel Remote
> +	  Temperature Sensor.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called max31732.
> +
>  config SENSORS_MAX31760
>  	tristate "MAX31760 fan speed controller"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e2e4e87b2..6b2871cc5 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -140,6 +140,7 @@ obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
>  obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
>  obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
>  obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
> +obj-$(CONFIG_SENSORS_MAX31732)	+= max31732.o
>  obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
>  obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
>  obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
> diff --git a/drivers/hwmon/max31732.c b/drivers/hwmon/max31732.c
> new file mode 100644
> index 000000000..cf075c990
> --- /dev/null
> +++ b/drivers/hwmon/max31732.c
> @@ -0,0 +1,620 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MAX31732 4-Channel Remote Temperature Sensor
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/regmap.h>
> +
> +/* common definitions*/
> +#define MAX3173X_STOP			BIT(7)
> +#define MAX3173X_ALARM_MODE		BIT(4)
> +#define MAX3173X_ALARM_FAULT_QUEUE_MASK	GENMASK(3, 2)
> +#define MAX3173X_EXTRANGE		BIT(1)
> +#define MAX3173X_TEMP_OFFSET_BASELINE	0x77
> +#define MAX3173X_TEMP_MIN		(-128000)
> +#define MAX3173X_TEMP_MAX		127937
> +#define MAX3173X_OFFSET_MIN		(-14875)
> +#define MAX3173X_OFFSET_MAX		17000
> +#define MAX3173X_OFFSET_ZERO		14875
> +#define MAX31732_SECOND_TEMP_MIN	(-128000)
> +#define MAX31732_SECOND_TEMP_MAX	127000
> +#define MAX31732_CUSTOM_OFFSET_RES	125
> +#define MAX31732_ALL_CHANNEL_MASK	0x1F
> +#define MAX31732_ALARM_INT_MODE		0
> +#define MAX31732_ALARM_COMP_MODE	1
> +#define MAX31732_ALARM_FAULT_QUE	1
> +#define MAX31732_ALARM_FAULT_QUE_MAX	3
> +
> +/* The MAX31732 registers */
> +#define MAX31732_REG_TEMP_R		0x02
> +#define MAX31732_REG_TEMP_L		0x0A
> +#define MAX31732_REG_PRIM_HIGH_STATUS	0x0C
> +#define MAX31732_REG_PRIM_LOW_STATUS	0x0D
> +#define MAX31732_REG_CHANNEL_ENABLE	0x0E
> +#define MAX31732_REG_CONF1		0x0F
> +#define MAX31732_REG_CONF2		0x10
> +#define MAX31732_REG_TEMP_OFFSET	0x16
> +#define MAX31732_REG_OFFSET_ENABLE	0x17
> +#define MAX31732_REG_ALARM1_MASK	0x1B
> +#define MAX31732_REG_ALARM2_MASK	0x1C
> +#define MAX31732_REG_PRIM_HIGH_TEMP_R	0x1D
> +#define MAX31732_REG_PRIM_HIGH_TEMP_L	0x25
> +#define MAX31732_REG_PRIM_LOW_TEMP	0x27
> +#define MAX31732_REG_SECOND_HIGH_TEMP_R	0x29
> +#define MAX31732_REG_SECOND_HIGH_TEMP_L	0x2D
> +#define MAX31732_REG_SECOND_LOW_TEMP	0x2E
> +#define MAX31732_REG_SECOND_HIGH_STATUS	0x42
> +#define MAX31732_REG_SECOND_LOW_STATUS	0x43
> +#define MAX31732_REG_TEMP_FAULT		0x44
> +
> +enum max31732_temp_type {
> +	MAX31732_TEMP,
> +	MAX31732_PRIM_HIGH,
> +	MAX31732_SECOND_HIGH
> +};
> +
> +struct max31732_data {
> +	struct i2c_client	*client;
> +	struct device		*hwmon_dev;
> +	struct regmap		*regmap;
> +	s32			irqs[2];
> +};
> +
> +static u32 max31732_get_temp_reg(enum max31732_temp_type temp_type, u32 channel)
> +{
> +	switch (temp_type) {
> +	case MAX31732_PRIM_HIGH:
> +		if (channel == 0)
> +			return MAX31732_REG_PRIM_HIGH_TEMP_L;
> +		else

else after return is unnecessary (static analyzers will complain).

> +			return (MAX31732_REG_PRIM_HIGH_TEMP_R + (channel - 1) * 2);

Unnecessary outer ()

> +		break;
> +	case MAX31732_SECOND_HIGH:
> +		if (channel == 0)
> +			return MAX31732_REG_SECOND_HIGH_TEMP_L;
> +		else
> +			return (MAX31732_REG_SECOND_HIGH_TEMP_R + (channel - 1));
> +		break;
> +	case MAX31732_TEMP:
> +	default:
> +		if (channel == 0)
> +			return MAX31732_REG_TEMP_L;
> +		else

Unnecessary else after return

> +			return (MAX31732_REG_TEMP_R + (channel - 1) * 2);

Unnecessary outer ()

> +		break;
> +	}
> +}
> +
> +static bool max31732_volatile_reg(struct device *dev, u32 reg)
> +{
> +	if (reg >= MAX31732_REG_TEMP_R && reg <= MAX31732_REG_PRIM_LOW_STATUS)
> +		return true;
> +
> +	if (reg == MAX31732_REG_SECOND_HIGH_STATUS || reg == MAX31732_REG_SECOND_LOW_STATUS)
> +		return true;
> +
> +	if (reg == MAX31732_REG_TEMP_FAULT)
> +		return true;
> +
> +	return false;
> +}
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = max31732_volatile_reg,
> +};
> +
> +static inline long max31732_reg_to_mc(s16 temp)
> +{
> +	return DIV_ROUND_CLOSEST((temp / 16) * 1000, 16);
> +}
> +
> +static int max31732_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, s32 channel,
> +			 long *val)
> +{
> +	struct max31732_data *data = dev_get_drvdata(dev);
> +	s32 ret;
> +	u32 reg_val, reg_addr;
> +	s16 temp_reg_val;
> +	u8 regs[2];
> +
> +	if (type != hwmon_temp)
> +		return -EINVAL;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!ret)
> +			return -ENODATA;
> +
> +		reg_addr = max31732_get_temp_reg(MAX31732_TEMP, channel);
> +		break;
> +	case hwmon_temp_max:
> +		reg_addr = max31732_get_temp_reg(MAX31732_PRIM_HIGH, channel);
> +		break;
> +	case hwmon_temp_min:
> +		reg_addr = MAX31732_REG_PRIM_LOW_TEMP;
> +		break;
> +	case hwmon_temp_lcrit:
> +		ret = regmap_read(data->regmap, MAX31732_REG_SECOND_LOW_TEMP, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val * 1000;
> +		return 0;
> +	case hwmon_temp_crit:
> +		reg_addr = max31732_get_temp_reg(MAX31732_SECOND_HIGH, channel);
> +		ret = regmap_read(data->regmap, reg_addr, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val * 1000;
> +		return 0;
> +	case hwmon_temp_enable:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return 0;
> +	case hwmon_temp_offset:
> +		if (channel == 0)
> +			return -EINVAL;
> +
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_OFFSET_ENABLE, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!ret)
> +			return 0;
> +
> +		ret = regmap_read(data->regmap, MAX31732_REG_TEMP_OFFSET, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		*val = (reg_val - MAX3173X_TEMP_OFFSET_BASELINE) * MAX31732_CUSTOM_OFFSET_RES;
> +		return 0;
> +	case hwmon_temp_fault:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_TEMP_FAULT, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return 0;
> +	case hwmon_temp_lcrit_alarm:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_SECOND_LOW_STATUS, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return 0;
> +	case hwmon_temp_min_alarm:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_PRIM_LOW_STATUS, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return 0;
> +	case hwmon_temp_max_alarm:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_PRIM_HIGH_STATUS, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return 0;
> +	case hwmon_temp_crit_alarm:
> +		ret = regmap_test_bits(data->regmap, MAX31732_REG_SECOND_HIGH_STATUS, BIT(channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, reg_addr, &regs, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	temp_reg_val = regs[1] | regs[0] << 8;
> +	*val = max31732_reg_to_mc(temp_reg_val);
> +	return 0;
> +}
> +
> +static int max31732_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, s32 channel,
> +			  long val)
> +{
> +	struct max31732_data *data = dev_get_drvdata(dev);
> +	s32 reg_addr, ret;
> +	u16 temp_reg_val;
> +
> +	if (type != hwmon_temp)
> +		return -EINVAL;
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		reg_addr = max31732_get_temp_reg(MAX31732_PRIM_HIGH, channel);
> +		break;
> +	case hwmon_temp_min:
> +		reg_addr = MAX31732_REG_PRIM_LOW_TEMP;
> +		break;
> +	case hwmon_temp_enable:
> +		if (val == 0) {
> +			return regmap_clear_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE,
> +						 BIT(channel));
> +		} else if (val == 1) {
> +			return regmap_set_bits(data->regmap, MAX31732_REG_CHANNEL_ENABLE,
> +					       BIT(channel));
> +		} else {

else after return is unnecessary.

> +			return -EINVAL;
> +		}
> +	case hwmon_temp_offset:
> +		val = clamp_val(val, MAX3173X_OFFSET_MIN, MAX3173X_OFFSET_MAX) +
> +				MAX3173X_OFFSET_ZERO;
> +		val = DIV_ROUND_CLOSEST(val, 125);
> +
> +		if (val == MAX3173X_TEMP_OFFSET_BASELINE) {
> +			ret = regmap_clear_bits(data->regmap, MAX31732_REG_OFFSET_ENABLE,
> +						BIT(channel));
> +		} else {
> +			ret = regmap_set_bits(data->regmap, MAX31732_REG_OFFSET_ENABLE,
> +					      BIT(channel));
> +		}
> +		if (ret)
> +			return ret;
> +
> +		return regmap_write(data->regmap, MAX31732_REG_TEMP_OFFSET, val);
> +	case hwmon_temp_crit:
> +		val = clamp_val(val, MAX31732_SECOND_TEMP_MIN, MAX31732_SECOND_TEMP_MAX);
> +		val = DIV_ROUND_CLOSEST(val, 1000);
> +		reg_addr = max31732_get_temp_reg(MAX31732_SECOND_HIGH, channel);
> +		return regmap_write(data->regmap, reg_addr, val);
> +	case hwmon_temp_lcrit:
> +		val = clamp_val(val, MAX31732_SECOND_TEMP_MIN, MAX31732_SECOND_TEMP_MAX);
> +		val = DIV_ROUND_CLOSEST(val, 1000);
> +		return regmap_write(data->regmap, MAX31732_REG_SECOND_LOW_TEMP, val);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val = clamp_val(val, MAX3173X_TEMP_MIN, MAX3173X_TEMP_MAX);
> +	val = DIV_ROUND_CLOSEST(val << 4, 1000) << 4;
> +
> +	temp_reg_val = (u16)val;
> +	temp_reg_val = swab16(temp_reg_val);

Why not just
	temp_reg_val = swab16(val);
?

> +
> +	return regmap_bulk_write(data->regmap, reg_addr, &temp_reg_val, sizeof(temp_reg_val));
> +}
> +
> +static umode_t max31732_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> +				   s32 channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_lcrit_alarm:
> +		case hwmon_temp_min_alarm:
> +		case hwmon_temp_max_alarm:
> +		case hwmon_temp_crit_alarm:
> +		case hwmon_temp_fault:
> +			return 0444;
> +		case hwmon_temp_min:
> +		case hwmon_temp_lcrit:
> +			return channel ? 0444 : 0644;
> +		case hwmon_temp_offset:
> +		case hwmon_temp_enable:
> +		case hwmon_temp_max:
> +		case hwmon_temp_crit:
> +			return 0644;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t max31732_irq_handler(s32 irq, void *data)
> +{
> +	struct device *dev = data;
> +	struct max31732_data *drvdata = dev_get_drvdata(dev);
> +	s32 ret;
> +	u32 reg_val;
> +	bool reported = false;
> +
> +	ret = regmap_read(drvdata->regmap, MAX31732_REG_PRIM_HIGH_STATUS, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val != 0) {
> +		dev_crit(dev, "Primary Overtemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
> +			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
> +			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));

dev_crit seems excessive here.

> +		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_max_alarm, 0);
> +		reported = true;
> +	}
> +
> +	ret = regmap_read(drvdata->regmap, MAX31732_REG_PRIM_LOW_STATUS, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val != 0) {
> +		dev_crit(dev, "Primary Undertemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
> +			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
> +			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));

dev_crit seems excessive here.

> +		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_min_alarm, 0);
> +		reported = true;
> +	}
> +
> +	ret = regmap_read(drvdata->regmap, MAX31732_REG_SECOND_HIGH_STATUS, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val != 0) {
> +		dev_crit(dev, "Secondary Overtemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
> +			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
> +			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));
> +		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_crit_alarm, 0);

Why always report events against channel 0 ?

> +		reported = true;
> +	}
> +
> +	ret = regmap_read(drvdata->regmap, MAX31732_REG_SECOND_LOW_STATUS, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val != 0) {
> +		dev_crit(dev, "Secondary Undertemperature Alarm, R4:%d R3:%d R2:%d R1:%d L:%d.\n",
> +			 !!(reg_val & BIT(4)), !!(reg_val & BIT(3)), !!(reg_val & BIT(2)),
> +			 !!(reg_val & BIT(1)), !!(reg_val & BIT(0)));
> +		hwmon_notify_event(drvdata->hwmon_dev, hwmon_temp, hwmon_temp_lcrit_alarm, 0);
> +		reported = true;
> +	}
> +
> +	if (!reported) {
> +		if (irq == drvdata->irqs[0])
> +			dev_err(dev, "ALARM1 interrupt received but status registers not set.\n");
> +		else if (irq == drvdata->irqs[1])
> +			dev_err(dev, "ALARM2 interrupt received but status registers not set.\n");
> +		else
> +			dev_err(dev, "Undefined interrupt source.\n");
> +	}

I am a bit concerned with the volume of alarm log messages. What happens
if the alarm is persistent ? Will there be just one or many reports ?

The second and third else statements are unnecessary. There are two
interrupts, and the reported interrupt will be one of those.
In fact, I wonder if it even makes sense to have a single interrupt
handler for both interrupts; that seems to defeat the purpose
of having separate interrupts. I'll need to see the datasheet to
help me determine if and how this makes sense.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct hwmon_channel_info *max31732_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
> +			   HWMON_T_CRIT |
> +			   HWMON_T_ENABLE |
> +			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_LCRIT_ALARM,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
> +			   HWMON_T_CRIT |
> +			   HWMON_T_OFFSET | HWMON_T_ENABLE |
> +			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_LCRIT_ALARM |
> +			   HWMON_T_FAULT,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
> +			   HWMON_T_CRIT |
> +			   HWMON_T_OFFSET | HWMON_T_ENABLE |
> +			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_LCRIT_ALARM |
> +			   HWMON_T_FAULT,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
> +			   HWMON_T_CRIT |
> +			   HWMON_T_OFFSET | HWMON_T_ENABLE |
> +			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_LCRIT_ALARM |
> +			   HWMON_T_FAULT,
> +			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_LCRIT |
> +			   HWMON_T_CRIT |
> +			   HWMON_T_OFFSET | HWMON_T_ENABLE |
> +			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
> +			   HWMON_T_LCRIT_ALARM |
> +			   HWMON_T_FAULT
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_ops max31732_hwmon_ops = {
> +	.is_visible = max31732_is_visible,
> +	.read = max31732_read,
> +	.write = max31732_write,
> +};
> +
> +static const struct hwmon_chip_info max31732_chip_info = {
> +	.ops = &max31732_hwmon_ops,
> +	.info = max31732_info,
> +};
> +
> +static int max31732_parse_alarms(struct device *dev, struct max31732_data *data)
> +{
> +	s32 ret;
> +	u32 alarm_que;
> +
> +	if (fwnode_property_read_bool(dev_fwnode(dev), "adi,alarm1-interrupt-mode"))
> +		ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_ALARM_MODE);
> +	else
> +		ret = regmap_set_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_ALARM_MODE);

What is the impact of this ? It is not normally configurable. One would expect
one interrupt when an alarm is raised, and another interrupt when the alarm
condition no longer exists. I have no access to the datasheet, so I can not
determine if and how it might make sense to have this configurable, and what
the impact might be.

> +
> +	if (ret)
> +		return ret;
> +
> +	if (fwnode_property_read_bool(dev_fwnode(dev), "adi,alarm2-interrupt-mode"))
> +		ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF2, MAX3173X_ALARM_MODE);
> +	else
> +		ret = regmap_set_bits(data->regmap, MAX31732_REG_CONF2, MAX3173X_ALARM_MODE);
> +
> +	if (ret)
> +		return ret;
> +
> +	alarm_que = MAX31732_ALARM_FAULT_QUE;
> +	fwnode_property_read_u32(dev_fwnode(dev), "adi,alarm1-fault-queue", &alarm_que);
> +
> +	if ((alarm_que / 2) <= MAX31732_ALARM_FAULT_QUE_MAX) {

Norm is to check for errors first.

> +		ret = regmap_write_bits(data->regmap, MAX31732_REG_CONF1,
> +					MAX3173X_ALARM_FAULT_QUEUE_MASK,
> +					FIELD_PREP(MAX3173X_ALARM_FAULT_QUEUE_MASK,
> +						   (alarm_que / 2)));
> +		if (ret)
> +			return ret;
> +	} else {
> +		return dev_err_probe(dev, -EINVAL, "Invalid adi,alarm1-fault-queue.\n");
> +	}
> +
> +	alarm_que = MAX31732_ALARM_FAULT_QUE;
> +	fwnode_property_read_u32(dev_fwnode(dev), "adi,alarm2-fault-queue", &alarm_que);
> +
> +	if ((alarm_que / 2) <= MAX31732_ALARM_FAULT_QUE_MAX) {

Unnecessary ( )

This accepts values of 3 and 5 which are invalid according to the
devicetree file. The code should check for that.


> +		ret = regmap_write_bits(data->regmap, MAX31732_REG_CONF2,
> +					MAX3173X_ALARM_FAULT_QUEUE_MASK,
> +					FIELD_PREP(MAX3173X_ALARM_FAULT_QUEUE_MASK,
> +						   (alarm_que / 2)));
> +	} else {
> +		return dev_err_probe(dev, -EINVAL, "Invalid adi,alarm2-fault-queue.\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int max31732_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max31732_data *data;
> +	s32 ret;
> +	u32 reg_val;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;

I don't see this used anywhere.

> +
> +	data->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
> +
> +	ret = regmap_read(data->regmap, MAX31732_REG_CHANNEL_ENABLE, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val == 0)
> +		ret = regmap_set_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
> +	else
> +		ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_EXTRANGE);
> +	if (ret)
> +		return ret;
> +
> +	ret = max31732_parse_alarms(dev, data);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(dev, data);
> +
> +	data->irqs[0] = fwnode_irq_get_byname(dev_fwnode(dev), "ALARM1");
> +	if (data->irqs[0] > 0) {
> +		ret = devm_request_threaded_irq(dev, data->irqs[0], NULL, max31732_irq_handler,
> +						IRQF_ONESHOT, client->name, dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "cannot request irq\n");
> +
> +		ret = regmap_set_bits(data->regmap, MAX31732_REG_ALARM1_MASK,
> +				      MAX31732_ALL_CHANNEL_MASK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_clear_bits(data->regmap, MAX31732_REG_ALARM1_MASK,
> +					MAX31732_ALL_CHANNEL_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	data->irqs[1] = fwnode_irq_get_byname(dev_fwnode(dev), "ALARM2");
> +	if (data->irqs[1] > 0) {
> +		ret = devm_request_threaded_irq(dev, data->irqs[1], NULL, max31732_irq_handler,
> +						IRQF_ONESHOT, client->name, dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "cannot request irq\n");
> +
> +		ret = regmap_set_bits(data->regmap, MAX31732_REG_ALARM2_MASK,
> +				      MAX31732_ALL_CHANNEL_MASK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_clear_bits(data->regmap, MAX31732_REG_ALARM2_MASK,
> +					MAX31732_ALL_CHANNEL_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
> +							       &max31732_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(data->hwmon_dev);
> +}
> +
> +static const struct i2c_device_id max31732_ids[] = {
> +	{ "max31732" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max31732_ids);
> +
> +static const struct of_device_id __maybe_unused max31732_of_match[] = {
> +	{ .compatible = "adi,max31732", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, max31732_of_match);
> +
> +static int __maybe_unused max31732_suspend(struct device *dev)
> +{
> +	struct max31732_data *data = dev_get_drvdata(dev);
> +
> +	return regmap_set_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
> +}
> +
> +static int __maybe_unused max31732_resume(struct device *dev)
> +{
> +	struct max31732_data *data = dev_get_drvdata(dev);
> +
> +	return regmap_clear_bits(data->regmap, MAX31732_REG_CONF1, MAX3173X_STOP);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max31732_pm_ops, max31732_suspend, max31732_resume);
> +
> +static struct i2c_driver max31732_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "max31732-driver",
> +		.of_match_table = of_match_ptr(max31732_of_match),
> +		.pm	= &max31732_pm_ops,
> +	},
> +	.probe_new	= max31732_probe,
> +	.id_table	= max31732_ids,
> +};
> +
> +module_i2c_driver(max31732_driver);
> +
> +MODULE_AUTHOR("Sinan Divarci <sinan.divarci@analog.com>");
> +MODULE_DESCRIPTION("MAX31732 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");
