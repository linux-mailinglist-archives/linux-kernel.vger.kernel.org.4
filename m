Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032F604BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiJSPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiJSPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:38:57 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9611D9AB;
        Wed, 19 Oct 2022 08:35:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w196so19629996oiw.8;
        Wed, 19 Oct 2022 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laOx8JEUkYOBVsrZgeUaM0M4fbp7OLGnhupIrYPqb4w=;
        b=RrQWM8yAa/UvluekZaABCeB0Aj49W8VpK7/qpWX2XyabhBVIJvyvImRc16Kl82x/uo
         5R+MTXu1XvFUSP6G6VbvChnhXMP8cM0E51V1JhLmDEyblBauJ/cKBTUS6HI82gLxRAqS
         mkeBpyf4OH9NkCQnbK1tuYa1ZGhftb4k0C3HiQIMxxniZNH1WzgF6LkbO9PDHgsz6kcC
         Tg6GLPCG2shArlndJslH2NaHOjE2wHOIjv/dZrZ42KyQlm7mXZa0+ptZ70uj+uheX4/p
         ee9PwIFwCvZww9BCYZvKcXBXCakOWaaiTp8xsCYPNa7jpKqiFkaCN/gVyM+VJG+u6G91
         fosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laOx8JEUkYOBVsrZgeUaM0M4fbp7OLGnhupIrYPqb4w=;
        b=vnooGYSHblFoi+DiJcXM+LVwVo5D8/2Z/9HfEWzSS+U6LCiQvekaxPHLd7Nyf49tAs
         g02c2WLJhZITMmYW4uHLU4vFOeuUKKKtz5IuC7tRq4Z4oYpzEGJ0/IsBJpeRIBCc8RiH
         GGUGOwtPeuX6wHIZokGupk0L4UjpK01vy98h4pNFoakO9uIi8qYHChZKkdlep9ffLfZB
         HvGvN9aYJDXbD+dp6Nlx1SsOwYiwQ0vTX04j24THZLANaxK+cAWZEJf4ytSlQki50Wvm
         oc9YWfDRD0cHT2H5azUgAlG2p9V6m+sa36Akbhn47QSHP8hq2gShniaMnVrldwIEP7lK
         beUQ==
X-Gm-Message-State: ACrzQf3H4enb/erunmPhxtXIgqW/wdxKGbu8CnVcSey3oIn7qsWpgaF0
        HrNMDj6f2/qKl32uD9fI1/M=
X-Google-Smtp-Source: AMsMyM7S1b7Sbh6MAlG1ceyYKGiYGhaEiw1qbNfnuu1w0Mxwzi9gAiWFmoQkB+AdGBRzHRfgyzfBSA==
X-Received: by 2002:a05:6808:221b:b0:354:cca5:9215 with SMTP id bd27-20020a056808221b00b00354cca59215mr4756130oib.53.1666193589306;
        Wed, 19 Oct 2022 08:33:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd40-20020a056870d7a800b0012d6f3d370bsm7507906oab.55.2022.10.19.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:33:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Oct 2022 08:33:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
Subject: Re: [PATCH 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Message-ID: <20221019153306.GC4602@roeck-us.net>
References: <20221019111714.1953262-1-andrej.picej@norik.com>
 <20221019111714.1953262-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019111714.1953262-2-andrej.picej@norik.com>
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

On Wed, Oct 19, 2022 at 01:17:12PM +0200, Andrej Picej wrote:
> Putting device into the "Suspend-To-Idle" mode causes watchdog to
> trigger and reset the board after set watchdog timeout period elapses.
> 
> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
> watchdog in WAIT mode. This is done by setting WDW bit in WCR
> (Watchdog Control Register) Watchdog operation is restored after exiting
> WAIT mode as expected. WAIT mode coresponds with Linux's
> "Suspend-To-Idle".
> 

Does that have any impact on suspend/resume handling in the driver,
specifically with the "no_ping" variable used for fsl,imx7d-wdt ?

Thanks,
Guenter

> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  drivers/watchdog/imx2_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index d0c5d47ddede..150ba83ce176 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -35,6 +35,7 @@
>  
>  #define IMX2_WDT_WCR		0x00		/* Control Register */
>  #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
>  #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
>  #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
>  #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
> @@ -67,6 +68,7 @@ struct imx2_wdt_device {
>  	bool ext_reset;
>  	bool clk_is_on;
>  	bool no_ping;
> +	bool sleep_wait;
>  };
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -129,6 +131,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>  
>  	/* Suspend timer in low power mode, write once-only */
>  	val |= IMX2_WDT_WCR_WDZST;
> +	/* Suspend timer in low power WAIT mode, write once-only */
> +	if (wdev->sleep_wait)
> +		val |= IMX2_WDT_WCR_WDW;
>  	/* Strip the old watchdog Time-Out value */
>  	val &= ~IMX2_WDT_WCR_WT;
>  	/* Generate internal chip-level reset if WDOG times out */
> @@ -313,6 +318,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  
>  	wdev->ext_reset = of_property_read_bool(dev->of_node,
>  						"fsl,ext-reset-output");
> +	wdev->sleep_wait = of_property_read_bool(dev->of_node,
> +						"fsl,suspend-in-wait");
>  	/*
>  	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
>  	 * during suspend.
> -- 
> 2.25.1
> 
