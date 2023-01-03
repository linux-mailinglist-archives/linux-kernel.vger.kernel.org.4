Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89865C8DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbjACVWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbjACVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:22:10 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E2101C6;
        Tue,  3 Jan 2023 13:22:08 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id e205so28112124oif.11;
        Tue, 03 Jan 2023 13:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jAoZL42JAx32jP8qKqwmopet4olfOMCg8spIc9wSNw=;
        b=NGjMFUs9uNuE+bWg82ndWO3hlqYBvJKr9MQevpaDYrPymzwNcr2a4bZaICslLozeAi
         7bEJnsA1nCFIh7dcwtpQzoEd7z7m8MvFRKWug+7hMkVZnSY2o3Sy/Y7MbKPoCTV1QI6i
         Q5Og9/kz+WQUqVtL68yCIzYpvpnyBzj1lpeIUrg/qf2m2z19zt7RV2TWpE3aPfC+zfVC
         6ZMpoMv4aclwzxvRtRus5DZ6OSfMId6ILmd0WTE/L/OdADUDw2Fzpm9ICMp5A6i3ssR7
         cpqZ1VXHaVTB8YewGDEDHphmUZvLNxgM2CjY7ewMg1K3Ds3KzywVCAqhkqF7rilHx088
         QRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jAoZL42JAx32jP8qKqwmopet4olfOMCg8spIc9wSNw=;
        b=Rn/dYemuYyAgPfLPTUKan7zZgagIrTVPGd6Ivo9VRt9LG7rtakL2N1HWdyMXe3Ne7J
         4M6ahEeQgRJG0nnrkxZv4ORXBSo1fyGuoIRLdu3XegJmcUCKDlp4/dY1Jdtp0H4bjNjQ
         eKz7hnzdHe8hbuAJYLCHODbUoxG248scSlVF0vR9pS9yeUnbCQ5AUrYFbR/QFfrlB8yD
         JTzY/y0GCuXY6c9jq5LqI52wJwjwrBvXD8OZaVUEkNuCbxhd0QU7Bt1jb6NBeyV/TNio
         GoGu6PFBzdAYFEl1npeS2zszdOu6Xm7WS49rXNUmLzlyGU2ggTGke6x84dUR4gU1Y+g6
         TPZg==
X-Gm-Message-State: AFqh2koRplBHobcltHxbtLWaDjkequAWBPyrb2UrpmCbQwUYW5P6yvu5
        rYfzFcAjxFDRXBPFVbkYoojqUJCG44w=
X-Google-Smtp-Source: AMrXdXvHfpyWmYo//n4J9u6ZBaOXcZM0wa5OvkgQkaAfnAJnayyIsILS0FS9Pk97wRROBY02McNW+Q==
X-Received: by 2002:a05:6808:1781:b0:35e:9090:296d with SMTP id bg1-20020a056808178100b0035e9090296dmr31579112oib.12.1672780927973;
        Tue, 03 Jan 2023 13:22:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cg6-20020a056830630600b006706cd202b0sm15313806otb.11.2023.01.03.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:22:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:22:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for reading
 calculated Aquaero sensors
Message-ID: <20230103212206.GA213374@roeck-us.net>
References: <20230101190056.1357124-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101190056.1357124-1-savicaleksa83@gmail.com>
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

