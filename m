Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD36698495
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBOTe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBOTeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:34:25 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA139CC9;
        Wed, 15 Feb 2023 11:34:23 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w11so2083951oiv.5;
        Wed, 15 Feb 2023 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNYnekYPseeQguttIxXvyS88yPC9BRvYp0pTTXRcaPI=;
        b=Bj29XicFXfr9qwUdrSchxSk0CooITWNgZ6gFgNgjEXkqrh0PzFJGSUkJhFpxHXnTTj
         mDlvPbD75XkYLTn3AC/f9RY/CVwkfuccsM9QsT1eqjbW5xtM1CI6nut1Ocq49+jgU2Wa
         rxIlCe7vCXOiH0E73B1zx8XJmxJSC846dR3vM0hNmn+mKydsDaqN2ViujpgLkCPaZxTJ
         pm9CiIEE/pAr4DIL2QAEoiB3+za1szq84WBZ/GMBP72Tl/ZEQnOLncO+BJ/z6RNgCCgz
         0j5yiaKmi8KIbS0Rtt2h7mUAxzOtaYdqW8sdtcASYal3c3tzHbuHh5C3Vi7eGxxTTgYI
         oa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNYnekYPseeQguttIxXvyS88yPC9BRvYp0pTTXRcaPI=;
        b=tS1JLMc+HHftKA16AT1SYTBoPI2UMGmJOklm3psAJ9qxFIYYOSPogPZbKr1j9x4FDY
         Otq3Q3Dv62xiVAKr+v+9B6A6ODUJbMj5VZAfNi2IZQochSUhfugFkZOlj6be+QoG5/ei
         4Dd3wTHWs3d7bTd8eEHjEQXJ4b75CYpW+9b79NHZzpVYu0hzKYPtgRoOu8rCaEmV5Ai5
         HKZb07I64vV/NzG5YvEHX4Br2fkw+tguXj9gp3NNA6Pc8dZAiQdQ8BqGdnuOrsLLbr4E
         ZKT6go5790RoLl/NpyfUvEG4HjprLZBk8mAsEGrOPbWfvdpE9IEuyRnLdp4FuGPbg4Xd
         b1/Q==
X-Gm-Message-State: AO0yUKWsA+T3Qt+J/6U2CgDcJbDQvLEi73hYI9iNfIBpkxD3uqsh8P4f
        MUFG2YpIBKE/+BtoqSGhk8M=
X-Google-Smtp-Source: AK7set+6oHYTJvgeuk7pH52iN5kpEuWxkkzJPuDwWcoEnNv4Ymt/Ek8CctHq+5MFj/E4HSkFvdHYiw==
X-Received: by 2002:a05:6808:112:b0:36e:c24a:a620 with SMTP id b18-20020a056808011200b0036ec24aa620mr1261518oie.1.1676489662813;
        Wed, 15 Feb 2023 11:34:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i126-20020acaea84000000b0037887ca2150sm7600031oih.22.2023.02.15.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:34:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Feb 2023 11:34:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     andybeg <andybeg@gmail.com>
Cc:     jdelvare@suse.com, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: max34409 driver added
Message-ID: <20230215193420.GC3786546@roeck-us.net>
References: <20230215172613.359079-1-andybeg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215172613.359079-1-andybeg@gmail.com>
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

On Wed, Feb 15, 2023 at 08:26:12PM +0300, andybeg wrote:

Subject should be something like: "Add driver for MAX34409"

checkpatch reports:

total: 0 errors, 8 warnings, 12 checks, 256 lines checked

Please fix.

> diff --git a/Documentation/hwmon/max34409.rst b/Documentation/hwmon/max34409.rst
> new file mode 100644
> index 000000000000..91779c6a9163
> --- /dev/null
> +++ b/Documentation/hwmon/max34409.rst
> @@ -0,0 +1,23 @@
> +Kernel driver max34409
> +=====================
> +
> +Supported chips:
> +  * Analog Devices MAX34409
> +    Prefix: 'max34409'
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> +
> +Author: Andrey Kononov <a.kononov@gagarin.me>
> +
> +
> +Description
> +-----------
> +
> +This driver for SMBus Dual/Quad Current Monitor MaximIntegrated MAX34409
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst
> +for details.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 3176c33af6c6..de412f7dcad8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1088,6 +1088,13 @@ config SENSORS_MAX31760
>  	  This driver can also be built as a module. If so, the module
>  	  will be called max31760.
>  
> +config SENSORS_MAX3440X

X -> 9

This driver for sure does not and never will cover all of MAX3440[0-9].

Same for the code itself.

