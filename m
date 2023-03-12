Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030D6B68F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCLRsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCLRsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:48:21 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC014225;
        Sun, 12 Mar 2023 10:48:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t22so7917279oiw.12;
        Sun, 12 Mar 2023 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh1OjP2yvgNNZgxu3iedAF37PT3DxZ6O8v/6p1T1v4c=;
        b=JCwGMhGbTzAHZVAIS01oeConKg3xYEgxbufgy19+CMFPEVUMaXSlk8lA5O8fkbAsTA
         JIQ4FSIEgD/zpceA5+OeDTs/oE2Ku/KBHcG5//zfOo4bF62NpeZIWSLv38jcOHkDhqKf
         nMYYmb0D7VAhrLYptWWexkpzTFvfh0jY2mIO5NY0dpy1WDmLCTDH7YzyeZsVnxLMEFyc
         mtXnUlCVuVO1oP5u3gH/u6pQAhJABht2kC9k0Ahby87wQqOsbSiM+5yr+xmImShOC8iv
         qad7yt4p4a/zAmx+t7ewH6TPK/2mFirsU5qMIJaFPMDKo2xNm25+ekUXjuKnO0MkR5Ae
         tULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh1OjP2yvgNNZgxu3iedAF37PT3DxZ6O8v/6p1T1v4c=;
        b=aoqSgwZfi+7kMV4/xmoRukx5DXSwJopXwSOFZyXMzg09MSEE4ky8b2GuXum0SSAKoF
         cJ2wzo4N6QkMvR8jRXFgVs5bzmrUV+ljU8dB2MNSLf/efl0Hgf+VdB3ShcRzj06/lAzB
         3uw08Qav9MvItNuBs/EOHeXnjVIlwUgVGOWJQkkLc85g7ZTJ0cajbfQedT776Q3HHovp
         uw1EdrfRi2P6buca1WkhOkokQ5ElOgIHZfQUWQecsFpFRSNV4oIgjV+sU+QnL05QIYGQ
         8Jhjv64C3l7dHSdXqebsMaSTJ69KgQ2U0/zsBx8YZNurKJ2GxvWmX2Qx5UZbs5ZyAUVE
         mdtw==
X-Gm-Message-State: AO0yUKXDQr5ic9YB5mWinJx42lnXXyU0N/GKUUdAd9+yOnqNuAVaPNZh
        PypYFCyKFAXtwyE6MjYbYIQ=
X-Google-Smtp-Source: AK7set8N5gIWj6tpqostksTkFXjkmPVsLyne3nUkNMzRI4xT2vqfCnkQh8JftVp/TBWupnuw2CBlgw==
X-Received: by 2002:a05:6808:1511:b0:384:dfa5:11d with SMTP id u17-20020a056808151100b00384dfa5011dmr4231746oiw.16.1678643298648;
        Sun, 12 Mar 2023 10:48:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8-20020a9d3788000000b00670679748f9sm2386133otb.49.2023.03.12.10.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:48:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:48:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] hwmon: (aquacomputer_d5next) Add fan PWM control
 for Aquaero
Message-ID: <0263f545-0857-4ba2-b812-2fa81be3c9e5@roeck-us.net>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
 <20230214220221.15003-7-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214220221.15003-7-leonard.anderweit@gmail.com>
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

On Tue, Feb 14, 2023 at 11:02:21PM +0100, Leonard Anderweit wrote:
> Add the option to control fan PWM on Aquacomputer Aquaero. The Aquaero is the
> most complex Aquacomputer device, control is therefore more complicated then on
> already supported devices.
> Setting PWM requires multiple steps. First, an internal static PWM controller
> is set to the desired PWM value. Second, the fan is set to use that PWM
> controller. Last, the minimum and maximum accepted PWM values of the fan are
> set to allow all possible PWM values.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84:
Add the option to control fan PWM on Aquacomputer Aquaero. The Aquaero is the

WARNING: line length of 116 exceeds 100 columns
#144: FILE: drivers/hwmon/aquacomputer_d5next.c:869:
+			ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,

Fixed up and applied, but, again: You are causing extra work for me.
If I encounter such problems, affected patches end up at the tail of
my review queue. Which happened here, in case you wonder why it took
so long to apply the series.

Guenter

> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
>  drivers/hwmon/aquacomputer_d5next.c         | 63 +++++++++++++++++++--
>  2 files changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 618c826093a2..c604d4becb8d 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -25,7 +25,8 @@ communicate through proprietary USB HID protocols.
>  
>  The Aquaero devices expose eight physical, eight virtual and four calculated
>  virtual temperature sensors, as well as two flow sensors. The fans expose their
> -speed (in RPM), power, voltage and current. Temperature offsets can be controlled.
> +speed (in RPM), power, voltage and current. Temperature offsets and fan speeds
> +can be controlled.
>  
>  For the D5 Next pump, available sensors are pump and fan speed, power, voltage
>  and current, as well as coolant temperature and eight virtual temp sensors. Also
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 61c1ffcd8f3b..a6cff7f9cac9 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -104,6 +104,9 @@ static u8 aquaero_secondary_ctrl_report[] = {
>  #define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
>  #define AQUAERO_NUM_FLOW_SENSORS		2
>  #define AQUAERO_CTRL_REPORT_SIZE		0xa93
> +#define AQUAERO_CTRL_PRESET_ID			0x5c
> +#define AQUAERO_CTRL_PRESET_SIZE		0x02
> +#define AQUAERO_CTRL_PRESET_START		0x55c
>  
>  /* Sensor report offsets for Aquaero fan controllers */
>  #define AQUAERO_SENSOR_START			0x65
> @@ -118,6 +121,10 @@ static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
>  
>  /* Control report offsets for the Aquaero fan controllers */
>  #define AQUAERO_TEMP_CTRL_OFFSET	0xdb
> +#define AQUAERO_FAN_CTRL_MIN_PWR_OFFSET	0x04
> +#define AQUAERO_FAN_CTRL_MAX_PWR_OFFSET	0x06
> +#define AQUAERO_FAN_CTRL_SRC_OFFSET	0x10
> +static u16 aquaero_ctrl_fan_offsets[] = { 0x20c, 0x220, 0x234, 0x248 };
>  
>  /* Specs of the D5 Next pump */
>  #define D5NEXT_NUM_FANS			2
> @@ -857,13 +864,22 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		*val = priv->power_input[channel];
>  		break;
>  	case hwmon_pwm:
> -		if (priv->fan_ctrl_offsets) {
> +		switch (priv->kind) {
> +		case aquaero:
> +			ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,
> +					       val, AQC_BE16);
> +			if (ret < 0)
> +				return ret;
> +			*val = aqc_percent_to_pwm(*val);
> +			break;
> +		default:
>  			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
>  					       val, AQC_BE16);
>  			if (ret < 0)
>  				return ret;
>  
>  			*val = aqc_percent_to_pwm(ret);
> +			break;
>  		}
>  		break;
>  	case hwmon_in:
> @@ -922,6 +938,10 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		     long val)
>  {
>  	int ret, pwm_value;
> +	/* Arrays for setting multiple values at once in the control report */
> +	int ctrl_values_offsets[4];
> +	long ctrl_values[4];
> +	int ctrl_values_types[4];
>  	struct aqc_data *priv = dev_get_drvdata(dev);
>  
>  	switch (type) {
> @@ -956,15 +976,47 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_input:
> -			if (priv->fan_ctrl_offsets) {
> -				pwm_value = aqc_pwm_to_percent(val);
> -				if (pwm_value < 0)
> -					return pwm_value;
> +			pwm_value = aqc_pwm_to_percent(val);
> +			if (pwm_value < 0)
> +				return pwm_value;
>  
> +			switch (priv->kind) {
> +			case aquaero:
> +				/* Write pwm value to preset corresponding to the channel */
> +				ctrl_values_offsets[0] = AQUAERO_CTRL_PRESET_START +
> +				    channel * AQUAERO_CTRL_PRESET_SIZE;
> +				ctrl_values[0] = pwm_value;
> +				ctrl_values_types[0] = AQC_BE16;
> +
> +				/* Write preset number in fan control source */
> +				ctrl_values_offsets[1] = priv->fan_ctrl_offsets[channel] +
> +				    AQUAERO_FAN_CTRL_SRC_OFFSET;
> +				ctrl_values[1] = AQUAERO_CTRL_PRESET_ID + channel;
> +				ctrl_values_types[1] = AQC_BE16;
> +
> +				/* Set minimum power to 0 to allow the fan to turn off */
> +				ctrl_values_offsets[2] = priv->fan_ctrl_offsets[channel] +
> +				    AQUAERO_FAN_CTRL_MIN_PWR_OFFSET;
> +				ctrl_values[2] = 0;
> +				ctrl_values_types[2] = AQC_BE16;
> +
> +				/* Set maximum power to 255 to allow the fan to reach max speed */
> +				ctrl_values_offsets[3] = priv->fan_ctrl_offsets[channel] +
> +				    AQUAERO_FAN_CTRL_MAX_PWR_OFFSET;
> +				ctrl_values[3] = aqc_pwm_to_percent(255);
> +				ctrl_values_types[3] = AQC_BE16;
> +
> +				ret = aqc_set_ctrl_vals(priv, ctrl_values_offsets, ctrl_values,
> +							ctrl_values_types, 4);
> +				if (ret < 0)
> +					return ret;
> +				break;
> +			default:
>  				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
>  						       pwm_value, AQC_BE16);
>  				if (ret < 0)
>  					return ret;
> +				break;
>  			}
>  			break;
>  		default:
> @@ -1287,6 +1339,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  		priv->num_fans = AQUAERO_NUM_FANS;
>  		priv->fan_sensor_offsets = aquaero_sensor_fan_offsets;
> +		priv->fan_ctrl_offsets = aquaero_ctrl_fan_offsets;
>  
>  		priv->num_temp_sensors = AQUAERO_NUM_SENSORS;
>  		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
