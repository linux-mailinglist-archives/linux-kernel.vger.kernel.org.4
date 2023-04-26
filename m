Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC566EED91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 07:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbjDZFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjDZFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:33:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70233273A;
        Tue, 25 Apr 2023 22:32:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f001a2f3aeso1267562e87.2;
        Tue, 25 Apr 2023 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682487173; x=1685079173;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKiRzAfexxSoERWHBC6uVUHZJQjp6Uwktpa+usUqLzA=;
        b=g4OTVTxjUYPNnrYDSAhfFNtCPEOR3GTLbWruZI20l9JSwxH345AnQZqWPlbmVS3eOS
         jleqWwBcKgOhVzmlefwnCmeR9wUlk4iEerH1Vg8OjimmyFTVUUFfVqTEh6MUnkYjjVNX
         oTo6uFw8b0tqfzqHvo86A3W0l/ITtx+i7QouhMYoygenyhBXcKu4mXZAzCeApymJlT9i
         rTfULu+i8UHy9HFKy7vBWQ8eLsKxDN0QSKBxBBBt/KL1OjTsSGYrL5ZGNi/81mOlK4tq
         sDFHY/R3YEFGLgQDkSZ9TVo2veeUjTE54sjL3bEpzng/T6ol7BaBKZguHwowPULWx1OR
         +r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682487173; x=1685079173;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKiRzAfexxSoERWHBC6uVUHZJQjp6Uwktpa+usUqLzA=;
        b=id9nfpxVfc+cIkFhyIeYvU3w75cpexwUG2hWyIsBpGB+07gsVGi3Rd7tykwg5P5omy
         kh6ibQq3pPt5AP30e9rE4D8sEuVPEuiP86kM/nnG8tej2fyBqiafJ/l79UGz+dqcWPlA
         pBu3EU/uyk4zpHCteEhfKV5DoT97CH1x9tXrE1Ix7T9v+KwnvFm2yB0WzH5ROvKtY34E
         9GuRIHk6WDj3bilTelviCStsZhGihzX4QkBA4Wgyd0khyGXtvhP52Mw+GSKvmRhM3Gwz
         ZyPVKagmG8jQ+XwDUlHy7qmdyuNp+tdQ8DT8t5ktMMkFRnslhAaIwt5s09WIWW5FaNkF
         ESFg==
X-Gm-Message-State: AAQBX9elWPgzMBwdI07kxGoJsm3U4MZveVEwbs8VsZaOoTUDXzqUMsIj
        cHP0lx7168kHSlr/PP7ObcITLxZaxaw=
X-Google-Smtp-Source: AKy350Yz1BOV0w/L5XtK8K3XucF4dgEEhKAheUJ6KYBCH72igIhl3eKyjfuvyC9hsBdmtMKRvpi44g==
X-Received: by 2002:ac2:5103:0:b0:4ea:f60c:4e29 with SMTP id q3-20020ac25103000000b004eaf60c4e29mr4551408lfb.20.1682487173031;
        Tue, 25 Apr 2023 22:32:53 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id k18-20020ac24572000000b004efeea0dcfesm1322473lfm.44.2023.04.25.22.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 22:32:52 -0700 (PDT)
Message-ID: <102a1605-d6dc-80c7-2075-212569c97042@gmail.com>
Date:   Wed, 26 Apr 2023 08:32:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
 <20230425164522.sljcniui5ox5yx3l@intel.intel>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <20230425164522.sljcniui5ox5yx3l@intel.intel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Thanks for the review! It's nice to see you're still keeping an eye on 
ROHM / Kionix senor drivers ;)

On 4/25/23 19:45, Andi Shyti wrote:
> Hi Matti,
> 
> [...]
> 
>> +static int bu27008_get_int_time(struct bu27008_data *data)
> 
> this is providing the time in 'us' if I understood correctly.
> 
> Can you add it at the end of the function to make it clear?
> bu27008_get_int_time_us().
> 
> No need to resend it just for this.

I like the idea.

