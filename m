Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4A659016
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiL2SAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiL2SAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:00:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DFF266
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:00:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso11600076wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bnRFOtera/4Ai8XY9VXDNmw2ZETDuwKCzUgDJzLzns=;
        b=aS9QRK9h8BSd/H2DZeb0wrji/oEisoLg6mAYuNNOEOitrJVGk4t/l57o/rShSX5bS1
         gBEs4qyz1ZFQGgu2RbmM1Tre3j0TUOIDvtbto4VrW+EJYYvG/AHws9+vTz6VTtmEySVK
         SJRYcOGuaOqBLTrmcJU33bo7b/97ERO/3faPgg5V0KurGJMYYbbnOn127fA/XDDuhKsX
         LNfTAvqCIFY5lO3nXL0mishSSzo5igucdZRv4X6Gh2IIaYRsindb+lxIwFgZGYF7XoY4
         GVKztDSn543NizgVGMA7Gr6VPIBBah2nTQTxUsN9Czgn8iYzXNwaM1TWmrycn28dZ1y7
         2ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bnRFOtera/4Ai8XY9VXDNmw2ZETDuwKCzUgDJzLzns=;
        b=tznpAmL1PXLeFVofnmyrmOFC2FMaHsmkYCe/JGe6WsEPxAprMpIkHohGTTT+i7KTU8
         Z2EnAnD2kI1eK0aJaHDSTlj3eOn0LexrA3HqZy2zUYtwQ88gjtkYGRNk36kAD+zzKk2b
         xB2ZDg5S06f48OCZP7x6NN9DzDyVF+tbgncNXV9gwx7u5IGCclFY7bqYFG/hGV3LBq29
         5RFCq5Hi8N3BPyallD70oP2RggRAGGymxqtyAYAfKpjWf8AAqb4cXJWJjg03eshZ/QgG
         nSTF45AM7Hg8kp55bwPePfFf1VNO6DqVs6n+VXW8C4eAMBrHUHBOFZBUC3gBduCweb2g
         PQtg==
X-Gm-Message-State: AFqh2kq7FCQcofY3y+HR8Pzfg/xVK8zshBlp8tkWzd0HoQK7ApJDdQrb
        YHSHDp5P3nvmrqBfgghePWCQCA==
X-Google-Smtp-Source: AMrXdXvOUVzfSXMefQYKAU9R4QRh3+fb8PF3hR1HTvnmyBkvD/FllJJNib9Ei5eCwLQCFVEAVK8LwA==
X-Received: by 2002:a05:600c:21c1:b0:3d3:45c6:b641 with SMTP id x1-20020a05600c21c100b003d345c6b641mr21184064wmj.22.1672336842514;
        Thu, 29 Dec 2022 10:00:42 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n25-20020a7bc5d9000000b003d969a595fbsm25393250wmk.10.2022.12.29.10.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 10:00:42 -0800 (PST)
Message-ID: <9a500c88-2f1b-f7cd-a2ce-d12305c27d0a@linaro.org>
Date:   Thu, 29 Dec 2022 19:00:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] thermal/acpi: Add ACPI trip point routines
Content-Language: en-US
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20221221183840.2352014-1-daniel.lezcano@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221221183840.2352014-1-daniel.lezcano@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

does this patch to convert ACPI trip points description into generic 
structure as the thermal device tree parsing makes sense ?