On Sun, Jan 01, 2023 at 08:00:56PM +0100, Aleksa Savic wrote:
> Add support for reading four calculated virtual temp sensors on the
> Aquacomputer Aquaero. Values of these sensors are calculated on the
> device itself based on what the user configured in the official software.
> Configuring these sensors is not currently reverse engineered.
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  6 +--
>  drivers/hwmon/aquacomputer_d5next.c         | 49 ++++++++++++++++++---
>  2 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index b94ff08080bf..3f7880fb8116 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -21,9 +21,9 @@ Description
>  This driver exposes hardware sensors of listed Aquacomputer devices, which
>  communicate through proprietary USB HID protocols.
>  
> -The Aquaero devices expose eight temperature sensors, eight virtual temperature
> -sensors and two flow senors. The fans expose their speed (in RPM), power,
> -voltage and current.
> +The Aquaero devices expose eight physical, eight virtual and four calculated
> +virtual temperature sensors, as well as two flow sensors. The fans expose their
> +speed (in RPM), power, voltage and current.
>  
>  For the D5 Next pump, available sensors are pump and fan speed, power, voltage
>  and current, as well as coolant temperature and eight virtual temp sensors. Also
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 0fd00cfb86c8..c1b885240ddf 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -77,11 +77,13 @@ static u8 secondary_ctrl_report[] = {
>  #define AQUAERO_NUM_FANS			4
>  #define AQUAERO_NUM_SENSORS			8
>  #define AQUAERO_NUM_VIRTUAL_SENSORS		8
> +#define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
>  #define AQUAERO_NUM_FLOW_SENSORS		2
>  
>  /* Sensor report offsets for Aquaero fan controllers */
>  #define AQUAERO_SENSOR_START			0x65
>  #define AQUAERO_VIRTUAL_SENSOR_START		0x85
> +#define AQUAERO_CALC_VIRTUAL_SENSOR_START	0x95
>  #define AQUAERO_FLOW_SENSORS_START		0xF9
>  #define AQUAERO_FAN_VOLTAGE_OFFSET		0x04
>  #define AQUAERO_FAN_CURRENT_OFFSET		0x06
> @@ -232,6 +234,13 @@ static const char *const label_virtual_temp_sensors[] = {
>  	"Virtual sensor 16",
>  };
>  
> +static const char *const label_aquaero_calc_temp_sensors[] = {
> +	"Calc. virtual sensor 1",
> +	"Calc. virtual sensor 2",
> +	"Calc. virtual sensor 3",
> +	"Calc. virtual sensor 4"
> +};
> +
>  /* Labels for Octo and Quadro (except speed) */
>  static const char *const label_fan_speed[] = {
>  	"Fan 1 speed",
> @@ -361,6 +370,8 @@ struct aqc_data {
>  	int temp_sensor_start_offset;
>  	int num_virtual_temp_sensors;
>  	int virtual_temp_sensor_start_offset;
> +	int num_calc_virt_temp_sensors;
> +	int calc_virt_temp_sensor_start_offset;
>  	u16 temp_ctrl_offset;
>  	u16 power_cycle_count_offset;
>  	int num_flow_sensors;
> @@ -378,7 +389,7 @@ struct aqc_data {
>  	u32 power_cycles;
>  
>  	/* Sensor values */
> -	s32 temp_input[20];	/* Max 4 physical and 16 virtual */
> +	s32 temp_input[20];	/* Max 4 physical and 16 virtual or 8 physical and 12 virtual */
>  	u16 speed_input[8];
>  	u32 power_input[8];
>  	u16 voltage_input[8];
> @@ -387,6 +398,7 @@ struct aqc_data {
>  	/* Label values */
>  	const char *const *temp_label;
>  	const char *const *virtual_temp_label;
> +	const char *const *calc_virt_temp_label;	/* For Aquaero */
>  	const char *const *speed_label;
>  	const char *const *power_label;
>  	const char *const *voltage_label;
> @@ -507,7 +519,9 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  			}
>  		}
>  
> -		if (channel < priv->num_temp_sensors + priv->num_virtual_temp_sensors)
> +		if (channel <
> +		    priv->num_temp_sensors + priv->num_virtual_temp_sensors +
> +		    priv->num_calc_virt_temp_sensors)
>  			switch (attr) {
>  			case hwmon_temp_label:
>  			case hwmon_temp_input:
> @@ -676,12 +690,20 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>  {
>  	struct aqc_data *priv = dev_get_drvdata(dev);
>  
> +	/* Number of sensors that are not calculated */
> +	int num_non_calc_sensors = priv->num_temp_sensors + priv->num_virtual_temp_sensors;
> +
>  	switch (type) {
>  	case hwmon_temp:
> -		if (channel < priv->num_temp_sensors)
> +		if (channel < priv->num_temp_sensors) {
>  			*str = priv->temp_label[channel];
> -		else
> -			*str = priv->virtual_temp_label[channel - priv->num_temp_sensors];
> +		} else {
> +			if (priv->kind == aquaero && channel >= num_non_calc_sensors)
> +				*str =
> +				    priv->calc_virt_temp_label[channel - num_non_calc_sensors];
> +			else
> +				*str = priv->virtual_temp_label[channel - priv->num_temp_sensors];
> +		}
>  		break;
>  	case hwmon_fan:
>  		*str = priv->speed_label[channel];
> @@ -910,6 +932,20 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  
>  	/* Special-case sensor readings */
>  	switch (priv->kind) {
> +	case aquaero:
> +		/* Read calculated virtual temp sensors */
> +		i = priv->num_temp_sensors + priv->num_virtual_temp_sensors;
> +		for (j = 0; j < priv->num_calc_virt_temp_sensors; j++) {
> +			sensor_value = get_unaligned_be16(data +
> +					priv->calc_virt_temp_sensor_start_offset +
> +					j * AQC_SENSOR_SIZE);
> +			if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
> +				priv->temp_input[i] = -ENODATA;
> +			else
> +				priv->temp_input[i] = sensor_value * 10;
> +			i++;
> +		}
> +		break;
>  	case d5next:
>  		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
>  		priv->voltage_input[3] = get_unaligned_be16(data + D5NEXT_12V_VOLTAGE) * 10;
> @@ -1046,11 +1082,14 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
>  		priv->num_virtual_temp_sensors = AQUAERO_NUM_VIRTUAL_SENSORS;
>  		priv->virtual_temp_sensor_start_offset = AQUAERO_VIRTUAL_SENSOR_START;
> +		priv->num_calc_virt_temp_sensors = AQUAERO_NUM_CALC_VIRTUAL_SENSORS;
> +		priv->calc_virt_temp_sensor_start_offset = AQUAERO_CALC_VIRTUAL_SENSOR_START;
>  		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
>  		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
>  
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
> +		priv->calc_virt_temp_label = label_aquaero_calc_temp_sensors;
>  		priv->speed_label = label_aquaero_speeds;
>  		priv->power_label = label_fan_power;
>  		priv->voltage_label = label_fan_voltage;
