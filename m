Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143A6932E5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBKRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBKRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:41:57 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4B126E0;
        Sat, 11 Feb 2023 09:41:56 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so2527724oty.7;
        Sat, 11 Feb 2023 09:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB4BYaKypxug/Usxg3JHYWD2etWYVYsCzwgp8OF/toA=;
        b=XGp0TX1TJXUAWmb8g/lMmsPjIPLN/i9DKQ8/skM9467YRbR83Po+Sowy1dm3gPTJt3
         WTGqIpW4w5hgMBIe7+51AfYbv0SKfzt1igxb+t31qruN4Sije36MGn6w2ASbpryzyUBw
         j4a1nP/jlDjpCkgMckStnuKvTWa+zq5vQIgR6YuCn+xxkOy7BUgb9XWCyKzTQ0cGArjH
         hticXh43eIVW+xws6gcLtF5sX9lkNIrWjADxIi+V8drDOjgyh0hw55xcXHuFcnkJAxGE
         y2hBn4iSixXuZF89uXeKKeqFh7/iIdL2Y/O3v8+81TvT+av4ZuOKoPPI/M3ip1HClfei
         4MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lB4BYaKypxug/Usxg3JHYWD2etWYVYsCzwgp8OF/toA=;
        b=OgH0Hg1jqQsfzPnb2nizqzOksMnEi6nBrbU3n40lyNk7+R+cZwm1lGEdrvdVMxACc6
         VPdKsgLHKQI6bVayI1IZX5lgFgnwYAWMdVCyC10zMcSwLL8p/4zbxPyYPfJT13uiPFE8
         AMvhVLRxbWwDGYqS7PeFcbxWIk2vKt53gwSjWTw1LRPexXqtwWaFmB8Z1KZbv5qIQhpW
         YCSL3nTfHJ72EWC0EUcPcsGYjRKvJ/J8rexYoziebLwGbLJdhEe7vpALJyOOJw2i5wNp
         DsNAmX+3b30YIpxJzuZesYhvVS1C0PdIWTrtGAvINOA9BP+oaYYt6yQfb5qiLEiRjaWm
         kmpw==
X-Gm-Message-State: AO0yUKUuDZZG5DNezh4/cmH8s53TYJEpkDFYstKs5qjikF+C2Hr4LRpg
        vXyC9dMNKxqFNsILqyEKtvZ/43asclU=
X-Google-Smtp-Source: AK7set+XLqmBXbzcKZ8FKtIE+ku4zpYPa2S4L8c5yXo/kAp7AwMC/zgxRjW0lNooXwQGZQqd/6oOtg==
X-Received: by 2002:a05:6830:610b:b0:68d:3e67:22a7 with SMTP id ca11-20020a056830610b00b0068d3e6722a7mr13771369otb.33.1676137315407;
        Sat, 11 Feb 2023 09:41:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23-20020a9d5a17000000b0068bc8968753sm3300435oth.17.2023.02.11.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 09:41:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef64d9c3-65e1-636c-1cb7-8721b1e8746e@roeck-us.net>
Date:   Sat, 11 Feb 2023 09:41:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-6-leonard.anderweit@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5/5] hwmon: (aquacomputer_d5next) Add PWM mode control for
 Aquaero
In-Reply-To: <20230211165923.17807-6-leonard.anderweit@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 08:59, Leonard Anderweit wrote:
> Add PWM mode control for the Aquacomputer Aquaero. On the Aquaero 6 all four
> ports can switch between DC and PWM control. On the Aquaero 5 this is only
> supported for the fourth port, but changing the setting for the other ports has
> no consequences.
> 

Adding the capability without actually supporting it raises the expectation
that it works from those who don't know better. Please only provide the
capability to set the mode where it is actually supported.

Otherwise one could argue along the line of 'hey, let's just "enable"
all attributes no matter if supported or not', which would lead to a
lot of confusion. I really hope that isn't done with other attributes
in this driver.

> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
> ---
>   Documentation/hwmon/aquacomputer_d5next.rst |  4 +-
>   drivers/hwmon/aquacomputer_d5next.c         | 86 ++++++++++++++++-----
>   2 files changed, 70 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 2dbb3bd37878..002cb9eecdf5 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -26,7 +26,8 @@ communicate through proprietary USB HID protocols.
>   The Aquaero devices expose eight physical, eight virtual and four calculated
>   virtual temperature sensors, as well as two flow sensors. The fans expose their
>   speed (in RPM), power, voltage and current. The temperature offset and the fan speed
> -can be controlled.
> +can be controlled. The fan PWM mode (DC/PWM) can be controlled. The Aquaero 6 supports
> +this on all four fan connectors and the Aquaero 5 only on the fourth connector.
>   
>   For the D5 Next pump, available sensors are pump and fan speed, power, voltage
>   and current, as well as coolant temperature and eight virtual temp sensors. Also
> @@ -83,6 +84,7 @@ power[1-8]_input Pump/fan power (in micro Watts)
>   in[0-7]_input    Pump/fan voltage (in milli Volts)
>   curr[1-8]_input  Pump/fan current (in milli Amperes)
>   pwm[1-8]         Fan PWM (0 - 255)
> +pwm[1-4]_mode    Fan control mode (0: DC mode; 1: PWM mode)

