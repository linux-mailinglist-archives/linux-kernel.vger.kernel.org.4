Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858E618093
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKCPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiKCPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:07:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020EC1B1DA;
        Thu,  3 Nov 2022 08:05:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c18-20020a056830349200b0066c47e192f0so1114448otu.12;
        Thu, 03 Nov 2022 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+LMDPVxiSEBWz30xQrCRDeHZy70LgG1o1jfGXqxYeY=;
        b=UMeYriPiO7lwL6z/qS1RudNvF22v90Ona84GJxHd7cVu8922bHAXNvmfRq9OTVZrzX
         EF1oV1qH7wXpcXYCltJr+t6tbHs0jTA+luZDZNHE/UujMCesgRqLdKoa1auEuwEIFMi5
         LFak0tc+Hk7bPEtEAL/5qqZEDeXaT/g0YTlvmcKQbHNRFWYuHp8L1FqrIltEtwZsFdBk
         eLs3jPtFrTTverMvMpTgp0CAJC+gpkeL/9opDie4Dyg56T8nuWVCPlsMarZjXxV1n0Rz
         cAVzt10cXG5+HKkHGouHmoHhNO0wQNMI62UZl72HfNCohmt/IbxouIIMW4tZwNOb3br2
         riJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+LMDPVxiSEBWz30xQrCRDeHZy70LgG1o1jfGXqxYeY=;
        b=AbKndLr17PL6apic9MTuh5oEUkY1vvoX3ODZiBh0H1ody1IPB7FWnwJDyvXk5qBK0T
         /QcxfgFpbkQhbwqkoHYbVRzhjnVKL5giEclaRglFcqDjMHaEPHvWRH2nGwbQbTfxkafo
         i/Sm1DPp82jvr0wYayiosxcowETFVOwYDpuFGnv3mlRfgGL+nFUwJpgJTr/wl45eSQlt
         tFZQESXs5vgKTQWhKiooMpVW1AgZyTpw4FybqrrxXlrKrdeL+TMM008+IQBZxqjx4rXH
         NdKB+BAKVSHu3lcFISm/TQPW4KnWdt8NVS75hy8WeqqGMU5II61MIFWf94an3ydf4KvE
         yq7g==
X-Gm-Message-State: ACrzQf1hAQWR7jGus5MHSfOULea8iw/72ufibgIWwlAa+d32DRWgYlDq
        ruOE1NWiNZ1CIQ2H7AJpzAw=
X-Google-Smtp-Source: AMsMyM6y+XpWcpKs5/mVvU7JTTwYNV8cL+uzhoilDVBfn/1sVPOneHDsBvhPnvMTZTlhwVvLyei2qw==
X-Received: by 2002:a9d:2ae8:0:b0:667:d857:55bc with SMTP id e95-20020a9d2ae8000000b00667d85755bcmr15348603otb.50.1667487903310;
        Thu, 03 Nov 2022 08:05:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u29-20020a056870d59d00b0013b09a56d59sm482055oao.27.2022.11.03.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:05:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Nov 2022 08:04:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Message-ID: <20221103150458.GA146501@roeck-us.net>
References: <20221103100358.176099-1-andrej.picej@norik.com>
 <20221103100358.176099-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103100358.176099-2-andrej.picej@norik.com>
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

On Thu, Nov 03, 2022 at 11:03:56AM +0100, Andrej Picej wrote:
> Putting device into the "Suspend-To-Idle" mode causes watchdog to
> trigger and resets the board after set watchdog timeout period elapses.
> 
> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
> watchdog in WAIT mode. This is done by setting WDW bit in WCR
> (Watchdog Control Register). Watchdog operation is restored after
> exiting WAIT mode as expected. WAIT mode corresponds with Linux's
> "Suspend-To-Idle".
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This will have to wait for dt approval.

Thanks,
Guenter