> +	tristate "Maxim max3440x SMBus Dual/Quad Current Monitor"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Maxim family of SMBus Dual/Quad Current Monitors.
> +	  This driver is mutually exclusive with the HWMON version.
> +
>  config SENSORS_MAX6620
>  	tristate "Maxim MAX6620 fan controller"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e2e4e87b282f..a4e24d2b03c1 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
>  obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
>  obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
>  obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
> +obj-$(CONFIG_SENSORS_MAX3440X)  += max3440x.o
>  obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
>  obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
>  obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
> diff --git a/drivers/hwmon/max3440x.c b/drivers/hwmon/max3440x.c
> new file mode 100644
> index 000000000000..b62c34f9425c
> --- /dev/null
> +++ b/drivers/hwmon/max3440x.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> +*
> +*/

Completely useless comment.

> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>

Alphabetic include file order, please.

> +
> +/*
> + * Registers description.
> + */
> +#define MAX3440X_STATUS             0x00
> +#define MAX3440X_CONTROL            0x01
> +#define MAX3440X_OCDELAY            0x02
> +#define MAX3440X_SDDELAY            0x03
> +#define MAX3440X_ADC1               0x04	/* readonly */
> +#define MAX3440X_ADC2               0x05	/* readonly */
> +#define MAX3440X_ADC3               0x06	/* readonly */
> +#define MAX3440X_ADC4               0x07	/* readonly */
> +#define MAX3440X_OCT1               0x08
> +#define MAX3440X_OCT2               0x09
> +#define MAX3440X_OCT3               0x0A
> +#define MAX3440X_OCT4               0x0B
> +#define MAX3440X_DID                0x0C	/* readonly */
> +#define MAX3440X_DCYY               0x0D	/* readonly */
> +#define MAX3440X_DCWW               0x0E    /* readonly */
> +
> +//maximal current in mA throw RSENSE, that can be measured. see datasheet table 18

No C++ comments, please.

> +static unsigned short imax[4];
> +module_param_array(imax, short, NULL, 0);
> +MODULE_PARM_DESC(imax,
> +		 "maximal current in mA throw RSENSE, that can be measured. see datasheet table 18");

This is not an appropriate way to set limits or to provide scaling.
The driver should assume a default for Rsense (such as 1 mOhm),
and possibly provide the ability (via devicetree properties) to
configure actual rsense values. Anything else should be done using
sensors3.conf.

> +struct max3440x_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +	const char *name;

'name' and 'hwmon_dev' are unused.

> +
> +   struct mutex update_lock;
> +   bool valid;
> +

valid is never read and pointless. 

Obviously some formatting problems. See checkpatch output.

> +	u16 adc[4];
> +	u8 oct[4];

'oct' is unused. I assume this is supposed to be for "Over Current Threshold",
which should be implemented as curr[1-4]_max sysfs attributes.

