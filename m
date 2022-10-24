Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCE660A194
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJXL2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJXL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:28:35 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6245AC7C;
        Mon, 24 Oct 2022 04:28:33 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o64so10440989oib.12;
        Mon, 24 Oct 2022 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sf1VrRLjEGKjeCk1tRFXWVoYs9+/Tgacf+92aq6aKFU=;
        b=ZpeSKYjS9ZRzLUM/K5H+bVbOOlU0a7N5QJuHRyvWuPGlyRvSqwaE0Ix7T7tq0ixFVk
         eoHVvskf4Wn0ubVyoz8IsMeGWu3a8QycPPIvbpaWSWWgefHrPvowNzOZ+rO3z4Eu449P
         2C1DJdA/D4aeHzXGP3PQ17cLq/xhs2ZkHE7sPFZ4DnoZOg5t0PIFK65Is7ZHgIfNij9k
         ibNBTW/tuIEmA7osK4ufbJKplBc1UrbVVytSNDC5WRu7Qbxfv8zH65kdDDHR1MJAvAzh
         S62CN7sikWSFZ4OpounHm67/EhXjvAGQ6gjaGIqTNAQqcYcLRadEIWuTysmNA4CHPve7
         2KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sf1VrRLjEGKjeCk1tRFXWVoYs9+/Tgacf+92aq6aKFU=;
        b=r1NzXoJRAbCWy/jLxOaYnri3e73VrfAZzlug1sZJ659PepZOer8B/rL4eHgAYHzgAs
         jbu44niI90dOvbd20fRikFBDYam/dBeSPVrwzMuq/5wBgRCwvIPBHmqJ8f7XzvHbvLTF
         uc1Ke8b4gnmdrVd4OFFOv/qsMFUs3qycC4dXFhpcxnY/CZRSMA+Fjq0uUwQ3GbzdldM+
         ZZ3UU2IJu+rDO4WVhiitlNww1utG9HgkCXaPZpvS9VqGaq7Z1RAgqNbiOMHLNZjI8Tnb
         n0qkeJvfyPl8GdS0jKRmjbGyoof0uQ/s8iUqc84M49zwYxJaiYEhM22EizmZu5KclfIX
         gUFw==
X-Gm-Message-State: ACrzQf18+8O+3LD4GMgdGSHcNL2Ha7gc4FsuSvoykNge1WjSd5B74ia+
        JpXyt3+n7ynEpXu1sZ+Loz1pLyOYpZY=
X-Google-Smtp-Source: AMsMyM4IzmabqBRQUF930h0JULqxsLtFA4255voJ3XOhQ6Y2rSEdraHGNzp+H+FlB5GA+FYhNsbl8A==
X-Received: by 2002:a05:6808:1188:b0:34b:90d1:766 with SMTP id j8-20020a056808118800b0034b90d10766mr15848516oil.167.1666610912705;
        Mon, 24 Oct 2022 04:28:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s41-20020a05680820a900b003458d346a60sm3878497oiw.25.2022.10.24.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:28:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 24 Oct 2022 04:28:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v5] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221024112829.GA2807876@roeck-us.net>
References: <20221024165658.181340-1-rajat.khandelwal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221024165658.181340-1-rajat.khandelwal@linux.intel.com>
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

On Mon, Oct 24, 2022 at 10:26:58PM +0530, Rajat Khandelwal wrote:
> Maxim MAX30208 is a digital temperature sensor with 0.1°C accuracy.
> 
> Add support for max30208 driver in iio subsystem.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Question was:

> with the open question on whether they consider it acceptable for this driver
> to be in IIO. Main argument in favour is it's an expensive clinical grade sensor
> so fairly unlikely to be used in classic hardware monitoring circumstances.

Agreed; the sensor doesn't seem to be very useful for traditional hardware
monitoring. The driver better resides in IIO.

I don't understand why readings are discarded. Why trigger multiple
readings just to discard all but the last one ? I thought iio would
be expected to return all values.

Additional comment inline.

