Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6EF658DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiL2OUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiL2OUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:20:43 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E482E4;
        Thu, 29 Dec 2022 06:20:41 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1447c7aa004so21777964fac.11;
        Thu, 29 Dec 2022 06:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfp9xmNEKzb4aVH9wsr2XIFLpCxBiR0hxpVBZPWMiEU=;
        b=Gbnhw4Rf+85bidUPzxxynfNMqNqVV+6Ku5QmOu9g6NBkEQ/3+kK3HI5iq3tDWIjGYz
         WkJ0MF1uFwaDrRdNahu7zfWOXd8eYbRRj2pHX6QJgpZmdqISriXX657X1/36fgmQWryX
         JED/8osqHrTGh8JTbdMTqrLy2CQGF2hFFe2rI8U1YOvdVDbs6HMTZWpjeSvGmk2Q7Bn/
         xfGyJWAffBUB0qSbqAeobhzBZnOtFBm+ZcoXnTBICZtB+IcE6+IxUCHqLaBNQxLDpsgz
         4YTXOqvzKyT+s2dExx/l31wsVKeh6qzz2iTsRoAPpz72lMunOAqyIZkaWq4Jm1G8VOic
         POgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfp9xmNEKzb4aVH9wsr2XIFLpCxBiR0hxpVBZPWMiEU=;
        b=xi0kn2x5AwIgvZXtpacW4MlA9N7Tf03TlClrqz7Ahzf4f09UWTR30ElZxAQ3NsMSFu
         NW2u0+mj+kVj2SpYxDcbJbe7ObSElxpO8wxHksxbEb9tyU2010CaANpfW52xmzsUtJJ4
         xGHQrCKS5aj8XzyFZ6aD7AkJ/RC18cks1/2GLCA9AidrQOW9D+A5kk+dwvjFkwx8yPQ6
         MWA+hhoazLqr8fTwKLRH52VVaznkuOCMrmLq91agLB0n2x98syeqDse6CKc55fCcZZ+B
         LiStclDLBaUVUJvAolfk6vBqCsUi/dPlrH6Iab4s8rs+22hoC0jNdzvBqP5CKm+Cc3cy
         0xvw==
X-Gm-Message-State: AFqh2kpnZJ5nxtrJHFDfRfYCWC9J82l+blo07ei4fyie/qqL3IyLoCJ4
        N5Y/q82VLx/EAE8SYc9ew9cnHP8imyQ=
X-Google-Smtp-Source: AMrXdXv40Ayt3dD71viSQHzMxVv9WfUtJm1968N+UTty5Y7P2rJJYtLk83tNrfnrOXr55dZ79xUxgA==
X-Received: by 2002:a05:6870:3854:b0:14f:ffa7:86d2 with SMTP id z20-20020a056870385400b0014fffa786d2mr6272909oal.15.1672323640510;
        Thu, 29 Dec 2022 06:20:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z12-20020a056870738c00b00143065d3e99sm8754501oam.5.2022.12.29.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:20:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:20:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] hwmon: (aquacomputer_d5next) Support sensors for
 Aquacomputer Aquaero
Message-ID: <20221229142038.GA19825@roeck-us.net>
References: <20221218113131.3752-1-leonard.anderweit@gmail.com>
 <20221218113131.3752-7-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218113131.3752-7-leonard.anderweit@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 12:31:31PM +0100, Leonard Anderweit wrote:
