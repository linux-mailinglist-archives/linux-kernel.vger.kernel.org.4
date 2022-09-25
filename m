Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B445E9505
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiIYRjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiIYRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:38:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7C2F3A7;
        Sun, 25 Sep 2022 10:38:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id iw17so4381715plb.0;
        Sun, 25 Sep 2022 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Nv52lVrXeDJdkgqgOmgaRHFK3xM6rgSOdfECS4uQI1I=;
        b=LKG50ohmntp9p6406DyZWy11GyuszLdoPgDfeNIp0dV9Ai897gz3OBjOeFLFWmN9Sx
         1pxDx1yZHqFsYqQ96erqwLtHCLhCcDo04geaSNYv0PVfeCHpHgepnRu0Q38LNC+zz4ss
         NkJWA0qg/6Fm4qpQ2MwPScwC49zFRuz/1iAWolZiMQKxQzqF8IXWbAL4U535usb/Iz7a
         xRasSiZQLMnCojoUi5/Q3ezdnz0icM+V9BkoOUG2drKgZU9xB4jIUJVD5K7mQvsDJnKc
         P+iLHQMtbiVnbufQIA+I9MBz6QKswqspX3xDQ3zkttguOcz4o/55VOT2wribUJTR37YL
         +G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Nv52lVrXeDJdkgqgOmgaRHFK3xM6rgSOdfECS4uQI1I=;
        b=3UaIYHdvFaMnl0X4WujaBFpAcBOGcs92004g1eLobrqPwD8dAPk4uODLTHXe5aFhuH
         HtKiw2VvxQGQ09VbyOEFpdGHxzbBpAQYd5dhui93pBF2ebAI8IK0wSufGx4WPchaa2wb
         DaZXXZvCXZYFR4TWnhLpmAtyMx0nwraZcWwqRITAlYAt6IkbrrBD67jdvWl9dKvxaiST
         WbHYaJG16biFT2USmvVK9GMHoTBCPOGLywU2dQhpOSgHE0MwZ+3UeBLAcm+Dowka7Zea
         fuOorTk3pzbuGLeHz/lmJQzE8yrj4npP6zKOePN64CqZvtI1uPRFPwLeYywJsqJTOmig
         EsfA==
X-Gm-Message-State: ACrzQf3864Y9z3xoMDg34rOXm0y4kBH5LBBZWdQGE6lr8iqMWWHxqTYl
        ZMNf+TVzq1ycHhlAKxZMGoU=
X-Google-Smtp-Source: AMsMyM6Q2ux3B3uVB9EZ+N6h622GnhzQpaMCYICu2+MEQ1XYAAHZ0KXQ1hIqTauy+adFxlvw/Djodw==
X-Received: by 2002:a17:903:54:b0:176:cdf8:b791 with SMTP id l20-20020a170903005400b00176cdf8b791mr17267372pla.24.1664127523123;
        Sun, 25 Sep 2022 10:38:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23-20020a635017000000b00438b79c7049sm9055326pgb.42.2022.09.25.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:38:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:38:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] watchdog: imx93: add watchdog timer on imx93
Message-ID: <20220925173841.GG1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-8-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-8-alice.guo@oss.nxp.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:32:56PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> The WDOG clocks are sourced from lpo_clk, and lpo_clk is the fixed
> 32KHz. TOVAL contains the 16-bit value used to set the timeout period of
> the watchdog. When the timeout period exceeds 2 seconds, the value
> written to the TOVAL register is larger than 16-bit can represent.
> Enabling watchdog prescaler can solve this problem.
> 
> Two points need to be aware of:
> 1. watchdog prescaler enables a fixed 256 pre-scaling of watchdog
> counter reference clock
> 2. reconfiguration takes about 55ms on imx93
> 
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes for v2:
>  - none
> 
>  drivers/watchdog/imx7ulp_wdt.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index dee02c2a52c9..2897902090b3 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
>  #include <linux/watchdog.h>
> @@ -52,11 +53,17 @@ module_param(nowayout, bool, 0000);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +struct imx_wdt_hw_feature {
> +	bool prescaler_enable;
> +	u32 wdog_clock_rate;
> +};
> +
>  struct imx7ulp_wdt_device {
>  	struct watchdog_device wdd;
>  	void __iomem *base;
>  	struct clk *clk;
>  	bool post_rcs_wait;
> +	const struct imx_wdt_hw_feature *hw;
>  };
>  
>  static int imx7ulp_wdt_wait_ulk(void __iomem *base)
> @@ -179,7 +186,7 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
>  				   unsigned int timeout)
>  {
>  	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
> -	u32 toval = WDOG_CLOCK_RATE * timeout;
> +	u32 toval = wdt->hw->wdog_clock_rate * timeout;
>  	u32 val;
>  	int ret;
>  	u32 loop = RETRY_MAX;
> @@ -276,6 +283,9 @@ static int imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout
>  	int ret;
>  	u32 loop = RETRY_MAX;
>  
> +	if (wdt->hw->prescaler_enable)
> +		val |= WDOG_CS_PRES;
> +
>  	do {
>  		ret = _imx7ulp_wdt_init(wdt, timeout, val);
>  		toval = readl(wdt->base + WDOG_TOVAL);
> @@ -346,7 +356,9 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  	watchdog_stop_on_reboot(wdog);
>  	watchdog_stop_on_unregister(wdog);
>  	watchdog_set_drvdata(wdog, imx7ulp_wdt);
> -	ret = imx7ulp_wdt_init(imx7ulp_wdt, wdog->timeout * WDOG_CLOCK_RATE);
> +
> +	imx7ulp_wdt->hw = of_device_get_match_data(dev);
> +	ret = imx7ulp_wdt_init(imx7ulp_wdt, wdog->timeout * imx7ulp_wdt->hw->wdog_clock_rate);
>  	if (ret)
>  		return ret;
>  
> @@ -368,7 +380,7 @@ static int __maybe_unused imx7ulp_wdt_suspend_noirq(struct device *dev)
>  static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
>  {
>  	struct imx7ulp_wdt_device *imx7ulp_wdt = dev_get_drvdata(dev);
> -	u32 timeout = imx7ulp_wdt->wdd.timeout * WDOG_CLOCK_RATE;
> +	u32 timeout = imx7ulp_wdt->wdd.timeout * imx7ulp_wdt->hw->wdog_clock_rate;
>  	int ret;
>  
>  	ret = clk_prepare_enable(imx7ulp_wdt->clk);
> @@ -389,9 +401,20 @@ static const struct dev_pm_ops imx7ulp_wdt_pm_ops = {
>  				      imx7ulp_wdt_resume_noirq)
>  };
>  
> +static const struct imx_wdt_hw_feature imx7ulp_wdt_hw = {
> +	.prescaler_enable = false,
> +	.wdog_clock_rate = 1000,
> +};
> +
> +static const struct imx_wdt_hw_feature imx93_wdt_hw = {
> +	.prescaler_enable = true,
> +	.wdog_clock_rate = 125,
> +};
> +
>  static const struct of_device_id imx7ulp_wdt_dt_ids[] = {
> -	{ .compatible = "fsl,imx8ulp-wdt", },
> -	{ .compatible = "fsl,imx7ulp-wdt", },
> +	{ .compatible = "fsl,imx8ulp-wdt", .data = &imx7ulp_wdt_hw, },
> +	{ .compatible = "fsl,imx7ulp-wdt", .data = &imx7ulp_wdt_hw, },
> +	{ .compatible = "fsl,imx93-wdt", .data = &imx93_wdt_hw, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx7ulp_wdt_dt_ids);
> -- 
> 2.17.1
> 
