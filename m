Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFC607727
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJUMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJUMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:41:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EE1189529;
        Fri, 21 Oct 2022 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666356112; x=1697892112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bou6DyskOER+ntSIc4LJoiabSHGa9sVAQRO2wNo043U=;
  b=a0YwuDupPAX0BnAvHz0ooYpgI5DJo8f59HdkBwX3dE9N/HMUoFTTZ+2D
   4yYLI5i+whAJ+WqXtC8SA95WK6hRQYcIRIy/WAnBlUXg3r1YE1yxQAhDa
   ISy6g4orl+N4liv5mFQhtGdtJZ+nLmQZyiOnSUFPn4NdvD6vx5J6pi4nq
   uHCdFk0xxVD9Yhcx2q68qU5uzu14oHY59ZoCPTXmkR7pl4+o5u8U7i8gJ
   nF5uu9l3OUhUA49L6svxf6l115XbZH8U55v7no/n8gpt0zjo8pb3cH1pU
   uCJVTq8xYf6HyCztwD4Jf2pRZ+EJzK+fZBKNAjuOm4wyncDuxnqcRULId
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308091974"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="308091974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 05:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581571664"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="581571664"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2022 05:41:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olrLN-00B9ns-1R;
        Fri, 21 Oct 2022 15:41:45 +0300
Date:   Fri, 21 Oct 2022 15:41:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y1KTibIKKz/KdJDj@smile.fi.intel.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:22:49PM +0300, Matti Vaittinen wrote:
> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g), and probably some other cool features.
> 
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Important things to be added include the double-tap, motion
> detection and wake-up as well as the runtime power management.

While I have some disagreements on some code
pieces, this version is okay to go I think.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Below a few nit-picks in case it needs to be a v5.

> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> v3 => v4 fixes suggested by Andy:
> - styling changes
> - use str_on_off()
> - drop check for !dev
> - drop adding return value to print printed using dev_err_probe()
> - use dev_err_probe() in SPI/I2C drivers too
> - fix IRQ thread return value
> 
> v2 => v3 Mostly fixes suggested by Andy
> - styling issues
> - spell-checks
> - use namespaces for exported symbols
> - drop module param
> - document the lock
> - change value written when clearing fifo
> - drop WARN_ON()
> - correctly check the return value from fwnode_irq_get_byname()
> - do not emphasize config Y over M
> - reorder struct kx022a_data from potential optimization
> - IIO_DEVICE_ATTR_RO instead of IIO_DEVICE_ATTR where applicable
> - directly include bits.h for BIT()
> - use sysfs_emit() for sysfs
> - use unique name for IRQ
> - convert read_raw() values to CPU endianess
> - fix HW-fifo size to 258 bytes
> - kx022a-spi, Fix kconfig dependency
> - disable irq (to protect timestamp / sample amount calculation) when the
>   fifo flush is iniriated by user-space
> 
> RFCv1 => v2 (mostly based on feedback from Jonathan):
> - Fix bunch of typos from the commit message.
> - Add missing break; to the kx022a_write_raw()
> - Fix SPI driver to use of_match_table
> - Fix indentiation in I2C driver
> - Drop struct kx022a_trigger
> - Drop cross references from Kconfig
> - Use /* */ also in file header comments
> - Misc minor styling
> - Do sensor-reset at probe
> - Support both IRQ pins
> - Implement read_avail callback
> - Use dma aligned buffers for bulk-reads
> - Use iio_trigger_poll_chained()
> - Use devm consistently
> - Drop inclusion of device.h
> - Add SPI device ID for module loading
> - Add module param for hw fifo / watermark IRQ usage
> - Fix io-vdd-supply name to match one in the bindings
> ---
>  drivers/iio/accel/Kconfig             |   21 +
>  drivers/iio/accel/Makefile            |    3 +
>  drivers/iio/accel/kionix-kx022a-i2c.c |   51 ++
>  drivers/iio/accel/kionix-kx022a-spi.c |   58 ++
>  drivers/iio/accel/kionix-kx022a.c     | 1145 +++++++++++++++++++++++++
>  drivers/iio/accel/kionix-kx022a.h     |   82 ++
>  6 files changed, 1360 insertions(+)
>  create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index ffac66db7ac9..b7fd054819d2 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -409,6 +409,27 @@ config IIO_ST_ACCEL_SPI_3AXIS
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called st_accel_spi.
>  
> +config IIO_KX022A
> +	tristate
> +
> +config IIO_KX022A_SPI
> +	tristate "Kionix KX022A tri-axis digital accelerometer"
> +	depends on SPI
> +	select IIO_KX022A
> +	select REGMAP_SPI
> +	help
> +	  Enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface.
> +
> +config IIO_KX022A_I2C
> +	tristate "Kionix KX022A tri-axis digital accelerometer"
> +	depends on I2C
> +	select IIO_KX022A
> +	select REGMAP_I2C
> +	help
> +	  Enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface.
> +
>  config KXSD9
>  	tristate "Kionix KXSD9 Accelerometer Driver"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 5e45b5fa5ab5..311ead9c3ef1 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -40,6 +40,9 @@ obj-$(CONFIG_FXLS8962AF)	+= fxls8962af-core.o
>  obj-$(CONFIG_FXLS8962AF_I2C)	+= fxls8962af-i2c.o
>  obj-$(CONFIG_FXLS8962AF_SPI)	+= fxls8962af-spi.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
> +obj-$(CONFIG_IIO_KX022A)	+= kionix-kx022a.o
> +obj-$(CONFIG_IIO_KX022A_I2C)	+= kionix-kx022a-i2c.o
> +obj-$(CONFIG_IIO_KX022A_SPI)	+= kionix-kx022a-spi.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
>  obj-$(CONFIG_KXSD9_SPI)	+= kxsd9-spi.o
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> new file mode 100644
> index 000000000000..6510f8d62b85
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 ROHM Semiconductors
> + *
> + * ROHM/KIONIX KX022A accelerometer driver
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "kionix-kx022a.h"
> +
> +static int kx022a_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct regmap *regmap;
> +
> +	if (!i2c->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	return kx022a_probe_internal(dev);
> +}
> +
> +static const struct of_device_id kx022a_of_match[] = {
> +	{ .compatible = "kionix,kx022a", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kx022a_of_match);
> +
> +static struct i2c_driver kx022a_i2c_driver = {
> +	.driver = {
> +		.name  = "kx022a-i2c",
> +		.of_match_table = kx022a_of_match,
> +	  },
> +	.probe_new    = kx022a_i2c_probe,
> +};
> +module_i2c_driver(kx022a_i2c_driver);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(KIONIX_ACCEL);
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> new file mode 100644
> index 000000000000..7fe3b0aba1fe
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 ROHM Semiconductors
> + *
> + * ROHM/KIONIX KX022A accelerometer driver
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "kionix-kx022a.h"
> +
> +static int kx022a_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct regmap *regmap;
> +
> +	if (!spi->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	return kx022a_probe_internal(dev);
> +}
> +
> +static const struct spi_device_id kx022a_id[] = {
> +	{ "kx022a" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, kx022a_id);
> +
> +static const struct of_device_id kx022a_of_match[] = {
> +	{ .compatible = "kionix,kx022a", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kx022a_of_match);
> +
> +static struct spi_driver kx022a_spi_driver = {
> +	.driver = {
> +		.name   = "kx022a-spi",
> +		.of_match_table = kx022a_of_match,
> +	},
> +	.probe = kx022a_spi_probe,
> +	.id_table = kx022a_id,
> +};
> +module_spi_driver(kx022a_spi_driver);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix kx022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(KIONIX_ACCEL);
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> new file mode 100644
> index 000000000000..5a8622c8127b
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -0,0 +1,1145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 ROHM Semiconductors
> + *
> + * ROHM/KIONIX KX022A accelerometer driver
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/string_helpers.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include "kionix-kx022a.h"
> +
> +/*
> + * The KX022A has FIFO which can store 43 samples of HiRes data from 2
> + * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
> + * 258 bytes of sample data. The quirk to know is that the amount of bytes in
> + * the FIFO is advertised via 8 bit register (max value 255). The thing to note
> + * is that full 258 bytes of data is indicated using the max value 255.
> + */
> +#define KX022A_FIFO_LENGTH			43
> +#define KX022A_FIFO_FULL_VALUE			255
> +#define KX022A_SOFT_RESET_WAIT_TIME_US		(5 * USEC_PER_MSEC)
> +#define KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US	(500 * USEC_PER_MSEC)
> +
> +/* 3 axis, 2 bytes of data for each of the axis */
> +#define KX022A_FIFO_SAMPLES_SIZE_BYTES		6
> +#define KX022A_FIFO_MAX_BYTES					\
> +	(KX022A_FIFO_LENGTH * KX022A_FIFO_SAMPLES_SIZE_BYTES)
> +
> +enum {
> +	KX022A_STATE_SAMPLE,
> +	KX022A_STATE_FIFO,
> +};
> +
> +/* Regmap configs */
> +static const struct regmap_range kx022a_volatile_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_XHP_L,
> +		.range_max = KX022A_REG_COTR,
> +	}, {
> +		.range_min = KX022A_REG_TSCP,
> +		.range_max = KX022A_REG_INT_REL,
> +	}, {
> +		/* The reset bit will be cleared by sensor */
> +		.range_min = KX022A_REG_CNTL2,
> +		.range_max = KX022A_REG_CNTL2,
> +	}, {
> +		.range_min = KX022A_REG_BUF_STATUS_1,
> +		.range_max = KX022A_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_volatile_regs = {
> +	.yes_ranges = &kx022a_volatile_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx022a_volatile_ranges),
> +};
> +
> +static const struct regmap_range kx022a_precious_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_INT_REL,
> +		.range_max = KX022A_REG_INT_REL,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_precious_regs = {
> +	.yes_ranges = &kx022a_precious_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx022a_precious_ranges),
> +};
> +
> +/*
> + * The HW does not set WHO_AM_I reg as read-only but we don't want to write it
> + * so we still include it in the read-only ranges.
> + */
> +static const struct regmap_range kx022a_read_only_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_XHP_L,
> +		.range_max = KX022A_REG_INT_REL,
> +	}, {
> +		.range_min = KX022A_REG_BUF_STATUS_1,
> +		.range_max = KX022A_REG_BUF_STATUS_2,
> +	}, {
> +		.range_min = KX022A_REG_BUF_READ,
> +		.range_max = KX022A_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_ro_regs = {
> +	.no_ranges = &kx022a_read_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx022a_read_only_ranges),
> +};
> +
> +static const struct regmap_range kx022a_write_only_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_BTS_WUF_TH,
> +		.range_max = KX022A_REG_BTS_WUF_TH,
> +	}, {
> +		.range_min = KX022A_REG_MAN_WAKE,
> +		.range_max = KX022A_REG_MAN_WAKE,
> +	}, {
> +		.range_min = KX022A_REG_SELF_TEST,
> +		.range_max = KX022A_REG_SELF_TEST,
> +	}, {
> +		.range_min = KX022A_REG_BUF_CLEAR,
> +		.range_max = KX022A_REG_BUF_CLEAR,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_wo_regs = {
> +	.no_ranges = &kx022a_write_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx022a_write_only_ranges),
> +};
> +
> +static const struct regmap_range kx022a_noinc_read_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_BUF_READ,
> +		.range_max = KX022A_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_nir_regs = {
> +	.yes_ranges = &kx022a_noinc_read_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
> +};
> +
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
> +};
> +EXPORT_SYMBOL_NS_GPL(kx022a_regmap, KIONIX_ACCEL);
> +
> +struct kx022a_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct device *dev;
> +	struct iio_mount_matrix orientation;
> +	int64_t timestamp, old_timestamp;
> +
> +	int irq;
> +	int inc_reg;
> +	int ien_reg;
> +
> +	unsigned int g_range;
> +	unsigned int state;
> +	unsigned int odr_ns;
> +
> +	bool trigger_enabled;
> +	/*
> +	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
> +	 * middle of a configuration, or when the fifo is enabled. Also,
> +	 * protect the data stored/retrieved from this structure from
> +	 * concurrent accesses.
> +	 */
> +	struct mutex mutex;
> +	u8 watermark;
> +
> +	/* 3 x 16bit accel data + timestamp */
> +	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +};
> +
> +static const struct iio_mount_matrix *
> +kx022a_get_mount_matrix(const struct iio_dev *idev,
> +			const struct iio_chan_spec *chan)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	return &data->orientation;
> +}
> +
> +enum {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +	AXIS_MAX
> +};
> +
> +static const unsigned long kx022a_scan_masks[] = {
> +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z), 0
> +};
> +
> +static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kx022a_get_mount_matrix),
> +	{ }
> +};
> +
> +#define KX022A_ACCEL_CHAN(axis, index)						\
> +{								\
> +	.type = IIO_ACCEL,					\
> +	.modified = 1,						\
> +	.channel2 = IIO_MOD_##axis,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.info_mask_shared_by_type_available =			\
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.ext_info = kx022a_ext_info,				\
> +	.address = KX022A_REG_##axis##OUT_L,			\
> +	.scan_index = index,					\
> +	.scan_type = {                                          \
> +		.sign = 's',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_LE,				\
> +	},							\
> +}
> +
> +static const struct iio_chan_spec kx022a_channels[] = {
> +	KX022A_ACCEL_CHAN(X, 0),
> +	KX022A_ACCEL_CHAN(Y, 1),
> +	KX022A_ACCEL_CHAN(Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +/*
> + * The sensor HW can support ODR up to 1600 Hz, which is beyond what most of the
> + * Linux CPUs can handle without dropping samples. Also, the low power mode is
> + * not available for higher sample rates. Thus, the driver only supports 200 Hz
> + * and slower ODRs. The slowest is 0.78 Hz.
> + */
> +static const int kx022a_accel_samp_freq_table[][2] = {
> +	{ 0, 780000 },
> +	{ 1, 563000 },
> +	{ 3, 125000 },
> +	{ 6, 250000 },
> +	{ 12, 500000 },
> +	{ 25, 0 },
> +	{ 50, 0 },
> +	{ 100, 0 },
> +	{ 200, 0 },
> +};
> +
> +static const unsigned int kx022a_odrs[] = {
> +	1282051282,
> +	639795266,
> +	320 * MEGA,
> +	160 * MEGA,
> +	80 * MEGA,
> +	40 * MEGA,
> +	20 * MEGA,
> +	10 * MEGA,
> +	5 * MEGA,
> +};
> +
> +/*
> + * range is typically +-2G/4G/8G/16G, distributed over the amount of bits.
> + * The scale table can be calculated using
> + *	(range / 2^bits) * g = (range / 2^bits) * 9.80665 m/s^2
> + *	=> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are zeroed
> + *	in low-power mode(?) )
> + *	=> +/-2G  => 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
> + *	=> +/-2G  - 598.550415
> + *	   +/-4G  - 1197.10083
> + *	   +/-8G  - 2394.20166
> + *	   +/-16G - 4788.40332
> + */
> +static const int kx022a_scale_table[][2] = {
> +	{ 598, 550415 },
> +	{ 1197, 100830 },
> +	{ 2394, 201660 },
> +	{ 4788, 403320 },
> +};
> +
> +static int kx022a_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)kx022a_accel_samp_freq_table;
> +		*length = ARRAY_SIZE(kx022a_accel_samp_freq_table) *
> +			  ARRAY_SIZE(kx022a_accel_samp_freq_table[0]);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)kx022a_scale_table;
> +		*length = ARRAY_SIZE(kx022a_scale_table) *
> +			  ARRAY_SIZE(kx022a_scale_table[0]);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define KX022A_DEFAULT_PERIOD_NS (20 * NSEC_PER_MSEC)
> +
> +static void kx022a_reg2freq(unsigned int val,  int *val1, int *val2)
> +{
> +	*val1 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][0];
> +	*val2 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][1];
> +}
> +
> +static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
> +			     unsigned int *val2)
> +{
> +	val &= KX022A_MASK_GSEL;
> +	val >>= KX022A_GSEL_SHIFT;
> +
> +	*val1 = kx022a_scale_table[val][0];
> +	*val2 = kx022a_scale_table[val][1];
> +}
> +
> +static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
> +{
> +	int ret;
> +
> +	if (on)
> +		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +				      KX022A_MASK_PC1);
> +	else
> +		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> +					KX022A_MASK_PC1);
> +	if (ret)
> +		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
> +
> +	return ret;
> +
> +}
> +
> +static int kx022a_turn_off_lock(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = kx022a_turn_on_off_unlocked(data, false);
> +	if (ret)
> +		mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_turn_on_unlock(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	ret = kx022a_turn_on_off_unlocked(data, true);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_write_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	int ret, n;
> +
> +	/*
> +	 * We should not allow changing scale or frequency when FIFO is running
> +	 * as it will mess the timestamp/scale for samples existing in the
> +	 * buffer. If this turns out to be an issue we can later change logic
> +	 * to internally flush the fifo before reconfiguring so the samples in
> +	 * fifo keep matching the freq/scale settings. (Such setup could cause
> +	 * issues if users trust the watermark to be reached within known
> +	 * time-limit).
> +	 */
> +	ret = iio_device_claim_direct_mode(idev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
> +
> +		while (n--)
> +			if (val == kx022a_accel_samp_freq_table[n][0] &&
> +			    val2 == kx022a_accel_samp_freq_table[n][1])
> +				break;
> +		if (n < 0) {
> +			ret = -EINVAL;
> +			goto unlock_out;
> +		}
> +		ret = kx022a_turn_off_lock(data);
> +		if (ret)
> +			break;
> +
> +		ret = regmap_update_bits(data->regmap,
> +					 KX022A_REG_ODCNTL,
> +					 KX022A_MASK_ODR, n);
> +		data->odr_ns = kx022a_odrs[n];
> +		kx022a_turn_on_unlock(data);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		n = ARRAY_SIZE(kx022a_scale_table);
> +
> +		while (n-- > 0)
> +			if (val == kx022a_scale_table[n][0] &&
> +			    val2 == kx022a_scale_table[n][1])
> +				break;
> +		if (n < 0) {
> +			ret = -EINVAL;
> +			goto unlock_out;
> +		}
> +
> +		ret = kx022a_turn_off_lock(data);
> +		if (ret)
> +			break;
> +
> +		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
> +					 KX022A_MASK_GSEL,
> +					 n << KX022A_GSEL_SHIFT);
> +		kx022a_turn_on_unlock(data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +unlock_out:
> +	iio_device_release_direct_mode(idev);
> +
> +	return ret;
> +}
> +
> +static int kx022a_fifo_set_wmi(struct kx022a_data *data)
> +{
> +	u8 threshold;
> +
> +	threshold = data->watermark;
> +
> +	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
> +				  KX022A_MASK_WM_TH, threshold);
> +}
> +
> +static int kx022a_get_axis(struct kx022a_data *data,
> +			   struct iio_chan_spec const *chan,
> +			   int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer[0],
> +			       sizeof(__le16));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(data->buffer[0]);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int kx022a_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	unsigned int regval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->mutex);
> +		ret = kx022a_get_axis(data, chan, val);
> +		mutex_unlock(&data->mutex);
> +
> +		iio_device_release_direct_mode(idev);
> +
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
> +		if (ret)
> +			return ret;
> +
> +		if ((regval & KX022A_MASK_ODR) >
> +		    ARRAY_SIZE(kx022a_accel_samp_freq_table)) {
> +			dev_err(data->dev, "Invalid ODR\n");
> +			return -EINVAL;
> +		}
> +
> +		kx022a_reg2freq(regval, val, val2);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
> +		if (ret < 0)
> +			return ret;
> +
> +		kx022a_reg2scale(regval, val, val2);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +};
> +
> +static int kx022a_validate_trigger(struct iio_dev *idev,
> +				   struct iio_trigger *trig)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (data->trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (val > KX022A_FIFO_LENGTH)
> +		val = KX022A_FIFO_LENGTH;
> +
> +	mutex_lock(&data->mutex);
> +	data->watermark = val;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static ssize_t hwfifo_enabled_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct iio_dev *idev = dev_to_iio_dev(dev);
> +	struct kx022a_data *data = iio_priv(idev);
> +	bool state;
> +
> +	mutex_lock(&data->mutex);
> +	state = data->state;
> +	mutex_unlock(&data->mutex);
> +
> +	return sysfs_emit(buf, "%d\n", state);
> +}
> +
> +static ssize_t hwfifo_watermark_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct iio_dev *idev = dev_to_iio_dev(dev);
> +	struct kx022a_data *data = iio_priv(idev);
> +	int wm;
> +
> +	mutex_lock(&data->mutex);
> +	wm = data->watermark;
> +	mutex_unlock(&data->mutex);
> +
> +	return sysfs_emit(buf, "%d\n", wm);
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
> +
> +static const struct attribute *kx022a_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL
> +};
> +
> +static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> +{
> +	/*
> +	 * We must clear the old time-stamp to avoid computing the timestamps
> +	 * based on samples acquired when buffer was last enabled.
> +	 *
> +	 * We don't need to protect the timestamp as long as we are only
> +	 * called from fifo-disable where we can guarantee the sensor is not
> +	 * triggering interrupts and where the mutex is locked to prevent the
> +	 * user-space access.
> +	 */
> +	data->timestamp = 0;
> +
> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> +}
> +
> +static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> +			       bool irq)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u16 buffer[KX022A_FIFO_LENGTH * 3];
> +	uint64_t sample_period;
> +	int count, fifo_bytes;
> +	bool renable = false;
> +	int64_t tstamp;
> +	int ret, i;
> +
> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	/* Let's not overflow if we for some reason get bogus value from i2c */
> +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> +
> +	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
> +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> +
> +	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	if (!count)
> +		return 0;
> +
> +	/*
> +	 * If we are being called from IRQ handler we know the stored timestamp
> +	 * is fairly accurate for the last stored sample. Otherwise, if we are
> +	 * called as a result of a read operation from userspace and hence
> +	 * before the watermark interrupt was triggered, take a timestamp
> +	 * now. We can fall anywhere in between two samples so the error in this
> +	 * case is at most one sample period.
> +	 */
> +	if (!irq) {
> +		/*
> +		 * We need to have the IRQ disabled or we risk of messing-up
> +		 * the timestamps. If we are ran from IRQ, then the
> +		 * IRQF_ONESHOT has us covered - but if we are ran by the
> +		 * user-space read we need to disable the IRQ to be on a safe
> +		 * side. We do this usng synchronous disable so that if the
> +		 * IRQ thread is being ran on other CPU we wait for it to be
> +		 * finished.
> +		 */
> +		disable_irq(data->irq);
> +		renable = true;
> +
> +		data->old_timestamp = data->timestamp;
> +		data->timestamp = iio_get_time_ns(idev);
> +	}
> +
> +	/*
> +	 * Approximate timestamps for each of the sample based on the sampling
> +	 * frequency, timestamp for last sample and number of samples.
> +	 *
> +	 * We'd better not use the current bandwidth settings to compute the
> +	 * sample period. The real sample rate varies with the device and
> +	 * small variation adds when we store a large number of samples.
> +	 *
> +	 * To avoid this issue we compute the actual sample period ourselves
> +	 * based on the timestamp delta between the last two flush operations.
> +	 */
> +	if (data->old_timestamp) {
> +		sample_period = data->timestamp - data->old_timestamp;
> +		do_div(sample_period, count);
> +	} else {
> +		sample_period = data->odr_ns;
> +	}
> +	tstamp = data->timestamp - (count - 1) * sample_period;
> +
> +	if (samples && count > samples) {
> +		/*
> +		 * Here we leave some old samples to the buffer. We need to
> +		 * adjust the timestamp to match the first sample in the buffer
> +		 * or we will miscalculate the sample_period at next round.
> +		 */
> +		data->timestamp -= (count - samples) * sample_period;
> +		count = samples;
> +	}
> +
> +	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> +				buffer, fifo_bytes);
> +	if (ret)
> +		goto renable_out;
> +
> +	for (i = 0; i < count; i++) {
> +		u16 *sam = &buffer[i * 3];
> +		__le16 *chs;
> +		int bit;
> +
> +		chs = &data->scan.channels[0];
> +		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
> +			memcpy(&chs[bit], &sam[bit], sizeof(*chs));
> +
> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +
> +		tstamp += sample_period;
> +	}
> +
> +	ret = count;
> +
> +renable_out:
> +	if (renable)
> +		enable_irq(data->irq);
> +
> +	return ret;
> +}
> +
> +static int kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = __kx022a_fifo_flush(idev, samples, false);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info kx022a_info = {
> +	.read_raw = &kx022a_read_raw,
> +	.write_raw = &kx022a_write_raw,
> +	.read_avail = &kx022a_read_avail,
> +
> +	.validate_trigger	= kx022a_validate_trigger,
> +	.hwfifo_set_watermark	= kx022a_set_watermark,
> +	.hwfifo_flush_to_buffer	= kx022a_fifo_flush,
> +};
> +
> +static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
> +{
> +	if (en)
> +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +				       KX022A_MASK_DRDY);
> +
> +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> +				 KX022A_MASK_DRDY);
> +}
> +
> +static int kx022a_prepare_irq_pin(struct kx022a_data *data)
> +{
> +	/* Enable IRQ1 pin. Set polarity to active low */
> +	int mask = KX022A_MASK_IEN | KX022A_MASK_IPOL |
> +		   KX022A_MASK_ITYP;
> +	int val = KX022A_MASK_IEN | KX022A_IPOL_LOW |
> +		  KX022A_ITYP_LEVEL;
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, data->inc_reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* We enable WMI to IRQ pin only at buffer_enable */
> +	mask = KX022A_MASK_INS2_DRDY;
> +
> +	return regmap_set_bits(data->regmap, data->ien_reg, mask);
> +}
> +
> +static int kx022a_fifo_disable(struct kx022a_data *data)
> +{
> +	int ret = 0;
> +
> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(data->regmap, data->ien_reg, KX022A_MASK_WMI);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +				KX022A_MASK_BUF_EN);
> +	if (ret)
> +		goto unlock_out;

