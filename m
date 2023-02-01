Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB90687136
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBAWq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjBAWqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:46:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED3392A4;
        Wed,  1 Feb 2023 14:46:22 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bj22so7945521oib.11;
        Wed, 01 Feb 2023 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzojT2eyaXYXiJ8uoGa4fLftd+wHfD5ULPE4dOrc+xg=;
        b=UAz4SQLsyV3Q0BbPMMXDobACX0/3oOMR9LXz+SCEdVXePjVgV05buCCup1P7GpWlzL
         deYXDlM0BSTNFSU+nuhO/n6FcR24S9lG0lcavvIe7B6dtyO6ndIRlmr3VYwXyJAS1lfh
         GlIm5ksqOT6yvpbv+1/Ro6QL5aFdMmZ5jHW7zo6nhTZHIobKHiHpCMPiYT8eJ56Klnsg
         23wJLCCVzfrLg6prmHMH+xUFeENaW8ndQSNDXXc/laUo4CPOPM10JZJzX3kYpKdXevQX
         XVwurj/hB82ca1nBSwCIWT84HjBjRXhsCKupaT7BFYHVOCPtYWO6m7k4fYWzACztmV2s
         WeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzojT2eyaXYXiJ8uoGa4fLftd+wHfD5ULPE4dOrc+xg=;
        b=CvYkWldKJ+5xcUZX11DgMlN/qS5GVRMCxJX3J6ZxpOwILxwXvHuirbgayAQbAl4MW5
         vfdiUi8hzhS9O3chuOKE8cPE2hjoogkPF/QmjRfx7Iyg5bpKXLzDa+RgpVY+RGL2DaUw
         eJYwp3+DcOlCTw5hTbfR+fJrEfHTKdCs/0NdA0AGRa+Gd3M3vPzwPVOx8vtsOlx8qjp0
         H5BhTboT7U1lmFLFWkouIrkzV9WGuMIaqDFlauCsFIv2wwlfIbbdjuY+nfieYJSfwfk4
         wANPOE212biw5ak7awb0NN/10eqcIWIQD4mIJvMbGducd8V6Or4B+0yDCmi90faIiv4c
         I91Q==
X-Gm-Message-State: AO0yUKV5/xYqWffLQinekwx0KIvMakbIFcQetU+dq6LRkFCFYVL0GfhC
        M678AdR77RsAyOQ33Jor6ug=
X-Google-Smtp-Source: AK7set+Gayetn2k3IeSTf1hJjQYCC+Le81ehhBaVrsuzmL8aizoIxqdEt/+Ycsa7n3PymX1TFXpF6A==
X-Received: by 2002:aca:3fc1:0:b0:378:5473:dbb with SMTP id m184-20020aca3fc1000000b0037854730dbbmr1714347oia.42.1675291581821;
        Wed, 01 Feb 2023 14:46:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v20-20020a9d5a14000000b006865f605ce3sm8237894oth.54.2023.02.01.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:46:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Feb 2023 14:46:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers: watchdog: Add StarFive Watchdog driver
Message-ID: <20230201224619.GA3194283@roeck-us.net>
References: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
 <20221219094233.179153-3-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219094233.179153-3-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 05:42:32PM +0800, Xingyu Wu wrote:
> Add watchdog driver for the StarFive JH7110 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

This driver is almost impossible for me to review. There is a lot of code
which doesn't make sense to me. I'll outline some of it below, but this is
by far not a complete review.

