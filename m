Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB872C850
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjFLOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjFLOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FE268D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:22:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30fa23e106bso1977371f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686579771; x=1689171771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3N5ixTiUlzWmpYmBD+1hlS/BQuXBGl9fax7Ta2e1qsU=;
        b=IeaYOAY/ocIFff/KUtJuEnpY7ZO0aJ3N1CzM+p1jmf03pedayLTBm3ZCHzN4riEsVe
         JdDCI/nAotUDIGCrU+ru21+hAugCl+Xap1foMWMTpT5iBgh7tiseYQ/LgJDEp0mADcJi
         E9U1WPH/GKJcdbGLFbRemrbllEoEZvsjEB+gXXRw+IZ2Y9TIWDT8VURfj2vO6bPDsV2T
         Q2oNzuAWOZVFynR5bKi9jo6YO2nwIvT2+qQxesrGRwFxN8EXqBsxkQZxtGYAnSgM+EX6
         QEFHnFnHwH66dy6f/75PnojGj9FtN61F924fbUhkiNBZ+wEMzhTdI4tyFZvMbMZoaMgt
         5Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579771; x=1689171771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N5ixTiUlzWmpYmBD+1hlS/BQuXBGl9fax7Ta2e1qsU=;
        b=bgUioQOUkVoyRaZPkylxgsU7M1cSGaIwnXOowEXix4WcRftgm2gADcW+tdgu+0R/ny
         vN6l1X5ue/t0pH1/96nHzPmoDZ10y7DOmqSjMZoYhINY78vefE2tLGtKPVJDPNMoYhsK
         yOhCKc2fps/mAWwvm4FMlsPYemMTB0TjthCB8WVoIkgZk6aWCn8+M95D4Ap+E04LlXcE
         ddHsgLNFV4xPHJ8ZP6VCcAxrqlwptxOCZiqwYH5MLstvPrHQ6bM3KS0ba9fRntPjPxia
         HQ/yykdMpTNNTKAwF/pbyXWL0FbcrhSHk3pnArJU3Rj8YkNu5bY/kuJ9ZkKt6GL6sabl
         O2Eg==
X-Gm-Message-State: AC+VfDzDRCFKqiUdMbL679aojpphz+eF3sg+2GXlQI95kNVYvywa/pLi
        vm4Jn/LafpDhlNn9eLAldI4RAQ==
X-Google-Smtp-Source: ACHHUZ6g2+LR0jP9I3gwohIAJWscdF3YHz9hAhzSh7Dn6Lw8YMs0u4LwSLKz4FwoGqB13XVW7Zdq3Q==
X-Received: by 2002:a5d:4ece:0:b0:305:ed26:8576 with SMTP id s14-20020a5d4ece000000b00305ed268576mr4008132wrv.9.1686579770854;
        Mon, 12 Jun 2023 07:22:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id v17-20020adfedd1000000b0030630de6fbdsm12550688wro.13.2023.06.12.07.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 07:22:50 -0700 (PDT)
