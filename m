Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D56408F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiLBPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:08:13 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266274F1AC;
        Fri,  2 Dec 2022 07:08:11 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142306beb9aso5837107fac.11;
        Fri, 02 Dec 2022 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3lcRifTXi35bJpfB4wV3rU8ZAWGWLYgqHVfTxaBJHw=;
        b=Pd7MqMIXBxNZJZ7pwKJQkbAtEc0CPOS8fUO+OmyPVRs7JcrwYlgT/3i4eWMe6X92Ac
         w7bUnG/kbuwB8qNnb/15aY8ntyCSfzPFa5LxP9NQ8sP3Ij1D/vSaAmCb/6r4Nr4S+kXk
         qJWVMzuGi9vwIudp39yghufTYdk6QO0K+mjCYtOvepHb6cZ+y9fEpIZ9doI3HrukjpM5
         /8YsypJL4ujyie1/IGJ68199HhmfemgWi74G99ZDM4NxMBkzBQS9+eRa0IT4+jhmJQ6d
         Ged5uqWRNuq0hr9cElzpY68H2FeLBiJM41StYVKUkvR6O5PkyWLmFQ6vHzF+GNHFkXuS
         BFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3lcRifTXi35bJpfB4wV3rU8ZAWGWLYgqHVfTxaBJHw=;
        b=ETX2hQxEO6cgtHJD/QwwPku3NWCM+o8q/tLEKObjbVsKJkJ3nQJbVKCqGaeXEXpHnQ
         rY09UYPmpv5Chs7PFSi+GKRq4/c6G7eAojyMn3zpxO2/X5WiyjsOpOUW6eDZEkWbGIaM
         tmboFCBduyOtG5UfVargcbj1K6xpNdjNLXKUg2Kw+tQYpqGQUYt1uopdGRKluRV3gRaC
         7/jre43asa99wWVOMgPRDjdCztIawFRDAPMWTikoKv2yJ9atylffu9m6lb4QeRfLGrNE
         qZ35bC6x6ZJZ0Tdg9MjAKtZnuek0WQJWX5n8iQNQB6P3phk95xhKOLXsIB1yWQNYE7dG
         nD7A==
X-Gm-Message-State: ANoB5pmenRmP8vodogfW8261yZHiKf1CIRGKoxRvH+AsSSBZct42/EZu
        Ug+buvlLz1+LBcg6iWh6zhY=
X-Google-Smtp-Source: AA0mqf4QXpNkdmOywEtZVN8AXe2uQrMb76WRibuh/tkeX8ln+VKla+PijojiDGVRpSOIJQ4p+iJd/g==
X-Received: by 2002:a05:6871:4703:b0:142:81e3:e9b5 with SMTP id py3-20020a056871470300b0014281e3e9b5mr32654918oab.26.1669993690145;
        Fri, 02 Dec 2022 07:08:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w64-20020aca6243000000b0035ba52d0efasm3138086oib.52.2022.12.02.07.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:08:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <89587e87-c4f2-da05-ccbd-336bbe93d44c@roeck-us.net>
Date:   Fri, 2 Dec 2022 07:08:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "xingu.wu" <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
 <20221202093943.149674-3-xingyu.wu@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 2/3] drivers: watchdog: Add StarFive Watchdog driver
