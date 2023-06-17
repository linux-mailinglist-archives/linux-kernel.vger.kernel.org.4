Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289AA734292
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346394AbjFQRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346366AbjFQRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:16:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20CF268C;
        Sat, 17 Jun 2023 10:16:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b539d2f969so8994705ad.0;
        Sat, 17 Jun 2023 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687022167; x=1689614167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wd8jgzQSh3RwcySp8HayO5ucJccArIu6rQcXRfiGrX4=;
        b=MmSavfVtxOXgCZDSmIEnvzlZzX56rZ/o3B4U1jzl6xwDcgQcl578KWXEJx+yUQIGah
         gfOJwBdHrFMsb5B+w46N3UM3iPCJqrlvx5xiPuf/PqEs2PX6vgVwNrvOc+vXAUAsB/oq
         UWuRUEAtESL1djexqVjtu0OtYjaZtmGBy84oY2NIPqTLM97UJvrBEys8ONkR69+5OkoK
         JFOnW/jvtcYhmvPnVlc4QZ24Z7CFxD7MregNaUxDQ2gIYA7zuKpS7t13yiGIqdTmtkhL
         y/ZVIE2K++m7dpjHFckFl8jfvj67hgTr8CzgHRFSqJY/6w1+s7b9aMp9pDzA6zOCIljX
         9vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022167; x=1689614167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd8jgzQSh3RwcySp8HayO5ucJccArIu6rQcXRfiGrX4=;
        b=V4qUgyv6KEhdNGXdrkH2VZz7wcG2KUfSEmrKXy30i5fyYDeltw8YFqUsKnSNXqSih/
         3iAkLUHBzRFrr445dc3QHkoi1cDFtkbTIJ1um1ac1EmhofazXHku7TEczt0rTHloj1eJ
         63G09aRF2Unua6rFB/wf8H9+p21wZYFkxt2Pgp8Se0gHMf71In4EcfNKjmEdoNajhKuE
         bCaaEZW6GXkeEI+Nj+03oSYToBfCoC6t0bCUMlKgPKRZw8aBC7X4gQWvnQqKxtF5io6/
         mtbwfZXhrBpfNhkqi17hH1D1nuCnkT3QMfbBltjRFLw9mDclBckTNXbNDxdOG4qafeuc
         C4pQ==
X-Gm-Message-State: AC+VfDwY0wFFYiTVFTs0iBjRzn53qFixDz3Ea/LbvbeGOQcbDAeDN2qf
        NxZ4AUFNcy5rf/nTGR5CTI0=
X-Google-Smtp-Source: ACHHUZ6ZVIp84aE+uCDymMq6AT0X55kptXtJwSv6FUtZqi4M63nbQy8vtly/XFcPRoKBLLTNOrOpYw==
X-Received: by 2002:a17:902:db09:b0:1b2:5d90:fc3f with SMTP id m9-20020a170902db0900b001b25d90fc3fmr7736302plx.17.1687022166602;
        Sat, 17 Jun 2023 10:16:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902bd8400b001ab061e352bsm17607140pls.195.2023.06.17.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:16:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 10:16:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (oxp-sensors) Add tt_toggle attribute on
 supported boards
