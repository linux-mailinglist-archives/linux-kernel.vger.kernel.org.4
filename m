Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB096ADEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjCGMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjCGMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:24:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9437F31;
        Tue,  7 Mar 2023 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678191892; x=1709727892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gcu+E5qYJfV98BPM+GFa1LRfbtFr1k5858cQIYjQGko=;
  b=TUR6ASt+84aq0tYeJnUDZR03gs0+GcG8G/ysCJ1b7e6dA789Hym9fnsT
   6H+W5oWOVxmM07FLikUnLKdact5dltjx+4sGj4EUpaCnNTVatYj0q7rn6
   0zwpkmjEa/78UJVKdvfQgG8okP2sR/SoV2DzLKY91WEAvtBn69EFQrZgd
   YOBsxalRYoHa2fAXCwz9eDgrjsLZC6owndQY8GWw2y0FtYEvjztPgri0j
   wvMMgbPrx9jTjhQfUxSdOKtxFpUVikUL/wPktbdv8hPr5/ETLq7fzuvqK
   CYz0WoiAF0eV4UDad+Yb/zUp31MyB5CddLxeNUoYObE2906nU2qklS4Oq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="319667810"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="319667810"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 04:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="819745083"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="819745083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 04:24:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZWN2-00Guew-2p;
        Tue, 07 Mar 2023 14:24:44 +0200
