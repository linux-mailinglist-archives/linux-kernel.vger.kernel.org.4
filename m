Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350CB6F2528
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjD2POd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjD2POb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 11:14:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77B1BE4;
        Sat, 29 Apr 2023 08:14:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aae46e62e9so1171455ad.2;
        Sat, 29 Apr 2023 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682781269; x=1685373269;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jS/Qj5qy6a2iwP+ksA0M21M2FNcCXcOLPE8xjaXit00=;
        b=QmxozxAtwsr9yArsMKtZ+3pRvwEoMnL2stoyIyBDYVd5Y4eauNPSsZjh7WoRJvm232
         n3FYJ/9vDqBnRs736NfhXDUu2ZTvWzQO3QarV85Ny7pRq83uPKQsfpzPZMYcg9AGyhFS
         HzQsSrORn29qVqLs5ZiV+MjZM58Smtt4LaCsvqEPOxYN86Hz0/bwBHSulCyFv/YRwODB
         F5w93NJKoGP6ocf60V05lqKCaex5s3uIWk9XIP9N531Ydn5zvIpZ1ZpGZzdavurcs0S6
         jAOArkhK5zC+ek32cnO3ogwOEb15J44q8nAqEpp4xiOJkT97VauSsefe0cDFrGvXYkcH
         j1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682781269; x=1685373269;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jS/Qj5qy6a2iwP+ksA0M21M2FNcCXcOLPE8xjaXit00=;
        b=g49Hk42UxzG9cnhVBQQf11F7tPTUxOe/0x1VOyxoqgDL75eYdbLhTfCF+lz8XqbDSi
         viihKThAhNWz02iaasK6Ean711i2Y4vk0ek/xY591vc2I+vbjlz+1wRClkECqBsQrNKn
         TCkIZ1oO/yJsAmVo6wgaxQEfXc1eX7aPpKmmaBYAtR9u12dXmPVhxSa5vK59VTaw1pWy
         tSq5CrChoV39LLjImra5lssXEWRUOWlre6Rh68MhEIEbbpbfHxzCIBtmTeisbUQjAn06
         nknYNW6txEFUPuU2u9NOoFj6V6OisCOIElOLusM0/iHdUYqbWZu5YcebgBcNHBkVEtoV
         +QRA==
X-Gm-Message-State: AC+VfDx5hfpbU+DH1/UvNIdOIDWHBbbNH7fbUx490fAT4vqqa31WXT8X
        PHTfOYqZHs0RTlmsBtRzfZs=
X-Google-Smtp-Source: ACHHUZ6zHbzuQ3Mz8G4lRMSTiyEL779griAx+Gq2oJqRvGQ1cJ0nJzpfnUdhopNmju76HIT2B4NfMQ==
X-Received: by 2002:a17:902:b20e:b0:1a1:d366:b085 with SMTP id t14-20020a170902b20e00b001a1d366b085mr8349435plr.21.1682781268695;
        Sat, 29 Apr 2023 08:14:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a2dc800b0024b4a06a4fesm3203532pjm.5.2023.04.29.08.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 08:14:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55b5c88b-8d0d-d02f-6fe7-091a991f4065@roeck-us.net>
Date:   Sat, 29 Apr 2023 08:14:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20230427071408.8493-1-bbhushan2@marvell.com>
 <20230427071408.8493-2-bbhushan2@marvell.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2 v4] Watchdog: Add marvell GTI watchdog driver
