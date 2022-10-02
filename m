Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7D5F2414
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJBQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:25:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE331367;
        Sun,  2 Oct 2022 09:25:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so13297941pjs.4;
        Sun, 02 Oct 2022 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=oIn28/zhO4sKgPD/Pi6S7yQmG5pQOXj6/mPd9b8Z+k4=;
        b=QYqXoZelE4SDcWIBSbnNj3gvTxN1hR3fz0gVtRZohReHdChc+izu55x0Px17LW1auu
         tL/43/vquxflfnadyGTCG0bxsP7IFooM39lmYwpCS3207FRxiVay0w4MhDffcwcIZwCq
         hVYqgo016QlXkB/574+BWBLI379NuJY6xUTGUQIb/WLETjJ1xcFm2cCHtwA3oCzC32fd
         N9rWJn43QagEoOr4ZG8uOdUFVuGvLSssLQ2wy7S+QY38uKJ4tsktfPsk36qvR5mpGtHG
         odvFeHwXveTING3w97BBm2b/m5aWiz4KMDTd3iBqlOzfokluhfKdqmsEIAqJmismYeGo
         tGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oIn28/zhO4sKgPD/Pi6S7yQmG5pQOXj6/mPd9b8Z+k4=;
        b=kbfKTZo3RwtwwZMV8C2lzstIQ4F4hqNdwXZ8F4sgfiZTug1PMwLHOfYmMiGMn7QvWL
         NWu6Lzx0eh2u7ryN2LcuB++Cr3yCbB/9WIfc92ij/pjcG6hysdp2XqVQFpGN5bld+17A
         DZITO4qWeuwpibshMCW361G1vfTg1cnaTUDGrbj5Mu/+sDf12N0Tqfj83M40715DMJou
         5Y/FWdBEKLWCL+JrWOWK0Wd5UNuhz+xmgSvPke9gRFWIOoEqbeogEbn0BsU6mvrH41XX
         PZBkqoAZVwthiDYDq712U4drZYQqCDWeaPR9gfG+ErGMXk3s5gi2CZWgWtDLr2GStAUp
         cz8w==
X-Gm-Message-State: ACrzQf05VCuXxDNVhEIXyoW2I6fHcYsP2NQAydfcmMPd5vPqzMzagHv/
        qXOQMME0+MzYjLHM+EY+ISQ=
X-Google-Smtp-Source: AMsMyM4c56/sPWXIxzGkt9hIjWQnCGICCo8+PCe1aaWz3arFf4Flhsffsuah+P6fgKJVuZXvK8B8MQ==
X-Received: by 2002:a17:90b:1d81:b0:203:6c1e:5a29 with SMTP id pf1-20020a17090b1d8100b002036c1e5a29mr8262993pjb.0.1664727930862;
        Sun, 02 Oct 2022 09:25:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v124-20020a622f82000000b005365aee486bsm5629725pfv.192.2022.10.02.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 09:25:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 2 Oct 2022 09:25:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     wim@linux-watchdog.org, shubhrajyoti.datta@amd.com,
        michal.simek@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Message-ID: <20221002162528.GA2900147@roeck-us.net>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927110257.41963-3-srinivas.neeli@amd.com>
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

