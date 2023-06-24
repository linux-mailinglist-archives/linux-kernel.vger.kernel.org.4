Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A973CBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjFXQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:50:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C771993;
        Sat, 24 Jun 2023 09:50:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666edfc50deso1191126b3a.0;
        Sat, 24 Jun 2023 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687625428; x=1690217428;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnng0hG2XTpldv6eBSFkHUCLWtF8fd62l9O3XfWUV74=;
        b=XjItiu3eMlqiVW7EBV2no2irYw6k7SrYOfsBIapnf5wOEceeI+8IqNYgL30cyrjEAl
         5SDsjOoWgIu6HFrMoMQZ5pjSka9chz977sEVIt+PN/luwWST0TVq8Z9BcMGAKnN9blPn
         sv4oJVga+iF/qnYTsGsRAO6nTemY3lUmzwWPxqqOKu0/CO0HTG+zIlygTDLld8ywaCse
         jMCOQr62EKggBMKeVDusC6QIaEBuxTTHtmcbuVuyvz86M9qTiv0hBS6qGTTHjBdgZwpC
         9gbW2zazYXGCrsVOZxCBUoKlRm1hrjYtwfUnErt10XLR0vIhhBsDAY4M8vuy3kDjGaR2
         9qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687625428; x=1690217428;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnng0hG2XTpldv6eBSFkHUCLWtF8fd62l9O3XfWUV74=;
        b=hy5NCJ16/QpRrI3uqE2BWg5Yxh8XPY5kiKy4AhZpNcgmO9jQwbBSCB5nHnhD7HNV4X
         7MZn5aAN59P6ZLWdMAIIccxWP9sD3lSsBl2O4QcubYGwKESELiStuSJvK8Xq5q/QpocF
         Nh0ST/uRvf1YyY7xIJuIrStPmJ79lSnUvLN8vUPD6pxz0Z3Yo+L9B48hxTfZyn/Ns5Qz
         9PojQGsJviJN+5dMkD+JDfpCseviJqQvQk5578sbVzK7yCKFbp0QapR4IHGi7o8YNeaR
         qsLTFCiUVMagntjt02W07O4xNqBeAZoCNMXVTMiCpmSrG0Ghh19vmjJOGwzsMtGyYwEN
         4GHQ==
X-Gm-Message-State: AC+VfDyn0uOyI2SLqwA2pfKDbmmvLZraszmZtCjL9aqaZrQ8UVNsbLNi
        douuDSfWDIiq3xr59Ot8r8U=
X-Google-Smtp-Source: ACHHUZ4V8Ki7nUdQ0CxrlVd2Zl/fvYuzyBr783GczYCHp+i15fbIyQeH0BewDmZiWRQAMzGJX93p1g==
X-Received: by 2002:a05:6a20:a122:b0:103:7b36:f21 with SMTP id q34-20020a056a20a12200b001037b360f21mr40135172pzk.21.1687625428151;
        Sat, 24 Jun 2023 09:50:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11-20020a63ec0b000000b00502f4c62fd3sm1482694pgh.33.2023.06.24.09.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 09:50:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <53324e25-c71f-b485-505b-fff3213fc599@roeck-us.net>
Date:   Sat, 24 Jun 2023 09:50:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     JuenKit_Yip@hotmail.com, jdelvare@suse.com,
        krzysztof.kozlowki+dt@linaro.org, conor+dt@kernel.org,
        broonie@kernel.org, vincent@vtremblay.dev, michal.simek@amd.com,
        geert+renesas@glider.be
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DB4PR10MB6261BA825CB417ACA76772529220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (sht3x) convert some of sysfs interface to
 hwmon
In-Reply-To: <DB4PR10MB6261BA825CB417ACA76772529220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 09:01, JuenKit_Yip@hotmail.com wrote:
> From: JuenKit Yip <JuenKit_Yip@hotmail.com>
> 
> update_interval, temperature/humidity max/min and hyst
> were moved to new hwmon interface, and only heater and
> repeatability were reserved as non-stardard sysfs interface.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Please version your patches and provide change logs.

> ---
>   drivers/hwmon/sht3x.c | 359 ++++++++++++++++++++++++++++--------------
>   1 file changed, 244 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index bf18630619e0..9b2dadd11eeb 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -147,6 +147,19 @@ static const u16 mode_to_update_interval[] = {
>   	 100,
>   };
>   
> +static const struct hwmon_channel_info * const sht3x_channel_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MIN |
> +				HWMON_T_MIN_HYST | HWMON_T_MAX |
> +				HWMON_T_MAX_HYST | HWMON_T_ALARM),
> +	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT | HWMON_H_MIN |
> +				HWMON_H_MIN_HYST | HWMON_H_MAX |
> +				HWMON_H_MAX_HYST | HWMON_H_ALARM),
> +	NULL,
> +};
> +
> +static const struct i2c_device_id sht3x_ids[];
> +

