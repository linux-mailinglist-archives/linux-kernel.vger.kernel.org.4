Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9112865A64F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiLaT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiLaT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:29:11 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F865E0;
        Sat, 31 Dec 2022 11:29:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so14942229otk.8;
        Sat, 31 Dec 2022 11:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQyokkSz01BZp4uqahSMrw4J7faS/cYrsxSE51O9MlA=;
        b=Skq1fDglbDeeHdPoDbxLYXKwPrWsWu1qYD6S2/6bRK5r6Ui8Ky/Kvh28URk08oeED6
         KZjvgfi1KE/ZtSrgsuoWmDgQL4r42Jkvj8R4rakou5fOLV8aIE1Cr/78b2zOhiOf+KDh
         sfv4FgE6uGolojNWZBllzJhNyuWtD/PFUd7TxI5T9UBMTvtFsBNWP2t9dOp5XUOLESmF
         LNm3DpLuo6igHMw5TS/ZEFNqIuTVaDHTRc2IPbHE3twZlO/Z1+lzqTbaiSVbbmXcfsri
         PUSyQ6qxAqqWxQBww9shP/LWXE+yOmyvCoPIPQ+D+VcYm3L6hHcL60Jipahw+CX8QU49
         Yudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQyokkSz01BZp4uqahSMrw4J7faS/cYrsxSE51O9MlA=;
        b=ciIVlILcoZo8hoC+WfOHc281DtQv5dPRzVetGHmDInWqXnnP8jEOGJrRRns7DHwhl4
         kJ1JMvgOWVAEtVcFOU0C4/cxUpB5fZkJ6msiDVzMuQSeQDa4hOiqem2eH2vKLjFwg/Ru
         PFgnSC25Jzo8OxwIbno3zQpyaWZKDJC5/rjxOULZ6BdN4NOxqh3k+kKq2Mjpx/spKhdy
         bNtM/CUloybfJEj6NiajcxBKh+o7slLYnuqIlG8CCMFmdKCdt3DB7OwZ6mhYRvX03rKh
         FP1EO0slwg5E+CX9kf2wa+beW3sN44BIBC2mYeZ1ULuldcjjHrbGEJNslcTnr5298ur/
         Fy6w==
X-Gm-Message-State: AFqh2kq9mZhAits9Xzq4MYMBHZwcPXB5HIVTUJH2C5jLZEerCG8QMbLY
        hil392NARGpSddzKps3oDfY=
X-Google-Smtp-Source: AMrXdXvVC7JFe4GVjKVr2iDX8qhl3MzhYsU7wJcARo59DEAlwBqjvWvhLhddnNAaFLEPn23vJ1hUCQ==
X-Received: by 2002:a9d:1e8:0:b0:66c:808f:4a27 with SMTP id e95-20020a9d01e8000000b0066c808f4a27mr19464265ote.20.1672514944466;
        Sat, 31 Dec 2022 11:29:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g35-20020a05683030a300b0066ea5d4f349sm11648378ots.18.2022.12.31.11.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 11:29:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 11:29:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: bcm7038: Use devm_clk_get_enabled() helper
Message-ID: <20221231192902.GC3434944@roeck-us.net>
References: <9c055911e9f557b7239000c8e6cfa0cc393a19e9.1672474203.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c055911e9f557b7239000c8e6cfa0cc393a19e9.1672474203.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 09:10:17AM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/bcm7038_wdt.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index 9388838899ac..e038dd66b819 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -127,11 +127,6 @@ static const struct watchdog_ops bcm7038_wdt_ops = {
>  	.get_timeleft	= bcm7038_wdt_get_timeleft,
>  };
>  
> -static void bcm7038_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int bcm7038_wdt_probe(struct platform_device *pdev)
>  {
>  	struct bcm7038_wdt_platform_data *pdata = pdev->dev.platform_data;
> @@ -153,17 +148,9 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
>  	if (pdata && pdata->clk_name)
>  		clk_name = pdata->clk_name;
>  
> -	wdt->clk = devm_clk_get(dev, clk_name);
> +	wdt->clk = devm_clk_get_enabled(dev, clk_name);
>  	/* If unable to get clock, use default frequency */
>  	if (!IS_ERR(wdt->clk)) {
> -		err = clk_prepare_enable(wdt->clk);
> -		if (err)
> -			return err;
> -		err = devm_add_action_or_reset(dev,
> -					       bcm7038_clk_disable_unprepare,
> -					       wdt->clk);
> -		if (err)
> -			return err;
>  		wdt->rate = clk_get_rate(wdt->clk);
>  		/* Prevent divide-by-zero exception */
>  		if (!wdt->rate)
> -- 
> 2.34.1
> 