> ---
> Changes in v3:
>  - fix spelling in commit message,
>  - fix and simplify property handling in probe,
>  - add a comment about unknown interaction between imx7d no-ping
>    functionality and "fsl,suspend-in-wait",
>  - property support handled by of_device_id data pointer.
> 
> Changes in v2:
>  - validate the property with compatible string, as this functionality
>    is not supported by all devices.
> ---
>  drivers/watchdog/imx2_wdt.c | 55 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index d0c5d47ddede..19ab7b3d286b 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -27,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
> @@ -35,6 +36,7 @@
>  
>  #define IMX2_WDT_WCR		0x00		/* Control Register */
>  #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
>  #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
>  #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
>  #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
> @@ -60,13 +62,19 @@
>  
>  #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
>  
> +struct imx2_wdt_data {
> +	bool wdw_supported;
> +};
> +
>  struct imx2_wdt_device {
>  	struct clk *clk;
>  	struct regmap *regmap;
>  	struct watchdog_device wdog;
> +	const struct imx2_wdt_data *data;
>  	bool ext_reset;
>  	bool clk_is_on;
>  	bool no_ping;
> +	bool sleep_wait;
>  };
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -129,6 +137,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>  
>  	/* Suspend timer in low power mode, write once-only */
>  	val |= IMX2_WDT_WCR_WDZST;
> +	/* Suspend timer in low power WAIT mode, write once-only */
> +	if (wdev->sleep_wait)
> +		val |= IMX2_WDT_WCR_WDW;
>  	/* Strip the old watchdog Time-Out value */
>  	val &= ~IMX2_WDT_WCR_WT;
>  	/* Generate internal chip-level reset if WDOG times out */
> @@ -292,6 +303,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  	wdog->max_hw_heartbeat_ms = IMX2_WDT_MAX_TIME * 1000;
>  	wdog->parent		= dev;
>  
> +	wdev->data = of_device_get_match_data(dev);
> +
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret > 0)
>  		if (!devm_request_irq(dev, ret, imx2_wdt_isr, 0,
> @@ -313,9 +326,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  
>  	wdev->ext_reset = of_property_read_bool(dev->of_node,
>  						"fsl,ext-reset-output");
> +
> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait")) {
> +		if (!wdev->data->wdw_supported) {
> +			dev_err(dev, "suspend-in-wait not supported\n");
> +			return -EINVAL;
> +		}
> +		wdev->sleep_wait = true;
> +	}
> +
>  	/*
>  	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
> -	 * during suspend.
> +	 * during suspend. Interaction with "fsl,suspend-in-wait" is unknown!
>  	 */
>  	wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");
>  	platform_set_drvdata(pdev, wdog);
> @@ -417,9 +439,36 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>  			 imx2_wdt_resume);
>  
> +struct imx2_wdt_data imx_wdt = {
> +	.wdw_supported = true,
> +};
> +
> +struct imx2_wdt_data imx_wdt_legacy = {
> +	.wdw_supported = false,
> +};
> +
>  static const struct of_device_id imx2_wdt_dt_ids[] = {
> -	{ .compatible = "fsl,imx21-wdt", },
> -	{ .compatible = "fsl,imx7d-wdt", },
> +	{ .compatible = "fsl,imx21-wdt", .data = &imx_wdt_legacy },
> +	{ .compatible = "fsl,imx25-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx27-wdt", .data = &imx_wdt_legacy },
> +	{ .compatible = "fsl,imx31-wdt", .data = &imx_wdt_legacy },
> +	{ .compatible = "fsl,imx35-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx50-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx51-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx53-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx6q-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx6sl-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx6sll-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx6sx-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx6ul-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx7d-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx8mm-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx8mn-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx8mp-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,imx8mq-wdt", .data = &imx_wdt },
> +	{ .compatible = "fsl,ls1012a-wdt", .data = &imx_wdt_legacy },
> +	{ .compatible = "fsl,ls1043a-wdt", .data = &imx_wdt_legacy },
> +	{ .compatible = "fsl,vf610-wdt", .data = &imx_wdt },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
> -- 
> 2.25.1
> 
