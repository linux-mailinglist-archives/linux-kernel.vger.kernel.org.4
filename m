Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FAB65A802
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiLaXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiLaXKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:10:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCE4225;
        Sat, 31 Dec 2022 15:10:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r205so22194701oib.9;
        Sat, 31 Dec 2022 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENlX3FFLDh3wgIqc1xOaPfINmD8K7dyU0rKdck6ROU0=;
        b=f7PW5ybJLRiB8vmAXUU+uUkbVNqLKLTLhyZnRpg+brWw5jTGMotKpTe0nT7ceOyt8b
         PPFN0Co3fxC4Gml2QP2c0SViYwHvRzgNHQgqZ6csUsxzby+RwyQRLr3+punM7S/IPW5D
         +J4PLjmOAHdSV2AQh64NupVZnLOOk3LBW8sJdnFeVYLIYpNrOaONr6Nwoj70lMGTSQdY
         3KsyWEmxsDCkM96Cso/0WmL1RJJBEedJ2QGma6xW6FwPPIR4xnso5rBvoQBvnJLsU2QJ
         xeEXJCfmDCYQpXuzniw6CSb/UQKwxDu5mGi5XlympEmtwFxbrk3KXTymr0ltlJAHHALa
         H85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENlX3FFLDh3wgIqc1xOaPfINmD8K7dyU0rKdck6ROU0=;
        b=G9Mj6az8aIDj6lcN7R1qIi3J3TPI2j5q/KhAnhvHMI2vHCNZJIcXXquYrqzEfbC3yg
         O1IURo7cl3enh/vBMseDWJrtal9OK93LkfBcrofKnZWySHjECxd87RBVhir1Swtrb6YZ
         KaeRNQ1CTa9IRqPZvwhlng9iufhuY+wcEf5nhWRn6lB0pMcIwc/JWNP74q/lm0XFWdTK
         OrUhAzJVdM09LgP2sY04ffw8LAS4IA6F43tQTXJJ071ffGnMHw3A1ISHCr+WXuqFSD5G
         2398GB7NjL24hmI32d0c4ZbBrSsQ7ov6Nx90yqs6IC2qprt263AkEaZmycyeJxY9y2qq
         Szvw==
X-Gm-Message-State: AFqh2kq3A602upa8710oEOuCMEl/RTxpjCyImhGeagmLj7VdTEY8OVtN
        71Zbe3QUqVtn4rfvazpLpWk=
X-Google-Smtp-Source: AMrXdXtB6FJbs/Eg7M6yUNzJnYKHs+CJuGkyrQPItYsePzPx90UMgLXajyUofCmzi+BUxnNTQMRHYw==
X-Received: by 2002:a05:6808:290f:b0:360:f286:820b with SMTP id ev15-20020a056808290f00b00360f286820bmr16110211oib.2.1672528244844;
        Sat, 31 Dec 2022 15:10:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11-20020a056808148b00b00342eade43d4sm10628577oiw.13.2022.12.31.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 15:10:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 15:10:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: imx7ulp: Use devm_clk_get_enabled() helper
Message-ID: <20221231231043.GC2706156@roeck-us.net>
References: <f23a2cf84958adca255b82fd688e7cee0461760f.1672484376.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23a2cf84958adca255b82fd688e7cee0461760f.1672484376.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 11:59:57AM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/imx7ulp_wdt.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 2897902090b3..7ca486794ba7 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -299,11 +299,6 @@ static int imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout
>  	return ret;
>  }
>  
> -static void imx7ulp_wdt_action(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  {
>  	struct imx7ulp_wdt_device *imx7ulp_wdt;
> @@ -321,7 +316,7 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(imx7ulp_wdt->base))
>  		return PTR_ERR(imx7ulp_wdt->base);
>  
> -	imx7ulp_wdt->clk = devm_clk_get(dev, NULL);
> +	imx7ulp_wdt->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(imx7ulp_wdt->clk)) {
>  		dev_err(dev, "Failed to get watchdog clock\n");
>  		return PTR_ERR(imx7ulp_wdt->clk);
> @@ -336,14 +331,6 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  		dev_info(dev, "imx7ulp wdt probe\n");
>  	}
>  
> -	ret = clk_prepare_enable(imx7ulp_wdt->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, imx7ulp_wdt_action, imx7ulp_wdt->clk);
> -	if (ret)
> -		return ret;
> -
>  	wdog = &imx7ulp_wdt->wdd;
>  	wdog->info = &imx7ulp_wdt_info;
>  	wdog->ops = &imx7ulp_wdt_ops;
> -- 
> 2.34.1
> 
