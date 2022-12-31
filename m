Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C794665A7FB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiLaXJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiLaXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:08:59 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFDA267D;
        Sat, 31 Dec 2022 15:08:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id u204so21718712oib.7;
        Sat, 31 Dec 2022 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdhFSaUyyooJRYrsLbS1pmk011oIfeEFmUexZWQ1AhU=;
        b=pWiEK8IvBa5CGqs4FvjFuxOtzh6+vbIahEEDlJ0Kgba5HJ1J25jLsicbvSx5jql3Yy
         iEAaXUDaDRzekHCXnDtGcRneD/RdGHvKyAzhlPc2Uvltj7iHoWj7jkPp+XeLj+U/uQZs
         jjlJLNFHn8yIreZ8B/vyHO7W7UX0GWRL9U1FH1y1QYS2vib9ifb5hh2fLjH+0qObZT5/
         V7vQ9pIByQlG00s0DoNb8psFz17ZxLwVbhg9UTPZf0DwwPZ4K282RHxbUMPIg1TqJIKV
         JWex7Tm1dxebphWcwsIEk1pt1wQK5OLuuszVJ+p/JbNNx/vvDJmeQBaM7JjudUHJytgw
         7lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdhFSaUyyooJRYrsLbS1pmk011oIfeEFmUexZWQ1AhU=;
        b=l6uwjpD4JRpkIr2UgF2xbsAG00YCPAZND/kZiuVH5IIxkVTNHX84jOjsqQ7+frUYsK
         bJG5NpUgaP0mRsqLNDD4hwL3eBxnjpT31Xn/Yxh8F/xmw2PE9HtEzL015cyCzJLbPJeu
         kj2c2lto2FTC4x3fFppUvVmYH7ZvakdxnfRJFNJ4lBtf0QECv9a6Z4jF0ZV458HwRyG2
         nV7ZQqwQO6G73yeE/B3YCI0zayqdEeDz55DJiGRUCuMvpRdRAzqqaN0GjDT9n2Dq3TMO
         ZE63L4MDTBGDP3GAIhXiUgYjxTTc88/hVwEfnwTBRfYoxVGlaq3ZttJeAKNAhdlEGR9U
         LaPQ==
X-Gm-Message-State: AFqh2koHbGnTdqm0af8GkE+aQnIAt2WrwTI6RoNSpVlJvg6eNDpqiXq7
        6bSrqIen5+DLV3wEkfbfTzY=
X-Google-Smtp-Source: AMrXdXtawS7y2vgg5ldfvcO49lsoNYM3L/h+WugxWqXIJqTSCNVdU7Kw9p1x3K+elyrSPDTGJ25Ikw==
X-Received: by 2002:a05:6808:5c3:b0:35e:b863:1cfc with SMTP id d3-20020a05680805c300b0035eb8631cfcmr22491146oij.26.1672528137730;
        Sat, 31 Dec 2022 15:08:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bk13-20020a056830368d00b00667ff6b7e9esm12275525otb.40.2022.12.31.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 15:08:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 15:08:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: davinci: Use devm_clk_get_enabled() helper
Message-ID: <20221231230855.GA2706156@roeck-us.net>
References: <6a4cf8e8b9d8f555c77395ba2ecadc205553774d.1672483046.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4cf8e8b9d8f555c77395ba2ecadc205553774d.1672483046.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 11:37:39AM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/davinci_wdt.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 584a56893b81..5f2184bda7b2 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -189,14 +189,8 @@ static const struct watchdog_ops davinci_wdt_ops = {
>  	.restart	= davinci_wdt_restart,
>  };
>  
> -static void davinci_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int davinci_wdt_probe(struct platform_device *pdev)
>  {
> -	int ret = 0;
>  	struct device *dev = &pdev->dev;
>  	struct watchdog_device *wdd;
>  	struct davinci_wdt_device *davinci_wdt;
> @@ -205,21 +199,11 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>  	if (!davinci_wdt)
>  		return -ENOMEM;
>  
> -	davinci_wdt->clk = devm_clk_get(dev, NULL);
> +	davinci_wdt->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(davinci_wdt->clk))
>  		return dev_err_probe(dev, PTR_ERR(davinci_wdt->clk),
>  				     "failed to get clock node\n");
>  
> -	ret = clk_prepare_enable(davinci_wdt->clk);
> -	if (ret) {
> -		dev_err(dev, "failed to prepare clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, davinci_clk_disable_unprepare,
> -				       davinci_wdt->clk);
> -	if (ret)
> -		return ret;
> -
>  	platform_set_drvdata(pdev, davinci_wdt);
>  
>  	wdd			= &davinci_wdt->wdd;
> -- 
> 2.34.1
> 
