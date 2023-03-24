Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804346C7C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCXKK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:10:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782324BE3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:10:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so1367884pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679652652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4KS5G3REHVCdxBgUTUEliCmdg0KdWIiJLQyKXqBc8o=;
        b=T971bppT4E5KW3z8EklcB48B725o+sWZpdb8P3syTbEgrBqgbsUtkH1NU9NB11yQEL
         uSpE3Hkw8E+ChGrirhdOIQzXmyglPiZCAw8jH9aGeyI4J73YD9gvOjjOHOb0cH6cJsuu
         aXPMTZFJoqvfIFFxeQxfQemjRgRoJxMjMatUNPP/PGDrbijRJuFMXm2Kr6ZLXmlgNxEr
         Vg9CRsReoOHIHLscpE75sVbsogHchW9TdzSnQyObLYWTAu+lcnPIB8v5FDEmGcuiJGAu
         iP37OrvLFnL6kmHoc52cIW3O5rNvrF/2O8YJdEgsyEs6UWj26PvADgSylGZDIs20Wwe3
         DM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4KS5G3REHVCdxBgUTUEliCmdg0KdWIiJLQyKXqBc8o=;
        b=Dt7D1OXkSG95XjED4Lvhm7rpeQj0MbkLuNXhY29OxJU6jgOXMAIlOW+ufMNTFvU6RZ
         ncLuhGxyQt+MitoyV/PnZB6CdD7NgUOHqPnDiQp8ElVp/oASoNxdEZl/9BjInGRshz9L
         y5ft/sEQjqxrR10JcvCvbRaeISUnmLwyla0IUP9RHSNF/DMtyGEOF8FxrheBPb3EzB7Q
         1u+ms7YkXnP+NFv7oToBvExKD86UYiS7CwYEgruF3KF7ZARz9CM/E9Hp8RzJ1po6Qh+R
         cIsfuIAflOQNDL5WTdMWoOT2Fb6OOZcma3vGVVrtzA9cU1i7bbNkIY6CPkK5kr5ce1s2
         Y0Vw==
X-Gm-Message-State: AAQBX9dmZkSEDTkOFkOPBkP0iMb3jqLr27sE6oyvxFwI5Ith4kfwN0mo
        LlDWjS6uH4mhmSs+dl56lQd6NbXcjnBwH3ABUSZO4g==
X-Google-Smtp-Source: AKy350bMN38ffgwIpzSmXtq+JrV7BDSFXJNQlgxqgWDzullhuOnJWv6Vb/49p5tbUEulIx7AEVihLQ==
X-Received: by 2002:a17:903:684:b0:19d:297:f30b with SMTP id ki4-20020a170903068400b0019d0297f30bmr1750023plb.19.1679652652570;
        Fri, 24 Mar 2023 03:10:52 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902a5c700b001a207906418sm2564043plq.23.2023.03.24.03.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:10:52 -0700 (PDT)
