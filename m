Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB26ACA92
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCFRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCFRdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:33:33 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246E69CF7;
        Mon,  6 Mar 2023 09:32:38 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t22so7618673oiw.12;
        Mon, 06 Mar 2023 09:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jU1OOkRe9SQAzExqSarRKsrqG7UQRcNhBjXmNaUsVSE=;
        b=HpEkioNg+nYs4nYGdyfWvxU2hqEPwEZvGGoPQe5HWao7HZin5g6zrdI1+Ld/kU9nI/
         ps5pw9yOBOdu6OwT7TBAdosEL5ZoL5aqepdYvUZ/kcaLJcvyGGUAMv69eEXY2U+rpoop
         6ZvlyPT3w/Hfu+NOmfdAIP2FYNkU+GXn3PAOIAb6Gfac2YSOZ0tKuJ+2Q9Frww3woxOD
         yiOSoa6f980yh6CcGforY8JXExuX7ja9T7UrOoYa3KiIw/y3PVDP9gfbF5TcD5761qDb
         8tDfGPjiJyY4owvCnYyOpxZcj/QjG2thSq1x1yiXai6fVbaSGs+kgNL8DFcQuMsS91ui
         M60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1OOkRe9SQAzExqSarRKsrqG7UQRcNhBjXmNaUsVSE=;
        b=jdN+OykdJe6qdMLVsBAvtjGk+sBscmAfi45dXP03Eg9pJxHG4JyA3xxOo3nQAvwUP+
         5VORHOzQU8URH9TbA6CFYPznX7PDMX4QyeVIx1esPnEyxREv+qH3ZBXfIv7e89CJIPTm
         5fFKwXxcoVwKa6CZRszJv6T1Ztoaqhyv6XtwEevG8zk/arfMjVd7pom9mMMorhn0pbZj
         wNFggo+VjHc5uvvPHLVreLEfi/ndlBvTdFIbHHljDC2T/cb0JG9vOKZJSFC6WBgT92aY
         CZAZjXgrCXvlHaH/X1CYWYPQuWT+ipENtaxu8vyOmZxHPCrT06k1WnzF5i8RpfbUkZFl
         Ca9A==
X-Gm-Message-State: AO0yUKWSw3TPaBdgC+8Iz10dAjHIS0ZzxoIDgr0ifKpiMtmjSL79mY1h
        ESuhlQEUY7UNP6/hW8XK73M=
X-Google-Smtp-Source: AK7set+IyP8l4CzxJssq1QDLPD6sqKYN/VotOb0/7twUScSaSrz2BnBD5vIo4IdmYn8pi7/uZz2k0w==
X-Received: by 2002:a05:6808:274a:b0:383:f91b:cf5 with SMTP id eh10-20020a056808274a00b00383f91b0cf5mr4841179oib.53.1678123873520;
        Mon, 06 Mar 2023 09:31:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020aca6202000000b00383bfd8a184sm4209950oib.25.2023.03.06.09.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:31:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Mar 2023 09:31:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/3] watchdog: rn5t618: Simplify using
 devm_watchdog_register_device()
Message-ID: <c029adf2-7f7e-452f-bc35-b2ecbf0d3128@roeck-us.net>
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
 <20230306170901.2232323-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306170901.2232323-3-u.kleine-koenig@pengutronix.de>
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

On Mon, Mar 06, 2023 at 06:09:00PM +0100, Uwe Kleine-König wrote:
> This allows to drop the .remove() function as it only exists to
> unregister the watchdog device which is now done in a callback
> registered by devm_watchdog_register_device().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rn5t618_wdt.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
> index 40d8ebd8c0ac..c0aee627ff3b 100644
> --- a/drivers/watchdog/rn5t618_wdt.c
> +++ b/drivers/watchdog/rn5t618_wdt.c
> @@ -178,21 +178,11 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, wdt);
>  
> -	return watchdog_register_device(&wdt->wdt_dev);
> -}
> -
> -static int rn5t618_wdt_remove(struct platform_device *pdev)
> -{
> -	struct rn5t618_wdt *wdt = platform_get_drvdata(pdev);
> -
> -	watchdog_unregister_device(&wdt->wdt_dev);
> -
> -	return 0;
> +	return devm_watchdog_register_device(&wdt->wdt_dev);
>  }
>  
>  static struct platform_driver rn5t618_wdt_driver = {
>  	.probe = rn5t618_wdt_probe,
> -	.remove = rn5t618_wdt_remove,
>  	.driver = {
>  		.name	= DRIVER_NAME,
>  	},
> -- 
> 2.39.1
> 