In-Reply-To: <20221202093943.149674-3-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 01:39, xingu.wu wrote:
> From: Xingyu Wu <xingyu.wu@starfivetech.com>
> 
> Add watchdog driver for the StarFive JH7110 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>   MAINTAINERS                     |   7 +
>   drivers/watchdog/Kconfig        |  11 +
>   drivers/watchdog/Makefile       |   3 +
>   drivers/watchdog/starfive-wdt.c | 854 ++++++++++++++++++++++++++++++++
>   4 files changed, 875 insertions(+)
>   create mode 100644 drivers/watchdog/starfive-wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a70c1d0f303e..133214dd2f60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19623,6 +19623,13 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>   F:	drivers/reset/starfive/
>   F:	include/dt-bindings/reset/starfive*
>   
> +STARFIVE WATCHDOG DRIVER
> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
> +M:	Samin Guo <samin.guo@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/watchdog/starfive*
> +F:	drivers/watchdog/starfive-wdt.c
> +
>   STATIC BRANCH/CALL
>   M:	Peter Zijlstra <peterz@infradead.org>
>   M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b64bc49c7f30..658fc9fef4fa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2082,6 +2082,17 @@ config UML_WATCHDOG
>   	tristate "UML watchdog"
>   	depends on UML || COMPILE_TEST
>   
> +# RISCV Architecture
> +
> +config STARFIVE_WATCHDOG
> +	tristate "StarFive Watchdog support"
> +	depends on RISCV
> +	select WATCHDOG_CORE
> +	default SOC_STARFIVE
> +	help
> +	  Say Y here to support the StarFive watchdog. This driver can also
> +	  be built as a module if choose M.
> +
>   #
>   # ISA-based Watchdog Cards
>   #
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index d41e5f830ae7..9c22f1a43d5c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -210,6 +210,9 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
>   # Xen
>   obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>   
> +# RISCV Architecture
> +obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
> +
>   # Architecture Independent
>   obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> new file mode 100644
> index 000000000000..dcb6e693ba6c
> --- /dev/null
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -0,0 +1,854 @@
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
> +
> +/* JH7110 WatchDog register define */
> +#define STARFIVE_WDT_JH7110_LOAD	0x000	/* RW: Watchdog load register */
> +#define STARFIVE_WDT_JH7110_VALUE	0x004	/* RO: The current value for the watchdog counter */
> +#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
> +						 * RW: [0]: reset enable;
> +						 * [1]: int enable/wdt enable/reload counter;
> +						 * [31:2]: res.
> +						 */
> +#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* WO: clear intterupt && reload the counter */
> +#define STARFIVE_WDT_JH7110_RIS		0x010	/* RO: Raw interrupt status from the counter */
> +#define STARFIVE_WDT_JH7110_IMS		0x014	/* RO: Enabled interrupt status from the counter */
> +#define STARFIVE_WDT_JH7110_LOCK	0xc00	/*
> +						 * RO: Enable write access to all other registers
> +						 * by writing 0x1ACCE551.
> +						 */
> +#define STARFIVE_WDT_JH7110_ITCR	0xf00	/*
> +						 * RW: When set HIGH,
> +						 * places the Watchdog into integraeion test mode.\\intetration

> +						 */
> +#define STARFIVE_WDT_JH7110_ITOP	0xf04	/*
> +						 * WO: [0] WDOGRES value Integration Test Mode.
> +						 * Value output on WDOGRES when in
> +						 * Integration Test Mode.
> +						 * [1] Integration Test WDOGINT value.
> +						 * Value output on WDOGINT when in
> +						 * Integration Test Mode.
> +						 */
> +
> +#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
> +#define STARFIVE_WDT_JH7110_RESEN_SHIFT		1
> +#define STARFIVE_WDT_JH7110_EN_SHIFT		0
> +#define STARFIVE_WDT_JH7110_INT_EN_SHIFT	STARFIVE_WDT_JH7110_EN_SHIFT
> +
> +/* WDOGCONTROL */
> +#define STARFIVE_WDT_INT_EN	0x0
> +#define STARFIVE_WDT_INT_DIS	BIT(0)
> +#define STARFIVE_WDT_RESET_EN	0x1
> +
> +/* WDOGLOCK */
> +#define STARFIVE_WDT_LOCKED	BIT(0)
> +
> +#define STARFIVE_WDT_INTCLR	0x1
> +#define STARFIVE_WDT_ENABLE	0x1
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
> +MODULE_PARM_DESC(tmr_atboot,
> +		 "Watchdog is started at boot time if set to 1, default="
> +		 __MODULE_STRING(STARFIVE_WDT_ATBOOT));
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +MODULE_PARM_DESC(soft_noboot,
> +		 "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");
> +
> +struct starfive_wdt_variant_t {
> +	u32 unlock_key;
> +	u8 enrst_shift;
> +	u8 en_shift;
> +	u8 intclr_check;
> +	u8 intclr_ava_shift;
> +};
> +
> +struct starfive_wdt_variant {
> +	u32 control;
> +	u32 load;
> +	u32 enable;
> +	u32 reload;
> +	u32 value;
> +	u32 int_clr;
> +	u32 int_mask;
> +	u32 unlock;
> +	u32 enter_irq_status;
> +	struct starfive_wdt_variant_t *variant;
> +};
> +
> +struct starfive_wdt {
> +	u64 freq;

clk_get_rate() returns unsigned long. Why would u64 be needed here ?

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
> +
> +	int irq;
> +};
> +
> +#ifdef CONFIG_OF
> +static struct starfive_wdt_variant_t jh7110_variant = {
> +	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
> +	.enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
> +	.en_shift = STARFIVE_WDT_JH7110_EN_SHIFT,
> +};
> +
> +static const struct starfive_wdt_variant drv_data_jh7110 = {
> +	.control = STARFIVE_WDT_JH7110_CONTROL,
> +	.load = STARFIVE_WDT_JH7110_LOAD,
> +	.enable = STARFIVE_WDT_JH7110_CONTROL,
> +	.value = STARFIVE_WDT_JH7110_VALUE,
> +	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
> +	.unlock = STARFIVE_WDT_JH7110_LOCK,
> +	.enter_irq_status = STARFIVE_WDT_JH7110_IMS,
> +	.variant = &jh7110_variant,
> +};
> +

