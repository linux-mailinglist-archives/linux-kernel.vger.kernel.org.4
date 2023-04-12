Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E696DEA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLE3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDLE30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:29:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9D4ECD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:29:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso8798027pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681273763; x=1683865763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnmfnSRDxa7MaxQzZaTRuZCEqM4/rjeAap6Q/yV2EEU=;
        b=SxCA3dyD0VZG1BRZy/zu/1Z/shBFUKE1WmtwJ02a9Y5vOaXlrP4fTwysNN1qdlpGRL
         w9tD+qDs2XxPzm+6w90PUlG0VIBRA8NYJ+Cu0SR29Rgef+i8kWxDzCPNw7+/wTdDVV8R
         /HRe+I28D5amDpn7lBadzoSMlpW+G9kGNcn5EnmVq539xa4CR/cIHNFxI053rFwVY7nf
         kpwFlD5FkOor57VwvK4LsQRdcwPq0UJch0K/LMSVeVTMSDjr6cdW2ukj74HXPY0lIG7y
         GxsDcLlfgckEtTJ3vhNnSl3eYHr3kZswyrY4R1WoSrQI6Wp8wluJKj5M7fm+uWUs92c9
         nPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681273763; x=1683865763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnmfnSRDxa7MaxQzZaTRuZCEqM4/rjeAap6Q/yV2EEU=;
        b=HfxLyTaWH5XoTLnKqGDqDWscfmf11WALFqni31OTeBTJTauH8YG/Qgc41iTsh654BU
         bmhaGXe2q7N1bGbiveYcvu+yAr/KO3HziC0WHe/x703TwwrQPGRK521UXx9cvHqHxERT
         zPxffIHIhVnqx2V1+9rMX2TswBFMX8DM9Rv4RPSj2eAaZmvFtT0dv7N/ePXOKu+MdKAq
         ctibXEkO+6XjTMfIqB+CLb29yFreQlbfXXHAYVeaeIIA1UG2HGMEWM65c7EzC3qPnAaP
         rn7LcAEEJ0vBpZGgw31HnJeIHP/qWbuCogorU0x2l+WN2DTan2k+cbVOQ29QsuAlDoU9
         N/jQ==
X-Gm-Message-State: AAQBX9dw5OMwneC0W3PoItTEQ61H1ZHpLA2R+HN//bIXgOZzUag+3lxP
        IPx+fRBjanJkKIGIiNkXGjx/uQ==
X-Google-Smtp-Source: AKy350YRHnAyTXpgP3AjErhxJIPw/0wZsxcVA69x9tm7CEv3lmwcfAhXloeNyA39Xmj6nnDFe7/jWg==
X-Received: by 2002:a05:6a20:85a4:b0:da:897b:ae40 with SMTP id s36-20020a056a2085a400b000da897bae40mr1259093pzd.37.1681273763109;
        Tue, 11 Apr 2023 21:29:23 -0700 (PDT)
Received: from [10.240.2.163] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id y36-20020a631824000000b0051ae762c842sm3449430pgl.87.2023.04.11.21.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 21:29:22 -0700 (PDT)
Message-ID: <ab1d9746-4d23-efcc-0ee1-d2b8c634becd@tweaklogic.com>
Date:   Wed, 12 Apr 2023 12:29:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
 <ZDVWB9xV9Cdbwyqd@smile.fi.intel.com>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <ZDVWB9xV9Cdbwyqd@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
Thank you so much for the detailed review.
Appreciate you taking time to do this.
It would be helpful if you could answers few questions inline?

> 
>> +/*
>> + * APDS-9306/APDS-9306-065 Ambient Light Sensor
>> + *
>> + * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
>> + *
>> + * I2C Address: 0x52
> 
> I guess this can be reordered and condensed a bit:
> 
>   * APDS-9306/APDS-9306-065 Ambient Light Sensor
>   * I2C Address: 0x52
>   * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> 
>> + * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>> + */
> 
Understood. It will be fixed.

>> +#include <linux/iio/events.h>
>> +#include <linux/regulator/consumer.h>
> 
> Sorted?
> 
> + Blank line.
> 
>> +#include <asm/unaligned.h>
> 
Understood. It will be fixed.

> Namespace? Capital letters?
> 
>> +};
>> +
>> +enum apds9306_int_channels {
>> +	clear,
>> +	als,
> 
> Ditto.
> 
>> +};
> 
Understood. It will be fixed.

