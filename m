Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25386F868A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjEEQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjEEQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:19:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E218FC4;
        Fri,  5 May 2023 09:19:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643465067d1so1563445b3a.0;
        Fri, 05 May 2023 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683303563; x=1685895563;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cNKEZg3bxp1iNacr15kDvnZyY5ipBzS+pF8ojG5h8I=;
        b=R48w65BL7KwK/wY0TUMIp65Pl7AgSRgalyxVJ37AYTesusIf2Y9D3bA0xHoUq7H2LU
         ZGlpNF0/417Qgacqhrgm7WdRt83RFWuK6Dy5ur6gZrJ0KuIhAeljqnmXgx6nGtcuVu0u
         tnAQ8JWfzxNGLRTM88eGX95fXbkhvdNg78voA1swG4DQskkKKteSSHDC/stY8EyHQ+Tu
         EoPNKETwYG5litUph66oh9cb7OZc+mSbi07a0nBsa25iSmURcBYNTxL8qcnmxFokWqMv
         rAauOLCi7h7B//IJcvFmyk8Rx1IVCev3mmQX2RMGeu4YhaVtiBSBNhuIBUfObzcEMEAU
         8klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683303563; x=1685895563;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cNKEZg3bxp1iNacr15kDvnZyY5ipBzS+pF8ojG5h8I=;
        b=DWlVu/zTlSvlQkcZpvD/CvyaBglb1lWuVJVRmvy9/LkPegab4elXQTV1VrrBdpE+pE
         /bmit2Z2fuFE6NwPiuIVg1ok5jP50sdfeD3cEOPSVCJWgz8io1SQf63OELD2QfaIgW13
         SZaHBqEph6ITUddcYMf7w+UhmKC+T02oBVKcanRhUauf0ABH+LwAxWI1xDlXmgNdzUer
         Awmzy7S6oaZc0ebVQG5KZuIYvgNO1VaNBNIaFyRMrT2DdXP4YfU7XNwZREVX6J7DaT1Z
         wsNZ+Sm4Rt9+LcyCnw9vRwB+FtpEePaLzPvxTNXXErt/hWrA5X8k//EmL//nre1K6QRk
         jtMg==
X-Gm-Message-State: AC+VfDx0W7X4M9paysPNdI4JMoOaPdTsqTjlklYQXOxcP4S5mGhD73Ww
        asD3Ou81m+gBuWKagvmmOT8=
X-Google-Smtp-Source: ACHHUZ7JKg6jEXoqtAVZiLVDEkVI9K93pXgoJeOV2c3qJlDOOO4Yn3kcwP8aNL2EOsZOjAA8Y6OP0w==
X-Received: by 2002:a05:6a20:9183:b0:fc:8dfb:318b with SMTP id v3-20020a056a20918300b000fc8dfb318bmr2900417pzd.0.1683303562889;
        Fri, 05 May 2023 09:19:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b0063d44634d8csm1828653pfn.71.2023.05.05.09.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:19:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fe113cd7-ec8a-9d8b-e6c8-9614abf32158@roeck-us.net>
Date:   Fri, 5 May 2023 09:19:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230505172538.32733-1-daniel.matyas@analog.com>
 <20230505172538.32733-2-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 2/2] hwmon: max31827: add MAX31827 driver
