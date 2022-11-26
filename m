Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A241639708
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKZQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKZQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:06:18 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043F1AF1B;
        Sat, 26 Nov 2022 08:06:16 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-14279410bf4so8388419fac.8;
        Sat, 26 Nov 2022 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0fsuRfK5Gq48zd+qsP9bvn3GpvxGf9JpEvTwTZKDL4=;
        b=VSCPUtnMOA0gR8FDj2PHrTkU/wqf/n6Dy+EMiOMC1go94506jeinUZk18kUOp/Zwi4
         O3EGbBd91HdRa1YkUuw8yUlgZh40ZzUPWPa2Z3jZYWvFqvIDknVrLEaAHdtG8EDLVLk1
         +yVUr4mYEwPa7j2O47V/S8IkqKawOiSHznxe13/L0pQSDDCZddLO9T+mURHV07kEbL1X
         wDRCxc5t94QAlt6yL/pRaisO7a6UmBm7JaxTgFt/wlR/CiVhLlOXiAtt60LSXWCMakLU
         D2E8BelAQRb9izR4G0m+vExaolrPaEFYyC8wo/nroxLORGCDzIDHZDVgWzyDKP2TQgvr
         WBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0fsuRfK5Gq48zd+qsP9bvn3GpvxGf9JpEvTwTZKDL4=;
        b=JsNJEIlZ9oY3H5cKZVwWhKAvewFkck0hSyqF4InaaD+Vv8+3aSBHp8Z5GzmvJzJMdD
         it4hw4GNqHEM4ups67nenvT1iQ8XIWO4Ujq3cLq3abkY5crpeBLv2El2gttqKcovtIOx
         RLvNj517N1RdJDkCrfa2TJVKdVlaWIRvetuRX9YenGsMnOX7x1HGtgXlUbvpSgbPDIno
         jks6Z7ikUtzwBZEkmE0qsCTm4PgI8ZacXNAe/qlQAnFlGdcsxY2fn+W6Vi4ia5B6/A6l
         psrECvDWnx2R8+zDw80/9wuIlJqFLlYXY7Bwt+M243BMsxbiVf8GJUiDI18W7hONUvJB
         10YA==
X-Gm-Message-State: ANoB5pmAwwVd1D4fkTz6KZ3nRYkua0DnGTUnm84OaKg+w5i7Ml0kVleZ
        hL1vgtvdnMSU959Mw7Qi06U=
X-Google-Smtp-Source: AA0mqf4ZNVtQbdjwCnczqyaax1ljhPqTumuGR+ggZKSCT3r3o10xCvmuPGU6eLYWn2d2AnstjOEk1A==
X-Received: by 2002:a05:6870:7d19:b0:142:664c:c315 with SMTP id os25-20020a0568707d1900b00142664cc315mr15717691oab.202.1669478775685;
        Sat, 26 Nov 2022 08:06:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u42-20020a056808152a00b00354978180d8sm2619959oiw.22.2022.11.26.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 08:06:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 26 Nov 2022 08:06:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for Quadro
 flow sensor pulses
Message-ID: <20221126160613.GA920956@roeck-us.net>
References: <20221126071313.34356-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126071313.34356-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 08:13:13AM +0100, Aleksa Savic wrote:
> Add support for reading and writing flow sensor pulses value on
> the Aquacomputer Quadro. Implemented by Leonard Anderweit [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/45
> 
> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v2:
> - Added missing default: in aqc_is_visible()
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
>  drivers/hwmon/aquacomputer_d5next.c         | 66 +++++++++++++++++----
>  2 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 15226346434d..637bdbc8fcad 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -39,7 +39,7 @@ current.
>  
>  The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
>  sensor and four PWM controllable fans, along with their speed (in RPM), power,
> -voltage and current.
> +voltage and current. Flow sensor pulses are also available.
>  
>  The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
>  sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
> @@ -64,6 +64,7 @@ Sysfs entries
>  temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
>  temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
>  fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
> +fan5_pulses      Quadro flow sensor pulses
>  power[1-8]_input Pump/fan power (in micro Watts)
>  in[0-7]_input    Pump/fan voltage (in milli Volts)
>  curr[1-8]_input  Pump/fan current (in milli Amperes)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 49d3f9876fe8..9cc10080160b 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -136,6 +136,7 @@ static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
>  
>  /* Control report offsets for the Quadro */
>  #define QUADRO_TEMP_CTRL_OFFSET		0xA
> +#define QUADRO_FLOW_PULSES_CTRL_OFFSET	0x6
>  static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed offsets (0-100%) */
>  
>  /* Specs of High Flow Next flow sensor */
> @@ -303,6 +304,7 @@ struct aqc_data {
>  	u16 temp_ctrl_offset;
>  	u16 power_cycle_count_offset;
>  	u8 flow_sensor_offset;
> +	u8 flow_pulses_ctrl_offset;
>  
>  	/* General info, same across all devices */
>  	u32 serial_number[2];
> @@ -461,20 +463,34 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  		}
>  		break;
>  	case hwmon_fan:
> -		switch (priv->kind) {
> -		case highflownext:
> -			/* Special case to support flow sensor, water quality and conductivity */
> -			if (channel < 3)
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
>  			break;
> -		case quadro:
> -			/* Special case to support flow sensor */
> -			if (channel < priv->num_fans + 1)
> -				return 0444;
> +		case hwmon_fan_pulses:
> +			/* Special case for Quadro flow sensor */
> +			if (priv->kind == quadro && channel == priv->num_fans)
> +				return 0644;
>  			break;
>  		default:
> -			if (channel < priv->num_fans)
> -				return 0444;
>  			break;
>  		}
>  		break;
> @@ -552,7 +568,18 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		}
>  		break;
>  	case hwmon_fan:
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
>  		break;
>  	case hwmon_power:
>  		*val = priv->power_input[channel];
> @@ -632,6 +659,18 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  			return -EOPNOTSUPP;
>  		}
>  		break;
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
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_input:
> @@ -691,7 +730,7 @@ static const struct hwmon_channel_info *aqc_info[] = {
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES,
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
>  			   HWMON_F_INPUT | HWMON_F_LABEL,
>  			   HWMON_F_INPUT | HWMON_F_LABEL),
> @@ -1000,6 +1039,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
>  
>  		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
> +		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
>  		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
>  
>  		priv->temp_label = label_temp_sensors;
