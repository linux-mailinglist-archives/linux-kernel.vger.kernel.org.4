Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD34F5E9500
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIYRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiIYRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:38:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE32EF31;
        Sun, 25 Sep 2022 10:38:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id u69so4689087pgd.2;
        Sun, 25 Sep 2022 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=EMSyRy/j25qHscJ26RfufhEd1Juz6VZbivWMabol+68=;
        b=IZtYJmlfblepENUBr4Z27Ifit4HVWJSPEbJBsLZceV6qpwjDt36RtNjo4MweZd20p3
         PHoFXNh8zVWYJXRvlgs3f0lYSv9pYeSo7eqIoS2uAkiR2+rnuHmPxZKJ/pNjugrTb4rW
         +pd0feXHPBk1scd4x+xqzlvbhqQUpYZZaA7r7VPzMJtAPmrdRpMqSbvbdQY20pIUiuqb
         XncmNxrhssPFxJiwaYER/CRZJActlUvkPjP9h4gTMFrnqF/w1ziGpkRsOhZyCqJU/az9
         h6lXwU/P94NQpR0EClhbyAifIeRnrU8BLji7Prix01rCbT5En0zF7KFFpHzxMrlBZWfF
         YkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EMSyRy/j25qHscJ26RfufhEd1Juz6VZbivWMabol+68=;
        b=WKLBRxVxhSRhN1qtgWMSqa2RlPrVpA+VfwMrco6Diy2kAp4ea62O5iDgzV7rRH9zhw
         hMjsAg3EJ1ojd9LbJBLLhquM3D8x4Li+iu5hqYVrHDyIwdYDC1DjCBc7h1yKklFld37T
         Uf9rWLuSAQM3ZCWUx0m8elERw1lgg5Dcteh9/20hlj1nJhQoKxvppVbOmZjaY+IITNP4
         R2USe28IDji6A6kK73gaC4oJnW01XXGiH299t2s6O9itmVgBABXVy6pUmNSi8TEqMgYP
         5dczAgqXYndnxfuCs1zHOqZZQnP8l/5eWJePdyTzeqOZrXz505F9T+p9yM9ot/P7xHi+
         zuEQ==
X-Gm-Message-State: ACrzQf378L2Cn/TuI/6wXm9mO6W0fKSNisGhuFwatjfT0pq2Y6DCw9ob
        DrybzivRgL8vR9Gzgs/sl+o=
X-Google-Smtp-Source: AMsMyM7tVxEMYfQ4gvV7wPYpDUx4JdUfQFEWiN7SED+zPzCpOpKCih7sM8aGUg++d8OhMIoGVTsDeQ==
X-Received: by 2002:a63:b64:0:b0:439:8143:c184 with SMTP id a36-20020a630b64000000b004398143c184mr16390700pgl.22.1664127502548;
        Sun, 25 Sep 2022 10:38:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001789ee5c821sm9545510plt.61.2022.09.25.10.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:38:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:38:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] watchdog: imx7ulp_wdt: Handle wdog reconfigure
 failure
Message-ID: <20220925173821.GE1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-6-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-6-alice.guo@oss.nxp.com>
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

