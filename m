Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65462713340
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjE0IRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjE0IRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:17:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C513A;
        Sat, 27 May 2023 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685175427; x=1716711427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gcPy+GtkXZ94/wT11rDEhRs306j6RkH6KPR1NEfJSTY=;
  b=UhHi8cuuOBQST/3nkEceX01QeEWHeWmBOlmm7EzwaLlrMorsG8JjCfvG
   P7iNLCpj8NI7ZVx39TvI+0uMYgR0D2LJzY/Pkqp9hU8oB66dDtixyxfDA
   WvLHtZHtmuPCdIBq/VkHOrzs2lzxeWqPUHYqiYkOb7BDOgxmt+tJ92zuf
   g5D3OEl1Q0vT4VP5BOKX4AaFkd9aHxighO2qJyjtVjJ58u5rMUpL46IkF
   1PSlJ7hKUpwYJSDASGH0xds/RaSZvxqDBgzPaMTWDvpvyUi3biMkvGzQP
   4dsXalQSVJAA43wOMNHreSf7jx5n6Hj75SR+w5ID+Vpi2vU1pgkyX5XN1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="356757180"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="356757180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 01:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="738526843"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="738526843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2023 01:17:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q2p6h-000Ioz-1f;
        Sat, 27 May 2023 11:16:59 +0300
Date:   Sat, 27 May 2023 11:16:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add microchip MCP3561/2/4R devices
Message-ID: <ZHG8e5qivS5rGe1H@smile.fi.intel.com>
References: <20230523124354.24294-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eb6f5840-d073-4c65-a5e6-2e0163b5b1a6@emailsignatures365.codetwo.com>
 <20230523124354.24294-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523124354.24294-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:43:54PM +0200, Mike Looijmans wrote:
> The MCP3564R is a 24-bit ADC with 8 multiplexed inputs. The MCP3561R is
> the same device with 2 inputs, the MCP3562R has 4 inputs. The device
> contains one ADC and a multiplexer to select the inputs to the ADC.
> To facilitate buffered reading, only channels that can be continuously
> sampled are exported to the IIO subsystem. The driver does not support
> buffered reading yet.

...

> +#include <asm/unaligned.h>

Move this after linux/* in a separate group.

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Avoid OF-centric calls in the new IIO drivers. Or maybe you simply used the
wrong header?

> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

...

> +#define MCP396XR_CONFIG2_DEFAULT				\
> +		(FIELD_PREP(MCP396XR_CONFIG2_BOOST, 0x2) |	\

BIT()?

> +		 FIELD_PREP(MCP396XR_CONFIG2_GAIN, 0x1) |	\

Ditto.

> +		 MCP396XR_CONFIG2_RESERVED1)

...

> +#define MCP396XR_CONFIG3_DEFAULT				\
> +		(FIELD_PREP(MCP396XR_CONFIG3_CONV_MODE, 0x1) |	\
> +		 FIELD_PREP(MCP396XR_CONFIG3_DATA_FORMAT, 0x3))

Ditto / GENMASK()?

...

> +#define MCP396XR_INT_VREF_UV	2400000

I would go with _uV, but I don't remember what is the practice currently.

...

> +struct mcp356xr {
> +	struct spi_device *spi;

> +	struct mutex lock;

Locks must be commented.

> +	struct regulator *vref;
> +	struct clk *clki;
> +	struct completion sample_available;
> +	u8 dev_addr;
> +	u8 n_inputs;
> +	u8 config[4];

> +	int scale_avail[8 * 2]; /* 8 gain settings */

Shouldn't it be double array [8][2] ?

Also I would move it before u8 members. In some cases might save a few bytes
(although seems not the case here right now).

> +	/* SPI transfer buffer */
> +	u8 buf[1 + MCP396XR_MAX_TRANSFER_SIZE] ____cacheline_aligned;
> +};

