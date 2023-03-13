Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913C6B74C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCMKzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCMKzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:55:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84543A8C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:55:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l12so2580991wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678704908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFiu4gK1oF4dM0YNdw9Pi5aeqhM8jAUatJngxP34/Pc=;
        b=CVFio4BDa5aU+nkhtauEDIcpFZI5PHh1ReX+icfExlAhiz6NBSg8/TCEzcX1OPtNKp
         nh+74NcBW1PtR9wC7zLCDMs8dnq54M4lNjeSzGGrrhK2anLog/dcV4yfhoOPxql5sC1a
         WeyOG5yVHIWg3zES670S8g7D35LkNB3IH6CVLagbP4EyZLXUbqif2ZoX8/+9fDtwZd4A
         M8kC4LyULXr+XNn25LqHbOSwNAb+v4wklg7HtljcXqpyrEGnKu2yPGJI4Z97s0g0AoL7
         Vf9esYIwKC6QEE5/CpBsPAD6AW/PXiQOYGwczQ8CFTz1jAckyJs5ihhuZAs3vuj2Iu3b
         Kg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678704908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFiu4gK1oF4dM0YNdw9Pi5aeqhM8jAUatJngxP34/Pc=;
        b=oSWqaCUhM5Yo29Z/gPnPrMzth92HKQKVVZXxfHI0misD6CYiwX+fp6n2wg4kufrac3
         WPjnriGdRx834cOwRzjcGp0bgJdnnHXvwEQ12vUqKoimC7iyy9eG8GeeyegQi2FJbbAq
         OMOIHvjC3fl2b2RJiUlF/C0w4gyQ9XzkG260ffAC1LD0vMklMeTlSIxOVIlm2hLSgLKW
         tUaIYmVZxAerGgAziJcstWsm0YtAq+51I/ECH4kEjIYWo52ThgEsJvQcyGHM5d0wmlXe
         y/YEEGXjo81251G1FTYFxvdDXiz5fveEVzUBWS5A7mfRUrawwrnXSIKcnEMYECvb+xd3
         tNqQ==
X-Gm-Message-State: AO0yUKUh2GFxXTTdZ/rUEZXkiUtAxnTxezy0y/xyMpIRf9hBa+uZ6jED
        QOOu0QZYECywxZshBrMRXZRF/g==
X-Google-Smtp-Source: AK7set9f8VZt3snkUFB3q4J/GDNuQzkNCXlRS2pa7s8pf6kxCKYRlcg5VUDjEeFoCHrGWGSQwvzG6w==
X-Received: by 2002:adf:f44c:0:b0:2cf:6089:2408 with SMTP id f12-20020adff44c000000b002cf60892408mr1950978wrp.0.1678704908158;
        Mon, 13 Mar 2023 03:55:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8522:ca6e:1db4:96c6? ([2a05:6e02:1041:c10:8522:ca6e:1db4:96c6])
        by smtp.googlemail.com with ESMTPSA id z16-20020adfd0d0000000b002c5d3f0f737sm7422539wrh.30.2023.03.13.03.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:55:07 -0700 (PDT)
Message-ID: <ca4e9523-0d12-c29f-6de1-365d1713ec84@linaro.org>
Date:   Mon, 13 Mar 2023 11:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 03/11] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Content-Language: en-US
To:     rafael@kernel.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        "open list:INTEL MENLOW THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-4-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230307133735.90772-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

is this code removal acceptable ?


On 07/03/2023 14:37, Daniel Lezcano wrote:
> The driver hooks the thermal framework sysfs to add some driver
> specific information. A debatable approach as that may belong the
> device sysfs directory, not the thermal zone directory.
> 
> As the driver is accessing the thermal internals, we should provide at
> least an API to the thermal framework to add an attribute to the
> existing sysfs thermal zone entry.
> 
> Before doing that and given the age of the driver (2008) may be it is
> worth to double check if these attributes are really needed. So my
> first proposal is to remove them if that does not hurt.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>



