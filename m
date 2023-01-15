Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1266B28A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjAOQXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAOQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:23:37 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFECDC9;
        Sun, 15 Jan 2023 08:23:36 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15ebfdf69adso9619868fac.0;
        Sun, 15 Jan 2023 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IephNpc498jOa4OrcgfeiAVDBEDuV4Dqx8JYWGrc2Oc=;
        b=OHHY37iRFp6y1hp/r0k/yObxu/jNd00x95D//TZNlwTD2VWGFJPWOjKMnHA7z8qi2F
         l0drYshYnSKCezor9zry+OzJmVqwUI3OiGV/vec/XRhIwXa5UwJj4uWDomc0QFDG90BA
         DqAusCEV902YDFAsST6dKH9MpKq5q3HR8he7swv1k+dZo073unPupF6/gRsS1m7AcIwG
         ZO84himXEG6fZg10we3lfVoBh63imc1g9ER1HNuY0myfHB0bg6XkZlw5VePCOb9KtX2y
         MCC6EjPqNVFcaZ631jjiwlVt50wV19/gsBDy9D4cHWvSrmu029YDGO0hPdAuf/RthKpj
         UGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IephNpc498jOa4OrcgfeiAVDBEDuV4Dqx8JYWGrc2Oc=;
        b=ukmZwRSkkl0jPVhnVFZAvx7OOpp6Si/mfeQHDyMrHBuEZmxQzBjAXKW6IM9ZDH6EZi
         uRpI4BD1wmZahUebUj8TAw/hWCR5r7nSXtQ2xHIw7uRUdF9sqKF0tW9tKTTtSuZVcFYO
         Hl0n6bn22GweXP/2WXIzS2USiKj5tsc0tAOWcmeBEHyI0KvwSH9CTs5pYzYCet+dwKZP
         HxLEi4pxC9bKIf8gm6C2GI0eGf9jlSRwBrKzxAKlYrFjahhs4gwWcVZ+keH3aFzskpBY
         kena03p6TIrX/Z1A6uQojkV/IeyXb23MMgBQ26Ht4J0BLYykpCD6uZ5qj5yqK/znYAZ0
         G/1w==
X-Gm-Message-State: AFqh2kp115a8kh12i5ybQhR/TBLVFJkdvL6zWx6tN+qjyT3NqvxpkLKz
        wd0rUPf2mjkgKDhyyWNZfh8=
X-Google-Smtp-Source: AMrXdXtEumOse3Aaql+Fxn7ysO2V4Ey6zjfSRC6fBX7a85ZzQ0ViQgNh9KV5T7S45om1EDgH2p7Trw==
X-Received: by 2002:a05:6870:562c:b0:15e:dce3:49a7 with SMTP id m44-20020a056870562c00b0015edce349a7mr6015349oao.8.1673799816167;
        Sun, 15 Jan 2023 08:23:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8-20020a056870d0c800b0015b64f8ff2bsm10716500oaa.52.2023.01.15.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:23:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:23:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: (ftsteutates) Replace fanX_source with
 pwmX_auto_channels_temp
Message-ID: <20230115162334.GA1247593@roeck-us.net>
References: <20230105225107.58308-1-W_Armin@gmx.de>
 <20230105225107.58308-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105225107.58308-3-W_Armin@gmx.de>
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