> 
>> +{
>> +	int ret, sel;
>> +
>> +	ret = bu27008_get_int_time_sel(data, &sel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return iio_gts_find_int_time_by_sel(&data->gts,
>> +					    sel & BU27008_MASK_MEAS_MODE);
>> +}
> 
> [...]
> 
>> +static int bu27008_try_set_int_time(struct bu27008_data *data, int int_time_new)
>> +{
>> +	int ret, old_time_sel, new_time_sel,  old_gain, new_gain;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	ret = bu27008_get_int_time_sel(data, &old_time_sel);
>> +	if (ret < 0)
>> +		goto unlock_out;
>> +
>> +	if (!iio_gts_valid_time(&data->gts, int_time_new)) {
>> +		dev_dbg(data->dev, "Unsupported integration time %u\n",
>> +			int_time_new);
>> +
>> +		ret = -EINVAL;
>> +		goto unlock_out;
>> +	}
>> +	new_time_sel = iio_gts_find_sel_by_int_time(&data->gts, int_time_new);
>> +	if (new_time_sel == old_time_sel) {
>> +		ret = 0;
> 
> ret is already '0' here.

Good point! Kills the ugly brackets just nice :)

> 
>> +		goto unlock_out;
>> +	}
> 
> [...]
> 
>> +static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
>> +			    struct iio_chan_spec const *chan, int *val, int *val2)
>> +{
>> +	int ret, int_time;
>> +
>> +	ret = bu27008_chan_cfg(data, chan);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = bu27008_meas_set(data, BU27008_MEAS_EN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	int_time = bu27008_get_int_time(data);
>> +	if (int_time < 0)
>> +		int_time = 400000;
>> +
>> +	msleep((int_time + 500) / 1000);
> 
> What is this 500 doing? Is it making a real difference? it's
> 0.5ms.

Thanks for the question, having extra pairs of eyes helps spotting 
brainfarts :)

The 500 here is half of the value of the divider - idea was to do 
rounding correctly upwards to prevent premature wake-up. Well, this is 
incorrect because we should always round up the sleep time, not just 
'mathematically correctly' (Eg, not only upwards when value >= 0.5 but 
upwards always when the division is not even).

After this being said, integration times for this device are full milli 
seconds so they can all be divided by 1000 uS.

Nevertheless, it's good to note that the sensor is definitely not being 
clocked by the same clock as CPU and I assume the timing for it will be 
drifting quite a bit from the CPU clock. This means some sensors will 
for sure complete the measurement later than this wake-up. In order to 
tackle this we have the valid-bit polling in bu27008_chan_read_data(). 
So, at the end of the day, this rounding correction is lkely to be just 
some unnecessary noise.

> What's the minimum int_time? Can we set a minimum, as well, just
> for the sake of the msleep?

Can you please elaborate what you mean by this? The minimum integration 
time for bu27008 is 55 mS and this is set in the time tables for the 
gts-helpers. The bu27008_get_int_time() should never return valid time 
smaller than that.

>> +	ret = bu27008_chan_read_data(data, chan->address, val);
>> +	if (!ret)
>> +		ret = IIO_VAL_INT;
> 
> [...]
> 
>> +static int bu27008_set_scale(struct bu27008_data *data,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2)
>> +{
>> +	int ret, gain_sel, time_sel, i;
>> +
>> +	if (chan->scan_index == BU27008_IR)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	ret = bu27008_get_int_time_sel(data, &time_sel);
>> +	if (ret < 0)
>> +		goto unlock_out;
>> +
>> +
> 
> extra line here.
> 
>> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
>> +						val, val2 * 1000, &gain_sel);
>> +	if (ret) {
>> +		/* Could not support new scale with existing int-time */
>> +		int new_time_sel;
>> +
>> +		for (i = 0; i < data->gts.num_itime; i++) {
>> +			new_time_sel = data->gts.itime_table[i].sel;
>> +			ret = iio_gts_find_gain_sel_for_scale_using_time(
>> +				&data->gts, new_time_sel, val, val2 * 1000,
>> +				&gain_sel);
>> +			if (!ret)
>> +				break;
>> +		}
>> +		if (i == data->gts.num_itime) {
>> +			dev_err(data->dev, "Can't support scale %u %u\n", val,
>> +				val2);
>> +
>> +			ret = -EINVAL;
>> +			goto unlock_out;
>> +		}
>> +
>> +		ret = bu27008_set_int_time_sel(data, new_time_sel);
>> +		if (ret)
>> +			goto unlock_out;
>> +	}
> 
> just a nit: I see you got tight here and goto's are not made only
> for error handling. You could:
> 
> 	if (!ret)
> 		goto something;
> 
> 	/*
> 	 * everything that you have inside the 'if (ret)' with
> 	 * one level of indentation less
> 	 */
> 
>     something:
> 	ret = bu27008_write_gain_sel(data, gain_sel);
> 
> 	/* ... */
> 
> free to ignore this comment, though, I just saw that there are a
> few cases where you can save some indentation above.
> 

Thanks for the suggestion. I am not really sure which way I like better. 
I think the logic is tiny bit easier to follow when the success case is 
not handled with goto. OTOH, with a proper descriptive goto label 
(definitely not 'something' ;) ) this "tiny bit" gets, well, tiny.

