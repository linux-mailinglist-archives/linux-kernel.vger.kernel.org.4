Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B836A62565F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiKKJOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKKJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:14:11 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBED5CD36
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:14:09 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 136so3973300pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMc8vI7zPupIH5NMouyK7zEwaRdl05YzFkjBeaTXwAs=;
        b=VkaY5AsLYXMb0wlAaHJROmjkzOY/qJyXntdM8NFQHne3OqOCHMXf8Ck14YxHvNwelP
         +SZUeVCXmP9iw9UhVt84mkTdOu5fCwFeh5B7ql5O47uH9WykeAdERScFSO32M0RgGEkT
         dyAjDwc+/03BRSZjsfTj1jXYulzXq2v+boQqmmhvXY9p6zCH2ejmlmU08nAO0fZL1jk5
         gO3WR2eN8+9vUh9t7zCfNjhqfC08+XHPLoeo4Q1DwrWrtZohPICOWHPSXTZrnsD7DEom
         Q922u4jLiFBHyxJmVi33aJGrFMw6tA1WcT3A3+nFCLzLokQoYUifJMHpyQbfUktXGRbE
         bsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMc8vI7zPupIH5NMouyK7zEwaRdl05YzFkjBeaTXwAs=;
        b=5Q6N9iPzl+MNOPcEsYm97injOZvftgGV3DoS2QoUL97TfuzbEVEr0a3LLfnw+NE2o4
         qggYmi6RQYnP8CXwR0RbDwzCX6ITHbxFxE+IGloA2MTbrJee9jQPlfMvC7ixBKyoOzqF
         2YyH6D3OZZKdg6JyhIPHXw5bO00rZHgRYM6EqWxsAVHPciM8ORpB9n3PX56GWeIgnE7r
         0KX8LlIJFpHBsPqnOUIStlaJc3dn5XpFW0irF+BvjfkMxJ3H6AR64k+Fnw7Yuwl0RyzB
         tF1o7nwyeNzG+Gm4cpHBa2aMgQ3VdDv6ZHRVlJXmUB4z4vN9JpJ5ywq4OJTlOj1mC1hz
         Xlyg==
X-Gm-Message-State: ANoB5plr7jN1qfnF+C/I814GTYfWJinYpTCi4CvEcv+1bRr5+3DxxOgz
        yZQKTwdGmaxK2oBxlxiKu3Gkgg==
X-Google-Smtp-Source: AA0mqf4j//T+50H849o2X6we+9B/8/KWeod28ayuSO03WgwbyHOZw13Kw4IT7cxaJhSSzSXUPhU4Nw==
X-Received: by 2002:a63:4759:0:b0:46e:ca75:a5f1 with SMTP id w25-20020a634759000000b0046eca75a5f1mr891201pgk.161.1668158048484;
        Fri, 11 Nov 2022 01:14:08 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001753654d9c5sm1175501plb.95.2022.11.11.01.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:14:07 -0800 (PST)
Message-ID: <f5e5a2d3-d985-f351-78e0-8a479a6d896a@9elements.com>
Date:   Fri, 11 Nov 2022 14:44:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v8 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
 <20221103213425.2474772-3-Naresh.Solanki@9elements.com>
 <Y2jRm2J4tvK5ET1e@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <Y2jRm2J4tvK5ET1e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