Message-ID: <5e861c22-84e0-6f97-e25b-f754257e2f74@9elements.com>
Date:   Fri, 24 Mar 2023 15:40:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] iio: max597x: Add support for max597x
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jic23@kernel.org, lars@metafoo.de, lee@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick.rudolph@9elements.com
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <10c6640e-4de3-65dd-8798-988def9a6cc5@wanadoo.fr>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <10c6640e-4de3-65dd-8798-988def9a6cc5@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24-03-2023 01:36 am, Christophe JAILLET wrote:
> Le 23/03/2023 à 20:45, Naresh Solanki a écrit :
>> From: Patrick Rudolph 
>> <patrick.rudolph-cWEv32IpryCakBO8gow8eQ@public.gmane.org>
>>
>> max597x has 10bit ADC for voltage & current monitoring.
>> Use iio framework to expose the same in sysfs.
>>
>> Signed-off-by: Patrick Rudolph 
>> <patrick.rudolph-cWEv32IpryCakBO8gow8eQ@public.gmane.org>
>> Signed-off-by: Naresh Solanki 
>> <Naresh.Solanki-cWEv32IpryCakBO8gow8eQ@public.gmane.org>
> 
> Hi, a few nits below, should there be a v3.
> 
> CJ
> 
>> ...
>> Changes in V2:
>> - Remove fallthrough
>> - Use pdev->dev instead of i2c->dev
>> - Init indio_dev->name based on device type.
>> ---
>>   drivers/iio/adc/Kconfig       |  15 ++++
>>   drivers/iio/adc/Makefile      |   1 +
>>   drivers/iio/adc/max597x-iio.c | 152 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+)
>>   create mode 100644 drivers/iio/adc/max597x-iio.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 45af2302be53..0d1a3dea0b7d 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -735,6 +735,21 @@ config MAX1363
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called max1363.
>> +config MAX597X_IIO
>> +    tristate "Maxim 597x power switch and monitor"
>> +    depends on I2C && OF
>> +    select MFD_MAX597X
>> +    help
>> +      This driver enables support for the Maxim 597x smart switch and
>> +      voltage/current monitoring interface using the Industrial I/O 
>> (IIO)
>> +      framework. The Maxim 597x is a power switch and monitor that can
>> +      provide voltage and current measurements via the I2C bus. Enabling
>> +      this driver will allow user space applications to read the voltage
>> +      and current measurements using IIO interfaces.
>> +
>> +      To compile this driver as a module, choose M here: the module 
>> will be
>> +      called max597x-iio.
>> +
>>   config MAX9611
>>       tristate "Maxim max9611/max9612 ADC driver"
>>       depends on I2C
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 36c18177322a..7ec0c2cf7bbb 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
>>   obj-$(CONFIG_MAX11410) += max11410.o
>>   obj-$(CONFIG_MAX1241) += max1241.o
>>   obj-$(CONFIG_MAX1363) += max1363.o
>> +obj-$(CONFIG_MAX597X_IIO) += max597x-iio.o
>>   obj-$(CONFIG_MAX9611) += max9611.o
>>   obj-$(CONFIG_MCP320X) += mcp320x.o
>>   obj-$(CONFIG_MCP3422) += mcp3422.o
>> diff --git a/drivers/iio/adc/max597x-iio.c 
>> b/drivers/iio/adc/max597x-iio.c
>> new file mode 100644
>> index 000000000000..8a9fc27ff71e
>> --- /dev/null
>> +++ b/drivers/iio/adc/max597x-iio.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device driver for IIO in MAX5970 and MAX5978 IC
>> + *
>> + * Copyright (c) 2022 9elements GmbH
>> + *
>> + * Author: Patrick Rudolph 
>> <patrick.rudolph-cWEv32IpryCakBO8gow8eQ@public.gmane.org>
>> + */
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/mfd/max597x.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +struct max597x_iio {
>> +    struct regmap *regmap;
>> +    int shunt_micro_ohms[MAX5970_NUM_SWITCHES];
>> +    unsigned int irng[MAX5970_NUM_SWITCHES];
>> +    unsigned int mon_rng[MAX5970_NUM_SWITCHES];
>> +};
>> +
>> +#define MAX597X_ADC_CHANNEL(_idx, _type) {            \
>> +    .type = IIO_ ## _type,                    \
>> +    .indexed = 1,                        \
>> +    .channel = (_idx),                    \
>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |        \
>> +                  BIT(IIO_CHAN_INFO_SCALE),        \
>> +    .address = MAX5970_REG_ ## _type ## _L(_idx),        \
>> +}
>> +
>> +static const struct iio_chan_spec max5978_adc_iio_channels[] = {
>> +    MAX597X_ADC_CHANNEL(0, VOLTAGE),
>> +    MAX597X_ADC_CHANNEL(0, CURRENT),
>> +};
>> +
>> +static const struct iio_chan_spec max5970_adc_iio_channels[] = {
>> +    MAX597X_ADC_CHANNEL(0, VOLTAGE),
>> +    MAX597X_ADC_CHANNEL(0, CURRENT),
>> +    MAX597X_ADC_CHANNEL(1, VOLTAGE),
>> +    MAX597X_ADC_CHANNEL(1, CURRENT),
>> +};
>> +
>> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
>> +                struct iio_chan_spec const *chan,
>> +                int *val, int *val2, long info)
>> +{
>> +    int ret;
>> +    struct max597x_iio *data = iio_priv(iio_dev);
>> +    unsigned int reg_l, reg_h;
>> +
>> +    switch (info) {
>> +    case IIO_CHAN_INFO_RAW:
>> +        ret = regmap_read(data->regmap, chan->address, &reg_l);
>> +        if (ret < 0)
>> +            return ret;
>> +        ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
>> +        if (ret < 0)
>> +            return ret;
>> +        *val = (reg_h << 2) | (reg_l & 3);
>> +
>> +        return IIO_VAL_INT;
>> +    case IIO_CHAN_INFO_SCALE:
>> +
> 
> Nit: This blank line would look nicer if above the case:
Oh yes. Will do that in V3
> 
>> +        switch (chan->address) {
>> +        case MAX5970_REG_CURRENT_L(0):
>> +        case MAX5970_REG_CURRENT_L(1):
>> +            /* in A, convert to mA */
>> +            *val = data->irng[chan->channel] * 1000;
>> +            *val2 =
>> +                data->shunt_micro_ohms[chan->channel] * ADC_MASK;
>> +            return IIO_VAL_FRACTIONAL;
>> +
>> +        case MAX5970_REG_VOLTAGE_L(0):
>> +        case MAX5970_REG_VOLTAGE_L(1):
>> +            /* in uV, convert to mV */
>> +            *val = data->mon_rng[chan->channel];
>> +            *val2 = ADC_MASK * 1000;
>> +            return IIO_VAL_FRACTIONAL;
>> +        }
>> +
>> +        break;
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>> +static const struct iio_info max597x_adc_iio_info = {
>> +    .read_raw = &max597x_iio_read_raw,
>> +};
>> +
>> +static int max597x_iio_probe(struct platform_device *pdev)
>> +{
>> +    struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +    struct iio_dev *indio_dev;
>> +    struct max597x_iio *priv;
>> +    int ret, i;
>> +
>> +    if (!regmap)
>> +        return -EPROBE_DEFER;
>> +
>> +    if (!max597x || !max597x->num_switches)
>> +        return -EPROBE_DEFER;
>> +
>> +    /* registering iio */
>> +    indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> +    if (!indio_dev)
>> +        return dev_err_probe(&pdev->dev, -ENOMEM,
>> +                     "failed to allocate iio device\n");
>> +
>> +    indio_dev->info = &max597x_adc_iio_info;
>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +    switch (max597x->num_switches) {
>> +    case MAX597x_TYPE_MAX5970:
>> +        indio_dev->channels = max5970_adc_iio_channels;
>> +        indio_dev->num_channels = ARRAY_SIZE(max5970_adc_iio_channels);
>> +        indio_dev->name = "max5970";
>> +        break;
>> +    case MAX597x_TYPE_MAX5978:
>> +        indio_dev->channels = max5978_adc_iio_channels;
>> +        indio_dev->num_channels = ARRAY_SIZE(max5978_adc_iio_channels);
>> +        indio_dev->name = "max5978";
>> +        break;
>> +    }
>> +
>> +    priv = iio_priv(indio_dev);
>> +    priv->regmap = regmap;
>> +    for (i = 0; i < indio_dev->num_channels; i++) {
>> +        priv->irng[i] = max597x->irng[i];
>> +        priv->mon_rng[i] = max597x->mon_rng[i];
>> +        priv->shunt_micro_ohms[i] = max597x->shunt_micro_ohms[i];
>> +    }
>> +
>> +    ret = devm_iio_device_register(&pdev->dev, indio_dev);
>> +    if (ret)
>> +        dev_err_probe(&pdev->dev, ret, "could not register iio device");
> 
> Nit: \n missing
> 
Sure will make it like this:
	if (ret)
		return dev_err_probe(&pdev->dev, ret, "could not register iio device\n");
>> +
>> +    return ret;
> 
> Nit: return 0;
Sure
> 
>> +}
>> +
>> +static struct platform_driver max597x_iio_driver = {
>> +    .driver = {
>> +        .name = "max597x-iio",
>> +    },
>> +    .probe = max597x_iio_probe,
>> +};
>> +
>> +module_platform_driver(max597x_iio_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph 
>> <patrick.rudolph-cWEv32IpryCakBO8gow8eQ@public.gmane.org>");
>> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
>> +MODULE_LICENSE("GPL");
>>
>> base-commit: 368eb79f738a21e16c2bdbcac2444dfa96b01aaa
> 
