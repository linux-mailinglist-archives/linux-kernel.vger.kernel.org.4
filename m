Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA62689E48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjBCP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjBCP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:27:16 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A1A6403;
        Fri,  3 Feb 2023 07:26:51 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r34-20020a05683044a200b0068d4a8a8d2dso1434443otv.12;
        Fri, 03 Feb 2023 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1v3N93K+wFvh1o9fHYZEbm4yYTFQVCIycI7xJBRS6I=;
        b=pntJ5U19/et9QhQvRV5mqbEkerlSa9CDs7/oYR6bHIj/r3UnKPW83xnpcuAqLmvk86
         TlI7H5LQgl260jxJpn3VC03nobN/hH3FK9ky1luSkSUuWdtvlLZSLDlR34iMyTfuqK93
         PFYEuZnCL6fyucJrK/gkxszI3VE1pWhKTXzhhHhgPb34sBNkvUgXAT8L8quc8TIylbbi
         dyDpQFxbgBfzMY13Zs+9YOB3miCGsmPW0xlljN9lG9nja5obDNhYe6dS409UCMqa27sn
         Ga0l9lvDsjy7bcFukdrAj42uxko6lBaWnuIRVX0kdmbZKIuBxmo6rawipa7Dc7/6pjKV
         nGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1v3N93K+wFvh1o9fHYZEbm4yYTFQVCIycI7xJBRS6I=;
        b=lT30tU/8ySW/Wf4dtZuvB8acW4TjYbf2vwZco4R7ylwaPnrdTZZHyEw3JzTrv+WSye
         NCIlGPP5FXCdvvHHlV3QNwprtp36aLNph/ITZusagBGBbLGn9i0TkURXzbCAsQj+2gWW
         ovr5zSkqvnPBmsNlOnvb7Ki11NJLoe4bXPCIv3p19y+iByLMUmBt/tV62UbeYq8mdPKR
         leAn14e1k8+eLDtddtFYutYrAjggFM16aHztt1xQsrdZzhiiEoNBLPIl1bFFVsONGiQN
         +wEJxCgQh1DeJrZJUp0q1jItCC+NkCCkoRyjEM2ug4LzQ6j/JfLPB7jkLfUfwtccVdyn
         NX+w==
X-Gm-Message-State: AO0yUKVmvHlw3IGA8bnDnEs/Le9B3/07jpqcpcbL50PvzLf984atNGec
        G9w3JhWtWi05jNzzRMXG8W8=
X-Google-Smtp-Source: AK7set+KZrdn2sRUTofSvbCxwPBvOilh1CxxgiIcSiBOYluQOBjYX9mHC3sPNnlrfbHy0df9RZo8pQ==
X-Received: by 2002:a05:6830:708:b0:68b:d889:8b78 with SMTP id y8-20020a056830070800b0068bd8898b78mr5584336ots.32.1675438010991;
        Fri, 03 Feb 2023 07:26:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g37-20020a05683030a500b00684e4d974e6sm1215945ots.24.2023.02.03.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:26:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Feb 2023 07:26:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Aquastream Ultimate
Message-ID: <20230203152648.GA2506913@roeck-us.net>
References: <20230203120324.579808-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203120324.579808-1-savicaleksa83@gmail.com>
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

