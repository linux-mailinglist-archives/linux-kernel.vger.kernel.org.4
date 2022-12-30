Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3F657EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiL1Pzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiL1Pzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:55:46 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA84215;
        Wed, 28 Dec 2022 07:55:45 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id o66so15108012oia.6;
        Wed, 28 Dec 2022 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ex5tYf31Xk1rGmhkgq6xlaI9dUZ6fIGKRroYpBkzes=;
        b=WZscb7bbkrY3PpCoMWczd1BUUGFAmT+esA+YU64tjqqa+2B6Jh8V8MIl2rknxglPh2
         eCMNY3d0ZrN5Bvx3/+IfFVa+8jpvUGlJ93gqOwR1hevIeu9R/Z1Xuk/CNhYnVtNz5tEB
         pHRGvGEiQ790Fw2IWtAu0oJdlouTOlirDIxIRvjoF45l/C0J+/VSDBHkGzQqmFKJkL1q
         iCXCZvT+Naw88awM4EnQ2dYp3xTHhBqg30974ITOHoZEh2ncJXMLyZ6zo2qMgJyb1s84
         770A6ipccgMg10dcPOkOj06x78GM1KPAtrTQw8hwYlsQbEDkt40qwQMcMuZNm9ULVh6D
         Ke3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ex5tYf31Xk1rGmhkgq6xlaI9dUZ6fIGKRroYpBkzes=;
        b=Uh/7QpILhLvlJ7rvucxkUZPu5D+TftxUVuq4nJv5BRJIXhlkZAAOz6VFtz+KGal99X
         qB2we5TDY/dpV0zybk5FA3+IsOjIYqsQn7aotZjVfxqg6SLmHTvOC038Hz0hLX64MtAW
         xJrG+VQptbPHxBoDRKSYDAOw2GmajSb6bxsAKda4VgaaVYQ2NLSOLb7ArUTk52Nb7DTC
         PZwIHefGjcWD4M2vX9LQcc8cIAlIKQAQYBHPw0glBE8JHWZe6MkYqzy4iaTTDDbHLPGU
         WhCllit3jLL3n3y+2wZRS+fJUNKzSsV+vEajCIwULm3Jh9suJvq1bwv8mbBrg8JzLtEX
         N/2w==
X-Gm-Message-State: AFqh2kpG+SLxYCR7dabKaOAAQ8E1/WPqdeBRUCzZIFDzr88u/fbs0b/R
        oSIxlAz4EkQ+ytzbnIq7eaA=
X-Google-Smtp-Source: AMrXdXvCAxyGTX+8OVSsvkqt786/qg50LyT6VKIYUj2GoADWKMvCDA2X9NBTn+bCRX/1oQDYnpISHg==
X-Received: by 2002:aca:44c2:0:b0:360:c338:b94a with SMTP id r185-20020aca44c2000000b00360c338b94amr10901525oia.20.1672242944424;
        Wed, 28 Dec 2022 07:55:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r26-20020a05683001da00b006706247fdbfsm8020280ota.23.2022.12.28.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 07:55:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 07:55:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Message-ID: <20221228155542.GA3964987@roeck-us.net>
References: <Y5lBue87IXkhNs42@debian.me>
 <20221214154713.100648-1-derekjohn.clark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214154713.100648-1-derekjohn.clark@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 07:47:13AM -0800, Derek J. Clark wrote:
> Add support for the AYANEO AIR and AYANEO AIR Pro models of handheld
> devices. These devices use the same EC registers and logic as the One X
> Player mini AMD. Previous AYANEO models are not supported as they use a
> different EC and do not have the necessary fan speed write enable and
> setting registers. Tihe driver is tested on Aya Neo AIR while AIR Pro
> model EC functionality and DMI data were verified using command line
> tools by another user.
> 
> The added devices are:
> - AYANEO AIR (AMD 5560U)
> - AYANEO AIR Pro (AMD 5560U)
> - AYANEO AIR Pro (AMD 5825U)
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Missed v2, sorry. Comments below.