Message-ID: <4e3913cb-8f7c-4df1-85cb-36e2d562dd6d@roeck-us.net>
References: <20230611143332.40590-2-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230611143332.40590-2-samsagax@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 11:33:20AM -0300, Joaquín Ignacio Aramendía wrote:
> OneXPlayer boards from the last generation (both for OneXPlayer and AOK
> ZOE brands) have a toggle in the EC to switch the "Turbo/Silent" button
> into a different keyboard event.
> 
> Add a means to use that "Turbo button takeover" function and expose it
> to userspace in a custom sysfs `tt_toggle` attribute. It can be read to
> take the current state. Write 1|0 to activate the function. The specific
> keycode is dependent on the board but can be checked by running
> `evtest` utility.
> 
> Newer BIOS on the OneXPlayer added this function aside from string changes.
> Add a board enum to differentiate it from the old OneXplayer Mini AMD BIOS.
> 
> Currently known supported boards:
> - AOK ZOE A1
> - OneXPlayer Mini AMD (only newer BIOS version supported)
> - OneXPlayer Mini Pro
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v2 changes:
> - Attach the attribute to the platform device as per review
> - Make the attribute return status 0|1 instead of read value
> 
> v3 changes:
> - Mention the attribute attached to the platform device on Documentation
> - Use boolean instead of base 10 int in tt_toggle_store()
> - Remove unnecesary status logic in tt_toggle_show() (use !!val instead)
> - Add missing breaks in probe()
> ---
>  Documentation/hwmon/oxp-sensors.rst |  17 ++++
>  drivers/hwmon/oxp-sensors.c         | 134 +++++++++++++++++++++++++++-
>  2 files changed, 150 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 4ab442301415..0ca1f7728c34 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -19,6 +19,11 @@ out the EC registers and values to write to since the EC layout and model is
>  different. Aya Neo devices preceding the AIR may not be supportable as the EC
>  model is different and do not appear to have manual control capabilities.
>  
> +Some models have a toggle for changing the behaviour of the "Turbo/Silent"
> +button of the device. It will change the key event that it triggers with
> +a flip of the `tt_toggle` attribute. See below for boards that support this
> +function.
> +
>  Supported devices
>  -----------------
>  
> @@ -33,6 +38,11 @@ Currently the driver supports the following handhelds:
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO
>  
> +"Turbo/Silent" button behaviour toggle is only supported on:
> + - AOK ZOE A1
> + - OneXPlayer mini AMD (only with updated alpha BIOS)
> + - OneXPlayer mini AMD PRO
> +
>  Sysfs entries
>  -------------
>  
> @@ -49,3 +59,10 @@ pwm1
>    Read Write. Read this attribute to see current duty cycle in the range [0-255].
>    When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
>    to set fan speed.
> +
> +tt_toggle
> +  Read Write. Read this attribute to check the status of the turbo/silent
> +  button behaviour function. Write "1" to activate the switch and "0" to
> +  deactivate it. The specific keycodes and behaviour is specific to the device
> +  both with this function on and off. This attribute is attached to the platform
> +  driver and not to the hwmon driver (/sys/devices/platform/oxp-platform/tt_toggle)
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 0ec7588610ad..be36d38f13d9 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -47,15 +47,29 @@ enum oxp_board {
>  	aya_neo_air_pro,
>  	aya_neo_geek,
>  	oxp_mini_amd,
> +	oxp_mini_amd_a07,
>  	oxp_mini_amd_pro,
>  };
>  
>  static enum oxp_board board;
>  
> +/* Fan reading and PWM */
>  #define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
>  #define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
>  #define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
>  
> +/* Turbo button takeover function
> + * Older boards have different values and EC registers
> + * for the same function
> + */
> +#define OXP_OLD_TURBO_SWITCH_REG	0x1E
> +#define OXP_OLD_TURBO_TAKE_VAL		0x01
> +#define OXP_OLD_TURBO_RETURN_VAL	0x00
> +
> +#define OXP_TURBO_SWITCH_REG		0xF1
> +#define OXP_TURBO_TAKE_VAL		0x40
> +#define OXP_TURBO_RETURN_VAL		0x00
> +
>  static const struct dmi_system_id dmi_table[] = {
>  	{
>  		.matches = {
> @@ -104,7 +118,7 @@ static const struct dmi_system_id dmi_table[] = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER mini A07"),
>  		},
> -		.driver_data = (void *)oxp_mini_amd,
> +		.driver_data = (void *)oxp_mini_amd_a07,
>  	},
>  	{
>  		.matches = {
> @@ -156,6 +170,102 @@ static int write_to_ec(u8 reg, u8 value)
>  	return ret;
>  }
>  
> +/* Turbo button toggle functions */
> +static int tt_toggle_enable(void)
> +{
> +	u8 reg;
> +	u8 val;
> +
> +	switch (board) {
> +	case oxp_mini_amd_a07:
> +		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		val = OXP_OLD_TURBO_TAKE_VAL;
> +		break;
> +	case oxp_mini_amd_pro:
> +	case aok_zoe_a1:
> +		reg = OXP_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_TAKE_VAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return write_to_ec(reg, val);
> +}
> +
> +static int tt_toggle_disable(void)
> +{
> +	u8 reg;
> +	u8 val;
> +
> +	switch (board) {
> +	case oxp_mini_amd_a07:
> +		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		val = OXP_OLD_TURBO_RETURN_VAL;
> +		break;
> +	case oxp_mini_amd_pro:
> +	case aok_zoe_a1:
> +		reg = OXP_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_RETURN_VAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return write_to_ec(reg, val);
> +}
> +
> +/* Callbacks for turbo toggle attribute */
> +static ssize_t tt_toggle_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t count)
> +{
> +	int rval;
> +	bool value;
> +
> +	rval = kstrtobool(buf, &value);
> +	if (rval)
> +		return rval;
> +
> +	if (value) {
> +		rval = tt_toggle_enable();
> +		if (rval)
> +			return rval;
> +	} else {
> +		rval = tt_toggle_disable();
> +		if (rval)
> +			return rval;
> +	}
> +	return count;
> +}
> +
> +static ssize_t tt_toggle_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	int retval;
> +	u8 reg;
> +	long val;
> +
> +	switch (board) {
> +	case oxp_mini_amd_a07:
> +		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		break;
> +	case oxp_mini_amd_pro:
> +	case aok_zoe_a1:
> +		reg = OXP_TURBO_SWITCH_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	retval = read_from_ec(reg, 1, &val);
> +	if (retval)
> +		return retval;
> +
> +	return sysfs_emit(buf, "%d\n", !!val);
> +}
> +
> +static DEVICE_ATTR_RW(tt_toggle);
> +
> +/* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
>  	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
> @@ -206,6 +316,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			case aya_neo_air_pro:
>  			case aya_neo_geek:
>  			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>  				*val = (*val * 255) / 100;
>  				break;
>  			case oxp_mini_amd_pro:
> @@ -247,6 +358,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			case aya_neo_air_pro:
>  			case aya_neo_geek:
>  			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>  				val = (val * 100) / 255;
>  				break;
>  			case aok_zoe_a1:
> @@ -274,6 +386,13 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
>  	NULL,
>  };
>  
> +static struct attribute *oxp_ec_attrs[] = {
> +	&dev_attr_tt_toggle.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(oxp_ec);
> +
>  static const struct hwmon_ops oxp_ec_hwmon_ops = {
>  	.is_visible = oxp_ec_hwmon_is_visible,
>  	.read = oxp_platform_read,
> @@ -291,6 +410,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  	const struct dmi_system_id *dmi_entry;
>  	struct device *dev = &pdev->dev;
>  	struct device *hwdev;
> +	int ret;
>  
>  	/*
>  	 * Have to check for AMD processor here because DMI strings are the
> @@ -305,6 +425,18 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  
>  	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>  
> +	switch (board) {
> +	case aok_zoe_a1:
> +	case oxp_mini_amd_a07:
> +	case oxp_mini_amd_pro:
> +		ret = devm_device_add_groups(dev, oxp_ec_groups);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
>  						     &oxp_ec_chip_info, NULL);
>  
