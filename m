Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514616BA891
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCOHB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjCOHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:01:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A16253734;
        Wed, 15 Mar 2023 00:01:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi9so878925lfb.12;
        Wed, 15 Mar 2023 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678863712;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOJ4Yjw15bXt8teuteIjQCFacvp8fUsGlorwX7mWOk8=;
        b=EkVePWOSMUjO1PNVxm8tPramhXLllEvMmo/nL0wbaaqQea5pyECtkBXSPur7lqHxY9
         CKU58KdKADjaWiqRiYwNtx56pXop7WPvSrY4WwPzuHrCjEzbrVAEbCaNT03Zt+h1oppH
         QaSX9oIrpPzlxOrBCE6Rc4gTIUvbYqD4YPinblJCWOX+9NGM9z3oxU/1UbH0DqORulFb
         CE3VUIVP/qFte6CMWWe5d9SjGSDcdLQl5tl9emh18AfHcz4VqPhrKJmAaSyuy30t4z8q
         VqeDmmZaSeXfvD8UB3HqfrgeeBjuoXLCY+ORYUwoxf7hsVG5SwkfbmVRn1s1PuwXaKB/
         dJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678863712;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJ4Yjw15bXt8teuteIjQCFacvp8fUsGlorwX7mWOk8=;
        b=4+vRCPvw2h3sL0I6Zvlvfsr/K/H8eIDA0FTlmBmwuDhYxZRPI2xZox4Xv5ZTco5Gqf
         mf2WeaUlEBrtHqj/pxeCpTX3dFCn3u79alDutdZB2EGJ3ogENLSQ7WeX0sCDLr6fkKXC
         u5KYTGxL8Azx3dI9GBgwHcrh9RfzhoWSOMZ2/fJclV1umPiyLtl9WzWh45OeB0K5EoAg
         X/+ZPZwwdkVxGQ7zL0rJ2t0Khb7sl70PRvnJdoolSd0QruY2nz3Qgfn6FVa2T++LGdo5
         2adQiHsbe7Yn2UUuytyO2Ssdda5kBTgxu40uWzadAth0Sp7W5kUtjvxfzKjLZH/080Kr
         mPtA==
X-Gm-Message-State: AO0yUKUw+xDfG2sqwtBRF8LdXlbOiouKJoDa88+325qCxeraQw7QTItc
        csyV8AXrLA39UBfs51auVhGgY5pWhjc=
X-Google-Smtp-Source: AK7set+Le96Ei9X8pGQ8GCIQj7+LF5VqFgqqIKlT4lY4wFjLuvJQoh73vOluRShcn0dO0u+MB+vEYw==
X-Received: by 2002:a05:6512:24f:b0:4dd:998b:4dc7 with SMTP id b15-20020a056512024f00b004dd998b4dc7mr1636411lfo.21.1678863711531;
        Wed, 15 Mar 2023 00:01:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id x16-20020ac259d0000000b004dc4b00a1eesm709675lfn.261.2023.03.15.00.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:01:50 -0700 (PDT)
Message-ID: <baffa307-173c-6ba1-0289-e7287049c0f5@gmail.com>
Date:   Wed, 15 Mar 2023 09:01:50 +0200
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
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-3-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv2 02/12] power: supply: core: auto-exposure of
 simple-battery data
In-Reply-To: <20230314225535.1321736-3-sre@kernel.org>
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
> Add support for automatically exposing data from the
> simple-battery firmware node with a single configuration
> option in the power-supply device.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   drivers/power/supply/power_supply_core.c  | 173 +++++++++++++++++++---
>   drivers/power/supply/power_supply_sysfs.c |  15 ++
>   include/linux/power_supply.h              |   8 +
>   3 files changed, 178 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index f3d7c1da299f..842c27de4fac 100644
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
> @@ -832,6 +832,133 @@ void power_supply_put_battery_info(struct power_supply *psy,
>   }
>   EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>   
> +const enum power_supply_property power_supply_battery_info_properties[] = {
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +};
> +EXPORT_SYMBOL_GPL(power_supply_battery_info_properties);
> +
> +const size_t power_supply_battery_info_properties_size = ARRAY_SIZE(power_supply_battery_info_properties);
> +EXPORT_SYMBOL_GPL(power_supply_battery_info_properties_size);
> +
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
> +
>   /**
>    * power_supply_temp2resist_simple() - find the battery internal resistance
>    * percent from temperature
> @@ -1046,6 +1173,22 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
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
> @@ -1056,7 +1199,12 @@ int power_supply_get_property(struct power_supply *psy,
>   		return -ENODEV;
>   	}
>   
> -	return psy->desc->get_property(psy, psp, val);
> +	if (psy_has_property(psy->desc, psp))
> +		return psy->desc->get_property(psy, psp, val);
> +	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> +		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
> +	else
> +		return -EINVAL;
>   }
>   EXPORT_SYMBOL_GPL(power_supply_get_property);
>   
> @@ -1117,22 +1265,6 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
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

I do really like everything in this patch up to this point :) Core 
providing properties to the user based on the battery-info seems great 
to me.

>   #ifdef CONFIG_THERMAL
>   static int power_supply_read_temp(struct thermal_zone_device *tzd,
>   		int *temp)
> @@ -1255,6 +1387,11 @@ __power_supply_register(struct device *parent,
>   		goto check_supplies_failed;
>   	}
>   
> +	/* psy->battery_info is optional */
> +	rc = power_supply_get_battery_info(psy, &psy->battery_info);
> +	if (rc && rc != -ENODEV)
> +		goto check_supplies_failed;
> +