> ---
>  Documentation/hwmon/oxp-sensors.rst | 19 ++++++----
>  MAINTAINERS                         |  1 +
>  drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
>  3 files changed, 59 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 39c588ec5c50..a53c961065b2 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -3,18 +3,21 @@
>  Kernel driver oxp-sensors
>  =========================
>  
> -Author:
> +Authors:
> +    - Derek John Clark <derekjohn.clark@gmail.com>
>      - Joaqu�n Ignacio Aramend�a <samsagax@gmail.com>
>  
> -Description:
> +Description
>  ------------

Why drop ":" here ?

>  
> -One X Player devices from One Netbook provide fan readings and fan control
> -through its Embedded Controller.
> +Handheld devices from One Netbook and Aya Neo provide fan readings and fan
> +control through their embedded controllers.
>  
> -Currently only supports AMD boards from the One X Player and AOK ZOE lineup.
> -Intel boards could be supported if we could figure out the EC registers and
> -values to write to since the EC layout and model is different.
> +Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
> +Neo devices. One X PLayer Intel boards could be supported if we could figure
> +out the EC registers and values to write to since the EC layout and model is
> +different. Aya Neo devices preceding the AIR may not be usable as the EC model

s/usable/supportable/ ?

> +is different and do not appear to have manual control capabiltities.
>  
>  Supported devices
>  -----------------
> @@ -22,6 +25,8 @@ Supported devices
>  Currently the driver supports the following handhelds:
>  
>   - AOK ZOE A1
> + - Aya Neo AIR
> + - Aya Neo AIR Pro
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90220659206c..8bce95170f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15346,6 +15346,7 @@ F:	drivers/mtd/nand/onenand/
>  F:	include/linux/mtd/onenand*.h
>  
>  ONEXPLAYER FAN DRIVER
> +M:	Derek John Clark <derekjohn.clark@gmail.com>
>  M:	Joaqu�n Ignacio Aramend�a <samsagax@gmail.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index f84ec8f8eda9..7adc0199ea66 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OXP Handhelds that expose fan reading and control
> - * via hwmon sysfs.
> + * Platform driver for Handhelds that expose fan reading and control via
> + * hwmon sysfs.

Still too generic. Refer to "One Netbook and Aya Neo" as above. 

>   *
> - * Old boards have the same DMI strings and they are told appart by the
> - * boot cpu vendor (Intel/AMD). Currently only AMD boards are supported
> - * but the code is made to be simple to add other handheld boards in the
> - * future.
> + * Old OXP boards have the same DMI strings and they are told appart by

Old problem, but s/appart/apart/

> + * the boot cpu vendor (Intel/AMD). Currently only AMD boards are
> + * supported but the code is made to be simple to add other handheld
> + * boards in the future.
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
>   * scaled to accommodate for that. Newer boards like the mini PRO and
> @@ -42,6 +42,8 @@ static bool unlock_global_acpi_lock(void)
>  
>  enum oxp_board {
>  	aok_zoe_a1 = 1,
> +	aya_neo_air,
> +	aya_neo_air_pro,
>  	oxp_mini_amd,
>  	oxp_mini_amd_pro,
>  };
> @@ -60,6 +62,20 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_air},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -161,8 +177,19 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
>  			if (ret)
>  				return ret;
> -			if (board == oxp_mini_amd)
> +			switch (board) {
> +			case aok_zoe_a1:
> +				break;
> +			case aya_neo_air:
> +			case aya_neo_air_pro:
> +			case oxp_mini_amd:
>  				*val = (*val * 255) / 100;
> +				break;
> +			case oxp_mini_amd_pro:
> +				break;
> +			default:
> +				break;

bundle case statements

> +			}
>  			return 0;
>  		case hwmon_pwm_enable:
>  			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> @@ -191,8 +218,19 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  		case hwmon_pwm_input:
>  			if (val < 0 || val > 255)
>  				return -EINVAL;
> -			if (board == oxp_mini_amd)
> +			switch (board) {
> +			case aok_zoe_a1:
> +				break;
> +			case aya_neo_air:
> +			case aya_neo_air_pro:
> +			case oxp_mini_amd:
>  				val = (val * 100) / 255;
> +				break;
> +			case oxp_mini_amd_pro:
> +				break;
> +			default:
> +				break;
> +			}

Same as above.

>  			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
>  		default:
>  			break;
