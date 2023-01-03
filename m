Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D465C8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjACVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjACVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:15:35 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC0F13F01;
        Tue,  3 Jan 2023 13:15:34 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id o66so28109422oia.6;
        Tue, 03 Jan 2023 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZxT7AkK4JaaocuB9JiHUjdT5b+M9kmcVxNv9bDE1Xk=;
        b=hyKqduVN0JDnk5wxAUL9GQHSV4jns03UucHDkmteolm5TZgNpxL2EaMOkLxxDSlvJ1
         ShLKzOu4l6/aWbkoqesrffKkSWE54qhMn30rRP09ZwafQqZVIDBvAvoV9LDOWTYjtxEA
         CbhORl05MF2SkUhABbzJHSW4kz0fUkncJZuMiQqPr4vkcuwiQ27szOmvoMB3dDCAZa1L
         WDQUamcG9Bs7/vJjOcnHC+DDrAekkN7sigpDpifc1DCFBiv8DFtPXHNIr7JvPdM05iWG
         0e5ctgmsqY5QDGLte61bXCOjhga6QA8C3oARjz0CJxEgn1TcVunuceWuFmIGiqFxy5k9
         9PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZxT7AkK4JaaocuB9JiHUjdT5b+M9kmcVxNv9bDE1Xk=;
        b=PgGOYhX4iz1Ji0KlDBd12oaZok/l/hwJtfYYRpulnolXOrb7mMm3LX67f91iBQXNp/
         He0yC5YmYb5pBo+vrf93tRab2vz0QmjbNwFq5AbK1zVNhOkcNsm29qfu+R72OGeQ1j34
         NtIeAa3PmJlaKaZRWoCH1sWN+ED82ORsh88yjF1QTMEXhay8t0B2cfXRrfK4lo5ZJbfs
         KfbqbulVRW+AvsZ6CM2oaQXJ6sS/0OLPFIsMcjDpIfXDnO8y3ztJylOCd7+W7+E8vILo
         wRW8qveLssmPq+RuSfdSRu8iG/pX/hbLhuZ1dnVMxzj+MbWomQvwd5gU+8mDVe34PYyj
         p4MQ==
X-Gm-Message-State: AFqh2ko7fOuI1LA65QIDM9X8hG+lQAKLd6ByxXpcdXY6S4AFeeEnE7f5
        GKa1zTJ/+Z2CSnjW74dyGZ0=
X-Google-Smtp-Source: AMrXdXu4WIyav5RtdaBHBeekV7IxuWtMs8Epo1jBJL+gverOfxMVuMA4aZVXLdGGCh9sPH23aq6hdQ==
X-Received: by 2002:a05:6808:191e:b0:35e:9838:162b with SMTP id bf30-20020a056808191e00b0035e9838162bmr32514408oib.14.1672780533962;
        Tue, 03 Jan 2023 13:15:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b24-20020a056808011800b0035b99bbe30bsm13464438oie.54.2023.01.03.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:15:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:15:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pic32-wdt: Use devm_clk_get_enabled() helper
Message-ID: <20230103211532.GE212337@roeck-us.net>
References: <4335b4201b535ebc749a98bad0b99e3cb5317c39.1672496563.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4335b4201b535ebc749a98bad0b99e3cb5317c39.1672496563.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 03:22:57PM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/pic32-wdt.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
> index 41715d68d9e9..6d1a00222991 100644
> --- a/drivers/watchdog/pic32-wdt.c
> +++ b/drivers/watchdog/pic32-wdt.c
> @@ -162,11 +162,6 @@ static const struct of_device_id pic32_wdt_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, pic32_wdt_dt_ids);
>  
> -static void pic32_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int pic32_wdt_drv_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -186,22 +181,12 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
>  	if (!wdt->rst_base)
>  		return -ENOMEM;
>  
> -	wdt->clk = devm_clk_get(dev, NULL);
> +	wdt->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(wdt->clk)) {
>  		dev_err(dev, "clk not found\n");
>  		return PTR_ERR(wdt->clk);
>  	}
>  
> -	ret = clk_prepare_enable(wdt->clk);
> -	if (ret) {
> -		dev_err(dev, "clk enable failed\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, pic32_clk_disable_unprepare,
> -				       wdt->clk);
> -	if (ret)
> -		return ret;
> -
>  	if (pic32_wdt_is_win_enabled(wdt)) {
>  		dev_err(dev, "windowed-clear mode is not supported.\n");
>  		return -ENODEV;
> -- 
> 2.34.1
> 
