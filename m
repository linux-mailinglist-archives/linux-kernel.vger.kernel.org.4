Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6505F8CBC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJISAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJISAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:00:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C91B9C5;
        Sun,  9 Oct 2022 11:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13A83B8069D;
        Sun,  9 Oct 2022 18:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1751C433D6;
        Sun,  9 Oct 2022 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665338448;
        bh=U6cShSAbvX5Nne31qEg27JEawParISF5+hc260ZiWfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GoMR0l6EFSfK4HVYVMAfIl28osbE3QxFsnnrMJfz0l7zLTS3CS93z6EdCCzHuWuKM
         Yid2eKW+Tvxc8wN7h1Sbwf30SABUu5vebQWR9zQlff8qAYxGJz2G7JHKNGKWm1j/qC
         8NUsA43CRZsTXGs2afriLRr8aA0geOjHDeb6l/dYKqp7AcV0eIfkeCfaHxite0+cKc
         oZ++7tvRheXqm8IiiBvei8TvPDYsntfKauEwwAmENXpSyEJ4/q0r1eB2PkJcl7SK+E
         wgUKDdqczGoYGGhXeAToldPaL6e04y2YTLmRF/ibykF6aQOUeJBukrtVketSDuAZO0
         76l8d65i+B6PA==
Date:   Sun, 9 Oct 2022 19:01:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: addac: add AD74115 driver
Message-ID: <20221009190110.2d7eb1da@jic23-huawei>
In-Reply-To: <20221003103016.195805-3-demonsingur@gmail.com>
References: <20221003103016.195805-1-demonsingur@gmail.com>
        <20221003103016.195805-3-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Oct 2022 13:30:15 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The AD74115H is a single-channel, software-configurable, input and
> output device for industrial control applications. The AD74115H
> provides a wide range of use cases, integrated on a single chip.
> 
> These use cases include analog output, analog input, digital output,
> digital input, resistance temperature detector (RTD), and thermocouple
> measurement capability. The AD74115H also has an integrated HART modem.
> 
> A serial peripheral interface (SPI) is used to handle all communications
> to the device, including communications with the HART modem. The digital
> input and digital outputs can be accessed via the SPI or the
> general-purpose input and output (GPIO) pins to support higher
> speed data rates.
> 
> The device features a 16-bit, sigma-delta analog-to-digital converter
> (ADC) and a 14-bit digital-to-analog converter (DAC).
> The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> be used as the DAC and ADC reference.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin, very much a partial review as I'm out of time today.
I'll get back to the rest, but may be a few days.

> ---
>  MAINTAINERS                 |    1 +
>  drivers/iio/addac/Kconfig   |   14 +
>  drivers/iio/addac/Makefile  |    1 +
>  drivers/iio/addac/ad74115.c | 2025 +++++++++++++++++++++++++++++++++++
>  4 files changed, 2041 insertions(+)
>  create mode 100644 drivers/iio/addac/ad74115.c
> 

...


> diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
> index 17de20ef0d8e..577777276e43 100644
> --- a/drivers/iio/addac/Makefile
> +++ b/drivers/iio/addac/Makefile
> @@ -4,5 +4,6 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD74115) += ad74115.o
>  obj-$(CONFIG_AD74413R) += ad74413r.o
>  obj-$(CONFIG_STX104) += stx104.o
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> new file mode 100644
> index 000000000000..3234b7165b9f
> --- /dev/null
> +++ b/drivers/iio/addac/ad74115.c
> @@ -0,0 +1,2025 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Analog Devices, Inc.
> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <linux/crc8.h>