> ---
>  MAINTAINERS                     |   7 +
>  drivers/watchdog/Kconfig        |  11 +
>  drivers/watchdog/Makefile       |   3 +
>  drivers/watchdog/starfive-wdt.c | 720 ++++++++++++++++++++++++++++++++
>  4 files changed, 741 insertions(+)
>  create mode 100644 drivers/watchdog/starfive-wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a70c1d0f303e..9c1758e7d034 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19623,6 +19623,13 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>  F:	drivers/reset/starfive/
>  F:	include/dt-bindings/reset/starfive*
>  
> +STARFIVE JH7110 WATCHDOG DRIVER
> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
> +M:	Samin Guo <samin.guo@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/watchdog/starfive*
> +F:	drivers/watchdog/starfive-wdt.c
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b64bc49c7f30..8eeb0e23e98d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2082,6 +2082,17 @@ config UML_WATCHDOG
>  	tristate "UML watchdog"
>  	depends on UML || COMPILE_TEST
>  
> +# RISCV Architecture
> +
> +config STARFIVE_WATCHDOG
> +	tristate "StarFive Watchdog support"
> +	depends on RISCV
> +	select WATCHDOG_CORE
> +	default SOC_STARFIVE
> +	help
> +	  Say Y here to support the watchdog of StarFive JH7110 SoC.
> +	  This driver can also be built as a module if choose M.
> +
>  #
>  # ISA-based Watchdog Cards
>  #
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index d41e5f830ae7..9c22f1a43d5c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -210,6 +210,9 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
>  # Xen
>  obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>  
> +# RISCV Architecture
> +obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
> +
>  # Architecture Independent
>  obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
>  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> new file mode 100644
> index 000000000000..d7fad0a2207c
> --- /dev/null
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -0,0 +1,720 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Starfive Watchdog driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/timer.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +#include <linux/watchdog.h>

Several of those include files are unnecessary.

> +
> +/* JH7110 WatchDog register define */
> +#define STARFIVE_WDT_JH7110_LOAD	0x000	/* RW: Watchdog load register */
> +#define STARFIVE_WDT_JH7110_VALUE	0x004	/* RO: The current value for the watchdog counter */
> +#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
> +						 * RW:
> +						 * [0]: reset enable;
> +						 * [1]: int enable/wdt enable/reload counter;
> +						 * [31:2]: reserve.
> +						 */
> +#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* WO: clear intterupt && reload the counter */
> +#define STARFIVE_WDT_JH7110_RIS		0x010	/* RO: Raw interrupt status from the counter */
> +#define STARFIVE_WDT_JH7110_IMS		0x014	/* RO: Enabled interrupt status from the counter */
> +#define STARFIVE_WDT_JH7110_LOCK	0xc00	/*
> +						 * RO: Enable write access to all other registers
> +						 * by writing 0x1ACCE551.
> +						 */
> +
> +#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
> +#define STARFIVE_WDT_JH7110_RESEN_SHIFT		1
> +#define STARFIVE_WDT_JH7110_EN_SHIFT		0
> +
> +/* WDOGCONTROL */
> +#define STARFIVE_WDT_ENABLE	0x1
> +#define STARFIVE_WDT_RESET_EN	0x1
> +
> +/* WDOGLOCK */
> +#define STARFIVE_WDT_LOCKED	BIT(0)
> +
> +/* WDOGINTCLR */
> +#define STARFIVE_WDT_INTCLR	0x1
> +
> +#define STARFIVE_WDT_ATBOOT	0x0
> +#define STARFIVE_WDT_MAXCNT	0xffffffff
> +
> +#define STARFIVE_WDT_DEFAULT_TIME	(15)
> +#define STARFIVE_WDT_DELAY_US		0
> +#define STARFIVE_WDT_TIMEOUT_US		10000
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +static int tmr_margin;
> +static int tmr_atboot = STARFIVE_WDT_ATBOOT;
> +static int soft_noboot;
> +
> +module_param(tmr_margin, int, 0);
> +module_param(tmr_atboot, int, 0);
> +module_param(nowayout, bool, 0);
> +module_param(soft_noboot, int, 0);
> +
> +MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. (default="
> +		 __MODULE_STRING(STARFIVE_WDT_DEFAULT_TIME) ")");

Use "timeout" or "heartbeat".

> +MODULE_PARM_DESC(tmr_atboot,
> +		 "Watchdog is started at boot time if set to 1, default="
> +		 __MODULE_STRING(STARFIVE_WDT_ATBOOT));

Use "early_enable"

> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +MODULE_PARM_DESC(soft_noboot,
> +		 "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");

I do not understand what this module parameter is supposed to be used for,
and what the "soft_' prefix is supposed to mean.

> +
> +struct starfive_wdt_variant {
> +	u32 control;
> +	u32 load;
> +	u32 enable;
> +	u32 value;
> +	u32 int_clr;
> +	u32 unlock;
> +	u32 unlock_key;
> +	u32 irq_is_raise;
> +	u8 enrst_shift;
> +	u8 en_shift;
> +};
> +
> +struct starfive_wdt {
> +	unsigned long freq;
> +	struct device *dev;
> +	struct watchdog_device wdt_device;
> +	struct clk *core_clk;
> +	struct clk *apb_clk;
> +	struct reset_control *rsts;
> +	const struct starfive_wdt_variant *drv_data;
> +	u32 count;	/*count of timeout*/
> +	u32 reload;	/*restore the count*/
> +	void __iomem *base;
> +	spinlock_t lock;	/* spinlock for register handling */
> +};
> +
> +#ifdef CONFIG_OF
> +/* Register bias in JH7110 */
> +static const struct starfive_wdt_variant drv_data_jh7110 = {
> +	.control = STARFIVE_WDT_JH7110_CONTROL,
> +	.load = STARFIVE_WDT_JH7110_LOAD,
> +	.enable = STARFIVE_WDT_JH7110_CONTROL,
> +	.value = STARFIVE_WDT_JH7110_VALUE,
> +	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
> +	.unlock = STARFIVE_WDT_JH7110_LOCK,
> +	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
> +	.irq_is_raise = STARFIVE_WDT_JH7110_IMS,
> +	.enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
> +	.en_shift = STARFIVE_WDT_JH7110_EN_SHIFT,
> +};
> +
> +static const struct of_device_id starfive_wdt_match[] = {
> +	{ .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, starfive_wdt_match);
> +#endif
> +
> +static const struct platform_device_id starfive_wdt_ids[] = {
> +	{
> +		.name = "starfive-jh7110-wdt",
> +		.driver_data = (unsigned long)&drv_data_jh7110,

This will fail to compile if CONFIG_OF=n.

> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, starfive_wdt_ids);
> +
> +static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
> +{
> +	if (!IS_ERR(wdt->core_clk)) {
> +		wdt->freq = clk_get_rate(wdt->core_clk);

wdt->freq can at least in theory be 0, which would
result in a zero-divide crash later on.

> +		return 0;
> +	}
> +	dev_err(wdt->dev, "get clock rate failed.\n");
> +
> +	return -ENOENT;

The above code can not be reached.

> +}
> +
> +static int starfive_wdt_enable_clock(struct starfive_wdt *wdt)
> +{
> +	int ret = 0;
> +
> +	wdt->apb_clk = devm_clk_get_enabled(wdt->dev, "apb");
> +	if (IS_ERR(wdt->apb_clk)) {
> +		dev_err(wdt->dev, "failed to get and enable apb clock.\n");
> +		ret = PTR_ERR(wdt->apb_clk);
> +		return ret;
> +	}
> +
> +	wdt->core_clk = devm_clk_get_enabled(wdt->dev, "core");
> +	if (IS_ERR(wdt->core_clk)) {
> +		dev_err(wdt->dev, "failed to get and enable core clock.\n");
> +		ret = PTR_ERR(wdt->core_clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
> +{
> +	int ret = 0;
> +
> +	wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
> +	if (!IS_ERR(wdt->rsts)) {

Error handling should come first, and return immediately.

> +		ret = reset_control_deassert(wdt->rsts);
> +		if (ret)
> +			dev_err(wdt->dev, "failed to deassert rsts.\n");
> +	} else {
> +		dev_err(wdt->dev, "failed to get rsts error.\n");
> +		ret = PTR_ERR(wdt->rsts);
> +	}
> +
> +	return ret;
> +}
> +
> +static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
> +{
> +	return DIV_ROUND_CLOSEST(ticks, wdt->freq);
> +}
> +
> +/*
> + * Write unlock-key to unlock. Write other value to lock. When lock bit is 1,
> + * external accesses to other watchdog registers are ignored.
> + */
> +static bool starfive_wdt_is_locked(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->unlock);
> +	return !!(val & STARFIVE_WDT_LOCKED);
> +}
> +
> +static void starfive_wdt_unlock(struct starfive_wdt *wdt)
> +{
> +	if (starfive_wdt_is_locked(wdt))
> +		writel(wdt->drv_data->unlock_key,
> +		       wdt->base + wdt->drv_data->unlock);
> +}
> +
> +static void starfive_wdt_lock(struct starfive_wdt *wdt)
> +{
> +	if (!starfive_wdt_is_locked(wdt))
> +		writel(~wdt->drv_data->unlock_key,
> +		       wdt->base + wdt->drv_data->unlock);
> +}
> +
> +/* enable watchdog interrupt to reset */
> +static void starfive_wdt_enable_reset(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->control);
> +	val |= STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift;
> +	writel(val, wdt->base + wdt->drv_data->control);
> +}
> +
> +/* disable watchdog interrupt to reset */
> +static void starfive_wdt_disable_reset(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->control);
> +	val &= ~(STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift);
> +	writel(val, wdt->base + wdt->drv_data->control);
> +}
> +
> +/* interrupt status whether has been raised from the counter */
> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
> +{
> +	return !!readl(wdt->base + wdt->drv_data->irq_is_raise);
> +}
> +
> +static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
> +{
> +	writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
> +}

There is no explanation for this interrupt handling (or, rather,
non-handling since there is no interrupt handler. What is the purpose
of even having all this code ?

> +
> +static inline void starfive_wdt_set_count(struct starfive_wdt *wdt, u32 val)
> +{
> +	writel(val, wdt->base + wdt->drv_data->load);
> +}
> +
> +static inline u32 starfive_wdt_get_count(struct starfive_wdt *wdt)
> +{
> +	return readl(wdt->base + wdt->drv_data->value);
> +}
> +
> +static inline void starfive_wdt_enable(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->enable);
> +	val |= STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift;
> +	writel(val, wdt->base + wdt->drv_data->enable);
> +}
> +
> +static inline void starfive_wdt_disable(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->enable);
> +	val &= ~(STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift);
> +	writel(val, wdt->base + wdt->drv_data->enable);
> +}
> +
> +static inline void starfive_wdt_set_reload_count(struct starfive_wdt *wdt, u32 count)
> +{
> +	starfive_wdt_set_count(wdt, count);
> +	/* need enable controller to reload counter */
> +	starfive_wdt_enable(wdt);
> +}
> +
> +static void starfive_wdt_mask_and_disable_reset(struct starfive_wdt *wdt, bool mask)
> +{
> +	starfive_wdt_unlock(wdt);
> +
> +	if (mask)
> +		starfive_wdt_disable_reset(wdt);
> +	else
> +		starfive_wdt_enable_reset(wdt);
> +
> +	starfive_wdt_lock(wdt);
> +}
> +
> +static unsigned int starfive_wdt_max_timeout(struct starfive_wdt *wdt)
> +{
> +	return DIV_ROUND_UP(STARFIVE_WDT_MAXCNT, wdt->freq) - 1;
> +}

For a frequency of 1 MHz, this results in a maximum timeout of 4294.

This value is then used in starfive_wdt_set_timeout(), but as
(4294 * 1000000) / 2, which is then again compared against
STARFIVE_WDT_MAXCNT. Somewhere this calculation is wrong.



> +
> +static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 count;
> +
> +	starfive_wdt_unlock(wdt);
> +	/*
> +	 * Because set half count value,
> +	 * timeleft value should add the count value before first timeout.
> +	 */
> +	count = starfive_wdt_get_count(wdt);
> +	if (!starfive_wdt_raise_irq_status(wdt))
> +		count += wdt->count;
> +
> +	starfive_wdt_lock(wdt);
> +
> +	return starfive_wdt_ticks_to_sec(wdt, count);
> +}
> +
> +static int starfive_wdt_keepalive(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);
> +
> +	starfive_wdt_unlock(wdt);
> +	starfive_wdt_int_clr(wdt);
> +	starfive_wdt_set_reload_count(wdt, wdt->count);
> +	starfive_wdt_lock(wdt);
> +
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);
> +
> +	starfive_wdt_unlock(wdt);
> +	starfive_wdt_int_clr(wdt);
> +	starfive_wdt_disable(wdt);
> +	starfive_wdt_lock(wdt);
> +
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	starfive_wdt_stop(wdd);
> +	pm_runtime_put(wdt->dev);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	pm_runtime_get_sync(wdt->dev);
> +
> +	spin_lock(&wdt->lock);
> +
> +	starfive_wdt_unlock(wdt);
> +
> +	if (soft_noboot)
> +		starfive_wdt_disable_reset(wdt);
> +	else
> +		starfive_wdt_enable_reset(wdt);
> +
> +	starfive_wdt_int_clr(wdt);
> +	starfive_wdt_set_count(wdt, wdt->count);
> +	starfive_wdt_enable(wdt);
> +
> +	starfive_wdt_lock(wdt);
> +
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_restart(struct watchdog_device *wdd, unsigned long action,
> +				void *data)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);
> +	starfive_wdt_unlock(wdt);
> +	/* disable watchdog, to be safe */
> +	starfive_wdt_disable(wdt);
> +
> +	if (soft_noboot)
> +		starfive_wdt_disable_reset(wdt);
> +	else
> +		starfive_wdt_enable_reset(wdt);
> +

