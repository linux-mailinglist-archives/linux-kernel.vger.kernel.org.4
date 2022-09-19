Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093305BC366
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiISHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiISHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:11:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C031D326
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:11:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o2so43275439lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OkybTE66mfrvnk07mJhb8uDsL9ZCbDV0hOsy6isKbWw=;
        b=D/nRppMBq0YAnoEhINH3Z0P9TRgG1BXuZTIwyQM0dyZDLVwNJwi8aESkUvM73QHl+5
         F9QYMQK/xtCsTHVDZ19PN2TwvyZXD05vkPJLCzo4Ij2OttCP2NEl2aoqD5jAYDbq3iU+
         KMUaAnNPVXtKyV3LT4gSDILkBs/SV/ucd3Qn9u0YMqrvozsJ7A3DfDbt+kbzoAgfUtjg
         p5foBSLRm97TnkizKOVfpI3StsmQB5lQkCbUulHvRy8qRJOEjo9cDhs4oTEK6/38kmbq
         SNdleQ5QVzc6nSfF+j4drb/f4gEA0xgqkpxOEtIr6BUhfXcP1m3I1Ql11/vwTZUXU6Ri
         2qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OkybTE66mfrvnk07mJhb8uDsL9ZCbDV0hOsy6isKbWw=;
        b=pPvMoisTY8STEfGKmrWvWDptSuBlBwayOg9wrOiPMP6P/rbFznH2T1vsHEnh6/u0a5
         NzlYCvL9+teYvUOw2XdYzJeKcyKMcIJJT12I1RXHzYQQhsEJmA3727kEZIteDFqWgoHZ
         g+KT4sFgjUUiqs7/Q5nDKmLDy5g+G9ViKl78rEUD47PUqO+DdFMmGp9tj3dy5JHnXTDc
         uiWI/kCNk69t0SII3Rv8o3qsC/1XAhV/cxyy9pboDWz1ocqdxP9hE8P+xwBXxBNKbd40
         zjVVCofk/ZOFK8VcII3YpDwfRWHy5m1Wh0AviJZyMet8IeHecM/htgV/2VYM2dzEUcuX
         N9og==
X-Gm-Message-State: ACrzQf2EcppMgt2K6KO8JlZnw5zl6qk6s2cnN6stfnYQ/Zg4V96S4r9r
        BmMD1Zs/F5ipBWdEQeaP2JpKYQ==
X-Google-Smtp-Source: AMsMyM69FgTlQ/RA3kiV+ul8Cu2ZVr0C81M5qS5BMPwpGr3XxoadcKtBJkR9DBcKrshWMwkdmydh/w==
X-Received: by 2002:a05:6512:3da9:b0:49f:1742:c692 with SMTP id k41-20020a0565123da900b0049f1742c692mr6275517lfv.313.1663571479878;
        Mon, 19 Sep 2022 00:11:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b20-20020a056512071400b00492b494c4e8sm5049666lfs.298.2022.09.19.00.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 00:11:19 -0700 (PDT)
Message-ID: <b5578e0f-ac41-9889-a6bb-4b1d74197ec0@linaro.org>
Date:   Mon, 19 Sep 2022 09:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 3/3] thermal: ls2k: add thermal management support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>
References: <20220919034915.26912-1-zhuyinbo@loongson.cn>
 <20220919034915.26912-3-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919034915.26912-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 05:49, Yinbo Zhu wrote:
> This patch adds the support for loongson2k thermal sensor controller,
> which can support maximum 3 sensors.
> 
> It's based on thermal of framework:
>  - Trip points defined in device tree.
>  - Cpufreq as cooling device registered in loongson2k cpufreq driver.
>  - Pwm fan as cooling device registered in hwmon pwm-fan driver.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/thermal/Kconfig        |  10 ++
>  drivers/thermal/Makefile       |   1 +
>  drivers/thermal/ls2k_thermal.c | 244 +++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/thermal/ls2k_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..04f5c044bc94 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>  	  If you say yes here you get support for the FAN controlled
>  	  by the Microcontroller found on the Khadas VIM boards.
>  
> +config LOONGSON2K_THERMAL
> +	tristate "Loongson 2K SOC series thermal driver"
> +	depends on OF
> +	default m