> ---
>   drivers/thermal/intel/intel_menlow.c | 193 ---------------------------
>   1 file changed, 193 deletions(-)
> 
> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> index 5a6ad0552311..5a9738a93083 100644
> --- a/drivers/thermal/intel/intel_menlow.c
> +++ b/drivers/thermal/intel/intel_menlow.c
> @@ -230,174 +230,8 @@ struct intel_menlow_attribute {
>   static LIST_HEAD(intel_menlow_attr_list);
>   static DEFINE_MUTEX(intel_menlow_attr_lock);
>   
> -/*
> - * sensor_get_auxtrip - get the current auxtrip value from sensor
> - * @handle: Object handle
> - * @index : GET_AUX1/GET_AUX0
> - * @value : The address will be fill by the value
> - */
> -static int sensor_get_auxtrip(acpi_handle handle, int index,
> -							unsigned long long *value)
> -{
> -	acpi_status status;
> -
> -	if ((index != 0 && index != 1) || !value)
> -		return -EINVAL;
> -
> -	status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
> -				       NULL, value);
> -	if (ACPI_FAILURE(status))
> -		return -EIO;
> -
> -	return 0;
> -}
> -
> -/*
> - * sensor_set_auxtrip - set the new auxtrip value to sensor
> - * @handle: Object handle
> - * @index : GET_AUX1/GET_AUX0
> - * @value : The value will be set
> - */
> -static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
> -{
> -	acpi_status status;
> -	union acpi_object arg = {
> -		ACPI_TYPE_INTEGER
> -	};
> -	struct acpi_object_list args = {
> -		1, &arg
> -	};
> -	unsigned long long temp;
> -
> -	if (index != 0 && index != 1)
> -		return -EINVAL;
> -
> -	status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
> -				       NULL, &temp);
> -	if (ACPI_FAILURE(status))
> -		return -EIO;
> -	if ((index && value < temp) || (!index && value > temp))
> -		return -EINVAL;
> -
> -	arg.integer.value = value;
> -	status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
> -				       &args, &temp);
> -	if (ACPI_FAILURE(status))
> -		return -EIO;
> -
> -	/* do we need to check the return value of SAX0/SAX1 ? */
> -
> -	return 0;
> -}
> -
> -#define to_intel_menlow_attr(_attr)	\
> -	container_of(_attr, struct intel_menlow_attribute, attr)
> -
> -static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
> -			char *buf, int idx)
> -{
> -	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
> -	unsigned long long value;
> -	int result;
> -
> -	result = sensor_get_auxtrip(attr->handle, idx, &value);
> -	if (result)
> -		return result;
> -
> -	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
> -}
> -
> -static ssize_t aux0_show(struct device *dev,
> -			 struct device_attribute *dev_attr, char *buf)
> -{
> -	return aux_show(dev, dev_attr, buf, 0);
> -}
> -
> -static ssize_t aux1_show(struct device *dev,
> -			 struct device_attribute *dev_attr, char *buf)
> -{
> -	return aux_show(dev, dev_attr, buf, 1);
> -}
> -
> -static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
> -			 const char *buf, size_t count, int idx)
> -{
> -	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
> -	int value;
> -	int result;
> -
> -	/*Sanity check; should be a positive integer */
> -	if (!sscanf(buf, "%d", &value))
> -		return -EINVAL;
> -
> -	if (value < 0)
> -		return -EINVAL;
> -
> -	result = sensor_set_auxtrip(attr->handle, idx,
> -				    celsius_to_deci_kelvin(value));
> -	return result ? result : count;
> -}
> -
> -static ssize_t aux0_store(struct device *dev,
> -			  struct device_attribute *dev_attr,
> -			  const char *buf, size_t count)
> -{
> -	return aux_store(dev, dev_attr, buf, count, 0);
> -}
> -
> -static ssize_t aux1_store(struct device *dev,
> -			  struct device_attribute *dev_attr,
> -			  const char *buf, size_t count)
> -{
> -	return aux_store(dev, dev_attr, buf, count, 1);
> -}
> -
>   /* BIOS can enable/disable the thermal user application in dabney platform */
>   #define BIOS_ENABLED "\\_TZ.GSTS"
> -static ssize_t bios_enabled_show(struct device *dev,
> -				 struct device_attribute *attr, char *buf)
> -{
> -	acpi_status status;
> -	unsigned long long bios_enabled;
> -
> -	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
> -}
> -
> -static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
> -					  void *store, struct device *dev,
> -					  acpi_handle handle)
> -{
> -	struct intel_menlow_attribute *attr;
> -	int result;
> -
> -	attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
> -	if (!attr)
> -		return -ENOMEM;
> -
> -	sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
> -	attr->attr.attr.name = name;
> -	attr->attr.attr.mode = mode;
> -	attr->attr.show = show;
> -	attr->attr.store = store;
> -	attr->device = dev;
> -	attr->handle = handle;
> -
> -	result = device_create_file(dev, &attr->attr);
> -	if (result) {
> -		kfree(attr);
> -		return result;
> -	}
> -
> -	mutex_lock(&intel_menlow_attr_lock);
> -	list_add_tail(&attr->node, &intel_menlow_attr_list);
> -	mutex_unlock(&intel_menlow_attr_lock);
> -
> -	return 0;
> -}
>   
>   static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>   						void *context, void **rv)
> @@ -420,12 +254,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>   	if (ACPI_FAILURE(status))
>   		return (status == AE_NOT_FOUND) ? AE_OK : status;
>   
> -	result = intel_menlow_add_one_attribute("aux0", 0644,
> -						aux0_show, aux0_store,
> -						&thermal->device, handle);
> -	if (result)
> -		return AE_ERROR;
> -
>   	status = acpi_get_handle(handle, GET_AUX1, &dummy);
>   	if (ACPI_FAILURE(status))
>   		goto aux1_not_found;
> @@ -434,27 +262,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>   	if (ACPI_FAILURE(status))
>   		goto aux1_not_found;
>   
> -	result = intel_menlow_add_one_attribute("aux1", 0644,
> -						aux1_show, aux1_store,
> -						&thermal->device, handle);
> -	if (result) {
> -		intel_menlow_unregister_sensor();
> -		return AE_ERROR;
> -	}
> -
> -	/*
> -	 * create the "dabney_enabled" attribute which means the user app
> -	 * should be loaded or not
> -	 */
> -
> -	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
> -						bios_enabled_show, NULL,
> -						&thermal->device, handle);
> -	if (result) {
> -		intel_menlow_unregister_sensor();
> -		return AE_ERROR;
> -	}
> -
>   	return AE_OK;
>   
>    aux1_not_found:

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

