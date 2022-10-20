Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF0606332
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJTOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJTOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:34:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2CD5A2F9;
        Thu, 20 Oct 2022 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666276492; x=1697812492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFTFNiV92NX50PnQOqzwKZWlpo7k25DwAW2u5qQ5P9Y=;
  b=OY5D08iaPL1qmz7dsIf/21IYAYL9vBeH1gaSSGFcfFcGgzLad0eh3a4m
   LP+y2RIbem9WCWbeU6hBr8KE6vXNGQJfrCQjO49w3K2mzK9d2qvMYZYtV
   VPp+ymfZ0wFjXh5LUQnZdQ9rIG5v0j2QEQtWpOsB/4ICCPxUX0VHa9TpL
   fJmRF4Q2Ce+6fC+0BPHw1xPYm7LbcBuRFgV8pz6RPOi+Au+Rl21eJhxKC
   BvCsCaEBYAKpcUmNfxwsXzf+vMBlRzw1TBarNWI9HWFut8Z8s8tGBMntw
   q2mB+LBaW6deINpo/RGEz5V+7U5YkLdxZjFZhwqpOZgEeap1FuSTa98pA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="370935723"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="370935723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="580938420"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="580938420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2022 07:34:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olWd4-00AadZ-2V;
        Thu, 20 Oct 2022 17:34:38 +0300
Date:   Thu, 20 Oct 2022 17:34:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y1FcftQKimmvcOej@smile.fi.intel.com>
References: <cover.1666263249.git.mazziesaccount@gmail.com>
 <5000bd61650554658d13619c8244f02cedbc182a.1666263249.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5000bd61650554658d13619c8244f02cedbc182a.1666263249.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:37:15PM +0300, Matti Vaittinen wrote:
> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
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

...

> +	if (!i2c->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;

At least

	return dev_err_probe(...);

for know error codes (or when we know that there won't be EPROBE_DEFER), takes
less LoCs in the source file.

> +	}

...

> +	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to initialize Regmap\n");
> +		return PTR_ERR(regmap);

Ditto here and anywhere else for the similar cases.

> +	}

...

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)kx022a_accel_samp_freq_table;
> +		*length = ARRAY_SIZE(kx022a_accel_samp_freq_table) * 2;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)kx022a_scale_table;
> +		*length = ARRAY_SIZE(kx022a_scale_table) * 2;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;

These  ' * 2' can be replaced with respective ARRAY_SIZE() of nested element
for robustness, but I don't think it worth it. What we need is to provide
IIO specific type for these tables and use it.

...

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
> +
> +	if (ret)
> +		dev_err(data->dev, "Turn %s fail %d\n", (on) ? "ON" : "OFF",
> +			ret);

str_on_off() ?

> +	return ret;
> +
> +}

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
> +
> +		while (n--)
> +			if (val == kx022a_accel_samp_freq_table[n][0] &&
> +			    kx022a_accel_samp_freq_table[n][1] == val2)

Why not to use the same kind of l and r arguments in == lines?
In current form it's a bit harder to see what the catch here.

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
> +			    kx022a_scale_table[n][1] == val2)

Ditto.

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

...

> +static int kx022a_get_axis(struct kx022a_data *data,
> +			   struct iio_chan_spec const *chan,
> +			   int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
> +			       sizeof(__le16));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(data->buffer[0]);

'p'-variant of the above would look better

	*val = le16_to_cpup(data->buffer);

since it will be the same as above address without any additional arithmetics.

> +	return IIO_VAL_INT;
> +}


...

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

> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +
> +		break;

return IIO_VAL_INT_PLUS_MICRO;

> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
> +		if (ret < 0)
> +			return ret;
> +
> +		kx022a_reg2scale(regval, val, val2);
> +
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;

Ditto.

...

> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);

Would simple '0' suffice?

...

> +	for (i = 0; i < count; i++) {
> +		int bit;
> +		u16 *samples = &buffer[i * 3];

I would put it as

		u16 *samples = &buffer[i * 3];
		int bit;

> +		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
> +			memcpy(&data->scan.channels[bit], &samples[bit],
> +			       sizeof(data->scan.channels[0]));

Why not use bit instead of 0 for the sake of consistency?

Also might be good to have a temporary for channels:

		... *chs = data->scan.channels;


		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
			memcpy(&chs[bit], &samples[bit], sizeof(chs[bit]));

> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +
> +		tstamp += sample_period;
> +	}

...

> +	ret = regmap_clear_bits(data->regmap, data->ien_reg,
> +				KX022A_MASK_WMI);

I don't see why it's not on a single line. Even if you are a conservative
adept of 80.

Maybe other lines also need to be revised?

> +	if (ret)
> +		goto unlock_out;

...

> +	int ret = IRQ_NONE;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (data->trigger_enabled) {
> +		iio_trigger_poll_chained(data->trig);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (data->state & KX022A_STATE_FIFO) {

> +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
> +		if (ret > 0)
> +			ret = IRQ_HANDLED;

I don't like it. Perhaps

	bool handled = false;
	int ret;

	...
		ret = ...
		if (ret > 0)
			handled = true;
	...

	return IRQ_RETVAL(handled);

> +	}
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;

...

> +	if (!dev)
> +		return -ENODEV;

Do you really need this check?

...

> +	fw = dev_fwnode(dev);
> +	if (!fw)
> +		return -ENODEV;

You may combine these two in one.

	struct fwnode_handle *fwnode;


	fwnode = dev ? dev_fwnode(dev) : NULL;
	if (!fwnode)
		return -ENODEV;

And please, call it fwnode.

...

> +	irq = fwnode_irq_get_byname(fw, "INT1");
> +	if (irq > 0) {
> +		data->inc_reg = KX022A_REG_INC1;
> +		data->ien_reg = KX022A_REG_INC4;
> +
> +		if (fwnode_irq_get_byname(dev_fwnode(dev), "INT2") > 0)

Why not use fwnode again

> +			dev_warn(dev, "Only one IRQ supported\n");
> +	} else {
> +		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");

Ditto.

> +		if (irq <= 0)
> +			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> +
> +		data->inc_reg = KX022A_REG_INC5;
> +		data->ien_reg = KX022A_REG_INC6;
> +	}

...

> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL %d\n",
> +				     ret);

Drop dup ret at the end, dev_err_probe() has been adding it to each message.

...

> +	/*
> +	 * No need to check for NULL. request_threadedI_irq() defaults to
> +	 * dev_name() should the alloc fail.
> +	 */
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> +			      dev_name(data->dev));

It's not clear why do you need a suffix here.

-- 
With Best Regards,
Andy Shevchenko