If there is no specific reason for all that complexity, drop it and introduce
it if/when necessary.

> +static const struct of_device_id starfive_wdt_match[] = {
> +	{ .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, starfive_wdt_match);
> +#endif
> +
> +static const struct platform_device_id starfive_wdt_ids[] = {
> +	{
> +		.name = "starfive-wdt",
> +		.driver_data = (unsigned long)&drv_data_jh7110,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, starfive_wdt_ids);
> +
> +static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
> +{
> +	int ret;
> +	u32 freq;
> +
> +	if (!IS_ERR(wdt->core_clk)) {
> +		wdt->freq = clk_get_rate(wdt->core_clk);
> +		return 0;
> +	}
> +	dev_dbg(wdt->dev, "get rate failed, need clock-frequency define in dts.\n");
> +
> +	/* Next we try to get clock-frequency from dts.*/
> +	ret = of_property_read_u32(wdt->dev->of_node, "clock-frequency", &freq);
> +	if (!ret) {
> +		wdt->freq = (u64)freq;

Unnecessary typecast.

> +		return 0;
> +	}
> +	dev_err(wdt->dev, "get clock-frequency failed\n");
> +
> +	return -ENOENT;
> +}

I have never seen this kind of code before. Why would it be needed ?

> +
> +static int starfive_wdt_enable_clock(struct starfive_wdt *wdt)
> +{
> +	int ret = 0;
> +
> +	wdt->apb_clk = devm_clk_get(wdt->dev, "apb_clk");
> +	if (!IS_ERR(wdt->apb_clk)) {
> +		ret = clk_prepare_enable(wdt->apb_clk);
> +		if (ret) {
> +			dev_err(wdt->dev, "failed to enable apb_clk.\n");
> +			goto err;
> +		}
> +	} else {
> +		dev_err(wdt->dev, "failed to get apb_clk.\n");
> +		ret = PTR_ERR(wdt->apb_clk);
> +		goto err;
> +	}

Why not use devm_clk_get_enabled() ?

> +
> +	wdt->core_clk = devm_clk_get(wdt->dev, "core_clk");
> +	if (!IS_ERR(wdt->core_clk)) {
> +		ret = clk_prepare_enable(wdt->core_clk);
> +		if (ret) {
> +			dev_err(wdt->dev, "failed to enable core_clk.\n");
> +			goto err;
> +		}
> +	} else {
> +		dev_err(wdt->dev, "failed to get core_clk.\n");
> +		ret = PTR_ERR(wdt->core_clk);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	return ret;

Unnecessary. Return directly.

> +}
> +
> +static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
> +{
> +	int ret = 0;
> +
> +	wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
> +	if (!IS_ERR(wdt->rsts)) {
> +		ret = reset_control_deassert(wdt->rsts);
> +		if (ret) {
> +			dev_err(wdt->dev, "failed to deassert rsts.\n");
> +			goto err;
> +		}
> +	} else {
> +		dev_err(wdt->dev, "failed to get rsts error.\n");

failed ... error is redundant. Drop "errror".

> +		ret = PTR_ERR(wdt->rsts);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	return ret;

Unnecessary. Return directly.

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
> +static int starfive_wdt_is_locked(struct starfive_wdt *wdt)

bool ?

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
> +		writel(wdt->drv_data->variant->unlock_key,
> +		       wdt->base + wdt->drv_data->unlock);
> +}
> +
> +static void starfive_wdt_lock(struct starfive_wdt *wdt)
> +{
> +	if (!starfive_wdt_is_locked(wdt))
> +		writel(~wdt->drv_data->variant->unlock_key,
> +		       wdt->base + wdt->drv_data->unlock);
> +}
> +
> +/* enable watchdog interrupt */
> +static inline void starfive_wdt_int_enable(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	if (wdt->drv_data->int_mask) {
> +		val = readl(wdt->base + wdt->drv_data->int_mask);
> +		val &= ~STARFIVE_WDT_INT_DIS;
> +		writel(val, wdt->base + wdt->drv_data->int_mask);
> +	}
> +}
> +
> +/* disable watchdog interrupt */
> +static inline void starfive_wdt_int_disable(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	if (wdt->drv_data->int_mask) {
> +		val = readl(wdt->base + wdt->drv_data->int_mask);
> +		val |= STARFIVE_WDT_INT_DIS;
> +		writel(val, wdt->base + wdt->drv_data->int_mask);
> +	}
> +}
> +
> +/* enable watchdog interrupt to reset */
> +static void starfive_wdt_enable_reset(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->control);
> +	val |= STARFIVE_WDT_RESET_EN << wdt->drv_data->variant->enrst_shift;
> +	writel(val, wdt->base + wdt->drv_data->control);
> +}
> +
> +/* disable watchdog interrupt to reset */
> +static void starfive_wdt_disable_reset(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->control);
> +	val &= ~(STARFIVE_WDT_RESET_EN << wdt->drv_data->variant->enrst_shift);
> +	writel(val, wdt->base + wdt->drv_data->control);
> +}
> +
> +/* interrupt status whether has been raised from the counter */
> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
> +{
> +	return !!readl(wdt->base + wdt->drv_data->enter_irq_status);
> +}
> +
> +static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
> +{
> +	void __iomem *addr;
> +	u8 clr_check;
> +	u8 clr_ava_shift;
> +	u32 value;
> +	int ret = 0;
> +
> +	addr = wdt->base + wdt->drv_data->int_clr;
> +	clr_ava_shift = wdt->drv_data->variant->intclr_ava_shift;
> +	clr_check = wdt->drv_data->variant->intclr_check;
> +	if (clr_check) {
> +		/* waiting interrupt can be to clearing */
> +		value = readl(addr);
> +		ret = readl_poll_timeout_atomic(addr, value,
> +						!(value & BIT(clr_ava_shift)),
> +						STARFIVE_WDT_DELAY_US, STARFIVE_WDT_TIMEOUT_US);
> +	}
> +
> +	if (!ret)
> +		writel(STARFIVE_WDT_INTCLR, addr);
> +
> +	if (starfive_wdt_raise_irq_status(wdt))
> +		enable_irq(wdt->irq);
> +}
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
> +	val |= STARFIVE_WDT_ENABLE << wdt->drv_data->variant->en_shift;
> +	writel(val, wdt->base + wdt->drv_data->enable);
> +}
> +
> +static inline void starfive_wdt_disable(struct starfive_wdt *wdt)
> +{
> +	u32 val;
> +
> +	val = readl(wdt->base + wdt->drv_data->enable);
> +	val &= ~(STARFIVE_WDT_ENABLE << wdt->drv_data->variant->en_shift);
> +	writel(val, wdt->base + wdt->drv_data->enable);
> +}
> +
> +static inline void starfive_wdt_set_relod_count(struct starfive_wdt *wdt, u32 count)
> +{
> +	writel(count, wdt->base + wdt->drv_data->load);
> +	if (wdt->drv_data->reload)
> +		writel(0x1, wdt->base + wdt->drv_data->reload);
> +	else
> +		/* jh7110 need enable controller to reload counter */
> +		starfive_wdt_enable(wdt);
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
> +
> +static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +	u32 count;
> +	u32 irq_status;
> +
> +	starfive_wdt_unlock(wdt);
> +	/*
> +	 * Because set half count value,
> +	 * timeleft value should add the count value before first timeout.
> +	 */
> +	irq_status = starfive_wdt_raise_irq_status(wdt) ? 1 : 0;
> +	count = starfive_wdt_get_count(wdt) + (1 - irq_status) * wdt->count;
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
> +	starfive_wdt_set_relod_count(wdt, wdt->count);
> +	starfive_wdt_lock(wdt);
> +
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t starfive_wdt_interrupt_handler(int irq, void *data)
> +{
> +	/*
> +	 * We don't clear the IRQ status. It's supposed to be done by the
> +	 * following ping operations.
> +	 */
> +	struct platform_device *pdev = data;
> +	struct starfive_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	/* Disable the IRQ and avoid re-entry interrupt. */
> +	disable_irq_nosync(wdt->irq);
> +
> +	return IRQ_HANDLED;
> +}

What is the purpose of this interrupt ? It doesn't add any value
as implemented.

> +
> +static int starfive_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);
> +
> +	starfive_wdt_unlock(wdt);
> +	starfive_wdt_int_disable(wdt);
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
> +	starfive_wdt_int_enable(wdt);
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
> +	/* put initial values into count and data */
> +	starfive_wdt_set_count(wdt, wdt->count);

This is supposed to reset the system. Why write wdt->count
instead of 0 or 1 ?

> +
> +	/* set the watchdog to go and reset... */
> +	starfive_wdt_int_clr(wdt);
> +	starfive_wdt_int_enable(wdt);
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
> +	if (timeout < 1)
> +		return -EINVAL;

Can not happen if configured properly, ie if min_timeout is set *which it is).