This is a _restart_ handler. Disabling it doesn't make any sense.

> +	/* put native values into count */
> +	starfive_wdt_set_count(wdt, wdt->count);
> +
> +	/* set the watchdog to go and reset */
> +	starfive_wdt_int_clr(wdt);
> +	starfive_wdt_enable(wdt);
> +
> +	starfive_wdt_lock(wdt);
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
> +				    unsigned int timeout)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	unsigned long freq = wdt->freq;
> +	unsigned int count;
> +
> +	spin_lock(&wdt->lock);
> +
> +	if (timeout < wdt->wdt_device.min_timeout)
> +		return -EINVAL;

This is checked by the watchdog core.

> +
> +	/*
> +	 * This watchdog takes twice timeouts to reset.
> +	 * In order to reduce time to reset, should set half count value.
> +	 */
> +	count = timeout * freq / 2;
> +
> +	if (count > STARFIVE_WDT_MAXCNT) {

count is an unsigned int, which is pretty much everywhere a 32-bit
value. STARFIVE_WDT_MAXCNT is 0xffffffff. How is an unsigned integer
ever supposed to be larger than 0xffffffff ?

> +		dev_warn(wdt->dev, "timeout %d too big,use the MAX-timeout set.\n",
> +			 timeout);
> +		timeout = starfive_wdt_max_timeout(wdt);
> +		count = timeout * freq;

This is confusing. First, the timeout range is checked by the calling code,
which makes sure it is never larger than max_timeout. max_timeout is
set to the value returned by starfive_wdt_max_timeout().
Thus, count = timeout * freq / 2 will _never_ be larger than
STARFIVE_WDT_MAXCNT. Even if it ever was, it doesn't make sense
to use a count value of timeout * freq in that case, ie a value which
could be twice as large as the supposed maximum value.

> +	}
> +
> +	dev_info(wdt->dev, "Heartbeat: timeout=%d, count/2=%d (%08x)\n",
> +		 timeout, count, count);