On Thu, Jan 05, 2023 at 11:51:06PM +0100, Armin Wolf wrote:
> Replace the nonstandard fanX_source attributes with the standardized
> pwmX_auto_channels_temp attributes and document the special behaviour
> associated with those attributes.
> 
> Tested on a Fujitsu DS3401-B1.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/ftsteutates.rst |  5 ++
>  drivers/hwmon/ftsteutates.c         | 77 +++++++++++------------------
>  2 files changed, 33 insertions(+), 49 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/hwmon/ftsteutates.rst b/Documentation/hwmon/ftsteutates.rst
> index 198fa8e2819d..b3bfec36661d 100644
> --- a/Documentation/hwmon/ftsteutates.rst
> +++ b/Documentation/hwmon/ftsteutates.rst
> @@ -22,6 +22,11 @@ enhancements. It can monitor up to 4 voltages, 16 temperatures and
>  8 fans. It also contains an integrated watchdog which is currently
>  implemented in this driver.
> 
> +The ``pwmX_auto_channels_temp`` attributes show which temperature sensor
> +is currently driving which fan channel. This value might dynamically change
> +during runtime depending on the temperature sensor selected by
> +the fan control circuit.
> +
>  The 4 voltages require a board-specific multiplier, since the BMC can
>  only measure voltages up to 3.3V and thus relies on voltage dividers.
>  Consult your motherboard manual for details.
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index 23dc3a74f84b..0d8ab94250a9 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -6,9 +6,7 @@
>   *		  Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>
>   */
>  #include <linux/err.h>
> -#include <linux/fs.h>
>  #include <linux/hwmon.h>
> -#include <linux/hwmon-sysfs.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/jiffies.h>
> @@ -16,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/watchdog.h>
> 
>  #define FTS_DEVICE_ID_REG		0x0000
> @@ -48,6 +45,8 @@
>  #define FTS_NO_TEMP_SENSORS		0x10
>  #define FTS_NO_VOLT_SENSORS		0x04
> 
> +#define FTS_FAN_SOURCE_INVALID		0xff
> +
>  static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
> 
>  static const struct i2c_device_id fts_id[] = {
> @@ -187,7 +186,7 @@ static int fts_update_device(struct fts_data *data)
>  			data->fan_source[i] = err;
>  		} else {
>  			data->fan_input[i] = 0;
> -			data->fan_source[i] = 0;
> +			data->fan_source[i] = FTS_FAN_SOURCE_INVALID;
>  		}
>  	}
> 
> @@ -339,50 +338,6 @@ static int fts_watchdog_init(struct fts_data *data)
>  	return devm_watchdog_register_device(&data->client->dev, &data->wdd);
>  }
> 
> -static ssize_t fan_source_show(struct device *dev,
> -			       struct device_attribute *devattr, char *buf)
> -{
> -	struct fts_data *data = dev_get_drvdata(dev);
> -	int index = to_sensor_dev_attr(devattr)->index;
> -	int err;
> -
> -	err = fts_update_device(data);
> -	if (err < 0)
> -		return err;
> -
> -	return sprintf(buf, "%u\n", data->fan_source[index]);
> -}
> -
> -static SENSOR_DEVICE_ATTR_RO(fan1_source, fan_source, 0);
> -static SENSOR_DEVICE_ATTR_RO(fan2_source, fan_source, 1);
> -static SENSOR_DEVICE_ATTR_RO(fan3_source, fan_source, 2);
> -static SENSOR_DEVICE_ATTR_RO(fan4_source, fan_source, 3);
> -static SENSOR_DEVICE_ATTR_RO(fan5_source, fan_source, 4);
> -static SENSOR_DEVICE_ATTR_RO(fan6_source, fan_source, 5);
> -static SENSOR_DEVICE_ATTR_RO(fan7_source, fan_source, 6);
> -static SENSOR_DEVICE_ATTR_RO(fan8_source, fan_source, 7);
> -
> -static struct attribute *fts_fan_attrs[] = {
> -	&sensor_dev_attr_fan1_source.dev_attr.attr,
> -	&sensor_dev_attr_fan2_source.dev_attr.attr,
> -	&sensor_dev_attr_fan3_source.dev_attr.attr,
> -	&sensor_dev_attr_fan4_source.dev_attr.attr,
> -	&sensor_dev_attr_fan5_source.dev_attr.attr,
> -	&sensor_dev_attr_fan6_source.dev_attr.attr,
> -	&sensor_dev_attr_fan7_source.dev_attr.attr,
> -	&sensor_dev_attr_fan8_source.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group fts_attr_group = {
> -	.attrs = fts_fan_attrs
> -};
> -
> -static const struct attribute_group *fts_attr_groups[] = {
> -	&fts_attr_group,
> -	NULL
> -};
> -
>  static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_types type, u32 attr,
>  			      int channel)
>  {
> @@ -408,6 +363,7 @@ static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_types type,
>  			break;
>  		}
>  		break;
> +	case hwmon_pwm:
>  	case hwmon_in:
>  		return 0444;
>  	default:
> @@ -460,6 +416,19 @@ static int fts_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  			break;
>  		}
>  		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_auto_channels_temp:
> +			if (data->fan_source[channel] == FTS_FAN_SOURCE_INVALID)
> +				*val = 0;
> +			else
> +				*val = BIT(data->fan_source[channel]);
> +
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
>  	case hwmon_in:
>  		switch (attr) {
>  		case hwmon_in_input:
> @@ -576,6 +545,16 @@ static const struct hwmon_channel_info *fts_info[] = {
>  			   HWMON_F_INPUT | HWMON_F_ALARM,
>  			   HWMON_F_INPUT | HWMON_F_ALARM
>  			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
> +			   ),
>  	HWMON_CHANNEL_INFO(in,
>  			   HWMON_I_INPUT,
>  			   HWMON_I_INPUT,
> @@ -672,7 +651,7 @@ static int fts_probe(struct i2c_client *client)
>  	revision = err;
> 
>  	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, "ftsteutates", data,
> -							 &fts_chip_info, fts_attr_groups);
> +							 &fts_chip_info, NULL);
>  	if (IS_ERR(hwmon_dev))
>  		return PTR_ERR(hwmon_dev);
