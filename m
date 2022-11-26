Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B40639332
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKZBtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZBta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:49:30 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992412CE23;
        Fri, 25 Nov 2022 17:49:29 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a7-20020a056830008700b0066c82848060so3663336oto.4;
        Fri, 25 Nov 2022 17:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qrFJYNhe1eUR+cg2PLq9sf7qlUh16S1Iij0FFbWrKHU=;
        b=Lu3daCAyy7EYi1IT7G3mGSnZlaiHzyFbgq9EUKYiYrcGgyWj9xuA0PZ/WwTL4Xu6VS
         lqRv8mirC/+QyX1ZwWtL0of/HMFbhhrmxfEmaOIQq/RfhDL7fpfbqrm81+KFO0YZd80J
         M2UY7BHsy6Lo0Fix8BkKhKA9UEWUXRa1fO3XlU5MuS3vYzy5xMgDOF0x/mAEG7SmwGwi
         eh/z4R5CcSKH8LWrrvWzgRsQxmNuOrq3HBn0qHCS9RU0LYDC2+EOTrY/bKNVP1SDuXzE
         Ux0mnsjQqjFqs5fghwkp3jJHBNlFOOOVsUQkXtttxiH6w9A5PvomyR0asbRYwAWGi8YF
         Nahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrFJYNhe1eUR+cg2PLq9sf7qlUh16S1Iij0FFbWrKHU=;
        b=rKy3KecVDdHY45eTgojgjF67q4w4xyP3qjO2TZAUCqEpEZPvSK/gUMbMcQtmIA6l87
         UIXtu7gbSmFLOeUCuVGjcpHcQ9SM8QWsYXYtISHhkKLAN7dEAtblEmFPLgA/OJ1BPKts
         cT+RgWdblMX12DLCJO4dL2rKqbsfwJoFg04hwHpgPFhQm/JSjxXpOh2+FaXBkDsPhr1E
         ltRCaoUSnja4w81J9qqqZZeJAT83XGVcYrsbLAgSe1eIk03w/t0qeagk0dHBMD0xvcZM
         +DCF6/P1WZNW0Hgvw70I5hKFy7fMamLE6wbvh/0gm37GUdS36pHFEYEDtFrnU3nqWew7
         6XvA==
X-Gm-Message-State: ANoB5pnvrraf88M0aWDEYD2d7G36CrSrf8NZnZSqLKuNCCPgD9644sgO
        dsXdvJa1eEnlc6veB3gUuRJSOmeZLjA=
X-Google-Smtp-Source: AA0mqf7qzJnZCGRtUmx9b6Z8RAFQpFJaFhFSkj9lwX9+LwE5akFCrWjKU+XmA9GZ84oAAKagjA7R+g==
X-Received: by 2002:a9d:5e9a:0:b0:661:dd09:fcc4 with SMTP id f26-20020a9d5e9a000000b00661dd09fcc4mr20733624otl.60.1669427368822;
        Fri, 25 Nov 2022 17:49:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1-20020a9d4b01000000b0066cc88749f8sm2251432otf.68.2022.11.25.17.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 17:49:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d9728160-001c-9e29-b195-0cbc82b45184@roeck-us.net>