In-Reply-To: <20230505172538.32733-2-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 10:25, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
> 
> v5 -> v6: Corrected the mistakes with mutex. Explained why I shift the
> last 4 bits in the .rst file. (because the LSB is 0.0625 degrees Celsius).
> 
>   Documentation/hwmon/index.rst    |   1 +
>   Documentation/hwmon/max31827.rst |  90 +++++++
>   MAINTAINERS                      |   2 +
>   drivers/hwmon/Kconfig            |  11 +
>   drivers/hwmon/Makefile           |   2 +-
>   drivers/hwmon/max31827.c         | 430 +++++++++++++++++++++++++++++++
>   6 files changed, 535 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/hwmon/max31827.rst
>   create mode 100644 drivers/hwmon/max31827.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index fa1208c62855..8cc0922f3b36 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -140,6 +140,7 @@ Hardware Monitoring Kernel Drivers
>      max31760
>      max31785
>      max31790
> +   max31827
>      max34440
>      max6620
>      max6639
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> new file mode 100644
> index 000000000000..b0971d05b8a4
> --- /dev/null
> +++ b/Documentation/hwmon/max31827.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver max31827
> +======================
> +
> +Supported chips:
> +
> +  * Maxim MAX31827
> +
> +    Prefix: 'max31827'
> +
> +    Addresses scanned: I2C 0x40 - 0x5f
> +
> +    Datasheet: Publicly available at the Analog Devices website
> +
> +  * Maxim MAX31828
> +
> +    Prefix: 'max31828'
> +
> +    Addresses scanned: I2C 0x40 - 0x5f
> +
> +    Datasheet: Publicly available at the Analog Devices website
> +
> +  * Maxim MAX31829
> +
> +    Prefix: 'max31829'
> +
> +    Addresses scanned: I2C 0x40 - 0x5f
> +
> +    Datasheet: Publicly available at the Analog Devices website
> +
> +
> +Authors:
> +	- Daniel Matyas <daniel.matyas@analog.com>
> +
> +Description
> +-----------
> +
> +The chips supported by this driver are quite similar. The only difference
> +between them is found in the default power-on behaviour of the chips. While the
> +MAX31827's fault queue is set to 1, the other two chip's fault queue is set to
> +4. Besides this, the MAX31829's alarm active state is high, while the other two
> +chip's alarms are active on low. It is important to note that the chips can be
> +configured to operate in the same manner with 1 write operation to the
> +configuration register. From here on, we will refer to all these chips as
> +MAX31827.
> +
> +MAX31827 implements a temperature sensor with a 6 WLP packaging scheme. This
> +sensor measures the temperature of the chip itself.
> +
> +MAX31827 has low and over temperature alarms with an effective value and a
> +hysteresis value: -40 and -30 degrees for under temperature alarm and +100 and
> ++90 degrees for over temperature alarm.
> +
> +The alarm can be configured in comparator and interrupt mode. Currently only
> +comparator mode is implemented. In Comparator mode, the OT/UT status bits have a
> +value of 1 when the temperature rises above the TH value or falls below TL,
> +which is also subject to the Fault Queue selection. OT status returns to 0 when
> +the temperature drops below the TH_HYST value or when shutdown mode is entered.
> +Similarly, UT status returns to 0 when the temperature rises above TL_HYST value
> +or when shutdown mode is entered.
> +
> +Putting the MAX31827 into shutdown mode also resets the OT/UT status bits. Note
> +that if the mode is changed while OT/UT status bits are set, an OT/UT status
> +reset may be required before it begins to behave normally. To prevent this,
> +it is recommended to perform a read of the configuration/status register to
> +clear the status bits before changing the operating mode.
> +
> +The conversions can be manual with the one-shot functionality and automatic with
> +a set frequency. When powered on, the chip measures temperatures with 1 conv/s.
> +Enabling the device when it is already enabled has the side effect of setting
> +the conversion frequency to 1 conv/s. The conversion time varies depending on
> +the resolution. The conversion time doubles with every bit of increased
> +resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
> +(default) 140ms. When chip is in shutdown mode and a read operation is
> +requested, one-shot is triggered, the device waits for 140 (conversion time) + 1
> +(error) ms, and only after that is the temperature value register read.
> +
> +The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
> +the temperatures are displayed in milli-degrees. This means, that some data is
> +lost. The step between 2 consecutive values is 62 or 63. This effect can be seen
> +in the writing of alarm values too. For positive numbers the user-input value
> +will always be rounded down to the nearest possible value, for negative numbers
> +the user-input will always be rounded up to the nearest possible value.
> +
> +Notes
> +-----
> +
> +Currently fault queue, alarm polarity and resolution cannot be modified.
> +PEC is not implemented either.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91de1e95f11d..40504fc94db5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12624,6 +12624,8 @@ L:	linux-hwmon@vger.kernel.org
>   S:	Supported
>   W:	http://ez.analog.com/community/linux-device-drivers
>   F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +F:	Documentation/hwmon/max31827.rst
> +F:	drivers/hwmon/max31827.c
>   
>   MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
>   L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index fc640201a2de..12bd17075dc4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1097,6 +1097,17 @@ config SENSORS_MAX31760
>   	  This driver can also be built as a module. If so, the module
>   	  will be called max31760.
>   
> +config MAX31827
> +	tristate "MAX31827 low-power temperature switch and similar devices"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for MAX31827, MAX31828 and
> +	  MAX31829 low-power temperature switches and sensors connected with I2C.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max31827.
> +
>   config SENSORS_MAX6620
>   	tristate "Maxim MAX6620 fan controller"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index cd8c568c80a9..8a8021f9ca9e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -149,6 +149,7 @@ obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
>   obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
>   obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
>   obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
> +obj-$(CONFIG_MAX31827) += max31827.o
>   obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>   obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
>   obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
> @@ -224,4 +225,3 @@ obj-$(CONFIG_SENSORS_PECI)	+= peci/
>   obj-$(CONFIG_PMBUS)		+= pmbus/
>   
>   ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
> -
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> new file mode 100644
> index 000000000000..03f5524d6d9b
> --- /dev/null
> +++ b/drivers/hwmon/max31827.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * max31827.c - Support for Maxim Low-Power Switch
> + *
> + * Copyright (c) 2023 Daniel Matyas <daniel.matyas@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +#define MAX31827_T_REG	0x0
> +#define MAX31827_CONFIGURATION_REG	0x2
> +#define MAX31827_TH_REG	0x4
> +#define MAX31827_TL_REG 0x6
> +#define MAX31827_TH_HYST_REG	0x8
> +#define MAX31827_TL_HYST_REG	0xA
> +
> +#define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
> +#define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
> +#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
> +
> +#define MAX31827_12_BIT_CNV_TIME	141
> +
> +#define MAX31827_CNV_1_DIV_64_HZ	0x1
> +#define MAX31827_CNV_1_DIV_32_HZ	0x2
> +#define MAX31827_CNV_1_DIV_16_HZ	0x3
> +#define MAX31827_CNV_1_DIV_4_HZ		0x4
> +#define MAX31827_CNV_1_HZ	0x5
> +#define MAX31827_CNV_4_HZ	0x6
> +#define MAX31827_CNV_8_HZ	0x7
> +
> +#define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
> +#define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
> +#define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
> +
> +struct max31827_state {
> +	/*
> +	 * Prevent simultaneous access to the i2c client.
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	bool enable;
> +};
> +
> +static const struct regmap_config max31827_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0xA,
> +};
> +
> +static int write_alarm_val(struct max31827_state *st, unsigned int reg,
> +			   long val)
> +{
> +	unsigned int cfg;
> +	unsigned int tmp;
> +	int ret;
> +
> +	val = MAX31827_M_DGR_TO_16_BIT(val);
> +
> +	/*
> +	 * Before the Temperature Threshold Alarm and Alarm Hysteresis Threshold
> +	 * register values are changed over I2C, the part must be in shutdown
> +	 * mode.
> +	 *
> +	 * Mutex is used to ensure, that some other process doesn't change the
> +	 * configuration register.
> +	 */
> +	mutex_lock(&st->lock);
> +
> +	if (!st->enable) {
> +		mutex_unlock(&st->lock);
> +		return regmap_write(st->regmap, reg, val);

That defeats the purpose of the lock. It should be something like

		ret = regmap_write(st->regmap, reg, val);
		goto unlock;

with

unlock:
	mutex_unlock(&st->lock);
	return ret;


> +	}
> +
> +	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &cfg);
> +	if (ret) {
> +		mutex_unlock(&st->lock);
> +		return ret;

		goto unlock;

See Documentation/process/coding-style.rst, 7) "Centralized exiting of functions".
Same below.

