Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1616F6DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEDOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEDOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:33:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35CED;
        Thu,  4 May 2023 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683210838; x=1714746838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xlLDMQQnaoiJZU5cc5xhDZa7M+4PCVjcjgdzn9vspmI=;
  b=PpIkwUDi2EOUbNVwXxnpOGKCOUOxcVT47VYAaQEVhL1My8miYN3b2AV+
   7au4Dx1c1oZDgT5CoFEDjIjvYOH+YgSwyqHCkJ+1c314NyVbPildcYrsB
   i0Ib5KWUVxuOz4GiS7oPd4PSrJJ+v/WAafJsXNTmA1ocjE55h9S9yRaCs
   8EW5yXQkPPwDqjgZdsknLHI62OyZXr2KTnD8gGdvDFldeBxUAcW39TuUK
   F/y50GJR1KkO84uoQM4N5o2NbMZXLnWKwdAbtia8Bj5Qj6+fD1Vk7Y8g5
   Ry5koy4r9qT0d6U49AiG4Pgu7sXvd34tOySRqZF46De++gxACl5rV75gX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="329305927"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="329305927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 07:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="821195742"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="821195742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2023 07:33:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pua1p-0095jL-07;
        Thu, 04 May 2023 17:33:53 +0300
Date:   Thu, 4 May 2023 17:33:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <ZFPCUJ81aw/GkJgT@smile.fi.intel.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
 <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 12:50:14PM +0300, Matti Vaittinen wrote:
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add initial support for the ROHM BU27008 color sensor.
>  - raw_read() of RGB and clear channels
>  - triggered buffer w/ DRDY interrtupt

...

> +config ROHM_BU27008
> +	tristate "ROHM BU27008 color (RGB+C/IR) sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_GTS_HELPER
> +	help
> +	  Enable support for the ROHM BU27008 color sensor.
> +	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,
> +	  blue, clear and IR) with four configurable channels. Red and
> +	  green being always available and two out of the rest three
> +	  (blue, clear, IR) can be selected to be simultaneously measured.
> +	  Typical application is adjusting LCD backlight of TVs,
> +	  mobile phones and tablet PCs.

Module name?

...

> +static const struct regmap_range bu27008_read_only_ranges[] = {
> +	{
> +		.range_min = BU27008_REG_DATA0_LO,
> +		.range_max = BU27008_REG_DATA3_HI,
> +	}, {
> +		.range_min = BU27008_REG_MANUFACTURER_ID,
> +		.range_max = BU27008_REG_MANUFACTURER_ID,

> +	}

+ trailing comma for consistency?

> +};

...

> +static const struct regmap_config bu27008_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = BU27008_REG_MAX,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_table = &bu27008_volatile_regs,
> +	.wr_table = &bu27008_ro_regs,

Do you need regmap lock? If so, why (since you have mutex)?

> +};

...

> +static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan, int *val, int *val2)
> +{
> +	int ret, int_time;
> +
> +	ret = bu27008_chan_cfg(data, chan);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27008_meas_set(data, BU27008_MEAS_EN);
> +	if (ret)
> +		return ret;
> +
> +	int_time = bu27008_get_int_time_us(data);
> +	if (int_time < 0)
> +		int_time = BU27008_MEAS_TIME_MAX_MS;
> +	else
> +		int_time /= USEC_PER_MSEC;

The above function returns an error code when negative, so I would rather see

	ret = bu27008_get_int_time_us(data);
	if (ret < 0)
		int_time = BU27008_MEAS_TIME_MAX_MS;
	else
		int_time = ret / USEC_PER_MSEC;

at least this explicitly shows the semantics of the "negative" time.

> +	msleep(int_time);
> +
> +	ret = bu27008_chan_read_data(data, chan->address, val);
> +	if (!ret)
> +		ret = IIO_VAL_INT;
> +
> +	if (bu27008_meas_set(data, BU27008_MEAS_DIS))
> +		dev_warn(data->dev, "measurement disabling failed\n");
> +
> +	return ret;
> +}

...

> +	ret = regmap_reinit_cache(data->regmap, &bu27008_regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to reinit reg cache\n");

> +		return ret;

Dup is not needed.

> +	}
> +
> +	return ret;

...

> +	if (i2c->irq) {

Instead of a long body, I would rather see a call to

		ret = ..._setup_irq();
		if (ret)
			return ret;

> +		ret = devm_iio_triggered_buffer_setup(dev, idev,
> +						      &iio_pollfunc_store_time,
> +						      bu27008_trigger_handler,
> +						      &bu27008_buffer_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
> +
> +		itrig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d",
> +					       idev->name, iio_device_id(idev));
> +		if (!itrig)
> +			return -ENOMEM;
> +
> +		data->trig = itrig;
> +
> +		itrig->ops = &bu27008_trigger_ops;
> +		iio_trigger_set_drvdata(itrig, data);
> +
> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s-bu27008",
> +				      dev_name(dev));
> +
> +		ret = devm_request_irq(dev, i2c->irq,
> +				       &bu27008_data_rdy_poll,
> +				       0, name, itrig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Could not request IRQ\n");
> +
> +		ret = devm_iio_trigger_register(dev, itrig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Trigger registration failed\n");
> +
> +		/* set default trigger */
> +		idev->trig = iio_trigger_get(itrig);
> +	} else {
> +		dev_info(dev, "No IRQ, buffered mode disabled\n");
> +	}


-- 
With Best Regards,
Andy Shevchenko