... and it isn't even mentioned here that the mode only works on
Aquacomputer Aquaero, and only on the 4th port for Aquaero 5.

Really, please don't do that, and I sincerely hope that the driver
doesn't hide (i.e., claim to support when it isn't really supported)
other similar limitations.

Guenter

>   ================ ==============================================================
>   
>   Debugfs entries
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 02551c26918a..2ec00124785f 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -123,6 +123,7 @@ static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
>   #define AQUAERO_TEMP_CTRL_OFFSET	0xdb
>   #define AQUAERO_FAN_CTRL_MIN_PWR_OFFSET	0x04
>   #define AQUAERO_FAN_CTRL_MAX_PWR_OFFSET	0x06
> +#define AQUAERO_FAN_CTRL_MODE_OFFSET	0x0f
>   #define AQUAERO_FAN_CTRL_SRC_OFFSET	0x10
>   static u16 aquaero_ctrl_fan_offsets[] = { 0x20c, 0x220, 0x234, 0x248 };
>   
> @@ -672,10 +673,23 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   		break;
>   	case hwmon_pwm:
>   		if (priv->fan_ctrl_offsets && channel < priv->num_fans) {
> -			switch (attr) {
> -			case hwmon_pwm_input:
> -				return 0644;
> +			switch (priv->kind) {
> +			case aquaero:
> +				switch (attr) {
> +				case hwmon_pwm_input:
> +				case hwmon_pwm_mode:
> +					return 0644;
> +				default:
> +					break;
> +				}
> +				break;
>   			default:
> +				switch (attr) {
> +				case hwmon_pwm_input:
> +					return 0644;
> +				default:
> +					break;
> +				}
>   				break;
>   			}
>   		}
> @@ -863,22 +877,46 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>   		*val = priv->power_input[channel];
>   		break;
>   	case hwmon_pwm:
> -		switch (priv->kind) {
> -		case aquaero:
> -			ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,
> -					       val, AQC_BE16);
> -			if (ret < 0)
> -				return ret;
> -			*val = aqc_percent_to_pwm(*val);
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			switch (priv->kind) {
> +			case aquaero:
> +				ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START +
> +						       channel * AQUAERO_CTRL_PRESET_SIZE,
> +						       val, AQC_BE16);
> +				if (ret < 0)
> +					return ret;
> +				*val = aqc_percent_to_pwm(*val);
> +				break;
> +			default:
> +				ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
> +						       val, AQC_BE16);
> +				if (ret < 0)
> +					return ret;
> +
> +				*val = aqc_percent_to_pwm(ret);
> +				break;
> +			}
>   			break;
> -		default:
> -			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
> -					       val, AQC_BE16);
> +		case hwmon_pwm_mode:
> +			ret = aqc_get_ctrl_val(priv,
> +					       priv->fan_ctrl_offsets[channel] +
> +					       AQUAERO_FAN_CTRL_MODE_OFFSET, val, AQC_8);
>   			if (ret < 0)
>   				return ret;
>   
> -			*val = aqc_percent_to_pwm(ret);
> +			switch (*val) {
> +			case 0:	/* DC mode */
> +				break;
> +			case 2:	/* PWM mode */
> +				*val = 1;
> +				break;
> +			default:
> +				break;
> +			}
>   			break;
> +		default:
> +			return -EOPNOTSUPP;
>   		}
>   		break;
>   	case hwmon_in:
> @@ -936,7 +974,7 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>   static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
>   		     long val)
>   {
> -	int ret, pwm_value;
> +	int ret, pwm_value, ctrl_mode;
>   	/* Arrays for setting multiple values at once in the control report */
>   	int ctrl_values_offsets[4];
>   	long ctrl_values[4];
> @@ -1018,6 +1056,16 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>   				break;
>   			}
>   			break;
> +		case hwmon_pwm_mode:
> +			if (val > 1 || val < 0)
> +				return -EINVAL;
> +			ctrl_mode = 2 * val;
> +			ret = aqc_set_ctrl_val(priv,
> +					       priv->fan_ctrl_offsets[channel] +
> +					       AQUAERO_FAN_CTRL_MODE_OFFSET, ctrl_mode, AQC_8);
> +			if (ret < 0)
> +				return ret;
> +			break;
>   		default:
>   			break;
>   		}
> @@ -1077,10 +1125,10 @@ static const struct hwmon_channel_info *aqc_info[] = {
>   			   HWMON_P_INPUT | HWMON_P_LABEL,
>   			   HWMON_P_INPUT | HWMON_P_LABEL),
>   	HWMON_CHANNEL_INFO(pwm,
> -			   HWMON_PWM_INPUT,
> -			   HWMON_PWM_INPUT,
> -			   HWMON_PWM_INPUT,
> -			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
>   			   HWMON_PWM_INPUT,
>   			   HWMON_PWM_INPUT,
>   			   HWMON_PWM_INPUT,