Yet, the indentation is not _that_ deep here - logic does not (in my 
opinion) get messy because of nesting but 
iio_gts_find_gain_sel_for_scale_using_time - is a long function name and 
the call looks kind of ugly.

Thanks for the suggestion - I'll see how this looks like and decide when 
I open the file next time :)

>> +
>> +	ret = bu27008_write_gain_sel(data, gain_sel);
>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
> 
> [...]
> 
>> +static int bu27008_chip_init(struct bu27008_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
>> +			   BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
>> +
>> +	/*
>> +	 * The data-sheet does not tell how long performing the IC reset takes.
>> +	 * However, the data-sheet says the minimum time it takes the IC to be
>> +	 * able to take inputs after power is applied, is 100 uS. I'd assume
>> +	 * > 1 mS is enough.
>> +	 */
>> +	msleep(1);
> 
> please use usleep_range().

I prefer to not require setting up hrtimers as we have no real 
requirements for the duration of this sleep. I know the msleep() is 
likely to exceed the 1 mS, potentially a lot if there is things to do - 
but we don't really care at this point. The main thing is to give the HW 
time to reset while allowing other things to be scheduled.

> 
>> +
>> +	return ret;
>> +}
> 
> [...]
> 
>> +static irqreturn_t bu27008_trigger_handler(int irq, void *p)
> 
> Do we really need to be in atomic context here? Can this be
> handled from a thread?

As far as I understand, this is handled from a process context.

> 
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct bu27008_data *data = iio_priv(idev);
>> +	struct {
>> +		__le16 chan[BU27008_NUM_HW_CHANS];
>> +		s64 ts __aligned(8);
>> +	} raw;
>> +	int ret, dummy;
>> +
>> +	memset(&raw, 0, sizeof(raw));
>> +
>> +	/*
>> +	 * After some measurements, it seems reading the
>> +	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
>> +	 */
>> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
>> +	if (ret < 0)
>> +		goto err_read;
>> +
>> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, &raw.chan,
>> +			       sizeof(raw.chan));
>> +	if (ret < 0)
>> +		goto err_read;
>> +
>> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
>> +err_read:
>> +	iio_trigger_notify_done(idev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> [...]
> 
>> +static int bu27008_probe(struct i2c_client *i2c)
>> +{
>> +	struct device *dev = &i2c->dev;
>> +	struct iio_trigger *itrig;
>> +	struct bu27008_data *data;
>> +	struct regmap *regmap;
>> +	unsigned int part_id, reg;
>> +	struct iio_dev *idev;
>> +	char *name;
>> +	int ret;
>> +
>> +	if (!i2c->irq)
>> +		dev_warn(dev, "No IRQ configured\n");
> 
> [...]
> 
>> +	if (i2c->irq) {
> 
> e.g.:
> 
> 
> 	if (!i2c->irq) {
> 		dev_warn(dev, "No IRQ configured\n");
> 		goto no_irq;
> 	}
> 
> 	/* ... */
> 
> or, if you don't like the goto used like this...
> 
>> +		ret = devm_iio_triggered_buffer_setup(dev, idev,
>> +						      &iio_pollfunc_store_time,
>> +						      bu27008_trigger_handler,
>> +						      &bu27008_buffer_ops);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +				     "iio_triggered_buffer_setup_ext FAIL\n");
>> +
>> +		itrig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d",
>> +					       idev->name, iio_device_id(idev));
>> +		if (!itrig)
>> +			return -ENOMEM;
>> +
>> +		data->trig = itrig;
>> +
>> +		itrig->ops = &bu27008_trigger_ops;
>> +		iio_trigger_set_drvdata(itrig, data);
>> +
>> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s-bu27008",
>> +				      dev_name(dev));
>> +
>> +		ret = devm_request_threaded_irq(dev, i2c->irq,
>> +						iio_pollfunc_store_time,
>> +						&bu27008_irq_thread_handler,
>> +						IRQF_ONESHOT, name, idev->pollfunc);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Could not request IRQ\n");
>> +
>> +
>> +		ret = devm_iio_trigger_register(dev, itrig);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Trigger registration failed\n");
>> +	}
> 
> 	} else {
> 		dev_warn(dev, "No IRQ configured\n");
> 	}
> 
> and save the first 'if' of this function.

Thanks. I like this suggestion. I should've done it like this in the 
first place.

> 
>> +
>> +	ret = devm_iio_device_register(dev, idev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register iio device\n");
>> +
>> +	return ret;
>> +}


Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