> ---
> 
> v5:
> 1. Fixed comment position in max30208_request
> 2. Use of local u8 variable to build register values
> 3. Using u8 instead of s8 in data_count
> 4. Removed global MAX30208_RES_MILLICELCIUS
> 5. Removed 'comma' on NULL terminators
> 
> v4: Version comments go below line separator of signed-off-by
> 
> v3: Release the mutex lock after error gets returned
> 
> v2:
> 1. Removed TODO
> 2. Removed unnecessary blank spaces
> 3. Corrected MC->MILLICELCIUS
> 4. Comments added wherever required
> 5. dev_err on i2c fails
> 6. Rearranged some flows
> 7. Removed PROCESSED
> 8. int error return on gpio setup
> 9. device_register at the end of probe
> 10. Return on unsuccessful reset
> 11. acpi_match_table and of_match_table added
> 12. Minor quirks
> 
>  MAINTAINERS                        |   6 +
>  drivers/iio/temperature/Kconfig    |  10 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30208.c | 323 +++++++++++++++++++++++++++++
>  4 files changed, 340 insertions(+)
>  create mode 100644 drivers/iio/temperature/max30208.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1390b8270b2..7f1fd2e31b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12373,6 +12373,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
>  F:	drivers/regulator/max20086-regulator.c
>  
> +MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> +M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/temperature/max30208.c
> +
>  MAXIM MAX77650 PMIC MFD DRIVER
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index e8ed849e3b76..ed384f33e0c7 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -128,6 +128,16 @@ config TSYS02D
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys02d.
>  
> +config MAX30208
> +	tristate "Maxim MAX30208 digital temperature sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Maxim MAX30208
> +	  digital temperature sensor connected via I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called max30208.
> +
>  config MAX31856
>  	tristate "MAX31856 thermocouple sensor"
>  	depends on SPI
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index dd08e562ffe0..dfec8c6d3019 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
>  obj-$(CONFIG_LTC2983) += ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> +obj-$(CONFIG_MAX30208) += max30208.o
>  obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MAX31865) += max31865.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
> diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
> new file mode 100644
> index 000000000000..4f78337c78fe
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> + *
> + * Maxim MAX30208 digital temperature sensor with 0.1°C accuracy
> + * (7-bit I2C slave address (0x50 - 0x53))
> + *
> + * Note: This driver sets GPIO1 to behave as input for temperature
> + * conversion and GPIO0 to act as interrupt for temperature conversion.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#define MAX30208_DRV_NAME		"max30208"
> +
> +#define MAX30208_STATUS			0x00
> +#define MAX30208_STATUS_TEMP_RDY	BIT(0)
> +#define MAX30208_INT_ENABLE		0x01
> +#define MAX30208_INT_ENABLE_TEMP_RDY	BIT(0)
> +
> +#define MAX30208_FIFO_OVF_CNTR		0x06
> +#define MAX30208_FIFO_DATA_CNTR		0x07
> +#define MAX30208_FIFO_DATA		0x08
> +
> +#define MAX30208_SYSTEM_CTRL		0x0c
> +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> +
> +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> +
> +#define MAX30208_GPIO_SETUP		0x20
> +#define MAX30208_GPIO1_SETUP		GENMASK(7, 6)
> +#define MAX30208_GPIO0_SETUP		GENMASK(1, 0)
> +#define MAX30208_GPIO_CTRL		0x21
> +#define MAX30208_GPIO1_CTRL		BIT(3)
> +#define MAX30208_GPIO0_CTRL		BIT(0)
> +
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock; /* Lock to prevent concurrent reads */
> +};
> +
> +static const struct iio_chan_spec max30208_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +/**
> + * max30208_request() - Request a reading
> + * @data: Struct comprising member elements of the device
> + *
> + * Requests a reading from the device and waits until the conversion is ready.
> + */
> +static int max30208_request(struct max30208_data *data)
> +{
> +	/*
> +	 * Sensor can take up to 500 ms to respond so execute a total of
> +	 * 10 retries to give the device sufficient time.
> +	 */
> +	int retries = 10;
> +	u8 regval;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg temperature setup\n");
> +		return ret;
> +	}
> +
> +	regval = ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> +

This is really pointless. The register has only one bit to set.
Just write that bit; reading the register before that is pointless. 

Also, the code assumes that one of the gpio input registers would be used
to trigger temperature readings. Why trigger another one if this is indeed
the case ? Triggering a temperature reading should only be necessary if
there is no data in the fifo.

> +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg temperature setup\n");

Not my call to make, but this driver is really noisy.