> +};
> +
> +static const char * const input_names[] = {
> +	[MAX3440X_ADC1]	=	"curr1",
> +	[MAX3440X_ADC2]	=	"curr2",
> +	[MAX3440X_ADC3]	=	"curr3",
> +	[MAX3440X_ADC4]	=	"curr4",

Those names have no value. It is obvious that curr1_input is curr1.

> +};
> +
> +static void max3440x_init_client(struct max3440x_data *data,
> +				struct i2c_client *client)
> +{
> +	u8 status;
> +   u16 val = 0;

Pointless initialization

> +	/*
> +	 * Start the conversions.
> +	 */

There is nothing in the datasheet suggesting that it would be necessary
to read the status register to start conversions.

> +	status = i2c_smbus_read_byte_data(client, MAX3440X_STATUS);

Please do not ignore errors. Anyway, "status" is neither used nor saved,
and reading it is thus just pointless.

> +
> +val = (u16)i2c_smbus_read_byte_data(client, MAX3440X_ADC1);
> +	data->adc[0] = DIV_ROUND_CLOSEST((imax[0] * val), 256);
> +	val = i2c_smbus_read_byte_data(client, MAX3440X_ADC2);
> +	data->adc[1] = DIV_ROUND_CLOSEST((imax[1] * val), 256);
> +	val = i2c_smbus_read_byte_data(client, MAX3440X_ADC3);
> +	data->adc[2] = DIV_ROUND_CLOSEST((imax[2] * val), 256);
> +	val = i2c_smbus_read_byte_data(client, MAX3440X_ADC4);
> +	data->adc[3] = DIV_ROUND_CLOSEST((imax[3] * val), 256);

This function for the most part duplicates max3440x_update_device()
and does not add any value.

> +}
> +
> +static struct max3440x_data *max3440x_update_device(struct device *dev)
> +{
> +	struct max3440x_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
> +	u16 val;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	dev_dbg(dev, "Updating max3440 data.\n");
> +	val = (u16)i2c_smbus_read_byte_data(client,
> +				MAX3440X_ADC1);

i2c_smbus_read_byte_data() returns a negative error code. Please
do not ignore.

> +	data->adc[0] = DIV_ROUND_CLOSEST((imax[0] * val), 256);
> +	val =  (u16)i2c_smbus_read_byte_data(client,
> +				MAX3440X_ADC2);
> +	data->adc[1] = DIV_ROUND_CLOSEST((imax[1] * val), 256);
> +	val = (u16)i2c_smbus_read_byte_data(client,
> +				MAX3440X_ADC3);
> +	data->adc[2] = DIV_ROUND_CLOSEST((imax[2] * val), 256);
> +	val = (u16)i2c_smbus_read_byte_data(client,
> +				MAX3440X_ADC4);
> +	data->adc[3] = DIV_ROUND_CLOSEST((imax[3] * val), 256);
> +
> +	data->valid = 1;
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +static ssize_t adc1_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
> +	struct max3440x_data *data = max3440x_update_device(dev);

Reading all sensors to report one is a waste of i2c bandwidth. Please
drop max3440x_update_device() entirely and only read the data for the
sensor which is reported.

> +
> +	return sprintf(buf, "%d\n", data->adc[0]);
> +}
> +static ssize_t adc2_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
> +	struct max3440x_data *data = max3440x_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", data->adc[1]);
> +}
> +static ssize_t adc3_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
> +	struct max3440x_data *data = max3440x_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", data->adc[2]);
> +}
> +static ssize_t adc4_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
> +	struct max3440x_data *data = max3440x_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", data->adc[3]);
> +}
> +
> +static ssize_t label_show(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	return sprintf(buf, "%s\n",
> +		       input_names[to_sensor_dev_attr(devattr)->index]);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(curr1_input, adc1, 0);
> +static SENSOR_DEVICE_ATTR_RO(curr1_label, label, MAX3440X_ADC1);
> +static SENSOR_DEVICE_ATTR_RO(curr2_input, adc2, 0);
> +static SENSOR_DEVICE_ATTR_RO(curr2_label, label, MAX3440X_ADC2);
> +static SENSOR_DEVICE_ATTR_RO(curr3_input, adc3, 0);
> +static SENSOR_DEVICE_ATTR_RO(curr3_label, label, MAX3440X_ADC3);
> +static SENSOR_DEVICE_ATTR_RO(curr4_input, adc4, 0);
> +static SENSOR_DEVICE_ATTR_RO(curr4_label, label, MAX3440X_ADC4);

Not that it matters because you should use the _with_info API, but the
last parameter of SENSOR_DEVICE_ATTR_{RO,RW} is supposed to be the index,
which is supposed to be used by the called function to determine
which of the sensors should be accessed. This means that separate functions
are not necessary.

> +
> +static struct attribute *max3440x_attrs[] = {
> +	&sensor_dev_attr_curr1_input.dev_attr.attr,
> +	&sensor_dev_attr_curr1_label.dev_attr.attr,
> +	&sensor_dev_attr_curr2_input.dev_attr.attr,
> +	&sensor_dev_attr_curr2_label.dev_attr.attr,
> +	&sensor_dev_attr_curr3_input.dev_attr.attr,
> +	&sensor_dev_attr_curr3_label.dev_attr.attr,
> +	&sensor_dev_attr_curr4_input.dev_attr.attr,
> +	&sensor_dev_attr_curr4_label.dev_attr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(max3440x);
> +
> +static int max3440x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct max3440x_data *data;
> +	struct device *hwmon_dev;
> +
> +	data = devm_kzalloc(dev, sizeof(struct max3440x_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	mutex_init(&data->update_lock);
> +
> +	/* Initialize the MAX3440x chip */
> +	max3440x_init_client(data, client);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +							   client->name, data,
> +							   max3440x_groups);

Please rewrite to use devm_hwmon_device_register_with_info().

> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +
> +static const struct i2c_device_id max3440x_id[] = {
> +	{ "max34409", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max3440x_id);
> +
> +static const struct i2c_driver max3440x_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "max3440x",
> +	},
> +	.probe = max3440x_probe,
> +	.id_table	= max3440x_id,
> +};
> +
> +module_i2c_driver(max3440x_driver);
> +
> +MODULE_AUTHOR("Andrey Kononov");
> +MODULE_DESCRIPTION("I2C adc driver");

There is an emphasis on adc, not on hardware monitoring. The limit
registers / attributes are not implemented, and neither is status
reporting, making its value as hwmon driver quite limited.
Are you sure you want/need a hardware monitoring driver ? If this
is just used as an ADC and not as current monitor it may be better
to implement it as an IIO driver.

Guenter

> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