> +static int mcp356xr_read(struct mcp356xr *adc, u8 reg, u8 len)
> +{
> +	int ret;
> +	struct spi_transfer xfer = {
> +		.tx_buf = adc->buf,
> +		.rx_buf = adc->buf,
> +		.len = len + 1,
> +	};
> +
> +	adc->buf[0] = FIELD_PREP(MCP396XR_CMD_MASK_DEV_ADDR, adc->dev_addr) |
> +		      FIELD_PREP(MCP396XR_CMD_MASK_REG_ADDR, reg) |
> +		      MCP396XR_CMD_TYPE_READ_SEQ;

> +	memset(adc->buf + 1, 0, len);

I would rather move it at the top and take whole buffer.

	u16 length = len + 1;
	...
		.len = length,
	...
	memset(...->buf, 0, length);

> +	ret = spi_sync_transfer(adc->spi, &xfer, 1);

> +	if (ret < 0)
> +		return ret;
> +
> +	return ret;

	return 0;

?

But why you check for negative? May spi_sync_transfer() return positive?

Hence

	return spi_sync_transfer() would suffice.

> +}

...

> +static int mcp356xr_write(struct mcp356xr *adc, u8 reg, void *val, u8 len)
> +{

	Same comments as per above function.
> +}

...

> +static int mcp356xr_get_oversampling_rate(struct mcp356xr *adc)
> +{
> +	return mcp356xr_oversampling_rates[FIELD_GET(MCP396XR_CONFIG1_OSR,
> +						     adc->config[1])];

With a temporary variable for index it will look better.

> +}

> +	/* The scale is always below 1 */
> +	if (val)
> +		return -EINVAL;
> +
> +	if (!val2)
> +		return -EINVAL;

Both can be done in one "if".

...

> +	/*
> +	 * val2 is in 'micro' units, n = val2 / 1000000
> +	 * the full-scale value is millivolts / n, corresponds to 2^23,
> +	 * hence the gain = ((val2 / 1000000) << 23) / millivolts
> +	 * Approximate ((val2 / 1000000) << 23) as (549755 * val2) >> 16
> +	 * because 2 << (23 + 16) / 1000000 = 549755

You can use definitions from units.h. They made to be readable in the code and
in the comments.

> +	 */

...

> +static long mcp356xr_get_amclk_freq(struct mcp356xr *adc)
> +{
> +	long result;
> +
> +	if (adc->clki) {
> +		result = clk_get_rate(adc->clki);

> +		if (result > 0) {

		if (result == 0)
			return 0;

> +			result >>= FIELD_GET(MCP396XR_CONFIG1_AMCLK_PRE,
> +					    adc->config[1]);

		return result >> ...;

> +		}

> +	} else {
> +		result =  MCP396XR_INTERNAL_CLOCK_FREQ;
> +	}
> +
> +	return result;

	return MCP...;

> +}

...

> +static int mcp356xr_adc_conversion(struct mcp356xr *adc,
> +				   struct iio_chan_spec const *channel,
> +				   int *val)
> +{
> +	long freq = mcp356xr_get_amclk_freq(adc);
> +	int osr = mcp356xr_get_oversampling_rate(adc);
> +	/* Over-estimate timeout by a factor 2 */
> +	int timeout_ms = DIV_ROUND_UP((osr << 2) * 2 * 1000, freq);

MILLI ?

> +	int ret;
> +
> +	/* Setup input mux (address field is the mux setting) */
> +	ret = mcp356xr_write_u8(adc, MCP396XR_REG_MUX, channel->address);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&adc->sample_available);
> +	/* Start conversion */
> +	ret = mcp356xr_fast_command(adc, MCP396XR_FASTCMD_START);
> +	if (ret)
> +		return ret;
> +
> +	if (timeout_ms < 10)
> +		timeout_ms = 10;

	timeout_ms = max(DIV_ROUND_UP(...), 10);

?

> +	ret = wait_for_completion_interruptible_timeout(
> +			&adc->sample_available, msecs_to_jiffies(timeout_ms));

Strange indentation.

> +	if (ret == 0) {
> +		/* Interrupt did not fire, check status and report */
> +		dev_warn(&adc->spi->dev, "Timeout (%d ms)\n", timeout_ms);
> +		ret = mcp356xr_read(adc, MCP396XR_REG_ADCDATA, 4);
> +		if (!ret) {
> +			/* Check if data-ready was asserted  */
> +			if ((adc->buf[0] & MCP396XR_STATUS_DR))
> +				return -ETIMEDOUT;
> +		}
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * We're using data format 0b11 (see datasheet). While the ADC output is
> +	 * 24-bit, it allows over-ranging it and produces a 25-bit output in
> +	 * this mode. Hence the "24".
> +	 */
> +	*val = sign_extend32(get_unaligned_be32(&adc->buf[1]), 24);
> +
> +	return 0;
> +}