> +	}
> +
> +	tmp = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
> +		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
> +	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, tmp);
> +	if (ret) {
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, reg, val);
> +	if (ret) {
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
> +
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static umode_t max31827_is_visible(const void *state,
> +				   enum hwmon_sensor_types type, u32 attr,
> +				   int channel)
> +{
> +	if (type == hwmon_temp) {
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +		case hwmon_temp_max:
> +		case hwmon_temp_min:
> +		case hwmon_temp_max_hyst:
> +		case hwmon_temp_min_hyst:
> +			return 0644;
> +		case hwmon_temp_input:
> +		case hwmon_temp_min_alarm:
> +		case hwmon_temp_max_alarm:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	} else if (type == hwmon_chip) {
> +		if (attr == hwmon_chip_update_interval)
> +			return 0644;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *val)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +			ret = regmap_read(st->regmap,
> +					  MAX31827_CONFIGURATION_REG, &uval);
> +			uval = FIELD_GET(MAX31827_CONFIGURATION_1SHOT_MASK |
> +					 MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +					 uval);
> +			*val = !!uval;
> +
> +			break;
> +		case hwmon_temp_input:
> +			mutex_lock(&st->lock);
> +
> +			if (!st->enable) {
> +				/*
> +				 * This operation requires mutex protection,
> +				 * because the chip configuration should not
> +				 * be changed during the conversion process.
> +				 */
> +
> +				ret = regmap_update_bits(st->regmap,
> +							 MAX31827_CONFIGURATION_REG,
> +							 MAX31827_CONFIGURATION_1SHOT_MASK,
> +							 1);
> +				if (ret) {
> +					mutex_unlock(&st->lock);
> +					return ret;
> +				}
> +
> +				msleep(MAX31827_12_BIT_CNV_TIME);
> +			}
> +			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
> +
> +			mutex_unlock(&st->lock);
> +
> +			*val = MAX31827_16_BIT_TO_M_DGR(uval);
> +
> +			break;
> +		case hwmon_temp_max:
> +			ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
> +			*val = MAX31827_16_BIT_TO_M_DGR(uval);
> +			break;
> +		case hwmon_temp_max_hyst:
> +			ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG,
> +					  &uval);
> +			*val = MAX31827_16_BIT_TO_M_DGR(uval);
> +			break;
> +		case hwmon_temp_max_alarm:
> +			ret = regmap_read(st->regmap,
> +					  MAX31827_CONFIGURATION_REG, &uval);
> +			*val = FIELD_GET(MAX31827_CONFIGURATION_O_TEMP_STAT_MASK,
> +					 uval);
> +			break;
> +		case hwmon_temp_min:
> +			ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
> +			*val = MAX31827_16_BIT_TO_M_DGR(uval);
> +			break;
> +		case hwmon_temp_min_hyst:
> +			ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG,
> +					  &uval);
> +			*val = MAX31827_16_BIT_TO_M_DGR(uval);
> +			break;
> +		case hwmon_temp_min_alarm:
> +			ret = regmap_read(st->regmap,
> +					  MAX31827_CONFIGURATION_REG, &uval);
> +			*val = FIELD_GET(MAX31827_CONFIGURATION_U_TEMP_STAT_MASK,
> +					 uval);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +
> +		break;
> +
> +	case hwmon_chip:
> +		if (attr == hwmon_chip_update_interval) {
> +			ret = regmap_read(st->regmap,
> +					  MAX31827_CONFIGURATION_REG, &uval);

			if (ret)
				break;

because calculations don't really make sense in that case.

Same everywhere above where you do the same.

> +			uval = FIELD_GET(MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +					 uval);
> +			switch (uval) {
> +			case MAX31827_CNV_1_DIV_64_HZ:
> +				*val = 64000;
> +				break;
> +			case MAX31827_CNV_1_DIV_32_HZ:
> +				*val = 32000;
> +				break;
> +			case MAX31827_CNV_1_DIV_16_HZ:
> +				*val = 16000;
> +				break;
> +			case MAX31827_CNV_1_DIV_4_HZ:
> +				*val = 4000;
> +				break;
> +			case MAX31827_CNV_1_HZ:
> +				*val = 1000;
> +				break;
> +			case MAX31827_CNV_4_HZ:
> +				*val = 250;
> +				break;
> +			case MAX31827_CNV_8_HZ:
> +				*val = 125;
> +				break;
> +			default:
> +				*val = 0;
> +				break;
> +			}
> +		}
> +		break;
> +
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
> +			  u32 attr, int channel, long val)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +			if (val >> 1)
> +				return -EOPNOTSUPP;
> +
> +			st->enable = val;
> +
> +			return regmap_update_bits(st->regmap,
> +						  MAX31827_CONFIGURATION_REG,
> +						  MAX31827_CONFIGURATION_1SHOT_MASK |
> +						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +						  MAX31827_DEVICE_ENABLE(val));

