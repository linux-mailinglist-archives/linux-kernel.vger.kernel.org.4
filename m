Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D66D5CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjDDKH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjDDKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:07:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27901BD6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:07:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r7-20020a17090b050700b002404be7920aso31540212pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1680602844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0naYlH38qDPlxYqIhqWjzrElNtaC1EIByyzISKIVm5I=;
        b=hUXeQRJ2IkL3FHCz5472bpj5Avec2dfWS98yb687j7IC+zBQGS4OSHGAIpG/LW9/tj
         FC6UKgp3mbMtzSj26yFACNFsHJ9vGkVh4NA61fu1Ihi3H4vilivnqwurzPvgLNhDSWda
         hj90vs6wOOoyPeMuRT/SZDjDIiWSA8DsWTxmFPYGdhGlb+t+CXTZ9ox5DBHYtv7eKZuT
         AvZoLFtUHVL5PNhKfUNmmY3/7KE+0B5JlyNOTSJ2z/dC4R8HaF7T3DnVJQyuyIoyZsLP
         Ftgekqkn2UyW63qcr8k+IZZkPtnue7Hw8P4bMUTjz1PCmZQ+6hCGWYW7Yjt3FRuo1CCk
         U3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0naYlH38qDPlxYqIhqWjzrElNtaC1EIByyzISKIVm5I=;
        b=f9MuiAZJ6a98wMtJTLHFe8AiIaBypbkl5+mUCQ02ph1IeUT7u4CnVXm5DVesS6iPaN
         NMtR2p4SVL1g2cp+bjSBRAS13zlbNJzt0TIdWAKNNKuLswfKbioHvToMn0SoBjqP9CxA
         ooiJ/udLs9KjAjKFa0j7h0iE8eI2Y0qyCz5Fd5Ht0yAdZVQEfOj3RoOpsCEKX2iBoeky
         ZqpxVX8ayrMjgg9qapNzHDTn/3nr6PR/N2Gyvv9jFQnSsfqIR7EocPBObeEWitaprmCI
         X+kD7Ty0zEypuJbVptpJhOwMN5+0kL1miW6qHHkjrgJJJt5nk1UWLMafuj2L3Mixx1nr
         Cj5w==
X-Gm-Message-State: AAQBX9etmqIsxCnwFFKF45J0I6Mq+w9DEv8kexmC4sCpy2RSeeGj89ns
        N+HZA2gPsUIKMBllLO8EdBq7rQ==
X-Google-Smtp-Source: AKy350a/NYtTpDxDGMHqKHRNq4Ks26w1ekraxpVVAIQNOOX2wpIdNfRyWa0Uw8DkPY++8VaakBfWOQ==
X-Received: by 2002:a17:902:ec8f:b0:1a1:7da3:ef5b with SMTP id x15-20020a170902ec8f00b001a17da3ef5bmr2381734plg.7.1680602844317;
        Tue, 04 Apr 2023 03:07:24 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902bc4600b001a19f3a661esm7974713plz.138.2023.04.04.03.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:07:24 -0700 (PDT)
Message-ID: <c8f709d3-1a8e-c98c-6917-839a0ca4d4ff@9elements.com>
Date:   Tue, 4 Apr 2023 15:37:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] iio: max597x: Add support for max597x
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
 <20230402180123.0fc1cfde@jic23-huawei>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230402180123.0fc1cfde@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 02-04-2023 10:31 pm, Jonathan Cameron wrote:
