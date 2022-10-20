Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2256606AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJTV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJTV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:59:40 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DFF3ECE4;
        Thu, 20 Oct 2022 14:59:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13af2d12469so1228762fac.13;
        Thu, 20 Oct 2022 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpKyyfWkb62lUIceh7gyV/N6Kg54kc5jJ2XC2VNLnUM=;
        b=mHR7V41ApUDBGiYLMp2rxWBH8UQDoI0+iRXCdB+dyDfhHdo6aK0V2D7+7rbSuOvSSx
         hkDkw5tY/7XugrnfduadrQCcPHDIMgxwtk/2ohzAQjM1Qh3TbhZdlUslg4jwLP5iIPVi
         nz6AXYzp/wP2yPCG42Na5YN7W875N4nhO3VZzknnlB15KDMKLxWzHSyY9kj84UZ2xvfI
         J2jl2ixSM5TsRP7gGdHGkzNMnR56mkbg0bfsx/OzVI4YMrvLm3crckHSZm9ok3g4FoMF
         +egrPk7DIVY/pNq/b9bNDjU8Jt1CaISX4dlubm/pVXLsqscC+FDKzJLK7KQPrg+gjI8t
         8DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpKyyfWkb62lUIceh7gyV/N6Kg54kc5jJ2XC2VNLnUM=;
        b=a5GFQUi/4VLcVuHlVXSipcJsH96uCb0leUKJoQ9Y6R4Ggq2zaob+27g5N21ENi4jme
         sIFVKGH5/J570HXQDwK0nYFw8gacDNU2AciAu3r0yZ/lryxAaEwIuPPTxPydu97yhVRD
         vhyHiicXpBuu4PmWOP40/IgiOFgknJIWFk7c7ofoqX7AkOcM2ZnVmoK28uOIwQvUmo+T
         wu52XR4+JCf6o9CRxz2+werXEo+8Qf646/LenI3hv42gVALItNfk20kePSZEhNf63wMp
         JSuAF75VoR9km7mVcjm1M3pEHlyqzprUsvtkmrwkE7BSrovApL+GI0x7hzJukyb7vxK4
         P9jw==
X-Gm-Message-State: ACrzQf2Ep5e6LDJcdQ+GpuB3MRjriQH7jkA9KoAhEkY91bkuJDz+iwg+
        WqO55XwLkpm7/sxg6WChgokE6nTjtrg=
X-Google-Smtp-Source: AMsMyM5vpBPfIaIeco5D6jMKvwrZ8L7UWSZAqNhqnnYMq6szIAcfiSKIjf4gmY5rIcXAGbdP/WlQxw==
X-Received: by 2002:a05:6870:344b:b0:133:2265:780c with SMTP id i11-20020a056870344b00b001332265780cmr26776518oah.164.1666303176493;
        Thu, 20 Oct 2022 14:59:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t33-20020a4a96e4000000b00480fd9f311esm543483ooi.13.2022.10.20.14.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:59:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 14:59:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] watchdog: at91rm9200: Remove #ifdef guards for PM
 related functions
Message-ID: <20221020215933.GA4035307@roeck-us.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
 <20221020185047.1001522-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020185047.1001522-2-paul@crapouillou.net>
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

On Thu, Oct 20, 2022 at 07:50:44PM +0100, Paul Cercueil wrote:
> Use the pm_ptr() macro to handle the .suspend/.resume callbacks.
> 
> This macro allows the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
>  drivers/watchdog/at91rm9200_wdt.c | 11 ++---------
>  drivers/watchdog/db8500_wdt.c     |  9 ++-------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
> index 6d751eb8191d..5126454bb861 100644
> --- a/drivers/watchdog/at91rm9200_wdt.c
> +++ b/drivers/watchdog/at91rm9200_wdt.c
> @@ -278,8 +278,6 @@ static void at91wdt_shutdown(struct platform_device *pdev)
>  	at91_wdt_stop();
>  }
>  
> -#ifdef CONFIG_PM
> -
>  static int at91wdt_suspend(struct platform_device *pdev, pm_message_t message)
>  {
>  	at91_wdt_stop();
> @@ -293,11 +291,6 @@ static int at91wdt_resume(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#else
> -#define at91wdt_suspend NULL
> -#define at91wdt_resume	NULL
> -#endif
> -
>  static const struct of_device_id at91_wdt_dt_ids[] = {
>  	{ .compatible = "atmel,at91rm9200-wdt" },
>  	{ /* sentinel */ }
> @@ -308,8 +301,8 @@ static struct platform_driver at91wdt_driver = {
>  	.probe		= at91wdt_probe,
>  	.remove		= at91wdt_remove,
>  	.shutdown	= at91wdt_shutdown,
> -	.suspend	= at91wdt_suspend,
> -	.resume		= at91wdt_resume,
> +	.suspend	= pm_ptr(at91wdt_suspend),
> +	.resume		= pm_ptr(at91wdt_resume),
>  	.driver		= {
>  		.name	= "atmel_st_watchdog",
>  		.of_match_table = at91_wdt_dt_ids,
> diff --git a/drivers/watchdog/db8500_wdt.c b/drivers/watchdog/db8500_wdt.c
> index 6ed8b63d310d..97148ac0aa54 100644
> --- a/drivers/watchdog/db8500_wdt.c
> +++ b/drivers/watchdog/db8500_wdt.c
> @@ -105,7 +105,6 @@ static int db8500_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
>  static int db8500_wdt_suspend(struct platform_device *pdev,
>  			     pm_message_t state)
>  {
> @@ -130,15 +129,11 @@ static int db8500_wdt_resume(struct platform_device *pdev)
>  	}
>  	return 0;
>  }
> -#else
> -#define db8500_wdt_suspend NULL
> -#define db8500_wdt_resume NULL
> -#endif
>  
>  static struct platform_driver db8500_wdt_driver = {
>  	.probe		= db8500_wdt_probe,
> -	.suspend	= db8500_wdt_suspend,
> -	.resume		= db8500_wdt_resume,
> +	.suspend	= pm_ptr(db8500_wdt_suspend),
> +	.resume		= pm_ptr(db8500_wdt_resume),
>  	.driver		= {
>  		.name	= "db8500_wdt",
>  	},
> -- 
> 2.35.1
> 