Date:   Tue, 7 Mar 2023 14:24:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZActDOEsT+tNMfZ1@smile.fi.intel.com>
References: <20230307065535.7927-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.812861c4-ffbd-402e-bb22-77232c1fbafb@emailsignatures365.codetwo.com>
 <20230307065535.7927-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307065535.7927-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:55:34AM +0100, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But see below.

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v5:
> Use scripts/Lindent to auto-format
> Use DIV_ROUNDUP_CLOSEST in gain calculation
> 
> Changes in v4:
> Use post-increment
> Formatting fixes (commas, indents, empty line)
> Use 'ffs' and explain gain formula
> Use dev_set_drvdata/dev_get_drvdata for pm_ methods
> Use units.h for micro-to-milli conversion
> 
> Changes in v3:
> Add #include linux/bitfield.h and linux/bits.h
> 
> Changes in v2:
> Remove "driver for" from title
> Use proper PM_RUNTIME macros
> Fix indents
> Use dev_err_probe()
> Unsigned index and post-increment
> Use GENMASK and FIELD_GET
> remove ads1100_set_conv_mode
> remove Kconfig BUFFER dependencies
> remove unused #include
> Set SCALE instead of HARDWAREGAIN
> Use devm_add_action_or_reset
> 
>  drivers/iio/adc/Kconfig      |  10 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1100.c | 444 +++++++++++++++++++++++++++++++++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1100.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 63f80d747cbd..257efb25a92e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1207,6 +1207,16 @@ config TI_ADS1015
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1015.
>  
> +config TI_ADS1100
> +	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS1100 and
> +	  ADS1000 ADC chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads1100.
> +
>  config TI_ADS7950
>  	tristate "Texas Instruments ADS7950 ADC driver"
>  	depends on SPI && GPIOLIB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 4ef41a7dfac6..61ef600fab99 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> +obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> new file mode 100644
> index 000000000000..ce386c18618f
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -0,0 +1,444 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADS1100 - Texas Instruments Analog-to-Digital Converter
> + *
> + * Copyright (c) 2023, Topic Embedded Products
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/ads1100
> + * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +/* The ADS1100 has a single byte config register */
> +
> +/* Conversion in progress bit */
> +#define ADS1100_CFG_ST_BSY	BIT(7)
> +/* Single conversion bit */
> +#define ADS1100_CFG_SC		BIT(4)
> +/* Data rate */
> +#define ADS1100_DR_MASK		GENMASK(3, 2)
> +/* Gain */
> +#define ADS1100_PGA_MASK	GENMASK(1, 0)
> +
> +#define ADS1100_CONTINUOUS	0
> +#define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
> +
> +#define ADS1100_SLEEP_DELAY_MS	2000
> +
> +static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> +static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
> +
> +struct ads1100_data {
> +	struct i2c_client *client;
> +	struct regulator *reg_vdd;
> +	struct mutex lock;
> +	int scale_avail[2 * 4]; /* 4 gain settings */
> +	u8 config;
> +	bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +};
> +
> +static const struct iio_chan_spec ads1100_channel = {
> +	.type = IIO_VOLTAGE,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_all =
> +	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_shared_by_all_available =
> +	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type = {
> +		      .sign = 's',
> +		      .realbits = 16,
> +		      .storagebits = 16,
> +		      .endianness = IIO_CPU,
> +		       },
> +	.datasheet_name = "AIN",
> +};
> +
> +static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
> +{
> +	int ret;
> +	u8 config = (data->config & ~mask) | (value & mask);
> +
> +	if (data->config == config)
> +		return 0;	/* Already done */
> +
> +	ret = i2c_master_send(data->client, &config, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->config = config;
> +	return 0;
> +};
> +
> +static int ads1100_data_bits(struct ads1100_data *data)
> +{
> +	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +}
> +
> +static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
> +{
> +	int ret;
> +	__be16 buffer;
> +	s16 value;
> +
> +	if (chan != 0)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_resume_and_get(&data->client->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +
> +	pm_runtime_mark_last_busy(&data->client->dev);
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Value is always 16-bit 2's complement */
> +	value = be16_to_cpu(buffer);
> +
> +	/* Shift result to compensate for bit resolution vs. sample rate */
> +	value <<= 16 - ads1100_data_bits(data);
> +
> +	*val = sign_extend32(value, 15);
> +
> +	return 0;
> +}
> +
> +static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
> +{
> +	int microvolts;
> +	int gain;
> +
> +	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
> +	if (val)
> +		return -EINVAL;
> +
> +	if (!val2)
> +		return -EINVAL;
> +
> +	microvolts = regulator_get_voltage(data->reg_vdd);
> +	/*
> +	 * val2 is in 'micro' units, n = val2 / 1000000
> +	 * result must be millivolts, d = microvolts / 1000
> +	 * the full-scale value is d/n, corresponds to 2^15,
> +	 * hence the gain = (d / n) >> 15, factoring out the 1000 and moving the
> +	 * bitshift so everything fits in 32-bits yields this formula.
> +	 */
> +	gain = DIV_ROUND_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
> +	if (gain < BIT(0) || gain > BIT(3))
> +		return -EINVAL;
> +
> +	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
> +	return 0;
> +}
> +
> +static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
> +{
> +	unsigned int i;
> +	unsigned int size;
> +
> +	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> +	for (i = 0; i < size; i++) {
> +		if (ads1100_data_rate[i] == rate)
> +			return ads1100_set_config_bits(data, ADS1100_DR_MASK,

> +						       FIELD_PREP
> +						       (ADS1100_DR_MASK, i));

This is better on a single line.

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
> +{
> +	return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
> +}
> +
> +static void ads1100_calc_scale_avail(struct ads1100_data *data)
> +{
> +	int millivolts = ads1100_get_vdd_millivolts(data);
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
> +		data->scale_avail[i * 2 + 0] = millivolts;
> +		data->scale_avail[i * 2 + 1] = 15 + i;
> +	}
> +}
> +
> +static int ads1100_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = ads1100_data_rate;
> +		if (data->supports_data_rate)
> +			*length = ARRAY_SIZE(ads1100_data_rate);
> +		else
> +			*length = 1;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_FRACTIONAL_LOG2;
> +		*vals = data->scale_avail;
> +		*length = ARRAY_SIZE(data->scale_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads1100_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret;
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			break;
> +
> +		ret = ads1100_get_adc_result(data, chan->address, val);
> +		if (ret >= 0)
> +			ret = IIO_VAL_INT;
> +		iio_device_release_direct_mode(indio_dev);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* full-scale is the supply voltage in millivolts */
> +		*val = ads1100_get_vdd_millivolts(data);
> +		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> +						   data->config)];
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int ads1100_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = ads1100_set_scale(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads1100_set_data_rate(data, chan->address, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ads1100_info = {
> +	.read_avail = ads1100_read_avail,
> +	.read_raw = ads1100_read_raw,
> +	.write_raw = ads1100_write_raw,
> +};
> +
> +static int ads1100_setup(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	/* Setup continuous sampling mode at 8sps */
> +	buffer[0] = ADS1100_DR_MASK | ADS1100_CONTINUOUS;
> +	ret = i2c_master_send(data->client, buffer, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Config register returned in third byte, strip away the busy status */
> +	data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
> +
> +	/* Detect the sample rate capability by checking the DR bits */
> +	data->supports_data_rate = FIELD_GET(ADS1100_DR_MASK, buffer[2]) != 0;
> +
> +	return 0;
> +}
> +
> +static void ads1100_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
> +static void ads1100_disable_continuous(void *data)
> +{
> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
> +}
> +
> +static int ads1100_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1100_data *data;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, data);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "ads1100";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &ads1100_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ads1100_info;
> +
> +	data->reg_vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->reg_vdd))
> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> +				     "Failed to get vdd regulator\n");
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret < 0)
> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> +				     "Failed to enable vdd regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1100_setup(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to communicate with device\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads1100_disable_continuous, data);
> +	if (ret)
> +		return ret;
> +
> +	ads1100_calc_scale_avail(data);
> +
> +	pm_runtime_set_autosuspend_delay(dev, ADS1100_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static int ads1100_runtime_suspend(struct device *dev)
> +{
> +	struct ads1100_data *data = dev_get_drvdata(dev);
> +
> +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
> +	regulator_disable(data->reg_vdd);
> +
> +	return 0;
> +}
> +
> +static int ads1100_runtime_resume(struct device *dev)
> +{
> +	struct ads1100_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to enable Vdd\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * We'll always change the mode bit in the config register, so there is
> +	 * no need here to "force" a write to the config register. If the device
> +	 * has been power-cycled, we'll re-write its config register now.
> +	 */
> +	return ads1100_set_config_bits(data, ADS1100_CFG_SC,
> +				       ADS1100_CONTINUOUS);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
> +				 ads1100_runtime_suspend,
> +				 ads1100_runtime_resume,
> +				 NULL);
> +
> +static const struct i2c_device_id ads1100_id[] = {
> +	{ "ads1100" },
> +	{ "ads1000" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ads1100_id);
> +
> +static const struct of_device_id ads1100_of_match[] = {
> +	{.compatible = "ti,ads1100" },
> +	{.compatible = "ti,ads1000" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ads1100_of_match);
> +
> +static struct i2c_driver ads1100_driver = {
> +	.driver = {
> +		   .name = "ads1100",
> +		   .of_match_table = ads1100_of_match,
> +		   .pm = pm_ptr(&ads1100_pm_ops),
> +		    },
> +	.probe_new = ads1100_probe,
> +	.id_table = ads1100_id,
> +};
> +
> +module_i2c_driver(ads1100_driver);
> +
> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> +MODULE_DESCRIPTION("Texas Instruments ADS1100 ADC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail

-- 
With Best Regards,
Andy Shevchenko


