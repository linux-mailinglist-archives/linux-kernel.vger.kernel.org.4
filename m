Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B96AECB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCGR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCGR4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:56:52 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC24A42EC;
        Tue,  7 Mar 2023 09:51:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bj30so10247437oib.6;
        Tue, 07 Mar 2023 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678211494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XafBvAxNajLYeHau3iqjN262qG+5QqLl0fx9ytKVlqk=;
        b=pTV/8MvOAFF/sCCDNnH7rE2X/7nmpf19i4hQfw4yiv22CEz0Uc0mtHpuOU18eCbCn2
         IsmIrmx0jhXB2bBVDsTRfezFOBXiMKf3hggnieIxldBrmCp7mEZeD4epujCBZZfPE5VP
         H1FO8bSSphrjs1Sasi4/Qar1hDhDJue+7ubkxOAvDbf2BxbZM+caqgiWBfLq7lK2eBRR
         0xlVTzlU1sNG7X/aQuiIT0XhMWBzNqiUoFcr8Vni+e/zTqhDHv8h5YjiZXbQyH7hhvz9
         FayKHYDdUxitu7ZADPpMO2pG5fSnu0rjZ1sXETfLwmoqm+3zp6magKsNbazwlypQ9J/o
         8IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XafBvAxNajLYeHau3iqjN262qG+5QqLl0fx9ytKVlqk=;
        b=wvHnurxGXvwmbyDEEu/B13AqddyLY+zaRFBpXlINNtrmtma6a8Z2bJ8Ls3OYrvzt3s
         mpUAR7vkrFOjwcuj6GFRIBlAeiWqDBmT3o9r5/Lvcklm1qyraBp7LX6sHRfVSBJ2BcaE
         qw4gtTNDO1n4cF2SOdCmD+gcgJq240oQ0fEZnHZp+sRuxMAa1xCBLPDssrCUVvUHyJF/
         aUVhvK5EW0XDPGduqiVdJO1pviAqwKETkvpL4FU5RASZ/8mqQmwChJmXp3RgsOk2mz4j
         3IB+TLtMwY4MSC78qmDdGOUwi8ec97B4/gOwjg21trANozR9KcoPIV+84VVTqqv+j3fI
         8W1A==
X-Gm-Message-State: AO0yUKX4b2SMhLGs8O2ZIySEPyOHLELaTKwTETvqB1NSqdfWEBwbSBVO
        eECZZMFgElAaSEzvavl5cFZDT/MkJYA=
X-Google-Smtp-Source: AK7set9iGP7z/gNhNmco93PtYXUxMK0bNDBmsjpLzwIN8Enlh52h1KlbCouyl5eJQoe5lPDYROgYrg==
X-Received: by 2002:a05:6808:983:b0:384:1d7:5834 with SMTP id a3-20020a056808098300b0038401d75834mr6717150oic.28.1678211494617;
        Tue, 07 Mar 2023 09:51:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b00383ef58c15bsm5453030oih.28.2023.03.07.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:51:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Mar 2023 09:51:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
Message-ID: <ffa8bb97-7764-4463-9ee9-ad2748f32d10@roeck-us.net>
References: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Note that I get a compilation error because read_cpuid_id() is not defined
> on my system (x86_64).
> So I think that a "depends on ARM<something>" in missing in a KConfig file.
> 
> Fixing it could help compilation farms build-bots.

As mentioned, this not how build dependencies work. The code builds fine
with arm:allmodconfig. It is not enabled with x86_64:allmodconfig since
it depends on ARCH_IXP4XX. It is is not expected to be buildable if
ARCH_IXP4XX is not selected.

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
