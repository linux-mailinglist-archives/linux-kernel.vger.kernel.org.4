Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C86B6F97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCMGpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCMGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:45:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944941088;
        Sun, 12 Mar 2023 23:45:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp27so4020147lfb.6;
        Sun, 12 Mar 2023 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678689919;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY0qPy0GOPqIHczpB+O9ixtAv+lNXDzFAMv5wze+hKI=;
        b=DoaDcMzlv11N1PE21UzFZ7OEXCuHHSgLsHIep70JFsRR3+ffDF46tWSKmt2/OV34GV
         8MF2X+OuYqhLkcBeOr/hoV+Lwb+3savscxyTTunXAnSBZ4kZMUQbioCovhGOg8kT6oha
         qowY1i8VCV42O7kP4bwvPaVsyn5qw23oDUhIZyeknK0i2U//2/zgXsY7H06FdrXjEslB
         AcsLttt+uhA+8zfu0/VDwaGargtDyr1ta56IHtBm2tsQOSuJR70gMjMfvtckObsl60jS
         SZjX1WbYKS/y5OhlVVAYqxXz/fMolO/puY86i8c9zQnLQZcJKCa/BUKyXbTgAkxH5Ot8
         3MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678689919;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY0qPy0GOPqIHczpB+O9ixtAv+lNXDzFAMv5wze+hKI=;
        b=70SWN+wRhHzyjyUdfv+mM8G0PoB0wpXhMENxy3QQUEfz+6OaRiAJ3dt73iVFcbrgQL
         8XCMHh3BIW6eo0kfQ6ZawQmg2juGWcaNxdKZPX8wSPnS9mgn0NIoQ3togmpqlXWspJqV
         yurRfTv6sxiLo0yj6Eis3Fr6d1jDOYtXdZHPfShyKcGnSUecwoNMlsxdGC0qNfjlDoEW
         8YdcncRXaKqAyheDPy/a0IfZ7m+iGN3L0mow8HNJpAVERQmfkKKqaQsUPKMR8J8cFlUd
         wdTHTGpjyEVsiTQO3P1MyrCMZb3fGUND1Ebtug/v2GZIm1YFXENABwsaE9RTy/LU0Iv5
         GkVw==
X-Gm-Message-State: AO0yUKXhRf6fkJ7JGnz8Vd3neyCGmF6DeJyTpnIIfYOqVImR+yRThGzA
        UlDboUO8zulg6pbFCnmNRe4=
X-Google-Smtp-Source: AK7set/jEXYFFDMIxAZqfVeFG9BX06e4S9c/mBX/neppggLLD6qHkfZ0NTU5CLoGXxDHy1TE16+EHQ==
X-Received: by 2002:a05:6512:23a7:b0:4db:5123:c271 with SMTP id c39-20020a05651223a700b004db5123c271mr3610230lfv.29.1678689919303;
        Sun, 12 Mar 2023 23:45:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id s13-20020a19ad4d000000b004e048852377sm866850lfd.263.2023.03.12.23.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:45:18 -0700 (PDT)
Message-ID: <cd278a98-c8dc-ac73-f269-e75cd88f9a27@gmail.com>
Date:   Mon, 13 Mar 2023 08:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-3-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv1 02/11] power: supply: core: auto-exposure of
 simple-battery data
In-Reply-To: <20230309225041.477440-3-sre@kernel.org>
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

