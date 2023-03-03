Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20A6A9394
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCCJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:17:57 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB03AB8;
        Fri,  3 Mar 2023 01:17:55 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h3so1621081lja.12;
        Fri, 03 Mar 2023 01:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677835074;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsujOaTvbx1uJDKm5VJBpE5kqbWhozdbtYBWb6N9/lA=;
        b=eQYBjjNBWN2LCA7upktM5xk4hC/FLuD2pjE+qo5OT5m+01jV9Kgyw5wDZFEU8LH2sY
         w/itO5ND3eFZNaEIrsiJa9CjiKfcYcnGbgfXT1Hn+driDlvxhIzbxySvpPo9YdvSnMMp
         3mKHgWuLaDIQ7xVympB8P1Vg8/FwxNmI5AZaVfQWvZFLXpsG4cjA2jFGzCrZI1w8ROmM
         FhxQVH9G0JxGK1G8/BycslJb1dwqeAQYNaGISe2V11rOgeQailaUKS04lNEN5yl1XfKL
         JPsAN4dvcIjqjaEfc33XOglbppgmMSm4/mPDjHpeDseQkcsVgAC69GUmE+hAb2hEBJSF
         UQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677835074;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsujOaTvbx1uJDKm5VJBpE5kqbWhozdbtYBWb6N9/lA=;
        b=YzPag+/uERcnCKudAdurc+ck47vKkmvUkOMDGRMCogMSXFvHQiolECR29WjEb1nCNk
         OCz0WjeQ5b720A1Tax/eF8E9yqt3lr74GMPSqT4LOqmBhzu/vyhPKmJcb31G/v6+Qlo2
         9cg3XvoatJ/NetGV9sy+bDC1ASuj5DRn73kDO0AHMoz5gyI+uL2bpMmGO1K5PtIvBXjL
         1ps1/PJp5GwJAOaxQ2Wwontyza1FjZUDLGD6Ij26Qt0osYehQCKTLrnvQ+5QD7YF5DgS
         S2DKmtDM81/6pZVaZS+UdxfW/G7Hnvii2n0UNncS47qZRU1KqhyWDfve2z+xMdWVAlPN
         oaWg==
X-Gm-Message-State: AO0yUKXh4cTy9cPg82rtX0dWY89bFrYqj0G4XSmxz0+7v9n9fqYCGyCh
        42D8z7Qsa64N86euHAuRtnTpu/Ti23w=
X-Google-Smtp-Source: AK7set8odoOHKaEPawiJfNtUnZJ6Ia6/PhbxRDbbmlwRZ3FKg0jQ2u3xcc//fukDAzL75J5PJqpmYg==
X-Received: by 2002:a2e:2a46:0:b0:293:4b60:419c with SMTP id q67-20020a2e2a46000000b002934b60419cmr256791ljq.18.1677835073648;
        Fri, 03 Mar 2023 01:17:53 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e7d01000000b00295728289dasm214689ljc.79.2023.03.03.01.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:17:53 -0800 (PST)
Message-ID: <ae769902-4bb5-a970-be1e-05b26f4c770c@gmail.com>
Date:   Fri, 3 Mar 2023 11:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <ZADCEPc1ZKczhEpE@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <ZADCEPc1ZKczhEpE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks again for the review. Some nice catches there.

On 3/2/23 17:34, Andy Shevchenko wrote:
> On Thu, Mar 02, 2023 at 12:58:59PM +0200, Matti Vaittinen wrote:
>> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
>> capable of detecting a very wide range of illuminance. Typical application
>> is adjusting LCD and backlight power of TVs and mobile phones.
>>
>> Add initial  support for the ROHM BU27034 ambient light sensor.
>>
>> NOTE:
>> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
>> 	  calculated lux values based on measured data from diodes #0 and
>> 	  #1. Additionally 3 IIO_INTENSITY channels are emitting the raw
>> 	  register data from all diodes for more intense user-space
>> 	  computations.
>> 	- Sensor has adjustible GAIN values ranging from 1x to 4096x.
>> 	- Sensor has adjustible measurement times 5, 55, 100, 200 and
>> 	  400 mS. Driver does not support 5 mS which has special
>> 	  limitations.
>> 	- Driver exposes standard 'scale' adjustment which is
>> 	  implemented by:
>> 		1) Trying to adjust only the GAIN
>> 		2) If GAIN adjustment only can't provide requested
>> 		   scale, adjusting both the time and the gain is
>> 		   attempted.
>> 	- Driver exposes writable INT_TIME property which can be used
>> 	  for adjusting the measurement time. Time adjustment will also
>> 	  cause the driver to adjust the GAIN so that the overall scale
>> 	  is not changed.
>> 	- Runtime PM is not implemented.
>> 	- Driver starts the measurement on the background when it is
>> 	  probed. This improves the respnse time to read-requests
>> 	  compared to starting the read only when data is requested.
>> 	  When the most accurate 400 mS measurement time is used, data reads
>> 	  would last quite long if measurement was started only on
>> 	  demand. This, however, is not appealing for users who would
>> 	  prefere power saving over measurement response time.
> 
> ...
> 
>> +config ROHM_BU27034
>> +	tristate "ROHM BU27034 ambient light sensor"
> 
>> +	depends on I2C
> 
> How? I do not see a such.

