Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1926A99C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCCOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjCCOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:49:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB1474FF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:49:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k37so1795227wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Exy3Yn87eaf0ZXgYUzDkdrAAuGVg7rQYYWC6WdwO9g=;
        b=kbZhL6OAvgwbkNo9fdSYcHXsh9vCMo3TLQzboWgPKF0SDG6svJglPowMGxgKdjXMFW
         jMVjSps0ou14cXJZjLFj9SywH8cltV3ohEHzAQZ/ApbIXR7kZw+pCmlE1y0jvLAj4r66
         zJmU7MzDDonT5mMERJHzVD6U6sWeGmDFIg3uKGneC/LWFpZ55O5jnVztDPzAyrLmVr/N
         /+Yrz3kl0p+NgYkol0eB7FDxiDSGGR2hugkjDRkgB2bTFkCSILP9wtPs1udLjYalDhA4
         DxWqr9Mgt8oRNxDMuUkDG3sIpDTv1DD8JPDBu03kPrXobtbvWhdXDN7amefCIaFWAcVo
         2S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Exy3Yn87eaf0ZXgYUzDkdrAAuGVg7rQYYWC6WdwO9g=;
        b=A7D9bUMMmZN69AAiYb5sqE4pUzIUbFGdG6yTdLWUY0ZCiRmm0vSSIyYE8VcedDOY9T
         yfySCYsYFwXXAfOeuUmZeXYqWE29OKARuHMri3AWrDWowtXC4ZlR2blLdDgtNuJFT9gK
         3O4MWmIcufhREI4HymDVtIlwKYlHhVJN4a/DeUaekreoK9qK2e1PZx4xs/KHJ+nP6QcB
         omoBPRDC6lDHPywjeW3wNEWJB8Wf+Ds4vo1D770d08B47/T9KLoIiCCb8UYBhrU7meB4
         B/YncoDUfwtmzD23PyHXSDe7x1Wku1zeEUFLXjxUThDj2f3X5cC4dt0Ye4aeOFCpJXUc
         xvbA==
X-Gm-Message-State: AO0yUKVTuKC0CLldIqSxoNp/1Jej1J29Po7SjTHDDD87lvVbBOtpN+bu
        P4sjbSxPxvRoxVdjWbg4echYxw==
X-Google-Smtp-Source: AK7set+lDVlPjWxNw7wuUK44z3QFiTkfHBkIyGzChGvsvbbsS/tQPd3hiFc811hgMcqj6qPpvf1mPA==
X-Received: by 2002:a05:600c:1f0a:b0:3ea:9530:22a6 with SMTP id bd10-20020a05600c1f0a00b003ea953022a6mr4242981wmb.1.1677854942041;
        Fri, 03 Mar 2023 06:49:02 -0800 (PST)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b002c70851bfcasm2413130wru.28.2023.03.03.06.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 06:49:01 -0800 (PST)
Message-ID: <97541a89-7677-8dd4-b852-27f00a253a59@baylibre.com>
Date:   Fri, 3 Mar 2023 15:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
 <ceb76b77-1361-5605-db18-3b6918c029aa@gmail.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <ceb76b77-1361-5605-db18-3b6918c029aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 15:05, Matti Vaittinen wrote:
