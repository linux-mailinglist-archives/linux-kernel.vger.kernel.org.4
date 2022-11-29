Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7363B940
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiK2Eyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiK2Eyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:54:36 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38916440;
        Mon, 28 Nov 2022 20:54:34 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r76so13979746oie.13;
        Mon, 28 Nov 2022 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WwucCheI9FWEfqfvKhHxj83zbdel8FBhfzs35yo6xj8=;
        b=djzIJ7eibE5fvPBVLvSyUZgqdvK9eWTaXfhBhL5JCScXVYHT2ElV6SlB+YC8Z8TcEG
         lwXfalIzofTZEx316L2c6/Es2q+XbnHoGn+6alpKUwuaBf22i3A3eSlBUSWoVsvH8Q53
         X5Q29tE88gFi82n0DFIE9tvYZz6pYoVDNAGkllTvRh5/Gen8i4+2lsg8nQgJfp9bwxik
         DqWoCn4NNjIOxTQYtrx0KA6PBzK0cF9uNJM9FWcCW2EnQowVPRxpPYAQIpkM+Ns14jGb
         wDtASR2fjXn4BNHxAMCnVdRlr0YT5mojDqVYWYdLjBh6sIXhIcXvl+M/WGb/nXBTD/Vm
         u22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwucCheI9FWEfqfvKhHxj83zbdel8FBhfzs35yo6xj8=;
        b=DijVsw6D3N6Z1IAp6MjH1LV4KWwH1ZZ1GgK3ZHqGctyfJ4OfJFBgrABJlCDDQvqc5V
         wIE90VKX29bvS+JBLlor5xmnqo5lIByVqfxYk3EoNy/1kaozYKXgemI24QJCnGjKV0u8
         hdpSptvUvvHfHk3H9SxQps51QJdliyTCsMTuKgISG+C65K818utWi88UI4mPbBd3NGeJ
         pQBFvUeObubCFrhKD8jSfGDBjkAjEplk10GgTncGQHuD+4LoyLxD1d60jssMV9WQeCPi
         uWlTlR4NisNObP8TDXTXKBBrg4RIUD2uyPe9xRVftftGSkmHMNPAKZ3d1aQtqZpYkYPs
         Eyqg==
X-Gm-Message-State: ANoB5pmG4Ol2XSQP7xsNeN5X9evhCydoaxhV+6hyVwpIYlTfZ1t/BxP8
        uq3na0vU1ap1obv4BwaHms4=
X-Google-Smtp-Source: AA0mqf7NXDMePKv5x+gnr+KsS1xDtzEft8pruKRNDmbbHoCLW74TsCO1zEYqJyrT7m6u+saxeBbP+g==
X-Received: by 2002:a05:6808:2195:b0:35b:beed:fc4c with SMTP id be21-20020a056808219500b0035bbeedfc4cmr2260151oib.163.1669697673997;
        Mon, 28 Nov 2022 20:54:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15-20020a4a964f000000b0049bd96ec131sm5119371ooi.8.2022.11.28.20.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 20:54:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <69ab58fe-b3cf-3649-d55b-f43173ff5ab0@roeck-us.net>
Date:   Mon, 28 Nov 2022 20:54:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/22 03:49, Fabrizio Castro wrote:
> As per section 48.4 of the HW User Manual, IPs in the RZ/V2M
> SoC need either a TYPE-A reset sequence or a TYPE-B reset
> sequence. More specifically, the watchdog IP needs a TYPE-B
> reset sequence.
> 
> If the proper reset sequence isn't implemented, then resetting
> IPs may lead to undesired behaviour. In the restart callback of
> the watchdog driver the reset has basically no effect on the
> desired funcionality, as the register writes following the reset
> happen before the IP manages to come out of reset.
> 
> Implement the TYPE-B reset sequence in the watchdog driver to
> address the issues with the restart callback on RZ/V2M.
> 
> Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/rzg2l_wdt.c | 37 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index ceca42db0837..d404953d0e0f 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -8,6 +8,7 @@
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> @@ -35,6 +36,8 @@
>   
>   #define F2CYCLE_NSEC(f)			(1000000000 / (f))
>   
> +#define RZV2M_A_NSEC			730
> +
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> @@ -51,11 +54,35 @@ struct rzg2l_wdt_priv {
>   	struct reset_control *rstc;
>   	unsigned long osc_clk_rate;
>   	unsigned long delay;
> +	unsigned long minimum_assertion_period;
>   	struct clk *pclk;
>   	struct clk *osc_clk;
>   	enum rz_wdt_type devtype;
>   };
>   
> +static int rzg2l_wdt_reset(struct rzg2l_wdt_priv *priv)
> +{
> +	int err, status;
> +
> +	if (priv->devtype == WDT_RZV2M) {
> +		/* WDT needs TYPE-B reset control */
> +		err = reset_control_assert(priv->rstc);
> +		if (err)
> +			return err;
> +		ndelay(priv->minimum_assertion_period);
> +		err = reset_control_deassert(priv->rstc);
> +		if (err)
> +			return err;
> +		err = read_poll_timeout(reset_control_status, status,
> +					status != 1, 0, 1000, false,
> +					priv->rstc);
> +	} else {
> +		err = reset_control_reset(priv->rstc);
> +	}
> +
> +	return err;
> +}
> +
>   static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
>   {
>   	/* delay timer when change the setting register */
> @@ -115,7 +142,7 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>   {
>   	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>   
> -	reset_control_reset(priv->rstc);
> +	rzg2l_wdt_reset(priv);
>   	pm_runtime_put(wdev->parent);
>   
>   	return 0;
> @@ -154,6 +181,7 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>   		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
>   	} else {
>   		/* RZ/V2M doesn't have parity error registers */
> +		rzg2l_wdt_reset(priv);
>   
>   		wdev->timeout = 0;
>   
> @@ -251,6 +279,13 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>   
>   	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
>   
> +	if (priv->devtype == WDT_RZV2M) {
> +		priv->minimum_assertion_period = RZV2M_A_NSEC +
> +			3 * F2CYCLE_NSEC(pclk_rate) + 5 *
> +			max(F2CYCLE_NSEC(priv->osc_clk_rate),
> +			    F2CYCLE_NSEC(pclk_rate));
> +	}
> +
>   	pm_runtime_enable(&pdev->dev);
>   
>   	priv->wdev.info = &rzg2l_wdt_ident;