On Thu, Aug 25, 2022 at 04:32:54PM +0800, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> Current driver may meet reconfigure failure caused by below reasons:
> 
> 1. The wdog on iMX7ULP has different behavior after RCS valid. It needs
>    to wait more than 2.5 wdog clock for clock sync before next
>    reconfiguration, while imx8ulp wdog does not need such delay.
> 
> 2. After unlock, there is 128 bus clock window opened for reconfiguration,
>    but on iMX8ULP, the HW can't guarantee the latency. So it is possible
>    the window is closed before the writing arrives to wdog.
> 
> 3. If the PRES is enabled, the RCS valid time becomes x256 to the time
>    of PRES disabled. It is about 1715ms on iMX8ULP. So We have to increase
>    the RCS timeout and can't wait it in IRQ disabled.
> 
> The patch updates the driver to handle failures
> 
> 1. Using different wait for unlock and RCS. Unlock valid time is very short
>    and only related to bus clock. It must be in IRQ disabled to avoid
>    being interrupted in 128 clock window. But for RCS time, it is longer
>    and ok for IRQ enabled.
> 
> 2. Add retry for any reconfigure failure with default 5 times.
> 
> 3. Add "fsl,imx8ulp-wdt" compatile string for iMX8ULP and afterwards
>    platform which don't need more 2.5 wdog clock after RCS valid.
>    For imx7ulp, add post delay of 2.5 clock after RCS valid.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes for v2:
>  - the wait timeout value of the RCS is 10ms, so use the sleep_us of
>    readl_poll_timeout in imx7ulp_wdt_wait_rcs to avoid a 10ms hot wait
> 
>  drivers/watchdog/imx7ulp_wdt.c | 163 ++++++++++++++++++++++++++-------
>  1 file changed, 129 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 12715c248688..0cafa86fff7f 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -14,7 +14,9 @@
>  #include <linux/watchdog.h>
>  
>  #define WDOG_CS			0x0
> +#define WDOG_CS_FLG		BIT(14)
>  #define WDOG_CS_CMD32EN		BIT(13)
> +#define WDOG_CS_PRES		BIT(12)
>  #define WDOG_CS_ULK		BIT(11)
>  #define WDOG_CS_RCS		BIT(10)
>  #define LPO_CLK			0x1
> @@ -39,7 +41,11 @@
>  #define DEFAULT_TIMEOUT	60
>  #define MAX_TIMEOUT	128
>  #define WDOG_CLOCK_RATE	1000
> -#define WDOG_WAIT_TIMEOUT	10000
> +#define WDOG_ULK_WAIT_TIMEOUT	1000
> +#define WDOG_RCS_WAIT_TIMEOUT	10000
> +#define WDOG_RCS_POST_WAIT 3000
> +
> +#define RETRY_MAX 5
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0000);
> @@ -50,40 +56,82 @@ struct imx7ulp_wdt_device {
>  	struct watchdog_device wdd;
>  	void __iomem *base;
>  	struct clk *clk;
> +	bool post_rcs_wait;
>  };
>  
> -static int imx7ulp_wdt_wait(void __iomem *base, u32 mask)
> +static int imx7ulp_wdt_wait_ulk(void __iomem *base)
>  {
>  	u32 val = readl(base + WDOG_CS);
>  
> -	if (!(val & mask) && readl_poll_timeout_atomic(base + WDOG_CS, val,
> -						       val & mask, 0,
> -						       WDOG_WAIT_TIMEOUT))
> +	if (!(val & WDOG_CS_ULK) &&
> +	    readl_poll_timeout_atomic(base + WDOG_CS, val,
> +				      val & WDOG_CS_ULK, 0,
> +				      WDOG_ULK_WAIT_TIMEOUT))
>  		return -ETIMEDOUT;
>  
>  	return 0;
>  }
>  
> -static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
> +static int imx7ulp_wdt_wait_rcs(struct imx7ulp_wdt_device *wdt)
>  {
> -	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
> +	int ret = 0;
> +	u32 val = readl(wdt->base + WDOG_CS);
> +	u64 timeout = (val & WDOG_CS_PRES) ?
> +		WDOG_RCS_WAIT_TIMEOUT * 256 : WDOG_RCS_WAIT_TIMEOUT;
> +	unsigned long wait_min = (val & WDOG_CS_PRES) ?
> +		WDOG_RCS_POST_WAIT * 256 : WDOG_RCS_POST_WAIT;
>  
> +	if (!(val & WDOG_CS_RCS) &&
> +	    readl_poll_timeout(wdt->base + WDOG_CS, val, val & WDOG_CS_RCS, 100,
> +			       timeout))
> +		ret = -ETIMEDOUT;
> +
> +	/* Wait 2.5 clocks after RCS done */
> +	if (wdt->post_rcs_wait)
> +		usleep_range(wait_min, wait_min + 2000);
> +
> +	return ret;
> +}
> +
> +static int _imx7ulp_wdt_enable(struct imx7ulp_wdt_device *wdt, bool enable)
> +{
>  	u32 val = readl(wdt->base + WDOG_CS);
>  	int ret;
>  
>  	local_irq_disable();
>  	writel(UNLOCK, wdt->base + WDOG_CNT);
> -	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_ULK);
> +	ret = imx7ulp_wdt_wait_ulk(wdt->base);
>  	if (ret)
>  		goto enable_out;
>  	if (enable)
>  		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
>  	else
>  		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
> -	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +
> +	local_irq_enable();
> +	ret = imx7ulp_wdt_wait_rcs(wdt);
> +
> +	return ret;
>  
>  enable_out:
>  	local_irq_enable();
> +	return ret;
> +}
> +
> +static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
> +{
> +	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
> +	int ret;
> +	u32 val;
> +	u32 loop = RETRY_MAX;
> +
> +	do {
> +		ret = _imx7ulp_wdt_enable(wdt, enable);
> +		val = readl(wdt->base + WDOG_CS);
> +	} while (--loop > 0 && ((!!(val & WDOG_CS_EN)) != enable || ret));
> +
> +	if (loop == 0)
> +		return -EBUSY;
>  
>  	return ret;
>  }
> @@ -114,28 +162,44 @@ static int imx7ulp_wdt_stop(struct watchdog_device *wdog)
>  	return imx7ulp_wdt_enable(wdog, false);
>  }
>  
> -static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
> -				   unsigned int timeout)
> +static int _imx7ulp_wdt_set_timeout(struct imx7ulp_wdt_device *wdt,
> +				   unsigned int toval)
>  {
> -	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
> -	u32 val = WDOG_CLOCK_RATE * timeout;
>  	int ret;
>  
>  	local_irq_disable();
>  	writel(UNLOCK, wdt->base + WDOG_CNT);
> -	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_ULK);
> +	ret = imx7ulp_wdt_wait_ulk(wdt->base);
>  	if (ret)
>  		goto timeout_out;
> -	writel(val, wdt->base + WDOG_TOVAL);
> -	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> -	if (ret)
> -		goto timeout_out;
> -
> -	wdog->timeout = timeout;
> +	writel(toval, wdt->base + WDOG_TOVAL);
> +	local_irq_enable();
> +	ret = imx7ulp_wdt_wait_rcs(wdt);
> +	return ret;
>  
>  timeout_out:
>  	local_irq_enable();
> +	return ret;
> +}
>  
> +static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
> +				   unsigned int timeout)
> +{
> +	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
> +	u32 toval = WDOG_CLOCK_RATE * timeout;
> +	u32 val;
> +	int ret;
> +	u32 loop = RETRY_MAX;
> +
> +	do {
> +		ret = _imx7ulp_wdt_set_timeout(wdt, toval);
> +		val = readl(wdt->base + WDOG_TOVAL);
> +	} while (--loop > 0 && (val != toval || ret));
> +
> +	if (loop == 0)
> +		return -EBUSY;
> +
> +	wdog->timeout = timeout;
>  	return ret;
>  }
>  
> @@ -175,38 +239,59 @@ static const struct watchdog_info imx7ulp_wdt_info = {
>  		    WDIOF_MAGICCLOSE,
>  };
>  
> -static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
> +static int _imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout, unsigned int cs)
>  {
>  	u32 val;
>  	int ret;
>  
>  	local_irq_disable();
>  
> -	val = readl(base + WDOG_CS);
> +	val = readl(wdt->base + WDOG_CS);
>  	if (val & WDOG_CS_CMD32EN) {
> -		writel(UNLOCK, base + WDOG_CNT);
> +		writel(UNLOCK, wdt->base + WDOG_CNT);
>  	} else {
>  		mb();
>  		/* unlock the wdog for reconfiguration */
> -		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> -		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> +		writel_relaxed(UNLOCK_SEQ0, wdt->base + WDOG_CNT);
> +		writel_relaxed(UNLOCK_SEQ1, wdt->base + WDOG_CNT);
>  		mb();
>  	}
>  
> -	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> +	ret = imx7ulp_wdt_wait_ulk(wdt->base);
>  	if (ret)
>  		goto init_out;
>  
>  	/* set an initial timeout value in TOVAL */
> -	writel(timeout, base + WDOG_TOVAL);
> -	/* enable 32bit command sequence and reconfigure */
> -	val = WDOG_CS_CMD32EN | WDOG_CS_CLK | WDOG_CS_UPDATE |
> -	      WDOG_CS_WAIT | WDOG_CS_STOP;
> -	writel(val, base + WDOG_CS);
> -	imx7ulp_wdt_wait(base, WDOG_CS_RCS);
> +	writel(timeout, wdt->base + WDOG_TOVAL);
> +	writel(cs, wdt->base + WDOG_CS);
> +	local_irq_enable();
> +	ret = imx7ulp_wdt_wait_rcs(wdt);
> +
> +	return ret;
>  
>  init_out:
>  	local_irq_enable();
> +	return ret;
> +}
> +
> +static int imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout)
> +{
> +	/* enable 32bit command sequence and reconfigure */
> +	u32 val = WDOG_CS_CMD32EN | WDOG_CS_CLK | WDOG_CS_UPDATE |
> +		  WDOG_CS_WAIT | WDOG_CS_STOP;
> +	u32 cs, toval;
> +	int ret;
> +	u32 loop = RETRY_MAX;
> +
> +	do {
> +		ret = _imx7ulp_wdt_init(wdt, timeout, val);
> +		toval = readl(wdt->base + WDOG_TOVAL);
> +		cs = readl(wdt->base + WDOG_CS);
> +		cs &= ~(WDOG_CS_FLG | WDOG_CS_ULK | WDOG_CS_RCS);
> +	} while (--loop > 0 && (cs != val || toval != timeout || ret));
> +
> +	if (loop == 0)
> +		return -EBUSY;
>  
>  	return ret;
>  }
> @@ -239,6 +324,15 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx7ulp_wdt->clk);
>  	}
>  
> +	imx7ulp_wdt->post_rcs_wait = true;
> +	if (of_device_is_compatible(dev->of_node,
> +				    "fsl,imx8ulp-wdt")) {
> +		dev_info(dev, "imx8ulp wdt probe\n");
> +		imx7ulp_wdt->post_rcs_wait = false;
> +	} else {
> +		dev_info(dev, "imx7ulp wdt probe\n");
> +	}
> +
>  	ret = clk_prepare_enable(imx7ulp_wdt->clk);
>  	if (ret)
>  		return ret;
> @@ -259,7 +353,7 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  	watchdog_stop_on_reboot(wdog);
>  	watchdog_stop_on_unregister(wdog);
>  	watchdog_set_drvdata(wdog, imx7ulp_wdt);
> -	ret = imx7ulp_wdt_init(imx7ulp_wdt->base, wdog->timeout * WDOG_CLOCK_RATE);
> +	ret = imx7ulp_wdt_init(imx7ulp_wdt, wdog->timeout * WDOG_CLOCK_RATE);
>  	if (ret)
>  		return ret;
>  
> @@ -289,7 +383,7 @@ static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
>  		return ret;
>  
>  	if (imx7ulp_wdt_is_enabled(imx7ulp_wdt->base))
> -		imx7ulp_wdt_init(imx7ulp_wdt->base, timeout);
> +		imx7ulp_wdt_init(imx7ulp_wdt, timeout);
>  
>  	if (watchdog_active(&imx7ulp_wdt->wdd))
>  		imx7ulp_wdt_start(&imx7ulp_wdt->wdd);
> @@ -303,6 +397,7 @@ static const struct dev_pm_ops imx7ulp_wdt_pm_ops = {
>  };
>  
>  static const struct of_device_id imx7ulp_wdt_dt_ids[] = {
> +	{ .compatible = "fsl,imx8ulp-wdt", },
>  	{ .compatible = "fsl,imx7ulp-wdt", },
>  	{ /* sentinel */ }
>  };
> -- 
> 2.17.1
> 