The missing lock here makes the mutex above quite pointless. The chip can
still be enabled while the above code is waiting for a conversion result
from a disabled chip. Similar, the mutex in write_alarm_val is pointless
without a lock here because that means that the enable status can change
while the mutex is locked.

On top of that, changing st->enable and then the register without lock means
that it is not well defined if the flag and the actual chip status are
in sync.

> +
> +		case hwmon_temp_max:
> +			return write_alarm_val(st, MAX31827_TH_REG, val);
> +
> +		case hwmon_temp_max_hyst:
> +			return write_alarm_val(st, MAX31827_TH_HYST_REG, val);
> +
> +		case hwmon_temp_min:
> +			return write_alarm_val(st, MAX31827_TL_REG, val);
> +
> +		case hwmon_temp_min_hyst:
> +			return write_alarm_val(st, MAX31827_TL_HYST_REG, val);
> +
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_chip:
> +		if (attr == hwmon_chip_update_interval) {
> +			switch (val) {
> +			case 125:
> +				val = MAX31827_CNV_8_HZ;
> +				break;
> +			case 250:
> +				val = MAX31827_CNV_4_HZ;
> +				break;
> +			case 1000:
> +				val = MAX31827_CNV_1_HZ;
> +				break;
> +			case 4000:
> +				val = MAX31827_CNV_1_DIV_4_HZ;
> +				break;
> +			case 16000:
> +				val = MAX31827_CNV_1_DIV_16_HZ;
> +				break;
> +			case 32000:
> +				val = MAX31827_CNV_1_DIV_32_HZ;
> +				break;
> +			case 64000:
> +				val = MAX31827_CNV_1_DIV_64_HZ;
> +				break;
> +			default:
> +				return -EOPNOTSUPP;
> +			}
> +
> +			val = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +					 val);
> +
> +			return regmap_update_bits(st->regmap,
> +						  MAX31827_CONFIGURATION_REG,
> +						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +						  val);