Why should it be module by default on x86 or ARM? See how other drivers
do it.

> +	help
> +	  Support for Thermal driver found on Loongson 2K SOC series platforms.
> +	  It supports one critical trip point and one passive trip point. The
> +	  cpufreq and the pwm fan is used as the cooling device to throttle CPUs
> +	  when the passive trip is crossed.
> +
>  endif

(...)

> +
> +static int ls2k_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct ls2k_thermal_data *data;
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

There is a helper combining these two.

> +	if (IS_ERR(data->regs)) {
> +		dev_err(dev, "failed to get io address\n");

I think error msg can be skipped in such case. Core should print it.

> +		return PTR_ERR(data->regs);
> +	}
> +
> +	/* get irq */
> +	data->irq = platform_get_irq(pdev, 0);
> +	if (data->irq < 0)
> +		return data->irq;
> +
> +	/* get id */
> +	if (of_property_read_u32(dev->of_node, "id", &data->id)) {
> +		dev_err(dev, "not found id property!\n");
> +		data->id = LS2K_SOC_DEFAULT_SENSOR;
> +	}
> +
> +	if (data->id > LS2K_SOC_MAX_SENSOR_NUM) {
> +		dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
> +				LS2K_SOC_MAX_SENSOR_NUM);
> +		return -EINVAL;
> +	}
> +
> +	writeb(0xff, data->regs + LS2K_TSENSOR_STATUS);
> +
> +	ls2k_tsensor_set(data, 0, 0, false);
> +
> +	data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +							   data->id, data,
> +							   &ls2k_of_thermal_ops);
> +	if (IS_ERR(data->tzd)) {
> +		ret = PTR_ERR(data->tzd);
> +		data->tzd = NULL;
> +		dev_err(&pdev->dev, "failed to register %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, data->irq,
> +			ls2k_thermal_alarm_irq, ls2k_thermal_irq_thread,
> +			IRQF_ONESHOT, "ls2k_thermal", data);
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
> +int ls2k_thermal_remove(struct platform_device *pdev)
> +{
> +	struct ls2k_thermal_data *data = platform_get_drvdata(pdev);
> +	int reg_off = data->id * 2;
> +
> +	/* disable interrupt */
> +	writew(0, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
> +	writew(0, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_ls2k_thermal_match[] = {
> +	{ .compatible = "loongson,2k-tsensor",},
> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_ls2k_thermal_match);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ls2k_thermal_suspend(struct device *dev)
> +{
> +	struct ls2k_thermal_data *data = dev_get_drvdata(dev);
> +	int reg_off = data->id * 2;
> +
> +	data->ctrl_low_val = readw(data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
> +	data->ctrl_hi_val = readw(data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
> +
> +	writew(0, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
> +	writew(0, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static int ls2k_thermal_resume(struct device *dev)
> +{
> +	struct ls2k_thermal_data *data = dev_get_drvdata(dev);
> +	int reg_off = data->id * 2;
> +
> +	writew(data->ctrl_low_val, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
> +	writew(data->ctrl_hi_val, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ls2k_thermal_pm_ops,
> +			 ls2k_thermal_suspend, ls2k_thermal_resume);
> +#endif
> +
> +static struct platform_driver ls2k_thermal_driver = {
> +	.driver = {
> +		.name		= "ls2k_thermal",
> +#ifdef CONFIG_PM_SLEEP

pm_ptr() (and use same approach as its users - no need for ifdefs,
DEFINE_SIMPLE_DEV_PM_OPS)


> +		.pm = &ls2k_thermal_pm_ops,
> +#endif
> +		.of_match_table = of_ls2k_thermal_match,
> +	},
> +	.probe	= ls2k_thermal_probe,
> +	.remove	= ls2k_thermal_remove,
> +};
> +module_platform_driver(ls2k_thermal_driver);


Best regards,
Krzysztof
