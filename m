Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAE5F6D8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiJFScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiJFScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:32:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95A15E0F1;
        Thu,  6 Oct 2022 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665081137; x=1696617137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=opqdRbc8ndO9R8WcBmOdSZJq7iJe8FoqT9ZKLh7VEhQ=;
  b=QYjLta35iu9CUdTB4NJqTlMP4QzmQP/RmnHMhTB7KDCmsX+DZodbFjJq
   W9vbXStnXfPvDLUz3SfNuXsK/D2Wq1ytfTkCOu4tnzVqposnyU911OE91
   YdQfAMyZL0jlj5RWTxvecfI1XObVNaRHbv7UvgQMxxs6hw/+fxMOXxVs0
   fx6nHTdD1KEhed0Ng7nbJbpVtAd6OupP+/A1AKp1zN3tF2jVBjwnfmg5p
   zq8Sa+rHWMhp/pZx5ZfOaAqyj0KSDhNRMrxztBJ1SGFzFUCuRSp8NL7qf
   ngH63jWSt1KLrcDhXSRGQD5EMNP/OBtQDdNAjUgkPlRwfSdG7R5I4Zwid
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="305113927"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="305113927"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 11:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="767259763"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="767259763"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2022 11:32:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogVfH-003IGn-2X;
        Thu, 06 Oct 2022 21:32:11 +0300
Date:   Thu, 6 Oct 2022 21:32:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:
> KX022A is a 3-axis accelerometer from ROHM/Kionix. The senosr features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g) and probably some other cool features.
> 
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Important things to be added include the double-tap, motion
> detection and wake-up as well as the runtime power management.
> 
> NOTE: Filling-up the hardware FIFO should be avoided. During my testing
> I noticed that filling up the hardware FIFO might mess-up the sample
> count. My sensor ended up in a state where the amount of data in FIFO was
> reported to be 0xff bytes, which equals to 42,5 samples. Specification
> says the FIFO can hold a maximum of 41 samples in HiRes mode. Also, at
> least once the FIFO was stuck in a state where reading data from
> hardware FIFO did not decrease the amount of data reported to be in the
> FIFO - eg. FIFO was "stuck". The code has now an error count and 10
> reads with invalid FIFO data count will cause the fifo contents to be
> dropped.

...

> +config IIO_KX022A_SPI
> +	tristate "Kionix KX022A tri-axis digital accelerometer"
> +	depends on I2C
> +	select IIO_KX022A
> +	select REGMAP_SPI
> +	help
> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface.

Why it tending to get user to choose Y? It might increase the footprint of
bootable image and on the embedded platforms it may increase the chances
to not fit into (flash) ROM.

Also what will be the module name (see other Kconfig for the pattern)?

> +config IIO_KX022A_I2C
> +	tristate "Kionix KX022A tri-axis digital accelerometer"
> +	depends on I2C
> +	select IIO_KX022A
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface.

Ditto.

...

> +static struct i2c_driver kx022a_i2c_driver = {
> +	.driver = {
> +		.name  = "kx022a-i2c",
> +		.of_match_table = kx022a_of_match,
> +	  },
> +	.probe_new    = kx022a_i2c_probe,
> +};

> +

Redundant blank line.

> +module_i2c_driver(kx022a_i2c_driver);

...

> +static int kx022a_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct regmap *regmap;

Interestingly in the I²C driver you have other style (and I prefer SPI one over
that). Can you fix I²C driver to follow this style?

> +	}

Ditto (blank line).

> +	return kx022a_probe_internal(dev);
> +}

...

> +static struct spi_driver kx022a_spi_driver = {
> +	.driver = {
> +		.name   = "kx022a-spi",
> +		.of_match_table = kx022a_of_match,
> +	},
> +	.probe = kx022a_spi_probe,
> +	.id_table = kx022a_id,
> +};

> +

Redundant blank line.

> +module_spi_driver(kx022a_spi_driver);

...

> +#include <linux/delay.h>

> +#include <linux/gpio.h>

No way. The linux/gpio.h  mustn't appear in the new code.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Can this group be placed after units.h (with blank line in between)?

> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +
> +#include "kionix-kx022a.h"

...