On Tue, Sep 27, 2022 at 04:32:56PM +0530, Srinivas Neeli wrote:
> Versal watchdog driver uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and a
> period that is not too late. The WWDT has to be restarted within
> the open window time. If software tries to restart WWDT outside of
> the open window time period, it generates a reset.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
>  drivers/watchdog/Kconfig       |  17 ++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/xilinx_wwdt.c | 286 +++++++++++++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 drivers/watchdog/xilinx_wwdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 688922fc4edb..9822e471b9f0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -304,6 +304,23 @@ config XILINX_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called of_xilinx_wdt.
>  
> +config XILINX_WINDOW_WATCHDOG
> +	tristate "Xilinx window watchdog timer"
> +	depends on HAS_IOMEM
> +	select WATCHDOG_CORE
> +	help
> +	  Window watchdog driver for the versal_wwdt ip core.
> +	  Window watchdog timer(WWDT) contains closed(first) and
> +	  open(second) window with 32 bit width. Write to the watchdog
> +	  timer within predefined window periods of time. This means
> +	  a period that is not too soon and a period that is not too
> +	  late. The WWDT has to be restarted within the open window time.
> +	  If software tries to restart WWDT outside of the open window
> +	  time period, it generates a reset.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called xilinx_wwdt.
> +
>  config ZIIRAVE_WATCHDOG
>  	tristate "Zodiac RAVE Watchdog Timer"
>  	depends on I2C
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index cdeb119e6e61..4ff96c517407 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
>  
>  # MicroBlaze Architecture
>  obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
> +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
>  
>  # MIPS Architecture
>  obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
> diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> new file mode 100644
> index 000000000000..2594a01c2764
> --- /dev/null
> +++ b/drivers/watchdog/xilinx_wwdt.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Window watchdog device driver for Xilinx Versal WWDT
> + *
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/watchdog.h>
> +
> +#define XWWDT_DEFAULT_TIMEOUT	40
> +#define XWWDT_MIN_TIMEOUT	1
> +#define XWWDT_MAX_TIMEOUT	42
> +
> +/* Register offsets for the WWDT device */
> +#define XWWDT_MWR_OFFSET	0x00
> +#define XWWDT_ESR_OFFSET	0x04
> +#define XWWDT_FCR_OFFSET	0x08
> +#define XWWDT_FWR_OFFSET	0x0c
> +#define XWWDT_SWR_OFFSET	0x10
> +
> +/* Master Write Control Register Masks */
> +#define XWWDT_MWR_MASK		BIT(0)
> +
> +/* Enable and Status Register Masks */
> +#define XWWDT_ESR_WINT_MASK	BIT(16)
> +#define XWWDT_ESR_WSW_MASK	BIT(8)
> +#define XWWDT_ESR_WEN_MASK	BIT(0)
> +
> +#define XWWDT_PERCENT		50
> +
> +static int xwwdt_timeout;
> +static int xclosed_window_percent;
> +
> +module_param(xwwdt_timeout, int, 0644);
> +MODULE_PARM_DESC(xwwdt_timeout,
> +		 "Watchdog time in seconds. (default="
> +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");

There is no reason to make this writeable. There are means to set the
timeout in runtime. Those should be used.

> +module_param(xclosed_window_percent, int, 0644);
> +MODULE_PARM_DESC(xclosed_window_percent,
> +		 "Watchdog closed window percentage. (default="
> +		 __MODULE_STRING(XWWDT_PERCENT) ")");

The above is problematic. This should really not be set during runtime,
and the behavior is pretty much undefined if it is changed while the
watchdog is running. It should really be set using devicetree and not
be changed in the running system.

> +
> +/**
> + * struct xwwdt_device - Watchdog device structure
> + * @base: base io address of WDT device
> + * @spinlock: spinlock for IO register access
> + * @xilinx_wwdt_wdd: watchdog device structure
> + * @clk: struct clk * of a clock source
> + * @freq: source clock frequency of WWDT
> + */
> +struct xwwdt_device {
> +	void __iomem *base;
> +	spinlock_t spinlock; /* spinlock for register handling */
> +	struct watchdog_device xilinx_wwdt_wdd;
> +	struct clk *clk;
> +	unsigned long	freq;
> +};
> +
> +static bool is_wwdt_in_closed_window(struct watchdog_device *wdd)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	u32 csr, ret;
> +
> +	csr = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> +
> +	ret = (csr & XWWDT_ESR_WEN_MASK) ? !(csr & XWWDT_ESR_WSW_MASK) ? 0 : 1 : 1;

This is confusing.

	return !(csr & XWWDT_ESR_WEN_MASK) || ((csr & XWWDT_ESR_WSW_MASK);

should do the same and would be easier to understand, though I am not sure if
it is correct (making the point that the expression is confusing).

> +
> +	return ret;
> +}
> +
> +static int xilinx_wwdt_start(struct watchdog_device *wdd)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
> +	u64 time_out, closed_timeout, open_timeout;
> +	u32 control_status_reg;
> +
> +	/* Calculate timeout count */
> +	time_out = xdev->freq * wdd->timeout;
> +
> +	if (xclosed_window_percent) {
> +		closed_timeout = (time_out * xclosed_window_percent) / 100;
> +		open_timeout = time_out - closed_timeout;
> +		wdd->min_hw_heartbeat_ms = xclosed_window_percent * 10 * wdd->timeout;
> +	} else {
> +		/* Calculate 50% of timeout */

Isn't that a bit random ?

> +		time_out *= XWWDT_PERCENT;
> +		time_out /= 100;
> +		wdd->min_hw_heartbeat_ms = XWWDT_PERCENT * 10 * wdd->timeout;

min_hw_heartbeat_ms is supposed to be fixed after probe. Behavior of changing
it when starting the watchdog is undefined. This will likely fail under some
conditions.

> +	}
> +
> +	spin_lock(&xdev->spinlock);
> +
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	if (xclosed_window_percent) {
> +		iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
> +		iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
> +	} else {
> +		/* Configure closed and open windows with 50% of timeout */
> +		iowrite32((u32)time_out, xdev->base + XWWDT_FWR_OFFSET);
> +		iowrite32((u32)time_out, xdev->base + XWWDT_SWR_OFFSET);
> +	}

This if/else should not be necessary by using appropriate calculations
above. Anyway, this is moot - as said above, changing min_hw_heartbeat_ms
after probe is unexpected, and the code will have to be changed to use
a fixed value for the window size. With that, all calculations can and
should be done in the probe function.

> +
> +	/* Enable the window watchdog timer */
> +	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> +	control_status_reg |= XWWDT_ESR_WEN_MASK;
> +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);

