Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98162F010
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiKRIvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbiKRIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:51:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F4F2B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:51:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o7so3946852pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCS9BWikguUDStEb7GBt+k8M9oiO12h49uU4c+M4WyA=;
        b=TGTiJtrjFiHcIoe4fpf2AcKyHM/8Q0UdlvbE9gn0ZGrptt4mu62DsoePn863Hp8qwy
         fguV86BZCNp71ZR0CjQGAI62ZxuDSQNx+XXmBxyytwbyFvzBFD8oxrZeucBXLPvkLXJB
         /SLTjPyahngpwSvXGXqjmbvhB6LQSe+JuKuyG6rN7CkmCaGjyYTVYAMkcpHGuRNPOay8
         uLWC6ho4Z586tSp+JQY3mwGvTD2wZ3jBqpoTRcw2wbWPWqqNtDdZlCXqFMCgevsdaSBM
         PVwjmJp6IlHtdl0Aks3c6QFu4ZP4+4Hk7F4H+CmgHmftD/b4yvRqzuHQyEhO5EYbvVdy
         IDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCS9BWikguUDStEb7GBt+k8M9oiO12h49uU4c+M4WyA=;
        b=v6na3Z3Ztzak0O3M6vryr34cJFmE7VBS8WCt9W2tptNr6iBpNW0XnensMDVHBBAbpZ
         wZ1J3CtlBkjJLYkz0Nly8PhbGUu7KtYe2vKvLmZeZnVMI5wUsaeE0uqImfC3crJh3/2z
         z4dSU4MC+EW07cR0O/Z7MGI1d6sNHN03jU1C868EvminV0E0cbvWTmBMGCGvmbt1guqv
         qxegDF7nvTY8+c6qe1mAAB0nefJb8xAelfrGpXHGzLYjRoF/+eSuB/8TFFJSV0g+kfAn
         TGNQ9KbKFJwCxa4BJ6hrm3d60RkyoZYJCL3xC51cPmfQX4QMRast/qIQ8qLwLswad5WG
         ezRA==
X-Gm-Message-State: ANoB5plvXkrc7ft7PjT8D1HV417O/DflESFeiEYthX8aev1p8PWufnP7
        zSLLhq/35heu2MWx+Lo0zeiKRQ==
X-Google-Smtp-Source: AA0mqf7gMVGgoQWNFp67iarh/TvfSFGiYOGe2Nh+73WGu3fv+dD29HN9xsZm1FQZHQoblNIaLYnalQ==
X-Received: by 2002:a17:903:cd:b0:186:a2ef:7a69 with SMTP id x13-20020a17090300cd00b00186a2ef7a69mr6576867plc.77.1668761463216;
        Fri, 18 Nov 2022 00:51:03 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id oe4-20020a17090b394400b00213c7cf21c0sm2305965pjb.5.2022.11.18.00.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:51:02 -0800 (PST)
Message-ID: <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
Date:   Fri, 18 Nov 2022 14:20:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
 <Y3YJ2EkYNW+gA+/R@google.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <Y3YJ2EkYNW+gA+/R@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17-11-2022 03:45 pm, Lee Jones wrote:
> On Wed, 16 Nov 2022, Naresh Solanki wrote:
> 
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Implement a regulator driver with IRQ support for fault management.
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
>> Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/mfd/Kconfig         |  12 +++++
>>   drivers/mfd/Makefile        |   1 +
>>   drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
>>   include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 207 insertions(+)
>>   create mode 100644 drivers/mfd/max597x.c
>>   create mode 100644 include/linux/mfd/max597x.h
> 
> Ignoring my comments won't make them go away. :)
> 
> Please tell me why you need a whole new driver, instead of adding
> support to simple-mfd-i2c?
> 
I felt current implementation to be simpler, clearer & straight forward.

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
>> index 000000000000..45838413f24a
>> --- /dev/null
>> +++ b/drivers/mfd/max597x.c
>> @@ -0,0 +1,93 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Maxim MAX5970/MAX5978 Power Switch & Monitor
>> + *
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
>> +	/*
>> +	 * Based on chip type, Initialize the number of switch. This is needed by
>> +	 * regulator & iio cells.
>> +	 */
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
>> +		dev_err(&i2c->dev, "Failed to initialize regmap");
>> +		return PTR_ERR(ddata->regmap);
>> +	}
>> +
>> +	/* IRQ used by regulator cell */
>> +	ddata->irq = i2c->irq;
>> +	ddata->dev = &i2c->dev;
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
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, max597x_table);
>> +
>> +static const struct of_device_id max597x_of_match[] = {
>> +	{ .compatible = "maxim,max5970" },
>> +	{ .compatible = "maxim,max5978" },
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, max597x_of_match);
>> +
>> +static struct i2c_driver max597x_driver = {
>> +	.id_table = max597x_table,
>> +	.driver = {
>> +		  .name = "max597x",
>> +		  .of_match_table = of_match_ptr(max597x_of_match),
>> +		  },
>> +	.probe = max597x_probe,
>> +};
>> +module_i2c_driver(max597x_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX597X Power Switch and Monitor");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
>> new file mode 100644
>> index 000000000000..706eff9c50a4
>> --- /dev/null
>> +++ b/include/linux/mfd/max597x.h
>> @@ -0,0 +1,101 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Maxim MAX5970/MAX5978 Power Switch & Monitor
>> + *
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
>> +#define MAX5970_NUM_SWITCHES 2
>> +#define MAX5978_NUM_SWITCHES 1
>> +#define MAX597X_NUM_LEDS     4
>> +
>> +enum max597x_chip_type {
>> +	MAX597x_TYPE_MAX5978 = 1,
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
>> +
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
>> +#endif
> 
