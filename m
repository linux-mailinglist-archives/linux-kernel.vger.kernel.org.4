Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D76614F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiKAQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiKAQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:39:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF831005E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:38:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o7so10532621pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bD1xpOYKzbVGjf5BccRA3M+/LDSHVpBRn/pOl5YsPU=;
        b=JWj1OmDZBmkyYnPS57CY1ADUOtJC+kKQt79+9Ni/YQU2qJqp8v52ORhDDA5s2ea9eR
         qbFvi+ZoEh2uQEsNIzi+SEFZUPPAZMLFO12J5BAp2wIt1cUBd9sogQ+1sQX62HP8i04j
         zT3MM4keCJWtDXRUZ1X8+mlgGg15vlzBwUSRG884Dga4lP0CRjmyikXuoj3IB1F+/X7z
         8jG1vluNPbj2UZUb4nwYWSKDbbL1qTihlCTg1PCq72ie2vmYFBA8WdY/SKA3V7nhsFf+
         fa7Pk5Boog1FOsNDkpTljKiITSjfawi/ItRsyFZx3eneigL3zA2NEtWy7UbbJY4lskXl
         TkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bD1xpOYKzbVGjf5BccRA3M+/LDSHVpBRn/pOl5YsPU=;
        b=NAHFs5d+V9nB3/lqG6GAZL2LxqEjMFfkZaFUpXgIp4URVZmFueUePEZTLvAmv8kQPy
         HoVGgK+YZl+r4bC5pBgmNx77i3GtDFaGhVESWvE9ZP6r0CKxvN5hObio45qbs+6ZmwG3
         JQgmLY4MDNMIGZiIZI2lkmyByDgbG/yL2I1LlXDzrtpLYKu4k262EBccXhejv43LS+o5
         B8m7YhYyBlxUDWFTw2Qc5vf7LxEO1qLVtJ88VBnVGbqcX2HM4nGVIgsMhmK/n5sbDWaC
         8ZbP5Y9ZBMIoov7oIiLW+ZHIShcp5GIKcuMduiZ6W5RDJbS+zsqwfJUTnoaVFA3JMGr1
         W0cA==
X-Gm-Message-State: ACrzQf1NETwzJKxdwGqFn/sQXEe/zRDHXij/0dDKjh/Ff9by2i3HZQ4W
        H7VovwXQxazvArOozpkxX7wqDw==
X-Google-Smtp-Source: AMsMyM5hP/CVeu6IZxBbVyCmy2gaOaqOgseWo5qO+C0EcK9xBe5PmOeC5Y5n01LGvIFaxp/tTc3Ohg==
X-Received: by 2002:a17:90a:71ca:b0:213:c03a:1b07 with SMTP id m10-20020a17090a71ca00b00213c03a1b07mr17007244pjs.67.1667320693081;
        Tue, 01 Nov 2022 09:38:13 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id s5-20020a170903200500b00186616b8fbasm6602548pla.10.2022.11.01.09.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 09:38:12 -0700 (PDT)
Message-ID: <89b0bb79-fc04-9cfc-5fe1-535889e914d0@9elements.com>
Date:   Tue, 1 Nov 2022 22:08:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221031204129.1434059-1-Naresh.Solanki@9elements.com>
 <20221031204129.1434059-3-Naresh.Solanki@9elements.com>
 <a9b7d97e-88f8-711d-541c-e0c0802d0178@wanadoo.fr>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <a9b7d97e-88f8-711d-541c-e0c0802d0178@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 01-11-2022 02:49 am, Christophe JAILLET wrote:
> Le 31/10/2022 à 21:41, Naresh Solanki a écrit :
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
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> Hi,
> a few nits below.
> 
>> ---
>>   drivers/mfd/Kconfig         |  12 +++++
>>   drivers/mfd/Makefile        |   1 +
>>   drivers/mfd/max597x.c       |  87 ++++++++++++++++++++++++++++++
>>   include/linux/mfd/max597x.h | 102 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 202 insertions(+)
>>   create mode 100644 drivers/mfd/max597x.c
>>   create mode 100644 include/linux/mfd/max597x.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 8b93856de432..416fe7986b7b 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -253,6 +253,18 @@ config MFD_MADERA_SPI
>>         Support for the Cirrus Logic Madera platform audio SoC
>>         core functionality controlled via SPI.
>> +config MFD_MAX597X
>> +    tristate "Maxim 597x Power Switch and Monitor"
>> +    depends on I2C
>> +    depends on OF
>> +    select MFD_CORE
>> +    select REGMAP_I2C
>> +    help
>> +      This driver controls a Maxim 5970/5978 switch via I2C bus.
>> +      The MAX5970/5978 is a smart switch with no output regulation, but
>> +      fault protection and voltage and current monitoring capabilities.
>> +      Also it supports upto 4 indication LEDs.
>> +
>>   config MFD_CS47L15
>>       bool "Cirrus Logic CS47L15"
>>       select PINCTRL_CS47L15
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 7ed3ef4a698c..819d711fa748 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -161,6 +161,7 @@ obj-$(CONFIG_MFD_DA9063)    += da9063.o
>>   obj-$(CONFIG_MFD_DA9150)    += da9150-core.o
>>   obj-$(CONFIG_MFD_MAX14577)    += max14577.o
>> +obj-$(CONFIG_MFD_MAX597X)    += max597x.o
>>   obj-$(CONFIG_MFD_MAX77620)    += max77620.o
>>   obj-$(CONFIG_MFD_MAX77650)    += max77650.o
>>   obj-$(CONFIG_MFD_MAX77686)    += max77686.o
>> diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
>> new file mode 100644
>> index 000000000000..68a4e7755f21
>> --- /dev/null
>> +++ b/drivers/mfd/max597x.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Maxim MAX5970/MAX5978 MFD Driver
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
>> +    .reg_bits = 8,
>> +    .val_bits = 8,
>> +    .max_register = MAX_REGISTERS,
>> +};
>> +
>> +static const struct mfd_cell max597x_cells[] = {
>> +    { .name = "max597x-regulator", },
>> +    { .name = "max597x-iio", },
>> +    { .name = "max597x-led", },
>> +};
>> +
>> +static int max597x_probe(struct i2c_client *i2c, const struct 
>> i2c_device_id *id)
>> +{
>> +    struct max597x_data *ddata;
>> +    enum max597x_chip_type chip = id->driver_data;
>> +
>> +    ddata = devm_kzalloc(&i2c->dev, sizeof(*ddata),
>> +            GFP_KERNEL);
> 
> if (!ddata)
>      return -ENOMEM;
> 
Done
> GFP_KERNEL should be aligned with the ( on the previous line.
Done
> 
>> +
>> +    switch (chip) {
>> +    case MAX597x_TYPE_MAX5970:
>> +        ddata->num_switches = 2;
>> +        break;
>> +    case MAX597x_TYPE_MAX5978:
>> +        ddata->num_switches = 1;
>> +        break;
>> +    }
> 
> ddata->num_switches looks unused.
> Is it needed? Maybe for future use?
> 
Yes. Used by regulator & IIO driver.
> Should MAX5970_NUM_SWITCHES and MAX5979_NUM_SWITCHES be used instead of 
> hard coding 1 and 2?
Done
> 
>> +
>> +    ddata->regmap = devm_regmap_init_i2c(i2c, &max597x_regmap_config);
>> +    if (IS_ERR(ddata->regmap)) {
>> +        dev_err(&i2c->dev, "Failed to initialise regmap");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* IRQ used by regulator cell */
>> +    ddata->irq = i2c->irq;
>> +    ddata->dev = &i2c->dev;
>> +    i2c_set_clientdata(i2c, ddata);
>> +
>> +    return devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO,
>> +                    max597x_cells, ARRAY_SIZE(max597x_cells),
>> +                    NULL, 0, NULL);
>> +}
>> +
>> +static const struct i2c_device_id max597x_table[] = {
>> +    { .name = "max5970", MAX597x_TYPE_MAX5970 },
>> +    { .name = "max5978", MAX597x_TYPE_MAX5978 },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, max597x_table);
>> +
>> +static const struct of_device_id max597x_of_match[] = {
>> +    { .compatible = "maxim,max5970", .data = (void 
>> *)MAX597x_TYPE_MAX5970 },
>> +    { .compatible = "maxim,max5978", .data = (void 
>> *)MAX597x_TYPE_MAX5978 },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, max597x_of_match);
>> +
>> +static struct i2c_driver max597x_driver = {
>> +    .id_table = max597x_table,
>> +    .driver = {
>> +        .name = "max597x",
>> +        .of_match_table = of_match_ptr(max597x_of_match),
>> +        },
>> +    .probe = max597x_probe,
>> +};
>> +
>> +module_i2c_driver(max597x_driver);
>> +
>> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
>> +MODULE_DESCRIPTION("MAX597X Power Switch and Monitor");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
>> new file mode 100644
>> index 000000000000..ae7f38f0aee2
>> --- /dev/null
>> +++ b/include/linux/mfd/max597x.h
>> @@ -0,0 +1,102 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Maxim MAX5970/MAX5978 MFD Driver
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
>> +#define MAX597X_NUM_LEDS     4
> 
> Unused?
> Maybe the "4" below (or elsewhere) should be MAX597X_NUM_LEDS?
Yes. The chip has 4 indiaction leds. Used by led cell.
> 
>> +
>> +enum max597x_chip_type {
>> +    MAX597x_TYPE_MAX5978 = 1,
>> +    MAX597x_TYPE_MAX5970,
>> +};
>> +
>> +#define MAX5970_REG_CURRENT_L(ch)        (0x01 + (ch) * 4)
>> +#define MAX5970_REG_CURRENT_H(ch)        (0x00 + (ch) * 4)
>> +#define MAX5970_REG_VOLTAGE_L(ch)        (0x03 + (ch) * 4)
>> +#define MAX5970_REG_VOLTAGE_H(ch)        (0x02 + (ch) * 4)
>> +#define MAX5970_REG_MON_RANGE            0x18
>> +#define  MAX5970_MON_MASK                0x3
>> +#define  MAX5970_MON(reg, ch) \
>> +                        (((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
> 
> Why a line break here?
Fixed.
> 
>> +#define  MAX5970_MON_MAX_RANGE_UV        16000000
>> +
>> +#define MAX5970_REG_CH_UV_WARN_H(ch)    (0x1A + (ch) * 10)
>> +#define MAX5970_REG_CH_UV_WARN_L(ch)    (0x1B + (ch) * 10)
>> +#define MAX5970_REG_CH_UV_CRIT_H(ch)    (0x1C + (ch) * 10)
>> +#define MAX5970_REG_CH_UV_CRIT_L(ch)    (0x1D + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_WARN_H(ch)    (0x1E + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_WARN_L(ch)    (0x1F + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_CRIT_H(ch)    (0x20 + (ch) * 10)
>> +#define MAX5970_REG_CH_OV_CRIT_L(ch)    (0x21 + (ch) * 10)
>> +
>> +#define  MAX5970_VAL2REG_H(x)            (((x) >> 2) & 0xFF)
>> +#define  MAX5970_VAL2REG_L(x)            ((x) & 0x3)
>> +
>> +#define MAX5970_REG_DAC_FAST(ch)        (0x2E + (ch))
>> +
>> +#define MAX5970_FAST2SLOW_RATIO            200
>> +
>> +#define MAX5970_REG_STATUS0                0x31
>> +#define  MAX5970_CB_IFAULTF(ch)            (1 << (ch))
>> +#define  MAX5970_CB_IFAULTS(ch)            (1 << ((ch) + 4))
>> +
>> +#define MAX5970_REG_STATUS1                0x32
>> +#define  STATUS1_PROT_MASK                0x3
>> +#define  STATUS1_PROT(reg) \
>> +    (((reg) >> 6) & STATUS1_PROT_MASK)
>> +#define  STATUS1_PROT_SHUTDOWN            0
>> +#define  STATUS1_PROT_CLEAR_PG            1
>> +#define  STATUS1_PROT_ALERT_ONLY        2
>> +
>> +#define MAX5970_REG_STATUS2                0x33
>> +#define  MAX5970_IRNG_MASK                0x3
>> +#define  MAX5970_IRNG(reg, ch)    \
>> +                        (((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
>> +
>> +#define MAX5970_REG_STATUS3                0x34
>> +#define  MAX5970_STATUS3_ALERT            BIT(4)
>> +#define  MAX5970_STATUS3_PG(ch)            BIT(ch)
>> +
>> +#define MAX5970_REG_FAULT0                0x35
>> +#define  UV_STATUS_WARN(ch)                BIT(ch)
>> +#define  UV_STATUS_CRIT(ch)                BIT(ch + 4)
>> +
>> +#define MAX5970_REG_FAULT1                0x36
>> +#define  OV_STATUS_WARN(ch)                BIT(ch)
>> +#define  OV_STATUS_CRIT(ch)                BIT(ch + 4)
>> +
>> +#define MAX5970_REG_FAULT2                0x37
>> +#define  OC_STATUS_WARN(ch)                BIT(ch)
>> +
>> +#define MAX5970_REG_CHXEN                0x3b
>> +#define  CHXEN(ch)                        (3 << (ch * 2))
>> +
>> +#define MAX5970_REG_LED_FLASH            0x43
>> +
>> +#define MAX_REGISTERS                    0x49
>> +#define ADC_MASK                        0x3FF
>> +
>> +struct max597x_data {
>> +    struct device *dev;
>> +    int irq;
>> +    int num_switches;
>> +    struct regmap *regmap;
>> +    /* Chip specific parameters needed by regulator & iio cells */
>> +    u32 irng[MAX5970_NUM_SWITCHES];
>> +    u32 mon_rng[MAX5970_NUM_SWITCHES];
>> +    u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
> 
> mon_rng and shunt_micro_ohms look unused.
> Are they needed? Maybe for future use?
Used by regulator & iio driver.
> 
>> +};
>> +
>> +#endif                /* _MAX597X_H */
> 
> MFD_MAX597X_H
> 
> CJ

Thanks,
Naresh