This is what rubs me in a slightly wrong way - but again, you probably 
know better than I what's the direction things are heading so please 
ignore me if I am talking nonsense :)

Anyways, I think the battery information may be relevant to the driver 
which is registering the power-supply. It may be there is a fuel-gauge 
which needs to know the capacity and OCV tables etc. Or some other 
thingy. And - I may be wrong - but I have a feeling it might be 
something that should be known prior registering the power-supply.

So, in my head it should be the driver which is getting the information 
about the battery (whether it is in the DT node or coded in some tables 
and fetched by battery type) - using helpers provided by core.

I further think it should be the driver who can pass the battery 
information to core at registration - core may 'fall-back' finding 
information itself if driver did not provide it.

So, I think the core should not unconditionally populate the 
battery-info here but it should first check if the driver had it already 
filled.

Well, as I said, I recognize I may not (do not) know all the dirty 
details and I do trust you to evaluate if what I wrote here makes any 
sense :) All in all, I think this auto-exposure is great.

Please, bear with me if what I wrote above does not make sense to you 
and just assume I don't see the big picture :)

>   	spin_lock_init(&psy->changed_lock);
>   	rc = device_add(dev);
>   	if (rc)
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index c228205e0953..5842dfe5dfb7 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -380,6 +380,9 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>   		}
>   	}
>   
> +	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> +		return mode;
> +
>   	return 0;
>   }
>   
> @@ -461,6 +464,8 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
>   int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>   {
>   	const struct power_supply *psy = dev_get_drvdata(dev);
> +	const enum power_supply_property *battery_props =
> +		power_supply_battery_info_properties;
>   	int ret = 0, j;
>   	char *prop_buf;
>   
> @@ -488,6 +493,16 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>   			goto out;
>   	}
>   
> +	for (j = 0; j < power_supply_battery_info_properties_size; j++) {
> +		if (!power_supply_battery_info_has_prop(psy->battery_info,
> +				battery_props[j]))
> +			continue;

Hmm. I just noticed that there can probably be same properties in the 
psy->desc->properties and in the battery-info. I didn't cascade deep 
into the code so I can't say if it is a problem to add duplicates?

So, if this is safe, and if what I wrote above is not something you want 
to consider:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> +		ret = add_prop_uevent(dev, env, battery_props[j],
> +			      prop_buf);
> +		if (ret)
> +			goto out;
> +	}
> +
>   out:
>   	free_page((unsigned long)prop_buf);
>   
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index aa2c4a7c4826..a427f13c757f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -301,6 +301,7 @@ struct power_supply {
>   	bool initialized;
>   	bool removing;
>   	atomic_t use_cnt;
> +	struct power_supply_battery_info *battery_info;
>   #ifdef CONFIG_THERMAL
>   	struct thermal_zone_device *tzd;
>   	struct thermal_cooling_device *tcd;
> @@ -791,10 +792,17 @@ devm_power_supply_get_by_phandle(struct device *dev, const char *property)
>   { return NULL; }
>   #endif /* CONFIG_OF */
>   
> +extern const enum power_supply_property power_supply_battery_info_properties[];
> +extern const size_t power_supply_battery_info_properties_size;
>   extern int power_supply_get_battery_info(struct power_supply *psy,
>   					 struct power_supply_battery_info **info_out);
>   extern void power_supply_put_battery_info(struct power_supply *psy,
>   					  struct power_supply_battery_info *info);
> +extern bool power_supply_battery_info_has_prop(struct power_supply_battery_info *info,
> +					       enum power_supply_property psp);
> +extern int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,
> +					      enum power_supply_property psp,
> +					      union power_supply_propval *val);
>   extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
>   				       int table_len, int ocv);
>   extern struct power_supply_battery_ocv_table *

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

