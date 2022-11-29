Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69163C4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiK2QLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiK2QLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:11:35 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC9391FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c15so4834756pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YhA6n8dm357wcZqVNioqoaI1v/zEL4SWm9nn+WcoVo=;
        b=J5PwCT3ItcYBJ/LNx/WxNgK7NNHvSlo8aNUyjBqWvPHd5+qVe1rgk9mySruamECctd
         8QBsm9ut3i0LblrrcrNr7vydLflUOuOOd1anziWvIKlNiTgX081UgfvfauAPlUz29Jra
         Qcer17O45wzONGAZuqS5GSZb8Xd1jwRY1mD1VJuyBLw8MNaRpkbQSysHHAGdSTllHid9
         71XyBt0Ms88yRs0V8+WRJb8pGotOzcBaOTPZp5jxMM33AdEcTiyLLYr4T+WMVnoHN4ix
         9FHWWLsm0lECCA64xoQZ2/IregO83ZrO1bOno5einesn5isAFgyhUQvI5oBe7jRGSDOK
         tz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YhA6n8dm357wcZqVNioqoaI1v/zEL4SWm9nn+WcoVo=;
        b=HvWjzomdllqYM10+cxM8zvHvDoyP+W4lx+dT2izM7QqESZd8RdhJbYlvkSIIZWvfUA
         wJcq+2CDRRc6QUjiWlL9AWnnsfb0+ABFLc4sP/+cKvhrBqO07Wji4ekVKWBYkjRd3oPy
         V1+ANzWvLKIXw1vRkjvBSHVQXHT5XX6AV+q0nOrP91EXR7/tiS0Njxh26aiWljZ3Z3LA
         wYQZqT02PELzwVs1wp7LZJSuJMnrlnaUOrgDfwBfHEYXkSJEHiL0YftDlzqLXXCB1qTP
         9UQbTNkzc76xtA32aotRp8A/3tAHlRtElJWiN5ZcT4M+2ixKo63RUjnj+GxqYNYBzZM0
         +MQw==
X-Gm-Message-State: ANoB5pn2TwEAo89odYXM1wl/VVOxvGHVLqSDiYSNMYpJw1B4LPkaLPzl
        rlNA5fDEbwIOJw5EnY5KRia2kA==
X-Google-Smtp-Source: AA0mqf7v0KYzV00BIYMtWiCx3r3DOn3aecrz0E9tjwvwP1SO6q1wcwJqBV1w10qvi4gblO//0fHEsg==
X-Received: by 2002:a63:225d:0:b0:477:beb8:70f8 with SMTP id t29-20020a63225d000000b00477beb870f8mr26800938pgm.281.1669738293476;
        Tue, 29 Nov 2022 08:11:33 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b001714e7608fdsm4088002pln.256.2022.11.29.08.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:11:33 -0800 (PST)
Message-ID: <eeed8981-5b38-c8ac-60fe-db6dcfea4908@9elements.com>
Date:   Tue, 29 Nov 2022 21:41:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 3/4] hwmon: (max6639) Change from pdata to dt
 configuration
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
 <20221121122932.2493174-4-Naresh.Solanki@9elements.com>
 <20221125161854.GA1171306@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221125161854.GA1171306@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 25-11-2022 09:48 pm, Guenter Roeck wrote:
