Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF1606AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJTWAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJTWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:00:13 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A74210B78E;
        Thu, 20 Oct 2022 15:00:08 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-13ae8117023so1257841fac.9;
        Thu, 20 Oct 2022 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mADrD5kqZ/aWrDx8+xfVy4IIeq0xlwp2VEYiTpJwCPg=;
        b=Q7t7Sk3IMTefNmRlElWe23sXJSE+xUcHKmdPRosUNJY9MKcRBkV16rF92pkbmJj3y9
         TshRhELiOAVYg2+voo6loNbXHIJhAACYivxSq/Wy11q8y1JnOLSJ9wEFU7qVO9hUSv9k
         h8GWf/zt6QIkxDmOJBwPqGe9Iq9P1WozuQHEGh433mvN2vxj1BQ3xPNfLXj5yJdF21nb
         oQ/3TzGbyP6l3Vpac3ppfDHznMGaYw3UZbinK+4pNYhBiX+QVL/xIR6+quVL1mD2Bq7p
         XdnKQ1gkxLGZY4uv3yfpCQb8R5GjksUAcqCtEN5JfnVEmoO8BxUZDUygb25Rtr4QE2S3
         vuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mADrD5kqZ/aWrDx8+xfVy4IIeq0xlwp2VEYiTpJwCPg=;
        b=cbMGnKSAHAmIi/zGmhM7TyIFwZDf1HObFLqhd+xYA2kG3FqDUTm70ffJiHP7I/hsLF
         CNLwBWxrk3uRMuvc29ElQwHoBPBKDkGtEo6iZVRuvR7zuYeTQdI4ukRZFEBIRE4slTdB
         J5BoVMsrAMB27zG9YwGD66re5VO2+izUEDPE7BIcERRH/AnD/CC3Gqgin634dnJBlG79
         PP3UCaUdSfz4hdJZ3YF6MOYvMynJ4CDYcDk6GkgKn7g/IW7G51yH4ymQWuFC9GTEhPNx
         tefdsO3OVTNvUVhxT/H3WWDNYeM7ojNbnEf38EQ9nCibPAd3sHUjHdV+Ab/HuRasdrgl
         o7GA==
X-Gm-Message-State: ACrzQf3p0yehiOovvXmxjkwLMQD9J9/aVoG6xYC/S8OoXCEj/ywKOexq
        soRWgS055elhM5bfBXcCOck=
X-Google-Smtp-Source: AMsMyM7a2jcQriM9sV+NON7Zf7PX03Znjkv4gAjl8Lhp5FKb1qq4xwyietbaenKl9y1nU4ARxwH9og==
X-Received: by 2002:a05:6870:a198:b0:136:6459:b294 with SMTP id a24-20020a056870a19800b001366459b294mr10505915oaf.43.1666303207397;
        Thu, 20 Oct 2022 15:00:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id db10-20020a0568306b0a00b00661a80d555fsm398041otb.40.2022.10.20.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:00:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 15:00:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: omap: Remove #ifdef guards for PM related
 functions
Message-ID: <20221020220005.GC4035307@roeck-us.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
 <20221020185047.1001522-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020185047.1001522-4-paul@crapouillou.net>
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