> +/*
> + * Threshold for deciding our HW fifo is unrecoverably corrupt and should be
> + * cleared

Multi-line comments have to follow English grammar and punctuation,
i.e. trailing period.

> + */
> +#define KXO22A_FIFO_ERR_THRESHOLD 10
> +#define KX022A_FIFO_LENGTH 41

Why not to use TAB between definitions and values (also for the rest similar
cases)?

...

> +#define KX022A_FIFO_MAX_BYTES (KX022A_FIFO_LENGTH *			\
> +			       KX022A_FIFO_SAMPLES_SIZE_BYTES)

Slightly better to read:

#define KX022A_FIFO_MAX_BYTES					\
	(KX022A_FIFO_LENGTH * KX022A_FIFO_SAMPLES_SIZE_BYTES)

...

> +#define KX022A_SOFT_RESET_WAIT_TIME_US (5 * KILO)
> +#define KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US (500 * KILO)

For time we have different macros like USEC_PER_MSEC (look into vdso/time64.h).

...

> +const struct regmap_config kx022a_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &kx022a_volatile_regs,
> +	.rd_table = &kx022a_wo_regs,
> +	.wr_table = &kx022a_ro_regs,
> +	.rd_noinc_table = &kx022a_nir_regs,
> +	.precious_table = &kx022a_precious_regs,
> +	.max_register = KX022A_MAX_REGISTER,
> +	.cache_type = REGCACHE_RBTREE,

No max register? Have you tried debugfs output?

> +};
> +EXPORT_SYMBOL_GPL(kx022a_regmap);

Can we use namespace from day 1?

...

> +struct kx022a_data;

Why?

> +struct kx022a_data {
> +	int irq;
> +	int inc_reg;
> +	int ien_reg;

> +	struct regmap *regmap;

Putting this as a first member might improve code by making pointer arithmetics
better. Have you checked possibilities with bloat-o-meter?

> +	struct iio_trigger *trig;
> +	bool trigger_enabled;
> +
> +	struct device *dev;
> +	unsigned int g_range;

> +	struct mutex mutex;

No warning from checkpatch? Every lock should be commented what it is for.

> +	unsigned int state;
> +
> +	int64_t timestamp, old_timestamp;
> +	unsigned int odr_ns;
> +
> +	struct iio_mount_matrix orientation;
> +	u8 watermark;
> +	/* 3 x 16bit accel data + timestamp */
> +	s16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +};

...

> +enum {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +	AXIS_MAX,

No comma for terminator entry.

> +};

...

> +static const unsigned long kx022a_scan_masks[] = {
> +					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +					0};

Seems broken indentation. The }; is better on a new line.

...

> +static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kx022a_get_mount_matrix),

> +	{ },

No comma for the terminator entry.

> +};

...

> +#define KX022A_ACCEL_CHAN(axis, index)						\
> +	{								\
> +		.type = IIO_ACCEL,					\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_shared_by_type_available =			\
> +					BIT(IIO_CHAN_INFO_SCALE) |	\
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.ext_info = kx022a_ext_info,				\
> +		.address = KX022A_REG_##axis##OUT_L,			\
> +		.scan_index = index,					\
> +		.scan_type = {                                          \
> +			.sign = 's',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +			.endianness = IIO_LE,				\
> +		},							\
> +	}

It's fine to indent left by one TAB.

...

> +/*
> + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
> + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
> + * available for higher sample rates. Thus the driver only supports 200 Hz and
> + * slower ODRs. Slowest being 0.78 Hz

Please, check the punctuation.

> + */

...

> +static const int kx022a_accel_samp_freq_table[][2] = {
> +	[0] = { 0, 780000 },
> +	[1] = { 1, 563000 },
> +	[2] = { 3, 125000 },
> +	[3] = { 6, 250000 },
> +	[4] = { 12, 500000 },
> +	[5] = { 25, 0 },
> +	[6] = { 50, 0 },
> +	[7] = { 100, 0 },
> +	[8] = { 200, 0 }

What do you need the indices for? They are not defines, so are you expecting to
shuffle the entries?

> +};

...

> +static const unsigned int kx022a_odrs[] = { 1282051282, 639795266, 320 * MEGA,
> +	 160 * MEGA, 80 * MEGA, 40 * MEGA, 20 * MEGA, 10 * MEGA, 5 * MEGA };