> +	data->state &= (~KX022A_STATE_FIFO);

Too many parentheses.

> +	kx022a_drop_fifo_contents(data);
> +
> +	return kx022a_turn_on_unlock(data);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_buffer_predisable(struct iio_dev *idev)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	return kx022a_fifo_disable(data);
> +}
> +
> +static int kx022a_fifo_enable(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	/* Update watermark to HW */
> +	ret = kx022a_fifo_set_wmi(data);
> +	if (ret)
> +		goto unlock_out;
> +
> +	/* Enable buffer */
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +			      KX022A_MASK_BUF_EN);
> +	if (ret)
> +		goto unlock_out;
> +
> +	data->state |= KX022A_STATE_FIFO;
> +	ret = regmap_set_bits(data->regmap, data->ien_reg,
> +			      KX022A_MASK_WMI);
> +	if (ret)
> +		goto unlock_out;
> +
> +	return kx022a_turn_on_unlock(data);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_buffer_postenable(struct iio_dev *idev)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	/*
> +	 * If we use data-ready trigger, then the IRQ masks should be handled by
> +	 * trigger enable and the hardware buffer is not used but we just update
> +	 * results to the IIO fifo when data-ready triggers.
> +	 */
> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	return kx022a_fifo_enable(data);
> +}
> +
> +static const struct iio_buffer_setup_ops kx022a_buffer_ops = {
> +	.postenable = kx022a_buffer_postenable,
> +	.predisable = kx022a_buffer_predisable,
> +};
> +
> +static irqreturn_t kx022a_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct kx022a_data *data = iio_priv(idev);
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
> +			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Get timestamps and wake the thread if we need to read data */
> +static irqreturn_t kx022a_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	data->old_timestamp = data->timestamp;
> +	data->timestamp = iio_get_time_ns(idev);
> +
> +	if (data->state & KX022A_STATE_FIFO || data->trigger_enabled)
> +		return IRQ_WAKE_THREAD;
> +
> +	return IRQ_NONE;
> +}
> +
> +/*
> + * WMI and data-ready IRQs are acked when results are read. If we add
> + * TILT/WAKE or other IRQs - then we may need to implement the acking
> + * (which is racy).
> + */
> +static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct kx022a_data *data = iio_priv(idev);