> +		return ret;
> +	}
> +
> +	while (retries--) {
> +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg status\n");
> +			goto sleep;
> +		}
> +
> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> +			return 0;
> +
> +		msleep(50);
> +	}

The datasheet says that it can take up to 50 ms to report a result.
10 retries with 50ms wait each time seems overkill.

> +	dev_warn(&data->client->dev, "Temperature conversion failed\n");
> +
> +	return 0;
> +
> +sleep:
> +	usleep_range(50000, 60000);
> +	return 0;

Odd error handling. And why use usleep_range() here
but msleep() above ?

> +}
> +
> +static int max30208_update_temp(struct max30208_data *data)
> +{
> +	u8 data_count;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = max30208_request(data);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n");
> +		goto unlock;
> +	} else if (!ret) {
> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       MAX30208_FIFO_DATA_CNTR);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +			goto unlock;
> +		}
> +	}
> +
> +	data_count = ret;

This is wrong. It uses the overflow counter as data counter if it
is != 0. The overflow counter counts the number of overflows, not
the number of entries in the fifo.

> +
> +	/*
> +	 * Ideally, counter should decrease by 1 each time a word is read from FIFO.
> +	 * However, practically, the device behaves erroneously and counter sometimes
> +	 * decreases by more than 1. Hence, do not loop the counter until it becomes 0
> +	 * rather, use the exact counter value after each FIFO word is read.
> +	 * Return the last reading from FIFO as the most recently triggered one.
> +	 */
> +	while (data_count) {
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +						  MAX30208_FIFO_DATA);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
> +			goto unlock;
> +		}
> +
> +		data_count = i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);
> +		if (data_count < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +			ret = data_count;
> +			goto unlock;
> +		}

data_count is declared as u8 and will never be < 0.

> +	}
> +
> +unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int max30208_read(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int *val, int *val2, long mask)
> +{
> +	struct max30208_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max30208_update_temp(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 5;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30208_gpio_setup(struct max30208_data *data)
> +{
> +	u8 regval;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_GPIO_SETUP);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg GPIO setup\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Setting GPIO1 to trigger temperature conversion
> +	 * when driven low.
> +	 * Setting GPIO0 to trigger interrupt when temperature
> +	 * conversion gets completed.
> +	 */
> +	regval = ret | MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					MAX30208_GPIO_SETUP, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg GPIO setup\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_INT_ENABLE);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg interrupt enable\n");
> +		return ret;
> +	}
> +
> +	/* Enabling GPIO0 interrupt */
> +	regval = ret | MAX30208_INT_ENABLE_TEMP_RDY;
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					MAX30208_INT_ENABLE, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg interrupt enable\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info max30208_info = {
> +	.read_raw = max30208_read,
> +};
> +
> +static int max30208_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct max30208_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = i2c;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = MAX30208_DRV_NAME;
> +	indio_dev->channels = max30208_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max30208_channels);
> +	indio_dev->info = &max30208_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Reset the device initially */
> +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> +					MAX30208_SYSTEM_CTRL_RESET);
> +	if (ret) {
> +		dev_err(dev, "Failure in performing reset\n");
> +		return ret;
> +	}
> +
> +	usleep_range(50000, 60000);
> +
> +	ret = max30208_gpio_setup(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max30208_id_table[] = {
> +	{ "max30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> +
> +static const struct acpi_device_id max30208_acpi_match[] = {
> +	{ "MAX30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
> +
> +static const struct of_device_id max30208_of_match[] = {
> +	{ .compatible = "maxim,max30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max30208_of_match);
> +
> +static struct i2c_driver max30208_driver = {
> +	.driver = {
> +		.name = MAX30208_DRV_NAME,
> +		.of_match_table = max30208_of_match,
> +		.acpi_match_table = ACPI_PTR(max30208_acpi_match),
> +	},
> +	.probe_new = max30208_probe,
> +	.id_table = max30208_id_table,
> +};
> +
> +static int __init max30208_init(void)
> +{
> +	return i2c_add_driver(&max30208_driver);
> +}
> +module_init(max30208_init);
> +
> +static void __exit max30208_exit(void)
> +{
> +	i2c_del_driver(&max30208_driver);
> +}
> +module_exit(max30208_exit);
> +
> +MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
> +MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");
> +MODULE_LICENSE("GPL");
