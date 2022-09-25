Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52755E9404
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiIYPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:40:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13618E05;
        Sun, 25 Sep 2022 08:40:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s26so4522652pgv.7;
        Sun, 25 Sep 2022 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ALf43tEt4uTY7t2ZG6Ao8BT7RErUJLGMqwWyM5uhgEc=;
        b=hqwPnnM/ypNQfn1GAU6crVglBMh7NBmkOrRMeMKH0gXTqXMYa5DFjsjfRf5m+R6r/e
         wjaP/7EpmEPJ61efUZ3KgwrZ6eKWxBBBmY8VPN9ctSySBRvtXpXd/WZeOHXChaTCjiDl
         YS7ydQy/7kvk/NLQMuYRdiq9e0B/BL9l9JiyH4WAweuar2ZX1zY03K2ToY6sQWjMXL3Z
         h7svrokrX4Rqm1Gf7QBy9+9GiOb9Lh5YqnJTQm3bcrXzQ6YeqiG3vxa9o4/ahkIolpzQ
         xx4yjcBIoitEZaLR/2f3M8tOWDy86puakGnE7rOmCVA8xXiOJZNyoIcbEzMN4bK4+GFo
         DrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ALf43tEt4uTY7t2ZG6Ao8BT7RErUJLGMqwWyM5uhgEc=;
        b=hn6C5fK0WYpUXIGNguCmIGQOfeyVxkxuW2oEZ2YLWYsia9EyQ0/ICtyWrBmP0CUF4d
         Ei7FrTowf0RPjAQoOFfdjn2d95l6aTsbz4Iif/CGUd2eWokpbDKjBjOz8KjGmh6SuPrb
         NSqcIdFw5I3AExP9uLnCI2NeE72ItRactjDHzNlHMcW4ZWcCHR715lhjyhXOXvaoUntp
         JfujGFQRjyHpn7CUYisJcD9nUtmCTwa7mbpSzmMJ9tKbmI6F8gKTAOZBQk8ThJrCo7oS
         0ujl1SHORczVFlP8K9ewtRLnHJxRRDzewZBODxVYRb1hfHkpyivA5gi0bwNAbPm8kVMs
         tuNQ==
X-Gm-Message-State: ACrzQf3xh8I8w3WRMas6Dzu3F6jLUPqp5lNhFNapvfTYQUgOyNIB5j95
        TrnxW2GvXgUPP4XULgCdoWY=
X-Google-Smtp-Source: AMsMyM5qEgpsSBH0Cd3X5H1tJXymH6cgWhNuk88G9vgitj4eLEaGuYvD3kPzFZfzfeaTUToVZNfo8w==
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id z29-20020a63191d000000b004344bb3e016mr16522946pgl.133.1664120424520;
        Sun, 25 Sep 2022 08:40:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o67-20020a625a46000000b00554722eda37sm7790166pfb.0.2022.09.25.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 08:40:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 08:40:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Philippe Boos <pboos@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: meson: keep running if already active
Message-ID: <20220925154022.GA1758351@roeck-us.net>
References: <20220801092150.4449-1-pboos@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801092150.4449-1-pboos@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:21:50AM +0200, Philippe Boos wrote:
> If the watchdog is already running (e.g.: started by bootloader) then
> the kernel driver should keep the watchdog active but the amlogic driver
> turns it off.
> 
> Let the driver fix the clock rate if already active because we do not
> know the previous timebase value. To avoid unintentional resetting we
> temporarily set it to its maximum value.
> 
> Then keep the enable bit if is was previously active.
> 
> Signed-off-by: Philippe Boos <pboos@baylibre.com>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/meson_gxbb_wdt.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 5a9ca10fbcfa..8be8fd9e5637 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -146,6 +146,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct meson_gxbb_wdt *data;
>  	int ret;
> +	u32 ctrl_reg;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -177,13 +178,26 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
>  	watchdog_set_drvdata(&data->wdt_dev, data);
>  
> +	ctrl_reg = readl(data->reg_base + GXBB_WDT_CTRL_REG) &
> +				GXBB_WDT_CTRL_EN;
> +
> +	if (ctrl_reg) {
> +		/* Watchdog is running - keep it running but extend timeout
> +		 * to the maximum while setting the timebase
> +		 */
> +		set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);
> +		meson_gxbb_wdt_set_timeout(&data->wdt_dev,
> +				GXBB_WDT_TCNT_SETUP_MASK / 1000);
> +	}
> +
>  	/* Setup with 1ms timebase */
> -	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> -		GXBB_WDT_CTRL_EE_RESET |
> -		GXBB_WDT_CTRL_CLK_EN |
> -		GXBB_WDT_CTRL_CLKDIV_EN,
> -		data->reg_base + GXBB_WDT_CTRL_REG);
> +	ctrl_reg |= ((clk_get_rate(data->clk) / 1000) &
> +			GXBB_WDT_CTRL_DIV_MASK) |
> +			GXBB_WDT_CTRL_EE_RESET |
> +			GXBB_WDT_CTRL_CLK_EN |
> +			GXBB_WDT_CTRL_CLKDIV_EN;
>  
> +	writel(ctrl_reg, data->reg_base + GXBB_WDT_CTRL_REG);
>  	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
>  
>  	watchdog_stop_on_reboot(&data->wdt_dev);