> On Mon, Nov 21, 2022 at 01:29:31PM +0100, Naresh Solanki wrote:
>> max6639_platform_data is not used by any in-kernel driver and does not
>> address the MAX6639 fans separately.
>> Move to device tree configuration with explicit properties to configure
>> each fan.
>>
> 
> This patch does way more than that.
> 
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/max6639.c               | 246 +++++++++++++++++++-------
>>   include/linux/platform_data/max6639.h |  15 --
>>   2 files changed, 178 insertions(+), 83 deletions(-)
>>   delete mode 100644 include/linux/platform_data/max6639.h
>>
>> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
>> index 9b895402c80d..feafa3511297 100644
>> --- a/drivers/hwmon/max6639.c
>> +++ b/drivers/hwmon/max6639.c
>> @@ -19,7 +19,6 @@
>>   #include <linux/hwmon-sysfs.h>
>>   #include <linux/err.h>
>>   #include <linux/mutex.h>
>> -#include <linux/platform_data/max6639.h>
>>   
>>   /* Addresses to scan */
>>   static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
>> @@ -54,9 +53,12 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
>>   #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
>>   
>>   #define MAX6639_FAN_CONFIG1_PWM			0x80
>> -
>> +#define MAX6639_REG_FAN_CONFIG2a_PWM_POL	0x02
>>   #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
>> +#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
>> +#define MAX6639_REG_TARGTDUTY_SLOT		120
>>   
>> +/* Tach supported range. This internally controls tach frequency */
>>   static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>>   
>>   #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
>> @@ -76,18 +78,21 @@ struct max6639_data {
>>   	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
>>   	bool temp_fault[2];	/* Detected temperature diode failure */
>>   	u8 fan[2];		/* Register value: TACH count for fans >=30 */
>> +	u32 target_rpm[2];
>> +	u32 max_rpm[2];
>> +	u8 pwm[2];
>> +
>>   	u8 status;		/* Detected channel alarms and fan failures */
>>   
>>   	/* Register values only written to */
>> -	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
>>   	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
>>   	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
>>   	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
>>   
>>   	/* Register values initialized only once */
>> -	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
>> -	u8 rpm_range;		/* Index in above rpm_ranges table */
>> -
>> +	u8 ppr[2];		/* Pulses per rotation 0..3 for 1..4 ppr */
>> +	u8 rpm_range[2];	/* Index in above rpm_ranges table */
>> +	u8 pwm_polarity[2];
>>   	/* Optional regulator for FAN supply */
>>   	struct regulator *reg;
>>   };
>> @@ -282,6 +287,7 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
>>   	struct max6639_data *data = dev_get_drvdata(dev);
>>   
>>   	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
>> +
> 
> Unnecessary and wrong whitespace change.
> 
>>   }
>>   
>>   static ssize_t pwm_store(struct device *dev,
>> @@ -302,10 +308,10 @@ static ssize_t pwm_store(struct device *dev,
>>   
>>   	mutex_lock(&data->update_lock);
>>   	data->pwm[attr->index] = (u8)(val * 120 / 255);
>> -	i2c_smbus_write_byte_data(client,
>> -				  MAX6639_REG_TARGTDUTY(attr->index),
>> -				  data->pwm[attr->index]);
>> +	i2c_smbus_write_byte_data(client, MAX6639_REG_TARGTDUTY(attr->index),
>> +				 data->pwm[attr->index]);
>>   	mutex_unlock(&data->update_lock);
>> +
>>   	return count;
> 
> Unnecessary formatting change. You may not like the original formatting,
> but that is no reason to change it.
> 
>>   }
>>   
>> @@ -319,7 +325,7 @@ static ssize_t fan_input_show(struct device *dev,
>>   		return PTR_ERR(data);
>>   
>>   	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
>> -		       data->rpm_range));
>> +		       data->rpm_range[attr->index]));
>>   }
>>   
>>   static ssize_t alarm_show(struct device *dev,
>> @@ -386,29 +392,40 @@ static struct attribute *max6639_attrs[] = {
>>   ATTRIBUTE_GROUPS(max6639);
>>   
>>   /*
>> - *  returns respective index in rpm_ranges table
>> - *  1 by default on invalid range
>> + *  Get respective index in rpm_ranges table
>>    */
>> -static int rpm_range_to_reg(int range)
>> +static int rpm_range_to_index(struct device *dev, u8 *index, int rpm)
>>   {
>> -	int i;
>> -
>> -	for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
>> -		if (rpm_ranges[i] == range)
>> -			return i;
>> +	if (rpm < 0)
>> +		return -EINVAL;
>> +
>> +	/* Set index based on chip support */
>> +	switch (rpm) {
>> +	case 0 ... 2000:
>> +		*index = 0;
>> +		break;
>> +	case 2001 ... 4000:
>> +		*index = 1;
>> +		break;
>> +	case 4001 ... 8000:
>> +		*index = 2;
>> +		break;
>> +	case 8001 ... 16000:
>> +		*index = 3;
>> +		break;
>> +	default:
>> +		/* Use max range for higher RPM */
>> +		dev_warn(dev,
>> +		    "RPM higher than supported range. Default to 16000 RPM");
>> +		*index = 3;
>>   	}
>> -
>> -	return 1; /* default: 4000 RPM */
>> +	return 0;
> 
> The above changes are unrelated to $subject. Also, the same could be
> accomplished by varying the range check in the for loop, making the
> change POV. The warning is both unacceptable and unnecessary.
> 
>>   }
>>   
>>   static int max6639_init_client(struct i2c_client *client,
>>   			       struct max6639_data *data)
>>   {
>> -	struct max6639_platform_data *max6639_info =
>> -		dev_get_platdata(&client->dev);
>> -	int i;
>> -	int rpm_range = 1; /* default: 4000 RPM */
>> -	int err;
>> +	int i, err;
>>   
>>   	/* Reset chip to default values, see below for GCONFIG setup */
>>   	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
>> @@ -416,51 +433,29 @@ static int max6639_init_client(struct i2c_client *client,
>>   	if (err)
>>   		goto exit;
>>   
>> -	/* Fans pulse per revolution is 2 by default */
>> -	if (max6639_info && max6639_info->ppr > 0 &&
>> -			max6639_info->ppr < 5)
>> -		data->ppr = max6639_info->ppr;
>> -	else
>> -		data->ppr = 2;
>> -	data->ppr -= 1;
>> -
>> -	if (max6639_info)
>> -		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
>> -	data->rpm_range = rpm_range;
>> -
>>   	for (i = 0; i < 2; i++) {
>>   
>>   		/* Set Fan pulse per revolution */
>> -		err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_FAN_PPR(i),
>> -				data->ppr << 6);
>> +		err = i2c_smbus_write_byte_data(client,	MAX6639_REG_FAN_PPR(i),
>> +						data->ppr[i] << 6);
>>   		if (err)
>>   			goto exit;
>>   
>>   		/* Fans config PWM, RPM */
>>   		err = i2c_smbus_write_byte_data(client,
>> -			MAX6639_REG_FAN_CONFIG1(i),
>> -			MAX6639_FAN_CONFIG1_PWM | rpm_range);
>> -		if (err)
>> -			goto exit;
>> -
>> -		/* Fans PWM polarity high by default */
>> -		if (max6639_info && max6639_info->pwm_polarity == 0)
>> -			err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
>> -		else
>> -			err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
>> +						MAX6639_REG_FAN_CONFIG1(i),
>> +						MAX6639_FAN_CONFIG1_PWM |
>> +						data->rpm_range[i]);
> 
> The above change silently drops the configuration of
> MAX6639_REG_FAN_CONFIG2a, which is puzzling since the patch
> also introduces MAX6639_REG_FAN_CONFIG2a_PWM_POL which isn't
> used. I don't see what this has to do with $subject, and the
> lack of explanation is not really reassuring.
> 
>>   		if (err)
>>   			goto exit;
>>   
>>   		/*
>> -		 * /THERM full speed enable,
>> +		 * /THERM full speed disable,
> 
> Change unrelated to $subject and possibly unexpected results
> for users of this driver.
> 
>>   		 * PWM frequency 25kHz, see also GCONFIG below
>>   		 */
>>   		err = i2c_smbus_write_byte_data(client,
>> -			MAX6639_REG_FAN_CONFIG3(i),
>> -			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
>> +						MAX6639_REG_FAN_CONFIG3(i),
>> +						0x03);
>>   		if (err)
>>   			goto exit;
>>   
>> @@ -469,31 +464,34 @@ static int max6639_init_client(struct i2c_client *client,
>>   		data->temp_alert[i] = 90;
>>   		data->temp_ot[i] = 100;
>>   		err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_THERM_LIMIT(i),
>> -				data->temp_therm[i]);
>> +						MAX6639_REG_THERM_LIMIT(i),
>> +						data->temp_therm[i]);
>>   		if (err)
>>   			goto exit;
>>   		err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_ALERT_LIMIT(i),
>> -				data->temp_alert[i]);
>> +						MAX6639_REG_ALERT_LIMIT(i),
>> +						data->temp_alert[i]);
> 
> Unrelated formatting changes above. Such changes just obfuscate functional
> changes made in the patch and are unacceptable. If you want to fix
> checkpatch issues, do it in a separate patch.
> 
> I am stopping the review here. In the future, please refrain from making
> unrelated changes. One logical change per patch, please.
Sure. Thanks.
> 
> Guenter
> 
>>   		if (err)
>>   			goto exit;
>>   		err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
>> +						MAX6639_REG_OT_LIMIT(i),
>> +						data->temp_ot[i]);
>>   		if (err)
>>   			goto exit;
>>   
>>   		/* PWM 120/120 (i.e. 100%) */
>> -		data->pwm[i] = 120;
>> -		err = i2c_smbus_write_byte_data(client,
>> -				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
>> +		data->pwm[i] = data->target_rpm[i];
>> +		err = i2c_smbus_write_byte_data(client, MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
>> +
>>   		if (err)
>>   			goto exit;
>> +
>>   	}
>>   	/* Start monitoring */
>>   	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
>>   		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
>>   		MAX6639_GCONFIG_PWM_FREQ_HI);
>> +
>>   exit:
>>   	return err;
>>   }
>> @@ -524,12 +522,95 @@ static void max6639_regulator_disable(void *data)
>>   	regulator_disable(data);
>>   }
>>   
>> +static int max6639_probe_child_from_dt(struct i2c_client *client,
>> +				      struct device_node *child,
>> +				      struct max6639_data *data)
>> +
>> +{
>> +	struct device *dev = &client->dev;
>> +	u32 i, maxrpm;
>> +	int val, err;
>> +
>> +	err = of_property_read_u32(child, "reg", &i);
>> +	if (err) {
>> +		dev_err(dev, "missing reg property of %pOFn\n", child);
>> +		return err;
>> +	}
>> +
>> +	if (i >= 2) {
>> +		dev_err(dev, "invalid reg %d of %pOFn\n", i, child);
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = of_property_read_u32(child, "pulses-per-revolution", &val);
>> +	if (err) {
>> +		dev_err(dev, "missing pulses-per-revolution property of %pOFn",
>> +			child);
>> +		return err;
>> +	}
>> +
>> +	if (val < 0 || val > 5) {
>> +		dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val,
>> +			child);
>> +		return -EINVAL;
>> +	}
>> +	data->ppr[i] = val;
>> +
>> +	err = of_property_read_u32(child, "max-rpm", &maxrpm);
>> +	if (err) {
>> +		dev_err(dev, "missing max-rpm property of %pOFn\n", child);
>> +		return err;
>> +	}
>> +
>> +	err = rpm_range_to_index(dev, &data->rpm_range[i], maxrpm);
>> +	if (err) {
>> +		dev_err(dev, "invalid max-rpm %d of %pOFn\n", maxrpm, child);
>> +		return err;
>> +	}
>> +	data->max_rpm[i] = maxrpm;
>> +
>> +	err = of_property_read_u32(child, "target-rpm", &val);
>> +	/* Use provided target RPM else default to maxrpm */
>> +	if (!err)
>> +		data->target_rpm[i] = val;
>> +	else
>> +		data->target_rpm[i] = maxrpm;
>> +
>> +	return 0;
>> +}
>> +
>> +static int max6639_probe_from_dt(struct i2c_client *client,
>> +				 struct max6639_data *data)
>> +{
>> +	struct device *dev = &client->dev;
>> +	const struct device_node *np = dev->of_node;
>> +	struct device_node *child;
>> +	int err;
>> +
>> +	/* Compatible with non-DT platforms */
>> +	if (!np)
>> +		return 0;
>> +
>> +	for_each_child_of_node(np, child) {
>> +		if (strcmp(child->name, "fan"))
>> +			continue;
>> +
>> +		err = max6639_probe_child_from_dt(client, child, data);
>> +		if (err) {
>> +			of_node_put(child);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int max6639_probe(struct i2c_client *client)
>>   {
>>   	struct device *dev = &client->dev;
>>   	struct max6639_data *data;
>>   	struct device *hwmon_dev;
>> -	int err;
>> +	int err, i;
>>   
>>   	data = devm_kzalloc(dev, sizeof(struct max6639_data), GFP_KERNEL);
>>   	if (!data)
>> @@ -539,9 +620,11 @@ static int max6639_probe(struct i2c_client *client)
>>   
>>   	data->reg = devm_regulator_get_optional(dev, "fan");
>>   	if (IS_ERR(data->reg)) {
>> -		if (PTR_ERR(data->reg) != -ENODEV)
>> -			return PTR_ERR(data->reg);
>> -
>> +		if (PTR_ERR(data->reg) != -ENODEV) {
>> +			err = (int)PTR_ERR(data->reg);
>> +			return dev_err_probe(dev, err,
>> +					     "Failed looking up fan supply\n");
>> +		}
>>   		data->reg = NULL;
>>   	} else {
>>   		/* Spin up fans */
>> @@ -560,6 +643,22 @@ static int max6639_probe(struct i2c_client *client)
>>   
>>   	mutex_init(&data->update_lock);
>>   
>> +	/* Below are defaults later overridden by DT properties */
>> +	for (i = 0; i < 2; i++) {
>> +		/* 4000 RPM */
>> +		data->rpm_range[i] = 1;
>> +		data->ppr[i] = 2;
>> +		/* Max. temp. 80C/90C/100C */
>> +		data->temp_therm[i] = 80;
>> +		data->temp_alert[i] = 90;
>> +		data->temp_ot[i] = 100;
>> +	}
>> +
>> +	/* Probe from DT to get configuration */
>> +	err = max6639_probe_from_dt(client, data);
>> +	if (err)
>> +		return err;
>> +
>>   	/* Initialize the max6639 chip */
>>   	err = max6639_init_client(client, data);
>>   	if (err < 0)
>> @@ -571,6 +670,7 @@ static int max6639_probe(struct i2c_client *client)
>>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_PM_SLEEP)
>>   static int max6639_suspend(struct device *dev)
>>   {
>>   	struct i2c_client *client = to_i2c_client(dev);
>> @@ -608,6 +708,7 @@ static int max6639_resume(struct device *dev)
>>   	return i2c_smbus_write_byte_data(client,
>>   			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
>>   }
>> +#endif
>>   
>>   static const struct i2c_device_id max6639_id[] = {
>>   	{"max6639", 0},
>> @@ -616,13 +717,22 @@ static const struct i2c_device_id max6639_id[] = {
>>   
>>   MODULE_DEVICE_TABLE(i2c, max6639_id);
>>   
>> -static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id maxim_of_platform_match[] = {
>> +	{.compatible = "maxim,max6639"},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
>>   
>>   static struct i2c_driver max6639_driver = {
>>   	.class = I2C_CLASS_HWMON,
>>   	.driver = {
>>   		   .name = "max6639",
>>   		   .pm = pm_sleep_ptr(&max6639_pm_ops),
>> +		   .of_match_table = of_match_ptr(maxim_of_platform_match),
>>   		   },
>>   	.probe_new = max6639_probe,
>>   	.id_table = max6639_id,
>> diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
>> deleted file mode 100644
>> index 65bfdb4fdc15..000000000000
>> --- a/include/linux/platform_data/max6639.h
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef _LINUX_MAX6639_H
>> -#define _LINUX_MAX6639_H
>> -
>> -#include <linux/types.h>
>> -
>> -/* platform data for the MAX6639 temperature sensor and fan control */
>> -
>> -struct max6639_platform_data {
>> -	bool pwm_polarity;	/* Polarity low (0) or high (1, default) */
>> -	int ppr;		/* Pulses per rotation 1..4 (default == 2) */
>> -	int rpm_range;		/* 2000, 4000 (default), 8000 or 16000 */
>> -};
>> -
>> -#endif /* _LINUX_MAX6639_H */
Regrads,
Naresh