{ and }; on the new line. And I would suggest to group by 4 or 8, that makes it
easier to read / count.

...

> +#define KX022A_DEFAULT_PERIOD_NS (20 * MEGA)

NSEC_PER_MSEC ?

...

> +static int __kx022a_turn_on_unlocked(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL, KX022A_MASK_PC1);
> +	if (ret)
> +		dev_err(data->dev, "Turn ON fail %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int __kx022a_turn_off_unlocked(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL, KX022A_MASK_PC1);
> +	if (ret)
> +		dev_err(data->dev, "Turn OFF fail %d\n", ret);
> +
> +	return ret;
> +}

With making this a single function with a boolean parameter you may utilise

	if (on)
		ret = set
	else
		ret = clear
	if (ret)
		... str_on_off(on)

...

> +	ret = __kx022a_turn_off_unlocked(data);
> +	ret = __kx022a_turn_on_unlocked(data);

Actually having __ and '_unlocked' seems overkill, I would leave one of them.

...

> +		int n = ARRAY_SIZE(kx022a_accel_samp_freq_table);

You may drop {} in each case and have n defined once for all cases.

> +
> +		while (n-- > 0)

while (n--) ? Or why the 0 is ignored?

> +			if (val == kx022a_accel_samp_freq_table[n][0] &&
> +			    kx022a_accel_samp_freq_table[n][1] == val2)
> +				break;

> +		if (n < 0) {

How is it even possible with your conditional?

> +			ret = -EINVAL;
> +			goto unlock_out;
> +		}

...

> +	default:
> +		ret = -EINVAL;

break; ?

...

> +static int kx022a_get_axis(struct kx022a_data *data,
> +			   struct iio_chan_spec const *chan,
> +			   int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
> +			       sizeof(s16));

No endianess awareness (sizeof __le16 / __be16) ?

> +	if (ret)
> +		return ret;
> +
> +	*val = data->buffer[0];

Ditto (get_unaligned_be16/le16 / le16/be16_to_cpup()).

> +	return IIO_VAL_INT;
> +}

...

> +static int kx022a_validate_trigger(struct iio_dev *idev,
> +				   struct iio_trigger *trig)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (data->trig == trig)
> +		return 0;
> +
> +	return -EINVAL;

Usual pattern is to check for error condition first:

	if (... != trig)
		return -E...

	return 0;

> +}

...

> +	if (val > KX022A_FIFO_LENGTH)
> +		val = KX022A_FIFO_LENGTH;

max() from minmax.h?

...

> +	return sprintf(buf, "%d\n", state);

Documentation states it must be sysfs_emit().
Ditto for the rest of the similar cases.

> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       kx022a_get_fifo_state, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       kx022a_get_fifo_watermark, NULL, 0);

_ATTR_RO ?

...

> +static const struct attribute *kx022a_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,

No comma for terminator entry.

> +};

...

> +	/*
> +	 * We must clear the old time-stamp to avoid computing the timestamps
> +	 * based on samples acquired when buffer was last enabled

Period!

> +	 */

...

> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0xff);

GENMASK() ?

...

> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret < 0) {

Is ' < 0' part consistent with the rest of similar checks?

> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}

...

> +	if (data->old_timestamp) {
> +		sample_period = (data->timestamp - data->old_timestamp);

Too many parentheses.

> +		do_div(sample_period, count);
> +	} else {
> +		sample_period = data->odr_ns;
> +	}

...

> +static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
> +{
> +	if (en)
> +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +				       KX022A_MASK_DRDY);

I would put redundant 'else' here to have them on the same column, but
it's pity we don't have regmap_assign_bits() API (or whatever name you
can come up with) to hide this kind of code.

> +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> +				 KX022A_MASK_DRDY);
> +}

...

> +static int kx022a_fifo_enable(struct kx022a_data *data)
> +{
> +	int ret = 0;

Redundant assignment.

> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;

> +}

...

> +	if (!g_kx022a_use_buffer) {
> +		dev_err(data->dev, "Neither trigger set nor hw-fifo enabled\n");

> +

No need in blank line in such cases.

> +		return -EINVAL;
> +	}