Doesn't this automatically enable the chip ?

> +		}
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int max31827_init_client(struct max31827_state *st)
> +{
> +	st->enable = true;
> +
> +	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +				  MAX31827_CONFIGURATION_1SHOT_MASK |
> +					  MAX31827_CONFIGURATION_CNV_RATE_MASK,
> +				  MAX31827_DEVICE_ENABLE(1));
> +}
> +
> +static const struct hwmon_channel_info *max31827_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_MIN |
> +					 HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM |
> +					 HWMON_T_MAX | HWMON_T_MAX_HYST |
> +					 HWMON_T_MAX_ALARM),
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops max31827_hwmon_ops = {
> +	.is_visible = max31827_is_visible,
> +	.read = max31827_read,
> +	.write = max31827_write,
> +};
> +
> +static const struct hwmon_chip_info max31827_chip_info = {
> +	.ops = &max31827_hwmon_ops,
> +	.info = max31827_info,
> +};
> +
> +static int max31827_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct max31827_state *st;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	mutex_init(&st->lock);
> +
> +	st->regmap = devm_regmap_init_i2c(client, &max31827_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	err = max31827_init_client(st);
> +	if (err)
> +		return err;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
> +							 &max31827_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id max31827_i2c_ids[] = {
> +	{ "max31827", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> +
> +static const struct of_device_id max31827_of_match[] = {
> +	{ .compatible = "max31827" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max31827_of_match);
> +
> +static struct i2c_driver max31827_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "max31827",
> +		.of_match_table = max31827_of_match,
> +	},
> +	.probe_new = max31827_probe,
> +	.id_table = max31827_i2c_ids,
> +};
> +module_i2c_driver(max31827_driver);
> +
> +MODULE_AUTHOR("Daniel Matyas <daniel.matyas@analog.com>");
> +MODULE_DESCRIPTION("Maxim MAX31827 low-power temperature switch driver");
> +MODULE_LICENSE("GPL");