> Hi Esteban,
> 
> On 2/24/23 15:31, Esteban Blanc wrote:
>> From: Jerome Neanne <jneanne@baylibre.com>
>>
>> This patch adds support for TPS6594 regulators (bucks and LDOs).
>> The output voltages are configurable and are meant to supply power
>> to the main processor and other components.
>> Bucks can be used in single or multiphase mode, depending on PMIC
>> part number.
>>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>> ---
>>   drivers/regulator/Kconfig             |  12 +
>>   drivers/regulator/Makefile            |   1 +
>>   drivers/regulator/tps6594-regulator.c | 559 ++++++++++++++++++++++++++
>>   3 files changed, 572 insertions(+)
>>   create mode 100644 drivers/regulator/tps6594-regulator.c
>>
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index 820c9a0788e5..921540af6958 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -1432,6 +1432,18 @@ config REGULATOR_TPS65219
>>         voltage regulators. It supports software based voltage control
>>         for different voltage domains.
>> +config REGULATOR_TPS6594
>> +    tristate "TI TPS6594 Power regulators"
>> +    depends on MFD_TPS6594 && OF
>> +    help
>> +      This driver supports TPS6594 voltage regulator chips.
>> +      TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
>> +      voltage regulators.
>> +      BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
>> +      Part number defines which single or multiphase mode is i used.
>> +      It supports software based voltage control
>> +      for different voltage domains.
>> +
>>   config REGULATOR_TPS6524X
>>       tristate "TI TPS6524X Power regulators"
>>       depends on SPI
>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>> index b9f5eb35bf5f..948b53f6156b 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -171,6 +171,7 @@ obj-$(CONFIG_REGULATOR_TPS6524X) += 
>> tps6524x-regulator.o
>>   obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
>>   obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
>>   obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
>> +obj-$(CONFIG_REGULATOR_TPS6594) += tps6594-regulator.o
>>   obj-$(CONFIG_REGULATOR_TPS65132) += tps65132-regulator.o
>>   obj-$(CONFIG_REGULATOR_TPS68470) += tps68470-regulator.o
>>   obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
>> diff --git a/drivers/regulator/tps6594-regulator.c 
>> b/drivers/regulator/tps6594-regulator.c
>> new file mode 100644
>> index 000000000000..c099711fd460
>> --- /dev/null
>> +++ b/drivers/regulator/tps6594-regulator.c
>> @@ -0,0 +1,559 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Regulator driver for tps6594 PMIC
>> + *
>> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
>> + *
>> + * This implementation derived from tps65218 authored by "J Keerthy 
>> <j-keerthy@ti.com>"
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/regulator/of_regulator.h>
>> +
>> +#include <linux/mfd/tps6594.h>
>> +
>> +#define BUCK_NB        5
>> +#define LDO_NB        4
>> +#define MULTI_PHASE_NB    4
>> +
>> +enum tps6594_regulator_id {
>> +    /* DCDC's */
>> +    TPS6594_BUCK_1,
>> +    TPS6594_BUCK_2,
>> +    TPS6594_BUCK_3,
>> +    TPS6594_BUCK_4,
>> +    TPS6594_BUCK_5,
>> +
>> +    /* LDOs */
>> +    TPS6594_LDO_1,
>> +    TPS6594_LDO_2,
>> +    TPS6594_LDO_3,
>> +    TPS6594_LDO_4,
>> +};
>> +
>> +enum tps6594_multi_regulator_id {
>> +    /* Multi-phase DCDC's */
>> +    TPS6594_BUCK_12,
>> +    TPS6594_BUCK_34,
>> +    TPS6594_BUCK_123,
>> +    TPS6594_BUCK_1234,
>> +};
>> +
>> +struct tps6594_regulator_irq_type {
>> +    const char *irq_name;
>> +    const char *regulator_name;
>> +    const char *event_name;
>> +    unsigned long event;
>> +};
>> +
>> +static struct tps6594_regulator_irq_type 
>> tps6594_regulator_irq_types[] = {
>> +    { TPS6594_IRQ_NAME_BUCK1_OV, "BUCK1", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_BUCK1_UV, "BUCK1", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
> 
> You have warning level IRQs - which is cool :)
> 
> As warning level IRQs are used for non fatal errors, you probably would 
> like to also implement a mechanism for consumers to know when the 
> "warning is over" (assuming the HW provides the status information). 
> Maybe regulator_get_error_flags() would serve you?
> 
> I'd be _really_ interested in hearing if you already have a use-case for 
> the warnings.
I double checked with TI PMIC team and so far we don't have any routine.
The requirement for upstream driver is to raise the warning to the 
processor nothing else. Up to the final customer to customize further.
Note that it can be dangerous to handle in sw it in a generic way since 
those warnings might affect some regulators that is supplying some 
resources needed by the processor for correct behavior...
> 
>> +    { TPS6594_IRQ_NAME_BUCK1_SC, "BUCK1", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_BUCK1_ILIM, "BUCK1", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_BUCK2_OV, "BUCK2", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_BUCK2_UV, "BUCK2", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_BUCK2_SC, "BUCK2", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_BUCK2_ILIM, "BUCK2", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_BUCK3_OV, "BUCK3", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_BUCK3_UV, "BUCK3", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_BUCK3_SC, "BUCK3", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_BUCK3_ILIM, "BUCK3", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_BUCK4_OV, "BUCK4", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_BUCK4_UV, "BUCK4", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_BUCK4_SC, "BUCK4", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_BUCK4_ILIM, "BUCK4", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_BUCK5_OV, "BUCK5", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_BUCK5_UV, "BUCK5", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_BUCK5_SC, "BUCK5", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_BUCK5_ILIM, "BUCK5", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_LDO1_OV, "LDO1", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_LDO1_UV, "LDO1", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_LDO1_SC, "LDO1", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_LDO1_ILIM, "LDO1", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_LDO2_OV, "LDO2", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_LDO2_UV, "LDO2", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_LDO2_SC, "LDO2", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_LDO2_ILIM, "LDO2", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_LDO3_OV, "LDO3", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_LDO3_UV, "LDO3", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_LDO3_SC, "LDO3", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_LDO3_ILIM, "LDO3", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +    { TPS6594_IRQ_NAME_LDO4_OV, "LDO4", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_LDO4_UV, "LDO4", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_LDO4_SC, "LDO4", "short circuit", 
>> REGULATOR_EVENT_REGULATION_OUT },
>> +    { TPS6594_IRQ_NAME_LDO4_ILIM, "LDO4", "reach ilim, overcurrent",
>> +      REGULATOR_EVENT_OVER_CURRENT },
>> +};
>> +
>> +static struct tps6594_regulator_irq_type 
>> tps6594_ext_regulator_irq_types[] = {
>> +    { TPS6594_IRQ_NAME_VCCA_OV, "VCCA", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_VCCA_UV, "VCCA", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_VMON1_OV, "VMON1", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_VMON1_UV, "VMON1", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_VMON1_RV, "VMON1", "residual voltage",
>> +      REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_VMON2_OV, "VMON2", "overvoltage", 
>> REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +    { TPS6594_IRQ_NAME_VMON2_UV, "VMON2", "undervoltage", 
>> REGULATOR_EVENT_UNDER_VOLTAGE },
>> +    { TPS6594_IRQ_NAME_VMON2_RV, "VMON2", "residual voltage",
>> +      REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>> +};
>> +
>> +struct tps6594_regulator_irq_data {
>> +    struct device *dev;
>> +    struct tps6594_regulator_irq_type *type;
>> +    struct regulator_dev *rdev;
>> +};
>> +
>> +struct tps6594_ext_regulator_irq_data {
>> +    struct device *dev;
>> +    struct tps6594_regulator_irq_type *type;
>> +};
>> +
>> +    for (i = 0; i < ARRAY_SIZE(tps6594_regulator_irq_types); ++i) {
>> +        irq_type = &tps6594_regulator_irq_types[i];
>> +
>> +        irq = platform_get_irq_byname(pdev, irq_type->irq_name);
>> +        if (irq < 0)
>> +            return -EINVAL;
>> +
>> +        irq_data[i].dev = tps->dev;
>> +        irq_data[i].type = irq_type;
>> +
>> +        tps6594_get_rdev_by_name(irq_type->regulator_name, rdevbucktbl,
>> +                     rdevldotbl, rdev);
>> +
>> +        if (rdev < 0) {
>> +            dev_err(tps->dev, "Failed to get rdev for %s\n",
>> +                irq_type->regulator_name);
>> +            return -EINVAL;
>> +        }
>> +        irq_data[i].rdev = rdev;
>> +
>> +        error = devm_request_threaded_irq(tps->dev, irq, NULL,
>> +                          tps6594_regulator_irq_handler,
>> +                          IRQF_ONESHOT,
>> +                          irq_type->irq_name,
>> +                          &irq_data[i]);
>> +        if (error) {
>> +            dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
>> +                irq_type->irq_name, irq, error);
>> +            return error;
>> +        }
>> +    }
> 
> If I read this correctly, you have exact, 1 to 1 mapping from an IRQ to 
> regulator and event? Maybe you could slightly simplify the driver by 
> using the devm_regulator_irq_helper() and 
> regulator_irq_map_event_simple() with it's map-event? And if the 
> devm_regulator_irq_helper() does not work for you I'll be interested in 
> hearing if it could be improved.
> 
I'll give it a try.

Thanks