I have assumed we need this because:

We select REGMAP_I2C which depends on I2C.
What happens if I2C=n and we select REGMAP_I2C? I may be wrong but I 
guess the I2C stays 'n' while REGMAP_I2C becomes y/m (?) I think that 
would be unfortunate - but I can't claim I am confident with how config 
dependencies are handled. I can drop this depends on if you're sure 
that's not a problem.

>> +	select REGMAP_I2C
>> +	select IIO_GTS_HELPER
>> +	help
>> +	  Enable support for the ROHM BU27034 ambient light sensor. ROHM BU27034
>> +	  is an ambient light sesnor with 3 channels and 3 photo diodes capable
>> +	  of detecting a very wide range of illuminance.
>> +	  Typical application is adjusting LCD and backlight power of TVs and
>> +	  mobile phones.
> 
> Module name?

I am having a deja-vu.
https://lore.kernel.org/all/10c4663b-dd65-a545-786d-10aed6e6e5e9@fi.rohmeurope.com/

Module name is completely irrelevant when selecting a kernel configuration.

> ...
> 
>>   obj-$(CONFIG_OPT3001)		+= opt3001.o
>>   obj-$(CONFIG_PA12203001)	+= pa12203001.o
> 
>> +obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
> 
> If you see, most of the components are without vendor prefix, why rohm is
> special? Like you are expecting the very same filename for something else?

No. I don't.

Using the vendor prefix in _file name_ was suggested to me by Lee 
already a few years ago. And I am actually grateful he did. I've found 
that _very_ useful as it simplifies finding the files I am looking for. 
What comes to the config option name, being able to easily search for 
the configs by vendor name has also been helpful.

> ...
> 
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/kfifo_buf.h>
> 
> Sorted?

Sure, thanks.

> 
> ...
> 
>> +#define BU27034_REG_DATA0_LO		0x50
>> +#define BU27034_REG_DATA1_LO		0x52
>> +#define BU27034_REG_DATA2_LO		0x54
> 
> I would drop _LO in all these
> 
>> +#define BU27034_REG_DATA2_HI		0x55
> 
> and rename somehow this to something like _END / _MAX (similar to the fields.
> Perhaps you would need _START / _MIN above.

I don't think this would improve anything. The _LO / _HI are descriptive 
as we have only two registers for each channel, _LO and _HI being more 
or less standard abbreviations for low and high.

> ...
> 
>> +/*
>> + * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
>> + * Time impacts to gain: 1x, 2x, 4x, 8x.
>> + *
>> + * => Max total gain is HWGAIN * gain by integration time (8 * 4096) = 32768
>> + *
>> + * Using NANO precision for scale we must use scale 64x corresponding gain 1x
>> + * to avoid precision loss. (32x would result scale 976 562.5(nanos).
>> + */
>> +#define BU27034_SCALE_1X	64
>> +
>> +#define BU27034_GSEL_1X		0x00
>> +#define BU27034_GSEL_4X		0x08
>> +#define BU27034_GSEL_16X	0x0a
>> +#define BU27034_GSEL_32X	0x0b
>> +#define BU27034_GSEL_64X	0x0c
>> +#define BU27034_GSEL_256X	0x18
>> +#define BU27034_GSEL_512X	0x19
>> +#define BU27034_GSEL_1024X	0x1a
>> +#define BU27034_GSEL_2048X	0x1b
>> +#define BU27034_GSEL_4096X	0x1c
> 
> Shouldn't the values be in plain decimal?

Why?

> Otherwise I would like to understand bit mapping inside these hex values.

I like having register values in hex. It makes it obvious they don't 
necessarily directly match any 'real world' human-readable values.

> ...
> 
>> +	.indexed = 1							\
> 
> + Comma at the end.

ok.

> 
> ...
> 
>> +	static const int reg[] = {
>> +		[BU27034_CHAN_DATA0] = BU27034_REG_MODE_CONTROL2,
>> +		[BU27034_CHAN_DATA1] = BU27034_REG_MODE_CONTROL3,
>> +		[BU27034_CHAN_DATA2] = BU27034_REG_MODE_CONTROL2
> 
> Ditto.

ok.

> 
>> +	};
> 
> ...
> 
>> +	struct bu27034_gain_check gains[3] = {
>> +		{ .chan = BU27034_CHAN_DATA0, },
>> +		{ .chan = BU27034_CHAN_DATA1, },
> 
> Inner commas are not needed.
> 
>> +		{ .chan = BU27034_CHAN_DATA2 }
> 
> But here the outer one is good to have.
> 
>> +	};
> 

ok

> ...
> 
>> +	if (chan == BU27034_CHAN_ALS) {
>> +		if (val == 0 && val2 == 1000)
>> +			return 0;
>> +		else
> 
> Redundant 'else'

Thanks for pointing out the unnecessary else. Killing it makes this nicer.


>. And probably here is better to use standard pattern for
> "checking for error first".

I prefer to check for this one specific exactly supported case for ALS 
channel. Cheking for 'all other possibilities but what we are expecting' 
would be counter intuitive.

> 
>> +			return -EINVAL;
>> +	}
> 
> ...
> 
>> +		if (helper64 < 0xFFFFFFFFFFFFFLLU) {
> 
> Perhaps this needs a definition.

I like seeing the value here. It makes this less obfuscating. Comment 
makes the purpose obvious so adding a define would not really give any 
extra advantage.

>> +			helper64 *= gain0;
>> +			do_div(helper64, ch0);
>> +		} else {
>> +			do_div(helper64, ch0);
>> +			helper64 *= gain0;
>> +		}
> 
> 
>> +	/* Same overflow check here */
> 
> Why not a helper function?

I actually was thinking of it - but the check is smallish, only done 
twice and felt a tad too specific to warrant own function. I am not 
really against adding a function if you feel strongly about this :)

