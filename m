Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7561159B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJ1PMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJ1PMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:12:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC520B12D;
        Fri, 28 Oct 2022 08:12:02 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id o64so6400748oib.12;
        Fri, 28 Oct 2022 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPblGtdagM6qnN+XXUdKGO5EZ0kxLFakPRX4v/DmSdU=;
        b=eS2uxqi8HPIXp5LK3gCAQlgLnBOAjACLF3ywq+8IRnpc0LNHbsQ4ywXcaq12NDIlvu
         ht00r2nJf76YiVXHjhv6AOogrSp1IAZf634KJsvILrgJKlFAf4GnNpQdAug7T0SmhxLE
         sdDND6RzOof5/srprrSuFNLOrfWvBZq5uZY3dYXQG+7vE4d3HqdIWVFbxvpsICDPKlnb
         Nqz3CsZUKpSKI5ONiSBgWJklLhCWv5X5EguOfuJnMN4ptulf9tuq7YqlvxXnanf2bKeW
         HrMsNyDQHjMrqA/AzmXiu4cZV1TnNVQfa4c7Z5BTHq2AzefQ/8XcKGEtgPnYQj4TcwYw
         Tm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPblGtdagM6qnN+XXUdKGO5EZ0kxLFakPRX4v/DmSdU=;
        b=mlYwgF2mx+tgBaMZUna1MUxpArTNlYDPqNRAMcklcwx7zYqQ1ol0T7U5DfEug2K+Cx
         RzkZanFbxTdv13M/Bd8wUP8YrCyb6pIPcrv2yIow6iF+kt1teDXAyMTNT6fmg88UL+Lm
         ZMVy06a+2wdGDt8aJNSz44riImgbLWnC3kEChGTaXaLsgcO4vWgHCbpqjIYp7A2qZ2k5
         iSTNzhbUp1ZYjSuPscCeoyAV5d1PQXHMKemCCHs5F7MhVqxRm/Gm204b9ZG8nnz85Jag
         Bmun4DRNTet2DkxH25ApPB4OA4gZPm8KA1vsFMoA+7AKilyTfNiHl/aiSyXE0KT6HXpx
         vTMA==
X-Gm-Message-State: ACrzQf3nGfIFquY8a+vawnUcpcMP9L25uXrbxsNZaTtsjgU9ZAxGwSI5
        FfSnDySiYOeI7ug6VH9I2L0=
X-Google-Smtp-Source: AMsMyM7tkGOdgUbCyEwDmpQGPgZ5gNyFzX8lSwhqL6nNjI8+YCQt4J6RwXUX27MZgPNqjYCMjxDW+Q==
X-Received: by 2002:aca:a84f:0:b0:359:aa75:443e with SMTP id r76-20020acaa84f000000b00359aa75443emr34359oie.108.1666969921505;
        Fri, 28 Oct 2022 08:12:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5-20020aca5d05000000b0035956747d07sm1597415oib.17.2022.10.28.08.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 08:12:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b914ea25-a9a8-f443-2ba0-615bdd6cc04f@roeck-us.net>
Date:   Fri, 28 Oct 2022 08:11:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hwmon@vger.kernel.org
References: <20221028140833.280091-1-cristian.marussi@arm.com>
 <20221028140833.280091-7-cristian.marussi@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
In-Reply-To: <20221028140833.280091-7-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 07:08, Cristian Marussi wrote:
> Available sensors are enumerated and reported by the SCMI platform server
> using a 16bit identification number; not all such sensors are of a type
> supported by hwmon subsystem and, among the supported ones, only a subset
> could be temperature sensors that have to be registered with the Thermal
> Framework.
> Potential clashes between hwmon channels indexes and the underlying real
> sensors IDs do not play well with the hwmon<-->thermal bridge automatic
> registration routines and could need a sensible number of fake dummy
> sensors to be made up in order to keep indexes and IDs in sync.
> 
> Avoid to use the hwmon<-->thermal bridge dropping the HWMON_C_REGISTER_TZ
> attribute and instead explicit register temperature sensors directly with
> the Thermal Framework.
> 


For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

$subject says "patch 7/8". Patches 1-6 are firmware patches. Does this patch
depend on the other patches of the series or can I apply it on its own ?

Additional comment inline below.

