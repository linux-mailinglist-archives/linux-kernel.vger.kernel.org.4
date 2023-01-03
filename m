Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9465C8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbjACVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjACVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:15:58 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774C1175;
        Tue,  3 Jan 2023 13:15:57 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id e205so28100170oif.11;
        Tue, 03 Jan 2023 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mmz5EfPJYW5sbHdfhkkJ4o6mpRbEVK07CuDfTq7KXi0=;
        b=cJyWLibv8MJfrNfaMqRqG16/iN8+9MMEqxmct/lpHCLp68UfIcVOjCnaXMsswvJAcd
         5AqatPt5+BmhHWx7+fXEMF7RLo5tfnu4XbjBLCXyrFvdYBkL7M4TaCtT0BwzTMsrul55
         UYavV4fN3S+CW9K7XX3lfdpW5So4lMGhF9hlbFtw2KKIk/3T3CSONIN2051GKM9Cn3aw
         oNRhgZ9ylVUr46hwnin8b+wrulS1mAC89wLqIDO9+8Sm38w05tF293LiCl1q3pMsbGNP
         mRonneYSzKJi1J2tthDtp/yb1bqLXevQuvGYie5y55iBnhx9Bg+56m9Wug2AY/sE+q/+
         l7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmz5EfPJYW5sbHdfhkkJ4o6mpRbEVK07CuDfTq7KXi0=;
        b=UNA5tcWxJ6yXGC34atDb7hG3UaXF7OCC99ydk3NkX7Ug0hDBtu7KDWce84U1cZehpV
         RUgZmjOWMfdOwRBK62UzMCMd9rTxq9uV0JDCVol1/TwEDZ9XBE6AmBDKCU20nnmEMwyz
         boDxKXrGFXWKntDwxUWaHir1wh7cUpsOAAQ3aQPfxHjU/btj+F+aBuxjqSN2CBsOBhIj
         yY/0JhE0vTMCqSQvTLjb3W8xDlCCI6+ENW0x2X9WW+4WkCxOcv3zTk/JZRNBhZRSywdK
         dl56sN2VVYhYDm/Yp3wI+4/Nxbt6aKUM1nSgwVbf9vJUHFV6cmjnKZAMiRoPhNcleOuN
         wRcw==
X-Gm-Message-State: AFqh2kptAGhRxC7kkH0OeCE3sLVMgu6WwV+aHjm2d0SWts5IK+SDHlJp
        fvfWoVu3Y8/Io28rT0qVAaA=
X-Google-Smtp-Source: AMrXdXv0O24ex5Bf3s7rX7ZZe3nTzmzmrWjpQND3/6KVh+iANKcVCEaICaR6y+hrfwX4VsQE43sy1A==
X-Received: by 2002:a05:6808:601:b0:363:a766:e78d with SMTP id y1-20020a056808060100b00363a766e78dmr5195151oih.5.1672780556617;
        Tue, 03 Jan 2023 13:15:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e21-20020a9d0195000000b00670523bf1cfsm15623622ote.47.2023.01.03.13.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:15:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:15:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pnx4008: Use devm_clk_get_enabled() helper
Message-ID: <20230103211555.GF212337@roeck-us.net>
References: <61f4e39db4c88408ee0149580e9aa925b784bc93.1672496714.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f4e39db4c88408ee0149580e9aa925b784bc93.1672496714.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 03:25:31PM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/pnx4008_wdt.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index e0ea133c1690..87a44a5675a1 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -179,11 +179,6 @@ static struct watchdog_device pnx4008_wdd = {
>  	.max_timeout = MAX_HEARTBEAT,
>  };
>  
> -static void pnx4008_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int pnx4008_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -195,18 +190,10 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt_base))
>  		return PTR_ERR(wdt_base);
>  
> -	wdt_clk = devm_clk_get(dev, NULL);
> +	wdt_clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(wdt_clk))
>  		return PTR_ERR(wdt_clk);
>  
> -	ret = clk_prepare_enable(wdt_clk);
> -	if (ret)
> -		return ret;
> -	ret = devm_add_action_or_reset(dev, pnx4008_clk_disable_unprepare,
> -				       wdt_clk);
> -	if (ret)
> -		return ret;
> -
>  	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
>  			WDIOF_CARDRESET : 0;
>  	pnx4008_wdd.parent = dev;
> -- 
> 2.34.1
> 
