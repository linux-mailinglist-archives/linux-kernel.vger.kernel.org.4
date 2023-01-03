Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A996365C8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjACVNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjACVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:13:29 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547ED13F14;
        Tue,  3 Jan 2023 13:13:28 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-14ffd3c5b15so26707130fac.3;
        Tue, 03 Jan 2023 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/ctDO+1ilKD6bs7lChYRRMb/JY8dZrPmDPwlnfuZHc=;
        b=oIB3rIEQz/D2KREth89OCJSRJZEBpIK+MFBQmor0fooSEZk18AcmqBOgYOhmas9q7D
         ttfETsVJw1GpHmdCg57IL79D3Nasg5d87mS7DmRK7QILO0Allhm1YF5fhN8ICghyryaI
         djFOu6K+6T3cN38qivcj9h7S9Ol6oXKU/9W6TBqt7ao4Zxx4/94B1w+O84hfwL7uxyP0
         PyRm3iW0VcUlU9iDoVuUA2K/AgUrAWMB7PMQto3fDAZrNOE6AhefW31KRkdiaOvDvWCx
         JzuWJmaF/99calV257xxJVwQNHDetlQvoMvFTNQ3m7VLLYRdaB9QJBy3jE/KNOULlyH3
         AYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/ctDO+1ilKD6bs7lChYRRMb/JY8dZrPmDPwlnfuZHc=;
        b=yKrJA8JMrrPCO4iapiZ0yB3NbUrdWLQN5EChJB/s0Ex7Rs51nId8KSa9Kh+rJQk9Ng
         kNTeyh34XQQX439c4YNCoQv10E1GQarJM+WdvTmShpy0Rjc9Jmoml0ePaLRiHPKG9W4P
         jcbcUxmHbCnHLGTLVZ6HJRRjHOFFrS+CJ5Ks3LWDT9juTXSKE1We835LFVJCRqo5m51W
         eObEytzvezD3oLGL/uyifngCrzCBejOvH55c3Q05QggDWL9lPEUHJ98Xx0T9lYzVPdX6
         UJtUmkFMuIc91r6TeCZZmRta7C8j1M8xAAc0YMg7AB25rg9J+o4P+Nr41pPWU6zweTwb
         X+Xg==
X-Gm-Message-State: AFqh2krV0yRrQe647wBosHf1Wc61A/aCivw10u1sNsr3+sz9dN7BPGLL
        L/4AxDL2A0YBv17o06oUy6Y=
X-Google-Smtp-Source: AMrXdXu5bzH3G3kwF3I9ktB1IvbGd0d/1Z36TYxs8O4B3uzY/tLwiEmdYnn5FfJ+MKxI65vK9IoF2A==
X-Received: by 2002:a05:6870:6c04:b0:14f:b93f:1603 with SMTP id na4-20020a0568706c0400b0014fb93f1603mr17825271oab.22.1672780407611;
        Tue, 03 Jan 2023 13:13:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o33-20020a05687107a100b001446480a042sm14816200oap.58.2023.01.03.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:13:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:13:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: lpc18xx: Use devm_clk_get_enabled() helper
Message-ID: <20230103211325.GA212337@roeck-us.net>
References: <d4c675190d3ddfbba5c354edb4274757f9117304.1672489554.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c675190d3ddfbba5c354edb4274757f9117304.1672489554.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 01:26:09PM +0100, Christophe JAILLET wrote:
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
> Note that the order of operations is slightly modified by this patch. The
> "reg" clk is now prepare_enable()'ed before clk_get("wdtclk").
> ---
>  drivers/watchdog/lpc18xx_wdt.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
> index 60b6d74f267d..1b9b5f21a0df 100644
> --- a/drivers/watchdog/lpc18xx_wdt.c
> +++ b/drivers/watchdog/lpc18xx_wdt.c
> @@ -197,16 +197,10 @@ static const struct watchdog_ops lpc18xx_wdt_ops = {
>  	.restart        = lpc18xx_wdt_restart,
>  };
>  
> -static void lpc18xx_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int lpc18xx_wdt_probe(struct platform_device *pdev)
>  {
>  	struct lpc18xx_wdt_dev *lpc18xx_wdt;
>  	struct device *dev = &pdev->dev;
> -	int ret;
>  
>  	lpc18xx_wdt = devm_kzalloc(dev, sizeof(*lpc18xx_wdt), GFP_KERNEL);
>  	if (!lpc18xx_wdt)
> @@ -216,38 +210,18 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(lpc18xx_wdt->base))
>  		return PTR_ERR(lpc18xx_wdt->base);
>  
> -	lpc18xx_wdt->reg_clk = devm_clk_get(dev, "reg");
> +	lpc18xx_wdt->reg_clk = devm_clk_get_enabled(dev, "reg");
>  	if (IS_ERR(lpc18xx_wdt->reg_clk)) {
>  		dev_err(dev, "failed to get the reg clock\n");
>  		return PTR_ERR(lpc18xx_wdt->reg_clk);
>  	}
>  
> -	lpc18xx_wdt->wdt_clk = devm_clk_get(dev, "wdtclk");
> +	lpc18xx_wdt->wdt_clk = devm_clk_get_enabled(dev, "wdtclk");
>  	if (IS_ERR(lpc18xx_wdt->wdt_clk)) {
>  		dev_err(dev, "failed to get the wdt clock\n");
>  		return PTR_ERR(lpc18xx_wdt->wdt_clk);
>  	}
>  
> -	ret = clk_prepare_enable(lpc18xx_wdt->reg_clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare or enable sys clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, lpc18xx_clk_disable_unprepare,
> -				       lpc18xx_wdt->reg_clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(lpc18xx_wdt->wdt_clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare or enable wdt clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, lpc18xx_clk_disable_unprepare,
> -				       lpc18xx_wdt->wdt_clk);
> -	if (ret)
> -		return ret;
> -
>  	/* We use the clock rate to calculate timeouts */
>  	lpc18xx_wdt->clk_rate = clk_get_rate(lpc18xx_wdt->wdt_clk);
>  	if (lpc18xx_wdt->clk_rate == 0) {
> -- 
> 2.34.1
> 
