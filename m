Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0936E220E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDNL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDNL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:27:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98727EF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:27:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud9so44547626ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471668; x=1684063668;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XM86V3q0VssVgC57HZFavLzNSvDNISvAL0hx/IADtCs=;
        b=GysGcyMM2DpD83blgu4UAReXUkqavpGB5hKnRD7pRKNjuoCgLwuXBM66VqqvJ/kwQ3
         Z2W4X7jWmdCiIwe+hWB2EY5LRsNdqR0w4NjVybO7j5bz/FomK6QnHlM3A1WgCSpOZABM
         3+L8ZZXGDCgWwZHH8aPl8Qx2B0NiMgHwvSqyMgC/I5bSnZtljGOetPd3mTmLWwSZcfvq
         HzfxpLe3s5Cnj4tT/yOrJpxnlivFrXafq/UHwUrSxCKPJXQn3IITYghrj8PzpWBzmgHP
         iS5JiDzY0FEpuLAjXH/7eomV7tI1ccLotTLjE9PBBWQB5Svo0ro1ebWxco0Pz7+rOFjf
         FTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471668; x=1684063668;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM86V3q0VssVgC57HZFavLzNSvDNISvAL0hx/IADtCs=;
        b=DcqZuLjwGJLmfbFlo4cazZTD7TOb6aJtnnMS011fWuZh/iGlKA8V7Ejvfmu07b9DWL
         okkMWL0Csv4M6vCedPcpZPemeM9kdDPjH9XSY/fVkN8yj3p/ZYuLoIJi5xFGbDn+Crmm
         ykkiIX5cf6N+NESoN7sBhtg2kaFXwBlWsjrJOa13p5ORWyo4NURqNb2cxuVz7ubRAr0c
         nOsC5vOOOMOGF+TKe/apDIA+nRIWuktSMsqDXcgxIz84D4ACE5nbTsrzmUm/Nts7noAj
         L24DpljhEh6z0xhpdlggH2fgRlB1N+6DSM9YrmzA4pZdzauXhDauQq7srbhr+KfkfMNt
         R37g==
X-Gm-Message-State: AAQBX9dVNnc2lL0oZ/2cY/URBs02jtLTNewT1MAsraHeHQln5gjmn6km
        pxmpDNDVlSHTqi6XqtNXAy0LhQ==
X-Google-Smtp-Source: AKy350ZIISl8bncVzBpGN6xCIPgW8roFvudPexgCuXBzuI//MWjpuQNw+IshnQjsjUEtsZ1QH0FE4Q==
X-Received: by 2002:a17:907:1b1b:b0:94e:4fac:d92b with SMTP id mp27-20020a1709071b1b00b0094e4facd92bmr6010702ejc.58.1681471668315;
        Fri, 14 Apr 2023 04:27:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id nd23-20020a170907629700b0094e9f87c6d4sm2296149ejc.192.2023.04.14.04.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:27:47 -0700 (PDT)
Message-ID: <832d7830-be98-243c-ebf7-c23ae51e4ccc@linaro.org>
Date:   Fri, 14 Apr 2023 13:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <20230414102342.23696-2-bbhushan2@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414102342.23696-2-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:23, Bharat Bhushan wrote:
> GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
> and del3t traps are not enabled.
> GTI watchdog exception flow is:
>  - 1st timer expiration generates watchdog interrupt.
>  - 2nd timer expiration is ignored
>  - On 3rd timer expiration will trigger a system-wide core reset.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  drivers/watchdog/Kconfig         |   9 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/octeontx2_wdt.c | 238 +++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/watchdog/octeontx2_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..31ff282c62ad 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called keembay_wdt.
>  
> +config OCTEONTX2_WATCHDOG
> +	tristate "OCTEONTX2 Watchdog driver"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)

Why it cannot be compile tested on 32-bit?

> +	help
> +	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog timer are
> +	 programmed in "interrupt + del3t + reset" mode. On first expiry it will
> +	 generate interrupt. Second expiry (del3t) is ignored and system will reset
> +	 on final timer expiry.
> +
>  endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..aa1b813ad1f9 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>  obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> +obj-$(CONFIG_OCTEONTX2_WATCHDOG) += octeontx2_wdt.o

Please tell me that you added it in some reasonable place, not just at
the end... The same in Kconfig.