...

> +	int ret = -EINVAL;

Seems missing default.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = mcp356xr_oversampling_rates;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(mcp356xr_oversampling_rates);
> +		ret = IIO_AVAIL_LIST;
> +		break;

		return ...;

> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_FRACTIONAL_LOG2;
> +		*vals = adc->scale_avail;
> +		*length = ARRAY_SIZE(adc->scale_avail);
> +		ret = IIO_AVAIL_LIST;
> +		break;

Ditto.

> +	}
> +
> +	return ret;

default?

...

> +static int mcp356xr_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mcp356xr *adc = iio_priv(indio_dev);
> +	int ret = -EINVAL;

Use default.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			break;
> +
> +		ret = mcp356xr_adc_conversion(adc, channel, val);
> +		if (ret >= 0)

Can we use traditional pattern?

		if (ret < 0)
			...handle error...

> +			ret = IIO_VAL_INT;
> +		iio_device_release_direct_mode(indio_dev);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = FIELD_GET(MCP396XR_CONFIG2_GAIN, adc->config[2]);
> +		*val = adc->scale_avail[ret * 2 + 0];
> +		*val2 = adc->scale_avail[ret * 2 + 1];
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		if (channel->type == IIO_TEMP) {
> +			/* To obtain temperature scale, divide by 0.0002973 */
> +			*val = 100 * ((*val * 100000) / 2973);
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (channel->type == IIO_TEMP) {
> +			ret = FIELD_GET(MCP396XR_CONFIG2_GAIN, adc->config[2]);
> +			/* temperature has 80 mV offset */
> +			*val = (-80 << adc->scale_avail[ret * 2 + 1]) /
> +						adc->scale_avail[ret * 2 + 0];
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = mcp356xr_get_samp_freq(adc);
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = mcp356xr_get_oversampling_rate(adc);
> +		ret = IIO_VAL_INT;
> +		break;
> +	}
> +
> +	return ret;

Return directly from each case.

> +}

...

> +static int mcp356xr_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int val,
> +			    int val2, long mask)
> +{

As per previous comments.

> +}

...

> +	ret = mcp356xr_read(adc, MCP396XR_REG_ADCDATA, 4);
> +	if (!ret) {

Please, use traditional pattern

> +		/* Check if data-ready bit is 0 (active) */
> +		if (!(adc->buf[0] & MCP396XR_STATUS_DR))
> +			complete(&adc->sample_available);
> +	}

...

> +	if (!of_property_read_u32(of_node, "device-addr", &value)) {

No of_*() in a new IIO drivers, please.

> +		if (value > 3) {
> +			dev_err(&adc->spi->dev,
> +				"invalid device address (%u). Must be <3.\n",
> +				value);
> +			return -EINVAL;
> +		}

Validation should be done on YAML level, no?

> +		adc->dev_addr = value;
> +	} else {
> +		/* Default address is "1" unless you special-order them */
> +		adc->dev_addr = 0x1;

Why hex?

> +	}

...

Missing comment to explain the below sleep.

> +	usleep_range(200, 400);

...

> +	if (!of_property_read_bool(of_node, "drive-open-drain"))

No of_*().

> +		regval |= MCP396XR_IRQ_PUSH_PULL;


> +	ret = mcp356xr_write_u8(adc, MCP396XR_REG_IRQ, regval);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return ncp356xr_...;


> +	adc->clki = devm_clk_get(dev, NULL);
> +	if (IS_ERR(adc->clki)) {
> +		if (PTR_ERR(adc->clki) == -ENOENT) {
> +			adc->clki = NULL;

We have _optional()

> +		} else {
> +			return dev_err_probe(dev, PTR_ERR(adc->clki),
> +					     "Failed to get adc clk\n");
> +		}
> +	} else {
> +		ret = clk_prepare_enable(adc->clki);

We have _enabled()

> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable adc clk\n");
> +
> +		ret = devm_add_action_or_reset(dev, mcp356xr_clk_disable,
> +					       adc->clki);
> +		if (ret)
> +			return ret;
> +	}

Just call devm_clk_get_optional_enabled()

...

> +	ret = devm_iio_device_register(dev, indio_dev);
> +	return ret;

	return devm_...;

-- 
With Best Regards,
Andy Shevchenko