On 3/10/23 00:50, Sebastian Reichel wrote:
> Add support for automatically exposing data from the
> simple-battery firmware node with a single configuration
> option in the power-supply device.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   drivers/power/supply/power_supply_core.c  | 153 +++++++++++++++++++---
>   drivers/power/supply/power_supply_sysfs.c |  16 +++
>   include/linux/power_supply.h              |  31 +++++
>   3 files changed, 181 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index f3d7c1da299f..c3684ec46b3f 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -388,7 +388,7 @@ static int __power_supply_get_supplier_property(struct device *dev, void *_data)
>   	struct psy_get_supplier_prop_data *data = _data;
>   
>   	if (__power_supply_is_supplied_by(epsy, data->psy))
> -		if (!epsy->desc->get_property(epsy, data->psp, data->val))
> +		if (!power_supply_get_property(epsy, data->psp, data->val))
>   			return 1; /* Success */
>   
>   	return 0; /* Continue iterating */
> @@ -832,6 +832,111 @@ void power_supply_put_battery_info(struct power_supply *psy,
>   }
>   EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>   
> +bool power_supply_battery_info_has_prop(struct power_supply_battery_info *info,
> +				        enum power_supply_property psp)
> +{
> +	if (!info)
> +		return false;
> +
> +	switch (psp) {
> +		case POWER_SUPPLY_PROP_TECHNOLOGY:
> +			return info->technology != POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> +		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +			return info->energy_full_design_uwh >= 0;
> +		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +			return info->charge_full_design_uah >= 0;
> +		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +			return info->voltage_min_design_uv >= 0;
> +		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +			return info->voltage_max_design_uv >= 0;
> +		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +			return info->precharge_current_ua >= 0;
> +		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +			return info->charge_term_current_ua >= 0;
> +		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +			return info->constant_charge_current_max_ua >= 0;
> +		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +			return info->constant_charge_voltage_max_uv >= 0;
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> +			return info->temp_ambient_alert_min > INT_MIN;
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> +			return info->temp_ambient_alert_max < INT_MAX;
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +			return info->temp_alert_min > INT_MIN;
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +			return info->temp_alert_max < INT_MAX;
> +		case POWER_SUPPLY_PROP_TEMP_MIN:
> +			return info->temp_min > INT_MIN;
> +		case POWER_SUPPLY_PROP_TEMP_MAX:
> +			return info->temp_max < INT_MAX;
> +		default:
> +			return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(power_supply_battery_info_has_prop);
> +
> +int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	if (!info)
> +		return -EINVAL;
> +
> +	if (!power_supply_battery_info_has_prop(info, psp))
> +		return -EINVAL;
> +
> +	switch (psp) {
> +		case POWER_SUPPLY_PROP_TECHNOLOGY:
> +			val->intval = info->technology;
> +			return 0;
> +		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +			val->intval = info->energy_full_design_uwh;
> +			return 0;
> +		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +			val->intval = info->charge_full_design_uah;
> +			return 0;
> +		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +			val->intval = info->voltage_min_design_uv;
> +			return 0;
> +		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +			val->intval = info->voltage_max_design_uv;
> +			return 0;
> +		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +			val->intval = info->precharge_current_ua;
> +			return 0;
> +		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +			val->intval = info->charge_term_current_ua;
> +			return 0;
> +		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +			val->intval = info->constant_charge_current_max_ua;
> +			return 0;
> +		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +			val->intval = info->constant_charge_voltage_max_uv;
> +			return 0;
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> +			val->intval = info->temp_ambient_alert_min;
> +			return 0;
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> +			val->intval = info->temp_ambient_alert_max;
> +			return 0;
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +			val->intval = info->temp_alert_min;
> +			return 0;
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +			val->intval = info->temp_alert_max;
> +			return 0;
> +		case POWER_SUPPLY_PROP_TEMP_MIN:
> +			val->intval = info->temp_min;
> +			return 0;
> +		case POWER_SUPPLY_PROP_TEMP_MAX:
> +			val->intval = info->temp_max;
> +			return 0;
> +		default:
> +			return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(power_supply_battery_info_get_prop);

This is not really relevant for the series. Just speaking it as it came 
into my mind - I am not expecting changes to this series.

I do very much like the way you have these battery-info APIs not 
requiring the "struct power_supply *psy". It may be useful for drivers 
to get the stuff from battery-node prior registering to the power-supply 
core. I think it'd be nice to have a 'power-supply-info getter API like 
power_supply_get_battery_info() - which does not require the struct 
power_supply * but just a device pointer or fwnode pointer. I think it 
might also be reasonable to pull the battery-info parsing APIs in own 
file. Or maybe not - definitely up-to you guys. I don't have any active 
psy-stuff at my hands right now :)

> +
>   /**
>    * power_supply_temp2resist_simple() - find the battery internal resistance
>    * percent from temperature
> @@ -1046,6 +1151,22 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
>   }
>   EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
>   
> +static bool psy_has_property(const struct power_supply_desc *psy_desc,
> +			     enum power_supply_property psp)
> +{
> +	bool found = false;
> +	int i;
> +
> +	for (i = 0; i < psy_desc->num_properties; i++) {
> +		if (psy_desc->properties[i] == psp) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	return found;
> +}
> +
>   int power_supply_get_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
>   			    union power_supply_propval *val)
> @@ -1056,9 +1177,13 @@ int power_supply_get_property(struct power_supply *psy,
>   		return -ENODEV;
>   	}
>   
> -	return psy->desc->get_property(psy, psp, val);
> +	if (psy_has_property(psy->desc, psp))
> +		return psy->desc->get_property(psy, psp, val);
> +	else if(psy->desc->expose_battery_info)
> +		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
> +	else
> +		return -EINVAL;
>   }
> -EXPORT_SYMBOL_GPL(power_supply_get_property);
>   
>   int power_supply_set_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
> @@ -1117,22 +1242,6 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
>   
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> -{
> -	bool found = false;
> -	int i;
> -
> -	for (i = 0; i < psy_desc->num_properties; i++) {
> -		if (psy_desc->properties[i] == psp) {
> -			found = true;
> -			break;
> -		}
> -	}
> -
> -	return found;
> -}
> -
>   #ifdef CONFIG_THERMAL
>   static int power_supply_read_temp(struct thermal_zone_device *tzd,
>   		int *temp)
> @@ -1255,6 +1364,12 @@ __power_supply_register(struct device *parent,
>   		goto check_supplies_failed;
>   	}
>   
> +	if (psy->desc->expose_battery_info) {
> +		rc = power_supply_get_battery_info(psy, &psy->battery_info);
> +		if (rc)
> +			goto check_supplies_failed;
> +	}
> +
>   	spin_lock_init(&psy->changed_lock);
>   	rc = device_add(dev);
>   	if (rc)
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index c228205e0953..8822a17f9589 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -380,6 +380,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>   		}
>   	}
>   
> +	if (psy->desc->expose_battery_info) {
> +		if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> +			return mode;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -488,6 +493,17 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>   			goto out;
>   	}
>   
> +	if (psy->desc->expose_battery_info) {
> +		for (j = 0; j < ARRAY_SIZE(power_supply_battery_info_properties); j++) {
> +			if (!power_supply_battery_info_has_prop(psy->battery_info, power_supply_battery_info_properties[j]))
> +				continue;
> +			ret = add_prop_uevent(dev, env, power_supply_battery_info_properties[j],
> +				      prop_buf);

Usually I do not spot styling things like this - but for some reason it 
now caught my attention. If you for some reason respin, then you might 
want to either do this an oneliner - or split the longer line 
"power_supply_battery_info_has_prop(..." just above.

With or without that:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

