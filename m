Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DBB65A81A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiLaXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiLaXPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:15:00 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24ABA1A9;
        Sat, 31 Dec 2022 15:14:53 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j130so16570425oif.4;
        Sat, 31 Dec 2022 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDleaKjLD/Qhd9h4aoa9p72UIb8nR7MniYX4gWrbZJ0=;
        b=fvljcvxNh25c4C4r8wjp9qbv8SnqWuMLLk2PQnHdVmrzc4V10Dpo2YaG6RIPvfSyti
         6G/wSVQr4nHyu5tL/t5m6QCNt9GdoL93d7xQovRDTO0fh45rKWFiNBYXRRbYOeqPxMVu
         TSJ2M818/a/cQ9S6bgKMV5tDxtb8T/Y9/KyWg2lCKEV4i1k+rcPytpzW1qvnQqFTxp2n
         kqhVSkSJSbAtarW8bT1D5FhAsIoWS0pugA74rdoptF7xmZlpt9jvDaOEKQvkyHAO6nG+
         ayCo1LVnXK4hnESVGn26XYv0qYoIok4sAb0OXJzygzGWptz+pEO8YPdAkAG8+m9+KkQS
         RwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDleaKjLD/Qhd9h4aoa9p72UIb8nR7MniYX4gWrbZJ0=;
        b=4DKm3zU6o0d8b+7VDWqGxySi/mQA7wmeuUI/lm6Wy1M5mz22VVuAZyNNemSuXnhsf6
         l6wgELrCUeLs2dV60TCNMA0Z0NQ12P/cC/gF+wUtlwam+vhv781QXZxHQMaS993/rJXr
         H1laI+WZcfxbN3V49p/cD8xQ9+c37JKv8BpjMxVP07o9WvOPheTLB/GZthd2AWXX0pUh
         /Wb1+d8YhmTvONObdtiqknjV71RwQUJLkHOQEp/EOPGoVOH8Bay54BN7vzFs2u1IRK++
         DpZ2ciKOsEsy7pETOaGNy/kqkAY4ghP4u5Lj5UPHoSKWfB8RD9FB5gVVhcOeo/BLJdRR
         31wQ==
X-Gm-Message-State: AFqh2kpnB8A0Z88F27rNlg6UFaJuJcDbUe7hCAtfeRmavmizq5WO0dOR
        c4CeIxObMsCCkzbGqXyMAZY=
X-Google-Smtp-Source: AMrXdXvbeWxhfQuo5xiDU/qMBeTB4+1RFn1jBaNc8KUAdE+pwSdb7RD5B9ynzZc+vV5I1SyO3Tfx7Q==
X-Received: by 2002:a05:6808:2206:b0:361:2c10:fb53 with SMTP id bd6-20020a056808220600b003612c10fb53mr20261279oib.44.1672528493074;
        Sat, 31 Dec 2022 15:14:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020aca1706000000b0035a64076e0bsm10541481oii.37.2022.12.31.15.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 15:14:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 15:14:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
Message-ID: <20221231231451.GD2706156@roeck-us.net>
References: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 12:07:27PM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Note that I get a compilation error because read_cpuid_id() is not defined
> on my system (x86_64).
> So I think that a "depends on ARM<something>" in missing in a KConfig file.

It has

	depends on ARCH_IXP4XX

and CONFIG_IXP4XX_WATCHDOG is not set for me after "make allmodconfig".

> 
> Fixing it could help compilation farms build-bots.

Mine doesn't see a problem, and I don't recall ever being alerted about
one. What am I missing ? Do you see a problem reported anywhere ?

Guenter

> ---
>  drivers/watchdog/ixp4xx_wdt.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
> index 281a48d9889f..607ce4b8df57 100644
> --- a/drivers/watchdog/ixp4xx_wdt.c
> +++ b/drivers/watchdog/ixp4xx_wdt.c
> @@ -112,12 +112,6 @@ static const struct watchdog_info ixp4xx_wdt_info = {
>  	.identity = KBUILD_MODNAME,
>  };
>  
> -/* Devres-handled clock disablement */
> -static void ixp4xx_clock_action(void *d)
> -{
> -	clk_disable_unprepare(d);
> -}
> -
>  static int ixp4xx_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -139,16 +133,10 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
>  	 * Retrieve rate from a fixed clock from the device tree if
>  	 * the parent has that, else use the default clock rate.
>  	 */
> -	clk = devm_clk_get(dev->parent, NULL);
> -	if (!IS_ERR(clk)) {
> -		ret = clk_prepare_enable(clk);
> -		if (ret)
> -			return ret;
> -		ret = devm_add_action_or_reset(dev, ixp4xx_clock_action, clk);
> -		if (ret)
> -			return ret;
> +	clk = devm_clk_get_enabled(dev->parent, NULL);
> +	if (!IS_ERR(clk))
>  		iwdt->rate = clk_get_rate(clk);
> -	}
> +
>  	if (!iwdt->rate)
>  		iwdt->rate = IXP4XX_TIMER_FREQ;
>  
> -- 
> 2.34.1
> 
