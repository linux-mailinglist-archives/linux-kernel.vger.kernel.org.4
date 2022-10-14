Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C55FE7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJNDtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJNDtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:49:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8F99192984;
        Thu, 13 Oct 2022 20:49:04 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxumoq3Ehjs9wtAA--.29066S2;
        Fri, 14 Oct 2022 11:48:58 +0800 (CST)
Subject: Re: [PATCH v7 1/2] thermal: loongson2: add thermal management support
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, zhuyinbo@loongson.cn,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220930021054.22387-1-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <72c5ecfa-da9f-f7d9-e020-133a48de92a4@loongson.cn>
Date:   Fri, 14 Oct 2022 11:48:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220930021054.22387-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxumoq3Ehjs9wtAA--.29066S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tF4ftr13Gr4fGF1DJr4kXrb_yoWDtrykpF
        W7JwsxCFZrJF47Zw1DXr1UZF90vw13tFy3ZFZ7G3s5ZrZxJ343Wry8Gr18ZrWSkrWDGF1U
        ZFsYkrW5CFWqq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi thermal maintainer

Are there any other suggestions about this patch? If not, please help
merge this patch to upstream.

RRs
Yinbo
ÔÚ 2022/9/30 ÉÏÎç10:10, Yinbo Zhu Ð´µÀ:
> This patch adds the support for loongson2 thermal sensor controller,
> which can support maximum 4 sensors.
> 
> It's based on thermal of framework:
>   - Trip points defined in device tree.
>   - Cpufreq as cooling device registered in loongson2 cpufreq driver.
>   - Pwm fan as cooling device registered in hwmon pwm-fan driver.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v7:
> 		1. Split the modification of patch 3 and merge it into this patch.
> 		2. Remove the unless code annotation to fix the compile warning
> 		   when compile C code with W=1.
> 
>   MAINTAINERS                         |   7 +
>   drivers/thermal/Kconfig             |  10 ++
>   drivers/thermal/Makefile            |   1 +
>   drivers/thermal/loongson2_thermal.c | 264 ++++++++++++++++++++++++++++
>   4 files changed, 282 insertions(+)
>   create mode 100644 drivers/thermal/loongson2_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 589517372408..2efbd5b158b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11899,6 +11899,13 @@ F:	drivers/*/*loongarch*
>   F:	Documentation/loongarch/
>   F:	Documentation/translations/zh_CN/loongarch/
>   
> +LOONGSON2 SOC SERIES THERMAL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/loongson2_thermal.c
> +
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>   M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..6b60397e96a1 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config LOONGSON2_THERMAL
> +	tristate "Loongson2 SOC series thermal driver"
> +	depends on OF
> +	default y
> +	help
> +	  Support for Thermal driver found on Loongson2 SOC series platforms.
> +	  It supports one critical trip point and one passive trip point. The
> +	  cpufreq and the pwm fan is used as the cooling device to throttle
> +	  CPUs when the passive trip is crossed.
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..e99f839126fa 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> new file mode 100644
> index 000000000000..082f9dd0b2a2
> --- /dev/null
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: zhanghongchen <zhanghongchen@loongson.cn>
> + *         Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/thermal.h>
> +#include "thermal_hwmon.h"
> +
> +#define LOONGSON2_SOC_MAX_SENSOR_NUM			4
> +
> +#define LOONGSON2_TSENSOR_CTRL_HI			0x0
> +#define LOONGSON2_TSENSOR_CTRL_LO			0x8
> +#define LOONGSON2_TSENSOR_STATUS			0x10
> +#define LOONGSON2_TSENSOR_OUT				0x14
> +
> +struct loongson2_thermal_data {
> +	struct thermal_zone_device *tzd;
> +	int irq;
> +	int id;
> +	void __iomem *regs;
> +	struct platform_device *pdev;
> +	u16 ctrl_low_val;
> +	u16 ctrl_hi_val;
> +};
> +
> +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> +					int low, int high, bool enable)
> +{
> +	u64 reg_ctrl = 0;
> +	int reg_off = data->id * 2;
> +
> +	if (low > high)
> +		return -EINVAL;
> +
> +	low = low < -100 ? -100 : low;
> +	high = high > 155 ? 155 : high;
> +
> +	low += 100;
> +	high += 100;
> +
> +	reg_ctrl |= low;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +
> +	reg_ctrl = 0;
> +	reg_ctrl |= high;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static int loongson2_thermal_get_temp(void *__data, int *temp)
> +{
> +	struct loongson2_thermal_data *data = __data;
> +	u32 reg_val;
> +
> +	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
> +	*temp = ((reg_val & 0xff) - 100) * 1000;
> +
> +	return 0;
> +}
> +
> +static int loongson2_thermal_get_sensor_id(void)
> +{
> +	int ret, id;
> +	struct of_phandle_args sensor_specs;
> +	struct device_node *np, *sensor_np;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return -ENODEV;
> +
> +	sensor_np = of_get_next_child(np, NULL);
> +	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +			"#thermal-sensor-cells",
> +			0, &sensor_specs);
> +	if (ret) {
> +		of_node_put(np);
> +		of_node_put(sensor_np);
> +		return ret;
> +	}
> +
> +	if (sensor_specs.args_count >= 1) {
> +		id = sensor_specs.args[0];
> +		WARN(sensor_specs.args_count > 1,
> +				"%s: too many cells in sensor specifier %d\n",
> +				sensor_specs.np->name, sensor_specs.args_count);
> +	} else {
> +		id = 0;
> +	}
> +
> +	of_node_put(np);
> +	of_node_put(sensor_np);
> +
> +	return id;
> +}
> +
> +static irqreturn_t loongson2_thermal_alarm_irq(int irq, void *dev)
> +{
> +	struct loongson2_thermal_data *data = dev;
> +
> +	/* clear interrupt */
> +	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);
> +
> +	disable_irq_nosync(irq);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
> +{
> +	struct loongson2_thermal_data *data = dev;
> +
> +	thermal_zone_device_update(data->tzd,
> +				   THERMAL_EVENT_UNSPECIFIED);
> +	enable_irq(data->irq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int loongson2_thermal_set_trips(void *data, int low, int high)
> +{
> +	return loongson2_thermal_set(data, low/1000, high/1000, true);
> +}
> +
> +static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
> +	.get_temp = loongson2_thermal_get_temp,
> +	.set_trips = loongson2_thermal_set_trips,
> +};
> +
> +static int loongson2_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct loongson2_thermal_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev = pdev;
> +	platform_set_drvdata(pdev, data);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(data->regs))
> +		return PTR_ERR(data->regs);
> +
> +	/* get irq */
> +	data->irq = platform_get_irq(pdev, 0);
> +	if (data->irq < 0)
> +		return data->irq;
> +
> +	/* get id */
> +	data->id = loongson2_thermal_get_sensor_id();
> +	if (data->id > LOONGSON2_SOC_MAX_SENSOR_NUM - 1 || data->id < 0) {
> +		dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
> +				LOONGSON2_SOC_MAX_SENSOR_NUM - 1);
> +		return -EINVAL;
> +	}
> +
> +	writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
> +
> +	loongson2_thermal_set(data, 0, 0, false);
> +
> +	data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +							   data->id, data,
> +							   &loongson2_of_thermal_ops);
> +	if (IS_ERR(data->tzd)) {
> +		ret = PTR_ERR(data->tzd);
> +		data->tzd = NULL;
> +		dev_err(&pdev->dev, "failed to register %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, data->irq,
> +			loongson2_thermal_alarm_irq, loongson2_thermal_irq_thread,
> +			IRQF_ONESHOT, "loongson2_thermal", data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request alarm irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Thermal_zone doesn't enable hwmon as default,
> +	 * enable it here
> +	 */
> +	data->tzd->tzp->no_hwmon = false;
> +	ret = thermal_add_hwmon_sysfs(data->tzd);
> +	if (ret) {
> +		dev_err(dev, "failed to add hwmon sysfs interface %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int loongson2_thermal_remove(struct platform_device *pdev)
> +{
> +	struct loongson2_thermal_data *data = platform_get_drvdata(pdev);
> +	int reg_off = data->id * 2;
> +
> +	/* disable interrupt */
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_loongson2_thermal_match[] = {
> +	{ .compatible = "loongson,ls2k-thermal",},
> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_loongson2_thermal_match);
> +
> +static int __maybe_unused loongson2_thermal_suspend(struct device *dev)
> +{
> +	struct loongson2_thermal_data *data = dev_get_drvdata(dev);
> +	int reg_off = data->id * 2;
> +
> +	data->ctrl_low_val = readw(data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	data->ctrl_hi_val = readw(data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused loongson2_thermal_resume(struct device *dev)
> +{
> +	struct loongson2_thermal_data *data = dev_get_drvdata(dev);
> +	int reg_off = data->id * 2;
> +
> +	writew(data->ctrl_low_val, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	writew(data->ctrl_hi_val, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(loongson2_thermal_pm_ops,
> +			 loongson2_thermal_suspend, loongson2_thermal_resume);
> +
> +static struct platform_driver loongson2_thermal_driver = {
> +	.driver = {
> +		.name		= "loongson2_thermal",
> +		.pm = &loongson2_thermal_pm_ops,
> +		.of_match_table = of_loongson2_thermal_match,
> +	},
> +	.probe	= loongson2_thermal_probe,
> +	.remove	= loongson2_thermal_remove,
> +};
> +module_platform_driver(loongson2_thermal_driver);
> 

