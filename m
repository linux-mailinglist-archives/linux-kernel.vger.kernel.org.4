Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8776A852F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCBPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCBPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:34:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF9233D2;
        Thu,  2 Mar 2023 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677771286; x=1709307286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U27e2r3WNQq//SFj8QnH7KOGnyTFHy9RyFnObh6jVs8=;
  b=lhzRKPnTS7/iyYHjTcOY2Pcswvmrd7AE/spk+VdYUJLSHjbCPJrq997h
   ZHkht6luRHlyRnpAuSIa7WsTx0h4RZYO5z4U1jlMpSpeufYat7OSka4Gn
   vVQ7idxKhZYPpmJvEMNRCXnktPdEul7rNUH4RNWcIN2MiwsWrNdXEtb33
   bzoNUDuk8n3W/REWIlDb1FLSD/aJ/aECnuJNNMCMUuu1iKNgsX68iDyMZ
   f+e+0UopaPilD76wPqi4fueYJH1d5bbz4PTZpzxpoNYBwQH7HtsTaLa2P
   89L1Z0KljsNE0lOhcNmHGi44wELcqlNePy8V1HLJ29bH8e5uL53ON29EX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="336271622"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="336271622"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="652437913"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="652437913"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 07:34:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXkx7-00EPJY-0a;
        Thu, 02 Mar 2023 17:34:41 +0200
Date:   Thu, 2 Mar 2023 17:34:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <ZADCEPc1ZKczhEpE@smile.fi.intel.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:58:59PM +0200, Matti Vaittinen wrote:
> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. Additionally 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has adjustible GAIN values ranging from 1x to 4096x.
> 	- Sensor has adjustible measurement times 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment only can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property which can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to adjust the GAIN so that the overall scale
> 	  is not changed.
> 	- Runtime PM is not implemented.
> 	- Driver starts the measurement on the background when it is
> 	  probed. This improves the respnse time to read-requests
> 	  compared to starting the read only when data is requested.
> 	  When the most accurate 400 mS measurement time is used, data reads
> 	  would last quite long if measurement was started only on
> 	  demand. This, however, is not appealing for users who would
> 	  prefere power saving over measurement response time.

...

> +config ROHM_BU27034
> +	tristate "ROHM BU27034 ambient light sensor"

> +	depends on I2C

How? I do not see a such.

> +	select REGMAP_I2C
> +	select IIO_GTS_HELPER
> +	help
> +	  Enable support for the ROHM BU27034 ambient light sensor. ROHM BU27034
> +	  is an ambient light sesnor with 3 channels and 3 photo diodes capable
> +	  of detecting a very wide range of illuminance.
> +	  Typical application is adjusting LCD and backlight power of TVs and
> +	  mobile phones.

Module name?

...

>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o

> +obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o

If you see, most of the components are without vendor prefix, why rohm is
special? Like you are expecting the very same filename for something else?

>  obj-$(CONFIG_RPR0521)		+= rpr0521.o
>  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
>  obj-$(CONFIG_SI1133)		+= si1133.o

...

> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>

Sorted?

...

> +#define BU27034_REG_DATA0_LO		0x50
> +#define BU27034_REG_DATA1_LO		0x52
> +#define BU27034_REG_DATA2_LO		0x54

I would drop _LO in all these

> +#define BU27034_REG_DATA2_HI		0x55

