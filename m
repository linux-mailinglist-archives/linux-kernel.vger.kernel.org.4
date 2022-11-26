Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DFB6392C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKZAew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiKZAet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:34:49 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225B5B5A9;
        Fri, 25 Nov 2022 16:34:46 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v81so5972721oie.5;
        Fri, 25 Nov 2022 16:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iM7ET6EbhqLG7ZikTWYHO9npthIfHL6Ui48nWAdew8E=;
        b=P8zCKWepFpqociAzqaSuKaEKj82UoEfQXOZf6GkJ0mu4l965VSCuWR3n5nGiyFBRyp
         HgopUf8UT/zadN/4kpEE/K+ErE2UD8QWAS2WZUoWsXnAPSLYzAOt1Po5yJ/cuw30ZxQ3
         Bk609/KYFMcYGBJjoRnoZ/8iA7oz301WdE6MxeYJ2yks9nV1laC4U+GyIL7VClD3TZir
         Y4jmHFldVjZROM1G68D7hN/83NHK8WL0d5y9HnZ6vGKFwDbHNGIDEKjxXfunLSxoGHDy
         Uq2GgJTQ6DR6sdU0PTV+Y0PiOEU4mYvxpio2h0MTdg84UjK5a7KFKg1d1c7p4T1L+LbT
         +EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iM7ET6EbhqLG7ZikTWYHO9npthIfHL6Ui48nWAdew8E=;
        b=c4boLaL5F2QGMfz2O2TsVye94Ig7DlNmzDEd5PZCNgdYKjUi/Mp7oM6WWflcJQHzj8
         2jtfj+JZfTkY960pTG34kwWvnp6BowxP+3V7Gkevu4mCx5GiYnbK35rlEGqXHMuCGvqL
         agYAxdXUZ8hahr1OCeRsmcwspq6YDQDJP0lx27E1tNvNgRgbfyP3K2H7VCxht792COZ6
         bDUnwwaDuGB/JEZaM+xnJf3NoNgswEoIQORHo3be4qBic5tK81k2StFuQHwmngZdXCF0
         YkKWcr+V/aR7AzjMJK3o6q/jB+sFhb6z96Te9BULYtVz6aHz5LNe62VdluEKKQnqm2bz
         Bl8Q==
X-Gm-Message-State: ANoB5pkbFoe8kGXE8OOcnTEyYaQF1hyYdjnjQSma9yxv+1tLPnaFlz9N
        Xd36CGyx7j+45VMCEjW+iqMOHwQVxhQ=
X-Google-Smtp-Source: AA0mqf6T7r96tZXdrqyuqWEokrJCxCpXAZQllli9yqePZ8267iGHap9+BB+6cFl2H071Lhthg/i79g==
X-Received: by 2002:a05:6808:19a0:b0:359:d42b:4d53 with SMTP id bj32-20020a05680819a000b00359d42b4d53mr9859488oib.145.1669422885971;
        Fri, 25 Nov 2022 16:34:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j44-20020a4a946f000000b0049fcedf1899sm2080131ooi.3.2022.11.25.16.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:34:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <acf780ec-11e4-bd1c-e931-c430f5e43edd@roeck-us.net>
Date:   Fri, 25 Nov 2022 16:34:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] watchdog: iTCO_wdt: Report firmware_version
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125221240.2818-1-linux@weissschuh.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221125221240.2818-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/22 14:12, Thomas Weißschuh wrote:
> Synchronize the reported information in dmesg and the watchdog APIs.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/iTCO_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 34693f11385f..9b3c9f8b0b93 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -437,11 +437,10 @@ static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
>    *	Kernel Interfaces
>    */
>   
> -static const struct watchdog_info ident = {
> +static struct watchdog_info ident = {
>   	.options =		WDIOF_SETTIMEOUT |
>   				WDIOF_KEEPALIVEPING |
>   				WDIOF_MAGICCLOSE,
> -	.firmware_version =	0,
>   	.identity =		DRV_NAME,
>   };
>   
> @@ -562,6 +561,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>   		break;
>   	}
>   
> +	ident.firmware_version = p->iTCO_version;
>   	p->wddev.info = &ident,
>   	p->wddev.ops = &iTCO_wdt_ops,
>   	p->wddev.bootstatus = 0;
> 
> base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536

