Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD06AED37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCGSCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCGSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:02:02 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61169A8C58;
        Tue,  7 Mar 2023 09:55:21 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-176b48a9a05so8475427fac.0;
        Tue, 07 Mar 2023 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678211720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHG36lzNr+0MKns2Z8CLtBxE1/BWaAWLiQcYx5kbvTI=;
        b=h69phTOnMkva0qAJniwtPXqWnZBB20ZvoeVHVDLVJeHrLgcfFPWj38k4itcLwOlnNv
         M7pb3iPMH1VFpISaJDqXvTteYXF4Z4r1jLkxDHAdZ2aEhBdPCJP2OqDCShTgU8nmPKw+
         Q19CsP7x7F0TGZENf70DfPyC7y/W101avtunhvAwGnngUEb1ur+wecqw13nbLG0wUCka
         bVk5ke4C6JWtUe8waZPrDggLV8hSYe83++9bFfLam/jyG8N39Ic1Cvjuw1nqCFgGUtxi
         i6RxGkL0FxXBgBXvIQLbxiZ5DDXfUOPvex82NewhYQZx1wqjvgnTu1Uy5ssDaf6/VLDc
         beww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHG36lzNr+0MKns2Z8CLtBxE1/BWaAWLiQcYx5kbvTI=;
        b=jN92wPCVHuZRgga4051t60L7r9p134hrfm8XNKm2aXhUuwDMCIhnU7MaQjOnyQkN89
         Fec+k4rSpZlSd1sEwSW7FB69z17NLDNU2fLXe0aquZX5J8D4Ah1MPsSgzyxW7tUPSgvp
         SD+3JjVLjW4JPQBe6obfn1bxXb809g4kusjL0XS7Lot0JLvyETk1QWdNXdj/MQj/83Ht
         ykYS11YwjK4K28WLeiZiXWBmsmLxdGMeSUUkFY8utBuiXdfQj8BfjSGEw3CZOjJVkkMQ
         KJrwRMCp5zBhdzqdxzHMtAtpt7ChaSLlxX3uZL8Le5gVW42nkx5Bknp8dFm8wiCvhPuA
         B3hQ==
X-Gm-Message-State: AO0yUKWmvKbocvxnAJb02DDCy4IAOQ//wV+9LS1cWIRImK8JJVtxO4sV
        zni0ucZOnsT74NdUEe0y558=
X-Google-Smtp-Source: AK7set8n+Y8sZKSYTNBR5dC2J0IYWxQgIchgUGkDmOPwc4oBXKBbxCYC4mqx7e6bnlKwlfIA2ouAqA==
X-Received: by 2002:a05:6870:3a06:b0:176:3218:a837 with SMTP id du6-20020a0568703a0600b001763218a837mr7463844oab.16.1678211720222;
        Tue, 07 Mar 2023 09:55:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ax39-20020a05687c022700b0016b0369f08fsm5329261oac.15.2023.03.07.09.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:55:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Mar 2023 09:55:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: loongson1: Use devm_clk_get_enabled() helper
Message-ID: <3144eb08-ca46-42df-9a7d-c541ad534857@roeck-us.net>
References: <624106aa86ef7e49f16b11b229528eabd63de8f7.1672485257.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624106aa86ef7e49f16b11b229528eabd63de8f7.1672485257.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 12:14:30PM +0100, Christophe JAILLET wrote:
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
> Note that I get a compilation error because <loongson1.h> is not found on
> my system (x86_64).
> So I think that a "depends on LOONG<something>" in missing in a KConfig
> file.

It has "depends on MACH_LOONGSON32" and is not expected to be buildable if
MACH_LOONGSON32 is not selected. It builds just fine if MACH_LOONGSON32
is selected.

Guenter

> 
> Fixing it could help compilation farms build-bots.
> ---
>  drivers/watchdog/loongson1_wdt.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> index bb3d075c0633..c55656cfb403 100644
> --- a/drivers/watchdog/loongson1_wdt.c
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -79,11 +79,6 @@ static const struct watchdog_ops ls1x_wdt_ops = {
>  	.set_timeout = ls1x_wdt_set_timeout,
>  };
>  
> -static void ls1x_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int ls1x_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -100,20 +95,10 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(drvdata->base))
>  		return PTR_ERR(drvdata->base);
>  
> -	drvdata->clk = devm_clk_get(dev, pdev->name);
> +	drvdata->clk = devm_clk_get_enabled(dev, pdev->name);
>  	if (IS_ERR(drvdata->clk))
>  		return PTR_ERR(drvdata->clk);
>  
> -	err = clk_prepare_enable(drvdata->clk);
> -	if (err) {
> -		dev_err(dev, "clk enable failed\n");
> -		return err;
> -	}
> -	err = devm_add_action_or_reset(dev, ls1x_clk_disable_unprepare,
> -				       drvdata->clk);
> -	if (err)
> -		return err;
> -
>  	clk_rate = clk_get_rate(drvdata->clk);
>  	if (!clk_rate)
>  		return -EINVAL;
