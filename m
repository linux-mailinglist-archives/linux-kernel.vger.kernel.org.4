Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ECB616F47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKBVAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKBU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:59:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B0B7D9;
        Wed,  2 Nov 2022 13:59:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m204so21881oib.6;
        Wed, 02 Nov 2022 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soS0Yn/ZfokS1qDWkDRsD0zJtKnYpfw4M0hFaCGBl6A=;
        b=KAgJr5TKogtZjSuef30nd+LiAEK4V2yhrt1PTlZZkWcR996CjbOhTvPai+AGSSVE99
         vMeCPW2O3U4TLaDwDwBJ6iTSzFKXd3VyBDfJccDj7yyht6fjkX8r5UaB8HAWxrf6K0bD
         8/2Rgr0t/5JYBR9RqzI979iJsRxNsNv+7f2FbuHuPcZLjizzfJeiNRgiZyewHe6H5+us
         L9PaSqk10wbv/vehz36H8r7rs3wYrkZrMx1685L5PbpTPDzPfpWWjlenWgwAULw4RHEY
         XWmvnNj5LpI5PxGYIcI/PhIzXFlzrI7j0BLCxU6mV8XZfeSH7MKxAoyuqAmFWSEoNlD0
         29vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soS0Yn/ZfokS1qDWkDRsD0zJtKnYpfw4M0hFaCGBl6A=;
        b=C9vzgyQqDHoGoohah//u0G3yejnlvVstjXnsFsSe83y8GnTkgDCGaTA46CCu8RsU+A
         8uB1WZXRcJr+VuGFACCtk5oYCamGtw3I+4zlgIIUfWd5Dwazok2LTpv7vuPrBlsbTonD
         pmNQjmmVG5GeMCnoLKuaLALPyrVivkypvWZlTOUirOV2bUsPgw9RyW+Jxrz7wCGSm52m
         E6iECU6TVd6huIs0GZh/2Ayz61tbklCwC5cgLGKkZoRULsg8su+a8CNAQSaUdGe0DNmd
         x+YBeMGqdju87WS0nDLLtioud+uvVk1CUCQ/DQ8yg5Tv7ikH4nsK+GpmlWLQE5RCF7lC
         CNQA==
X-Gm-Message-State: ACrzQf2y33hI0940Y+CLWF+6vn5zbYwchsFnRw/3E1huEfdmTCESKRrq
        TB+XDLFdLy/dhDdhTPh7OhcaLpajaWg=
X-Google-Smtp-Source: AMsMyM60QwbnBdqegQTHutWhgWFgSvG6RppshZhcmtSjy4OMnY4Pv8mxZyakqUgILkZBi4C2n9Pyaw==
X-Received: by 2002:a05:6808:1207:b0:353:e6cf:6d46 with SMTP id a7-20020a056808120700b00353e6cf6d46mr14534475oil.207.1667422792485;
        Wed, 02 Nov 2022 13:59:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14-20020a54418e000000b0034d8abf42f1sm4953081oiy.23.2022.11.02.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:59:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Nov 2022 13:59:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        joel@jms.id.au, andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: aspeed: Enable pre-timeout interrupt
Message-ID: <20221102205951.GA2090175@roeck-us.net>
References: <20221101205338.577427-1-eajames@linux.ibm.com>
 <20221101205338.577427-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101205338.577427-2-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:53:37PM -0500, Eddie James wrote:
