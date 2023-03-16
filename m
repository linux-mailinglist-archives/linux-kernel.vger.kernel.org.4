Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE56BC762
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCPHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCPHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:38:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD30819C67;
        Thu, 16 Mar 2023 00:38:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so1173898lfv.4;
        Thu, 16 Mar 2023 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678952303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rvs1+zLkgWFQK+bxZ6xuanlYESj2CqPRnz2A9+zJTq4=;
        b=YhiCZFq0obvEp8H1OzbRKaO76PihZqoS/x5adjsyTQetQxTSl2hI5qSgz/NjaT+dAE
         Fc7xtBshrXJHRTOnNXZqfO5hkjoBRRlWt13rhsZOSzre+FZfcbSD8PKOW6K5ialfLjMV
         FD9OjG+NG1bB+4G6YA7tYei3W/ajfkyaK2XwvDGbPwez7Oo4olkLwZBu66cE0OgOM58j
         sQOJS9ZYCBrUs7krlQXRh82f1oXdT4A5OMT3WPm3lL8Lpk17u+N9/8d1XvaWIOTn0d7S
         XNaHs85bIxvoO+B2aqgP+mzTpqqGscRuou2p4ivu4nLY66vIyquk67Qpsm8RIJ/yvhTX
         3N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvs1+zLkgWFQK+bxZ6xuanlYESj2CqPRnz2A9+zJTq4=;
        b=gQcSg2GUm+pCibg7IT+2xawd2IdNcpYLZJT02wJwndWv+UD+C97Kj/sf5DyPu+7BgZ
         oXqn+0cXlq7gLosLZr+WE0Udbjgt4k20qIVyBeHudqpGQlHHGPlM0GRJJyRqpZeW/Z1w
         RhJp6p01+DmNQLFXj/GINJut2tVGVFbQt8BtVXCFBSU3Iutyl9bZ6+kdqowZA0XoEekQ
         N9J4oS9aQRS1SskwuxOzSbrVSuesixfvEJI/xQJ8w7IjdzAzYJnmUTBi4JTMe0R071cJ
         JZdaiUx4PQVjbhQcpsWXs9xuZMWJTKxsbZxQB0zAd/svkU7XFh2POAXmfHPKmHHo6oNH
         Ow2g==
X-Gm-Message-State: AO0yUKWZJWlNBVik6t6EaeuYq4CaaR10sbIf0wtEEx7snufE13JsLa40
        cjP5KqvB00HvWBe+Wo3sNKto/rFpAh0=
X-Google-Smtp-Source: AK7set9wLrN71OcjSdjEtPud0TkPUrM8kBZ2qBEj/i4aqe512qRbsbxt3VCrT+6wa6XgcmpCXpDlgw==
X-Received: by 2002:a05:6512:7a:b0:4b0:2a2f:ea6d with SMTP id i26-20020a056512007a00b004b02a2fea6dmr2700488lfo.35.1678952303073;
        Thu, 16 Mar 2023 00:38:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id t16-20020ac24c10000000b004d4d7fb0e07sm1120070lfq.216.2023.03.16.00.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:38:22 -0700 (PDT)
Message-ID: <775fab33-0964-67f0-837a-b5fdd7ae7a2b@gmail.com>
Date:   Thu, 16 Mar 2023 09:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 08/12] power: supply: generic-adc-battery: use
 simple-battery API
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-9-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230314225535.1321736-9-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 00:55, Sebastian Reichel wrote:
> Use standard simple-battery API for constant battery
> information like min and max voltage. This simplifies
> the driver a lot and brings automatic support for DT.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   drivers/power/supply/generic-adc-battery.c | 64 ++--------------------
>   include/linux/power/generic-adc-battery.h  | 18 ------
>   2 files changed, 4 insertions(+), 78 deletions(-)
>   delete mode 100644 include/linux/power/generic-adc-battery.h
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index 771e5cfc49c3..d4f63d945b2c 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -22,7 +22,6 @@
>   #include <linux/slab.h>
>   #include <linux/iio/consumer.h>
>   #include <linux/iio/types.h>
> -#include <linux/power/generic-adc-battery.h>
>   #include <linux/devm-helpers.h>
>   
>   #define JITTER_DEFAULT 10 /* hope 10ms is enough */
> @@ -48,9 +47,7 @@ struct gab {
>   	struct power_supply		*psy;
>   	struct power_supply_desc	psy_desc;
>   	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
> -	struct gab_platform_data	*pdata;
>   	struct delayed_work bat_work;
> -	int	level;
>   	int	status;
>   	bool cable_plugged;
>   	struct gpio_desc *charge_finished;
> @@ -70,14 +67,6 @@ static void gab_ext_power_changed(struct power_supply *psy)
>   
>   static const enum power_supply_property gab_props[] = {
>   	POWER_SUPPLY_PROP_STATUS,
> -	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
> -	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -	POWER_SUPPLY_PROP_CURRENT_NOW,
> -	POWER_SUPPLY_PROP_TECHNOLOGY,
> -	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> -	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> -	POWER_SUPPLY_PROP_MODEL_NAME,
>   };
>   
>   /*
> @@ -97,17 +86,6 @@ static bool gab_charge_finished(struct gab *adc_bat)
>   	return gpiod_get_value(adc_bat->charge_finished);
>   }
>   
> -static int gab_get_status(struct gab *adc_bat)
> -{
> -	struct gab_platform_data *pdata = adc_bat->pdata;
> -	struct power_supply_info *bat_info;
> -
> -	bat_info = &pdata->battery_info;
> -	if (adc_bat->level == bat_info->charge_full_design)
> -		return POWER_SUPPLY_STATUS_FULL;

Not sure if this is intentional but I don't see the 
POWER_SUPPLY_STATUS_FULL being reported after applying your series. If 
this is intended, maybe it could be mentioned in commit log?

Other than that - this really cleans up the driver in a nice way!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

