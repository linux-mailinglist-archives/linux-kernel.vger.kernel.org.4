Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2376E65A7FE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiLaXJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiLaXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:09:43 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C04267D;
        Sat, 31 Dec 2022 15:09:42 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j130so16564441oif.4;
        Sat, 31 Dec 2022 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7WNsD6gyaCetehSHXPCDB9R+yMnhSn/6iTm7wa2rxg=;
        b=H7rfb2pRenXTsAyAsNEZGbuU+5sD3mE5iGpxyGV+ZxmwcuoXMDTBnshnFcAvQhKc0F
         GAGQ8HnE4WZ44AfjOFFMFmSlNozBDqKWN8liDr3h0eolaSnTj3ViFsUSvkwtUED+LkVd
         IFqhHvd9F+P6vDn3Hhby+vpgAAzuiC7v4xWeLVGQOWdULHRq6D62MH8Jzt54ttFseoig
         tpXAH94tNr/NpyZlNSCZQJTkTsdow1i1skjEDf0zPiKADPWeh1dme8myLX6K0bruLunG
         YkEGoMvyKWX3wSKPUAUznHoYy/p2WcOtUxIMKazZmw1wB3p4YsgNu4s/XjPtPnB0R8bc
         RGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7WNsD6gyaCetehSHXPCDB9R+yMnhSn/6iTm7wa2rxg=;
        b=VVhiW3EUWuZwF5pzIooWBwSB44Elmv6XXYyYAPcvv7r9Wb+W31HoTO45lJlc+tqz/+
         zRmVAinBmlyuvSkgi/6cXBq2VMSSh7LqvMK8AHWxqHtxOhw2iVfOS4KL6GQC/VzOITdp
         BJVBeiQh7xpCz9H0vg+3p7C7YDBTvWyvTHMEuyBup+SrXMMGk8Wpo4TuUZjvkXsDN2WK
         j+2JMxs6dCryYNzxJ/5br2UBwbFagi0Rwk4oRT6SjMzQsXFQ/6jc7kV2c4hGClbkJxXq
         raGJfnGdCq37I7ttZxCerHOQx70tYMg0LB0ZIs3asw3RQbbkgAi6q1F0fDWCX0AczHug
         hyyQ==
X-Gm-Message-State: AFqh2koh1Tyf1pR75HbBACPgdAFrFJ2l4XXfnbr9bf+z7Df+GdFAz95M
        MoOF5GPMf8NBhfRMfyzyo8xxQ4xORZo=
X-Google-Smtp-Source: AMrXdXuGcn54EQNsR7XHwmmNsjgWlF5rRo9SvUrqgGFQCp9pJkWmyJAX32Gti8S8OAi5hqe3Y9MLqA==
X-Received: by 2002:a05:6808:d4:b0:355:1df0:9b9c with SMTP id t20-20020a05680800d400b003551df09b9cmr14919340oic.26.1672528181795;
        Sat, 31 Dec 2022 15:09:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020aca0d05000000b0035c21f1a570sm10581752oin.6.2022.12.31.15.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 15:09:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 15:09:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imgpdc: Use devm_clk_get_enabled() helper
Message-ID: <20221231230940.GB2706156@roeck-us.net>
References: <1f8d1ce1e6a63c507a291aea624b1337326cc563.1672483996.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8d1ce1e6a63c507a291aea624b1337326cc563.1672483996.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 11:53:34AM +0100, Christophe JAILLET wrote:
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
> "sys" clk is now prepare_enable()'ed before clk_get("wdt").
> ---
>  drivers/watchdog/imgpdc_wdt.c | 31 +++----------------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index b57ff3787052..a55f801895d4 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -175,16 +175,11 @@ static const struct watchdog_ops pdc_wdt_ops = {
>  	.restart        = pdc_wdt_restart,
>  };
>  
> -static void pdc_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int pdc_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	u64 div;
> -	int ret, val;
> +	int val;
>  	unsigned long clk_rate;
>  	struct pdc_wdt_dev *pdc_wdt;
>  
> @@ -196,38 +191,18 @@ static int pdc_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(pdc_wdt->base))
>  		return PTR_ERR(pdc_wdt->base);
>  
> -	pdc_wdt->sys_clk = devm_clk_get(dev, "sys");
> +	pdc_wdt->sys_clk = devm_clk_get_enabled(dev, "sys");
>  	if (IS_ERR(pdc_wdt->sys_clk)) {
>  		dev_err(dev, "failed to get the sys clock\n");
>  		return PTR_ERR(pdc_wdt->sys_clk);
>  	}
>  
> -	pdc_wdt->wdt_clk = devm_clk_get(dev, "wdt");
> +	pdc_wdt->wdt_clk = devm_clk_get_enabled(dev, "wdt");
>  	if (IS_ERR(pdc_wdt->wdt_clk)) {
>  		dev_err(dev, "failed to get the wdt clock\n");
>  		return PTR_ERR(pdc_wdt->wdt_clk);
>  	}
>  
> -	ret = clk_prepare_enable(pdc_wdt->sys_clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare or enable sys clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, pdc_clk_disable_unprepare,
> -				       pdc_wdt->sys_clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(pdc_wdt->wdt_clk);
> -	if (ret) {
> -		dev_err(dev, "could not prepare or enable wdt clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, pdc_clk_disable_unprepare,
> -				       pdc_wdt->wdt_clk);
> -	if (ret)
> -		return ret;
> -
>  	/* We use the clock rate to calculate the max timeout */
>  	clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
>  	if (clk_rate == 0) {
> -- 
> 2.34.1
> 