and rename somehow this to something like _END / _MAX (similar to the fields.
Perhaps you would need _START / _MIN above.

...

> +/*
> + * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
> + * Time impacts to gain: 1x, 2x, 4x, 8x.
> + *
> + * => Max total gain is HWGAIN * gain by integration time (8 * 4096) = 32768
> + *
> + * Using NANO precision for scale we must use scale 64x corresponding gain 1x
> + * to avoid precision loss. (32x would result scale 976 562.5(nanos).
> + */
> +#define BU27034_SCALE_1X	64
> +
> +#define BU27034_GSEL_1X		0x00
> +#define BU27034_GSEL_4X		0x08
> +#define BU27034_GSEL_16X	0x0a
> +#define BU27034_GSEL_32X	0x0b
> +#define BU27034_GSEL_64X	0x0c
> +#define BU27034_GSEL_256X	0x18
> +#define BU27034_GSEL_512X	0x19
> +#define BU27034_GSEL_1024X	0x1a
> +#define BU27034_GSEL_2048X	0x1b
> +#define BU27034_GSEL_4096X	0x1c

Shouldn't the values be in plain decimal?

Otherwise I would like to understand bit mapping inside these hex values.

...

> +	.indexed = 1							\

+ Comma at the end.

...

> +	static const int reg[] = {
> +		[BU27034_CHAN_DATA0] = BU27034_REG_MODE_CONTROL2,
> +		[BU27034_CHAN_DATA1] = BU27034_REG_MODE_CONTROL3,
> +		[BU27034_CHAN_DATA2] = BU27034_REG_MODE_CONTROL2

Ditto.

> +	};

...

> +	struct bu27034_gain_check gains[3] = {
> +		{ .chan = BU27034_CHAN_DATA0, },
> +		{ .chan = BU27034_CHAN_DATA1, },

Inner commas are not needed.

> +		{ .chan = BU27034_CHAN_DATA2 }

But here the outer one is good to have.

> +	};

...

> +	if (chan == BU27034_CHAN_ALS) {
> +		if (val == 0 && val2 == 1000)
> +			return 0;
> +		else

Redundant 'else'. And probably here is better to use standard pattern for
"checking for error first".

> +			return -EINVAL;
> +	}

...

> +		if (helper64 < 0xFFFFFFFFFFFFFLLU) {

Perhaps this needs a definition.

> +			helper64 *= gain0;
> +			do_div(helper64, ch0);
> +		} else {
> +			do_div(helper64, ch0);
> +			helper64 *= gain0;
> +		}


> +	/* Same overflow check here */

Why not a helper function?

> +	if (helper64 < 0xFFFFFFFFFFFFFLLU) {
> +		helper64 *= gain0;
> +		do_div(helper64, helper);
> +	} else {
> +		do_div(helper64, helper);
> +		helper64 *= gain0;
> +	}

...

> +	return (val & BU27034_MASK_VALID);

Unneeded parentheses.

...

> +retry:
> +	/* Get new value from sensor if data is ready */
> +	if (bu27034_has_valid_sample(data)) {
> +		ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
> +				       res, size);
> +		if (ret)
> +			return ret;
> +
> +		bu27034_invalidate_read_data(data);
> +	} else {
> +		/* No new data in sensor. Wait and retry */
> +		msleep(25);
> +
> +		goto retry;

There is no way out. What might go wrong?

> +	}

...

> +	ret = bu27034_get_int_time(data);

_get_int_time_us() ? (Looking at the below code)

> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(ret / 1000);

...

> +	 * Avoid div by zeroi. Not using max() as the data may not be in

zeroi?

...

> +	if (!res[0])

Positive conditional?

> +		ch0 = 1;
> +	else
> +		ch0 = le16_to_cpu(res[0]);
> +
> +	if (!res[1])
> +		ch1 = 1;

Ditto.

> +	else
> +		ch1 = le16_to_cpu(res[1]);

But why not to read and convert first and then check. This at least will
correctly compare 0 to the LE16 0 (yes, it's the same for 0, but strictly
speaking the bits order of lvalue and rvalue is different).

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return iio_gts_avail_times(&data->gts, vals, type, length);
> +	case IIO_CHAN_INFO_SCALE:
> +		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

You may do it from default case.

...

> +	ret = regmap_read_poll_timeout(data->regmap, BU27034_REG_MODE_CONTROL4,
> +				       val, (val & BU27034_MASK_VALID),

Redundant parentheses.

> +				       BU27034_DATA_WAIT_TIME_US,
> +				       BU27034_TOTAL_DATA_WAIT_TIME_US);
> +	if (ret) {
> +		dev_err(data->dev, "data polling %s\n",
> +			!(val & BU27034_MASK_VALID) ? "timeout" : "fail");

Why not positive conditional in ternary?

> +		return ret;
> +	}

...

> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;

So, you deliberately disable a possibility to instantiate this from user space,
why?

...

> +	ret = devm_iio_kfifo_buffer_setup(dev, idev, &bu27034_buffer_ops);
> +
> +	ret = devm_iio_device_register(dev, idev);

Don't you find something strange in between?

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");

...

> +	{ .compatible = "rohm,bu27034", },

Inner comma is not needed.

-- 
With Best Regards,
Andy Shevchenko