> Enable the core pre-timeout interrupt on AST2500 and AST2600.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c | 104 ++++++++++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 0cff2adfbfc9..86b5331bc491 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -5,11 +5,14 @@
>   * Joel Stanley <joel@jms.id.au>
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  
> @@ -18,28 +21,41 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +struct aspeed_wdt_config {
> +	u32 ext_pulse_width_mask;
> +	u32 irq_shift;
> +	u32 irq_mask;
> +};
> +
>  struct aspeed_wdt {
>  	struct watchdog_device	wdd;
>  	void __iomem		*base;
>  	u32			ctrl;
> -};
> -
> -struct aspeed_wdt_config {
> -	u32 ext_pulse_width_mask;
> +	const struct aspeed_wdt_config *cfg;
>  };
>  
>  static const struct aspeed_wdt_config ast2400_config = {
>  	.ext_pulse_width_mask = 0xff,
> +	.irq_shift = 0,
> +	.irq_mask = 0,
>  };
>  
>  static const struct aspeed_wdt_config ast2500_config = {
>  	.ext_pulse_width_mask = 0xfffff,
> +	.irq_shift = 12,
> +	.irq_mask = GENMASK(31, 12),
> +};
> +
> +static const struct aspeed_wdt_config ast2600_config = {
> +	.ext_pulse_width_mask = 0xfffff,
> +	.irq_shift = 0,
> +	.irq_mask = GENMASK(31, 10),
>  };
>  
>  static const struct of_device_id aspeed_wdt_of_table[] = {
>  	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>  	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
> -	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
> +	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> @@ -58,6 +74,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
>  #define   WDT_CTRL_ENABLE		BIT(0)
>  #define WDT_TIMEOUT_STATUS	0x10
> +#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
>  #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
>  #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>  #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
> @@ -160,6 +177,26 @@ static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>  	return 0;
>  }
>  
> +static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
> +				     unsigned int pretimeout)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +	u32 actual = pretimeout * WDT_RATE_1MHZ;
> +	u32 s = wdt->cfg->irq_shift;
> +	u32 m = wdt->cfg->irq_mask;
> +
> +	wdd->pretimeout = pretimeout;
> +	wdt->ctrl &= ~m;
> +	if (pretimeout)
> +		wdt->ctrl |= ((actual << s) & m) | WDT_CTRL_WDT_INTR;
> +	else
> +		wdt->ctrl &= ~WDT_CTRL_WDT_INTR;
> +
> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
>  static int aspeed_wdt_restart(struct watchdog_device *wdd,
>  			      unsigned long action, void *data)
>  {
> @@ -232,6 +269,7 @@ static const struct watchdog_ops aspeed_wdt_ops = {
>  	.stop		= aspeed_wdt_stop,
>  	.ping		= aspeed_wdt_ping,
>  	.set_timeout	= aspeed_wdt_set_timeout,
> +	.set_pretimeout = aspeed_wdt_set_pretimeout,
>  	.restart	= aspeed_wdt_restart,
>  	.owner		= THIS_MODULE,
>  };
> @@ -243,10 +281,29 @@ static const struct watchdog_info aspeed_wdt_info = {
>  	.identity	= KBUILD_MODNAME,
>  };
>  
> +static const struct watchdog_info aspeed_wdt_pretimeout_info = {
> +	.options	= WDIOF_KEEPALIVEPING
> +			| WDIOF_PRETIMEOUT
> +			| WDIOF_MAGICCLOSE
> +			| WDIOF_SETTIMEOUT,
> +	.identity	= KBUILD_MODNAME,
> +};
> +
> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
> +{
> +	struct watchdog_device *wdd = arg;
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> +
> +	if (status & WDT_TIMEOUT_STATUS_IRQ)
> +		watchdog_notify_pretimeout(wdd);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int aspeed_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct aspeed_wdt_config *config;
>  	const struct of_device_id *ofdid;
>  	struct aspeed_wdt *wdt;
>  	struct device_node *np;
> @@ -259,11 +316,33 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (!wdt)
>  		return -ENOMEM;
>  
> +	np = dev->of_node;
> +
> +	ofdid = of_match_node(aspeed_wdt_of_table, np);
> +	if (!ofdid)
> +		return -EINVAL;
> +	wdt->cfg = ofdid->data;
> +
>  	wdt->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
>  	wdt->wdd.info = &aspeed_wdt_info;
> +
> +	if (wdt->cfg->irq_mask) {
> +		int irq = platform_get_irq_optional(pdev, 0);
> +
> +		if (irq > 0) {
> +			ret = devm_request_irq(dev, irq, aspeed_wdt_irq,
> +					       IRQF_SHARED, dev_name(dev),
> +					       wdt);
> +			if (ret)
> +				return ret;
> +
> +			wdt->wdd.info = &aspeed_wdt_pretimeout_info;
> +		}
> +	}
> +
>  	wdt->wdd.ops = &aspeed_wdt_ops;
>  	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
>  	wdt->wdd.parent = dev;
> @@ -273,13 +352,6 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  
>  	watchdog_set_nowayout(&wdt->wdd, nowayout);
>  
> -	np = dev->of_node;
> -
> -	ofdid = of_match_node(aspeed_wdt_of_table, np);
> -	if (!ofdid)
> -		return -EINVAL;
> -	config = ofdid->data;
> -
>  	/*
>  	 * On clock rates:
>  	 *  - ast2400 wdt can run at PCLK, or 1MHz
> @@ -331,7 +403,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
>  		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>  
> -		reg &= config->ext_pulse_width_mask;
> +		reg &= wdt->cfg->ext_pulse_width_mask;
>  		if (of_property_read_bool(np, "aspeed,ext-active-high"))
>  			reg |= WDT_ACTIVE_HIGH_MAGIC;
>  		else
> @@ -339,7 +411,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  
>  		writel(reg, wdt->base + WDT_RESET_WIDTH);
>  
> -		reg &= config->ext_pulse_width_mask;
> +		reg &= wdt->cfg->ext_pulse_width_mask;
>  		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
>  			reg |= WDT_PUSH_PULL_MAGIC;
>  		else
> @@ -349,7 +421,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
> -		u32 max_duration = config->ext_pulse_width_mask + 1;
> +		u32 max_duration = wdt->cfg->ext_pulse_width_mask + 1;
>  
>  		if (duration == 0 || duration > max_duration) {
>  			dev_err(dev, "Invalid pulse duration: %uus\n",