> 
>> +/* Sampling Frequency in uSec */
>> +static const int apds9306_repeat_rate_period[] = {
>> +	25000, 50000, 100000, 200000, 500000, 1000000,
>> +	2000000
> 
> Can be on a single line.
> 
>> +};
> 
> ...
> 
> Perhaps you want to add a few static_asserts() to be sure that the ARRAY_SIZE()
> of the tables are all greater or equal to each others.
> 
> ...
Ok. I'll do that.

> 
> Why not converting all comments to a kernel-doc for the entire structure?
>
Yes. Sure.
  
> 
> ...
> 
>> +static const struct regmap_config apds9306_regmap = {
>> +	.name = "apds9306_regmap",
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.rd_table = &apds9306_readable_table,
>> +	.wr_table = &apds9306_writable_table,
>> +	.volatile_table = &apds9306_volatile_table,
>> +	.precious_table = &apds9306_precious_table,
>> +	.max_register = APDS9306_ALS_THRES_VAR,
>> +	.cache_type = REGCACHE_RBTREE,
> 
> Do you need an internal regmap lock? If so, why?
For event interface - interrupt enable, adaptive interrupt enable,
upper and lower threshold values, selection of clear or als
channels for interrupt, the mutex in the driver's private data structure
is not used.
I thought to use the regmap's internal locking mechanism for
mutual exclusion as the values are directly written to or read from
the device registers form the write_event(), read_event(),
write_event_config() and read_event_config().
What do you think?
> 
>> +	else if (data->int_ch == 0)
>> +		ret = sprintf(buff, "clear\n");
> 
> Must be sysfs_emit().
Sure. I'll use that.
> 
>> +	else
>> +		ret = -EINVAL;
>> +
>> +	return ret;
> 
> Make the string literal array for these and...
> ...
>> +		channel = 1;
>> +	else if (!strncmp(buff, "clear", 5))
>> +		channel = 0;
>> +	else
>> +		return -EINVAL;
> 
> ...use sysfs_match_string().
Understood. It will be done.

>> +	NULL,
> 
> No comma for a terminator entry.
> 
>> +};
> 
Sorry. Mistake. It will be fixed.
> 
>> +static int apds9306_power_state(struct apds9306_data *data,
>> +		enum apds9306_power_states state)
>> +{
>> +	int ret;
>> +
>> +	/* Reset not included as it causes ugly I2C bus error */
>> +	switch (state) {
>> +	case standby:
>> +		return regmap_field_write(data->regfield_en, 0);
>> +	case active:
>> +		ret = regmap_field_write(data->regfield_en, 1);
>> +		if (ret)
>> +			return ret;
>> +		/* 5ms wake up time */
>> +		usleep_range(5000, 10000);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
>> +	return 0;
> 
> Move that to a single user of this line inside the switch-case.
Sorry, I did not get you. Can you please elaborate?

>> +	struct device *dev = &data->client->dev;
> 
> Why data contains I²C client pointer, what for?
I copied the implementation. It will be re-implemented.
> 
> ...
> 
>> +	int ret = 0;
> 
> Unneeded assignment...
Yes. It will be fixed.
> 
>> +	if (en) {
>> +		ret = pm_runtime_resume_and_get(dev);
>> +		if (ret < 0) {
>> +			dev_err(dev, "runtime resume failed: %d\n", ret);
>> +			return ret;
>> +		}
>> +		ret = 0;
>> +	} else {
>> +		pm_runtime_mark_last_busy(dev);
>> +		pm_runtime_put_autosuspend(dev);
>> +	}
>> +
>> +	return ret;
> 
> ...just return 0 here.
Ok.
> 
> ...
> 
>> +		while (retries--) {
>> +			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
>> +					&status);
>> +			if (ret) {
>> +				dev_err(dev, "read status failed: %d\n", ret);
>> +				return ret;
>> +			}
>> +			if (status & APDS9306_ALS_DATA_STAT_MASK)
>> +				break;
>> +			/*
>> +			 * In case of continuous one-shot read from userspace,
>> +			 * new data is available after sampling period.
>> +			 * Delays are in the range of 25ms to 2secs.
>> +			 */
>> +			fsleep(delay);
>> +		}
> 
> regmap_read_poll_timeout().
According to the regmap_read_poll_timeout() documentation, the maximum time
to sleep between reads should be less than ~20ms as it uses usleep_range().

If userspace is doing continuous reads, then data is available after sampling
period (25ms to 2sec) or integration time (3.125ms to 400ms) whichever is
greater.

The runtime_suspend() function is called after 5 seconds, so the device is
still active and running.

If the ALS data bit is not set in status reg, it is efficient to sleep for
one sampling period rather than continuously checking the status reg
within ~20ms if we use regmap_read_poll_timeout().

Do you have any suggestions?

> 
> ...
> 
>> +	*val = get_unaligned_le24(&buff[0]);
> 
> buff is enough, but if you want to be too explicit...
Ok. It will be done.
> 
> ...
> 
>> +	ret = apds9306_runtime_power(data, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret;
> 
> 	return apds...(...);
Oh yes.
> 
> ...
> 
>> +		if (apds9306_intg_time[i][0] ==  val &&
>> +				apds9306_intg_time[i][1] ==  val2) {
> 
> Too many spaces and wrong indentation.
> 
> ...
> 
>> +		if (apds9306_repeat_rate_freq[i][0] ==  val &&
>> +				apds9306_repeat_rate_freq[i][1] ==  val2) {
> 
> Ditto.
> 
> ...
> 
>> +		if (apds9306_gain[i] ==  val) {
> 
> Too many spaces.
Thank you. It will be fixed.
> 
> ...
> 
>> +	if (thad > 7)
>> +		return -EINVAL;
> 
> This 7 should be defined with a meaningful name.
> 
> ...
> 
>> +	if (val < 0 || val > 7)
>> +		return -EINVAL;
> 
> Ditto.
>
Understood.
> ...
> 
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	int ret = -EINVAL;
> 
> This assignment is used only once, so make it explicit in that user below.
>
Got it.

> 
> ...
> 
>> +	/* The interrupt line is released and the interrupt flag is
>> +	 * cleared as a result of reading the status register
>> +	 */
> 
> /*
>   * Style of the multi-line comment
>   * is wrong.
>   */
> 
Thank you for this. I've been scratching my head for some time on the
style of commenting.
> ...
> 
>> +	break;
>> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>> +		ret = apds9306_event_thresh_adaptive_get(data, val);
>> +		if (ret)
>> +			return ret;
> 
>> +	break;
> 
> Wrong indentation of this in entire switch-case. Why the style is different
> from piece of code to piece of code?
> 
> ...
> 
>> +		if (val < 0 || val > 0xFFFFF)
>> +			return -EINVAL;
> 
> Definition and use some plain decimal number if it's about the upper limit of
> the respective non-bitwise value.
Ok, it will be done
> 
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
>> +	return 0;
> 
> Is it dead code?
Yes, seems to be. It will be fixed.

>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
> 
> Ditto.
Yes, seems to be. It will be fixed.
> 
> ...
> 
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:
>> +		ret = regmap_field_read(data->regfield_int_en, &curr_state);
>> +		if (ret)
>> +			return ret;
>> +		if (curr_state == state)
>> +			return 0;
>> +		ret = regmap_field_write(data->regfield_int_en, state);
>> +		if (ret)
>> +			return ret;
>> +		mutex_lock(&data->mutex);
>> +		ret = apds9306_runtime_power(data, state);
>> +		mutex_unlock(&data->mutex);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>> +		ret = regmap_field_write(data->regfield_int_thresh_var_en, state);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
> 
> Again, use the same style, here you have no lock, so you may return directly.
> No need to have this.
> 
>> +	}
>> +
>> +	return ret;
> 
> Why ret?
Once, it is clear whether regmap's internal locking should be used or not,
this function will be re-implemented.
> 
> ...
> 
>> +	regmap_field_write(data->regfield_int_en, 0);
>> +	/* Clear status */
>> +	regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
>> +	/* Put the device in standby mode */
>> +	apds9306_power_state(data, standby);
> 
> 
> No error checks at all?
Missed it. I'll do that.
> 
> ...
> 
>> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +				apds9306_irq_handler, IRQF_TRIGGER_FALLING |
>> +				IRQF_ONESHOT, "apds9306_event", indio_dev);
> 
> Re-indent them to have logical split on the lines.
Yes.

> 
>> +static int apds9306_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> 
> WHy? Use dev_get_drvdata() directly.
Thanks. I'll use that function.

>> +
>> +static int apds9306_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> 
> Ditto.
Yes.

> Alternatively
> 
> static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
> 				 apds9306_runtime_suspend,
> 				 apds9306_runtime_resume,
> 				 NULL);
> 
Thank you. Second option looks nice. I'll stick to that.
> 
> Redundant blank line.
It will be fixed.


Regards,
Subhajit Ghosh
  