> +
> +	/*
> +	 * This watchdog takes twice timeouts to reset.
> +	 * In order to reduce time to reset, should set half count value.
> +	 */
> +	count = timeout * freq / 2;
> +
> +	if (count > STARFIVE_WDT_MAXCNT) {
> +		dev_warn(wdt->dev, "timeout %d too big,use the MAX-timeout set.\n",
> +			 timeout);
> +		timeout = starfive_wdt_max_timeout(wdt);
> +		count = timeout * freq;
> +	}
> +
> +	dev_info(wdt->dev, "Heartbeat: timeout=%d, count/2=%d (%08x)\n",
> +		 timeout, count, count);
> +
> +	starfive_wdt_unlock(wdt);
> +	starfive_wdt_disable(wdt);
> +	starfive_wdt_set_relod_count(wdt, count);
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
> +	wdt->irq = platform_get_irq(pdev, 0);
> +	if (wdt->irq < 0) {
> +		dev_err(dev, "can not find irq.\n");
> +		return wdt->irq;
> +	}
> +
> +	/* get the memory region for the watchdog timer */
> +	wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(wdt->base)) {
> +		ret = PTR_ERR(wdt->base);
> +		goto err;
> +	}
> +
> +	ret = starfive_wdt_enable_clock(wdt);
> +	if (ret)
> +		goto err;
> +
> +	starfive_wdt_get_clock_rate(wdt);
> +