Message-ID: <af4d1e00-76d6-b71a-2ed1-562e6405306b@linaro.org>
Date:   Mon, 12 Jun 2023 16:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20230426062018.19755-1-zhuyinbo@loongson.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230426062018.19755-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 08:20, Yinbo Zhu wrote:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum 4 sensors, each sensor contains a sampling
> register and a control register. The sampling register is used to obtain
> the temperature in real time, the control register GATE field is used to
> set the threshold of high or low temperature, when the input temperature
> is higher than the high temperature threshold or lower than the low
> temperature threshold, an interrupt will occur.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v14:
> 		1. Add back depends on COMPILE_TEST.
> 		2. The implementation of devm_thermal_add_hwmon_sysfs has changed in
> 		   recent community code that cause compile fail issue and this verison
> 		   add a dev args in devm_thermal_add_hwmon_sysfs to fix compile issue.
> Change in v13:
> 		1. Add a description about that how works the sensor.
> 		2. Drop the COMPILE_TEST.
> 		3. Rework the help prograph in LOONGSON2_THERMAL Kconfig.
> 		4. Drop the 'tzd' 'irq' and 'pdev' element in loongson2_thermal_data.
> 		5. Drop the reset of variable in loongson2_thermal_set.
> 		6. Drop the function loongson2_thermal_get_sensor_id.
> 		7. Drop the function loongson2_thermal_alarm_irq.
> 		8. Rework the devm_thermal_of_zone_register.
> 		9. Pass 'tzd' instead of 'data' in devm_request_threaded_irq.
> 		10. Drop the "data->tzd->tzp->no_hwmon = false".
> 		11. Drop the loongson2_thermal_remove.
> 		12. Add the sensor id in the of_device_id data field.
> 		13. Drop the save and restore function.
> Change in v12:
> 		1. Fixup it about min and max.
> 		2. Use dev_err_probe replace dev_err in devm_request_threaded_irq context.
> Change in v11:
> 		1. Add min() and max() to replace related code in function
> 		   loongson2_thermal_set.
> 		2. Add dev_err_probe to to replace related code for function
> 		   return value use devm_thermal_of_zone_register.
> 		3. Replace thermal_add_hwmon_sysfs with devm_thermal_add_hwmon_sysfs
> 		   and use dev_warn replace dev_err in this context.
> Change in v10:
> 		1. Add all history change log information.
> Change in v9:
> 		1. Switch new API that use devm_thermal_of_zone_register
> 		   to replace previous interfaces.
> 		2. Add depend on LOONGARCH || COMPILE_TEST.
> Change in v8:
>                  1. Replace string loongson2/Loongson2/LOONGSON2 with loongson-2/
>                     Loongson-2/LOONGSON-2 in Kconfig and commit log and MAINTAINERS
> 		   files.
> Change in v7:
> 		1. Split the modification of patch 3 and merge it into this patch.
> 		2. Remove the unless code annotation to fix the compile warning
> 		   when compile C code with W=1.
> Change in v6:
> 		1. NO change, but other patch in this series of patches set has
> 		   changes.
> Change in v5:
> 		1. NO change, but other patch in this series of patches set has
> 		   changes.
> Change in v4:
> 		1. Fixup the compatible.
> Change in v3:
> 		1. Add a function to gain sensor id an remove dts id.
> Change in v2:
> 		1. Remove error msg printing when addr ioremap has error.
> 		2. Make loongson2 thermal driver was built-in by default.
> 		3. Replace ls2k with loongson2.
> 		4. Remove CONFIG_PM_SLEEP and set pm function type was
> 		   __maybe_unused.
> 
>   MAINTAINERS                         |   7 ++
>   drivers/thermal/Kconfig             |  12 ++
>   drivers/thermal/Makefile            |   1 +
>   drivers/thermal/loongson2_thermal.c | 166 ++++++++++++++++++++++++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 drivers/thermal/loongson2_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25a0981c74b6..b3a76acd2caf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12143,6 +12143,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
>   F:	drivers/pinctrl/pinctrl-loongson2.c
>   
> +LOONGSON-2 SOC SERIES THERMAL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/loongson2_thermal.c
> +
>   LOONGSON GPIO DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-gpio@vger.kernel.org
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4cd7ab707315..c4de94e972f4 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -502,4 +502,16 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config LOONGSON2_THERMAL
> +	tristate "Loongson-2 SoC series thermal driver"
> +	depends on LOONGARCH || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Support for Thermal driver found on Loongson-2 SoC series platforms.
> +	  The thermal driver realizes get_temp and set_trips function, which
> +	  are used to obtain the temperature of the current node and set the
> +	  temperature range to trigger the interrupt. When the input temperature
> +	  is higher than the high temperature threshold or lower than the low
> +	  temperature threshold, the interrupt will occur.
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index eed300e83d48..4edde4df647b 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -62,3 +62,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> new file mode 100644
> index 000000000000..6a338e6e490e
> --- /dev/null
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: zhanghongchen <zhanghongchen@loongson.cn>
> + *         Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/cpufreq.h>

Is it really needed ?

> +#include <linux/delay.h>

Is it really needed ?

> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/thermal.h>
> +#include "thermal_hwmon.h"
>
> +#define LOONGSON2_SOC_MAX_SENSOR_NUM			4
> +
> +#define LOONGSON2_TSENSOR_CTRL_HI			0x0
> +#define LOONGSON2_TSENSOR_CTRL_LO			0x8
> +#define LOONGSON2_TSENSOR_STATUS			0x10
> +#define LOONGSON2_TSENSOR_OUT				0x14

Please use BIT() macros

> +struct loongson2_thermal_data {
> +	int id;
> +	void __iomem *regs;
> +};

It would make sense to replace the id by the precomputed register offset 
value.