> Add support for reading sensors of the Aquacomputer Aquaero 5/6 fan
> controllers. These fan controllers supports 4 fans, 8 physical
> temperature sensors, 8 virtual temperature sensors and 2 flow sensors.
> Temperature and flow sensor reading implemented by Aleksa Savic [1] [2]
> [3].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/31
> [2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/51
> [3] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/55
> 
> Originally-from: Aleksa Savic <savicaleksa83@gmail.com>
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

Series applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |   5 +
>  drivers/hwmon/aquacomputer_d5next.c         | 108 ++++++++++++++++++--
>  2 files changed, 104 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 637bdbc8fcad..b94ff08080bf 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -5,6 +5,7 @@ Kernel driver aquacomputer-d5next
>  
>  Supported devices:
>  
> +* Aquacomputer Aquaero 5/6 fan controllers
>  * Aquacomputer D5 Next watercooling pump
>  * Aquacomputer Farbwerk RGB controller
>  * Aquacomputer Farbwerk 360 RGB controller
> @@ -20,6 +21,10 @@ Description
>  This driver exposes hardware sensors of listed Aquacomputer devices, which
>  communicate through proprietary USB HID protocols.
>  
> +The Aquaero devices expose eight temperature sensors, eight virtual temperature
> +sensors and two flow senors. The fans expose their speed (in RPM), power,
> +voltage and current.
> +
>  For the D5 Next pump, available sensors are pump and fan speed, power, voltage
>  and current, as well as coolant temperature and eight virtual temp sensors. Also
>  available through debugfs are the serial number, firmware version and power-on
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index d28d7079917a..0fd00cfb86c8 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
> - * Quadro, High Flow Next)
> + * Quadro, High Flow Next, Aquaero)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values.
> @@ -21,6 +21,7 @@
>  #include <asm/unaligned.h>
>  
>  #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
> +#define USB_PRODUCT_ID_AQUAERO		0xf001
>  #define USB_PRODUCT_ID_FARBWERK		0xf00a
>  #define USB_PRODUCT_ID_QUADRO		0xf00d
>  #define USB_PRODUCT_ID_D5NEXT		0xf00e
> @@ -28,7 +29,7 @@
>  #define USB_PRODUCT_ID_OCTO		0xf011
>  #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
>  
> -enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext };
> +enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext, aquaero };
>  
>  static const char *const aqc_device_names[] = {
>  	[d5next] = "d5next",
> @@ -36,7 +37,8 @@ static const char *const aqc_device_names[] = {
>  	[farbwerk360] = "farbwerk360",
>  	[octo] = "octo",
>  	[quadro] = "quadro",
> -	[highflownext] = "highflownext"
> +	[highflownext] = "highflownext",
> +	[aquaero] = "aquaero"
>  };
>  
>  #define DRIVER_NAME			"aquacomputer_d5next"
> @@ -57,7 +59,7 @@ static u8 secondary_ctrl_report[] = {
>  	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
>  };
>  
> -/* Info, sensor sizes and offsets for all Aquacomputer devices */
> +/* Info, sensor sizes and offsets for most Aquacomputer devices */
>  #define AQC_SERIAL_START		0x3
>  #define AQC_FIRMWARE_VERSION		0xD
>  
> @@ -69,6 +71,24 @@ static u8 secondary_ctrl_report[] = {
>  #define AQC_FAN_POWER_OFFSET		0x06
>  #define AQC_FAN_SPEED_OFFSET		0x08
>  
> +/* Specs of the Aquaero fan controllers */
> +#define AQUAERO_SERIAL_START			0x07
> +#define AQUAERO_FIRMWARE_VERSION		0x0B
> +#define AQUAERO_NUM_FANS			4
> +#define AQUAERO_NUM_SENSORS			8
> +#define AQUAERO_NUM_VIRTUAL_SENSORS		8
> +#define AQUAERO_NUM_FLOW_SENSORS		2
> +
> +/* Sensor report offsets for Aquaero fan controllers */
> +#define AQUAERO_SENSOR_START			0x65
> +#define AQUAERO_VIRTUAL_SENSOR_START		0x85
> +#define AQUAERO_FLOW_SENSORS_START		0xF9
> +#define AQUAERO_FAN_VOLTAGE_OFFSET		0x04
> +#define AQUAERO_FAN_CURRENT_OFFSET		0x06
> +#define AQUAERO_FAN_POWER_OFFSET		0x08
> +#define AQUAERO_FAN_SPEED_OFFSET		0x00
> +static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
> +
>  /* Specs of the D5 Next pump */
>  #define D5NEXT_NUM_FANS			2
>  #define D5NEXT_NUM_SENSORS		1
> @@ -181,12 +201,16 @@ static const char *const label_d5next_current[] = {
>  	"Fan current"
>  };
>  
> -/* Labels for Farbwerk, Farbwerk 360 and Octo and Quadro temperature sensors */
> +/* Labels for Aquaero, Farbwerk, Farbwerk 360 and Octo and Quadro temperature sensors */
>  static const char *const label_temp_sensors[] = {
>  	"Sensor 1",
>  	"Sensor 2",
>  	"Sensor 3",
> -	"Sensor 4"
> +	"Sensor 4",
> +	"Sensor 5",
> +	"Sensor 6",
> +	"Sensor 7",
> +	"Sensor 8"
>  };
>  
>  static const char *const label_virtual_temp_sensors[] = {
> @@ -262,6 +286,16 @@ static const char *const label_quadro_speeds[] = {
>  	"Flow speed [dL/h]"
>  };
>  
> +/* Labels for Aquaero fan speeds */
> +static const char *const label_aquaero_speeds[] = {
> +	"Fan 1 speed",
> +	"Fan 2 speed",
> +	"Fan 3 speed",
> +	"Fan 4 speed",
> +	"Flow sensor 1 [dL/h]",
> +	"Flow sensor 2 [dL/h]"
> +};
> +
>  /* Labels for High Flow Next */
>  static const char *const label_highflownext_temp_sensors[] = {
>  	"Coolant temp",
> @@ -290,6 +324,14 @@ struct aqc_fan_structure_offsets {
>  	u8 speed;
>  };
>  
> +/* Fan structure offsets for Aquaero */
> +static struct aqc_fan_structure_offsets aqc_aquaero_fan_structure = {
> +	.voltage = AQUAERO_FAN_VOLTAGE_OFFSET,
> +	.curr = AQUAERO_FAN_CURRENT_OFFSET,
> +	.power = AQUAERO_FAN_POWER_OFFSET,
> +	.speed = AQUAERO_FAN_SPEED_OFFSET
> +};
> +
>  /* Fan structure offsets for all devices except Aquaero */
>  static struct aqc_fan_structure_offsets aqc_general_fan_structure = {
>  	.voltage = AQC_FAN_VOLTAGE_OFFSET,
> @@ -496,6 +538,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  				if (channel < 3)
>  					return 0444;
>  				break;
> +			case aquaero:
>  			case quadro:
>  				/* Special case to support flow sensors */
>  				if (channel < priv->num_fans + priv->num_flow_sensors)
> @@ -977,6 +1020,42 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		goto fail_and_stop;
>  
>  	switch (hdev->product) {
> +	case USB_PRODUCT_ID_AQUAERO:
> +		/*
> +		 * Aquaero presents itself as three HID devices under the same product ID:
> +		 * "aquaero keyboard/mouse", "aquaero System Control" and "aquaero Device",
> +		 * which is the one we want to communicate with. Unlike most other Aquacomputer
> +		 * devices, Aquaero does not return meaningful data when explicitly requested
> +		 * using GET_FEATURE_REPORT.
> +		 *
> +		 * The difference between "aquaero Device" and the other two is in the collections
> +		 * they present. The two other devices have the type of the second element in
> +		 * their respective collections set to 1, while the real device has it set to 0.
> +		 */
> +		if (hdev->collection[1].type != 0) {
> +			ret = -ENODEV;
> +			goto fail_and_close;
> +		}
> +
> +		priv->kind = aquaero;
> +
> +		priv->num_fans = AQUAERO_NUM_FANS;
> +		priv->fan_sensor_offsets = aquaero_sensor_fan_offsets;
> +
> +		priv->num_temp_sensors = AQUAERO_NUM_SENSORS;
> +		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
> +		priv->num_virtual_temp_sensors = AQUAERO_NUM_VIRTUAL_SENSORS;
> +		priv->virtual_temp_sensor_start_offset = AQUAERO_VIRTUAL_SENSOR_START;
> +		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
> +		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
> +
> +		priv->temp_label = label_temp_sensors;
> +		priv->virtual_temp_label = label_virtual_temp_sensors;
> +		priv->speed_label = label_aquaero_speeds;
> +		priv->power_label = label_fan_power;
> +		priv->voltage_label = label_fan_voltage;
> +		priv->current_label = label_fan_current;
> +		break;
>  	case USB_PRODUCT_ID_D5NEXT:
>  		priv->kind = d5next;
>  
> @@ -1100,10 +1179,20 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		break;
>  	}
>  
> -	priv->serial_number_start_offset = AQC_SERIAL_START;
> -	priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
> +	switch (priv->kind) {
> +	case aquaero:
> +		priv->serial_number_start_offset = AQUAERO_SERIAL_START;
> +		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
> +
> +		priv->fan_structure = &aqc_aquaero_fan_structure;
> +		break;
> +	default:
> +		priv->serial_number_start_offset = AQC_SERIAL_START;
> +		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
>  
> -	priv->fan_structure = &aqc_general_fan_structure;
> +		priv->fan_structure = &aqc_general_fan_structure;
> +		break;
> +	}
>  
>  	if (priv->buffer_size != 0) {
>  		priv->checksum_start = 0x01;
> @@ -1152,6 +1241,7 @@ static void aqc_remove(struct hid_device *hdev)
>  }
>  
>  static const struct hid_device_id aqc_table[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUAERO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