> diff --git a/drivers/watchdog/octeontx2_wdt.c b/drivers/watchdog/octeontx2_wdt.c
> new file mode 100644
> index 000000000000..7b78a092e83f
> --- /dev/null
> +++ b/drivers/watchdog/octeontx2_wdt.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell Octeontx2 Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell International Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Drop boilerplate.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/sched/debug.h>
> +
> +#include <asm/arch_timer.h>
> +
> +/* GTI CWD Watchdog Registers */
> +#define GTI_CWD_GLOBAL_WDOG_IDX		63
> +#define GTI_CWD_WDOG			(0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
> +#define GTI_CWD_WDOG_MODE_MASK		0x3
> +#define GTI_CWD_WDOG_LEN_SHIFT		4
> +#define GTI_CWD_WDOG_CNT_SHIFT		20
> +
> +/* GTI Per-core Watchdog Interrupt Register */
> +#define GTI_CWD_INT			0x200
> +#define GTI_CWD_INT_PENDING_STATUS	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +/* GTI Per-core Watchdog Interrupt Enable Clear Register */
> +#define GTI_CWD_INT_ENA_CLR		0x210
> +#define GTI_CWD_INT_ENA_CLR_VAL		(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +/* GTI Per-core Watchdog Interrupt Enable Set Register */
> +#define GTI_CWD_INT_ENA_SET		0x218
> +#define GTI_CWD_INT_ENA_SET_VAL		(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +/* GTI Per-core Watchdog Poke Registers */
> +#define GTI_CWD_POKE		(0x10000 + 0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
> +#define GTI_CWD_POKE_VAL	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> +
> +struct octeontx2_wdt_priv {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	u64 clock_freq;
> +	int irq;
> +};
> +
> +static irqreturn_t octeontx2_wdt_interrupt(int irq, void *data)
> +{
> +	panic("Kernel Watchdog");
> +	return IRQ_HANDLED;
> +}
> +
> +static int octeontx2_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> +
> +	/* Clear any pending interrupt */
> +	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
> +
> +	/* Enable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_SET_VAL, priv->base + GTI_CWD_INT_ENA_SET);
> +
> +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
> +	regval = readq(priv->base + GTI_CWD_WDOG);
> +	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	/* Disable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_CLR_VAL, priv->base + GTI_CWD_INT_ENA_CLR);
> +
> +	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
> +	regval = readq(priv->base + GTI_CWD_WDOG);
> +	regval &= ~GTI_CWD_WDOG_MODE_MASK;
> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_settimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 timeout_wdog, regval;
> +
> +	/* Update new timeout */
> +	wdev->timeout = timeout;
> +
> +	/* Get clock cycles from timeout in second */
> +	timeout_wdog = (u64)timeout * priv->clock_freq;
> +
> +	/* Watchdog counts in 1024 cycle steps */
> +	timeout_wdog = timeout_wdog >> 10;
> +
> +	/*
> +	 * Hardware allows programming of upper 16-bits of 24-bits cycles
> +	 * Round up and use upper 16-bits only.
> +	 * Set max if timeout more than h/w supported
> +	 */
> +	timeout_wdog = (timeout_wdog + 0xff) >> 8;
> +	if (timeout_wdog >= 0x10000)
> +		timeout_wdog = 0xffff;
> +
> +	/*
> +	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
> +	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
> +	 */
> +	regval = readq(priv->base + GTI_CWD_WDOG);
> +	regval &= GTI_CWD_WDOG_MODE_MASK;
> +	regval |= ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +	return 0;
> +}
> +
> +static const struct watchdog_info octeontx2_wdt_ident = {
> +	.identity = "OcteonTX2 watchdog",
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
> +			  WDIOF_CARDRESET,

Weird indentation in =

> +};
> +
> +static const struct watchdog_ops octeontx2_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = octeontx2_wdt_start,
> +	.stop = octeontx2_wdt_stop,
> +	.ping = octeontx2_wdt_ping,
> +	.set_timeout = octeontx2_wdt_settimeout,
> +};
> +
> +static int octeontx2_wdt_probe(struct platform_device *pdev)
> +{
> +	struct octeontx2_wdt_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdog_dev;
> +	int irq;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> +			      "reg property not valid/found\n");
> +
> +	priv->clock_freq = arch_timer_get_cntfrq();
> +
> +	wdog_dev = &priv->wdev;
> +	wdog_dev->info = &octeontx2_wdt_ident,
> +	wdog_dev->ops = &octeontx2_wdt_ops,
> +	wdog_dev->parent = dev;
> +	wdog_dev->min_timeout = 1;
> +	wdog_dev->max_timeout = 16;
> +	wdog_dev->max_hw_heartbeat_ms = 16000;
> +	wdog_dev->timeout = 8;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "IRQ resource not found\n");

return dev_err_probe
also in other places

> +		return -ENODEV;
> +	}
> +
> +	err = request_irq(irq, octeontx2_wdt_interrupt, 0, pdev->name, priv);
> +	if (err) {
> +		dev_err(dev, "cannot register interrupt handler %d\n", err);
> +		return err;
> +	}
> +
> +	priv->irq = irq;
> +	watchdog_set_drvdata(wdog_dev, priv);
> +	platform_set_drvdata(pdev, priv);
> +	watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
> +	octeontx2_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> +	watchdog_stop_on_reboot(wdog_dev);
> +	watchdog_stop_on_unregister(wdog_dev);
> +
> +	err = devm_watchdog_register_device(dev, wdog_dev);
> +	if (err) {
> +		free_irq(irq, priv);
> +		return err;
> +	}
> +
> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
> +	return 0;
> +}
> +
> +static int octeontx2_wdt_remove(struct platform_device *pdev)
> +{
> +	struct octeontx2_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (priv->irq)

Is it possible?

> +		free_irq(priv->irq, priv);

Anyway, your order of cleanup is a bit surprising. It is expected to be
reversed from probe. In probe() you requested IRQs before watchdog, but
cleanup will be done before watchdog release? This does not look right.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id octeontx2_wdt_of_match[] = {
> +	{ .compatible = "marvell-octeontx2-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, octeontx2_wdt_of_match);

Best regards,
Krzysztof