> On Tue, 28 Mar 2023 11:44:14 +0200
> Naresh Solanki <naresh.solanki@9elements.com> wrote:
> 
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> max5970 & max5978 has 10bit ADC for voltage & current
>> monitoring.
>> Use iio framework to expose the same in sysfs.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
> 
> --- not ...
> 
> As I mentioned in my reply to v2 thread (which crossed with this v3)
> I'd like this series to be cc'd to the list and maintainers for Hwmon
> with a cover letter explaining the reasoning for it being an IIO driver
> + the restrictions that potentially brings.
Sure.
> 
> A few other comments inline from taking another look.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> Changes in V3:
>> - Use bulk read
>> - Remove line split
>> Changes in V2:
>> - Remove fallthrough
>> - Use pdev->dev instead of i2c->dev
>> - Init indio_dev->name based on device type.
>> ---
>>   drivers/iio/adc/Kconfig       |  15 ++++
>>   drivers/iio/adc/Makefile      |   1 +
>>   drivers/iio/adc/max597x-iio.c | 148 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 164 insertions(+)
>>   create mode 100644 drivers/iio/adc/max597x-iio.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 45af2302be53..69310af5c665 100644
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
>> +	  This driver enables support for the Maxim 5970 & 5978 smart switch
>> +	  and voltage/current monitoring interface using the Industrial I/O
>> +	  (IIO) framework. The Maxim 597x is a power switch and monitor that can
>> +	  provide voltage and current measurements via the I2C bus. Enabling
>> +	  this driver will allow user space applications to read the voltage
>> +	  and current measurements using IIO interfaces.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called max597x-iio.
>> +
>>   config MAX9611
>>   	tristate "Maxim max9611/max9612 ADC driver"
>>   	depends on I2C
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 36c18177322a..7ec0c2cf7bbb 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
>>   obj-$(CONFIG_MAX11410) += max11410.o
>>   obj-$(CONFIG_MAX1241) += max1241.o
>>   obj-$(CONFIG_MAX1363) += max1363.o
>> +obj-$(CONFIG_MAX597X_IIO) += max597x-iio.o
>>   obj-$(CONFIG_MAX9611) += max9611.o
>>   obj-$(CONFIG_MCP320X) += mcp320x.o
>>   obj-$(CONFIG_MCP3422) += mcp3422.o
>> diff --git a/drivers/iio/adc/max597x-iio.c b/drivers/iio/adc/max597x-iio.c
>> new file mode 100644
>> index 000000000000..f158e49b5a56
>> --- /dev/null
>> +++ b/drivers/iio/adc/max597x-iio.c
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device driver for IIO in MAX5970 and MAX5978 IC
>> + *
>> + * Copyright (c) 2022 9elements GmbH
>> + *
>> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>> + */
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/mfd/max597x.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +struct max597x_iio {
>> +	struct regmap *regmap;
>> +	int shunt_micro_ohms[MAX5970_NUM_SWITCHES];
>> +	unsigned int irng[MAX5970_NUM_SWITCHES];
>> +	unsigned int mon_rng[MAX5970_NUM_SWITCHES];
>> +};
>> +
>> +#define MAX597X_ADC_CHANNEL(_idx, _type) {			\
>> +	.type = IIO_ ## _type,					\
>> +	.indexed = 1,						\
>> +	.channel = (_idx),					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>> +			      BIT(IIO_CHAN_INFO_SCALE),		\
>> +	.address = MAX5970_REG_ ## _type ## _L(_idx),		\
>> +}
>> +
>> +static const struct iio_chan_spec max5978_adc_iio_channels[] = {
>> +	MAX597X_ADC_CHANNEL(0, VOLTAGE),
>> +	MAX597X_ADC_CHANNEL(0, CURRENT),
>> +};
>> +
>> +static const struct iio_chan_spec max5970_adc_iio_channels[] = {
>> +	MAX597X_ADC_CHANNEL(0, VOLTAGE),
>> +	MAX597X_ADC_CHANNEL(0, CURRENT),
>> +	MAX597X_ADC_CHANNEL(1, VOLTAGE),
>> +	MAX597X_ADC_CHANNEL(1, CURRENT),
>> +};
>> +
>> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				int *val, int *val2, long info)
>> +{
>> +	int ret;
>> +	struct max597x_iio *data = iio_priv(iio_dev);
>> +	u16 reg_l, reg_h;
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = regmap_bulk_read(data->regmap, chan->address - 1, &reg_l, 2);
> 
> This crossed with my reply to the v2 thread.  If reading two separate registers that
> don't directly correspond to a large packed value, read them into an array
> of u8.  Then get the relevant parts from that.
Sure
> 
> The following use is not endian safe (it won't work on a big endian machine)
Sure
> 
>> +		if (ret < 0)
>> +			return ret;
>> +		reg_h = reg_l & 0xff;
>> +		reg_l = (reg_l >> 8) & 0xff;
>> +		*val = (reg_h << 2) | (reg_l & 3);
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->address) {
>> +		case MAX5970_REG_CURRENT_L(0):
>> +		case MAX5970_REG_CURRENT_L(1):
>> +			/* in A, convert to mA */
>> +			*val = data->irng[chan->channel] * 1000;
>> +			*val2 = data->shunt_micro_ohms[chan->channel] * ADC_MASK;
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
> 
> I'd prefer this pushed up as a default: in each of the two switch statements.
> Makes it clear to compilers and readers that only listing some case values is
> deliberate.
Sure
> 
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
>> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> +	if (!indio_dev)
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>> +				     "failed to allocate iio device\n");
>> +
>> +	indio_dev->info = &max597x_adc_iio_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	switch (max597x->num_switches) {
> 
> Having a value 'num_switches' that maps to a set of enums called _TYPE_ is unusual.
> Perhaps rename it to type.
Will add a local variable type to track the same within with driver.

> 
> 
>> +	case MAX597x_TYPE_MAX5970:
>> +		indio_dev->channels = max5970_adc_iio_channels;
>> +		indio_dev->num_channels = ARRAY_SIZE(max5970_adc_iio_channels);
>> +		indio_dev->name = "max5970";
>> +		break;
>> +	case MAX597x_TYPE_MAX5978:
>> +		indio_dev->channels = max5978_adc_iio_channels;
>> +		indio_dev->num_channels = ARRAY_SIZE(max5978_adc_iio_channels);
>> +		indio_dev->name = "max5978";
>> +		break;
>> +	}
>> +
>> +	priv = iio_priv(indio_dev);
>> +	priv->regmap = regmap;
>> +	for (i = 0; i < indio_dev->num_channels; i++) {
>> +		priv->irng[i] = max597x->irng[i];
>> +		priv->mon_rng[i] = max597x->mon_rng[i];
>> +		priv->shunt_micro_ohms[i] = max597x->shunt_micro_ohms[i];
>> +	}
>> +
>> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "could not register iio device\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver max597x_iio_driver = {
>> +	.driver = {
>> +		.name = "max597x-iio",
>> +	},
>> +	.probe = max597x_iio_probe,
>> +};
>> +
>> +module_platform_driver(max597x_iio_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
>> +MODULE_LICENSE("GPL");
>>
>> base-commit: 368eb79f738a21e16c2bdbcac2444dfa96b01aaa
> 

Regards,
Naresh