Maybe you want to place it here instead?

> +	return kx022a_fifo_enable(data);

...

> +	/*
> +	 * I've seen I2C read failures if we poll too fast after the sensor
> +	 * reset. Slight delay gives I2C block the time to recover.
> +	 */
> +	msleep(1);

msleep(1) is not doing what you think it is. I recommend to use usleep_range()
here.

...

> +int kx022a_probe_internal(struct device *dev)
> +{
> +	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> +	struct iio_trigger *indio_trig;
> +	struct kx022a_data *data;
> +	struct regmap *regmap;
> +	unsigned int chip_id;
> +	struct iio_dev *idev;
> +	int ret, irq;

> +	if (WARN_ON(!dev))

Huh?! This can be easily transformed to panic followed by oops. Why is it
necessary to do so?

> +		return -ENODEV;
> +
> +	regmap = dev_get_regmap(dev, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "no regmap\n");

> +

No blank line here as it's usual pattern in ->probe().

> +		return -EINVAL;
> +	}
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(idev);
> +
> +	/*
> +	 * VDD is the analog and digital domain voltage supply
> +	 * IO_VDD is the digital I/O voltage supply

You know what...

> +	 */
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> +	if (ret) {

> +		dev_err_probe(dev, ret, "Failed to access sensor\n");
> +		return ret;

If you are going to use that, use in a form of

	return dev_err_probe(...);

> +	}
> +
> +	if (chip_id != KX022A_ID) {
> +		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> +		return -EINVAL;
> +	}
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (irq > 0) {
> +		data->inc_reg = KX022A_REG_INC1;
> +		data->ien_reg = KX022A_REG_INC4;
> +	} else {
> +		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "No suitable IRQ\n");

Missed check for 0.

> +		data->inc_reg = KX022A_REG_INC5;
> +		data->ien_reg = KX022A_REG_INC6;
> +	}
> +
> +	data->regmap = regmap;
> +	data->dev = dev;
> +	data->irq = irq;
> +	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
> +	mutex_init(&data->mutex);
> +
> +	idev->channels = kx022a_channels;
> +	idev->num_channels = ARRAY_SIZE(kx022a_channels);
> +	idev->name = "kx022-accel";
> +	idev->info = &kx022a_info;
> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	idev->available_scan_masks = kx022a_scan_masks;
> +
> +	/* Read the mounting matrix, if present */
> +	ret = iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
> +	/* The sensor must be turned off for configuration */
> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = kx022a_chip_init(data);
> +	if (ret) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +
> +	ret = kx022a_turn_on_unlock(data);
> +	if (ret)
> +		return ret;
> +
> +	udelay(100);
> +	ret = devm_iio_triggered_buffer_setup_ext(dev, idev,
> +						  &iio_pollfunc_store_time,
> +						  kx022a_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &kx022a_buffer_ops,
> +						  kx022a_fifo_attributes);
> +
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL %d\n",
> +				     ret);
> +	indio_trig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
> +					    iio_device_id(idev));
> +	if (!indio_trig)
> +		return -ENOMEM;
> +
> +	data->trig = indio_trig;
> +
> +	indio_trig->ops = &kx022a_trigger_ops;
> +	iio_trigger_set_drvdata(indio_trig, data);
> +
> +	ret = devm_iio_trigger_register(dev, indio_trig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +	ret = devm_iio_device_register(data->dev, idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> +					&kx022a_irq_thread_handler,
> +					IRQF_ONESHOT, "kx022", idev);

If you have more than one device, all handlers will be marked with the same
name, perhaps dev_name() is better to have here?

> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +	return ret;
> +}

To me it feels inconsistency to use dev_err_probe() in the cases when
it _might_ be a deferred probe and not use it in the cases we it won't
be a deferred probe.

...

> +module_param(g_kx022a_use_buffer, bool, 0);
> +MODULE_PARM_DESC(g_kx022a_use_buffer,
> +		 "Buffer samples. Use at own risk. Fifo must not overflow");

Why?! We usually do not allow module parameters in the new code.

...

> +#include <linux/regmap.h>

Missed bits.h.

You probably wanted to have

struct device;

as well.

-- 
With Best Regards,
Andy Shevchenko