No. Drop such noise. Make it a debug message if you think you need it.

> +
> +	starfive_wdt_unlock(wdt);
> +	starfive_wdt_disable(wdt);
> +	starfive_wdt_set_reload_count(wdt, count);
> +	starfive_wdt_enable(wdt);
> +	starfive_wdt_lock(wdt);
> +
> +	wdt->count = count;
> +	wdd->timeout = timeout;
> +
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> +
> +static const struct watchdog_info starfive_wdt_ident = {
> +	.options = OPTIONS,
> +	.firmware_version = 0,

It is not necessary to initilize a static variable with 0.

> +	.identity = "StarFive Watchdog",
> +};
> +
> +static const struct watchdog_ops starfive_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = starfive_wdt_start,
> +	.stop = starfive_wdt_pm_stop,
> +	.ping = starfive_wdt_keepalive,
> +	.set_timeout = starfive_wdt_set_timeout,
> +	.restart = starfive_wdt_restart,
> +	.get_timeleft = starfive_wdt_get_timeleft,
> +};
> +
> +static const struct watchdog_device starfive_wdd = {
> +	.info = &starfive_wdt_ident,
> +	.ops = &starfive_wdt_ops,
> +	.timeout = STARFIVE_WDT_DEFAULT_TIME,
> +};
> +
> +static inline const struct starfive_wdt_variant *
> +starfive_wdt_get_drv_data(struct platform_device *pdev)
> +{
> +	const struct starfive_wdt_variant *variant;
> +
> +	variant = of_device_get_match_data(&pdev->dev);
> +	if (!variant) {
> +		/* Device matched by platform_device_id */
> +		variant = (struct starfive_wdt_variant *)
> +			   platform_get_device_id(pdev)->driver_data;
> +	}
> +
> +	return variant;
> +}
> +
> +static int starfive_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct starfive_wdt *wdt;
> +	int started = 0;

