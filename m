Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3765C8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjACVO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjACVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:14:52 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D417E13F01;
        Tue,  3 Jan 2023 13:14:51 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15085b8a2f7so13457862fac.2;
        Tue, 03 Jan 2023 13:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=femL7aEqLe1KO5Vr9GNJqhZJWyR6cx2fYeM5OLgTsuY=;
        b=a+qNPUoCiFTI1t0t7/oQ/1zIUg2os38eBdinlPOYgvGktqSj/xRIRR1L/YJkgJHUTg
         HN6th49Q0wTtK9jBKcuNQriFmha9YSeveDUJ8Xvr+wI+fNpjTMWOMdEAjuxmfqhmX1PS
         avL05JhreCFzboSqoqGarnCPO9+SOviab2KUbfPfpcQhImJgld/r6eKucWjWERtNOciD
         PgGTxavWWWpSwnA7cUb2i5IrQ0gaal/8iwEZqCyunbZ64zh+bBfjXidOvbuk6wkBNy3s
         baSRi3JdeIWscXdRcMkOcxbfPGIQjWmt0K/4iZ0GJQOpVQrFg508C8EuXsTFbj9nP+oX
         lg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=femL7aEqLe1KO5Vr9GNJqhZJWyR6cx2fYeM5OLgTsuY=;
        b=gGbOu/7SYuN3AhcrLHKD40CJD/udU8y9Hau8eIPhM2KSaVzVv8jJYQ2VNfq8nvS4wB
         o9jgu233isXSH18vAMXr0f36kpdFnqtPh3gsCS9v0UP/3wngxdstNTUVSVjZgx2cGAEB
         VI4yaBwXT8wTWgsX7sH1ZSNUWxEf64nZbB46papD5L6xVIzPIWrmPjBBIhgV9GQyYwrE
         iQ1GTaNHjUSbAFAtKM6gbdaIv4CSFNp7Itln3lpi6ShiPan5Gx5f+KXIDn8dE2nB02jD
         jN80Z0SmXCEGaSrLdruA0DQzv7IO9WPNSLWSTX/XfO/+F3lymjXNU1QTs2bOOHiN8igf
         sSSg==
X-Gm-Message-State: AFqh2krNmeOboGSs3gIqUxlXVFnedx3KUyNqPf8E368RObEqcY75euVb
        e3pGPms09y9DfHf+ENobzdk2vP2VHt0=
X-Google-Smtp-Source: AMrXdXsSfw9qlNGFbRdAuRTvWUEJIuKuk/H/4MtM0BfqKooruzNMvDIzuARcyneswQt9tDfY27KXYg==
X-Received: by 2002:a05:6870:75cc:b0:150:ce00:7856 with SMTP id de12-20020a05687075cc00b00150ce007856mr2486195oab.12.1672780491181;
        Tue, 03 Jan 2023 13:14:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t123-20020a4a5481000000b00492f9f46aa4sm12619354ooa.36.2023.01.03.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:14:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:14:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] watchdog: of_xilinx_wdt: Use devm_clk_get_enabled()
 helper
Message-ID: <20230103211449.GC212337@roeck-us.net>
References: <2b041dc8230a4ed255051bb2d323da8a51a8d0be.1672491445.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b041dc8230a4ed255051bb2d323da8a51a8d0be.1672491445.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 01:57:49PM +0100, Christophe JAILLET wrote:
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
> V2: remove xwdt_clk_disable_unprepare() as-well
> 
> Note that the order of operations is slightly modified by this patch. The
> clk is now prepare_enable()'ed before calling clk_get_rate().
> ---
>  drivers/watchdog/of_xilinx_wdt.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 3318544366b8..2a079ca04aa3 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -154,11 +154,6 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
>  		return XWT_TIMER_FAILED;
>  }
>  
> -static void xwdt_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int xwdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -193,7 +188,7 @@ static int xwdt_probe(struct platform_device *pdev)
>  
>  	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>  
> -	xdev->clk = devm_clk_get(dev, NULL);
> +	xdev->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(xdev->clk)) {
>  		if (PTR_ERR(xdev->clk) != -ENOENT)
>  			return PTR_ERR(xdev->clk);
> @@ -211,15 +206,6 @@ static int xwdt_probe(struct platform_device *pdev)
>  				 "The watchdog clock freq cannot be obtained\n");
>  	} else {
>  		pfreq = clk_get_rate(xdev->clk);
> -		rc = clk_prepare_enable(xdev->clk);
> -		if (rc) {
> -			dev_err(dev, "unable to enable clock\n");
> -			return rc;
> -		}
> -		rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
> -					      xdev->clk);
> -		if (rc)
> -			return rc;
>  	}
>  
>  	/*
> -- 
> 2.34.1
> 