This can fail, leaving the clock rate uninitialized.

> +	ret = starfive_wdt_reset_init(wdt);
> +	if (ret)
> +		goto err;
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
> +	ret = devm_request_irq(dev, wdt->irq, starfive_wdt_interrupt_handler, 0,
> +			       pdev->name, pdev);
> +	if (ret != 0) {
> +		dev_err(dev, "failed to install irq (%d)\n", ret);
> +		goto err;
> +	}
> +

That interrupt seems pointless.

> +	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
> +	watchdog_set_restart_priority(&wdt->wdt_device, 128);
> +
> +	wdt->wdt_device.parent = dev;
> +
> +	ret = watchdog_register_device(&wdt->wdt_device);
> +	if (ret)
> +		goto err;
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
> +	}

This should be done before registering the watdhdog, and the watchdog core
should be informed if the watchdog is running.

> +
> +#ifdef CONFIG_PM
> +	clk_disable_unprepare(wdt->core_clk);
> +	clk_disable_unprepare(wdt->apb_clk);
> +#endif
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	return 0;
> +
> +err:
> +	return ret;

This is never acceptable. Return directly.

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

This is potentially unbalanced. I would suggest to use
watchdog_stop_on_unregister().

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

Use watchdog_stop_on_reboot().

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
> +	starfive_wdt_set_relod_count(wdt, wdt->reload);
> +
> +	starfive_wdt_restart(&wdt->wdt_device, 0, NULL);
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
> +		goto err;
> +	}
> +
> +	ret = clk_prepare_enable(wdt->core_clk);
> +	if (ret) {
> +		dev_err(wdt->dev, "failed to enable core_clk.\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
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