In-Reply-To: <20230427071408.8493-2-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 00:14, Bharat Bhushan wrote:
> This patch add support for Marvell GTI watchdog.  Global timer
> unit (GTI) support hardware watchdog timer. Software programs
> watchdog timer to generate interrupt on first timeout, second
> timeout is configured to be ignored and system reboots on
> third timeout.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v4:
>   - Use generic name "GTI (Global Timer)" and removed OcteonTX2 as this driver
>     is applicable for other marvell devices as well.
> 
>   drivers/watchdog/Kconfig           |  11 ++
>   drivers/watchdog/Makefile          |   1 +
>   drivers/watchdog/marvell_gti_wdt.c | 271 +++++++++++++++++++++++++++++
>   3 files changed, 283 insertions(+)
>   create mode 100644 drivers/watchdog/marvell_gti_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..a96e7d7c0ad2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1779,6 +1779,17 @@ config OCTEON_WDT
>   	  from the first interrupt, it is then only poked when the
>   	  device is written.
>   
> +config MARVELL_GTI_WDT
> +	tristate "Marvell GTI Watchdog driver"
> +	depends on ARCH_THUNDER || COMPILE_TEST

As 0-day reported, COMPILE_TEST does not work if there are asm includes
in the code.

> +	help
> +	 Marvell GTI hardware supports watchdog timer. First timeout
> +	 works as watchdog pretimeout and installed interrupt handler
> +	 will be called on first timeout. Hardware can generate interrupt
> +	 to SCP on second timeout but it is not enabled, So second
> +	 timeout is ignored. If device poke does not happen then system
> +	 will reboot on third timeout.
> +
>   config BCM2835_WDT
>   	tristate "Broadcom BCM2835 hardware watchdog"
>   	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..bd425408fcaa 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>   obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>   obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
>   obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
> +obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
>   
>   # X86 (i386 + ia64 + x86_64) Architecture
>   obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
> new file mode 100644
> index 000000000000..a3f0740dedca
> --- /dev/null
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell GTI Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#include <asm/arch_timer.h>
> +
> +/*
> + * Hardware supports following mode of operation:
> + * 1) Interrupt Only:
> + *    This will generate the interrupt to arm core whenever timeout happens.
> + *
> + * 2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
> + *    This will generate interrupt to arm core on 1st timeout happens
> + *    This will generate interrupt to SCP processor on 2nd timeout happens
> + *
> + * 3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
> + *    This will generate interrupt to arm core on 1st timeout happens
> + *    Will generate interrupt to SCP processor on 2nd timeout happens,
> + *    if interrupt is configured.
> + *    Reboot on 3rd timeout.
> + *
> + * Driver will use hardware in mode-3 above so that system can reboot in case
> + * a hardware hang. Also h/w is configured not to generate SCP interrupt, so
> + * effectively 2nd timeout is ignored within hardware.
> + */
> +
> +
> +/* GTI CWD Watchdog Registers */
> +#define GTI_CWD_GLOBAL_WDOG_IDX		63

It might make sense to explain "63".

> +#define GTI_CWD_WDOG			(0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
> +#define GTI_CWD_WDOG_MODE_MASK		0x3
> +#define GTI_CWD_WDOG_LEN_SHIFT		4
> +#define GTI_CWD_WDOG_CNT_SHIFT		20
> +
> +/* GTI Per-core Watchdog Interrupt Register */
> +#define GTI_CWD_INT			0x200
> +#define GTI_CWD_INT_PENDING_STATUS	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)

Please use BIT_ULL().

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

There should be a comment explaining the "8". Also,
there is a define for "0x8 * GTI_CWD_GLOBAL_WDOG_IDX" above.
Why not use it here ?

> +#define GTI_CWD_POKE_VAL	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)

I don't think it makes sense to have three defines with the same value.

