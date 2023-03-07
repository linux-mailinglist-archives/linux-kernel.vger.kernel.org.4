Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF586AE6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCGQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCGQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:39:59 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023C900A6;
        Tue,  7 Mar 2023 08:37:22 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso7451670ots.9;
        Tue, 07 Mar 2023 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678207041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlN3Hd9NH7mOlX+BzcqMzXEQ9etvjS+ej/djzDPYTH0=;
        b=pIOAmon3FzAc1jTqL2gC7i7uFbHIKda/mDrD6Fsn1huzX0iwJV1EBtbmy8oakKtxEa
         8LYRtqBpCCTjdQdoxbei5AM2TSUvQ7I8JsMcJj1G85Zlz09ykBw1JH/j0OAlIe+706kR
         C7IOUwcxyoRm5LnByCSNUSww/rlTKoaUPovFW2UWPPxTAlAj4R8n264XxGx0VJaTgu5P
         KxaDWboOEfnUZ3eZHyYkfJXZFz+hrk6P5aJj+vy4/X6N8T3a+orcnHZAaNpv6KH5OduB
         jP/vhbd6PyGjrBAilyCz1lQEbv9s1CxWSdb8oZ4uJMDWcBwYzXCIgRdzfx4N/wu4AnTN
         klCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlN3Hd9NH7mOlX+BzcqMzXEQ9etvjS+ej/djzDPYTH0=;
        b=HsfquIVJFYp9W1niIl1MbWro3LRH8u0KOz0kimE8oZDPCh6NXB57j0B3mzcGWrkHrf
         VTCIstnY0WsIoKO3GIAamZjYo0QohgZehiGVhadPlSE6xauY/JmQgC5EP/zM8Cf4hmaf
         xJxcy9sj7Rl1QJNtGxIspErwrXfhQKLmwEzTPpq8JMjBcL7fwKRwG7C4gsXwqNhj4xkq
         e9dhxui5udaLvbHxOM4C3Hd2ACLiDzJC4m4fD9g663ooGhHXT3huO7L2KVsbgQDuEQhE
         4x4Fi6YO+XNsdejFQm4ecpBsvn0ij8l70o7sX0o8VOWHykBCAmsjyA8XC30IKmiCrBzK
         YkkA==
X-Gm-Message-State: AO0yUKVu2ppuQwzp6WmBFzUQdlar/Z6WfabuPjt3z0BQJQwXSgxC8ChN
        AwG82PtBhvlN3T6+46jOxe8=
X-Google-Smtp-Source: AK7set/E9/ktmklL4iauj78AQ96RtIYiXnFYZ7eAH4rFLQaLOoKVHBLTpnZkyp+fXYwDEoY5/610xQ==
X-Received: by 2002:a9d:705c:0:b0:68b:bf5e:492c with SMTP id x28-20020a9d705c000000b0068bbf5e492cmr7547022otj.28.1678207040889;
        Tue, 07 Mar 2023 08:37:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s27-20020a05683004db00b00684c5211c58sm5452754otd.60.2023.03.07.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:37:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Mar 2023 08:37:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: Simplify using
 dev_err_probe()
Message-ID: <51057d03-f421-4e76-b293-d186ba0f78a2@roeck-us.net>
References: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
 <20230307065603.2253054-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307065603.2253054-3-u.kleine-koenig@pengutronix.de>
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

On Tue, Mar 07, 2023 at 07:56:03AM +0100, Uwe Kleine-König wrote:
> Make use of dev_err_probe() also for error paths that don't have to
> handle -EPROBE_DEFER. While the code handing -EPROBE_DEFER isn't used
> for these error paths, it still simpler as it cares for pretty printing
> the error code and usually needs one code line less as it combines
> message emitting and error returning. This also unifies the format of
> the error messages.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index f3de8ef499c3..e14d6d9050ce 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -601,10 +601,8 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
>  
>  		err = of_property_read_u32(dev->of_node,
>  					   "samsung,cluster-index", &index);
> -		if (err) {
> -			dev_err(dev, "failed to get cluster index\n");
> -			return -EINVAL;
> -		}
> +		if (err)
> +			return dev_err_probe(dev, -EINVAL, "failed to get cluster index\n");
>  
>  		switch (index) {
>  		case 0:
> @@ -615,8 +613,7 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
>  				&drv_data_exynosautov9_cl1;
>  			break;
>  		default:
> -			dev_err(dev, "wrong cluster index: %u\n", index);
> -			return -EINVAL;
> +			return dev_err_probe(dev, -EINVAL, "wrong cluster index: %u\n", index);
>  		}
>  	}
>  #endif
> @@ -653,10 +650,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
>  		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						"samsung,syscon-phandle");
> -		if (IS_ERR(wdt->pmureg)) {
> -			dev_err(dev, "syscon regmap lookup failed.\n");
> -			return PTR_ERR(wdt->pmureg);
> -		}
> +		if (IS_ERR(wdt->pmureg))
> +			return dev_err_probe(dev, PTR_ERR(wdt->pmureg), "syscon regmap lookup failed.\n");
>  	}
>  
>  	wdt_irq = platform_get_irq(pdev, 0);
> @@ -694,21 +689,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  	if (ret) {
>  		ret = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
>  					       S3C2410_WATCHDOG_DEFAULT_TIME);
> -		if (ret == 0) {
> +		if (ret == 0)
>  			dev_warn(dev, "tmr_margin value out of range, default %d used\n",
>  				 S3C2410_WATCHDOG_DEFAULT_TIME);
> -		} else {
> -			dev_err(dev, "failed to use default timeout\n");
> -			return ret;
> -		}
> +		else
> +			return dev_err_probe(dev, ret, "failed to use default timeout\n");
>  	}
>  
>  	ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
>  			       pdev->name, pdev);
> -	if (ret != 0) {
> -		dev_err(dev, "failed to install irq (%d)\n", ret);
> -		return ret;
> -	}
> +	if (ret != 0)
> +		return dev_err_probe(dev, ret, "failed to install irq (%d)\n", ret);
>  
>  	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
>  	watchdog_set_restart_priority(&wdt->wdt_device, 128);
> -- 
> 2.39.1
> 