On 07-11-2022 03:06 pm, Lee Jones wrote:
> On Thu, 03 Nov 2022, Naresh Solanki wrote:
> 
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Implement a regulator driver with IRQ support for fault management.
> 
> This is not a "regulator driver".
> 
>> Written against documentation [1] and [2] and tested on real hardware.
>>
>> Every channel has its own regulator supplies nammed 'vss1-supply' and
>> 'vss2-supply'. The regulator supply is used to determine the output
>> voltage, as the smart switch provides no output regulation.
>> The driver requires the 'shunt-resistor-micro-ohms' property to be
>> present in Device Tree to properly calculate current related
>> values.
>>
>> Datasheet links:
>> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> Can you explain these tags to me please?
> 
> Patrick wrote it.  Then what happened?
> 
Yes Its written by Patrick & Marcello.
>> ---
>>   drivers/mfd/Kconfig         |  12 +++++
>>   drivers/mfd/Makefile        |   1 +
>>   drivers/mfd/max597x.c       |  92 ++++++++++++++++++++++++++++++++
>>   include/linux/mfd/max597x.h | 103 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 208 insertions(+)
>>   create mode 100644 drivers/mfd/max597x.c
>>   create mode 100644 include/linux/mfd/max597x.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 8b93856de432..416fe7986b7b 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -253,6 +253,18 @@ config MFD_MADERA_SPI
>>   	  Support for the Cirrus Logic Madera platform audio SoC
>>   	  core functionality controlled via SPI.
>>   
>> +config MFD_MAX597X
>> +	tristate "Maxim 597x Power Switch and Monitor"
>> +	depends on I2C
>> +	depends on OF
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	help
>> +	  This driver controls a Maxim 5970/5978 switch via I2C bus.
>> +	  The MAX5970/5978 is a smart switch with no output regulation, but
>> +	  fault protection and voltage and current monitoring capabilities.
>> +	  Also it supports upto 4 indication LEDs.
>> +
>>   config MFD_CS47L15
>>   	bool "Cirrus Logic CS47L15"
>>   	select PINCTRL_CS47L15
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 7ed3ef4a698c..819d711fa748 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -161,6 +161,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
>>   obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>>   
>>   obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
>> +obj-$(CONFIG_MFD_MAX597X)	+= max597x.o
>>   obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>>   obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>>   obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>> diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
>> new file mode 100644
>> index 000000000000..2c64edb6b6dd
>> --- /dev/null
>> +++ b/drivers/mfd/max597x.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Maxim MAX5970/MAX5978 MFD Driver
> 
> Please drop "MFD Driver" and replace it with what it does.
> 
> "Power Switch and Monitor"?
> 
Yes. that makes more sense. sure.
>> + * Copyright (c) 2022 9elements GmbH
>> + *
>> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/max597x.h>
>> +#include <linux/regmap.h>
>> +
>> +static const struct regmap_config max597x_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = MAX_REGISTERS,
>> +};
>> +
>> +static const struct mfd_cell max597x_cells[] = {
>> +	{ .name = "max597x-regulator", },
>> +	{ .name = "max597x-iio", },
>> +	{ .name = "max597x-led", },
>> +};
>> +
>> +static int max597x_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>> +{
>> +	struct max597x_data *ddata;
>> +	enum max597x_chip_type chip = id->driver_data;
>> +
>> +	ddata = devm_kzalloc(&i2c->dev, sizeof(*ddata),	GFP_KERNEL);
>> +	if (!ddata)
>> +		return -ENOMEM;
>> +
>> +	/* Initialize num of switch based on chip type for later use by regulator
>> +	 * & iio cells
>> +	 */
> 
> Please use proper multi-line comment structure.
> 
> Also use proper words, unlike 'num'.
> 
> In fact, it looks like this whole comment could do with some love.
> 
Done.
>> +	switch (chip) {
>> +	case MAX597x_TYPE_MAX5970:
>> +		ddata->num_switches = MAX5970_NUM_SWITCHES;
>> +		break;
>> +	case MAX597x_TYPE_MAX5978:
>> +		ddata->num_switches = MAX5978_NUM_SWITCHES;
>> +		break;
>> +	}
>> +
>> +	ddata->regmap = devm_regmap_init_i2c(i2c, &max597x_regmap_config);
>> +	if (IS_ERR(ddata->regmap)) {
>> +		dev_err(&i2c->dev, "Failed to initialise regmap");
> 
> Are you using American spelling or English?
> 
> Please make up your mind and be consistent.
> 
Sure
>> +		return -EINVAL;
> 
> Shouldn't you be propagating the error you received?
> 
Yes. Will update in next version.
>> +	}
>> +
>> +	/* IRQ used by regulator cell */
> 
> What IRQ is this?  Does it have a name?
>Its is VR fault status update related irq.
> If it's only used in Regulator, why not fetch it there?
> >> +	ddata->irq = i2c->irq;
>> +	ddata->dev = &i2c->dev;
> 
> You should already have access to the Driver, else how are you going
> to fetch the data back in the first place?
> 
>> +	i2c_set_clientdata(i2c, ddata);
>> +
>> +	return devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO,
>> +				    max597x_cells, ARRAY_SIZE(max597x_cells),
>> +				    NULL, 0, NULL);
>> +}
>> +
>> +static const struct i2c_device_id max597x_table[] = {
>> +	{ .name = "max5970", MAX597x_TYPE_MAX5970 },
>> +	{ .name = "max5978", MAX597x_TYPE_MAX5978 },
> 
> You don't need ".name = ".
> 
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, max597x_table);
>> +
>> +static const struct of_device_id max597x_of_match[] = {
>> +	{ .compatible = "maxim,max5970", .data = (void *)MAX597x_TYPE_MAX5970 },
>> +	{ .compatible = "maxim,max5978", .data = (void *)MAX597x_TYPE_MAX5978 },
> 
> Where is .data used?
The .data isn't used.
> 
>> +	{ /* sentinel */ }
> > Drop the comment.  We know what a NULL entry means.
Sure.
> 
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, max597x_of_match);
>> +
>> +static struct i2c_driver max597x_driver = {
>> +	.id_table = max597x_table,
>> +	.driver = {
>> +		.name = "max597x",
>> +		.of_match_table = of_match_ptr(max597x_of_match),
>> +		},
> 
> Tabbing error.
Fixed Will be in next version.
> 
>> +	.probe = max597x_probe,
>> +};
>> +
> 
> Remove this line.
Sure.
> 
>> +module_i2c_driver(max597x_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX597X Power Switch and Monitor");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
>> new file mode 100644
>> index 000000000000..f88a57f0e4f2
>> --- /dev/null
>> +++ b/include/linux/mfd/max597x.h
>> @@ -0,0 +1,103 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Maxim MAX5970/MAX5978 MFD Driver
> 
> Same here.
> 
>> + * Copyright (c) 2022 9elements GmbH
>> + *
>> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>> + */
>> +
>> +#ifndef MFD_MAX597X_H
>> +#define MFD_MAX597X_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/regmap.h>
>> +
>> +/* Number of switch based on chip variant */
> 
> This comment is superfluous.
You mean this comment should be removed ?
> 
>> +#define MAX5970_NUM_SWITCHES 2
>> +#define MAX5978_NUM_SWITCHES 1
>> +/* Both chip variant have 4 indication LEDs used by LED cell */
> 
> Here too I think.
> 
>> +#define MAX597X_NUM_LEDS     4
>> +
>> +enum max597x_chip_type {
>> +	MAX597x_TYPE_MAX5978 = 1,
> 
> Why 1?
MAX5978 & single power switch wheres MAX5970 has two.
> 
>> +	MAX597x_TYPE_MAX5970,
>> +};
>> +
>> +#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
>> +#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
>> +#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
>> +#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
>> +#define MAX5970_REG_MON_RANGE			0x18
>> +#define  MAX5970_MON_MASK				0x3
>> +#define  MAX5970_MON(reg, ch)		(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
>> +#define  MAX5970_MON_MAX_RANGE_UV		16000000
>> +
>> +#define MAX5970_REG_CH_UV_WARN_H(ch)	(0x1A + (ch) * 10)
>> +#define MAX5970_REG_CH_UV_WARN_L(ch)	(0x1B + (ch) * 10)
>> +#define MAX5970_REG_CH_UV_CRIT_H(ch)	(0x1C + (ch) * 10)
>> +#define MAX5970_REG_CH_UV_CRIT_L(ch)	(0x1D + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_WARN_H(ch)	(0x1E + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_WARN_L(ch)	(0x1F + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_CRIT_H(ch)	(0x20 + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_CRIT_L(ch)	(0x21 + (ch) * 10)
>> +
>> +#define  MAX5970_VAL2REG_H(x)			(((x) >> 2) & 0xFF)
>> +#define  MAX5970_VAL2REG_L(x)			((x) & 0x3)
>> +
>> +#define MAX5970_REG_DAC_FAST(ch)		(0x2E + (ch))
>> +
>> +#define MAX5970_FAST2SLOW_RATIO			200
>> +
>> +#define MAX5970_REG_STATUS0				0x31
>> +#define  MAX5970_CB_IFAULTF(ch)			(1 << (ch))
>> +#define  MAX5970_CB_IFAULTS(ch)			(1 << ((ch) + 4))
>> +
>> +#define MAX5970_REG_STATUS1				0x32
>> +#define  STATUS1_PROT_MASK				0x3
>> +#define  STATUS1_PROT(reg) \
>> +	(((reg) >> 6) & STATUS1_PROT_MASK)
>> +#define  STATUS1_PROT_SHUTDOWN			0
>> +#define  STATUS1_PROT_CLEAR_PG			1
>> +#define  STATUS1_PROT_ALERT_ONLY		2
>> +
>> +#define MAX5970_REG_STATUS2				0x33
>> +#define  MAX5970_IRNG_MASK				0x3
>> +#define  MAX5970_IRNG(reg, ch)	\
>> +						(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
>> +
>> +#define MAX5970_REG_STATUS3				0x34
>> +#define  MAX5970_STATUS3_ALERT			BIT(4)
>> +#define  MAX5970_STATUS3_PG(ch)			BIT(ch)
>> +
>> +#define MAX5970_REG_FAULT0				0x35
>> +#define  UV_STATUS_WARN(ch)				BIT(ch)
>> +#define  UV_STATUS_CRIT(ch)				BIT(ch + 4)
>> +
>> +#define MAX5970_REG_FAULT1				0x36
>> +#define  OV_STATUS_WARN(ch)				BIT(ch)
>> +#define  OV_STATUS_CRIT(ch)				BIT(ch + 4)
>> +
>> +#define MAX5970_REG_FAULT2				0x37
>> +#define  OC_STATUS_WARN(ch)				BIT(ch)
>> +
>> +#define MAX5970_REG_CHXEN				0x3b
>> +#define  CHXEN(ch)						(3 << (ch * 2))
>> +
>> +#define MAX5970_REG_LED_FLASH			0x43
> 
> Do these all need to be shared?
> 
> Or can they be isolated into, say, the Regulator driver?
> 
Shared reg.
>> +#define MAX_REGISTERS					0x49
>> +#define ADC_MASK						0x3FF
>> +
>> +struct max597x_data {
>> +	struct device *dev;
>> +	int irq;
>> +	int num_switches;
>> +	struct regmap *regmap;
>> +	/* Chip specific parameters needed by regulator & iio cells */
>> +	u32 irng[MAX5970_NUM_SWITCHES];
>> +	u32 mon_rng[MAX5970_NUM_SWITCHES];
>> +	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
>> +};
>> +
>> +#endif				/* _MAX597X_H */
> 
>                                         This is incorrect and doesn't
> 				       need to be tabbed out over
> 				       here.
> 
Will update in next version.
