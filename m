Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14B6CAD91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjC0So7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjC0Sou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:44:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE75262
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:44:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q102so8548201pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679942660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJKx3ROuPpySoPkX6h0zejKSYpDoyvBuCqcSMWc1HBE=;
        b=DhxyllRrGjGxXzpcWb4vZl7CeKF31v40Y7PdwURQmEjaADYpjQ+hWQJpPMYZg67Exs
         ERHiJdPEmweYMBwQjohUxD/G2EZMnhHv/1KFQdhNfOTVDqmP92v0IO+IJ8VV/ALW3XPG
         wxqMOSinQF5TdHvEIT0kieKUewlnMaCqLEsWlpxsP/8WulxP29xVHShBfJLA735O7xzI
         6HiECuXwjaIqg02mrCfRnN2YL+oZLn8g7OYz3ONLvXm7dQIJsiYnvJY6sjIW++t+tbTo
         xnxcpQLqVtRYHNLJ8nI3ZbyW/qAFJV0lzn5VBIEF8mfF01pTBNBEQiyRz6hYB7o4Bv3d
         NMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJKx3ROuPpySoPkX6h0zejKSYpDoyvBuCqcSMWc1HBE=;
        b=wyFNEWQ81LAPRy/4z4rzspQ+cm9xZjyFPR0sC7ZyzSYKslfgV9VSeZbpBU7IeKflZY
         Y98aHbaJd+I9Km18tXhoeknPeSWuFyONFsQcEofBeTJKaYDJtSzpLQTjoeJk479q8r+4
         3TES/Eg6s2jePiW7OQnNlFRniumzpgDe0AMmxtxNEYuH2zhDLqiBL6wr7kyxvl6HG9yj
         9nrkOgZEqrC352O70cBWt1rM/kR7oLnnf6xDyitv0yxImEWOuojQZ3KqBhkYNB1/oAHN
         cOOL/VarL2MoW+kQ3Km9TuE+d9mXrQp1r7yYPMfOfu1CgfyqE9Z+1BJZzMZUcaS6i+V3
         SB5A==
X-Gm-Message-State: AO0yUKXckWPJqrT7O9wSYzksjF8uafg3eZLGM1PF7lK6K0vxqvrpSMVY
        bHBjtie4jiIGoTRueswQeIWP4A==
X-Google-Smtp-Source: AK7set+rOMcqkVOWFpNJgx1CTMAC5km2y8uA+KMSrqRZLixDgdJZjuKFYMmeJHfP9AWRsMODY+IpZw==
X-Received: by 2002:a05:6a20:2921:b0:cc:ca9:4fde with SMTP id t33-20020a056a20292100b000cc0ca94fdemr10696672pzf.33.1679942659976;
        Mon, 27 Mar 2023 11:44:19 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79117000000b005a8173829d5sm17393736pfh.66.2023.03.27.11.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:44:19 -0700 (PDT)
