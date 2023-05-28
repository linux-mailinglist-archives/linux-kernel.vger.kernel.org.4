Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F40714141
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjE1Xwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE1Xwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:52:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A37B8;
        Sun, 28 May 2023 16:52:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1971646b3a.0;
        Sun, 28 May 2023 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685317962; x=1687909962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4cIU343BEC8Polo9T4ezxjw9Hqkv/ZWf69ZG2MdWIE=;
        b=FQhhNPDGIS/oiO7wzJjwtnDBH4rGKB9rjw8BIjaI8ofLJWOnmfHZCkURatxY38rTcA
         DzGsCgWEtabde/2CNy+OCAPp5lm+cAdUF/pEv150sBDIIxYzB/ZNLo6OiOsEXJiq5AjF
         5u0rQdK8gfgJs3cNV91bQkhpMUkDQs8AQ7g/aYzc/lj++uuxRhwpK1k4j7dJvq1eZcGq
         GkM/WrPIaYAuYoX/SkAASYdjb6WzP1V25GZV9cYa3fsJqgRbAfahAGemzq3GV/na/vOW
         9H2s4ANetXGVZJD9gKL0hs78xyv4401WmouUXkGGKFNvsKqwX2gsi5NN5yHmIcbPUR3e
         20dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685317962; x=1687909962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4cIU343BEC8Polo9T4ezxjw9Hqkv/ZWf69ZG2MdWIE=;
        b=EdPrJq9UMYV2jplwG6V/HOBf9A55OIkP0db+KIvF2s+2BVNp0bel9wxAsspER5LyxU
         QIyzjFu/tVT2clnH1MA+m5HZujYG+wlhdBTB18nTvNJWmEQtVSVPD3x7/Pb+cFhUycBe
         +nSAKTWjIxDXMjKeyFxHpI92Qe+8QDMxe6KvRHj076AMCJusVfv+48ujHI4jj/D7T4Kv
         lCjbCju5N/KIDEtAQydtpxzi0Eu86qAwNRkGtdd2Y60CwEEy9AaW0O1mwVnCxYerRzZB
         YNAHe6VAXH3aV1/GXi/393OMlHa1aMT1vQDIigF3/DnxO7IGdTj+9D8Rau7p0torINXa
         sWpg==
X-Gm-Message-State: AC+VfDwDQ5bcWr49KW240vOI8abbyafNkwBTCnYWQe9Yqua8AsLzykB2
        2C4WiOusjyugDMTKmer/COo0ta3mLJs=
X-Google-Smtp-Source: ACHHUZ4fM27dZdzm+X+q2iLjNFymw+3Z60HLT0DVzZfZkgONZXrrQLZ2rwN/pX4tF0XuWm72Kemp1g==
X-Received: by 2002:a05:6a00:cc5:b0:648:ebb2:3d6 with SMTP id b5-20020a056a000cc500b00648ebb203d6mr14668391pfv.26.1685317961748;
        Sun, 28 May 2023 16:52:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b0064358d032a4sm5819586pfn.145.2023.05.28.16.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:52:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 28 May 2023 16:52:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on
 supported boards
Message-ID: <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
References: <20230527012206.133464-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230527012206.133464-1-samsagax@gmail.com>
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

On Fri, May 26, 2023 at 10:22:06PM -0300, Joaquín Ignacio Aramendía wrote:
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

This attribute is a no-go. It is not even remotely related to hardware
monitoring, and thus must not be attached to the hwmon device.

I don't know exactly where it belongs, but it appears to be related
to the keyboard. Its natural place therefore seems to be a keyboard driver.
We could possibly also attach it to the platform device, but there would
have to be some precedence of other drivers doing the same. Question
in that case though would be if this is just the first of many attributes
to come. If so, we would need to find a different solution.

Guenter

> Newer BIOS on the OneXPlayer added this function aside from string changes.
> Add a board enum to differentiate it from the old OneXplayer Mini AMD BIOS.
> 
> Currently known supported boards:
> - AOK ZOE A1
> - OneXPlayer Mini AMD (only newer BIOS version supported)
> - OneXPlayer Mini Pro
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> ---
> This patch includes the one in https://lore.kernel.org/linux-hwmon/20230526215621.16075-1-samsagax@gmail.com/
> so it should be discarded.
> ---
>  Documentation/hwmon/oxp-sensors.rst |  16 ++++
>  drivers/hwmon/oxp-sensors.c         | 140 +++++++++++++++++++++++++++-
>  2 files changed, 153 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 4ab442301415..131c89fad03a 100644
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
> @@ -49,3 +59,9 @@ pwm1
>    Read Write. Read this attribute to see current duty cycle in the range [0-255].
>    When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
>    to set fan speed.
> +
> +tt_toggle
> +  Read Write. Read this attribute to check the status of the turbo/silent
> +  button behaviour function. Write "1" to activate the switch and "0" to
> +  deactivate it. The specific keycodes and behaviour is specific to the device
> +  both with this function on and off.
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 0ec7588610ad..80fd153253fc 100644
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
> @@ -156,6 +170,108 @@ static int write_to_ec(u8 reg, u8 value)
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
> +	unsigned int value;
> +
> +	rval = kstrtouint(buf, 10, &value);
> +	if (rval)
> +		return rval;
> +
> +	switch (value) {
> +	case 0:
> +		rval = tt_toggle_disable();
> +		if (rval)
> +			return rval;
> +		return count;
> +	case 1:
> +		rval = tt_toggle_enable();
> +		if (rval)
> +			return rval;
> +		return count;
> +	default:
> +		return -EINVAL;
> +	}
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
> +
> +	retval = read_from_ec(reg, 1, &val);
> +	if (retval)
> +		return retval;
> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +static DEVICE_ATTR_RW(tt_toggle);
> +
> +/* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
>  	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
> @@ -206,6 +322,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			case aya_neo_air_pro:
>  			case aya_neo_geek:
>  			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>  				*val = (*val * 255) / 100;
>  				break;
>  			case oxp_mini_amd_pro:
> @@ -247,6 +364,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			case aya_neo_air_pro:
>  			case aya_neo_geek:
>  			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>  				val = (val * 100) / 255;
>  				break;
>  			case aok_zoe_a1:
> @@ -274,6 +392,13 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
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
> @@ -305,8 +430,17 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  
>  	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>  
> -	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> -						     &oxp_ec_chip_info, NULL);
> +	switch (board) {
> +	case aok_zoe_a1:
> +	case oxp_mini_amd_a07:
> +	case oxp_mini_amd_pro:
> +		hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> +							     &oxp_ec_chip_info, oxp_ec_groups);
> +		break;
> +	default:
> +		hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> +							     &oxp_ec_chip_info, NULL);
> +	}
>  
>  	return PTR_ERR_OR_ZERO(hwdev);
>  }
> -- 
> 2.40.1
> 
