Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD343608D83
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJVN52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:57:26 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658A606BE;
        Sat, 22 Oct 2022 06:57:24 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13aeccf12fbso6899765fac.11;
        Sat, 22 Oct 2022 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZhQznEWYNowKYy4BIKQwLooGxQM1J5Bvj9ssvaVWfY=;
        b=LdfzLc8VDOFVilqEHWqMATGcyp3modSGAkQ9a3rdtPT9Czhk7UTorfCfkTcUOmDmo0
         S588Lck8P0kP6XEZR3GTrPV1e1QoP3M99M/eSptfUbL5pLRZXNbhxLBwpjlPhdlMimUf
         WC8vdzIhCUeKyeFFS0fF2tbi88BiKSz6YhdSysV10/d6n7JrShBkX7NdUHdSEJ15YxTk
         hHKIceGQyO54jzYCM6oVNXPkpsJWWilkdj7NQRkq+3a+ZJIfpNvLIhGesOBogOpMRfnl
         vw2iSml9CnmzaLqXONCdPHs0/HbVdQPSqBDQG/9IPyw9AASZ1ktJSlRILaGRndma/UNR
         lt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZhQznEWYNowKYy4BIKQwLooGxQM1J5Bvj9ssvaVWfY=;
        b=8OqKIfdhtZB8QNWK7E+Sd9kX2gmEyMq/fh2wn91O/vKVEttMSmE5nYLhQ07Ytbrbyv
         GEp8OcvoISf47hplAP7/1H+GZymgPxdaTgZbKf0B8RZsaDPIatxf+6sYzjMdlAotSqG5
         iInJI3vORquaKJ7xMmXg10qqokcnlkJcy7P+Z/LvBkvJM7C6kKCjArwpaV59T6OodRtD
         QWJvXYGy27qNPrc0q+SOali8S063/IdChA03AY+xO1IyfQaeeV5jjxpqRbiyMQ2iAfYz
         56cZLlovBe0lxKwa5eMm44w9XdlaTaxXNv1Y3Us3eCNeyb+vO7WEaoSYDw7Mws/S1CFq
         Cltw==
X-Gm-Message-State: ACrzQf3Kgrr5lsrbugdP+cqgwLUvJ7Yqnd6+wqstFtI3KDUZu/3M29PB
        /ijXhk6g6vZGWbNb7J0IMFs=
X-Google-Smtp-Source: AMsMyM52QrwwcQhLz+zh9MWvRb5VvWXn8b/8wQK8+KcfWyk3FrZSsk2DQldI0Ki0fxFJHedbxWa7Og==
X-Received: by 2002:a05:6870:960d:b0:13b:254d:247e with SMTP id d13-20020a056870960d00b0013b254d247emr5832662oaq.237.1666447043445;
        Sat, 22 Oct 2022 06:57:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s16-20020a05683004d000b00661a33883b8sm2240937otd.71.2022.10.22.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 06:57:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Oct 2022 06:57:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for temperature
 sensor offsets
Message-ID: <20221022135720.GA739650@roeck-us.net>
References: <20221021174834.736930-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021174834.736930-1-savicaleksa83@gmail.com>
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

