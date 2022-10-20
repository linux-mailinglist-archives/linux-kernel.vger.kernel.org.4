Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8B6068CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJTTXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:23:04 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEEC1F8101;
        Thu, 20 Oct 2022 12:23:03 -0700 (PDT)
Received: from t60.musicnaut.iki.fi (85-76-8-144-nat.elisa-mobile.fi [85.76.8.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 204E9200C5;
        Thu, 20 Oct 2022 22:23:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1666293780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNxYWZtqhQJ3EBnB8jz3JWPqixt8xcwZe2p6tpEoE8Y=;
        b=EmkHLYuM9bMA98DxeONON4fIcT90tau9h2WSMOQJOlTiCoOvC2edtD/TvifBE0LdU4FaIQ
        xUXuj4mqFY+1rTI9OTXtplS5m6WLUcw2TMOVP4qtcmFckDRXvV845GkfqslVVsLM+e3xyF
        +Yd9pF3j9Ko7OWtoGOOsw26o7pNr8oY=
Date:   Thu, 20 Oct 2022 22:22:58 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: omap: Remove #ifdef guards for PM related
 functions
Message-ID: <20221020192258.GA3019@t60.musicnaut.iki.fi>
References: <20221020185047.1001522-1-paul@crapouillou.net>
 <20221020185047.1001522-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020185047.1001522-4-paul@crapouillou.net>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1666293780; a=rsa-sha256; cv=none;
        b=d9CzQI/102zmHVRTy51I4xghMb00z3jR9v6tK95ShM9/rN9iqzhDohMFNDex46pXOdw/HO
        O5xZOkQJYrd6LvY0gi6ebsCQqSJy4ja7aVE7YcA34irwNWO1khNa7mxXR6aLxeyjR2kt2v
        it2/g11MZFA+G+Wf/vijRS7atoCj74s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1666293780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNxYWZtqhQJ3EBnB8jz3JWPqixt8xcwZe2p6tpEoE8Y=;
        b=pZjHRPy6zdJ3wKa+yTHk+9CRs5ayFGBPqpgZR1//On2OJ2y1Vjsb/k50SpEqCZXx2A8VCC
        4wKtjcsAp4wMOSnEC7xEsGvbOgufQxK3JVt/8NN3SKf/Wew1oCROTSJv8/e06+SliHr/kA
        cJw5LDwhiwOa7N1ugNazSrwksPJ92LA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:50:46PM +0100, Paul Cercueil wrote:
> Use the pm_ptr() macro to handle the .suspend/.resume callbacks.
> 
> This macro allows the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> ---
>  drivers/watchdog/omap_wdt.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 74d785b2b478..e75aa86f63cb 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -316,8 +316,6 @@ static int omap_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef	CONFIG_PM
> -
>  /* REVISIT ... not clear this is the best way to handle system suspend; and
>   * it's very inappropriate for selective device suspend (e.g. suspending this
>   * through sysfs rather than by stopping the watchdog daemon).  Also, this
> @@ -353,11 +351,6 @@ static int omap_wdt_resume(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#else
> -#define	omap_wdt_suspend	NULL
> -#define	omap_wdt_resume		NULL
> -#endif
> -
>  static const struct of_device_id omap_wdt_of_match[] = {
>  	{ .compatible = "ti,omap3-wdt", },
>  	{},
> @@ -368,8 +361,8 @@ static struct platform_driver omap_wdt_driver = {
>  	.probe		= omap_wdt_probe,
>  	.remove		= omap_wdt_remove,
>  	.shutdown	= omap_wdt_shutdown,
> -	.suspend	= omap_wdt_suspend,
> -	.resume		= omap_wdt_resume,
> +	.suspend	= pm_ptr(omap_wdt_suspend),
> +	.resume		= pm_ptr(omap_wdt_resume),
>  	.driver		= {
>  		.name	= "omap_wdt",
>  		.of_match_table = omap_wdt_of_match,
> -- 
> 2.35.1
> 
