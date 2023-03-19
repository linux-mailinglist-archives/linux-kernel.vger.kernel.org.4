Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7D6C01B9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCSMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCSMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:45:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41293B761;
        Sun, 19 Mar 2023 05:45:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o8so11846870lfo.0;
        Sun, 19 Mar 2023 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679229949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUFR/owu04/HGO42G2+su2qkeCReL5ITlw7CfWk1G2A=;
        b=IXnYmbIXkea6DDGMhRq1jyYbb7qxrAT5M+MHIzNWOYJOsFZEZPUKLTl0S5J7teTKDj
         BoUJPOVbdxCL6282g4NjarvQo4gjb81MWq6A3REVk2RuEClDWW/dFh9TyHIbs81XYfjN
         eBFoet0uFATA11/hK3LM5AesFy9ief6wdMwNbDgEo0X/WNlCcP/c+REUn758trdFWG4s
         nuZRcO8aD9Rddi21sahgmVUJIg9B6IETiq2tRRw1tPY0P4O6NNTqo23v/nBgcOielPYD
         FH70hghO/wMSfXDc5pLAVxmRRnwFZ+Gb543OlgFl3hCZfQsITMEzRGMhw9IznyE8IK2Z
         qYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679229949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUFR/owu04/HGO42G2+su2qkeCReL5ITlw7CfWk1G2A=;
        b=qdOC6ApFLDuEA2GlxRFnLn0uU7OTEDGw1v7ATQktVlmrNBZi3stHj0KRa47ETGQ5gD
         wohmcK5EilBag0UOCxPPyEFEX4qX8SqnguhoGKDFjn/OaLdjV6dSy6wKX+usCndUpXPw
         8lWJI/7+wkk3Ykfj9Ny+u0j/plEo4obV6fRjZANG+4ucf+gVHf8SLdhvPap078+fDYbq
         O8sBqz9bpxleRMmpVXXXJrQrnxrEdf5kEJPSzSGm9dg3dtzfN2wdS4twb2UmUI4N80H0
         m5X0umIzcLO76cM/nKVthnOD0oo4mj7XALmukbmkM2CzbJ+W58RAqyOPgn0XO+wBqX1r
         Ou/A==
X-Gm-Message-State: AO0yUKUno5eu9GUIu6ChXnp1asHBBCfhwJzj3CWHs74IfeeBcs36+eWZ
        eQ6FOdk8qF4o6V3vBx3FNwg=
X-Google-Smtp-Source: AK7set/0Ceqe51le506ovkyGA2FAEvBQnykF4dIG7idWAdyk5nkmGhM5ooEnV03OnY5aQjvtRiSMOA==
X-Received: by 2002:ac2:5a5e:0:b0:4e1:7dd:1142 with SMTP id r30-20020ac25a5e000000b004e107dd1142mr5255395lfn.51.1679229949369;
        Sun, 19 Mar 2023 05:45:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004e83f59ed10sm1263687lfc.44.2023.03.19.05.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:45:48 -0700 (PDT)
Message-ID: <c2e4540c-a607-d2d7-992f-9ff7d1c2cce7@gmail.com>
Date:   Sun, 19 Mar 2023 14:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv3 08/14] power: supply: generic-adc-battery: use
 simple-battery API
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230317225707.1552512-1-sre@kernel.org>
 <20230317225707.1552512-9-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230317225707.1552512-9-sre@kernel.org>
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

