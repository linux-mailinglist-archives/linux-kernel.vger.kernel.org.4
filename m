Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056C638808
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKYK7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKYK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:59:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B34876D;
        Fri, 25 Nov 2022 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669373946; x=1700909946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tHrOxyZ8dD1qpOu8DeNtf7y6eOgb8MFdo+A1XFRRy4Q=;
  b=TwzaLSJIuljEy4tOf2oeIu2yKVSzMbOAxSAhll3/4p90pe3Zdn3I+ue2
   cqURGsEOxmsE9/YX2bYuWrEFD+LEaLk4VMJCfMOmnvCTO8NGUfVFV9X1C
   /CIO51VahtQtQ02M790I6jY+GJiI+7N6fO/uZ7opkowf5qomePeUa4AGD
   ylkojlJko+0Pgu1bieJv9eWWf2uUFhUdZ0DiTuuH/e+Nj7ZaKpv/id8wf
   gmZfibyJvitfeXUvMkV4Hs8yP3UNQtaXTVcQwX5k1p9oqNc/XrcwqlHhx
   tkDZe2ukZYtWw96klz1IcGuI32so2A9AS3/3suKay69KIuVpfbKXSoNWr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="314495296"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="314495296"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 02:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="636541393"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="636541393"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2022 02:59:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyWQ9-00HCI4-0Q;
        Fri, 25 Nov 2022 12:59:01 +0200
Date:   Fri, 25 Nov 2022 12:59:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v3 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y4Cf9MvNRcfy+7jf@smile.fi.intel.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-4-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125083526.2422900-4-gerald.loacker@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 09:35:26AM +0100, Gerald Loacker wrote:
> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.

Much better now, my comments below.

...

> +static int tmag5273_write_scale(struct tmag5273_data *data, int scale_micro)
> +{

What about

	u32 mask;

> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tmag5273_scale[0]); i++) {
> +		if (tmag5273_scale[data->version][i].val_micro == scale_micro)
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(tmag5273_scale[0]))
> +		return -EINVAL;
> +	data->scale_index = i;

	if (data->scale_index == MAGN_RANGE_LOW)
		mask = 0;
	else
		mask = TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK;

> +	return regmap_update_bits(data->map,
> +		TMAG5273_SENSOR_CONFIG_2,
> +		TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK,

		mask);

> +		data->scale_index == MAGN_RANGE_LOW ? 0 :
> +			TMAG5273_Z_RANGE_MASK |
> +			TMAG5273_X_Y_RANGE_MASK);

?

> +}

...

> +		switch (chan->type) {
> +		case IIO_MAGN:

> +			if (val != 0)

			if (val)

> +				return -EINVAL;
> +			return tmag5273_write_scale(data, val2);
> +		default:
> +			return -EINVAL;
> +		}

...

> +static const struct regmap_config tmag5273_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,

> +	.max_register = 0xff,

Does it indeed have 256 registers?

> +	.volatile_reg = tmag5273_volatile_reg,
> +};

...

> +static void tmag5273_read_device_property(struct tmag5273_data *data)
> +{

	struct device *dev = data->dev;

> +	const char *str;
> +	int ret;
> +
> +	data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;

	ret = device_property_read_string(dev, "ti,angle-measurement", &str);
	if (ret)
		return;

> +	if (!device_property_read_string(data->dev, "ti,angle-measurement", &str)) {
> +		ret = match_string(tmag5273_angle_names,
> +				   ARRAY_SIZE(tmag5273_angle_names), str);
> +		if (ret < 0)
> +			dev_warn(data->dev,
> +				 "unexpected read angle-measurement property: %s\n", str);
> +		else
> +			data->angle_measurement = ret;
> +	}

	ret = match_string(tmag5273_angle_names, ARRAY_SIZE(tmag5273_angle_names), str);
	if (ret < 0)
		dev_warn(dev, "unexpected read angle-measurement property: %s\n", str);
	else
		data->angle_measurement = ret;

> +}

...

> +		return dev_err_probe(data->dev, ret,
> +				     "failed to power on device\n");

I would leave on one line (only 84 characters long).

...

> +		return dev_err_probe(data->dev, ret,
> +				     "failed to read device ID\n");

Ditto.

...

> +	switch (data->devid) {
> +	case TMAG5273_MANUFACTURER_ID:
> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u",
> +			 data->version);
> +		if (data->version < 1 || data->version > 2)
> +			dev_warn(data->dev, "Unsupported device %s\n",
> +				 data->name);
> +		break;
> +	default:
> +		dev_warn(data->dev, "Unknown device ID 0x%x\n", data->devid);
> +		break;
> +	}
> +
> +	return 0;

'break;':s above can be replaced by direct 'return 0;':s. It's up to you.

...

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "IIO device allocation failed\n");

We don't print ENOMEM error messages in the drivers, core does this for us.
Otherwise you have to explain why this message is so important.

...

> +	/*
> +	 * Register powerdown deferred callback which suspends the chip
> +	 * after module unloaded.
> +	 *
> +	 * TMAG5273 should be in SUSPEND mode in the two cases:
> +	 * 1) When driver is loaded, but we do not have any data or
> +	 *    configuration requests to it (we are solving it using
> +	 *    autosuspend feature).
> +	 * 2) When driver is unloaded and device is not used (devm action is

Something with indentation of this or other lines.

> +	 *    used in this case).
> +	 */

...

> +		return dev_err_probe(dev, ret,
> +				     "failed to add powerdown action\n");

One line?

...

> +		dev_err(dev, "failed to power off device (%pe)\n",
> +			ERR_PTR(ret));

Ditto.

-- 
With Best Regards,
Andy Shevchenko