Date:   Fri, 25 Nov 2022 17:49:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for Quadro flow
 sensor pulses
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125215515.31380-1-savicaleksa83@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221125215515.31380-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/22 13:55, Aleksa Savic wrote:
> Add support for reading and writing flow sensor pulses value on
> the Aquacomputer Quadro. Implemented by Leonard Anderweit [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/45
> 
> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>   Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
>   drivers/hwmon/aquacomputer_d5next.c         | 68 ++++++++++++++++-----
>   2 files changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 15226346434d..637bdbc8fcad 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -39,7 +39,7 @@ current.
>   
>   The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
>   sensor and four PWM controllable fans, along with their speed (in RPM), power,
> -voltage and current.
> +voltage and current. Flow sensor pulses are also available.
>   
>   The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
>   sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
> @@ -64,6 +64,7 @@ Sysfs entries
>   temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
>   temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
>   fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
> +fan5_pulses      Quadro flow sensor pulses
>   power[1-8]_input Pump/fan power (in micro Watts)
>   in[0-7]_input    Pump/fan voltage (in milli Volts)
>   curr[1-8]_input  Pump/fan current (in milli Amperes)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 49d3f9876fe8..77a3ac33d4ac 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -136,6 +136,7 @@ static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
>   
>   /* Control report offsets for the Quadro */
>   #define QUADRO_TEMP_CTRL_OFFSET		0xA
> +#define QUADRO_FLOW_PULSES_CTRL_OFFSET	0x6
>   static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed offsets (0-100%) */
>   
>   /* Specs of High Flow Next flow sensor */
> @@ -303,6 +304,7 @@ struct aqc_data {
>   	u16 temp_ctrl_offset;
>   	u16 power_cycle_count_offset;
>   	u8 flow_sensor_offset;
> +	u8 flow_pulses_ctrl_offset;
>   
>   	/* General info, same across all devices */
>   	u32 serial_number[2];
> @@ -461,20 +463,32 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   		}
>   		break;
>   	case hwmon_fan:
> -		switch (priv->kind) {
> -		case highflownext:
> -			/* Special case to support flow sensor, water quality and conductivity */
> -			if (channel < 3)
> -				return 0444;
> -			break;
> -		case quadro:
> -			/* Special case to support flow sensor */
> -			if (channel < priv->num_fans + 1)
> -				return 0444;
> +		switch (attr) {
> +		case hwmon_fan_input:
> +		case hwmon_fan_label:
> +			switch (priv->kind) {
> +			case highflownext:
> +				/* Special case to support flow sensor, water quality
> +				 * and conductivity
> +				 */
> +				if (channel < 3)
> +					return 0444;
> +				break;
> +			case quadro:
> +				/* Special case to support flow sensor */
> +				if (channel < priv->num_fans + 1)
> +					return 0444;
> +				break;
> +			default:
> +				if (channel < priv->num_fans)
> +					return 0444;
> +				break;
> +			}
>   			break;
> -		default:
> -			if (channel < priv->num_fans)
> -				return 0444;
> +		case hwmon_fan_pulses:
> +			/* Special case for Quadro flow sensor */
> +			if (priv->kind == quadro && channel == priv->num_fans)
> +				return 0644;
>   			break;

I think "default:" is now missing here.

Guenter

>   		}
>   		break;
> @@ -552,7 +566,18 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>   		}
>   		break;
>   	case hwmon_fan:
> -		*val = priv->speed_input[channel];
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			*val = priv->speed_input[channel];
> +			break;
> +		case hwmon_fan_pulses:
> +			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			break;
> +		}
>   		break;
>   	case hwmon_power:
>   		*val = priv->power_input[channel];
> @@ -632,6 +657,18 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>   			return -EOPNOTSUPP;
>   		}
>   		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_pulses:
> +			val = clamp_val(val, 10, 1000);
> +			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>   	case hwmon_pwm:
>   		switch (attr) {
>   		case hwmon_pwm_input:
> @@ -691,7 +728,7 @@ static const struct hwmon_channel_info *aqc_info[] = {
>   			   HWMON_F_INPUT | HWMON_F_LABEL,
>   			   HWMON_F_INPUT | HWMON_F_LABEL,
>   			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES,
>   			   HWMON_F_INPUT | HWMON_F_LABEL,
>   			   HWMON_F_INPUT | HWMON_F_LABEL,
>   			   HWMON_F_INPUT | HWMON_F_LABEL),
> @@ -1000,6 +1037,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
>   
>   		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
> +		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
>   		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
>   
>   		priv->temp_label = label_temp_sensors;