> +	int ret = IRQ_NONE;

Strictly speaking this should be

	irqreturn_t ret = ...

> +	mutex_lock(&data->mutex);
> +
> +	if (data->trigger_enabled) {
> +		iio_trigger_poll_chained(data->trig);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (data->state & KX022A_STATE_FIFO) {
> +		int ok;
> +
> +		ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
> +		if (ok > 0)
> +			ret = IRQ_HANDLED;
> +	}
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_trigger_set_state(struct iio_trigger *trig,
> +				    bool state)
> +{
> +	struct kx022a_data *data = iio_trigger_get_drvdata(trig);
> +	int ret = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (data->trigger_enabled == state)
> +		goto unlock_out;
> +
> +	if (data->state & KX022A_STATE_FIFO) {
> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	ret = kx022a_turn_on_off_unlocked(data, false);
> +	if (ret)
> +		goto unlock_out;
> +
> +	data->trigger_enabled = state;
> +	ret = kx022a_set_drdy_irq(data, state);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = kx022a_turn_on_off_unlocked(data, true);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops kx022a_trigger_ops = {
> +	.set_trigger_state = kx022a_trigger_set_state,
> +};
> +
> +static int kx022a_chip_init(struct kx022a_data *data)
> +{
> +	int ret, val;
> +
> +	/* Reset the senor */
> +	ret = regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * I've seen I2C read failures if we poll too fast after the sensor
> +	 * reset. Slight delay gives I2C block the time to recover.
> +	 */
> +	msleep(1);
> +
> +	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
> +				       !(val & KX022A_MASK_SRST),
> +				       KX022A_SOFT_RESET_WAIT_TIME_US,
> +				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
> +	if (ret) {
> +		dev_err(data->dev, "Sensor reset %s\n",
> +			val & KX022A_MASK_SRST ? "timeout" : "fail#");
> +		return ret;
> +	}
> +
> +	ret = regmap_reinit_cache(data->regmap, &kx022a_regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to reinit reg cache\n");
> +		return ret;
> +	}
> +
> +	/* set data res 16bit */
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +			      KX022A_MASK_BRES16);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to set data resolution\n");
> +		return ret;
> +	}
> +
> +	return kx022a_prepare_irq_pin(data);
> +}
> +
> +int kx022a_probe_internal(struct device *dev)
> +{
> +	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> +	struct iio_trigger *indio_trig;
> +	struct fwnode_handle *fwnode;
> +	struct kx022a_data *data;
> +	struct regmap *regmap;
> +	unsigned int chip_id;
> +	struct iio_dev *idev;
> +	int ret, irq;
> +	char *name;
> +
> +	regmap = dev_get_regmap(dev, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "no regmap\n");
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
> +	 * VDD is the analog and digital domain voltage supply and
> +	 * IO_VDD is the digital I/O voltage supply.
> +	 */
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> +
> +	if (chip_id != KX022A_ID) {
> +		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> +		return -EINVAL;
> +	}

> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;

You can do it before allocating any of the resources, so it will bail out
earlier with less potential issues.

> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq > 0) {
> +		data->inc_reg = KX022A_REG_INC1;
> +		data->ien_reg = KX022A_REG_INC4;
> +
> +		if (fwnode_irq_get_byname(fwnode, "INT2") > 0)
> +			dev_warn(dev, "Only one IRQ supported\n");
> +	} else {
> +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> +		if (irq <= 0)
> +			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> +
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

Probably a comment that tells why you need an atomic delay.

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
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
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
> +	/*
> +	 * No need to check for NULL. request_threadedI_irq() defaults to
> +	 * dev_name() should the alloc fail.
> +	 */
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> +			      dev_name(data->dev));
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> +					&kx022a_irq_thread_handler,
> +					IRQF_ONESHOT, name, idev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(kx022a_probe_internal, KIONIX_ACCEL);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> new file mode 100644
> index 000000000000..12424649d438
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2022 ROHM Semiconductors
> + *
> + * ROHM/KIONIX KX022A accelerometer driver
> + */
> +
> +#ifndef _KX022A_H_
> +#define _KX022A_H_
> +
> +#include <linux/bits.h>
> +#include <linux/regmap.h>
> +
> +#define KX022A_REG_WHO		0x0f
> +#define KX022A_ID		0xc8
> +
> +#define KX022A_REG_CNTL2	0x19
> +#define KX022A_MASK_SRST	BIT(7)
> +#define KX022A_REG_CNTL		0x18
> +#define KX022A_MASK_PC1		BIT(7)
> +#define KX022A_MASK_RES		BIT(6)
> +#define KX022A_MASK_DRDY	BIT(5)
> +#define KX022A_MASK_GSEL	GENMASK(4, 3)
> +#define KX022A_GSEL_SHIFT	3
> +#define KX022A_GSEL_2		0x0
> +#define KX022A_GSEL_4		BIT(3)
> +#define KX022A_GSEL_8		BIT(4)
> +#define KX022A_GSEL_16		GENMASK(4, 3)
> +
> +#define KX022A_REG_INS2		0x13
> +#define KX022A_MASK_INS2_DRDY	BIT(4)
> +#define KX122_MASK_INS2_WMI	BIT(5)
> +
> +#define KX022A_REG_XHP_L	0x0
> +#define KX022A_REG_XOUT_L	0x06
> +#define KX022A_REG_YOUT_L	0x08
> +#define KX022A_REG_ZOUT_L	0x0a
> +#define KX022A_REG_COTR		0x0c
> +#define KX022A_REG_TSCP		0x10
> +#define KX022A_REG_INT_REL	0x17
> +
> +#define KX022A_REG_ODCNTL	0x1b
> +
> +#define KX022A_REG_BTS_WUF_TH	0x31
> +#define KX022A_REG_MAN_WAKE	0x2c
> +
> +#define KX022A_REG_BUF_CNTL1	0x3a
> +#define KX022A_MASK_WM_TH	GENMASK(6, 0)
> +#define KX022A_REG_BUF_CNTL2	0x3b
> +#define KX022A_MASK_BUF_EN	BIT(7)
> +#define KX022A_MASK_BRES16	BIT(6)
> +#define KX022A_REG_BUF_STATUS_1	0x3c
> +#define KX022A_REG_BUF_STATUS_2	0x3d
> +#define KX022A_REG_BUF_CLEAR	0x3e
> +#define KX022A_REG_BUF_READ	0x3f
> +#define KX022A_MASK_ODR		GENMASK(3, 0)
> +#define KX022A_ODR_SHIFT	3
> +#define KX022A_FIFO_MAX_WMI_TH	41
> +
> +#define KX022A_REG_INC1		0x1c
> +#define KX022A_REG_INC5		0x20
> +#define KX022A_REG_INC6		0x21
> +#define KX022A_MASK_IEN		BIT(5)
> +#define KX022A_MASK_IPOL	BIT(4)
> +#define KX022A_IPOL_LOW		0
> +#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
> +#define KX022A_MASK_ITYP	BIT(3)
> +#define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
> +#define KX022A_ITYP_LEVEL	0
> +
> +#define KX022A_REG_INC4		0x1f
> +#define KX022A_MASK_WMI		BIT(5)
> +
> +#define KX022A_REG_SELF_TEST	0x60
> +#define KX022A_MAX_REGISTER	0x60
> +
> +struct device;
> +
> +int kx022a_probe_internal(struct device *dev);
> +extern const struct regmap_config kx022a_regmap;
> +
> +#endif
> -- 
> 2.37.3

-- 
With Best Regards,
Andy Shevchenko