Why is this enabled unconditionally ? I would assume that a user specifying
a 0-percentage window size doesn't want it enabled.

> +
> +	spin_unlock(&xdev->spinlock);
> +
> +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
> +
> +	return 0;
> +}
> +
> +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	u32 control_status_reg;
> +
> +	spin_lock(&xdev->spinlock);
> +
> +	/* Enable write access control bit for the window watchdog */
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +
> +	/* Trigger restart kick to watchdog */
> +	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> +	control_status_reg |= XWWDT_ESR_WSW_MASK;
> +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	spin_unlock(&xdev->spinlock);
> +
> +	return 0;
> +}
> +
> +static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
> +				   unsigned int new_time)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
> +
> +	if (watchdog_active(xilinx_wwdt_wdd))
> +		return -EPERM;

Why ? This will be the most common case and means to change the timeout.

> +
> +	wdd->timeout = new_time;
> +
> +	return 0;
> +}
> +
> +static int xilinx_wwdt_stop(struct watchdog_device *wdd)
> +{
> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> +	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
> +
> +	if (watchdog_active(xilinx_wwdt_wdd)) {
> +		if (!is_wwdt_in_closed_window(wdd)) {
> +			dev_warn(xilinx_wwdt_wdd->parent, "timer in closed window");
> +			return -EPERM;
> +		}
> +	}
> +
> +	spin_lock(&xdev->spinlock);
> +
> +	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
> +
> +	/* Disable the Window watchdog timer */
> +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
> +
> +	spin_unlock(&xdev->spinlock);
> +
> +	clk_disable(xdev->clk);

This doesn't work. The start function doesn't enable the clock; it is
enabled in the probe function. If you want to enable the clock
dynamically, you'll have to enable it in the start function and make sure
that it is stopped when unloading the driver (you can't use the devm
function in this case). You'll also need to make sure that the unprepare
function is called when unloading the driver.

> +
> +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Stopped!\n");
> +
> +	return 0;
> +}
> +
> +static void xwwdt_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static const struct watchdog_info xilinx_wwdt_ident = {
> +	.options = WDIOF_KEEPALIVEPING |
> +		WDIOF_SETTIMEOUT,
> +	.firmware_version = 1,
> +	.identity = "xlnx_window watchdog",
> +};
> +
> +static const struct watchdog_ops xilinx_wwdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = xilinx_wwdt_start,
> +	.stop = xilinx_wwdt_stop,
> +	.set_timeout = xilinx_wwdt_set_timeout,
> +	.ping = xilinx_wwdt_keepalive,
> +};
> +
> +static int xwwdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *xilinx_wwdt_wdd;
> +	struct device *dev = &pdev->dev;
> +	struct xwwdt_device *xdev;
> +	int ret;
> +
> +	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
> +	xilinx_wwdt_wdd->info = &xilinx_wwdt_ident;
> +	xilinx_wwdt_wdd->ops = &xilinx_wwdt_ops;
> +	xilinx_wwdt_wdd->parent = dev;
> +
> +	xdev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(xdev->base))
> +		return PTR_ERR(xdev->base);
> +
> +	xdev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(xdev->clk))
> +		return PTR_ERR(xdev->clk);
> +
> +	xdev->freq = clk_get_rate(xdev->clk);
> +	if (!xdev->freq)
> +		return -EINVAL;
> +
> +	ret = clk_prepare_enable(xdev->clk);
> +	if (ret) {
> +		dev_err(dev, "unable to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, xwwdt_clk_disable_unprepare,
> +				       xdev->clk);
> +	if (ret)
> +		return ret;
> +
> +	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
> +	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
> +	xilinx_wwdt_wdd->max_timeout = XWWDT_MAX_TIMEOUT;
> +
> +	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
> +				    xwwdt_timeout, &pdev->dev);
> +	if (ret)
> +		dev_info(&pdev->dev, "Configured default timeout value\n");
> +
> +	spin_lock_init(&xdev->spinlock);
> +	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
> +
> +	ret = devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
> +		 xilinx_wwdt_wdd->timeout);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id xwwdt_of_match[] = {
> +	{ .compatible = "xlnx,versal-wwdt-1.0", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xwwdt_of_match);
> +
> +static struct platform_driver xwwdt_driver = {
> +	.probe = xwwdt_probe,
> +	.driver = {
> +		.name = "Xilinx window watchdog",
> +		.of_match_table = xwwdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(xwwdt_driver);
> +
> +MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
> +MODULE_DESCRIPTION("Xilinx window watchdog driver");
> +MODULE_LICENSE("GPL");
