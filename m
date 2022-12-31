Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9465A652
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiLaT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiLaT3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:29:33 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D9764E;
        Sat, 31 Dec 2022 11:29:33 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12c8312131fso28300293fac.4;
        Sat, 31 Dec 2022 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMJefebfXJA7bVT551UtWnm/lYehGHM3tdJ6FqrrgtQ=;
        b=ED+Gem04Ga3wpzxKuiUYl4DBeGAPrrQd8EkPIVFAJGc+GhjI2tthZ6G76X4xZNuANn
         Nd7FkhaYDdyk2jpcvW+K7ZBvdnwIA0BDsp0oX9LRgGlAs8FnWxz4l1B4vBjvCZsb6kAn
         HXPSfBVpOUJFpWbbSmoefS/8x+0YnXP7+mBThrXgBQVvddjl+jqHtr3ku2fYwmZHEVk3
         Hex7/LIqQISuEVEUXofM4772qjKI43R6Nw/ueOKk8KT/SXMnw8cu408fr/PU/RGoIGL/
         umDBRmDRZoO48b0t4gF5sqe2KpLtDQABLhFISrV/jmEIaWMDCiQw/PqBid/Z+Y5SXCYZ
         j/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMJefebfXJA7bVT551UtWnm/lYehGHM3tdJ6FqrrgtQ=;
        b=u6JxKLHWZR9k4HCltwS9aUbEMZxd4APy6bVyltYYPgfBXNcd58ZV3iL3l4x0xpuUaO
         OLdscpNxbNYIRVvm4RP5jA3hIFKsxFqeGnjmeIDGEM5Om1jauedFaEFgatWCW82/r0zG
         MzetRypsu9+il8e9euA3PlYXFTikaImOg9X9NWP0ilwsyelyt1Xt4/epQL5eifn9kwZw
         96T7VJ1NF/s+dl1XF1x7KeaEdVqLpTf8PYIqhffttyQV1GPZmQWWWkSzNG9BEhZljV1q
         FJJEUdCmos7oZA98QbeMd2z6hz9fLKRQdMv0fVdU1eg96Z0m16YlbikkFWMLmoxZPtdG
         w3rA==
X-Gm-Message-State: AFqh2krBc68RBT6ZrEu0kRQ9Vo77SCX0M1k7S/PB0PGdHb8tM8/GUJuk
        OyqXCy404evhkPZpS4Ms+JM=
X-Google-Smtp-Source: AMrXdXv0C+YLQUmmdhVwRc0RSGWIeIdpiE9lDMIxnwb3S2YJmIG6Vg+ODrE3Bfuo04/ZxIYe2/OVuA==
X-Received: by 2002:a05:6870:46a6:b0:148:15ba:886d with SMTP id a38-20020a05687046a600b0014815ba886dmr21013018oap.54.1672514972404;
        Sat, 31 Dec 2022 11:29:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p66-20020a4a4845000000b004908a9542f8sm9721518ooa.31.2022.12.31.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 11:29:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 11:29:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence: Use devm_clk_get_enabled() helper
Message-ID: <20221231192930.GD3434944@roeck-us.net>
References: <615c6c3c46c3ee8e3136725af0ab0b51e1298091.1672474336.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615c6c3c46c3ee8e3136725af0ab0b51e1298091.1672474336.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 09:12:28AM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/cadence_wdt.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index bc99e9164930..23d41043863f 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -274,11 +274,6 @@ static const struct watchdog_ops cdns_wdt_ops = {
>  	.set_timeout = cdns_wdt_settimeout,
>  };
>  
> -static void cdns_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  /************************Platform Operations*****************************/
>  /**
>   * cdns_wdt_probe - Probe call for the device.
> @@ -333,21 +328,11 @@ static int cdns_wdt_probe(struct platform_device *pdev)
>  	watchdog_stop_on_reboot(cdns_wdt_device);
>  	watchdog_set_drvdata(cdns_wdt_device, wdt);
>  
> -	wdt->clk = devm_clk_get(dev, NULL);
> +	wdt->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(wdt->clk))
>  		return dev_err_probe(dev, PTR_ERR(wdt->clk),
>  				     "input clock not found\n");
>  
> -	ret = clk_prepare_enable(wdt->clk);
> -	if (ret) {
> -		dev_err(dev, "unable to enable clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, cdns_clk_disable_unprepare,
> -				       wdt->clk);
> -	if (ret)
> -		return ret;
> -
>  	clock_f = clk_get_rate(wdt->clk);
>  	if (clock_f <= CDNS_WDT_CLK_75MHZ) {
>  		wdt->prescaler = CDNS_WDT_PRESCALE_512;
> -- 
> 2.34.1
> 