On Fri, Oct 21, 2022 at 07:48:34PM +0200, Aleksa Savic wrote:
> Add support for reading and writing temperature sensor offsets
> on the Aquacomputer D5 Next, Farbwerk 360, Octo and Quadro,
> for which the needed offsets are known. Implemented by
> Leonard Anderweit [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/22
> 
> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  1 +
>  drivers/hwmon/aquacomputer_d5next.c         | 91 ++++++++++++++++++---
>  2 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index e238533b5fe0..15226346434d 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -62,6 +62,7 @@ Sysfs entries
>  
>  ================ ==============================================================
>  temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
> +temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
>  fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
>  power[1-8]_input Pump/fan power (in micro Watts)
>  in[0-7]_input    Pump/fan voltage (in milli Volts)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index c51a2678f0eb..862d6c284e83 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -80,6 +80,7 @@ static u8 secondary_ctrl_report[] = {
>  #define D5NEXT_5V_VOLTAGE		0x39
>  #define D5NEXT_12V_VOLTAGE		0x37
>  #define D5NEXT_CTRL_REPORT_SIZE		0x329
> +#define D5NEXT_TEMP_CTRL_OFFSET		0x2D
>  static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
>  
>  /* Pump and fan speed registers in D5 Next control report (from 0-100%) */
> @@ -94,6 +95,8 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
>  #define FARBWERK360_SENSOR_START		0x32
>  #define FARBWERK360_NUM_VIRTUAL_SENSORS		16
>  #define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
> +#define FARBWERK360_CTRL_REPORT_SIZE		0x682
> +#define FARBWERK360_TEMP_CTRL_OFFSET		0x8
>  
>  /* Register offsets for the Octo fan controller */
>  #define OCTO_POWER_CYCLES		0x18
> @@ -103,6 +106,7 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
>  #define OCTO_NUM_VIRTUAL_SENSORS	16
>  #define OCTO_VIRTUAL_SENSORS_START	0x45
>  #define OCTO_CTRL_REPORT_SIZE		0x65F
> +#define OCTO_TEMP_CTRL_OFFSET		0xA
>  static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
>  
>  /* Fan speed registers in Octo control report (from 0-100%) */
> @@ -117,6 +121,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
>  #define QUADRO_VIRTUAL_SENSORS_START	0x3c
>  #define QUADRO_CTRL_REPORT_SIZE		0x3c1
>  #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
> +#define QUADRO_TEMP_CTRL_OFFSET		0xA
>  static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
>  
>  /* Fan speed registers in Quadro control report (from 0-100%) */
> @@ -282,6 +287,7 @@ struct aqc_data {
>  	int temp_sensor_start_offset;
>  	int num_virtual_temp_sensors;
>  	int virtual_temp_sensor_start_offset;
> +	u16 temp_ctrl_offset;
>  	u16 power_cycle_count_offset;
>  	u8 flow_sensor_offset;
>  
> @@ -365,8 +371,8 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>  	return ret;
>  }
>  
> -/* Refreshes the control buffer and returns value at offset */
> -static int aqc_get_ctrl_val(struct aqc_data *priv, int offset)
> +/* Refreshes the control buffer and stores value at offset in val */
> +static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
>  {
>  	int ret;
>  
> @@ -376,7 +382,7 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset)
>  	if (ret < 0)
>  		goto unlock_and_return;
>  
> -	ret = get_unaligned_be16(priv->buffer + offset);
> +	*val = (s16)get_unaligned_be16(priv->buffer + offset);
>  
>  unlock_and_return:
>  	mutex_unlock(&priv->mutex);
> @@ -393,7 +399,7 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
>  	if (ret < 0)
>  		goto unlock_and_return;
>  
> -	put_unaligned_be16((u16)val, priv->buffer + offset);
> +	put_unaligned_be16((s16)val, priv->buffer + offset);
>  
>  	ret = aqc_send_ctrl_data(priv);
>  
> @@ -408,8 +414,28 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  
>  	switch (type) {
>  	case hwmon_temp:
> +		if (channel < priv->num_temp_sensors) {
> +			switch (attr) {
> +			case hwmon_temp_label:
> +			case hwmon_temp_input:
> +				return 0444;
> +			case hwmon_temp_offset:
> +				if (priv->temp_ctrl_offset != 0)
> +					return 0644;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
>  		if (channel < priv->num_temp_sensors + priv->num_virtual_temp_sensors)
> -			return 0444;
> +			switch (attr) {
> +			case hwmon_temp_label:
> +			case hwmon_temp_input:
> +				return 0444;
> +			default:
> +				break;
> +			}
>  		break;
>  	case hwmon_pwm:
>  		if (priv->fan_ctrl_offsets && channel < priv->num_fans) {
> @@ -492,10 +518,26 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  
>  	switch (type) {
>  	case hwmon_temp:
> -		if (priv->temp_input[channel] == -ENODATA)
> -			return -ENODATA;
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			if (priv->temp_input[channel] == -ENODATA)
> +				return -ENODATA;
> +
> +			*val = priv->temp_input[channel];
> +			break;
> +		case hwmon_temp_offset:
> +			ret =
> +			    aqc_get_ctrl_val(priv,
> +					     priv->temp_ctrl_offset +
> +					     channel * AQC_TEMP_SENSOR_SIZE, val);

Please go up to 100 columns to avoid excessive line splits.

Is it really necessary to re-read the control buffer repeatedly
to report this value ? I don't know how costly that is, but unlike
the pwm value I would not expect the number to change.

Also, is this number indeed not included in the regular reports
sent from the controller ?

The driver doesn't distinguish between offsets in the control buffer
(pwm, and now temperature sensor offset) and offsets in the report buffer,
making it a bit difficult to determine if those are the same or not.
Some explanation in the driver would be nice if someone finds the time
to provide one. If the control buffer offsets are in a different number
space, they should really be marked accordingly (for example with a
_CTRL in the define).

> +			if (ret < 0)
> +				return ret;
>  
> -		*val = priv->temp_input[channel];
> +			*val *= 10;
> +			break;
> +		default:
> +			break;
> +		}
>  		break;
>  	case hwmon_fan:
>  		*val = priv->speed_input[channel];
> @@ -505,7 +547,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		break;
>  	case hwmon_pwm:
>  		if (priv->fan_ctrl_offsets) {
> -			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel]);
> +			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel], val);
>  			if (ret < 0)
>  				return ret;
>  
> @@ -563,6 +605,22 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  	struct aqc_data *priv = dev_get_drvdata(dev);
>  
>  	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_offset:
> +			/* Limit temp offset to +/- 15K as in the official software */
> +			val = clamp_val(val, -15000, 15000) / 10;
> +			ret =
> +			    aqc_set_ctrl_val(priv,
> +					     priv->temp_ctrl_offset +
> +					     channel * AQC_TEMP_SENSOR_SIZE, val);

Too many line splits. Please go up to 100 columns.

> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_input:
> @@ -597,10 +655,10 @@ static const struct hwmon_ops aqc_hwmon_ops = {
>  
>  static const struct hwmon_channel_info *aqc_info[] = {
>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
> @@ -853,6 +911,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->virtual_temp_sensor_start_offset = D5NEXT_VIRTUAL_SENSORS_START;
>  		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
>  		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
> +		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
>  
>  		priv->temp_label = label_d5next_temp;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
> @@ -867,6 +926,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->num_fans = 0;
>  		priv->num_temp_sensors = FARBWERK_NUM_SENSORS;
>  		priv->temp_sensor_start_offset = FARBWERK_SENSOR_START;
> +		priv->temp_ctrl_offset = 0;
> +

It is not necessary to initialize this value with 0. It is 0 by default.

>  		priv->temp_label = label_temp_sensors;
>  		break;
>  	case USB_PRODUCT_ID_FARBWERK360:
> @@ -877,6 +938,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->temp_sensor_start_offset = FARBWERK360_SENSOR_START;
>  		priv->num_virtual_temp_sensors = FARBWERK360_NUM_VIRTUAL_SENSORS;
>  		priv->virtual_temp_sensor_start_offset = FARBWERK360_VIRTUAL_SENSORS_START;
> +		priv->buffer_size = FARBWERK360_CTRL_REPORT_SIZE;
> +		priv->temp_ctrl_offset = FARBWERK360_TEMP_CTRL_OFFSET;
>  
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
> @@ -893,6 +956,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
>  		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
>  		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
> +		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
>  
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
> @@ -914,6 +978,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
>  		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
>  		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
> +		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
>  
>  		priv->temp_label = label_temp_sensors;
>  		priv->virtual_temp_label = label_virtual_temp_sensors;