Stick to alphabetical order within the 3 blocks of includes.

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +> +
> +struct ad74115_channels {
> +	struct iio_chan_spec		*channels;
> +	unsigned int			num_channels;
> +};
> +
> +struct ad74115_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	struct iio_trigger		*trig;
> +
> +	/*
> +	 * Synchronize consecutive operations when doing a one-shot
> +	 * conversion and when updating the ADC samples SPI message.
> +	 */
> +	struct mutex			lock;
> +	struct regulator_bulk_data	regulators[AD74115_REGULATORS_NUM];
> +	struct gpio_chip		gc;
> +	struct gpio_chip		comp_gc;
> +
> +	unsigned int			avdd_mv;
> +	unsigned long			gpio_valid_mask;
> +	bool				dac_bipolar;
> +	bool				dac_hart_slew;
> +	enum ad74115_ch_func		ch_func;
> +	enum ad74115_diag_func		diag_func[AD74115_DIAG_NUM];
> +	enum ad74115_din_threshold_mode	din_threshold_mode;
> +	enum ad74115_rtd_mode		rtd_mode;
> +
> +	struct completion		adc_data_completion;
> +	struct spi_message		adc_samples_msg;
> +	struct spi_transfer		adc_samples_xfer[AD74115_ADC_CH_NUM + 1];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8				reg_tx_buf[AD74115_FRAME_SIZE] ____cacheline_aligned;

Switch to __aligned(IIO_DMA_MINALIGN)
See the patches that did that for all the other drivers for why...

> +	u8				reg_rx_buf[AD74115_FRAME_SIZE];
> +	u8				adc_samples_tx_buf[AD74115_FRAME_SIZE * AD74115_ADC_CH_NUM];
> +	u8				adc_samples_rx_buf[AD74115_FRAME_SIZE * AD74115_ADC_CH_NUM];
> +};

... BIG CHUNK I SKIPPED OVER due to lack of time...


> +
> +static int ad74115_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ad74115_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +	mutex_init(&st->lock);
> +	init_completion(&st->adc_data_completion);
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", AD74115_NAME,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad74115_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;

I'd normally expect trigger registration to be alongside the irq setup.
Makes it easier to see everything involved.

> +
> +	indio_dev->name = AD74115_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad74115_info;
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	st->regulators[AD74115_AVDD_REGULATOR].supply = "avdd";
> +	st->regulators[AD74115_AVCC_REGULATOR].supply = "avcc";
> +	st->regulators[AD74115_DVCC_REGULATOR].supply = "dvcc";
> +	st->regulators[AD74115_ALDO1V8_REGULATOR].supply = "aldo1v8";
> +	st->regulators[AD74115_DOVDD_REGULATOR].supply = "dovdd";
> +	st->regulators[AD74115_REFIN_REGULATOR].supply = "refin";

I think you only query the voltages on a subset of these. I'd be tempted
to handle those independently of those where you only care if they are on.

That way you can use the new
devm_regulator_bulk_get_enabled() call to reduce how many need the more
complex handling.

Also makes it clear here which ones you might query.

> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad74115_regulators_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	st->regmap = devm_regmap_init(dev, NULL, st, &ad74115_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad74115_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74115_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, spi->irq, ad74115_adc_data_interrupt,
> +			       0, AD74115_NAME, indio_dev);

It's unusual to have a required irq.  Is it not possible to use a
fixed length sleep if no irq is wired? (people for ever seem to decide
not writing the interrupt is a good idea when they are short on pins).

Obviously if irq no present then the trigger doesn't make much sense, but
other trigger types will be fine.  You allow those currently...


> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ad74115_trigger_handler,
> +					      &ad74115_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +

> +
> +static const struct spi_device_id ad74115_spi_id[] = {
> +	{ "ad74115h", 0 },

No point in filling in the data with 0.  That's the default and
I would hope you aren't currently using it anyway given only
one supported ID.

> +	{ },
I'd prefer no comma after "NULL" terminators like this one.
Makes it slightly harder to add stuff afterwards which never makes sense.


> +};
> +
> +MODULE_DEVICE_TABLE(spi, ad74115_spi_id);
> +
> +static const struct of_device_id ad74115_dt_id[] = {
> +	{ .compatible = "adi,ad74115h" },
> +	{},

Prefer no comma on NULL terminator + consistent spacing for similar
structures.

> +};
> +MODULE_DEVICE_TABLE(of, ad74115_dt_id);
> +
> +static struct spi_driver ad74115_driver = {
> +	.driver = {
> +		   .name = "ad74115",
> +		   .of_match_table = ad74115_dt_id,
> +	},
> +	.probe = ad74115_probe,
> +	.id_table = ad74115_spi_id,
> +};
> +
> +module_driver(ad74115_driver,
> +	      ad74115_register_driver,
> +	      ad74115_unregister_driver);
> +
> +MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD74115 ADDAC");
> +MODULE_LICENSE("GPL");