On Fri, Feb 03, 2023 at 01:03:24PM +0100, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose various hardware sensors of the
> Aquacomputer Aquastream Ultimate watercooling pump, which communicates
> through a proprietary USB HID protocol.
> 
> Coolant temp and external temp sensor readings are available, along with
> speed, power, voltage and current of both the pump and optionally connected
> fan. It also exposes pressure and flow speed readings.
> 
> Additionally, serial number and firmware version are exposed through
> debugfs.
> 
> Tested by a user on Github [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/50
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |   5 +
>  drivers/hwmon/aquacomputer_d5next.c         | 126 +++++++++++++++++++-
>  2 files changed, 125 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 527bcd3edda9..7d0d015b1a52 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -12,6 +12,7 @@ Supported devices:
>  * Aquacomputer Octo fan controller
>  * Aquacomputer Quadro fan controller
>  * Aquacomputer High Flow Next sensor
> +* Aquacomputer Aquastream Ultimate watercooling pump
>  * Aquacomputer Poweradjust 3 fan controller
>  
>  Author: Aleksa Savic
> @@ -54,6 +55,10 @@ The High Flow Next exposes +5V voltages, water quality, conductivity and flow re
>  A temperature sensor can be connected to it, in which case it provides its reading
>  and an estimation of the dissipated/absorbed power in the liquid cooling loop.
>  
> +The Aquastream Ultimate pump exposes coolant temp and an external temp sensor, along
> +with speed, power, voltage and current of both the pump and optionally connected fan.
> +It also exposes pressure and flow speed readings.
> +
>  The Poweradjust 3 controller exposes a single external temperature sensor.
>  
>  Depending on the device, not all sysfs and debugfs entries will be available.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 2945b630b4a0..12682a610ce7 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
> - * Quadro, High Flow Next, Aquaero)
> + * Quadro, High Flow Next, Aquaero, Aquastream Ultimate)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values, except for devices that communicate through the
> @@ -29,9 +29,13 @@
>  #define USB_PRODUCT_ID_FARBWERK360	0xf010
>  #define USB_PRODUCT_ID_OCTO		0xf011
>  #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
> +#define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
>  #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
>  
> -enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext, aquaero, poweradjust3 };
> +enum kinds {
> +	d5next, farbwerk, farbwerk360, octo, quadro,
> +	highflownext, aquaero, poweradjust3, aquastreamult
> +};
>  
>  static const char *const aqc_device_names[] = {
>  	[d5next] = "d5next",
> @@ -41,6 +45,7 @@ static const char *const aqc_device_names[] = {
>  	[quadro] = "quadro",
>  	[highflownext] = "highflownext",
>  	[aquaero] = "aquaero",
> +	[aquastreamult] = "aquastreamultimate",
>  	[poweradjust3] = "poweradjust3"
>  };
>  
> @@ -117,6 +122,26 @@ static u16 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET
>  #define D5NEXT_TEMP_CTRL_OFFSET		0x2D	/* Temperature sensor offsets location */
>  static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };	/* Pump and fan speed (from 0-100%) */
>  
> +/* Specs of the Aquastream Ultimate pump */
> +/* Pump does not follow the standard structure, so only consider the fan */
> +#define AQUASTREAMULT_NUM_FANS		1
> +#define AQUASTREAMULT_NUM_SENSORS	2
> +
> +/* Sensor report offsets for the Aquastream Ultimate pump */
> +#define AQUASTREAMULT_SENSOR_START		0x2D
> +#define AQUASTREAMULT_PUMP_OFFSET		0x51
> +#define AQUASTREAMULT_PUMP_VOLTAGE		0x3D
> +#define AQUASTREAMULT_PUMP_CURRENT		0x53
> +#define AQUASTREAMULT_PUMP_POWER		0x55
> +#define AQUASTREAMULT_FAN_OFFSET		0x41
> +#define AQUASTREAMULT_PRESSURE_OFFSET		0x57
> +#define AQUASTREAMULT_FLOW_SENSOR_OFFSET	0x37
> +#define AQUASTREAMULT_FAN_VOLTAGE_OFFSET	0x02
> +#define AQUASTREAMULT_FAN_CURRENT_OFFSET	0x00
> +#define AQUASTREAMULT_FAN_POWER_OFFSET		0x04
> +#define AQUASTREAMULT_FAN_SPEED_OFFSET		0x06
> +static u16 aquastreamult_sensor_fan_offsets[] = { AQUASTREAMULT_FAN_OFFSET };
> +
>  /* Spec and sensor report offset for the Farbwerk RGB controller */
>  #define FARBWERK_NUM_SENSORS		4
>  #define FARBWERK_SENSOR_START		0x2f
> @@ -339,6 +364,34 @@ static const char *const label_highflownext_voltage[] = {
>  	"+5V USB voltage"
>  };
>  
> +/* Labels for Aquastream Ultimate */
> +static const char *const label_aquastreamult_temp[] = {
> +	"Coolant temp",
> +	"External temp"
> +};
> +
> +static const char *const label_aquastreamult_speeds[] = {
> +	"Fan speed",
> +	"Pump speed",
> +	"Pressure [mbar]",
> +	"Flow speed [dL/h]"
> +};
> +
> +static const char *const label_aquastreamult_power[] = {
> +	"Fan power",
> +	"Pump power"
> +};
> +
> +static const char *const label_aquastreamult_voltages[] = {
> +	"Fan voltage",
> +	"Pump voltage"
> +};
> +
> +static const char *const label_aquastreamult_current[] = {
> +	"Fan current",
> +	"Pump current"
> +};
> +
>  /* Labels for Poweradjust 3 */
>  static const char *const label_poweradjust3_temp_sensors[] = {
>  	"External sensor"
> @@ -359,7 +412,15 @@ static struct aqc_fan_structure_offsets aqc_aquaero_fan_structure = {
>  	.speed = AQUAERO_FAN_SPEED_OFFSET
>  };
>  
> -/* Fan structure offsets for all devices except Aquaero */
> +/* Fan structure offsets for Aquastream Ultimate */
> +static struct aqc_fan_structure_offsets aqc_aquastreamult_fan_structure = {
> +	.voltage = AQUASTREAMULT_FAN_VOLTAGE_OFFSET,
> +	.curr = AQUASTREAMULT_FAN_CURRENT_OFFSET,
> +	.power = AQUASTREAMULT_FAN_POWER_OFFSET,
> +	.speed = AQUASTREAMULT_FAN_SPEED_OFFSET
> +};
> +
> +/* Fan structure offsets for all devices except those above */
>  static struct aqc_fan_structure_offsets aqc_general_fan_structure = {
>  	.voltage = AQC_FAN_VOLTAGE_OFFSET,
>  	.curr = AQC_FAN_CURRENT_OFFSET,
> @@ -565,6 +626,14 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  		case hwmon_fan_input:
>  		case hwmon_fan_label:
>  			switch (priv->kind) {
> +			case aquastreamult:
> +				/*
> +				 * Special case to support pump RPM, fan RPM,
> +				 * pressure and flow sensor
> +				 */
> +				if (channel < 4)
> +					return 0444;
> +				break;
>  			case highflownext:
>  				/* Special case to support flow sensor, water quality
>  				 * and conductivity
> @@ -595,6 +664,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  		break;
>  	case hwmon_power:
>  		switch (priv->kind) {
> +		case aquastreamult:
> +			/* Special case to support pump and fan power */
> +			if (channel < 2)
> +				return 0444;
> +			break;
>  		case highflownext:
>  			/* Special case to support one power sensor */
>  			if (channel == 0)
> @@ -607,8 +681,17 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  		}
>  		break;
>  	case hwmon_curr:
> -		if (channel < priv->num_fans)
> -			return 0444;
> +		switch (priv->kind) {
> +		case aquastreamult:
> +			/* Special case to support pump and fan current */
> +			if (channel < 2)
> +				return 0444;
> +			break;
> +		default:
> +			if (channel < priv->num_fans)
> +				return 0444;
> +			break;
> +		}
>  		break;
>  	case hwmon_in:
>  		switch (priv->kind) {
> @@ -617,6 +700,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  			if (channel < priv->num_fans + 2)
>  				return 0444;
>  			break;
> +		case aquastreamult:
>  		case highflownext:
>  			/* Special case to support two voltage sensors */
>  			if (channel < 2)
> @@ -1001,6 +1085,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  			i++;
>  		}
>  		break;
> +	case aquastreamult:
> +		priv->speed_input[1] = get_unaligned_be16(data + AQUASTREAMULT_PUMP_OFFSET);
> +		priv->speed_input[2] = get_unaligned_be16(data + AQUASTREAMULT_PRESSURE_OFFSET);
> +		priv->speed_input[3] = get_unaligned_be16(data + AQUASTREAMULT_FLOW_SENSOR_OFFSET);
> +
> +		priv->power_input[1] = get_unaligned_be16(data + AQUASTREAMULT_PUMP_POWER) * 10000;
> +
> +		priv->voltage_input[1] = get_unaligned_be16(data + AQUASTREAMULT_PUMP_VOLTAGE) * 10;
> +
> +		priv->current_input[1] = get_unaligned_be16(data + AQUASTREAMULT_PUMP_CURRENT);
> +		break;
>  	case d5next:
>  		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
>  		priv->voltage_input[3] = get_unaligned_be16(data + D5NEXT_12V_VOLTAGE) * 10;
> @@ -1273,6 +1368,21 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->power_label = label_highflownext_power;
>  		priv->voltage_label = label_highflownext_voltage;
>  		break;
> +	case USB_PRODUCT_ID_AQUASTREAMULT:
> +		priv->kind = aquastreamult;
> +
> +		priv->num_fans = AQUASTREAMULT_NUM_FANS;
> +		priv->fan_sensor_offsets = aquastreamult_sensor_fan_offsets;
> +
> +		priv->num_temp_sensors = AQUASTREAMULT_NUM_SENSORS;
> +		priv->temp_sensor_start_offset = AQUASTREAMULT_SENSOR_START;
> +
> +		priv->temp_label = label_aquastreamult_temp;
> +		priv->speed_label = label_aquastreamult_speeds;
> +		priv->power_label = label_aquastreamult_power;
> +		priv->voltage_label = label_aquastreamult_voltages;
> +		priv->current_label = label_aquastreamult_current;
> +		break;
>  	case USB_PRODUCT_ID_POWERADJUST3:
>  		priv->kind = poweradjust3;
>  
> @@ -1302,7 +1412,10 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->serial_number_start_offset = AQC_SERIAL_START;
>  		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
>  
> -		priv->fan_structure = &aqc_general_fan_structure;
> +		if (priv->kind == aquastreamult)
> +			priv->fan_structure = &aqc_aquastreamult_fan_structure;
> +		else
> +			priv->fan_structure = &aqc_general_fan_structure;
>  		break;
>  	}
>  
> @@ -1360,6 +1473,7 @@ static const struct hid_device_id aqc_table[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
>  	{ }
>  };