Thanks,
Guenter

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/hwmon/scmi-hwmon.c | 115 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 102 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index b1329a58ce40..124fe8ee1b9b 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -20,6 +20,11 @@ struct scmi_sensors {
>   	const struct scmi_sensor_info **info[hwmon_max];
>   };
>   
> +struct scmi_thermal_sensor {
> +	const struct scmi_protocol_handle *ph;
> +	const struct scmi_sensor_info *info;
> +};
> +
>   static inline u64 __pow10(u8 x)
>   {
>   	u64 r = 1;
> @@ -64,16 +69,14 @@ static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
>   	return 0;
>   }
>   
> -static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> -			   u32 attr, int channel, long *val)
> +static int scmi_hwmon_read_scaled_value(const struct scmi_protocol_handle *ph,
> +					const struct scmi_sensor_info *sensor,
> +					long *val)
>   {
>   	int ret;
>   	u64 value;
> -	const struct scmi_sensor_info *sensor;
> -	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
>   
> -	sensor = *(scmi_sensors->info[type] + channel);
> -	ret = sensor_ops->reading_get(scmi_sensors->ph, sensor->id, &value);
> +	ret = sensor_ops->reading_get(ph, sensor->id, &value);
>   	if (ret)
>   		return ret;
>   
> @@ -84,6 +87,17 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	return ret;
>   }
>   
> +static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	const struct scmi_sensor_info *sensor;
> +	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
> +
> +	sensor = *(scmi_sensors->info[type] + channel);
> +
> +	return scmi_hwmon_read_scaled_value(scmi_sensors->ph, sensor, val);
> +}
> +
>   static int
>   scmi_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
>   		       u32 attr, int channel, const char **str)
> @@ -122,6 +136,25 @@ static struct hwmon_chip_info scmi_chip_info = {
>   	.info = NULL,
>   };
>   
> +static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
> +				       int *temp)
> +{
> +	int ret;
> +	long value;
> +	struct scmi_thermal_sensor *th_sensor = tz->devdata;
> +
> +	ret = scmi_hwmon_read_scaled_value(th_sensor->ph, th_sensor->info,
> +					   &value);
> +	if (!ret)
> +		*temp = value;
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
> +	.get_temp = scmi_hwmon_thermal_get_temp,
> +};
> +
>   static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
>   				    struct device *dev, int num,
>   				    enum hwmon_sensor_types type, u32 config)
> @@ -149,7 +182,6 @@ static enum hwmon_sensor_types scmi_types[] = {
>   };
>   
>   static u32 hwmon_attributes[hwmon_max] = {
> -	[hwmon_chip] = HWMON_C_REGISTER_TZ,
>   	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
>   	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
>   	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
> @@ -157,6 +189,43 @@ static u32 hwmon_attributes[hwmon_max] = {
>   	[hwmon_energy] = HWMON_E_INPUT | HWMON_E_LABEL,
>   };
>   
> +static int scmi_thermal_sensor_register(struct device *dev,
> +					const struct scmi_protocol_handle *ph,
> +					const struct scmi_sensor_info *sensor)
> +{
> +	struct scmi_thermal_sensor *th_sensor;
> +	struct thermal_zone_device *tzd;
> +
> +	th_sensor = devm_kzalloc(dev, sizeof(*th_sensor), GFP_KERNEL);
> +	if (!th_sensor)
> +		return -ENOMEM;
> +
> +	th_sensor->ph = ph;
> +	th_sensor->info = sensor;
> +
> +	/*
> +	 * Try to register a temperature sensor with the Thermal Framework:
> +	 * skip sensors not defined as part of any thermal zone (-ENODEV) but
> +	 * report any other errors related to misconfigured zones/sensors.
> +	 */
> +	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
> +					    &scmi_hwmon_thermal_ops);
> +	if (IS_ERR(tzd)) {
> +		devm_kfree(dev, th_sensor);
> +
> +		if (PTR_ERR(tzd) != -ENODEV)
> +			return PTR_ERR(tzd);
> +
> +		dev_info(dev, "Sensor '%s' not attached to any thermal zone.\n",
> +			 sensor->name);

There were complaints about this message as it is noisy. If you send
another version, please drop it unless attaching each sensor to a thermal
zone is strongly expected. If you don't send another version, I'll drop it
while applying.

> +	} else {
> +		dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
> +			sensor->name, tzd->id);
> +	}
> +
> +	return 0;
> +}
> +
>   static int scmi_hwmon_probe(struct scmi_device *sdev)
>   {
>   	int i, idx;
> @@ -164,7 +233,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   	enum hwmon_sensor_types type;
>   	struct scmi_sensors *scmi_sensors;
>   	const struct scmi_sensor_info *sensor;
> -	int nr_count[hwmon_max] = {0}, nr_types = 0;
> +	int nr_count[hwmon_max] = {0}, nr_types = 0, nr_count_temp = 0;
>   	const struct hwmon_chip_info *chip_info;
>   	struct device *hwdev, *dev = &sdev->dev;
>   	struct hwmon_channel_info *scmi_hwmon_chan;
> @@ -208,10 +277,8 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   		}
>   	}
>   
> -	if (nr_count[hwmon_temp]) {
> -		nr_count[hwmon_chip]++;
> -		nr_types++;
> -	}
> +	if (nr_count[hwmon_temp])
> +		nr_count_temp = nr_count[hwmon_temp];
>   
>   	scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
>   				       GFP_KERNEL);
> @@ -262,8 +329,30 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   	hwdev = devm_hwmon_device_register_with_info(dev, "scmi_sensors",
>   						     scmi_sensors, chip_info,
>   						     NULL);
> +	if (IS_ERR(hwdev))
> +		return PTR_ERR(hwdev);
> +
> +	for (i = 0; i < nr_count_temp; i++) {
> +		int ret;
>   
> -	return PTR_ERR_OR_ZERO(hwdev);
> +		sensor = *(scmi_sensors->info[hwmon_temp] + i);
> +		if (!sensor)
> +			continue;
> +
> +		/*
> +		 * Warn on any misconfiguration related to thermal zones but
> +		 * bail out of probing only on memory errors.
> +		 */
> +		ret = scmi_thermal_sensor_register(dev, ph, sensor);
> +		if (ret == -ENOMEM)
> +			return ret;
> +		else if (ret)
> +			dev_warn(dev,
> +				 "Thermal zone misconfigured for %s. err=%d\n",
> +				 sensor->name, ret);
> +	}
> +
> +	return 0;
>   }
>   
>   static const struct scmi_device_id scmi_id_table[] = {