On 3/18/23 00:57, Sebastian Reichel wrote:
> Constant battery data is available through power-supply's simple-battery
> API. This works automatically, so the manual handling can be removed
> without loosing any feature :)
> 
> Note, that the POWER_SUPPLY_STATUS_FULL check for the level variable can
> be dropped, since the variable is never written. It can be re-introduced
> properly once the driver gets functionality to calculate the current
> charge level. Apart from that the check must be done fuzzy anyways,
> since charge estimation usually is not precise enough to always return
> exactly the full charge capacity for a full battery.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

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
> -	return adc_bat->status;
> -}
> -
>   static enum gab_chan_type gab_prop_to_chan(enum power_supply_property psp)
>   {
>   	switch (psp) {
> @@ -144,27 +122,12 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
>   static int gab_get_property(struct power_supply *psy,
>   		enum power_supply_property psp, union power_supply_propval *val)
>   {
> -	struct gab *adc_bat;
> -	struct gab_platform_data *pdata;
> -	struct power_supply_info *bat_info;
> -	int result = 0;
> -	int ret = 0;
> -
> -	adc_bat = to_generic_bat(psy);
> -	if (!adc_bat) {
> -		dev_err(&psy->dev, "no battery infos ?!\n");
> -		return -EINVAL;
> -	}
> -	pdata = adc_bat->pdata;
> -	bat_info = &pdata->battery_info;
> +	struct gab *adc_bat = to_generic_bat(psy);
>   
>   	switch (psp) {
>   	case POWER_SUPPLY_PROP_STATUS:
> -		val->intval = gab_get_status(adc_bat);
> -		break;
> -	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
> -		val->intval = 0;
> -		break;
> +		val->intval = adc_bat->status;
> +		return 0;
>   	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>   	case POWER_SUPPLY_PROP_POWER_NOW:
> @@ -173,26 +136,9 @@ static int gab_get_property(struct power_supply *psy,
>   			goto err;
>   		val->intval = result;
>   		break;
> -	case POWER_SUPPLY_PROP_TECHNOLOGY:
> -		val->intval = bat_info->technology;
> -		break;
> -	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> -		val->intval = bat_info->voltage_min_design;
> -		break;
> -	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> -		val->intval = bat_info->voltage_max_design;
> -		break;
> -	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> -		val->intval = bat_info->charge_full_design;
> -		break;
> -	case POWER_SUPPLY_PROP_MODEL_NAME:
> -		val->strval = bat_info->name;
> -		break;
>   	default:
>   		return -EINVAL;
>   	}
> -err:
> -	return ret;
>   }
>   
>   static void gab_work(struct work_struct *work)
> @@ -235,7 +181,6 @@ static int gab_probe(struct platform_device *pdev)
>   	struct gab *adc_bat;
>   	struct power_supply_desc *psy_desc;
>   	struct power_supply_config psy_cfg = {};
> -	struct gab_platform_data *pdata = pdev->dev.platform_data;
>   	enum power_supply_property *properties;
>   	int ret = 0;
>   	int chan;
> @@ -248,7 +193,7 @@ static int gab_probe(struct platform_device *pdev)
>   
>   	psy_cfg.drv_data = adc_bat;
>   	psy_desc = &adc_bat->psy_desc;
> -	psy_desc->name = pdata->battery_info.name;
> +	psy_desc->name = dev_name(&pdev->dev);
>   
>   	/* bootup default values for the battery */
>   	adc_bat->cable_plugged = false;
> @@ -256,7 +201,6 @@ static int gab_probe(struct platform_device *pdev)
>   	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
>   	psy_desc->get_property = gab_get_property;
>   	psy_desc->external_power_changed = gab_ext_power_changed;
> -	adc_bat->pdata = pdata;
>   
>   	/*
>   	 * copying the static properties and allocating extra memory for holding
> diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
> deleted file mode 100644
> index 54434e4304d3..000000000000
> --- a/include/linux/power/generic-adc-battery.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2012, Anish Kumar <anish198519851985@gmail.com>
> - */
> -
> -#ifndef GENERIC_ADC_BATTERY_H
> -#define GENERIC_ADC_BATTERY_H
> -
> -/**
> - * struct gab_platform_data - platform_data for generic adc iio battery driver.
> - * @battery_info:         recommended structure to specify static power supply
> - *			   parameters
> - */
> -struct gab_platform_data {
> -	struct power_supply_info battery_info;
> -};
> -
> -#endif /* GENERIC_ADC_BATTERY_H */

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