> +
> +struct gti_wdt_priv {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	u64 clock_freq;
> +	int irq;
> +};
> +
> +static irqreturn_t gti_wdt_interrupt(int irq, void *data)
> +{
> +	struct watchdog_device *wdev = data;
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	/* Clear Interrupt Pending Status */
> +	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
> +
> +	watchdog_notify_pretimeout(wdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gti_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	if (!wdev->pretimeout)
> +		return -EINVAL;
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
> +static int gti_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
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
> +static int gti_wdt_settimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 timeout_wdog, regval;
> +
> +	/* Update new timeout */
> +	wdev->timeout = timeout;
> +
> +	/* Pretimeout is 1/3 of timeout */
> +	wdev->pretimeout = timeout / 3;
> +	if (!wdev->pretimeout)
> +		return -EINVAL;

Since min_timeout is set to 3 seconds, this can not happen,
and the check is unnecessary.

> +
> +	/* Get clock cycles from timeout in second */

from pretimeout ?

> +	timeout_wdog = wdev->pretimeout * priv->clock_freq;
> +
> +	/* Watchdog counts in 1024 cycle steps */
> +	timeout_wdog = timeout_wdog >> 10;
> +
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
> +	regval |= (timeout_wdog << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
> +	writeq(regval, priv->base + GTI_CWD_WDOG);
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	struct watchdog_device *wdog_dev = &priv->wdev;
> +
> +	/* pretimeout should 1/3 of max_timeout */
> +	if ((timeout * 3) <= wdog_dev->max_timeout)

Unnecessary ()

> +		return gti_wdt_settimeout(wdev, timeout * 3);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct watchdog_info gti_wdt_ident = {
> +	.identity = "Marvell GTI watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT | WDIOF_KEEPALIVEPING |
> +		   WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> +};
> +
> +static const struct watchdog_ops gti_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = gti_wdt_start,
> +	.stop = gti_wdt_stop,
> +	.ping = gti_wdt_ping,
> +	.set_timeout = gti_wdt_settimeout,
> +	.set_pretimeout = gti_wdt_set_pretimeout,
> +};
> +
> +static int gti_wdt_probe(struct platform_device *pdev)
> +{
> +	struct gti_wdt_priv *priv;
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

arch_timer_get_cntfrq() returns u32. Storing it as u64 to save
a couple of typecasts really doesn't add value.

Note that this limits compilability to arm and arm64.

> +
> +	wdog_dev = &priv->wdev;
> +	wdog_dev->info = &gti_wdt_ident,
> +	wdog_dev->ops = &gti_wdt_ops,
> +	wdog_dev->parent = dev;
> +	/*
> +	 * Watchdog counter is 24 bit where lower 8 bits are zeros, so maximum
> +	 * value that can be programmed in hardware is 0xffff00. This counter
> +	 * decrements every one microsec.
> +	 * Hardware will generate interrupt on first timeout (pretimeout)
> +	 * reset the system on 3rd timeout.
> +	 * Max watchdog pretimeout can be 16 sec, so max timeout is 48 sec.
> +	 * Let's have min pretimeout to 1sec, so min timeout is 3sec.
> +	 */
> +	wdog_dev->max_timeout = 48;

The code setting the actual timeout checks for overflow, suggesting that
the actual maximum timeout depends on the clock speed and may be less
than 48 seconds. If that ever happens, the actual timeout would be set
to less than 48 seconds, which could cause random reboots.

> +	wdog_dev->min_timeout = 3;
> +	wdog_dev->timeout = 30;
> +	wdog_dev->pretimeout = wdog_dev->timeout / 3;
> +
> +	priv->irq = irq;
> +	watchdog_set_drvdata(wdog_dev, priv);
> +	platform_set_drvdata(pdev, priv);
> +	gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> +	watchdog_stop_on_reboot(wdog_dev);
> +	watchdog_stop_on_unregister(wdog_dev);
> +
> +	err = devm_watchdog_register_device(dev, wdog_dev);
> +	if (err)
> +		return err;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq, "IRQ resource not found\n");
> +
> +	err = devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
> +			       pdev->name, &priv->wdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register interrupt handler\n");
> +
> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
> +	return 0;
> +}
> +
> +static const struct of_device_id gti_wdt_of_match[] = {
> +	{ .compatible = "marvell,gti-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, gti_wdt_of_match);
> +
> +static struct platform_driver gti_wdt_driver = {
> +	.driver = {
> +		.name = "gti-wdt",
> +		.of_match_table = gti_wdt_of_match,
> +	},
> +	.probe = gti_wdt_probe,
> +};
> +module_platform_driver(gti_wdt_driver);
> +
> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_DESCRIPTION("Marvell GTI watchdog driver");