What is this variable supposed to be used for ? It is alway 0.

> +	int ret;
> +
> +	pm_runtime_enable(dev);
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->dev = dev;
> +	spin_lock_init(&wdt->lock);
> +	wdt->wdt_device = starfive_wdd;
> +
> +	wdt->drv_data = starfive_wdt_get_drv_data(pdev);
> +
> +	/* get the memory region for the watchdog timer */
> +	wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(wdt->base)) {
> +		ret = PTR_ERR(wdt->base);
> +		return ret;
> +	}
> +
> +	ret = starfive_wdt_enable_clock(wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = starfive_wdt_get_clock_rate(wdt);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = starfive_wdt_reset_init(wdt);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	wdt->wdt_device.min_timeout = 1;
> +	wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
> +
> +	watchdog_set_drvdata(&wdt->wdt_device, wdt);
> +
> +	/*
> +	 * see if we can actually set the requested timer margin,
> +	 * and if not, try the default value.
> +	 */
> +	watchdog_init_timeout(&wdt->wdt_device, tmr_margin, dev);
> +
> +	ret = starfive_wdt_set_timeout(&wdt->wdt_device,
> +				       wdt->wdt_device.timeout);
> +	if (ret) {
> +		dev_err(dev, "tmr_margin value out of range, default %d used\n",
> +			STARFIVE_WDT_DEFAULT_TIME);
> +		starfive_wdt_set_timeout(&wdt->wdt_device,
> +					 STARFIVE_WDT_DEFAULT_TIME);
> +	}
> +
> +	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
> +	watchdog_set_restart_priority(&wdt->wdt_device, 128);
> +	watchdog_stop_on_reboot(&wdt->wdt_device);
> +	watchdog_stop_on_unregister(&wdt->wdt_device);
> +
> +	wdt->wdt_device.parent = dev;
> +
> +	ret = watchdog_register_device(&wdt->wdt_device);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	starfive_wdt_mask_and_disable_reset(wdt, false);
> +
> +	if (tmr_atboot && started == 0) {
> +		starfive_wdt_start(&wdt->wdt_device);
> +	} else if (!tmr_atboot) {
> +		/*
> +		 *if we're not enabling the watchdog, then ensure it is
> +		 * disabled if it has been left running from the bootloader
> +		 * or other source.
> +		 */
> +		starfive_wdt_stop(&wdt->wdt_device);

If it _is_ running from the boot loader, the watchdog core is not
informed about it. If it is started here, it is not informed either.
This is unusual and will need to be explained.
Why ?

> +	}
> +
> +#ifdef CONFIG_PM
> +	clk_disable_unprepare(wdt->core_clk);
> +	clk_disable_unprepare(wdt->apb_clk);
> +#endif

I do not understand the above code. Why stop the watchdog if CONFIG_PM
is enabled, even if it is supposed to be running ?

> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(wdt->core_clk);
> +	clk_disable_unprepare(wdt->apb_clk);
> +
> +	return ret;
> +}
> +
> +static int starfive_wdt_remove(struct platform_device *dev)
> +{
> +	struct starfive_wdt *wdt = platform_get_drvdata(dev);
> +
> +	starfive_wdt_mask_and_disable_reset(wdt, true);
> +	watchdog_unregister_device(&wdt->wdt_device);
> +
> +	clk_disable_unprepare(wdt->core_clk);
> +	clk_disable_unprepare(wdt->apb_clk);
> +	pm_runtime_disable(wdt->dev);
> +
> +	return 0;
> +}
> +
> +static void starfive_wdt_shutdown(struct platform_device *dev)
> +{
> +	struct starfive_wdt *wdt = platform_get_drvdata(dev);
> +
> +	starfive_wdt_mask_and_disable_reset(wdt, true);
> +
> +	starfive_wdt_pm_stop(&wdt->wdt_device);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int starfive_wdt_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> +
> +	starfive_wdt_unlock(wdt);
> +
> +	/* Save watchdog state, and turn it off. */
> +	wdt->reload = starfive_wdt_get_count(wdt);
> +
> +	starfive_wdt_mask_and_disable_reset(wdt, true);
> +
> +	/* Note that WTCNT doesn't need to be saved. */
> +	starfive_wdt_stop(&wdt->wdt_device);
> +	pm_runtime_force_suspend(dev);
> +
> +	starfive_wdt_lock(wdt);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_resume(struct device *dev)
> +{
> +	int ret;
> +	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> +
> +	starfive_wdt_unlock(wdt);
> +
> +	pm_runtime_force_resume(dev);
> +
> +	/* Restore watchdog state. */
> +	starfive_wdt_set_reload_count(wdt, wdt->reload);
> +
> +	starfive_wdt_restart(&wdt->wdt_device, 0, NULL);

I do not understand this call. Per its definition it is a restart handler,
supposed to restart the hardware. Why would anyone want to restart the
system on resume ?

> +
> +	starfive_wdt_mask_and_disable_reset(wdt, false);
> +
> +	starfive_wdt_lock(wdt);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +#ifdef CONFIG_PM
> +static int starfive_wdt_runtime_suspend(struct device *dev)
> +{
> +	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(wdt->apb_clk);
> +	clk_disable_unprepare(wdt->core_clk);
> +
> +	return 0;
> +}
> +
> +static int starfive_wdt_runtime_resume(struct device *dev)
> +{
> +	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(wdt->apb_clk);
> +	if (ret) {
> +		dev_err(wdt->dev, "failed to enable apb_clk.\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(wdt->core_clk);
> +	if (ret)
> +		dev_err(wdt->dev, "failed to enable core_clk.\n");
> +
> +	return ret;
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops starfive_wdt_pm_ops = {
> +	SET_RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
> +};
> +
> +static struct platform_driver starfive_wdt_driver = {
> +	.probe		= starfive_wdt_probe,
> +	.remove		= starfive_wdt_remove,
> +	.shutdown	= starfive_wdt_shutdown,
> +	.id_table	= starfive_wdt_ids,
> +	.driver		= {
> +		.name	= "starfive-wdt",
> +		.pm	= &starfive_wdt_pm_ops,
> +		.of_match_table = of_match_ptr(starfive_wdt_match),
> +	},
> +};
> +
> +module_platform_driver(starfive_wdt_driver);
> +
> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> +MODULE_AUTHOR("Samin Guo <samin.guo@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive Watchdog Device Driver");
> +MODULE_LICENSE("GPL v2");