> +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> +					int low, int high, bool enable)
> +{
> +	u64 reg_ctrl = 0;
> +	int reg_off = data->id * 2;
> +
> +	if (low > high)
> +		return -EINVAL;

I don't think this is supposed to happen

> +	low = max(low, -40);
> +	high = min(high, 125);

You can use clamp() alternatively (your call)

> +
> +	low += 100;
> +	high += 100;
> +
> +	reg_ctrl = low;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +
> +	reg_ctrl = high;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);

Is the 'enable' boolean really useful?

Wouldn't be the sensor trip points disabled by default at reset time?

If it is the case then we can get ride of this variable and make the 
routine simpler

> +	return 0;
> +}
> +
> +static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	u32 reg_val;
> +	struct loongson2_thermal_data *data = tz->devdata;
> +
> +	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);

Seems like there is no offset for the sensor id here ?

> +	*temp = ((reg_val & 0xff) - 100) * 1000;

Please use macros in units.h for conversion and change literals by macro

> +	return 0;
> +}
> +
> +static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
> +{
> +	struct thermal_zone_device *tzd = dev;
> +	struct loongson2_thermal_data *data = tzd->devdata;

The init function tells me whatever the sensor triggering the interrupt 
we update the same thermal zone, not necessarily the one which reach the 
trip point.

> +	/* clear interrupt */
> +	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);

Replace the literal value by a macro.

> +	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct loongson2_thermal_data *data = tz->devdata;
> +
> +	return loongson2_thermal_set(data, low/1000, high/1000, true);

Please use macros in units.h for conversion

> +}
> +
> +static const struct thermal_zone_device_ops loongson2_of_thermal_ops = {
> +	.get_temp = loongson2_thermal_get_temp,
> +	.set_trips = loongson2_thermal_set_trips,
> +};
> +
> +static int loongson2_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct loongson2_thermal_data *data;
> +	struct thermal_zone_device *tzd;
> +	int ret, irq, i;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = (uintptr_t)device_get_match_data(dev);

The changelog says there is up to 4 sensors on the controller but the 
initialization code seems to handle only one.

Either you skip this data at all and let the loop to fill the id when 
the thermal zone successfully registered or you add a eg. a mask with 
the sensor (eg. 0x3 for sensor 0 and 1) and use those value in the loop.


> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(data->regs))
> +		return PTR_ERR(data->regs);
> +
> +	/* get irq */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	if (data->id > LOONGSON2_SOC_MAX_SENSOR_NUM - 1 || data->id < 0) {
> +		dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
> +				LOONGSON2_SOC_MAX_SENSOR_NUM - 1);
> +		return -EINVAL;
> +	}

As this is coming from a static initialization, this test is not needed.

> +	writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);

Replace the literal value by a macro

> +	loongson2_thermal_set(data, 0, 0, false);
> +
> +	for (i = 0; i < LOONGSON2_SOC_MAX_SENSOR_NUM; i++) {
> +		tzd = devm_thermal_of_zone_register(dev, i, data,
> +			&loongson2_of_thermal_ops);
> +
> +		if (!IS_ERR(tzd))
> +			break;

Assuming the loop aims to register all the supported thermal zones, the 
conditions should be inverted.

> +		if (PTR_ERR(tzd) != ENODEV)
> +			continue;
 >
> +		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
> +			IRQF_ONESHOT, "loongson2_thermal", tzd);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to request alarm irq\n")

So there is one interrupt but 4 sensors. I assume there is one interrupt 
per controller but I don't see in the interrupt handler routine the code 
to figure out which sensor triggered the interrupt.

> +	if (devm_thermal_add_hwmon_sysfs(dev, tzd))
> +		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_loongson2_thermal_match[] = {
> +	{ .compatible = "loongson,ls2k-thermal", .data = (const void *)0},

May be better to replace that with a structure pointer but it is up to 
you to decide

> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_loongson2_thermal_match);
> +
> +static struct platform_driver loongson2_thermal_driver = {
> +	.driver = {
> +		.name		= "loongson2_thermal",
> +		.of_match_table = of_loongson2_thermal_match,
> +	},
> +	.probe	= loongson2_thermal_probe,
> +};
> +module_platform_driver(loongson2_thermal_driver);
> +
> +MODULE_DESCRIPTION("Loongson2 thermal driver");
> +MODULE_LICENSE("GPL");

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

