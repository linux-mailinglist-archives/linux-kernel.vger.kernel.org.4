Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF65606AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJTWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJTV75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:59:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3363372;
        Thu, 20 Oct 2022 14:59:49 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z11-20020a05683020cb00b00661a95cf920so716624otq.5;
        Thu, 20 Oct 2022 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARKH8V4OjwusuqSwsWSFzG2eaJLXUFsNfMNSJs9wECM=;
        b=QHLiWlFjoX5OUha/ys/iXAC4fg65Vf638ogS9SpT0lsl3GnzgKrCjmbrX72B14cu55
         TZzmNQvCnPhH9pBKFlYpxA/oE115jT7LvGo6IUONe2jDOGz0lxtKfTjnB4vYD3Lvdjdf
         1KxsSX/Mf8bxFkhNsVOQ3/l9wlk4McsQrey0r5ZzWRwgm5jSJ1ifDA1P4eJNAW0seKqd
         YNy1VDHfqq3SATFjrvEhtFn93VIaSZKIv6e/D42bWRbrVK/jl1SicFGnmlBEAFI8VEFW
         VuVz/ty8W/ekDinoR0vHCRuQPw63HIVC4xZjPweIDTLcjyKB946I+Cx/hNc2SjNF/mIE
         Riew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARKH8V4OjwusuqSwsWSFzG2eaJLXUFsNfMNSJs9wECM=;
        b=z1+9/bUWK7SfWWHgKOvPu7XyxIl6oAZp2H2fl5lz0nTkCX4+1K2YIDaphsugwYtnPz
         9mRiZXRbtLR3x0gayL/nIdm1qnk4gVzr71vM9BsEIeGNMYgE5TO0zBl2fKxzVIhTj/hY
         FbQTGEsz5n/OX86Bdv4Beqm4EGQyGv4Iruy0NM6zQdv2atceggx+cLovgMh6sgz8mdzI
         rSbgk43xl/RhPEqJwr4U1d6+hlHSO4KoIztUuOLj8vGekayVDIAF38Fxp5WxuinA/4KI
         Xq6KpeGaUzayrn5tJRMHTYK0LnZ+pQCgcPmZlAmm8sbiSxU1MSQMPFxRqewz4nlGNlUW
         U1ag==
X-Gm-Message-State: ACrzQf0rsYws4BudSD/SAK5k2exGWgQPBm51bEAR1U56zJHZF6Cw0iuH
        5ZuOdYPoGUocPGks1LBwJPXcGiWrwUw=
X-Google-Smtp-Source: AMsMyM6Bp5KAulmHuUu2awsZIpbNsyJIytpi5ilN12coZKK+TUs/+Xia9Oj5192t1KRIUT+AdtReMw==
X-Received: by 2002:a9d:191:0:b0:661:a5db:56d1 with SMTP id e17-20020a9d0191000000b00661a5db56d1mr8111675ote.125.1666303188712;
        Thu, 20 Oct 2022 14:59:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h23-20020a9d61d7000000b00661a1d92aacsm394776otk.33.2022.10.20.14.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:59:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 14:59:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog: twl4030: Remove #ifdef guards for PM
 related functions
Message-ID: <20221020215947.GB4035307@roeck-us.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
 <20221020185047.1001522-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020185047.1001522-3-paul@crapouillou.net>
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

On Thu, Oct 20, 2022 at 07:50:45PM +0100, Paul Cercueil wrote:
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
>  drivers/watchdog/twl4030_wdt.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
> index 36b4a660928d..09d17e20f4a7 100644
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -81,7 +81,6 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
>  	return devm_watchdog_register_device(dev, wdt);
>  }
>  
> -#ifdef CONFIG_PM
>  static int twl4030_wdt_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	struct watchdog_device *wdt = platform_get_drvdata(pdev);
> @@ -99,10 +98,6 @@ static int twl4030_wdt_resume(struct platform_device *pdev)
>  
>  	return 0;
>  }
> -#else
> -#define twl4030_wdt_suspend        NULL
> -#define twl4030_wdt_resume         NULL
> -#endif
>  
>  static const struct of_device_id twl_wdt_of_match[] = {
>  	{ .compatible = "ti,twl4030-wdt", },
> @@ -112,8 +107,8 @@ MODULE_DEVICE_TABLE(of, twl_wdt_of_match);
>  
>  static struct platform_driver twl4030_wdt_driver = {
>  	.probe		= twl4030_wdt_probe,
> -	.suspend	= twl4030_wdt_suspend,
> -	.resume		= twl4030_wdt_resume,
> +	.suspend	= pm_ptr(twl4030_wdt_suspend),
> +	.resume		= pm_ptr(twl4030_wdt_resume),
>  	.driver		= {
>  		.name		= "twl4030_wdt",
>  		.of_match_table	= twl_wdt_of_match,
> -- 
> 2.35.1
> 