Message-ID: <4188a480-15dd-0e17-b3e9-7572eee3ea0c@9elements.com>
Date:   Tue, 28 Mar 2023 00:14:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] iio: max597x: Add support for max597x
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <20230325193640.3dc8b330@jic23-huawei>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230325193640.3dc8b330@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-03-2023 01:06 am, Jonathan Cameron wrote:
> On Thu, 23 Mar 2023 20:45:48 +0100
> Naresh Solanki <naresh.solanki@9elements.com> wrote:
> 
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> max597x has 10bit ADC for voltage & current monitoring.
>> Use iio framework to expose the same in sysfs.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> I'm not a fan of wild cards in driver names. This doesn't
> for example support the max5974, max5971 etc
> 
> Much better to name it after one of the supported parts.
> Obviously can't do much about the mfd driver now, but I'd prefer
> not to carry that through to the IIO driver if possible.
> 
> One concern I have here is that from the max5978 datasheet I see
> this device supports features that are very much directed at hwmon
> type usecases.  In particular warning and critical threshold detection.
> We don't support multiple thresholds (in same direction) for a single
> channel via IIO.  If you want those features in the future you may want
> to consider using the hwmon subsystem.
> 
> We tend to be flexible with devices that sit near the boundary of IIO
> and hwmon because we can bridge many of the features using the iio-hwmon
> bridge driver.  That doesn't work for more complex event handling and
> I suspect some of the other features this device provides.
I believe it is the most appropriate approach for our use case at the 
moment. If we decide to incorporate more complex event handling or need 
to support multiple thresholds in the future, we will definitely 
consider using the hwmon subsystem. Thank for your input.
>    
>> ...
>> Changes in V2:
>> - Remove fallthrough
>> - Use pdev->dev instead of i2c->dev
>> - Init indio_dev->name based on device type.
>> ---
>>   drivers/iio/adc/Kconfig       |  15 ++++
>>   drivers/iio/adc/Makefile      |   1 +
>>   drivers/iio/adc/max597x-iio.c | 152 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+)
>>   create mode 100644 drivers/iio/adc/max597x-iio.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 45af2302be53..0d1a3dea0b7d 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -735,6 +735,21 @@ config MAX1363
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called max1363.
>>   
>> +config MAX597X_IIO
>> +	tristate "Maxim 597x power switch and monitor"
>> +	depends on I2C && OF
>> +	select MFD_MAX597X
>> +	help
>> +	  This driver enables support for the Maxim 597x smart switch and
>> +	  voltage/current monitoring interface using the Industrial I/O (IIO)
>> +	  framework. The Maxim 597x is a power switch and monitor that can
>> +	  provide voltage and current measurements via the I2C bus. Enabling
>> +	  this driver will allow user space applications to read the voltage
>> +	  and current measurements using IIO interfaces.
> 
> Call out the actual part numbers supported in this help text to make it easy
> to grep for them.
Sure. Will mention max5970 & max5978 in help section.
> 
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called max597x-iio.
>> +
> 
> ...
> 
> 
>> +
>> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int *val, int *val2, long info)
>> +{
>> +	int ret;
>> +	struct max597x_iio *data = iio_priv(iio_dev);
>> +	unsigned int reg_l, reg_h;
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = regmap_read(data->regmap, chan->address, &reg_l);
>> +		if (ret < 0)
>> +			return ret;
>> +		ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = (reg_h << 2) | (reg_l & 3);
> 
> I replied late to previous patch, but I'd prefer to see a bulk read if
> possible.  It might ensure a matched pair, or if not reduce the chance of
> tearing (when reg_l & 3 transitions from 3 to 0 for example and
> reg_h & 1 is going from 0 to 1)
> 
> You could try a repeated read if the sampling rate is fairly low as
> simply getting same high bits on either side of the low bit read is probably
> enough to say tearing didn't happen.
Yes. will use something like:
		ret = regmap_bulk_read(data->regmap, chan->address - 1, &reg_l, 2);
		if (ret < 0)
			return ret;
		reg_h = reg_l & 0xff;
		reg_l = (reg_l >> 8) & 0xff;
		*val = (reg_h << 2) | (reg_l & 3);
> 
>> +
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +
>> +		switch (chan->address) {
>> +		case MAX5970_REG_CURRENT_L(0):
>> +		case MAX5970_REG_CURRENT_L(1):
>> +			/* in A, convert to mA */
>> +			*val = data->irng[chan->channel] * 1000;
>> +			*val2 =
>> +			    data->shunt_micro_ohms[chan->channel] * ADC_MASK;
> Don't worry about 80 char limit when it hurts readability.  Just put that
> on one line.
Sure
> 
>> +			return IIO_VAL_FRACTIONAL;
>> +
>> +		case MAX5970_REG_VOLTAGE_L(0):
>> +		case MAX5970_REG_VOLTAGE_L(1):
>> +			/* in uV, convert to mV */
>> +			*val = data->mon_rng[chan->channel];
>> +			*val2 = ADC_MASK * 1000;
>> +			return IIO_VAL_FRACTIONAL;
>> +		}
>> +
>> +		break;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info max597x_adc_iio_info = {
>> +	.read_raw = &max597x_iio_read_raw,
>> +};
>> +
>> +static int max597x_iio_probe(struct platform_device *pdev)
>> +{
>> +	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
>> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	struct iio_dev *indio_dev;
>> +	struct max597x_iio *priv;
>> +	int ret, i;
>> +
>> +	if (!regmap)
>> +		return -EPROBE_DEFER;
>> +
>> +	if (!max597x || !max597x->num_switches)
>> +		return -EPROBE_DEFER;
>> +
>> +	/* registering iio */
> 
> Comment doesn't add anything is is wrong anyway as this doesn't do the
> majority of the registration. Dropt he comment.
Sure.
> 
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> +	if (!indio_dev)
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>> +				     "failed to allocate iio device\n");
> 
> ...
> 

BR,
Naresh