On 21/12/2022 19:38, Daniel Lezcano wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The ACPI specification describes the trip points, the device tree
> bindings as well.
> 
> The OF code uses the generic trip point structures.
> 
> The ACPI has their own trip points structure and uses the get_trip_*
> ops to retrieve them.
> 
> We can do the same as the OF code and create a set of ACPI functions
> to retrieve a trip point description. Having a common code for ACPI
> will help to cleanup the remaining Intel drivers and get rid of the
> get_trip_* functions.
> 
> These changes add the ACPI thermal calls to retrieve the basic
> information we need to be reused in the thermal ACPI and Intel
> drivers.
> 
> It does not depend on any material.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> ---
>   drivers/thermal/Kconfig        |  13 ++
>   drivers/thermal/Makefile       |   1 +
>   drivers/thermal/thermal_acpi.c | 267 +++++++++++++++++++++++++++++++++
>   include/linux/thermal.h        |  16 ++
>   4 files changed, 297 insertions(+)
>   create mode 100644 drivers/thermal/thermal_acpi.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..e57011be7009 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -76,6 +76,19 @@ config THERMAL_OF
>   	  Say 'Y' here if you need to build thermal infrastructure
>   	  based on device tree.
>   
> +config THERMAL_ACPI
> +	bool
> +	prompt "APIs to parse thermal data out of the ACPI tables"
> +	depends on ACPI
> +	default y
> +	help
> +	  This options provides helpers to add the support to
> +	  read and parse thermal data definitions out of the
> +	  ACPI tables blob.
> +
> +	  Say 'Y' here if you need to build thermal infrastructure
> +	  based on ACPI.
> +
>   config THERMAL_WRITABLE_TRIPS
>   	bool "Enable writable trip points"
>   	help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 2506c6c8ca83..60f0dfa9aae2 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
>   # interface to/from other layers providing sensors
>   thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
>   thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
> +thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
>   
>   # governors
>   thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
> diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
> new file mode 100644
> index 000000000000..4e18073f8817
> --- /dev/null
> +++ b/drivers/thermal/thermal_acpi.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * ACPI thermal configuration
> + */
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/units.h>
> +#include <uapi/linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +int thermal_acpi_trip_gtsh(struct acpi_device *adev)
> +{
> +	unsigned long long hyst;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	return (int)(hyst * 100);
> +}
> +
> +int thermal_acpi_get_tzd(struct acpi_device *adev, struct acpi_handle_list *devices)
> +{
> +	acpi_status status;
> +
> +	/*
> +	 * _TZD (Thermal zone device): This optional object evaluates
> +	 * to a package of device names. Each name corresponds to a
> +	 * device in the ACPI namespace that is associated with the
> +	 * thermal zone. The temperature reported by the thermal zone
> +	 * is roughly correspondent to that of each of the devices.
> +	 */
> +	status = acpi_evaluate_reference(adev->handle, "_TZD", NULL, devices);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +int thermal_acpi_get_temp(struct acpi_device *adev, int *temperature)
> +{
> +	unsigned long long temp;
> +	acpi_status status;
> +
> +	/*
> +	 * _TMP (Temperature): This control method returns the thermal zone’s
> +	 * current operating temperature. The return value is the current
> +	 * temperature of the thermal zone in tenths of degrees Kelvin
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &temp);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	*temperature = deci_kelvin_to_millicelsius(temp);
> +	
> +	return 0;
> +}
> +
> +int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip)
> +{
> +	unsigned long long temp;
> +	acpi_status status;
> +
> +	/*
> +	 * _CRT (Critical temperature): This object, when defined under a thermal
> +	 * zone, returns the critical temperature at which OSPM must shutdown
> +	 * the system. If this object it present under a device, the device’s
> +	 * driver evaluates this object to determine the device’s critical cooling
> +	 * temperature trip point. This value may then be used by the device’s
> +	 * driver to program an internal device temperature sensor trip point
> +         */
> +	status = acpi_evaluate_integer(adev->handle, "_CRT", NULL, &temp);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
> +	trip->temperature = deci_kelvin_to_millicelsius(temp);
> +	trip->type = THERMAL_TRIP_CRITICAL;
> +
> +	return 0;
> +}
> +
> +int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
> +{
> +	unsigned long long temp;
> +	acpi_status status;
> +
> +	/*
> +	 * _HOT (Hot Temperature): This optional object, when defined under a
> +	 * thermal zone, returns the critical temperature at which OSPM may
> +	 * choose to transition the system into the S4 sleeping state. The
> +	 * platform vendor should define _HOT to be far enough below _CRT so as
> +	 * to allow OSPM enough time to transition the system into the S4
> +	 * sleeping state. While dependent on the amount of installed memory,
> +	 * on typical platforms OSPM implementations can transition the system
> +	 * into the S4 sleeping state in tens of seconds. If this object it
> +	 * present under a device, the device’s driver evaluates this object to
> +	 * determine the device’s hot cooling temperature trip point. This value
> +	 * may then be used by the device’s driver to program an internal device
> +	 * temperature sensor trip point.
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_HOT", NULL, &temp);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
> +	trip->temperature = deci_kelvin_to_millicelsius(temp);
> +	trip->type = THERMAL_TRIP_HOT;
> +
> +	return 0;
> +}
> +
> +int thermal_acpi_trip_psv_psl(struct acpi_device *adev, struct acpi_handle_list *devices)
> +{
> +	acpi_status status;
> +
> +	/*
> +	 * _PSL (Passive List): This object is defined under a thermal zone and
> +	 *  evaluates to a list of processor objects to be used for passive cooling
> +	 */
> +	status = acpi_evaluate_reference(adev->handle, "_PSL", NULL, devices);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +int thermal_acpi_trip_psv_tsp(struct acpi_device *adev)
> +{
> +	acpi_status status;
> +	unsigned long long tsp;
> +	
> +	/*
> +	 * _TSP (Thermal Sampling Period): This object evaluates to a thermal
> +	 * sampling period (in tenths of seconds) used by OSPM to implement the
> +	 * Passive cooling equation. This value, along with _TC1 and _TC2, will
> +	 * enable OSPM to provide the proper hysteresis required by the system
> +	 * to accomplish an effective passive cooling policy.
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_TSP", NULL, &tsp);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return (int)tsp;
> +}
> +
> +int thermal_acpi_trip_psv_tc1(struct acpi_device *adev)
> +{
> +	acpi_status status;
> +	unsigned long long tc1;
> +
> +	/*
> +	 * _TC1 (Thermal Constant 1): This object evaluates to the constant _TC1
> +	 * for use in the Passive cooling formula
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_TC1", NULL, &tc1);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	return (int)tc1;
> +}
> +
> +int thermal_acpi_trip_psv_tc2(struct acpi_device *adev)
> +{
> +	acpi_status status;
> +	unsigned long long tc2;
> +	
> +	/*
> +	 * _TC2 (Thermal Constant 1): This object evaluates to the constant _TC2
> +	 * for use in the Passive cooling formula
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_TC2", NULL, &tc2);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	return (int)tc2;
> +}
> +
> +int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip)
> +{
> +	unsigned long long temp;
> +	acpi_status status;
> +
> +	/*
> +	 * _PSV (Passive): This optional object, if present under a thermal zone,
> +	 * evaluates to the temperature at which OSPM must activate passive
> +	 * cooling policy
> +	 */
> +	status = acpi_evaluate_integer(adev->handle, "_PSV", NULL, &temp);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	/*
> +	 * The _PSL, _TSP, _TC1 and _TC2 are required if the _PSV object exists.
> +	 * We assume the caller will raise an error if it was able to get the _PSV
> +	 * but then fail to get the other objects.
> +	 */
> +	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
> +	trip->temperature = deci_kelvin_to_millicelsius(temp);
> +	trip->type = THERMAL_TRIP_PASSIVE;
> +
> +	return 0;
> +}
> +
> +int thermal_acpi_trip_acl(struct acpi_device *adev,
> +			  struct acpi_handle_list *devices, int id)
> +{
> +	acpi_status status;
> +	char name[5];	
> +
> +	/*
> +	 * _ALx: This object is defined under a thermal zone and evaluates to a
> +	 * list of Active cooling devices to be turned on when the corresponding
> +	 * _ACx temperature threshold is exceeded. For example, these devices
> +	 * could be fans.
> +	 */
> +	sprintf(name, "_AL%d", id);
> +
> +	status = acpi_evaluate_reference(adev->handle, name, NULL, devices);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int thermal_acpi_trip_act(struct acpi_device *adev,
> +			  struct thermal_trip *trip, int id)
> +{
> +	acpi_status status;
> +	unsigned long long temp;
> +	char name[5];	
> +
> +	/*
> +	 * _ACx: This optional object, if present under a thermal zone, returns
> +	 * the temperature trip point at which OSPM must start or stop active
> +	 * cooling, where x is a value between 0 and 9 that designates multiple
> +	 * active cooling levels of the thermal zone. If the Active cooling
> +	 * device has one cooling level (that is, “on”) then that cooling level
> +	 * must be defined as _AC0. If the cooling device has two levels of
> +	 * capability, such as a high fan speed and a low fan speed, then they
> +	 * must be defined as _AC0 and _AC1 respectively. The smaller the value
> +	 * of x, the greater the cooling strength _ACx represents. In the above
> +	 * example, _AC0 represents the greater level of cooling (the faster fan
> +	 * speed) and _AC1 represents the lesser level of cooling (the slower
> +	 * fan speed). For every _ACx method, there must be a matching _ALx
> +	 * object or a corresponding entry in an _ART object’s active cooling
> +	 * relationship list.
> +	 */
> +	sprintf(name, "_AC%d", id);
> +
> +	status = acpi_evaluate_integer(adev->handle, name, NULL, &temp);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
> +	trip->temperature = deci_kelvin_to_millicelsius(temp);
> +	trip->type = THERMAL_TRIP_ACTIVE;
> +
> +	return 0;
> +}
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e2797f314d99..67608a3a62d3 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -334,6 +334,22 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
>   }
>   #endif
>   
> +#ifdef CONFIG_ACPI
> +struct acpi_handle_list;
> +int thermal_acpi_get_temp(struct acpi_device *adev, int *temperature);
> +int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip);
> +int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
> +int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip);
> +int thermal_acpi_trip_act(struct acpi_device *adev, struct thermal_trip *trip, int id);
> +int thermal_acpi_trip_acl(struct acpi_device *adev, struct acpi_handle_list *devices, int id);
> +int thermal_acpi_trip_psv_psl(struct acpi_device *adev, struct acpi_handle_list *devices);
> +int thermal_acpi_trip_psv_tsp(struct acpi_device *adev);
> +int thermal_acpi_trip_psv_tc1(struct acpi_device *adev);
> +int thermal_acpi_trip_psv_tc2(struct acpi_device *adev);
> +int thermal_acpi_trip_gtsh(struct acpi_device *adev);
> +int thermal_acpi_get_tzd(struct acpi_device *adev, struct acpi_handle_list *devices);
> +#endif
> +
>   int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			  struct thermal_trip *trip);
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