Again, please avoid forward declarations. More on that below.

>   struct sht3x_data {
>   	struct i2c_client *client;
>   	struct mutex i2c_lock; /* lock for sending i2c commands */
> @@ -276,27 +289,24 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
>   	return data;
>   }
>   
> -/* sysfs attributes */
> -static ssize_t temp1_input_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> +static int temp1_input_read(struct device *dev)
>   {
>   	struct sht3x_data *data = sht3x_update_client(dev);
>   
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
> -	return sprintf(buf, "%d\n", data->temperature);
> +	return data->temperature;
>   }
>   
> -static ssize_t humidity1_input_show(struct device *dev,
> -				    struct device_attribute *attr, char *buf)
> +static int humidity1_input_read(struct device *dev)
>   {
>   	struct sht3x_data *data = sht3x_update_client(dev);
>   
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>   
> -	return sprintf(buf, "%u\n", data->humidity);
> +	return data->humidity;
>   }
>   
>   /*
> @@ -332,33 +342,24 @@ static int limits_update(struct sht3x_data *data)
>   	return ret;
>   }
>   
> -static ssize_t temp1_limit_show(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static int temp1_limit_read(struct device *dev, int index)
>   {
>   	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
> -	int temperature_limit = data->temperature_limits[index];
>   
> -	return sysfs_emit(buf, "%d\n", temperature_limit);
> +	return data->temperature_limits[index];
>   }
>   
> -static ssize_t humidity1_limit_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> +static int humidity1_limit_read(struct device *dev, int index)
>   {
>   	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
> -	u32 humidity_limit = data->humidity_limits[index];
>   
> -	return sysfs_emit(buf, "%u\n", humidity_limit);
> +	return data->humidity_limits[index];
>   }
>   
>   /*
> - * limit_store must only be called with data_lock held
> + * limit_write must only be called with data_lock held
>    */
> -static size_t limit_store(struct device *dev,
> -			  size_t count,
> +static size_t limit_write(struct device *dev,
>   			  u8 index,
>   			  int temperature,
>   			  u32 humidity)
> @@ -379,7 +380,7 @@ static size_t limit_store(struct device *dev,
>   	 * ST = (T + 45) / 175 * 2^16
>   	 * SRH = RH / 100 * 2^16
>   	 * adapted for fixed point arithmetic and packed the same as
> -	 * in limit_show()
> +	 * in limit_read()
>   	 */
>   	raw = ((u32)(temperature + 45000) * 24543) >> (16 + 7);
>   	raw |= ((humidity * 42950) >> 16) & 0xfe00;
> @@ -400,50 +401,43 @@ static size_t limit_store(struct device *dev,
>   
>   	data->temperature_limits[index] = temperature;
>   	data->humidity_limits[index] = humidity;
> -	return count;
> +
> +	return 0;
>   }
>   
> -static ssize_t temp1_limit_store(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf,
> -				 size_t count)
> +static int temp1_limit_write(struct device *dev, int index, const char *val)
>   {
>   	int temperature;
>   	int ret;
>   	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
>   
> -	ret = kstrtoint(buf, 0, &temperature);
> +	ret = kstrtoint(val, 0, &temperature);
>   	if (ret)
>   		return ret;
>   
>   	temperature = clamp_val(temperature, SHT3X_MIN_TEMPERATURE,
>   				SHT3X_MAX_TEMPERATURE);
>   	mutex_lock(&data->data_lock);
> -	ret = limit_store(dev, count, index, temperature,
> +	ret = limit_write(dev, index, temperature,
>   			  data->humidity_limits[index]);
>   	mutex_unlock(&data->data_lock);
>   
>   	return ret;
>   }
>   
> -static ssize_t humidity1_limit_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t count)
> +static int humidity1_limit_write(struct device *dev, int index, const char *val)
>   {
>   	u32 humidity;
>   	int ret;
>   	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
>   
> -	ret = kstrtou32(buf, 0, &humidity);
> +	ret = kstrtou32(val, 0, &humidity);
>   	if (ret)
>   		return ret;
>   
>   	humidity = clamp_val(humidity, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
>   	mutex_lock(&data->data_lock);
> -	ret = limit_store(dev, count, index, data->temperature_limits[index],
> +	ret = limit_write(dev, index, data->temperature_limits[index],
>   			  humidity);
>   	mutex_unlock(&data->data_lock);
>   
> @@ -474,7 +468,6 @@ static void sht3x_select_command(struct sht3x_data *data)
>   }
>   
>   static int status_register_read(struct device *dev,
> -				struct device_attribute *attr,
>   				char *buffer, int length)
>   {
>   	int ret;
> @@ -487,34 +480,30 @@ static int status_register_read(struct device *dev,
>   	return ret;
>   }
>   
> -static ssize_t temp1_alarm_show(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static int temp1_alarm_read(struct device *dev)
>   {
>   	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>   	int ret;
>   
> -	ret = status_register_read(dev, attr, buffer,
> +	ret = status_register_read(dev, buffer,
>   				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>   	if (ret)
>   		return ret;
>   
> -	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
> +	return !!(buffer[0] & 0x04);
>   }
>   
> -static ssize_t humidity1_alarm_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> +static int humidity1_alarm_read(struct device *dev)
>   {
>   	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>   	int ret;
>   
> -	ret = status_register_read(dev, attr, buffer,
> +	ret = status_register_read(dev, buffer,
>   				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>   	if (ret)
>   		return ret;
>   
> -	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
> +	return !!(buffer[0] & 0x08);
>   }
>   
>   static ssize_t heater_enable_show(struct device *dev,
> @@ -524,7 +513,7 @@ static ssize_t heater_enable_show(struct device *dev,
>   	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>   	int ret;
>   
> -	ret = status_register_read(dev, attr, buffer,
> +	ret = status_register_read(dev, buffer,
>   				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>   	if (ret)
>   		return ret;
> @@ -560,20 +549,14 @@ static ssize_t heater_enable_store(struct device *dev,
>   	return ret;
>   }
>   
> -static ssize_t update_interval_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> +static int update_interval_read(struct device *dev)
>   {
>   	struct sht3x_data *data = dev_get_drvdata(dev);
>   
> -	return sysfs_emit(buf, "%u\n",
> -			 mode_to_update_interval[data->mode]);
> +	return mode_to_update_interval[data->mode];
>   }
>   
> -static ssize_t update_interval_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t count)
> +static int update_interval_write(struct device *dev, const char *val)
>   {
>   	u16 update_interval;
>   	u8 mode;
> @@ -582,7 +565,7 @@ static ssize_t update_interval_store(struct device *dev,
>   	struct sht3x_data *data = dev_get_drvdata(dev);
>   	struct i2c_client *client = data->client;
>   
> -	ret = kstrtou16(buf, 0, &update_interval);
> +	ret = kstrtou16(val, 0, &update_interval);
>   	if (ret)
>   		return ret;
>   
> @@ -592,7 +575,7 @@ static ssize_t update_interval_store(struct device *dev,
>   	/* mode did not change */
>   	if (mode == data->mode) {
>   		mutex_unlock(&data->data_lock);
> -		return count;
> +		return 0;
>   	}
>   
>   	mutex_lock(&data->i2c_lock);
> @@ -634,7 +617,7 @@ static ssize_t update_interval_store(struct device *dev,
>   	if (ret != SHT3X_CMD_LENGTH)
>   		return ret < 0 ? ret : -EIO;
>   
> -	return count;
> +	return 0;
>   }
>   
>   static ssize_t repeatability_show(struct device *dev,
> @@ -668,60 +651,211 @@ static ssize_t repeatability_store(struct device *dev,
>   	return count;
>   }
>   
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
> -static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_max, humidity1_limit, limit_max);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp1_limit, limit_max_hyst);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_max_hyst, humidity1_limit,
> -			     limit_max_hyst);
> -static SENSOR_DEVICE_ATTR_RW(temp1_min, temp1_limit, limit_min);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_min, humidity1_limit, limit_min);
> -static SENSOR_DEVICE_ATTR_RW(temp1_min_hyst, temp1_limit, limit_min_hyst);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_min_hyst, humidity1_limit,
> -			     limit_min_hyst);
> -static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
> -static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
>   static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
> -static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
>   static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
>   
>   static struct attribute *sht3x_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_max.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_min.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
>   	&sensor_dev_attr_heater_enable.dev_attr.attr,
> -	&sensor_dev_attr_update_interval.dev_attr.attr,
> -	&sensor_dev_attr_repeatability.dev_attr.attr,
> -	NULL
> -};
> -
> -static struct attribute *sts3x_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> -	&sensor_dev_attr_heater_enable.dev_attr.attr,
> -	&sensor_dev_attr_update_interval.dev_attr.attr,
>   	&sensor_dev_attr_repeatability.dev_attr.attr,
>   	NULL
>   };
>   
>   ATTRIBUTE_GROUPS(sht3x);
> -ATTRIBUTE_GROUPS(sts3x);
>   
> -static const struct i2c_device_id sht3x_ids[];
> +static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
> +				u32 attr, int channel)
> +{
> +	const struct sht3x_data *chip_data = data;
> +	struct i2c_client *client = chip_data->client;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_alarm:
> +			return 0444;
> +		case hwmon_temp_max:
> +		case hwmon_temp_max_hyst:
> +		case hwmon_temp_min:
> +		case hwmon_temp_min_hyst:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_humidity:
> +		if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)

It would be better to save the chip id in struct sht3x_data to avoid
having to dereference driver_data here, and to avoid needing a pointer
to struct i2c_client.

> +			return 0;

Maybe break; for consistency.

> +		switch (attr) {
> +		case hwmon_humidity_input:
> +		case hwmon_humidity_alarm:
> +			return 0444;
> +		case hwmon_humidity_max:
> +		case hwmon_humidity_max_hyst:
> +		case hwmon_humidity_min:
> +		case hwmon_humidity_min_hyst:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
> +		      u32 attr, int channel, long *val)
> +{
> +	enum sht3x_limits index;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			*val = update_interval_read(dev);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			*val = temp1_input_read(dev);
> +			break;
> +		case hwmon_temp_alarm:
> +			*val = temp1_alarm_read(dev);
> +			break;
> +		case hwmon_temp_max:
> +			index = limit_max;
> +			*val = temp1_limit_read(dev, index);
> +			break;
> +		case hwmon_temp_max_hyst:
> +			index = limit_max_hyst;
> +			*val = temp1_limit_read(dev, index);
> +			break;
> +		case hwmon_temp_min:
> +			index = limit_min;
> +			*val = temp1_limit_read(dev, index);
> +			break;
> +		case hwmon_temp_min_hyst:
> +			index = limit_min_hyst;
> +			*val = temp1_limit_read(dev, index);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_humidity:
> +		switch (attr) {
> +		case hwmon_humidity_input:
> +			*val = humidity1_input_read(dev);
> +			break;
> +		case hwmon_humidity_alarm:
> +			*val = humidity1_alarm_read(dev);
> +			break;
> +		case hwmon_humidity_max:
> +			index = limit_max;
> +			*val = humidity1_limit_read(dev, index);
> +			break;
> +		case hwmon_humidity_max_hyst:
> +			index = limit_max_hyst;
> +			*val = humidity1_limit_read(dev, index);
> +			break;
> +		case hwmon_humidity_min:
> +			index = limit_min;
> +			*val = humidity1_limit_read(dev, index);
> +			break;
> +		case hwmon_humidity_min_hyst:
> +			index = limit_min_hyst;
> +			*val = humidity1_limit_read(dev, index);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long val)
> +{
> +	enum sht3x_limits index;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return update_interval_write(dev, (const char *)&val);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_max:
> +			index = limit_max;
> +			break;
> +		case hwmon_temp_max_hyst:
> +			index = limit_max_hyst;
> +			break;
> +		case hwmon_temp_min:
> +			index = limit_min;
> +			break;
> +		case hwmon_temp_min_hyst:
> +			index = limit_min_hyst;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		return temp1_limit_write(dev, index, (const char *)&val);

This does not work. The val parameter passed to the write function
is already the value, not a pointer to a string. There is no need
to parse it again, and trying to do so will fail (or, with bad luck,
crash).

Guenter

> +	case hwmon_humidity:
> +		switch (attr) {
> +		case hwmon_humidity_max:
> +			index = limit_max;
> +			break;
> +		case hwmon_humidity_max_hyst:
> +			index = limit_max_hyst;
> +			break;
> +		case hwmon_humidity_min:
> +			index = limit_min;
> +			break;
> +		case hwmon_humidity_min_hyst:
> +			index = limit_min_hyst;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		return humidity1_limit_write(dev, index, (const char *)val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops sht3x_ops = {
> +	.is_visible = sht3x_is_visible,
> +	.read = sht3x_read,
> +	.write = sht3x_write,
> +};
> +
> +static const struct hwmon_chip_info sht3x_chip_info = {
> +	.ops = &sht3x_ops,
> +	.info = sht3x_channel_info,
> +};
>   
>   static int sht3x_probe(struct i2c_client *client)
>   {
> @@ -730,7 +864,6 @@ static int sht3x_probe(struct i2c_client *client)
>   	struct device *hwmon_dev;
>   	struct i2c_adapter *adap = client->adapter;
>   	struct device *dev = &client->dev;
> -	const struct attribute_group **attribute_groups;
>   
>   	/*
>   	 * we require full i2c support since the sht3x uses multi-byte read and
> @@ -771,15 +904,11 @@ static int sht3x_probe(struct i2c_client *client)
>   	if (ret)
>   		return ret;
>   
> -	if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
> -		attribute_groups = sts3x_groups;
> -	else
> -		attribute_groups = sht3x_groups;
> -
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> -							   client->name,
> -							   data,
> -							   attribute_groups);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +							 client->name,
> +							 data,
> +							 &sht3x_chip_info,
> +							 sht3x_groups);
>   
>   	if (IS_ERR(hwmon_dev))
>   		dev_dbg(dev, "unable to register hwmon device\n");