> 
>> +	if (helper64 < 0xFFFFFFFFFFFFFLLU) {
>> +		helper64 *= gain0;
>> +		do_div(helper64, helper);
>> +	} else {
>> +		do_div(helper64, helper);
>> +		helper64 *= gain0;
>> +	}
> 
> ...
> 
>> +	return (val & BU27034_MASK_VALID);
> 
> Unneeded parentheses.

ok.

> 
> ...
> 
>> +retry:
>> +	/* Get new value from sensor if data is ready */
>> +	if (bu27034_has_valid_sample(data)) {
>> +		ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
>> +				       res, size);
>> +		if (ret)
>> +			return ret;
>> +
>> +		bu27034_invalidate_read_data(data);
>> +	} else {
>> +		/* No new data in sensor. Wait and retry */
>> +		msleep(25);
>> +
>> +		goto retry;
> 
> There is no way out. What might go wrong?

Beyond hanging the user process? :)

I think you have a point here. I'll add a timeout.

> 
>> +	}
> 
> ...
> 
>> +	ret = bu27034_get_int_time(data);
> 
> _get_int_time_us() ? (Looking at the below code)
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	msleep(ret / 1000);
> 
> ...
> 
>> +	 * Avoid div by zeroi. Not using max() as the data may not be in
> 
> zeroi?
> 
> ...
> 
>> +	if (!res[0])
> 
> Positive conditional?

No. Again, we check for the very specific case where res has all bits 
zeroed. Inverse condition is counter intuitive.

> 
>> +		ch0 = 1;
>> +	else
>> +		ch0 = le16_to_cpu(res[0]);
>> +
>> +	if (!res[1])
>> +		ch1 = 1;
> 
> Ditto.
> 
>> +	else
>> +		ch1 = le16_to_cpu(res[1]);
> 
> But why not to read and convert first and then check.

Because conversion is not needed if channel data is zero.

> This at least will
> correctly compare 0 to the LE16 0 (yes, it's the same for 0, but strictly
> speaking the bits order of lvalue and rvalue is different).

and hence we check for !res[0]

> 
> ...
> 
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		return iio_gts_avail_times(&data->gts, vals, type, length);
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
> 
> You may do it from default case.
> 

I think we have discussed this one in the past too. I like having return 
at the end of a non void function.

> ...
> 
>> +	ret = regmap_read_poll_timeout(data->regmap, BU27034_REG_MODE_CONTROL4,
>> +				       val, (val & BU27034_MASK_VALID),
> 
> Redundant parentheses.

ok

> 
>> +				       BU27034_DATA_WAIT_TIME_US,
>> +				       BU27034_TOTAL_DATA_WAIT_TIME_US);
>> +	if (ret) {
>> +		dev_err(data->dev, "data polling %s\n",
>> +			!(val & BU27034_MASK_VALID) ? "timeout" : "fail");
> 
> Why not positive conditional in ternary?

Because I check this for a specific case: "Was it a timeout?" - not for 
unspecified "Was it something else but timeout?"

> 
>> +		return ret;
>> +	}
> 
> ...
> 
>> +	fwnode = dev_fwnode(dev);
>> +	if (!fwnode)
>> +		return -ENODEV;
> 
> So, you deliberately disable a possibility to instantiate this from user space,
> why?

Thanks! (And Sorry. Jonathan pointed this out to me already in the RFC.) 
I thought I already fixed this.

> 
> ...
> 
>> +	ret = devm_iio_kfifo_buffer_setup(dev, idev, &bu27034_buffer_ops);
>> +
>> +	ret = devm_iio_device_register(dev, idev);
> 
> Don't you find something strange in between?

Thanks!

> 
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register iio device\n");
> 
> ...
> 
>> +	{ .compatible = "rohm,bu27034", },
> 
> Inner comma is not needed.

ok




-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

